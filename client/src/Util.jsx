const Util = {
  handleErrors: (resp) => {
    if(!resp.ok) {
      throw Error(resp.statusText);
    }
    return resp;
  },
  isLoggedIn: () => (!!sessionStorage.getItem("session")),
  CLOVER_BASE: 'sandbox.dev.clover.com',
  APP_ID: 'TGN2F8DTRSYG2',
}

export default Util;
