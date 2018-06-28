import React from 'react';
import Chartist from 'chartist';
import ListResults from './ListResults';
import '../styles/Dash.css';

class Dash extends React.PureComponent {
  componentDidMount() {
    var data = {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'Mai', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        series: [
        [5, 4, 3, 7, 5, 10, 3, 4, 8, 10, 6, 8],
        [3, 2, 9, 5, 4, 6, 4, 6, 7, 8, 7, 4]
      ]
    };

    var options = {
      seriesBarDistance: 15,
      height: 400
    };

    var responsiveOptions = [
      ['screen and (min-width: 641px) and (max-width: 1024px)', {
        seriesBarDistance: 10,
        axisX: {
          labelInterpolationFnc: function (value) {
            return value;
          }
        }
      }],
      ['screen and (max-width: 640px)', {
        seriesBarDistance: 5,
        axisX: {
          labelInterpolationFnc: function (value) {
            return value[0];
          }
        }
      }]
    ];

    new Chartist.Bar('.ct-chart', data, options, responsiveOptions);
  }

  render() {
    return (
      <div className="dash">
        <div className="left">
          <img className="followUpLogo" src="/static/img/icFollowUp.png" alt="logo"/>
        </div>
        <div className="content">
          <span>
            <input type="text" className="search" placeholder="Search customer name, order type..."/>
          </span>
          <div className="filter"></div>
          <div className="graph">
            <div className="ct-chart"></div>
          </div>
          <ListResults/>
        </div>
      </div>
    )
  }
}

export default Dash;
