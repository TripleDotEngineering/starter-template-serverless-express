/**
 * @description This module is used to configure the environment variables
 * for the application by loading the .env file. This module MUST be imported
 * first by the entrypoint at runtime in order for configuration to work.
 */
import path from 'path';
import dotenv from 'dotenv';

// Determine the .env file path
const dotEnvPath = process.env.NODE_ENV === 'production'
  ? '.env'
  : path.normalize(`${__dirname}/../../.env.development`);

// eslint-disable-next-line no-console
console.log(`Loading configuration from: \n\t${dotEnvPath}`);

// Load the environment variables
dotenv.config({ path: dotEnvPath });
