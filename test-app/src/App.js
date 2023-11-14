import logo from './logo.svg';
import './App.css';
import { useEffect } from 'react';
function App() {

  useEffect(() => {
    fetch('https://tofsyutct5.execute-api.eu-west-3.amazonaws.com/prod/dynamoDB', {
      method: 'POST'
      })
      .then((response) => response.json())
      .then((data) => { 
        console.log(data.Attributes.counter);
      })
      .catch((err) => {
         console.log(err.message);
      });
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>ANISSSS</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
