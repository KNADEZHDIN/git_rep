SELECT * 
FROM Sys_Logs
WHERE 1=1
AND process = 'BIS.FMC_MAKE_CHARGE'
AND LOG_DATE >= TO_DATE('20.01.2019 00:00:00', 'DD.MM.YYYY HH24:MI:SS')  --TRUNC(SYSDATE,'DD') -1
AND LOG_DATE <= TO_DATE('21.01.2019 23:59:59', 'DD.MM.YYYY HH24:MI:SS')  --TRUNC(SYSDATE,'DD') +1
--AND UPPER (message) LIKE UPPER ('%FMC%')
ORDER BY log_date DESC
;



SELECT * FROM GV$SESSIONS --view for sessions
;