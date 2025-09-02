Return-Path: <linux-kernel+bounces-795827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FFCB3F86B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7177E484CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5062E719E;
	Tue,  2 Sep 2025 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RXUuFFtf"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B52737F6;
	Tue,  2 Sep 2025 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801911; cv=none; b=uLpp0I2GRZJo0w2ORDFgSsEixEPB5axzyYr7NULkqCgzthInUVReS1bePykh4c3Z8/fGOTAIxUcy0rUY+WIPSUHQj+gS8TubZo9vrIX50j+3T8W1xjDJ9jMHftEmFbE3Y/lVfBo4BZjpnCYyceIx1OQyeUrzJlcmLPbNtFCTLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801911; c=relaxed/simple;
	bh=i2QiLtqWqg6SM7I15TzWMTxBQAT18V4p+lC4F4CWE9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=V/Yk655X39sGGlOjeM6SEaaOfeYDYGICbS3KTS9Wq5l7S3Ogo4oz8HqQNDpYuoRZMJ5ACKsx/URcW37x+405iimXMIfDaiyTp1gWGHFlfWoSP0PzHmpU3YLxsGgQ8YBb7PEW5Xv45zVPL45lq7LCc9sBvSO/RYNtrHKj3GWiYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RXUuFFtf; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=i2QiLtqWqg6SM7I15TzWMTxBQAT18V4p+lC4F4CWE9s=; b=R
	XUuFFtfqFvKKkW7RVEg4oabugQR8qY3mOYnQIH6/w7vYDVowSLchVSITq4ycqGAa
	n1pKO696jn7ich9EcUmxyapkWDCqiaRQOwjnbbqoyjAp6+NK/YHF/zK4U/PpAXNW
	6dJi4dl+dAZ2JY8xPDukvt46e7z+89BbgFVULopmbk=
Received: from 00107082$163.com ( [111.35.190.191] ) by
 ajax-webmail-wmsvr-40-104 (Coremail) ; Tue, 2 Sep 2025 16:30:48 +0800 (CST)
Date: Tue, 2 Sep 2025 16:30:48 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Michal Pecio" <michal.pecio@gmail.com>
Cc: "Mathias Nyman" <mathias.nyman@linux.intel.com>,
	WeitaoWang-oc@zhaoxin.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, surenb@google.com,
	kent.overstreet@linux.dev
Subject: Re:[PATCH] usb: xhci: Fix xhci_free_virt_devices_depth_first()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250902093017.13d6c666.michal.pecio@gmail.com>
References: <20250829181354.4450-1-00107082@163.com>
 <20250830114828.3dd8ed56.michal.pecio@gmail.com>
 <5051e27a.2ba3.198fa7b5f31.Coremail.00107082@163.com>
 <f9476552-a6dc-4f1c-91da-b15c8f0d9844@linux.intel.com>
 <20250902093017.13d6c666.michal.pecio@gmail.com>
