Return-Path: <linux-kernel+bounces-798005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42864B4184C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FB55604AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDA72E92D9;
	Wed,  3 Sep 2025 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vkmezarc"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35D2DF716
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887729; cv=none; b=tYAkiojMADPgRvmuey0YIpSTm9/Rzf0iFHMLjZmbuKBHdzhEXn2URm3PSJAo3aj3xZlSFpXqjDZxu7d4rR60qWwEqbRZnHwD3J1T28awbEA5eofeHFu1Ab1eWwHTtYaj2NbvqTWcBcDQIk/gOSQLolsrme2jGk4oQTnCT7Me1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887729; c=relaxed/simple;
	bh=N0ZCxv90G25eo0Ved5BuTzC5yFsUyVfF1hJXMJKOPUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OaBrQsxzVJ8BiB/PEH2zOIJo0wVf1w51fSn9vBwsbZS8+IvvTXVjbJTQDzICMEnpl+EfQkF46nApAtPzzYnXJTuELAEQOg4ryjKPl4inQ6HkVrFDNXQmb4SsStUCWXGu5EXcVr0Ww4rNMjjm+dq5pbDnmwx8Ar8I5MYnEwzT0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vkmezarc; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5838LlSr3219746;
	Wed, 3 Sep 2025 03:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756887707;
	bh=N0ZCxv90G25eo0Ved5BuTzC5yFsUyVfF1hJXMJKOPUw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=vkmezarcNbXOn9C29udxCpuL70RkLeIfu28AuryUQ6N3WUlwAbhT6VwaWga4fJb/t
	 CD1QTCvL1icIE5XwY2ylP+evZRFZeXKO/nZ/rztciJ5gCxHZ5fshDXAPr7hHrf88qs
	 iEiADfpqfDseU5qSyfvrMKGYauiMeoqPlQ+pcGHw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5838LlVk2902531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 03:21:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 03:21:46 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.055; Wed, 3 Sep 2025 03:21:46 -0500
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "13564923607@139.com" <13564923607@139.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <baojun.xu@ti.com>,
        "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2] ALSA: hda/tas2781: Fix the order of
 TAS2781 calibrated-data
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ALSA: hda/tas2781: Fix the order of
 TAS2781 calibrated-data
Thread-Index: AQHcHIktAJvNMNT5vE+BhvDY5ZGSArSBYW0A//+74SA=
Date: Wed, 3 Sep 2025 08:21:46 +0000
Message-ID: <27b157f549b64c15b77a60dfef84dcfd@ti.com>
References: <20250903041351.143-1-shenghao-ding@ti.com>
 <87cy88vw5t.wl-tiwai@suse.de>
In-Reply-To: <87cy88vw5t.wl-tiwai@suse.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
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

R2xhZCB0byBhbnN3ZXIgeW91ciBxdWVzdGlvbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBTZXB0ZW1iZXIgMywgMjAyNSAzOjIxIFBNDQo+IFRvOiBEaW5nLCBTaGVuZ2hhbyA8c2hl
bmdoYW8tZGluZ0B0aS5jb20+DQo+IENjOiBicm9vbmllQGtlcm5lbC5vcmc7IGFuZHJpeS5zaGV2
Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsNCj4gMTM1NjQ5MjM2MDdAMTM5LmNvbTsgMTM5MTYyNzUy
MDZAMTM5LmNvbTsgYWxzYS1kZXZlbEBhbHNhLQ0KPiBwcm9qZWN0Lm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgWHUsIEJhb2p1biA8YmFvanVuLnh1QHRpLmNvbT47DQo+IEJhb2p1
bi5YdUBmcHQuY29tDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2Ml0gQUxTQTog
aGRhL3RhczI3ODE6IEZpeCB0aGUgb3JkZXIgb2YNCj4gVEFTMjc4MSBjYWxpYnJhdGVkLWRhdGEN
Cj4gDQouLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQN
Cj4gT24gV2VkLCAwMyBTZXAgMjAyNSAwNjoxMzo1MSArMDIwMCwNCj4gU2hlbmdoYW8gRGluZyB3
cm90ZToNCj4gPg0KPiA+IEEgYnVnIHJlcG9ydGVkIGJ5IG9uZSBvZiBteSBjdXN0b21lcnMgdGhh
dCB0aGUgb3JkZXIgb2YgVEFTMjc4MQ0KPiA+IGNhbGlicmF0ZWQtZGF0YSBpcyBpbmNvcnJlY3Qs
IHRoZSBjb3JyZWN0IHdheSBpcyB0byBtb3ZlIFIwX0xvdyBhbmQNCj4gPiBpbnNlcnQgaXQgYmV0
d2VlbiBSMCBhbmQgSW52UjAuDQo+ID4NCj4gPiBGaXhlczogNGZlMjM4NTEzNDA3ICgiQUxTQTog
aGRhL3RhczI3ODE6IE1vdmUgYW5kIHVuaWZpZWQgdGhlDQo+ID4gY2FsaWJyYXRlZC1kYXRhIGdl
dHRpbmcgZnVuY3Rpb24gZm9yIFNQSSBhbmQgSTJDIGludG8gdGhlIHRhczI3ODFfaGRhDQo+ID4g
bGliIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVuZ2hhbyBEaW5nIDxzaGVuZ2hhby1kaW5nQHRp
LmNvbT4NCj4gPg0KPiA+IC0tLQ0KPiA+IHYyOg0KPiA+ICAtIFN1Ym1pdCB0byBzb3VuZCBicmFu
Y2ggbWFpbnRpYW5lZCBieSBUaXdhaSBpbnN0ZWFkIG9mIGxpbnV4LW5leHQNCj4gPiBicmFuY2gN
Cj4gPiAgLSBkcm9wIG90aGVyIGZpeA0KPiANCj4gWW91IGhhdmVuJ3QgYW5zd2VyZWQgdG8gbXkg
cHJldmlvdXMgcXVlc3Rpb24gYXQgYWxsLg0KPiANCj4gSXMgdGhlIGlzc3VlIHlvdSdyZSB0cnlp
bmcgdG8gZml4IHNvbWV0aGluZyBkaWZmZXJlbnQgZnJvbSB3aGF0IEdlcmdvIGFscmVhZHkNCj4g
Zml4ZWQgaW4gY29tbWl0IGQ1Zjg0NThlMzRhMzMxZTViMjI4ZGUxNDIxNDVlNjJhYzViZmRhMzQN
Cj4gKHdoaWNoIHdhcyBhbHJlYWR5IG1lcmdlZCB0byBMaW51cyB0cmVlKS4NClllcywgdGhpcyBw
YXRjaCBpcyB0byBmaXggVEFTMjc4MS4gR2VyZ28gZml4ZWQgVEFTMjU2Mw0KPiANCj4gDQo+IFRh
a2FzaGkNCg==

