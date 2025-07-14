Return-Path: <linux-kernel+bounces-730397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93AB04402
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A99A7B49C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA14261581;
	Mon, 14 Jul 2025 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="lDPI4d+b"
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E57B26136D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506842; cv=none; b=rCCipdbRrUmMO1pvYPxdtyTCYHFuOXjz9Da/DTgHsDdgz+pm8K1GR9emAG6VsaQgq0nXi9YvrONEc+fr9AnBYOf6hovo4cJarTi24sw09DL6CoCf1/uuymhbA+BAl17yI+AncwkrfhEGD69+aIpg30lE3VSPmVfRYOslwQUmYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506842; c=relaxed/simple;
	bh=VhISQusA4JxiQyLFqdYM75SPbIGJqEPE0o6W49XMvhU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=STvYuWLvY5whJOFyKI8DE4UBIiGlH9p1s90H7h4KNi1Z933a2ZM/8GLslZbHjWmlU5FAqV3EiXw0IK6D2AfA3SthcDPTpug9q2RRmqqzrvvJ5Rfoa+xjQRDkv6RSoeiLYTTV6V1HRDmb9VubLed5f40goeVJzU3ljIB4NG/RgSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=lDPI4d+b; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D7C532050A;
	Mon, 14 Jul 2025 17:27:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z4sMKxBn-z8T; Mon, 14 Jul 2025 17:27:16 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4BAB220189;
	Mon, 14 Jul 2025 17:27:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4BAB220189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1752506836;
	bh=VhISQusA4JxiQyLFqdYM75SPbIGJqEPE0o6W49XMvhU=;
	h=From:To:CC:Subject:Date:From;
	b=lDPI4d+bBnEQ1QXRAHNaqclaZkU6pg50UCIMOaOzcsIowpHpc0F+bVmpGAiniYU5/
	 mgzK9h7+eJhyTDH3Qc94sj6xne4QGVdUej1n3LzIP5vb1gW79SHzGNxL1BfZQ6LsRW
	 dm56H0RC2iF90bsQ/1GTipw7MNaYRbqQbNPJJAe6qLZoRYT/yMrC5/o+nt1Wzubqup
	 Gevy5RmVEwWbDfySZlOwoxwSVny2GdkuctQ/+GvOGVehJmPVQtnIbl/yD2VL8xshhO
	 8gvlD5915WnEXbDScNVseLb4NbJiHZTaLugNVbVdjzWO1T6nDgUJxQk+OzeVhpTw2k
	 IUGzF6B2lM+3g==
Received: from EXCH-04.secunet.de (10.32.0.184) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 14 Jul
 2025 17:27:15 +0200
Received: from EXCH-04.secunet.de ([fe80::f0d0:317:aa9d:ee57]) by
 EXCH-04.secunet.de ([fe80::f0d0:317:aa9d:ee57%4]) with mapi id
 15.02.1748.010; Mon, 14 Jul 2025 17:27:06 +0200
From: "Heijligen, Thomas" <thomas.heijligen@secunet.com>
To: "lee@kernel.org" <lee@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Huber, Nico" <Nico.Huber@secunet.com>, "michael.brunner@kontron.com"
	<michael.brunner@kontron.com>, "Schumann, Peter" <Peter.Schumann@secunet.com>
