Return-Path: <linux-kernel+bounces-849123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A175CBCF405
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E105519A1085
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6942609D9;
	Sat, 11 Oct 2025 10:59:34 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D421D590;
	Sat, 11 Oct 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760180373; cv=none; b=MnbDiXg0rj0kraJuOEj4ZbTT2lJFloGAZZgmwcYrzz4dew1xOtyOKLXEMgOPou44eB0rL0xC3EzVdD5Eq/WvQeET636IrtKYxOdJlB+vfh9r0CoZw3A5fByLl04Pslvx/3jKt2KwcxQeyopzIv8ScU7JCI84PGT1B6J87ZKDDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760180373; c=relaxed/simple;
	bh=p18314kQrqNwtFjDlrJ/pGINPw/6EePuRm3jLz/Kdkc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OTJ+K2Wf7kR+p7PrgAx+sIGS3NaA6y0C4UFJQegDSb3CsJIgZoVPO5P8y5ReI2fHU+69exAonD+Y6vHtfe3My7aoCtvCFWSZDzzGFCt2INpfYNbRKa3S1rRjHWbt0cfe+al2uN15/hQyLsU82iTlovI6DZlD8GSW/kcJGuEuCX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Kees Cook <kees@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "lance.yang@linux.dev" <lance.yang@linux.dev>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>,
	"pauld@redhat.com" <pauld@redhat.com>, "joel.granados@kernel.org"
	<joel.granados@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdW3YyXSBodW5nX3Rhc2s6?=
 =?utf-8?Q?_Panic_after_fixed_number_of_hung_tasks?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bdjJdIGh1bmdfdGFzazogUGFu?=
 =?utf-8?Q?ic_after_fixed_number_of_hung_tasks?=
Thread-Index: AQHcMDksdcRioXB8tEOzfxW7SI8WgLS7pGyAgABZ+wCAANv20A==
Date: Sat, 11 Oct 2025 10:57:41 +0000
Message-ID: <1729312f8358451ba32eabdea86a7820@baidu.com>
References: <20250928053137.3412-1-lirongqing@baidu.com>
 <d8c6762c-e08c-4b7a-92e9-7dad17ad0b49@infradead.org>
 <B0A75949-C40A-49E7-83BD-58D6BD5A1493@kernel.org>
In-Reply-To: <B0A75949-C40A-49E7-83BD-58D6BD5A1493@kernel.org>
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
X-FEAS-Client-IP: 172.31.3.13
X-FE-Policy-ID: 52:10:53:SYSTEM

DQo+IE9uIE9jdG9iZXIgMTAsIDIwMjUgNToyNTowNSBQTSBQRFQsIFJhbmR5IER1bmxhcCA8cmR1
bmxhcEBpbmZyYWRlYWQub3JnPg0KPiB3cm90ZToNCj4gPkhpLA0KPiA+DQo+ID5PbiA5LzI3LzI1
IDEwOjMxIFBNLCBsaXJvbmdxaW5nIHdyb3RlOg0KPiA+PiBGcm9tOiBMaSBSb25nUWluZyA8bGly
b25ncWluZ0BiYWlkdS5jb20+DQo+ID4+DQo+ID4+IEN1cnJlbnRseSwgd2hlbiBodW5nX3Rhc2tf
cGFuaWMgaXMgZW5hYmxlZCwga2VybmVsIHdpbGwgcGFuaWMNCj4gPj4gaW1tZWRpYXRlbHkgdXBv
biBkZXRlY3RpbmcgdGhlIGZpcnN0IGh1bmcgdGFzay4gSG93ZXZlciwgc29tZSBodW5nDQo+ID4+
IHRhc2tzIGFyZSB0cmFuc2llbnQgYW5kIHRoZSBzeXN0ZW0gY2FuIHJlY292ZXIgZnVsbHksIHdo
aWxlIG90aGVycw0KPiA+PiBhcmUgdW5yZWNvdmVyYWJsZSBhbmQgdHJpZ2dlciBjb25zZWN1dGl2
ZSBodW5nIHRhc2sgcmVwb3J0cywgYW5kIGEgcGFuaWMgaXMNCj4gZXhwZWN0ZWQuDQo+ID4+DQo+
ID4+IFRoaXMgY29tbWl0IGFkZHMgYSBuZXcgc3lzY3RsIHBhcmFtZXRlciBodW5nX3Rhc2tfY291
bnRfdG9fcGFuaWMgdG8NCj4gPj4gYWxsb3dzIHNwZWNpZnlpbmcgdGhlIG51bWJlciBvZiBjb25z
ZWN1dGl2ZSBodW5nIHRhc2tzIHRoYXQgbXVzdCBiZQ0KPiA+PiBkZXRlY3RlZA0KPiANCj4gV2h5
IG1ha2UgYSBuZXcgc3lzY3RsPyBDYW4ndCB5b3UganVzdCB1c2UgaHVuZ190YXNrX3BhbmljIGFu
ZCByYWlzZSB0aGUgbWF4DQo+IHRvIElOVF9NQVg/DQo+IA0KDQoNCkhvd2V2ZXIsIHRoaXMgd2ls
bCBwcmV2ZW50IHRoZSBwcmludGluZyBvZiBodW5nIHRhc2sgd2FybmluZ3MuIEh1bmcgdGFzayB3
YXJuaW5ncyBhcmUgdmVyeSB1c2VmdWwgZm9yIGlkZW50aWZ5aW5nIHdoaWNoIHRhc2tzIGFyZSBo
YW5naW5nIGFuZCB3aGVyZSB0aGV5IGFyZSBzdHVjay4NCg0KSWYgdGhlcmUgaXMgdGhpcyBmdW5j
dGlvbiwgSSBob3BlIHRvIHNob3J0ZW4gc3lzY3RsX2h1bmdfdGFza190aW1lb3V0X3NlY3MgdG8g
Z2l2ZSBtb3JlIGluZm9ybWF0aW9uLg0KDQpBbmQgcmN1IGhhcyB0aGUgc2ltaWxhciBmdW5jdGlv
biBhcyBkZmU1NjQwNDVjNjUzZCAiKHJjdTogUGFuaWMgYWZ0ZXIgZml4ZWQgbnVtYmVyIG9mIHN0
YWxscykiDQoNCi1MaQ0KDQoNCg==

