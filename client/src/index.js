import React from 'react';
import ReactDOM from 'react-dom';
import {BrowserRouter as Router, Route} from 'react-router-dom';
import {Switch} from 'react-router-dom';
import './index.css';

//components
import App from './App';
import Login from './Login/components/Login';
import Dash from './Dash/components/Dash';
import Email from './Email/components/Email';
import Feedback from './Feedback/components/Feedback';
import Clover from './Clover/components/Clover';
import NotFound from './NotFound';

// import registerServiceWorker from './registerServiceWorker';

const appRouter = (
  <Router>
    <Switch>
      <Route exact path="/" component={App}/>
      <Route exact path="/login" component={Login}/>
      <Route exact path="/dash" component={Dash}/>
      <Route exact path="/email" component={Email}/>
      <Route exact path="/feedback" component={Feedback}/>
      <Route exact path="/clover" component={Clover}/>
      <Route exact path="/test" component={Dash}/>
    </Switch>
  </Router>
)

ReactDOM.render(appRouter, document.getElementById('root'));
// registerServiceWorker();

// <Route component={ NotFound } />
