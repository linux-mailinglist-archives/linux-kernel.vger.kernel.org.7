Return-Path: <linux-kernel+bounces-828470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D4DB94AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13D62E3B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6472EAB64;
	Tue, 23 Sep 2025 07:03:47 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917926E717;
	Tue, 23 Sep 2025 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611026; cv=none; b=nmVmrF4Cqn33RB50z8gFn0BJMjtYVR2V9xK7ZyhW7K7UhXCkz12qq2Kz5i25H0UWbdOOpSXHOlsGRtKn5q2RsFKAw3vwy1dMvbQ4EtNLiLWvJzW1qW5+qkcFTmH4t/AOMbBESFBTompWZ/FNYOICvemUPMdD74O24KK7/JFBGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611026; c=relaxed/simple;
	bh=e9Vg2dzIeDuuObcmwsRBRncNjaaipGCZqDw3uwGilp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uohSoXYebzpAge9yt2YUrR46NjX3kjjnu8C+bO6Fo0Q/ttZHxEyrfuoxkR3wq81ecEMMVWmYOQk9e+QZPyJ+8A9PayERKMdJPzWMMFbLAh0uwqxSbjWciA8PT6q7lpcl1jHwoFccPaXNX0x1qp6LkQ/8xXk4P08CqljyNLi1NnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "lance.yang@linux.dev" <lance.yang@linux.dev>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"mingo@kernel.org" <mingo@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"kees@kernel.org" <kees@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>,
	"pauld@redhat.com" <pauld@redhat.com>, "joel.granados@kernel.org"
	<joel.granados@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbPz8/P10gUmU6IFtQQVRDSF1bUkZD?=
 =?utf-8?B?XSBodW5nX3Rhc2s6IFN1cHBvcnQgdG8gcGFuaWMgd2hlbiB0aGUgbWF4aW11?=
 =?utf-8?Q?m_number_of_hung_task_warnings_is_reached?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFs/Pz8/XSBSZTogW1BBVENIXVtSRkNdIGh1?=
 =?utf-8?B?bmdfdGFzazogU3VwcG9ydCB0byBwYW5pYyB3aGVuIHRoZSBtYXhpbXVtIG51?=
 =?utf-8?Q?mber_of_hung_task_warnings_is_reached?=
Thread-Index: AQHcLDttVizJ2u6zwEeKMgiwnSexq7SfmowAgACJIFD//51tAIAAlYrw
Date: Tue, 23 Sep 2025 07:01:47 +0000
Message-ID: <b37376c5ed0141e5a370bf4e73c33751@baidu.com>
References: <20250923033740.2696-1-lirongqing@baidu.com>
 <20250922204554.55dd890090b0f56ad10a61f5@linux-foundation.org>
 <f11f4dd1983f4073a8008112e55f92f8@baidu.com>
 <36db2f10-ebbe-4ecd-b27f-e02d9e1569c2@paulmck-laptop>
