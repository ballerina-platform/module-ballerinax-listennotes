// Searches for episodes on a topic and collects them in a new playlist.

import ballerina/io;
import ballerinax/listennotes;

configurable string apiKey = ?;
configurable string topic = "distributed systems";
configurable string playlistName = "Distributed systems reading list";
configurable int maxEpisodes = 5;

public function main() returns error? {
    listennotes:Client listenNotes = check new ({xListenAPIKey: apiKey});

    // Step 1: Search for episodes about the topic, following next_offset until enough are found.
    string[] episodeIds = [];
    int offset = 0;
    while episodeIds.length() < maxEpisodes {
        listennotes:SearchResponse found = check listenNotes->search(q = topic, 'type = "episode", offset = offset);
        listennotes:SearchResponseResults[] results = found.results ?: [];
        foreach listennotes:SearchResponseResults result in results {
            if result is listennotes:EpisodeSearchResult {
                string? id = result.id;
                if id is string && episodeIds.length() < maxEpisodes {
                    episodeIds.push(id);
                }
            }
        }
        int? nextOffset = found.nextOffset;
        if results.length() == 0 || nextOffset is () || nextOffset <= offset {
            break;
        }
        offset = nextOffset;
    }
    if episodeIds.length() == 0 {
        return error(string `No episodes were found for '${topic}'`);
    }

    // Step 2: Create the playlist.
    listennotes:PlaylistSummary playlist = check listenNotes->createPlaylist({name: playlistName, visibility: "private"});
    string playlistId = playlist.id ?: "";
    io:println(string `Created playlist '${playlist.name ?: playlistName}' (${playlistId})`);

    // Step 3: Add each episode to the playlist.
    foreach string episodeId in episodeIds {
        listennotes:PlaylistItem item = check listenNotes->addPlaylistItem(playlistId, {episodeId, notes: string `Found by searching for ${topic}`});
        io:println(string `Added episode ${episodeId} as item ${item.id ?: 0}`);
    }

    // Step 4: Read the playlist back.
    listennotes:PlaylistResponse saved = check listenNotes->getPlaylistById(playlistId);
    io:println(string `The playlist now holds ${saved.total ?: 0} item(s)`);
}
