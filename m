Return-Path: <linux-kernel+bounces-709445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE4AEDDC6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 15:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0183AF638
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3230B28A1DA;
	Mon, 30 Jun 2025 12:59:18 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B15285075
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288357; cv=none; b=N+UIrP/O/ncJwOL+6SQTNF/BQ9ivgm6gVc0q8Pa/wrx7qlZLXeHUXJmkPm8U/mWkfzMrIjOABwMx+Mp4t3CFcdczvsPcMqbTuw7DDBVyxJb7gvx3EOK/ScBrVvVg6IYo0R3JJ8nEs3NUEakDn0czlmNWWYgNqeVi5IrTiXHsZUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288357; c=relaxed/simple;
	bh=dTnevGznb3uoSzC5S9aK1Uc/u5EIyryFxirqLBiA+94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWooUTKt4S0caJs5w3IOLR7NJHZRXql2ofRVS594cffvgToMKQOonpOKzouepuEOH8ePTubMWB1mP/Hrt6eMq6YkqnywBBERXgpOy69BvMKjCEmG5wq1rj+zp4YoTV0HqdCmW525y3LZqNs9BiGEBaFVHElILDmOI0qyU+znNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: HPfwmezkRrSQcgaJKph1pA==
X-CSE-MsgGUID: GB9+ytL8RSa6G3w7Nhb3Rw==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="119068382"
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
Thread-Index: AQHb5Z1MQCqP3gvX0E2hj7eo3PmF6LQTCY8AgAARqwCAAACSgIAH9bKAgAAao4A=
Date: Mon, 30 Jun 2025 12:58:56 +0000
Message-ID: <f4ee4a0b-86b5-41c0-8fec-c3697c8856f4@xiaomi.com>
References: <20250625064927.516586-1-huangjianan@xiaomi.com>
 <d2ac0da9-3d47-4269-a7b0-a18719c64346@kernel.org>
 <e58344ef-0544-41f3-be07-1f1478912469@xiaomi.com>
 <b76e5aaa-edb2-4a4d-a6a8-72f6e975f398@xiaomi.com>
 <18cd79ac-b7c6-4d7c-a322-d98c194656ee@kernel.org>
