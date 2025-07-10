#!/bin/bash

# === CONFIGURABLE VARIABLES ===
MONGO_PORT=23723
MONGO_ADMIN_USER="admin"
MONGO_ADMIN_PASS="StrongAdminPassword123"

APP_DB="kartbaord"
APP_USER="kartuser"
APP_PASS="UserPassword456"

# === FETCH SERVER IP ===
SERVER_IP=$(hostname -I | awk '{print $1}')

echo "🚀 Connecting to MongoDB on port $MONGO_PORT to create users and database..."

mongosh --port $MONGO_PORT <<EOF
use admin

// Create admin user
db.createUser({
  user: "$MONGO_ADMIN_USER",
  pwd: "$MONGO_ADMIN_PASS",
  roles: [ { role: "root", db: "admin" } ]
});

// Authenticate as admin
db.auth("$MONGO_ADMIN_USER", "$MONGO_ADMIN_PASS");

// Create application database and user
use $APP_DB

db.createUser({
  user: "$APP_USER",
  pwd: "$APP_PASS",
  roles: [ { role: "readWrite", db: "$APP_DB" } ]
});

// Insert dummy doc to materialize DB
db.init.insertOne({ createdAt: new Date(), note: "DB initialized" });
EOF

# === OUTPUT CONNECTION STRINGS ===

echo ""
echo "✅ Users and database created successfully!"
echo ""
echo "🔗 MongoDB Admin Connection URI:"
echo "   mongodb://$MONGO_ADMIN_USER:$MONGO_ADMIN_PASS@$SERVER_IP:$MONGO_PORT/admin?authSource=admin"
echo ""
echo "🔗 App User Connection URI:"
echo "   mongodb://$APP_USER:$APP_PASS@$SERVER_IP:$MONGO_PORT/$APP_DB?authSource=$APP_DB"
echo ""
