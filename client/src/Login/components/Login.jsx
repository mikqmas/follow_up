import React from 'react';
import { Redirect } from 'react-router';
import Util from '../../Util';
import '../styles/Login.css';

function Login() {
  let session = sessionStorage.getItem("session");
  const params = window.location.search;
  const newIdx = params.indexOf('new=')+4;
  const newUser = params.slice(newIdx, newIdx+4) === "true";
  if(!session) {
    const sesIdx = params.indexOf('session=')+8;
    session = params.slice(sesIdx);
    sessionStorage.setItem("session", session);
  }
  if(!session) {
    window.location = `https://sandbox.dev.clover.com/oauth/authorize?client_id=${Util.APP_ID}`;
  }
  return (
    newUser ? <Redirect to='/'/> : <Redirect to='/dash'/>
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
