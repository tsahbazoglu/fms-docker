db.getSisterDB("admin").createUser({
   user: "tspb-db-admin",
   pwd: "12345678",
   roles: [
        {role: "root", db: "admin"}
   ]
})

