Return-Path: <linux-kernel+bounces-642113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E55AB1AA4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427D3A00119
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866FD235BE2;
	Fri,  9 May 2025 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="H/h4+xD7"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA43FF9C1
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808613; cv=none; b=KmNwFB7vpisMq2UDCEvgngSknuqXP/zdPSoYVEkQJKJTOuTN9jZWCovE8oY+dfD3h+JBC/ZmUCrOc13XfcTl51xI4Txsi1U8LyeX6uEgq44nVaPdckC8LVrRHMymUHk1YMbgYTOZ09d5ql6xzaB4PanqgpvTzJ8s4e74XPlBbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808613; c=relaxed/simple;
	bh=+Xpb/qraPqGdj1i9Fs+ZPI/6XpO4G6LJ2IKG5LF2h7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ia/v7RRQuKNcouOG8Luv1TpEXgE9xDQrUeFJvdCJ9En/84EIKSZTNq28HMXSJdmxkzWfagcF8sLxnIkD/E3t+QLnddqKbNWk0CUgun2BJ/4mK82GzMrjxvdEQ0syASvg/qej5sAcZKoyqTOe+g+qB6aOq6VviyHbD5C1AwxydwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=H/h4+xD7 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=58sKb4UDded9DbTLj3WGSJJxl3U6ypowTxWKmpvz5d0=; b=H
	/h4+xD7ALjaym923u+tMApcxfqCLElndk6BncqJ88MyJ9uZkstqRdR7RKQKh50eC
	35D0q4eYQ+mvG9zTcyqh8zjn8Z5BfgG4XXKVNtLcpYWTF9ENM1OFx+F8C5v3+joW
	db0wnczPxJbqkPluCGv1yVoP6oh91RkHYFUuo8eQ9k=
Received: from 00107082$163.com ( [111.35.191.17] ) by
 ajax-webmail-wmsvr-40-142 (Coremail) ; Sat, 10 May 2025 00:36:23 +0800
 (CST)
Date: Sat, 10 May 2025 00:36:23 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG?]Data key in /proc/allocinfo is a multiset
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpH4eiSgZqdMTCUOU2VfYezZuLoJefc0wuOWor9eeNzNTA@mail.gmail.com>
References: <20250509061013.922944-1-00107082@163.com>
 <CAJuCfpH4eiSgZqdMTCUOU2VfYezZuLoJefc0wuOWor9eeNzNTA@mail.gmail.com>
