import { TestBed } from '@angular/core/testing';

import { ModuleFederationService } from './module-federation.service';

describe('ModuleFederationService', () => {
  let service: ModuleFederationService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ModuleFederationService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
