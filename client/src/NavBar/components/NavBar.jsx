import React from 'react';

import '../styles/Navbar.css';

class NavBar extends React.PureComponent {
  render() {
    const loggedIn = false;
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
            loggedIn ?
            <a href="/dash">
              <div>Go to Dashboard</div>
            </a>
            :
            <a href="/login">
              <div>Login</div>
            </a>
          }
        </nav>
      </header>
    )
  }
}

export default NavBar;
