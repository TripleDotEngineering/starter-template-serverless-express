import { createServer, Server } from 'http';
import logger from './logger';
import app from '../app';

async function initWebServer(): Promise<Server> {
  // Create the server
  logger.info('Initializing server ...');
  const httpServer: Server = createServer(app);
  logger.info('Initialized server.');

  // Connect to the database
  logger.info('This is where you\'d connect to a database ...');

  // Return the server
  return httpServer;
}

async function runWebServer() {
  // Initialize the web server
  const httpServer = await initWebServer();
  const port = process.env.PORT || 8080;

  // Print environment variables
  logger.info(`NODE_ENV: ${process.env.NODE_ENV}`);
  logger.info(`LOG_LEVEL: ${process.env.LOG_LEVEL}`);

  // Start listening
  httpServer.listen(port);
  logger.info(`Server listening on port ${port} ...`);
}

export default runWebServer;
