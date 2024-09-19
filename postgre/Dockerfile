FROM postgres:15
ENV POSTGRE_USER postgres
ENV POSTGRES_PASSWORD B@nLgU4qz*9?D~3n83
ENV POSTGRES_DB covoiturage
# copie du fichier de création de BDD dans le conteneur
# lancement automatique du script
COPY covoiturage-looping-postgre.sql /docker-entrypoint-initdb.d/