# Provided, don't edit
require 'directors_database'
require 'pry'


# A method we're giving you. This "flattens"  Arrays of Arrays so: [[1,2],
# [3,4,5], [6]] => [1,2,3,4,5,6].

def flatten_a_o_a(aoa)
  result = []
  i = 0

  while i < aoa.length do
    k = 0
    while k < aoa[i].length do
      result << aoa[i][k]
      k += 1
    end
    i += 1
  end

  result
end

#This is just a method that adds the director_name (a string you pass in), to the
# template used for the values of the :movies keys (re movie_collection), which is
# an AoH in the NDS. Here movie_data = nds[i][:movies][i] => one movie hash like below.
#It is just copy/pasting the values from that index hash and adding a :director_name key
#with a string value.
#However there is no iteration happening here, that is what the next function is for.
# This would only work for one movie at a time.
def movie_with_director_name(director_name, movie_data)
  {
    :title => movie_data[:title],
    :worldwide_gross => movie_data[:worldwide_gross],
    :release_year => movie_data[:release_year],
    :studio => movie_data[:studio],
    :director_name => director_name
  }
end


# Your code after this point
# This function iterates through an AoH (movies_collection) for one particular director.
# It creates a new AoH or movie collection for a director, that contains :director_name key & value.
def movies_with_director_key(name, movies_collection)
  result = []
  i = 0

  while i < movies_collection.length do
    movie_data = movies_collection[i]
    result << movie_with_director_name(name, movie_data)
    i += 1
  end

  result
end
#Example result:
# [
#   {
#   		:director_name => "A director",
#       :worldwide_gross => 2,
#       :release_year => 2014,
#       :studio => "Karbit Poodles",
#       :title => "The Fire Hydrant of Doom"
#     },
#   {
#       :director_name => "A director",
#       :worldwide_gross => 2,
#       :release_year => 2014,
#       :studio => "Karbit Poodles",
#       :title => "The Fire Hydrant of Doom"
#   }
# ]

# GOAL: For each Hash in an Array (movies_collection), provide a collection
# of movies and a directors name to the movie_with_director_name method
# and accumulate the returned Array of movies into a new Array that's
# returned by this method.
#
# INPUT:
# * name: A director's name
# * movies_collection: An Array of Hashes where each Hash represents a movie
#
# RETURN:
#
# Array of Hashes where each Hash represents a movie; however, they should all have a
# :director_name key. This addition can be done by using the provided
# movie_with_director_name method

def gross_per_studio(collection)
  # GOAL: Given an Array of Hashes where each Hash represents a movie,
  # return a Hash that includes the total worldwide_gross of all the movies from
  # each studio.
  #
  # INPUT:
  # * collection: Array of Hashes where each represents a movie
  #
  # RETURN:
  # Hash whose keys are the studio names and whose values are the sum
  # total of all the worldwide_gross numbers for every movie in the input Hash
  total = {}
  i = 0
  z = 0

  while i < collection.length do
    total[collection[i][:studio]] = 0
    i += 1
  end

  while z < collection.length do
      total[collection[z][:studio]] += collection[z][:worldwide_gross]
      z += 1
  end

  total
end

def movies_with_directors_set(source)
  # GOAL: For each director, find their :movies Array and stick it in a new Array
  #
  # INPUT:
  # * source: An Array of Hashes containing director information including
  # :name and :movies
  #
  # RETURN:
  #
  # Array of Arrays containing all of a director's movies. Each movie will need
  # to have a :director_name key added to it.

  i = 0
  new_dir_array = []

  while i < source.length do
    dir_hash = source[i]
    dir_name = dir_hash[:name]
    dir_movies = dir_hash[:movies]
    
    new_dir_array << movies_with_director_key(dir_name, dir_movies)
    i += 1
  end
  new_dir_array
end

# ----------------    End of Your Code Region --------------------
# Don't edit the following code! Make the methods above work with this method
# call code. You'll have to "see-saw" to get this to work!

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end
