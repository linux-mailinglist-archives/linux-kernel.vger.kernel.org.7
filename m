Return-Path: <linux-kernel+bounces-720729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748D1AFBFD1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2343BEE29
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBDF1E570B;
	Tue,  8 Jul 2025 01:20:10 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CAE1DB54C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937610; cv=none; b=RJiraKxCTD9tRasSg8PYtnLugSEKxHFCaXOXsJ5/vylttKLdSUaQcxpQkhx+EYUAPy4gsgMt7riN89ameicZ+TuZ71KonlQlF9E93UQ2SThYdIULkm2bIGEe36NJmj0sb9X6bOWuh51m/jagRjcXiEMmGYuhJjlap0Z0rCwl87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937610; c=relaxed/simple;
	bh=iaAHFVNpa8jdmuCqA2+udt/z7g5BZ2L1sQHg4bvNcgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nqWZf5hBYaT1x/Km7QSATrdu3PgozemcVQjfkiRdLuq2BhYqf9FkAN/hCKhtIRZLxYfpwSXgy85YHHxqI5ac30Co+9RLPVFsUn0p0gKvtM4A6H2vpc4eh2tjmg9L7BKlogZGK02Wnhsj/8sE+SjwGg6uDELXZrQsUgDZDBMreIU=
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
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbPz8/P10gUmU6IFs/Pz8/XSBSZTogZGl2aWRl?=
 =?gb2312?Q?_error_in_x86_and_cputime?=
Thread-Topic: [????] Re: [????] Re: [????] Re: divide error in x86 and cputime
Thread-Index: AQHb75zFK/FJTpEU3EWj+reAAU9eAbQm2c6AgACRUxA=
Date: Tue, 8 Jul 2025 01:17:50 +0000
Message-ID: <c22ff02d1af74ccca59e3a2927da8e67@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>	<20250707223038.GB15787@redhat.com>
	<2ef88def90634827bac1874d90e0e329@baidu.com>
	<20250707195318.0c7f401d@gandalf.local.home>
	<92674f89641f466b9ebbdf7681614ed3@baidu.com>
 <20250707203057.1b2af73d@gandalf.local.home>
In-Reply-To: <20250707203057.1b2af73d@gandalf.local.home>
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

