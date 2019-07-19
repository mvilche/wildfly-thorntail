# Wildfly thorntail s2i images 

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)


# Funcionalidades:

- Non-root
- Openshift compatible
- Runtime image with Jolokia Agent

### Variables


| Variable | Detalle |
| ------ | ------ |
| TIMEZONE | Define la zona horaria a utilizar (America/Montevideo, America/El_salvador) |
| JAVA_OPTS | Define parametros de la jvm |
| APP_OPTIONS | Permite setear configuraciones adicionales de la app |
| NEXUS_MIRROR_URL | Define url repositorio nexus para la descarga de dependencias |
| EXTRA_REPO | Define url repositorio git extra compila previo |
| TAG_VERSION | Variable usada en el proceso de build para definir la version |
| MVN_OPTS | Variable usada argumentos adicionales maven |





License
----

Martin vilche
