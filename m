Return-Path: <linux-kernel+bounces-824507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B789B896DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF08D1CC02B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5163101D9;
	Fri, 19 Sep 2025 12:22:44 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B394273810
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284563; cv=none; b=c9Q8MmzBdZHnSglXXCEeJ+gPYXfoj8TzrXNn4oIegeuWWwhwO5UG7+AjITif/hg/KftCXDo6N5h+IzDj+VxqauB1si4fEluvCC26ixmaV4/eAM5PFjYnbFUCtHbXpFPrSMgleHjwnMnLMdQyWzdbhKt9sROgKye7mwoFnYVCjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284563; c=relaxed/simple;
	bh=Rh5eguMgQOHmoTyzXzSs7aogeMT2P2/J0VUeUvWxnZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R7KRgGn70yd72rHEVX7C5o8IoHiPdmYJZeBJLkrOethVyEqh11a4CgUCDQpuRQ8JzPL7DJ/yA5L5uwvcoM6blxfgn13bHdLoXk5a+SYJHBM0zpaRskMXuWTqmN1lNkh22qGZ2szkg+RpfhzdSkeV3F3tMlvT6Mo3nB3W/4ebKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03046.xfusion.com (unknown [10.32.128.186])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4cSrlQ0P8KzB8y5J;
	Fri, 19 Sep 2025 20:04:18 +0800 (CST)
