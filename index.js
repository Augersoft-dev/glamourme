const { ApolloServer } = require("apollo-server");
const typeDefs = require("./graphql/typedefs");
const resolvers = require("./graphql/resolvers");
const {
  createSeller,
  createSetupIntent,
  accountLinks,
  updateStripe,
  createPaymentIntent,
  // getWithdraw,
} = require("./stripe/gateway");
const { listingExist } = require("./database/queries");
const server = new ApolloServer({
  typeDefs,
  resolvers,
});

server.listen().then(({ url }) => {
  // createSeller("test@gmail.com");
  // createSetupIntent("cus_KQ1r6dANeZb9Lp");
  // accountLinks("acct_1Jtvl2RVMEm2ECK0");
  // updateStripe("acct_1JpEX7RfDHB8zaCp");
  // createPaymentIntent(2, 4);
  console.log(`🚀 Server ready at ${url}`);
});
