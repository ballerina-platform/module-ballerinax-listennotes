_Author_:  @DimuthuMadushan \
_Created_: 2026/10/22 \
_Updated_: 2026/10/22 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Listen Notes.
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/listennotes/listennotes/2.0/openapi.yaml).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Changed `openapi` from `3.1.0` to `3.0.3` in the original spec (`docs/spec/openapi.yaml`). Under 3.1.0, `bal openapi flatten` drops the `type` from parameters and schemas, and client generation then fails with a `NullPointerException` on `Parameter.getIn()`. The spec uses no 3.1-only features apart from the unused top-level `webhooks` block, which 3.0.3 ignores.

2. Removed the `oneOf` constraint (an `episode_id` or a `podcast_id` is required) from both the `application/x-www-form-urlencoded` and `application/json` request bodies of `POST /playlists/{id}/items`, in the original spec. An inline `oneOf` in a request body makes the generator type the payload as `anydata`. The body is now an object with optional `episode_id`, `podcast_id` and `notes` properties, and exactly one of the two ids must still be supplied.

3. Renamed the generic schemas that flatten produced, kept stable through `ai-mappings.json`: `InlineResponse200` to `SearchEpisodeTitlesResponse`, `InlineResponse2001` to `DeletePlaylistResponse`, `InlineResponse2002` to `DeletePlaylistItemResponse`, `InlineResponse400` to `ErrorResponse`, `IdItemsBody` to `AddPlaylistItemRequest`, `ItemsitemIdBody` to `UpdatePlaylistItemNotesRequest`, `PlaylistsBody` to `CreatePlaylistRequest` and `PlaylistsidBody` to `UpdatePlaylistRequest`.

4. Patched the generated `ballerina/utils.bal` after generation (a spec change can't do this one, and it must be re-applied after every regeneration): each trailing-separator `pop()` in `createFormURLEncodedRequestBody`, `getDeepObjectStyleRequest`, `getFormStyleRequest` (both branches) and `getSerializedRecordArray` now runs only when the array is non-empty. Without the guard, a form-encoded payload with no fields set, such as `addPlaylistItem(id, {})`, `updatePlaylist(id, {})` or `getPodcastsInBatch({})`, panics instead of sending the request. Output for non-empty payloads is unchanged.

5. Made the `data` property of `PlaylistItem` distinguishable, in the original spec. Its four union members are open records whose fields are all optional, so a response always bound to the first one. Each member is now a named schema (`PlaylistEpisodeData`, `PlaylistPodcastData`, `PlaylistCustomAudioData`, `PlaylistDeletedItemData`) that extends the shared schema and requires one field: `podcast`, `publisher`, `audio` and `status` respectively. The shared `EpisodeSimple`, `PodcastSimple`, `CustomAudio` and `DeletedItem` schemas are unchanged, because other operations return them without those fields.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --client-methods remote --license docs/license.txt
```
Note: The license year is hardcoded to 2024, change if necessary.
