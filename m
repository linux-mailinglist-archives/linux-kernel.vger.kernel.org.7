Return-Path: <linux-kernel+bounces-849336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB7BCFDFD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 02:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC2884E37E9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7A1F0E26;
	Sun, 12 Oct 2025 00:00:10 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6042BAF9;
	Sun, 12 Oct 2025 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760227209; cv=none; b=qeyVz1E1ok+pBMeWuCg5bsK6GaYTip4MZ6xxRAe/z2S0wdqF6uAAM8lwl61BBdBO0pHV/eLZ2+6M7ojRFh2HhTlS8LUcHzWRgO04I3DppJ+OycHbNJ+LhLgqlfRNWapPzupPm+R+28/QbPlGM/yRPUqzRlfe2V2aAvA95y2I8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760227209; c=relaxed/simple;
	bh=aavCBw3tMB4GSqTIYmXAC5JXt7peBZI8vCwgtaP7AAw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l4P8XDj6LRfbmF2n8kceySRYaJio7VPgSoFFWgTcR6yFlPR0iAG6con6kvbuz26L/UGjjX0PRCDSMrmTcR55GyAKXmvrQaUaCSq7pmy42OYyWob6FO3xwKxQ8pZMFCLT1VQ5She0IwWhr+cbnqGmv4EdRlh/94utJaSMuU+/NUI=
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
Thread-Index: AQHcMDksdcRioXB8tEOzfxW7SI8WgLS7pGyAgABZ+wCAANv20IAA1bKw
Date: Sat, 11 Oct 2025 23:58:56 +0000
Message-ID: <6c4905288f374bf2ad48492cd03c473e@baidu.com>
References: <20250928053137.3412-1-lirongqing@baidu.com>
 <d8c6762c-e08c-4b7a-92e9-7dad17ad0b49@infradead.org>
 <B0A75949-C40A-49E7-83BD-58D6BD5A1493@kernel.org>
 <1729312f8358451ba32eabdea86a7820@baidu.com>
In-Reply-To: <1729312f8358451ba32eabdea86a7820@baidu.com>
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
X-FEAS-Client-IP: 172.31.3.14
X-FE-Policy-ID: 52:10:53:SYSTEM

DQoNCj4gDQo+IA0KPiA+IE9uIE9jdG9iZXIgMTAsIDIwMjUgNToyNTowNSBQTSBQRFQsIFJhbmR5
IER1bmxhcA0KPiA+IDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+ID4gd3JvdGU6DQo+ID4gPkhp
LA0KPiA+ID4NCj4gPiA+T24gOS8yNy8yNSAxMDozMSBQTSwgbGlyb25ncWluZyB3cm90ZToNCj4g
PiA+PiBGcm9tOiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gPj4NCj4g
PiA+PiBDdXJyZW50bHksIHdoZW4gaHVuZ190YXNrX3BhbmljIGlzIGVuYWJsZWQsIGtlcm5lbCB3
aWxsIHBhbmljDQo+ID4gPj4gaW1tZWRpYXRlbHkgdXBvbiBkZXRlY3RpbmcgdGhlIGZpcnN0IGh1
bmcgdGFzay4gSG93ZXZlciwgc29tZSBodW5nDQo+ID4gPj4gdGFza3MgYXJlIHRyYW5zaWVudCBh
bmQgdGhlIHN5c3RlbSBjYW4gcmVjb3ZlciBmdWxseSwgd2hpbGUgb3RoZXJzDQo+ID4gPj4gYXJl
IHVucmVjb3ZlcmFibGUgYW5kIHRyaWdnZXIgY29uc2VjdXRpdmUgaHVuZyB0YXNrIHJlcG9ydHMs
IGFuZCBhDQo+ID4gPj4gcGFuaWMgaXMNCj4gPiBleHBlY3RlZC4NCj4gPiA+Pg0KPiA+ID4+IFRo
aXMgY29tbWl0IGFkZHMgYSBuZXcgc3lzY3RsIHBhcmFtZXRlciBodW5nX3Rhc2tfY291bnRfdG9f
cGFuaWMgdG8NCj4gPiA+PiBhbGxvd3Mgc3BlY2lmeWluZyB0aGUgbnVtYmVyIG9mIGNvbnNlY3V0
aXZlIGh1bmcgdGFza3MgdGhhdCBtdXN0IGJlDQo+ID4gPj4gZGV0ZWN0ZWQNCj4gPg0KPiA+IFdo
eSBtYWtlIGEgbmV3IHN5c2N0bD8gQ2FuJ3QgeW91IGp1c3QgdXNlIGh1bmdfdGFza19wYW5pYyBh
bmQgcmFpc2UNCj4gPiB0aGUgbWF4IHRvIElOVF9NQVg/DQo+ID4NCj4gDQoNClNvcnJ5LCBJIG1p
c3VuZGVyc3RhbmQgYXQgZmlyc3QuDQoNCkknbSBub3Qgc3VyZSBpZiB0aGlzIHN5c2N0bCBodW5n
X3Rhc2tfcGFuaWMgY2FuIGJlIG1vZGlmaWVkLCBhbmQgaWYgY2hhbmdlZCwgQk9PVFBBUkFNX0hV
TkdfVEFTS19QQU5JQyBzaG91bGQgYmUgY2hhbmdlZCwgYW5kIHdoZXRoZXIgYm90aCBjaGFuZ2lu
ZyB3aWxsIGNhdXNlIGlzc3VlcyBmb3IgdXNlcnMgPw0KDQpJZiBubyBvbmUgb2JqZWN0cywgSSB3
aWxsIHJldXNlIGh1bmdfdGFza19wYW5pYyAsIGFuZCBub3QgYWRkaW5nIGEgbmV3IHN5c2N0bA0K
DQpUaGFua3MNCg0KLUxpDQoNCj4gDQo+IEhvd2V2ZXIsIHRoaXMgd2lsbCBwcmV2ZW50IHRoZSBw
cmludGluZyBvZiBodW5nIHRhc2sgd2FybmluZ3MuIEh1bmcgdGFzaw0KPiB3YXJuaW5ncyBhcmUg
dmVyeSB1c2VmdWwgZm9yIGlkZW50aWZ5aW5nIHdoaWNoIHRhc2tzIGFyZSBoYW5naW5nIGFuZCB3
aGVyZQ0KPiB0aGV5IGFyZSBzdHVjay4NCj4gDQo+IElmIHRoZXJlIGlzIHRoaXMgZnVuY3Rpb24s
IEkgaG9wZSB0byBzaG9ydGVuIHN5c2N0bF9odW5nX3Rhc2tfdGltZW91dF9zZWNzIHRvDQo+IGdp
dmUgbW9yZSBpbmZvcm1hdGlvbi4NCj4gDQo+IEFuZCByY3UgaGFzIHRoZSBzaW1pbGFyIGZ1bmN0
aW9uIGFzIGRmZTU2NDA0NWM2NTNkICIocmN1OiBQYW5pYyBhZnRlciBmaXhlZA0KPiBudW1iZXIg
b2Ygc3RhbGxzKSINCj4gDQo+IC1MaQ0KPiANCg0K

