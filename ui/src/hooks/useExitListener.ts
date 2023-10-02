import { useEffect, useRef } from 'react';
import { useAppSelector } from './../stores/index';

type FrameVisibleSetter = (bool: boolean) => void;

const LISTENED_KEYS = ['Escape'];

// Basic hook to listen for key presses in NUI in order to exit
export const useExitListener = (visibleSetter: FrameVisibleSetter, isMenu?: boolean) => {
  const { menu } = useAppSelector(state => state.Static);
  const setterRef = useRef<FrameVisibleSetter>(() => { });

  useEffect(() => {
    setterRef.current = visibleSetter;
  }, [visibleSetter]);

  useEffect(() => {
    const keyHandler = (e: KeyboardEvent) => {
      if (LISTENED_KEYS.includes(e.code)) {
        if (menu && !isMenu) return;
        setterRef.current(false);
      }
    };

    window.addEventListener('keyup', keyHandler);

    return () => window.removeEventListener('keyup', keyHandler);
  }, [menu]);
};
