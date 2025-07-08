Return-Path: <linux-kernel+bounces-721257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9762BAFC6C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7534918966DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D062BF3F8;
	Tue,  8 Jul 2025 09:10:02 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341DB23BD09;
	Tue,  8 Jul 2025 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965802; cv=none; b=F8cAP0F6AGjg6iHYmOrcOt8PvLgZbL0Y3vW6uQ/jhXF/hyr1D18qC1x+KyIE5tlFbu55QFTkHUz1u1jzmYfitmh87IO6ZAPwBKYMri9/KXiuAp2ALkwZzASiG9hGkOECus15y7OpaimzonYgIsOjqaUtkripoSjLif0dIbaf/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965802; c=relaxed/simple;
	bh=x8I+A7hb/9qw+eXlNU73nIGg8C5waMAV+rHPrmEgpko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=UO+hUtFXgOfeapw0lpbinpNT63Va4WUndn992q3Ffai4/UHIt/a10chSfibI/0VVG1ppHlxT654FxipXcYD0OyJyPNCFxT6iFSsFH6dnj+QdGl6Y41i0ixVRFknWv+/TiVCDL82PqPpeJ5mbKvIdRT94EhanpvnhUwiHv6Ioojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 8 Jul 2025 17:09:46 +0800 (GMT+08:00)
