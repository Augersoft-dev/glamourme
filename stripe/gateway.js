const { getPriceOfListing, fetchStripeID } = require("../database/queries");

require("dotenv").config();

const stripe = require("stripe")(
  "sk_test_51JkWNcDs9JlsrPB48gYlhnorxnzUFoBfikgXCRxiTrVXYzFKU62B80g30hq6GAPL2M91BfdA1gmNvUqzSrIujy6g00XQgXxlM0"
);
//console.log(process.env.stripe_private_key);

const createSeller = async (
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
  // accID
) => {
  try {
    const customer = await stripe.accounts.create({
      country: "US",
      type: "custom",
      email,
      // charges_enabled: true,ll
      capabilities: {
        card_payments: {
          requested: true,
        },
        transfers: {
          requested: true,
        },
      },
      business_type: "individual",
      business_profile: {
        mcc: 6513,
        url: "www.hopplace.com",
      },
      individual: {
        address: {
          city,
          country,
          line1,
          line2,
          postal_code,
          state,
        },
        dob: {
          day,
          month,
          year,
        },
        first_name,
        last_name,
        phone,
        ssn_last_4,
        email,
      },
      external_account: {
        object: "bank_account",
        country: "US",
        currency: "USD",
        routing_number,
        account_number,
      },
      tos_acceptance: {
        date: Math.floor(Date.now() / 1000),
        ip,
      },
      // payouts_enabled: true,
    });
    console.log(customer);
    return customer; //save custome ID in database
  } catch (error) {
    console.log(error);
  }
};

const accountLinks = async (ID) => {
  const accountLinks = await stripe.accountLinks.create({
    account: ID,
    return_url: "https://hopplace.com",
    refresh_url: "https://hopplace.com",
    type: "account_onboarding",
  });
  return accountLinks.url;
  console.log(accountLinks);
};

const createSetupIntent = async (customer_id) => {
  try {
    const setupIntent = await stripe.setupIntents.create({
      customer: customer_id,
    });
    console.log(setupIntent.client_secret);
  } catch (error) {
    console.log(error);
  }
};

const getBalance = async (ID) => {
  try {
    const balance = await stripe.balance.retrieve({
      stripeAccount: ID,
    });
    // console.log(balance);
    return balance;
  } catch (error) {
    console.log("error");
  }
};

const addBankAccount = async (external_account, stripe_ID) => {
  console.log(external_account, stripe_ID);
  const bankAccount = await stripe.accounts.createExternalAccount(stripe_ID, {
    external_account,
  });
  console.log(bankAccount);
};
const createBankAccountToken = async (
  account_holder_name,
  account_holder_type,
  routing_number,
  account_number
) => {
  const token = await stripe.tokens.create({
    bank_account: {
      country: "US",
      currency: "usd",
      account_holder_name,
      account_holder_type,
      routing_number,
      account_number,
    },
  });
  return token;
};

// const getWithdraw = async () => {
//   const transfer = await stripe.transfers.create({
//     amount: 200,
//     currency: "usd",
//     destination: "acct_1JnMNFRjsBl5WNti",
//   });
//   console.log(transfer);
// };

const updateStripe = async (STRIPE_ID) => {
  try {
    const account = await stripe.accounts.update(STRIPE_ID, {
      tos_acceptance: {
        date: Math.floor(Date.now() / 1000),
        ip: "39.46.75.158",
      },
    });
  } catch (error) {
    console.log(error);
  }
};

const createPaymentIntent = async (listingID, sellerID, totalNoOfDays) => {
  const price = await getPriceOfListing(listingID);
  console.log(price[0].pricing);
  const stripeID = await fetchStripeID(sellerID);
  console.log(stripeID);
  const paymentIntent = await stripe.paymentIntents.create({
    amount: price[0].pricing * totalNoOfDays,
    currency: "usd",
    application_fee_amount: Math.floor(price[0].pricing * totalNoOfDays * 0.05),
    transfer_data: {
      destination: stripeID,
    },
  });
  return paymentIntent;
};

module.exports = {
  updateStripe,
  createSeller,
  createSetupIntent,
  getBalance,
  accountLinks,
  createBankAccountToken,
  addBankAccount,
  createPaymentIntent,
  // getWithdraw,
};
