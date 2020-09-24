#!/bin/sh

echo -e  "---------------------------------------------------------------- undeploy"
asadmin undeploy uys-ear-3.2-SNAPSHOT

echo -e  "---------------------------------------------------------------- deploy"
asadmin deploy uys-ear-3.2-SNAPSHOT.ear


