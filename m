Return-Path: <linux-kernel+bounces-830127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E2B98C85
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC702E11FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6570127E07E;
	Wed, 24 Sep 2025 08:19:06 +0000 (UTC)
Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA733D544;
	Wed, 24 Sep 2025 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701946; cv=none; b=adt1Z8E48lYqk7FynBr0eKYihE4xdVqs5KfO7ipbXNKonjky2T7p3/5Aa2K2iekkyI/o5V1m+AHazksI+OY8WNdNSbDTwz80sMcubaNorPmC2fPONnVEIrljLTXNnI7hKxtNeGVJIsw3KWODjszPq0YsnCJAZLQaFhONrWvfzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701946; c=relaxed/simple;
	bh=lZUCWci03AbglxggQWQQ4x0B8Eeqd3JY0hT4rfpA0ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=SLpu6z/pepmCInAHKzGYyIenCV8pS96K8ORdz/3snhGLe6heH97HtMAzKeEM2ut2W2K5K5Zg6S1vEa7s5eYFgTljY9+nq0TX4pPMKAt5V1z01iSPAD3RGfV1YMl+/sSHzndyoy2O82b5LJboGVaDiCHm1VygbSxJAJMMP66mBjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Wed, 24 Sep 2025 16:18:49 +0800 (GMT+08:00)
