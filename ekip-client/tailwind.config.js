/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: "#1D2639",
        secondary: "#465975",
        thirdy: "#7B8CA6",
        pink: "#E0E1DD",
        orange: "#e49b0f",
        light: "#f2f2f2",
      },
      boxShadow: {
        "shadow-right": "5px 0 10px 0px #1D2639",
        bottom: "0 4px 2px -2px #1D2639",
      },
    },
  },
  plugins: [],
};
