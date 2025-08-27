Return-Path: <linux-kernel+bounces-788295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E728FB3827B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25B017E851
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC230DECF;
	Wed, 27 Aug 2025 12:35:14 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D1337694
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298113; cv=none; b=DECstbScAW8pnWvTv0Id1h/zLBeOGy0wXnbblj6iDA3pY7av2+417Mal9pX/JE2HLX5MkRAu+5CrOxx4PjJuEuN9zFxr1FqMECRLZPxmIpazqpXZBYdPexsMfIToQKMtDX7D+o8180pqK8nKsCzjRFSHuSngPNXuZoEg5XOXTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298113; c=relaxed/simple;
	bh=Yx0kr1wXhgSaAx25bJJouKIIwYnGwEseD+c/vd2eMho=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rvEeGvOMaqEBshCgDON3hBVoGBeEqGk0NXZjK8R9FkewBgYot/WzyGFayICHa+ca6wqCg1E3EnTxPZX8kADFxGJNPBk4PjWOUlVkJXjfVw6uJwdCP20IjMw6JE7i3mq7SgbcZz7DShcXqngWCCxl0r4+ShcHjJ42IPnptxgYLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: David Hildenbrand <david@redhat.com>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "osalvador@suse.de" <osalvador@suse.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "giorgitchankvetadze1997@gmail.com"
	<giorgitchankvetadze1997@gmail.com>
CC: "Xu,Wenjie(ACG CCN)" <xuwenjie04@baidu.com>
Subject: RE: Re: [PATCH] mm/hugetlb: two-phase hugepage allocation when
 reservation is high
Thread-Topic: Re: [PATCH] mm/hugetlb: two-phase hugepage allocation when
 reservation is high
