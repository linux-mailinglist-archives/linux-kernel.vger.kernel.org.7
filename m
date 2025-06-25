Return-Path: <linux-kernel+bounces-702095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DF6AE7E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 11:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F9A1884F94
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C629B22D;
	Wed, 25 Jun 2025 09:48:26 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A7E285CBF
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844906; cv=none; b=ok9K8Dw5GNJWhVXcGoo0PIKItw9QPP5yTZ3TvkdcV3FXkQb7bi+iFpu07AsjtgHzajuRYQVS4hLsyniVZnh1AAdk36dmf1HjzoSyTUSDAAg8Q63ShWgRd+fMmUblzVHFXoNKWboJypWaH1cpv95ovIYxiGz/WL+dyFpLTvwyDQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844906; c=relaxed/simple;
	bh=n+XBI2Ab6dlqEa0ug9pegk0k056t138HDkGT61V1MBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rw6fsl0N7b+vmzgXvYMib0mW7u8ts35A8ZogFhVjEYx+jsb4bPaLjvQILR/g9p64IfnsRFP7flcdGrdGVqade6cBDit/cKI9P9sWO9wb2Nio+5yCbpPR3ZOOcoej+/QpUS2v/ga2lxzWAz/H1vpFIktoaDjzz4k3Br3j7qBmlIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: QB0u5cqvRnyQ1XWXvZ5wUQ==
X-CSE-MsgGUID: ePpIfG8+TBybtD7zYj78jg==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="144227785"
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
Thread-Index: AQHb5Z1MQCqP3gvX0E2hj7eo3PmF6LQTCY8AgAARqwA=
Date: Wed, 25 Jun 2025 09:48:19 +0000
Message-ID: <e58344ef-0544-41f3-be07-1f1478912469@xiaomi.com>
References: <20250625064927.516586-1-huangjianan@xiaomi.com>
 <d2ac0da9-3d47-4269-a7b0-a18719c64346@kernel.org>
