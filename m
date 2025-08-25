Return-Path: <linux-kernel+bounces-783866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189C0B3339D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54BC3A888A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4D0224234;
	Mon, 25 Aug 2025 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="DpCKLDb4"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3EA1DF73A;
	Mon, 25 Aug 2025 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756085838; cv=none; b=hOJ4lCdLcIjlO3CWk+aEyVsiBQp6WHDoYUD+6+g5XZeW1Z6pdi4YR2FswnunKpPWSR7mS/JWjPglDcXe8YUl61zKXODq4eS9sGN+9XiAvkx6dQdx73AmHbOsG8Pfed5qFvVJT0BRZifgKoWQWqZF3vBoebbNRAHBHioxYI6ujzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756085838; c=relaxed/simple;
	bh=CYxRMx3JKPMFk0XIbw57x4SFeAQzU/07YODBSok7L/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=vDaFZQtFKoulv4MML43dTA1D+tw8lYzaLi1C1f4371CZnSRvSrr2Lf+vcuoizQREfJsp5ti0eM5IuotB9QrHq906g/DhNQkpKgiHlw6/AeXf2hSg3MHFqsGsnsbJdHeetxqTOt8/pw0Sgr/57Rydm+FnrAWbnWHCR5wXQ9tp4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=DpCKLDb4 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Xky+Bq7YlamxTZUutvPOTGMHUmRRJgrM7Mv/sxUPEXU=; b=D
	pCKLDb4IWJUriMDids2kfp/jx4eCWtqcszBlOuQxmz7aKjs4K6rAr8YrwHJLbwCS
	mPLfg+nsnSMC0RCWi/9LYRx5Jlul5FBHbe5apOH+O/BwHEG50icA3C3JPKzNR1pf
	wfpPA9zMns0qEpT2hb2ltxQowBLD74zQEOQKMmJ2Do=
Received: from ccc194101$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-126 (Coremail) ; Mon, 25 Aug 2025 09:36:49 +0800
 (CST)
Date: Mon, 25 Aug 2025 09:36:49 +0800 (CST)
From: =?GBK?B?19S8ug==?= <ccc194101@163.com>
To: "Alan Stern" <stern@rowland.harvard.edu>, gregkh@linuxfoundation.org
Cc: jannh@google.com, rex.nie@jaguarmicro.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re:Re: [PATCH] usb: usbfs: Add reset_resume callback to usbfs.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <f159e37f-3b27-4977-9712-345e8902eb48@rowland.harvard.edu>
References: <20250822024602.42894-1-ccc194101@163.com>
 <f159e37f-3b27-4977-9712-345e8902eb48@rowland.harvard.edu>
