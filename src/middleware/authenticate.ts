/**
 * *** DO NOT USE THIS IN PRODUCTION ***
 * 
 * This authentication module is for demonstration purposes only. 
 * It uses a HARDCODED API Key. 
 * 
 * *** DO NOT USE THIS IN PRODUCTION ***
 */

const unsafeHardcodedKey = 'MjgazfPTSjzXUx5mrp1cAQ=='

export default function authenticate(req: any, res: any, next: any) {
  try {
    const authorization = req.headers.authorization || req.headers.Authorization
    const token = authorization.split(' ')[1]
    if (token === unsafeHardcodedKey) {
      req.user = { username: 'demo' }
      return next();
    }
    return res.status(401).send({ message: 'Unauthorized' })
  }
  catch (e: any) {
    return res.status(401).send({ message: 'Unauthorized' })
  }
}