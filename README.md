# A simple Maven Archetype for Java

Generates a Maven project with

- JDK 16
- JUnit 5

You can change the Java version number when using the archetype from the commandline.

PS: The archetype is not yet published to Maven central. Clone and build the project locally if you want to test it.

## How to use

```
mvn archetype:generate -DarchetypeGroupId=no.dervis \
                    -DarchetypeArtifactId=java-starter \
                    -DarchetypeVersion=1.0.0 \
                    -DgroupId=org.mygroup \
                    -DartifactId=demoapp \
                    -Dversion=1.0.0 \
                    -DjdkVersion=16 \
                    -DjavaPreviewFeatures=yes \
                    -DinteractiveMode=false
```

Change the `jdkVersion` property to change the JDK version.

Change `javaPreviewFeatures` to `no` or `n` if you want to disable preview features