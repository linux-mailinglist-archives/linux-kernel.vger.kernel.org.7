Return-Path: <linux-kernel+bounces-762236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62836B203CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DA71888487
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFC02DCF5C;
	Mon, 11 Aug 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="TPJLkk3c"
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E97E621FF44
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904855; cv=none; b=N/Jzgccd6q7DZ0r3VxXr4VLm3f3StAG0PaPpRo4evqUKWQykR4Ul6xv+OHBpFeXVYGOcbERFo9dJKz7lQFjT2v2HvU3S042KPoXXUoaxi3WK3ZaGbLCCev02KCDTPJlQxQ46u08q+nU/pRIDeKzcSl0HQdG0WPxTh2LsYA/V+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904855; c=relaxed/simple;
	bh=tbYqQ6dZ2UtNUjKP1xA+5JsyeFVSnoKQ9wVK4d6xk9U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MGcN+czELDbVPowfK9sVQHtRokXDJUwhr4YdY5QNiqxynfGsXEs6QhNvnL66lVIRYJ/JIgz0rtOMFRgbuvI6Ax46YRUqKgzpSsniTqyVTq/DUN14CaKMxpoVHid2Fw03qUQ3Rj0LYIb2oNRkaCjRa1TXusrxEnamOp/xHF2yYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=TPJLkk3c; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.38])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 5AAD5198EB986C;
	Mon, 11 Aug 2025 17:30:14 +0800 (CST)
Received: from BJ02-ACTMBX-07.didichuxing.com (10.79.65.14) by
 BJ03-ACTMBX-02.didichuxing.com (10.79.71.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 17:30:55 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ02-ACTMBX-07.didichuxing.com (10.79.65.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 17:30:55 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Mon, 11 Aug 2025 17:30:55 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.71.38
From: =?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
To: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
	<tursulin@ursulin.net>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, "lkp@intel.com"
	<lkp@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"oliver.sang@intel.com" <oliver.sang@intel.com>,
	=?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Subject: [PATCH 1/2] drm/i915: set O_LARGEFILE in __create_shmem()
Thread-Topic: [PATCH 1/2] drm/i915: set O_LARGEFILE in __create_shmem()
Thread-Index: AQHcCqKjb8Z7QwCk60q7byo9M7F7ng==
Date: Mon, 11 Aug 2025 09:30:55 +0000
Message-ID: <20250811093050.38930-1-chentaotao@didiglobal.com>
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
	s=2025; t=1754904618;
	bh=tbYqQ6dZ2UtNUjKP1xA+5JsyeFVSnoKQ9wVK4d6xk9U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=TPJLkk3ce9eO10IlTEyeS/cPeR1CTfjA8zYCUaNaQkWcwsfv4iSXEvizyvaMQIxLV
	 MwiIUbLh7H37Uk/dY/GVKOFaPvakeWH1ErfzqmA85hCTmnhZV7gmWmuISqsboD+E2k
	 ZiJyye10z0rZpabbEfnDdlsAyrf4tECyNc8K2uKg=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNCldpdGhvdXQg
T19MQVJHRUZJTEUsIGZpbGUtPmZfb3AtPndyaXRlX2l0ZXIgY2FsbHMNCmdlbmVyaWNfd3JpdGVf
Y2hlY2tfbGltaXRzKCksIHdoaWNoIGVuZm9yY2VzIGEgMkdCIChNQVhfTk9OX0xGUykgbGltaXQs
DQpjYXVzaW5nIC1FRkJJRyBvbiBsYXJnZSB3cml0ZXMuDQoNCkluIHNobWVtX3B3cml0ZSgpLCB0
aGlzIGVycm9yIGlzIGxhdGVyIG1hc2tlZCBhcyAtRUlPIGR1ZSB0byB0aGUgZXJyb3INCmhhbmRs
aW5nIG9yZGVyLCBsZWFkaW5nIHRvIGlndCBmYWlsdXJlcyBsaWtlIGdlbjlfZXhlY19wYXJzZShi
Yi1sYXJnZSkuDQoNClNldCBPX0xBUkdFRklMRSBpbiBfX2NyZWF0ZV9zaG1lbSgpIHRvIHByZXZl
bnQgLUVGQklHIG9uIGxhcmdlIHdyaXRlcy4NCg0KUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJv
Ym90IDxvbGl2ZXIuc2FuZ0BpbnRlbC5jb20+DQpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL29lLWxrcC8yMDI1MDgwODEwMjkuMzQzMTkyZWMtbGtwQGludGVsLmNvbQ0KRml4ZXM6IDA0
ODgzMmEzZjQwMCAoImRybS9pOTE1OiBSZWZhY3RvciBzaG1lbV9wd3JpdGUoKSB0byB1c2Uga2lv
Y2IgYW5kIHdyaXRlX2l0ZXIiKQ0KU2lnbmVkLW9mZi1ieTogVGFvdGFvIENoZW4gPGNoZW50YW90
YW9AZGlkaWdsb2JhbC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9n
ZW1fc2htZW0uYyB8IDUgKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fc2htZW0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1lbS5jDQppbmRleCBlM2QxODg0
NTVmNjcuLjJiNTNhYWQ5MTVmNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dl
bS9pOTE1X2dlbV9zaG1lbS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9n
ZW1fc2htZW0uYw0KQEAgLTUxNCw2ICs1MTQsMTEgQEAgc3RhdGljIGludCBfX2NyZWF0ZV9zaG1l
bShzdHJ1Y3QgZHJtX2k5MTVfcHJpdmF0ZSAqaTkxNSwNCiAJaWYgKElTX0VSUihmaWxwKSkNCiAJ
CXJldHVybiBQVFJfRVJSKGZpbHApOw0KIA0KKwkvKg0KKwkgKiBQcmV2ZW50IC1FRkJJRyBieSBh
bGxvd2luZyBsYXJnZSB3cml0ZXMgYmV5b25kIE1BWF9OT05fTEZTIG9uIHNobWVtDQorCSAqIG9i
amVjdHMgYnkgc2V0dGluZyBPX0xBUkdFRklMRS4NCisJICovDQorCWZpbHAtPmZfZmxhZ3MgfD0g
T19MQVJHRUZJTEU7DQogCW9iai0+ZmlscCA9IGZpbHA7DQogCXJldHVybiAwOw0KIH0NCi0tIA0K
Mi4zNC4xDQo=

