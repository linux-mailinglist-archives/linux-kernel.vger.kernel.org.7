Return-Path: <linux-kernel+bounces-601222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556C5A86B0A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 07:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B691319E6D71
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 05:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239CE188736;
	Sat, 12 Apr 2025 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="QQhey1f2"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74410A1E
	for <linux-kernel@vger.kernel.org>; Sat, 12 Apr 2025 05:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744435721; cv=none; b=TUB5+FcjKlQfD7GQbpmG5e6PEgNwN1PGpgvpJYiehSQLrKHty2iBybaaV490+QlVYiWUtnyfAWKiH92FwA/yzFgVj5mO1JCjha4Da+iin3eunGsn4B68AsJpdnXZtULThZzff4vJcfDjSYTGDtknZw6CpPcK/vriaZQ7hNVBDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744435721; c=relaxed/simple;
	bh=/0HUU+RYZEkDiBT4zohKlXsyMElplvBVF3jBMKt6MOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=s/qqj2KE9NiFEthvjVmEeXdaPIyk10FRAytbtSFiPk0pxEbX+jFIlon1nRnmw7sp06oSCO1QvIZIcHUPAjvbuOdKBZ2GBXqm43p17QNRmbsbvHLkNdNbhwn1+qEbpTxwbPcKmoSKsYDyUd0amjG+KUHVt4I0we3IS34mpjVEs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=QQhey1f2 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=zoCBp7+pZJn5INI9ZK8jPUOEsFSC7a3R40ArDMdggfc=; b=Q
	Qhey1f2uaQC0aFSjrGiDzgF285AvcjVcRxwnhhgOShMvIxPyhpoYj0L1fNuKVKG4
	cH192h940SNyfCJUOIgMU+uovHRBJPkkn0alkVRfdU/XrCuExfHflnjzNYwLwARJ
	No3XBTsSNH+caTS/HCSgPzDosO9VnEZOfIwJitorUI=
Received: from xavier_qy$163.com ( [112.91.84.73] ) by
 ajax-webmail-wmsvr-40-123 (Coremail) ; Sat, 12 Apr 2025 13:27:32 +0800
 (CST)
Date: Sat, 12 Apr 2025 13:27:32 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: "Lance Yang" <ioworker0@gmail.com>, "Dev Jain" <dev.jain@arm.com>,
	"Barry Song" <21cnbao@gmail.com>,
	"David Hildenbrand" <david@redhat.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, "Matthew Wilcox" <willy@infradead.org>,
	"Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v1] mm/contpte: Optimize loop to reduce redundant
 operations
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAK1f24=5-VVJoE75wrskXxrGi=KmrbxSYH9P69PRPiOxQuArpA@mail.gmail.com>
References: <20250407092243.2207837-1-xavier_qy@163.com>
 <CAGsJ_4wsW+urp6gbp+yDG40fZw9Bszny2iJVsV_AzzGqgQy+4g@mail.gmail.com>
 <7dccb3a2-f5e2-4f9e-8f5c-465a1d3ffdb6@arm.com>
 <CAK1f24=5-VVJoE75wrskXxrGi=KmrbxSYH9P69PRPiOxQuArpA@mail.gmail.com>
