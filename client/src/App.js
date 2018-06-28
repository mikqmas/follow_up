import React, { Component } from 'react';
import './App.css';
import NavBar from './NavBar/components/NavBar';
import FrontPage from './Landing/components/FrontPage';
import Footer from './Footer/components/Footer';

class App extends Component {
  render() {
    return (
      <div className="App">
        <NavBar />
        <FrontPage />
        <Footer />
      </div>
    );
  }
}

export default App;
