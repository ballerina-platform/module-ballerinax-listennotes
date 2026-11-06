# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- The initial Listen Notes connector, a `Client` with 32 remote methods for the Listen Notes podcast API:
  - Search: `search`, `typeahead`, `searchEpisodeTitles`, `getTrendingSearches`, `getRelatedSearches` and `spellcheck`.
  - Podcasts and episodes: `getBestPodcasts`, `getPodcastById`, `getEpisodeById`, `getPodcastsInBatch`, `getEpisodesInBatch`, `getCuratedPodcasts`, `getCuratedPodcastById`, `justListen`, `getPodcastRecommendations`, `getEpisodeRecommendations`, `getPodcastAudience`, `getPodcastsByDomainName`, `submitPodcast`, `refreshRss` and `deletePodcastById`.
  - Directory data: `getGenres`, `getRegions` and `getLanguages`.
  - Playlists: `getPlaylists`, `getPlaylistById`, `createPlaylist`, `updatePlaylist`, `deletePlaylist`, `addPlaylistItem`, `updatePlaylistItemNotes` and `deletePlaylistItem`.
- `ApiKeysConfig`, passed to `init`, which holds the Listen Notes API key. The client sends it as the `X-ListenAPI-Key` header on every request.
- A default `serviceUrl` of `https://listen-api.listennotes.com/api/v2`.
