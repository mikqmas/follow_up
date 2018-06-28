import React from 'react';
import GetStarted from './GetStarted';
import '../styles/Frontpage.css';

function FrontPage() {
  return (
    <main className="frontpage">
      <div className="splash">
        <h1>Get Feedback, Win Loyalty</h1>
        <h2>Keep in touch with your valued customers while getting invaluable feedback.
          Reward them when they revisit.</h2>
      </div>
      <GetStarted />
      <div className="demo">
        <div className="demo-container">
          <video></video>
        </div>
      </div>
      <div className="testimonials">
        <h1>Many small businesses are already using FollowUp</h1>
        <h2>Since day one, FollowUp focuses purely on improving communication
          between small business owners and customers, providing them a channel
          to give and receive feedback and loyalty rewards. Thousands of smiles
          and rewards have already been shared using FollowUp.</h2>
      </div>
      <div className="call-to-action">
        <img alt="cta"></img>
        <h1>Experience the glory of FollowUp, for free.</h1>
        <GetStarted />
      </div>
    </main>
  )
}

export default FrontPage;
