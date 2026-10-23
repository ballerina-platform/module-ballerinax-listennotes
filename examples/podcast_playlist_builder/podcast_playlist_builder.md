# Podcast playlist builder

This example searches for episodes about a topic, creates a private playlist, adds the matching episodes to it with a short note, and reads the playlist back. Use it to turn a search into a reusable listening list.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Listen API key from the [API dashboard](https://www.listennotes.com/api/dashboard/) with access to the playlist endpoints
- Create a `Config.toml` in this directory:

  ```toml
  apiKey = "<Listen API key>"
  topic = "distributed systems"
  playlistName = "Distributed systems reading list"
  maxEpisodes = 5
  ```

## Run the example

```bash
bal run
```
