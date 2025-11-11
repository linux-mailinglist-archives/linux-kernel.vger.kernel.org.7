Return-Path: <linux-kernel+bounces-895436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8710C4DE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8BB188E482
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16D736DD02;
	Tue, 11 Nov 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NhdUWAUN"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213236C5AD;
	Tue, 11 Nov 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864199; cv=none; b=Sb0hw5OU4aNXK0AsMcDwo563ju5pPuJN6Z13TokzYELcpw4WiLNiY8anK+cSejvOaW1ZWasYPRhIvPrY3yTkpI7lsjUiBIBoa75LrmneWz2ZM5EGgCroKBuaMbdQDgLlY4JS7rvlmUgxplxrUCJz0F4gBx8VL0qtlUSnYnfxQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864199; c=relaxed/simple;
	bh=2Cb4RJIiwrA0iwYFhQSYgZYtQeR56U1POeoVXbD5MMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oIuHYrZEjhHLnMFn2xZf6WQfNjoLnfpEcozBHmc3t057gr1sjtPCep/FZW+3/1oQDlQQszR65XrmtiMkLro/jdW/ktoKr7Jv5IZdUNmcax79SHhq/IfCvlv4Z8PNohLgMdSWozmzOxcBCFF0xbxpOW6b94wNDChVHY4+VjDHAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NhdUWAUN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5ABCTfFM23673138, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762864181; bh=2Cb4RJIiwrA0iwYFhQSYgZYtQeR56U1POeoVXbD5MMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NhdUWAUNZgAtYz+113ppNRXfiVUbMVmbs+vAh5XFHNy/An8MOQABBhYLLn06UwMYB
	 l13wqYAnklRSk14lYStXo3DX62TOEBC+8i3jy+iY/ImmbX0gHa1C/Zoa4ZZDuwZs3f
	 IS8Q3GXwlUoqaD2YvndgdW8rpb37EOB+5AUqSOen28NvOKFARUpaBldvfe3sH+hXuy
	 7pnRQA3mN34VNmCuTtZmWvI0sRa0iaDNJ/esRaPaaq5USRtPDUN66MDiVqxM0Y8LkW
	 FZ9C/DQCNu1T1ED11sY29xXg+B+TOvuDa1sBZhmik+UiAk/cWju8BrNZtKbMIYei9I
	 RJ2a0Xwb0FsMQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5ABCTfFM23673138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 20:29:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 20:29:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 20:29:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 11 Nov 2025 20:29:41 +0800
From: =?utf-8?B?RWxlYW5vciBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        =?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
        "afaerber@suse.de" <afaerber@suse.de>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        "linux-realtek-soc@lists.infradead.org"
	<linux-realtek-soc@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= <stanley_chang@realtek.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee@kernel.org" <lee@kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: mfd: Add Realtek ISO system controller
Thread-Topic: [PATCH 2/3] dt-bindings: mfd: Add Realtek ISO system controller
Thread-Index: AQHcTkE4z87SosdXOU61jeE3W7fMtLTjfWCAgAnzAoA=
Date: Tue, 11 Nov 2025 12:29:41 +0000
Message-ID: <c699f2878357435180348cae59092792@realtek.com>
References: <20251105104452.6336-1-eleanor.lin@realtek.com>
 <20251105104452.6336-3-eleanor.lin@realtek.com>
 <176234584170.562648.2189277623860888038.robh@kernel.org>
In-Reply-To: <176234584170.562648.2189277623860888038.robh@kernel.org>
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

PiANCj4gT24gV2VkLCAwNSBOb3YgMjAyNSAxODo0NDo1MSArMDgwMCwgWXUtQ2h1biBMaW4gd3Jv
dGU6DQo+ID4gQWRkIERUIGJpbmRpbmcgc2NoZW1hIGZvciBSZWFsdGVrIHN5c3RlbSBjb250cm9s
bGVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWXUtQ2h1biBMaW4gPGVsZWFub3IubGluQHJl
YWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvbWZkL3JlYWx0ZWssaXNvLXN5
c3RlbS55YW1sICAgICAgfCA2NQ0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvcmVhbHRlayxpc28tc3lzdGVtLnlh
bWwNCj4gPg0KPiANCj4gTXkgYm90IGZvdW5kIGVycm9ycyBydW5uaW5nICdtYWtlIGR0X2JpbmRp
bmdfY2hlY2snIG9uIHlvdXIgcGF0Y2g6DQo+IA0KPiB5YW1sbGludCB3YXJuaW5ncy9lcnJvcnM6
DQo+IC4vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnlhbWw6
NzY6MTogW3dhcm5pbmddIHRvbw0KPiBtYW55IGJsYW5rIGxpbmVzICgyID4gMSkgKGVtcHR5LWxp
bmVzKQ0KPiANCj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoNCj4gDQo+IGRvYyByZWZl
cmVuY2UgZXJyb3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQo+IA0KPiBTZWUNCj4gaHR0cHM6Ly9w
YXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2RldmljZXRyZWUtYmluZGluZ3MvcGF0Y2gvMjAy
NTExMDUxMDQ0DQo+IDUyLjYzMzYtMy1lbGVhbm9yLmxpbkByZWFsdGVrLmNvbQ0KPiANCj4gVGhl
IGJhc2UgZm9yIHRoZSBzZXJpZXMgaXMgZ2VuZXJhbGx5IHRoZSBsYXRlc3QgcmMxLiBBIGRpZmZl
cmVudCBkZXBlbmRlbmN5DQo+IHNob3VsZCBiZSBub3RlZCBpbiAqdGhpcyogcGF0Y2guDQo+IA0K
PiBJZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGRpZG4ndCBz
ZWUgdGhlIGFib3ZlIGVycm9yKHMpLA0KPiB0aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQnIGlzIGlu
c3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+IGRhdGU6DQo+IA0KPiBwaXAzIGluc3Rh
bGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1Ym1pdCBh
ZnRlciBydW5uaW5nIHRoZSBhYm92ZSBjb21tYW5kIHlvdXJzZWxmLiBOb3RlDQo+IHRoYXQgRFRf
U0NIRU1BX0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91ciBzY2hlbWEgZmlsZSB0byBzcGVlZCB1cCBj
aGVja2luZw0KPiB5b3VyIHNjaGVtYS4gSG93ZXZlciwgaXQgbXVzdCBiZSB1bnNldCB0byB0ZXN0
IGFsbCBleGFtcGxlcyB3aXRoIHlvdXIgc2NoZW1hLg0KDQpUaGFua3MuIEkgd2lsbCBmaXggaXQg
aW4gdjIuDQo=

