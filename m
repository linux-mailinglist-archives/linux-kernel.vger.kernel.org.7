Return-Path: <linux-kernel+bounces-779335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ABCB2F2A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43547BAA02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3C02ECEA5;
	Thu, 21 Aug 2025 08:45:46 +0000 (UTC)
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016FE2EA48F;
	Thu, 21 Aug 2025 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765946; cv=none; b=lH8bcDk/W6o7iVRVflYUvFBN0ka0axaAyRs9K3I7+Ai+peVUl5sbou3p2oPSPXQhvBQ4vMuTvNgUHn06KE2TUnFNtP96/Nke34IrGGxCddanet7g73fjIdtXrBMkIUQqoaymuPjeorBis1gHEiGWdP2PSchaDyXyyCx3m07ym+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765946; c=relaxed/simple;
	bh=1OZUlltJR5Uc++55sA1dzKlArKgrpruidlWcPYjFWIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=fM9b0gYeQqCUZc5pZnvJFjYi7RhI3ln0Jg+bZFfABVQNJBGxbQ+qIn1krdYV5ayn6hbopiyw1F/LMRFQV6mexQHOnZNxBjV/EgQhJnMp8r57WurYTUuOxjVr29CRfdfc0YIcc1qT91s1JMUO9L7sqk7GSHxDo4JfSTcZIhhILDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 21 Aug 2025 16:45:26 +0800 (GMT+08:00)
