Return-Path: <linux-kernel+bounces-635926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39408AAC3C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 14:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AF87B0B5E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358BC27FD40;
	Tue,  6 May 2025 12:23:08 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FD27FB2A
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534187; cv=none; b=PRYVZqk1BEUBfq8a5Up4Hpsgy0S/HLxCyZfhQ8ndnuwDTZFT/vwE21/j31IvYjHuHuABGlso2OkP5rCF31aPuLtWb/GxpIwzoW1kiTLpCauT2tpyI9kiqaRqIA0PhKZyBcPlUw59CFeKxTRMxCuSZhW4IQQ1AMLQADAfoPUqOTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534187; c=relaxed/simple;
	bh=+AsV3FfvFyjm+nJS6lLXkvZPdGmM/MfaPxj0wojFrCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EhYs5ZYHf0vZpRoiiTsWk2koO7OgUQLb9JOkPXLt+EaEyVIKaQGAB4dpaiHNaYU4AaoUAQDukp6CtyweYXRFa4zWW6Q+CDkFESatw37tFM01iWfeyTLqOw4MjNF4EO9QZfI+f17JoGeTrRkGHcGVrxepb2hmDxwBwn7ZMf8l9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 14:22:55 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Tue, 6 May 2025 14:22:55 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Stefano Stabellini <sstabellini@kernel.org>
