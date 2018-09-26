# docker-ebx581-java10-nodownload-noaddons-customdirectory-openidconnect

works with Azure

## build

```
put your ebxLicense in ~/.profile
export EBXLICENSE=XXXXX-XXXXX-XXXXX-XXXXX
source ~/.profile
docker build -t ebx5.8.1-azure-openidconnect .
```

## run

```
docker run -p 9090:8080 -e "CATALINA_OPTS=-DebxLicense=$EBXLICENSE" ebx5.8.1-azure-openidconnect
```

## EBX

open your browser at ```http://localhost:9090/ebx```

create your repository and create user admin/admin

you can login as usual with admin/admin

also you can use a openidconnect bearer token, use the following

- userid: ```##OPENIDCONNECT_TOKEN##```
- password is a bearer token such as: ```eyJ0eXAiOiJKV1QiLCJub25jZSI6IkFRQUJBQUFBQUFEWHpaM2lmci1HUmJEVDQ1ek5TRUZFUU5oblVHNzRyelByaTMzdWVyMGFfRTNobE9sbWpDUkFxMGxtaEJOWVZESDUzTDkzSlpBallxaHFGdmtpWmd4OGR4OGpZQ0Fsa2F5YmJZVHJTRWFua3lBQSIsImFsZyI6IlJTMjU2IiwieDV0IjoiaTZsR2szRlp6eFJjVWIyQzNuRVE3c3lISmxZIiwia2lkIjoiaTZsR2szRlp6eFJjVWIyQzNuRVE3c3lISmxZIn0.eyJhdWQiOiJodHRwczovL2dyYXBoLm1pY3Jvc29mdC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC85MWU2ZDgzYi04YmIzLTQzNDgtOGVhNC1jY2ZlZjQzMzcxOTQvIiwiaWF0IjoxNTM3OTkyMjQwLCJuYmYiOjE1Mzc5OTIyNDAsImV4cCI6MTUzNzk5NjE0MCwiYWNjdCI6MCwiYWNyIjoiMSIsImFpbyI6IjQyQmdZTmprdE1jdzF0S3U1Q1BYcS93eXB1T3hVNngxem12WmI0bFVQOE1aSU52OUpRQUEiLCJhbHRzZWNpZCI6IjE6bGl2ZS5jb206MDAwNjAwMDBFQjY1MjAzRCIsImFtciI6WyJwd2QiXSwiYXBwX2Rpc3BsYXluYW1lIjoiV2ViYXBwLU9wZW5pZGNvbm5lY3QiLCJhcHBpZCI6ImJiNTM1NmJkLWRiNjYtNDFiZC04OTJjLWZmNGExNGMyZDhhZCIsImFwcGlkYWNyIjoiMSIsImVfZXhwIjoyNjI4MDAsImVtYWlsIjoibWlja2FlbGdlcm1lbW9udEBob3RtYWlsLmNvbSIsImZhbWlseV9uYW1lIjoiR0VSTUVNT05UIiwiZ2l2ZW5fbmFtZSI6Im1pY2thZWxnZXJtZW1vbnRAaG90bWFpbC5jb20iLCJpZHAiOiJsaXZlLmNvbSIsImlwYWRkciI6IjY4LjE3NC4xNTcuMjU1IiwibmFtZSI6Im1pY2thZWxnZXJtZW1vbnRAaG90bWFpbC5jb20gR0VSTUVNT05UIiwib2lkIjoiZWE3ZTMyNzktOGUyMC00MTQ0LTk2ZjgtODJkOTE1MjcxOGY2IiwicGxhdGYiOiI1IiwicHVpZCI6IjEwMDNCRkZEQUUzQTYzOTciLCJzY3AiOiJVc2VyLlJlYWQgVXNlci5SZWFkQmFzaWMuQWxsIiwic2lnbmluX3N0YXRlIjpbImttc2kiXSwic3ViIjoib1V1RTZjMWdOd0R1akc1eFN3a3dXT0hOU3M4eWFwT0o3M08tYmEwTE5yZyIsInRpZCI6IjkxZTZkODNiLThiYjMtNDM0OC04ZWE0LWNjZmVmNDMzNzE5NCIsInVuaXF1ZV9uYW1lIjoibGl2ZS5jb20jbWlja2FlbGdlcm1lbW9udEBob3RtYWlsLmNvbSIsInV0aSI6ImlFbUt1b1ZQdUVHQktjVUlubm5NQUEiLCJ2ZXIiOiIxLjAiLCJ3aWRzIjpbIjYyZTkwMzk0LTY5ZjUtNDIzNy05MTkwLTAxMjE3NzE0NWUxMCJdLCJ4bXNfdGNkdCI6IjE1Mzc5NzAxMTEifQ.kQ7QghQEVA-9PMJjWLum2K9sMwaSWcxfMW2n8c16U6WSWM0JnfUdeD1QK928v03Wg8zgvW5lSuoZ0Lsg7AIyh6pZiJCt2TnH1rgzwm8mHgfjWX9w3_bOlSX2pGlmrGUDq7hyz2yAQISHrua1gU09FndAvIkWXHM4TJIUf_1AlI8Q5zZcl08z522pL4wPvO6vD7QTeuI3vEy95nHGpn647_8sv15_2XyJVgtN572Wo7ptvhlTW8bvg2ML6iVabPU_g-VwhVhhPcvFW4aLYQUB9hAKw1U-g35HzzL33CkuE53rGEt205v04b7zClgjm5MeCv70jvO1kjiRJZfGrivBag```

## POSTMAN / REST call authenticated with openidconnect

in EBX, create dataspace list, give RO permission to everybody

in EBX, create dataset list, give RO permission to everybody

use data model

```
<?xml version="1.0" encoding="UTF-8"?>
<!--XML schema generated from EBX5 DMA instance [reference=list] on Wed Sep 26 21:14:05 UTC 2018 by user [admin].-->
<xs:schema xmlns:osd="urn:ebx-schemas:common_1.0" xmlns:fmt="urn:ebx-schemas:format_1.0" xmlns:ebxbnd="urn:ebx-schemas:binding_1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ebxs="urn:ebx-schemas:session_1.0">
    <xs:import namespace="urn:ebx-schemas:common_1.0" schemaLocation="http://schema.orchestranetworks.com/common_1.0.xsd"/>
    <xs:import namespace="urn:ebx-schemas:session_1.0" schemaLocation="http://schema.orchestranetworks.com/session_1.0.xsd"/>
    <xs:element name="root" osd:access="--">
        <xs:complexType>
            <xs:sequence>
                <xs:element name="things" minOccurs="0" maxOccurs="unbounded">
                    <xs:annotation>
                        <xs:appinfo>
                            <osd:table>
                                <primaryKeys>/id </primaryKeys>
                            </osd:table>
                        </xs:appinfo>
                    </xs:annotation>
                    <xs:complexType>
                        <xs:sequence>
                            <xs:element name="id" type="xs:string" minOccurs="1" maxOccurs="1"/>
                        </xs:sequence>
                    </xs:complexType>
                </xs:element>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
</xs:schema>
```

create a record in your things table

then

use POSTMAN basic authentication, enter ```##OPENIDCONNECT_TOKEN##``` and the bearer token as password

then finally test with REST URL is ```http://localhost:9090/ebx-dataservices/rest/data/v1/Blist/list/root/things```
