# Ballerina Listen Notes connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-listennotes/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-listennotes/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-listennotes.svg)](https://github.com/ballerina-platform/module-ballerinax-listennotes/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/listennotes.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Flistennotes)

## Overview

The Listen Notes connector lets Ballerina applications search and explore podcasts and episodes, and manage playlists, through the [Listen API](https://www.listennotes.com/api/docs/). It supports version 2.0 of the API.

## Setup guide

To use the connector, you need a Listen API key.

1. Create an account at [Listen Notes](https://www.listennotes.com/) and sign in.

2. Open the [API dashboard](https://www.listennotes.com/api/dashboard/) and choose a plan. A free plan is available for trying out the API.

3. Copy your API key from the dashboard. Team keys act as the API admin.

## Quickstart

To use the Listen Notes connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/listennotes;
```

### Step 2: Create a `Config.toml` file

```toml
apiKey = "<Listen API key>"
```

### Step 3: Create a client

```ballerina
configurable string apiKey = ?;

final listennotes:Client listenNotes = check new ({xListenAPIKey: apiKey});
```

### Step 4: Invoke an operation

```ballerina
public function main() returns error? {
    listennotes:TrendingSearchesResponse _ = check listenNotes->getTrendingSearches();
}
```

## Examples

The Listen Notes connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-listennotes/tree/main/examples/), covering the following use cases:

1. [Genre podcast report](https://github.com/ballerina-platform/module-ballerinax-listennotes/tree/main/examples/genre_podcast_report) - Finds the best podcasts in a genre and lists the most recent episodes of each.
2. [Podcast playlist builder](https://github.com/ballerina-platform/module-ballerinax-listennotes/tree/main/examples/podcast_playlist_builder) - Searches for episodes on a topic, collects them in a new playlist and reads the playlist back.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`listennotes` package](https://central.ballerina.io/ballerinax/listennotes/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
