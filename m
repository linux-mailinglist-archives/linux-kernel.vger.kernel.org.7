Return-Path: <linux-kernel+bounces-801913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0745FB44B86
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742125A1050
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD221F239B;
	Fri,  5 Sep 2025 02:15:02 +0000 (UTC)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B2C13FD86
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038502; cv=none; b=M4Vz/wmul0DnFuIA7BK4Z0hPTPfedDQXgWQtskOF8Atj9rtxbWBiToV+iu9lw0WLlsY4VP7KRKOuyLxFcq8MMzhp6cfVARQqqQtSq0q751yL21j00qEngEGa2VbWHwtBZfq8r0+LWrxwqcdmCwBkhL3HqBjE1eSqDykk+BdGt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038502; c=relaxed/simple;
	bh=CgvvXNBKSy9vJSEOZhE1RDNMzq3ddYjwrkwKTEeUoVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VM6I0oIscaGUTS9EugaSWTs76XUNWE4L/QA5qrGGNsj/KAK3G8A4oosNFtSPjpAIyndd8Co5x/89SVEEun218Jv8z/6iU53SUUYkpMxjtjTiMbs5P8Q9DJk6oqOtj/xwYJMbiYnSR3Wy+0p07vXsoEV1Ef4mFZ7sEwxhoYQlMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4cJ0KP3k3lzv0Qk;
	Fri,  5 Sep 2025 10:14:33 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4cJ0KL3s5Yzv0Qk;
	Fri,  5 Sep 2025 10:14:30 +0800 (CST)
