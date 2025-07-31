Return-Path: <linux-kernel+bounces-752272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7801AB1735E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A3E1C24411
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90691C3306;
	Thu, 31 Jul 2025 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="0S7WDM/1"
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7731A23A6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973106; cv=none; b=uwbgick2O282OFdfyJ4IvCCNuX1WJUtQx+xef7Xp3nSII83eUSSGk4/MSlrW+gGWnOPYyDdenjkZ/t26TcNuKI+5HBrhK6gBC4cVwObx9ctzsf++e5tddWpUt48TNnlbGsQ+qZoj6Pxu9wR6pgDQEwQOGrXPb+xHxW+d2F4q2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973106; c=relaxed/simple;
	bh=VbZk0naDjC8ZePWABUYhTHspPTH9PL+GPWOLLLSK6iA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ip59ts5DZS3CWmfWak2tw28zlfoIFqVgCA9t7WFQv5dyOAtHNpq/0UH1eGlqiXdyWI7EzKer5QNcKsij/p550GBXyNn0BRSvmTWA2ts5AjIJrOdnfWt6Q6e66r3lGeDDy+MLGuAtaXj7jVV+T/gVUha67MWd7VIvIjbMzfRwbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=0S7WDM/1; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 95C55208B5;
	Thu, 31 Jul 2025 16:45:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxqNI8TkhTB9; Thu, 31 Jul 2025 16:45:02 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EA7C920892;
	Thu, 31 Jul 2025 16:45:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EA7C920892
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753973102;
	bh=VbZk0naDjC8ZePWABUYhTHspPTH9PL+GPWOLLLSK6iA=;
	h=From:To:CC:Subject:Date:From;
	b=0S7WDM/1jAxNCYfcDspmt7shZjzkDIEog3adeVCoVx4Irn97uWDe72afUBvXvgacZ
	 MMl1lvrV5uuQFMGe/SzSwGldGfaQXgBso/CvFZPXmrNv06IVrLlUl5xVYsRLQ++rSm
	 Pteb4zln9cZnGkyQyRUh1FoPV0X0uxTFVBeAz6irxg2t+RuT8cPC4lI4PtYvkz8k1n
	 /o3BC46qfvRuD6mxkzZJjbi0gunnFeuUPR+v5dm6GHpQwbBa97A4KmOS7m1H+f9NvY
	 5gQ4D3TgCOHtojC4ptFCdXKUTwqWBx/gzBzHDitLDkNzSRv8JHsY+bhOt/14fUp+xP
	 E9RFlAroMhZjA==
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 31 Jul
 2025 16:45:01 +0200
