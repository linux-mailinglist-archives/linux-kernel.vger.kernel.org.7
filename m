Return-Path: <linux-kernel+bounces-596291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F8A829DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 17:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFDE1BC7B96
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4A926657F;
	Wed,  9 Apr 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="GUkKmlg4"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E417C224
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211467; cv=none; b=nd7zVLtljvces7vKAPs3JA0l2a+hOL2hMbHi+tyhLPNxh70KW8tqw0VIcKVit2gptRY825PgXPNrlTXwYhDS2qaz0lNWrlZQOI2CnPxWDwI9U0/ahmzmVSssoebxmmbhXS7U+akE2fcqktrH+7am2IPUulZyLuOQqvmYOnNNztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211467; c=relaxed/simple;
	bh=AePvhI2SXWmJLqUoOjPYK90Odz11O+/6J4DVCQO4bY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=PK0OQm8ZuYzNk8TVBUdYQrRqDw9Djtpu0YsZ8OSkVZ+ZicHpTKMLDIZdwV2GXbmxyPdHO1sEUCs7BAq//xXA4/3cf/UtMyI3/JnUyR+FtUddkI4VgaFOeTwIcOXAXoMxyentxL6LeT2DTBOujKiEtDG5pZI330zoh0xmwiKcIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=GUkKmlg4 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=nsBLPsTvN38zqZ7XLV3XXpP451e6QwNbgp2j43yn7Vs=; b=G
	UkKmlg49Qai7KCvxxafh6vTCGInchXnp22q/mHTJCVznnB9wswN6gktrvJAOyy6n
	1i6lwoT/pcmWAzCFOP2CDhj/IE0poU3pQA2Hww3DJcRlfrJncauM4Z0Ozz9kwzG6
	2mOV8KfbooJhpxPEpb35j4lkw5w3Dt7obUyVqp31Mk=
Received: from xavier_qy$163.com ( [2408:820c:340b:d070:c540:cde:b0c8:b3ab]
 ) by ajax-webmail-wmsvr-40-117 (Coremail) ; Wed, 9 Apr 2025 23:10:17 +0800
 (CST)
Date: Wed, 9 Apr 2025 23:10:17 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: "Gavin Shan" <gshan@redhat.com>
Cc: dev.jain@arm.com, akpm@linux-foundation.org, baohua@kernel.org,
	ryan.roberts@arm.com, catalin.marinas@arm.com, ioworker0@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org
Subject: Re:Re: [PATCH v2 1/1] mm/contpte: Optimize loop to reduce redundant
 operations
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <34a4bf01-6324-482b-a011-32974d68e02f@redhat.com>
References: <027cc666-a562-46fa-bca5-1122ea00ec0e@arm.com>
 <20250408085809.2217618-1-xavier_qy@163.com>
 <20250408085809.2217618-2-xavier_qy@163.com>
 <34a4bf01-6324-482b-a011-32974d68e02f@redhat.com>
