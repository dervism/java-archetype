# A simple Maven Archetype for Java

Generates a Maven project with

- JDK 16
- JUnit 5.7.2

## How to use

Change the values of `DgroupId`, `-DartifactId` and `-Dversion` to match your own project details.

Change the `jdkVersion` property to change the JDK version. Default value is currently `16`.

Change the `javaPreviewFeatures` property to `no` or `n` if you want to disable preview features. Default value is `yes`

```
mvn archetype:generate -DarchetypeGroupId=no.dervis \
                    -DarchetypeArtifactId=java-starter \
                    -DarchetypeVersion=1.0.2 \
                    -DgroupId=org.mygroup \
                    -DartifactId=demoapp \
                    -Dversion=1.0.0 \
                    -DjdkVersion=16 \
                    -DjavaPreviewFeatures=yes \
                    -DinteractiveMode=false
```
