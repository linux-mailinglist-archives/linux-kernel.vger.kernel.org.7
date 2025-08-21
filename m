Return-Path: <linux-kernel+bounces-778842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD616B2EBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0DC3B2B51
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE82D4804;
	Thu, 21 Aug 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="axQ7ftNF"
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 845B12580CF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755746533; cv=none; b=tst0/bL8BNnowksWdR3j5gQf2xt4E5ztlQ+vf7+4vg7v5ymiM9472uTHwSZfeKmUvh3xU09JNmwYndIl18AnYUtZfmeZ0rQnhztPw0OLBboP+LGnlmYLfB7la3YkgXpQNrCddvsbkX8BpF8tsI3osp6rLVl4/Is2ka/hn3Nvs+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755746533; c=relaxed/simple;
	bh=QIbg+7UJekuVhcRCR5H+JFkJMdK1lI4H9zNSAkonX4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=ZbBAPEorb+OlZ4gZygFBLmzdhMVKu7OgMGKMcnXP3C+Jc0WUyCbHK+bCQz9+GE/Pkwg6++DxotRH06wLte87zAQg6+dDQe9ZZvyKKua4oLvqGLHXpiOn000ThX1Uc8xTZeV4493KGcFoWsr95gFN23/Psi3G1baON7be9Jf4YpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=axQ7ftNF; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.37])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 0B19618B3E86F9;
	Thu, 21 Aug 2025 11:21:08 +0800 (CST)
