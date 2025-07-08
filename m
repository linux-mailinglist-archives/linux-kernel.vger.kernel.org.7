Return-Path: <linux-kernel+bounces-720788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6B8AFC063
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966824A1072
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73122165F3;
	Tue,  8 Jul 2025 02:01:10 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900020F062
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940070; cv=none; b=f23rqHyJ/vYZmLnP5/Xu/x8Jz4FwBuF0E7PIvdOn/4ntenP227VnxiXwWf4oqd23k1xXNeQLrQktDY4tmQkY/UzF+ADI3wOSXlffDgxUS8Qmyw8tw+JrHwJh1yQ5Um5sWrdqwQgqTF16TYBwTrXeXP+uQ9cULDf5QBESoP7gjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940070; c=relaxed/simple;
	bh=eyZdCPp13Bznow8kxvhtOAc1H48jsEJT70DS8mOegpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dejYQl9chcLGwFZETxoXZqaMMgYXFpNeh/cpmMXFLsnZiGiVMARis1K0CO6Y8CeNiXwYWDBpuS8uTU0VCKmjwEOFMcY+Ltkkgh6ALiroPl0VYsbNX8+NSFspP7qYLAmU3bQ4NxC5AfHWNb2v8RBpKbQnVchqdaybCfOjtvlKnPc=
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
Thread-Index: AQHb76u7B2Ok5ffmWUu9olkbSlbR1g==
Date: Tue, 8 Jul 2025 01:58:00 +0000
Message-ID: <8f68278c4a454fd79b39cf21d4c0974f@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
	<20250707182056.66a8468a@gandalf.local.home>
	<20250707183331.029570bf@gandalf.local.home>
	<42f5344b80e244278aaf49f112498e02@baidu.com>
 <20250707215322.0e4ec431@gandalf.local.home>
In-Reply-To: <20250707215322.0e4ec431@gandalf.local.home>
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

PiAiTGksUm9uZ3FpbmciIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4g
VGhhdCB3b3VsZCBiZToNCj4gPiA+DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG1pbnV0ZXMgICAgZGF5cw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2ICAgICAgICB2DQo+ID4gPiAgIDkyMjMzNzIwMzY4NTQ3NzU4MDggLyAxMDAw
MDAwMDAwIC8gNjAgLyA2MCAvIDI0IC8gMzY1LjI1ID0gMjkyLjI3DQo+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBeICAgICAgICAgICAgICAgXiAgICAgICAgIF4NCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIG5zIC0+IHNlYyAgICAgICBob3VycyAgICAgICB5ZWFycw0KPiA+
ID4NCj4gPiA+IFNvIHRoZSByZXBvcnQgc2F5cyB0aGV5IGhhdmUgdGhyZWFkcyBydW5uaW5nIGZv
ciBhIHZlcnkgbG9uZyB0aW1lLA0KPiA+ID4gaXQgd291bGQgc3RpbGwgYmUgMjkyIHllYXJzIG9m
IHJ1biB0aW1lIQ0KPiA+DQo+ID4gVXRpbWUvcnRpbWUgaXMgdTY0LCBpdCBtZWFucyBvdmVyZmxv
dyBuZWVkcyAyOTIuMjcqMj01ODQgeWVhciwNCj4gPg0KPiA+IEJ1dCB3aXRoIG11bHRpcGxlIHRo
cmVhZCwgbGlrZSAyOTIgdGhyZWFkcywgaXQgb25seSBuZWVkIHR3byB5ZWFycywgaXQNCj4gPiBp
cyBhIHRocmVhZCBncm91cCB0b3RhbCBydW5uaW5nIHRpbWUNCj4gPg0KPiA+DQo+ID4gdm9pZCB0
aHJlYWRfZ3JvdXBfY3B1dGltZV9hZGp1c3RlZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHU2NCAq
dXQsIHU2NA0KPiA+ICpzdCkgew0KPiA+ICAgICBzdHJ1Y3QgdGFza19jcHV0aW1lIGNwdXRpbWU7
DQo+ID4NCj4gPiAgICAgdGhyZWFkX2dyb3VwX2NwdXRpbWUocCwgJmNwdXRpbWUpOw0KPiA+ICAg
ICBjcHV0aW1lX2FkanVzdCgmY3B1dGltZSwgJnAtPnNpZ25hbC0+cHJldl9jcHV0aW1lLCB1dCwg
c3QpOyB9DQo+ID4NCj4gDQo+IFNvIHlvdSBhcmUgc2F5aW5nIHRoYXQgeW91IGhhdmUgYmVlbiBy
dW5uaW5nIHRoaXMgZm9yIG92ZXIgdHdvIHllYXJzIHdpdGhvdXQgYQ0KPiByZWJvb3Q/DQo+IA0K
DQpZZXMsIENvbnNpZGVyIG1vcmUgYW5kIG1vcmUgQ1BVcyBpbiBtYWNoaW5lLCBJIHRoaW5rIGl0
IGlzIGNvbW1vbiBjYXNlDQoNCg0KPiBUaGVuIHRoZSBpc3N1ZSBpc24ndCB0aGUgZGl2aWRlciwg
aXQncyB0aGF0IHRoZSB0aHJlYWQgZ3JvdXAgY3B1dGltZSBjYW4gb3ZlcmZsb3cuDQo+IFBlcmhh
cHMgaXQgbmVlZHMgYSBjYXAsIG9yIGEgd2F5IHRvICJyZXNldCIgc29tZWhvdyBhZnRlciAic28g
bG9uZyI/DQoNCg0KRG8gbm90IGNsZWFyIGhvdyB0byByZXNldA0KDQpCdXQgbXVsX3U2NF91NjRf
ZGl2X3U2NCgpIGZvciB4ODYgc2hvdWxkIG5vdCB0cmlnZ2VyIGEgZGl2aXNpb24gZXJyb3IgcGFu
aWMsIG1heWJlIHNob3VsZCByZXR1cm4gYSBVTExPTkdfTUFYIG9uICNERSAobGlrZSBub24teDg2
IG11bF91NjRfdTY0X2Rpdl91NjQoKSwpDQoNCj4gDQo+IC0tIFN0ZXZlDQoNCg==

