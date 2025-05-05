Return-Path: <linux-kernel+bounces-632607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F5FAA9999
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 18:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0EB3A31ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9D625DCEC;
	Mon,  5 May 2025 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Hd9UyoN1"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E2E189916
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463491; cv=none; b=WcpQA4/8HJDcC7qlkGmFXvvyX+bUK4JY4dn+D+gVpncegLj0xD9t/SfBugfe2ttKM0QXR9iCWKAK6T0IcV8/YJAqe7XsVkfkJ9BAzjZEjN2LaRwXNYDjdEAMIvpP0MgRLfnkFG6CSACRj5FHMM9KBkqRgNrQy+14+ftYG8ocY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463491; c=relaxed/simple;
	bh=5AdZ9BuxWl7YvyIoRvD0eR9p9c6NIPgV5IaUN9XFB6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=HkGpIW4MqyAL3/1KBDFdFWPpW/TP4HsmvbmzSD9JCY7Ig0vzDT3NJbQJqmS2k47vLojCWl/VFp2FBZC1UZ6uDIs0Dm3dUuPC5BA1Gc4tPmJjF2xARRl8R531xjK0F53wTji+kRm+ZB63n/+91IyaIUdVzp0epM/aq2C77C0w13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Hd9UyoN1 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=kfkVVVSgzqjU7YqGCUhayd/q7iJiFadlQEQ5wDeBZAM=; b=H
	d9UyoN18sy+2vS979XJT6fI9bjSy6khLNut+WmrjChjFNTEGpAJ7zfUkwyJ2ZPW8
	fkB7v9aiGl6piHr39yZ/vJzqSoa1zJNip178kHRoO0QVlzBAsfTBvZbpr/+X01qO
	ADKhewXMV14D32Xdg+kUxZxulCIsT7SYQ0BYcpuuXE=
