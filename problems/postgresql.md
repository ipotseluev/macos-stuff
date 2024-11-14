## Problem: can't run `brew services start postgrsql` without sudo

**Solution**: Look at install logs. It mentions initdb command:

```
initdb --locale=C -E UTF-8 /usr/local/var/postgresql@14
```

Run it manually