PiBIYXZlIHlvdSB0cmllZCBpdD8gT3IgYXJlIHlvdSBqdXN0IG1ha2luZyBhbiBhc3N1bXB0aW9u
Pw0KPiANCj4gSG93IGNhbiB5b3UgYmUgc28gc3VyZT8gRGlkIHlvdSBldmVuICpsb29rKiBhdCB0
aGUgY29tbWl0Pw0KPiANCj4gICAgIHNjaGVkL2NwdXRpbWU6IEZpeCBtdWxfdTY0X3U2NF9kaXZf
dTY0KCkgcHJlY2lzaW9uIGZvciBjcHV0aW1lDQo+IA0KPiAgICAgSW4gZXh0cmVtZSB0ZXN0IHNj
ZW5hcmlvczoNCj4gICAgIHRoZSAxNHRoIGZpZWxkIHV0aW1lIGluIC9wcm9jL3h4L3N0YXQgaXMg
Z3JlYXRlciB0aGFuIHN1bV9leGVjX3J1bnRpbWUsDQo+ICAgICB1dGltZSA9IDE4NDQ2NzQ0MDcz
NzA5NTE4NzkwIG5zLCBydGltZSA9IDEzNTk4OTc0OTcyODAwMCBucw0KPiANCj4gICAgIEluIGNw
dXRpbWVfYWRqdXN0KCkgcHJvY2Vzcywgc3RpbWUgaXMgZ3JlYXRlciB0aGFuIHJ0aW1lIGR1ZSB0
bw0KPiAgICAgbXVsX3U2NF91NjRfZGl2X3U2NCgpIHByZWNpc2lvbiBwcm9ibGVtLg0KPiAgICAg
YmVmb3JlIGNhbGwgbXVsX3U2NF91NjRfZGl2X3U2NCgpLA0KPiAgICAgc3RpbWUgPSAxNzUxMzY1
ODY3MjAwMDAsIHJ0aW1lID0gMTM1OTg5NzQ5NzI4MDAwLCB1dGltZSA9DQo+IDE0MTY3ODAwMDAu
DQo+ICAgICBhZnRlciBjYWxsIG11bF91NjRfdTY0X2Rpdl91NjQoKSwNCj4gICAgIHN0aW1lID0g
MTM1OTg5OTQ5NjUzNTMwDQo+IA0KPiAgICAgdW5zaWduZWQgcmV2ZXJzaW9uIG9jY3VycyBiZWNh
dXNlIHJ0aW1lIGlzIGxlc3MgdGhhbiBzdGltZS4NCj4gICAgIHV0aW1lID0gcnRpbWUgLSBzdGlt
ZSA9IDEzNTk4OTc0OTcyODAwMCAtIDEzNTk4OTk0OTY1MzUzMA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgID0gLTE5OTkyNTUzMA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgID0gKHU2
NCkxODQ0Njc0NDA3MzcwOTUxODc5MA0KPiANCg0KSSB3aWxsIHRyeSB0byB0ZXN0ZWQgdGhpcyBw
YXRjaCwgQnV0IEkgdGhpbmsgaXQgaXMgZGlmZmVyZW50IGNhc2U7DQoNClN0aW1lIGlzIG5vdCBn
cmVhdGVyIHRoYW4gcnRpbWUgaW4gbXkgY2FzZSwgKHN0aW1lPSAweDY5Zjk4ZGE5YmE5ODBjMDAs
IHJ0aW1lPSAweGZmZmQyMTNhYWJkNzQ2MjYsIHN0aW1lK3V0aW1lPSAweDllMDA5MDAuIFNvIHV0
aW1lIHNob3VsZCBiZSAweDk2MDY3MjU2NGY0N2ZkMDAgKSwgYW5kIHRoaXMgb3ZlcmZsb3cgcHJv
Y2VzcyB3aXRoIDIzNiBidXN5IHBvbGwgdGhyZWFkcyBydW5uaW5nIGFib3V0IDkwNCBkYXksIHNv
IEkgdGhpbmsgdGhlc2UgdGltZXMgYXJlIGNvcnJlY3QNCg0KDQpUaGFua3MNCg0KLUxpDQoNCj4g
ICAgIFRyaWdnZXIgY29uZGl0aW9uOg0KPiAgICAgICAxKS4gVXNlciB0YXNrIHJ1biBpbiBrZXJu
ZWwgbW9kZSBtb3N0IG9mIHRpbWUNCj4gICAgICAgMikuIEFSTTY0IGFyY2hpdGVjdHVyZQ0KPiAg
ICAgICAzKS4gVElDS19DUFVfQUNDT1VOVElORz15DQo+ICAgICAgICAgICBDT05GSUdfVklSVF9D
UFVfQUNDT1VOVElOR19OQVRJVkUgaXMgbm90IHNldA0KPiANCj4gICAgIEZpeCBtdWxfdTY0X3U2
NF9kaXZfdTY0KCkgY29udmVyc2lvbiBwcmVjaXNpb24gYnkgcmVzZXQgc3RpbWUgdG8gcnRpbWUN
Cj4gDQo+IA0KPiBXaGVuIHN0aW1lIGVuZHMgdXAgZ3JlYXRlciB0aGFuIHJ0aW1lLCBpdCBjYXVz
ZXMgdXRpbWUgdG8gZ28gTkVHQVRJVkUhDQo+IA0KPiBUaGF0IG1lYW5zICpZRVMqIGl0IGNhbiBv
dmVyZmxvdyBhIHU2NCBudW1iZXIuIFRoYXQncyB5b3VyIGJ1Zy4NCj4gDQo+IE5leHQgdGltZSwg
bG9vayB0byBzZWUgaWYgdGhlcmUncyBmaXhlcyBpbiB0aGUgY29kZSB0aGF0IGlzIHRyaWdnZXJp
bmcgaXNzdWVzIGZvciB5b3UNCj4gYW5kIHRlc3QgdGhlbSBvdXQsIGJlZm9yZSBib3RoZXJpbmcg
dXBzdHJlYW0uDQo+IA0KPiBHb29kYnllLg0KPiANCj4gLS0gU3RldmUNCg==

