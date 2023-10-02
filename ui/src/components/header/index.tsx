import { BiSkipPrevious, BiPause, BiPlay, BiSkipNext } from 'react-icons/bi'
import { FaVolumeDown, FaVolumeUp } from 'react-icons/fa'
import Stack from '@mui/material/Stack';
import Slider from '@mui/material/Slider';
import { useCallback, useState } from 'react';
import { styled, useTheme } from '@mui/material/styles';
import { Box } from '@mui/material';

const Header = () => {
    const theme = useTheme();
    const [volume, setVolume] = useState<number>(30);
    const volumeOnChange = useCallback((_: any, newValue: number | number[]) => {
        setVolume(newValue as number);
    }, []);
    const [position, setPosition] = useState<number>(32);
    const duration = 200; // seconds
    function formatDuration(value: number) {
        const minute = Math.floor(value / 60);
        const secondLeft = value - minute * 60;
        return `${minute}:${secondLeft < 10 ? `0${secondLeft}` : secondLeft}`;
    }
    return (
        <header className='grid grid-cols-3 w-full justify-between items-center gap-24'>
            <article className='flex flex-row gap-4'>
                <img src='https://picsum.photos/300/300' width={64} height={32} className='rounded-lg object-cover' alt='playlist' />
                <article className='flex flex-col'>
                    <section>
                        <h2>Song Name</h2>
                        <p className='text-gray-500'>Author Name</p>
                    </section>
                </article>
            </article>
            <article className='w-full flex flex-col'>
                <section className='w-full flex-shrink-0 flex-1 flex flex-row justify-between'>
                    {/* previous icon */}
                    <BiSkipPrevious size={42} />
                    <BiPause size={42} />
                    {/* <BiPlay size={32} /> */}
                    <BiSkipNext size={42} />
                </section>
                <Slider
                    aria-label="time-indicator"
                    size="small"
                    value={position}
                    min={0}
                    step={1}
                    max={duration}
                    onChange={(_, value) => setPosition(value as number)}
                    sx={{
                        color: theme.palette.mode === 'dark' ? '#fff' : 'rgba(0,0,0,0.87)',
                        height: 8,
                        '& .MuiSlider-thumb': {
                            width: 12,
                            height: 12,
                            transition: '0.3s cubic-bezier(.47,1.64,.41,.8)',
                            '&:before': {
                                boxShadow: '0 2px 12px 0 rgba(0,0,0,0.4)',
                            },
                            '&:hover, &.Mui-focusVisible': {
                                boxShadow: `0px 0px 0px 8px ${theme.palette.mode === 'dark'
                                    ? 'rgb(255 255 255 / 16%)'
                                    : 'rgb(0 0 0 / 16%)'
                                    }`,
                            },
                            '&.Mui-active': {
                                width: 16,
                                height: 16,
                            },
                        },
                        '& .MuiSlider-rail': {
                            opacity: 0.28,
                        },
                    }}
                />
                <Box
                    sx={{
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        mt: -2,
                    }}
                >
                    <p className='text-sm opacity-40 font-medium mt-2'>{formatDuration(position)}</p>
                    <p className='text-sm opacity-40 font-medium mt-2'>-{formatDuration(duration - position)}</p>
                </Box>
            </article>
            <article className='w-full m-auto'>
                <Stack spacing={2} direction="row" sx={{ mb: 1 }} alignItems="center">
                    <FaVolumeDown size={28} />
                    <Slider aria-label="Volume" value={volume} onChange={volumeOnChange} />
                    <FaVolumeUp size={28} />
                </Stack>
            </article>

        </header>
    )
}

export default Header