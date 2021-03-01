global.vdom = {};

function buildvdom() {
  vdom = {
    type: 'div',
    style: {
      flex: 1,
      backgroundColor: 'white',
    },
  };
}

function getvdom() {
  return JSON.stringify(vdom);
}

function addvdom() {
  let children = [
    {
      type: 'img',
      source: 'assets/flutter.png',
      style: {
        width: 100,
        height: 100,
      },
    },
    {
      type: 'p',
      style: {
        width: 100,
        height: 100,
      },
    },
  ];
  Object.assign(vdom, children);
}

function removevdomChildren() {
  vdom = {
    type: 'div',
    style: {
      flex: 1,
      backgroundColor: 'white',
    },
  };
}
