const express = require('express')
const movies = require('./extranjeros.json')
const extranjeros = require('./extranjeros.json')
const nacionales = require('./nacionales.json')

const app = express()
// middleware
app.use(express.json())

app.disable('x-powered-by')

app.get('/', (req, res) => {
  res.json({ message: 'hola mundo' })
})
// Identifica todos los recursos en movies
app.get('/movies', (req, res) => {
  const { genre } = req.query
  if (genre) {
    const filteredMovies = movies.filter(
      movie => movie.genre.some(g => g.toLocaleLowerCase() === genre.toLocaleLowerCase())
    )
    return res.json(filteredMovies)
  }
  res.json(movies)
})

app.get('/movies/:id', (req, res) => {
  const { id } = req.params
  const movie = movies.find(movie => movie.id === id)
  if (movie) return res.json(movie)
  res.status(404).json({ message: 'Movie not found' })
})

app.get('/extranjeras/:id', (req, res) => {
  const { id } = req.params
  const persona = extranjeros.find(persona => extranjeros.n_identificacion === id)
  if (persona) {
    return res.json(persona)
  }
  res.status(404).json({ message: 'Person not found' })
})

app.get('/nacionales/:id', (req, res) => {
  const { id } = req.params
  const persona = nacionales.find(persona => nacionales.n_identificacion === id)
  if (persona) {
    return res.json(persona)
  }
  res.status(404).json({ message: 'Person not found' })
})

app.post('/movies', (req, res) => {
  const {
    title,
    genre,
    year,
    director,
    duration,
    rate,
    poster
  } = req.body
  
  const newMovie = {
    id: crypto.randomUUID(),
    title,
    genre,
    director,
    year,
    duration,
    rate: rate ?? 0,
    poster
  }
  movies.push(newMovie)

  res.status(201).json(newMovie)
})

const PORT = process.env.PORT ?? 1234

app.listen(PORT, () => {
  console.log(`server listening on port http://localhost:${PORT}`)
})
