Return-Path: <linux-kernel+bounces-895397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA7C4DA70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA07189FC63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF8F358D30;
	Tue, 11 Nov 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kk9PJUD4"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098E358D17;
	Tue, 11 Nov 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863750; cv=none; b=QF2VfvYXeTO2ubQWGXBlD+SWyRI5AigLoF01WCJ+geFchv74ECNpy2YriGvehx/2ldSjlhmZeF5WvIqKONElcpHtHX0TPHKRhxkrtMUacg08exzPpqIplPMnQLILPZ6Wz734g0Hd52Qdd/C+rw+hUSawEHzRRrDrXkzLyFNZhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863750; c=relaxed/simple;
	bh=X6y6Se/nW/e277wYLxWrMYnRgi7gLDbMTLe9oGju5Js=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DX3rBSaXVVczypii53uaTljCkENt4aUxFLJHsf6v9aNCfC7JGy2N000NcSAxyYkWeEHiK6IV9peMDDz9KpAjJ9KyAev/fYLT/cba1eACUK8STwNSI/NPp4+Ti0ptf3+IS9eJvh266R2vS8f8h3jXfnZRhjog1nu2TSy0O2NhnQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kk9PJUD4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5ABCJmNG23665349, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762863588; bh=X6y6Se/nW/e277wYLxWrMYnRgi7gLDbMTLe9oGju5Js=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kk9PJUD4sih1dwCMEHJvr3Sxns4rr21JT+uRagUTsogYBOxEaTMOkTbYrA4ooK+KI
	 zuDk8qBgVv9X0c9zOXy9YXe/ATI0fXIvH9wcziShVCXget3Yx4L7MMNls/tSxwV3pP
	 a9o0iD7rKOuCzWyVxDtCifSTSRXFupuLwdC5WbEvWF9ib8qxaIVkMZJtrB03x2OXvo
	 xsjdo3seiNpdTkYvTWxOxY7OhQ6Z3Lx/OQX7HKLxZQWluocfB5xpy+PJhL/1Gu5E8k
	 1/srdQP0Nhq+D7uMc0hi8NVtv74QddHr6nmMoaL2M/2QCqWkZOHx8jItXPs5Wz8gmY
	 YZgwuJuWOI0Cg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5ABCJmNG23665349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 20:19:48 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 20:19:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 20:19:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 11 Nov 2025 20:19:48 +0800
From: =?utf-8?B?RWxlYW5vciBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "afaerber@suse.de"
	<afaerber@suse.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?=
	<james.tai@realtek.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-realtek-soc@lists.infradead.org"
	<linux-realtek-soc@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        =?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?=
	<cy.huang@realtek.com>,
        =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?=
	<stanley_chang@realtek.com>
Subject: RE: [PATCH 2/3] dt-bindings: mfd: Add Realtek ISO system controller
Thread-Topic: [PATCH 2/3] dt-bindings: mfd: Add Realtek ISO system controller
Thread-Index: AQHcTkE4z87SosdXOU61jeE3W7fMtLTjY5SAgAoKXOA=
Date: Tue, 11 Nov 2025 12:19:48 +0000
Message-ID: <06078f60af0948d19b1abae53eeec7f6@realtek.com>
References: <20251105104452.6336-1-eleanor.lin@realtek.com>
 <20251105104452.6336-3-eleanor.lin@realtek.com>
 <88d90e44-88d9-4b5c-ba76-1e27dd28f78b@kernel.org>
