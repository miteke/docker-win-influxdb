# escape=`
FROM microsoft/nanoserver:10.0.14393.1480

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV INFLUXDB_VERSION 1.3.0

RUN Invoke-WebRequest -UseBasicParsing https://dl.influxdata.com/influxdb/releases/influxdb-${env:INFLUXDB_VERSION}_windows_amd64.zip -OutFile influxdb.zip; `
    Expand-Archive influxdb.zip -DestinationPath ${env:TEMP}/influxdb-tmp; `
    Move-Item ${env:TEMP}/influxdb-tmp/influxdb-${env:INFLUXDB_VERSION}-1 C:/influxdb; `
    $env:PATH += \";C:\influxdb\"; `
    Remove-Item -Force influxdb.zip

RUN MkDir C:\influxdbdata

COPY influxdb.conf C:/influxdb

EXPOSE 8086

VOLUME C:/influxdbdata

WORKDIR C:/influxdb

CMD ["influxd.exe"]

