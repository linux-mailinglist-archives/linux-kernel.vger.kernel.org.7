Return-Path: <linux-kernel+bounces-720657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DA3AFBED2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482B77A315D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2B228BA9B;
	Mon,  7 Jul 2025 23:59:12 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF227713
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932752; cv=none; b=n/kmHVfXL/x52lfE2EP1/p8g85t1FYIKgyAdmGEcwY1ogxyVf2KTO6hX1w9gTq55uJ1olDdNotdm2taXOkqhWHWiAUwYXjn1cFMSSWGzIAltsa7we+U9M5ZoDcc0CAwAgutJWPypNKKlI2mdQi/RaYB2MJ96/XBKcb7/if19jEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932752; c=relaxed/simple;
	bh=DikT8ktGhIfeAaNBuhv0F2upOtkYIobxqYTOCV+abks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A9Yt+Gkv6A4Tw2k3rUw1QbNfJRmNBdSXtMuxpXRQUMcHrqwghF87TcZzaFGmxeWcXzSA1CYiXpHjup2L9fndEp4E1PmGygCI6AG3a4OBcIiLzgsHpDsfvQtIM9GzVq4k4W/8VKrCv9N+ZGlWsX2Q+Du4KlITzaBpJMH1GWGUsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	David Laight <david.laight.linux@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "bsegall@google.com" <bsegall@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBkaXZpZGUgZXJyb3IgaW4geDg2IGFuZCBjcHV0?=
 =?gb2312?Q?ime?=
Thread-Topic: [????] Re: divide error in x86 and cputime
Thread-Index: AdvvFOeRwP1XMiJ8Sh6ojy4vzov+4AAM96oAAAC7wQAAEo0PUA==
Date: Mon, 7 Jul 2025 23:41:14 +0000
Message-ID: <2ef88def90634827bac1874d90e0e329@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
 <20250707220937.GA15787@redhat.com> <20250707223038.GB15787@redhat.com>
In-Reply-To: <20250707223038.GB15787@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.18
X-FE-Policy-ID: 52:10:53:SYSTEM

