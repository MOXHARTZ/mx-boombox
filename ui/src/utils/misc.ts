export const isEnvBrowser = (): boolean => !(window as any).invokeNative;
export const noop = () => { };
export const ICON_SETTINGS = {
    size: 32,
    color: '#ffff',
}
export const formatNumber = (amount: string | number) => new Intl.NumberFormat().format(+amount);
export const defaultNumber = (value: string | number) => String(value).split(",").join("");
export const isEmpty = (value: any) => {
    if (value === undefined || value === null) return true;
    if (value == '') return true;
    if (typeof value === 'string' && value.trim() === '') return true;
    if (typeof value === 'object' && Object.keys(value).length === 0) return true;
    return false;
}