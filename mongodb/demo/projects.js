db.getSisterDB("configdb").project.update({key: "demo"}, {$set: {
        configCollections: "configdemo",
        adminRole: "admin",
        userRole: "admin",
        welcomePage: "welcome-demo.html"
    }
}, {upsert: true});



