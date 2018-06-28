import React from 'react';
import Review from './Review';
import '../styles/SingleFeedback.css'

function SingleFeedback({data}) {
  return (
    <div className="single-feedback">
      <p>{data.name}</p>
      <Review/>
    </div>
  )
}

export default SingleFeedback;
