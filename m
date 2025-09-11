Return-Path: <linux-kernel+bounces-812389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311CDB53797
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9061C239E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA36D34F46A;
	Thu, 11 Sep 2025 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="KoO2UY5t"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A4350822
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604052; cv=none; b=mcACjyxFjXd+tUQJaw990fmpJj3rkBGE2Y7ImCuWawWPWDswNskl8GgWPWYcTI5SI4z9ULryWz6wKVVnA3C7M0itRQWu4OjD6u1WGX277ibmdYBg1sNVSHXU1I87Ecluc++R0lK81cVbU+tt6mX8Jqzk3otUYsOflwodElTmgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604052; c=relaxed/simple;
	bh=R9HM9zIlGy82epQdECWeMo8XaOByczUIim9micFq2Ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=UZQdeXBTNuCJCO4MBxZJUcghR5JHR4zkgBIgeXzJ/ES/2hbL+KbxHjbA/63zfNH/ivvsKqVwzR6QKGB0mT4TrbY09t/fbdHDQbiqFUzStYRmjOrXuGSFxAkxbNMNAU3pqDQGz7+KscRO7CfFLcG0dbDG90StkUDMQH6TlqHkskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=KoO2UY5t reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=zT13f5E8NapKoHf1bvUnYWcJqBwdVmg+t2G4vMoo2nk=; b=K
	oO2UY5t+ZDFloK72DQPnCscC5fZRfRTy9f1PLz6QspKCK8VxHA6Qm7VWugpA1XC9
	fj2O4XtqiERgCL+97vlqAaoZWj+BUWPZuwBCDwxwfZxpjYP/XqIvdg3YRtpRQrYs
	72bh32IifnaEIF956GpPoz0x9ri6MDLf7YJjqP1qgU=
Received: from 00107082$163.com ( [111.35.190.173] ) by
 ajax-webmail-wmsvr-40-122 (Coremail) ; Thu, 11 Sep 2025 23:03:50 +0800
 (CST)
Date: Thu, 11 Sep 2025 23:03:50 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz,
	hannes@cmpxchg.org, usamaarif642@gmail.com, rientjes@google.com,
	roman.gushchin@linux.dev, harry.yoo@oracle.com,
	shakeel.butt@linux.dev, pasha.tatashin@soleen.com,
	souravpanda@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250909234942.1104356-1-surenb@google.com>
