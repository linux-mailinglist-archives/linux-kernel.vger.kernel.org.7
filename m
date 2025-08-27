Return-Path: <linux-kernel+bounces-788985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B7B38F46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2488C46479A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF83115AD;
	Wed, 27 Aug 2025 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="lLviqIgO"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B9301006
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756337330; cv=none; b=j1dLJaxF8IJ3A3vq/QDJqG0nG7+1dIntUEaPbNCylQE1QWrOrKcWZ6nPrOZWXnqgEJK3NwYSvwFiEU35McydFcYNVJAC0B2EvsGvdwK0Rxwxs/7HbJLRCLyxWjehtMZvjyA87tOq1P5UD4L67WXR4XeqAZSmTfgx8SYeQ/27jrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756337330; c=relaxed/simple;
	bh=+7Ma31QPJuiP41MxYJS91rDyqDomjD/mryM4vXlEuCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GEtiPXmcao9nYxrFhJjI9ilF6reSvhA8gPnqNiChcVy+/2umJn3Mgflo2iD6JC2HD+cO5ycw4EMsM37t6wWv3DcbKlg/QjYuenNmJWUYzoMaG9O1RyAXHy5k2cteYVs9OF1/sf9XDBc5tIwwigbyRyj83tCZfWQPWHbiVAIdu04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=lLviqIgO; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8CC772C03CC;
	Thu, 28 Aug 2025 11:28:38 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1756337318;
	bh=+7Ma31QPJuiP41MxYJS91rDyqDomjD/mryM4vXlEuCQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=lLviqIgOQ3lY7PbD6MOn2/VbOvR90fp0riV5Dn2uX8qFHIothCBCV4JNJLwOseucl
	 RMwg0wapvxZSzE3DOHdvp7F09zZJ8rwpv4vIlKDhh/mjW764Lg3yQDJxI8Zcx9x8a4
	 7ALSayV1pO84jR9h18s7qlLHt4jCHCit6IUXUndRg5KTMGhI6U9XTdatxHS0wV1xwm
	 WLQTGkVxVZ941hR1+IsjcmWQwRfY42GTtlf8X7EwkrJMiUcjV1WUxkfqRUJ3jU184L
	 4NNnBxF1Fc24X4TME84K2eIvjv7UQQ+wYwJAst6XVQ3hW5t+eEbLLrKk1p1u1Hb7I2
	 gLAOFnyYrCO2g==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68af94a60001>; Thu, 28 Aug 2025 11:28:38 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 28 Aug 2025 11:28:38 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Thu, 28 Aug 2025 11:28:38 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Guenter Roeck <linux@roeck-us.net>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] hwmon: (ina238) Add support for INA780
Thread-Topic: [PATCH v2 2/2] hwmon: (ina238) Add support for INA780
Thread-Index: AQHcCBFCT9dgOoAuzUOPUPjlGL2uJ7R1/1AAgAB8A4A=
Date: Wed, 27 Aug 2025 23:28:38 +0000
Message-ID: <d371f4c2-d328-49ca-a3f3-b23b1fee68ee@alliedtelesis.co.nz>
References: <20250808030510.552724-1-chris.packham@alliedtelesis.co.nz>
 <20250808030510.552724-3-chris.packham@alliedtelesis.co.nz>
 <4381440d-cd92-40df-bf4b-53ba629abc0c@roeck-us.net>
