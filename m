Return-Path: <linux-kernel+bounces-720675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F31FAFBF21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3914A0376
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C95AD24;
	Tue,  8 Jul 2025 00:12:15 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CED79C0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933535; cv=none; b=uUv7Hj5g3sg749KFHl8xRi+F9Q3SiHEzdI+i1TIAL5vtvP/vnvlz49dOtEy30dVo0+mgsss+SeeViwWPKVLaUcsStTiwHuHcOeQ7EFeVIWeQp40MUnvUBqixcKurl/6QLQdLtEQXJcYH4JL5ZKdE0mDWjYhSLYddZPWug+8Pwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933535; c=relaxed/simple;
	bh=GrsAph00Fm761jPXr/ytZw8yEbM6xEm6t0LQHZ2PKeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XHeaFf1oYqAyC4zNfb5BiI97mhN0XlfgZDiwcreTxt0YDjEIeUC+BAhk/+E86tHfzWvEzbjAX5gsYQflQ9b4K7/rvJ6IwPkjo5s6mFlk/s9pR17DYdoyL6wzh/Yd8DZuq1zLqlvr92W+PjTRf2TOnhROYPYiQaySKqq1k0rQItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	David Laight <david.laight.linux@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "bsegall@google.com"
	<bsegall@google.com>, "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbPz8/P10gUmU6IGRpdmlkZSBlcnJvciBpbiB4?=
 =?gb2312?Q?86_and_cputime?=
Thread-Topic: [????] Re: [????] Re: divide error in x86 and cputime
Thread-Index: AQHb75zFK/FJTpEU3EWj+reAAU9eAQ==
Date: Tue, 8 Jul 2025 00:10:54 +0000
Message-ID: <92674f89641f466b9ebbdf7681614ed3@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>	<20250707223038.GB15787@redhat.com>
	<2ef88def90634827bac1874d90e0e329@baidu.com>
 <20250707195318.0c7f401d@gandalf.local.home>
