import express, { Request, Response } from 'express';
import compression from 'compression';
import { getHelloWorld } from './endpoints/hello';
import { version } from '../package.json';
import authenticate from './middleware/authenticate';
import logger from './services/logger';

const app = express();

/**
 * This function always returns a 200 OK response. It can be used to test the
 * application / determine if the server is up.
 */
function healthcheck(req: any, res: Response) {
  logger.info('GET /healthcheck');
  res.set('Content-Type', 'application/json');
  res.status(200).json({ status: 200, message: 'OK', version: version });
}

/* Load Middleware */
app.use(
  compression(),
  express.json()
);

/* Routes */
app.get('/healthcheck', healthcheck);
app.get('/hello', authenticate, getHelloWorld);

/* Catch-all route for 404 errors */
app.get('*', (req: Request, res: Response) => {
  return res.status(404).send({ message: 'Not Found' });
});


export default app;



