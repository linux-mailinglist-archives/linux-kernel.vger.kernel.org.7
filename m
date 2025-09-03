Return-Path: <linux-kernel+bounces-797687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B020B41391
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5913F176484
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27462D0C75;
	Wed,  3 Sep 2025 04:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="O/Q0+huT"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043F44F5E0;
	Wed,  3 Sep 2025 04:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756873897; cv=none; b=BydYPGgFEdBU1y5SVnrWmsEBr6jcjab/9Cr5TygRaZCls6qRluaadXg2Z7cf9himbikc9nphVix0Ubd2SUb9eM/RcVV+XGVewQa2Nrw+Y0gzOT3IiFU9Yw/oKAcOXhEfxzBrVUPmzWKLs5yBhGirAK1oeSf38+BEUmJDWZXfwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756873897; c=relaxed/simple;
	bh=zOfqp69JcHUenStvsJhSWzm74vh4e1gjzLYrUutW6B4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fo0PRZKnsPlUrlEZW5JFendOR6n+Z2209G9v57J//1akq3tYViGfVS2y74Hy9lcH62f1TRTxzpsxQJt8HA/h+unTZyrWSKiZISELonkI7fmKDtJZcjmWsFFNTiaTOb1aGUXWl4SC3sHQw6Ai1wTxrGg3DF9DIyR0K8mtKD6WrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=O/Q0+huT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756873885;
	bh=zOfqp69JcHUenStvsJhSWzm74vh4e1gjzLYrUutW6B4=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=O/Q0+huTqBG5Gci+NR6iWMVRDmD/ivXH9zJMQTBvhMosT3ddDaIrwYrEpax1mEsGU
	 uOudqMsjwzGhx4g8z5V+Il3mXfk9JbMAx/FG/leY6hYZkSmMzgiS7oSwKqan6oXMtW
	 eC7PHv+6g+iQBPqU1R/QL41KA7ruDcywh8LzH+J4m+vQfQMGC+K3BBTvCl3doU/O8v
	 YeJqwZ6/lWTREgVFa0M6gQt7kl5c1NvlcOLkYJGczMXSZb8UGT6bfVBYoEEeg1XlmK
	 1S0ZXDTD3W5CgV8AgqSZMxTXM3AiuaFA5sIFFQVA9wjRrvWSD4YP+km8nJs9Wfinyy
	 lQ4Ych5bkaZJg==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D50876E02C;
	Wed,  3 Sep 2025 12:31:23 +0800 (AWST)
Message-ID: <3a65d568540e9ca43d3bfc24cfe5f72d2bb12b3b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 3/3] ARM: dts: aspeed: harma: add mp5990
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Sep 2025 14:01:22 +0930
In-Reply-To: <20250828074955.542711-4-peteryin.openbmc@gmail.com>
References: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
	 <20250828074955.542711-4-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUGV0ZXIsCgpPbiBUaHUsIDIwMjUtMDgtMjggYXQgMTU6NDkgKzA4MDAsIFBldGVyIFlpbiB3
cm90ZToKPiBBZGQgc3VwcG9ydCBmb3IgdGhlIEhTQyBNUDU5OTAgZGV2aWNlIG9uIHRoZSBIYXJt
YSBwbGF0Zm9ybS4KPiAKPiBUaGlzIGNoYW5nZSB1cGRhdGVzIHRoZSBkZXZpY2UgdHJlZSB0byBp
bmNsdWRlIHRoZSBNUDU5OTAgSFNDCj4gKEhvdCBTd2FwIENvbnRyb2xsZXIpLCBhbGxvd2luZyBw
cm9wZXIgY29uZmlndXJhdGlvbiBhbmQgaW50ZWdyYXRpb24KPiB3aXRoIHRoZSBwbGF0Zm9ybS4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBZaW4gPHBldGVyeWluLm9wZW5ibWNAZ21haWwuY29t
Pgo+IC0tLQo+IMKgYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2st
aGFybWEuZHRzIHwgNCArKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4g
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vi
b29rLWhhcm1hLmR0cwo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFj
ZWJvb2staGFybWEuZHRzCj4gaW5kZXggODEyNzhhNzcwMmRlLi4yM2VhZjQ3YTM4ZTggMTAwNjQ0
Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2staGFy
bWEuZHRzCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJv
b2staGFybWEuZHRzCj4gQEAgLTUyMCw2ICs1MjAsMTAgQEAgaW11eDI4OiBpMmNAMCB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI2FkZHJlc3MtY2Vs
bHMgPSA8MT47Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgI3NpemUtY2VsbHMgPSA8MD47Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmVnID0gPDA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcG93ZXItc2Vuc29yQDIwIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0g
Im1wcyxtcDU5OTAiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDIwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcG93ZXItbW9uaXRvckA2MSB7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBh
dGlibGUgPSAiaXNpbCxpc2w2OTI2MCI7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDYxPjsKCkkndmUgYXBw
bGllZCB0aGUgc2VyaWVzLCBob3dldmVyLCBjYW4geW91IHBsZWFzZSBzZW5kIGEgZm9sbG93LXVw
IHBhdGNoCmFkZGluZyBuZXctbGluZXMgYmV0d2VlbiB0aGUgY2hpbGQgbm9kZXMgb2YgaW11eDI4
PyBJdCdzIG5vdCBjb25zaXN0ZW50CndpdGggdGhlIHJlc3Qgb2YgdGhlIGRldmljZXRyZWUgYW5k
IGlzIGEgYml0IGRlbnNlLgoKVGhhbmtzLAoKQW5kcmV3Cgo=


