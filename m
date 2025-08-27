Return-Path: <linux-kernel+bounces-787638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B5DB378FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EE8204704
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2766273D6F;
	Wed, 27 Aug 2025 04:14:01 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922003BB44
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756268041; cv=none; b=ScjsTZoHlpqKcMcDjSsqm/HBbGl/YSmbTxRFpNlKPrDnWtyJYhTW78SrNr6CF5UzB4Mc2QOac4/QMLB266kD73oNmhNgTpm/kaJ6Cyvpn+Ezs/4AIf27b/Lgis0bN5Dv3C9bSnQuXaGBVmqNnSiZOI9Lo0pujsCYe2AzhEE5A8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756268041; c=relaxed/simple;
	bh=FwKGMJa1YOKpFW+ky8zIIrquwgW58xBTUeC+8VrZPms=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NRknw042cpjbdsrqsDUTzT5Mv3Dt+L6ygbtRZnAePZCaEgMayUdMhtDiBtBAFZg4LapxCVE59CLm8Lp91SUWWj4Ii/Sd6s/xXdsLzP3MHp9/D19vOzMqcLffPSvzVqSjS++fKgc6xS4rl4yZG5gpSie0ntr1e28XPi6E2rdo8nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: David Hildenbrand <david@redhat.com>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "osalvador@suse.de" <osalvador@suse.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "giorgitchankvetadze1997@gmail.com"
	<giorgitchankvetadze1997@gmail.com>
CC: "Xu,Wenjie(ACG CCN)" <xuwenjie04@baidu.com>
Subject: RE:  Re: [PATCH] mm/hugetlb: two-phase hugepage allocation when
 reservation is high
Thread-Topic: Re: [PATCH] mm/hugetlb: two-phase hugepage allocation when
 reservation is high
Thread-Index: AdwXCKQKyZG+t/+FSoO+KsNcdGLEBA==
Date: Wed, 27 Aug 2025 04:12:48 +0000
Message-ID: <33c9676b1fda4cbaa42857787e03c7ec@baidu.com>
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
X-FEAS-Client-IP: 172.31.4.11
X-FE-Policy-ID: 52:10:53:SYSTEM

DQouDQo+IA0KPiBBbHNvLCBjYW4ndCB3ZSBmYWlsIGxpZ2h0bHkgZHVyaW5nIHRoZSBmaXJzdCBh
dHRlbXB0IGFuZCBkeW5hbWljYWxseSBkZWNpZGUgaWYgd2UNCj4gc2hvdWxkIGRvIGEgc2Vjb25k
IHBhc2U/DQo+IA0KDQoNCkdvb2QgaWRlYSwgbGlrZSBiZWxvdw0KDQpkaWZmIC0tZ2l0IGEvbW0v
aHVnZXRsYi5jIGIvbW0vaHVnZXRsYi5jDQppbmRleCA3NTNmOTliLi40MjVhNzU5IDEwMDY0NA0K
LS0tIGEvbW0vaHVnZXRsYi5jDQorKysgYi9tbS9odWdldGxiLmMNCkBAIC0zNTg5LDYgKzM1ODks
NyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBfX2luaXQgaHVnZXRsYl9wYWdlc19hbGxvY19ib290
KHN0cnVjdCBoc3RhdGUgKmgpDQoNCiAgICAgICAgdW5zaWduZWQgbG9uZyBqaWZmaWVzX3N0YXJ0
Ow0KICAgICAgICB1bnNpZ25lZCBsb25nIGppZmZpZXNfZW5kOw0KKyAgICAgICB1bnNpZ25lZCBs
b25nIHJlbWFpbmluZzsNCg0KICAgICAgICBqb2IudGhyZWFkX2ZuICAgPSBodWdldGxiX3BhZ2Vz
X2FsbG9jX2Jvb3Rfbm9kZTsNCiAgICAgICAgam9iLnN0YXJ0ICAgICAgID0gMDsNCkBAIC0zNjIw
LDYgKzM2MjEsMTggQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgX19pbml0IGh1Z2V0bGJfcGFnZXNf
YWxsb2NfYm9vdChzdHJ1Y3QgaHN0YXRlICpoKQ0KDQogICAgICAgIGppZmZpZXNfc3RhcnQgPSBq
aWZmaWVzOw0KICAgICAgICBwYWRhdGFfZG9fbXVsdGl0aHJlYWRlZCgmam9iKTsNCisNCisgICAg
ICAgaWYgKGgtPm5yX2h1Z2VfcGFnZXMgIT0gaC0+bWF4X2h1Z2VfcGFnZXMgJiYgaHVnZXRsYl92
bWVtbWFwX29wdGltaXphYmxlKGgpKSB7DQorICAgICAgICAgICAgICAgcmVtYWluaW5nID0gaC0+
bWF4X2h1Z2VfcGFnZXMgLSBoLT5ucl9odWdlX3BhZ2VzOw0KKyAgICAgICAgICAgICAgIC8qIHZt
ZW1tYXAgb3B0aW1pemF0aW9uIGNhbiBzYXZlIGFib3V0IDEuNiUgKDQvMjUwKSBtZW1vcnkgKi8N
CisgICAgICAgICAgICAgICByZW1haW5pbmcgPSBtaW4ocmVtYWluaW5nLCAoaC0+bnJfaHVnZV9w
YWdlcyAqIDQgLyAyNTApKTsNCisNCisgICAgICAgICAgICAgICBqb2Iuc3RhcnQgICAgICAgPSBo
LT5ucl9odWdlX3BhZ2VzOw0KKyAgICAgICAgICAgICAgIGpvYi5zaXplICAgICAgICA9IHJlbWFp
bmluZzsNCisgICAgICAgICAgICAgICBqb2IubWluX2NodW5rICAgPSByZW1haW5pbmcgLyBodWdl
cGFnZV9hbGxvY2F0aW9uX3RocmVhZHM7DQorICAgICAgICAgICAgICAgcGFkYXRhX2RvX211bHRp
dGhyZWFkZWQoJmpvYik7DQorICAgICAgIH0NCg0KVGhhbmtzDQoNCi1MaQ0KDQo+IC0tDQo+IENo
ZWVycw0KPiANCj4gRGF2aWQgLyBkaGlsZGVuYg0KDQo=

