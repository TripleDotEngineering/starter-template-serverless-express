import serverlessExpress from '@vendia/serverless-express';
import app from '../app';

let serverlessExpressInstance : any;

async function setup(event: any, context: any) {
  /* This is where you could connect to the DB */
  
  // Create the serverless express instance
  serverlessExpressInstance = serverlessExpress({ app });
  return serverlessExpressInstance(event, context);
}

function handler(event: any, context: any) {
  if (serverlessExpressInstance) return serverlessExpressInstance(event, context);
  return setup(event, context);
}

export { handler };
