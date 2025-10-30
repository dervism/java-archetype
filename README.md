# A simple Maven Archetype for Java
![Maven Central](https://img.shields.io/maven-central/v/no.dervis/java-starter?style=flat-square)

Generates a minimal Maven project for Java with

- JDK 25 (or any version you specify, read below)
- JUnit 5.11.x

## How to use

### Selecting Java version
Change the `jdkVersion` property to change the JDK version. Default value is currently `25`.

### Activate/deactivate Java preview features
Change the `javaPreviewFeatures` property to `no` or `n` if you want to disable preview features. Default value is `yes`, which means this archetype will generate a `pom.xml` file that allows you to use the newest preview features of Java.

### Generating a new Java project from CLI
Change the values of `DgroupId`, `-DartifactId` and `-Dversion` to match your own project details. These properties are required. `archetypeGroupId`, `archetypeArtifactId` and `archetypeVersion` must remain as is.

```
mvn archetype:generate -DarchetypeGroupId=no.dervis \
                    -DarchetypeArtifactId=java-starter \
                    -DarchetypeVersion=1.0.14 \
                    -DgroupId=org.mygroup \
                    -DartifactId=demoapp \
                    -Dversion=1.0.0 \
                    -DjdkVersion=25 \
                    -DjavaPreviewFeatures=yes \
                    -DinteractiveMode=false
```

### Maven Central
[https://central.sonatype.com/artifact/no.dervis/java-starter/1.0.14](https://central.sonatype.com/artifact/no.dervis/java-starter/1.0.14)

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

### Rolling back a failed release
If a release started with the Maven Release Plugin fails or needs to be reverted, you can run the provided rollback script:

- ./rollback.sh — rolls back the Maven release state (restores pom.xml from backups, removes temporary release files)
- ./rollback.sh --delete-tag — additionally deletes the created Git tag locally
- ./rollback.sh --delete-remote-tag — deletes the created Git tag both locally and on the configured Git remote (origin by default)

Notes:
- The script reads the tag name from release.properties (key: scm.tag).
- It is safe to run multiple times; if there is nothing to roll back or the tag does not exist, it will continue with a warning.

### Releasing (with dry run option)
You can run the release using the Maven Release Plugin via the provided script:

- Actual release: `./release.sh`
- Dry run (no tags/commits/push; validates that everything is ready): `./release.sh --dry-run` or `./release.sh -n`

Dry run runs `mvn release:prepare -DdryRun=true` so you can verify versions, SCM configuration, and checks without modifying your repository. When it completes successfully, run the script again without `--dry-run` to perform the actual release.