Received: from EXCH-04.secunet.de (10.32.0.184) by mbx-dresden-01.secunet.de
 (10.53.40.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 16:45:00 +0200
Received: from EXCH-04.secunet.de ([fe80::f0d0:317:aa9d:ee57]) by
 EXCH-04.secunet.de ([fe80::f0d0:317:aa9d:ee57%4]) with mapi id
 15.02.1748.010; Thu, 31 Jul 2025 16:45:00 +0200
From: "Heijligen, Thomas" <thomas.heijligen@secunet.com>
To: "lee@kernel.org" <lee@kernel.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Huber, Nico" <Nico.Huber@secunet.com>, "michael.brunner@kontron.com"
	<michael.brunner@kontron.com>, "Schumann, Peter" <Peter.Schumann@secunet.com>
Subject: [PATCH v2] mfd: kempld: Switch back to earlier ->init() behavior
Thread-Topic: [PATCH v2] mfd: kempld: Switch back to earlier ->init() behavior
Thread-Index: AQHcAimwhdkzkdq2i0C0BWDAKG+E9w==
Date: Thu, 31 Jul 2025 14:45:00 +0000
Message-ID: <7d2c7e92253d851194a781720051536cca2722b8.camel@secunet.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1DB5E8229584345915CB260805D1696@secunet.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Q29tbWl0IDllMzY3NzVjMjJjNyAoIm1mZDoga2VtcGxkOiBSZW1vdmUgY3VzdG9tIERNSSBtYXRj
aGluZyBjb2RlIikNCnJlbW92ZXMgdGhlIGFiaWxpdHkgdG8gbG9hZCB0aGUgZHJpdmVyIGlmIG5v
IG1hdGNoaW5nIHN5c3RlbSBETUkgZGF0YQ0KaXMgZm91bmQuIEJlZm9yZSB0aGlzIGNvbW1pdCB0
aGUgZHJpdmVyIGNvdWxkIGJlIGxvYWRlZCB1c2luZw0KYWx0ZXJuYXRpdmUgbWV0aG9kcyBzdWNo
IGFzIEFDUEkgb3IgYGZvcmNlX2RldmljZV9pZGAgaW4gdGhlIGFic2VuY2UNCm9mIGEgbWF0Y2hp
bmcgc3lzdGVtIERNSSBlbnRyeS4NCg0KUmVzdG9yZSB0aGlzIGFiaWxpdHkgd2hpbGUga2VlcGlu
ZyB0aGUgcmVmYWN0b3JlZA0KYHBsYXRmb3JtX2RldmljZV9pbmZvYCB0YWJsZS4NCg0KU2lnbmVk
LW9mZi1ieTogVGhvbWFzIEhlaWpsaWdlbiA8dGhvbWFzLmhlaWpsaWdlbkBzZWN1bmV0LmNvbT4N
ClJldmlld2VkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4Lmlu
dGVsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbWZkL2tlbXBsZC1jb3JlLmMgfCAzMiArKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCsp
LCAxNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL2tlbXBsZC1jb3Jl
LmMgYi9kcml2ZXJzL21mZC9rZW1wbGQtY29yZS5jDQppbmRleCBjNWJmYjY0NDBhOTMuLjc3OTgw
YzdmYzMxZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWZkL2tlbXBsZC1jb3JlLmMNCisrKyBiL2Ry
aXZlcnMvbWZkL2tlbXBsZC1jb3JlLmMNCkBAIC03NzksMjIgKzc3OSwyNiBAQCBNT0RVTEVfREVW
SUNFX1RBQkxFKGRtaSwga2VtcGxkX2RtaV90YWJsZSk7DQogc3RhdGljIGludCBfX2luaXQga2Vt
cGxkX2luaXQodm9pZCkNCiB7DQogCWNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkICppZDsNCi0J
aW50IHJldCA9IC1FTk9ERVY7DQogDQotCWZvciAoaWQgPSBkbWlfZmlyc3RfbWF0Y2goa2VtcGxk
X2RtaV90YWJsZSk7IGlkOyBpZCA9IGRtaV9maXJzdF9tYXRjaChpZCArIDEpKSB7DQotCQkvKiBD
aGVjaywgaWYgdXNlciBhc2tlZCBmb3IgdGhlIGV4YWN0IGRldmljZSBJRCBtYXRjaCAqLw0KLQkJ
aWYgKGZvcmNlX2RldmljZV9pZFswXSAmJiAhc3Ryc3RyKGlkLT5pZGVudCwgZm9yY2VfZGV2aWNl
X2lkKSkNCi0JCQljb250aW51ZTsNCi0NCi0JCXJldCA9IGtlbXBsZF9jcmVhdGVfcGxhdGZvcm1f
ZGV2aWNlKCZrZW1wbGRfcGxhdGZvcm1fZGF0YV9nZW5lcmljKTsNCi0JCWlmIChyZXQpDQotCQkJ
Y29udGludWU7DQotDQotCQlicmVhazsNCisJLyoNCisJICogVGhpcyBjdXN0b20gRE1JIGl0ZXJh
dGlvbiBhbGxvd3MgdGhlIGRyaXZlciB0byBiZSBpbml0aWFsaXplZCBpbiB0aHJlZSB3YXlzOg0K
KwkgKiAtIFdoZW4gYSBmb3JjZWRfZGV2aWNlX2lkIHN0cmluZyBtYXRjaGVzIGFueSBpZGVudCBp
biB0aGUga2VtcGxkX2RtaV90YWJsZSwNCisJICogICByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhl
IERNSSBkZXZpY2UgaXMgcHJlc2VudCBpbiB0aGUgc3lzdGVtIGRtaSB0YWJsZS4NCisJICogLSBX
aGVuIGEgbWF0Y2hpbmcgZW50cnkgaXMgcHJlc2VudCBpbiB0aGUgRE1JIHN5c3RlbSB0YWJlLg0K
KwkgKiAtIFRocm91Z2ggYWx0ZXJuYXRpdmUgbWVjaGFuaXNtcyBsaWtlIEFDUEkuDQorCSAqLw0K
KwlpZiAoZm9yY2VfZGV2aWNlX2lkWzBdKSB7DQorCQlmb3IgKGlkID0ga2VtcGxkX2RtaV90YWJs
ZTsgaWQtPm1hdGNoZXNbMF0uc2xvdCAhPSBETUlfTk9ORTsgaWQrKykNCisJCQlpZiAoc3Ryc3Ry
KGlkLT5pZGVudCwgZm9yY2VfZGV2aWNlX2lkKSkNCisJCQkJaWYgKCFrZW1wbGRfY3JlYXRlX3Bs
YXRmb3JtX2RldmljZSgma2VtcGxkX3BsYXRmb3JtX2RhdGFfZ2VuZXJpYykpDQorCQkJCQlicmVh
azsNCisJCWlmIChpZC0+bWF0Y2hlc1swXS5zbG90ID09IERNSV9OT05FKQ0KKwkJCXJldHVybiAt
RU5PREVWOw0KKwl9IGVsc2Ugew0KKwkJZm9yIChpZCA9IGRtaV9maXJzdF9tYXRjaChrZW1wbGRf
ZG1pX3RhYmxlKTsgaWQ7IGlkID0gZG1pX2ZpcnN0X21hdGNoKGlkKzEpKQ0KKwkJCWlmIChrZW1w
bGRfY3JlYXRlX3BsYXRmb3JtX2RldmljZSgma2VtcGxkX3BsYXRmb3JtX2RhdGFfZ2VuZXJpYykp
DQorCQkJCWJyZWFrOw0KIAl9DQotCWlmIChyZXQpDQotCQlyZXR1cm4gcmV0Ow0KLQ0KIAlyZXR1
cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZrZW1wbGRfZHJpdmVyKTsNCiB9DQogDQotLSAN
CjIuNTAuMA0KDQo=