X-NTES-SC: AL_Qu2fBviYuk4u5CKaY+kfmkgWgus/WcW2u/Qj3IRSO5FwjAnp3AAPdHlFPknV8MKdJD6mnh6RfztB1Oh2Z5l4VIY5k9b1PY8cz4fVxcXctumxPw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3c365d2f.1656.1962877a689.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eygvCgD3P2nE+flnDWADAA--.26462W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiTgosEGf5UJEr9AAHs-
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSwKCgpBdCAyMDI1LTA0LTEyIDEzOjA1OjEzLCAiTGFuY2UgWWFuZyIgPGlvd29ya2VyMEBn
bWFpbC5jb20+IHdyb3RlOgo+T24gU2F0LCBBcHIgMTIsIDIwMjUgYXQgMTozMOKAr0FNIERldiBK
YWluIDxkZXYuamFpbkBhcm0uY29tPiB3cm90ZToKPj4KPj4gK290aGVycwo+Pgo+PiBPbiAxMS8w
NC8yNSAyOjU1IGFtLCBCYXJyeSBTb25nIHdyb3RlOgo+PiA+IE9uIE1vbiwgQXByIDcsIDIwMjUg
YXQgOToyM+KAr1BNIFhhdmllciA8eGF2aWVyX3F5QDE2My5jb20+IHdyb3RlOgo+PiA+Pgo+PiA+
PiBUaGlzIGNvbW1pdCBvcHRpbWl6ZXMgdGhlIGNvbnRwdGVfcHRlcF9nZXQgZnVuY3Rpb24gYnkg
YWRkaW5nIGVhcmx5Cj4+ID4+ICAgdGVybWluYXRpb24gbG9naWMuIEl0IGNoZWNrcyBpZiB0aGUg
ZGlydHkgYW5kIHlvdW5nIGJpdHMgb2Ygb3JpZ19wdGUKPj4gPj4gICBhcmUgYWxyZWFkeSBzZXQg
YW5kIHNraXBzIHJlZHVuZGFudCBiaXQtc2V0dGluZyBvcGVyYXRpb25zIGR1cmluZwo+PiA+PiAg
IHRoZSBsb29wLiBUaGlzIHJlZHVjZXMgdW5uZWNlc3NhcnkgaXRlcmF0aW9ucyBhbmQgaW1wcm92
ZXMgcGVyZm9ybWFuY2UuCj4+ID4+Cj4+ID4+IFNpZ25lZC1vZmYtYnk6IFhhdmllciA8eGF2aWVy
X3F5QDE2My5jb20+Cj4+ID4+IC0tLQo+PiA+PiAgIGFyY2gvYXJtNjQvbW0vY29udHB0ZS5jIHwg
MTMgKysrKysrKysrKystLQo+PiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQo+PiA+Pgo+PiA+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9j
b250cHRlLmMgYi9hcmNoL2FybTY0L21tL2NvbnRwdGUuYwo+PiA+PiBpbmRleCBiY2FjNGY1NWY5
YzEuLmNhMTVkOGY1MmQxNCAxMDA2NDQKPj4gPj4gLS0tIGEvYXJjaC9hcm02NC9tbS9jb250cHRl
LmMKPj4gPj4gKysrIGIvYXJjaC9hcm02NC9tbS9jb250cHRlLmMKPj4gPj4gQEAgLTE2MywxNyAr
MTYzLDI2IEBAIHB0ZV90IGNvbnRwdGVfcHRlcF9nZXQocHRlX3QgKnB0ZXAsIHB0ZV90IG9yaWdf
cHRlKQo+PiA+Pgo+PiA+PiAgICAgICAgICBwdGVfdCBwdGU7Cj4+ID4+ICAgICAgICAgIGludCBp
Owo+PiA+PiArICAgICAgIGJvb2wgZGlydHkgPSBmYWxzZTsKPj4gPj4gKyAgICAgICBib29sIHlv
dW5nID0gZmFsc2U7Cj4+ID4+Cj4+ID4+ICAgICAgICAgIHB0ZXAgPSBjb250cHRlX2FsaWduX2Rv
d24ocHRlcCk7Cj4+ID4+Cj4+ID4+ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBDT05UX1BURVM7
IGkrKywgcHRlcCsrKSB7Cj4+ID4+ICAgICAgICAgICAgICAgICAgcHRlID0gX19wdGVwX2dldChw
dGVwKTsKPj4gPj4KPj4gPj4gLSAgICAgICAgICAgICAgIGlmIChwdGVfZGlydHkocHRlKSkKPj4g
Pj4gKyAgICAgICAgICAgICAgIGlmICghZGlydHkgJiYgcHRlX2RpcnR5KHB0ZSkpIHsKPj4gPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgZGlydHkgPSB0cnVlOwo+PiA+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgb3JpZ19wdGUgPSBwdGVfbWtkaXJ0eShvcmlnX3B0ZSk7Cj4+ID4+ICsgICAg
ICAgICAgICAgICB9Cj4+ID4+Cj4+ID4+IC0gICAgICAgICAgICAgICBpZiAocHRlX3lvdW5nKHB0
ZSkpCj4+ID4+ICsgICAgICAgICAgICAgICBpZiAoIXlvdW5nICYmIHB0ZV95b3VuZyhwdGUpKSB7
Cj4+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIHlvdW5nID0gdHJ1ZTsKPj4gPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgIG9yaWdfcHRlID0gcHRlX21reW91bmcob3JpZ19wdGUpOwo+PiA+
PiArICAgICAgICAgICAgICAgfQo+PiA+PiArCj4+ID4+ICsgICAgICAgICAgICAgICBpZiAoZGly
dHkgJiYgeW91bmcpCj4+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+PiA+Cj4+
ID4gVGhpcyBraW5kIG9mIG9wdGltaXphdGlvbiBpcyBhbHdheXMgdHJpY2t5LiBEZXYgcHJldmlv
dXNseSB0cmllZCBhIHNpbWlsYXIKPj4gPiBhcHByb2FjaCB0byByZWR1Y2UgdGhlIGxvb3AgY291
bnQsIGJ1dCBpdCBlbmRlZCB1cCBjYXVzaW5nIHBlcmZvcm1hbmNlCj4+ID4gZGVncmFkYXRpb246
Cj4+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyNDA5MTMwOTE5MDIuMTE2
MDUyMC0xLWRldi5qYWluQGFybS5jb20vCj4+ID4KPj4gPiBTbyB3ZSBtYXkgbmVlZCBhY3R1YWwg
ZGF0YSB0byB2YWxpZGF0ZSB0aGlzIGlkZWEuCgpZb3UncmUgYWJzb2x1dGVseSByaWdodC4gT3B0
aW1pemF0aW9uIG11c3QgYmUgcHJvdmVuIGJ5IHRlc3QgZGF0YS4gSSB3aWxsCiBjb25kdWN0IHNv
bWUgdGVzdHMgYW5kIHZhbGlkYXRpb25zIG5leHQuCgo+Pgo+PiBUaGUgb3JpZ2luYWwgdjIgcGF0
Y2ggZG9lcyBub3Qgd29yaywgSSBjaGFuZ2VkIGl0IHRvIHRoZSBmb2xsb3dpbmc6Cj4+Cj4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L21tL2NvbnRwdGUuYyBiL2FyY2gvYXJtNjQvbW0vY29udHB0
ZS5jCj4+IGluZGV4IGJjYWM0ZjU1ZjljMS4uZGIwYWQzODYwMWRiIDEwMDY0NAo+PiAtLS0gYS9h
cmNoL2FybTY0L21tL2NvbnRwdGUuYwo+PiArKysgYi9hcmNoL2FybTY0L21tL2NvbnRwdGUuYwo+
PiBAQCAtMTUyLDYgKzE1MiwxNiBAQCB2b2lkIF9fY29udHB0ZV90cnlfdW5mb2xkKHN0cnVjdCBt
bV9zdHJ1Y3QgKm1tLAo+PiB1bnNpZ25lZCBsb25nIGFkZHIsCj4+ICAgfQo+PiAgIEVYUE9SVF9T
WU1CT0xfR1BMKF9fY29udHB0ZV90cnlfdW5mb2xkKTsKPj4KPj4gKyNkZWZpbmUgQ0hFQ0tfQ09O
VFBURV9GTEFHKHN0YXJ0LCBwdGVwLCBvcmlnX3B0ZSwgZmxhZykgXAo+PiArICAgICAgIGludCBf
c3RhcnQ7IFwKPj4gKyAgICAgICBwdGVfdCAqX3B0ZXAgPSBwdGVwOyBcCj4+ICsgICAgICAgZm9y
IChfc3RhcnQgPSBzdGFydDsgX3N0YXJ0IDwgQ09OVF9QVEVTOyBfc3RhcnQrKywgcHRlcCsrKSB7
IFwKPj4gKyAgICAgICAgICAgICAgIGlmIChwdGVfIyNmbGFnKF9fcHRlcF9nZXQoX3B0ZXApKSkg
eyBcCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIG9yaWdfcHRlID0gcHRlX21rIyNmbGFnKG9y
aWdfcHRlKTsgXAo+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsgXAo+PiArICAgICAg
ICAgICAgICAgfSBcCj4+ICsgICAgICAgfQo+PiArCj4+ICAgcHRlX3QgY29udHB0ZV9wdGVwX2dl
dChwdGVfdCAqcHRlcCwgcHRlX3Qgb3JpZ19wdGUpCj4+ICAgewo+PiAgICAgICAgICAvKgo+PiBA
QCAtMTY5LDExICsxNzksMTcgQEAgcHRlX3QgY29udHB0ZV9wdGVwX2dldChwdGVfdCAqcHRlcCwg
cHRlX3Qgb3JpZ19wdGUpCj4+ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBDT05UX1BURVM7IGkr
KywgcHRlcCsrKSB7Cj4+ICAgICAgICAgICAgICAgICAgcHRlID0gX19wdGVwX2dldChwdGVwKTsK
Pj4KPj4gLSAgICAgICAgICAgICAgIGlmIChwdGVfZGlydHkocHRlKSkKPj4gKyAgICAgICAgICAg
ICAgIGlmIChwdGVfZGlydHkocHRlKSkgewo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgb3Jp
Z19wdGUgPSBwdGVfbWtkaXJ0eShvcmlnX3B0ZSk7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAg
IENIRUNLX0NPTlRQVEVfRkxBRyhpLCBwdGVwLCBvcmlnX3B0ZSwgeW91bmcpOwo+PiArICAgICAg
ICAgICAgICAgICAgICAgICBicmVhazsKPj4gKyAgICAgICAgICAgICAgIH0KPj4KPj4gLSAgICAg
ICAgICAgICAgIGlmIChwdGVfeW91bmcocHRlKSkKPj4gKyAgICAgICAgICAgICAgIGlmIChwdGVf
eW91bmcocHRlKSkgewo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgb3JpZ19wdGUgPSBwdGVf
bWt5b3VuZyhvcmlnX3B0ZSk7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIENIRUNLX0NPTlRQ
VEVfRkxBRyhpLCBwdGVwLCBvcmlnX3B0ZSwgZGlydHkpOwo+PiArICAgICAgICAgICAgICAgICAg
ICAgICBicmVhazsKPj4gKyAgICAgICAgICAgICAgIH0KPj4gICAgICAgICAgfQo+Pgo+PiAgICAg
ICAgICByZXR1cm4gb3JpZ19wdGU7Cj4+Cj4+IFNvbWUgcnVkaW1lbnRhcnkgdGVzdGluZyB3aXRo
IG1pY3JvbW0gcmV2ZWFscyB0aGF0IHRoaXMgbWF5IGJlCj4+ICpzbGlnaHRseSogZmFzdGVyLiBJ
IGNhbm5vdCBzYXkgZm9yIHN1cmUgeWV0LgoKVGhhbmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb25z
IG9uIHRoZSBtb2RpZmljYXRpb24uIEkgd2lsbCB3cml0ZSBzb21lCnRlc3QgY2FzZXMgZm9yIHZl
cmlmaWNhdGlvbi4KCj4KPlllcCwgdGhpcyBjaGFuZ2Ugd29ya3MgYXMgZXhwZWN0ZWQsIElJVUMu
Cj4KPkhvd2V2ZXIsIEknbSBzdGlsbCB3b25kZXJpbmcgaWYgdGhlIGFkZGVkIGNvbXBsZXhpdHkg
aXMgd29ydGggaXQgZm9yCj5zdWNoIGEgc2xpZ2h0L25lZ2xpZ2libGUgcGVyZm9ybWFuY2UgZ2Fp
bi4gVGhhdCBzYWlkLCBpZiB3ZSBoYXZlCj5zb2xpZCBudW1iZXJzL2RhdGEgdG8gYmFjayBpdCB1
cCwgYWxsIGRvdWJ0cyB3b3VsZCBkaXNhcHBlYXIgOykKPgoKSW5kZWVkLCB1bmxlc3MgdGhlcmUg
aXMgYSBub3RpY2VhYmxlIGltcHJvdmVtZW50IGluIGVmZmljaWVuY3ksIGluY3JlYXNpbmcKY29t
cGxleGl0eSBtYXkgbm90IGJlIHdvcnRoIHRoZSBjb3N0LiBJIHdpbGwgc3VtbWFyaXplIHNvbWUg
dGVzdCBkYXRhCnRvIGRldGVybWluZSB3aGV0aGVyIHRoaXMgb3B0aW1pemF0aW9uIGlzIHdvcnRo
d2hpbGUuCgotLS0tLS0KVGhhbmtzLApYYXZpZXIK

