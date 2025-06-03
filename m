Return-Path: <linux-kernel+bounces-671234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E6CACBE63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 04:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3793A4CAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 02:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBDE78F5D;
	Tue,  3 Jun 2025 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="j2ug0Aif"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B0FA47;
	Tue,  3 Jun 2025 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916167; cv=none; b=E3tjExriiNufCAr0MWzOiPy8hHH4bC58TM4cXMDsuJqswIDQlJy3SD8+UjbfMZ094uPoLL7aOJ0KZlvwOrn8WylSw41NnTAQWsPaZx6A9L38zT/CLAeonvpM2OHFqFS4TAuIIJ5TyeMnAAPCtEWLxNIxE9QKBawol9fALX0PDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916167; c=relaxed/simple;
	bh=AB7taGPJNVOMSUMHjBNx630ACxRkKV1NT/QYiCEgMOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=WqMdvxRaRiO2Gyo4DjvlqgVJkx/ISB1M9et0anAHINU4FPuLbJXxLt/T0hMVO8vdvSA89sFg79shafx1Lcjasms28EkY80p7aY9D17Um5usOFq9EEpuN+EtKgcxJrYiQDmYlI3X72LsuF9RNah2iz97cNVQkXRke64+zCvk/LMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=j2ug0Aif reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=mcHfqe8UU8sPOJgw3g1JkNrG9x9xp2dzQdh7oL2hRWk=; b=j
	2ug0Aif310C5jJRny/XEbwKq0X33xtI/Hu5KEQ8r2Dht3rp+TFV5hLo5BEGdw+gk
	nP26TjSGiZyF9ASECKVfV9tuP1OSG380bL/Xe8O6GPuaq716IgqcBVYt4An8CcG3
	qu4Umv3nbLiF2pZ2oOwialAnd0hyxDwFgr0Yr9uOXI=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-143 (Coremail) ; Tue, 3 Jun 2025 10:01:41 +0800 (CST)