CC: Juergen Gross <jgross@suse.com>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] xen: swiotlb: Implement map_resource callback
Thread-Topic: [PATCH 2/2] xen: swiotlb: Implement map_resource callback
Thread-Index: AQHbu1cR+sKkXAZoXEOAUfrcrER157O/dMAAgAX2O4A=
Date: Tue, 6 May 2025 12:22:55 +0000
Message-ID: <75266eb7-66a4-4477-ae8a-cbd1ebbee8db@actia.se>
References: <20250502114043.1968976-1-john.ernberg@actia.se>
 <20250502114043.1968976-3-john.ernberg@actia.se>
 <alpine.DEB.2.22.394.2505021007460.3879245@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2505021007460.3879245@ubuntu-linux-20-04-desktop>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2955B14453667060
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E994E23DDFC0E4EB8666504990A79B4@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU3RlZmFubywNCg0KT24gNS8yLzI1IDc6MjAgUE0sIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90
ZToNCj4gK0NocmlzdG9waA0KPiANCj4gT24gRnJpLCAyIE1heSAyMDI1LCBKb2huIEVybmJlcmcg
d3JvdGU6DQo+PiBOZWVkZWQgYnkgdGhlIGVETUEgdjMgRE1BIGVuZ2luZSBmb3VuZCBpbiBpb21t
dS1sZXNzIFNvQ3Mgc3VjaCBhcyBpTVg4UVhQDQo+PiB0byBiZSBhYmxlIHRvIHBlcmZvcm0gRE1B
IG9wZXJhdGlvbnMgYXMgYSBYZW4gSGFyZHdhcmUgRG9tYWluLCB3aGljaCBuZWVkcw0KPj4gdG8g
YmUgYWJsZSB0byBkbyBETUEgaW4gTU1JTyBzcGFjZS4NCg0KU2VsZi1ub3RlOiBUaGUgYWJvdmUg
cGFydCBvZiB0aGUgY29tbWl0IG1lc3NhZ2UgaXMgYSBkaXNhc3RlciBhbmQgc2hvdWxkIA0KcmVh
ZCBzb21ldGhpbmcgbGlrZS4NCg0KTmVlZGVkIGJ5IFNvQ3Mgd2l0aG91dCBhbiBpb21tdSAoc3Vj
aCBhcyB0aGUgaU1YOFFYUCBhbmQgaXQncyBlRE1BIHYzIA0KZW5naW5lKSB0aGF0IG5lZWQgdG8g
YmUgYWJsZSB0byBwZXJmb3JtIERNQSBvcGVyYXRpb25zIGluIE1NSU8gc3BhY2UuDQoNCj4+DQo+
PiBUaGUgY2FsbGJhY2sgaW1wbGVtZW50YXRpb24gaXMgYmFzaWNhbGx5IHRoZSBzYW1lIGFzIHRo
ZSBvbmUgZm9yIGRpcmVjdA0KPj4gbWFwcGluZyBvZiByZXNvdXJjZXMsIGV4Y2VwdCB0aGlzIGFs
c28gdGFrZXMgaW50byBhY2NvdW50IFhlbiBwYWdlDQo+PiBtYXBwaW5ncy4NCj4+DQo+PiBUaGVy
ZSBpcyBub3RoaW5nIHRvIGRvIGZvciB1bm1hcCwganVzdCBsaWtlIHdpdGggZGlyZWN0LCBzbyB0
aGUgdW5tYXANCj4+IGNhbGxiYWNrIGlzIG5vdCBuZWVkZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogSm9obiBFcm5iZXJnIDxqb2huLmVybmJlcmdAYWN0aWEuc2U+DQo+Pg0KPj4gLS0tDQo+Pg0K
Pj4gSSBvcmlnaW5hbGx5IGV4cG9ydGVkIGRtYV9kaXJlY3RfbWFwX3Jlc291cmNlKCkgYW5kIHVz
ZWQgdGhhdCB3aGljaA0KPj4gYXBwZWFyZWQgdG8gd29yaywgYnV0IGl0IGZlbHQgbGlrZSBub3Qg
Y2hlY2tpbmcgWGVuIHBhZ2UgbWFwcGluZ3Mgd2Fzbid0DQo+PiBmdWxseSBjb3JyZWN0IGFuZCBJ
IHdlbnQgd2l0aCB0aGlzLiBCdXQgaWYgZG1hX2RpcmVjdF9tYXBfcmVzb3VyY2UoKSBpcw0KPj4g
dGhlIGNvcnJlY3QgYXBwcm9hY2ggaGVyZSB0aGVuIEkgY2FuIHN1Ym1pdCB0aGF0IGlzbnRlYWQu
DQo+PiAtLS0NCj4+ICAgZHJpdmVycy94ZW4vc3dpb3RsYi14ZW4uYyB8IDE1ICsrKysrKysrKysr
KysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3hlbi9zd2lvdGxiLXhlbi5jIGIvZHJpdmVycy94ZW4vc3dpb3RsYi14
ZW4uYw0KPj4gaW5kZXggZWY1NmEyNTAwZWQ2Li4wZjAyZmRkOTEyOGQgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL3hlbi9zd2lvdGxiLXhlbi5jDQo+PiArKysgYi9kcml2ZXJzL3hlbi9zd2lvdGxi
LXhlbi5jDQo+PiBAQCAtMjg1LDYgKzI4NSwyMCBAQCBzdGF0aWMgdm9pZCB4ZW5fc3dpb3RsYl91
bm1hcF9wYWdlKHN0cnVjdCBkZXZpY2UgKmh3ZGV2LCBkbWFfYWRkcl90IGRldl9hZGRyLA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXR0cnMsIHBvb2wpOw0K
Pj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBkbWFfYWRkcl90IHhlbl9zd2lvdGxiX21hcF9yZXNvdXJj
ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHBoeXNfYWRkcl90IHBoeXMsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBzaXplLCBlbnVtIGRtYV9kYXRhX2Rp
cmVjdGlvbiBkaXIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVuc2lnbmVkIGxvbmcgYXR0cnMpDQo+PiArew0KPj4gKyAgICAgZG1hX2FkZHJfdCBkZXZfYWRk
ciA9IHhlbl9waHlzX3RvX2RtYShkZXYsIHBoeXMpOw0KPiANCj4gWWVzLCB3ZSBuZWVkIHRoZSB4
ZW5fcGh5c190b19kbWEgY2FsbCBoZXJlLiBUaGlzIGlzIG9uZSBvZiB0aGUgcmVhc29ucyBJDQo+
IGRvbid0IHRoaW5rIHdlIGNhbiB1c2UgZG1hX2RpcmVjdF9tYXBfcmVzb3VyY2UoKSB0byBpbXBs
ZW1lbnQNCj4gbWFwX3Jlc291cmNlDQo+IA0KPiANCj4+ICsgICAgIEJVR19PTihkaXIgPT0gRE1B
X05PTkUpOw0KPj4gKw0KPj4gKyAgICAgaWYgKCFkbWFfY2FwYWJsZShkZXYsIGRldl9hZGRyLCBz
aXplLCBmYWxzZSkpDQo+PiArICAgICAgICAgICAgIHJldHVybiBETUFfTUFQUElOR19FUlJPUjsN
Cj4gDQo+IEJ1dCBoZXJlIHlvdSBhbHNvIG5lZWQgdG8gY2hlY2sgdGhhdCBwaHlzK3NpemUgZG9l
c24ndCBjcm9zcyBhIHBhZ2UNCj4gYm91bmRhcnkuIFlvdSBuZWVkIHRvIGNhbGwgcmFuZ2Vfc3Ry
YWRkbGVzX3BhZ2VfYm91bmRhcnksIGxpa2Ugd2UgZG8gYXQNCj4gdGhlIGJlZ2lubmluZyBvZiB4
ZW5fc3dpb3RsYl9tYXBfcGFnZS4NCj4gDQo+IElmIGl0IGlzIHBvc3NpYmxlIHRvIGNyb3NzIGEg
cGFnZSBib3VuZGFyeSwgdGhlbiB3ZSBuZWVkIHRvIGJhc2ljYWxseSB0bw0KPiBkbyB0aGUgc2Ft
ZSB0aGluZyBoZXJlIGFzIHdlIGRvIGluIHhlbl9zd2lvdGxiX21hcF9wYWdlIHdoZXJlIHdlIGNo
ZWNrDQo+IGZvcjoNCj4gDQo+ICAgICAgICAgIGlmIChkbWFfY2FwYWJsZShkZXYsIGRldl9hZGRy
LCBzaXplLCB0cnVlKSAmJg0KPiAgICAgICAgICAgICAgIXJhbmdlX3N0cmFkZGxlc19wYWdlX2Jv
dW5kYXJ5KHBoeXMsIHNpemUpICYmDQo+ICAgICAgICAgICAgICAgICAgIXhlbl9hcmNoX25lZWRf
c3dpb3RsYihkZXYsIHBoeXMsIGRldl9hZGRyKSAmJg0KPiAgICAgICAgICAgICAgICAgICFpc19z
d2lvdGxiX2ZvcmNlX2JvdW5jZShkZXYpKQ0KPiAgICAgICAgICAgICAgICAgIGdvdG8gZG9uZTsN
Cj4gDQo+IGlmIGFsbCBpcyB3ZWxsLCB3ZSBnbyB3aXRoIHRoZSBuYXRpdmUgcGF0aCwgb3RoZXJ3
aXNlIHdlIGJvdW5jZSBvbg0KPiBzd2lvdGxiLXhlbi4NCj4gDQoNCkknbGwgcHJlZmFjZSB0aGlz
IHdpdGggdGhhdCBpdCdzIG15IGZpcnN0IGRlZXAgZGl2ZSBpbiBETUEsIHNvIHRoZSANCmZvbGxv
d2luZyBtYXkgZW50aXJlbHkgYmUgbWUgYmVpbmcgc3R1cGlkOg0KDQpJJ20gbm90IHN1cmUgYSBz
dHJhZGRsZXMgcGFnZSBib3VuZGFyeSBwYXRoIG1ha2VzIHNlbnNlLg0KDQpUaGlzIG1hcHBpbmcg
aXMgbm90IGZvciBhIFJBTSBiYWNrZWQgYWRkcmVzcy4gSW4gdGhlIGVETUEgY2FzZSBmb3IgdGhl
IA0KaU1YOFFYUCB0aGUgYHBoeXNgIGNvbWluZyBpbiBoZXJlIGlzIHRoZSBhZGRyZXNzIG9mIGEg
cmVnaXN0ZXIuIEkgY2Fubm90IA0Kc2VlIGhvdyBhIHN3aW90bGIgYm91bmNlIHdvdWxkIGZpeCBh
bnl0aGluZyBpZiB5b3UgZW5kIHVwIHN0cmFkZGxpbmcgYSANCnBhZ2UgYm91bmRhcnkuIEF0IG1v
c3QgSSBjYW4gc2VlIGEgV0FSTl9PTiB3aXRoIGEgRE1BX01BUFBJTkdfRVJST1IgDQpyZXR1cm4g
aWYgc3VjaCBhIGNoZWNrIHdvdWxkIHlpZWxkIHRydWUuDQoNCkxldCdzIHNheSB5b3Ugd2FudCB0
byBkbyBhIERFVl9UT19NRU0gYW5kIGEgY2hlY2sgZGVjaWRlcyB5b3UgbmVlZCB0byANCmJvdW5j
ZSBpdCB5b3UnZCBib3VuY2UgYW4gUlggcmVnaXN0ZXIgYWRkcmVzcy4gSSBjYW5ub3Qgc2VlIGhv
dyB0aGF0IERNQSANCndvdWxkIGV2ZXIgZW5kIHVwIGRvaW5nIHRoZSBleHBlY3RlZCB0aGluZy4N
Cg0KVGhlIGVETUEgZW5naW5lIHdpbGwgbWFuYWdlIHRoZSBSWC9UWCByZWdpc3RlcnMgZm9yIGFu
IElQIGJsb2NrIGFuZCBtb3ZlIA0KdGhlIGRhdGEgYmV0d2VlbiB0aGVtIGFuZCBSQU0sIHdoZXJl
IHRoZSBSQU0gbWVtb3J5IGlzIG1hcHBlZCBzZXBhcmF0ZWx5IA0KYnkgZG1hX21hcF9wYWdlIChh
bmQgZmFtaWx5KS4gQW5kIHRoZXNlIGNhbiBiZSBzd2lvdGxiIGJvdW5jZWQgdmlhIHRoZSANCm1h
cCBwYWdlIGNhbGxiYWNrIHdpdGggbm8gcHJvYmxlbS4NCg0KQmVzdCByZWdhcmRzIC8vIEpvaG4g
RXJuYmVyZw==