References: <20250909234942.1104356-1-surenb@google.com>
X-NTES-SC: AL_Qu2eBfqbvEgo5iCQYOkZnEYQheY4XMKyuPkg1YJXOp80qSTW1A0GU1FlInXn6t6RBSGwlyeUcjhi6ehqfah2XYRFpFuYvfayCeL9QuJ6t6c1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eigvCgD3P2zX5MJoXO0uAA--.16302W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEA7FqmjCuoTPRgAGsq
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDktMTAgMDc6NDk6NDIsICJTdXJlbiBCYWdoZGFzYXJ5YW4iIDxzdXJlbmJAZ29v
Z2xlLmNvbT4gd3JvdGU6Cj5XaGlsZSByYXJlLCBtZW1vcnkgYWxsb2NhdGlvbiBwcm9maWxpbmcg
Y2FuIGNvbnRhaW4gaW5hY2N1cmF0ZSBjb3VudGVycwo+aWYgc2xhYiBvYmplY3QgZXh0ZW5zaW9u
IHZlY3RvciBhbGxvY2F0aW9uIGZhaWxzLiBUaGF0IGFsbG9jYXRpb24gbWlnaHQKPnN1Y2NlZWQg
bGF0ZXIgYnV0IHByaW9yIHRvIHRoYXQsIHNsYWIgYWxsb2NhdGlvbnMgdGhhdCB3b3VsZCBoYXZl
IHVzZWQKPnRoYXQgb2JqZWN0IGV4dGVuc2lvbiB2ZWN0b3Igd2lsbCBub3QgYmUgYWNjb3VudGVk
IGZvci4gVG8gaW5kaWNhdGUKPmluY29ycmVjdCBjb3VudGVycywgbWFyayB0aGVtIHdpdGggYW4g
YXN0ZXJpc2sgaW4gdGhlIC9wcm9jL2FsbG9jaW5mbwo+b3V0cHV0Lgo+QnVtcCB1cCAvcHJvYy9h
bGxvY2luZm8gdmVyc2lvbiB0byByZWZsZWN0IGNoYW5nZSBpbiB0aGUgZmlsZSBmb3JtYXQuCj4K
PkV4YW1wbGUgb3V0cHV0IHdpdGggaW52YWxpZCBjb3VudGVyczoKPmFsbG9jaW5mbyAtIHZlcnNp
b246IDIuMAo+ICAgICAgICAgICAwICAgICAgICAwIGFyY2gveDg2L2tlcm5lbC9rZGVidWdmcy5j
OjEwNSBmdW5jOmNyZWF0ZV9zZXR1cF9kYXRhX25vZGVzCj4gICAgICAgICAgIDAgICAgICAgIDAg
YXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmM6MjA5MCBmdW5jOmFsdGVybmF0aXZlc19zbXBf
bW9kdWxlX2FkZAo+ICAgICAgICAgIDAqICAgICAgIDAqIGFyY2gveDg2L2tlcm5lbC9hbHRlcm5h
dGl2ZS5jOjEyNyBmdW5jOl9faXRzX2FsbG9jCj4gICAgICAgICAgIDAgICAgICAgIDAgYXJjaC94
ODYva2VybmVsL2ZwdS9yZWdzZXQuYzoxNjAgZnVuYzp4c3RhdGVyZWdzX3NldAo+ICAgICAgICAg
ICAwICAgICAgICAwIGFyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRlLmM6MTU5MCBmdW5jOmZwc3Rh
dGVfcmVhbGxvYwo+ICAgICAgICAgICAwICAgICAgICAwIGFyY2gveDg2L2tlcm5lbC9jcHUvYXBl
cmZtcGVyZi5jOjM3OSBmdW5jOmFyY2hfZW5hYmxlX2h5YnJpZF9jYXBhY2l0eV9zY2FsZQo+ICAg
ICAgICAgICAwICAgICAgICAwIGFyY2gveDg2L2tlcm5lbC9jcHUvYW1kX2NhY2hlX2Rpc2FibGUu
YzoyNTggZnVuYzppbml0X2FtZF9sM19hdHRycwo+ICAgICAgNDkxNTIqICAgICAgNDgqIGFyY2gv
eDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYzoyNzA5IGZ1bmM6bWNlX2RldmljZV9jcmVhdGUKPiAg
ICAgICAzMjc2OCAgICAgICAgMSBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9nZW5wb29sLmM6MTMy
IGZ1bmM6bWNlX2dlbl9wb29sX2NyZWF0ZQo+ICAgICAgICAgICAwICAgICAgICAwIGFyY2gveDg2
L2tlcm5lbC9jcHUvbWNlL2FtZC5jOjEzNDEgZnVuYzptY2VfdGhyZXNob2xkX2NyZWF0ZV9kZXZp
Y2UKPgoKSGksIApUaGUgY2hhbmdlcyBtYXkgIGJyZWFrIHNvbWUgY2xpZW50IHRvb2xzLCBtaW5l
IGluY2x1ZGVkLi4uLiAKSSBkb24ndCBtaW5kIGFkanVzdGluZyBteSB0b29scywgYnV0IHN0aWxs
CklzIGl0IGFjY2VwdGFibGUgIHRvIGNoYW5nZSAKICAgICAgNDkxNTIqICAgICAgNDgqIGFyY2gv
eDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYzoyNzA5IGZ1bmM6bWNlX2RldmljZV9jcmVhdGUKdG8K
ICAgICAgKzQ5MTUyICAgICAgKzQ4IGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYzoyNzA5
IGZ1bmM6bWNlX2RldmljZV9jcmVhdGUqCgpUaGUgJysnIHNpZ24gbWFrZSBpdCBzdGlsbCBzdGFu
ZG91dCB3aGVuIHZpZXcgZnJvbSBhIHRlcm1pbmFsLCBhbmQgY2xpZW50IHRvb2xzLCBub3QgYWxs
IG9mIHRoZW0gdGhvdWdoLCBtaWdodCBub3QgbmVlZCBhbnkgY2hhbmdlcy4gCkFuZCB3aGVuIGNs
aWVudCB3YW50IHRvIGZpbHRlciBvdXQgaW5hY2N1cmF0ZSBkYXRhIGl0ZW1zLCBpdCBjb3VsZCBi
ZSBkb25lIGJ5IGNoZWNraW5nIHRoZSB0YWlsaW5nICcqIiBvZiBmdW5jIG5hbWUuCgooVGhlcmUg
d291bGQgYmUgc29tZSBjb3JuZXIgY2FzZXMsIGZvciBleGFtcGxlLCB0aGUgJysnIHNpZ24gbWF5
IG5vdCBuZWVkZWQgd2hlbiB0aGUgdmFsdWUgcmVhY2ggYSBuZWdhdGl2ZSB2YWx1ZSBpZiBzb21l
IHVuZGVyZmxvdyBidWcgaGFwcGVuZWQpCgoKVGhhbmtzCkRhdmlkLgoKCj5TdWdnZXN0ZWQtYnk6
IEpvaGFubmVzIFdlaW5lciA8aGFubmVzQGNtcHhjaGcub3JnPgo+U2lnbmVkLW9mZi1ieTogU3Vy
ZW4gQmFnaGRhc2FyeWFuIDxzdXJlbmJAZ29vZ2xlLmNvbT4KPi0tLQoK

