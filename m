Return-Path: <linux-kernel+bounces-632785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEF8AA9C5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 21:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A9A3AFBFA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B4B264A6D;
	Mon,  5 May 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XSJJhgLn"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC619ABAB
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472724; cv=none; b=CzblBHaBvKm6zWQ8gJdYynRjb4dSLJTa/cXHEHudwDpLBRNrbHKEtsW6SzrICzmhBJyJf4eq7jW/JCwe9y2+U1BUTti9JK0iFpoq7of9Kc2AVBegZ0NyMaAb3q1Wi/bzkhp4GyJEGhyKCzAuD4Are8pYu7IDw4iVVv8gLZJ5jMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472724; c=relaxed/simple;
	bh=ZnMLoIwBY5W0VmYP3BtBid7BiKKI5FktyERR4l9YxoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=iwc/kjWIhm4eY052Y9XPqCXwmKjg8+omw9fSUrwxYzDX3KCGJ3RIHy9Xbg72PBGuy58PsfDFOQHUdgZLzQFB9QmQCrQnjs1U+nHQN0yj+6p50KhZ2tSq7VtShSpuuRwNVJlRRuCH5Bcz0SxdPxKa7uaK2iAfxnPGxRcZH34DD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XSJJhgLn; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ZnMLoIwBY5W0VmYP3BtBid7BiKKI5FktyERR4l9YxoI=; b=X
	SJJhgLnCE6O9789Unbc1sjB5C+4Mh0Z67lcAzUY8RQzYlfuMWrkvoyUcCe+pcdGg
	HPVxpTa4fZd1+zm0hlDuo2d4pvOwxLiqgsXoPb2EBBHcMGC3i6jIa48Z3I/F5dlE
	1GVnR70qROgyTckuNh8sy+i0ksIA43HOiKdoWEV5Hc=
Received: from 00107082$163.com ( [111.35.191.17] ) by
 ajax-webmail-wmsvr-40-132 (Coremail) ; Tue, 6 May 2025 03:17:55 +0800 (CST)
Date: Tue, 6 May 2025 03:17:55 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH v2] mm/codetag: move tag retrieval back upfront in
 __free_pages()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250505183423.33773-1-00107082@163.com>
References: <CAJuCfpHKcDkce=no0Uu3UO2ua2GkgkKMZxnctMuDbOqQNKj_KA@mail.gmail.com>
 <20250505183423.33773-1-00107082@163.com>
X-NTES-SC: AL_Qu2fBPicvU4s4yidbOkXn0oTju85XMCzuv8j3YJeN500myXEwhAvZ25sE2TU0fmICiSmoQmUVSpe0+5WRa57fYk6gBy1S+/UxJDXG91QVryX
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <14556e7b.3c3e.196a1e22a1b.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hCgvCgD3v_zkDhloaN+nAA--.13938W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqBdEqmgZB8UtNwACs6
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

