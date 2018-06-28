import React from 'react';
import Util from '../../Util';
import '../styles/Navbar.css';

class NavBar extends React.PureComponent {
  render() {
    return(
      <header>
        <nav className="left">
          <a href="/">
            <img className="followUpLogo" src="/static/img/icFollowUp.png" alt="icFollowUp"/>
          </a>
        </nav>
        <nav className="right">
          <a href="/why-follow-up">
            <div>Why Follow Up?</div>
          </a>
          {
            Util.isLoggedIn() ?
            <a href="/dash">
              <div>Go to Dashboard</div>
            </a>
            :
            <a href={`https://${Util.CLOVER_BASE}/oauth/authorize?client_id=${Util.APP_ID}`}>
              <div>Login with Clover</div>
            </a>
          }
        </nav>
      </header>
    )
  }
}

export default NavBar;
