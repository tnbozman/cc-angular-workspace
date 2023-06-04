import { Directive, InjectionToken } from '@angular/core';
import {
  ComponentContainer
} from "golden-layout";

@Directive({
  selector: '[libGoldenLayoutBaseComponent]'
})
export class BaseComponentDirective {
  constructor(public rootHtmlElement: HTMLElement) {

  }

  public setPositionAndSize(left: number, top: number, width: number, height: number) {
    this.rootHtmlElement.style.left = this.numberToPixels(left);
    this.rootHtmlElement.style.top = this.numberToPixels(top);
    this.rootHtmlElement.style.width = this.numberToPixels(width);
    this.rootHtmlElement.style.height = this.numberToPixels(height);
} 

public setVisibility(visible: boolean) {
    if (visible) {
        this.rootHtmlElement.style.display = '';
    } else {
        this.rootHtmlElement.style.display = 'none';
    }
}

public setZIndex(value: string) {
    this.rootHtmlElement.style.zIndex = value;
}

protected numberToPixels(value: number): string {
    return value.toString(10) + 'px';
}
}

export namespace BaseComponentDirective {
const GoldenLayoutContainerTokenName = 'GoldenLayoutContainer'; 
export const GoldenLayoutContainerInjectionToken = new InjectionToken<ComponentContainer>(GoldenLayoutContainerTokenName);
}
