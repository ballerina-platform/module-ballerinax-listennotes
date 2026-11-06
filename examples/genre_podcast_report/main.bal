// Reports the best podcasts in a genre together with their most recent episodes.

import ballerina/io;
import ballerinax/listennotes;

configurable string apiKey = ?;
configurable string genreName = "Technology";
configurable string region = "us";

public function main() returns error? {
    listennotes:Client listenNotes = check new ({xListenAPIKey: apiKey});

    // Step 1: Resolve the genre name to its id.
    listennotes:GetGenresResponse genres = check listenNotes->getGenres();
    int? genreId = ();
    foreach listennotes:Genre genre in genres.genres {
        if genre.name == genreName {
            genreId = genre.id;
            break;
        }
    }
    if genreId is () {
        return error(string `Genre '${genreName}' was not found`);
    }

    // Step 2: Fetch the best podcasts in that genre.
    listennotes:BestPodcastsResponse best = check listenNotes->getBestPodcasts(genreId = genreId.toString(), region = region);
    io:println(string `Best podcasts in ${best.name} (${best.total} in total)`);

    // Step 3: Print the latest episodes of each podcast.
    foreach listennotes:PodcastSimple podcast in best.podcasts {
        string podcastId = podcast.id ?: "";
        if podcastId == "" {
            continue;
        }
        listennotes:PodcastFull details = check listenNotes->getPodcastById(podcastId);
        io:println(string `${details.title ?: podcastId} - ${details.totalEpisodes ?: 0} episodes`);
        foreach listennotes:EpisodeMinimum episode in (details.episodes ?: []) {
            io:println(string `  * ${episode.title ?: "Untitled"}`);
        }
    }
}
