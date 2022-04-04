const { gql } = require("apollo-server");

module.exports = gql`
  type listing {
    category: String!
    subCategory: String!
    title: String!
    description: String!
    latitude: Float
    longitude: Float
    address: String
    pricing: Int!
    images: [String]
  }
  input listingObj {
    category: String!
    subCategory: String!
    title: String!
    description: String!
    latitude: Float
    longitude: Float
    address: String
    pricing: Int!
    images: [String]
  }
  type listOfListings {
    Listings: [listing]
    errorMsg: String
  }
  type listingInRadius {
    Listings: [listing]
    errorMsg: String!
    noOfResults: Int
  }
  type balance {
    available: Float
    pending: Float
  }
  type bookingDetail {
    bookerID: Int
    name: String
    multiple_days: Boolean
    start_day: String
    end_day: String
  }
  input point {
    latitude: Float!
    Longitude: Float!
  }
  input AccountDetails {
    user_ID: Int!
    account_holder_name: String!
    account_holder_type: String!
    routing_number: String!
    account_number: String!
  }
  type dates {
    start_day: String
    end_day: String
  }
  type Query {
    "A simple type for getting started!"
    hello: String
    getAllListings(userToken: String): listOfListings #for getting listing of a user who is logged in
    getAllListingInRadius(
      Point: point!
      mCat: String
      sCat: String
    ): listingInRadius #getting all listing in a radius
    getAllListingsNoCondition(approve: String): listOfListings #get all listing no condition applied
    getSingleListing(ID: Int!): listing #getting listing by a specific ID
    getUserBalance(ID: String!): balance
    generateAccoutLink(ID: String!): String
    getBookingDetails(ID: Int): [bookingDetail] #used to get all details of the listing booker
    getBookingDatesByID(ID: Int): [dates] #used to get when dates that specific listing is booked
    getMainCategory: [String]
    getSubCategory(mCat: String): [String]
    propertyTypes: [String]
    adminLogin(email: String, password: String): String
    getlistingOwnerID(jwt: String!, listingID: Int): String
    getCmnts(ID: Int): [String]
    getImagesByListingID(ID: Int): [String]
    getListingsTobeApproved(token: String, listingID: Int): [toBeApproved] #get list of listing that needs tp be approved
    getFavListings(token: String): listOfListings
    login(token: String): String
  }
  type toBeApproved {
    bookerID: Int
    listingID: Int
    bookerName: String
    start_date: String
    end_date: String
    multipleDays: Boolean
  }
  type Comment {
    comnt: String
  }
  input registerSeller {
    email: String
    city: String
    country: String
    line1: String
    line2: String
    postal_code: String
    state: String
    routing_number: String
    account_number: String
    day: String
    month: String
    year: String
    first_name: String
    last_name: String
    phone: String
    ssn_last_4: String
    ip: String
    id: Int
  }
  type Message {
    message: String!
  }
  type paymentIntentSecret {
    id: String
    client_secret: String
  }
  input signUpData {
    email: String
    socialMediaToken: String
    name: String
  }
  type Mutation {
    addSellerInfo(RegisterSeller: registerSeller!): String
    addListing(token: String!, ListingObj: listingObj!): Message!
    deleteListing(token: String, listingID: Int): String!
    addExternalAccount(accountDetails: AccountDetails!): String
    approveListingUser(token: String, status: String, listingID: Int): String
    bookListing(
      listingID: Int!
      jwt: String!
      startingDate: String!
      endingDate: String
      multipleDays: Boolean
    ): String
    PaymentIntent(
      listingID: Int
      sellerID: Int
      noOfDays: Int
    ): paymentIntentSecret
    updateUserToken(token: String, newToken: String!): String
    signup(SignUpData: signUpData): String
    changeApproval(
      listingID: Int
      jwt: String
      approve: String
      cmnt: String
    ): String
    addFavListing(token: String, listingID: Int): String
    removeFavListing(token: String, listingID: Int): String
  }
`;
