const http = require('node:http') // protocolo de HTTP
const fs = require('node:fs')

const desiredPort = process.env.PORT ?? 1234

const processRequest = (req, res) => {
  console.log('request recieved: ', req.url)
  if (req.url === '/') {
    res.setHeader('Content-Type', 'text/html; charset=utf-8')
    res.end('Bienvenido a la página de inicio')
  } else if (req.url === '/imagen-super-bonita.png') {
    fs.readFile('./img.jpg', (err, data) => {
      if (err) {
        res.statusCode = 500
        res.end('<h1>500 Internal Server Error</h1>')
      } else {
        res.setHeader('Content-Type', 'image/jpg')
        res.end(data)
      }
    })
  } else if (req.url === '/contacto') {
    res.end('<h1>Contacto</h1>')
  } else {
    res.statusCode = 404
    res.end('<h1>404</h1>')
  }
}

const server = http.createServer(processRequest)

server.listen(desiredPort, () => {
  console.log(`server listening on port http://localhost:${desiredPort}`)
})
