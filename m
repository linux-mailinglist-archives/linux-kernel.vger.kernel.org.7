Return-Path: <linux-kernel+bounces-642616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AFCAB2115
	for <lists+linux-kernel@lfdr.de>; Sat, 10 May 2025 05:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C2816AC25
	for <lists+linux-kernel@lfdr.de>; Sat, 10 May 2025 03:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E01A38F9;
	Sat, 10 May 2025 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="QUBvHjiH"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6C4288D6
	for <linux-kernel@vger.kernel.org>; Sat, 10 May 2025 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746849547; cv=none; b=Nlnk4tJFQ0le7SUs9GmzbkLFFWWxsQS3bi8wY7i9AUl5f6GCrd6GSfnK08Tuq0EEpnUCxVAWJwevjUm3JGJ+l8CCMM63ae36p2ZSxebxBJJ/aZ1Qxw/eJRJ4HemFheioXrYynjiqBmdU20nU5KdxLCUY6l/gqWPlBTspmHUKc90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746849547; c=relaxed/simple;
	bh=9Cw381KLctZ4HcdUtbAymFU967UMtv9Lndj7P6qd76E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Q7agr23kh6uuA/ytWiwIuCRhY3pqlqlOP6jHnUkyoxqTK03CFU7RTZkFVy9y+mG7cNIi+NgQ8gaGKGIQD2mn3cloFX86YogfjVSurqrbRhlHL2GQ51igyBG38fXFsRhdOTgoCnBnFut7oQUFaynACsVSwr4EdwyRb0d+LNbEb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=QUBvHjiH reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=nDcIRkEQ4CSUXxX0dVJa+XqS7i/HGdMYdn6W7O/fhZs=; b=Q
	UBvHjiH4hHjv3jrTggxBOFs4UI0K/C6DqgSVBPV9+6JJMhDyOkqmUB5oRpDnkIG5
	AQ1etguwzTU8PtPDsqFQ57ho1Xla4yFjtakSYhRhL00OXmFNX8JyNdr6EwsdpjhZ
	Oa19q+pJdC9WphQH7fsLP16E6CKcUgkS3OTEoC2jP0=
Received: from 00107082$163.com ( [111.35.191.17] ) by
 ajax-webmail-wmsvr-40-128 (Coremail) ; Sat, 10 May 2025 11:58:04 +0800
 (CST)
Date: Sat, 10 May 2025 11:58:04 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: "Tim Chen" <tim.c.chen@linux.intel.com>, kent.overstreet@linux.dev,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] alloc_tag: keep codetag iterator active between
 read() calls
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpHuYHJh6yM+na0WLi3Lb910m73Xth8N3ZBnJKpAW5Qxww@mail.gmail.com>
References: <20250507175500.204569-1-00107082@163.com>
 <20250509173929.42508-1-00107082@163.com>
 <7f237574d9f08a9fa8dcaa60d2edf8d8e91441d4.camel@linux.intel.com>
 <CAJuCfpHB8T8daanvE_wowRD9-sAo30rtCcFfMPZL_751+KSs5w@mail.gmail.com>
 <294d0743c0b2e5c409857ef81a6fe8baaf87727f.camel@linux.intel.com>
 <CAJuCfpF=u-LpR6S+XmwPe8a6h4knzP2Nu5WFp=Rdvqa14vOzDA@mail.gmail.com>
 <CAJuCfpFLqTR=KfkstR-iRQvE7ZQMsr9=jXj6C4VdFq-Ebq6mvQ@mail.gmail.com>
 <3cbaf905.ef7.196b82bdcc9.Coremail.00107082@163.com>
 <CAJuCfpHuYHJh6yM+na0WLi3Lb910m73Xth8N3ZBnJKpAW5Qxww@mail.gmail.com>
