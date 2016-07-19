startup nomount pfile=/u01/app/oracle/product/11.2.0/xe/dbs/initXE.ora
/

create database
        maxinstances 1
        maxloghistory 2
        maxlogfiles 16
        maxlogmembers 2
        maxdatafiles 30
      datafile '/u01/app/oracle/oradata/XE/system.dbf'
        size 200M reuse autoextend on next 10M maxsize 600M
        extent management local
      sysaux datafile '/u01/app/oracle/oradata/XE/sysaux.dbf'
        size 10M reuse autoextend on next  10M
      default temporary tablespace temp tempfile 
 '/u01/app/oracle/oradata/XE/temp.dbf'
        size 20M reuse autoextend on next  10M maxsize 500M
      undo tablespace undotbs1 datafile '/u01/app/oracle/oradata/XE/undotbs1.dbf'
        size 50M reuse autoextend on next  5M maxsize 500M
       character set cl8mswin1251
       national character set al16utf16
       set time_zone='00:00'
       controlfile reuse
       logfile '/u01/app/oracle/oradata/XE/log1.dbf' size 50m reuse
             , '/u01/app/oracle/oradata/XE/log2.dbf' size 50m reuse
             , '/u01/app/oracle/oradata/XE/log3.dbf' size 50m reuse
      user system identified by oracle
      user sys identified by oracle
/

create tablespace users
       datafile '/u01/app/oracle/oradata/XE/users.dbf'
       size 100M reuse autoextend on next 10M maxsize 11G
       extent management local
/

exit;

