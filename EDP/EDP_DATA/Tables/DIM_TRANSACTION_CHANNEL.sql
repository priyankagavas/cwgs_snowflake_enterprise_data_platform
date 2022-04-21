create or replace TABLE DEV_EDP.EDP_DATA.DIM_TRANSACTION_CHANNEL (
	CHANNEL_ID NUMBER(38,0) NOT NULL autoincrement COMMENT 'A unique channel identifier',
	CHANNEL_DESC VARCHAR(40) COMMENT 'Description of a sales channel, such as \nRetail Store, \nWholesale, \nMail, \nDCC,\n Web, \nGander Amazon, \nGander Retail, \nGander Web\nGander AMZ FBA,\n ELW Web, \nELW CC, \nOB, \nAUM\nOvertons Retail\nOvertons Web\nOvertons CC\nGander CC\nUncle Dans Web\nRock Creek Web\nRock Creek CC\nReplenishment',
	CHANNEL_CATEGORY_DESC VARCHAR(40) COMMENT 'Description of channel category, such as \nDirect\nWholesale\nRetail\n',
	RECORD_LOAD_DTM DATE DEFAULT CURRENT_DATE() COMMENT 'Record load datetime',
	constraint XPKTRNSCHNLDIM primary key (CHANNEL_ID)
)COMMENT='A sales channel is the vessel a product is sold, such as in-store, online'
;