X-NTES-SC: AL_Qu2fBPSftkwj4iKYYukZnEYQheY4XMKyuPkg1YJXOp80liTj+QsqeHJmM2fy0MWCMhmgvRWIThZo2P9Ff7J6UbIozmhKmBHnAGsdkfASGrC/
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7bb65ee6.129c.196b857cdb3.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gCgvCgD3_wTNzh5oty8BAA--.8433W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqBdJqmgeyjBdrQACsi
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI1LTA1LTEwIDExOjMwOjUwLCAiU3VyZW4gQmFnaGRhc2FyeWFuIiA8c3VyZW5iQGdv
b2dsZS5jb20+IHdyb3RlOgo+T24gRnJpLCBNYXkgOSwgMjAyNSBhdCA4OjEw4oCvUE0gRGF2aWQg
V2FuZyA8MDAxMDcwODJAMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+Cj4+IEF0IDIwMjUtMDUtMTAgMDU6
MTU6NDMsICJTdXJlbiBCYWdoZGFzYXJ5YW4iIDxzdXJlbmJAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4+
ID5PbiBGcmksIE1heSA5LCAyMDI1IGF0IDE6NDbigK9QTSBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1
cmVuYkBnb29nbGUuY29tPiB3cm90ZToKPj4gPj4KPj4gPj4gT24gRnJpLCBNYXkgOSwgMjAyNSBh
dCAxMjo0NuKAr1BNIFRpbSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6
Cj4+ID4+ID4KPj4gPj4gPiBPbiBGcmksIDIwMjUtMDUtMDkgYXQgMTI6MzYgLTA3MDAsIFN1cmVu
IEJhZ2hkYXNhcnlhbiB3cm90ZToKPj4gPj4gPiA+IE9uIEZyaSwgTWF5IDksIDIwMjUgYXQgMTE6
MzPigK9BTSBUaW0gQ2hlbiA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+PiA+
PiA+ID4gPgo+PiA+PiA+ID4gPiBPbiBTYXQsIDIwMjUtMDUtMTAgYXQgMDE6MzkgKzA4MDAsIERh
dmlkIFdhbmcgd3JvdGU6Cj4+ID4+ID4gPiA+ID4KPj4gPj4gPiA+ID4gPgo+PiA+PiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IERhdmlkIFdhbmcgPDAwMTA3MDgyQDE2My5jb20+Cj4+ID4+ID4gPgo+
PiA+PiA+ID4gQWNrZWQtYnk6IFN1cmVuIEJhZ2hkYXNhcnlhbiA8c3VyZW5iQGdvb2dsZS5jb20+
Cj4+ID4+ID4gPgo+PiA+PiA+ID4gPiA+IC0tLQo+PiA+PiA+ID4gPiA+ICBsaWIvYWxsb2NfdGFn
LmMgfCAyOSArKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiA+PiA+ID4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCj4+ID4+ID4gPiA+
ID4KPj4gPj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbGliL2FsbG9jX3RhZy5jIGIvbGliL2FsbG9j
X3RhZy5jCj4+ID4+ID4gPiA+ID4gaW5kZXggMjVlY2MxMzM0YjY3Li5mZGQ1ODg3NzY5YTYgMTAw
NjQ0Cj4+ID4+ID4gPiA+ID4gLS0tIGEvbGliL2FsbG9jX3RhZy5jCj4+ID4+ID4gPiA+ID4gKysr
IGIvbGliL2FsbG9jX3RhZy5jCj4+ID4+ID4gPiA+ID4gQEAgLTQ1LDIxICs0NSwxNiBAQCBzdHJ1
Y3QgYWxsb2NpbmZvX3ByaXZhdGUgewo+PiA+PiA+ID4gPiA+ICBzdGF0aWMgdm9pZCAqYWxsb2Np
bmZvX3N0YXJ0KHN0cnVjdCBzZXFfZmlsZSAqbSwgbG9mZl90ICpwb3MpCj4+ID4+ID4gPiA+ID4g
IHsKPj4gPj4gPiA+ID4gPiAgICAgICBzdHJ1Y3QgYWxsb2NpbmZvX3ByaXZhdGUgKnByaXY7Cj4+
ID4+ID4gPiA+ID4gLSAgICAgc3RydWN0IGNvZGV0YWcgKmN0Owo+PiA+PiA+ID4gPiA+ICAgICAg
IGxvZmZfdCBub2RlID0gKnBvczsKPj4gPj4gPiA+ID4gPgo+PiA+PiA+ID4gPiA+IC0gICAgIHBy
aXYgPSBremFsbG9jKHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOwo+PiA+PiA+ID4gPiA+IC0g
ICAgIG0tPnByaXZhdGUgPSBwcml2Owo+PiA+PiA+ID4gPiA+IC0gICAgIGlmICghcHJpdikKPj4g
Pj4gPiA+ID4gPiAtICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+PiA+PiA+ID4gPiA+IC0KPj4g
Pj4gPiA+ID4gPiAtICAgICBwcml2LT5wcmludF9oZWFkZXIgPSAobm9kZSA9PSAwKTsKPj4gPj4g
PiA+ID4gPiArICAgICBwcml2ID0gKHN0cnVjdCBhbGxvY2luZm9fcHJpdmF0ZSAqKW0tPnByaXZh
dGU7Cj4+ID4+ID4gPiA+ID4gICAgICAgY29kZXRhZ19sb2NrX21vZHVsZV9saXN0KGFsbG9jX3Rh
Z19jdHR5cGUsIHRydWUpOwo+PiA+PiA+ID4gPiA+IC0gICAgIHByaXYtPml0ZXIgPSBjb2RldGFn
X2dldF9jdF9pdGVyKGFsbG9jX3RhZ19jdHR5cGUpOwo+PiA+PiA+ID4gPiA+IC0gICAgIHdoaWxl
ICgoY3QgPSBjb2RldGFnX25leHRfY3QoJnByaXYtPml0ZXIpKSAhPSBOVUxMICYmIG5vZGUpCj4+
ID4+ID4gPiA+ID4gLSAgICAgICAgICAgICBub2RlLS07Cj4+ID4+ID4gPiA+ID4gLQo+PiA+PiA+
ID4gPiA+IC0gICAgIHJldHVybiBjdCA/IHByaXYgOiBOVUxMOwo+PiA+PiA+ID4gPiA+ICsgICAg
IGlmIChub2RlID09IDApIHsKPj4gPj4gPiA+ID4gPiArICAgICAgICAgICAgIHByaXYtPnByaW50
X2hlYWRlciA9IHRydWU7Cj4+ID4+ID4gPiA+ID4gKyAgICAgICAgICAgICBwcml2LT5pdGVyID0g
Y29kZXRhZ19nZXRfY3RfaXRlcihhbGxvY190YWdfY3R0eXBlKTsKPj4gPj4gPiA+ID4gPiArICAg
ICAgICAgICAgIGNvZGV0YWdfbmV4dF9jdCgmcHJpdi0+aXRlcik7Cj4+ID4+ID4gPiA+ID4gKyAg
ICAgfQo+PiA+PiA+ID4gPgo+PiA+PiA+ID4gPiBEbyB5b3UgbmVlZCB0byBza2lwIHByaW50IGhl
YWRlciB3aGVuICpwb3MgIT0gMD8gaS5lIGFkZAo+PiA+PiA+ID4KPj4gPj4gPiA+IFRlY2huaWNh
bGx5IG5vdCBuZWVkZWQgc2luY2UgcHJvY19jcmVhdGVfc2VxX3ByaXZhdGUoKSBhbGxvY2F0ZXMK
Pj4gPj4gPiA+IHNlcS0+cHJpdmF0ZSB1c2luZyBremFsbG9jKCksIHNvIHRoZSBpbml0aWFsIHZh
bHVlIG9mCj4+ID4+ID4gPiBwcml2LT5wcmludF9oZWFkZXIgaXMgYWx3YXlzIGZhbHNlLgo+PiA+
PiA+Cj4+ID4+ID4gQnV0IHdlJ2xsIHN0YXJ0IHdpdGggZmlyc3QgY2FsbCB0byBhbGxvY2luZm9f
c3RhcnQoKSB3aXRoICpwb3MgPT0gMCwKPj4gPj4KPj4gPj4gVXN1YWxseSBidXQgbm90IGFsd2F5
cyBpZiB3ZSBkbyBsc2VlaygpIHRvIGEgbm9uLXplcm8gcG9zaXRpb24gYmVmb3JlaGFuZC4KPj4g
Pgo+PiA+QWN0dWFsbHksIHRoaXMgY2hhbmdlIHdpbGwgYnJlYWsgdGhlIGxzZWVrKCkgY2FzZS4g
V2UgY2FuJ3QgYWx3YXlzCj4+ID5hc3N1bWUgdGhhdCB3ZSBzdGFydCByZWFkaW5nIGZyb20gKnBv
cyA9PSAwLiBDdXJyZW50IHBhdGNoIHdpbGwgZmFpbAo+PiA+dG8gaW5pdGlhbGl6ZSBwcml2IGlm
IHdlIHN0YXJ0IHJlYWRpbmcgd2l0aCAqcG9zICE9IDAuCj4+ID5wcml2LT5pdGVyIHNob3VsZCBi
ZSB0cmFja2luZyBjdXJyZW50IHBvc2l0aW9uIGFuZCBhbGxvY2luZm9fc3RhcnQoKQo+PiA+c2hv
dWxkIGRldGVjdCBhIG1pc21hdGNoIGJldHdlZW4gKnBvcyBhbmQgaXRlci0+cG9zIGFuZCByZS13
YWxrIHRoZQo+PiA+dGFncyBpZiB0aGVyZSB3YXMgYSBwb3NpdGlvbiBjaGFuZ2UuCj4+Cj4+IHNl
cV9maWxlIHdvcmtzIGxpbmUgYnkgbGluZSwgIEkgdGhpbmsgZXZlbiBpZiBpdCBzdXBwb3J0IGxz
ZWVrLCBzZXFfZmlsZSB3b3VsZCBzdGlsbCBzdGFydCB3aXRoIGxpbmUgIzAsCj4+IHNpbmNlIHNl
cV9maWxlIGhhdmUgb24gY2x1ZSB0aGUgYnl0ZSBzaXplIGZvciBlYWNoIGxpbmUuCj4+Cj4+IEkg
d2lsbCBjaGVjayB0aGUgY29kZSwgIG1ha2Ugc29tZSB0ZXN0cyBhbmQgdXBkYXRlIGxhdGVyLgo+
Cj5BaCwgeWVzLiBZb3UgYXJlIGNvcnJlY3QuCj5zZXFfbHNlZWsoKSB3aWxsIHRyYXZlcnNlIHJl
c3RhcnRpbmcgZnJvbSAwOgo+aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTQu
Ni9zb3VyY2UvZnMvc2VxX2ZpbGUuYyNMMzIzLgo+UG9zaXRpb24ganVtcHMgYXJlIHNpbWlsYXJs
eSBoYW5kbGVkIHdpdGggdHJhdmVyc2FsIGZyb20gMDoKPmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4u
Y29tL2xpbnV4L3Y2LjE0LjYvc291cmNlL2ZzL3NlcV9maWxlLmMjTDE5NC4KPgoKQWN0dWFsbHkg
SSB3YXMgZXhwZWN0aW5nIEVPUE5PVFNVUFAgd2hlbiBsc2VlayBvbiBzZXEgZmlsZXMsIHN1cnBy
aXNlZCB0byBzZWUgaXQgd29ya3MuLi4uLi4gOikKCklmIHNlcV9maWxlIHNvbWVob3cgc2tpcHMg
c3RhcnQoMCksICB0aGVuIG5vdGhpbmcgd291bGQgYmUgZGlzcGxheWVkIHNpbmNlIApwcml2LT5p
dGVyLmN0IHdvdWxkIGJlIDAgYW5kIGByZXR1cm4gcHJpdi0+aXRlci5jdCA/IHByaXYgOiBOVUxM
O2Agd291bGQgcmV0dXJuIE5VTEw7CkJ1dCBJIHRoaW5rIHRoYXQgY2FzZSAgd291bGQgYmUgIHNl
cV9maWxlJ3MgYnVnLCAgIHN0YXJ0aW5nIHdpdGggMCBpcyBraW5kIG9mIHByb3RvY29sIHByb21p
c2VkIGJ5IHNlcV9maWxlLiAKCgo+PgoKPj4KPj4gPgo+PiA+Pgo+PiA+PiA+IHRoZW4gcHJpbnRf
aGVhZGVyIHdpbGwgYmUgaW5pdGlhbGl6ZWQgdG8gdHJ1ZS4KPj4gPj4KPj4gPj4gQWZ0ZXIgdGhl
IGZpcnN0IGNhbGwgdG8gYWxsb2NpbmZvX3Nob3coKSBwcmludF9oZWFkZXIgd2lsbCBiZSByZXNl
dAo+PiA+PiBiYWNrIHRvIGZhbHNlLgo+PiA+Pgo+PiA+PiA+IFdpbGwgdGhlcmUgYmUgc3Vic2Vx
dWVudCBjYWxscyBvZiBhbGxvY2luZm9fc3RhcnQoKSB3aXRoICpwb3MgIT0wLAo+PiA+PiA+IGJ1
dCBwcml2LT5wcmludF9oZWFkZXIgc3RheXMgYXQgMD8KPj4gPj4KPj4gPj4gWWVzLCB0aGVyZSB3
aWxsIGJlIHN1YnNlcXVlbnQgY2FsbHMgdG8gYWxsb2NpbmZvX3N0YXJ0KCkgd2l0aCAqcG9zICE9
MAo+PiA+PiBhbmQgcHJpdi0+cHJpbnRfaGVhZGVyPWZhbHNlLCB3aGljaCBpcyB3aGF0IHdlIHdh
bnQsIHJpZ2h0PyBXZSB3YW50IHRvCj4+ID4+IHByaW50IHRoZSBoZWFkZXIgb25seSBhdCB0aGUg
YmVnaW5uaW5nIG9mIHRoZSBmaWxlIChub2RlID09IDApLgo+PiA+Pgo+PiA+PiA+Cj4+ID4+ID4g
VGltCj4+ID4+ID4gPgo+PiA+PiA+ID4gPgo+PiA+PiA+ID4gPiAgICAgICAgIH0gZWxzZSB7Cj4+
ID4+ID4gPiA+ICAgICAgICAgICAgICAgICBwcml2LT5wcmludF9oZWFkZXIgPSBmYWxzZTsKPj4g
Pj4gPiA+ID4gICAgICAgICB9Cj4+ID4+ID4gPiA+Cj4+ID4+ID4gPiA+IFRpbQo+PiA+PiA+ID4g
Pgo+PiA+PiA+ID4gPiA+ICsgICAgIHJldHVybiBwcml2LT5pdGVyLmN0ID8gcHJpdiA6IE5VTEw7
Cj4+ID4+ID4gPiA+ID4gIH0KPj4gPj4gPiA+ID4gPgo+PiA+PiA+ID4gPgo+PiA+PiA+Cg==

