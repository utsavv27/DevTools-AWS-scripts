#!/bin/bash

# === CONFIGURABLE VARIABLES ===
MONGO_ADMIN_USER="admin"
MONGO_ADMIN_PASS="StrongAdminPassword123"

APP_DB="kartbaord"
APP_USER="kartuser"
APP_PASS="UserPassword456"

# === CREATE ADMIN USER, DATABASE, AND APP USER ===
echo "🚀 Creating admin user, new database, and application user..."

mongosh <<EOF
// Switch to admin database
use admin

// Create admin user with root privileges
db.createUser({
  user: "$MONGO_ADMIN_USER",
  pwd: "$MONGO_ADMIN_PASS",
  roles: [ { role: "root", db: "admin" } ]
});

// Authenticate as admin (in case needed for next steps)
db.auth("$MONGO_ADMIN_USER", "$MONGO_ADMIN_PASS");

// Switch to the application database (will be created on first write)
use $APP_DB

// Create an app user with read/write access to the app DB
db.createUser({
  user: "$APP_USER",
  pwd: "$APP_PASS",
  roles: [ { role: "readWrite", db: "$APP_DB" } ]
});

// Insert dummy data to ensure the database exists
db.sampleCollection.insertOne({ status: "Database Initialized" });
EOF

echo "✅ Admin and app users created, database '$APP_DB' initialized."
