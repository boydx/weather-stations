module.exports = {
  content: [
    "./index.html",
    "./main.js",
  ],
  theme: {
    fontFamily: {
      'sans': ['"Merriweather Sans"', 'ui-sans-serif', 'system-ui'],
    },
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
