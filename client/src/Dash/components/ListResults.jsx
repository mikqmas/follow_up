import React from 'react';
import Result from './Result';
import Util from '../../Util';
import '../styles/ListResults.css'

class ListResults extends React.PureComponent {
  state = {
    data: []
  }

  componentWillMount() {
    fetch('https://jsonplaceholder.typicode.com/posts')
    .then(Util.handleErrors)
    .then(res=>res.json())
    .then(json=>this.setState({data: json}))
    .catch(error => console.log(error));
  }

  render() {
    return (
      <div className="list-results">
        {
          this.state.data.map(data=><Result key={data.id} data={data}/>)
        }
      </div>
    )
  }
}

export default ListResults;
