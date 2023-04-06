# A simple Maven Archetype for Java

Generates a Maven project with

- JDK 19
- JUnit 5.9.2

## How to use

Change the values of `DgroupId`, `-DartifactId` and `-Dversion` to match your own project details.

Change the `jdkVersion` property to change the JDK version. Default value is currently `19`.

Change the `javaPreviewFeatures` property to `no` or `n` if you want to disable preview features. Default value is `yes`

```
mvn archetype:generate -DarchetypeGroupId=no.dervis \
                    -DarchetypeArtifactId=java-starter \
                    -DarchetypeVersion=1.0.5 \
                    -DgroupId=org.mygroup \
                    -DartifactId=demoapp \
                    -Dversion=1.0.0 \
                    -DjdkVersion=19 \
                    -DjavaPreviewFeatures=yes \
                    -DinteractiveMode=false
```

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