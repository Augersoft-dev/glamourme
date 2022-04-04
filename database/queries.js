const db = require("../database/db");
const { signToken } = require("../JWT");

//for fetching the the listing of specific user
const getUsersListing = (userID) => {
  return new Promise((resolve, reject) => {
    const query =
      "SELECT * FROM listings INNER JOIN(SELECT i.listing_id,GROUP_CONCAT(i.img_url) as images FROM images i GROUP BY listing_id) as T ON listings.id=T.listing_id AND listings.user_id=?";
    db.query(query, [userID], async (err, result, field) => {
      if (err) {
        reject("THERE WAS AN ERROR WHILE FETCHING THE INFORMATION");
      }
      if (result.length) {
        result.map((o) => {
          o.images = o.images.split(",");
          o.images = o.images.map((o) => "https://hopplace.com/images/" + o);
        });
        resolve(result);
      } else {
        reject("THERE IS NO LISTING UNDER YOUR USERNAME");
      }
    });
  });
};
const addImages = (images) => {
  console.log(images);
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO images(listing_id,img_url) VALUES ?";
    db.query(query, [images], (err, result) => {
      if (err) {
        console.log(err);
        reject("SOME ERROR OCCURED");
      }
      if (result) {
        resolve(result);
      } else {
        reject("SOME OCCURED");
      }
    });
  });
};
const addListing = (arr, id) => {
  // console.log(arr)
  const images = arr.splice(-1, 1);
  // console.log(images);
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO listings (user_id,category,subCategory,title,description,latitude,longitude,address,price) values(?,?,?,?,?,?,?,?,?);";
    arr.unshift(id);
    console.log(arr)
    db.query(query, arr, async (err, result) => {
      if (err) {
        console.log(err)
        return reject(err);
      }
      if (result.affectedRows) {
        const imagesArray = images[0].map((o, i) => {
          return [result.insertId, o];
        });
        try {
          const r = await addImages(imagesArray);
          console.log(r);
        } catch (error) {
          console.log(error);
        }

        resolve("LISTING ADDED SUCCESSFULLY FOR REVIEW");
      } else {
        console.log(err);
        reject("SOME ERROR OCCURED PEASE TRY AGAIN!");
      }
    });
  });
};

const filterByRadius = (lat, long, mCat, sCat) => {
  return new Promise((resolve, reject) => {
    // console.log(lat, long, mCat, sCat);
    let query;
    let arr = [];
    console.log(mCat);
    if (lat && long && mCat && sCat) {
      // console.log("is");
      query =
        "SELECT *, (3959 * acos (cos(radians(?))* cos(radians(latitude))* cos(radians(longitude) - radians(?))+ sin (radians(?))* sin(radians(latitude)))) AS distance FROM listings HAVING distance < 100 AND category=(?) AND subCategory=(?) ORDER BY distance";
      // console.log(1);
      arr = [lat, long, lat, mCat, sCat];
    } else if (lat && long && mCat) {
      console.log("tis");
      query =
        "SELECT *, (3959 * acos (cos(radians(?))* cos(radians(latitude))* cos(radians(longitude) - radians(?))+ sin (radians(?))* sin(radians(latitude)))) AS distance FROM listings HAVING distance < 100 AND category=(?) ORDER BY distance";
      arr = [lat, long, lat, mCat];
    } else {
      query =
        "SELECT *, (3959 * acos (cos(radians(?))* cos(radians(latitude))* cos(radians(longitude) - radians(?))+ sin (radians(?))* sin(radians(latitude)))) AS distance FROM listings HAVING distance < 100 ORDER BY distance";
      arr = [lat, long, lat];
    }
    // console.log(query);
    db.query(query, arr, (err, result, fields) => {
      console.log(result);

      if (err) {
        // console.log(err);
        reject("COULD GET ANYTHING");
      }
      // console.log("query : ", result);
      resolve(result);
    });
  });
};

const deleteByID = (ID) => {
  // console.log(ID);
  return new Promise((resolve, reject) => {
    const query = "DELETE FROM listings WHERE id=?";
    db.query(query, [ID], (err, result) => {
      if (err) {
        reject("UNABLE TO DELETE PLEASE TRY AGAIN!");
      }
      if (result.affectedRows) {
        resolve("LISTING DELETED SUCCESSFULLY");
      } else {
        reject("THE POST YOU ARE TRYING TO DELETE DOES'NT EXIST");
      }
    });
  });
};

