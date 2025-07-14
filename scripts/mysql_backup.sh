#!/bin/bash
HOST="127.0.0.1"
PORT="3306"
DB="db_name"
USER="root"
PASS="pass"
BACKUP_DIR="/home/ubuntu"
DATE=$(date +%F_%H-%M)
FILENAME="${DB}_${DATE}.sql.gz"
SQLFILE="${DB}_${DATE}.sql"

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR"

# Step 1: Backup and compress
echo "Starting backup for $DB..."
mysqldump \
  --single-transaction \
  --set-gtid-purged=OFF \
  --triggers \
  --routines \
  --events \
  -h "$HOST" -P "$PORT" -u "$USER" -p"$PASS" "$DB" | gzip > "$BACKUP_DIR/$FILENAME"


if [ $? -eq 0 ]; then
  echo "Backup completed: $FILENAME"

  # Step 2: Extract to .sql file
  gunzip -c "$BACKUP_DIR/$FILENAME" > "$BACKUP_DIR/$SQLFILE"

  if [ $? -eq 0 ]; then
    echo "Extracted SQL file: $SQLFILE"

    # Step 3: Delete the .gz file
    rm -f "$BACKUP_DIR/$FILENAME"
    echo "Removed compressed file: $FILENAME"
  else
    echo "Failed to extract SQL file."
    exit 2
  fi

else
  echo "Backup failed!"
  exit 1
fi
