
db.getSisterDB("configdb").ldapMatch.update({projectCode: "base"}, {$set: {
        db: "basedb",
        collection: "user",
        query: {},
        ldapUID: "username"
    }
}, {upsert: true});


db.getSisterDB("configdb").ldapMatch.update({projectCode: 'demo'}, {$set: {
        db: 'basedb',
        collection: 'user',
        query: {},
        ldapUID: 'username'
    }
}, {upsert: true});


