const { body, validationResult } = require('express-validator');

const validateRequest = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  next();
};

module.exports = {
  validateRequest,
  validateLogin: [
    body('email').isEmail(),
    body('password').isLength({ min: 8 })
  ],
  validateControlUpdate: [
    body('answer').isIn(['Yes', 'No', 'In-Progress', 'Not-Applicable']),
    body('rating').optional({ nullable: true }).isInt({ min: 1, max: 5 })
  ]
};
