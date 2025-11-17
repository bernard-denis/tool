# escape \
FROM quay.io/keycloak/keycloak:9.0.3 AS builder

# Enable features and set database
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres

WORKDIR /opt/jboss/keycloak
RUN mkdir -p /opt/jboss/keycloak/modules/org/postgresql/main
ADD --chown=keycloak:keycloak --chmod=644 \
    https://jdbc.postgresql.org/download/postgresql-42.7.7.jar \
    /opt/jboss/keycloak/modules/org/postgresql/main/postgresql-42.7.7.jar

COPY module.xml /opt/jboss/keycloak/modules/module.xml
# Build optimized image
#RUN /opt/keycloak/bin/kc.sh build

#RUN /opt/jboss/tools/build-keycloak.sh

#FROM quay.io/keycloak/keycloak:9.0.3
#COPY --from=builder /opt/keycloak/ /opt/keycloak/
#
## Runtime configuration
#ENV KC_DB=postgres
#ENV KC_HOSTNAME=localhost
ENTRYPOINT ["/opt/jboss/keycloak/bin/standalone.sh"]


