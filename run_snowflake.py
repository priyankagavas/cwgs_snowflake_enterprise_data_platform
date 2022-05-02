import sys
import os
import snowflake.connector as sf
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.primitives.asymmetric import dsa
from cryptography.hazmat.primitives import serialization
import base64

def decode64(encoded_str):
    base64_bytes = encoded_str.encode("ascii")
    decoded_bytes = base64.b64decode(base64_bytes)
    return decoded_bytes.decode("ascii")

def sf_connect(username, private_key, passphrase, account, warehouse):
    try:
        p_key = serialization.load_pem_private_key(
            decode64(private_key),
            password=decode64(passphrase).encode(),
            backend=default_backend(),
        )

        pkb = p_key.private_bytes(
            encoding=serialization.Encoding.DER,
            format=serialization.PrivateFormat.PKCS8,
            encryption_algorithm=serialization.NoEncryption(),
        )

        conn = sf.connect(
            user=username, private_key=pkb, account=account, warehouse=warehouse,
        )
        return conn, conn.cursor()
    except Exception as e:
        raise Exception(
            f"Exception occured whlie establishing connection to snowflake:\n{e}"
        )


def check_log_table(cursor):
    query = "select count(*) from db.information_schema.tables where table_name = 'log_table'"
    cursor.execute(query)
    if cursor.fetchone()[0] == 1:
        return True
    else:
        return create_log_table(cursor)


def log_table(cursor, file_name, sha, actor, file_action):
    if check_log_table(cursor=cursor):
        query = f"select file_name, count(*) from db.schema.log_table where file_name = '{file_name}' group by 1"
        cursor.execute(query)
        if cursor.fetchone()[1] > 1:
            raise Exception(f"Error in log table, duplicate entry for {file_name}")
        elif cursor.fetchone()[1] == 1:
            query = f"update db.schema.log_table set update_datetime = current_datetime, commit_user = '{actor}', commit_sha = '{sha}', file_action = '{file_action}' where file_name = '{file_name}'"
            cursor.execute(query)
        else:
            query = f"insert into db.schema.log_table (file_name, created_datetime, update_datetime, commit_user, commit_sha, file_action ) values ('{file_name}', current_timestamp, current_timestamp, '{actor}', '{sha}', '{file_action}')"
            cursor.execute(query)
    else:
        raise Exception(f"log table not available. Please create log table.")


def create_log_table(cursor):
    query = "create table db.schema.log_table(file_name varchar, created_datetime timestamp_ntz, update_datetime timestamp_ntz, commit_user varchar, commit_sha varchar, file_action varchar)"
    cursor.execute(query)
    return True


if __name__ == "__main__":
    file_name = sys.argv[1]
    branch = sys.argv[2]
    username = sys.argv[3]
    dev_ppk = sys.argv[4]
    uat_ppk = sys.argv[5]
    dev_passphrase = sys.argv[6]
    uat_passphrase = sys.argv[7]
    account = sys.argv[8]
    warehouse = sys.argv[9]
    file_action = sys.argv[10]
    actor = os.getenv("GITHUB_ACTOR")
    sha = os.getenv("GITHUB_SHA")

    branch_replacement = {"dev": "dev", "uat": "uat", "main": "prod"}
    file_type = file_name.split(".")[1]
    ppk_key = ''
    if branch_replacement[branch] == 'dev':
        ppk_key = dev_ppk
        passphrase = dev_passphrase
    elif branch_replacement[branch] == 'uat':
        ppk_key = uat_ppk
        passphrase = uat_passphrase
    conn, cursor = sf_connect(
        username=username[branch_replacement[branch]], passphrase=passphrase, private_key=ppk_key, account=account, warehouse=warehouse
    )
    try:
        if file_type.lower() in ["yml", "py"]:
            sys.exit(0)
        else:
            print(f"Branch name: {branch}")
            print(f"{file_name} has been changed")
            query = ""
            with open(file_name, "r") as f:
                queries = "".join(line.rstrip() for line in f)
                if ";" in queries:
                    for query in queries.split(";"):
                        query = query.replace(
                            "$env", branch_replacement[branch]
                        ).upper()
                        print(query)
                        cursor.execute(query)
                        for x in cursor.fetchall():
                            print(x)
            query = query.replace("$env", branch_replacement[branch]).upper()
            print(query)
            cursor.execute(query)
            for x in cursor.fetchall():
                print(x)
    except Exception as e:
        raise Exception(f"Exception occured while executing the query:\n{e}")
    finally:
        cursor.close()
        conn.close()

