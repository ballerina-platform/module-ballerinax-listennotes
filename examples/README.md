# Examples

The `ballerinax/listennotes` connector provides practical examples illustrating usage in various scenarios.

1. [Genre podcast report](./genre_podcast_report/genre_podcast_report.md) - Finds the best podcasts in a genre and lists the most recent episodes of each.
2. [Podcast playlist builder](./podcast_playlist_builder/podcast_playlist_builder.md) - Searches for episodes on a topic, collects them in a new playlist and reads the playlist back.

## Prerequisites

1. Get a Listen API key from the [API dashboard](https://www.listennotes.com/api/dashboard/).

2. For each example, create a `Config.toml` file with the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    apiKey = "<Listen API key>"
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
