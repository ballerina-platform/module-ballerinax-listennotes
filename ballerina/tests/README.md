# Running Tests

## Prerequisites

The tests run against a local mock server by default and need no credentials. To run them against the live Listen API, set the environment variables below.

| Variable | Description |
| --- | --- |
| `IS_LIVE_SERVER` | Set to `true` to call the live API instead of the mock server |
| `LISTEN_NOTES_API_KEY` | A Listen API key, read only when `IS_LIVE_SERVER` is `true` |

## Test environments

The suite covers the first 25 operations served by the mock: search, typeahead, episode title search, trending and related searches, best podcasts, podcast and episode lookup (single and batch), curated lists, genres, recommendations, podcast submission and RSS refresh, and playlist and playlist item management. Tests that create, change or delete data run against the mock only.

* Run all tests:

    ```bash
    bal test
    ```

* Run only the tests that are also valid against the live API:

    ```bash
    IS_LIVE_SERVER=true LISTEN_NOTES_API_KEY=<key> bal test --groups live_tests
    ```
