# Genre podcast report

This example looks up a podcast genre by name, fetches the best podcasts in that genre for a region, and prints the most recent episodes of each podcast. Use it to see what is popular in a topic area.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Listen API key from the [API dashboard](https://www.listennotes.com/api/dashboard/)
- Create a `Config.toml` in this directory:

  ```toml
  apiKey = "<Listen API key>"
  genreName = "Technology"
  region = "us"
  ```

## Run the example

```bash
bal run
```
