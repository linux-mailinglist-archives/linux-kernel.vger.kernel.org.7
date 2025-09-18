Return-Path: <linux-kernel+bounces-789738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7570CB399C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9899616770C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A653112A0;
	Thu, 28 Aug 2025 10:23:04 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95C130F949;
	Thu, 28 Aug 2025 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376584; cv=none; b=TwIUE43KpmDd2ZHjGEo41VK6d06JWS+TPCe7giP2sfhCytzpCsyYABzVO9nF+ZEoCHqyCE7pyJ7NBFQZXvxLNB8SfI9+o6gndssOF7qRDC4P90Eox39C46W78KSCiI1FyRnuqQuRf74BPzmyZJI9Lbl7E8pKnVpd0yS2QKukwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376584; c=relaxed/simple;
	bh=n9rQG0HiH4n+CJwGltmwSRUQaAp3/3Waf/KiyeFfQF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=lX5d56qpeDKxFT6YbPX7d5EcAT5vmaJ9i+fekbkQo8kk+LdMuCEzl7bzKKVvawzXPOs4YHIS5dLIuzYK1tSXZYU8Y99A/M8GXVMUb1EjAI/U9ZOEw4ztkc9hIz+OuUb79SgBr9FpG4EOLkUjWzdSZPbBXqnMM+FRw2pYCOJGVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from luyulin$eswincomputing.com ( [10.12.96.77] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 28 Aug 2025 18:22:40 +0800 (GMT+08:00)
Date: Thu, 28 Aug 2025 18:22:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: luyulin@eswincomputing.com
To: "Rob Herring" <robh@kernel.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
	ningyu@eswincomputing.com, zhengyu@eswincomputing.com,
	linmin@eswincomputing.com, huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com, lianghujun@eswincomputing.com
Subject: Re: Re: [PATCH v2 1/3] dt-bindings: ata: eswin: Document for
 EIC7700 SoC ahci
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <CAL_JsqKFotNLZZXwiy7S6K8qXLdGRAnsa-1zvZRDQBE39Gf5kg@mail.gmail.com>
References: <20250819134722.220-1-luyulin@eswincomputing.com>
 <20250819135413.386-1-luyulin@eswincomputing.com>
 <CAL_JsqKFotNLZZXwiy7S6K8qXLdGRAnsa-1zvZRDQBE39Gf5kg@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <692e11ca.843.198f0337528.Coremail.luyulin@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgA31pTwLbBo7avEAA--.23472W
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/1tbiAQEIA2ivMvYgfwAB
	sW
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8sIFJvYgoKVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciByZXBseS4KSSBoYXZlIGEg
cXVlc3Rpb24gdGhhdCBJIHdvdWxkIGxpa2UgdG8gc2VlayB5b3VyIGFkdmljZSBvbiBhbmQgY2xh
cmlmeS4KCj4gCj4gT24gVHVlLCBBdWcgMTksIDIwMjUgYXQgODo1NOKAr0FNIFl1bGluIEx1IDxs
dXl1bGluQGVzd2luY29tcHV0aW5nLmNvbT4gd3JvdGU6Cj4gPgo+ID4gRnJvbTogbHV5dWxpbiA8
bHV5dWxpbkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gCj4gUGxlYXNlIGZpeCB5b3VyIG5hbWUuCj4g
Cj4gPgo+ID4gQWRkIGRvY3VtZW50IGZvciB0aGUgU0FUQSBBSENJIGNvbnRyb2xsZXIgb24gdGhl
IEVJQzc3MDAgU29DIHBsYXRmb3JtLAo+ID4gaW5jbHVkaW5nIGRlc2NyaXB0aW9ucyBvZiBpdHMg
aGFyZHdhcmUgY29uZmlndXJhdGlvbnMuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogbHV5dWxpbiA8
bHV5dWxpbkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gCj4gQW5kIGhlcmUuCj4gCj4gPiAtLS0KPiA+
ICAuLi4vYmluZGluZ3MvYXRhL2Vzd2luLGVpYzc3MDAtYWhjaS55YW1sICAgICAgfCA5MiArKysr
KysrKysrKysrKysrKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkyIGluc2VydGlvbnMoKykKPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2F0
YS9lc3dpbixlaWM3NzAwLWFoY2kueWFtbAo+ID4KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXRhL2Vzd2luLGVpYzc3MDAtYWhjaS55YW1sIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2F0YS9lc3dpbixlaWM3NzAwLWFoY2kueWFt
bAo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uOWVmNThj
OWMyZjI4Cj4gPiAtLS0gL2Rldi9udWxsCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXRhL2Vzd2luLGVpYzc3MDAtYWhjaS55YW1sCj4gPiBAQCAtMCwwICsxLDky
IEBACj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0Qt
Mi1DbGF1c2UpCj4gPiArJVlBTUwgMS4yCj4gPiArLS0tCj4gPiArJGlkOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvc2NoZW1hcy9hdGEvZXN3aW4sZWljNzcwMC1haGNpLnlhbWwjCj4gPiArJHNjaGVt
YTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjCj4gPiArCj4g
PiArdGl0bGU6IEVzd2luIEVJQzc3MDAgU29DIFNBVEEgQ29udHJvbGxlcgo+ID4gKwo+ID4gK21h
aW50YWluZXJzOgo+ID4gKyAgLSBZdWxpbiBMdSA8bHV5dWxpbkBlc3dpbmNvbXB1dGluZy5jb20+
Cj4gPiArICAtIEh1YW4gSGUgPGhlaHVhbjFAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gKwo+ID4g
K2Rlc2NyaXB0aW9uOgo+ID4gKyAgVGhpcyBkb2N1bWVudCBkZWZpbmVzIGRldmljZSB0cmVlIGJp
bmRpbmdzIGZvciB0aGUgU3lub3BzeXMgRFdDCj4gPiArICBpbXBsZW1lbnRhdGlvbiBvZiB0aGUg
QUhDSSBTQVRBIGNvbnRyb2xsZXIgZm91bmQgaW4gRXN3aW4ncwo+ID4gKyAgRWljNzcwMCBTb0Mg
cGxhdGZvcm0uCj4gPiArCj4gPiArc2VsZWN0Ogo+ID4gKyAgcHJvcGVydGllczoKPiA+ICsgICAg
Y29tcGF0aWJsZToKPiA+ICsgICAgICBjb25zdDogZXN3aW4sZWljNzcwMC1haGNpCj4gPiArICBy
ZXF1aXJlZDoKPiA+ICsgICAgLSBjb21wYXRpYmxlCj4gPiArCj4gPiArYWxsT2Y6Cj4gPiArICAt
ICRyZWY6IHNucHMsZHdjLWFoY2ktY29tbW9uLnlhbWwjCj4gPiArCj4gPiArcHJvcGVydGllczoK
PiA+ICsgIGNvbXBhdGlibGU6Cj4gPiArICAgIGl0ZW1zOgo+ID4gKyAgICAgIC0gY29uc3Q6IGVz
d2luLGVpYzc3MDAtYWhjaQo+ID4gKyAgICAgIC0gY29uc3Q6IHNucHMsZHdjLWFoY2kKPiA+ICsK
PiA+ICsgIHJlZzoKPiA+ICsgICAgbWF4SXRlbXM6IDEKPiAKPiBEcm9wLiBzbnBzLGR3Yy1haGNp
LWNvbW1vbi55YW1sIGFscmVhZHkgZGVmaW5lcyB0aGlzLgo+IAo+ID4gKwo+ID4gKyAgaW50ZXJy
dXB0czoKPiA+ICsgICAgbWF4SXRlbXM6IDEKPiAKPiBEcm9wLiBzbnBzLGR3Yy1haGNpLWNvbW1v
bi55YW1sIGFscmVhZHkgZGVmaW5lcyB0aGlzLgo+IAo+ID4gKwo+ID4gKyAgcG9ydHMtaW1wbGVt
ZW50ZWQ6Cj4gPiArICAgIGNvbnN0OiAxCj4gCj4gUmVhbGx5LCB5b3VyIGZpcm13YXJlIHNob3Vs
ZCBpbml0aWFsaXplIHRoZSBEV0Mgc3BlY2lmaWMgcmVnaXN0ZXIgdGhhdAo+IHNldHMgdGhpcyBh
bmQgaXMgZGlzY292ZXJhYmxlIHZpYSBhIHN0YW5kYXJkIEFIQ0kgcmVnaXN0ZXIuCj4gCgpBY2Nv
cmQgdG8gbXkgdW5kZXJzdGFuZGluZywgaWYgcG9ydHMtaW1wbGVtZW50ZWQgaXMgY29uZmlndXJl
ZCBpbiB0aGUgZHRzLAp0aGlzIHJlZ2lzdGVyIHdpbGwgYmUgc2V0IGJ5IHRoZSBwbGF0Zm9ybSBk
cml2ZXIgaW4gbGliYWhjaV9wbGF0Zm9ybS5jLgoKRG8geW91IG1lYW4gdGhhdCBwb3J0cy1pbXBs
ZW1lbnRlZCBzaG91bGQgYmUgcmVtb3ZlZCBmcm9tIHRoZSBkdHMsCmFuZCB0aGUgY29ycmVzcG9u
ZGluZyByZWdpc3RlciBzaG91bGQgYmUgY29uZmlndXJlZCBieSB0aGUgZmlybXdhcmUKKHdoaWNo
IGlzIFUtQm9vdCBvbiB0aGUgSGlGaXZlIFByZW1pZXIgUDU1MCBib2FyZCk/IElzIHRoaXMgdW5k
ZXJzdGFuZGluZyBjb3JyZWN0PwpJZiBzbywgd2hlbiB0aGUgZHJpdmVyIGlzIHJlbW92ZWQsIGEg
cmVzZXQgd2lsbCBiZSB0cmlnZ2VyZWQsCmNhdXNpbmcgdGhlIGNvbmZpZ3VyYXRpb24gb2YgdGhp
cyByZWdpc3RlciB0byBiZSBsb3N0LAp3aGljaCB3aWxsIHJlc3VsdCBpbiBhbiBlcnJvciB3aGVu
IGluc21vZCB0aGUgZHJpdmVyIGFnYWluLgoKQmVzdCByZWdhcmRzLApZdWxpbgo=

