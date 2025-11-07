Return-Path: <linux-kernel+bounces-890010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C88C3F0F1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 959ED4E8BB7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7FE316910;
	Fri,  7 Nov 2025 09:02:32 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D82D3164CB;
	Fri,  7 Nov 2025 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506151; cv=none; b=plgh7+cptrXW2Wf6kkmqym3a7Jj8juX5GoenUkxpxHtggDGsyu50W5Z8njXVyS4plp4w/XAZ0FG1wU2YSMpgdQ86jW5R++oR3oYBAqjsQ6E3OxAkgIwe6xHIvyuuy0kzBtvjiP4PAr+UvD2N6LvBpOA5n7GeIwHfQ1DRONwPXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506151; c=relaxed/simple;
	bh=+soozUbq4KCPWTIh5G7JqfsUDroaOwLTIC6v9IAnJ/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=uR67hKnLfymSILnoioGjfenh1/7fGWGXnmKCRI3N028Rslt4ZJ1FBsoUhB8hW7dsLQJSLUBBVQdVL8TMiAUjQI/fD7xxa9TQNYVzwSHURHDwhCrD4buEPzO+NCQFto0xdUMn8E2b8vh8GiuHlwg5dWrExTCcE+RMdPcONsaqCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 7 Nov 2025 17:02:06 +0800 (GMT+08:00)
Date: Fri, 7 Nov 2025 17:02:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>,
	"Krzysztof Kozlowski" <krzk@kernel.org>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bmasney@redhat.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: Re: [PATCH v7 0/2] Add driver support for ESWIN eic700 SoC
 clock controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <1618037D174FDF5F+aQ2hU1J9oLEKCq25@kernel.org>
References: <20251023071658.455-1-dongxuyang@eswincomputing.com>
 <1abb85b.c11.19a582bcbbc.Coremail.dongxuyang@eswincomputing.com>
 <039a3a41-c60f-4296-afd9-2bf3467574ca@kernel.org>
 <6d2d7ddb.cbd.19a5cf92465.Coremail.dongxuyang@eswincomputing.com>
 <1618037D174FDF5F+aQ2hU1J9oLEKCq25@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5a9911a3.d09.19a5d8d32cd.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDnK6+OtQ1pYuBJAA--.1101W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgETAmkMzdoxi
	QACsa
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+ID4gPiAKPiA+ID4gPiAgIEdlbnRsZSBwaW5nLiBMb29raW5nIGZvcndhcmQgdG8geW91ciBy
ZXBseS4gVGhhbmsgeW91IHZlcnkgbXVjaCEKPiA+ID4gCj4gPiA+IFBsZWFzZSBkbyBub3QgdG9w
IHBvc3QuCj4gPiA+IAo+ID4gPiBZb3UgZGlkIG5vdCBhZGQgYW55IG1haW50YWluZXJzIG9mIHRo
ZXNlIGRyaXZlcnMsIHNvIEkgd291bGQgbm90IHB1dCBpdAo+ID4gPiBoaWdoIG9uIG91ciBwcmlv
cml0eSBsaXN0LiAKPiBEbyB5b3UgaGF2ZSBhbnkgcGxhbnMgdG8gYmVjb21lIGEgbWFpbnRhaW5l
cj8gSWYgc28sIHRoaXMgcGF0Y2ggbWlnaHQgZ2V0Cj4gcmV2aWV3ZWQgd2l0aCBoaWdoZXIgcHJp
b3JpdHkuIEkgdGhpbmsgdGhhdCdzIHdoYXQgS3J6eXN6dG9mIG1lYW50Lgo+IAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC0gVHJveQoKSGVsbG8gVHJveSwKClllcywgSSBwbGFuIHRv
IGJlY29tZSB0aGUgbWFpbnRhaW5lciBmb3IgdGhpcyBkcml2ZXIuIEkgd2lsbCBhZGQgbXnCoApt
YWludGFpbmVyIGluZm9ybWF0aW9uIHRvIHRoZSBNQUlOVEFJTkVSUyBmaWxlIGluIHRoZSBuZXh0
IHBhdGNoIHNlcmllcy7CoApXb3VsZCB0aGF0IGJlIGFjY2VwdGFibGU/CgpSZWdhcmRzLApYdXlh
bmcgRG9uZwo=