Received: from 00107082$163.com ( [111.35.191.17] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Tue, 6 May 2025 00:42:36 +0800 (CST)
Date: Tue, 6 May 2025 00:42:36 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: "Vlastimil Babka" <vbabka@suse.cz>, akpm@linux-foundation.org,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	"Shakeel Butt" <shakeel.butt@linux.dev>
Subject: Re: [PATCH] mm/codetag: sub in advance when free non-compound high
 order pages
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpHS9obp7yoxRUPoj3Yp8KkkYWCnnoXwtmAOxfynnq8aug@mail.gmail.com>
References: <20250504061923.66914-1-00107082@163.com>
 <8edbd2be-d495-4bfc-a9f3-6eaae7a66d91@suse.cz>
 <1da43908.3afc.196a0db7dc3.Coremail.00107082@163.com>
 <0feb4309-431f-4b74-83bf-e16198798c30@suse.cz>
 <CAJuCfpHS9obp7yoxRUPoj3Yp8KkkYWCnnoXwtmAOxfynnq8aug@mail.gmail.com>
X-NTES-SC: AL_Qu2fBPidvEsu4CGRZekXn0oTju85XMCzuv8j3YJeN500mCTywxwvZ25DJ3zU0fmIJSKmoQm9bj9I+NtXXrN5cZhU0HoW6mjWXu8S6k+gFbZa
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3be93014.40dc.196a153f521.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gSgvCgD3HxF96hhoT5ujAA--.53264W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBkA5EqmgYz3EnGwADsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKQXQgMjAyNS0wNS0wNSAyMzozMzo1MCwgIlN1cmVuIEJhZ2hkYXNhcnlhbiIgPHN1cmVuYkBn
b29nbGUuY29tPiB3cm90ZToKPk9uIE1vbiwgTWF5IDUsIDIwMjUgYXQgNzo1NeKAr0FNIFZsYXN0
aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+IHdyb3RlOgo+Pgo+PiBPbiA1LzUvMjUgMTY6MzEs
IERhdmlkIFdhbmcgd3JvdGU6Cj4+ID4KPj4gPgo+PiA+IEF0IDIwMjUtMDUtMDUgMjE6MTI6NTUs
ICJWbGFzdGltaWwgQmFia2EiIDx2YmFia2FAc3VzZS5jej4gd3JvdGU6Cj4+ID4+T24gNS80LzI1
IDA4OjE5LCBEYXZpZCBXYW5nIHdyb3RlOgo+PiA+Pj4gV2hlbiBwYWdlIGlzIG5vbi1jb21wb3Vu
ZCwgcGFnZVswXSBjb3VsZCBiZSByZWxlYXNlZCBieSBvdGhlcgo+PiA+Pj4gdGhyZWFkIHJpZ2h0
IGFmdGVyIHB1dF9wYWdlX3Rlc3R6ZXJvIGZhaWxlZCBpbiBjdXJyZW50IHRocmVhZCwKPj4gPj4+
IHBnYWxsb2NfdGFnX3N1Yl9wYWdlcyBhZnRlcndhcmRzIHdvdWxkIG1hbmlwdWxhdGUgYW4gaW52
YWxpZAo+PiA+Pj4gcGFnZSBmb3IgYWNjb3VudGluZyByZW1haW5pbmcgcGFnZXM6Cj4+ID4+Pgo+
PiA+Pj4gW3RpbWVsaW5lXSAgIFt0aHJlYWQxXSAgICAgICAgICAgICAgICAgICAgIFt0aHJlYWQy
XQo+PiA+Pj4gICB8ICAgICAgICAgIGFsbG9jX3BhZ2Ugbm9uLWNvbXBvdW5kCj4+ID4+PiAgIFYK
Pj4gPj4+ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZXRfcGFn
ZSwgcmYgY291bnRlciBpbmMKPj4gPj4+ICAgVgo+PiA+Pj4gICB8ICAgICAgICAgIGluIF9fX2Zy
ZWVfcGFnZXMKPj4gPj4+ICAgfCAgICAgICAgICBwdXRfcGFnZV90ZXN0emVybyBmYWlscwo+PiA+
Pj4gICBWCj4+ID4+PiAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cHV0X3BhZ2UsIHBhZ2UgcmVsZWFzZWQKPj4gPj4+ICAgVgo+PiA+Pj4gICB8ICAgICAgICAgIGlu
IF9fX2ZyZWVfcGFnZXMsCj4+ID4+PiAgIHwgICAgICAgICAgcGdhbGxvY190YWdfc3ViX3BhZ2Vz
Cj4+ID4+PiAgIHwgICAgICAgICAgbWFuaXB1bGF0ZSBhbiBpbnZhbGlkIHBhZ2UKPj4gPj4+ICAg
Vgo+PiA+Pj4gICBWCj4+ID4+Pgo+PiA+Pj4gTW92ZSB0aGUgdGFnIHBhZ2UgYWNjb3VudGluZyBh
aGVhZCwgYW5kIG9ubHkgYWNjb3VudCByZW1haW5pbmcgcGFnZXMKPj4gPj4+IGZvciBub24tY29t
cG91bmQgcGFnZXMgd2l0aCBub24temVybyBvcmRlci4KPj4gPj4+Cj4+ID4+PiBTaWduZWQtb2Zm
LWJ5OiBEYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMuY29tPgo+Cj5UaGFua3MgZm9yIHJlcG9ydGlu
ZyEKPgo+PiA+Pgo+PiA+PkhtbSwgSSB0aGluayB0aGUgcHJvYmxlbSB3YXMgaW50cm9kdWNlZCBi
eSA1MWZmNGQ3NDg2ZjAgKCJtbTogYXZvaWQgZXh0cmEKPj4gPj5tZW1fYWxsb2NfcHJvZmlsaW5n
X2VuYWJsZWQoKSBjaGVja3MiKS4gUHJldmlvdXNseSB3ZSdkIGdldCB0aGUgdGFnIHBvaW50ZXIK
Pj4gPj51cGZyb250IGFuZCBhdm9pZCB0aGUgcGFnZSB1c2UtYWZ0ZXItZnJlZS4KPgo+UmlnaHQs
IHNvcnJ5IEkgbWlzc2VkIHRoYXQuCj4KPj4gPgo+PiA+Cj4+ID4gT2gsIHlvdSdyZSByaWdodC4g
SSBmb3Jnb3QgdG8gY2hlY2sgaGlzdG9yeS4uLi4uLgo+PiA+Cj4+ID4KPj4gPj4KPj4gPj5JdCB3
b3VsZCBsaWtlbHkgYmUgbmljZXIgdG8gZml4IGl0IGJ5IGdvaW5nIGJhY2sgdG8gdGhhdCBhcHBy
b2FjaCBmb3IKPj4gPj5fX19mcmVlX3BhZ2VzKCksIHdoaWxlIGhvcGVmdWxseSBrZWVwaW5nIHRo
ZSBvcHRpbWlzYXRpb25zIG9mIDUxZmY0ZDc0ODZmMAo+PiA+PmZvciB0aGUgb3RoZXIgY2FsbCBz
aXRlcyB3aGVyZSBpdCBhcHBsaWVzPwo+PiA+Cj4+ID4gQWZ0ZXIgY2hlY2tpbmcgdGhhdCBjb21t
aXQsIEkga2luZCBvZiBmZWVscyB0aGUgY2hhbmdlcyBpbiBfX2ZyZWVfcGFnZXMgYXJlCj4+ID4g
IHRoZSBtYWpvciBvcHRpbWl6YXRpb24gb2YgdGhlIGNvbW1pdC4uLi4KPj4KPj4gV2UgY291bGQg
aGF2ZSBib3RoIHBnYWxsb2NfdGFnX2dldCgpIHRvIHVzZSBpbiBfX2ZyZWVfcGFnZSgpIGFzIGJl
Zm9yZQo+PiA1MWZmNGQ3NDg2ZjAsIGFuZCBrZWVwIF9fcGdhbGxvY190YWdfZ2V0KCkgdG8gdXNl
IGluIHBnYWxsb2NfdGFnX3NwbGl0KCkgYW5kCj4+IHBnYWxsb2NfdGFnX3N3YXAoKS4KPgo+WWVz
LCB3ZSBjYW4gYWRkIGJhY2sgcGdhbGxvY190YWdfZ2V0KCkgd2hpY2ggd291bGQgY2FsbAo+X19w
Z2FsbG9jX3RhZ19nZXQoKSBpZiBtZW1fYWxsb2NfcHJvZmlsaW5nX2VuYWJsZWQoKSBpcyB0cnVl
IGFuZAo+Y2hhbmdlIHBnYWxsb2NfdGFnX3N1Yl9wYWdlcygpIGJhY2sgdG8gdXNlIHRhZ3MgaW5z
dGVhZCBvZiBwYWdlcy4KPl9fZnJlZV9wYWdlcygpIGlzIHRoZSBvbmx5IHVzZXIgb2YgdGhhdCBm
dW5jdGlvbiwgc28gdGhhdCBjaGFuZ2UKPnNob3VsZCBub3QgYWZmZWN0IGFueXRoaW5nIGVsc2Uu
CgoKQWRkaW5nIGJhY2sgcGdhbGxvY190YWdfZ2V0KCkgc2VlbXMganVzdCByZXZlcnRpbmcgNTFm
ZjRkNzQ4NmYwLi4uLi4KRG8geW91IHdhbnQgbWUgdG8gZG8gaXQgb3IgeW91IHRha2Ugb3ZlciBh
bmQgbWFrZSBmdXJ0aGVyIGFkanVzdG1lbnRzPwoKCgo+Cj4+Cj4+IEkgdGhpbmsgX19mcmVlX3Bh
Z2UoKSBkaWRuJ3QgYmVuZWZpdCBmcm9tIHRoZSBzdGF0ZWQgcHVycG9zZSBvZiAiYXZvaWRpbmcK
Pj4gbWVtX2FsbG9jX3Byb2ZpbGluZ19lbmFibGVkKCkgLi4uIHdoaWNoIGlzIG9mdGVuIGNhbGxl
ZCBhZnRlciB0aGF0IGNoZWNrIHdhcwo+PiBhbHJlYWR5IGRvbmUiCj4+Cj4+ID4gV2hhdCBhYm91
dCByZXZlcnQgdGhhdCBjb21taXQgYW5kIG1ha2Ugb3B0aW1pemF0aW9uIGJ5IGNvbmRpdGlvbiBj
aGVja3MsCj4+ID4gc2ltaWxhciB0byB3aGF0IHRoaXMgcGF0Y2ggZGlkPwo+Pgo+PiBUaGUgZG93
bnNpZGUgb2YgdGhlIGNvbmRpdGlvbiBjaGVja3MgaXMgdGhleSBtYWtlIHRoZSBjb2RlIG1vcmUg
Y29tcGxleCBhbmQKPj4gbWlnaHQgYWN0dWFsbHkgaW5jcmVhc2Ugb3ZlcmhlYWQgd2hlbiBtZW1f
YWxsb2NfcHJvZmlsaW5nX2VuYWJsZWQoKSBpcwo+PiBmYWxzZSwgYXMgdGhvc2UgY2hlY2tzIGFk
ZCBub24tc3RhdGljIGJyYW5jaGVzIG91dHNpZGUgb2YgdGhlIHN0YXRpYyBicmFuY2gKPj4gdGhh
dCdzIG1lbV9hbGxvY19wcm9maWxpbmdfZW5hYmxlZCgpLgo+Pgo+PiBJIHRoaW5rIF9fZnJlZV9w
YWdlcygpIGJlZm9yZSA1MWZmNGQ3NDg2ZjAgd2FzIHF1aXRlIG9rLgo+Pgo+PiAtIHBnYWxsb2Nf
dGFnX2dldCgpIGlzIGRvbmUgdW5jb25kaXRpb25hbGx5LCBidXQgaXRzIGNvZGUgaXMgYWxsIGlu
c2lkZSB0aGUKPj4gbWVtX2FsbG9jX3Byb2ZpbGluZ19lbmFibGVkKCkgc3RhdGljIGJyYW5jaCBz
byB0aGF0J3MgYSBuby1vcCB3aGVuIHByb2ZpbGluZwo+PiBpcyBub3QgZW5hYmxlZAo+Pgo+PiAt
IHBnYWxsb2NfdGFnX3N1Yl9wYWdlcygpIGlzIGFsc28gYWxsIGJlaGluZCB0aGUgc3RhdGljIGJy
YW5jaCBpbnNpZGUuIEFsc28KPj4gaXQncyBhIHZlcnkgcmFyZSBwYXRoIGFueXdheSwgbW9zdCBm
cmVlaW5nIHNob3VsZCBnbyB0aHJvdWdoIHRoZQo+PiBwdXRfcGFnZV90ZXN0emVybygpIGJlaW5n
IHRydWUuCj4KPlllYWgsIHRoZSBtYWluIGdvYWwgb2YgdGhhdCBjaGFuZ2UgaW4gX19mcmVlX3Bh
Z2UoKSB3YXMgdG8gbWFrZQo+X19wZ2FsbG9jX3RhZ19nZXQoKSBhIGxvY2FsIGZ1bmN0aW9uIGZv
ciBhbGxvY190YWdzIGFuZCBsaW1pdGluZyB0aGUKPmRpcmVjdCB1c2Ugb2Ygc3RydWN0IGFsbG9j
X3RhZyBpbiB0aGUgY29yZSBtbSBjb2RlLiBPYnZpb3VzbHkgSQo+c2NyZXdlZCB1cCBmb3JnZXR0
aW5nIHdoeSB3ZSBoYWQgdG8gc3RvcmUgdGhlIHRhZyBpbiB0aGUgZmlyc3QgcGxhY2UuCj5BbiBh
ZGRpdGlvbmFsIGNvbW1lbnQgaW4gX19mcmVlX3BhZ2UoKSBpcyBwcm9iYWJseSBhIGdvb2QgaWRl
YSB0bwo+YXZvaWQgY29uZnVzaW9uIGluIHRoZSBmdXR1cmUuCj5UaGFua3MsCj5TdXJlbi4KPgo+
Pgo+PiA+IERhdmlkCj4+ID4KPj4K