Date: Thu, 21 Aug 2025 16:45:26 +0800 (GMT+08:00)
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
In-Reply-To: <bfa23779-9861-4ae4-9ced-9f347394f033@kernel.org>
References: <20250815093539.975-1-dongxuyang@eswincomputing.com>
 <20250815093754.1143-1-dongxuyang@eswincomputing.com>
 <0ef61f03-0346-491d-ad2a-293e24cbc4a8@kernel.org>
 <3fa3950e.371.198c1770125.Coremail.dongxuyang@eswincomputing.com>
 <bfa23779-9861-4ae4-9ced-9f347394f033@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <27984d9.51f.198cbcde8d7.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAXt5Wm3KZodHPBAA--.23144W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEBAmil+M8hP
	gACsn
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgS3J6eXN6dG9mLAoKVGhhbmtzIGZvciB5b3VyIGNvbnN0cnVjdGl2ZSBzdWdnZXN0aW9ucy4K
IAo+ID4+Pgo+ID4+PiBBZGQgY2xvY2sgZGV2aWNlIHRyZWUgc3VwcG9ydCBmb3IgZWljNzcwMCBT
b0MuCj4gPj4+Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IFlpZmVuZyBIdWFuZyA8aHVhbmd5aWZlbmdA
ZXN3aW5jb21wdXRpbmcuY29tPgo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBYdXlhbmcgRG9uZyA8ZG9u
Z3h1eWFuZ0Blc3dpbmNvbXB1dGluZy5jb20+Cj4gPj4+IC0tLQo+ID4+PiAgYXJjaC9yaXNjdi9i
b290L2R0cy9lc3dpbi9laWM3NzAwLWNsb2Nrcy5kdHNpIHwgMjI4MyArKysrKysrKysrKysrKysr
Kwo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDIyODMgaW5zZXJ0aW9ucygrKQo+ID4+PiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvZXN3aW4vZWljNzcwMC1jbG9ja3MuZHRz
aQo+ID4+Pgo+ID4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9lc3dpbi9laWM3
NzAwLWNsb2Nrcy5kdHNpIGIvYXJjaC9yaXNjdi9ib290L2R0cy9lc3dpbi9laWM3NzAwLWNsb2Nr
cy5kdHNpCj4gPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPj4+IGluZGV4IDAwMDAwMDAwMDAw
MC4uNDA1ZDA2ZjkxOTBlCj4gPj4+IC0tLSAvZGV2L251bGwKPiA+Pj4gKysrIGIvYXJjaC9yaXNj
di9ib290L2R0cy9lc3dpbi9laWM3NzAwLWNsb2Nrcy5kdHNpCj4gPj4+IEBAIC0wLDAgKzEsMjI4
MyBAQAo+ID4+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIE1JVCkK
PiA+Pj4gKy8qCj4gPj4+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjUsIEJlaWppbmcgRVNXSU4gQ29t
cHV0aW5nIFRlY2hub2xvZ3kgQ28uLCBMdGQuCj4gPj4+ICsgKi8KPiA+Pj4gKwo+ID4+PiArLyB7
Cj4gPj4+ICsJY2xvY2stY29udHJvbGxlckA1MTgyODAwMCB7Cj4gPj4+ICsJCWNvbXBhdGlibGUg
PSAiZXN3aW4sZWljNzcwMC1jbG9jayI7Cj4gPj4+ICsJCXJlZyA9IDwweDAwMDAwMCAweDUxODI4
MDAwIDB4MDAwMDAwIDB4ODAwMDA+Owo+ID4+PiArCQkjY2xvY2stY2VsbHMgPSA8MD47Cj4gPj4+
ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Owo+ID4+PiArCQkjc2l6ZS1jZWxscyA9IDwwPjsKPiA+
Pj4gKwo+ID4+PiArCQkvKiBmaXhlZCBjbG9jayAqLwo+ID4+PiArCQlmaXhlZF9yYXRlX2Nsa19h
cGxsX2ZvdXQyOiBmaXhlZC1yYXRlLWFwbGwtZm91dDIgewo+ID4+Cj4gPj4gU3VjaCBwYXR0ZXJu
IHdhcyB5ZWFycyBhZ28gTkFLZWQuCj4gPj4KPiA+PiBObywgZG9uJ3QgZXZlciBicmluZyBub2Rl
cyBwZXIgY2xvY2suCj4gPj4KPiA+IFdlIGhhdmUgZGVmaW5lZCBhIGxhcmdlIG51bWJlciBvZiBj
bG9jayBkZXZpY2VzLsKgCj4gPiBUaGUgY29tbWVudCBvZiB2MyBpcyAiRHJpdmVyIGlzIGFsc28g
d2F5IHRvbyBiaWcgZm9yIHNpbXBsZSBjbG9jayBkcml2ZXIgYW5kIEnCoAo+ID4gYW0gc3VycHJp
c2VkIHRvIHNlZSBzbyBtYW55IHJlZHVuZGFuY2llcy4iLiBUaGVyZWZvcmUsIHdlIG1vZGlmaWVk
IHRoZSBjbG9ja8KgCj4gPiBkcml2ZXIgY29kZSBhbmQgbW92ZWQgdGhlIGRlc2NyaXB0aW9uIG9m
IGNsb2NrIGRldmljZSBmcm9tIHRoZSBkcml2ZXIgdG8gdGhlIERUUy4KPiA+IAo+ID4gQnV0LCB0
aGlzIGNvbW1lbnQgaXMgdGhhdCBkb24ndCBldmVyIGJyaW5nIG5vZGVzIHBlciBjbG9jay4gV2Xi
gJl2ZSBydW4gaW50byBzb21lCj4gCj4gQW5kPyBXaGF0IGlzIHVuY2xlYXIgaW4gdGhhdCBjb21t
ZW50Pwo+IAo+ID4gdHJvdWJsZSBhbmQgYXJlbuKAmXQgc3VyZSB3aGljaCBhcHByb2FjaCBhbGln
bnMgYmV0dGVyIHdpdGggY29tbXVuaXR5IGd1aWRlbGluZXMuwqAKPiA+IENvdWxkIHlvdSBzaGFy
ZSB5b3VyIGFkdmljZSBvciBzdWdnZXN0aW9ucyBvbiB0aGUgYmVzdCB3YXkgZm9yd2FyZD8KPiAK
PiBMb29rIGF0IGFueSBvdGhlciByZWNlbnQgY2xvY2sgZHJpdmVycy4KCkkgZm91bmQgb3V0IHRo
YXQgdGhlIHJlY2VudCBjbG9jayBkcml2ZXJzLCBzdWNoIGFzIHNvcGhnby9jbGstc2cyMDQ0LmPC
oAphbmQgcm9ja2NoaXAvY2xrLXJrMzU2Mi5jLCB0aGUgY2xvY2sgdHJlZSBpbmZvcm1hdGlvbiBv
ZiB0aGVtIHdhcyBwbGFjZWQKaW4gdGhlIEMgY29kZS7CoApTbywgZm9yIEVJQzc3MDAgU29DLCBz
aG91bGQgdGhlIGNsb2NrIHRyZWUgaW5mb3JtYXRpb24gYmUgcGxhY2VkIGluCmNsay1laWM3NzAw
LmMganVzdCBhcyBjbGstc2cyMDQ0LmM/IElzIHRoaXMgdW5kZXJzdGFuZGluZyBjb3JyZWN0PwoK
SSB3b3VsZCBiZSBncmF0ZWZ1bCBmb3IgeW91ciByZXBseS4KClJlZ2FyZHMsClh1eWFuZyBEb25n
Cg==

