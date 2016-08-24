module.exports = function(Review) {

 // Handle the reivew GET operation
  Review.observe('access', function(ctx, next) {

    console.log('> Review access triggered');
    //var context = loopback.getCurrentContext();
    //var itemId = context.active.http.req.query.itemId;

    //var model = ctx.instance;
    var reviewService = app.dataSources.Review;

    reviewService.find({"itemId": "1024"}, function(err, response, context) {
      if (err) throw err; //error making request
      if (response.error) {
        next('> response error: ' + response.error.stack);
      }
      model.review = response;
      console.log('> data fetched successfully from remote server');
      //verify via `curl localhost:3000/api/review`
      next();
    });
  });

};
