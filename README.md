# 🎧 Music Recommendation System using Neo4j & Cypher

## 📌 Overview

This project implements a graph-based music recommendation system using Neo4j. The goal is to model users, tracks, artists, and genres in a graph structure to identify listening patterns and generate personalized music recommendations.

Graph databases are ideal for this type of problem because they make it easy to navigate connections such as "users who liked similar songs", "songs from artists a user follows", and "tracks related by genre".

## 🚀 Project Objectives

The system is designed to:

- Represent users, tracks, artists, and genres as nodes in a graph.
- Represent interactions such as listening, liking, or following using relationships with properties.
- Use Cypher queries to generate personalized recommendations based on graph connections.

## 🧩 Graph Data Model

### Node Labels

- User
- Track
- Artist
- Genre

### Relationships

| Relationship                                       | Description                       |
| -------------------------------------------------- | --------------------------------- |
| `(:User)-[:LISTENED {times}]->(:Track)`            | User listened to a track          |
| `(:User)-[:LIKED]->(:Track)`                       | User liked a track                |
| `(:User)-[:FOLLOWS]->(:Artist)`                    | User follows an artist            |
| `(:Track)-[:BY_ARTIST]->(:Artist)`                 | Track created by an artist        |
| `(:Track)-[:IN_GENRE]->(:Genre)`                   | Track belongs to a genre          |
| `(:Artist)-[:IN_GENRE]->(:Genre)`                  | Artist is associated with a genre |

This structure enables multiple recommendation strategies such as collaborative filtering, artist-based recommendations, and genre-based suggestions.

## 🧱 Data Model Diagram

![Music Recommendation Graph Model](data_model_music.png)

## 🔍 Useful Cypher Queries

1. Recommend tracks based on genres the user listens to

```cypher
MATCH (u:User {id:"u1"})-[:LISTENED]->(:Track)-[:IN_GENRE]->(g:Genre)
MATCH (g)<-[:IN_GENRE]-(t:Track)
RETURN DISTINCT t.title AS track, g.name AS genre;
```


