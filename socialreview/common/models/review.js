module.exports = function(Review) {

  Review.save = function(comment, itemId, rating, reviewer_email, reviewer_name, review_date, cb) {


    //var reviewService = Review.app.dataSources.review;

    Review.post(comment, itemId, rating, reviewer_email, reviewer_name, review_date, function(err, response, context) {
      if (err) throw err; //error making request
      if (response.error) {
        cb(null, '> response error: ' + response.error.stack);
      }
      console.log('> data fetched successfully from remote server');
      //verify via `curl localhost:3000/api/review`
      //next();
      cb(null, response);
    });

    }

    Review.remoteMethod(
        'save',
        {
          accepts: [{arg: 'comment', type: 'string'},
                  {arg: 'itemId', type: 'string'},
                  {arg: 'rating', type: 'string'},
                  {arg: 'reviewer_email', type: 'string'},
                  {arg: 'reviewer_name', type: 'string'},
                  {arg: 'review_date', type: 'string'}
          ],
          returns: {arg: '_id', type: 'string'}
        }
    );

};