Date: Wed, 24 Sep 2025 16:18:49 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Conor Dooley" <conor@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v5 1/2] dt-bindings: clock: eswin: Documentation for
 eic7700 SoC
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20250923-popper-choice-397ce2df6966@spud>
References: <20250923084637.1223-1-dongxuyang@eswincomputing.com>
 <20250923084739.1281-1-dongxuyang@eswincomputing.com>
 <20250923-popper-choice-397ce2df6966@spud>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <78856df3.17ba.1997acdc444.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDHZpVpqdNoHNnaAA--.26233W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEPAmjSy9QU+
	QAAsG
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+IAo+ID4gQWRkIGRldmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIEVT
V0lOIGVpYzc3MDAKPiA+IGNsb2NrIGNvbnRyb2xsZXIgbW9kdWxlLgo+ID4gCj4gPiBTaWduZWQt
b2ZmLWJ5OiBZaWZlbmcgSHVhbmcgPGh1YW5neWlmZW5nQGVzd2luY29tcHV0aW5nLmNvbT4KPiA+
IFNpZ25lZC1vZmYtYnk6IFh1eWFuZyBEb25nIDxkb25neHV5YW5nQGVzd2luY29tcHV0aW5nLmNv
bT4KPiA+IC0tLQo+ID4gIC4uLi9iaW5kaW5ncy9jbG9jay9lc3dpbixlaWM3NzAwLWNsb2NrLnlh
bWwgICB8ICA0MCArKwo+ID4gIC4uLi9kdC1iaW5kaW5ncy9jbG9jay9lc3dpbixlaWM3NzAwLWNs
b2NrLmggICB8IDM3OSArKysrKysrKysrKysrKysrKysKPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQx
OSBpbnNlcnRpb25zKCspCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9jbG9jay9lc3dpbixlaWM3NzAwLWNsb2NrLnlhbWwKPiA+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9lc3dpbixlaWM3NzAwLWNs
b2NrLmgKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9jbG9jay9lc3dpbixlaWM3NzAwLWNsb2NrLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvY2xvY2svZXN3aW4sZWljNzcwMC1jbG9jay55YW1sCj4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NAo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi40OTA1MzU0M2VjZmUKPiA+IC0t
LSAvZGV2L251bGwKPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9j
bG9jay9lc3dpbixlaWM3NzAwLWNsb2NrLnlhbWwKPiA+IEBAIC0wLDAgKzEsNDAgQEAKPiA+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkK
PiA+ICslWUFNTCAxLjIKPiA+ICstLS0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9z
Y2hlbWFzL2Nsb2NrL2Vzd2luLGVpYzc3MDAtY2xvY2sueWFtbCMKPiA+ICskc2NoZW1hOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMKPiA+ICsKPiA+ICt0aXRs
ZTogRXN3aW4gRUlDNzcwMCBTb0MgY2xvY2sgY29udHJvbGxlcgo+ID4gKwo+ID4gK21haW50YWlu
ZXJzOgo+ID4gKyAgLSBZaWZlbmcgSHVhbmcgPGh1YW5neWlmZW5nQGVzd2luY29tcHV0aW5nLmNv
bT4KPiA+ICsgIC0gWHV5YW5nIERvbmcgPGRvbmd4dXlhbmdAZXN3aW5jb21wdXRpbmcuY29tPgo+
ID4gKwo+ID4gK2Rlc2NyaXB0aW9uOgo+ID4gKyAgVGhlIGNsb2NrIGNvbnRyb2xsZXIgZ2VuZXJh
dGVzIGFuZCBzdXBwbGllcyBjbG9jayB0byBhbGwgdGhlIG1vZHVsZXMKPiA+ICsgIGZvciBlaWM3
NzAwIFNvQy4KPiA+ICsKPiA+ICtwcm9wZXJ0aWVzOgo+ID4gKyAgY29tcGF0aWJsZToKPiA+ICsg
ICAgY29uc3Q6IGVzd2luLGVpYzc3MDAtY2xvY2sKPiA+ICsKPiA+ICsgIHJlZzoKPiA+ICsgICAg
bWF4SXRlbXM6IDEKPiA+ICsKPiA+ICsgICcjY2xvY2stY2VsbHMnOgo+ID4gKyAgICBjb25zdDog
MQo+ID4gKwo+ID4gK3JlcXVpcmVkOgo+ID4gKyAgLSBjb21wYXRpYmxlCj4gPiArICAtIHJlZwo+
ID4gKyAgLSAnI2Nsb2NrLWNlbGxzJwo+ID4gKwo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBm
YWxzZQo+ID4gKwo+ID4gK2V4YW1wbGVzOgo+ID4gKyAgLSB8Cj4gPiArICAgIGNsb2NrLWNvbnRy
b2xsZXJANTE4MjgwMDAgewo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJlc3dpbixlaWM3NzAw
LWNsb2NrIjsKPiA+ICsgICAgICAgIHJlZyA9IDwweDUxODI4MDAwIDB4MjAwPjsKPiA+ICsgICAg
ICAgICNjbG9jay1jZWxscyA9IDwxPjsKPiA+ICsgICAgfTsKPiAKPiBObyBjbG9jayBpbnB1dCB0
byB0aGlzIGJsb2NrPyBTdXJwcmlzZWQgdGhlcmUncyBub3Qgc29tZSBvZmYtY2hpcAo+IG9zY2ls
bGF0b3IgdGhhdCBwcm92aWRlcyBhIHF1YWxpdHkgcmVmZXJlbmNlIGZvciB0aGUgaW50ZXJuYWwg
UExMcyBldGMuCgpUaGVyZSBpcyBhbiBvc2NpbGxhdG9yIGFzIHRoZSBjbG9jayBpbnB1dC4gVGhl
IGZyZXF1ZW5jeSBpcyAyNDAwMDAwMCBIeiwgYW5kCnRoZSBjbG9jayBuYW1lIGlzICJ4dGFsIi4g
CldlIHdpbGwgdXBkYXRlIHRoZSBmb2xsb3dpbmcgZGVzY3JpcHRpb24gaW4gdGhlIG5leHQgcGF0
Y2guCgpwcm9wZXJ0aWVzOgrCoCBjb21wYXRpYmxlOgrCoCDCoCBjb25zdDogZXN3aW4sZWljNzcw
MC1jbG9jawoKwqAgcmVnOgrCoCDCoCBtYXhJdGVtczogMQoJCsKgIGNsb2NrczoKwqAgwqAgaXRl
bXM6CiAgICAgIC0gZGVzY3JpcHRpb246IEV4dGVybmFsIDI0TUh6IG9zY2lsbGF0b3IgY2xvY2sK
CsKgIGNsb2NrLW5hbWVzOgrCoCDCoCBpdGVtczoKICAgICAgLSBjb25zdDogeHRhbAoJwqDCoArC
oCAnI2Nsb2NrLWNlbGxzJzoKwqAgwqAgY29uc3Q6IDEKCnJlcXVpcmVkOgrCoCAtIGNvbXBhdGli
bGUKwqAgLSByZWcKwqAgLSBjbG9ja3MKwqAgLSBjbG9jay1uYW1lcwrCoCAtICcjY2xvY2stY2Vs
bHMnCgphZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UKCmV4YW1wbGVzOgrCoCAtIHwKwqAgwqAg
Y2xvY2stY29udHJvbGxlckA1MTgyODAwMCB7CsKgIMKgIMKgIMKgIGNvbXBhdGlibGUgPSAiZXN3
aW4sZWljNzcwMC1jbG9jayI7CsKgIMKgIMKgIMKgIHJlZyA9IDwweDUxODI4MDAwIDB4MjAwPjsK
wqAgwqAgwqAgwqAgY2xvY2tzID0gPCZ4dGFsPjsKwqAgwqAgwqAgwqAgY2xvY2stbmFtZXMgPSAi
eHRhbCI7CsKgIMKgIMKgIMKgICNjbG9jay1jZWxscyA9IDwxPjsKwqAgwqAgfTsKCgpwcm9wZXJ0
aWVzOgrCoCBjb21wYXRpYmxlOgrCoCDCoCBjb25zdDogZXN3aW4sZWljNzcwMC1jbG9jawoKwqAg
cmVnOgrCoCDCoCBtYXhJdGVtczogMQoJCsKgIGNsb2NrczoKwqAgwqAgaXRlbXM6CiAgICAgIC0g
ZGVzY3JpcHRpb246IEV4dGVybmFsIDI0TUh6IG9zY2lsbGF0b3IgY2xvY2sKCsKgIGNsb2NrLW5h
bWVzOgrCoCDCoCBpdGVtczoKICAgICAgLSBjb25zdDogeHRhbAoJwqDCoArCoCAnI2Nsb2NrLWNl
bGxzJzoKwqAgwqAgY29uc3Q6IDEKCnJlcXVpcmVkOgrCoCAtIGNvbXBhdGlibGUKwqAgLSByZWcK
wqAgLSBjbG9ja3MKwqAgLSBjbG9jay1uYW1lcwrCoCAtICcjY2xvY2stY2VsbHMnCgphZGRpdGlv
bmFsUHJvcGVydGllczogZmFsc2U=