Received: from wuxpheds03048.xfusion.com (10.32.143.30) by
 wuxpheds03046.xfusion.com (10.32.128.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.26;
 Fri, 19 Sep 2025 20:05:39 +0800
Received: from wuxpheds03048.xfusion.com ([fe80::36b8:d40d:4624:ad84]) by
 wuxpheds03048.xfusion.com ([fe80::36b8:d40d:4624:ad84%12]) with mapi id
 15.02.2562.020; Fri, 19 Sep 2025 20:05:38 +0800
From: shechenglong <shechenglong@xfusion.com>
To: Catalin Marinas <catalin.marinas@arm.com>
CC: "will@kernel.org" <will@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, xulei <stone.xulei@xfusion.com>, chenjialong
	<chenjialong@xfusion.com>, yuxiating <yuxiating@xfusion.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGNwdTogZml4IGhhcmQgbG9ja3VwIHRyaWdnZXJl?=
 =?utf-8?Q?d_during_stress-ng_stress_testing.?=
Thread-Topic: [PATCH] cpu: fix hard lockup triggered during stress-ng stress
 testing.
Thread-Index: AQHcKGhasfpFyT4DM0G5RpWWNk3BFbSYR6yAgAIiPGA=
Date: Fri, 19 Sep 2025 12:05:38 +0000
Message-ID: <2eeb109f50b34e628327972d1af57f5d@xfusion.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
 <aMvsxd8nHb5roC0o@arm.com>
In-Reply-To: <aMvsxd8nHb5roC0o@arm.com>
Accept-Language: en-US
Content-Language: zh-CN
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

T2theSwgdW5kZXJzdG9vZC4gVGhhbmsgeW91ISBNYXkgSSBhc2sgd2hlbiB0aGUgZml4L3BhdGNo
IGlzIGV4cGVjdGVkIHRvIGJlIGF2YWlsYWJsZT8NCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K
5Y+R5Lu25Lq6OiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPiANCuWP
kemAgeaXtumXtDogMjAyNeW5tDnmnIgxOOaXpSAxOToyOA0K5pS25Lu25Lq6OiBzaGVjaGVuZ2xv
bmcgPHNoZWNoZW5nbG9uZ0B4ZnVzaW9uLmNvbT4NCuaKhOmAgTogd2lsbEBrZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IHh1bGVpIDxzdG9uZS54dWxlaUB4ZnVzaW9uLmNvbT47IGNoZW5qaWFsb25nIDxj
aGVuamlhbG9uZ0B4ZnVzaW9uLmNvbT47IHl1eGlhdGluZyA8eXV4aWF0aW5nQHhmdXNpb24uY29t
Pg0K5Li76aKYOiBSZTogW1BBVENIXSBjcHU6IGZpeCBoYXJkIGxvY2t1cCB0cmlnZ2VyZWQgZHVy
aW5nIHN0cmVzcy1uZyBzdHJlc3MgdGVzdGluZy4NCg0KT24gVGh1LCBTZXAgMTgsIDIwMjUgYXQg
MDI6NDk6MDdQTSArMDgwMCwgc2hlY2hlbmdsb25nIHdyb3RlOg0KPiBDb250ZXh0IG9mIHRoZSBJ
c3N1ZToNCj4gSW4gYW4gQVJNNjQgZW52aXJvbm1lbnQsIHRoZSBmb2xsb3dpbmcgc3RlcHMgd2Vy
ZSBwZXJmb3JtZWQ6DQo+IA0KPiAxLiBSZXBlYXRlZGx5IHJhbiBzdHJlc3MtbmcgdG8gc3RyZXNz
IHRoZSBDUFUsIG1lbW9yeSwgYW5kIEkvTy4NCj4gMi4gQ3ljbGljYWxseSBleGVjdXRlZCB0ZXN0
IGNhc2UgcHR5MDYgZnJvbSB0aGUgTFRQIHRlc3Qgc3VpdGUuDQo+IDMuIEFkZGVkIG1pdGlnYXRp
b25zPW9mZiB0byB0aGUgR1JVQiBwYXJhbWV0ZXJzLg0KPiANCj4gQWZ0ZXIgMeKAkzIgaG91cnMg
b2Ygc3RyZXNzIHRlc3RpbmcsIGEgaGFyZGxvY2t1cCBvY2N1cnJlZCwgY2F1c2luZyBhIA0KPiBz
eXN0ZW0gY3Jhc2guDQo+IA0KPiBSb290IENhdXNlIG9mIHRoZSBIYXJkbG9ja3VwOg0KPiBFYWNo
IHRpbWUgc3RyZXNzLW5nIHN0YXJ0cywgaXQgaW52b2tlcyB0aGUgDQo+IC9zeXMva2VybmVsL2Rl
YnVnL2NsZWFyX3dhcm5fb25jZSBpbnRlcmZhY2UsIHdoaWNoIGNsZWFycyB0aGUgdmFsdWVzIA0K
PiBpbiB0aGUgbWVtb3J5IHNlY3Rpb24gZnJvbSBfX3N0YXJ0X29uY2UgdG8gX19lbmRfb25jZS4g
VGhpcyBjYXVzZWQgDQo+IGZ1bmN0aW9ucyBsaWtlIHByX2luZm9fb25jZSgpIOKAlCBvcmlnaW5h
bGx5IGRlc2lnbmVkIHRvIHByaW50IG9ubHkgb25jZSDigJQgdG8gcHJpbnQgYWdhaW4gZXZlcnkg
dGltZSBzdHJlc3Mtbmcgd2FzIGNhbGxlZC4NCj4gSWYgdGhlIHB0eTA2IHRlc3QgY2FzZSBoYXBw
ZW5lZCB0byBiZSB1c2luZyB0aGUgc2VyaWFsIG1vZHVsZSBhdCB0aGF0IA0KPiBzYW1lIG1vbWVu
dCwgaXQgd291bGQgc2xlZXAgaW4gd2FpdGVyLmxpc3Qgd2l0aGluIHRoZSBfX2Rvd25fY29tbW9u
IGZ1bmN0aW9uLg0KPiANCj4gQWZ0ZXIgcHJfaW5mb19vbmNlKCkgY29tcGxldGVkIGl0cyBvdXRw
dXQgdXNpbmcgdGhlIHNlcmlhbCBtb2R1bGUsIGl0IA0KPiBpbnZva2VkIHRoZSBzZW1hcGhvcmUg
dXAoKSBmdW5jdGlvbiB0byB3YWtlIHVwIHRoZSBwcm9jZXNzIHdhaXRpbmcgaW4gDQo+IHdhaXRl
ci5saXN0LiBUaGlzIHNlcXVlbmNlIHRyaWdnZXJlZCBhbiBBLUEgZGVhZGxvY2ssIHVsdGltYXRl
bHkgDQo+IGxlYWRpbmcgdG8gYSBoYXJkbG9ja3VwIGFuZCBzeXN0ZW0gY3Jhc2guDQo+IA0KPiBU
byBwcmV2ZW50IHRoaXMsIGEgbG9jYWwgdmFyaWFibGUgc2hvdWxkIGJlIHVzZWQgdG8gY29udHJv
bCBhbmQgZW5zdXJlIA0KPiB0aGUgcHJpbnQgb3BlcmF0aW9uIG9jY3VycyBvbmx5IG9uY2UuDQo+
IA0KPiBIYXJkIGxvY2t1cCBjYWxsIHN0YWNrOg0KPiANCj4gX3Jhd19zcGluX2xvY2tfbmVzdGVk
KzE2OA0KPiB0dHd1X3F1ZXVlKzE4MCDvvIhycV9sb2NrKHJxLCAmcmYpOyAybmQgYWNxdWlyaW5n
IHRoZSBycS0+X19sb2Nr77yJDQo+IHRyeV90b193YWtlX3VwKzU0OA0KPiB3YWtlX3VwX3Byb2Nl
c3MrMzINCj4gX191cCs4OA0KPiB1cCsxMDANCj4gX191cF9jb25zb2xlX3NlbSs5Ng0KPiBjb25z
b2xlX3VubG9jays2OTYNCj4gdnByaW50a19lbWl0KzQyOA0KPiB2cHJpbnRrX2RlZmF1bHQrNjQN
Cj4gdnByaW50a19mdW5jKzIyMA0KPiBwcmludGsrMTA0DQo+IHNwZWN0cmVfdjRfZW5hYmxlX3Rh
c2tfbWl0aWdhdGlvbiszNDQNCj4gX19zd2l0Y2hfdG8rMTAwDQo+IF9fc2NoZWR1bGUrMTAyOCAo
cnFfbG9jayhycSwgJnJmKTsgMXN0IGFjcXVpcmluZyB0aGUgcnEtPl9fbG9jaykNCj4gc2NoZWR1
bGVfaWRsZSs0OA0KPiBkb19pZGxlKzM4OA0KPiBjcHVfc3RhcnR1cF9lbnRyeSs0NA0KPiBzZWNv
bmRhcnlfc3RhcnRfa2VybmVsKzM1Mg0KDQpJcyB0aGUgcHJvYmxlbSBhY3R1YWxseSB0aGF0IHdl
IGNhbGwgdGhlIHNwZWN0cmUgdjQgc3R1ZmYgb24gdGhlDQpzd2l0Y2hfdG8oKSBwYXRoICh3ZSBj
YW4ndCBjaGFuZ2UgdGhpcykgdW5kZXIgdGhlIHJxX2xvY2soKSBhbmQgaXQgc3Vic2VxdWVudGx5
IGNhbGxzIHByaW50aygpIHdoaWNoIHRha2VzIHRoZSBjb25zb2xlIHNlbWFwaG9yZT8gSSB0aGlu
ayB0aGUgIm9uY2UiIGFzcGVjdCBtYWtlcyBpdCBsZXNzIGxpa2VseSBidXQgZG9lcyBub3QgYWRk
cmVzcyB0aGUgYWN0dWFsIHByb2JsZW0uDQoNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2Vy
bmVsL3Byb3Rvbi1wYWNrLmMgDQo+IGIvYXJjaC9hcm02NC9rZXJuZWwvcHJvdG9uLXBhY2suYyBp
bmRleCBlZGYxNzgzZmZjODEuLmY4NjYzMTU3ZTA0MSANCj4gMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtNjQva2VybmVsL3Byb3Rvbi1wYWNrLmMNCj4gKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvcHJv
dG9uLXBhY2suYw0KPiBAQCAtNDI0LDggKzQyNCwxMCBAQCBzdGF0aWMgYm9vbCBzcGVjdHJlX3Y0
X21pdGlnYXRpb25zX29mZih2b2lkKQ0KPiAgCWJvb2wgcmV0ID0gY3B1X21pdGlnYXRpb25zX29m
ZigpIHx8DQo+ICAJCSAgIF9fc3BlY3RyZV92NF9wb2xpY3kgPT0gU1BFQ1RSRV9WNF9QT0xJQ1lf
TUlUSUdBVElPTl9ESVNBQkxFRDsNCj4gIA0KPiAtCWlmIChyZXQpDQo+IC0JCXByX2luZm9fb25j
ZSgic3BlY3RyZS12NCBtaXRpZ2F0aW9uIGRpc2FibGVkIGJ5IGNvbW1hbmQtbGluZSBvcHRpb25c
biIpOw0KPiArCXN0YXRpYyBhdG9taWNfdCBfX3ByaW50a19vbmNlID0gQVRPTUlDX0lOSVQoMCk7
DQo+ICsNCj4gKwlpZiAocmV0ICYmICFhdG9taWNfY21weGNoZygmX19wcmludGtfb25jZSwgMCwg
MSkpDQo+ICsJCXByX2luZm8oInNwZWN0cmUtdjQgbWl0aWdhdGlvbiBkaXNhYmxlZCBieSBjb21t
YW5kLWxpbmUgb3B0aW9uXG4iKTsNCj4gIA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQoNCkkgdGhp
bmsgd2Ugc2hvdWxkIGp1c3QgYXZvaWQgdGhlIHByaW50aygpIG9uIHRoZQ0Kc3BlY3RyZV92NF9l
bmFibGVfdGFza19taXRpZ2F0aW9uKCkgcGF0aC4gV2VsbCwgSSdkIHJlbW92ZSBpdCBhbHRvZ2V0
aGVyIGZyb20gdGhlIHNwZWN0cmVfdjRfbWl0aWdhdGlvbnNfb2ZmKCkgYXMgaXQncyBjYWxsZWQg
b24ga2VybmVsIGVudHJ5IGFzIHdlbGwuIEp1c3QgYWRkIGEgZGlmZmVyZW50IHdheSB0byBwcmlu
dCB0aGUgc3RhdHVzIGR1cmluZyBrZXJuZWwgYm9vdCBpZiB0aGVyZSBpc24ndCBvbmUgYWxyZWFk
eSwgbWF5YmUgYW4gaW5pdGNhbGwuDQoNCi0tDQpDYXRhbGluDQo=