X-NTES-SC: AL_Qu2eBPyTukAr7yGZY+kfmkYVh+06W8K2vvwh24JUOJ94jA3p/B8sUHRSAkXw0O60MD68mgmGXhVg5uN+dJB/UoAB0djI+0bN5MEZZVblaHGd9g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4cdaecd1.131d.198dedeefe2.Coremail.ccc194101@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:figvCgD3X9YyvqtouGMgAA--.366W
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/1tbiZQ2x3mioYIwoAwAGsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNS0wOC0yMyAwNDozMDoxOCwgIkFsYW4gU3Rlcm4iIDxzdGVybkByb3dsYW5kLmhhcnZh
cmQuZWR1PiB3cm90ZToKPk9uIEZyaSwgQXVnIDIyLCAyMDI1IGF0IDEwOjQ2OjAyQU0gKzA4MDAs
IGNjYzE5NDEwMUAxNjMuY29tIHdyb3RlOgo+PiBGcm9tOiBjaGVuY2hhbmdjaGVuZyA8Y2hlbmNo
YW5nY2hlbmdAa3lsaW5vcy5jbj4KPj4gCj4+IFdoZW4gYW4gQXBwbGUgZGV2aWNlIGlzIGluc2Vy
dGVkIGludG8gdGhlIGhvc3QsIGFuZCB0aGUgaG9zdAo+PiB3YWtlcyB1cCBmcm9tIFMzL1M0IHBv
d2VyIHN0YXRlcywgaWYgdGhlIHJlc2V0X3Jlc3VtZSBwcm9jZXNzCj4+IGlzIHRyaWdnZXJlZCwg
dGhlIGFic2VuY2Ugb2YgYSByZXNldF9yZXN1bWUgY2FsbGJhY2sgaW4gdXNiZnMgd2lsbAo+PiBj
YXVzZSB0aGUgZGV2aWNlIHRvIHVuYmluZC4KPj4gQnkgYWRkaW5nIGEgcmVzZXRfcmVzdW1lIGNh
bGxiYWNrIHRvIHVzYmZzIGFuZCByZXBvcnRpbmcgUkVNT1ZFIGFuZCBBREQKPj4gdWV2ZW50cyBp
biByZXNldF9yZXN1bWUsIHRoZSB1c2Vyc3BhY2UgaXMgcHJvbXB0ZWQgdG8gcmVpc3N1ZSBjb21t
YW5kcwo+PiB0byByZS1lc3RhYmxpc2ggdGhlIGJpbmRpbmcgd2l0aCB1c2Jmcy4KPgo+dXNiZnMg
aGFzIG5vIHdheSB0byBpbmZvcm0gdXNlcnNwYWNlIHdoZW4gdGhlIGRldmljZSBpcyByZXNldC4g
IFRoaXMgaXMgCj50cnVlIGZvciBub3JtYWwgcmVzZXRzIGFzIHdlbGwgYXMgZm9yIHJlc2V0LXJl
c3VtZXMgKG5vIHByZV9yZXNldCwgCj5wb3N0X3Jlc2V0LCBvciByZXNldF9yZXN1bWUgY2FsbGJh
Y2tzKS4gIEkgZG9uJ3Qgc2VlIGFueSBwb2ludCBpbiB0cnlpbmcgCj50byBhZGQgc3VwcG9ydCBm
b3IgdGhlIGxhdHRlciBidXQgbm90IHRoZSBmb3JtZXIuCj4KPlVuYmluZGluZyB0aGUgZGV2aWNl
IGZvcmNlcyB1c2Vyc3BhY2UgdG8gcmUtb3BlbiB0aGUgZGV2aWNlIGZpbGUgYW5kIAo+ZXN0YWJs
aXNoIGEgbmV3IGJpbmRpbmcuICBIb3cgZG9lcyBhZGRpbmcgUkVNT1ZFIGFuZCBBREQgdWV2ZW50
cyBtYWtlIAo+dGhlIHNpdHVhdGlvbiBhbnkgYmV0dGVyIHRoYW4gaXQgYWxyZWFkeSBpcz8KPgoK
PkFsYW4gU3Rlcm4KCkhlcmUgaXMgbXkgcmVhc29uaW5nOiAKQ3VycmVudGx5LCBmb3IgQXBwbGUg
ZGV2aWNlcyBhZnRlciBTMy9TNCBzdGF0ZXMsIHNpbmNlIHRoZSBVU0IgaHViIGxvc2VzIHBvd2Vy
LCAKdGhlIHJlc2V0LXJlc3VtZSBwcm9jZXNzIGlzIHRyaWdnZXJlZCBkdXJpbmcgcmVzdW1lLiBJ
ZiB0aGUgb3JpZ2luYWwgCnJlc2V0X3Jlc3VtZSBwcm9jZXNzIGlzIGZvbGxvd2VkLCB0aGUgZGV2
aWNlIHdvdWxkIGJlIGZvcmNpYmx5IHVuYm91bmQsCmFuZCB0aGUgZGV2aWNlX2F0dGFjaCBmdW5j
dGlvbiB3b3VsZCBiZSB1c2VkIHRvIHJlYmluZCB0aGUgZHJpdmVyLgpIb3dldmVyLCB1c2JmcyBp
cyBkaWZmZXJlbnQgaW4gdGhhdCBpdCBjYW5ub3QgYXV0b21hdGljYWxseSByZWJpbmQKYWZ0ZXIg
dW5iaW5kaW5nIGFuZCByZXF1aXJlcyBhIHVzZXJzcGFjZSBpb2N0bCB0byByZS1lc3RhYmxpc2gg
dGhlIGJpbmRpbmcuCgpJZiB3ZSBhc3N1bWUgdGhhdCB0aGUgcmVzZXRfcmVzdW1lIGNhbGxiYWNr
IG9mIHVzYmZzIGRvZXMgbm90aGluZwphbmQgc2ltcGx5IHJldHVybnMgMCwgdGhlIFVTQiBkZXZp
Y2Ugd291bGQgc3RpbGwgYmUgcmVzZXQuIFdoZW4gdXNlcnNwYWNlCnVzZXMgdGhlIHByZXZpb3Vz
IGZpbGUgZGVzY3JpcHRvciBoYW5kbGUgdG8gaXNzdWUgYSBjb21tYW5kLCBpdCB3b3VsZCByZXN1
bHQKaW4gYW4gZXJyb3I6ICJQVFBfT0MgMHgxMDA3IHJlY2VpdmluZyByZXNwIGZhaWxlZDogUFRQ
IFNlc3Npb24gTm90IE9wZW4gKDB4MjAwMykuIgoKVGhlcmVmb3JlLCBieSBhZGRpbmcgUkVNT1ZF
IGFuZCBBREQgdWV2ZW50cyBpbiB0aGUgcmVzZXRfcmVzdW1lIHByb2Nlc3MsCnVzZXJzcGFjZSBp
cyBub3RpZmllZCB0byBmaXJzdCB1bmJpbmQgYW5kIHRoZW4gcmViaW5kLiBUaGlzIGFwcHJvYWNo
IGF2b2lkcyB0aGUgYWZvcmVtZW50aW9uZWQgaXNzdWUuCgpDaGVuIENoYW5nY2hlbmc=

