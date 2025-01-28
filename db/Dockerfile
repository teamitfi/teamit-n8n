FROM supabase/postgres:15.6.1.116

# Add initialization scripts
COPY init.sql /docker-entrypoint-initdb.d/

# Expose Postgres default port
EXPOSE 5432