var path = require('path');
var webpack = require('webpack');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  entry: {
    index: [
      './source/javascripts/index.js',
      './source/stylesheets/main.scss'
    ],
  },

  resolve: {
    root: path.join(__dirname, 'source/javascripts'),
    modulesDirectories: [
      path.join(__dirname, "node_modules"),
      path.join(__dirname, "source/stylesheets")
    ],
    extensions: ['', '.js', '.scss']
  },

  output: {
    path: path.join(__dirname, '.tmp/dist'),
    filename: 'javascripts/[name].js'
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015']
        }
      },

      // Load SCSS
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract(
          "style",
          "css!sass?sourceMap"
        )
      },

      // Load plain-ol' vanilla CSS
      { test: /\.css$/, loader: "style!css" },

      {
        test: /\.(jpe?g|png|gif|svg)$/i,
        loaders: [
            'file?hash=sha512&digest=hex&name=[hash].[ext]',
            'image-webpack?bypassOnDebug&optimizationLevel=7&interlaced=false'
        ]
      }
    ]
  },

  plugins: [
    new ExtractTextPlugin("stylesheets/app.css"),
  ],

  sassLoader: {
    includePaths: [path.join(__dirname, "node_modules")]
  }

};
