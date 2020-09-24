db.getSisterDB('basedb').user.update({username:"admin"},{$set:{email:"fms-admin@tspb.org.tr",forms:"user"}},{upsert:true});

