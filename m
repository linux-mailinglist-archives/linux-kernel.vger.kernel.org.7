Return-Path: <linux-kernel+bounces-779365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B914CB2F324
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE2D17BA17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2FE2D3ED1;
	Thu, 21 Aug 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wVFILoIx"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C06E2BDC17
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766931; cv=none; b=XtjJc/1w4q2ePo0aE2rzZ8TngQWW6HOQoXwr0E5ara9hk1ox3FlJAm5TyLuygoGvuLsUPm4laMPGzrWwxj4ZhyiHZPbTBbQGRM1KX+RLBh6ZW904lkHqCgDpg1kNMa+k/Ub2D+V+QqFAVJDKhAGeqtkm6PtZGb18mKVvuZf/wio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766931; c=relaxed/simple;
	bh=HUkFskVt/kLCNuvUrc419aqi6V/csSGTs5pBRhqs7ic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QcrJOVHBNDnzY3tOnzZ/bs1LgYOd9E/4hoXbgKkaKqI8vOq+OfeQxFsKPUpPTA9acFbQRtMauyR+jfz5jDS43LT2O0xXF/CNuxQcS6s5gmzgP9swhVFZ2yvIc+7NUZ00t/6pvAAEOAXavwEUhgCTJoiukGQFdYdaxdbVJjEOb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wVFILoIx; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57L91k6A452181;
	Thu, 21 Aug 2025 04:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755766906;
	bh=HUkFskVt/kLCNuvUrc419aqi6V/csSGTs5pBRhqs7ic=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=wVFILoIxvQSNFr9l3L7odWSGigO9fQYHcM2JxW46dwIy7F37Lrt58sGiTesCcn+hw
	 YyYpflXXg/MZ4WsccfLeQ5w2yKPvLRbhRUG/Hg02WqQMfF4xm3xVAjaZsTfZJ7/5h6
	 wOr8MVlE1mZwnXYLNJynH09Zvw3GdnbEjKXu8BJ8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57L91kUw2421733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 21 Aug 2025 04:01:46 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 04:01:45 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.055; Thu, 21 Aug 2025 04:01:45 -0500
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
        "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>, "Ji, Jesse" <jesse-ji@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1] ALSA: hda/tas2781: Enable
 init_profile_id for device initialization
Thread-Topic: [EXTERNAL] Re: [PATCH v1] ALSA: hda/tas2781: Enable
 init_profile_id for device initialization
Thread-Index: AQHcEatvZvlPwIjp+Em7/sG1clBO2bRtB8AA///I1EA=
Date: Thu, 21 Aug 2025 09:01:45 +0000
Message-ID: <203d0937f1974417ac64b4ed6a6f2e69@ti.com>
References: <20250820082123.1125-1-shenghao-ding@ti.com>
 <87cy8p6t4t.wl-tiwai@suse.de>
