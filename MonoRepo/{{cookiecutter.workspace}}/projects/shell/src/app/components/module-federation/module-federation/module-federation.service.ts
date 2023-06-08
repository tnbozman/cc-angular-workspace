import { Injectable } from '@angular/core';
import { getManifest, loadRemoteModule } from '@angular-architects/module-federation';
import { RemoteManifestItemModel, RemoteManifest } from './remote-manifest-item.model';

@Injectable({
  providedIn: 'root'
})
export class ModuleFederationService {
  remotes: RemoteManifestItemModel[] = [];

  constructor() {
    const manifest = getManifest<RemoteManifest>();
    this.remotes = Object.values(manifest);
   }

   getRemoteModules(): RemoteManifestItemModel[] {
     return this.remotes;
   }

   getGoldenLayoutRemoteModules(): RemoteManifestItemModel[] {
    return this.remotes.filter(item => item.isGoldenLayout === true);
  }

  async loadModule(item: RemoteManifestItemModel): Promise<any>{
    const module = await loadRemoteModule({
          type: 'module',
          remoteEntry: item.remoteEntry,
          exposedModule: item.exposedModule
      });

      return module[item.ngModuleName];
  }

}
