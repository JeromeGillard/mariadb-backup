Script to backup all databases of a mariadb instance.

# Usage
```
mariadb-backup:
    env:
      BACKUP_DB_HOST=mariadb
      BACKUP_DB_USER=root
      BACKUP_DB_PASSWORD=root
      BACKUP_NUM_KEEP=7
      BACKUP_FREQUENCY=1d
    volumes:
      - ./database-dump:/dump
      - /etc/localtime:/etc/localtime:ro
    depends_on:
      - mariadb
```

# Volume
 - `/dump` (mandatory): The directory where the dump archives will be created.
 - `/etc/localtime` (optional): Timezone

# Environment variables

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| BACKUP_DB_HOST | The host of the DB to backup | `mariadb` |
| BACKUP_DB_USER | Username that can read all databases | `root` |
| BACKUP_DB_PASSWORD | You guess it | `root` |
| BACKUP_NUM_KEEP | how many backup archive can I keep? | `7` |
| BACKUP_FREQUENCY | How long to wait until each backup | `1d` |
| UID | User id of the process. The produced archives will own them | `1001` |
| GID | Group id of the process | `1001` |