In-Reply-To: <4381440d-cd92-40df-bf4b-53ba629abc0c@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6DC519EDDC74143BF6F58E8466721F8@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Yo+sRJYX c=1 sm=1 tr=0 ts=68af94a6 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=RJhZdRoedsqvXEVZLXIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgR3VudGVyLA0KDQpPbiAyOC8wOC8yMDI1IDA0OjA0LCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBDaGlzLA0KPg0KPiBPbiBGcmksIEF1ZyAwOCwgMjAyNSBhdCAwMzowNToxMFBNICsxMjAwLCBD
aHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBUSSBJTkE3ODAgRGln
aXRhbCBQb3dlciBNb25pdG9yLiBUaGUgSU5BNzgwIHVzZXMNCj4+IEVaU2h1bnQodG0pIHRlY2hu
b2xvZ3ksIHdoaWNoIG1lYW5zIHRoZXJlIGFyZSBmaXhlZCBMU0IgY29udmVyc2lvbnMgZm9yDQo+
PiBhIG51bWJlciBvZiBmaWVsZHMgcmF0aGVyIHRoYW4gbmVlZGluZyB0byBiZSBjYWxpYnJhdGVk
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxs
aWVkdGVsZXNpcy5jby5uej4NCj4gUGxlYXNlIHNlbmQgbWUgYSByZWdpc3RlciBkdW1wIGZvciB0
aGUgY2hpcCBzbyBJIGNhbiBhZGQgdW5pdCB0ZXN0IGNvZGUNCj4gZm9yIGl0cyBzdXBwb3J0IGJ5
IHRoZSBkcml2ZXIuDQoNClN1cmUuIEkgdXNlZCB0aGUgZm9sbG93aW5nIHNjcmlwdCB0byBkdW1w
IHRoZSByZWdpc3RlcnMNCg0KY2F0IDw8RU9GIHwgd2hpbGUgcmVhZCBhZGRyIGxlbjsgZG8gcHJp
bnRmICIlMng6ICIgJGFkZHI7IGkyY2dldCAteSAtZiAxIA0KMHg0MCAkYWRkciBpICRsZW47IGRv
bmUNCjB4MCAyDQoweDEgMg0KMHg1IDINCjB4NiAyDQoweDcgMg0KMHg4IDMNCjB4OSA1DQoweGEg
NQ0KMHhiIDINCjB4YyAyDQoweGQgMg0KMHhlIDMNCjB4ZiAyDQoweDEwIDINCjB4MTEgMg0KMHgz
ZSAyDQpFT0YNCg0KT24gYW4gdW5jb25maWd1cmVkIElOQTc4MEEgd2l0aCBubyBsb2FkIGp1c3Qg
YWZ0ZXIgcmVzZXQNCg0KIMKgMDogMHgwMCAweDMwDQogwqAxOiAweGZiIDB4NjgNCiDCoDU6IDB4
MDAgMHgwMA0KIMKgNjogMHgwYiAweDAwDQogwqA3OiAweDAwIDB4MDANCiDCoDg6IDB4MDAgMHgw
MCAweDAwDQogwqA5OiAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDANCiDCoGE6IDB4ZmYgMHhmZiAw
eGZmIDB4ZmYgMHg1Yg0KIMKgYjogMHgwMCAweDAzDQogwqBjOiAweDdmIDB4ZmYNCiDCoGQ6IDB4
ODAgMHgwMA0KIMKgZTogMHg3ZiAweGZmIDB4ZmYNCiDCoGY6IDB4MDAgMHgwMA0KMTA6IDB4N2Yg
MHhmMA0KMTE6IDB4ZmYgMHhmZg0KM2U6IDB4NTQgMHg0OQ0KDQpPbiBhIElOQTc4MEEgd2l0aCBu
byBsb2FkDQoNCiDCoDA6IDB4MDAgMHgzMA0KIMKgMTogMHhmYiAweDZhDQogwqA1OiAweDAwIDB4
MDANCiDCoDY6IDB4MGIgMHgwMA0KIMKgNzogMHgwMCAweDAwDQogwqA4OiAweDAwIDB4MDAgMHgw
MA0KIMKgOTogMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwDQogwqBhOiAweGZmIDB4ZmYgMHhmZiAw
eGZmIDB4ZDgNCiDCoGI6IDB4MjAgMHgwMw0KIMKgYzogMHg3ZiAweGZmDQogwqBkOiAweDgwIDB4
MDANCiDCoGU6IDB4N2YgMHhmZiAweGZmDQogwqBmOiAweDAwIDB4MDANCjEwOiAweDdmIDB4ZjAN
CjExOiAweGZmIDB4ZmYNCjNlOiAweDU0IDB4NDkNCg0KY29ycmVzcG9uZGluZyBsbS1zZW5zb3Jz
IG91dHB1dA0KDQppbmE3ODAtaTJjLTEtNDANCkFkYXB0ZXI6IGkyYy0wLW11eCAoY2hhbl9pZCAw
KQ0KaW4wOsKgIMKgIMKgIMKgIMKgIMKgMC4wMCBWwqAgKG1pbiA9wqAgKzAuMDAgViwgbWF4ID0g
KzEwMi40MCBWKQ0KdGVtcDE6wqAgwqAgwqAgwqAgKzIyLjAgQ8KgIChoaWdoID0gKzI1NS45IEMp
DQpwb3dlcjE6wqAgwqAgwqAgwqAgMC4wMCBXwqAgKG1heCA9wqAgwqAyLjA2IGtXKQ0KZW5lcmd5
MTrCoCDCoCDCoCDCoDAuMDAgSg0KY3VycjE6wqAgwqAgwqAgwqAgwqAwLjAwIEHCoCAobWluID0g
LTc4LjY0IEEsIG1heCA9ICs3OC42NA0KDQpPbiBhIElOQTc4MEEgd2l0aCAxMFYsIDRBIGxvYWQN
Cg0KIMKgMDogMHgwMCAweDMwDQogwqAxOiAweGZiIDB4NmENCiDCoDU6IDB4MGQgMHg3NQ0KIMKg
NjogMHgwYiAweDIwDQogwqA3OiAweDA2IDB4NWYNCiDCoDg6IDB4MDEgMHg1NyAweDBhDQogwqA5
OiAweDAwIDB4MDAgMHgwMyAweDk0IDB4Y2QNCiDCoGE6IDB4MDAgMHgwMCAweDExIDB4NGIgMHhh
YQ0KIMKgYjogMHgyMCAweDAzDQogwqBjOiAweDdmIDB4ZmYNCiDCoGQ6IDB4ODAgMHgwMA0KIMKg
ZTogMHg3ZiAweGZmIDB4ZmYNCiDCoGY6IDB4MDAgMHgwMA0KMTA6IDB4N2YgMHhmMA0KMTE6IDB4
ZmYgMHhmZg0KM2U6IDB4NTQgMHg0OQ0KDQpjb3JyZXNwb25kaW5nIGxtLXNlbnNvcnMgb3V0cHV0
DQoNCmluYTc4MC1pMmMtMS00MA0KQWRhcHRlcjogaTJjLTAtbXV4IChjaGFuX2lkIDApDQppbjA6
wqAgwqAgwqAgwqAgwqAgMTAuNzcgVsKgIChtaW4gPcKgICswLjAwIFYsIG1heCA9ICsxMDIuNDAg
VikNCnRlbXAxOsKgIMKgIMKgIMKgICsyMi4yIEPCoCAoaGlnaCA9ICsyNTUuOSBDKQ0KcG93ZXIx
OsKgIMKgIMKgIMKgNDIuMDYgbVcgKG1heCA9wqAgwqAyLjA2IGtXKQ0KZW5lcmd5MTrCoCDCoCDC
oCDCoDIuODAgSg0KY3VycjE6wqAgwqAgwqAgwqAgwqAzLjkxIEHCoCAobWluID0gLTc4LjY0IEEs
IG1heCA9ICs3OC42NCBBKQ0KDQpBbmQgZm9yIGdvb2QgbWVhc3VyZSBhIHdvcmQtd2lzZSBkdW1w
IChzYW1lIGNvbmZpZyBhbmQgbG9hZCBhcyBhYm92ZSkNCg0KW3Jvb3RAbGludXhib3ggfl0jIGky
Y2R1bXAgLXkgLWYgMSAweDQwIHcNCiDCoCDCoCDCoDAsOMKgIDEsOcKgIDIsYcKgIDMsYsKgIDQs
Y8KgIDUsZMKgIDYsZcKgIDcsZg0KMDA6IDMwMDAgNmFmYiBmZmZmIGZmZmYgZmZmZiA3NjBkIDMw
MGIgNWEwNg0KMDg6IDU1MDEgMDAwMCAwMDAwIDAzMjAgZmY3ZiAwMDgwIGZmN2YgMDAwMA0KMTA6
IGYwN2YgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZg0KMTg6IGZmZmYgZmZmZiBm
ZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZg0KMjA6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZm
ZiBmZmZmIGZmZmYgZmZmZg0KMjg6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYg
ZmZmZg0KMzA6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiAwMDAwIGZmZmYgZmZmZg0KMzg6IGZm
ZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIDQ5NTQgNjIyNw0KNDA6IDMwMDAgNmFmYiBmZmZm
IGZmZmYgZmZmZiA3NjBkIDMwMGIgNWEwNg0KNDg6IDU1MDEgMDAwMCAwMDAwIDAzMjAgZmY3ZiAw
MDgwIGZmN2YgMDAwMA0KNTA6IGYwN2YgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZm
Zg0KNTg6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZg0KNjA6IGZmZmYg
ZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZg0KNjg6IGZmZmYgZmZmZiBmZmZmIGZm
ZmYgZmZmZiBmZmZmIGZmZmYgZmZmZg0KNzA6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiAwMDAw
IGZmZmYgZmZmZg0KNzg6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIDQ5NTQgNjIyNw0K
ODA6IDMwMDAgNmFmYiBmZmZmIGZmZmYgZmZmZiA3NjBkIDMwMGIgNWEwNg0KODg6IDU1MDEgMDAw
MCAwMDAwIDAzMjAgZmY3ZiAwMDgwIGZmN2YgMDAwMA0KOTA6IGYwN2YgZmZmZiBmZmZmIGZmZmYg
ZmZmZiBmZmZmIGZmZmYgZmZmZg0KOTg6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZm
ZmYgZmZmZg0KYTA6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZg0KYTg6
IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZg0KYjA6IGZmZmYgZmZmZiBm
ZmZmIGZmZmYgZmZmZiAwMDAwIGZmZmYgZmZmZg0KYjg6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZm
ZiBmZmZmIDQ5NTQgNjIyNw0KYzA6IDMwMDAgNmFmYiBmZmZmIGZmZmYgZmZmZiA3NjBkIDMwMGIg
NWEwNg0KYzg6IDU1MDEgMDAwMCAwMDAwIDAzMjAgZmY3ZiAwMDgwIGZmN2YgMDAwMA0KZDA6IGYw
N2YgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZg0KZDg6IGZmZmYgZmZmZiBmZmZm
IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZg0KZTA6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBm
ZmZmIGZmZmYgZmZmZg0KZTg6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZm
Zg0KZjA6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiAwMDAwIGZmZmYgZmZmZg0KZjg6IGZmZmYg
ZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIDQ5NTQgNjIyNw0K

