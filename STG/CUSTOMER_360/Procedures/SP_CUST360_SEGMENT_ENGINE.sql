USE DEV_INBOUND;

CREATE OR REPLACE PROCEDURE CUSTOMER_360.SP_CUST360_SEGMENT_ENGINE()
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
DECLARE
select_stmt VARCHAR;

BEGIN

//Calling unpivot view creation SP
CALL DEV_INBOUND.customer_360.sp_generate_unpivot_vw('SEGMENT');

//Calling Unpivot Transform view creation SP
call dev_inbound.customer_360.sp_generate_unpivot_transform_vw('SEGMENT');


//Deleting all the deleted records of SEGMENT from target- FACT_CUSTOMER_ATTRIBUTE
 
DELETE FROM DEV_EDP.EDP_DATA.FACT_CUSTOMER_ATTRIBUTE 
WHERE ENGINE_NAME = 'SEGMENT'
AND (CUSTOMER_ID, ATTRIBUTE_ID) NOT IN (
SELECT PIV.CUSTOMER_ID, PIV.ATTRIBUTE_ID FROM DEV_INBOUND.CUSTOMER_360.VW_SEGMENT_UNPIVOT PIV
where upper(PIV.ATTRIBUTE_VALUE)!='FALSE'
UNION ALL
SELECT PIV_1.CUSTOMER_ID, PIV_1.ATTRIBUTE_ID FROM DEV_INBOUND.CUSTOMER_360.VW_SEGMENT_UNPIVOT_TRANSFORM  PIV_1 where upper(PIV_1.ATTRIBUTE_VALUE)!='FALSE'
)
;


//Merge the source records (straight pull attributes) into target- FACT_CUSTOMER_ATTRIBUTE

MERGE INTO DEV_EDP.EDP_DATA.FACT_CUSTOMER_ATTRIBUTE U USING
(
SELECT 
ATTRIBUTE_VALUE,
ATTRIBUTE_ID,
CUSTOMER_ID
FROM
DEV_INBOUND.CUSTOMER_360.VW_SEGMENT_UNPIVOT where upper(ATTRIBUTE_VALUE)!='FALSE'
) I ON U.CUSTOMER_ID = I.CUSTOMER_ID AND U.ATTRIBUTE_ID = I.ATTRIBUTE_ID
WHEN MATCHED AND upper(U.ATTRIBUTE_VALUE) != upper(I.ATTRIBUTE_VALUE) THEN  UPDATE SET U.ATTRIBUTE_VALUE = I.ATTRIBUTE_VALUE , U.UPDATE_DTM = CURRENT_TIMESTAMP
WHEN NOT MATCHED
THEN INSERT
(
ATTRIBUTE_VALUE,
ATTRIBUTE_ID,
CUSTOMER_ID,
INSERT_DTM,
UPDATE_DTM,
ENGINE_NAME
) VALUES
(
I.ATTRIBUTE_VALUE,
I.ATTRIBUTE_ID,
I.CUSTOMER_ID,
CURRENT_TIMESTAMP,
CURRENT_TIMESTAMP,
'SEGMENT'
);



//Merge the source records (transform attributes) into target- FACT_CUSTOMER_ATTRIBUTE

MERGE INTO DEV_EDP.EDP_DATA.FACT_CUSTOMER_ATTRIBUTE U USING
(
SELECT distinct
ATTRIBUTE_VALUE,
ATTRIBUTE_ID,
CUSTOMER_ID
FROM
DEV_INBOUND.CUSTOMER_360.VW_SEGMENT_UNPIVOT_TRANSFORM 
where upper(ATTRIBUTE_VALUE)!='FALSE'
) I ON U.CUSTOMER_ID = I.CUSTOMER_ID AND U.ATTRIBUTE_ID = I.ATTRIBUTE_ID
WHEN MATCHED AND upper(U.ATTRIBUTE_VALUE) != upper(I.ATTRIBUTE_VALUE) THEN UPDATE SET U.ATTRIBUTE_VALUE = I.ATTRIBUTE_VALUE , U.UPDATE_DTM = CURRENT_TIMESTAMP
WHEN NOT MATCHED
THEN INSERT
(
ATTRIBUTE_VALUE,
ATTRIBUTE_ID,
CUSTOMER_ID,
INSERT_DTM,
UPDATE_DTM,
ENGINE_NAME
) VALUES
(
I.ATTRIBUTE_VALUE,
I.ATTRIBUTE_ID,
I.CUSTOMER_ID,
CURRENT_TIMESTAMP,
CURRENT_TIMESTAMP,
'SEGMENT'
);



RETURN 'SP_CUST360_SEGMENT_ENGINE executed successfully';

END;
$$;