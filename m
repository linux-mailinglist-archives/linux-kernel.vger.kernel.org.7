Return-Path: <linux-kernel+bounces-794411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8D3B3E155
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B963AE8D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E69302CAE;
	Mon,  1 Sep 2025 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="aK6I6f2H"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883852F37;
	Mon,  1 Sep 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725506; cv=none; b=JaPJ3QixAG6D8l8DIaqCZ55HvNdAWjYeKjJdsMoCRUZD5RRcYQUA76IuP9FRMXq1xc7Lw7OVJlCfRn93Amj3UXfhBh/+i31RrRztvuRiGJFAJovjIRm5oeuRwkEHtjpHyPaeQoM6yZFPuHIj5z9MM91jvMgYg12Qrgc8GDczF4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725506; c=relaxed/simple;
	bh=IVmbxiakIq39e/9ee4FAF69TVetQLrpss0ewxo3jaVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DuScCQ5f0RAEGK3USo31iuh5J18v3knelpWDnLOCzEJtz2W8JwPcg1fal6WKWkrr50pK7uxqFDv0YqDjvS6/ejZZchU0J2ihhdU6bMIe8cpI6ZK+xXYOurWcJbbQSygF1tnuXjCtOyUH3w9epmy9RxVbGu2mVbB5gVkgUJQ+Hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=aK6I6f2H reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=TlHUQQuyeZYSu+OfqT//Uc4L/7XQ/BI0UmWamh72sGQ=; b=a
	K6I6f2Hqhw7QHkwy9i3dmvpvz7nduWqzSGXsHa4yq3lxdd8+Zh7Y+0BsWxG6s8S7
	shgl6mHfhWf3+f2seFW6U8cm4/Bb7POnzlwT0J+tR51ok1WDvJzEmUhNgU5npYuC
	DFSP+1+kQjcQAOCHhLp23Nx/vXPRvGLFWTX4qhg6UI=
Received: from 00107082$163.com ( [111.35.190.191] ) by
 ajax-webmail-wmsvr-40-118 (Coremail) ; Mon, 1 Sep 2025 19:17:38 +0800 (CST)
Date: Mon, 1 Sep 2025 19:17:38 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Mathias Nyman" <mathias.nyman@linux.intel.com>
Cc: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>,
	WeitaoWang-oc@zhaoxin.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, surenb@google.com,
	kent.overstreet@linux.dev
Subject: Re: [REGRESSION 6.17-rc3] usb/xhci: possible memory leak after
 suspend/resume cycle.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <f9476552-a6dc-4f1c-91da-b15c8f0d9844@linux.intel.com>
References: <20250829181354.4450-1-00107082@163.com>
 <20250830114828.3dd8ed56.michal.pecio@gmail.com>
 <5051e27a.2ba3.198fa7b5f31.Coremail.00107082@163.com>
 <f9476552-a6dc-4f1c-91da-b15c8f0d9844@linux.intel.com>