X-NTES-SC: AL_Qu2fBv6avkwq4SieY+kfmk4QgeY+WMW1vP4m34NSN5FwjD/pywkgQGVSIETq9eO0NCSzmgmGehVR0OBiRbhaTaA3b0gv6O+zHMLliZXa4jTDGA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <711cf430.b25d.1961b1a1b0e.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dSgvCgCXv2vZjfZnXrSSAA--.27650W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiTgcqEGf18hkl0QAGs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBHYXZpbiwKClRoYW5rIHlvdSBmb3IgY2FyZWZ1bGx5IHJldmlld2luZyB0aGlzIHBhdGNo
IGFuZCByYWlzaW5nIHlvdXIgcXVlc3Rpb25zLiAKSSdsbCB0cnkgdG8gZXhwbGFpbiBhbmQgYW5z
d2VyIHRoZW0gYmVsb3cuCgoKQXQgMjAyNS0wNC0wOSAxMjowOTo0OCwgIkdhdmluIFNoYW4iIDxn
c2hhbkByZWRoYXQuY29tPiB3cm90ZToKPkhpIFhhdmllciwKPgo+T24gNC84LzI1IDY6NTggUE0s
IFhhdmllciB3cm90ZToKPj4gVGhpcyBjb21taXQgb3B0aW1pemVzIHRoZSBjb250cHRlX3B0ZXBf
Z2V0IGZ1bmN0aW9uIGJ5IGFkZGluZyBlYXJseQo+PiAgIHRlcm1pbmF0aW9uIGxvZ2ljLiBJdCBj
aGVja3MgaWYgdGhlIGRpcnR5IGFuZCB5b3VuZyBiaXRzIG9mIG9yaWdfcHRlCj4+ICAgYXJlIGFs
cmVhZHkgc2V0IGFuZCBza2lwcyByZWR1bmRhbnQgYml0LXNldHRpbmcgb3BlcmF0aW9ucyBkdXJp
bmcKPj4gICB0aGUgbG9vcC4gVGhpcyByZWR1Y2VzIHVubmVjZXNzYXJ5IGl0ZXJhdGlvbnMgYW5k
IGltcHJvdmVzIHBlcmZvcm1hbmNlLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogWGF2aWVyIDx4YXZp
ZXJfcXlAMTYzLmNvbT4KPj4gLS0tCj4+ICAgYXJjaC9hcm02NC9tbS9jb250cHRlLmMgfCAyMiAr
KysrKysrKysrKysrKysrKysrKy0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9jb250
cHRlLmMgYi9hcmNoL2FybTY0L21tL2NvbnRwdGUuYwo+PiBpbmRleCBiY2FjNGY1NWY5YzEuLjAz
NGQxNTNkN2QxOSAxMDA2NDQKPj4gLS0tIGEvYXJjaC9hcm02NC9tbS9jb250cHRlLmMKPj4gKysr
IGIvYXJjaC9hcm02NC9tbS9jb250cHRlLmMKPj4gQEAgLTE1Miw2ICsxNTIsMTggQEAgdm9pZCBf
X2NvbnRwdGVfdHJ5X3VuZm9sZChzdHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5zaWduZWQgbG9uZyBh
ZGRyLAo+PiAgIH0KPj4gICBFWFBPUlRfU1lNQk9MX0dQTChfX2NvbnRwdGVfdHJ5X3VuZm9sZCk7
Cj4+ICAgCj4KPkknbSB3YW5kZXJpbmcgaG93IGl0IGNhbiB3b3JrLiBNb3JlIGRldGFpbHMgYXJl
IGdpdmVuIGJlbG93Lgo+Cj4+ICsjZGVmaW5lIENIRUNLX0NPTlRQVEVfRkxBRyhzdGFydCwgcHRl
cCwgb3JpZ19wdGUsIGZsYWcpIFwKPj4gKwlkbyB7IFwKPj4gKwkJaW50IF9zdGFydCA9IHN0YXJ0
OyBcCj4+ICsJCXB0ZV90ICpfcHRlcCA9IHB0ZXA7IFwKPj4gKwkJd2hpbGUgKF9zdGFydCsrIDwg
Q09OVF9QVEVTKSB7IFwKPj4gKwkJCWlmIChwdGVfIyNmbGFnKF9fcHRlcF9nZXQoX3B0ZXArKykp
KSB7IFwKPj4gKwkJCQlvcmlnX3B0ZSA9IHB0ZV9tayMjZmxhZyhvcmlnX3B0ZSk7IFwKPj4gKwkJ
CQlicmVhazsgXAo+PiArCQkJfSBcCj4+ICsJCX0gXAo+PiArCX0gd2hpbGUgKDApCj4+ICsKPgo+
Q09OVF9QVEVTIGlzIDE2IHdpdGggdGhlIGFzc3VtcHRpb24gb2YgNEtCIGJhc2UgcGFnZSBzaXpl
LiBDSEVDS19DT05UUFRFX0ZMQUcoKQo+Y29sbGVjdHMgdGhlIGZsYWcgZm9yIHB0ZXBbc3RhcnQs
IENPTlRfUFRFU10uCj4KPj4gICBwdGVfdCBjb250cHRlX3B0ZXBfZ2V0KHB0ZV90ICpwdGVwLCBw
dGVfdCBvcmlnX3B0ZSkKPj4gICB7Cj4+ICAgCS8qCj4+IEBAIC0xNjksMTEgKzE4MSwxNyBAQCBw
dGVfdCBjb250cHRlX3B0ZXBfZ2V0KHB0ZV90ICpwdGVwLCBwdGVfdCBvcmlnX3B0ZSkKPj4gICAJ
Zm9yIChpID0gMDsgaSA8IENPTlRfUFRFUzsgaSsrLCBwdGVwKyspIHsKPj4gICAJCXB0ZSA9IF9f
cHRlcF9nZXQocHRlcCk7Cj4+ICAgCj4+IC0JCWlmIChwdGVfZGlydHkocHRlKSkKPj4gKwkJaWYg
KHB0ZV9kaXJ0eShwdGUpKSB7Cj4+ICAgCQkJb3JpZ19wdGUgPSBwdGVfbWtkaXJ0eShvcmlnX3B0
ZSk7Cj4+ICsJCQlDSEVDS19DT05UUFRFX0ZMQUcoaSwgcHRlcCwgb3JpZ19wdGUsIHlvdW5nKTsK
Pj4gKwkJCWJyZWFrOwo+PiArCQl9Cj4+ICAgCj4+IC0JCWlmIChwdGVfeW91bmcocHRlKSkKPj4g
KwkJaWYgKHB0ZV95b3VuZyhwdGUpKSB7Cj4+ICAgCQkJb3JpZ19wdGUgPSBwdGVfbWt5b3VuZyhv
cmlnX3B0ZSk7Cj4+ICsJCQlDSEVDS19DT05UUFRFX0ZMQUcoaSwgcHRlcCwgb3JpZ19wdGUsIGRp
cnR5KTsKPj4gKwkJCWJyZWFrOwo+PiArCQl9Cj4+ICAgCX0KPj4gICAKPj4gICAJcmV0dXJuIG9y
aWdfcHRlOwo+Cj5UaGVyZSBhcmUgdHdvIGlzc3VlcyBhcyBJIGNhbiBzZWU6ICgxKSBUaGUgbG9v
cCBzdG9wcyBvbiBhbnkgZGlydHkgb3IgeW91bmcgZmxhZy4gQW5vdGhlcgo+ZmxhZyBjYW4gYmUg
bWlzc2VkIHdoZW4gb25lIGZsYWcgaXMgc2Vlbi4gRm9yIGV4YW1wbGUsIHdoZW4gcHRlcFswXSBo
YXMgYm90aCBkaXJ0eS95b3VuZwo+ZmxhZywgb25seSB0aGUgZGlydHkgZmxhZyBpcyBjb2xsZWN0
ZWQuICgyKSBDSEVDS19DT05UUFRFX0ZMQUcoKSBpdGVyYXRlcyBwdGVwW2ksIENPTlRfUFRFU10s
Cj5jb25mbGljdGluZyB0byB0aGUgb3V0ZXIgbG9vcCwgd2hpY2ggaXRlcmF0ZXMgcHRlcFswLCBD
T05UX1BURVNdLgoKTm8gZmxhZ3Mgd2lsbCBiZSBtaXNzZWQuIFRoZSBvdXRlciBsb29wIGlzIHVz
ZWQgdG8gY2hlY2sgZm9yIHRoZSBmaXJzdCBmbGFnLAp3aGljaCBjb3VsZCBiZSBlaXRoZXIgdGhl
IGRpcnR5IG9yIHlvdW5nIGZsYWcuCk9uY2UgdGhpcyBmbGFnIChsZXQncyBhc3N1bWUgaXQncyB0
aGUgZGlydHkgZmxhZykgaXMgZm91bmQgaW4gdGhlIGktdGggUFRFLAp0aGUgZGlydHkgZmxhZyBv
ZiBvcmlnX3B0ZSB3aWxsIGJlIHNldCwgYW5kIHRoZSBjb2RlIHdpbGwgaW1tZWRpYXRlbHkgZW50
ZXIKdGhlIGlubmVyIGxvb3AsIG5hbWVseSBDSEVDS19DT05UUFRFX0ZMQUcuIFRoaXMgaW5uZXIg
bG9vcCB3aWxsIGNvbnRpbnVlCnRvIGNoZWNrIG9ubHkgZm9yIHRoZSB5b3VuZyBmbGFnIHN0YXJ0
aW5nIGZyb20gdGhlIGktdGggcG9zaXRpb24sIGFuZCB3ZSBuZWVkbid0CmNvbmNlcm4gYWJvdXQg
dGhlIGRpcnR5IGZsYWcgYW55bW9yZS4KSWYgQ0hFQ0tfQ09OVFBURV9GTEFHIGZpbmRzIHRoZSB5
b3VuZyBmbGFnIGluIHRoZSBqLXRoIFBURSwgdGhlIHlvdW5nIGZsYWcKb2Ygb3JpZ19wdGUgd2ls
bCBiZSBzZXQuIEF0IHRoaXMgcG9pbnQsIGJvdGggdGhlIHlvdW5nIGFuZCBkaXJ0eSBmbGFncyBv
ZgpvcmlnX3B0ZSBoYXZlIGJlZW4gc2V0LCBhbmQgdGhlcmUncyBubyBuZWVkIGZvciBmdXJ0aGVy
IGxvb3AganVkZ21lbnRzLCBzbwp0aGUgYm90aCB0aGUgaW5uZXIgYW5kIG91dGVyIGxvb3BzIGNh
biBiZSBleGl0ZWQgZGlyZWN0bHkuIFRoaXMgYXBwcm9hY2gKcmVkdWNlcyB1bm5lY2Vzc2FyeSBy
ZXBlYXRlZCB0cmF2ZXJzYWxzIGFuZCBqdWRnbWVudHMuCgo+Cj5CZXNpZGVzLCBJIGFsc28gZG91
YnQgaG93IG11Y2ggcGVyZm9ybWFuY2UgY2FuIGJlIGdhaW5lZCBieSBiYWlsaW5nIGVhcmx5IG9u
IChkaXJ0eSB8IHlvdW5nKS4KPkhvd2V2ZXIsIGl0J3MgYXZvaWRlZCB0byBjcm9zcyB0aGUgTDFE
IGNhY2hlIGxpbmUgYm91bmRhcnkgaWYgcG9zc2libGUuIFdpdGggNEtCIGJhc2UgcGFnZQo+c2l6
ZSwgMTI4IGJ5dGVzIGFyZSBuZWVkZWQgZm9yIHB0ZXBbQ09OVF9QVEVTXSwgZXF1YWwgdG8gdHdv
IGNhY2hlIGxpbmVzLiBJZiB3ZSBjYW4gYmFpbAo+ZWFybHkgd2l0aCBsdWNrLCB3ZSBkb24ndCBo
YXZlIHRvIHN0ZXAgaW50byBhbm90aGVyIGNhY2hlIGxpbmUuIE5vdGUgdGhhdCBleHRyYSBjaGVj
a3MgbmVlZHMKPm1vcmUgQ1BVIGN5Y2xlcy4KCkNvbXBhcmVkIHRvIHRoZSBwcmV2aW91cyBmdW5j
dGlvbiwgdGhpcyBjb2RlIGRvZXNuJ3QgYWRkIGFueSBleHRyYSBjaGVja3MuCkV2ZW4gaW4gdGhl
IHdvcnN0LWNhc2Ugc2NlbmFyaW8sIHdoZXJlIG5laXRoZXIgYSBkaXJ0eSBub3IgYSB5b3VuZyBm
bGFnIGlzCmZvdW5kIGFtb25nIHRoZSAxNiBQVEVzLCB0aGUgbnVtYmVyIG9mIGNoZWNrcyBpcyB0
aGUgc2FtZSBhcyBpbiB0aGUgb3JpZ2luYWwKZnVuY3Rpb24uIElmIGFueSBmbGFnIGlzIGZvdW5k
IGVhcmxpZXIsIHRoZSBvcHRpbWl6ZWQgcGF0Y2ggd2lsbCByZWR1Y2UgdGhlCm51bWJlciBvZiBz
dWJzZXF1ZW50IGNoZWNrcyBmb3IgdGhhdCBmbGFnIGNvbXBhcmVkIHRvIHRoZSBvcmlnaW5hbCBj
b2RlLgoKSSdtIG5vdCBzdXJlIGlmIG15IGV4cGxhbmF0aW9uIGlzIGNsZWFyLiBJZiB5b3UgaGF2
ZSBhbnkgZnVydGhlciBxdWVzdGlvbnMsCmZlZWwgZnJlZSB0byBjb21tdW5pY2F0ZSB3aXRoIG1l
IGFnYWluLgoKLS0KVGhhbmtzLApYYXZpZXI=

