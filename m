Return-Path: <linux-kernel+bounces-660979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF74AC24D8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 16:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF737BAEEF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 14:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31999295526;
	Fri, 23 May 2025 14:19:45 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B01219FC;
	Fri, 23 May 2025 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009984; cv=none; b=HNp5lpIych/X2I3GID/7aeMKobjeDLwi+dJk5zRZwdwgAC2I6nSjxQ+3qaRYtyqC35R23BgzYS8S48VpEAM7Cs5eGE+NjU3vB2a6UtUJFlQWgThiQj9skG1ZWmFuU05eaQFwCR9XrfRteKqT/G/p+tjRN9oue2tsNOGo9bMxAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009984; c=relaxed/simple;
	bh=PtnaVW1Gl2iS4KmDLtNA3/Vu7A34huTPLYGs5P+2rY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p1jxWRQC1JUsWhGjC5Gl30WWG3iAeWv368EDJ1YddVNs59i+aqILruGPMCHb082f6jS1CFd9igh3U4rwwxlokcZI80/1QdYj4/Izy4WQSctN1j563TDWjs6lCI+rSeq0dHtcBgmL5tBHAnoEI9685GgXJAatg8rQZ/k7nmKgUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 16:19:38 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Fri, 23 May 2025 16:19:38 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Frank Li <Frank.li@nxp.com>
CC: =?utf-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Thomas Richard
	<thomas.richard@bootlin.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "stable@kernel.org"
	<stable@kernel.org>
Subject: Re: [PATCH 1/4] crypto: caam - Prevent crash on suspend with iMX8QM /
 iMX8ULP
Thread-Topic: [PATCH 1/4] crypto: caam - Prevent crash on suspend with iMX8QM
 / iMX8ULP
Thread-Index: AQHby+Uubq4/T0/2xEa3pJeQa3AymLPgGseAgAAHVgA=
Date: Fri, 23 May 2025 14:19:38 +0000
Message-ID: <b62d6620-4c31-41e4-b510-130f0af66c79@actia.se>
References: <20250523131814.1047662-1-john.ernberg@actia.se>
 <20250523131814.1047662-2-john.ernberg@actia.se>
 <aDB909HDzfUaA3hv@lizhi-Precision-Tower-5810>