X-NTES-SC: AL_Qu2eBPuZukwu7iCeYOkZnEYQheY4XMKyuPkg1YJXOp80qCTy+hwydm5aNHzv3PmOGwymoQmreip/791XQrd1U54+YxnU7kfbLoF40EGGjjrz
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7e8a138e.af64.19904ff3496.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:digvCgD3X_jTgLVotogmAA--.3994W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEBO7qmi1e6ChNQABsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDktMDEgMTg6MTQ6MzIsICJNYXRoaWFzIE55bWFuIiA8bWF0aGlhcy5ueW1hbkBs
aW51eC5pbnRlbC5jb20+IHdyb3RlOgo+T24gMzAuOC4yMDI1IDEzLjE3LCBEYXZpZCBXYW5nIHdy
b3RlOgo+PiAKPj4gQXQgMjAyNS0wOC0zMCAxNzo0ODoyOCwgIk1pY2hhxYIgUGVjaW8iIDxtaWNo
YWwucGVjaW9AZ21haWwuY29tPiB3cm90ZToKPj4+Cj4+PiBIaSwKPj4+Cj4+PiBHb29kIHdvcmss
IGxvb2tzIGxpa2Ugc3VzcGVuZC9yZXN1bWUgaXMgYSBsaXR0bGUgdW5kZXJzdGVzdGVkIGNvcm5l
cgo+Pj4gb2YgdGhpcyBkcml2ZXIuCj4+Pgo+Pj4gRGlkIHlvdSBjaGVjayB3aGV0aGVyIHRoZSBz
YW1lIGxlYWsgb2NjdXJzIGlmIHlvdSBzaW1wbHkgZGlzY29ubmVjdAo+Pj4gYSBkZXZpY2Ugb3Ig
aWYgaXQncyB0cnVseSB1bmlxdWUgdG8gc3VzcGVuZD8KPj4+Cj4+Pj4gQW5kIGJpc2VjdCBuYXJy
b3cgZG93biB0byBjb21taXQgMmViMDMzNzYxNTFiYjg1ODVjYWEyM2VkMjY3MzU4MzEwN2JiNTE5
MygKPj4+PiAidXNiOiB4aGNpOiBGaXggc2xvdF9pZCByZXNvdXJjZSByYWNlIGNvbmZsaWN0Iik6
Cj4+Pgo+Pj4gSSBzZWUgYSB0cml2aWFsIGJ1ZyB3aGljaCBldmVyeW9uZSAobXlzZWxmIGluY2x1
ZGVkIHRiaCkgbWlzc2VkIGJlZm9yZS4KPj4+IERvZXMgdGhpcyBoZWxwPwo+Pj4KPj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbWVtLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3ho
Y2ktbWVtLmMKPj4+IGluZGV4IGYxMWUxM2Y5Y2RiNC4uZjI5NDAzMmMyYWQ3IDEwMDY0NAo+Pj4g
LS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW1lbS5jCj4+PiArKysgYi9kcml2ZXJzL3VzYi9o
b3N0L3hoY2ktbWVtLmMKPj4+IEBAIC05MzIsNyArOTMyLDcgQEAgdm9pZCB4aGNpX2ZyZWVfdmly
dF9kZXZpY2Uoc3RydWN0IHhoY2lfaGNkICp4aGNpLCBzdHJ1Y3QgeGhjaV92aXJ0X2RldmljZSAq
ZGV2LAo+Pj4gICAqLwo+Pj4gc3RhdGljIHZvaWQgeGhjaV9mcmVlX3ZpcnRfZGV2aWNlc19kZXB0
aF9maXJzdChzdHJ1Y3QgeGhjaV9oY2QgKnhoY2ksIGludCBzbG90X2lkKQo+Pj4gewo+Pj4gLQlz
dHJ1Y3QgeGhjaV92aXJ0X2RldmljZSAqdmRldjsKPj4+ICsJc3RydWN0IHhoY2lfdmlydF9kZXZp
Y2UgKnZkZXYsICp0bXBfdmRldjsKPj4+IAlzdHJ1Y3QgbGlzdF9oZWFkICp0dF9saXN0X2hlYWQ7
Cj4+PiAJc3RydWN0IHhoY2lfdHRfYndfaW5mbyAqdHRfaW5mbywgKm5leHQ7Cj4+PiAJaW50IGk7
Cj4+PiBAQCAtOTUyLDggKzk1Miw4IEBAIHN0YXRpYyB2b2lkIHhoY2lfZnJlZV92aXJ0X2Rldmlj
ZXNfZGVwdGhfZmlyc3Qoc3RydWN0IHhoY2lfaGNkICp4aGNpLCBpbnQgc2xvdF9pCj4+PiAJCWlm
ICh0dF9pbmZvLT5zbG90X2lkID09IHNsb3RfaWQpIHsKPj4+IAkJCS8qIGFyZSBhbnkgZGV2aWNl
cyB1c2luZyB0aGlzIHR0X2luZm8/ICovCj4+PiAJCQlmb3IgKGkgPSAxOyBpIDwgSENTX01BWF9T
TE9UUyh4aGNpLT5oY3NfcGFyYW1zMSk7IGkrKykgewo+Pj4gLQkJCQl2ZGV2ID0geGhjaS0+ZGV2
c1tpXTsKPj4+IC0JCQkJaWYgKHZkZXYgJiYgKHZkZXYtPnR0X2luZm8gPT0gdHRfaW5mbykpCj4+
PiArCQkJCXRtcF92ZGV2ID0geGhjaS0+ZGV2c1tpXTsKPj4+ICsJCQkJaWYgKHRtcF92ZGV2ICYm
ICh0bXBfdmRldi0+dHRfaW5mbyA9PSB0dF9pbmZvKSkKPj4+IAkJCQkJeGhjaV9mcmVlX3ZpcnRf
ZGV2aWNlc19kZXB0aF9maXJzdCgKPj4+IAkJCQkJCXhoY2ksIGkpOwo+PiAKPj4gSSBjb25maXJt
ZWQgdGhpcyAqc2lsbHkqIGNvZGUgaXMgdGhlIHJvb3QgY2F1c2Ugb2YgdGhpcyBtZW1vcnkgbGVh
ay4KPj4gQW5kIEkgd291bGQgc3VnZ2VzdCBzaW1wbGVyIGNvZGUgY2hhbmdlcyAod2hpY2ggaXMg
d2hhdCBJIHdhcyB0ZXN0aW5nKToKPj4gCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
aG9zdC94aGNpLW1lbS5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW1lbS5jCj4+IGluZGV4IDgx
ZWFhZDg3YTNkOS4uYzRhNjU0NGFhMTA3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0
L3hoY2ktbWVtLmMKPj4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW1lbS5jCj4+IEBAIC05
NjIsNyArOTYyLDcgQEAgc3RhdGljIHZvaWQgeGhjaV9mcmVlX3ZpcnRfZGV2aWNlc19kZXB0aF9m
aXJzdChzdHJ1Y3QgeGhjaV9oY2QgKnhoY2ksIGludCBzbG90X2kKPj4gICBvdXQ6Cj4+ICAgICAg
ICAgIC8qIHdlIGFyZSBub3cgYXQgYSBsZWFmIGRldmljZSAqLwo+PiAgICAgICAgICB4aGNpX2Rl
YnVnZnNfcmVtb3ZlX3Nsb3QoeGhjaSwgc2xvdF9pZCk7Cj4+IC0gICAgICAgeGhjaV9mcmVlX3Zp
cnRfZGV2aWNlKHhoY2ksIHZkZXYsIHNsb3RfaWQpOwo+PiArICAgICAgIHhoY2lfZnJlZV92aXJ0
X2RldmljZSh4aGNpLCB4aGNpLT5kZXZzW3Nsb3RfaWRdLCBzbG90X2lkKTsKPj4gICB9Cj4+ICAg
Cj4+ICAgaW50IHhoY2lfYWxsb2NfdmlydF9kZXZpY2Uoc3RydWN0IHhoY2lfaGNkICp4aGNpLCBp
bnQgc2xvdF9pZCwKPj4gCj4KPlRoYW5rcyB0byBib3RoIGZvciBjYXRjaGluZyB0aGlzCj4KPkkg
Y2FuIHF1aWNrbHkgdHVybiB0aGlzIGludG8gYSBwcm9wZXIgcGF0Y2ggdW5sZXNzIG9uZSBvZiB5
b3Ugd291bGQgbGlrZSB0byBzdWJtaXQgb25lPwoKT2gsIEkgd2FzIG5vdCBwbGFubmluZyB0byBz
dWJtaXQgYSBwYXRjaCBhdCBhbGwsIHNpbmNlIE1pY2hhxYIgUGVjaW8gZ290IHRoZSBjcmVkaXQg
b2YgcHVibGlzaGluZyB0aGUgZmlyc3QgcGF0Y2guCgpUaGFua3MKRGF2aWQKCj4KPlRoYW5rcwo+
TWF0aGlhcwo=

