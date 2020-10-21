#!/usr/bin/env bash
#java -jar -Dserver.servlet.context-path=/finIssuanceProcessor fin-issuance-processor-1.0.0.jar
#java -jar -Dspring.profiles.active=prod fin-issuance-processor-1.0.0.jar
#exec java $FIN_JAVA_OPTS -javaagent:/newrelic-agent-$1.jar -jar -Dspring.profiles.active=prod -Dnewrelic.config.file=/newrelic.yml /fin-issuance-processor-1.0.0.jar
curl -L https://github.com/signalfx/signalfx-java-tracing/releases/latest/download/signalfx-tracing.jar -o /opt/app/signalfx-tracing.jar

exec java $FIN_JAVA_OPTS -javaagent:/opt/app/signalfx-tracing.jar -jar -Dsignalfx.agent.host=localhost -Dsignalfx.endpoint.url=http://localhost:9080/v1/trace -Dcom.sun.management.jmxremote.port=3000 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.rmi.port=3000 -Dsignalfx.http.client.error.statuses=400-599 /fin-issuance-processor-1.0.0.jar