X-NTES-SC: AL_Qu2eBPSbvkAv7imZZekXn0oTju85XMCzuv8j3YJeN500tiTdwhoNcW9+JFv/4s6PNAqhoAi8eRhDzsJ4Q45jTY2kkaBwaK7P0QMh5334Ouwz
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <446082a4.7dbe.199098cd654.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aCgvCgDX_4k5q7ZoFJwnAA--.2282W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEhC7qmi2GIvzBQADsr
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNS0wOS0wMiAxNTozMDoxNywgIk1pY2hhbCBQZWNpbyIgPG1pY2hhbC5wZWNpb0BnbWFp
bC5jb20+IHdyb3RlOgo+UmV1c2luZyAndmRldicgZm9yIGl0ZXJhdGlvbiBjYXVzZWQgYSByZWNl
bnQgY29tbWl0IHRvIG1hbGZ1bmN0aW9uCj51ZXhwZWN0ZWRseSwgcmVzdWx0aW5nIGluIGEgcmVw
b3J0ZWQgbWVtb3J5IGxlYWsgYW5kIHBvdGVudGlhbCBVQUYKPmlmIGRldmljZXMgYXJlIGZyZWVk
IGluIGJhZCBvcmRlci4gVXNpbmcgYSBzZWNvbmQgdmFyaWFibGUgc29sdmVzCj50aGlzIHByb2Js
ZW0sIGFuZCBtYXliZSBvdGhlcnMgbGF0ZXIuCj4KPkhDU19NQVhfU0xPVFMoeGhjaS0+aGNzX3Bh
cmFtczEpIGlzIHRoZSBoaWdoZXN0IHBvc3NpYmxlIHNsb3RfaWQsCj5zbyBjaGFuZ2UgdGhlIGl0
ZXJhdGlvbiByYW5nZSB0byBpbmNsdWRlIGl0LiBDdXJyZW50bHkgdGhpcyBkb2Vzbid0Cj5zZWVt
IHRvIGNhdXNlIHByb2JsZW1zIGJlY2F1c2UgdGhlIG9ubHkgY2FsbGVyIGJlZ2lucyB3aXRoIGZy
ZWVpbmcKPnRoZSB0b3Btb3N0IHNsb3RfaWQsIGJ1dCBpdCBicmVha3MgZG9jdW1lbnRlZCBmdW5j
dGlvbmFsaXR5Lgo+Cj5SZXBvcnRlZC1ieTogRGF2aWQgV2FuZyA8MDAxMDcwODJAMTYzLmNvbT4K
PkNsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjUwODI5MTgxMzU0
LjQ0NTAtMS0wMDEwNzA4MkAxNjMuY29tLwo+Rml4ZXM6IDJlYjAzMzc2MTUxYiAoInVzYjogeGhj
aTogRml4IHNsb3RfaWQgcmVzb3VyY2UgcmFjZSBjb25mbGljdCIpCj5GaXhlczogZWU4NjY1ZTI4
ZThkICgieGhjaTogZnJlZSB4aGNpIHZpcnR1YWwgZGV2aWNlcyB3aXRoIGxlYWYgbm9kZXMgZmly
c3QiKQo+Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPlNpZ25lZC1vZmYtYnk6IE1pY2hhbCBQ
ZWNpbyA8bWljaGFsLnBlY2lvQGdtYWlsLmNvbT4KPi0tLQo+IGRyaXZlcnMvdXNiL2hvc3QveGhj
aS1tZW0uYyB8IDggKysrKy0tLS0KPiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW1lbS5j
IGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW1lbS5jCj5pbmRleCBlZWQ1OTI2YjIwMGUuLmRiN2Rj
NzBjMzdlNSAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tZW0uYwo+KysrIGIv
ZHJpdmVycy91c2IvaG9zdC94aGNpLW1lbS5jCj5AQCAtOTMyLDcgKzkzMiw3IEBAIHZvaWQgeGhj
aV9mcmVlX3ZpcnRfZGV2aWNlKHN0cnVjdCB4aGNpX2hjZCAqeGhjaSwgc3RydWN0IHhoY2lfdmly
dF9kZXZpY2UgKmRldiwKPiAgKi8KPiBzdGF0aWMgdm9pZCB4aGNpX2ZyZWVfdmlydF9kZXZpY2Vz
X2RlcHRoX2ZpcnN0KHN0cnVjdCB4aGNpX2hjZCAqeGhjaSwgaW50IHNsb3RfaWQpCj4gewo+LQlz
dHJ1Y3QgeGhjaV92aXJ0X2RldmljZSAqdmRldjsKPisJc3RydWN0IHhoY2lfdmlydF9kZXZpY2Ug
KnZkZXYsICp2ZGV2X2k7Cj4gCXN0cnVjdCBsaXN0X2hlYWQgKnR0X2xpc3RfaGVhZDsKPiAJc3Ry
dWN0IHhoY2lfdHRfYndfaW5mbyAqdHRfaW5mbywgKm5leHQ7Cj4gCWludCBpOwo+QEAgLTk1MSw5
ICs5NTEsOSBAQCBzdGF0aWMgdm9pZCB4aGNpX2ZyZWVfdmlydF9kZXZpY2VzX2RlcHRoX2ZpcnN0
KHN0cnVjdCB4aGNpX2hjZCAqeGhjaSwgaW50IHNsb3RfaQo+IAkJLyogaXMgdGhpcyBhIGh1YiBk
ZXZpY2UgdGhhdCBhZGRlZCBhIHR0X2luZm8gdG8gdGhlIHR0cyBsaXN0ICovCj4gCQlpZiAodHRf
aW5mby0+c2xvdF9pZCA9PSBzbG90X2lkKSB7Cj4gCQkJLyogYXJlIGFueSBkZXZpY2VzIHVzaW5n
IHRoaXMgdHRfaW5mbz8gKi8KPi0JCQlmb3IgKGkgPSAxOyBpIDwgSENTX01BWF9TTE9UUyh4aGNp
LT5oY3NfcGFyYW1zMSk7IGkrKykgewo+LQkJCQl2ZGV2ID0geGhjaS0+ZGV2c1tpXTsKPi0JCQkJ
aWYgKHZkZXYgJiYgKHZkZXYtPnR0X2luZm8gPT0gdHRfaW5mbykpCj4rCQkJZm9yIChpID0gMTsg
aSA8PSBIQ1NfTUFYX1NMT1RTKHhoY2ktPmhjc19wYXJhbXMxKTsgaSsrKSB7Cj4rCQkJCXZkZXZf
aSA9IHhoY2ktPmRldnNbaV07Cj4rCQkJCWlmICh2ZGV2X2kgJiYgKHZkZXZfaS0+dHRfaW5mbyA9
PSB0dF9pbmZvKSkKPiAJCQkJCXhoY2lfZnJlZV92aXJ0X2RldmljZXNfZGVwdGhfZmlyc3QoCj4g
CQkJCQkJeGhjaSwgaSk7Cj4gCQkJfQo+LS0gCj4yLjQ4LjEKClRlc3RlZC1ieTogRGF2aWQgV2Fu
ZyA8MDAxMDcwODJAMTYzLmNvbT4KCgpBYm91dCB0aGUgY2hhbmdlIGZyb20gIjwiIHRvICI8PSIs
IEkgZGlkIG5vdCBvYnNlcnZlIGFueSBkaWZmZXJlbmNlIG9uIG15IHN5c3RlbS4gSXMgaXQgYmVj
YXVzZSBteSBzeXN0ZW0gZG9lcyBub3QgdXNlIHVwIGFsbCBzbG90cz8KClRoYW5rcwpEYXZpZAo=


