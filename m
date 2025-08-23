Return-Path: <linux-kernel+bounces-783088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8787B32939
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973721BC2613
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0B625CC73;
	Sat, 23 Aug 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="CNCTRXRe"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9431DF97F;
	Sat, 23 Aug 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959858; cv=pass; b=t8tqjk2uVcG0VuZWSo8LhP8UZwvz9jMU2V6DYAIQRnnSkZQC3S0K0K5c4ooXDqKLOLUgf1hR5TqbcGUJaA1B4AA50lXEMM9sxnY2g99Uiy9ypWYgKOqKotiZvsLx8ukwDCZlJsn7Mq2Uj1QDEm7/olN1Zfa1sjBJX76JSxZObaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959858; c=relaxed/simple;
	bh=w5+3Wj7vfPQ8crCgywXDIjFpd5kHVU1zcCL+s+Zd5yA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNaoJeTiBsUvnEjg/E30QHvxrj0euji10iyt+NVXXUy/tlQK3uO3Cy2dnOv9wgCg/Gv2La0nAb1keJL0A6T1V3/FyZ9cPpA24WRQiDE1mmQy0vQYUHHHBinQfL7BHVCYqvgEv8Y4RfFNwj0tNujX0jSUXwphKDPLHMVdS1HSsz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=CNCTRXRe; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755959843; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i0gQp/bDFy9ZbVk4fLw3HLIa/f1GAQblOIedxJHhzUYGSCwuTkJvdY0wHjU21o0+og+XSqjtg3yYfKKap4WQzoWhTWXDEWrrVnVlBeSl9G1wubied71Ihhe+pCDnkfBFJo0U/WBrLh5DfsNi5y0CK+rhiE+gLHmgMBiU6tpZhaA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755959843; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w5+3Wj7vfPQ8crCgywXDIjFpd5kHVU1zcCL+s+Zd5yA=; 
	b=kBXB1g5C0ziF+S7ZfMaRqyDuwu379zZefxwotIZ1GP1UxgoFRpIV8kxoCscYEauQ/RMYDXeq9AXY1/qRqCqY5ufnszn4KfSl0zNUzNyD10dR5peGSjWLLQuYYt6DoS0AEbC8Hd7co3iZEliQOIrT74oi7TX/fpgP2X6pwNDiDR0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755959843;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=w5+3Wj7vfPQ8crCgywXDIjFpd5kHVU1zcCL+s+Zd5yA=;
	b=CNCTRXReAmkhoAUkpWYsBs4Cz0aIfjUPGIW85mAOd+QZLGoisIHsQKqvj2WQobPy
	NSxx54VcBo1e5tZWkf7KSF4PFIAEWqscylWk8Z3esZHmo+wY3QRtT6e05R6byNIgL8q
	oKBBsdiD7qCIRoSE1eM2gyYPH7exGKWFMo4X84MiGR4RtU7S7T9xDTGxsfNHLqliKgW
	GOPjocYyzPS6FhX8/Ks5g5lhekpbyzHjJ6TOEKNq9myNpjpgXtTa+bc9rHEGcdg60bL
	kahhwhWeHFslp8cbPZi7hMjxyLO0tWHW91TZWDdz+q95w/kw75TYsap+Dmx4SLaKWWx
	0/v+IRh9rg==
Received: by mx.zohomail.com with SMTPS id 1755959840626388.09144913566183;
	Sat, 23 Aug 2025 07:37:20 -0700 (PDT)
Message-ID: <6ac480db63aff3c59603db16e00b9c7b6580b663.camel@icenowy.me>
Subject: Re: [PATCH 1/3] riscv: dts: thead: th1520: add coefficients to the
 PVT node
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Han Gao <rabenda.cn@gmail.com>, Yao Zi
 <ziyao@disroot.org>,  linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Sat, 23 Aug 2025 22:37:13 +0800
In-Reply-To: <aKjhOuqlQyuLCVEK@x1>
References: <20250816093209.2600355-1-uwu@icenowy.me>
	 <20250816093209.2600355-2-uwu@icenowy.me> <aKjhOuqlQyuLCVEK@x1>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

