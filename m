Return-Path: <linux-kernel+bounces-702097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C91AE7DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 11:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C5F7A4FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544C3275B04;
	Wed, 25 Jun 2025 09:50:27 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B894E1917D6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845026; cv=none; b=hPn0ucM0WcGyD9rVanEzYQ0ebpTdbteEDjL3kBDO9/fiS5QbQxHy9tQF6Ay0ovMNEkp2xCQudy1/bBz4K/t6F4EjTcHF4n+o7MKgZFtLLnhVYEHw2yUdyBG5M94coeXrN1785hnh8/JZCPMq0njfWU/IK60luqlkY+t5c2Na4Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845026; c=relaxed/simple;
	bh=hF5Jjq73FzH3FxAcWX7y8qS/uRtj90H+LynyIFGNkhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FMem9X9tXYWUg3xOr8Ql0i1+cVKGLS5EBDsEglYiYsmYrG7+jg776GzeYeuoodgK6ZowsfAU84fj0vzF7w+UVvgoNglMXMYj38bnr8nyEnwHpVKxCwsNyMTZNuROjjNbT/72pwcunNm2BFjOR6eQr0W/3qLkdH4ZQB8TW2pTMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 8PMjbf1nSu27RrHEpj+NmQ==
X-CSE-MsgGUID: Gl296tigQtqmoleNE9XQ2Q==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="118554525"
From: Huang Jianan <huangjianan@xiaomi.com>
To: Chao Yu <chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "jaegeuk@kernel.org"
	<jaegeuk@kernel.org>
CC: =?utf-8?B?546L6L6J?= <wanghui33@xiaomi.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?55ub5YuH?= <shengyong1@xiaomi.com>
Subject: Re: [External Mail]Re: [PATCH v3] f2fs: avoid splitting bio when
 reading multiple pages
Thread-Topic: [External Mail]Re: [PATCH v3] f2fs: avoid splitting bio when
 reading multiple pages
Thread-Index: AQHb5Z1MQCqP3gvX0E2hj7eo3PmF6LQTCY8AgAARqwCAAACSgA==
Date: Wed, 25 Jun 2025 09:50:22 +0000
Message-ID: <b76e5aaa-edb2-4a4d-a6a8-72f6e975f398@xiaomi.com>
References: <20250625064927.516586-1-huangjianan@xiaomi.com>
 <d2ac0da9-3d47-4269-a7b0-a18719c64346@kernel.org>
 <e58344ef-0544-41f3-be07-1f1478912469@xiaomi.com>
