import React from 'react';
import '../styles/Login.css'
import Util from '../../Util';

function Login() {
  const CLOVER_BASE = 'sandbox.dev.clover.com';
  const APP_ID = 'TGN2F8DTRSYG2';
  const APP_SECRET = '987fda60-b5ed-18ee-99c1-18667de95d8b';
  const params = window.location.search;
  const codeIdx = params.indexOf('code=');
  const AUTHORIZATION_CODE = params.slice(codeIdx+5);
//   const url = `https://${CLOVER_BASE}/oauth/token?client_id=${APP_ID}&client_secret=${APP_SECRET}
// &code=${AUTHORIZATION_CODE}`
const url = `https://sandbox.dev.clover.com/oauth/token?client_id=${APP_ID}&client_secret=${APP_SECRET}
&code=${AUTHORIZATION_CODE}`

  fetch(url)
  .then(Util.handleErrors)
  .then(res=>res.json())
  .then(json=>{console.log("json: ",json); this.getSession()})
  .catch(error => console.log("error: ", error));
  return (
    <div></div>
  )
}

export default Login;


// componentWillMount() {
//   fetch('api/v1/clover/login', {
//     accept: 'application/json',
//   })
//   .then(Util.handleErrors)
//   .then(res=>res.json())
//   .then(json=>{console.log("json: ",json); this.getSession()})
//   .catch(error => console.log("error: ", error));
// }
//
// getSession() {
//   fetch('api/v1/clover/test', {
//     accept: 'application/json',
//   })
//   .then(Util.handleErrors)
//   .then(res=>res.json())
//   .then(json=>{console.log("json: ",json)})
//   .catch(error => console.log("error: ", error));
// }
// render() {
//   return (
//     <div className="login">
//       hello world
//     </div>
//   )
// }