Subject: [PATCH] mfd: kempld: Switch back to earlier ->init() behavior
Thread-Topic: [PATCH] mfd: kempld: Switch back to earlier ->init() behavior
Thread-Index: AQHb9NPB/wnq4hn0ZUu7P6EQBYYsOw==
Date: Mon, 14 Jul 2025 15:27:06 +0000
Message-ID: <71883d70d1b99f58c96ba1b0016751f41519025b.camel@secunet.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E9EE9A97BCD764FA20E32CC4F4F7C21@secunet.com>
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
Ci0tLQ0KIGRyaXZlcnMvbWZkL2tlbXBsZC1jb3JlLmMgfCAyNSArKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQva2VtcGxkLWNvcmUuYyBiL2RyaXZlcnMvbWZk
L2tlbXBsZC1jb3JlLmMNCmluZGV4IGM1YmZiNjQ0MGE5My4uYjBkZGNlYWUzODY0IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9tZmQva2VtcGxkLWNvcmUuYw0KKysrIGIvZHJpdmVycy9tZmQva2VtcGxk
LWNvcmUuYw0KQEAgLTc3OSwyMiArNzc5LDE5IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUoZG1pLCBr
ZW1wbGRfZG1pX3RhYmxlKTsNCiBzdGF0aWMgaW50IF9faW5pdCBrZW1wbGRfaW5pdCh2b2lkKQ0K
IHsNCiAJY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgKmlkOw0KLQlpbnQgcmV0ID0gLUVOT0RF
VjsNCiANCi0JZm9yIChpZCA9IGRtaV9maXJzdF9tYXRjaChrZW1wbGRfZG1pX3RhYmxlKTsgaWQ7
IGlkID0gZG1pX2ZpcnN0X21hdGNoKGlkICsgMSkpIHsNCi0JCS8qIENoZWNrLCBpZiB1c2VyIGFz
a2VkIGZvciB0aGUgZXhhY3QgZGV2aWNlIElEIG1hdGNoICovDQotCQlpZiAoZm9yY2VfZGV2aWNl
X2lkWzBdICYmICFzdHJzdHIoaWQtPmlkZW50LCBmb3JjZV9kZXZpY2VfaWQpKQ0KLQkJCWNvbnRp
bnVlOw0KLQ0KLQkJcmV0ID0ga2VtcGxkX2NyZWF0ZV9wbGF0Zm9ybV9kZXZpY2UoJmtlbXBsZF9w
bGF0Zm9ybV9kYXRhX2dlbmVyaWMpOw0KLQkJaWYgKHJldCkNCi0JCQljb250aW51ZTsNCi0NCi0J
CWJyZWFrOw0KKwlpZiAoZm9yY2VfZGV2aWNlX2lkWzBdKSB7DQorCQlmb3IgKGlkID0ga2VtcGxk
X2RtaV90YWJsZTsgaWQtPm1hdGNoZXNbMF0uc2xvdCAhPSBETUlfTk9ORTsgaWQrKykNCisJCQlp
ZiAoc3Ryc3RyKGlkLT5pZGVudCwgZm9yY2VfZGV2aWNlX2lkKSkNCisJCQkJaWYgKCFrZW1wbGRf
Y3JlYXRlX3BsYXRmb3JtX2RldmljZSgma2VtcGxkX3BsYXRmb3JtX2RhdGFfZ2VuZXJpYykpDQor
CQkJCQlicmVhazsNCisJCWlmIChpZC0+bWF0Y2hlc1swXS5zbG90ID09IERNSV9OT05FKQ0KKwkJ
CXJldHVybiAtRU5PREVWOw0KKwl9IGVsc2Ugew0KKwkJZm9yIChpZCA9IGRtaV9maXJzdF9tYXRj
aChrZW1wbGRfZG1pX3RhYmxlKTsgaWQ7IGlkID0gZG1pX2ZpcnN0X21hdGNoKGlkKzEpKQ0KKwkJ
CWlmIChrZW1wbGRfY3JlYXRlX3BsYXRmb3JtX2RldmljZSgma2VtcGxkX3BsYXRmb3JtX2RhdGFf
Z2VuZXJpYykpDQorCQkJCWJyZWFrOw0KIAl9DQotCWlmIChyZXQpDQotCQlyZXR1cm4gcmV0Ow0K
LQ0KIAlyZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZrZW1wbGRfZHJpdmVyKTsNCiB9
DQogDQotLSANCjIuNDkuMA0KDQo=

