CREATE CONSTRAINT user_id IF NOT EXISTS
FOR (u:User) REQUIRE u.id IS UNIQUE;

CREATE CONSTRAINT track_id IF NOT EXISTS
FOR (t:Track) REQUIRE t.id IS UNIQUE;

CREATE CONSTRAINT artist_id IF NOT EXISTS
FOR (a:Artist) REQUIRE a.id IS UNIQUE;

CREATE CONSTRAINT genre_id IF NOT EXISTS
FOR (g:Genre) REQUIRE g.id IS UNIQUE;


UNWIND [
  {id: 1, name: "Laura"},
  {id: 2, name: "Carla"},
  {id: 3, name: "Diego"},
  {id: 4, name: "Andres"},
  {id: 5, name: "Carol"},
  {id: 6, name: "Juliana"},
  {id: 7, name: "Diana"},
  {id: 8, name: "Santiago"},
  {id: 9, name: "Daniel"},
  {id: 10, name: "Ricardo"}
] AS userData
CREATE (:User {id: userData.id, name: userData.name});


UNWIND [
  {id: "a1", name: "Coldplay"},
  {id: "a2", name: "Shakira"},
  {id: "a3", name: "Katy Perry"},
  {id: "a4", name: "Adele"},
  {id: "a5", name: "Green Day"},
  {id: "a6", name: "Nirvana"},
  {id: "a7", name: "System of a Down"},
  {id: "a8", name: "Metallica"},
  {id: "a9", name: "Maroon 5"}
] AS artistData
CREATE (:Artist {id: artistData.id, name: artistData.name});



UNWIND [
  {id: "s101", song: "Yellow", year: 2000},
  {id: "s102", song: "Speed of Sound", year: 2008},
  {id: "s103", song: "Trouble", year: 2011},
  {id: "s104", song: "In my place", year: 2012},
  {id: "s105", song: "Viva la Vida", year: 2013},
  {id: "s106", song: "The Scientist", year: 2007},

  {id: "s201", song: "Pies descalzos", year: 1995},
  {id: "s202", song: "TQG", year: 2023},
  {id: "s203", song: "Hips don't lie", year: 2005},

  {id: "s301", song: "I kissed a girl", year: 2008},
  {id: "s302", song: "Firework", year: 2010},
  {id: "s303", song: "E.T.", year: 2010},
  {id: "s304", song: "Roar", year: 2013},

  {id: "s401", song: "Hello", year: 2015},
  {id: "s402", song: "Set fire to the rain", year: 2011},
  {id: "s403", song: "Rolling in the deep", year: 2011},

  {id: "s501", song: "Wake Me Up When September Ends", year: 2013},
  {id: "s502", song: "Boulevard of Broken Dreams", year: 2004},
  {id: "s503", song: "Basket Case", year: 2017},

  {id: "s600", song: "Dumb", year: 1993},
  {id: "s601", song: "All Apologies", year: 1993},
  {id: "s602", song: "Polly", year: 1994},
  {id: "s603", song: "Rape Me", year: 1993},

  {id: "s701", song: "Lonely Day", year: 2010},
  {id: "s702", song: "B.Y.O.B.", year: 2005},
  {id: "s703", song: "Aerials", year: 2011},

  {id: "s801", song: "One", year: 1998},
  {id: "s802", song: "Fuel", year: 1996},
  {id: "s803", song: "Nothing Else Matters", year: 1991},

  {id: "s901", song: "Payphone", year: 2012},
  {id: "s902", song: "She Will Be Loved", year: 2011},
  {id: "s903", song: "This Love", year: 2002}
] AS trackData
CREATE (:Track {
  id: trackData.id,
  song: trackData.song,
  year: trackData.year
});



UNWIND [
  {id: "g1", type: "Rock"},
  {id: "g2", type: "Electronic"},
  {id: "g3", type: "Pop"},
  {id: "g4", type: "Dance"},
  {id: "g5", type: "Metal"}
] AS genreData
CREATE (:Genre {id: genreData.id, type: genreData.type});


UNWIND [
  {artist: "Coldplay", tracks: ["s101","s102","s103","s104","s105","s106"]},
  {artist: "Shakira", tracks: ["s201","s202","s203"]},
  {artist: "Katy Perry", tracks: ["s301","s302","s303","s304"]},
  {artist: "Adele", tracks: ["s400","s401","s402"]},
  {artist: "Green Day", tracks: ["s501","s502","s503"]},
  {artist: "Nirvana", tracks: ["s600","s601","s602","s603"]},
  {artist: "System of a Down", tracks: ["s701","s702","s703"]},
  {artist: "Metallica", tracks: ["s802","s803","s804"]},
  {artist: "Maroon 5", tracks: ["s901","s902","s903"]}
] AS entry


