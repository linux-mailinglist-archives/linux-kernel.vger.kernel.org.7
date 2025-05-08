Return-Path: <linux-kernel+bounces-638966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF97AAF134
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 04:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964877A9238
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C501DB366;
	Thu,  8 May 2025 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="gOaByPWR"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382392CA9
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746672061; cv=none; b=YZdflAexm67kBRTsaGwXq62gHZ/4s86KheQQ0vC5ynZrrUXITwBfhvyoJbeCLn50Oamej8qgEofskUQXyEzYwra9s2+ETpb2UqqbOQa7V93khF/+CPBM9wBFaU5MRNDbtop82Zrmr450Pv3sJDfO7n8UBNTgev1edheTjmYzjXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746672061; c=relaxed/simple;
	bh=VnpsO50CPhOp2HWeeEdpcY39S0L3XrM0y40y2KK/BVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gwcQnt6FghMHJLIlhHtdoxHnIhOBKllT15X2WSD0rGqsBv5EEEz3mawrCbCoY9Qy9vX+vN/nw7ZuCHX26wZIvuKZJaePE9Wb3yYiKcvBEmO3df8nXtRo5Gh+XPb85X0sQvo9XhDkh4I/i1BwXEGF5q4Jh7cAqvqpn4/Xzxoj79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=gOaByPWR reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=VWEm5WKg8zaftzygDyDpLnRfJlPy7emQwfZ7p8GoLlE=; b=g
	OaByPWRzWChH50jtR09Owbq9gN0zhPgOqnVhKhdd3x6EuGHiqn/g0SVyWjmtBsct
	DSvYCSgrxGfTzdl2QMseSy2en97b+p3MWzWOfpBYOPoXcjBNcvQd2MB1ywv3o87L
	yLIzljT86keaJXQEASN+PrphAtHTO6/mOLNHH3nzLA=
Received: from 00107082$163.com ( [111.35.191.17] ) by
 ajax-webmail-wmsvr-40-127 (Coremail) ; Thu, 8 May 2025 10:24:55 +0800 (CST)
Date: Thu, 8 May 2025 10:24:55 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: avoid mem alloc and iter reset when reading
 allocinfo
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpFAUdqqvFPfe_OLR76c0bX_ngwG=JKC42pVB+WAeX4w0w@mail.gmail.com>
References: <20250507175500.204569-1-00107082@163.com>
 <a0ebf2e.b422.196abf97373.Coremail.00107082@163.com>
 <CAJuCfpFAUdqqvFPfe_OLR76c0bX_ngwG=JKC42pVB+WAeX4w0w@mail.gmail.com>
