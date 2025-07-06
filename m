Return-Path: <linux-kernel+bounces-717085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC5CAF8F00
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 11:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A34B58280A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53AB2ECD0C;
	Fri,  4 Jul 2025 09:46:36 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F528750C;
	Fri,  4 Jul 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622396; cv=none; b=QzLLdDnSHjq8OIGZRx1UYCxj6MsBku3b3hs9LgfbQHQh2QewyQOGFDN9rUQ3Wtu7Q7UsWcmhdX7/OtntVgx5LsOAGvYlehfkFpjAEs6vhao3lSZ3o7K22a3P9fUi4XumOICzdaRWuNSZ4Wf2gVJi0NYKXRzZkC4BpSs/Kfd432w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622396; c=relaxed/simple;
	bh=kaAvn2mEvpkM/kZRGRfT46cp+asI1NtSPv8mylZUabk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ZH+p5f2IyQFpkdeBiFVjOYBfAytYxY714LnQ+v0ZU3hblD6mOYKQ8SFXho5+mrCA2+9R7F/Adn3mewIfp2J42jcQfMcYEmtTg98tcrJgxdEEWRCSiztonmxR8yfcLSgxWNefVLYDUWpQnvW7S39jyGHy+BcfCnlDhe8BbX+iXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 4 Jul 2025 17:46:13 +0800 (GMT+08:00)
Date: Fri, 4 Jul 2025 17:46:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6JGj57uq5rSL?= <dongxuyang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	=?UTF-8?B?6Z+m5bCa5aif?= <weishangjuan@eswincomputing.com>
Subject: Re: Re: [PATCH v3 2/2] clock: eswin: Add eic7700 clock driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <420cc724-e6cf-42d9-b00b-558965bee085@kernel.org>
References: <20250624103212.287-1-dongxuyang@eswincomputing.com>
 <20250624103314.400-1-dongxuyang@eswincomputing.com>
 <420cc724-e6cf-42d9-b00b-558965bee085@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6890259a.2bec.197d4d45239.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDHZpXlomdodOKoAA--.18354W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQENAmhmsG0fS
	QABsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBPbiAyNC8wNi8yMDI1IDEyOjMzLCBkb25neHV5YW5nQGVzd2luY29tcHV0aW5nLmNvbSB3cm90
