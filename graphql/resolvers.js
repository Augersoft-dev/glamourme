const { UserInputError } = require("apollo-server-errors");
const { GraphQLError } = require("graphql");
const {
  getUsersListing,
  addListing,
  filterByRadius,
  deleteByID,
  getListingByID,
  createUser,
  fetchStripeID,
  updateUserRegistrationToken,
  checkIfExist,
  listingExist,
  bookingDetails,
  getName,
  getBookingDates,
  signUPData,
  getAllListingNoCond,
  adminCred,
  checkAdminExist,
  approveListing,
  approveListingWithCmnt,
  getUserIDbyListingID,
  getDeviceID,
  getComments,
  addForApproval,
  getImagesByID,
  fetchFavListing,
  addFav,
  removeFav,
} = require("../database/queries");
const { signToken, verifyToken } = require("../JWT");
const {
  getBalance,
  createSeller,
  createBankAccountToken,
  addBankAccount,
  accountLinks,
  createPaymentIntent,
} = require("../stripe/gateway");
module.exports = {
  Query: {
    hello: () => "world",
    adminLogin: async (parent, args, context, info) => {
      try {
        const result = await adminCred(args.email, args.password);
        const jwt = await signToken(result[0].id);
        // console.log("IF");
        return jwt;
      } catch (error) {
        // console.log("else");
        return new GraphQLError(error);
      }
    },
    getCmnts: async (parent, args, context, info) => {
      const { ID } = args;
      // console.log(ID);
      try {
        const result = await getComments(ID);
        // console.table(result);
        console.log("res", result);
        return result;
      } catch (error) {
        return error;
      }
    },
    getFavListings: async (parent, args, context, info) => {
      const { token } = args;
      const decoded = await verifyToken(token);
      console.log(decoded.id[0].id);
      try {
        const favListings = await fetchFavListing(decoded.id[0].id);
        console.log(favListings);
        return { Listings: favListings };
      } catch (error) {
        return new GraphQLError(error);
      }
    },
    getAllListings: async (parent, args, context, info) => {
      const { userToken } = args;
      try {
        // console.log("try");
        const decoded = await verifyToken(userToken);
        console.log(decoded.id[0].id);
        const listings = await getUsersListing(decoded.id[0].id);
        return {
          Listings: listings,
          errorMsg: "",
        };
      } catch (error) {
        // console.log("try");
        return {
          listings: [],
          errorMsg: error,
        };
      }
    },
    getImagesByListingID: async (parent, args, context, info) => {
      const { ID } = args;
      try {
        const result = await getImagesByID(ID);
        // console.log(result);
        return result;
      } catch (error) {
        return GraphQLError(error);
      }
    },
    propertyTypes: (parent, args, context, info) => {
      return ["Entire Place", "Private Room", "Shared Room"];
    },
    getAllListingInRadius: async (parent, args, context, info) => {
      const { latitude, Longitude } = args.Point;
      const { mCat, sCat } = args;
      // console.log(mCat, sCat);
      try {
        let listing;
        if (latitude && Longitude && mCat && sCat) {
          listings = await filterByRadius(latitude, Longitude, mCat, sCat);
          // console.log("MCAT AND SCAT");
        } else if (latitude && Longitude && mCat) {
          listings = await filterByRadius(latitude, Longitude, mCat);
          // console.log("MCAT");
        } else if (latitude && Longitude) {
          listings = await filterByRadius(latitude, Longitude);
          // console.log("nothing");
        }
        const l = listings.length;
        return {
          Listings: listings,
          errorMsg: "",
          noOfResults: l,
        };
      } catch (error) {
        return {
          listings: [],
          errorMsg: error,
          noOfResults: 0,
        };
      }
    },
    getSingleListing: async (parent, args, context, info) => {
      try {
        const response = await getListingByID(args.ID);
        return response;
      } catch (error) {
        return new UserInputError(error);
      }
    },
    getUserBalance: async (parent, args, context, info) => {
      const balance = await getBalance();
      return {
        available: balance.available[0].amount,
        pending: balance.pending[0].amount,
      };
    },
    generateAccoutLink: async (parent, args, context, info) => {
      // console.log(args);
      const link = await accountLinks(args.ID);
      console.log(link);
      return link;
    },
    getBookingDetails: async (parent, args, context, info) => {
      const { ID } = args;
      try {
        const result = await bookingDetails(ID);
        let names = result.map((o) => {
          const name = getName(o.bookerID);
          return name;
        });
        // console.log(p);
        names = await Promise.all(names);
        names.map((o, i) => {
          result[i].name = o[0].name;
          delete result[i].id;
          delete result[i].listing_id;
        });
        // console.log(result);
        return result;
      } catch (error) {
        return new GraphQLError(error);
      }
    },
    getlistingOwnerID: async (parent, args, context, info) => {
      const { jwt, listingID } = args;
      try {
        const decode = await jwt;
        const userID = await getUserIDbyListingID(listingID);
        // console.log(userID);
        const deviceID = await getDeviceID(userID[0].user_id);
        // console.log(deviceID);
        return deviceID[0].registerToken;
      } catch (error) {
        return error;
      }
    },
    getBookingDatesByID: async (parent, args, context, info) => {
      const { ID } = args;
      try {
        const result = await getBookingDates(ID);
        // console.log(result);
        result.map((o) => {
          o.start_day = new Date(o.start_day).toLocaleDateString();
          o.end_day = new Date(o.end_day).toLocaleDateString();
        });
        return result;
      } catch (error) {
        console.log(error);
      }
    },
    getAllListingsNoCondition: async (parent, args, context, info) => {
      const { approve } = args;
      try {
        const result = await getAllListingNoCond(approve);
        // console.log(result);
        // console.log(result[2]);
        return {
          Listings: result,
          errorMsg: "",
        };
      } catch (error) {
        return {
          Listings: null,
          errorMsg: error,
        };
        // console.log(error);
      }
    },
    getMainCategory: (parent, args, context, info) => {
      return [
        "Haircuts",
        "Manicure",
        "Hair Brading",
        "Henna Tattoos",
        "Eyebrow threading",
        "Facials",
        "Cupping",
        "Foot Scrub Massage",
        "Lashs",
        "Hair Conditioning",
        "Makeup",
        "Waxing/Tinting",
      ];
    },
    getSubCategory: (parent, args, context, info) => {
      const { mCat } = args;
      if (mCat === "Home") {
        return ["Villa", "Condo", "Apartment", "Pant House"];
      } else if (mCat === "Entertainment") {
        return ["Movie Theatre", "Table Tennis", "Basketball Court", "Gym"];
      } else if (mCat === "Gamming") {
        return ["Gamming Computer", "PS5", "XBOX one", "ARCADE"];
      }
    },
    getListingsTobeApproved: async (parent, args, context, info) => {
      const { token, listingID } = args;
      const decode = await verifyToken(token);
      const ownerID = decode.id[0].id;
      // console.log(token, listingID);
    },
  },

  Mutation: {
    addSellerInfo: async (parent, args, context, info) => {
      const {
        email,
        city,
        country,
        line1,
        line2,
        postal_code,
        state,
        routing_number,
        account_number,
        day,
        month,
        year,
        first_name,
        last_name,
        phone,
        ssn_last_4,
        ip,
        id,
      } = args.RegisterSeller;
      const stripe_ID = await createSeller(
        email,
        city,
        country,
        line1,
        line2,
        postal_code,
        state,
        routing_number,
        account_number,
        day,
        month,
        year,
        first_name,
        last_name,
        phone,
        ssn_last_4,
        ip
      );
      // console.log(stripe_ID);
      try {
        const result = await createUser(id, stripe_ID.id);
        return result;
      } catch (error) {
        return error;
      }
    },
    addExternalAccount: async (parent, args, context, info) => {
      const {
        user_ID,
        account_holder_name,
        account_holder_type,
        routing_number,
        account_number,
      } = args.accountDetails;
      const result = await createBankAccountToken(
        account_holder_name,
        account_holder_type,
        routing_number,
        account_number
      );
      // console.log(result.id);
      try {
        const stripe_ID = await fetchStripeID(user_ID);
        // console.log(result.id, stripe_ID);
        const bank = await addBankAccount(result.id, stripe_ID);
      } catch (error) {
        console.log(error);
      }
    },
    addListing: async (parent, args, context, info) => {
      // console.log(Object.values(args.ListingObj));
      try {
        const decode = await verifyToken(args.token);
        const res = await addListing(
          Object.values(args.ListingObj),
          decode.id[0].id
        );
        return {
          message: res,
        };
      } catch (error) {
        return {
          message: error,
        };
      }
    },

    deleteListing: async (parent, args, context, info) => {
      try {
        const decode = await verifyToken(args.token);
        const response = await deleteByID(args.listingID);
        return response;
      } catch (error) {
        return error;
      }
    },
    bookListing: async (parent, args, context, info) => {
      const { listingID, jwt, startingDate, endingDate, multipleDays } = args;
      // console.log(startingDate, "    ", endingDate);
      try {
        const decode = await verifyToken(jwt);
        const doListingExist = await listingExist(
          listingID,
          decode.id[0].id,
          startingDate,
          endingDate,
          multipleDays
        );
        if (doListingExist) {
          const result = await addForApproval(
            startingDate,
            endingDate,
            listingID,
            multipleDays,
            decode.id[0].id
          );
          return result;
        } else {
          return "LISTING YOU ARE TRYING TO BOOK DOES NOT EXIST!";
        }
      } catch (error) {
        return error;
      }
    },
    PaymentIntent: async (parent, args, context, info) => {
      const { listingID, sellerID, noOfDays } = args;
      const pi = await createPaymentIntent(listingID, sellerID, noOfDays);
      // console.log(pi);
      return {
        id: pi.id,
        client_secret: pi.client_secret,
      };
    },

    updateUserToken: async (parent, args, context, info) => {
      const { userID, newToken } = args;
      try {
        const decoded = await verifyToken(args.token);
        const result = await updateUserRegistrationToken(userID, newToken);
        return "TOKEN UPDATED";
      } catch (error) {
        return error;
      }
    },
    login: async (parent, args, context, info) => {
      const { token } = args;
      try {
        const result = await checkIfExist(token);
        return result;
      } catch (error) {
        return error;
      }
      //jsonwebtoken will be created here
      // console.log(result);
    },
    signup: async (parent, args, context, info) => {
      // console.log("wow");
      const { email, socialMediaToken, name } = args.SignUpData;
      try {
        const result = await signUPData(name, email, socialMediaToken);
        const token = await signToken(result);
        // console.log(result);
        return token;
      } catch (error) {
        return error;
      }
      // console.log(email, socialMediaToken, name);
    },
    addFavListing: async (parent, args, context, info) => {
      const { token, listingID } = args;
      const decoded = await verifyToken(token);
      console.log(decoded.id[0].id);
      try {
        const addListing = await addFav(decoded.id[0].id, listingID);
        console.log(addListing);
        return addListing;
      } catch (error) {
        return new GraphQLError(error);
      }
    },
    removeFavListing: async (parent, args, context, info) => {
      const { token, listingID } = args;
      const decoded = await verifyToken(token);
      console.log(decoded.id[0].id);
      try {
        const removeListing = await removeFav(decoded.id[0].id, listingID);
        return removeListing;
      } catch (error) {
        return new GraphQLError(error);
      }
    },
    changeApproval: async (parent, args, context, info) => {
      const { listingID, jwt, approve, cmnt } = args;
      // console.log(listingID, approve);
      try {
        const token = await verifyToken(jwt);
        // console.log(token.id);
        let response;
        if (cmnt) {
          response = await approveListingWithCmnt(
            listingID,
            approve,
            cmnt,
            token.id
          );
          return response;
        } else {
          response = await approveListing(listingID, approve);
          return "LISTING UPDATED";
        }
        // const result = await checkAdminExist(token.id);

        console.log(response);
      } catch (error) {
        return new GraphQLError(error);
      }
    },
  },
};