X-NTES-SC: AL_Qu2fBPqcvkgi4ySZbekZnEYQheY4XMKyuPkg1YJXOp80lyTS1i8PZ25IJ2Ls0fmBKwSmoQmJUCZj9eRhRIVjWqiZ0Jl9/nlmXEbSJ+Z+JFTt
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4b78ebee.26dc.196adb5ce7e.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fygvCgD3_6j4FRxoP3ymAA--.56913W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqAZGqmgb7oIe+QADs5
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI1LTA1LTA4IDA3OjQyOjU2LCAiU3VyZW4gQmFnaGRhc2FyeWFuIiA8c3VyZW5iQGdv
b2dsZS5jb20+IHdyb3RlOgo+T24gV2VkLCBNYXkgNywgMjAyNSBhdCA2OjE54oCvUE0gRGF2aWQg
V2FuZyA8MDAxMDcwODJAMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+IEhpLAo+PiBKdXN0IHdhbnQgdG8g
c2hhcmUgaG93IEkgbm90aWNlIHRob3NlIG1lbW9yeSBhbGxvY2F0aW9uIGJlaGFpdm9yczogdGhl
IGN1bXVsYXRpdmUgY291bnRlcnN+IQo+Pgo+PiBXaXRoIGN1bXVsYXRpdmUgY291bnRlcnMsIEkg
Y2FuIGlkZW50aWZ5IHdoaWNoIG1vZHVsZSBrZWVwcyBhbGxvYy9mcmVlIG1lbW9yeSwgYnkgdGhl
IHJhdGlvIGJldHdlZW4KPj4gIGN1bXVsYXRpdmUgY2FsbHMgYW5kIHJlbWFpbmluZyBjYWxscywg
YW5kIG1heWJlIGFuIG9wdGltaXphdGlvbiBjb3VsZCBiZSBhcHBsaWVkLgo+PiBGb2xsb3dpbmcg
aXMgdG9wMTYgSSBnb3Qgb24gbXkgc3lzdGVtOgo+Pgo+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0t
LS0tLS0tLS0tLS0rCj4+IHwgICAgICAgICAgICAgICAgICBhbGxvYyAgICAgICAgICAgICAgICAg
IHwgY2FsbHMgfCBjdW11bGF0aXZlIGNhbGxzIHwgICAgICAgcmF0aW8gICAgICAgIHwKPj4gKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0rLS0tLS0tLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+PiB8ICAgICAgICAgICAgZnMvc2VxX2Zp
bGUuYzo1ODQgICAgICAgICAgICB8ICAgMiAgIHwgICAgIDE4MDY0ODI1ICAgICB8ICAgICA5MDMy
NDEyLjUgICAgICB8Cj4+IHwgICAgICAgICAgICAgZnMvc2VxX2ZpbGUuYzozOCAgICAgICAgICAg
IHwgICA1ICAgfCAgICAgMTgxNDgyODggICAgIHwgICAgIDM2Mjk2NTcuNiAgICAgIHwKPj4gfCAg
ICAgICAgICAgICBmcy9zZXFfZmlsZS5jOjYzICAgICAgICAgICAgfCAgIDE1ICB8ICAgICAxODE1
MzI3MSAgICAgfCAxMjEwMjE4LjA2NjY2NjY2NjcgfAo+PiB8ICAgICAgICAgIG5ldC9jb3JlL3Nr
YnVmZi5jOjU3NyAgICAgICAgICB8ICAgOSAgIHwgICAgIDEwNjc5OTc1ICAgICB8IDExODY2NjMu
ODg4ODg4ODg5ICB8Cj4+IHwgICAgICAgICAgbmV0L2NvcmUvc2tidWZmLmM6NjU4ICAgICAgICAg
IHwgICAyMSAgfCAgICAgMTEwMTM0MzcgICAgIHwgIDUyNDQ0OS4zODA5NTIzODEgIHwKPj4gfCAg
ICAgICAgICAgICBmcy9zZWxlY3QuYzoxNjggICAgICAgICAgICAgfCAgIDcgICB8ICAgICAyODMx
MjI2ICAgICAgfCA0MDQ0NjAuODU3MTQyODU3MTYgfAo+PiB8ICAgICAgICAgICAgbGliL2FsbG9j
X3RhZy5jOjUxICAgICAgICAgICB8ICAgMSAgIHwgICAgICAzNDA2NDkgICAgICB8ICAgICAgMzQw
NjQ5LjAgICAgICB8ICA8LS0tIEhlcmUgSSBzdGFydGVkCj4+IHwgICAgICAgICAgIGtlcm5lbC9z
aWduYWwuYzo0NTUgICAgICAgICAgIHwgICAxICAgfCAgICAgIDMwMDczMCAgICAgIHwgICAgICAz
MDA3MzAuMCAgICAgIHwKPj4gfCBmcy9ub3RpZnkvaW5vdGlmeS9pbm90aWZ5X2Zzbm90aWZ5LmM6
OTYgfCAgIDEgICB8ICAgICAgMjQ5ODMxICAgICAgfCAgICAgIDI0OTgzMS4wICAgICAgfAo+PiB8
ICAgICAgICAgICAgZnMvZXh0NC9kaXIuYzo2NzUgICAgICAgICAgICB8ICAgMyAgIHwgICAgICA1
MTk3MzQgICAgICB8IDE3MzI0NC42NjY2NjY2NjY2NiB8Cj4+IHwgICAgICAgZHJpdmVycy91c2Iv
aG9zdC94aGNpLmM6MTU1NSAgICAgIHwgICA0ICAgfCAgICAgIDEyNjQwMiAgICAgIHwgICAgICAz
MTYwMC41ICAgICAgIHwKPj4gfCAgICAgICAgICAgICAgZnMvbG9ja3MuYzoyNzUgICAgICAgICAg
ICAgfCAgIDM2ICB8ICAgICAgOTg2OTU3ICAgICAgfCAyNzQxNS40NzIyMjIyMjIyMjMgfAo+PiB8
ICAgICAgICAgICBmcy9wcm9jL2lub2RlLmM6NTAyICAgICAgICAgICB8ICAgMyAgIHwgICAgICA2
Mzc1MyAgICAgICB8ICAgICAgMjEyNTEuMCAgICAgICB8Cj4+IHwgICAgICAgICAgICAgIGZzL3Bp
cGUuYzoxMjUgICAgICAgICAgICAgIHwgIDEyMyAgfCAgICAgMjE0MzM3OCAgICAgIHwgMTc0MjUu
ODM3Mzk4MzczOTg0IHwKPj4gfCAgICAgICAgICAgIG5ldC9jb3JlL3NjbS5jOjg0ICAgICAgICAg
ICAgfCAgIDMgICB8ICAgICAgNDMyNjcgICAgICAgfCAxNDQyMi4zMzMzMzMzMzMzMzQgfAo+PiB8
ICAgICAgICAgZnMva2VybmVsX3JlYWRfZmlsZS5jOjgwICAgICAgICB8ICAgMiAgIHwgICAgICAy
NjkxMCAgICAgICB8ICAgICAgMTM0NTUuMCAgICAgICB8Cj4+ICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0t
LS0tLS0tLS0tLS0tLSsKPj4KPj4gSSB0aGluayB0aGlzIGlzIGFub3RoZXIgImdvb2QiIHVzYWdl
IGZvciBjdW11bGF0aXZlIGNvdW50ZXJzOiBpZiBhIG1vZHVsZSBqdXN0IGtlZXBzIGFsbG9jL2Zy
ZWUgbWVtb3J5LAo+PiBtYXliZSBpdCBpcyBnb29kIHRvIG1vdmUgdGhlIG1lbW9yeSBhbGxvYy9m
cmVlIHRvIHNvbWV3aGVyZSBsZXNzIGZyZXF1ZW50Lgo+Pgo+PiBJbiB0aGUgY2FzZSBvZiB0aGlz
IHBhdGNoLCBhIG1lbW9yeSBhbGxvY2F0aW9uIGZvciBlYWNoIHJlYWQtY2FsbHMsIGNhbiBiZSBt
b3ZlZCB0byBvcGFuLWNhbGxzLgo+Pgo+PiBJZiBpbnRlcmVzdGVkLCBJIGNhbiByZS1zZW5kIHRo
ZSBwYXRjaCBmb3IgY3VtdWxhdGl2ZSBjb3VudGVycyBmb3IgZnVydGhlciBkaXNjdXNzaW9ucy4K
Pgo+WWVhaCwgbXkgaXNzdWUgd2l0aCBjdW11bGF0aXZlIGNvdW50ZXJzIGlzIHRoYXQgd2hpbGUg
dGhleSBtaWdodCBiZQo+dXNlZnVsIGZvciBzb21lIGFuYWx5c2VzLCBtb3N0IHVzZWNhc2VzIHdv
dWxkIHByb2JhYmx5IG5vdCBiZW5lZml0Cj5mcm9tIHRoZW0gd2hpbGUgc2hhcmluZyB0aGUgcGVy
Zm9ybWFuY2Ugb3ZlcmhlYWQuIE9UT0ggbWFraW5nIGl0Cj5vcHRpb25hbCB3aXRoIGEgc2VwYXJh
dGUgQ09ORklHIHRoYXQgYWZmZWN0cyB0aGUgY29udGVudCBvZiB0aGUKPi9wcm9jL2FsbG9jaW5m
byBzZWVtcyBsaWtlIGEgYmFkIGlkZWEgdG8gbWUuIFVzZXJzcGFjZSBwYXJzZXJzIG5vdwo+d291
bGQgaGF2ZSB0byBjaGVjayBub3Qgb25seSB0aGUgZmlsZSB2ZXJzaW9uIGJ1dCBhbHNvIHdoZXRo
ZXIgdGhpcwo+a2VybmVsIGNvbmZpZyBpcyBlbmFibGVkLCBvciBoYW5kbGUgYSBwb3NzaWJpbGl0
eSBvZiBhbiBhZGRpdGlvbmFsCj5jb2x1bW4gaW4gdGhlIG91dHB1dC4gRG9lcyBub3Qgc2VlbSBs
aWtlIGEgZ29vZCBzb2x1dGlvbiB0byBtZS4KClRoYW5rcyBmb3IgdGhlIHF1aWNrIGZlZWRiYWNr
fiAKIEFncmVlIHRoYXQgdGhpcyB3b3VsZCBjYXVzZSB0cm91YmxlcyB0byB1c2Vyc3BhY2UgIHRv
b2xzLAphbmQgYWxzbyBpdCBhZGQgbW9yZSBwZXJmb3JtYW5jZSBpbXBhY3QgZm9yIHByb2ZpbGlu
Zy4KCkRhdmlkCgo+Cj5BbGwgdGhhdCBzYWlkLCBJJ20gb3BlbiB0byBzdWdnZXN0aW9ucyBpZiB0
aGVyZSBpcyBhIHdheSB0bwo+aW5jb3Jwb3JhdGUgY3VtdWxhdGl2ZSBjb3VudGVycyB0aGF0IHdv
dWxkIG5vdCB0YXggYWxsIG90aGVyIHVzZWNhc2VzCj50aGF0IGRvIG5vdCBuZWVkIHRoZW0uCj4K
Pj4KPj4KPj4gRllJCj4+IERhdmlkCg==

