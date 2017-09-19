@echo off
setlocal EnableDelayedExpansion
echo ***************************************************************************
echo                build_all.bat
echo                     by niuren.zhu
echo                           2017.01.13
echo  ˵����
echo     1. �˽ű���Ҫ��Node.js command prompt�����С�
echo     2. ������ǰĿ¼��������Ŀ¼������tsconfig.json����롣
echo     3. ����1�������Ŀ¼����.\����ʾ��ǰ��
echo     4. ����2��tsc����������������磺-w����ʾ�����ļ��仯��
echo ****************************************************************************
REM ���ò�������
REM ����Ŀ¼
SET STARTUP_FOLDER=%~dp0
REM ����Ĺ���Ŀ¼
SET WORK_FOLDER=%~1
REM �ж��Ƿ񴫹���Ŀ¼��û����������Ŀ¼
if "%WORK_FOLDER%"=="" SET WORK_FOLDER=%STARTUP_FOLDER%
REM ������Ŀ¼����ַ����ǡ�\������
if "%WORK_FOLDER:~-1%" neq "\" SET WORK_FOLDER=%WORK_FOLDER%\
echo --������Ŀ¼��%WORK_FOLDER%
REM ��������
SET OPTIONS=%~2
REM ��������
SET COMMOND=tsc
if "%OPTIONS%" neq "" (
  SET COMMOND=start /min !COMMOND! %OPTIONS%
  echo ���!COMMOND!
)
REM ӳ���
SET IBAS_FOLDER=%IBAS_TS_LIB%
if "%IBAS_FOLDER%" equ "" (
REM û�ж��廷������
  if exist "%WORK_FOLDER%..\..\..\..\..\ibas-typescript\" (
    SET IBAS_FOLDER=%WORK_FOLDER%..\..\..\..\..\ibas-typescript\
  )
)

REM ��鲢ӳ���
if "%IBAS_FOLDER%" neq "" (
  if not exist %WORK_FOLDER%3rdparty\ibas mklink /d .\3rdparty\ibas %IBAS_FOLDER%ibas\
  if not exist %WORK_FOLDER%3rdparty\openui5 mklink /d .\3rdparty\openui5 %IBAS_FOLDER%openui5\
)

REM ���˷�������Ŀ¼
if exist "%WORK_FOLDER%\tomcat\webapps\ROOT" rd /s /q "%WORK_FOLDER%\tomcat\webapps\ROOT"
for /f %%l in ('dir /b "%WORK_FOLDER%tsconfig.json"') DO (
  SET FOLDER=%%~dpl
  echo --��ʼ���룺!FOLDER!
REM ���б�������
  call !COMMOND! -p !FOLDER!
)