ZToKPiA+IEZyb206IFh1eWFuZyBEb25nIDxkb25neHV5YW5nQGVzd2luY29tcHV0aW5nLmNvbT4K
PiA+IAo+ID4gVGhpcyBkcml2ZXIgZGVwZW5kcyBvbiB0aGUgQ0NGIGZyYW1ld29yayBpbXBsZW1l
bnRhdGlvbi4KPiA+ICAgQmFzZWQgb24gdGhpcyBkcml2ZXIsIG90aGVyIG1vZHVsZXMgaW4gdGhl
IFNvQyBjYW4gdXNlIHRoZSBBUElzCj4gPiAgIHByb3ZpZGVkIGJ5IENDRiB0byBwZXJmb3JtIGNs
b2NrLXJlbGF0ZWQgb3BlcmF0aW9ucy4KPiA+ICAgVGhlIGRyaXZlciBzdXBwb3J0cyBlaWM3NzAw
IHNlcmllcyBjaGlwcy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogWWlmZW5nIEh1YW5nIDxodWFu
Z3lpZmVuZ0Blc3dpbmNvbXB1dGluZy5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdXlhbmcgRG9u
ZyA8ZG9uZ3h1eWFuZ0Blc3dpbmNvbXB1dGluZy5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2Ns
ay9LY29uZmlnICAgICAgICAgICAgIHwgICAgMSArCj4gPiAgZHJpdmVycy9jbGsvTWFrZWZpbGUg
ICAgICAgICAgICB8ICAgIDEgKwo+ID4gIGRyaXZlcnMvY2xrL2Vzd2luL0tjb25maWcgICAgICAg
fCAgIDEwICsKPiA+ICBkcml2ZXJzL2Nsay9lc3dpbi9NYWtlZmlsZSAgICAgIHwgICAgOCArCj4g
PiAgZHJpdmVycy9jbGsvZXN3aW4vY2xrLWVpYzc3MDAuYyB8IDM4MDkgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwo+ID4gIGRyaXZlcnMvY2xrL2Vzd2luL2Nsay1laWM3NzAwLmggfCAg
MTk0ICsrCj4gCj4gCj4gCj4gLi4uCj4gCj4gCj4gPiArdm9pZCBlc3dpbl9jbGtfcmVnaXN0ZXJf
cGxsKHN0cnVjdCBlc3dpbl9wbGxfY2xvY2sgKmNsa3MsIGludCBudW1zLAo+ID4gKwkJCSAgICBz
dHJ1Y3QgZXN3aW5fY2xvY2tfZGF0YSAqZGF0YSwgc3RydWN0IGRldmljZSAqZGV2KQo+ID4gK3sK
PiA+ICsJdm9pZCBfX2lvbWVtICpiYXNlID0gZGF0YS0+YmFzZTsKPiA+ICsJc3RydWN0IGVzd2lu
X2Nsa19wbGwgKnBfY2xrID0gTlVMTDsKPiA+ICsJc3RydWN0IGNsayAqY2xrID0gTlVMTDsKPiA+
ICsJc3RydWN0IGNsa19pbml0X2RhdGEgaW5pdDsKPiA+ICsJaW50IGk7Cj4gPiArCXN0YXRpYyBz
dHJ1Y3QgZ3Bpb19kZXNjICpjcHVfdm9sdGFnZV9ncGlvOwo+ID4gKwo+ID4gKwlwX2NsayA9IGRl
dm1fa3phbGxvYyhkZXYsIHNpemVvZigqcF9jbGspICogbnVtcywgR0ZQX0tFUk5FTCk7Cj4gPiAr
Cj4gPiArCWlmICghcF9jbGspCj4gPiArCQlyZXR1cm47Cj4gPiArCS8qCj4gPiArCSAqSW4gdGhl
IEQyRCBzeXN0ZW0sIHRoZSBib29zdCBvcGVyYXRpb24gaXMgcGVyZm9ybWVkIHVzaW5nIHRoZSBH
UElPIG9uIERpZTAuCj4gCj4gV2hhdCBpcyB0aGUgTGludXggY29kaW5nIHN0eWxlIG9mIGNvbW1l
bnQ/Cj4gCj4gPiArCSAqSG93ZXZlciwgdGhlIHNhbWUgR1BJTyBwaW4gY2Fubm90IGJlIGFjcXVp
cmVkIHR3aWNlLCBzbyBzcGVjaWFsIGhhbmRsaW5nIGlzIGltcGxlbWVudGVkOgo+ID4gKwkgKk9u
Y2UgdGhlIEdQSU8gaXMgYWNxdWlyZWQsdGhlIG90aGVyIGRyaXZlciBzaW1wbHkgdXNlcyBpdCBk
aXJlY3RseQo+ID4gKwkgKi8KPiA+ICsJY3B1X3ZvbHRhZ2VfZ3BpbyA9Cj4gPiArCQlJU19FUlJf
T1JfTlVMTChjcHVfdm9sdGFnZV9ncGlvKSA/Cj4gPiArCQkJZGV2bV9ncGlvZF9nZXQoZGV2LCAi
Y3B1LXZvbHRhZ2UiLCBHUElPRF9PVVRfSElHSCkgOgo+ID4gKwkJCWNwdV92b2x0YWdlX2dwaW87
Cj4gPiArCWlmIChJU19FUlJfT1JfTlVMTChjcHVfdm9sdGFnZV9ncGlvKSkgewo+ID4gKwkJZGV2
X3dhcm4oZGV2LCAiZmFpbGVkIHRvIGdldCBjcHUgdm9sYXRnZSBncGlvXG4iKTsKPiA+ICsJCWNw
dV92b2x0YWdlX2dwaW8gPSBOVUxMOwo+ID4gKwl9IGVsc2Ugewo+ID4gKwkJLypjcHUgZGVmYXVs
dCBmcmVxIGlzIDE0MDBNLCB0aGUgdm9sYXRnZSBzaG91bGQgYmUgVk9MVEFHRV8wXzhWKi8KPiA+
ICsJCWVzd2luX2Nsa19zZXRfY3B1X3ZvbGF0Z2UoY3B1X3ZvbHRhZ2VfZ3BpbywgVk9MVEFHRV8w
XzhWKTsKPiAKPiBBbW91bnQgb2YgdHlwb3MgYW5kIHVucmVhZGFibGUgc3R1ZmYgbGlrZSBtaXNz
aW5nIHNwYWNlcyBpbiB0aGlzIGRyaXZlcgo+IGlzIGp1c3QgZGlzY291cmFnaW5nIGFuZCBtYWtp
bmcgcmV2aWV3IHVubmVjZXNzYXJ5IGRpZmZpY3VsdC4gRml4IHRoZQo+IHR5cG9zLCBmaXggdGhl
IHN0eWxlLiBEcml2ZXIgaXMgYWxzbyB3YXkgdG9vIGJpZyBmb3Igc2ltcGxlIGNsb2NrIGRyaXZl
cgo+IGFuZCBJIGFtIHN1cnByaXNlZCB0byBzZWUgc28gbWFueSByZWR1bmRhbmNpZXMuCj4gCj4g
QW55d2F5LCB5b3VyIGJpbmRpbmcgc2FpZCBpdCBpcyBub3QgMTQwME0gYnV0IHNvbWV0aGluZyBl
bHNlIHNvIHRoaXMgaXMKPiBhIG1lc3MuCj4gCgpXaGVuIGhpZ2hlciBjcHUgZnJlcXVlbmN5IGlz
IGFwcGxpZWQsIHRoZSBoaWdoZXIgdm9sdGFnZSBtdXN0IGJlCmNvbmZpZ3VyZWQgYWNjb3JkaW5n
bHkuIFNvLCBmcm9tIG15IHBlcnNwZWN0aXZlLCBpdCdzIGJldHRlciB0bwppbXBsZW1lbnQgdGhl
IGNsaywgcmVndWxhdG9yIGFuZCBjcHUgZnJlcXVlbmN5IHNlcGFyYXRlbHkuCmNsay5jIGFuZCBj
bGstZWljNzcwMC5jIGFyZSByZXNwb25zaWJsZSBmb3Igc2V0dGluZyBjbGsgb25seS4KcmVndWxh
dG9yLWVpYzc3MDAuYyBpcyBmb3Igdm9sdGFnZSBjb25maWd1cmF0aW9uLgpjcHVmcmVxLWVpYzc3
MDAuYyBpcyBmb3IgY3B1IGZyZXF1ZW5jeSBjb25maWd1cmF0aW9uLCBhbmQgaXQgd2lsbCBjYWxs
CnRoZSBBUElzIG9mIGNsayBhbmQgcmVndWxhdG9yLgpJcyB0aGlzIHRoZSByaWdodCBhcHByb2Fj
aD8KClRoZSBjbGsgZHJpdmVyIHRvbyBiaWcgaXMgYmVjYXVzZSBjbGsgdHJlZXMgYXJlIGRlZmlu
ZWQgaW4gdGhlIC5jIGZpbGUuCgpXZSBhcHByZWNpYXRlIHlvdXIgcmV2aWV3IG9mIG91ciBwcm9w
b3NlZCBjaGFuZ2VzLiBQbGVhc2UgbGV0IHVzIGtub3cKaWYgdGhlc2UgbW9kaWZpY2F0aW9ucyBt
ZWV0IHRoZSBwcm9qZWN0J3Mgc3RhbmRhcmRzLiBTaG91bGQgYW55CmFkanVzdG1lbnRzIGJlIG5l
ZWRlZCwgd2UnZCB3ZWxjb21lIHlvdXIgc3BlY2lmaWMgZmVlZGJhY2sgdG8gaGVscAp1cyBpbXBy
b3ZlIHRoZSBpbXBsZW1lbnRhdGlvbi4KCkJlc3QgcmVnYXJkcywKWHV5YW5nIERvbmcK

