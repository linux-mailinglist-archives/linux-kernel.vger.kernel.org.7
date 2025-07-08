Return-Path: <linux-kernel+bounces-720764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9E7AFC02A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A7E4A70E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0681F9EC0;
	Tue,  8 Jul 2025 01:42:34 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E142AB0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938954; cv=none; b=Yt8D72YPmyNEf2QWGg+zENvX2l+h0SHSJgFO8i3oeRq5U5PqtZgvq3iwohcR4N8ntZJUR4aK/EcF94VHaqW9TJWXQGbER7DTNFxHAnr07F4x88qAjReb9YPV8fa1r3SPY/F2LKY1binu6pYdlma5G3hFDFO2F3Xf/tWkY8cDvf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938954; c=relaxed/simple;
	bh=2BSYKr7kSQko0CWJMRNlwpfMOg9o3FHtNDXqN4FkLro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r4XSPPMIyr8uZYga57g436GyJA+CUuLOVde8ZAxaqGiV+SWyYf4Euf6jWY336hW3wPrYKbBJof7sYqTuB+NuRrN12V0JPdmw1leTkqAU6XLzNVCVJJ12kYVgngw16ANLlP5gLl22GCA92Y4BuLkQ/x73VmoPdcain+ot4o05JX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>, David Laight
	<david.laight.linux@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "bsegall@google.com"
	<bsegall@google.com>, "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBkaXZpZGUgZXJyb3IgaW4geDg2IGFuZCBjcHV0?=
 =?gb2312?Q?ime?=
Thread-Topic: [????] Re: divide error in x86 and cputime
Thread-Index: AdvvFOeRwP1XMiJ8Sh6ojy4vzov+4AAM96oAAABlCAAAAHCBgAAXFAAA
Date: Tue, 8 Jul 2025 01:40:27 +0000
Message-ID: <42f5344b80e244278aaf49f112498e02@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
	<20250707182056.66a8468a@gandalf.local.home>
 <20250707183331.029570bf@gandalf.local.home>
In-Reply-To: <20250707183331.029570bf@gandalf.local.home>
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
X-FEAS-Client-IP: 172.31.50.44
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBUaGF0IHdvdWxkIGJlOg0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtaW51dGVzICAgIGRheXMNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2ICAgICAgICB2DQo+ICAgOTIyMzM3MjAzNjg1NDc3NTgwOCAvIDEwMDAwMDAwMDAgLyA2MCAv
IDYwIC8gMjQgLyAzNjUuMjUgPSAyOTIuMjcNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
XiAgICAgICAgICAgICAgIF4gICAgICAgICBeDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIG5z
IC0+IHNlYyAgICAgICBob3VycyAgICAgICB5ZWFycw0KPiANCj4gU28gdGhlIHJlcG9ydCBzYXlz
IHRoZXkgaGF2ZSB0aHJlYWRzIHJ1bm5pbmcgZm9yIGEgdmVyeSBsb25nIHRpbWUsIGl0IHdvdWxk
IHN0aWxsDQo+IGJlIDI5MiB5ZWFycyBvZiBydW4gdGltZSENCg0KVXRpbWUvcnRpbWUgaXMgdTY0
LCBpdCBtZWFucyBvdmVyZmxvdyBuZWVkcyAyOTIuMjcqMj01ODQgeWVhciwNCg0KQnV0IHdpdGgg
bXVsdGlwbGUgdGhyZWFkLCBsaWtlIDI5MiB0aHJlYWRzLCBpdCBvbmx5IG5lZWQgdHdvIHllYXJz
LCBpdCBpcyBhIHRocmVhZCBncm91cCB0b3RhbCBydW5uaW5nIHRpbWUNCg0KDQp2b2lkIHRocmVh
ZF9ncm91cF9jcHV0aW1lX2FkanVzdGVkKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgdTY0ICp1dCwg
dTY0ICpzdCkNCnsNCiAgICBzdHJ1Y3QgdGFza19jcHV0aW1lIGNwdXRpbWU7DQoNCiAgICB0aHJl
YWRfZ3JvdXBfY3B1dGltZShwLCAmY3B1dGltZSk7DQogICAgY3B1dGltZV9hZGp1c3QoJmNwdXRp
bWUsICZwLT5zaWduYWwtPnByZXZfY3B1dGltZSwgdXQsIHN0KTsNCn0NCg0KLUxpDQoNCg0KDQo=

