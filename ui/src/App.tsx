import { useEffect } from 'react'
import { isEnvBrowser } from '@/utils/misc'
import Header from './components/header'
import Playlist from './components/playlist'
function App() {
  useEffect(() => {
    if (!isEnvBrowser) return;
    document.body.style.backgroundImage = 'url(https://wallpaperaccess.com/full/707055.jpg)'
  }, [])
  return (
    <main className='max-w-7xl h-full mx-auto my-6 p-6 bg-zinc-700 text-white rounded-lg'>
      <Header />
      <Playlist />
    </main>
  )
}

export default App