5ZyoIDIwMjUtMDgtMjLmmJ/mnJ/kupTnmoQgMTQ6MjkgLTA3MDDvvIxEcmV3IEZ1c3Rpbmnlhpnp
gZPvvJoKPiBPbiBTYXQsIEF1ZyAxNiwgMjAyNSBhdCAwNTozMjowN1BNICswODAwLCBJY2Vub3d5
IFpoZW5nIHdyb3RlOgo+ID4gVGhlIG1hbnVhbCBvZiBUSDE1MjAgY29udGFpbnMgYSBzZXQgb2Yg
Y29lZmZpY2llbnRzIGEgbGl0dGxlCj4gPiBkaWZmZXJlbnQKPiA+IHRvIHRoZSBkcml2ZXIgZGVm
YXVsdCBvbmVzLgo+ID4gCj4gPiBBZGQgdGhlbSB0byB0aGUgZGV2aWNlIHRyZWUgbm9kZSBvZiBQ
VlQuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEljZW5vd3kgWmhlbmcgPHV3dUBpY2Vub3d5Lm1l
Pgo+ID4gLS0tCj4gPiDCoGFyY2gvcmlzY3YvYm9vdC9kdHMvdGhlYWQvdGgxNTIwLmR0c2kgfCA0
ICsrKysKPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy90aGVhZC90aDE1MjAuZHRzaQo+ID4gYi9hcmNo
L3Jpc2N2L2Jvb3QvZHRzL3RoZWFkL3RoMTUyMC5kdHNpCj4gPiBpbmRleCAwM2YxZDczMTkwNDk5
Li5lOWM4MWJkYWJlZDhhIDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy90aGVh
ZC90aDE1MjAuZHRzaQo+ID4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy90aGVhZC90aDE1MjAu
ZHRzaQo+ID4gQEAgLTY3Niw2ICs2NzYsMTAgQEAgcHZ0OiBwdnRAZmZmZmY0ZTAwMCB7Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWctbmFtZXMg
PSAiY29tbW9uIiwgInRzIiwgInBkIiwgInZtIjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrcyA9IDwmYW9uc3lzX2Nsaz47Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjdGhlcm1hbC1zZW5z
b3ItY2VsbHMgPSA8MT47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoG1vb3J0ZWMsdHMtY29lZmYtZyA9IDw0Mjc0MD47Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1vb3J0ZWMsdHMtY29lZmYtaCA9IDwy
MjA1MDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBtb29ydGVjLHRzLWNvZWZmLWogPSA8KC0xNjApPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9vcnRlYyx0cy1jb2VmZi1jYWw1ID0gPDQwOTQ+
Owo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gwqAKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ3Bpb0BmZmZmZjUyMDAwIHsKPiA+IC0tIAo+ID4g
Mi41MC4xCj4gPiAKPiAKPiBJIHRoaW5rIG1vb3J0ZWMsdHMtY29lZmYtWFhYIHdpbGwgbmVlZCB0
byBiZSByb3VuZGVkIHRvIG5lYXJlc3QKPiBtdWx0aXBsZQo+IG9mIDEwMCBhcyBkdGJzX2NoZWNr
IHdhcm5zIHRoYXQ6Cj4gCj4gcHZ0QGZmZmZmNGUwMDA6IG1vb3J0ZWMsdHMtY29lZmYtZzogNDI3
NDAgaXMgbm90IGEgbXVsdGlwbGUgb2YgMTAwCj4gwqDCoMKgwqDCoMKgwqDCoGZyb20gc2NoZW1h
ICRpZDoKPiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9od21vbi9tb29ydGVjLG1yNzUy
MDMueWFtbCMKPiBwdnRAZmZmZmY0ZTAwMDogbW9vcnRlYyx0cy1jb2VmZi1qOiAtMTYwIGlzIG5v
dCBhIG11bHRpcGxlIG9mIDEwMAo+IMKgwqDCoMKgwqDCoMKgwqBmcm9tIHNjaGVtYSAkaWQ6Cj4g
aHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaHdtb24vbW9vcnRlYyxtcjc1MjAzLnlhbWwj
Cj4gcHZ0QGZmZmZmNGUwMDA6IG1vb3J0ZWMsdHMtY29lZmYtZzogNDI3NDAgaXMgbm90IGEgbXVs
dGlwbGUgb2YgMTAwCj4gwqDCoMKgwqDCoMKgwqDCoGZyb20gc2NoZW1hICRpZDoKPiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9od21vbi9tb29ydGVjLG1yNzUyMDMueWFtbCMKPiBwdnRA
ZmZmZmY0ZTAwMDogbW9vcnRlYyx0cy1jb2VmZi1qOiAtMTYwIGlzIG5vdCBhIG11bHRpcGxlIG9m
IDEwMAo+IMKgwqDCoMKgwqDCoMKgwqBmcm9tIHNjaGVtYSAkaWQ6Cj4gaHR0cDovL2RldmljZXRy
ZWUub3JnL3NjaGVtYXMvaHdtb24vbW9vcnRlYyxtcjc1MjAzLnlhbWwjCgpUaGVuIGl0IGxvb2tz
IGxpa2UgdGhlIGJpbmRpbmcgaXMgdG8gYmUgYmxhbWVkIGZvciBub3QgYWxsb3dpbmcgZmluZQp0
d2Vhay4KCj4gCj4gVGhhbmtzLAo+IERyZXcKCg==


