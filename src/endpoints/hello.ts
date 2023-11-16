import { Request, Response } from 'express';

export default {
  getHelloWorld
}

export async function getHelloWorld(req: Request, res: Response) {
  return res.status(200).send('Hello World!')
}

