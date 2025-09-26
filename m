Return-Path: <linux-kernel+bounces-834004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE7BA3950
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E49624B72
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AF02ECD01;
	Fri, 26 Sep 2025 12:10:29 +0000 (UTC)
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19D886353
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888629; cv=none; b=ktfxIW3o1ss8pNeP+62k3hokTvHdkpln3DGmh7sC8EJKsPfAVrWTnWoTYBHIwbyadvPCHBsnYZkCy1nFyy96PYMBemG3U/a7qU7z8HUD+VxswldK7mhBPIqxzTD1bQ3EJ25BGxzZl7BstqusQtpWrziM0usnwJ1lVtP8YzMB0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888629; c=relaxed/simple;
	bh=BVLbxPt7UA6zDsZAZUHzAAB7IjmbYFTZ7/ayGtlWR3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ju9ciUjWaDBiyVAiznPlw2TeLSY+Qz2eQ6NqV7EhM46JY+8VGvuOY2eEdAe5tfRaq9S0xKl6DcCekMR5H4coDvjurCRag39mTpmCQTVZNlHyXce2Mzc2Bn/kAuKkSn6b09fX8NpmsGYAo4mORs3m0A+y81ZUGV6fcwKdUAl2L0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4cY8Xm1sRjz1YQrFZ;
	Fri, 26 Sep 2025 20:10:00 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4cY8Xm15FDz1YQrFZ;
	Fri, 26 Sep 2025 20:10:00 +0800 (CST)
Received: from cncheex06.Hygon.cn (unknown [172.23.18.116])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 34F811663;
	Fri, 26 Sep 2025 20:09:51 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex06.Hygon.cn
 (172.23.18.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Fri, 26 Sep
 2025 19:59:58 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.027; Fri, 26 Sep 2025 19:59:58 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, Rik van Riel
	<riel@surriel.com>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "bsegall@google.com"
	<bsegall@google.com>, "mgorman@suse.de" <mgorman@suse.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jianyong.wu@outlook.com"
	<jianyong.wu@outlook.com>
Subject: RE: [PATCH] sched/fair: Correct misleading comment in
 task_numa_migrate()
Thread-Topic: [PATCH] sched/fair: Correct misleading comment in
 task_numa_migrate()
Thread-Index: AQHcIIkbJJ30QoC5akm5HS0ZfG9NlrSI80qAgBx/ObA=
Date: Fri, 26 Sep 2025 11:59:58 +0000
Message-ID: <8c88ffd5e9de4a4cb56068c506e0cdbf@hygon.cn>
References: <20250908061923.543081-1-wujianyong@hygon.cn>
 <46380ec48c4d2e2d01a229650129066bb3d6c329.camel@surriel.com>
In-Reply-To: <46380ec48c4d2e2d01a229650129066bb3d6c329.camel@surriel.com>
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

SGkgUGV0ZXIsIFJpaywgYW5kIG1haW50YWluZXJzLA0KDQpHZW50bGUgcGluZyBvbiB0aGlzIHNt
YWxsIGNvbW1lbnQgZml4IHBhdGNoLg0KDQpJdCB3YXMgcmV2aWV3ZWQgYnkgUmlrIGFib3V0IDMg
d2Vla3MgYWdvIGFuZCBnb3QgYSAiIFJldmlld2VkLWJ5IiBbMV0uIFNpbmNlIHRoZW4gdGhlcmUg
aGFzIGJlZW4gbm8gZnVydGhlciBjb21tZW50cy4gSSBqdXN0IHdvbmRlciBpZiB0aGVyZSBhcmUg
YW55IG90aGVyIGNvbmNlcm5zIG9yIGlmIGl0IGlzIHJlYWR5IHRvIGJlIHBpY2tlZCB1cC4NCg0K
VGhlIG9yaWdpbmFsIHBhdGNoIGlzIGhlcmU6DQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMjUwOTA4MDYxOTIzLjU0MzA4MS0xLXd1amlhbnlvbmdAaHlnb24uY24vDQoNClRo
YW5rcyBmb3IgeW91ciB0aW1lLg0KDQpCZXN0IHJlZ2FyZHMsDQpKaWFueW9uZyBXdQ0KDQpKaWFu
eW9uZyBXdT4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmlrIHZhbiBSaWVs
IDxyaWVsQHN1cnJpZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgOSwgMjAyNSAx
MjoyNiBBTQ0KPiBUbzogSmlhbnlvbmcgV3UgPHd1amlhbnlvbmdAaHlnb24uY24+OyBtaW5nb0By
ZWRoYXQuY29tOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsganVyaS5sZWxsaUByZWRoYXQuY29t
OyB2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZzsNCj4gamlhbnlvbmcud3VAb3V0bG9vay5jb20N
Cj4gQ2M6IGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbTsgcm9zdGVkdEBnb29kbWlzLm9yZzsgYnNl
Z2FsbEBnb29nbGUuY29tOw0KPiBtZ29ybWFuQHN1c2UuZGU7IHZzY2huZWlkQHJlZGhhdC5jb207
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc2No
ZWQvZmFpcjogQ29ycmVjdCBtaXNsZWFkaW5nIGNvbW1lbnQgaW4NCj4gdGFza19udW1hX21pZ3Jh
dGUoKQ0KPiANCj4gT24gTW9uLCAyMDI1LTA5LTA4IGF0IDE0OjE5ICswODAwLCBKaWFueW9uZyBX
dSB3cm90ZToNCj4gPiBUaGUgY3VycmVudCBjb21tZW50IGltcGxpZXMgdGhhdCBib3RoIHRoZSB0
YXNrIGFuZCB0aGUgZ3JvdXAgbXVzdCBnZXQNCj4gPiBiZW5lZml0IGZvciBhIG5vZGUgdG8gYmUg
Y29uc2lkZXJlZC4gSG93ZXZlciwgdGhlIGFjdHVhbCBjb2RlIGFsbG93cyBhDQo+ID4gbm9kZSB0
byBwYXNzIGlmICplaXRoZXIqIHRoZSB0YXNrICpvciogdGhlIGdyb3VwIG1lZXRzIHRoZSBjcml0
ZXJpYS4NCj4gPg0KPiA+IEFzIGVzdGFibGlzaGVkIGluIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9u
IFsxXSwgdGhlIGNvZGUgbG9naWMgaXMNCj4gPiBjb3JyZWN0Lg0KPiA+IFVwZGF0ZSB0aGUgY29t
bWVudCB0byBhY2N1cmF0ZWx5IHJlZmxlY3QgdGhhdCBlaXRoZXIgY29uZGl0aW9uIGlzDQo+ID4g
c3VmZmljaWVudC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYW55b25nIFd1IDx3dWppYW55
b25nQGh5Z29uLmNuPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFJpayB2YW4gUmllbCA8cmllbEBzdXJy
aWVsLmNvbT4NCj4gDQo+IC0tDQo+IEFsbCBSaWdodHMgUmV2ZXJzZWQuDQoNCg==


