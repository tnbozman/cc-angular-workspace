import { Manifest, RemoteConfig } from "@angular-architects/module-federation";


export type RemoteManifestItemModel = RemoteConfig & {
    exposedModule: string;
    ngModuleName: string;
    isGoldenLayout: boolean;
};

export type RemoteManifest = Manifest<RemoteManifestItemModel>;