In-Reply-To: <18cd79ac-b7c6-4d7c-a322-d98c194656ee@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E1250B1A74C444B86C04AA3D799A418@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNS82LzMwIDE5OjIzLCBDaGFvIFl1IHdyb3RlOg0KPiANCj4gT24gNi8yNS8yNSAxNzo1
MCwgSHVhbmcgSmlhbmFuIHdyb3RlOg0KPj4gT24gMjAyNS82LzI1IDE3OjQ4LCBKaWFuYW4gSHVh
bmcgd3JvdGU6DQo+Pj4gT24gMjAyNS82LzI1IDE2OjQ1LCBDaGFvIFl1IHdyb3RlOg0KPj4+Pg0K
Pj4+PiBPbiA2LzI1LzI1IDE0OjQ5LCBKaWFuYW4gSHVhbmcgd3JvdGU6DQo+Pj4+PiBXaGVuIGZl
d2VyIHBhZ2VzIGFyZSByZWFkLCBucl9wYWdlcyBtYXkgYmUgc21hbGxlciB0aGFuIG5yX2NwYWdl
cy4gRHVlDQo+Pj4+PiB0byB0aGUgbnJfdmVjcyBsaW1pdCwgdGhlIGNvbXByZXNzZWQgcGFnZXMg
d2lsbCBiZSBzcGxpdCBpbnRvIG11bHRpcGxlDQo+Pj4+PiBiaW9zIGFuZCB0aGVuIG1lcmdlZCBh
dCB0aGUgYmxvY2sgbGV2ZWwuIEluIHRoaXMgY2FzZSwgbnJfY3BhZ2VzIHNob3VsZA0KPj4+Pj4g
YmUgdXNlZCB0byBwcmUtYWxsb2NhdGUgYnZlY3MuDQo+Pj4+PiBUbyBoYW5kbGUgdGhpcyBjYXNl
LCBhbGlnbiBtYXhfbnJfcGFnZXMgdG8gY2x1c3Rlcl9zaXplLCB3aGljaCBzaG91bGQgYmUNCj4+
Pj4+IGVub3VnaCBmb3IgYWxsIGNvbXByZXNzZWQgcGFnZXMuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVk
LW9mZi1ieTogSmlhbmFuIEh1YW5nIDxodWFuZ2ppYW5hbkB4aWFvbWkuY29tPg0KPj4+Pj4gU2ln
bmVkLW9mZi1ieTogU2hlbmcgWW9uZyA8c2hlbmd5b25nMUB4aWFvbWkuY29tPg0KPj4+Pj4gLS0t
DQo+Pj4+PiBDaGFuZ2VzIHNpbmNlIHYyOg0KPj4+Pj4gLSBJbml0aWFsaXplIGluZGV4IG9ubHkg
Zm9yIGNvbXByZXNzZWQgZmlsZXMuDQo+Pj4+PiBDaGFuZ2VzIHNpbmNlIHYxOg0KPj4+Pj4gLSBV
c2UgYWxpZ25lZCBucl9wYWdlcyBpbnN0ZWFkIG9mIG5yX2NwYWdlcyB0byBwcmUtYWxsb2NhdGUg
YnZlY3MuDQo+Pj4+Pg0KPj4+Pj4gICAgZnMvZjJmcy9kYXRhLmMgfCAxMiArKysrKysrKysrLS0N
Cj4+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2RhdGEuYyBiL2ZzL2YyZnMvZGF0
YS5jDQo+Pj4+PiBpbmRleCAzMWU4OTI4NDI2MjUuLmQwNzFkOWY2YTgxMSAxMDA2NDQNCj4+Pj4+
IC0tLSBhL2ZzL2YyZnMvZGF0YS5jDQo+Pj4+PiArKysgYi9mcy9mMmZzL2RhdGEuYw0KPj4+Pj4g
QEAgLTIzMDMsNyArMjMwMyw3IEBAIGludCBmMmZzX3JlYWRfbXVsdGlfcGFnZXMoc3RydWN0IGNv
bXByZXNzX2N0eA0KPj4+Pj4gKmNjLCBzdHJ1Y3QgYmlvICoqYmlvX3JldCwNCj4+Pj4+ICAgICAg
ICAgICAgICAgICB9DQo+Pj4+Pg0KPj4+Pj4gICAgICAgICAgICAgICAgIGlmICghYmlvKSB7DQo+
Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgYmlvID0gZjJmc19ncmFiX3JlYWRfYmlvKGlub2Rl
LCBibGthZGRyLCBucl9wYWdlcywNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBiaW8gPSBm
MmZzX2dyYWJfcmVhZF9iaW8oaW5vZGUsIGJsa2FkZHIsDQo+Pj4+PiBucl9wYWdlcyAtIGksDQo+
Pj4+DQo+Pj4+IEppYW5hbiwNCj4+Pj4NCj4+Pj4gQW5vdGhlciBjYXNlOg0KPj4+Pg0KPj4+PiBy
ZWFkIHBhZ2UgIzAsMSwyLDMgZnJvbSBibG9jayAjMTAwMCwxMDAxLDEwMDIsIGNsdXN0ZXJfc2l6
ZT00Lg0KPj4+Pg0KPj4+PiBucl9wYWdlcz00DQo+Pj4+IG1heF9ucl9wYWdlcz1yb3VuZF91cCgw
KzQsNCktcm91bmRfZG93bigwLDQpPTQNCj4+Pj4NCj4+Pj4gZjJmc19tcGFnZV9yZWFkcGFnZXMo
KSBjYWxscyBmMmZzX3JlYWRfbXVsdGlfcGFnZXMoKSB3aGVuIG5yX3BhZ2VzPTEsIGF0DQo+Pj4+
IHRoYXQgdGltZSwgbWF4X25yX3BhZ2VzIGVxdWFscyB0byAxIGFzIHdlbGwuDQo+Pj4+DQo+Pj4+
IGYyZnNfZ3JhYl9yZWFkX2JpbyguLi4sIDEgLSAwLC4uLikgYWxsb2NhdGUgYmlvIHcvIDEgdmVj
IGNhcGFjaXR5LA0KPj4+PiBob3dldmVyLA0KPj4+PiB3ZSBuZWVkIGF0IGxlYXN0IDMgdmVjcyB0
byBtZXJnZSBhbGwgY3BhZ2VzLCByaWdodD8NCj4+Pj4NCj4+Pg0KPj4+IEhpLCBjaGFvLA0KPj4+
DQo+Pj4gSWYgd2UgZG9uJ3QgYWxpZ24gbnJfcGFnZXMsIHRoZW4gd2hlbiBlbnRlcmluZyBmMmZz
X3JlYWRfbXVsdGlfcGFnZXMsDQo+Pj4gd2UgaGF2ZSBucl9wYWdlcyBwYWdlcyBsZWZ0LCB3aGlj
aCBiZWxvbmcgdG8gb3RoZXIgY2x1c3RlcnMuDQo+Pj4gSWYgdGhpcyBpcyB0aGUgbGFzdCBwYWdl
LCB3ZSBjYW4gc2ltcGx5IHBhc3MgbnJfcGFnZXMgPSAwLg0KPj4+DQo+Pj4gV2hlbiBhbGxvY2F0
aW5nIGJpbywgd2UgbmVlZDoNCj4+PiAxLiBUaGUgY3BhZ2VzIHJlbWFpbmluZyBpbiB0aGUgY3Vy
cmVudCBjbHVzdGVyLCB3aGljaCBzaG91bGQgYmUNCj4+PiAobnJfY2FwZ2VzIC0gaSkuDQo+Pj4g
Mi4gVGhlIG1heGltdW0gY3BhZ2VzIHJlbWFpbmluZyBpbiBvdGhlciBjbHVzdGVycywgd2hpY2gg
c2hvdWxkIGJlDQo+Pj4gbWF4KG5yX3BhZ2VzLCBjYy0+bnJfY3BhZ2VzKS4NCj4+Pg0KPj4NCj4+
IGFsaWduKG5yX3BhZ2VzLCBjYy0+bnJfY3BhZ2VzKSwgc29ycnkgZm9yIHRoaXMuDQo+Pg0KPj4+
IFNvIChucl9jYXBnZXMgLSBpKSArIG1heChucl9wYWdlcywgbnJfY3BhZ2VzKSwgc2hvdWxkIGJl
IGVub3VnaCBmb3IgYWxsDQo+Pj4gdmVjcz8NCj4gDQo+IEppYW5hbiwNCj4gDQo+IFdoYXQgYWJv
dXQgZ2V0dGluZyByaWQgb2YgYmVsb3cgY2hhbmdlPyBhbmQganVzdCBwYXNzaW5nIG1heF9ucl9w
YWdlcyB0bw0KPiBmMmZzX3JlYWRfbXVsdGlfcGFnZXM/IE1heWJlIHRoZXJlIGlzIGEgbGl0dGxl
IGJpdCB3YXN0ZSBmb3IgYmlvIHZlY3RvciBzcGFjZSwNCj4gYnV0IGl0IHdpbGwgYmUgbW9yZSBz
YWZlIHRvIHJlc2VydmUgZW5vdWdoIG1hcmdpbi4NCj4gDQo+ICsgICAgICAgZm9yICg7IG5yX3Bh
Z2VzOyBucl9wYWdlcy0tLCBtYXhfbnJfcGFnZXMtLSkgew0KPiANCg0KTEdUTSwgdXBkYXRlZCBp
biB2NC4NCg0KVGhhbmtzLA0KDQo+IFRoYW5rcywNCj4gDQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4N
Cj4+Pg0KPj4+PiBUaGFua3MsDQo+Pj4+DQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZjJmc19yYV9vcF9mbGFncyhyYWMpLA0KPj4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvbGlvLT5pbmRleCwgZm9yX3dyaXRlKTsNCj4+
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChJU19FUlIoYmlvKSkgew0KPj4+Pj4gQEAg
LTIzNzYsNiArMjM3NiwxNCBAQCBzdGF0aWMgaW50IGYyZnNfbXBhZ2VfcmVhZHBhZ2VzKHN0cnVj
dCBpbm9kZQ0KPj4+Pj4gKmlub2RlLA0KPj4+Pj4gICAgICAgICB1bnNpZ25lZCBtYXhfbnJfcGFn
ZXMgPSBucl9wYWdlczsNCj4+Pj4+ICAgICAgICAgaW50IHJldCA9IDA7DQo+Pj4+Pg0KPj4+Pj4g
KyNpZmRlZiBDT05GSUdfRjJGU19GU19DT01QUkVTU0lPTg0KPj4+Pj4gKyAgICAgaWYgKGYyZnNf
Y29tcHJlc3NlZF9maWxlKGlub2RlKSkgew0KPj4+Pj4gKyAgICAgICAgICAgICBpbmRleCA9IHJh
YyA/IHJlYWRhaGVhZF9pbmRleChyYWMpIDogZm9saW8tPmluZGV4Ow0KPj4+Pj4gKyAgICAgICAg
ICAgICBtYXhfbnJfcGFnZXMgPSByb3VuZF91cChpbmRleCArIG5yX3BhZ2VzLA0KPj4+Pj4gY2Mu
Y2x1c3Rlcl9zaXplKSAtDQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICByb3Vu
ZF9kb3duKGluZGV4LCBjYy5jbHVzdGVyX3NpemUpOw0KPj4+Pj4gKyAgICAgfQ0KPj4+Pj4gKyNl
bmRpZg0KPj4+Pj4gKw0KPj4+Pj4gICAgICAgICBtYXAubV9wYmxrID0gMDsNCj4+Pj4+ICAgICAg
ICAgbWFwLm1fbGJsayA9IDA7DQo+Pj4+PiAgICAgICAgIG1hcC5tX2xlbiA9IDA7DQo+Pj4+PiBA
QCAtMjM4NSw3ICsyMzkzLDcgQEAgc3RhdGljIGludCBmMmZzX21wYWdlX3JlYWRwYWdlcyhzdHJ1
Y3QgaW5vZGUNCj4+Pj4+ICppbm9kZSwNCj4+Pj4+ICAgICAgICAgbWFwLm1fc2VnX3R5cGUgPSBO
T19DSEVDS19UWVBFOw0KPj4+Pj4gICAgICAgICBtYXAubV9tYXlfY3JlYXRlID0gZmFsc2U7DQo+
Pj4+Pg0KPj4+Pj4gLSAgICAgZm9yICg7IG5yX3BhZ2VzOyBucl9wYWdlcy0tKSB7DQo+Pj4+PiAr
ICAgICBmb3IgKDsgbnJfcGFnZXM7IG5yX3BhZ2VzLS0sIG1heF9ucl9wYWdlcy0tKSB7DQo+Pj4+
PiAgICAgICAgICAgICAgICAgaWYgKHJhYykgew0KPj4+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgZm9saW8gPSByZWFkYWhlYWRfZm9saW8ocmFjKTsNCj4+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHByZWZldGNodygmZm9saW8tPmZsYWdzKTsNCj4+Pj4NCj4+Pg0KPj4NCj4gDQoNCg==

