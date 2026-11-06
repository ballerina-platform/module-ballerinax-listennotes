## Overview

The Listen Notes connector lets Ballerina applications search and explore podcasts and episodes, and manage playlists, through the [Listen API](https://www.listennotes.com/api/docs/). It supports version 2.0 of the API.

### Key features

- Search podcasts, episodes and curated lists, with typeahead suggestions, trending searches and related terms
- Browse the podcast directory by genre, region and language, and fetch curated lists of podcasts
- Retrieve detailed metadata for podcasts and episodes, individually or in batches
- Get podcast and episode recommendations and look up audience demographics
- Create and manage playlists of episodes and podcasts, and submit new podcasts to the database

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