MATCH (a:Artist {name: entry.artist})

UNWIND entry.tracks AS trackId
MATCH (t:Track {id: trackId})

MERGE (t)-[:BY_ARTIST]->(a);

UNWIND [
  {artist:"Coldplay", genre:"Pop"},
  {artist:"Shakira", genre:"Pop"},
  {artist:"Katy Perry", genre:"Pop"},
  {artist:"Adele", genre:"Pop"},
  {artist:"Green Day", genre:"Rock"},
  {artist:"Nirvana", genre:"Rock"},
  {artist:"System of a Down", genre:"Metal"},
  {artist:"Metallica", genre:"Metal"},
  {artist:"Maroon 5", genre:"Pop"}
] AS entry

MATCH (a:Artist {name: entry.artist})
MATCH (g:Genre {type: entry.genre})
MERGE (a)-[:IN_GENRE]->(g);

UNWIND [
  {track:"s101", genre:"Pop"},
  {track:"s102", genre:"Pop"},
  {track:"s103", genre:"Pop"},
  {track:"s104", genre:"Pop"},
  {track:"s105", genre:"Electronic"},
  {track:"s106", genre:"Pop"},

  {track:"s201", genre:"Pop"},
  {track:"s202", genre:"Dance"},
  {track:"s203", genre:"Pop"},

  {track:"s301", genre:"Pop"},
  {track:"s302", genre:"Pop"},
  {track:"s303", genre:"Pop"},
  {track:"s304", genre:"Dance"},

  {track:"s400", genre:"Pop"},
  {track:"s401", genre:"Pop"},
  {track:"s402", genre:"Electronic"},

  {track:"s501", genre:"Rock"},
  {track:"s502", genre:"Rock"},
  {track:"s503", genre:"Rock"},

  {track:"s600", genre:"Rock"},
  {track:"s601", genre:"Rock"},
  {track:"s602", genre:"Rock"},
  {track:"s603", genre:"Rock"},

  {track:"s701", genre:"Metal"},
  {track:"s702", genre:"Metal"},
  {track:"s703", genre:"Metal"},

  {track:"s802", genre:"Metal"},
  {track:"s803", genre:"Metal"},
  {track:"s804", genre:"Metal"},

  {track:"s901", genre:"Pop"},
  {track:"s902", genre:"Pop"},
  {track:"s903", genre:"Pop"}
] AS entry

MATCH (t:Track {id: entry.track})
MATCH (g:Genre {type: entry.genre})
MERGE (t)-[:IN_GENRE]->(g);

UNWIND [
  {user:1, track:"s101", times:4},
  {user:1, track:"s102", times:2},
  {user:2, track:"s203", times:5},
  {user:3, track:"s304", times:1},
  {user:4, track:"s501", times:3},
  {user:5, track:"s703", times:20},
  {user:6, track:"s803", times:6},
  {user:7, track:"s902", times:4},
  {user:8, track:"s105", times:2},
  {user:9, track:"s106", times:5},
  {user:10, track:"s301", times:10}
] AS entry

MATCH (u:User {id: entry.user})
MATCH (t:Track {id: entry.track})
MERGE (u)-[r:LISTENED]->(t)
SET r.times = entry.times;

UNWIND [
  {user:1, track:"s101"},
  {user:2, track:"s105"},
  {user:3, track:"s203"},
  {user:4, track:"s304"},
  {user:5, track:"s501"},
  {user:6, track:"s703"},
  {user:7, track:"s803"},
  {user:8, track:"s902"},
  {user:8, track:"s105"},
  {user:9, track:"s106"},
  {user:10, track:"s301"}
] AS entry

MATCH (u:User {id: entry.user})
MATCH (t:Track {id: entry.track})
MERGE (u)-[:LIKED]->(t);

UNWIND [
  {user:1, artist:"Coldplay"},
  {user:2, artist:"Shakira"},
  {user:3, artist:"Katy Perry"},
  {user:4, artist:"Green Day"},
  {user:5, artist:"Metallica"},
  {user:6, artist:"Nirvana"},
  {user:7, artist:"Maroon 5"},
  {user:8, artist:"Adele"},
  {user:9, artist:"System of a Down"},
  {user:10, artist:"Coldplay"}
] AS entry

MATCH (u:User {id: entry.user})
MATCH (a:Artist {name: entry.artist})
MERGE (u)-[:FOLLOWS]->(a);

