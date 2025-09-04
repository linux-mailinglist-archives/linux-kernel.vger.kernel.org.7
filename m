Return-Path: <linux-kernel+bounces-800802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A90B43C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CAE1C83D58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02186301475;
	Thu,  4 Sep 2025 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carnegierobotics.com header.i=@carnegierobotics.com header.b="Qv4o4dc3"
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE730101D;
	Thu,  4 Sep 2025 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990706; cv=none; b=ZuElepzVS0GrEmPnxlIhnQOAGzYroBWj/zh213q2pmutSvctTkM8P8sIOxNJnCzrGLUNd+vj6WpttB+NJESxFt+gcOuygP31H6s9vdw4AV3L232enDpNA3vQJYS/dpKmG0TB2ts2Qwlf06ME8NeJcmlNq8KkL3rWt68vZRgf/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990706; c=relaxed/simple;
	bh=Ck2sMaL7jXVOM/UOlPZGnZtM7ZcAIhw8oikg7wa0v7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oz1FTYmOszcycKsRkt1RAl+AkeD4Z/B9TBoxWaSEm+3kr+SCdp9M9UUlz+Ql1LhFmA96NXQHGq+rislx5haO3f0lVOAcz9s5YL862XPqNE0THa19flaXVmGzgEhe7lAfnVro//5XPx+mkNgOoaI5DJgw35cwtdIBjqOSP/3SeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=carnegierobotics.com; spf=pass smtp.mailfrom=carnegierobotics.com; dkim=pass (2048-bit key) header.d=carnegierobotics.com header.i=@carnegierobotics.com header.b=Qv4o4dc3; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=carnegierobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carnegierobotics.com
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cHffk5Lj6z2K8Wf4;
	Thu,  4 Sep 2025 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	carnegierobotics.com; h=mime-version:content-transfer-encoding
	:content-id:content-type:content-type:user-agent
	:content-language:accept-language:in-reply-to:references
	:message-id:date:date:subject:subject:from:from:received
	:received:received:received; s=mr01; t=1756990698; x=1759582699;
	 bh=Ck2sMaL7jXVOM/UOlPZGnZtM7ZcAIhw8oikg7wa0v7o=; b=Qv4o4dc3qj9A
	onBrp03a8Ia9lzwZM8ElskqPWWEg9YPyQMCztR3vTfY11HOmKNo2/F6Lthi8R1wu
	nILcIC+aBSwU2t6DHoMkZVOfDZj6Xioi8Wr2kCnTcBI+spZzS9g1Mx3FWTQSCpSz
	5CLmntR56HU13JfIOIdL0t+YhfJtuENSzelUVSRqrK0/zurRAZ/JfHRwZeo8+sKV
	1oKbuhHtIrmiXnEDRHzk37JN9fzGhq4gbXWUVCwPF6XloX9a3AsSXK5onRGcNqF3
	sM5L+hIqbWp9/FGKkxQOOK2WO7GHR0HuSw6h1U4GueY1+sReuw3kgD2YYeHhzDf5
	xRe+2O2iYg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10026) with LMTP
 id ORTsxFOqmSJh; Thu,  4 Sep 2025 12:58:18 +0000 (UTC)
