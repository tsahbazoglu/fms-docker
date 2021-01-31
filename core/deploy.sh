#!/bin/sh

echo -e  "---------------------------------------------------------------- undeploy"
asadmin undeploy uys-ear-3.2-SNAPSHOT

echo -e  "---------------------------------------------------------------- deploy"
asadmin deploy fms.ear