DQoNCj4gT24gYSBzZWNvbmQgdGhvdWdodCwgdGhpcw0KPiANCj4gICAgIG11bF91NjRfdTY0X2Rp
dl91NjQoMHg2OWY5OGRhOWJhOTgwYzAwLCAweGZmZmQyMTNhYWJkNzQ2MjYsDQo+IDB4MDllMDA5
MDApOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzdGltZSAgICAgICAgICAgICAgIHJ0aW1l
DQo+IHN0aW1lICsgdXRpbWUNCj4gDQo+IGxvb2tzIHN1c3BpY2lvdXM6DQo+IA0KPiAJLSBzdGlt
ZSA+IHN0aW1lICsgdXRpbWUNCj4gDQo+IAktIHJ0aW1lID0gMHhmZmZkMjEzYWFiZDc0NjI2IGlz
IGFic3VyZGx5IGh1Z2UNCj4gDQo+IHNvIHBlcmhhcHMgdGhlcmUgaXMgYW5vdGhlciBwcm9ibGVt
Pw0KPiANCg0KaXQgaGFwcGVuZWQgd2hlbiBhIHByb2Nlc3Mgd2l0aCAyMzYgYnVzeSBwb2xsaW5n
IHRocmVhZHMgLCBydW4gYWJvdXQgOTA0IGRheXMsIHRoZSB0b3RhbCB0aW1lIHdpbGwgb3ZlcmZs
b3cgdGhlIDY0Yml0DQoNCm5vbi14ODYgc3lzdGVtIG1heWJlIGhhcyBzYW1lIGlzc3VlLCBvbmNl
IChzdGltZSArIHV0aW1lKSBvdmVyZmxvd3MgNjRiaXQsIG11bF91NjRfdTY0X2Rpdl91NjQgZnJv
bSBsaWIvbWF0aC9kaXY2NC5jIG1heWJlIGNhdXNlIGRpdmlzaW9uIGJ5IDANCg0Kc28gdG8gY3B1
dGltZSwgY291bGQgY3B1dGltZV9hZGp1c3QoKSByZXR1cm4gc3RpbWUgaWYgc3RpbWUgaWYgc3Rp
bWUgKyB1dGltZSBpcyBvdmVyZmxvdw0KDQpkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2NwdXRp
bWUuYyBiL2tlcm5lbC9zY2hlZC9jcHV0aW1lLmMNCmluZGV4IDZkYWI0ODU0Li5kYjBjMjczIDEw
MDY0NA0KLS0tIGEva2VybmVsL3NjaGVkL2NwdXRpbWUuYw0KKysrIGIva2VybmVsL3NjaGVkL2Nw
dXRpbWUuYw0KQEAgLTU3OSw2ICs1NzksMTAgQEAgdm9pZCBjcHV0aW1lX2FkanVzdChzdHJ1Y3Qg
dGFza19jcHV0aW1lICpjdXJyLCBzdHJ1Y3QgcHJldl9jcHV0aW1lICpwcmV2LA0KICAgICAgICAg
ICAgICAgIGdvdG8gdXBkYXRlOw0KICAgICAgICB9DQoNCisgICAgICAgaWYgKHN0aW1lID4gKHN0
aW1lICsgdXRpbWUpKSB7DQorICAgICAgICAgICAgICAgZ290byB1cGRhdGU7DQorICAgICAgIH0N
CisNCiAgICAgICAgc3RpbWUgPSBtdWxfdTY0X3U2NF9kaXZfdTY0KHN0aW1lLCBydGltZSwgc3Rp
bWUgKyB1dGltZSk7DQogICAgICAgIC8qDQogICAgICAgICAqIEJlY2F1c2UgbXVsX3U2NF91NjRf
ZGl2X3U2NCgpIGNhbiBhcHByb3hpbWF0ZSBvbiBzb21lDQoNCg0KVGhhbmtzDQoNCi1MaQ0KDQoN
Cj4gT2xlZy4NCj4gDQo+IE9uIDA3LzA4LCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0KPiA+DQo+ID4g
T24gMDcvMDcsIExpLFJvbmdxaW5nIHdyb3RlOg0KPiA+ID4NCj4gPiA+IFs3ODI1MDgxNS43MDM4
NDddIGRpdmlkZSBlcnJvcjogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJDQo+ID4NCj4gPiAu
Li4NCj4gPg0KPiA+ID4gSXQgY2F1c2VkIGJ5IGEgcHJvY2VzcyB3aXRoIG1hbnkgdGhyZWFkcyBy
dW5uaW5nIHZlcnkgbG9uZywgYW5kDQo+ID4gPiB1dGltZStzdGltZSBvdmVyZmxvd2VkIDY0Yml0
LCB0aGVuIGNhdXNlIHRoZSBiZWxvdyBkaXYNCj4gPiA+DQo+ID4gPiBtdWxfdTY0X3U2NF9kaXZf
dTY0KDB4NjlmOThkYTliYTk4MGMwMCwgMHhmZmZkMjEzYWFiZDc0NjI2LA0KPiA+ID4gMHgwOWUw
MDkwMCk7DQo+ID4gPg0KPiA+ID4gSSBzZWUgdGhlIGNvbW1lbnRzIG9mIG11bF91NjRfdTY0X2Rp
dl91NjQoKSBzYXk6DQo+ID4gPg0KPiA+ID4gV2lsbCBnZW5lcmF0ZSBhbiAjREUgd2hlbiB0aGUg
cmVzdWx0IGRvZXNuJ3QgZml0IHU2NCwgY291bGQgZml4IHdpdGgNCj4gPiA+IGFuIF9fZXhfdGFi
bGVbXSBlbnRyeSB3aGVuIGl0IGJlY29tZXMgYW4gaXNzdQ0KPiA+ID4NCj4gPiA+IFNlZW0gX19l
eF90YWJsZVtdIGVudHJ5IGZvciBkaXYgZG9lcyBub3Qgd29yayA/DQo+ID4NCj4gPiBXZWxsLCB0
aGUgY3VycmVudCB2ZXJzaW9uIGRvZXNuJ3QgaGF2ZSBhbiBfX2V4X3RhYmxlW10gZW50cnkgZm9y
IGRpdi4uLg0KPiA+DQo+ID4gSSBkbyBub3Qga25vdyB3aGF0IGNhbi9zaG91bGQgd2UgZG8gaW4g
dGhpcyBjYXNlLi4uIFBlcmhhcHMNCj4gPg0KPiA+IAlzdGF0aWMgaW5saW5lIHU2NCBtdWxfdTY0
X3U2NF9kaXZfdTY0KHU2NCBhLCB1NjQgbXVsLCB1NjQgZGl2KQ0KPiA+IAl7DQo+ID4gCQlpbnQg
b2sgPSAwOw0KPiA+IAkJdTY0IHE7DQo+ID4NCj4gPiAJCWFzbSAoIm11bHEgJTM7IDE6IGRpdnEg
JTQ7IG1vdmwgJDEsJTE7IDI6XG4iDQo+ID4gCQkJX0FTTV9FWFRBQkxFKDFiLCAyYikNCj4gPiAJ
CQk6ICI9YSIgKHEpLCAiK3IiIChvaykNCj4gPiAJCQk6ICJhIiAoYSksICJybSIgKG11bCksICJy
bSIgKGRpdikNCj4gPiAJCQk6ICJyZHgiKTsNCj4gPg0KPiA+IAkJcmV0dXJuIG9rID8gcSA6IC0x
dWw7DQo+ID4gCX0NCj4gPg0KPiA+ID8NCj4gPg0KPiA+IFNob3VsZCByZXR1cm4gVUxMT05HX01B
WCBvbiAjREUuDQo+ID4NCj4gPiBPbGVnLg0KDQo=

