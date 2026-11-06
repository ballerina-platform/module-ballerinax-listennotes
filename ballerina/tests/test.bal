// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://listen-api.listennotes.com/api/v2" : "http://localhost:9090";
final string apiKey = isLiveServer ? os:getEnv("LISTEN_NOTES_API_KEY") : "test_api_key";

final Client listenNotes = check new ({xListenAPIKey: apiKey}, {httpVersion: http:HTTP_1_1}, serviceUrl);

const string TEST_PODCAST_ID = "4d3fe717742d4963a85562e9f84d8c79";
const string TEST_EPISODE_ID = "6b6d65930c5a4f71b254465871fed370";
const string TEST_PLAYLIST_ID = "m1pe7z60bsw";

@test:Config {groups: ["live_tests", "mock_tests"]}
function testSearch() returns error? {
    SearchResponse response = check listenNotes->search(q = "software engineering");
    test:assertTrue(response.results is SearchResponseResults[]);
    test:assertTrue((response.results ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testTypeahead() returns error? {
    TypeaheadResponse response = check listenNotes->typeahead(q = "software");
    test:assertTrue(response.terms.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testSearchEpisodeTitles() returns error? {
    SearchEpisodeTitlesResponse response = check listenNotes->searchEpisodeTitles(q = "distributed systems");
    test:assertTrue((response.results ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetTrendingSearches() returns error? {
    TrendingSearchesResponse response = check listenNotes->getTrendingSearches();
    test:assertTrue(response.terms.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetRelatedSearches() returns error? {
    RelatedSearchesResponse response = check listenNotes->getRelatedSearches(q = "startup");
    test:assertTrue(response.terms.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetBestPodcasts() returns error? {
    BestPodcastsResponse response = check listenNotes->getBestPodcasts();
    test:assertTrue(response.podcasts.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetPodcastById() returns error? {
    PodcastFull response = check listenNotes->getPodcastById(TEST_PODCAST_ID);
    test:assertTrue(response.id is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetEpisodeById() returns error? {
    EpisodeFull response = check listenNotes->getEpisodeById(TEST_EPISODE_ID);
    test:assertTrue(response.id is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetEpisodesInBatch() returns error? {
    GetEpisodesInBatchResponse response = check listenNotes->getEpisodesInBatch({ids: TEST_EPISODE_ID});
    test:assertTrue(response.episodes.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetPodcastsInBatch() returns error? {
    GetPodcastsInBatchResponse response = check listenNotes->getPodcastsInBatch({ids: TEST_PODCAST_ID});
    test:assertTrue(response.podcasts.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetCuratedPodcastById() returns error? {
    CuratedListFull response = check listenNotes->getCuratedPodcastById("SrM3RzHjbG0");
    test:assertTrue(response.id is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetGenres() returns error? {
    GetGenresResponse response = check listenNotes->getGenres();
    test:assertTrue(response.genres.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetPodcastRecommendations() returns error? {
    GetPodcastRecommendationsResponse response = check listenNotes->getPodcastRecommendations(TEST_PODCAST_ID);
    test:assertTrue(response.recommendations.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetEpisodeRecommendations() returns error? {
    GetEpisodeRecommendationsResponse response = check listenNotes->getEpisodeRecommendations(TEST_EPISODE_ID);
    test:assertTrue(response.recommendations.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetPlaylists() returns error? {
    PlaylistsResponse response = check listenNotes->getPlaylists();
    test:assertTrue(response.playlists is PlaylistsResponsePlaylists[]);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetPlaylistById() returns error? {
    PlaylistResponse response = check listenNotes->getPlaylistById(TEST_PLAYLIST_ID);
    test:assertEquals(response.id, TEST_PLAYLIST_ID);
}

@test:Config {groups: ["mock_tests"]}
function testPlaylistItemDataTypes() returns error? {
    if isLiveServer {
        return;
    }
    PlaylistResponse response = check listenNotes->getPlaylistById(TEST_PLAYLIST_ID);
    PlaylistItem[] items = response.items ?: [];
    test:assertEquals(items.length(), 2);
    test:assertTrue(items[0].data is PlaylistEpisodeData);
    test:assertTrue(items[1].data is PlaylistPodcastData);
}

@test:Config {groups: ["mock_tests"]}
function testSubmitPodcast() returns error? {
    if isLiveServer {
        return;
    }
    SubmitPodcastResponse response = check listenNotes->submitPodcast({rss: "https://softwareengineeringdaily.com/category/podcast/feed/"});
    test:assertEquals(response.status, "in review");
}

@test:Config {groups: ["mock_tests"]}
function testRefreshRss() returns error? {
    if isLiveServer {
        return;
    }
    RefreshRssResponse response = check listenNotes->refreshRss(TEST_PODCAST_ID);
    test:assertEquals(response.status, "refreshing");
}

@test:Config {groups: ["mock_tests"]}
function testRequestPodcastDeletion() returns error? {
    if isLiveServer {
        return;
    }
    SubmitPodcastResponse submitted = check listenNotes->submitPodcast({rss: "https://softwareengineeringdaily.com/category/podcast/feed/"});
    DeletePodcastResponse response = check listenNotes->deletePodcastById(submitted.podcast.id ?: TEST_PODCAST_ID, reason = "testing");
    test:assertEquals(response.status, "in review");
}

@test:Config {groups: ["mock_tests"]}
function testCreatePlaylist() returns error? {
    if isLiveServer {
        return;
    }
    PlaylistSummary response = check listenNotes->createPlaylist({name: "Podcasts about podcasting", visibility: "unlisted"});
    test:assertEquals(response.name, "Podcasts about podcasting");
    test:assertEquals(response.visibility, "unlisted");
}

@test:Config {groups: ["mock_tests"]}
function testUpdatePlaylist() returns error? {
    if isLiveServer {
        return;
    }
    PlaylistSummary response = check listenNotes->updatePlaylist(TEST_PLAYLIST_ID, {name: "Renamed playlist"});
    test:assertEquals(response.name, "Renamed playlist");
}

@test:Config {groups: ["mock_tests"]}
function testAddPlaylistItem() returns error? {
    if isLiveServer {
        return;
    }
    PlaylistItem response = check listenNotes->addPlaylistItem(TEST_PLAYLIST_ID, {episodeId: TEST_EPISODE_ID, notes: "Great episode"});
    test:assertTrue(response.id is int);
}

@test:Config {groups: ["mock_tests"]}
function testUpdatePlaylistItemNotes() returns error? {
    if isLiveServer {
        return;
    }
    PlaylistItem response = check listenNotes->updatePlaylistItemNotes(TEST_PLAYLIST_ID, 4321, {notes: "Updated notes"});
    test:assertEquals(response.notes, "Updated notes");
}

@test:Config {groups: ["mock_tests"]}
function testDeletePlaylistItem() returns error? {
    if isLiveServer {
        return;
    }
    PlaylistSummary playlist = check listenNotes->createPlaylist({name: "Delete item playlist"});
    PlaylistItem item = check listenNotes->addPlaylistItem(playlist.id ?: TEST_PLAYLIST_ID, {episodeId: TEST_EPISODE_ID});
    DeletePlaylistItemResponse response = check listenNotes->deletePlaylistItem(playlist.id ?: TEST_PLAYLIST_ID, item.id ?: 4321);
    test:assertTrue(response.deleted);
}

@test:Config {groups: ["mock_tests"]}
function testDeletePlaylist() returns error? {
    if isLiveServer {
        return;
    }
    PlaylistSummary playlist = check listenNotes->createPlaylist({name: "Delete playlist"});
    DeletePlaylistResponse response = check listenNotes->deletePlaylist(playlist.id ?: TEST_PLAYLIST_ID);
    test:assertTrue(response.deleted);
}