const fetchFavListing = async (id) => {
  const query =
    "SELECT * FROM listings inner join fav ON listings.id=fav.listing_id and bookerID=?";
  return new Promise((resolve, reject) => {
    db.query(query, [id], (err, result) => {
      if (err) {
        reject("UNABLE TO GET A RESPONSE");
      }
      if (result.length) {
        resolve(result);
      } else {
        reject("NO LISTINGS TO FETCH");
      }
    });
  });
};

const getListingsTobeApproved = async (listingID, ownerID) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM approval where listingID=?";
    db.query(query, [listingID], (err, result) => {
      if (err) {
        reject("UNABLE TO PROCESS THE REQUEST");
      }
      if (result.length) {
        console.log(result);
        resolve(result);
      } else {
        reject("NOBODY HAS BOOKED THIS LISTING");
      }
    });
  });
};

const getImagesByID = (listingID) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM images WHERE listing_id=?";
    db.query(query, [listingID], (err, result) => {
      if (err) {
        reject("UNABLE TO FETCH IMAGES");
      }
      if (result.length) {
        const arr = result.map((o) => {
          return "https://hopplace.com/images/" + o.img_url;
        });
        resolve(arr);
      } else {
        reject("NO IMAGES TO FETCH");
      }
    });
  });
};

const getListingByID = (ID) => {
  return new Promise((resolve, reject) => {
    const query =
      "SELECT * FROM listings INNER JOIN(SELECT i.listing_id,GROUP_CONCAT(i.img_url) as images FROM images i GROUP BY listing_id ) as T ON listings.id=T.listing_id WHERE id=?";
    db.query(query, [ID], (err, result) => {
      if (err) {
        reject("UNABLE TO FETCH ALL DATA");
      }
      if (result.length) {
        resolve(result[0]);
      }
      reject("NO LISTING EXISIT WITH THE GIVEN ID");
    });
  });
};
const getAllListingNoCond = (approve) => {
  const query =
    "SELECT * FROM listings INNER JOIN(SELECT i.listing_id,GROUP_CONCAT(i.img_url) as images FROM images i GROUP BY listing_id ) as T ON listings.id=T.listing_id WHERE approve=?";
  if (
    !(approve == "pending" || approve == "approved" || approve == "rejected")
  ) {
    return new error("WRONG OPTION SELECTED");
  }
  // console.log(query);
  return new Promise((resolve, reject) => {
    db.query(query, [approve], (err, result) => {
      if (err) {
        reject("NO LISTING EXIST");
      }
      // console.log(result);
      if (result) {
        result.map((o) => {
          o.images = o.images.split(",");
          o.images = o.images.map((o) => "https://hopplace.com/images/" + o);
        });
        resolve(result);
      } else {
        reject("NO LISTING EXIST");
      }
    });
  });
};

const checkAdminExist = (id) => {
  const query = "SELECT id FROM Admin WHERE ID=?";
  return new Promise((resolve, reject) => {
    db.query(query, [id], (err, result) => {
      if (err) {
        reject("UNABLE TO GET A RESPONSE FROM SERVER");
      }
      if (result.length != 0) {
        resolve(result);
      } else {
        reject("WRONG CRED");
      }
    });
  });
};

const createUser = (id, stripe_ID) => {
  // console.log(email, stripe_ID);
  return new Promise((resolve, reject) => {
    const query = "UPDATE users set stripe_ID=? WHERE id=?";
    db.query(query, [stripe_ID, id], (err, result) => {
      if (err) {
        reject("UNABLE TO CREATE STRIPE ACCOUNT!");
      }
      if (result) {
        resolve("STRIPE ACCOUNT REGISTERD");
      } else {
        reject("UNABLE TO CREATE STRIPE ACCOUNT!");
      }
    });
  });
};

const fetchStripeID = (userID) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT stripe_ID FROM users WHERE id=(?)";
    db.query(query, [userID], (err, result) => {
      if (err) {
        reject("SOME ERROR OCCURED PLEASE TRY AGAIN!");
      }
      if (result) {
        resolve(result[0].stripe_ID);
      } else {
        reject("SOME ERROR OCCURED PLEASE TRY AGAIN!");
      }
    });
  });
};

const updateUserRegistrationToken = (userID, newToken) => {
  return new Promise((resolve, reject) => {
    const query = "UPDATE users SET registerToken=(?) WHERE ID=(?)";
    db.query(query, [newToken, userID], (err, result) => {
      if (err) {
        reject("SOME ERROR OCCURED PLEASE TRY AGAIN!");
      }
      if (result) {
        resolve(result.affectedRows);
      } else {
        reject("SOME ERROR OCCURED PLEASE TRY AGAIN!");
      }
    });
  });
};

