#!/bin/bash

mongod --dbpath ~/fmsdb --fork --logpath  ~/fmsdb.log  --logappend

mongo admin --quiet ./admin.js
mongo test  --quiet ./properties.js
mongo test  --quiet ./projects.js
mongo test  --quiet ./ldapmatch.js
mongo test  --quiet ./init-basedb-user.js
