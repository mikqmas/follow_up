import React from 'react';
import Util from '../../Util';

function Clover() {
  fetch('api/v1/clover/test', {
    accept: 'application/json',
  })
  .then(Util.handleErrors)
  .then(res=>res.json())
  .then(json=>console.log("json: ",json))
  .catch(error => console.log("error: ", error));

  return (
    <div>test</div>
  )
}

export default Clover;

// fetch('api/v1/clover/auth', {
