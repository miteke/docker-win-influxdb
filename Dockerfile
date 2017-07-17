# escape=`
FROM microsoft/nanoserver:10.0.14393.1480

ENV INFLUXDB_VERSION 1.3.0

RUN Invoke-WebRequest -UseBasicParsing https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUXDB_VERSION}_windows_amd64.zip -OutFile influxdb.zip; `
    Expand-Archive influxdb.zip -DestinationPath ${env:TEMP}/influxdb-tmp; `
    Move-Item ${env:TEMP}/influxdb-tmp ${env:ProgramFiles}/influxdb; `
    $env:PATH += \";${env:ProgramFiles}/influxdb\"; `
    Remove-Item -Force influxdb.zip
    
RUN setx /M PATH $($Env:PATH + ';' + $Env:ProgramFiles + '/influxdb')

EXPOSE 8086

VOLUME c:\influxdbdata

CMD ["influxd.exe"]