U29ycnksIEkgbWFkZSBhIG1pc3Rha2UsIHBnYWxsb2NfdGFnX2dldCBzaG91bGQgaGF2ZSBhIGR1
bW15IGRlZmluaXRpb24gCndoZW4gQ09ORklHX01FTV9BTExPQ19QUk9GSUxJTkcgbm90IGRlZmlu
ZWQsIHdpbGwgc2VuZCBhbm90aGVyIHBhdGNoLgoKCkF0IDIwMjUtMDUtMDYgMDI6MzQ6MjMsICJE
YXZpZCBXYW5nIiA8MDAxMDcwODJAMTYzLmNvbT4gd3JvdGU6Cj5Db21taXQgNTFmZjRkNzQ4NmYw
ICgibW06IGF2b2lkIGV4dHJhIG1lbV9hbGxvY19wcm9maWxpbmdfZW5hYmxlZCgpCj4gY2hlY2tz
IikgaW50cm9kdWNlcyBhIHBvc3NpYmxlIHVzZS1hZnRlci1mcmVlIHNjZW5hcmlvLCB3aGVuIHBh
Z2UKPmlzIG5vbi1jb21wb3VuZCwgcGFnZVswXSBjb3VsZCBiZSByZWxlYXNlZCBieSBvdGhlciB0
aHJlYWQgcmlnaHQKPmFmdGVyIHB1dF9wYWdlX3Rlc3R6ZXJvIGZhaWxlZCBpbiBjdXJyZW50IHRo
cmVhZCwgcGdhbGxvY190YWdfc3ViX3BhZ2VzCj5hZnRlcndhcmRzIHdvdWxkIG1hbmlwdWxhdGUg
YW4gaW52YWxpZCBwYWdlIGZvciBhY2NvdW50aW5nIHJlbWFpbmluZwo+cGFnZXM6Cj4KPlt0aW1l
bGluZV0gICBbdGhyZWFkMV0gICAgICAgICAgICAgICAgICAgICBbdGhyZWFkMl0KPiAgfCAgICAg
ICAgICBhbGxvY19wYWdlIG5vbi1jb21wb3VuZAo+ICBWCj4gIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ2V0X3BhZ2UsIHJmIGNvdW50ZXIgaW5jCj4gIFYKPiAgfCAg
ICAgICAgICBpbiBfX19mcmVlX3BhZ2VzCj4gIHwgICAgICAgICAgcHV0X3BhZ2VfdGVzdHplcm8g
ZmFpbHMKPiAgVgo+ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB1
dF9wYWdlLCBwYWdlIHJlbGVhc2VkCj4gIFYKPiAgfCAgICAgICAgICBpbiBfX19mcmVlX3BhZ2Vz
LAo+ICB8ICAgICAgICAgIHBnYWxsb2NfdGFnX3N1Yl9wYWdlcwo+ICB8ICAgICAgICAgIG1hbmlw
dWxhdGUgYW4gaW52YWxpZCBwYWdlCj4gIFYKPgo+UmVzdG9yZSBfX2ZyZWVfcGFnZXMoKSB0byBp
dHMgc3RhdGUgYmVmb3JlLCByZXRyaWV2ZSBhbGxvYyB0YWcKPmJlZm9yZWhhbmQuCj4KPkZpeGVz
OiA1MWZmNGQ3NDg2ZjAgKCJtbTogYXZvaWQgZXh0cmEgbWVtX2FsbG9jX3Byb2ZpbGluZ19lbmFi
bGVkKCkgY2hlY2tzIikKPlNpZ25lZC1vZmYtYnk6IERhdmlkIFdhbmcgPDAwMTA3MDgyQDE2My5j
b20+Cj4tLS0KPiBpbmNsdWRlL2xpbnV4L3BnYWxsb2NfdGFnLmggfCAgNyArKysrKysrCj4gbW0v
cGFnZV9hbGxvYy5jICAgICAgICAgICAgIHwgMTUgKysrKysrLS0tLS0tLS0tCj4gMiBmaWxlcyBj
aGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+Cj5kaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9wZ2FsbG9jX3RhZy5oIGIvaW5jbHVkZS9saW51eC9wZ2FsbG9jX3RhZy5o
Cj5pbmRleCBjNzQwNzc5Nzc4MzAuLjk3ZWI0ODM1NTY4ZSAxMDA2NDQKPi0tLSBhL2luY2x1ZGUv
bGludXgvcGdhbGxvY190YWcuaAo+KysrIGIvaW5jbHVkZS9saW51eC9wZ2FsbG9jX3RhZy5oCj5A
QCAtMTg4LDYgKzE4OCwxMyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBhbGxvY190YWcgKl9fcGdh
bGxvY190YWdfZ2V0KHN0cnVjdCBwYWdlICpwYWdlKQo+IAlyZXR1cm4gdGFnOwo+IH0KPiAKPitz
dGF0aWMgaW5saW5lIHN0cnVjdCBhbGxvY190YWcgKnBnYWxsb2NfdGFnX2dldChzdHJ1Y3QgcGFn
ZSAqcGFnZSkKPit7Cj4rCWlmIChtZW1fYWxsb2NfcHJvZmlsaW5nX2VuYWJsZWQoKSkKPisJCXJl
dHVybiBfX3BnYWxsb2NfdGFnX2dldChwYWdlKTsKPisJcmV0dXJuIE5VTEw7Cj4rfQo+Kwo+IHZv
aWQgcGdhbGxvY190YWdfc3BsaXQoc3RydWN0IGZvbGlvICpmb2xpbywgaW50IG9sZF9vcmRlciwg
aW50IG5ld19vcmRlcik7Cj4gdm9pZCBwZ2FsbG9jX3RhZ19zd2FwKHN0cnVjdCBmb2xpbyAqbmV3
LCBzdHJ1Y3QgZm9saW8gKm9sZCk7Cj4gCj5kaWZmIC0tZ2l0IGEvbW0vcGFnZV9hbGxvYy5jIGIv
bW0vcGFnZV9hbGxvYy5jCj5pbmRleCA1NjY5YmFmMmE2ZmUuLjFiMDBlMTRhOTc4MCAxMDA2NDQK
Pi0tLSBhL21tL3BhZ2VfYWxsb2MuYwo+KysrIGIvbW0vcGFnZV9hbGxvYy5jCj5AQCAtMTE1MSwx
NCArMTE1MSw5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwZ2FsbG9jX3RhZ19zdWIoc3RydWN0IHBh
Z2UgKnBhZ2UsIHVuc2lnbmVkIGludCBucikKPiAJCV9fcGdhbGxvY190YWdfc3ViKHBhZ2UsIG5y
KTsKPiB9Cj4gCj4tc3RhdGljIGlubGluZSB2b2lkIHBnYWxsb2NfdGFnX3N1Yl9wYWdlcyhzdHJ1
Y3QgcGFnZSAqcGFnZSwgdW5zaWduZWQgaW50IG5yKQo+Ky8qIFdoZW4gdGFnIGlzIG5vdCBOVUxM
LCBhc3N1bWluZyBtZW1fYWxsb2NfcHJvZmlsaW5nX2VuYWJsZWQgKi8KPitzdGF0aWMgaW5saW5l
IHZvaWQgcGdhbGxvY190YWdfc3ViX3BhZ2VzKHN0cnVjdCBhbGxvY190YWcgKnRhZywgdW5zaWdu
ZWQgaW50IG5yKQo+IHsKPi0Jc3RydWN0IGFsbG9jX3RhZyAqdGFnOwo+LQo+LQlpZiAoIW1lbV9h
bGxvY19wcm9maWxpbmdfZW5hYmxlZCgpKQo+LQkJcmV0dXJuOwo+LQo+LQl0YWcgPSBfX3BnYWxs
b2NfdGFnX2dldChwYWdlKTsKPiAJaWYgKHRhZykKPiAJCXRoaXNfY3B1X3N1Yih0YWctPmNvdW50
ZXJzLT5ieXRlcywgUEFHRV9TSVpFICogbnIpOwo+IH0KPkBAIC0xMTY4LDcgKzExNjMsNyBAQCBz
dGF0aWMgaW5saW5lIHZvaWQgcGdhbGxvY190YWdfc3ViX3BhZ2VzKHN0cnVjdCBwYWdlICpwYWdl
LCB1bnNpZ25lZCBpbnQgbnIpCj4gc3RhdGljIGlubGluZSB2b2lkIHBnYWxsb2NfdGFnX2FkZChz
dHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLAo+IAkJCQkgICB1bnNp
Z25lZCBpbnQgbnIpIHt9Cj4gc3RhdGljIGlubGluZSB2b2lkIHBnYWxsb2NfdGFnX3N1YihzdHJ1
Y3QgcGFnZSAqcGFnZSwgdW5zaWduZWQgaW50IG5yKSB7fQo+LXN0YXRpYyBpbmxpbmUgdm9pZCBw
Z2FsbG9jX3RhZ19zdWJfcGFnZXMoc3RydWN0IHBhZ2UgKnBhZ2UsIHVuc2lnbmVkIGludCBucikg
e30KPitzdGF0aWMgaW5saW5lIHZvaWQgcGdhbGxvY190YWdfc3ViX3BhZ2VzKHN0cnVjdCBhbGxv
Y190YWcgKnRhZywgdW5zaWduZWQgaW50IG5yKSB7fQo+IAo+ICNlbmRpZiAvKiBDT05GSUdfTUVN
X0FMTE9DX1BST0ZJTElORyAqLwo+IAo+QEAgLTUwNjUsMTEgKzUwNjAsMTMgQEAgc3RhdGljIHZv
aWQgX19fZnJlZV9wYWdlcyhzdHJ1Y3QgcGFnZSAqcGFnZSwgdW5zaWduZWQgaW50IG9yZGVyLAo+
IHsKPiAJLyogZ2V0IFBhZ2VIZWFkIGJlZm9yZSB3ZSBkcm9wIHJlZmVyZW5jZSAqLwo+IAlpbnQg
aGVhZCA9IFBhZ2VIZWFkKHBhZ2UpOwo+KwkvKiBnZXQgYWxsb2MgdGFnIGluIGNhc2UgdGhlIHBh
Z2UgaXMgcmVsZWFzZWQgYnkgb3RoZXJzICovCj4rCXN0cnVjdCBhbGxvY190YWcgKnRhZyA9IHBn
YWxsb2NfdGFnX2dldChwYWdlKTsKPiAKPiAJaWYgKHB1dF9wYWdlX3Rlc3R6ZXJvKHBhZ2UpKQo+
IAkJX19mcmVlX2Zyb3plbl9wYWdlcyhwYWdlLCBvcmRlciwgZnBpX2ZsYWdzKTsKPiAJZWxzZSBp
ZiAoIWhlYWQpIHsKPi0JCXBnYWxsb2NfdGFnX3N1Yl9wYWdlcyhwYWdlLCAoMSA8PCBvcmRlcikg
LSAxKTsKPisJCXBnYWxsb2NfdGFnX3N1Yl9wYWdlcyh0YWcsICgxIDw8IG9yZGVyKSAtIDEpOwo+
IAkJd2hpbGUgKG9yZGVyLS0gPiAwKQo+IAkJCV9fZnJlZV9mcm96ZW5fcGFnZXMocGFnZSArICgx
IDw8IG9yZGVyKSwgb3JkZXIsCj4gCQkJCQkgICAgZnBpX2ZsYWdzKTsKPi0tIAo+Mi4zOS4yCg==


