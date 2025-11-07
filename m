Return-Path: <linux-kernel+bounces-889821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27683C3E9D1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A7DF4EB186
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FE5299954;
	Fri,  7 Nov 2025 06:20:45 +0000 (UTC)
Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223B16F0FE;
	Fri,  7 Nov 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762496444; cv=none; b=U88fGVHChfNlDcJxkMvFgaPLN6OIOqVrvI1GPogD4qlyLZOpw2ziTOQC6vUfZfKPvdYa6ta4PQHwDY352IRM9yajoH+DNeSg8OIxyzItiIhMmRyx61f62+K9hnCpGeeDPYmbAMnsZGJpBs5yLVHDya9IAbwJ9a2xLQtH4pniqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762496444; c=relaxed/simple;
	bh=OImAq9SEI/nyi/EcocR46cpbXzVVuW8gjiSqUXLR9sY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=rUDdDkdKPrfdrjNyegC0fN0sO+EkLB7LiIJaledW8LbxHcaPf/wJCgRfS+vcLR/Rs6klreR711cmE0erTDjb8swRuTQ6TiT/4gKYx03g5bPko08Pj3snyGMG/KPYbihW1vNj5VY2Eyo98XpaAjQPfKVl7o35DeA+n4REo0qFZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 7 Nov 2025 14:20:23 +0800 (GMT+08:00)
Date: Fri, 7 Nov 2025 14:20:23 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bmasney@redhat.com,
	troy.mitchell@linux.spacemit.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v7 0/2] Add driver support for ESWIN eic700 SoC
 clock controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <039a3a41-c60f-4296-afd9-2bf3467574ca@kernel.org>
References: <20251023071658.455-1-dongxuyang@eswincomputing.com>
 <1abb85b.c11.19a582bcbbc.Coremail.dongxuyang@eswincomputing.com>
 <039a3a41-c60f-4296-afd9-2bf3467574ca@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6d2d7ddb.cbd.19a5cf92465.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDnK6+njw1pviVIAA--.1079W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQETAmkMzYES4
	AABsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+IAo+ID4gICBHZW50bGUgcGluZy4gTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHkuIFRo
YW5rIHlvdSB2ZXJ5IG11Y2ghCj4gCj4gUGxlYXNlIGRvIG5vdCB0b3AgcG9zdC4KPiAKPiBZb3Ug
ZGlkIG5vdCBhZGQgYW55IG1haW50YWluZXJzIG9mIHRoZXNlIGRyaXZlcnMsIHNvIEkgd291bGQg
bm90IHB1dCBpdAo+IGhpZ2ggb24gb3VyIHByaW9yaXR5IGxpc3QuICBBc2sgeW91cnNlbGYgLSB3
aHkgd291bGQgY29tbXVuaXR5Cj4gbWFpbnRhaW5lciBsaWtlIHRvIHRha2UgdW5tYWludGFpbmVk
IGRyaXZlcj8gU28gdGhlIGNvbW11bml0eSBtYWludGFpbmVyCj4gd291bGQgbWFpbnRhaW4sIHJp
Z2h0PyBUbyBhZGQgaGltIG1vcmUgd29yaz8gSWYgdGhhdCBpcyB0aGUgY2FzZSwgaXNuJ3QKPiBi
ZXR0ZXIgbm90IHRvIHRha2UgdGhlIGRyaXZlcj8gWW91IHNlZSB3aGVyZSBJIGFtIGdldHRpbmcg
YXQ/Cj4gCj4gQWxzbywgSSBkb24ndCBzZWUgYW55IGludm9sdmVtZW50IGluIHJldmlld3MgZnJv
bSBlc3dpbi4gVGhlIG9ubHkKPiByZXZpZXdzIGhlcmUgd2hlcmUgZnJvbSBEVCBtYWludGFpbmVy
cywgVHJveSBhbmQgQnJpYW4gKEkgaG9wZSBJIGRpZCBub3QKPiBtaXNzIGFueW9uZSksIHNvIGFn
YWluIC0geW91IGp1c3QgcHV0IGFsbCB0aGUgZWZmb3J0IG9uIHVzIGFuZCB0aGVuIHBpbmcKPiB1
cy4uLgo+IAoKSGVsbG8gS3J6eXN6dG9mIEJyaWFuIFRyb3ksCgpXb3VsZCB5b3Uga2luZGx5IHJl
dmlldyB0aGUgdXBkYXRlZCB2NyBwYXRjaGVzIGF0IHlvdXIgZWFybGllc3QgY29udmVuaWVuY2U/
CgpUaGFua3MgdG8gS3J6eXN6dG9mIGZvciB5b3VyIHJlcGx5LgoKVGhlc2UgcGF0Y2hlcyBoYXZl
IGFscmVhZHkgdW5kZXJnb25lIHJldmlldyB3aXRoaW4gb3VyIGludGVybmFsIHRlYW0uwqAKVGhl
IHJlYXNvbiBmb3IgYWRkaW5nIGVzd2luIG1haW50YWluZXJzIHRvIHRoZSBtYWlsaW5nIGxpc3Qg
aXMgdG8gZW5zdXJlwqAKdGhhdCB0aGVzZSBjb2xsZWFndWVzIGNhbiBwcm9tcHRseSByZWNlaXZl
IGNvbW11bml0eSBmZWVkYmFjayBhbmQgc3RhecKgCmluZm9ybWVkIG9mIHRoZSBkaXNjdXNzaW9u
cy4KClJlZ2FyZHMsClh1eWFuZyBEb25nCg==

