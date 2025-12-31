export type ContentDescriptor = [unknown, string];
export type Environment = Record<string, unknown>;

export declare function getEnvironment(dictionary: Environment, path: string): Environment | undefined;
export declare function getValue(dictionary: Environment, path: string): ContentDescriptor;
export declare function joinPath(basePath: string, ...paths: string[]): string;
