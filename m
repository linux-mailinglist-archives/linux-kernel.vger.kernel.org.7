Return-Path: <linux-kernel+bounces-894454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A595C4ABAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EB7189460D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972D6258EF6;
	Tue, 11 Nov 2025 01:21:47 +0000 (UTC)
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF92D979C;
	Tue, 11 Nov 2025 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824107; cv=none; b=tnn9p4r/jIjtNTzH9NqDvhmOg0mGf/1vz377tgLZ3hF9PoG+OFUp2DRbnBNlkI9lOwuuIQvyDZlq/yx7Y3fMDbVc083DSiaCZdxyIu8qG8UecTNxCIM0vsY5IT/Hye8gZ6FE6BVyIUrfdt8J1BnyaDHnCDEMQ3x6KJd29Yt38w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824107; c=relaxed/simple;
	bh=gCjRIKc6GlJ4lkRY0m4vHpiJLg54xIt10H+z+ZH0plc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=l4qwS7wazLWkcdgeUu7DMPb5ly1zSTSX4UkXzWkPjrB/6JAhvEkkkVCFCEYXu6p0AIuCL5XXYJocQupjjNiOsJc/RW5s7abIorwBzbidytAyK/algLFug2TEb5WCrxcyMAnb1oL3BLjjKwSkrqF8o4n7jrTOPvzRex/igwKVgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 11 Nov 2025 09:21:32 +0800 (GMT+08:00)
Date: Tue, 11 Nov 2025 09:21:32 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Troy Mitchell" <troy.mitchell@linux.dev>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bmasney@redhat.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v7 2/2] clock: eswin: Add eic7700 clock driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <aQ2jbf2k3rwOZDuB@kernel.org>
References: <20251023071658.455-1-dongxuyang@eswincomputing.com>
 <20251023071814.568-1-dongxuyang@eswincomputing.com>
 <aQ2jbf2k3rwOZDuB@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <74be57c4.45.19a7080fca1.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgBnq66cjxJpoHd6AA--.1284W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEDAmkSE9sH7
	gABsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9lc3dpbi9LY29uZmlnIGIvZHJpdmVycy9jbGsv
ZXN3aW4vS2NvbmZpZwo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+IGluZGV4IDAwMDAwMDAw
MDAwMC4uOWJjOTAwOGQzMTU2Cj4gPiAtLS0gL2Rldi9udWxsCj4gPiArKysgYi9kcml2ZXJzL2Ns
ay9lc3dpbi9LY29uZmlnCj4gPiBAQCAtMCwwICsxLDE1IEBACj4gPiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMAo+ID4gKwo+ID4gK2NvbmZpZyBDT01NT05fQ0xLX0VTV0lOCj4g
PiArCWJvb2wKPiA+ICsKPiA+ICtjb25maWcgQ09NTU9OX0NMS19FSUM3NzAwCj4gPiArCWJvb2wg
IkVJQzc3MDAgQ2xvY2sgRHJpdmVyIgo+IFdlIGNhbid0IGJ1aWxkIHRoaXMgZHJpdmVyIGFzIG1v
ZHVsZT8KPiBJZiBubywgc2VlIGhlcmU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9aJTJG
bE43cXJJU3BiSzZNUVlAZ29rby13LnRhaWxjZTZjNDkudHMubmV0LwogCk9LCgo+ID4gKwlkZXBl
bmRzIG9uIEFSQ0hfRVNXSU4gfHwgQ09NUElMRV9URVNUCj4gPiArCXNlbGVjdCBDT01NT05fQ0xL
X0VTV0lOCj4gPiArCWRlZmF1bHQgQVJDSF9FU1dJTgo+ID4gKwloZWxwCj4gPiArCSAgVGhpcyBk
cml2ZXIgcHJvdmlkZXMgc3VwcG9ydCBmb3IgY2xvY2sgY29udHJvbGxlciBvbiBFU1dJTiBFSUM3
NzAwCj4gPiArCSAgU29DLiBUaGUgY2xvY2sgY29udHJvbGxlciBjYW4gZ2VuZXJhdGVzIGFuZCBz
dXBwbGllcyBjbG9jayB0byB2YXJpb3VzCj4gPiArCSAgcGVyaXBoZXJhbHMgd2l0aGluIHRoZSBT
b0MuCj4gPiArCSAgU2F5IHllcyBoZXJlIHRvIHN1cHBvcnQgdGhlIGNsb2NrIGNvbnRyb2xsZXIg
b24gdGhlIEVJQzc3MDAgU29DLgo+IFsuLi5dCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsv
ZXN3aW4vY2xrLWVpYzc3MDAuYyBiL2RyaXZlcnMvY2xrL2Vzd2luL2Nsay1laWM3NzAwLmMKPiBD
YW4geW91IGdpdmUgdXMgYSBjbG9jay10cmVlIGltZyBvciBwZGY/Cj4gCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgLSBUcm95CgpIaSBUcm95LAoKVGhlIGxpbmsgWzFdIHByb3ZpZGVzIHRoZSBv
ZmZpY2lhbCBkb2N1bWVudGF0aW9uIGZvciB0aGUgRUlDNzcwMC7CoApTZWN0aW9uIDMuMiBjb3Zl
cnMgdGhlIGNsb2NrIHN1YnN5c3RlbSwgd2hlcmUgeW91IGNhbiBmaW5kIGRldGFpbGVkwqAKaW5m
b3JtYXRpb24gYWJvdXQgdGhlIGNsb2NrLXRyZWUuCgpbMV0gaHR0cHM6Ly93d3cuc2lmaXZlLmNv
bS9kb2N1bWVudC1maWxlL2VpYzc3MDB4LWRhdGFzaGVldAoKUmVnYXJkcywKWHV5YW5nIERvbmcK


