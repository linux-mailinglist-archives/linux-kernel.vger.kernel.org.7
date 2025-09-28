Return-Path: <linux-kernel+bounces-835141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57777BA65D8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC390189D316
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4024634F;
	Sun, 28 Sep 2025 01:55:34 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9C23B61E;
	Sun, 28 Sep 2025 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759024533; cv=none; b=uYb011pepS8FGlD+/xwEhuHCNf1aP/30eOWt02BDUVhpgeSVaqhGFRalt+VwGWJ+C3RWPvy3Rr0Apc6kgn89gC+e781WaaBNSHMVRFIUXxcW507nEtXbxImDP42KKO8xjrdG9eiSX/a4R7x5XASb9N7nVYWmVHTCsXan86CKh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759024533; c=relaxed/simple;
	bh=DhMy8VelA4m+5ed71j+YSweluWKoiDqs3q7HQ2bmmIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lj2P0N38DU6J8c9Pb1BIdv/8DS5ZuMHakfcyLeSNcKHv5JlOuM2M4OeJxBhV2vjX5lsxcYLTFuefeb71AtCDTGmle9qIyJ7jjYrKosRbLzulCnDHTfx8jqAAWpp3Pr+2x+LGQQyyZdOQAiHuAH8imSPAgFXT9LaftyySHHk4ZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Lance Yang <lance.yang@linux.dev>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "joel.granados@kernel.org"
	<joel.granados@kernel.org>, "feng.tang@linux.alibaba.com"
	<feng.tang@linux.alibaba.com>, "pauld@redhat.com" <pauld@redhat.com>,
	"kees@kernel.org" <kees@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@kernel.org" <mingo@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIGh1bmdfdGFzazogUGFu?=
 =?utf-8?Q?ic_after_fixed_number_of_hung_tasks?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gaHVuZ190YXNrOiBQYW5pYyBh?=
 =?utf-8?Q?fter_fixed_number_of_hung_tasks?=
Thread-Index: AQHcLeKBbjlGoIEXG0G0MLy1vpHO47SlzeoAgAILndA=
Date: Sun, 28 Sep 2025 01:54:33 +0000
Message-ID: <bfe6df93ed8e4eb1b5191d4f7be719f7@baidu.com>
References: <20250925060605.2659-1-lirongqing@baidu.com>
 <3ae5cbea-d320-4d28-a894-5e11e048158f@linux.dev>
In-Reply-To: <3ae5cbea-d320-4d28-a894-5e11e048158f@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.3.12
X-FE-Policy-ID: 52:10:53:SYSTEM

