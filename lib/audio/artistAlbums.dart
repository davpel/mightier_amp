// (c) 2020 Dian Iliev (Tuntorius)
// This code is licensed under MIT license (see LICENSE.md for details)

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'albumTracks.dart';

class ArtistAlbums extends StatelessWidget {
  final String artist;
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  ArtistAlbums(this.artist);
  @override
  Widget build(BuildContext context) {
    Future<List<AlbumInfo>> album =
        audioQuery.getAlbumsFromArtist(artist: artist);
    return Scaffold(
      appBar: AppBar(title: Text("$artist albums")),
      body: FutureBuilder<List<AlbumInfo>>(
        future: album,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              // TODO: Handle this case.
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: FlatButton(
                          color: Colors.grey[700],
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AlbumTracks(
                                    snapshot.data[index].id,
                                    snapshot.data[index].artist)));
                          },
                          child: Text(
                            snapshot.data[index].title,
                            style: TextStyle(color: Colors.white),
                          )),
                    );
                  });
              break;
          }
          return Text("Loading...");
        },
      ),
    );
  }
}
