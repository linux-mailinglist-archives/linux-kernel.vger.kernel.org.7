Return-Path: <linux-kernel+bounces-737566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF0DB0ADEF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 06:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1477AC574
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 04:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A405218E96;
	Sat, 19 Jul 2025 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mzo0ccQd"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586372636;
	Sat, 19 Jul 2025 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752899412; cv=none; b=XscnhB8cB0pMpToGEToY7+EVaYSGPE1DmXkz8Gm1dcFapOusX65TOC17zJfxhyDxJMJdQ/a+0KWNBQMNk+aW8vuO19frjhE/0YUY4o5YiNKDIeDp+cWq0pyquc7n8JX24aBoVV1f/7Sm1kQxbaa/DypSQB19oSrV17xyTq4sylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752899412; c=relaxed/simple;
	bh=oi8FGO1psOx81HUBIRS3QyXQ1ErFNE8ttxyum62km0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VfjKSBbmJJym1ErbWrOl1V++mHHi89VJ7q7+9KXcz+mBKbQMkIAncOtgGVy96dEICHOIUxNFhHJo9Xk2T0bylvHKdFhx+HDlXlT6pL7dTIBS3AQnTpdttm/SZZB7jBWDCVz1Dc5DnAMDGaz/Fz9LpsiLslAS4FvwO4It/aw5vpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mzo0ccQd; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56J4TrFh843181;
	Fri, 18 Jul 2025 23:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752899393;
	bh=oi8FGO1psOx81HUBIRS3QyXQ1ErFNE8ttxyum62km0A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=Mzo0ccQdnrgFWRTnbVSHEuLfw97XBY3/aGE4slT6KqEe9sR3rxHMPAs46RR/8XEbu
	 A4gqM0nalFznqHX8VH1ovGIlKxnsSBqhpvXgJ5NXxDlOZIY1MVT+zUhTagkFI1yPWE
	 I8y1JrZPKo5wy2ki7hMKfWyWAqwoaOaZ5zkGLCio=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56J4TqF22837956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 18 Jul 2025 23:29:52 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 18
 Jul 2025 23:29:52 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.055; Fri, 18 Jul 2025 23:29:52 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Ding, Shenghao"
	<shenghao-ding@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "Hampiholi, Vallabha"
	<v-hampiholi@ti.com>,
        "P O, Vijeth" <v-po@ti.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ALSA: hda: Add TAS2770 support