Received: from cncheex03.Hygon.cn (unknown [172.23.18.113])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 4FA2016EF;
	Fri,  5 Sep 2025 10:14:22 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex03.Hygon.cn
 (172.23.18.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Fri, 5 Sep
 2025 10:14:30 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.027; Fri, 5 Sep 2025 10:14:30 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: Ethan Zhao <etzhao1900@gmail.com>
CC: "jianyong.wu@outlook.com" <jianyong.wu@outlook.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched/fair: fix task_numa_migrate to consider both task
 and group benefits
Thread-Topic: [PATCH] sched/fair: fix task_numa_migrate to consider both task
 and group benefits
Thread-Index: AQHcGMNAFjJ8dCQKsE683vCAPm0CKbSDTL0AgACVzsA=
Date: Fri, 5 Sep 2025 02:14:30 +0000
Message-ID: <4c57fcd55047412b9752aeba79f86dec@hygon.cn>
References: <20250829085529.15686-1-wujianyong@hygon.cn>
 <72d087b8-1af1-44a6-88c4-04a9ff98f660@gmail.com>
In-Reply-To: <72d087b8-1af1-44a6-88c4-04a9ff98f660@gmail.com>
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

SGVsbG8gRXRoYW4sDQoNClRoYW5rcyBmb3IgcmVwbHkuDQoNClRoZXJlIGlzIGluY29uc2lzdGVu
Y3kgYmV0d2VlbiB0aGUgY29tbWVudHMgYW5kIHRoZSBjb2RlLiBTZWUgdGhlIGRpc2N1c3Npb24g
aW4gYW4gb2xkZXIgcGF0Y2ggaGVyZSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNS82LzE2LzU0
MA0KDQpGb2xsb3dpbmcgdGhhdCwgdGhlIGlzc3VlIGlzIHdpdGggdGhlIGNvbW1lbnRzLCBub3Qg
dGhlIGNvZGUuDQoNCkJlc3RzDQpKaWFueW9uZyANCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBFdGhhbiBaaGFvIDxldHpoYW8xOTAwQGdtYWlsLmNvbT4NCj4gU2VudDog
RnJpZGF5LCBTZXB0ZW1iZXIgNSwgMjAyNSA5OjEzIEFNDQo+IFRvOiBKaWFueW9uZyBXdSA8d3Vq
aWFueW9uZ0BoeWdvbi5jbj4NCj4gQ2M6IGppYW55b25nLnd1QG91dGxvb2suY29tOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNjaGVkL2ZhaXI6
IGZpeCB0YXNrX251bWFfbWlncmF0ZSB0byBjb25zaWRlciBib3RoIHRhc2sNCj4gYW5kIGdyb3Vw
IGJlbmVmaXRzDQo+IA0KPiANCj4gDQo+IE9uIDgvMjkvMjAyNSA0OjU1IFBNLCBKaWFueW9uZyBX
dSB3cm90ZToNCj4gPiBUaGUgY29tbWVudCBpbmRpY2F0ZXMgdGhhdCB3aGVuIHNlYXJjaGluZyBm
b3IgYSBzdWl0YWJsZSBOVU1BIG5vZGUsIHdlDQo+ID4gc2hvdWxkIGVuc3VyZSB0aGF0IHRoZSBz
ZWxlY3RlZCBub2RlIGJlbmVmaXRzIGJvdGggdGhlIHRhc2sgYW5kIGl0cw0KPiA+IE5VTUEgZ3Jv
dXAuIEhvd2V2ZXIsIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGNhbiBvbmx5IGd1YXJhbnRl
ZQ0KPiA+IHRoYXQgZWl0aGVyIHRoZSB0YXNrIG9yIHRoZSBncm91cCBiZW5lZml0cywgYnV0IG5v
dCBuZWNlc3NhcmlseSBib3RoLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbnlvbmcgV3Ug
PHd1amlhbnlvbmdAaHlnb24uY24+DQo+ID4gLS0tDQo+ID4gICBrZXJuZWwvc2NoZWQvZmFpci5j
IHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9z
Y2hlZC9mYWlyLmMgaW5kZXgNCj4gPiBiMTczYTA1OTMxNWMuLjU4Yzg5OTczODM5OSAxMDA2NDQN
Cj4gPiAtLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5jDQo+ID4gKysrIGIva2VybmVsL3NjaGVkL2Zh
aXIuYw0KPiA+IEBAIC0yNTY4LDcgKzI1NjgsNyBAQCBzdGF0aWMgaW50IHRhc2tfbnVtYV9taWdy
YXRlKHN0cnVjdCB0YXNrX3N0cnVjdA0KPiAqcCkNCj4gPiAgIAkJCS8qIE9ubHkgY29uc2lkZXIg
bm9kZXMgd2hlcmUgYm90aCB0YXNrIGFuZCBncm91cHMgYmVuZWZpdA0KPiAqLw0KPiA+ICAgCQkJ
dGFza2ltcCA9IHRhc2tfd2VpZ2h0KHAsIG5pZCwgZGlzdCkgLSB0YXNrd2VpZ2h0Ow0KPiA+ICAg
CQkJZ3JvdXBpbXAgPSBncm91cF93ZWlnaHQocCwgbmlkLCBkaXN0KSAtIGdyb3Vwd2VpZ2h0Ow0K
PiA+IC0JCQlpZiAodGFza2ltcCA8IDAgJiYgZ3JvdXBpbXAgPCAwKQ0KPiA+ICsJCQlpZiAodGFz
a2ltcCA8IDAgfHwgZ3JvdXBpbXAgPCAwKQ0KPiBQZXJoYXBzIHlvdSBtaXN1bmRlcnN0YW5kIHRo
ZSBjb21tZW50LCAmJiBtZWFucyBlaXRoZXIgdGhlIHRhc2sgb3IgdGhlDQo+IGdyb3VwIGhhcyBO
TyBiZW5lZml0IGZyb20gdGhpcyBtaWdyYXRpb24sIGl0IHdvdWxkbid0IGJlIGRvbmUuDQo+IEJ1
dCBpZiB5b3UgcmVwbGFjZSBpdCB3aXRoIHx8LCB5b3Ugd2lsbCBpZ25vcmUgdGhlIHRhcmdldCBu
b2RlIHRoYXQgY291bGQgYmVuZWZpdA0KPiBlaXRoZXIgdGhlIHRhc2sgb3IgdGhlIGdyb3VwLg0K
PiANCj4gVGhlcmUgaXMgbW9yZSBsb2dpYyB0byBjb25zaWRlciB0aGUgYmVuZWZpdCBmb3IgYm90
aCB0YXNrICYgZ3JvdXAgaW4gdGhlIGxhdGVyDQo+IGZ1bmN0aW9uIHBhcnQuDQo+IA0KPiBPbmUg
cXVlc3Rpb24sIHdoeSBub3QNCj4gaWYgKHRhc2tpbXAgPD0gMCAmJiBncm91cGltcCA8PSAwKSA/
DQo+IA0KPiBUaGFua3MsDQo+IEV0aGFuDQo+ID4gICAJCQkJY29udGludWU7DQo+ID4NCj4gPiAg
IAkJCWVudi5kaXN0ID0gZGlzdDsNCj4gDQoNCg==


