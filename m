Return-Path: <linux-kernel+bounces-774942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E67B2B96E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D842116F751
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C31F2690C0;
	Tue, 19 Aug 2025 06:30:26 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0081725CC5E;
	Tue, 19 Aug 2025 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585026; cv=none; b=TfGMnBpYoCZkaizQUiSA3ADn38OSbeEsNW/X5skxInDWlQlP1OgFEOuBTNfsoyAfGn7mpXMj0wlBU6QYHJKzTiW3b0j0wkbLduhwO3lPC9eSFJ3MzBUpj58JjZ1Pcqil0knNDenpcc5LLhreRMOQkwnIyfpuR8SLYhv3A5N+m/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585026; c=relaxed/simple;
	bh=WLwMsf64ba8d/+q/tlokjJR6cjH3Psfoad9FLMDaRC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=NoekwlPg/h7eX2wEPjQpNOzbMoVFqY+DsjO23qbtA/m2uXc8EB9EncAKxbcB9H7ePBIPWTkGv1MfyS2Ni9I5tBLX12RS7Z/nOp6MQh5DRu+PW0T5z/f3hOudkxCrUoC5uTZv03YwEWDhqrPd5ZItfwNnoeBwTbE7frocNRvjUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 19 Aug 2025 14:30:08 +0800 (GMT+08:00)
Date: Tue, 19 Aug 2025 14:30:08 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6JGj57uq5rSL?= <dongxuyang@eswincomputing.com>
To: "Philipp Zabel" <p.zabel@pengutronix.de>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v5 2/2] reset: eswin: Add eic7700 reset driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <1c6b0262f0043e65592501d88221ec2a69e9d641.camel@pengutronix.de>
References: <20250725093249.669-1-dongxuyang@eswincomputing.com>
 <20250725093436.779-1-dongxuyang@eswincomputing.com>
 <1c6b0262f0043e65592501d88221ec2a69e9d641.camel@pengutronix.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <764c4fa5.321.198c105554b.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAXt5XwGaRofH7AAA--.22838W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgETAmijVc8aC
	wAAsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgUGhpbGlwcCwKCj4gPiAKPiA+IEFkZCBzdXBwb3J0IGZvciByZXNldCBjb250cm9sbGVyIGlu
IGVpYzc3MDAgc2VyaWVzIGNoaXBzLgo+ID4gUHJvdmlkZSBmdW5jdGlvbmFsaXR5IGZvciBhc3Nl
cnRpbmcgYW5kIGRlYXNzZXJ0aW5nIHJlc2V0cwo+ID4gb24gdGhlIGNoaXAuCj4gPiAKPiA+IFNp
Z25lZC1vZmYtYnk6IFlpZmVuZyBIdWFuZyA8aHVhbmd5aWZlbmdAZXN3aW5jb21wdXRpbmcuY29t
Pgo+ID4gU2lnbmVkLW9mZi1ieTogWHV5YW5nIERvbmcgPGRvbmd4dXlhbmdAZXN3aW5jb21wdXRp
bmcuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9yZXNldC9LY29uZmlnICAgICAgICAgfCAgMTAg
Kwo+ID4gIGRyaXZlcnMvcmVzZXQvTWFrZWZpbGUgICAgICAgIHwgICAxICsKPiA+ICBkcml2ZXJz
L3Jlc2V0L3Jlc2V0LWVpYzc3MDAuYyB8IDQzMiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA0NDMgaW5zZXJ0aW9ucygrKQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Jlc2V0L3Jlc2V0LWVpYzc3MDAuYwo+ID4gCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9yZXNldC9LY29uZmlnIGIvZHJpdmVycy9yZXNldC9LY29uZmlnCj4g
PiBpbmRleCBkODViZTU4OTlkYTYuLjgyZjgyOWY0YzlmMCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZl
cnMvcmVzZXQvS2NvbmZpZwo+ID4gKysrIGIvZHJpdmVycy9yZXNldC9LY29uZmlnCj4gPiBAQCAt
NjYsNiArNjYsMTYgQEAgY29uZmlnIFJFU0VUX0JSQ01TVEJfUkVTQ0FMCj4gPiAgCSAgVGhpcyBl
bmFibGVzIHRoZSBSRVNDQUwgcmVzZXQgY29udHJvbGxlciBmb3IgU0FUQSwgUENJZTAsIG9yIFBD
SWUxIG9uCj4gPiAgCSAgQkNNNzIxNi4KPiA+IAo+ID4gK2NvbmZpZyBSRVNFVF9FSUM3NzAwCj4g
PiArCWJvb2wgIlJlc2V0IGNvbnRyb2xsZXIgZHJpdmVyIGZvciBFU1dJTiBTb0NzIgo+ID4gKwlk
ZXBlbmRzIG9uIEFSQ0hfRVNXSU4gfHwgQ09NUElMRV9URVNUCj4gCj4gVW5kZWNsYXJlZCBkZXBl
bmRlbmN5IG9uIFsxXS4KPiAKPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUw
NjE2MTEyMzE2LjM4MzMzNDMtMy1waW5rZXNoLnZhZ2hlbGFAZWluZm9jaGlwcy5jb20vCj4gCj4g
cmVnYXJkcwo+IFBoaWxpcHAKCldlIHdpbGwgYWRkIHRoZSBmb2xsb3dpbmcgZGVwZW5kZW5jaWVz
IGluIHRoZSBjb3ZlciBsZXR0ZXIgb2Ygb3VyIG5leHQgcGF0Y2guCgpUaGlzIHNlcmllcyBkZXBl
bmRzIG9uIHRoZSB2ZW5kb3IgcHJlZml4IHBhdGNoIFsxXSBhbmQgY29uZmlnIG9wdGlvbiBwYXRj
aCBbMl0uCgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwNjE2MTEyMzE2LjM4
MzMzNDMtNC1waW5rZXNoLnZhZ2hlbGFAZWluZm9jaGlwcy5jb20vClsyXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyNTA2MTYxMTIzMTYuMzgzMzM0My0zLXBpbmtlc2gudmFnaGVsYUBl
aW5mb2NoaXBzLmNvbS8KClJlZ2FyZHMsClh1eWFuZyBEb25nCg==