In-Reply-To: <87cy8p6t4t.wl-tiwai@suse.de>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUYWthc2hpIEl3YWkgPHRpd2Fp
QHN1c2UuZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjEsIDIwMjUgMzoxNyBQTQ0KPiBU
bzogRGluZywgU2hlbmdoYW8gPHNoZW5naGFvLWRpbmdAdGkuY29tPg0KPiBDYzogYnJvb25pZUBr
ZXJuZWwub3JnOyBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207DQo+IDEzNTY0OTIz
NjA3QDEzOS5jb207IDEzOTE2Mjc1MjA2QDEzOS5jb207IGFsc2EtZGV2ZWxAYWxzYS0NCj4gcHJv
amVjdC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFh1LCBCYW9qdW4gPGJhb2p1
bi54dUB0aS5jb20+Ow0KPiBCYW9qdW4uWHVAZnB0LmNvbTsgSmksIEplc3NlIDxqZXNzZS1qaUB0
aS5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MV0gQUxTQTogaGRhL3Rh
czI3ODE6IEVuYWJsZQ0KPiBpbml0X3Byb2ZpbGVfaWQgZm9yIGRldmljZSBpbml0aWFsaXphdGlv
bg0KPiANCj4gT24gV2VkLCAyMCBBdWcgMjAyNSAxMDrigIoyMTrigIoyMyArMDIwMCwgU2hlbmdo
YW8gRGluZyB3cm90ZTogPiA+IE9wdGltaXplDQo+IHRoZSB0aW1lIGNvbnN1bXB0aW9uIG9mIHBy
b2ZpbGUgc3dpdGNoaW5nLCBpbml0X3Byb2ZpbGUgc2F2ZXMgPiB0aGUgY29tbW9uDQo+IHNldHRp
bmdzIG9mIGRpZmZlcmVudCBwcm9maWxlcywgc3VjaCBhcyB0aGUgZHNwIGNvZWZmaWNpZW50cywg
PiBldGMsIHdoaWNoIGNhbg0KPiBncmVhdGx5IFpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydCBUaGlz
IG1lc3NhZ2Ugd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mDQo+IFRleGFzIEluc3RydW1lbnRzLg0K
PiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29n
bml6ZSB0aGUgc291cmNlIG9mDQo+IHRoaXMgZW1haWwgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCj4gPGh0dHBzOi8vdXMtcGhpc2hhbGFybS0NCj4gZXd0LnByb29mcG9pbnQuY29tL0VX
VC92MS9HM3ZLIXZ4ZHJIZjNtVjJVYjRvYnN2eHRvWDRGVFYteVlkX0MtDQo+IDZuZ1F0RmVVRnBD
UmFFRVNqOF9CLXNaWG11WDVKTjJJMnU0UXgtbEQkPg0KPiBSZXBvcnQgU3VzcGljaW91cw0KPiAN
Cj4gWmpRY21RUllGcGZwdEJhbm5lckVuZA0KPiBPbiBXZWQsIDIwIEF1ZyAyMDI1IDEwOjIxOjIz
ICswMjAwLA0KPiBTaGVuZ2hhbyBEaW5nIHdyb3RlOg0KPiA+DQo+ID4gT3B0aW1pemUgdGhlIHRp
bWUgY29uc3VtcHRpb24gb2YgcHJvZmlsZSBzd2l0Y2hpbmcsIGluaXRfcHJvZmlsZSBzYXZlcw0K
PiA+IHRoZSBjb21tb24gc2V0dGluZ3Mgb2YgZGlmZmVyZW50IHByb2ZpbGVzLCBzdWNoIGFzIHRo
ZSBkc3ANCj4gPiBjb2VmZmljaWVudHMsIGV0Yywgd2hpY2ggY2FuIGdyZWF0bHkgcmVkdWNlIHRo
ZSBwcm9maWxlIHN3aXRjaGluZyB0aW1lDQo+ID4gY29tc3VtcHRpb24gYW5kIHJlbW92ZSB0aGUg
cmVwZXRpdGl2ZSBzZXR0aW5ncy4NCj4gPg0KLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
DQo+IFRoZSBwYXRjaCBjYXVzZXMgYnVpbGQgZXJyb3JzOg0KPiANCj4gc291bmQvaGRhL2NvZGVj
cy9zaWRlLWNvZGVjcy90YXMyNzgxX2hkYV9pMmMuYzogSW4gZnVuY3Rpb24NCj4gyr10YXNkZXZp
Y2VfZHNwZndfaW5pdMq8Og0KPiBzb3VuZC9oZGEvY29kZWNzL3NpZGUtY29kZWNzL3RhczI3ODFf
aGRhX2kyYy5jOjQ2ODoyOTogZXJyb3I6IMq9c3RydWN0DQo+IHRhc2RldmljZV9yY2HKvCBoYXMg
bm8gbWVtYmVyIG5hbWVkIMq9aW5pdF9wcm9maWxlX2lkyrwNCj4gICA0NjggfCAgICAgICAgIGlm
ICh0YXNfcHJpdi0+cmNhYmluLmluaXRfcHJvZmlsZV9pZCA+PSAwKQ0KPiAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeDQo+IC4uLi4NCj4gDQo+IFNvbWV0aGluZyBzdGlsbCBu
b3QgbGFuZGVkIGluIG15IHRyZWUgeWV0Lg0KSSB3aWxsIHJlc3VibWl0IGl0IGFmdGVyIHlvdXIg
dHJlZSBpcyByZWFkeS4NCj4gDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBUYWthc2hpDQo=