const checkIfExist = (token) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM users WHERE socialMediaToken=(?)";
    db.query(query, [token], async (err, result) => {
      if (err) {
        reject("SOME ERROR OCCURED PLEASE TRY AGAIN!");
      }
      if (result.length) {
        console.log(result);
        const token = await signToken(result);
        resolve(token);
        // resolve(result);
      } else {
        reject("YOU ARE NOT REGISTERD ON OUR PLATFORM,PLEASE SIGN UP");
      }
    });
  });
};
const getDeviceID = (userID) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT registerToken from users WHERE id=?";
    db.query(query, [userID], (err, result) => {
      if (err) {
        reject("UNABLE TO GET A RESPONSE FROM SERVER");
      }
      if (result.length) {
        resolve(result);
      } else {
        reject("NO USER EXIST WITH GIVEN ID");
      }
    });
  });
};
const getUserIDbyListingID = (listingID) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT user_id from listings WHERE id=?";
    db.query(query, [listingID], (err, result) => {
      if (err) {
        reject("ERROR OCCURED PLEASE TRY AGAIN!");
      }
      if (result.length) {
        resolve(result);
      }
      reject("NO LISTINGS WITH GIVEN ID EXIST");
    });
  });
};

const signUPData = (name, email, socialMediaToken) => {
  return new Promise((resolve, reject) => {
    const query =
      "INSERT into users(email,username,socialMediaToken) VALUES(?,?,?)";
    db.query(query, [email, name, socialMediaToken], (err, result) => {
      if (err) {
        console.log(err);
        return reject(err.code);
      }
      if (result.affectedRows) {
        resolve(result.insertId);
      } else {
        reject("TRY AGAIN");
      }
    });
  });
};

datesAvailable = (startDate, endDate) => {
  const query =
    "select * from approval where start_date AND end_date between (?) and (?)";
  return new Promise((resolve, reject) => {
    db.query(query, [startDate, endDate], (err, result) => {
      if (err) {
        reject("SOME ERROR OCCURED PLEASE TRY AGAIN!");
      }
      if (result.length) {
        reject("GIVEN DATES ARE NOT AVAILABLE FOR BOOKING");
      } else {
        resolve(true);
      }
    });
  });
};

addForApproval = (startDate, endDate, listingID, multipleDays, bookerID) => {
  const query =
    "insert into approval(listingID,start_date,end_date,bookerID,multipleDays) value(?,?,?,?,?)";
  return new Promise((resolve, reject) => {
    db.query(
      query,
      [listingID, startDate, endDate, bookerID, multipleDays],
      (err, result) => {
        if (err) {
          console.log(err);
          reject("UNABLE TO GET A RESPONSE FROM SERVER");
        }
        if (result) {
          resolve("APPROVAL IS PENDING");
        } else {
          reject("DATES ARE UNAVAILABLE");
        }
      }
    );
  });
};

listingExist = (id) => {
  const query = "SELECT * FROM listings WHERE ID=(?)";
  return new Promise((resolve, reject) => {
    db.query(query, [id], (err, result) => {
      if (err) {
        reject("SOME ERROR OCCURED PLEASE TRY AGAIN!");
      }
      if (result.length) {
        resolve(true);
      } else {
        reject("LISTING YOU ARE TRYING TO BOOK DOES NOT EXIST!");
      }
    });
  });
};

const bookingDetails = async (ID) => {
  const query = "SELECT * FROM bookedListings WHERE listing_id=(?)";
  return new Promise((resolve, reject) => {
    db.query(query, [ID], (err, result) => {
      if (err) {
        reject("ERROR OCCURED WHILE FETCHING THE DETAILS");
      }
      if (result.length) {
        resolve(result);
      } else {
        reject("NO ONE HAS BOOKED");
      }
    });
  });
};

const getName = async (ID) => {
  const query = "SELECT name FROM users WHERE id=(?)";
  return new Promise((resolve, reject) => {
    db.query(query, [ID], (err, result) => {
      if (err) {
        reject("NAME UNDEFINED");
      }
      if (result.length) {
        resolve(result);
      } else {
        reject("NAME NOT FOUND");
      }
    });
  });
};

const bookListing = (
  listing,
  listingOwner,
  listingBuyer,
  oneDay,
  startDate,
  endDate
) => {};

