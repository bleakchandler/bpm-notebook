# BPM Notebook

## Summary
Back in the golden age of disco, DJs would create setlists using BPM notebooks - large references of the year's biggest hits organized by BPM (beats per minute). They would then use these references to create sets for a given night with a consistent tempo, dynamic range and mood based on the atmosphere of the party. Thanks to the magic of Spotify, we've now written an app that does the same thing!

This app was written by [Josh Frank](https://github.com/josh-frank) and [James DeSousa](https://github.com/jamesdesousa) during their time at [Flatiron School](https://flatironschool.com/). It was written as an exercise software engineering concepts, including the use of ORM using SQL and the creation of a CLI. The app uses 'tty-prompt' to create a handsome interface, and the `ActiveRecord` ORM to persist users, setlists and songs. It also makes extensive use of `RSpotify`, a Ruby wrapper for the Spotify API written by [Guilherme Gorgulho](https://www.linkedin.com/in/guilhermesad/).

## Instructions

After forking and cloning this repository, run `bundle install` in the terminal to install dependencies, then run it with `ruby bin/run.rb`. After the welcome screen, a user will be prompted to sign in. A new user will be created if a nonexistent username is provided.

```
Enter Username James
Welcome back, James!
Enter your password •••
James has logged in successfully
Press any key to continue 
```

The main menu displays a list of a user's extant setlists as well as menu options for creating a new setlist or deleting an extant setlist after a confirmation. Each setlist has a target tempo which the app will use to make suggestions.

```
Choose a setlist or create a new setlist: 
‣ James's amazing set (110.25 BPM)
  (new setlist)
  (delete setlist)
  (quit)
```

Upon selecting a setlist, a user can see a list of the setlist's current songs and will be presented with a menu of setlist options:

```
Setlist name: James's amazing set (110.25 BPM)
1. Nellie - Dr. Dog (2013)
2. With Arms Outstretched - Rilo Kiley (2002)
3. Empire State of Mind (Part II) Broken Down - Alicia Keys (2009)
4. Cigarette Daydreams - Cage The Elephant (2013)
5. Still D.R.E. - Dr. Dre (1999)
Options: (Press ↑/↓ arrow to move and Enter to select)
‣ Add song from Spotify
  Suggest song from Spotify
  Remove song from setlist
  Clear setlist
  Go back to main menu
```

The first two menu options will add a song to the current setlist. A user can select from a menu listing all the given user's Spotify playlists, then another menu listing all the songs in a given Spotify playlist, from which the user can select to add the song the setlist currently being edited. The app can also suggest a song based on a variety of song features relevant to the art of disc-jockeying:

```
User James's Spotify playlists: 
Choose a playlist to suggest songs from driving 
Choose a feature to suggest by (Press ↑/↓ arrow to move and Enter to select)
‣ Tempo
  Danceability
  Energy
  Valence
  Loudness
...
Choose a feature to suggest by Tempo
How close to setlist's tempo should the suggested song be? 15
```

After selecting a feature and specifying a range to search for, the app will make a series of requests to the Spotify API using `RSpotify` and then display a list of songs in the specified Spotify playlist which conform to the user-specified filter:

```
Suggestions from James's playlist 'driving ' - filtered by tempo ±95.25..125.25
Choose a suggested song from playlist driving  to add to James's amazing set
‣ With Arms Outstretched
  Yeah Alright
  Because You Move Me
  Nothin But Time
  Amour plastique
  Car Camping
```

A user can also remove a song from the current setlist, or remove all songs by selecting `Clear setlist`:

```
Are you sure you want to remove all songs from setlist 'James's amazing set?' Yes
Setlist 'James's amazing set' cleared successfully.
Press any key to continue 
```

## Acknowledgments

James and Josh could not have completed this assignment without the amazing and patient help of our instructors, [Sylwia Vargas](https://www.linkedin.com/in/sylwia-vargas/en-us/) and [Hasibul Chowdhury](#)!