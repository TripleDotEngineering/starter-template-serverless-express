// This (config) must be imported first, otherwise logs will be configured improperly
import './services/config';
import runWebServer from './services/server';

(async function main() {
  // Start listening
  runWebServer();
}());
