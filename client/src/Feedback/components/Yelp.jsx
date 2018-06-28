import React from 'react';
import '../styles/Yelp.css'

function Yelp() {
  return (
    <div className="yelp">
      <p>
        We would love to have your feedback on Yelp. You’ll receive 30% off your
        next order. Please paste the url of your completed review in the text box below.
      </p>
      <input type="text" placeholder="eg. yelp.com/review/123"></input>
    </div>
  )
}

export default Yelp;