Received: from BJ02-ACTMBX-07.didichuxing.com (10.79.65.14) by
 BJ03-ACTMBX-01.didichuxing.com (10.79.71.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 21 Aug 2025 11:22:00 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ02-ACTMBX-07.didichuxing.com (10.79.65.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 21 Aug 2025 11:21:59 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Thu, 21 Aug 2025 11:21:59 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.71.37
From: =?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
To: "andi.shyti@kernel.org" <andi.shyti@kernel.org>, "rodrigo.vivi@intel.com"
	<rodrigo.vivi@intel.com>
CC: "airlied@gmail.com" <airlied@gmail.com>, "brauner@kernel.org"
	<brauner@kernel.org>, =?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?=
	<chentaotao@didiglobal.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com"
	<joonas.lahtinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lkp@intel.com" <lkp@intel.com>,
	"oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, "oliver.sang@intel.com"
	<oliver.sang@intel.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"tursulin@ursulin.net" <tursulin@ursulin.net>
Subject: Re: [PATCH 1/2] drm/i915: set O_LARGEFILE in __create_shmem()
Thread-Topic: [PATCH 1/2] drm/i915: set O_LARGEFILE in __create_shmem()
Thread-Index: AQHcEkrBvq4qfIVC9U6kg8R9EqP/Xw==
Date: Thu, 21 Aug 2025 03:21:59 +0000
Message-ID: <20250821032156.4946-1-chentaotao@didiglobal.com>
In-Reply-To: <nd2sd2vdwif242wslgkaonuvskawho36bp6j6a4caghauzx6f5@dgkaow5idqxt>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=didiglobal.com;
	s=2025; t=1755746471;
	bh=QIbg+7UJekuVhcRCR5H+JFkJMdK1lI4H9zNSAkonX4E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=axQ7ftNFi9gt9tS+UgrxjH9//DDzOdP3TiW7iA0+YMlAetbrOcVvY8yxUM1y8oD8g
	 38wnCq3Bm95YWPVuhU+o1wNh8yyNIAWiJ3/U18CwweIKp3qH+pmjW9EH6urYGNcR8y
	 HdO+XmurmzfuOCBmwCouCfuOO6Vuei1pl53PE/90=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNCkhpIEFuZGks
DQoNCj4gSGkgVGFvdGFvLA0KPiANCj4+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8
b2xpdmVyLnNhbmdAaW50ZWwuY29tPg0KPj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9vZS1sa3AvMjAyNTA4MDgxMDI5LjM0MzE5MmVjLWxrcEBpbnRlbC5jb20NCj4NCj4gLi4uDQo+
IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1l
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX3NobWVtLmMNCj4+IGluZGV4
IGUzZDE4ODQ1NWY2Ny4uMmI1M2FhZDkxNWY1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX3NobWVtLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2dlbS9pOTE1X2dlbV9zaG1lbS5jDQo+PiBAQCAtNTE0LDYgKzUxNCwxMSBAQCBzdGF0aWMg
aW50IF9fY3JlYXRlX3NobWVtKHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICppOTE1LA0KPj4gIAlp
ZiAoSVNfRVJSKGZpbHApKQ0KPj4gIAkJcmV0dXJuIFBUUl9FUlIoZmlscCk7DQo+PiAgDQo+PiAr
CS8qDQo+PiArCSAqIFByZXZlbnQgLUVGQklHIGJ5IGFsbG93aW5nIGxhcmdlIHdyaXRlcyBiZXlv
bmQgTUFYX05PTl9MRlMgb24gc2htZW0NCj4+ICsJICogb2JqZWN0cyBieSBzZXR0aW5nIE9fTEFS
R0VGSUxFLg0KPj4gKwkgKi8NCj4+ICsJZmlscC0+Zl9mbGFncyB8PSBPX0xBUkdFRklMRTsNCj4N
Cj4gSSBkb24ndCBoYXZlIGFueXRoaW5nIGFnYWluc3QgdGhpcywgYnV0IGlzIGl0IHJlYWxseSBm
aXhpbmcgdGhlDQo+IGlzc3VlPyBJIHRob3VnaHQgdGhhdCBPX0xBUkdFRklMRSBpcyBpZ25vcmVk
IGluIDY0IGJpdCBtYWNoaW5lcywNCj4gd2hpbGUgaGVyZSB0aGUgZmFpbHVyZSBpcyBoYXBwZW5p
bmcgaW4gNjQgYml0IG1hY2hpbmVzLg0KDQpBcyBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBib2R5
LCB3aXRob3V0IE9fTEFSR0VGSUxFLCBmaWxlLT5mX29wLT53cml0ZV9pdGVyDQpjYWxscyBnZW5l
cmljX3dyaXRlX2NoZWNrX2xpbWl0cygpLCB3aGljaCBlbmZvcmNlcyB0aGUgMkdCIChNQVhfTk9O
X0xGUykgbGltaXQNCmFuZCBjYXVzZXMgLUVGQklHIG9uIGxhcmdlIHdyaXRlcy4NCg0KT24gNjQt
Yml0IHN5c3RlbXMgT19MQVJHRUZJTEUgaXMgc3RpbGwgc2V0IHdoZW4gb3BlbmluZyBmaWxlcyAo
ZS5nLiB2aWEgb3BlbigpKSwNCnNvIHdlIGFsc28gbmVlZCB0byBzZXQgaXQgaGVyZSBmb3Igc2ht
ZW0gb2JqZWN0cyBjcmVhdGVkIGluc2lkZSB0aGUga2VybmVsLg0KDQpIb3dldmVyLCBvbiBvbGRl
ciAzMi1iaXQgc3lzdGVtcywgc2V0dGluZyBPX0xBUkdFRklMRSB1bmNvbmRpdGlvbmFsbHkgbWF5
IGJlIHJpc2t5Lg0KUHJldmlvdXNseSBJIGRpZCBub3QgY2hlY2sgdGhpcywgYnV0IHRvIHJlZHVj
ZSB0aGUgcmlzayBhIHNhZmVyIGFwcHJvYWNoIGlzIHRvIHdyYXANCml0IGluIGEgY2hlY2ssIGZv
ciBleGFtcGxlOg0KDQorCWlmIChmb3JjZV9vX2xhcmdlZmlsZSgpKQ0KKwkJZmlscC0+Zl9mbGFn
cyB8PSBPX0xBUkdFRklMRTsNCg0KPg0KPiBCZXNpZGVzLCB3aGVyZSBkbyB5b3Ugc2VlIGluIHRo
ZSBMS1AgbG9ncyB0aGUgLUVGQklHIGVycm9yDQo+IG1lc3NhZ2U/DQo+DQoNCkR1ZSB0byB0aGUg
cHJldmlvdXMgcmV0dXJuIG9yZGVyIGluIHNobWVtX3B3cml0ZSgpLCB0aGlzIC1FRkJJRyB3YXMg
YmVpbmcgb3ZlcndyaXR0ZW4NCmJ5IC1FSU8gb24gc2hvcnQgd3JpdGVzLiBUaGlzIGlzc3VlIHdp
bGwgYmUgZml4ZWQgaW4gUEFUQ0ggMi8yLg0KDQpUYW90YW8NCg0KPiBBbmRpDQo+DQo+PiAgCW9i
ai0+ZmlscCA9IGZpbHA7DQo+PiAgCXJldHVybiAwOw0KPj4gIH0NCj4+IC0tIA0KPj4gMi4zNC4x
DQo=

