Return-Path: <linux-kernel+bounces-642067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C41C5AB1A56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 18:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9796188D2FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386DF2356D8;
	Fri,  9 May 2025 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="h0EsuY8X"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BFB235BF0
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807437; cv=none; b=SvNCIhZPHRml6FQeI3EuiS7oxpBRXRbIt3pmRfT9GGt6+5KHW+Xrjc2AybNj6LQdKx9e2leihXvxFHs8YolXJTYOnYQFkI+cNOApvH6IIVRyz9PytD6TVVCXjMy1FKFck5TYP0JvH0AmDFVy7SI+OwobBDLEdcajQc0ut4nBndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807437; c=relaxed/simple;
	bh=h1AZrN4imjguVg2FlecZkIuZy+PTq1gO40h+QbV8T+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=QbdN+Qxh3X+vl5yLD7OWJGlYL6I5N1oqNvuv15vLsXK50PUPuepG+HUhnFhoVGmagM+KTxEYr+EEa00UKnsyxMB6/b2SdgQt2HGPfQlbLoAnTeM5QfcrK2RxTk9vnXSf/xgOfTRjDtO5ETpqpOKhTINkEWERYAMl5fM6Iu515Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=h0EsuY8X reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=WIre7rYTBB/RhQRzMYi5rIUU+oVgiUrL7ADL6Da5LVk=; b=h
	0EsuY8X+jdokN+V3y6jQvN3uSpuPFSiTERqDnmFxYJsXD22/+JW0kGVI8KMCx4hc
	TDUYRlCcrJDRc/JinyOChYzU5K58tPTbnReQiXhMr0VEj8bPHz35/D4YeTX9ACxU
	WUmEtr3G2jXW6jnKWknieyuEX1Sm4Rngor+pszgnzc=
Received: from 00107082$163.com ( [111.35.191.17] ) by
 ajax-webmail-wmsvr-40-142 (Coremail) ; Sat, 10 May 2025 00:16:57 +0800
 (CST)
Date: Sat, 10 May 2025 00:16:57 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] alloc_tag: add timestamp to codetag iterator
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpHRTGvctcEwXHd1bpfUiFa=A--zKmVBJggB5D9huPEdSA@mail.gmail.com>
References: <20250507175500.204569-1-00107082@163.com>
 <20250509055151.922612-1-00107082@163.com>
 <CAJuCfpHRTGvctcEwXHd1bpfUiFa=A--zKmVBJggB5D9huPEdSA@mail.gmail.com>
