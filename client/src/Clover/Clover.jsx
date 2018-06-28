import React from 'react';
import '../styles/Clover.css'
import Util from '../../Util';

function Clover() {
  function checkUser() {
    const test = Util.fetch('https://jsonplaceholder.typicode.com/posts')
    test.then(resp=>console.log(resp))
  }

  checkUser();

  return (
    <div className="login">
    </div>
  )
}

export default Clover;
