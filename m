Return-Path: <linux-kernel+bounces-721444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D46AFC94B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F3F188D382
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9683C2D8DA2;
	Tue,  8 Jul 2025 11:14:32 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61350254AE4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973272; cv=none; b=mUIAhm2kZc3QwwsCy11bgy/7NeOy/shhEY0a9Xk5FS0LB+K7gI4G27owVzdSAhmC58n8nNlPAVOOCrxxmIiNykYI7k2/fS88Kg2UTx2/MZ3DwWi4cXVVu+SKVQdklM2XL6/tkOVSLL5wnxhJ1//Un78vlBYtnJNSPyUiyO4aqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973272; c=relaxed/simple;
	bh=lXiNGqFwdpPJC1umL5WjJ0PDhMeQPylD/4ZTTvck5CE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vut21F7xbN4+HRIe1ZRHUd3tyvNaxtpsFmjUcWPtVxlikbiKte3g0MQtNCoDy7A0z/9ub9afuffGOFdXrjrd3Qg9+GV8VLEdwP1pGJRFaVXu1TDeO1KZFCj755L8qLan/DpasVRyfJnt+a1y0hhf2HTbzmTmcQroSlWnBzEXPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: David Laight <david.laight.linux@gmail.com>, Steven Rostedt
	<rostedt@goodmis.org>
CC: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "bsegall@google.com" <bsegall@google.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbPz8/P10gUmU6IFs/Pz8/XSBSZTogZGl2aWRl?=
 =?gb2312?Q?_error_in_x86_and_cputime?=
Thread-Topic: [????] Re: [????] Re: [????] Re: divide error in x86 and cputime
Thread-Index: AQHb75zFK/FJTpEU3EWj+reAAU9eAbQm2c6AgACoyYCAAI7+EA==
Date: Tue, 8 Jul 2025 11:12:02 +0000
Message-ID: <2ebb70da82a047bfbbbdfae4e0e30e48@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>	<20250707223038.GB15787@redhat.com>
	<2ef88def90634827bac1874d90e0e329@baidu.com>
	<20250707195318.0c7f401d@gandalf.local.home>
	<92674f89641f466b9ebbdf7681614ed3@baidu.com>
	<20250707203057.1b2af73d@gandalf.local.home>
 <20250708113503.147336d0@pumpkin>
In-Reply-To: <20250708113503.147336d0@pumpkin>
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
X-FEAS-Client-IP: 172.31.50.42
X-FE-Policy-ID: 52:10:53:SYSTEM

PiA+IE9uIFR1ZSwgOCBKdWwgMjAyNSAwMDoxMDo1NCArMDAwMA0KPiA+ICJMaSxSb25ncWluZyIg
PGxpcm9uZ3FpbmdAYmFpZHUuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gPiAgICAgICAgIHN0aW1l
ID0gbXVsX3U2NF91NjRfZGl2X3U2NChzdGltZSwgcnRpbWUsIHN0aW1lICsgdXRpbWUpOw0KPiA+
ID4gPiArICAgICAgIC8qDQo+ID4gPiA+ICsgICAgICAgICogQmVjYXVzZSBtdWxfdTY0X3U2NF9k
aXZfdTY0KCkgY2FuIGFwcHJveGltYXRlIG9uIHNvbWUNCj4gPiA+ID4gKyAgICAgICAgKiBhY2hp
dGVjdHVyZXM7IGVuZm9yY2UgdGhlIGNvbnN0cmFpbnQgdGhhdDogYSpiLyhiK2MpIDw9IGEuDQo+
ID4gPiA+ICsgICAgICAgICovDQo+ID4gPiA+ICsgICAgICAgaWYgKHVubGlrZWx5KHN0aW1lID4g
cnRpbWUpKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgc3RpbWUgPSBydGltZTsNCj4gPiA+DQo+
ID4gPg0KPiA+ID4gTXkgNS4xMCBoYXMgbm90IHRoaXMgcGF0Y2ggIiBzY2hlZC9jcHV0aW1lOiBG
aXgNCj4gPiA+IG11bF91NjRfdTY0X2Rpdl91NjQoKSBwcmVjaXNpb24gZm9yIGNwdXRpbWUgIiwg
YnV0IEkgYW0gc3VyZSB0aGlzDQo+ID4gPiBwYXRjaCBjYW4gbm90IGZpeCB0aGlzIG92ZXJmbG93
IGlzc3VlLCBTaW5jZSBkaXZpc2lvbiBlcnJvciBoYXBwZW5lZA0KPiA+ID4gaW4gbXVsX3U2NF91
NjRfZGl2X3U2NCgpDQo+ID4NCj4gPiBIYXZlIHlvdSB0cmllZCBpdD8gT3IgYXJlIHlvdSBqdXN0
IG1ha2luZyBhbiBhc3N1bXB0aW9uPw0KPiA+DQo+ID4gSG93IGNhbiB5b3UgYmUgc28gc3VyZT8g
RGlkIHlvdSBldmVuICpsb29rKiBhdCB0aGUgY29tbWl0Pw0KPiANCj4gSXQgY2FuJ3QgYmUgcmVs
ZXZhbnQuDQo+IFRoYXQgY2hhbmdlIGlzIGFmdGVyIHRoZSBtdWxfdTY0X3U2NF9kaXZfdTY0KCkg
Y2FsbCB0aGF0IHRyYXBwZWQuDQo+IEl0IGlzIGFsc28gbm90IHJlbGV2YW50IGZvciB4ODYtNjQg
YmVjYXVzZSBpdCB1c2VzIHRoZSBhc20gdmVyc2lvbi4NCj4gDQo+IEF0IHNvbWUgcG9pbnQgbXVs
X3U2NF91NjRfZGl2X3U2NCgpIGdvdCBjaGFuZ2VkIHRvIGJlIGFjY3VyYXRlIChhbmQgc2xvdykg
c28NCj4gdGhhdCBjaGVjayBpc24ndCBuZWVkZWQgYW55IG1vcmUuDQo+IA0KDQpJIHNlZSB0aGlz
IHBhdGNoIG5vdCByZWxldmFudA0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIGNvbmZp
cm1hdGlvbg0KDQotTGkNCg==