In-Reply-To: <d2ac0da9-3d47-4269-a7b0-a18719c64346@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <9013EE3F2EA98A4EB20C6CC4351BE9A9@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNS82LzI1IDE2OjQ1LCBDaGFvIFl1IHdyb3RlOg0KPiANCj4gT24gNi8yNS8yNSAxNDo0
OSwgSmlhbmFuIEh1YW5nIHdyb3RlOg0KPj4gV2hlbiBmZXdlciBwYWdlcyBhcmUgcmVhZCwgbnJf
cGFnZXMgbWF5IGJlIHNtYWxsZXIgdGhhbiBucl9jcGFnZXMuIER1ZQ0KPj4gdG8gdGhlIG5yX3Zl
Y3MgbGltaXQsIHRoZSBjb21wcmVzc2VkIHBhZ2VzIHdpbGwgYmUgc3BsaXQgaW50byBtdWx0aXBs
ZQ0KPj4gYmlvcyBhbmQgdGhlbiBtZXJnZWQgYXQgdGhlIGJsb2NrIGxldmVsLiBJbiB0aGlzIGNh
c2UsIG5yX2NwYWdlcyBzaG91bGQNCj4+IGJlIHVzZWQgdG8gcHJlLWFsbG9jYXRlIGJ2ZWNzLg0K
Pj4gVG8gaGFuZGxlIHRoaXMgY2FzZSwgYWxpZ24gbWF4X25yX3BhZ2VzIHRvIGNsdXN0ZXJfc2l6
ZSwgd2hpY2ggc2hvdWxkIGJlDQo+PiBlbm91Z2ggZm9yIGFsbCBjb21wcmVzc2VkIHBhZ2VzLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IEppYW5hbiBIdWFuZyA8aHVhbmdqaWFuYW5AeGlhb21pLmNv
bT4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoZW5nIFlvbmcgPHNoZW5neW9uZzFAeGlhb21pLmNvbT4N
Cj4+IC0tLQ0KPj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4+IC0gSW5pdGlhbGl6ZSBpbmRleCBvbmx5
IGZvciBjb21wcmVzc2VkIGZpbGVzLg0KPj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4+IC0gVXNlIGFs
aWduZWQgbnJfcGFnZXMgaW5zdGVhZCBvZiBucl9jcGFnZXMgdG8gcHJlLWFsbG9jYXRlIGJ2ZWNz
Lg0KPj4NCj4+ICAgZnMvZjJmcy9kYXRhLmMgfCAxMiArKysrKysrKysrLS0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2ZzL2YyZnMvZGF0YS5jIGIvZnMvZjJmcy9kYXRhLmMNCj4+IGluZGV4IDMxZTg5Mjg0
MjYyNS4uZDA3MWQ5ZjZhODExIDEwMDY0NA0KPj4gLS0tIGEvZnMvZjJmcy9kYXRhLmMNCj4+ICsr
KyBiL2ZzL2YyZnMvZGF0YS5jDQo+PiBAQCAtMjMwMyw3ICsyMzAzLDcgQEAgaW50IGYyZnNfcmVh
ZF9tdWx0aV9wYWdlcyhzdHJ1Y3QgY29tcHJlc3NfY3R4ICpjYywgc3RydWN0IGJpbyAqKmJpb19y
ZXQsDQo+PiAgICAgICAgICAgICAgICB9DQo+Pg0KPj4gICAgICAgICAgICAgICAgaWYgKCFiaW8p
IHsNCj4+IC0gICAgICAgICAgICAgICAgICAgICBiaW8gPSBmMmZzX2dyYWJfcmVhZF9iaW8oaW5v
ZGUsIGJsa2FkZHIsIG5yX3BhZ2VzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGJpbyA9IGYy
ZnNfZ3JhYl9yZWFkX2Jpbyhpbm9kZSwgYmxrYWRkciwgbnJfcGFnZXMgLSBpLA0KPiANCj4gSmlh
bmFuLA0KPiANCj4gQW5vdGhlciBjYXNlOg0KPiANCj4gcmVhZCBwYWdlICMwLDEsMiwzIGZyb20g
YmxvY2sgIzEwMDAsMTAwMSwxMDAyLCBjbHVzdGVyX3NpemU9NC4NCj4gDQo+IG5yX3BhZ2VzPTQN
Cj4gbWF4X25yX3BhZ2VzPXJvdW5kX3VwKDArNCw0KS1yb3VuZF9kb3duKDAsNCk9NA0KPiANCj4g
ZjJmc19tcGFnZV9yZWFkcGFnZXMoKSBjYWxscyBmMmZzX3JlYWRfbXVsdGlfcGFnZXMoKSB3aGVu
IG5yX3BhZ2VzPTEsIGF0DQo+IHRoYXQgdGltZSwgbWF4X25yX3BhZ2VzIGVxdWFscyB0byAxIGFz
IHdlbGwuDQo+IA0KPiBmMmZzX2dyYWJfcmVhZF9iaW8oLi4uLCAxIC0gMCwuLi4pIGFsbG9jYXRl
IGJpbyB3LyAxIHZlYyBjYXBhY2l0eSwgaG93ZXZlciwNCj4gd2UgbmVlZCBhdCBsZWFzdCAzIHZl
Y3MgdG8gbWVyZ2UgYWxsIGNwYWdlcywgcmlnaHQ/DQo+IA0KDQpIaSwgY2hhbywNCg0KSWYgd2Ug
ZG9uJ3QgYWxpZ24gbnJfcGFnZXMsIHRoZW4gd2hlbiBlbnRlcmluZyBmMmZzX3JlYWRfbXVsdGlf
cGFnZXMsDQp3ZSBoYXZlIG5yX3BhZ2VzIHBhZ2VzIGxlZnQsIHdoaWNoIGJlbG9uZyB0byBvdGhl
ciBjbHVzdGVycy4NCklmIHRoaXMgaXMgdGhlIGxhc3QgcGFnZSwgd2UgY2FuIHNpbXBseSBwYXNz
IG5yX3BhZ2VzID0gMC4NCg0KV2hlbiBhbGxvY2F0aW5nIGJpbywgd2UgbmVlZDoNCjEuIFRoZSBj
cGFnZXMgcmVtYWluaW5nIGluIHRoZSBjdXJyZW50IGNsdXN0ZXIsIHdoaWNoIHNob3VsZCBiZSAN
Cihucl9jYXBnZXMgLSBpKS4NCjIuIFRoZSBtYXhpbXVtIGNwYWdlcyByZW1haW5pbmcgaW4gb3Ro
ZXIgY2x1c3RlcnMsIHdoaWNoIHNob3VsZCBiZSANCm1heChucl9wYWdlcywgY2MtPm5yX2NwYWdl
cykuDQoNClNvIChucl9jYXBnZXMgLSBpKSArIG1heChucl9wYWdlcywgbnJfY3BhZ2VzKSwgc2hv
dWxkIGJlIGVub3VnaCBmb3IgYWxsIA0KdmVjcz8NCg0KVGhhbmtzLA0KDQoNCj4gVGhhbmtzLA0K
PiANCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGYyZnNfcmFfb3Bf
ZmxhZ3MocmFjKSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZv
bGlvLT5pbmRleCwgZm9yX3dyaXRlKTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKElT
X0VSUihiaW8pKSB7DQo+PiBAQCAtMjM3Niw2ICsyMzc2LDE0IEBAIHN0YXRpYyBpbnQgZjJmc19t
cGFnZV9yZWFkcGFnZXMoc3RydWN0IGlub2RlICppbm9kZSwNCj4+ICAgICAgICB1bnNpZ25lZCBt
YXhfbnJfcGFnZXMgPSBucl9wYWdlczsNCj4+ICAgICAgICBpbnQgcmV0ID0gMDsNCj4+DQo+PiAr
I2lmZGVmIENPTkZJR19GMkZTX0ZTX0NPTVBSRVNTSU9ODQo+PiArICAgICBpZiAoZjJmc19jb21w
cmVzc2VkX2ZpbGUoaW5vZGUpKSB7DQo+PiArICAgICAgICAgICAgIGluZGV4ID0gcmFjID8gcmVh
ZGFoZWFkX2luZGV4KHJhYykgOiBmb2xpby0+aW5kZXg7DQo+PiArICAgICAgICAgICAgIG1heF9u
cl9wYWdlcyA9IHJvdW5kX3VwKGluZGV4ICsgbnJfcGFnZXMsIGNjLmNsdXN0ZXJfc2l6ZSkgLQ0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcm91bmRfZG93bihpbmRleCwgY2MuY2x1
c3Rlcl9zaXplKTsNCj4+ICsgICAgIH0NCj4+ICsjZW5kaWYNCj4+ICsNCj4+ICAgICAgICBtYXAu
bV9wYmxrID0gMDsNCj4+ICAgICAgICBtYXAubV9sYmxrID0gMDsNCj4+ICAgICAgICBtYXAubV9s
ZW4gPSAwOw0KPj4gQEAgLTIzODUsNyArMjM5Myw3IEBAIHN0YXRpYyBpbnQgZjJmc19tcGFnZV9y
ZWFkcGFnZXMoc3RydWN0IGlub2RlICppbm9kZSwNCj4+ICAgICAgICBtYXAubV9zZWdfdHlwZSA9
IE5PX0NIRUNLX1RZUEU7DQo+PiAgICAgICAgbWFwLm1fbWF5X2NyZWF0ZSA9IGZhbHNlOw0KPj4N
Cj4+IC0gICAgIGZvciAoOyBucl9wYWdlczsgbnJfcGFnZXMtLSkgew0KPj4gKyAgICAgZm9yICg7
IG5yX3BhZ2VzOyBucl9wYWdlcy0tLCBtYXhfbnJfcGFnZXMtLSkgew0KPj4gICAgICAgICAgICAg
ICAgaWYgKHJhYykgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICBmb2xpbyA9IHJlYWRhaGVh
ZF9mb2xpbyhyYWMpOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICBwcmVmZXRjaHcoJmZvbGlv
LT5mbGFncyk7DQo+IA0KDQo=

