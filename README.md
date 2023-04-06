# A simple Maven Archetype for Java
![Maven Central](https://img.shields.io/maven-central/v/no.dervis/java-starter?style=flat-square)

Generates a minimal Maven project for Java with

- JDK 19
- JUnit 5.9.2

## How to use

### Selecting Java version
Change the `jdkVersion` property to change the JDK version. Default value is currently `19`.

### Activate/deactivate Java preview features
Change the `javaPreviewFeatures` property to `no` or `n` if you want to disable preview features. Default value is `yes`, which means this archetype will generate a `pom.xml` file that allows you to use the newest preview features of Java.

### Generating a new Java project from CLI
Change the values of `DgroupId`, `-DartifactId` and `-Dversion` to match your own project details. These properties are required. `archetypeGroupId`, `archetypeArtifactId` and `archetypeVersion` must remain as is.

```
mvn archetype:generate -DarchetypeGroupId=no.dervis \
                    -DarchetypeArtifactId=java-starter \
                    -DarchetypeVersion=1.0.7 \
                    -DgroupId=org.mygroup \
                    -DartifactId=demoapp \
                    -Dversion=1.0.0 \
                    -DjdkVersion=19 \
                    -DjavaPreviewFeatures=yes \
                    -DinteractiveMode=false
```

### Maven Central
[https://central.sonatype.com/artifact/no.dervis/java-starter/1.0.7](https://central.sonatype.com/artifact/no.dervis/java-starter/1.0.7)

### Useful Maven commands for beginners
#### Clean and compile

- mvn clean compile

#### Clean, compile and install

- mvn clean install

#### Check if there is newer versions of your dependencies
- mvn versions:display-dependency-updates

#### Upgrade snapshot versions to the closest release
- mvn versions:use-releases

#### Updating dependencies to the next version
- mvn versions:use-next-releases

#### Updating dependencies to the latest version
- mvn versions:use-latest-releases