cask 'font-titillium-web' do
  sha256 '2a96c82fbabd61b37640054b20d52483817d2c7661ce7e82faccdfb5b436f1bf'

  url "https://google-webfonts-helper.herokuapp.com/api/fonts/titillium-web?download=zip&subsets=latin&variants=regular"
  name 'Titillium Web'
  homepage 'https://google-webfonts-helper.herokuapp.com/fonts/titillium-web?subsets=latin'

  font 'titillium-web-v8-latin-regular.ttf'
end