Received: from mail.carnegierobotics.com (static-108-39-229-99.pitbpa.fios.verizon.net [108.39.229.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by 003.mia.mailroute.net (Postfix) with ESMTPS id 4cHffS3DpKz2K8Wdn;
	Thu,  4 Sep 2025 12:58:06 +0000 (UTC)
Received: from CRL-PGH-EX19-1.crl.local (10.1.7.176) by
 CRL-PGH-EX19-1.crl.local (10.1.7.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Thu, 4 Sep 2025 08:58:05 -0400
Received: from CRL-PGH-EX19-1.crl.local ([fe80::81d6:ea84:15d9:67d4]) by
 CRL-PGH-EX19-1.crl.local ([fe80::81d6:ea84:15d9:67d4%7]) with mapi id
 15.02.1544.033; Thu, 4 Sep 2025 08:58:05 -0400
From: Woody Douglass <wdouglass@carnegierobotics.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] regulator: pf530x: dt-bindings:
 nxp,pf530x-regulator
Thread-Topic: [PATCH v4 2/2] regulator: pf530x: dt-bindings:
 nxp,pf530x-regulator
Thread-Index: AQHcHV8L/sKRG5bBkUuX5B13FZSQTrSDP2uA
Date: Thu, 4 Sep 2025 12:58:05 +0000
Message-ID: <45ab7df9-f547-47c8-817d-c3f7be600300@carnegierobotics.com>
References: <20250902-pf530x-v4-0-4727f112424e@carnegierobotics.com>
 <20250902-pf530x-v4-2-4727f112424e@carnegierobotics.com>
 <997eb50b-db3e-4c0e-be29-0d04fef73ccf@kernel.org>
In-Reply-To: <997eb50b-db3e-4c0e-be29-0d04fef73ccf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
Content-Type: text/plain; charset="utf-8"
Content-ID: <8796B327954D634FA6F9F770B9399DD6@crl.local>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gOS80LzI1IDAxOjQ0LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAwMy8wOS8y
MDI1IDIyOjAzLCBXb29kcm93IERvdWdsYXNzIHdyb3RlOg0KPj4gQmluZGluZ3MgZm9yIHRoZSBw
ZjUzMHggc2VyaWVzIG9mIHZvbHRhZ2UgcmVndWxhdG9ycw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IFdvb2Ryb3cgRG91Z2xhc3MgPHdkb3VnbGFzc0BjYXJuZWdpZXJvYm90aWNzLmNvbT4NCj4+IC0t
LQ0KPj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9ueHAscGY1MzAwLnlhbWwg
IHwgNTIgKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNl
cnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9yZWd1bGF0b3IvbnhwLHBmNTMwMC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9ueHAscGY1MzAwLnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjI2Y2JhMWYxYWY2Mg0KPj4gLS0tIC9kZXYv
bnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRv
ci9ueHAscGY1MzAwLnlhbWwNCj4+IEBAIC0wLDAgKzEsNTIgQEANCj4+ICsjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFNTCAx
LjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3JlZ3Vs
YXRvci9ueHAscGY1MzB4LXJlZ3VsYXRvci55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBOWFAg
UEY1MzAwL1BGNTMwMS9QRjUzMDIgUE1JQyByZWd1bGF0b3JzDQo+PiArDQo+PiArbWFpbnRhaW5l
cnM6DQo+PiArICAtIFdvb2Ryb3cgRG91Z2xhc3MgPHdkb3VnbGFzc0BjYXJuZWdpZXJvYm90aWNz
LmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjogfA0KPj4gKyAgVGhlIFBGNTMwMCwgUEY1MzAx
LCBhbmQgUEY1MzAyIGludGVncmF0ZSBoaWdoLXBlcmZvcm1hbmNlIGJ1Y2sgY29udmVydGVycywN
Cj4+ICsgIDEyIEEsIDggQSwgYW5kIDE1IEEsIHJlc3BlY3RpdmVseSwgdG8gcG93ZXIgaGlnaC1l
bmQgYXV0b21vdGl2ZSBhbmQgaW5kdXN0cmlhbA0KPj4gKyAgcHJvY2Vzc29ycy4gV2l0aCBhZGFw
dGl2ZSB2b2x0YWdlIHBvc2l0aW9uaW5nIGFuZCBhIGhpZ2gtYmFuZHdpZHRoIGxvb3AsIHRoZXkN
Cj4+ICsgIG9mZmVyIHRyYW5zaWVudCByZWd1bGF0aW9uIHRvIG1pbmltaXplIGNhcGFjaXRvciBy
ZXF1aXJlbWVudHMuDQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+
PiArICAgIGVudW06DQo+PiArICAgICAgLSBueHAscGY1MzAwDQo+PiArICAgICAgLSBueHAscGY1
MzAxDQo+PiArICAgICAgLSBueHAscGY1MzAyDQo+IA0KPiBTdGlsbCBjb21wYXRpYmlsaXR5IG5v
dCBleHByZXNzZWQuDQo+IA0KDQpJJ20gc29ycnkgZm9yIHRoZSBtaXN1bmRlcnN0YW5kaW5nIGhl
cmUgLS0gSSBkaWQgcmVwbHkgKGFzIE1hcmsgQnJvd24gbWVudGlvbmVkIGluIGhpcw0KcmVwbHkg
dG8gdGhpcyBlbWFpbCkgaW4gdGhlIGNvdmVyIGxldHRlciBmb3IgdjMgb2YgdGhpcyBwYXRjaCAo
dGhpcyBtZXNzYWdlIA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI1MDkwMi1wZjUz
MHgtdjMtMC00MjQyZTc2ODc3NjFAY2FybmVnaWVyb2JvdGljcy5jb20vKS4NCk1hcmsgaXMgcmln
aHQsIEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgd2hhdCB5b3UncmUgYXNraW5nIGZvciwgYW5k
IG90aGVyIGJpbmRpbmdzIGZvciANCnJlZ3VsYXRvcnMgc2VlbSB0byBsaXN0IG9mZiBlYWNoIGNv
bXBhdGlibGUgbW9kZWwgaW4gdGhlIHdheSB0aGF0IEkgaGF2ZS4gSSBoYXZlIHByZXBhcmVkDQph
IHY1IG9mIHRoaXMgcGF0Y2hzZXQgdGhhdCBpbmNvcnBvcmF0ZXMgdGhlIHZhcmlvdXMgY29tbWVu
dHMsIGJ1dCBJJ2xsIHdhaXQgZm9yIHNvbWUNCmNsYXJpZmljYXRpb24gaGVyZSBiZWZvcmUgc3Vi
bWl0dGluZyBpdC4NCg0KPiBQbGVhc2UgcmVzcG9uZCB0byBjb21tZW50cy4NCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQpUaGFua3MsDQpXb29kcm93IERvdWdsYXNzDQo=

