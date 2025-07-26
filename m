Return-Path: <linux-kernel+bounces-746710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55CEB12A47
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8694917C2D0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 11:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8A023F417;
	Sat, 26 Jul 2025 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jHNETpN5"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265932D052;
	Sat, 26 Jul 2025 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753529692; cv=none; b=idhIymW4zvRUkxUYywPTzWWa7cslI4yyTT6xXgRMZq5fOl2s/Rv8/U/8zLLQPBPvEERgPBUeCPk/8m9cG1MF0msQfLgMN1YimlazO7w+wC/9MUcVdLeGhExhEnzTT48ZE7FcTj4dIXG66MbrqZ+qZV2FGGW5aA+9y7t552Nt0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753529692; c=relaxed/simple;
	bh=l6TuRz5EzLqeFVgvRZk84SkmxztLVYklXrBbwvkzRAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rAprVhRBRPVtqjEnke5oMFyeIrBbGoIUo2pePRIQHTVxBLKxR6Uq+rzyK4ucCXaXY8h/GTgXH2Ieku8G++78xLlJawkeQzSW9cD5vt/88OjpxRX9VCxGsNvS+DUBMfgDc+Bp83e2lIz+n5Bl/otqYIkWvP+C8pbtNzE/ajdl6k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jHNETpN5; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56QBYTIp1912008;
	Sat, 26 Jul 2025 06:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753529669;
	bh=l6TuRz5EzLqeFVgvRZk84SkmxztLVYklXrBbwvkzRAk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=jHNETpN5yGHM1rH/FSBAtl2HbNLrJDbJLc+EW/8a/sIrqx5V5W3yf1mJzQpRKdEvl
	 Y23ErP3Q1Ad+zhpaMqyxw/OjGcEztN7GPKzLMG48hUH6GcG1ACKC+q4pCuC9HSGs/h
	 9b0Khdtc5iSkU3UORwGvgWjCiYevWZ5wRM2LVLEU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56QBYS6R3880166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 26 Jul 2025 06:34:29 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 26
 Jul 2025 06:34:28 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.055; Sat, 26 Jul 2025 06:34:28 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Ding, Shenghao"
	<shenghao-ding@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "P O,
 Vijeth" <v-po@ti.com>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2] ALSA: hda: Add TAS2770 support
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ALSA: hda: Add TAS2770 support
Thread-Index: AQHb+92VnCyYVy56v0qMsWwwberg3LRAG64AgAQtmUE=
Date: Sat, 26 Jul 2025 11:34:28 +0000
Message-ID: <cc99c78e042b47cca92f4a3050f36a9c@ti.com>
References: <20250723142423.38768-1-baojun.xu@ti.com>,<87bjpbm0lj.wl-tiwai@suse.de>
In-Reply-To: <87bjpbm0lj.wl-tiwai@suse.de>
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
YWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+DQo+IFNlbnQ6IDIzIEp1bHkgMjAyNSAyMjo0MA0K
PiBUbzogWHUsIEJhb2p1bg0KPiBDYzogYnJvb25pZUBrZXJuZWwub3JnOyBhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb207IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgRGluZywg
U2hlbmdoYW87IDEzOTE2Mjc1MjA2QDEzOS5jb207IFAgTywgVmlqZXRoOyBsaW51eC1zb3VuZEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
W0VYVEVSTkFMXSBSZTogW1BBVENIIHYyXSBBTFNBOiBoZGE6IEFkZCBUQVMyNzcwIHN1cHBvcnQN
Cj4gDQo+IE9uIFdlZCwgMjMgSnVsIDIwMjUgMTY64oCKMjQ64oCKMjMgKzAyMDAsIEJhb2p1biBY
dSB3cm90ZTogPiA+IEFkZCBUQVMyNzcwIHN1cHBvcnQgaW4gVEkncyBIREEgZHJpdmVyLiBBbmQg
YWRkIGhkYV9jaGlwX2lkIGZvciA+IG1vcmUgcHJvZHVjdHMuIERpc3Rpbmd1aXNoIERTUCBhbmQg
bm9uLURTUCBpbiBmaXJtd2FyZSA+IGxvYWRpbmcgZnVuY3Rpb24uID4gPiBTaWduZWQtb2ZmLWJ5
OiBCYW9qdW4NCj4gWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0DQo+IFRoaXMgbWVzc2FnZSB3YXMg
c2VudCBmcm9tIG91dHNpZGUgb2YgVGV4YXMgSW5zdHJ1bWVudHMuDQo+IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzb3VyY2Ug
b2YgdGhpcyBlbWFpbCBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiA8aHR0cHM6Ly91
cy1waGlzaGFsYXJtLWV3dC5wcm9vZnBvaW50LmNvbS9FV1QvdjEvRzN2SyF2eGRySGYzRVBtZFFp
ZzN2Znh0b1gwZ2EtWlcyZ3JiNHBKLTkweEVhb20tblZzSFQ4eEhZM0Qybks4djVtZFdsRXcwdDNR
JD4NCj4gUmVwb3J0IFN1c3BpY2lvdXMNCj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj4g
DQo+IE9uIFdlZCwgMjMgSnVsIDIwMjUgMTY6MjQ6MjMgKzAyMDAsDQo+IEJhb2p1biBYdSB3cm90
ZToNCj4gPg0KPiA+IEFkZCBUQVMyNzcwIHN1cHBvcnQgaW4gVEkncyBIREEgZHJpdmVyLiBBbmQg
YWRkIGhkYV9jaGlwX2lkIGZvcg0KPiA+IG1vcmUgcHJvZHVjdHMuIERpc3Rpbmd1aXNoIERTUCBh
bmQgbm9uLURTUCBpbiBmaXJtd2FyZQ0KPiA+IGxvYWRpbmcgZnVuY3Rpb24uDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBCYW9qdW4gWHUgPGJhb2p1bi54dUB0aS5jb20+DQo+IA0KPiBBcHBsaWVk
IG5vdywgdGhhbmtzLg0KPiANCj4gDQo+IEJUVywgaXMgaW5jbHVkZS9zb3VuZC90YXMyNzcwLXRs
di5oIHVzZWQgYnkgYW55IG90aGVyIGRyaXZlcj8NCj4gKEFsc28gaW5jbHVkZS9zb3VuZC90YXMy
NzgxLXRsdi5oKS4NCj4gDQo+IElmIHRob3NlIGFyZSB1c2VkIG9ubHkgYnkgdGFzMjc4MS1oZGEt
aTJzL3NwaSBkcml2ZXJzLCB0aGUgZmlsZXMgY2FuDQo+IGJlIG1vdmVkIHRvIHNvdW5kL2hkYS9j
b2RlY3Mvc2lkZS1jb2RlY3MgYXMgbG9jYWwgaGVhZGVycy4NCj4gDQo+IEluIGdlbmVyYWwsIGlu
Y2x1ZGUvc291bmQgaXMgcmF0aGVyIGZvciBwdWJsaWMgaGVhZGVycyB0aGF0IGFyZSByZWFkDQo+
IGJ5IG11bHRpcGxlIGRyaXZlcnMgaW4gZGlmZmVyZW50IHBsYWNlcy4NCg0KVGhhbmtzIGZvciB0
aGUgYXBwbHkhDQpZZXMsIGluY2x1ZGUvc291bmQvdGFzeHh4eC10bHYuaCB3aWxsIGFsc28gYmUg
dXNlZCBieSBvdGhlciBkcml2ZXJzDQooZm9yIGV4YW1wbGUsIHNvdW5kL3NvYy9jb2RlY3MvdGFz
Mnh4eC1pMmMuYykNCg0KPiANCj4gDQo+IHRoYW5rcywNCj4gDQo+IFRha2FzaGkNCj4gDQoNCkJl
c3QgUmVnYXJkcw0KSmltDQo=