In-Reply-To: <36db2f10-ebbe-4ecd-b27f-e02d9e1569c2@paulmck-laptop>
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
X-FEAS-Client-IP: 172.31.50.45
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBUaGVyZSBhcmUgdGhlIHBhbmljX29uX3JjdV9zdGFsbCBhbmQgbWF4X3JjdV9zdGFsbF90b19w
YW5pYyBzeXNjdGxzLCB3aGljaA0KPiB0b2dldGhlciBhbGxvdyB5b3UgdG8gcGFuaWMgYWZ0ZXIg
KHNheSkgdGhyZWUgUkNVIENQVSBzdGFsbCB3YXJuaW5ncy4NCj4gRG9lcyB0aG9zZSBkbyB3aGF0
IHlvdSBuZWVkPw0KPiANCj4gCQkJCQkJCVRoYW54LCBQYXVsDQo+IA0KDQoNCmluc3BpcmVkIGJ5
IGRmZTU2NDA0NWM2NTNkICIocmN1OiBQYW5pYyBhZnRlciBmaXhlZCBudW1iZXIgb2Ygc3RhbGxz
KSIsIGFkZCBhIG5ldyBrbm9kIGZvciBodW5nIHRhc2ssIGhvdyBhYm91dD8NCg0KDQpkaWZmIC0t
Z2l0IGEva2VybmVsL2h1bmdfdGFzay5jIGIva2VybmVsL2h1bmdfdGFzay5jDQppbmRleCA4NzA4
YTEyLi5iOTM1OTJkIDEwMDY0NA0KLS0tIGEva2VybmVsL2h1bmdfdGFzay5jDQorKysgYi9rZXJu
ZWwvaHVuZ190YXNrLmMNCkBAIC04Myw2ICs4Myw4IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgX19y
ZWFkX21vc3RseSBzeXNjdGxfaHVuZ190YXNrX2FsbF9jcHVfYmFja3RyYWNlOw0KIHN0YXRpYyB1
bnNpZ25lZCBpbnQgX19yZWFkX21vc3RseSBzeXNjdGxfaHVuZ190YXNrX3BhbmljID0NCiAgICAg
ICAgSVNfRU5BQkxFRChDT05GSUdfQk9PVFBBUkFNX0hVTkdfVEFTS19QQU5JQyk7DQoNCitzdGF0
aWMgdW5zaWduZWQgaW50IF9fcmVhZF9tb3N0bHkgc3lzY3RsX2h1bmdfdGFza19wYW5pY19jb3Vu
dDsNCisNCiBzdGF0aWMgaW50DQogaHVuZ190YXNrX3BhbmljKHN0cnVjdCBub3RpZmllcl9ibG9j
ayAqdGhpcywgdW5zaWduZWQgbG9uZyBldmVudCwgdm9pZCAqcHRyKQ0KIHsNCkBAIC0yMTksNyAr
MjIxLDkgQEAgc3RhdGljIHZvaWQgY2hlY2tfaHVuZ190YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAq
dCwgdW5zaWduZWQgbG9uZyB0aW1lb3V0KQ0KDQogICAgICAgIHRyYWNlX3NjaGVkX3Byb2Nlc3Nf
aGFuZyh0KTsNCg0KLSAgICAgICBpZiAoc3lzY3RsX2h1bmdfdGFza19wYW5pYykgew0KKyAgICAg
ICBpZiAoc3lzY3RsX2h1bmdfdGFza19wYW5pYyB8fA0KKyAgICAgICAgICAgICAgIChzeXNjdGxf
aHVuZ190YXNrX3BhbmljX2NvdW50ICYmDQorICAgICAgICAgICAgICAgIChzeXNjdGxfaHVuZ190
YXNrX2RldGVjdF9jb3VudCA+IHN5c2N0bF9odW5nX3Rhc2tfcGFuaWNfY291bnQpKSkgew0KICAg
ICAgICAgICAgICAgIGNvbnNvbGVfdmVyYm9zZSgpOw0KICAgICAgICAgICAgICAgIGh1bmdfdGFz
a19zaG93X2xvY2sgPSB0cnVlOw0KICAgICAgICAgICAgICAgIGh1bmdfdGFza19jYWxsX3Bhbmlj
ID0gdHJ1ZTsNCkBAIC0zODgsNiArMzkyLDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY3RsX3Rh
YmxlIGh1bmdfdGFza19zeXNjdGxzW10gPSB7DQogICAgICAgICAgICAgICAgLmV4dHJhMiAgICAg
ICAgID0gU1lTQ1RMX09ORSwNCiAgICAgICAgfSwNCiAgICAgICAgew0KKyAgICAgICAgICAgICAg
IC5wcm9jbmFtZSAgICAgICA9ICJodW5nX3Rhc2tfcGFuaWNfY291bnQiLA0KKyAgICAgICAgICAg
ICAgIC5kYXRhICAgICAgICAgICA9ICZzeXNjdGxfaHVuZ190YXNrX3BhbmljX2NvdW50LA0KKyAg
ICAgICAgICAgICAgIC5tYXhsZW4gICAgICAgICA9IHNpemVvZihpbnQpLA0KKyAgICAgICAgICAg
ICAgIC5tb2RlICAgICAgICAgICA9IDA2NDQsDQorICAgICAgICAgICAgICAgLnByb2NfaGFuZGxl
ciAgID0gcHJvY19kb2ludHZlY19taW5tYXgsDQorICAgICAgICAgICAgICAgLmV4dHJhMSAgICAg
ICAgID0gU1lTQ1RMX1pFUk8sDQorICAgICAgIH0sDQorICAgICAgIHsNCiAgICAgICAgICAgICAg
ICAucHJvY25hbWUgICAgICAgPSAiaHVuZ190YXNrX2NoZWNrX2NvdW50IiwNCiAgICAgICAgICAg
ICAgICAuZGF0YSAgICAgICAgICAgPSAmc3lzY3RsX2h1bmdfdGFza19jaGVja19jb3VudCwNCiAg
ICAgICAgICAgICAgICAubWF4bGVuICAgICAgICAgPSBzaXplb2YoaW50KSwNCg==