X-NTES-SC: AL_Qu2fBPSbt00j5SmQYekZnEYQheY4XMKyuPkg1YJXOp80uCbu+QEYeXBjM2nx7cOmEwatvxeTWgRU9P9lb5ZDdKaiyiW1Nq1r7bilL/BxCpA/
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <152dd526.b05a.196b5e7b738.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jigvCgDHfkIJLx5oPQEBAA--.9568W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gxIqmgeKMYGfwAEsZ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDUtMDkgMjM6NTY6MzIsICJTdXJlbiBCYWdoZGFzYXJ5YW4iIDxzdXJlbmJAZ29v
Z2xlLmNvbT4gd3JvdGU6Cj5PbiBUaHUsIE1heSA4LCAyMDI1IGF0IDExOjEw4oCvUE0gRGF2aWQg
V2FuZyA8MDAxMDcwODJAMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+IEp1c3Qgc3RhcnQgYSBuZXcgdGhy
ZWFkIGZvciB0aGlzWzFdLgo+PiBUaGVyZSBhcmUgZHVwbGljYXRpb25zIGluIC9wcm9jL2FsbG9j
aW5mbyB3aGVyZSBzYW1lIFtmaWxlOmxpbmVdCj4+IHNob3dzIHVwIHNldmVyYWwgdGltZXM6Cj4+
Cj4+ID09PT09PT09PT09PT09PT09PT09PT09Cj4+ICAgICAgICAgICAgMCAgICAgICAgMCAuL2lu
Y2x1ZGUvY3J5cHRvL2twcC5oOjE4NSBmdW5jOmtwcF9yZXF1ZXN0X2FsbG9jCj4+ICAgICAgICAg
ICAgMCAgICAgICAgMCAuL2luY2x1ZGUvY3J5cHRvL2twcC5oOjE4NSBmdW5jOmtwcF9yZXF1ZXN0
X2FsbG9jCj4+ID09PT09PT09PT09PT09PT09PT09PT09Cj4+ICAgICAgICAgICAgMCAgICAgICAg
MCAuL2luY2x1ZGUvbmV0L3RjcC5oOjI1NDggZnVuYzp0Y3BfdjRfc2F2ZV9vcHRpb25zCj4+ICAg
ICAgICAgICAgMCAgICAgICAgMCAuL2luY2x1ZGUvbmV0L3RjcC5oOjI1NDggZnVuYzp0Y3BfdjRf
c2F2ZV9vcHRpb25zCj4+ID09PT09PT09PT09PT09PT09PT09PT09Cj4+ICAgICAgICAgICAgMCAg
ICAgICAgMCBkcml2ZXJzL2lvbW11L2FtZC8uLi9pb21tdS1wYWdlcy5oOjk0IGZ1bmM6aW9tbXVf
YWxsb2NfcGFnZXNfbm9kZQo+PiAgICAgICAgICAgIDAgICAgICAgIDAgZHJpdmVycy9pb21tdS9h
bWQvLi4vaW9tbXUtcGFnZXMuaDo5NCBmdW5jOmlvbW11X2FsbG9jX3BhZ2VzX25vZGUKPj4gICAg
ICAgICAgICAwICAgICAgICAwIGRyaXZlcnMvaW9tbXUvYW1kLy4uL2lvbW11LXBhZ2VzLmg6OTQg
ZnVuYzppb21tdV9hbGxvY19wYWdlc19ub2RlCj4+ID09PT09PT09PT09PT09PT09PT09PT09Cj4+
ICAgICAgICAgICAgMCAgICAgICAgMCBkcml2ZXJzL2lvbW11L2ludGVsLy4uL2lvbW11LXBhZ2Vz
Lmg6OTQgZnVuYzppb21tdV9hbGxvY19wYWdlc19ub2RlCj4+ICAgICAgICAgICAgMCAgICAgICAg
MCBkcml2ZXJzL2lvbW11L2ludGVsLy4uL2lvbW11LXBhZ2VzLmg6OTQgZnVuYzppb21tdV9hbGxv
Y19wYWdlc19ub2RlCj4+ICAgICAgICAgICAgMCAgICAgICAgMCBkcml2ZXJzL2lvbW11L2ludGVs
Ly4uL2lvbW11LXBhZ2VzLmg6OTQgZnVuYzppb21tdV9hbGxvY19wYWdlc19ub2RlCj4+ICAgICAg
ICAgICAgMCAgICAgICAgMCBkcml2ZXJzL2lvbW11L2ludGVsLy4uL2lvbW11LXBhZ2VzLmg6OTQg
ZnVuYzppb21tdV9hbGxvY19wYWdlc19ub2RlCj4+ICAgICAgICAgICAgMCAgICAgICAgMCBkcml2
ZXJzL2lvbW11L2ludGVsLy4uL2lvbW11LXBhZ2VzLmg6OTQgZnVuYzppb21tdV9hbGxvY19wYWdl
c19ub2RlCj4KPlllcCwgdGhhdCBoYXBwZW5zIHdoZW4gYW4gaW5saW5lZCBmdW5jdGlvbiBhbGxv
Y2F0ZXMgbWVtb3J5LiBJdCBlbmRzCj51cCBpbmxpbmVkIGluIGRpZmZlcmVudCBsb2NhdGlvbnMu
IFVzdWFsbHkgdGhhdCdzIGRvbmUgYnkgYWxsb2NhdGlvbgo+aGVscGVyIGZ1bmN0aW9ucy4KPlRv
IGZpeCB0aGlzIHdlIG5lZWQgdG8gd3JhcCB0aGVzZSBhbGxvY2F0b3IgaGVscGVycyB3aXRoIGFs
bG9jX2hvb2tzOgo+Cj4tc3RhdGljIGlubGluZSB2b2lkICppb21tdV9hbGxvY19wYWdlc19ub2Rl
KGludCBuaWQsIGdmcF90IGdmcCwgaW50IG9yZGVyKQo+K3N0YXRpYyBpbmxpbmUgdm9pZCAqaW9t
bXVfYWxsb2NfcGFnZXNfbm9kZV9ub3Byb2YoaW50IG5pZCwgZ2ZwX3QgZ2ZwLAo+aW50IG9yZGVy
KQo+ewo+LSAgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBhbGxvY19wYWdlc19ub2RlKG5pZCwg
Z2ZwIHwgX19HRlBfWkVSTywKPm9yZGVyKTsgIHN0cnVjdCBza2NpcGhlcl9yZXF1ZXN0ICpyZXE7
Cj4rICAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9IGFsbG9jX3BhZ2VzX25vZGVfbm9wcm9mKG5p
ZCwgZ2ZwIHwKPl9fR0ZQX1pFUk8sIG9yZGVyKTsgIHN0cnVjdCBza2NpcGhlcl9yZXF1ZXN0ICpy
ZXE7Cj4uLi4KPn0KPisjZGVmaW5lIGlvbW11X2FsbG9jX3BhZ2VzX25vZGUoLi4uKQo+YWxsb2Nf
aG9va3MoaW9tbXVfYWxsb2NfcGFnZXNfbm9kZV9ub3Byb2YoX19WQV9BUkdTX18pKQo+Cj5TZWUg
MmMzMjFmM2Y3MGJjICJtbTogY2hhbmdlIGlubGluZWQgYWxsb2NhdGlvbiBoZWxwZXJzIHRvIGFj
Y291bnQgYXQKPnRoZSBjYWxsIHNpdGUiIGZvciBleGFtcGxlcyBvZiBob3cgdGhpcyB3YXMgZG9u
ZSBiZWZvcmUuCj5UaGFua3MsCj5TdXJlbi4KClRoYW5rcyBmb3IgY2xhcmlmeWluZyB0aGlzLCBz
ZWVtcyBsaWtlIGEgbmV2ZXItZW5kaW5nIHdvcmsuLi4uLi4gPl88fHx8Cgo+Cj4+IC4uLgo+Pgo+
PiBUaGUgZHVwbGljYXRpb24gbWFrZSBwYXJzaW5nIHRvb2xzIGEgbGl0dGxlIGJpdCBtb3JlIGNv
bXBsaWNhdGVkOgo+PiB0aGUgbnVtYmVycyBuZWVkIHRvIGJlIGFkZGVkIHVwLCBncm91cCBieSBr
ZXkKPj4gICAgICAgIDgxOTIwICAgICAgIDIwIGRyaXZlcnMvaW9tbXUvYW1kLy4uL2lvbW11LXBh
Z2VzLmg6OTQgZnVuYzppb21tdV9hbGxvY19wYWdlc19ub2RlIDIwCj4+ICAgICAgMTQ0MTc5MiAg
ICAgIDM1MiBkcml2ZXJzL2lvbW11L2FtZC8uLi9pb21tdS1wYWdlcy5oOjk0IGZ1bmM6aW9tbXVf
YWxsb2NfcGFnZXNfbm9kZSAzNTIKPj4KPj4gVGhlIHNjcmlwdCBmb3IgY2hlY2tpbmc6Cj4+IGBg
YAo+PiAjIS9iaW4vZW52IHB5dGhvbgo+PiBkZWYgZmV0Y2goKToKPj4gICAgIHIgPSB7fQo+PiAg
ICAgd2l0aCBvcGVuKCIvcHJvYy9hbGxvY2luZm8iKSBhcyBmOgo+PiAgICAgICAgIGZvciBsIGlu
IGY6Cj4+ICAgICAgICAgICAgIGYgPSBsLnN0cmlwKCkuc3BsaXQoKVsyXQo+PiAgICAgICAgICAg
ICBpZiBmIG5vdCBpbiByOiByW2ZdPVtdCj4+ICAgICAgICAgICAgIHJbZl0uYXBwZW5kKGwpCj4+
ICAgICBrZXlzID0gW10KPj4gICAgIGZvciBmLCBscyBpbiByLml0ZW1zKCk6Cj4+ICAgICAgICAg
aWYgbGVuKGxzKSA+IDE6IGtleXMuYXBwZW5kKGYpCj4+ICAgICBrZXlzLnNvcnQoKQo+PiAgICAg
Zm9yIGYgaW4ga2V5czoKPj4gICAgICAgICBwcmludCAiPT09PT09PT09PT09PT09PT09PT09PT0i
Cj4+ICAgICAgICAgZm9yIGwgaW4gcltmXTogcHJpbnQgbCwKPj4KPj4gZmV0Y2goKQo+PiBgYGAK
Pj4KPj4gVGhhbmtzCj4+IERhdmlkCj4+Cj4+IFsxXS4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC81MzFhZGJiYS5iNTM3LjE5NmIwODY4YThjLkNvcmVtYWlsLjAwMTA3MDgyQDE2My5jb20v
Cj4+Cg==