Thread-Index: AdwXTo2D4t8VzJOQTS+wEMkzEbc86Q==
Date: Wed, 27 Aug 2025 12:33:35 +0000
Message-ID: <73da268715754133b787f22e016a903c@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.12
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBOb3Qgc3VyZSBpZiBzb21ldGhpbmcgbGlrZSB0aGUgZm9sbG93aW5nIGNvdWxkIGZseToNCj4g
DQo+IGRpZmYgLS1naXQgYS9tbS9odWdldGxiLmMgYi9tbS9odWdldGxiLmMgaW5kZXgNCj4gMWY0
MjE4NmE4NWVhNC4uZGZiNGQ3MTdiOGEwMiAxMDA2NDQNCj4gLS0tIGEvbW0vaHVnZXRsYi5jDQo+
ICsrKyBiL21tL2h1Z2V0bGIuYw0KPiBAQCAtMzU5NSw4ICszNTk1LDYgQEAgc3RhdGljIHVuc2ln
bmVkIGxvbmcgX19pbml0DQo+IGh1Z2V0bGJfcGFnZXNfYWxsb2NfYm9vdChzdHJ1Y3QgaHN0YXRl
ICpoKQ0KPiAgICAgICAgICB1bnNpZ25lZCBsb25nIGppZmZpZXNfZW5kOw0KPiANCj4gICAgICAg
ICAgam9iLnRocmVhZF9mbiAgID0gaHVnZXRsYl9wYWdlc19hbGxvY19ib290X25vZGU7DQo+IC0g
ICAgICAgam9iLnN0YXJ0ICAgICAgID0gMDsNCj4gLSAgICAgICBqb2Iuc2l6ZSAgICAgICAgPSBo
LT5tYXhfaHVnZV9wYWdlczsNCj4gDQo+ICAgICAgICAgIC8qDQo+ICAgICAgICAgICAqIGpvYi5t
YXhfdGhyZWFkcyBpcyAyNSUgb2YgdGhlIGF2YWlsYWJsZSBjcHUgdGhyZWFkcyBieSBkZWZhdWx0
Lg0KPiBAQCAtMzYyMCwxMCArMzYxOCwyNCBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBfX2luaXQN
Cj4gaHVnZXRsYl9wYWdlc19hbGxvY19ib290KHN0cnVjdCBoc3RhdGUgKmgpDQo+ICAgICAgICAg
IH0NCj4gDQo+ICAgICAgICAgIGpvYi5tYXhfdGhyZWFkcyA9IGh1Z2VwYWdlX2FsbG9jYXRpb25f
dGhyZWFkczsNCj4gLSAgICAgICBqb2IubWluX2NodW5rICAgPSBoLT5tYXhfaHVnZV9wYWdlcyAv
DQo+IGh1Z2VwYWdlX2FsbG9jYXRpb25fdGhyZWFkczsNCj4gDQo+ICAgICAgICAgIGppZmZpZXNf
c3RhcnQgPSBqaWZmaWVzOw0KPiAtICAgICAgIHBhZGF0YV9kb19tdWx0aXRocmVhZGVkKCZqb2Ip
Ow0KPiArICAgICAgIC8qIFRPRE86IGNvbW1lbnQgd2h5IHdlIHJldHJ5IGFuZCBob3cgaXQgaW50
ZXJhY3RzIHdpdGgNCj4gdm1lbW1hcCBvcC4gKi8NCj4gKyAgICAgICB3aGlsZSAoaC0+bnJfaHVn
ZV9wYWdlcyAhPSBoLT5tYXhfaHVnZV9wYWdlcykgew0KPiArICAgICAgICAgICAgICAgdW5zaWdu
ZWQgbG9uZyByZW1haW5pbmcgPSBoLT5tYXhfaHVnZV9wYWdlcyAtDQo+ICsgaC0+bnJfaHVnZV9w
YWdlczsNCj4gKw0KPiArICAgICAgICAgICAgICAgam9iLnN0YXJ0ICAgICAgID0gaC0+bnJfaHVn
ZV9wYWdlczsNCj4gKyAgICAgICAgICAgICAgIGpvYi5zaXplICAgICAgICA9IHJlbWFpbmluZzsN
Cj4gKyAgICAgICAgICAgICAgIGpvYi5taW5fY2h1bmsgICA9IHJlbWFpbmluZyAvDQo+IGh1Z2Vw
YWdlX2FsbG9jYXRpb25fdGhyZWFkczsNCj4gKyAgICAgICAgICAgICAgIHBhZGF0YV9kb19tdWx0
aXRocmVhZGVkKCZqb2IpOw0KPiArDQo+ICsgICAgICAgICAgICAgICBpZiAoaHVnZXRsYl92bWVt
bWFwX29wdGltaXphYmxlKGgpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCg0K
SXQgc2hvdWxkIGJlOg0KICAgICAgICAgICBpZiAoIWh1Z2V0bGJfdm1lbW1hcF9vcHRpbWl6YWJs
ZShoKSkNCiAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KDQpvdGhlciBpcyBmaW5lIHRvIG1l
DQoNCnRoYW5rcw0KDQotTGkNCg0KDQo+ICsNCj4gKyAgICAgICAgICAgICAgIC8qIFN0b3AgaWYg
dGhlcmUgaXMgbm8gcHJvZ3Jlc3MuICovDQo+ICsgICAgICAgICAgICAgICBpZiAocmVtYWluaW5n
ID09IGgtPm1heF9odWdlX3BhZ2VzIC0gaC0+bnJfaHVnZV9wYWdlcykNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgfQ0KPiAgICAgICAgICBqaWZmaWVzX2VuZCA9
IGppZmZpZXM7DQo+IA0KPiAgICAgICAgICBwcl9pbmZvKCJIdWdlVExCOiBhbGxvY2F0aW9uIHRv
b2sgJWRtcyB3aXRoDQo+IGh1Z2VwYWdlX2FsbG9jYXRpb25fdGhyZWFkcz0lbGRcbiIsDQo+IA0K
PiANCj4gLS0NCj4gQ2hlZXJzDQo+IA0KPiBEYXZpZCAvIGRoaWxkZW5iDQoNCg==

