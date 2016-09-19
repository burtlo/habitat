// Copyright (c) 2016 Chef Software Inc. and/or applicable contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

///<reference path="../typings/browser/index.d.ts" />
///<reference path='../node_modules/immutable/dist/immutable.d.ts'/>

// Include the nav control from the main website
require("./zepto-custom");
import "./nav";

import "reflect-metadata";
import "zone.js/dist/zone";

import { platformBrowserDynamic } from "@angular/platform-browser-dynamic";
import { enableProdMode } from "@angular/core";
import { AppModule } from "./app.module";
import config from "./config";

if (config["environment"] === "production") {
  enableProdMode();
}

platformBrowserDynamic().bootstrapModule(AppModule);