Date: Tue, 8 Jul 2025 17:09:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Bo Gan" <ganboing@gmail.com>, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v3 2/2] clock: eswin: Add eic7700 clock driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <0f3aff5b-ff54-48a2-ae95-b344d311c3a1@gmail.com>
References: <20250624103212.287-1-dongxuyang@eswincomputing.com>
 <20250624103314.400-1-dongxuyang@eswincomputing.com>
 <0f3aff5b-ff54-48a2-ae95-b344d311c3a1@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7a325b0b.2de1.197e94c605b.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgA31pRa4GxorO6qAA--.18310W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQERAmhr9m4gF
	AAAs8
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgQm8sCgpUaGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbiwgaXQgaW1wcm92ZXMgb3VyIGRy
aXZlciBkZXZlbG9wbWVudCBlZmZvcnRzLgpQZXIgeW91ciByZWNvbW1lbmRhdGlvbnMsIHdlIHdp
bGwgb3B0aW1pemUgdGhlIGRyaXZlciBwcm9ncmFtLgoKPiBPbiA2LzI0LzI1IDAzOjMzLCBkb25n
eHV5YW5nQGVzd2luY29tcHV0aW5nLmNvbSB3cm90ZToKPiBUaGlzIGlzIHRvdGFsbHkgd3Jvbmcg
SSB0aGluay4gV2h5IGRvZXMgdGhlIGNsb2NrIGRyaXZlciBoYXZlIHRvIGNhcmUgYWJvdXQKPiBD
UFUgdm9sdGFnZT8gVGhpcyBmdW5jdGlvbmFsaXR5IGJlbG9uZ3MgdG8gY3B1ZnJlcS4gWW91IGNh
biB0YWtlIEpINzExMCBhcwo+IHJlZmVyZW5jZSBhbmQgc2VlIGhvdyBpdCdzIGRvbmU6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDYwNjEwNTY1Ni4xMjQzNTUtNC1tYXNvbi5odW9A
c3RhcmZpdmV0ZWNoLmNvbS8KPiBMb29raW5nIGF0IGVzd2luIHZlbmRvciB1LWJvb3QsIGl0IHNl
ZW1zIHlvdSBoYXZlIHNvbWUgU29DIHRoYXQgY2FuIG9wZXJhdGUKPiBhdCAxLjZHaHogd2l0aG91
dCBidW1waW5nIHRoZSB2b2x0YWdlLiBXaHkgbm90IGRvIGl0IHZpYSBvcGVyYXRpbmctcG9pbnRz
LXYyLAo+IGxpa2UgdGhlIG90aGVyIFNvQ3M/IEl0IGNhbiB0aGVuIGJlIG92ZXJyaWRkZW4gYnkg
Ym9hcmQgZGV2aWNlLXRyZWUgYW5kIHUtYm9vdAo+IEFsc28gdGhlIGxvZ2ljIG9mIHN3aXRjaGlu
ZyBjbG9jayBiZWZvcmUgY2hhbmdpbmcgUExMIHNob3VsZCBiZSBkb25lIHVzaW5nCj4gbm90aWZp
ZXI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA4MjYwODA0MzAuMTc5Nzg4LTIteGlu
Z3l1Lnd1QHN0YXJmaXZldGVjaC5jb20KPiBSZW1vdmUgdW5kb2N1bWVudGVkIHBhcmFtZXRlcnMg
c3VjaCBhcyAiY3B1X25vX2Jvb3N0XzFfNmdoeiIgYW5kCj4gImNwdS1kZWZhdWx0LWZyZXF1ZW5j
eSIuCgpXaGVuIGhpZ2hlciBjcHUgZnJlcXVlbmN5IGlzIGFwcGxpZWQsIHRoZSBoaWdoZXIgdm9s
dGFnZSBtdXN0IGJlwqAKY29uZmlndXJlZCBhY2NvcmRpbmdseS4gU28sIGZyb20gbXkgcGVyc3Bl
Y3RpdmUsIGl0J3MgYmV0dGVyIHRvCmltcGxlbWVudCB0aGUgY2xrLCByZWd1bGF0b3IgYW5kIGNw
dSBmcmVxdWVuY3kgc2VwYXJhdGVseS4KY2xrLmMgYW5kIGNsay1laWM3NzAwLmMgYXJlIHJlc3Bv
bnNpYmxlIGZvciBzZXR0aW5nIGNsayBvbmx5LgpyZWd1bGF0b3ItZWljNzcwMC5jIGlzIGZvciB2
b2x0YWdlIGNvbmZpZ3VyYXRpb24uCmNwdWZyZXEtZWljNzcwMC5jIGlzIGZvciBjcHUgZnJlcXVl
bmN5IGNvbmZpZ3VyYXRpb24sIGFuZCBpdCB3aWxsIGNhbGwKdGhlIEFQSXMgb2YgY2xrIGFuZCBy
ZWd1bGF0b3IuCgpJcyB0aGlzIHRoZSByaWdodCBhcHByb2FjaD8KCj4gT3ZlcmFsbCBJIHRoaW5r
IHlvdSBiZXR0ZXIgZG8gc29tZSByZWFsIGNsZWFudXAgYW5kIHJlZmFjdG9yIG9mIHRoaXMgcGF0
Y2gKPiBiZWZvcmUgc2VuZGluZyBpdCBvdXQgYWdhaW4uIFRoZSBkcml2ZXIgaXMgcXVpdGUgbG9u
ZywgYW5kIEkgc3VnZ2VzdCB5b3Ugc2hvdWxkCj4gY29uc2lkZXIgb3B0aW1pemluZy9jb25kZW5z
aW5nIHRoZSBsb2dpYy4gSSBndWVzcyB5b3UgcHJvYmFibHkgY2FycmllZCBvdmVyIHRoZQo+IHNh
bWUgY29kZSBhbmQgaGFja3MgeW91IG1hZGUgZm9yIHRoZSB2ZW5kb3IgdHJlZSAoZXN3aW5jb21w
dXRpbmcvbGludXgtc3RhYmxlKQo+IFRoZXJlJ3Mgbm8gd2F5IHRoZXkgY2FuIGJlIGFjY2VwdGVk
IGJ5IHVwc3RyZWFtLiBUYWtlIGEgbG9vayBhdCBvdGhlciBjbGsgdHJlZQo+IGltcGxlbWVudGF0
aW9ucyBhbmQgc3BlbmQgc29tZSByZWFsIGVmZm9ydCBmaXhpbmcgdGhlIGNvZGUuIERvbid0IGxl
dCB0aGUKPiByZXZpZXdlcnMgZ3JvdyBpbXBhdGllbnQgYnkgb25seSBjaGFuZ2luZyBzb21ldGhp
bmcgc3VwZXJmaWNpYWxseS4KCldlJ2xsIGltcHJvdmUgdGhlIHF1YWxpdHkgb2Ygb3VyIHJlc3Bv
bnNlcy4KCkJlc3QgcmVnYXJkcywKWHV5YW5nCg==

