Return-Path: <linux-kernel+bounces-813050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53467B5401E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D391C86816
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067761624E9;
	Fri, 12 Sep 2025 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="G5kpzQVc"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C8B33E7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642611; cv=none; b=V73AcpFAjRqQfXNSD4nlAQut7q06Csnr9hobX1tcfFUJz/K3fGG2EE2LMSV0tXLw3SYqHlfGXLKlyy7JDVGBiLJT9vhGZQ8DK35WZUn1Wlr4ph0OOSgoheHoLIoA/EveK3XS/6AIvcvAnjw+9qAB+dgGw0Mnw88ZN8EGquFl1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642611; c=relaxed/simple;
	bh=LJmEQZs13F/FHF4ypoYTiLXFKxIIeE3eH7OBaf23C2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=KUCkmKXMa6ZfKdNsQ4chTBrU0EWayk7COZocHpKL/jIKPE/NjAQI8eO+lwGjDokLhh293Se15t8cw7yhl+34Pkplmf9dcY5K/pmdjSQyJ4NyWxsyvqPbdZ4TwdeRbraE43fMy3Mr78snjk78SP9VfSDRT13OuX9La0xSen6Mfk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=G5kpzQVc reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=2gaxk0ynRjWPbUcOPBABXZM/j5g3V2zX3Gie3kenttI=; b=G
	5kpzQVc/csgYi0KfemtadKSsFnjqAUJEuEWUWMt5Q38igTntyww6fnpNtY8bzt/g
	uXnMSbeZL0Hn+nHUKpP3gh+IXEhhMNwbfubBHyuV5EXpj7S6PyF0iMg6aJlQnNQ5
	fbBThsArpU+0JHVoKYazWINNDhy15RrDfOGrtAxVd8=
Received: from 00107082$163.com ( [111.35.190.173] ) by
 ajax-webmail-wmsvr-40-123 (Coremail) ; Fri, 12 Sep 2025 10:02:22 +0800
 (CST)
Date: Fri, 12 Sep 2025 10:02:22 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
	"Usama Arif" <usamaarif642@gmail.com>,
	"Yueyang Pan" <pyyjason@gmail.com>, kent.overstreet@linux.dev,
	vbabka@suse.cz, hannes@cmpxchg.org, rientjes@google.com,
	roman.gushchin@linux.dev, harry.yoo@oracle.com,
	shakeel.butt@linux.dev, pasha.tatashin@soleen.com,
	souravpanda@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpEoWtgv8k4vApkGsNNUYFBnvS-N2DPQu2JrreCUPbT5dA@mail.gmail.com>
References: <20250909234942.1104356-1-surenb@google.com>
 <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
 <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com>
 <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
 <20250911143132.ca88948c48df874f71983218@linux-foundation.org>
 <CAJuCfpEoWtgv8k4vApkGsNNUYFBnvS-N2DPQu2JrreCUPbT5dA@mail.gmail.com>
