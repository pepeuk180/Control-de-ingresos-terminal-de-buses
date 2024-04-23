const express = require('express')
const PORT = process.env.PORT ?? 1234

// para no mostrar que esta desarrollado en express
const app = express()
app.disable('x-powered-by')
// middleware
app.use((req, res, next) => {
  console.log('mi primer middleware')
  next()
})

app.get('/', (req, res) => {
  res.send('<h1>Mi página</h1>')
})

app.post('/pokemon', (req, res) => {
  let body = ''
})

// Erro de 404
app.use((req, res) => {
  res.status(404).send('<h1>404</h1>')
})

app.listen(PORT, () => {
  console.log(`server listening on port http://localhost:${PORT}`)
})
