FROM eclipse-temurin:17-jdk-alpine

# Installer Maven pour télécharger le jar
RUN apk add --no-cache maven

# Télécharger le jar de shiro-tools-hasher
RUN mvn dependency:get \
    -DgroupId=org.apache.shiro.tools \
    -DartifactId=shiro-tools-hasher \
    -Dclassifier=cli \
    -Dversion=2.0.3 && \
    cp /root/.m2/repository/org/apache/shiro/tools/shiro-tools-hasher/2.0.3/shiro-tools-hasher-2.0.3-cli.jar /shiro-tools-hasher-cli.jar

# Définir le point d'entrée
ENTRYPOINT ["java", "-jar", "/shiro-tools-hasher-cli.jar"]