Thread-Topic: [EXTERNAL] Re: [PATCH v1] ALSA: hda: Add TAS2770 support
Thread-Index: AQHb98ixOJRCWPnlVkCBFp4TVnPJVrQ4I18AgAC32RA=
Date: Sat, 19 Jul 2025 04:29:52 +0000
Message-ID: <26bbebb22e0046bcb154dcfd5c7094e9@ti.com>
References: <20250718094454.26574-1-baojun.xu@ti.com>,<87ms917kdl.wl-tiwai@suse.de>
In-Reply-To: <87ms917kdl.wl-tiwai@suse.de>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBGcm9tOiBU
YWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+DQo+IFNlbnQ6IDE4IEp1bHkgMjAyNSAyMDoyOQ0K
PiBUbzogWHUsIEJhb2p1bg0KPiBDYzogYnJvb25pZUBrZXJuZWwub3JnOyBhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb207IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgRGluZywg
U2hlbmdoYW87IE5hdmFkYSBLYW55YW5hLCBNdWt1bmQ7IDEzOTE2Mjc1MjA2QDEzOS5jb207IEhh
bXBpaG9saSwgVmFsbGFiaGE7IFAgTywgVmlqZXRoOyBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBS
ZTogW1BBVENIIHYxXSBBTFNBOiBoZGE6IEFkZCBUQVMyNzcwIHN1cHBvcnQNCj4gDQo+IE9uIEZy
aSwgMTggSnVsIDIwMjUgMTE64oCKNDQ64oCKNTQgKzAyMDAsIEJhb2p1biBYdSB3cm90ZTogDQo+
IA0KPiBBZGQgVEFTMjc3MCBzdXBwb3J0IGluIFRJJ3MgSERBIGRyaXZlci4gDQo+IEFuZCBhZGQg
aGRhX2NoaXBfaWQgZm9yIG1vcmUgcHJvZHVjdCBzdXBwb3J0IGluIHRoZSBmdXR1cmUuIA0KPiBT
ZXBhcmF0ZWQgRFNQIGFuZCBub24tRFNQIGluIGZpcm13YXJlIGxvYWQgZnVuY3Rpb24uIA0KPiAN
Cj4gU2lnbmVkLW9mZi1ieToNCj4gWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0DQo+IFRoaXMgbWVz
c2FnZSB3YXMgc2VudCBmcm9tIG91dHNpZGUgb2YgVGV4YXMgSW5zdHJ1bWVudHMuDQo+IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRo
ZSBzb3VyY2Ugb2YgdGhpcyBlbWFpbCBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiA8
aHR0cHM6Ly91cy1waGlzaGFsYXJtLWV3dC5wcm9vZnBvaW50LmNvbS9FV1QvdjEvRzN2SyF2eGRy
SGZ3bkYwMDd3V3p2dnh0b1g2VVNtVmVNQ1lWY2VidE5Uc2FGdzJQR0N6bDJIQzgtNVhFclhsYV9N
a3c5Mm04eXN3JD4NCj4gUmVwb3J0IFN1c3BpY2lvdXMNCj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5u
ZXJFbmQNCj4gDQo+IE9uIEZyaSwgMTggSnVsIDIwMjUgMTE6NDQ6NTQgKzAyMDAsDQo+IEJhb2p1
biBYdSB3cm90ZToNCj4gPg0KPiA+IEFkZCBUQVMyNzcwIHN1cHBvcnQgaW4gVEkncyBIREEgZHJp
dmVyLg0KPiA+IEFuZCBhZGQgaGRhX2NoaXBfaWQgZm9yIG1vcmUgcHJvZHVjdCBzdXBwb3J0IGlu
IHRoZSBmdXR1cmUuDQo+ID4gU2VwYXJhdGVkIERTUCBhbmQgbm9uLURTUCBpbiBmaXJtd2FyZSBs
b2FkIGZ1bmN0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFvanVuIFh1IDxiYW9qdW4u
eHVAdGkuY29tPg0KPiANCj4gQW55IHJlYXNvbiBvZiB0aGUgc3VibWlzc2lvbiBvZiB0aGUgdmVy
eSBzYW1lIHBhdGNoPw0KPiBJdCB3YXMgcmVxdWVzdGVkIHRvIHJlc3VibWl0IGFmdGVyIHJlYmFz
aW5nIHRvIHRoZSBuZXcgbG9jYXRpb24gZm9yDQo+IEhELWF1ZGlvIChzb3VuZC9oZGEvKikgYXMg
Zm91bmQgaW4gZm9yLW5leHQgYnJhbmNoIG9mIHNvdW5kLmdpdCB0cmVlLg0KPiANCg0KSSBoYXZl
IHVwbG9hZGVkIHRvOg0KZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25l
eHQvbGludXgtbmV4dC5naXQsDQphbmQgeW91IHNhaWQ6DQoiVGFrYXNoaSBJd2FpIDx0aXdhaUBz
dXNlLmRlPiwgU2F0IDEyLzA3LzIwMjUgMTY6MjkNCg0KVGhlIHdob2xlIEhELWF1ZGlvIHN0dWZm
IGhhcyBiZWVuIG1vdmVkIHVuZGVyIHNvdW5kL2hkYSByZWNlbnRseS4NClBsZWFzZSBjcmVhdGUg
YSBwYXRjaCBiYXNlZCBvbiBmb3ItbmV4dCBicmFuY2ggb2YgdGhlIHNvdW5kIGdpdCB0cmVlLiIN
Cg0KU28gSSByZS1wYXRjaGVkIGl0IHRvIGZvci1uZXh0Og0KZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L2Jyb29uaWUvc291bmQuDQoNCkRvIEkgaGF2ZSBhIG1pc3VuZGVy
c3RhbmRpbmcgYWJvdXQgaXQ/IERvIEkgc3RpbGwgbmVlZCBwYXRjaCBvbg0KL25leHQvbGludXgt
bmV4dC5naXQsIGp1c3QgYWZ0ZXIgdGhlIGNvZGUgd2FzIG1vdmVkIHRvIHNvdW5kL2hkYS9jb2Rl
Y3Mvc2lkZS1jb2RlY3M/DQoNCj4gDQo+IHRoYW5rcywNCj4gDQo+IFRha2FzaGkNCj4gDQoNCkJl
c3QgUmVnYXJkcw0KSmltDQo=

