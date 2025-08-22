Return-Path: <linux-kernel+bounces-781013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0C2B30C46
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76B77B25A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57333274FDE;
	Fri, 22 Aug 2025 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="Kmfe9i89"
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AC286268C73
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832049; cv=none; b=CHG+Qomm6G4Buo1aQd2Ni7ByyTY/cR7OnbeZiFxyMMHFG42ERyXxnmaq80T9vC63nn/G/AKHMnDpRSg2S3FOIWVwIew9yfE833PqxFxkGneIoFcE9DpDEq1VsY0Qr9YT2lNE4f2Rvr9HV4rsLwyKc7v8H3jlgk8j9OwK65SkeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832049; c=relaxed/simple;
	bh=AI2NXEuZSrXFyuXRU2Crhiyj9UAYepnZ6UFWCV6Y56s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DMB10S6So0MBgSOuDK1GOC2h72PmxqYP1VgiOtqovWu/V3D0zQEnZGgeoTJ/BWah0XRUnASTjZXfAgHly4u3UQpxrgKPNosmd71z9JY1TsAq2+V71Zn0dRS0YT/hhzAYGzF0QTIMuuTnktp4+LAk7LXbOCd6dJFyvoY+2MIY46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=Kmfe9i89; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.20])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id C1CB418A9E0289;
	Fri, 22 Aug 2025 11:06:08 +0800 (CST)
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ02-ACTMBX-02.didichuxing.com (10.79.65.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 22 Aug 2025 11:07:00 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 22 Aug 2025 11:06:59 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Fri, 22 Aug 2025 11:06:59 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.65.20
From: =?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
To: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
	<tursulin@ursulin.net>, "andi.shyti@linux.intel.com"
	<andi.shyti@linux.intel.com>
CC: "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "chentao325@qq.com" <chentao325@qq.com>,
	=?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>, "kernel
 test robot" <oliver.sang@intel.com>
Subject: [PATCH v2 1/2] drm/i915: set O_LARGEFILE in __create_shmem()
Thread-Topic: [PATCH v2 1/2] drm/i915: set O_LARGEFILE in __create_shmem()
Thread-Index: AQHcExHTV6aknsehhUav66+J8g4nVQ==
Date: Fri, 22 Aug 2025 03:06:59 +0000
Message-ID: <20250822030651.28099-1-chentaotao@didiglobal.com>
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
	s=2025; t=1755831980;
	bh=AI2NXEuZSrXFyuXRU2Crhiyj9UAYepnZ6UFWCV6Y56s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=Kmfe9i89SD/NHI0zQwebi3n3VqJlroo2ggQQApJqoAnM3ytME55iZ6rrZRk6d4N5F
	 aSaSDycAQDmjBmY8XhcVpFdv8oVZIwY1+abKyTkQmBO4QyyVijsMn3HKSIwrcbw3Kn
	 LYTbEr6prts9d33j5FOQU9zSP7wHMggBg/7nrdb4=

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
YW9AZGlkaWdsb2JhbC5jb20+DQotLS0NCnYyOg0KIC0gQWRkIGZvcmNlX29fbGFyZ2VmaWxlKCkg
Z3VhcmQgYmVmb3JlIHNldHRpbmcgT19MQVJHRUZJTEUNCg0KIGRyaXZlcnMvZ3B1L2RybS9pOTE1
L2dlbS9pOTE1X2dlbV9zaG1lbS5jIHwgNyArKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVf
Z2VtX3NobWVtLmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fc2htZW0uYw0K
aW5kZXggZTNkMTg4NDU1ZjY3Li5iOWRhZTE1YzFkMTYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fc2htZW0uYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5
MTUvZ2VtL2k5MTVfZ2VtX3NobWVtLmMNCkBAIC01MTQsNiArNTE0LDEzIEBAIHN0YXRpYyBpbnQg
X19jcmVhdGVfc2htZW0oc3RydWN0IGRybV9pOTE1X3ByaXZhdGUgKmk5MTUsDQogCWlmIChJU19F
UlIoZmlscCkpDQogCQlyZXR1cm4gUFRSX0VSUihmaWxwKTsNCiANCisJLyoNCisJICogUHJldmVu
dCAtRUZCSUcgYnkgYWxsb3dpbmcgbGFyZ2Ugd3JpdGVzIGJleW9uZCBNQVhfTk9OX0xGUyBvbiBz
aG1lbQ0KKwkgKiBvYmplY3RzIGJ5IHNldHRpbmcgT19MQVJHRUZJTEUuDQorCSAqLw0KKwlpZiAo
Zm9yY2Vfb19sYXJnZWZpbGUoKSkNCisJCWZpbHAtPmZfZmxhZ3MgfD0gT19MQVJHRUZJTEU7DQor
DQogCW9iai0+ZmlscCA9IGZpbHA7DQogCXJldHVybiAwOw0KIH0NCi0tIA0KMi4zNC4xDQo=

