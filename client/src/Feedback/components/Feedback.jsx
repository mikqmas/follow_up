import React from 'react';
import SingleFeedback from './SingleFeedback';
import '../styles/Feedback.css'

class Feedback extends React.PureComponent {
  state = {
    order: {}
  }
  componentWillMount() {
    // params will have order id
    // fetch more data from api
  }
  render() {
    return (
      <div className="feedback">
        <h1>Thank you for your feedback</h1>
        {this.state.order.employee && <SingleFeedback employee={this.state.order.employee} />}
        {
          this.state.order.items && this.state.order.items.map(SingleFeedback)
        }
      </div>
    )
  }
}

export default Feedback;