X-NTES-SC: AL_Qu2eBfqfvU0v5CKbZukZnEYQheY4XMKyuPkg1YJXOp80kSTOyB09YWNjB0v388e2MQqGmxSvbTF3wc5YRbl+baiNah29d8FEZXTnPdap4JF1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1880ff7f.1d98.1993ba8cca1.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eygvCgD3v7Mvf8NorwgGAA--.15023W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxTGqmjDX53NQAADss
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDktMTIgMDg6MjU6MTIsICJTdXJlbiBCYWdoZGFzYXJ5YW4iIDxzdXJlbmJAZ29v
Z2xlLmNvbT4gd3JvdGU6Cj5PbiBUaHUsIFNlcCAxMSwgMjAyNSBhdCAyOjMx4oCvUE0gQW5kcmV3
IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4+Cj4+IE9uIFRodSwg
MTEgU2VwIDIwMjUgMTI6MDA6MjMgLTA0MDAgVXNhbWEgQXJpZiA8dXNhbWFhcmlmNjQyQGdtYWls
LmNvbT4gd3JvdGU6Cj4+Cj4+ID4gPiBJIHRoaW5rIHNpbXBseSBhZGRpbmcgKiB0byB0aGUgZW5k
IG9mIGZ1bmN0aW9uIG5hbWUgb3IgZmlsZW5hbWUgaXMgc3VmZmljaWVudAo+PiA+ID4gYXMgdGhl
eSBhcmUgYWxyZWFkeSBzdHIuCj4+ID4gPgo+PiA+Cj4+ID4gSW5zdGVhZCBvZjoKPj4gPgo+PiA+
IDQ5MTUyKiAgICAgIDQ4KiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmM6MjcwOSBmdW5j
Om1jZV9kZXZpY2VfY3JlYXRlCj4+ID4KPj4gPiBDb3VsZCB3ZSBkbyBzb21ldGhpbmcgbGlrZToK
Pj4gPgo+PiA+IDQ5MTUyICAgICAgNDggYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jOjI3
MDkgZnVuYzptY2VfZGV2aWNlX2NyZWF0ZShpbmFjY3VyYXRlKQo+Pgo+PiBDYW4gd2UgYWRkIGFu
b3RoZXIgcm93LCBzYXlpbmcgInRoZSBwcmV2aW91cyByb3cgd2FzIGluYWNjdXJhdGUiPyAgSQo+
PiBndWVzcyB0aGF0IHdvdWxkIGJyZWFrIHBhcnNlcnMgYWxzby4KPj4KPj4KPj4KPj4gSSBkb24n
dCBrbm93IGlmIHRoaXMgd2FzIGJ5IGRlc2lnbiwgYnV0IHRoZSBwcmVzZW50IGZvcm1hdCBkb2Vz
IHByb3ZpZGUKPj4gZXh0ZW5zaWJpbGl0eS4gIEl0IGlzIGJhc2ljYWxseQo+Pgo+PiAgICAgICAg
IE5OTk4gTk5OIG5hbWU6dmFsdWUgbmFtZTp2YWx1ZQo+Pgo+PiBvbmUgY291bGQgYXJndWFibHkg
YXBwZW5kIGEgdGhpcmQgbmFtZTp2YWx1ZSBhbmQgaG9wZSB0aGF0IGF1dGhvcnMgb2YKPj4gZXhp
c3RpbmcgcGFyc2VycyBmaWd1cmVkIHRoaXMgb3V0Lgo+Cj5BY3R1YWxseSB0aGF0IHNvdW5kcyBs
aWtlIHRoZSBiZXN0IGlkZWEgc28gZmFyLiBDdXJyZW50bHkgdGhlIGZvcm1hdCBpczoKPgo+PGJ5
dGVzPiA8Y291bnQ+IDxmaWxlPjo8bGluZT4gWzxtb2R1bGU+XSBmdW5jOjxmdW5jdGlvbj4KPgo+
V2UgY2FuIGFkb3B0IGEgcnVsZSB0aGF0IGFmdGVyIHRoaXMsIHRoZSBsaW5lIGNhbiBjb250YWlu
IGFkZGl0aW9uYWwKPmtleTp2YWx1ZSBwYWlycy4gSW4gdGhhdCBjYXNlIGZvciBpbmFjY3VyYXRl
IGxpbmVzIHdlIGNhbiBhZGQ6Cj4KPjQ5MTUyICAgICAgNDggYXJjaC94ODYva2VybmVsL2NwdS9t
Y2UvY29yZS5jOjI3MDkKPmZ1bmM6bWNlX2RldmljZV9jcmVhdGUgYWNjdXJhdGU6bm8KPgo+SW4g
dGhlIGZ1dHVyZSB3ZSBjYW4gYXBwZW5kIG1vcmUga2V5OnZhbHVlIHBhaXJzIGlmIHdlIG5lZWQg
dGhlbS4KPlBhcnNlcnMgd2hpY2ggZG9uJ3Qga25vdyBob3cgdG8gcGFyc2UgYSBuZXcga2V5IGNh
biBzaW1wbHkgaWdub3JlCj50aGVtLgo+Cj5Eb2VzIHRoYXQgc291bmQgZ29vZCB0byBldmVyeW9u
ZT8KClRoaXMgbG9va3MgZ29vZCB0byBtZSwgYXQgbGVhc3QgZm9yIG15IHRvb2xzLiA6KQpPbiBt
eSBzeXN0ZW0sIHRoZXJlIGFyZSA0SysgbGluZXMgb2YgaXRlbXMsIGVhY2ggYnl0ZSBhZGRlZCB3
b3VsZCBpbmNyZWFzZSA0SytieXRlcyBmb3Igb25lIHJlYWQsCmJ1dCBnb29kIHRoaW5nIGlzIG5v
cm1hbGx5ICJhY2N1cmF0ZTpubyIgd291bGQgbm90IHNob3cgdXAuIAoKRGF2aWQKCj4KPj4KPj4K
Pj4gV2hhdGV2LiAgSSdsbCBkcm9wIHRoaXMgdmVyc2lvbiBmcm9tIG1tLmdpdC4K