Date: Tue, 3 Jun 2025 10:01:41 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, leo.yan@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250602184049.4010919-1-yeoreum.yun@arm.com>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
X-NTES-SC: AL_Qu2fCvWauUkr5yabYekZnEYQheY4XMKyuPkg1YJXOp80tybH4g4deXB7AFDkwcOjICOSvxerYgBD5MNQQahTc7z6s2g4/iiNDCQCd8LO/hSD
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3842c9a5.20ee.1973385e209.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jygvCgD3n22GVz5ojVISAA--.54749W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0hBgqmg+LTFWbAAEs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDYtMDMgMDI6NDA6NDksICJZZW9yZXVtIFl1biIgPHllb3JldW0ueXVuQGFybS5j
b20+IHdyb3RlOgo+Y29tbWl0IGEzYzNjNjY2NygicGVyZi9jb3JlOiBGaXggY2hpbGRfdG90YWxf
dGltZV9lbmFibGVkIGFjY291bnRpbmcgYnVnIGF0IHRhc2sgZXhpdCIpCj5jaGFuZ2VzIHRoZSBl
dmVudC0+c3RhdGUgdXBkYXRlIGJlZm9yZSBsaXN0X2RlbF9ldmVudCgpLgo+VGhpcyBjaGFuZ2Ug
cHJldmVudHMgY2FsbGluZyBwZXJmX2Nncm91cF9ldmVudF9kaXNhYmxlKCkgYXMgYSByZXN1bHQs
Cj5jcHVjdHgtPmNncnAgY2FuJ3QgYmUgY2xlYXJlZCBwcm9wZXJseSBhbmQgcG9pbnQgdG8gZGFu
Z2xpbmcgcG9pbnQgb2YgY2dyb3VwLgo+Cj5CZWNhdXNlIG9mIHRoaXMgcHJvYmxlbSwgc29tZSBt
YWNoaW4gbWVldHMgdGhlIGJlbG93IHBhbmljWzBdOgo+Cj44NjMuODgxOTYwXSBzeXN2ZWRfY2Fs
bF9mdW5jdGlvbl9zaW5nIGxlKzB4NGMvMHhjMAo+ODYzLjg4MTMwMV0gYXNtX3N5c3ZlY19jYWxs
X2Z1bmN0aW9uX3NpbmdsZSsweDE2LzB4MjAKPjg2OS44ODEzNDRdIFJJUDogMDYzMzoweDdmOWFs
Y2VhMzM2Nwo+NjYzLjY4MTM3M10gQ29kZTogMDAgNjYgOTkgYjggZmYgZmYgZmYgZmYgYzMgNjYg
Li4uLgo+ODYzLjg4MTUyNF0gUlNQOiAwMDJiOjAwMDA3ZmZmYTUyNmZjZjggRUZMQUdTOiAwMDAw
MDI0Ngo+ODY5Ljg4MTU2N10gUkFYOiAwMDAwNTYyMDYwYzk2MmQwIFJCWDogMDAwMDAwMDAwMDAw
MDAwMiBSQ1g6IDAwMDA3ZjlhMWNmZjFjNjAKPjg2My44ODE2MjVdIFJEWDogMDAwMDdmOWEwYzAw
MDAzMCBSU0k6IDAwMDA3ZjlhbGNmZjFjNjAgUkRJOiAwMDAwN2Y5YTFjYTkxYzIwCj44NjMuMDgx
NjgyXSBSQlA6IDAwMDAwMDAwMDAwMDAwMDEgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAw
MDdmOWExZDYyMTdhMAo+ODY5Ljg4MTc0MF0gUjEwOiAwMDAwN2Y5YWxjYTkxYzEwIFIxMTogMDAw
MDAwMDAwMDAwMDI0NiBSMTI6IDAwMDA3ZjlhMWQ3MGMwMjAKPjg2OS44ODE3OThdIFIxMzogMDAw
MDdmZmZhNTI3MDAzMCBSMTQ6IDAwMDA3ZmZmYTUyNmZkMDAgUjE1OiAwMDAwMDAwMDAwMDAwMDAw
Cj44NjMuODgxODYwXSA8L1RBU0s+Cj44NjMuODgxODc2KSBNb2R1bGVzIGxpbmtlZCBpbjogc25k
X3NlcV9kdW1teSAoRSkgc25kX2hydGltZXIgKEUpLi4uCj4uLi4KPjg2My44ODcxNDJdIGJ1dHRv
biAoRSkKPjg2My45MTIxMjddIENSMjogZmZmZmU0YWZjYzA3OTY1MAo+ODYzLjkxNDU5M10gLS0t
IFsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgMS0tCj44NjQuMDQyNzUwXSBSSVA6IDAwMTA6
Y3R4X3NjaGVkX291dCsweDFjZS8weDIxMAo+ODY0LjA0NTIxNF0gQ29kZTogODkgYzYgNGMgOGIg
YjkgZGUgMDAgMDAgMDAgNDggLi4uCj44NjQuMDUwMzQzXSBSU1A6IDAwMDA6ZmZmZmFhNGVjMGYz
ZmU2MCBFRkxBR1M6IDAwMDEwMDg2Cj44NjQuMDUyOTI5XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDIg
UkJYOiBmZmZmOGU4ZWVlZDJhNTgwIFJDWDogZmZmZjhlOGJkZWQ5YmYwMAo+ODY0LjA1NTUxOF0g
UkRYOiAwMDAwMDBjOTIzNDBiMDUxIFJTSTogMDAwMDAwYzkyMzQwYjA1MSBSREk6IGZmZmYKPjg2
NC4wNTgwOTNdIFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDIgUjA5
OiAwMAo+ODY0LjA2MDY1NF0gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAw
MDAwMCBSMTI6IDAwMAo+ODY0LjA2MzE4M10gUjEzOiBmZmZmOGU4ZWVlZDJhNTgwIFIxNDogMDAw
MDAwMDAwMDAwMDAwNyBSMTU6IGZmZmZlNGFmY2MwNzk2NTAKPjg2NC4wNjU3MjldIEZTOiAwMDAw
N2Y5YTFjYTkxOTQwICgwMDAwKSBHUzpmZmZmOGU4ZjZiMWMzMDAwKDAwMDApIGtuSUdTOjAwMDAw
MDAwMDAwMDAwMDAKPjg2NC4wNjgzMTJdIENTOiAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSTzog
MDAwMDAwMDA4MDA1MDAzMwo+ODY0LjA3MDg5OF0gQ1IyOiBmZmZmZTRhZmNjMDc5NjUwIENSMzog
MDAwMDAwMDExMzZkODAwMCBDUjQ6IDAwMDAwMDAwMDAzNTBlZjAKPjg2NC42NzM1MjNdIEtlcm5l
bCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24gaW4gaW50ZXJydXB0Cj44NjQu
MDc2NDEwXSBLZXJuZWwgT2Zmc2V0OiAweGMwMDAwMCBmcm9tIDB4ZmZmZmZmZmY4MTAwMDAwMCAo
cmVsb2NhdGlvbiByYW5nZTogMHhmZgo+ODY0LjIwNTQwMV0gLS0tIFsgZW5kIEtlcm5lbCBwYW5p
YyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24gaW4gaW50ZXJydXB0IF0tLS0KPgo+VG8g
YWRkcmVzcyB0aGlzIGNhbGwgdGhlIHBlcmZfY2dyb3VwX2V2ZW50X2Rpc2FibGUoKSBwcm9wZXJs
eSBiZWZvcmUKPmxpc3RfZGVsX2V2ZW50KCkgaW4gX19wZXJmX3JlbW92ZV9mcm9tX2NvbnRleHQo
KS4KPgo+TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2FEMlRzcEtIJTJGN3l2Zllv
T0BlMTI5ODIzLmFybS5jb20vIFswXQo+Rml4ZXM6IGEzYzNjNjY2NygicGVyZi9jb3JlOiBGaXgg
Y2hpbGRfdG90YWxfdGltZV9lbmFibGVkIGFjY291bnRpbmcgYnVnIGF0IHRhc2sgZXhpdCIpCj5T
aWduZWQtb2ZmLWJ5OiBZZW9yZXVtIFl1biA8eWVvcmV1bS55dW5AYXJtLmNvbT4KPlRlc3RlZC1i
eTogRGF2aWQgV2FuZyA8MDAxMDcwODJAMTYzLmNvbT4KPi0tLQo+IGtlcm5lbC9ldmVudHMvY29y
ZS5jIHwgNCArKysrCj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Cj5kaWZmIC0t
Z2l0IGEva2VybmVsL2V2ZW50cy9jb3JlLmMgYi9rZXJuZWwvZXZlbnRzL2NvcmUuYwo+aW5kZXgg
ZjM0Yzk5ZjhjZThmLi45MDliOWQ1YTY1YzEgMTAwNjQ0Cj4tLS0gYS9rZXJuZWwvZXZlbnRzL2Nv
cmUuYwo+KysrIGIva2VybmVsL2V2ZW50cy9jb3JlLmMKPkBAIC0yNDk4LDYgKzI0OTgsMTAgQEAg
X19wZXJmX3JlbW92ZV9mcm9tX2NvbnRleHQoc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50LAo+IAkJ
c3RhdGUgPSBQRVJGX0VWRU5UX1NUQVRFX0RFQUQ7Cj4gCX0KPiAJZXZlbnRfc2NoZWRfb3V0KGV2
ZW50LCBjdHgpOwo+Kwo+KwlpZiAoZXZlbnQtPnN0YXRlID4gUEVSRl9FVkVOVF9TVEFURV9PRkYp
Cj4rCQlwZXJmX2Nncm91cF9ldmVudF9kaXNhYmxlKGV2ZW50LCBjdHgpOwo+Kwo+IAlwZXJmX2V2
ZW50X3NldF9zdGF0ZShldmVudCwgbWluKGV2ZW50LT5zdGF0ZSwgc3RhdGUpKTsKPiAKPiAJaWYg
KGZsYWdzICYgREVUQUNIX0dST1VQKQo+LS0gCj5MRVZJOntDM0Y0N0YzNy03NUQ4LTQxNEEtQThC
QS0zOTgwRUM4QTQ2RDd9CgpJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgbm8gYmV0dGVyIHRoYW4gbXkg
cGF0Y2ggaW4gdGhlIG9yaWdpbmFsIHJlcG9ydApodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyNTA2MDExNzM2MDMuMzkyMC0xLTAwMTA3MDgyQDE2My5jb20vCgoKVGhpcyBwYXRjaCBpcyBt
b3JlIGFnZ3Jlc3NpdmUsICBpdCBhZGQgbW9yZSBjaGFuZ2VzIHRvIG9yaWdpbmFsIGxvZ2ljLCBz
YW1lIHByYWN0aWNlIAphcyBpbiB0aGUgb2ZmZW5kaW5nIGNvbW1pdC4gIHdvdWxkIHJhaXNlIG1v
cmUgY29uY2VybnMgYWJvdXQgaGlkZGVuIHNpZGUtZWZmZWN0LgoKRm9yIGV4YW1wbGUsIHRoaXMg
Y29kZSAgaW4gbGlzdF9kZWxfZXZlbnQgc2hvdWxkIHJhaXNlIGNvbmNlcm4gYWJvdXQgdGhpcyBw
YXRjaAogMjA5OSAgICAgICAgICAqIFdlIGNhbiBoYXZlIGRvdWJsZSBkZXRhY2ggZHVlIHRvIGV4
aXQvaG90LXVucGx1ZyArIGNsb3NlLgogMjEwMCAgICAgICAgICAqLwogMjEwMSAgICAgICAgIGlm
ICghKGV2ZW50LT5hdHRhY2hfc3RhdGUgJiBQRVJGX0FUVEFDSF9DT05URVhUKSkKIDIxMDIgICAg
ICAgICAgICAgICAgIHJldHVybjsKCgpUaGFua3MKRGF2aWQK

