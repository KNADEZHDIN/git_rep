SELECT * -- all
FROM Sys_Logs
WHERE 1=1
AND process = 'BIS.FMC_MAKE_CHARGE'
AND LOG_DATE >= TO_DATE('20.01.2019 00:00:00', 'DD.MM.YYYY HH24:MI:SS')  --TRUNC(SYSDATE,'DD') -1
AND LOG_DATE <= TO_DATE('21.01.2019 23:59:59', 'DD.MM.YYYY HH24:MI:SS')  --TRUNC(SYSDATE,'DD') +1
--AND UPPER (message) LIKE UPPER ('%FMC%')
ORDER BY log_date DESC
;

SELECT * FROM GV$SESSIONS --вьюха сессий
WHERE USER_ID = 'DEMO_BR';

--Таблица начислений только по абонплате:
SELECT * 
FROM BIS.CHARGES H
WHERE H.SUBS_SUBS_ID = 7764385
AND H.CGTP_CGTP_ID=2
AND H.SRLS_SRLS_ID = 10
AND H.DEL_DATE IS NULL
ORDER BY H.NAVI_DATE DESC;

-- Найти звонки по номеру телефона 
SELECT 
P.PACK_ID,P.NAME_R, SP.START_DATE AS DATE_START_PACK, SP.END_DATE AS DATE_END_PACK, PH.SUBS_SUBS_ID, NS.MSISDN, S.CLNT_CLNT_ID, 
PH.START_DATE AS DATE_START_SUB,PH.END_DATE AS DATE_END_SUB, S.PERS_CLNT_ID, SH.ACCOUNT 
FROM BIS.PHONE_HISTORIES PH 
JOIN BIS.NUMBER_SETS NS
ON PH.NSET_NSET_ID = NS.NSET_ID
JOIN BIS.SUBSCRIBERS S
ON PH.SUBS_SUBS_ID = S.SUBS_ID
JOIN SUBS_PACKS SP
ON SP.SUBS_SUBS_ID = S.SUBS_ID
JOIN PACKS P
ON SP.PACK_PACK_ID = P.PACK_ID
JOIN BIS.CLIENT_HISTORIES SH
ON SH.CLNT_CLNT_ID = S.CLNT_CLNT_ID
AND PH.START_DATE < SYSDATE
AND PH.END_DATE > SYSDATE
AND SP.END_DATE >SYSDATE
AND SH.START_DATE < SYSDATE
AND SH.END_DATE > SYSDATE
AND S.CLOSE_DATE IS NULL
--AND PACK_ID IN ( 14244,19084,14245,19088,16105,19085,16108,19092,21998,21999 )
AND NS.MSISDN = '675090484'
AND PH.SUBS_SUBS_ID = 9889423
AND PACK_ID = 21998
;