const getPriceOfListing = (ID) => {
  const query = "SELECT pricing FROM listings WHERE id=(?)";
  return new Promise((resolve, reject) => {
    db.query(query, [ID], (err, result) => {
      if (err) {
        reject("SOME ERROR OCCURED");
      }
      if (result.length) {
        resolve(result);
      } else {
        reject("NO PRICE TO FETCH");
      }
    });
  });
};

const getBookingDates = (ID) => {
  const query =
    "SELECT start_day,end_day FROM bookedlistings WHERE listing_id=(?)";
  return new Promise((resolve, reject) => {
    db.query(query, [ID], (err, result) => {
      if (err) {
        reject("UNABLE TO FETCH DATA");
      }
      if (result.length) {
        resolve(result);
      } else {
        reject("NO BOOKING");
      }
    });
  });
};

const adminCred = (email, password) => {
  const query = "SELECT * FROM Admin WHERE email=? AND password=?";
  return new Promise((resolve, reject) => {
    db.query(query, [email, password], (err, result) => {
      if (err) {
        reject("WRONG CREDS");
      }
      console.log(result);
      if (result) {
        resolve(result);
      } else {
        reject("WRONG RESULT");
      }
    });
  });
};

const approveListing = (listingID, approve) => {
  let query = "UPDATE listings SET approve=? WHERE id=?";
  if (!(approve == "approved" || approve == "rejected")) {
    return new error("WRONG OPTION SELECTED");
  }
  return new Promise((resolve, reject) => {
    db.query(query, [approve, listingID], (err, result) => {
      if (err) {
        reject("UNABLE TO GET RESPONSE FROM SERVER");
      }
      // console.log(result);
      if (result.affectedRows) {
        resolve(result);
      } else {
        reject("NO LISTING WITH THE GIVEN ID EXIST");
      }
    });
  });
};
const getComments = (ID) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT comnt FROM moderation_comment WHERE listing_id=?";
    db.query(query, [ID], (err, result) => {
      if (err) {
        return reject("UNABLE TO FETCH COMMENT");
      }
      if (result) {
        const arr = result.map((o) => o.comnt);
        return resolve(arr);
        // console.log(arr);
      } else {
        return reject("NO COMMENTS TO FETCH");
      }
    });
  });
};
const approveListingWithCmnt = async (listingID, approve, cmnt, adminID) => {
  // console.log(cmnt);
  try {
    const r = await approveListing(listingID, approve);
    const query =
      "INSERT INTO  moderation_comment(listing_id,admin_id,comnt) values(?,?,?) ON DUPLICATE KEY UPDATE comnt=(?)";
    return new Promise((resolve, reject) => {
      db.query(query, [listingID, adminID, cmnt, cmnt], (err, result) => {
        if (err) {
          reject("UNABLE TO POST COMMENT");
        }
        if (result) {
          resolve("COMMENT UPDATED");
        } else {
          reject("UNABLE TO POST COMMENT");
        }
      });
    });
  } catch (error) {
    return error;
  }
};
const addFav = (id, listingID) => {
  const query = "INSERT INTO fav(listing_id,bookerID) values(?,?)";
  return new Promise((resolve, reject) => {
    db.query(query, [listingID, id], (err, result) => {
      if (err) {
        reject("UNABLE TO GET A RES FROM THE SERVER");
      }
      if (result) {
        resolve("LISTING ADDED TO FAV");
      } else {
        reject("UNABLE TO GET A RES FROM THE SERVER");
      }
    });
  });
};
const removeFav = (id, listingID) => {
  const query = "DELETE FROM fav WHERE listing_id=? AND bookerID=?";
  return new Promise((resolve, reject) => {
    db.query(query, [listingID, id], (err, result) => {
      if (err) {
        reject("UNABLE TO GET A RES FROM THE SERVER");
      }
      if (result) {
        resolve("LISTING REMOVED FROM FAV");
      } else {
        reject("UNABLE TO GET A RES FROM THE SERVER");
      }
    });
  });
};
const registerUser = (email, socialMediaToken, name) => {};
module.exports = {
  getUsersListing,
  addListing,
  filterByRadius,
  deleteByID,
  getListingByID,
  createUser,
  fetchStripeID,
  updateUserRegistrationToken,
  checkIfExist,
  registerUser,
  listingExist,
  bookingDetails,
  getName,
  getBookingDates,
  getPriceOfListing,
  getAllListingNoCond,
  signUPData,
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
};
