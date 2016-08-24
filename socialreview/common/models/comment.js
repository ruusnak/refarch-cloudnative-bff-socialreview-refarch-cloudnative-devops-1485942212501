module.exports = function(Comment) {

  Comment.observe('before save', function(ctx, next) {

    console.log('> Comment before save triggered');

    var model = ctx.instance;
    var reviewService = Comment.app.dataSources.Review;

    reviewService.find(function(err, response, context) {
      if (err) throw err; //error making request
      if (response.error) {
        next('> response error: ' + response.error.stack);
      }
      model.comment = response;
      console.log('> data fetched successfully from remote server');
      //verify via `curl localhost:3000/api/Magazines`
      next();
    });
  });
};
