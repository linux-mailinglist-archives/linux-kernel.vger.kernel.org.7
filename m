Return-Path: <linux-kernel+bounces-775152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEEFB2BBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B305188BAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE35A3115B1;
	Tue, 19 Aug 2025 08:34:37 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981A2765D4;
	Tue, 19 Aug 2025 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592477; cv=none; b=bNmAmJXSkXFUUXKH4YNahmb+mEiSs5bEAUSh3BonNle61uTubPt8X06K4GJpYKcbeu1gytNtrGAwp1H/UhUAYY+I1lZb8EhmsAvIvKVG3ziPzJwKoLLmFiPJ+DHdQ9q4wlzvVPac4yAK0ZakeZ3appFRGvND2CNjKjAcMPHNlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592477; c=relaxed/simple;
	bh=AGQ4RfZQGSB5r6QgZFK8YYksCXzcan9R+m3zGTw78pI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Nc5XFGMXFXhSZsdUqFvIANIURtYx2B82WgkSwU26Jg9iFBmC8n9MtDK9bqgR9n0yzgAMgZu4a9nrmb9a++EOYI09yS7HBXY9HwkWW8K4SZB7TWky464ZRPrRmtrNhg7IgI6JLrOqo1KWBYcngc/cCqs6WqwR2O1HPuIKYCkGihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 19 Aug 2025 16:34:18 +0800 (GMT+08:00)
Date: Tue, 19 Aug 2025 16:34:18 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6JGj57uq5rSL?= <dongxuyang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v4 3/3] riscv: dts: eswin: Add clock driver support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <0ef61f03-0346-491d-ad2a-293e24cbc4a8@kernel.org>
References: <20250815093539.975-1-dongxuyang@eswincomputing.com>
 <20250815093754.1143-1-dongxuyang@eswincomputing.com>
 <0ef61f03-0346-491d-ad2a-293e24cbc4a8@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3fa3950e.371.198c1770125.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDHZpUKN6Ro+YvAAA--.22666W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgETAmijVc8e3
	wABsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgS3J6eXN6dG9mLAoKVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBjb25zdHJ1Y3RpdmUg
c3VnZ2VzdGlvbnMuCgo+ID4gCj4gPiBBZGQgY2xvY2sgZGV2aWNlIHRyZWUgc3VwcG9ydCBmb3Ig
ZWljNzcwMCBTb0MuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFlpZmVuZyBIdWFuZyA8aHVhbmd5
aWZlbmdAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogWHV5YW5nIERvbmcg
PGRvbmd4dXlhbmdAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gLS0tCj4gPiAgYXJjaC9yaXNjdi9i
b290L2R0cy9lc3dpbi9laWM3NzAwLWNsb2Nrcy5kdHNpIHwgMjI4MyArKysrKysrKysrKysrKysr
Kwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMjgzIGluc2VydGlvbnMoKykKPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgYXJjaC9yaXNjdi9ib290L2R0cy9lc3dpbi9laWM3NzAwLWNsb2Nrcy5kdHNpCj4g
PiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2Vzd2luL2VpYzc3MDAtY2xv
Y2tzLmR0c2kgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2Vzd2luL2VpYzc3MDAtY2xvY2tzLmR0c2kK
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjQwNWQwNmY5
MTkwZQo+ID4gLS0tIC9kZXYvbnVsbAo+ID4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9lc3dp
bi9laWM3NzAwLWNsb2Nrcy5kdHNpCj4gPiBAQCAtMCwwICsxLDIyODMgQEAKPiA+ICsvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgTUlUKQo+ID4gKy8qCj4gPiArICogQ29w
eXJpZ2h0IChjKSAyMDI1LCBCZWlqaW5nIEVTV0lOIENvbXB1dGluZyBUZWNobm9sb2d5IENvLiwg
THRkLgo+ID4gKyAqLwo+ID4gKwo+ID4gKy8gewo+ID4gKwljbG9jay1jb250cm9sbGVyQDUxODI4
MDAwIHsKPiA+ICsJCWNvbXBhdGlibGUgPSAiZXN3aW4sZWljNzcwMC1jbG9jayI7Cj4gPiArCQly
ZWcgPSA8MHgwMDAwMDAgMHg1MTgyODAwMCAweDAwMDAwMCAweDgwMDAwPjsKPiA+ICsJCSNjbG9j
ay1jZWxscyA9IDwwPjsKPiA+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Owo+ID4gKwkJI3NpemUt
Y2VsbHMgPSA8MD47Cj4gPiArCj4gPiArCQkvKiBmaXhlZCBjbG9jayAqLwo+ID4gKwkJZml4ZWRf
cmF0ZV9jbGtfYXBsbF9mb3V0MjogZml4ZWQtcmF0ZS1hcGxsLWZvdXQyIHsKPiAKPiBTdWNoIHBh
dHRlcm4gd2FzIHllYXJzIGFnbyBOQUtlZC4KPiAKPiBObywgZG9uJ3QgZXZlciBicmluZyBub2Rl
cyBwZXIgY2xvY2suCj4gCldlIGhhdmUgZGVmaW5lZCBhIGxhcmdlIG51bWJlciBvZiBjbG9jayBk
ZXZpY2VzLsKgClRoZSBjb21tZW50IG9mIHYzIGlzICJEcml2ZXIgaXMgYWxzbyB3YXkgdG9vIGJp
ZyBmb3Igc2ltcGxlIGNsb2NrIGRyaXZlciBhbmQgScKgCmFtIHN1cnByaXNlZCB0byBzZWUgc28g
bWFueSByZWR1bmRhbmNpZXMuIi4gVGhlcmVmb3JlLCB3ZSBtb2RpZmllZCB0aGUgY2xvY2vCoApk
cml2ZXIgY29kZSBhbmQgbW92ZWQgdGhlIGRlc2NyaXB0aW9uIG9mIGNsb2NrIGRldmljZSBmcm9t
IHRoZSBkcml2ZXIgdG8gdGhlIERUUy4KCkJ1dCwgdGhpcyBjb21tZW50IGlzIHRoYXQgZG9uJ3Qg
ZXZlciBicmluZyBub2RlcyBwZXIgY2xvY2suIFdl4oCZdmUgcnVuIGludG8gc29tZQp0cm91Ymxl
IGFuZCBhcmVu4oCZdCBzdXJlIHdoaWNoIGFwcHJvYWNoIGFsaWducyBiZXR0ZXIgd2l0aCBjb21t
dW5pdHkgZ3VpZGVsaW5lcy7CoApDb3VsZCB5b3Ugc2hhcmUgeW91ciBhZHZpY2Ugb3Igc3VnZ2Vz
dGlvbnMgb24gdGhlIGJlc3Qgd2F5IGZvcndhcmQ/CgpJIHdvdWxkIGJlIGdyYXRlZnVsIGZvciB5
b3VyIHJlcGx5LgoKUmVnYXJkcywKWHV5YW5nIERvbmcK

