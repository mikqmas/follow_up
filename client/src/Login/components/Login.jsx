import React from 'react';
import '../styles/Login.css'
import Util from '../../Util';

class Login extends React.PureComponent {
  componentWillMount() {
    fetch('api/v1/clover/login', {
      accept: 'application/json',
    })
    .then(Util.handleErrors)
    .then(res=>res.json())
    .then(json=>{console.log("json: ",json); this.getSession()})
    .catch(error => console.log("error: ", error));
  }

  getSession() {
    fetch('api/v1/clover/test', {
      accept: 'application/json',
    })
    .then(Util.handleErrors)
    .then(res=>res.json())
    .then(json=>{console.log("json: ",json)})
    .catch(error => console.log("error: ", error));
  }
  render() {
    return (
      <div className="login">
        hello world
      </div>
    )
  }
}

export default Login;
