class Album:
    def __init__(self, albumid, name, cover, uri):
        self._id = albumid
        self._name = name
        self._cover = cover
        self._uri = uri
        self._songs = []

    def add_song(self, song):
        self._songs.append(song)

    def get_id(self):
	return self._id

    def get_name(self):
	return self._name

    def get_cover(self):
	return self._cover

    def get_uri(self):
	return self._uri

    def get_songs(self):
	return self._songs

    def set_cover(self, cover):
        self._cover = cover

class Song:
    def __init__(self, number, filename):
        self._number = number
        self._filename = filename

    def get_number(self):
	return self._number

    def get_filename(self):
	return self._filename

class Movie:
    def __init__(self, movieid, cover, name, uri):
        self._id = movieid
        self._cover = cover
        self._name = name
        self._uri = uri

    def get_id(self):
        return self._id

    def get_cover(self):
        return self._cover

    def get_name(self):
        return self._name

    def get_uri(self):
        return self._uri

    def set_cover(self, cover):
        self._cover = cover

    def set_uri(self, uri):
        self._uri = uri

class Picture:
    def __init__(self, pictureid, thumbnail, uri):
        self._id = pictureid
        self._thumbnail = thumbnail
        self._uri = uri

    def get_id(self):
        return self._id

    def get_thumbnail(self):
        return self._thumbnail

    def get_uri(self):
        return self._uri

class BackendDevice:
    def __init__(self, client, uid, devicetype):
        self._client = client
        self._uid = uid
        self._type = devicetype
        self._albums = []
        self._movies = []
        self._pictures = []

    '''
    -------------------
     GETTERS & SETTERS
    -------------------
    '''

    def get_client(self):
        return self._client 

    def set_client(self, client):
        self._client = client

    def get_uid(self):
        return self._uid

    def set_uid(self, uid):
        self._uid = uid

    def get_type(self):
        return self._type

    def set_type(self, type):
        self._type = type

    def get_albums(self):
        return self._albums

    def set_albums(self, albums):
        self._albums = albums

    def get_movies(self):
        return self._movies

    def set_movies(self, movies):
        self._movies = movies

    def get_pictures(self):
        return self._pictures

    def set_pictures(self, pictures):
        self._pictures = pictures


    '''
     adds an album to the device's list
    '''
    def add_album(self, album):
        tmp = self.find_album(album.get_id())
        if tmp is None:
            self._albums.append(album)
    
    def add_picture(self, picture):
        tmp = self.find_picture(picture.get_id())
        if tmp is None:
            self._pictures.append(picture)

    def add_movie(self, movie):
        tmp = self.find_movie(movie.get_id())
        if tmp is None:
            self._movies.append(movie)

    def find_picture(self, id):
        for picture in self._pictures:
            if picture.get_id() == id:
                return picture
            
    def find_album(self, id):
        for album in self._albums:
            if album.get_id() == id:
                return album
                    
    def find_movie(self, id):
        for movie in self._movies:
            if movie.get_id() == id:
                return movie 