In-Reply-To: <88d90e44-88d9-4b5c-ba76-1e27dd28f78b@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgS3J6eXN6dG9mLA0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5IGluIHJlc3BvbmRpbmcgdG8geW91
Lg0KDQo+IE9uIDA1LzExLzIwMjUgMTE6NDQsIFl1LUNodW4gTGluIHdyb3RlOg0KPiA+IEFkZCBE
VCBiaW5kaW5nIHNjaGVtYSBmb3IgUmVhbHRlayBzeXN0ZW0gY29udHJvbGxlci4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFl1LUNodW4gTGluIDxlbGVhbm9yLmxpbkByZWFsdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL21mZC9yZWFsdGVrLGlzby1zeXN0ZW0ueWFtbCAgICAg
IHwgNjUNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNjUgaW5z
ZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWZkL3JlYWx0ZWssaXNvLXN5c3RlbS55YW1sDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3Jl
YWx0ZWssaXNvLXN5c3RlbS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWZkL3JlYWx0ZWssaXNvLXN5c3RlbS55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjZmYmRlZGQzZWU1Yg0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JlYWx0
ZWssaXNvLXN5c3RlbS55YW1sDQo+ID4gQEAgLTAsMCArMSw2NSBAQA0KPiA+ICsjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwgMS4y
DQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21mZC9y
ZWFsdGVrLGlzby1zeXN0ZW0ueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogUmVhbHRlayBJ
U08gU3lzdGVtIENvbnRyb2xsZXINCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+IA0KPiAN
Cj4gRG8gbm90IG5lZWQgJ3wnIHVubGVzcyB5b3UgbmVlZCB0byBwcmVzZXJ2ZSBmb3JtYXR0aW5n
Lg0KPiANCg0KSSB3aWxsIHJlbW92ZSBpdCBpbiBWMi4NCg0KPiA+ICsgIFRoZSBSZWFsdGVrIElT
TyBTeXN0ZW0gQ29udHJvbGxlciBpcyBhIHJlZ2lzdGVyIGFyZWEgdGhhdCBjb250YWlucw0KPiA+
ICsgbWlzY2VsbGFuZW91cyBzeXN0ZW0gcmVnaXN0ZXJzIGZvciB0aGUgU29DIGFuZCBzZXJ2ZXMg
YXMgYSBwYXJlbnQNCj4gPiArIG5vZGUgIGZvciBvdGhlciBmdW5jdGlvbnMuDQo+ID4gKw0KPiA+
ICttYWludGFpbmVyczoNCj4gPiArICAtIEphbWVzIFRhaSA8amFtZXMudGFpQHJlYWx0ZWsuY29t
Pg0KPiA+ICsgIC0gWXUtQ2h1biBMaW4gPGVsZWFub3IubGluQHJlYWx0ZWsuY29tPg0KPiA+ICsN
Cj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgaXRlbXM6DQo+
ID4gKyAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgIC0gcmVhbHRlayxpc28tc3lzdGVtDQo+
IA0KPiBObyBjbHVlIHdoYXQgaXMgImlzbyBzeXN0ZW0iLCBuZWl0aGVyIGNvbW1pdCBtc2csIG5v
ciB0aXRsZSBub3IgZGVzY3JpcHRpb24NCj4gZXhwbGFpbiBtZSB0aGF0LiBQbGVhc2UgYWRkIGZp
cnN0IGJpbmRpbmdzIGZvciB0aGUgaXNvIHNvYyBvciBpZiB0aGlzIGlzIG5vdCBzb2MsDQo+IHRo
ZW4gdXNlIG9ubHkgc29jLXNwZWNpZmljIGNvbXBhdGlibGVzIChzZWUgd3JpdGluZyBiaW5kaW5n
cyBkb2MpLg0KPiANCg0KSSB3aWxsIHJlbmFtZSAncmVhbHRlayxtaXNjJyBmb3IgY2xhcml0eS4N
Cg0KPiA+ICsgICAgICAtIGNvbnN0OiBzeXNjb24NCj4gPiArICAgICAgLSBjb25zdDogc2ltcGxl
LW1mZA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4g
PiArICByYW5nZXM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICAnI2FkZHJl
c3MtY2VsbHMnOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArDQo+ID4gKyAgJyNzaXplLWNlbGxz
JzoNCj4gPiArICAgIGNvbnN0OiAxDQo+ID4gKw0KPiA+ICsgIHJlZy1pby13aWR0aDoNCj4gPiAr
ICAgIGNvbnN0OiA0DQo+ID4gKw0KPiA+ICtwYXR0ZXJuUHJvcGVydGllczoNCj4gPiArICAiXi4q
QFswLTlhLWZdKyQiOg0KPiA+ICsgICAgdHlwZTogb2JqZWN0DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjogQ2F0Y2gtYWxsIGZvciBvdGhlciBzdWItZGV2aWNlcyBpbiB0aGUgSVNPIGFyZWEuDQo+IA0K
PiBOb3BlLCBzb3JyeS4gRGVmaW5lIGV4YWN0IGNoaWxkcmVuLiBBbGwgb2YgdGhlbS4NCj4gDQoN
CkdvdCBpdC4gSSB3aWxsIGV4cGxpY2l0bHkgZGVmaW5lIGNoaWxkIGZvciBWMi4NCg0KPiA+ICsN
Cj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiAr
ICAtIHJhbmdlcw0KPiA+ICsgIC0gJyNhZGRyZXNzLWNlbGxzJw0KPiA+ICsgIC0gJyNzaXplLWNl
bGxzJw0KPiA+ICsgIC0gcmVnLWlvLXdpZHRoDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJvcGVy
dGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAg
aXNvOiBzeXNjb25ANzAwMCB7DQo+IA0KPiBEcm9wIGxhYmVsLg0KPiANCg0KSSB3aWxsIHJlbW92
ZSBpdCBpbiBWMi4NCg0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAicmVhbHRlayxpc28tc3lz
dGVtIiwgInN5c2NvbiIsICJzaW1wbGUtbWZkIjsNCj4gPiArICAgICAgICByZWcgPSA8MHg3MDAw
IDB4MTAwMD47DQo+ID4gKyAgICAgICAgcmFuZ2VzID0gPDB4MCAweDcwMDAgMHgxMDAwPjsNCj4g
PiArICAgICAgICByZWctaW8td2lkdGggPSA8ND47DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2Vs
bHMgPSA8MT47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQo+IA0KPiBObyBjaGls
ZHJlbiBoZXJlLCBzbyBkcm9wIHNpbXBsZS1tZmQgYW5kIGFsbCB0aGVzZSBmYWtlIGNoaWxkIHN0
dWZmLg0KPg0KSSB3aWxsIHNob3cgaXRzIGNoaWxkIGluIGV4YW1wbGUgaW4gVjIuDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

