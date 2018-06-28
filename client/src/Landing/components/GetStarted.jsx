import React from 'react';
import Util from '../../Util';
import '../styles/GetStarted.css';

function GetStarted() {
  return (
    <div className="get-started">
      {Util.isLoggedIn() ?
        <a href="/dash" className="start-button">Get Started - It's Free</a> :
        <a href="/register" className="start-button">Get Started - It's Free</a>}
      <a href="/dash" className="goto-dash">Go to dashboard →</a>
    </div>
  )
}

export default GetStarted;
