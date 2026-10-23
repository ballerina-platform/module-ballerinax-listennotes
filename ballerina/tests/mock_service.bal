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

listener http:Listener ep0 = new (9090);

const string PODCAST_ID = "4d3fe717742d4963a85562e9f84d8c79";
const string EPISODE_ID = "6b6d65930c5a4f71b254465871fed370";
const string PLAYLIST_ID = "m1pe7z60bsw";

function mockPodcast() returns PodcastSimple => {
    id: PODCAST_ID,
    title: "Software Engineering Daily",
    publisher: "Software Engineering Daily",
    description: "Technical interviews about software topics.",
    image: "https://cdn-images-1.listennotes.com/podcasts/software-engineering-daily/cover.jpg",
    thumbnail: "https://cdn-images-1.listennotes.com/podcasts/software-engineering-daily/thumb.jpg",
    listennotesUrl: "https://www.listennotes.com/c/4d3fe717742d4963a85562e9f84d8c79/",
    rss: "https://softwareengineeringdaily.com/category/podcast/feed/",
    website: "https://softwareengineeringdaily.com",
    language: "English",
    country: "United States",
    totalEpisodes: 2250,
    explicitContent: false,
    listenScore: 79,
    listenScoreGlobalRank: "0.5%",
    isClaimed: true,
    genreIds: [127, 157],
    'type: "episodic"
};

function mockEpisode() returns EpisodeSimple => {
    id: EPISODE_ID,
    title: "Building Reliable Distributed Systems",
    description: "A conversation about designing fault tolerant services.",
    audio: "https://www.listennotes.com/e/p/6b6d65930c5a4f71b254465871fed370/",
    audioLengthSec: 3128,
    pubDateMs: 1698278400000,
    explicitContent: false,
    link: "https://softwareengineeringdaily.com/episodes/reliable-systems",
    image: "https://cdn-images-1.listennotes.com/podcasts/software-engineering-daily/episode.jpg",
    thumbnail: "https://cdn-images-1.listennotes.com/podcasts/software-engineering-daily/episode-thumb.jpg",
    listennotesUrl: "https://www.listennotes.com/e/6b6d65930c5a4f71b254465871fed370/",
    podcast: {id: PODCAST_ID, title: "Software Engineering Daily", publisher: "Software Engineering Daily"}
};

function mockPlaylist() returns PlaylistSummary => {
    id: PLAYLIST_ID,
    name: "Podcasts about podcasting",
    description: "A hand-picked list of episodes about building podcasts.",
    visibility: "public",
    'type: "episode_list",
    episodeCount: 12,
    podcastCount: 0,
    totalAudioLengthSec: 36000,
    listennotesUrl: "https://www.listennotes.com/listen/podcasts-about-podcasting-m1pe7z60bsw"
};

function mockPlaylistItem() returns PlaylistItem => {
    id: 4321,
    'type: "episode",
    addedAtMs: 1698278400000,
    notes: "Great episode to start with",
    data: <PlaylistEpisodeData>{
        id: EPISODE_ID,
        title: "Building Reliable Distributed Systems",
        audioLengthSec: 3128,
        pubDateMs: 1698278400000,
        podcast: {id: PODCAST_ID, title: "Software Engineering Daily", publisher: "Software Engineering Daily"}
    }
};

function mockPodcastPlaylistItem() returns PlaylistItem => {
    id: 4322,
    'type: "podcast",
    addedAtMs: 1698278500000,
    notes: "Worth subscribing to",
    data: <PlaylistPodcastData>{
        id: PODCAST_ID,
        title: "Software Engineering Daily",
        publisher: "Software Engineering Daily",
        totalEpisodes: 2250
    }
};