X-NTES-SC: AL_Qu2fBPSbuEwq4SOeYOkZnEYQheY4XMKyuPkg1YJXOp80uCbu+QEYeXBjM2nx7cOmEwatvxeTWgRU9P9lb5ZDdKbSsCSM3qxDNE9vpdLpoWJ4
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <204874d5.b00e.196b5d5ea1d.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jigvCgD33yR6Kh5o0wABAA--.9112W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gxIqmgeKMYGfwABsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDUtMTAgMDA6MTA6MDEsICJTdXJlbiBCYWdoZGFzYXJ5YW4iIDxzdXJlbmJAZ29v
Z2xlLmNvbT4gd3JvdGU6Cj5PbiBUaHUsIE1heSA4LCAyMDI1IGF0IDEwOjUy4oCvUE0gRGF2aWQg
V2FuZyA8MDAxMDcwODJAMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+IENvZGV0YWcgaXRlcmF0b3IgdXNl
IDxpZCxhZGRyZXNzPiBwYWlyIHRvIGd1YXJhbnRlZSB0aGUKPj4gdmFsaWRuZXNzLiBCdXQgYm90
aCBpZCBhbmQgYWRkcmVzcyBjYW4gYmUgcmV1c2VkLCB0aGVyZSBpcwo+PiB0aGVvcmV0aWNhbCBw
b3NzaWJpbGl0eSB3aGVuIG1vZHVsZSBpbnNlcnRlZCByaWdodCBhZnRlcgo+PiBhbm90aGVyIG1v
ZHVsZSByZW1vdmVkLCBrbWFsbG9jIHJldHVybiBhbiBhZGRyZXNzIGtmcmVlIGJ5Cj4+IHByZXZp
b3VzIG1vZHVsZSBhbmQgSURSIGtleSByZXVzZSB0aGUga2V5IHJlY2VudGx5IHJlbW92ZWQuCj4+
Cj4+IEFkZCB0aW1lc3RhbXAgdG8gY29kZXRhZ19tb2R1bGUgYW5kIGNvZGVfaXRlcmF0b3IsIHRo
ZQo+PiB0aW1lc3RhbXAgaXMgZ2VuZXJhdGVkIGJ5IGEgY2xvY2sgd2hpY2ggaXMgc3RyaWNrbHkK
Pj4gaW5jcmVtZW50ZWQgd2hlbmV2ZXIgYSBtb2R1bGUgaXMgbG9hZGVkLiBBbiBpdGVyYXRvciBp
cwo+PiB2YWxpZCBpZiBhbmQgb25seSBpZiBpdHMgdGltZXN0YW1wIG1hdGNoIGNvZGV0YWdfbW9k
dWxlJ3MuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFdhbmcgPDAwMTA3MDgyQDE2My5jb20+
Cj4+IC0tLQo+PiAgaW5jbHVkZS9saW51eC9jb2RldGFnLmggfCAgMSArCj4+ICBsaWIvY29kZXRh
Zy5jICAgICAgICAgICB8IDEyICsrKysrKysrKystLQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9jb2RldGFnLmggYi9pbmNsdWRlL2xpbnV4L2NvZGV0YWcuaAo+PiBpbmRleCBkMTRkYmQy
NmIzNzAuLjYxZDQzYzNmYmQxOSAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC9jb2RldGFn
LmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC9jb2RldGFnLmgKPj4gQEAgLTU0LDYgKzU0LDcgQEAg
c3RydWN0IGNvZGV0YWdfaXRlcmF0b3Igewo+PiAgICAgICAgIHN0cnVjdCBjb2RldGFnX21vZHVs
ZSAqY21vZDsKPj4gICAgICAgICB1bnNpZ25lZCBsb25nIG1vZF9pZDsKPj4gICAgICAgICBzdHJ1
Y3QgY29kZXRhZyAqY3Q7Cj4+ICsgICAgICAgdW5zaWduZWQgbG9uZyB0aW1lc3RhbXA7Cj4KPlRo
ZSB3YXkgeW91IGltcGxlbWVudCB0aGlzLCBpdCBpcyBub3QgcmVhbGx5IGEgdGltZXN0YW1wLCBt
b3JlIGxpa2UgYQo+dW5pcXVlIGlkIG9yIHNlcXVlbmNlIG51bWJlci4gSSB3b3VsZCBzdWdnZXN0
IGNhbGxpbmcgaXQgbW9kX3NlcSBvcgo+c29tZXRoaW5nIHNpbWlsYXIuIE1heWJlOiBjdHR5cGUt
Pm5leHRfbW9kX3NlcSwgaXRlci0+bW9kX3NlcSBhbmQKPmNtb2QtPm1vZF9zZXEuCgpDb3B5IHRo
YXR+Cgo+Cj4+ICB9Owo+Pgo+PiAgI2lmZGVmIE1PRFVMRQo+PiBkaWZmIC0tZ2l0IGEvbGliL2Nv
ZGV0YWcuYyBiL2xpYi9jb2RldGFnLmMKPj4gaW5kZXggNDJhYWRkNmMxNDU0Li45NzNiZmE1ZGQ1
ZGIgMTAwNjQ0Cj4+IC0tLSBhL2xpYi9jb2RldGFnLmMKPj4gKysrIGIvbGliL2NvZGV0YWcuYwo+
PiBAQCAtMTMsNiArMTMsOCBAQCBzdHJ1Y3QgY29kZXRhZ190eXBlIHsKPj4gICAgICAgICBzdHJ1
Y3QgaWRyIG1vZF9pZHI7Cj4+ICAgICAgICAgc3RydWN0IHJ3X3NlbWFwaG9yZSBtb2RfbG9jazsg
LyogcHJvdGVjdHMgbW9kX2lkciAqLwo+Cj5UaGUgY29tbWVudCBhYm92ZSBzaG91bGQgYmUgZXhw
YW5kZWQgdG8gc2F5IHRoYXQgbW9kX2xvY2sgYWxzbwo+cHJvdGVjdHMgYWNjZXNzZXMgdG8gY3R0
eXBlLT5jbG9jaywgaXRlci0+dGltZXN0YW1wIGFuZAo+Y21vZC0+dGltZXN0YW1wLgoKR29vZCBj
YXRjaH4hCgpUaGFua3MKPgo+PiAgICAgICAgIHN0cnVjdCBjb2RldGFnX3R5cGVfZGVzYyBkZXNj
Owo+PiArICAgICAgIC8qIGdlbmVyYXRlcyB0aW1lc3RhbXAgZm9yIG1vZHVsZSBsb2FkICovCj4+
ICsgICAgICAgdW5zaWduZWQgbG9uZyBjbG9jazsKPj4gIH07Cj4+Cj4+ICBzdHJ1Y3QgY29kZXRh
Z19yYW5nZSB7Cj4+IEBAIC0yMyw2ICsyNSw3IEBAIHN0cnVjdCBjb2RldGFnX3JhbmdlIHsKPj4g
IHN0cnVjdCBjb2RldGFnX21vZHVsZSB7Cj4+ICAgICAgICAgc3RydWN0IG1vZHVsZSAqbW9kOwo+
PiAgICAgICAgIHN0cnVjdCBjb2RldGFnX3JhbmdlIHJhbmdlOwo+PiArICAgICAgIHVuc2lnbmVk
IGxvbmcgdGltZXN0YW1wOwo+PiAgfTsKPj4KPj4gIHN0YXRpYyBERUZJTkVfTVVURVgoY29kZXRh
Z19sb2NrKTsKPj4gQEAgLTQ4LDYgKzUxLDcgQEAgc3RydWN0IGNvZGV0YWdfaXRlcmF0b3IgY29k
ZXRhZ19nZXRfY3RfaXRlcihzdHJ1Y3QgY29kZXRhZ190eXBlICpjdHR5cGUpCj4+ICAgICAgICAg
ICAgICAgICAuY21vZCA9IE5VTEwsCj4+ICAgICAgICAgICAgICAgICAubW9kX2lkID0gMCwKPj4g
ICAgICAgICAgICAgICAgIC5jdCA9IE5VTEwsCj4+ICsgICAgICAgICAgICAgICAudGltZXN0YW1w
ID0gMCwKPj4gICAgICAgICB9Owo+Pgo+PiAgICAgICAgIHJldHVybiBpdGVyOwo+PiBAQCAtOTEs
MTEgKzk1LDEzIEBAIHN0cnVjdCBjb2RldGFnICpjb2RldGFnX25leHRfY3Qoc3RydWN0IGNvZGV0
YWdfaXRlcmF0b3IgKml0ZXIpCj4+ICAgICAgICAgICAgICAgICBpZiAoIWNtb2QpCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+Pgo+PiAtICAgICAgICAgICAgICAgaWYgKGNtb2Qg
IT0gaXRlci0+Y21vZCkgewo+PiArICAgICAgICAgICAgICAgaWYgKCFpdGVyLT5jbW9kIHx8IGl0
ZXItPnRpbWVzdGFtcCAhPSBjbW9kLT50aW1lc3RhbXApIHsKPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgaXRlci0+Y21vZCA9IGNtb2Q7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGl0ZXIt
PnRpbWVzdGFtcCA9IGNtb2QtPnRpbWVzdGFtcDsKPj4gICAgICAgICAgICAgICAgICAgICAgICAg
Y3QgPSBnZXRfZmlyc3RfbW9kdWxlX2N0KGNtb2QpOwo+PiAtICAgICAgICAgICAgICAgfSBlbHNl
Cj4+ICsgICAgICAgICAgICAgICB9IGVsc2Ugewo+PiAgICAgICAgICAgICAgICAgICAgICAgICBj
dCA9IGdldF9uZXh0X21vZHVsZV9jdChpdGVyKTsKPj4gKyAgICAgICAgICAgICAgIH0KPj4KPj4g
ICAgICAgICAgICAgICAgIGlmIChjdCkKPj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7
Cj4+IEBAIC0xOTAsNiArMTk2LDggQEAgc3RhdGljIGludCBjb2RldGFnX21vZHVsZV9pbml0KHN0
cnVjdCBjb2RldGFnX3R5cGUgKmN0dHlwZSwgc3RydWN0IG1vZHVsZSAqbW9kKQo+PiAgICAgICAg
IGNtb2QtPnJhbmdlID0gcmFuZ2U7Cj4+Cj4+ICAgICAgICAgZG93bl93cml0ZSgmY3R0eXBlLT5t
b2RfbG9jayk7Cj4+ICsgICAgICAgY3R0eXBlLT5jbG9jaysrOwo+PiArICAgICAgIGNtb2QtPnRp
bWVzdGFtcCA9IGN0dHlwZS0+Y2xvY2s7Cj4+ICAgICAgICAgZXJyID0gaWRyX2FsbG9jKCZjdHR5
cGUtPm1vZF9pZHIsIGNtb2QsIDAsIDAsIEdGUF9LRVJORUwpOwo+PiAgICAgICAgIGlmIChlcnIg
Pj0gMCkgewo+PiAgICAgICAgICAgICAgICAgY3R0eXBlLT5jb3VudCArPSByYW5nZV9zaXplKGN0
dHlwZSwgJnJhbmdlKTsKPj4gLS0KPj4gMi4zOS4yCj4+Cg==