PiA+IFNpZ25lZC1vZmYtYnk6IExpIFJvbmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4g
PiAtLS0NCj4gPiAgIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvc3lzY3RsL2tlcm5lbC5yc3Qg
fCAgNiArKysrKysNCj4gPiAgIGtlcm5lbC9odW5nX3Rhc2suYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAxNCArKysrKysrKysrKysrLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9zeXNjdGwva2VybmVsLnJzdA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9h
ZG1pbi1ndWlkZS9zeXNjdGwva2VybmVsLnJzdA0KPiA+IGluZGV4IDhiNDllYWIuLjQyNDBlN2Ig
MTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9zeXNjdGwva2VybmVs
LnJzdA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvc3lzY3RsL2tlcm5lbC5y
c3QNCj4gPiBAQCAtNDA1LDYgKzQwNSwxMiBAQCBUaGlzIGZpbGUgc2hvd3MgdXAgaWYNCj4gYGBD
T05GSUdfREVURUNUX0hVTkdfVEFTS2BgIGlzIGVuYWJsZWQuDQo+ID4gICAxIFBhbmljIGltbWVk
aWF0ZWx5Lg0KPiA+ICAgPSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo+ID4NCj4gPiAraHVuZ190YXNrX2NvdW50X3RvX3BhbmljDQo+ID4gKz09PT09
PT09PT09PT09PT09PT09PQ0KPiA+ICsNCj4gPiArV2hlbiBzZXQgdG8gYSBub24temVybyB2YWx1
ZSwgYWZ0ZXIgdGhlIG51bWJlciBvZiBjb25zZWN1dGl2ZSBodW5nDQo+ID4gK3Rhc2sgb2NjdXIs
IHRoZSBrZXJuZWwgd2lsbCB0cmlnZ2VycyBhIHBhbmljDQo+IA0KPiBIbW0uLi4gdGhlIGRvY3Vt
ZW50YXRpb24gaGVyZSBzZWVtcyBhIGJpdCBtaXNsZWFkaW5nLg0KPiANCj4gaHVuZ190YXNrX3Bh
bmljPTEgd2lsbCBhbHdheXMgY2F1c2UgYW4gaW1tZWRpYXRlIHBhbmljLCByZWdhcmRsZXNzIG9m
IHRoZQ0KPiBodW5nX3Rhc2tfY291bnRfdG9fcGFuaWMgc2V0dGluZywgcmlnaHQ/DQo+IA0KPiBQ
ZXJoYXBzIHNvbWV0aGluZyBsaWtlIHRoaXMgd291bGQgYmUgbW9yZSBhY2N1cmF0ZT8NCj4gDQo+
IGBgYA0KPiBodW5nX3Rhc2tfY291bnRfdG9fcGFuaWMNCj4gPT09PT09PT09PT09PT09PT09PT09
PT09DQo+IA0KPiBXaGVuIHNldCB0byBhIG5vbi16ZXJvIHZhbHVlLCBhIGtlcm5lbCBwYW5pYyB3
aWxsIGJlIHRyaWdnZXJlZCBpZiB0aGUgbnVtYmVyIG9mDQo+IGRldGVjdGVkIGh1bmcgdGFza3Mg
cmVhY2hlcyB0aGlzIHZhbHVlLg0KPiANCj4gTm90ZSB0aGF0IHNldHRpbmcgaHVuZ190YXNrX3Bh
bmljPTEgd2lsbCBzdGlsbCBjYXVzZSBhbiBpbW1lZGlhdGUgcGFuaWMgb24gdGhlDQo+IGZpcnN0
IGh1bmcgdGFzaywgb3ZlcnJpZGluZyB0aGlzIHNldHRpbmcuDQo+IGBgYA0KDQoNCkkgd2lsbCBy
ZXdyaXRlIHRoaXMgZG9jdW1lbnRhdGlvbiBhcyB5b3VyIHN1Z2dlc3Rpb25zDQoNCg0KPiANCj4g
Pg0KPiA+ICAgaHVuZ190YXNrX2NoZWNrX2NvdW50DQo+ID4gICA9PT09PT09PT09PT09PT09PT09
PT0NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2h1bmdfdGFzay5jIGIva2VybmVsL2h1bmdfdGFz
ay5jIGluZGV4DQo+ID4gODcwOGExMi4uODdhNjQyMSAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwv
aHVuZ190YXNrLmMNCj4gPiArKysgYi9rZXJuZWwvaHVuZ190YXNrLmMNCj4gPiBAQCAtODMsNiAr
ODMsOCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IF9fcmVhZF9tb3N0bHkNCj4gc3lzY3RsX2h1bmdf
dGFza19hbGxfY3B1X2JhY2t0cmFjZTsNCj4gPiAgIHN0YXRpYyB1bnNpZ25lZCBpbnQgX19yZWFk
X21vc3RseSBzeXNjdGxfaHVuZ190YXNrX3BhbmljID0NCj4gPiAgIAlJU19FTkFCTEVEKENPTkZJ
R19CT09UUEFSQU1fSFVOR19UQVNLX1BBTklDKTsNCj4gPg0KPiA+ICtzdGF0aWMgdW5zaWduZWQg
aW50IF9fcmVhZF9tb3N0bHkgc3lzY3RsX2h1bmdfdGFza19jb3VudF90b19wYW5pYzsNCj4gDQo+
IE5pdDogd2hpbGUgc3RhdGljIHZhcmlhYmxlcyBhcmUgZ3VhcmFudGVlZCB0byBiZSB6ZXJvLWlu
aXRpYWxpemVkLCBpdCdzIGEgZ29vZA0KPiBwcmFjdGljZSBhbmQgY2xlYXJlciBmb3IgcmVhZGVy
cyB0byBpbml0aWFsaXplIHRoZW0gZXhwbGljaXRseS4NCj4gDQo+IHN0YXRpYyB1bnNpZ25lZCBp
bnQgX19yZWFkX21vc3RseSBzeXNjdGxfaHVuZ190YXNrX2NvdW50X3RvX3BhbmljID0gMDsNCj4g
DQoNCg0KT2ssIEkgd2lsbCBjaGFuZ2UgaXQNCg0KVGhhbmtzDQoNCi1MaQ0KDQo+IA0KPiBPdGhl
cndpc2UsIHRoaXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZSENCj4gQWNrZWQtYnk6IExhbmNlIFlh
bmcgPGxhbmNlLnlhbmdAbGludXguZGV2Pg0KPiANCj4gPiArDQo+ID4gICBzdGF0aWMgaW50DQo+
ID4gICBodW5nX3Rhc2tfcGFuaWMoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICp0aGlzLCB1bnNpZ25l
ZCBsb25nIGV2ZW50LCB2b2lkICpwdHIpDQo+ID4gICB7DQo+ID4gQEAgLTIxOSw3ICsyMjEsOSBA
QCBzdGF0aWMgdm9pZCBjaGVja19odW5nX3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0LA0KPiA+
IHVuc2lnbmVkIGxvbmcgdGltZW91dCkNCj4gPg0KPiA+ICAgCXRyYWNlX3NjaGVkX3Byb2Nlc3Nf
aGFuZyh0KTsNCj4gPg0KPiA+IC0JaWYgKHN5c2N0bF9odW5nX3Rhc2tfcGFuaWMpIHsNCj4gPiAr
CWlmIChzeXNjdGxfaHVuZ190YXNrX3BhbmljIHx8DQo+ID4gKwkgICAgKHN5c2N0bF9odW5nX3Rh
c2tfY291bnRfdG9fcGFuaWMgJiYNCj4gPiArCSAgICAgKHN5c2N0bF9odW5nX3Rhc2tfZGV0ZWN0
X2NvdW50ID49DQo+ID4gK3N5c2N0bF9odW5nX3Rhc2tfY291bnRfdG9fcGFuaWMpKSkgew0KPiA+
ICAgCQljb25zb2xlX3ZlcmJvc2UoKTsNCj4gPiAgIAkJaHVuZ190YXNrX3Nob3dfbG9jayA9IHRy
dWU7DQo+ID4gICAJCWh1bmdfdGFza19jYWxsX3BhbmljID0gdHJ1ZTsNCj4gPiBAQCAtMzg4LDYg
KzM5MiwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGN0bF90YWJsZSBodW5nX3Rhc2tfc3lzY3Rs
c1tdID0gew0KPiA+ICAgCQkuZXh0cmEyCQk9IFNZU0NUTF9PTkUsDQo+ID4gICAJfSwNCj4gPiAg
IAl7DQo+ID4gKwkJLnByb2NuYW1lCT0gImh1bmdfdGFza19jb3VudF90b19wYW5pYyIsDQo+ID4g
KwkJLmRhdGEJCT0gJnN5c2N0bF9odW5nX3Rhc2tfY291bnRfdG9fcGFuaWMsDQo+ID4gKwkJLm1h
eGxlbgkJPSBzaXplb2YoaW50KSwNCj4gPiArCQkubW9kZQkJPSAwNjQ0LA0KPiA+ICsJCS5wcm9j
X2hhbmRsZXIJPSBwcm9jX2RvaW50dmVjX21pbm1heCwNCj4gPiArCQkuZXh0cmExCQk9IFNZU0NU
TF9aRVJPLA0KPiA+ICsJfSwNCj4gPiArCXsNCj4gPiAgIAkJLnByb2NuYW1lCT0gImh1bmdfdGFz
a19jaGVja19jb3VudCIsDQo+ID4gICAJCS5kYXRhCQk9ICZzeXNjdGxfaHVuZ190YXNrX2NoZWNr
X2NvdW50LA0KPiA+ICAgCQkubWF4bGVuCQk9IHNpemVvZihpbnQpLA0KDQo=