In-Reply-To: <aDB909HDzfUaA3hv@lizhi-Precision-Tower-5810>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2956B14453607160
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B1A1B4F0E8E8D4B9F309BC7B8A62D68@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgRnJhbmssDQoNCk9uIDUvMjMvMjUgMzo1MyBQTSwgRnJhbmsgTGkgd3JvdGU6DQo+IE9uIEZy
aSwgTWF5IDIzLCAyMDI1IGF0IDAxOjE4OjMyUE0gKzAwMDAsIEpvaG4gRXJuYmVyZyB3cm90ZToN
Cj4+IFNpbmNlIHRoZSBDQUFNIG9uIHRoZXNlIFNvQ3MgaXMgbWFuYWdlZCBieSBhbm90aGVyIEFS
TSBjb3JlLCBjYWxsZWQgdGhlDQo+PiBTRUNPIChTZWN1cml0eSBDb250cm9sbGVyKSBvbiBpTVg4
UU0gYW5kIFNlY3VyZSBFbmNsYXZlIG9uIGlNWDhVTFAsIHdoaWNoDQo+PiBhbHNvIHJlc2VydmVz
IGFjY2VzcyB0byByZWdpc3RlciBwYWdlIDAgc3VzcGVuZCBvcGVyYXRpb25zIGNhbm5vdCB0b3Vj
aA0KPj4gdGhpcyBwYWdlLg0KPj4NCj4+IEludHJvZHVjZSBhIHZhcmlhYmxlIHRvIHRyYWNrIHRo
aXMgc2l0dWF0aW9uLiBTaW5jZSB0aGlzIGlzIHN5bm9ueW1vdXMNCj4+IHdpdGggdGhlIG9wdGVl
IGNhc2UgaW4gc3VzcGVuZC9yZXN1bWUgdGhlIG9wdGVlIGNoZWNrIGlzIHJlcGxhY2VkIHdpdGgN
Cj4+IHRoaXMgbmV3IGNoZWNrLg0KPj4NCj4+IEZpeGVzIHRoZSBmb2xsb3dpbmcgc3BsYXQgYXQg
c3VzcGVuZDoNCj4+DQo+PiAgICAgIEludGVybmFsIGVycm9yOiBzeW5jaHJvbm91cyBleHRlcm5h
bCBhYm9ydDogMDAwMDAwMDA5NjAwMDAxMCBbIzFdIFNNUA0KPj4gICAgICBIYXJkd2FyZSBuYW1l
OiBGcmVlc2NhbGUgaS5NWDhRWFAgQUNVNkMgKERUKQ0KPj4gICAgICBwc3RhdGU6IDYwNDAwMDA1
IChuWkN2IGRhaWYgK1BBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyBCVFlQRT0tLSkNCj4+ICAgICAg
cGMgOiByZWFkbCsweDAvMHgxOA0KPj4gICAgICBsciA6IHJkX3JlZzMyKzB4MTgvMHgzYw0KPj4g
ICAgICBzcCA6IGZmZmZmZmMwODE5MmJhMjANCj4+ICAgICAgeDI5OiBmZmZmZmZjMDgxOTJiYTIw
IHgyODogZmZmZmZmODAyNTE5MDAwMCB4Mjc6IDAwMDAwMDAwMDAwMDAwMDANCj4+ICAgICAgeDI2
OiBmZmZmZmZjMDgwOGFlODA4IHgyNTogZmZmZmZmYzA4MDkyMjMzOCB4MjQ6IGZmZmZmZjgwMjBl
ODkwOTANCj4+ICAgICAgeDIzOiAwMDAwMDAwMDAwMDAwMDAwIHgyMjogZmZmZmZmYzA4MDkyMjAw
MCB4MjE6IGZmZmZmZjgwMjBlODkwMTANCj4+ICAgICAgeDIwOiBmZmZmZmZjMDgwMzg3ZWY4IHgx
OTogZmZmZmZmODAyMGU4OTAxMCB4MTg6IDAwMDAwMDAwNWQ4MDAwZDUNCj4+ICAgICAgeDE3OiAw
MDAwMDAwMDMwZjM1OTYzIHgxNjogMDAwMDAwMDA4Zjc4NWYzZiB4MTU6IDAwMDAwMDAwM2I4ZWY1
N2MNCj4+ICAgICAgeDE0OiAwMDAwMDAwMGM0MThhZWY4IHgxMzogMDAwMDAwMDBmNWZlYTUyNiB4
MTI6IDAwMDAwMDAwMDAwMDAwMDENCj4+ICAgICAgeDExOiAwMDAwMDAwMDAwMDAwMDAyIHgxMDog
MDAwMDAwMDAwMDAwMDAwMSB4OSA6IDAwMDAwMDAwMDAwMDAwMDANCj4+ICAgICAgeDggOiBmZmZm
ZmY4MDI1MTkwODcwIHg3IDogZmZmZmZmODAyMTcyNjg4MCB4NiA6IDAwMDAwMDAwMDAwMDAwMDIN
Cj4+ICAgICAgeDUgOiBmZmZmZmY4MDIxNzI2OGYwIHg0IDogZmZmZmZmODAyMTcyNjg4MCB4MyA6
IGZmZmZmZmMwODEyMDAwMDANCj4+ICAgICAgeDIgOiAwMDAwMDAwMDAwMDAwMDAxIHgxIDogZmZm
ZmZmODAyMGU4OTAxMCB4MCA6IGZmZmZmZmMwODEyMDAwMDQNCj4+ICAgICAgQ2FsbCB0cmFjZToN
Cj4+ICAgICAgIHJlYWRsKzB4MC8weDE4DQo+PiAgICAgICBjYWFtX2N0cmxfc3VzcGVuZCsweDMw
LzB4ZGMNCj4+ICAgICAgIGRwbV9ydW5fY2FsbGJhY2suY29uc3Rwcm9wLjArMHgyNC8weDVjDQo+
PiAgICAgICBkZXZpY2Vfc3VzcGVuZCsweDE3MC8weDJlOA0KPj4gICAgICAgZHBtX3N1c3BlbmQr
MHhhMC8weDEwNA0KPj4gICAgICAgZHBtX3N1c3BlbmRfc3RhcnQrMHg0OC8weDUwDQo+PiAgICAg
ICBzdXNwZW5kX2RldmljZXNfYW5kX2VudGVyKzB4N2MvMHg0NWMNCj4+ICAgICAgIHBtX3N1c3Bl
bmQrMHgxNDgvMHgxNjANCj4+ICAgICAgIHN0YXRlX3N0b3JlKzB4YjQvMHhmOA0KPj4gICAgICAg
a29ial9hdHRyX3N0b3JlKzB4MTQvMHgyNA0KPj4gICAgICAgc3lzZnNfa2Zfd3JpdGUrMHgzOC8w
eDQ4DQo+PiAgICAgICBrZXJuZnNfZm9wX3dyaXRlX2l0ZXIrMHhiNC8weDE3OA0KPj4gICAgICAg
dmZzX3dyaXRlKzB4MTE4LzB4MTc4DQo+PiAgICAgICBrc3lzX3dyaXRlKzB4NmMvMHhkMA0KPj4g
ICAgICAgX19hcm02NF9zeXNfd3JpdGUrMHgxNC8weDFjDQo+PiAgICAgICBpbnZva2Vfc3lzY2Fs
bC5jb25zdHByb3AuMCsweDY0LzB4YjANCj4+ICAgICAgIGRvX2VsMF9zdmMrMHg5MC8weGIwDQo+
PiAgICAgICBlbDBfc3ZjKzB4MTgvMHg0NA0KPj4gICAgICAgZWwwdF82NF9zeW5jX2hhbmRsZXIr
MHg4OC8weDEyNA0KPj4gICAgICAgZWwwdF82NF9zeW5jKzB4MTUwLzB4MTU0DQo+PiAgICAgIENv
ZGU6IDg4ZGZmYzIxIDg4ZGZmYzIxIDVhYzAwODAwIGQ2NWYwM2MwIChiOTQwMDAwMCkNCj4+DQo+
PiBGaXhlczogZDI4MzU3MDFkOTNjICgiY3J5cHRvOiBjYWFtIC0gaS5NWDhVTFAgZG9ub3QgaGF2
ZSBDQUFNIHBhZ2UwIGFjY2VzcyIpDQo+PiBGaXhlczogNjFiYjhkYjZmNjgyICgiY3J5cHRvOiBj
YWFtIC0gQWRkIHN1cHBvcnQgZm9yIGkuTVg4UU0iKQ0KPj4gQ2M6IHN0YWJsZUBrZXJuZWwub3Jn
ICMgdjYuMTArDQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2huIEVybmJlcmcgPGpvaG4uZXJuYmVyZ0Bh
Y3RpYS5zZT4NCj4+DQo+PiAtLS0NCj4+DQo+PiBJIG5vdGljZWQgdGhpcyB3aGVuIGVuYWJsaW5n
IHRoZSBpTVg4UVhQIHN1cHBvcnQgKG5leHQgcGF0Y2gpLCBoZW5jZSB0aGUNCj4+IGlNWDhRWFAg
YmFja3RyYWNlLCBidXQgdGhlIGlNWDhRTSBDQUFNIGludGVncmF0aW9uIHdvcmtzIGV4YWN0bHkg
dGhlIHNhbWUNCj4+IGFuZCBhY2NvcmRpbmcgdG8gdGhlIE5YUCB0cmVlIFsxXSB0aGUgaU1YOFVM
UCBzdWZmZXJzIHRoZSBzYW1lIGlzc3VlLg0KPj4NCj4+IFsxXTogaHR0cHM6Ly9naXRodWIuY29t
L254cC1pbXgvbGludXgtaW14L2NvbW1pdC82NTM3MTJmZmU1MmRkNTlmNDA3YWYxYjc4MWNlMzE4
ZjNkOWUxN2JiDQo+PiAtLS0NCj4+ICAgZHJpdmVycy9jcnlwdG8vY2FhbS9jdHJsLmMgICB8IDUg
KysrLS0NCj4+ICAgZHJpdmVycy9jcnlwdG8vY2FhbS9pbnRlcm4uaCB8IDEgKw0KPj4gICAyIGZp
bGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vY2FhbS9jdHJsLmMgYi9kcml2ZXJzL2NyeXB0by9jYWFt
L2N0cmwuYw0KPj4gaW5kZXggMzhmZjkzMTA1OWI0Li43NjZjNDQ3YzljZmIgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2NyeXB0by9jYWFtL2N0cmwuYw0KPj4gKysrIGIvZHJpdmVycy9jcnlwdG8v
Y2FhbS9jdHJsLmMNCj4+IEBAIC04MzEsNyArODMxLDcgQEAgc3RhdGljIGludCBjYWFtX2N0cmxf
c3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+PiAgIHsNCj4+ICAgICAgICBjb25zdCBzdHJ1
Y3QgY2FhbV9kcnZfcHJpdmF0ZSAqY3RybHByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4+
DQo+PiAtICAgICBpZiAoY3RybHByaXYtPmNhYW1fb2ZmX2R1cmluZ19wbSAmJiAhY3RybHByaXYt
Pm9wdGVlX2VuKQ0KPj4gKyAgICAgaWYgKGN0cmxwcml2LT5jYWFtX29mZl9kdXJpbmdfcG0gJiYg
IWN0cmxwcml2LT5ub19wYWdlMCkNCj4+ICAgICAgICAgICAgICAgIGNhYW1fc3RhdGVfc2F2ZShk
ZXYpOw0KPj4NCj4+ICAgICAgICByZXR1cm4gMDsNCj4+IEBAIC04NDIsNyArODQyLDcgQEAgc3Rh
dGljIGludCBjYWFtX2N0cmxfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+ICAgICAgICBz
dHJ1Y3QgY2FhbV9kcnZfcHJpdmF0ZSAqY3RybHByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsN
Cj4+ICAgICAgICBpbnQgcmV0ID0gMDsNCj4+DQo+PiAtICAgICBpZiAoY3RybHByaXYtPmNhYW1f
b2ZmX2R1cmluZ19wbSAmJiAhY3RybHByaXYtPm9wdGVlX2VuKSB7DQo+PiArICAgICBpZiAoY3Ry
bHByaXYtPmNhYW1fb2ZmX2R1cmluZ19wbSAmJiAhY3RybHByaXYtPm5vX3BhZ2UwKSB7DQo+PiAg
ICAgICAgICAgICAgICBjYWFtX3N0YXRlX3Jlc3RvcmUoZGV2KTsNCj4+DQo+PiAgICAgICAgICAg
ICAgICAvKiBIVyBhbmQgcm5nIHdpbGwgYmUgcmVzZXQgc28gZGVpbnN0YW50aWF0aW9uIGNhbiBi
ZSByZW1vdmVkICovDQo+PiBAQCAtOTA4LDYgKzkwOCw3IEBAIHN0YXRpYyBpbnQgY2FhbV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4NCj4+ICAgICAgICAgICAgICAgIGlt
eF9zb2NfZGF0YSA9IGlteF9zb2NfbWF0Y2gtPmRhdGE7DQo+PiAgICAgICAgICAgICAgICByZWdf
YWNjZXNzID0gcmVnX2FjY2VzcyAmJiBpbXhfc29jX2RhdGEtPnBhZ2UwX2FjY2VzczsNCj4+ICsg
ICAgICAgICAgICAgY3RybHByaXYtPm5vX3BhZ2UwID0gIXJlZ19hY2Nlc3M7DQo+IA0KPiBJZiB5
b3Ugd2FudCB0byB1c2Ugbm9fcGFnZTAgdG8gY29udHJvbCBpZiBjYWxsIGNhYW1fc3RhdGVfc2F2
ZSgpLCB5b3UnZA0KPiBiZXR0ZXIgc2V0IGN0cmxwcml2LT5ub19wYWdlMCBhbHNvIGFmdGVyIGN0
cmxwcml2LT5vcHRlZV9lbiA9ICEhbnA7DQo+IA0KPiBGcmFuaw0KDQpJJ20gbm90IHN1cmUgSSB1
bmRlcnN0YW5kLCBJIGNhbm5vdCBzZWUgYSBjb2RlIHBhdGggd2hlcmUgbm9fcGFnZTAgd2lsbCAN
CmJlICh1bilzZXQgaW5jb3JyZWN0bHkuDQoNCm9wdGVlIGRpc2FibGVzIHRoZSBwYWdlMCBhY2Nl
c3MsIHNvIHJlZ19hY2Nlc3MgaXMgYWxyZWFkeSB0aGUgaW52ZXJzZSBvZiANCm9wdGVlX2VuLiBy
ZWdfYWNjZXNzID09IGZhbHNlIHdoZW4gb3B0ZWVfZW4gPT0gdHJ1ZS4NCg0KVGh1cywgaWYgb3B0
ZWUgaXMgbG9hZGVkIG9uIGEgU29DIHRoYXQgbm9ybWFsbHkgaGFzIHBhZ2UwX2FjY2VzcyB0aGUg
DQpgcmVnX2FjY2VzcyA9IHJlZ19hY2Nlc3MgJiYgaW14X3NvY19kYXRhLT5wYWdlMF9hY2Nlc3M7
YCBzdGF0ZW1lbnQgb24gDQp0aGUgbGluZSBhYm92ZSBzZXR0aW5nIG5vX3BhZ2UwIGFscmVhZHkg
dGFrZXMgY2FyZSBvZiBpdCwgc286DQpyZWdfYWNjZXNzID0gZmFsc2UgJiYgdHJ1ZSAtPiBmYWxz
ZS4NCg0KU2ltaWxhcmx5IGlmIGJvdGggcmVnX2FjY2VzcyA9PSBmYWxzZSBhbmQgcGFnZTBfYWNj
ZXNzID09IGZhbHNlLCANCnJlZ19hY2Nlc3Mgd2lsbCBzdGlsbCBiZSBmYWxzZS4NCg0KVGhhbmtz
ISAvLyBKb2huIEVybmJlcmc=