In-Reply-To: <20250707195318.0c7f401d@gandalf.local.home>
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
X-FEAS-Client-IP: 172.31.50.15
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBPbiBNb24sIDcgSnVsIDIwMjUgMjM6NDE6MTQgKzAwMDANCj4gIkxpLFJvbmdxaW5nIiA8bGly
b25ncWluZ0BiYWlkdS5jb20+IHdyb3RlOg0KPiANCj4gPiA+IE9uIGEgc2Vjb25kIHRob3VnaHQs
IHRoaXMNCj4gPiA+DQo+ID4gPiAgICAgbXVsX3U2NF91NjRfZGl2X3U2NCgweDY5Zjk4ZGE5YmE5
ODBjMDAsIDB4ZmZmZDIxM2FhYmQ3NDYyNiwNCj4gPiA+IDB4MDllMDA5MDApOw0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgc3RpbWUgICAgICAgICAgICAgICBydGltZQ0KPiA+ID4gc3Rp
bWUgKyB1dGltZQ0KPiA+ID4NCj4gPiA+IGxvb2tzIHN1c3BpY2lvdXM6DQo+ID4gPg0KPiA+ID4g
CS0gc3RpbWUgPiBzdGltZSArIHV0aW1lDQo+ID4gPg0KPiA+ID4gCS0gcnRpbWUgPSAweGZmZmQy
MTNhYWJkNzQ2MjYgaXMgYWJzdXJkbHkgaHVnZQ0KPiA+ID4NCj4gPiA+IHNvIHBlcmhhcHMgdGhl
cmUgaXMgYW5vdGhlciBwcm9ibGVtPw0KPiA+ID4NCj4gPg0KPiA+IGl0IGhhcHBlbmVkIHdoZW4g
YSBwcm9jZXNzIHdpdGggMjM2IGJ1c3kgcG9sbGluZyB0aHJlYWRzICwgcnVuIGFib3V0DQo+ID4g
OTA0IGRheXMsIHRoZSB0b3RhbCB0aW1lIHdpbGwgb3ZlcmZsb3cgdGhlIDY0Yml0DQo+ID4NCj4g
PiBub24teDg2IHN5c3RlbSBtYXliZSBoYXMgc2FtZSBpc3N1ZSwgb25jZSAoc3RpbWUgKyB1dGlt
ZSkgb3ZlcmZsb3dzDQo+ID4gNjRiaXQsIG11bF91NjRfdTY0X2Rpdl91NjQgZnJvbSBsaWIvbWF0
aC9kaXY2NC5jIG1heWJlIGNhdXNlIGRpdmlzaW9uDQo+ID4gYnkgMA0KPiA+DQo+ID4gc28gdG8g
Y3B1dGltZSwgY291bGQgY3B1dGltZV9hZGp1c3QoKSByZXR1cm4gc3RpbWUgaWYgc3RpbWUgaWYg
c3RpbWUgKw0KPiA+IHV0aW1lIGlzIG92ZXJmbG93DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEva2Vy
bmVsL3NjaGVkL2NwdXRpbWUuYyBiL2tlcm5lbC9zY2hlZC9jcHV0aW1lLmMgaW5kZXgNCj4gPiA2
ZGFiNDg1NC4uZGIwYzI3MyAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwvc2NoZWQvY3B1dGltZS5j
DQo+ID4gKysrIGIva2VybmVsL3NjaGVkL2NwdXRpbWUuYw0KPiA+IEBAIC01NzksNiArNTc5LDEw
IEBAIHZvaWQgY3B1dGltZV9hZGp1c3Qoc3RydWN0IHRhc2tfY3B1dGltZSAqY3VyciwNCj4gc3Ry
dWN0IHByZXZfY3B1dGltZSAqcHJldiwNCj4gPiAgICAgICAgICAgICAgICAgZ290byB1cGRhdGU7
DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiArICAgICAgIGlmIChzdGltZSA+IChzdGltZSArIHV0
aW1lKSkgew0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIHVwZGF0ZTsNCj4gPiArICAgICAgIH0N
Cj4gPiArDQo+ID4gICAgICAgICBzdGltZSA9IG11bF91NjRfdTY0X2Rpdl91NjQoc3RpbWUsIHJ0
aW1lLCBzdGltZSArIHV0aW1lKTsNCj4gPiAgICAgICAgIC8qDQo+ID4gICAgICAgICAgKiBCZWNh
dXNlIG11bF91NjRfdTY0X2Rpdl91NjQoKSBjYW4gYXBwcm94aW1hdGUgb24gc29tZQ0KPiA+DQo+
IA0KPiBBcmUgeW91IHJ1bm5pbmcgNS4xMC4wPyBCZWNhdXNlIGEgZGlmZiBvZiA1LjEwLjIzOCBm
cm9tIDUuMTAuMCBnaXZlczoNCj4gDQo+IEBAIC01NzksNiArNTc5LDEyIEBAIHZvaWQgY3B1dGlt
ZV9hZGp1c3Qoc3RydWN0IHRhc2tfY3B1dGltZSAqY3Vyciwgc3RydWN0DQo+IHByZXZfY3B1dGlt
ZSAqcHJldiwNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIHN0aW1lID0gbXVsX3U2NF91NjRf
ZGl2X3U2NChzdGltZSwgcnRpbWUsIHN0aW1lICsgdXRpbWUpOw0KPiArICAgICAgIC8qDQo+ICsg
ICAgICAgICogQmVjYXVzZSBtdWxfdTY0X3U2NF9kaXZfdTY0KCkgY2FuIGFwcHJveGltYXRlIG9u
IHNvbWUNCj4gKyAgICAgICAgKiBhY2hpdGVjdHVyZXM7IGVuZm9yY2UgdGhlIGNvbnN0cmFpbnQg
dGhhdDogYSpiLyhiK2MpIDw9IGEuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgaWYgKHVubGlr
ZWx5KHN0aW1lID4gcnRpbWUpKQ0KPiArICAgICAgICAgICAgICAgc3RpbWUgPSBydGltZTsNCg0K
DQpNeSA1LjEwIGhhcyBub3QgdGhpcyBwYXRjaCAiIHNjaGVkL2NwdXRpbWU6IEZpeCBtdWxfdTY0
X3U2NF9kaXZfdTY0KCkgcHJlY2lzaW9uIGZvciBjcHV0aW1lICIsDQpidXQgSSBhbSBzdXJlIHRo
aXMgcGF0Y2ggY2FuIG5vdCBmaXggdGhpcyBvdmVyZmxvdyBpc3N1ZSwgU2luY2UgZGl2aXNpb24g
ZXJyb3IgaGFwcGVuZWQgaW4gbXVsX3U2NF91NjRfZGl2X3U2NCgpDQoNClRoYW5rcw0KDQotTGkN
Cg0KDQo+IA0KPiAgdXBkYXRlOg0KPiANCj4gDQo+IFRodXMgdGhlIHJlc3VsdCBpcyB3aGF0J3Mg
Z2V0dGluZyBzY3Jld2VkIHVwLg0KPiANCj4gLS0gU3RldmUNCg==

