import React from 'react';
import '../styles/Result.css'

function Result({data}) {
  return (
    <div className="result">
      {data.title}
    </div>
  )
}

export default Result;