service / on ep0 {
    # Delete a playlist.
    #
    # + id - 11-character playlist ID returned by the playlist endpoints
    # + return - The deletion result, or an error response
    resource function delete playlists/[string id]() returns DeletePlaylistResponse|http:Unauthorized|http:Forbidden|http:NotFound|http:TooManyRequests|http:Response {
        DeletePlaylistResponse res = {id: PLAYLIST_ID, deleted: true};
        return res;
    }

    # Remove an item from a playlist.
    #
    # + id - 11-character playlist ID returned by the playlist endpoints
    # + itemId - Integer playlist-item ID
    # + return - The deletion result, or an error response
    resource function delete playlists/[string id]/items/[int itemId]() returns DeletePlaylistItemResponse|ErrorResponseBadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:TooManyRequests|http:Response {
        DeletePlaylistItemResponse res = {id: itemId, deleted: true};
        return res;
    }

    # Request to delete a podcast
    #
    # + id - Podcast id
    # + reason - The reason why this podcast should be deleted
    # + return - The status of the deletion request, or an error response
    resource function delete podcasts/[string id](string? reason) returns DeletePodcastResponse|http:Unauthorized|http:NotFound|http:TooManyRequests|http:Response {
        DeletePodcastResponse res = {status: "in review"};
        return res;
    }

    # Fetch a list of best podcasts by genre
    #
    # + genreId - Genre id
    # + page - Page number of those podcasts in this genre
    # + publisherRegion - Filter best podcasts by the publisher's country/region
    # + language - Filter best podcasts by language
    # + region - Filter best podcasts by country/region
    # + sort - Sort order of the podcasts
    # + safeMode - Whether or not to exclude podcasts with explicit language
    # + return - The best podcasts, or an error response
    resource function get best_podcasts(@http:Query {name: "genre_id"} string? genreId, int? page, @http:Query {name: "publisher_region"} string? publisherRegion, string? language, string region = "us", "recent_added_first"|"oldest_added_first"|"recent_published_first"|"oldest_published_first"|"listen_score" sort = "recent_added_first", @http:Query {name: "safe_mode"} 0|1 safeMode = 0) returns BestPodcastsResponse|http:Unauthorized|http:NotFound|http:TooManyRequests|http:Response {
        BestPodcastsResponse res = {
            id: 23,
            name: "Technology",
            parentId: 67,
            total: 1,
            pageNumber: 1,
            hasNext: false,
            hasPrevious: false,
            nextPageNumber: 2,
            previousPageNumber: 0,
            listennotesUrl: "https://www.listennotes.com/best-technology-podcasts-23/",
            podcasts: [mockPodcast()]
        };
        return res;
    }

    # Fetch a curated list of podcasts by id
    #
    # + id - Curated list id
    # + return - The curated list, or an error response
    resource function get curated_podcasts/[string id]() returns CuratedListFull|http:Unauthorized|http:NotFound|http:TooManyRequests|http:Response {
        CuratedListFull res = {
            id: "SrM3RzHjbG0",
            title: "Top engineering podcasts",
            description: "Podcasts recommended by engineering leaders.",
            total: 1,
            sourceDomain: "example-engineering.org",
            sourceUrl: "https://example-engineering.org/podcasts",
            pubDateMs: 1698278400000,
            listennotesUrl: "https://www.listennotes.com/curated-podcasts/top-engineering-podcasts-SrM3RzHjbG0/",
            podcasts: [mockPodcast()]
        };
        return res;
    }

    # Fetch detailed meta data for an episode by id
    #
    # + id - Episode id
    # + showTranscript - Whether to include the transcript
    # + return - The episode, or an error response
    resource function get episodes/[string id](@http:Query {name: "show_transcript"} int showTranscript = 0) returns EpisodeFull|http:Unauthorized|http:NotFound|http:TooManyRequests|http:Response {
        EpisodeFull res = {
            id: id,
            title: "Building Reliable Distributed Systems",
            description: "A conversation about designing fault tolerant services.",
            audio: "https://www.listennotes.com/e/p/6b6d65930c5a4f71b254465871fed370/",
            audioLengthSec: 3128,
            pubDateMs: 1698278400000,
            explicitContent: false,
            listennotesUrl: "https://www.listennotes.com/e/6b6d65930c5a4f71b254465871fed370/",
            podcast: mockPodcast()
        };
        return res;
    }

    # Fetch recommendations for an episode
    #
    # + id - Episode id
    # + safeMode - Whether or not to exclude episodes with explicit language
    # + return - Recommended episodes, or an error response
    resource function get episodes/[string id]/recommendations(@http:Query {name: "safe_mode"} 0|1 safeMode = 0) returns GetEpisodeRecommendationsResponse|http:Unauthorized|http:NotFound|http:TooManyRequests|http:Response {
        GetEpisodeRecommendationsResponse res = {recommendations: [mockEpisode()]};
        return res;
    }

    # Fetch a list of podcast genres
    #
    # + topLevelOnly - Whether to show only top level genres
    # + return - The genres, or an error response
    resource function get genres(@http:Query {name: "top_level_only"} 0|1 topLevelOnly = 0) returns GetGenresResponse|http:Unauthorized|http:TooManyRequests|http:Response {
        GetGenresResponse res = {
            genres: [
                {id: 144, name: "Personal Finance", parentId: 67},
                {id: 127, name: "Technology", parentId: 67},
                {id: 93, name: "Business", parentId: 67}
            ]
        };
        return res;
    }

    # Fetch a list of your playlists.
    #
    # + sort - Sort order of the playlists
    # + page - Page number of playlists
    # + return - The playlists, or an error response
    resource function get playlists("recent_added_first"|"oldest_added_first"|"name_a_to_z"|"name_z_to_a" sort = "recent_added_first", int page = 1) returns PlaylistsResponse|http:Unauthorized|http:TooManyRequests|http:Response {
        PlaylistsResponse res = {
            total: 1,
            pageNumber: 1,
            hasNext: false,
            hasPrevious: false,
            nextPageNumber: 2,
            previousPageNumber: 0,
            playlists: [
                {
                    id: PLAYLIST_ID,
                    name: "Podcasts about podcasting",
                    visibility: "public",
                    'type: "episode_list",
                    episodeCount: 12,
                    podcastCount: 0
                }
            ]
        };
        return res;
    }

    # Fetch a playlist's info and items (i.e., episodes or podcasts).
    #
    # + id - Playlist id
    # + 'type - Select episode_list or podcast_list to fetch that view
    # + lastTimestampMs - For playlist items pagination
    # + sort - Sort order of the playlist items
    # + return - The playlist, or an error response
    resource function get playlists/[string id]("episode_list"|"podcast_list"? 'type, @http:Query {name: "last_timestamp_ms"} int lastTimestampMs = 0, "recent_added_first"|"oldest_added_first"|"recent_published_first"|"oldest_published_first" sort = "recent_added_first") returns PlaylistResponse|http:Unauthorized|http:NotFound|http:TooManyRequests|http:Response {
        PlaylistResponse res = {
            id: id,
            name: "Podcasts about podcasting",
            description: "A hand-picked list of episodes about building podcasts.",
            visibility: "public",
            'type: "episode_list",
            total: 2,
            totalAudioLengthSec: 3128,
            lastTimestampMs: 1698278400000,
            listennotesUrl: "https://www.listennotes.com/listen/podcasts-about-podcasting-m1pe7z60bsw",
            items: [mockPlaylistItem(), mockPodcastPlaylistItem()]
        };
        return res;
    }

    # Fetch detailed meta data and episodes for a podcast by id
    #
    # + id - Podcast id
    # + nextEpisodePubDate - For episodes pagination
    # + sort - Sort order of the episodes
    # + return - The podcast, or an error response
    resource function get podcasts/[string id](@http:Query {name: "next_episode_pub_date"} int? nextEpisodePubDate, "recent_first"|"oldest_first" sort = "recent_first") returns PodcastFull|http:Unauthorized|http:NotFound|http:TooManyRequests|http:Response {
        PodcastFull res = {
            id: id,
            title: "Software Engineering Daily",
            publisher: "Software Engineering Daily",
            description: "Technical interviews about software topics.",
            language: "English",
            country: "United States",
            totalEpisodes: 2250,
            explicitContent: false,
            listenScore: 79,
            listennotesUrl: "https://www.listennotes.com/c/4d3fe717742d4963a85562e9f84d8c79/",
            nextEpisodePubDate: 1698192000000,
            episodes: [
                {
                    id: EPISODE_ID,
                    title: "Building Reliable Distributed Systems",
                    audioLengthSec: 3128,
                    pubDateMs: 1698278400000
                }
            ]
        };
        return res;
    }

    # Fetch recommendations for a podcast
    #
    # + id - Podcast id
    # + safeMode - Whether or not to exclude podcasts with explicit language
    # + return - Recommended podcasts, or an error response
    resource function get podcasts/[string id]/recommendations(@http:Query {name: "safe_mode"} 0|1 safeMode = 0) returns GetPodcastRecommendationsResponse|http:Unauthorized|http:NotFound|http:TooManyRequests|http:Response {
        GetPodcastRecommendationsResponse res = {recommendations: [mockPodcast()]};
        return res;
    }

    # Fetch related search terms
    #
    # + q - Search term
    # + return - Related search terms, or an error response
    resource function get related_searches(string q) returns RelatedSearchesResponse|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:Response {
        RelatedSearchesResponse res = {terms: ["startup", "engineering leadership", "distributed systems"]};
        return res;
    }

    # Full-text search
    #
    # + q - Search term
    # + lenMax - Maximum audio length in minutes
    # + episodeCountMin - Minimum number of episodes
    # + episodeCountMax - Maximum number of episodes
    # + updateFreqMin - Minimum update frequency in hours
    # + updateFreqMax - Maximum update frequency in hours
    # + genreIds - Comma-delimited genre ids
    # + publishedBefore - Only show results published before this timestamp
    # + language - Limit results to a language
    # + region - Limit results to a region
    # + ocid - Comma-delimited podcast ids to search within
    # + ncid - Comma-delimited podcast ids to exclude
    # + sortByDate - Sort by date instead of relevance
    # + 'type - Type of content to search for
    # + offset - Offset for pagination
    # + lenMin - Minimum audio length in minutes
    # + publishedAfter - Only show results published after this timestamp
    # + onlyIn - Fields to search in
    # + safeMode - Whether or not to exclude explicit content
    # + uniquePodcasts - Keep only one episode per podcast
    # + interviewsOnly - Keep only podcasts with guest interviews
    # + sponsoredOnly - Keep only podcasts with sponsors
    # + pageSize - Maximum number of results per page
    # + return - Search results, or an error response
    resource function get search(string q, @http:Query {name: "len_max"} int? lenMax, @http:Query {name: "episode_count_min"} int? episodeCountMin, @http:Query {name: "episode_count_max"} int? episodeCountMax, @http:Query {name: "update_freq_min"} int? updateFreqMin, @http:Query {name: "update_freq_max"} int? updateFreqMax, @http:Query {name: "genre_ids"} string? genreIds, @http:Query {name: "published_before"} int? publishedBefore, string? language, string? region, string? ocid, string? ncid, @http:Query {name: "sort_by_date"} 0|1 sortByDate = 0, "episode"|"podcast"|"curated" 'type = "episode", int offset = 0, @http:Query {name: "len_min"} int lenMin = 0, @http:Query {name: "published_after"} int publishedAfter = 0, @http:Query {name: "only_in"} string onlyIn = "title,description,author,audio", @http:Query {name: "safe_mode"} 0|1 safeMode = 0, @http:Query {name: "unique_podcasts"} 0|1 uniquePodcasts = 0, @http:Query {name: "interviews_only"} 0|1 interviewsOnly = 0, @http:Query {name: "sponsored_only"} 0|1 sponsoredOnly = 0, @http:Query {name: "page_size"} int pageSize = 10) returns SearchResponse|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:Response {
        EpisodeSearchResult episode = {
            id: EPISODE_ID,
            titleOriginal: "Building Reliable Distributed Systems",
            titleHighlighted: "Building Reliable <span class=\"ln-search-highlight\">Distributed</span> Systems",
            descriptionOriginal: "A conversation about designing fault tolerant services.",
            audioLengthSec: 3128,
            pubDateMs: 1698278400000,
            explicitContent: false,
            listennotesUrl: "https://www.listennotes.com/e/6b6d65930c5a4f71b254465871fed370/"
        };
        SearchResponse res = {took: 0.05, count: 1, total: 1, nextOffset: 1, results: [episode]};
        return res;
    }

    # Find individual episodes by searching for their titles
    #
    # + q - An episode's title
    # + podcastId - Refine results to a podcast
    # + podcastIdType - The type of podcast id
    # + return - Matching episodes, or an error response
    resource function get search_episode_titles(string q, @http:Query {name: "podcast_id"} string? podcastId, @http:Query {name: "podcast_id_type"} "listennotes_id"|"itunes_id"|"spotify_id"|"rss" podcastIdType = "listennotes_id") returns SearchEpisodeTitlesResponse|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:Response {
        EpisodeSearchResult episode = {
            id: EPISODE_ID,
            titleOriginal: "Building Reliable Distributed Systems",
            titleHighlighted: "Building Reliable <span class=\"ln-search-highlight\">Distributed</span> Systems",
            audioLengthSec: 3128,
            pubDateMs: 1698278400000
        };
        SearchEpisodeTitlesResponse res = {took: 0.02, count: 1, total: 1, nextOffset: 1, results: [episode]};
        return res;
    }

    # Fetch trending search terms
    #
    # + return - Trending search terms, or an error response
    resource function get trending_searches() returns TrendingSearchesResponse|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:Response {
        TrendingSearchesResponse res = {terms: ["joe rogan", "true crime", "stock market", "ai", "history"]};
        return res;
    }

    # Typeahead search
    #
    # + q - Search term
    # + showPodcasts - Autosuggest podcasts
    # + showGenres - Autosuggest genres
    # + safeMode - Whether or not to exclude explicit content
    # + return - Suggestions, or an error response
    resource function get typeahead(string q, @http:Query {name: "show_podcasts"} 0|1 showPodcasts = 0, @http:Query {name: "show_genres"} 0|1 showGenres = 0, @http:Query {name: "safe_mode"} 0|1 safeMode = 0) returns TypeaheadResponse|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:Response {
        TypeaheadResponse res = {
            terms: ["software engineering", "software engineering daily"],
            genres: showGenres == 1 ? [{id: 127, name: "Technology", parentId: 67}] : (),
            podcasts: showPodcasts == 1
                ? [{id: PODCAST_ID, titleOriginal: "Software Engineering Daily", publisherOriginal: "Software Engineering Daily"}]
                : ()
        };
        return res;
    }

    # Batch fetch basic meta data for episodes
    #
    # + payload - Episode IDs to fetch in a batch, with optional ranking and show notes options
    # + return - The episodes, or an error response
    resource function post episodes(@http:Payload map<string> payload) returns GetEpisodesInBatchResponseOk|http:Unauthorized|http:TooManyRequests|http:Response {
        GetEpisodesInBatchResponseOk res = {body: {episodes: [mockEpisode()]}, headers: {}};
        return res;
    }

    # Create a playlist.
    #
    # + payload - Playlist details: title, type, visibility and description
    # + return - The created playlist, or an error response
    resource function post playlists(@http:Payload map<string>|CreatePlaylistRequest payload) returns PlaylistSummary|ErrorResponseBadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:TooManyRequests|http:Response {
        string name = "Untitled playlist";
        string visibility = "public";
        if payload is CreatePlaylistRequest {
            name = payload.name;
            visibility = payload.visibility ?: "public";
        } else {
            name = payload["name"] ?: name;
            visibility = payload["visibility"] ?: visibility;
        }
        if name.trim() == "" {
            ErrorResponseBadRequest bad = {body: {'error: "name must not be blank"}};
            return bad;
        }
        PlaylistSummary res = mockPlaylist();
        res.name = name;
        res.visibility = visibility == "private" ? "private" : visibility == "unlisted" ? "unlisted" : "public";
        return res;
    }

    # Add an episode or podcast to a playlist.
    #
    # + id - 11-character playlist ID returned by the playlist endpoints
    # + payload - Episode or podcast to add to the playlist, with optional notes
    # + return - The added item, or an error response
    resource function post playlists/[string id]/items(@http:Payload map<string>|AddPlaylistItemRequest payload) returns PlaylistItemOk|PlaylistItem|ErrorResponseBadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:TooManyRequests|http:Response {
        PlaylistItem res = mockPlaylistItem();
        return res;
    }

    # Batch fetch basic meta data for podcasts
    #
    # + payload - Podcast IDs or RSS feeds to fetch in a batch, with optional episode options
    # + return - The podcasts, or an error response
    resource function post podcasts(@http:Payload map<string> payload) returns GetPodcastsInBatchResponseOk|http:Unauthorized|http:TooManyRequests|http:Response {
        GetPodcastsInBatchResponseOk res = {body: {podcasts: [mockPodcast()], latestEpisodes: [mockEpisode()]}, headers: {}};
        return res;
    }

    # Refresh RSS feed of a podcast
    #
    # + id - Podcast id
    # + return - The refresh status, or an error response
    resource function post podcasts/[string id]/rss() returns RefreshRssResponseOk|http:Unauthorized|http:NotFound|http:TooManyRequests|http:Response {
        RefreshRssResponseOk res = {body: {status: "refreshing", lastRefreshedAtMs: 1698278400000}, headers: {}};
        return res;
    }

    # Submit a podcast to Listen Notes database
    #
    # + payload - RSS feed URL and optional email of the podcast to submit
    # + return - The submission status, or an error response
    resource function post podcasts/submit(@http:Payload map<string> payload) returns SubmitPodcastResponseOk|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:Response {
        SubmitPodcastResponseOk res = {
            body: {
                status: "in review",
                podcast: {id: PODCAST_ID, title: "Software Engineering Daily", publisher: "Software Engineering Daily"}
            },
            headers: {}
        };
        return res;
    }

    # Update playlist metadata.
    #
    # + id - 11-character playlist ID returned by the playlist endpoints
    # + payload - Updated playlist title, description, visibility and notes settings
    # + return - The updated playlist, or an error response
    resource function put playlists/[string id](@http:Payload map<string>|UpdatePlaylistRequest payload) returns PlaylistSummary|ErrorResponseBadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:TooManyRequests|http:Response {
        PlaylistSummary res = mockPlaylist();
        res.id = id;
        if payload is UpdatePlaylistRequest {
            res.name = payload.name ?: res.name;
            res.description = payload.description ?: res.description;
        } else {
            res.name = payload["name"] ?: res.name;
            res.description = payload["description"] ?: res.description;
        }
        return res;
    }

    # Update notes for a playlist item.
    #
    # + id - 11-character playlist ID returned by the playlist endpoints
    # + itemId - Integer playlist-item ID
    # + payload - Updated notes for the playlist item
    # + return - The updated item, or an error response
    resource function put playlists/[string id]/items/[int itemId](@http:Payload map<string>|UpdatePlaylistItemNotesRequest payload) returns PlaylistItem|ErrorResponseBadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:TooManyRequests|http:Response {
        PlaylistItem res = mockPlaylistItem();
        res.id = itemId;
        if payload is UpdatePlaylistItemNotesRequest {
            res.notes = payload.notes;
        } else {
            res.notes = payload["notes"] ?: "";
        }
        return res;
    }
}

// Service-mode response types. `bal openapi --mode client` collapses 4XX/5XX
// to `error` and never emits these, so they are defined here for the mock only.
public type ErrorResponseBadRequest record {|
    *http:BadRequest;
    ErrorResponse body;
|};

public type GetEpisodesInBatchResponseOk record {|
    *http:Ok;
    GetEpisodesInBatchResponse body;
    record {|string X\-ListenAPI\-NextBillingDate?; string X\-listenAPI\-Latency\-Seconds?; string X\-ListenAPI\-Usage?; string X\-ListenAPI\-FreeQuota?;|} headers;
|};

public type GetPodcastsInBatchResponseOk record {|
    *http:Ok;
    GetPodcastsInBatchResponse body;
    record {|string X\-ListenAPI\-NextBillingDate?; string X\-listenAPI\-Latency\-Seconds?; string X\-ListenAPI\-Usage?; string X\-ListenAPI\-FreeQuota?;|} headers;
|};

public type PlaylistItemOk record {|
    *http:Ok;
    PlaylistItem body;
    record {|string X\-ListenAPI\-NextBillingDate?; string X\-listenAPI\-Latency\-Seconds?; string X\-ListenAPI\-Usage?; string X\-ListenAPI\-FreeQuota?;|} headers;
|};

public type RefreshRssResponseOk record {|
    *http:Ok;
    RefreshRssResponse body;
    record {|string X\-ListenAPI\-NextBillingDate?; string X\-listenAPI\-Latency\-Seconds?; string X\-ListenAPI\-Usage?; string X\-ListenAPI\-FreeQuota?;|} headers;
|};

public type SubmitPodcastResponseOk record {|
    *http:Ok;
    SubmitPodcastResponse body;
    record {|string X\-ListenAPI\-NextBillingDate?; string X\-listenAPI\-Latency\-Seconds?; string X\-ListenAPI\-Usage?; string X\-ListenAPI\-FreeQuota?;|} headers;
|};

public type ErrorResponse record {
    string 'error?;
};