In-Reply-To: <e58344ef-0544-41f3-be07-1f1478912469@xiaomi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B01E66B4E68EA419EE42BB180DEA912@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNS82LzI1IDE3OjQ4LCBKaWFuYW4gSHVhbmcgd3JvdGU6DQo+IE9uIDIwMjUvNi8yNSAx
Njo0NSwgQ2hhbyBZdSB3cm90ZToNCj4+DQo+PiBPbiA2LzI1LzI1IDE0OjQ5LCBKaWFuYW4gSHVh
bmcgd3JvdGU6DQo+Pj4gV2hlbiBmZXdlciBwYWdlcyBhcmUgcmVhZCwgbnJfcGFnZXMgbWF5IGJl
IHNtYWxsZXIgdGhhbiBucl9jcGFnZXMuIER1ZQ0KPj4+IHRvIHRoZSBucl92ZWNzIGxpbWl0LCB0
aGUgY29tcHJlc3NlZCBwYWdlcyB3aWxsIGJlIHNwbGl0IGludG8gbXVsdGlwbGUNCj4+PiBiaW9z
IGFuZCB0aGVuIG1lcmdlZCBhdCB0aGUgYmxvY2sgbGV2ZWwuIEluIHRoaXMgY2FzZSwgbnJfY3Bh
Z2VzIHNob3VsZA0KPj4+IGJlIHVzZWQgdG8gcHJlLWFsbG9jYXRlIGJ2ZWNzLg0KPj4+IFRvIGhh
bmRsZSB0aGlzIGNhc2UsIGFsaWduIG1heF9ucl9wYWdlcyB0byBjbHVzdGVyX3NpemUsIHdoaWNo
IHNob3VsZCBiZQ0KPj4+IGVub3VnaCBmb3IgYWxsIGNvbXByZXNzZWQgcGFnZXMuDQo+Pj4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBKaWFuYW4gSHVhbmcgPGh1YW5namlhbmFuQHhpYW9taS5jb20+DQo+
Pj4gU2lnbmVkLW9mZi1ieTogU2hlbmcgWW9uZyA8c2hlbmd5b25nMUB4aWFvbWkuY29tPg0KPj4+
IC0tLQ0KPj4+IENoYW5nZXMgc2luY2UgdjI6DQo+Pj4gLSBJbml0aWFsaXplIGluZGV4IG9ubHkg
Zm9yIGNvbXByZXNzZWQgZmlsZXMuDQo+Pj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4+PiAtIFVzZSBh
bGlnbmVkIG5yX3BhZ2VzIGluc3RlYWQgb2YgbnJfY3BhZ2VzIHRvIHByZS1hbGxvY2F0ZSBidmVj
cy4NCj4+Pg0KPj4+IMKgIGZzL2YyZnMvZGF0YS5jIHwgMTIgKysrKysrKysrKy0tDQo+Pj4gwqAg
MSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+
PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9kYXRhLmMgYi9mcy9mMmZzL2RhdGEuYw0KPj4+IGluZGV4
IDMxZTg5Mjg0MjYyNS4uZDA3MWQ5ZjZhODExIDEwMDY0NA0KPj4+IC0tLSBhL2ZzL2YyZnMvZGF0
YS5jDQo+Pj4gKysrIGIvZnMvZjJmcy9kYXRhLmMNCj4+PiBAQCAtMjMwMyw3ICsyMzAzLDcgQEAg
aW50IGYyZnNfcmVhZF9tdWx0aV9wYWdlcyhzdHJ1Y3QgY29tcHJlc3NfY3R4IA0KPj4+ICpjYywg
c3RydWN0IGJpbyAqKmJpb19yZXQsDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
DQo+Pj4NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghYmlvKSB7DQo+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmlvID0gZjJmc19ncmFi
X3JlYWRfYmlvKGlub2RlLCBibGthZGRyLCBucl9wYWdlcywNCj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiaW8gPSBmMmZzX2dyYWJfcmVhZF9iaW8oaW5vZGUs
IGJsa2FkZHIsIA0KPj4+IG5yX3BhZ2VzIC0gaSwNCj4+DQo+PiBKaWFuYW4sDQo+Pg0KPj4gQW5v
dGhlciBjYXNlOg0KPj4NCj4+IHJlYWQgcGFnZSAjMCwxLDIsMyBmcm9tIGJsb2NrICMxMDAwLDEw
MDEsMTAwMiwgY2x1c3Rlcl9zaXplPTQuDQo+Pg0KPj4gbnJfcGFnZXM9NA0KPj4gbWF4X25yX3Bh
Z2VzPXJvdW5kX3VwKDArNCw0KS1yb3VuZF9kb3duKDAsNCk9NA0KPj4NCj4+IGYyZnNfbXBhZ2Vf
cmVhZHBhZ2VzKCkgY2FsbHMgZjJmc19yZWFkX211bHRpX3BhZ2VzKCkgd2hlbiBucl9wYWdlcz0x
LCBhdA0KPj4gdGhhdCB0aW1lLCBtYXhfbnJfcGFnZXMgZXF1YWxzIHRvIDEgYXMgd2VsbC4NCj4+
DQo+PiBmMmZzX2dyYWJfcmVhZF9iaW8oLi4uLCAxIC0gMCwuLi4pIGFsbG9jYXRlIGJpbyB3LyAx
IHZlYyBjYXBhY2l0eSwgDQo+PiBob3dldmVyLA0KPj4gd2UgbmVlZCBhdCBsZWFzdCAzIHZlY3Mg
dG8gbWVyZ2UgYWxsIGNwYWdlcywgcmlnaHQ/DQo+Pg0KPiANCj4gSGksIGNoYW8sDQo+IA0KPiBJ
ZiB3ZSBkb24ndCBhbGlnbiBucl9wYWdlcywgdGhlbiB3aGVuIGVudGVyaW5nIGYyZnNfcmVhZF9t
dWx0aV9wYWdlcywNCj4gd2UgaGF2ZSBucl9wYWdlcyBwYWdlcyBsZWZ0LCB3aGljaCBiZWxvbmcg
dG8gb3RoZXIgY2x1c3RlcnMuDQo+IElmIHRoaXMgaXMgdGhlIGxhc3QgcGFnZSwgd2UgY2FuIHNp
bXBseSBwYXNzIG5yX3BhZ2VzID0gMC4NCj4gDQo+IFdoZW4gYWxsb2NhdGluZyBiaW8sIHdlIG5l
ZWQ6DQo+IDEuIFRoZSBjcGFnZXMgcmVtYWluaW5nIGluIHRoZSBjdXJyZW50IGNsdXN0ZXIsIHdo
aWNoIHNob3VsZCBiZSANCj4gKG5yX2NhcGdlcyAtIGkpLg0KPiAyLiBUaGUgbWF4aW11bSBjcGFn
ZXMgcmVtYWluaW5nIGluIG90aGVyIGNsdXN0ZXJzLCB3aGljaCBzaG91bGQgYmUgDQo+IG1heChu
cl9wYWdlcywgY2MtPm5yX2NwYWdlcykuDQo+IA0KDQphbGlnbihucl9wYWdlcywgY2MtPm5yX2Nw
YWdlcyksIHNvcnJ5IGZvciB0aGlzLg0KDQo+IFNvIChucl9jYXBnZXMgLSBpKSArIG1heChucl9w
YWdlcywgbnJfY3BhZ2VzKSwgc2hvdWxkIGJlIGVub3VnaCBmb3IgYWxsIA0KPiB2ZWNzPw0KPiAN
Cj4gVGhhbmtzLA0KPiANCj4gDQo+PiBUaGFua3MsDQo+Pg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZjJmc19yYV9vcF9mbGFncyhyYWMpLA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9saW8t
PmluZGV4LCBmb3Jfd3JpdGUpOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChJU19FUlIoYmlvKSkgew0KPj4+IEBAIC0yMzc2LDYgKzIzNzYsMTQg
QEAgc3RhdGljIGludCBmMmZzX21wYWdlX3JlYWRwYWdlcyhzdHJ1Y3QgaW5vZGUgDQo+Pj4gKmlu
b2RlLA0KPj4+IMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBtYXhfbnJfcGFnZXMgPSBucl9wYWdlczsN
Cj4+PiDCoMKgwqDCoMKgwqAgaW50IHJldCA9IDA7DQo+Pj4NCj4+PiArI2lmZGVmIENPTkZJR19G
MkZTX0ZTX0NPTVBSRVNTSU9ODQo+Pj4gK8KgwqDCoMKgIGlmIChmMmZzX2NvbXByZXNzZWRfZmls
ZShpbm9kZSkpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZGV4ID0gcmFjID8g
cmVhZGFoZWFkX2luZGV4KHJhYykgOiBmb2xpby0+aW5kZXg7DQo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtYXhfbnJfcGFnZXMgPSByb3VuZF91cChpbmRleCArIG5yX3BhZ2VzLCANCj4+
PiBjYy5jbHVzdGVyX3NpemUpIC0NCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcm91bmRfZG93bihpbmRleCwgY2MuY2x1c3Rlcl9z
aXplKTsNCj4+PiArwqDCoMKgwqAgfQ0KPj4+ICsjZW5kaWYNCj4+PiArDQo+Pj4gwqDCoMKgwqDC
oMKgIG1hcC5tX3BibGsgPSAwOw0KPj4+IMKgwqDCoMKgwqDCoCBtYXAubV9sYmxrID0gMDsNCj4+
PiDCoMKgwqDCoMKgwqAgbWFwLm1fbGVuID0gMDsNCj4+PiBAQCAtMjM4NSw3ICsyMzkzLDcgQEAg
c3RhdGljIGludCBmMmZzX21wYWdlX3JlYWRwYWdlcyhzdHJ1Y3QgaW5vZGUgDQo+Pj4gKmlub2Rl
LA0KPj4+IMKgwqDCoMKgwqDCoCBtYXAubV9zZWdfdHlwZSA9IE5PX0NIRUNLX1RZUEU7DQo+Pj4g
wqDCoMKgwqDCoMKgIG1hcC5tX21heV9jcmVhdGUgPSBmYWxzZTsNCj4+Pg0KPj4+IC3CoMKgwqDC
oCBmb3IgKDsgbnJfcGFnZXM7IG5yX3BhZ2VzLS0pIHsNCj4+PiArwqDCoMKgwqAgZm9yICg7IG5y
X3BhZ2VzOyBucl9wYWdlcy0tLCBtYXhfbnJfcGFnZXMtLSkgew0KPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKHJhYykgew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGZvbGlvID0gcmVhZGFoZWFkX2ZvbGlvKHJhYyk7DQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJlZmV0Y2h3KCZmb2xp
by0+ZmxhZ3MpOw0KPj4NCj4gDQoNCg==

