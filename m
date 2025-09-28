Return-Path: <linux-kernel+bounces-835260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C92BA6993
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D016F1897A24
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F331D221554;
	Sun, 28 Sep 2025 07:04:34 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB931A267;
	Sun, 28 Sep 2025 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759043074; cv=none; b=jEyMmw17yUAdOtDSbAZliqmt1dNEdgpH00CSQVagrSX6+4n+fusiFzx5Q6l956MaNtsjfc0VcHgutj7O60dxViusGEmtDTpSdUHMnHdsJ3jdiHToZHVFEysTW17X2KirBU3OiqQ552+33lbqU007W96v7JLfRN2+1ncCT1CD5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759043074; c=relaxed/simple;
	bh=BsnondPlu04MEHCTei8SjM5/nIa1e6nUI5FPxKQEvz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aCAq1AmnKN1jGUtVjhqEfjxPl3HsD3Oj6EfqhlOPKuQ+UAois+dy0EafeSybzePRM+THiVEApHFt0JC+pZfEtM2B/LOk3Mz91FZdIT7J/7zSwSGRSeH93oHHc7ZgcyhRo2WOsnzPW6z6E6FnGg4TPOLrClu2q80FCJDYAgAlBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Lance Yang <lance.yang@linux.dev>
CC: "corbet@lwn.net" <corbet@lwn.net>, "mingo@kernel.org" <mingo@kernel.org>,
	"pauld@redhat.com" <pauld@redhat.com>, "joel.granados@kernel.org"
	<joel.granados@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>,
	"kees@kernel.org" <kees@kernel.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdW3YyXSBodW5nX3Rhc2s6?=
 =?utf-8?Q?_Panic_after_fixed_number_of_hung_tasks?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bdjJdIGh1bmdfdGFzazogUGFu?=
 =?utf-8?Q?ic_after_fixed_number_of_hung_tasks?=
Thread-Index: AQHcMDksdcRioXB8tEOzfxW7SI8WgLSno0UAgACG63A=
Date: Sun, 28 Sep 2025 07:03:33 +0000
Message-ID: <d33ebade05ea45c2be47717fe1b812b8@baidu.com>
References: <20250928053137.3412-1-lirongqing@baidu.com>
 <3c44a757-f823-4671-b3d5-548fe04e52e3@linux.dev>
In-Reply-To: <3c44a757-f823-4671-b3d5-548fe04e52e3@linux.dev>
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
X-FEAS-Client-IP: 172.31.3.13
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBPbiAyMDI1LzkvMjggMTM6MzEsIGxpcm9uZ3Fpbmcgd3JvdGU6DQo+ID4gRnJvbTogTGkgUm9u
Z1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+DQo+ID4gQ3VycmVudGx5LCB3aGVuIGh1
bmdfdGFza19wYW5pYyBpcyBlbmFibGVkLCBrZXJuZWwgd2lsbCBwYW5pYw0KPiA+IGltbWVkaWF0
ZWx5IHVwb24gZGV0ZWN0aW5nIHRoZSBmaXJzdCBodW5nIHRhc2suIEhvd2V2ZXIsIHNvbWUgaHVu
Zw0KPiA+IHRhc2tzIGFyZSB0cmFuc2llbnQgYW5kIHRoZSBzeXN0ZW0gY2FuIHJlY292ZXIgZnVs
bHksIHdoaWxlIG90aGVycyBhcmUNCj4gPiB1bnJlY292ZXJhYmxlIGFuZCB0cmlnZ2VyIGNvbnNl
Y3V0aXZlIGh1bmcgdGFzayByZXBvcnRzLCBhbmQgYSBwYW5pYyBpcw0KPiBleHBlY3RlZC4NCj4g
Pg0KPiA+IFRoaXMgY29tbWl0IGFkZHMgYSBuZXcgc3lzY3RsIHBhcmFtZXRlciBodW5nX3Rhc2tf
Y291bnRfdG9fcGFuaWMgdG8NCj4gPiBhbGxvd3Mgc3BlY2lmeWluZyB0aGUgbnVtYmVyIG9mIGNv
bnNlY3V0aXZlIGh1bmcgdGFza3MgdGhhdCBtdXN0IGJlDQo+ID4gZGV0ZWN0ZWQgYmVmb3JlIHRy
aWdnZXJpbmcgYSBrZXJuZWwgcGFuaWMuIFRoaXMgcHJvdmlkZXMgZmluZXIgY29udHJvbA0KPiA+
IGZvciBlbnZpcm9ubWVudHMgd2hlcmUgdHJhbnNpZW50IGhhbmdzIG1heWJlIGhhcHBlbiBidXQg
cGVyc2lzdGVudA0KPiA+IGhhbmdzIHNob3VsZCBzdGlsbCBiZSBmYXRhbC4NCj4gPg0KPiA+IEFj
a2VkLWJ5OiBMYW5jZSBZYW5nIDxsYW5jZS55YW5nQGxpbnV4LmRldj4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gLS0tDQo+IA0KPiBJ
dCdzIHdvcmtpbmcgYXMgZXhwZWN0LiBTbzoNCj4gVGVzdGVkLWJ5OiBMYW5jZSBZYW5nIDxsYW5j
ZS55YW5nQGxpbnV4LmRldj4NCj4gDQo+IEJ1dCBvbiBzZWNvbmQgdGhvdWdodDogcmVnYXJkaW5n
IHRoaXMgbmV3IHN5c2N0bCBwYXJhbWV0ZXIsIEkgd2FzIHdvbmRlcmluZyBpZg0KPiBhIG5hbWUg
bGlrZSBtYXhfaHVuZ190YXNrX2NvdW50X3RvX3BhbmljIG1pZ2h0IGJlIGEgYml0IG1vcmUgZXhw
bGljaXQsIGp1c3QgdG8NCj4gZm9sbG93IHRoZSBjb252ZW50aW9uIGZyb20gbWF4X3JjdV9zdGFs
bF90b19wYW5pYy4NCj4gDQoNCkkgc2VlIHRoYXQgYWxsIHRoZSBodW5nIHRhc2sgc3lzY3RsIHBh
cmFtZXRlcnMgc3RhcnQgd2l0aCAiaHVuZ190YXNrIj8gU2hvdWxkIHdlIGtlZXAgdGhpcyBjb252
ZW50aW9uPyBJZiBzbywgd2UgY291bGQgbmFtZSBpdCAiaHVuZ190YXNrX21heF90b19wYW5pYyIu
IElmIG5vdCwgd2UgY291bGQgY2FsbCBpdCAibWF4X2hhbmdfdGFza190b19wYW5pYyI/DQoNCi1M
aQ0KDQoNCj4gTm8gc3Ryb25nIG9waW5pb24gb24gdGhpcywgdGhvdWdoIDopDQo+IA0KPiBDaGVl
cnMsDQo+IExhbmNlDQo+IA0KPiA+IERpZmYgd2l0aCB2MTogY2hhbmdlIGRvY3VtZW50YXRpb24g
YXMgTGFuY2Ugc3VnZ2VzdGVkDQo+ID4NCj4gPiAgIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUv
c3lzY3RsL2tlcm5lbC5yc3QgfCAgOCArKysrKysrKw0KPiA+ICAga2VybmVsL2h1bmdfdGFzay5j
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE0ICsrKysrKysrKysrKystDQo+ID4gICAyIGZp
bGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3N5c2N0bC9rZXJuZWwucnN0DQo+
ID4gYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3N5c2N0bC9rZXJuZWwucnN0DQo+ID4gaW5k
ZXggOGI0OWVhYi4uOThiNDdhNyAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL3N5c2N0bC9rZXJuZWwucnN0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1n
dWlkZS9zeXNjdGwva2VybmVsLnJzdA0KPiA+IEBAIC00MDUsNiArNDA1LDE0IEBAIFRoaXMgZmls
ZSBzaG93cyB1cCBpZg0KPiBgYENPTkZJR19ERVRFQ1RfSFVOR19UQVNLYGAgaXMgZW5hYmxlZC4N
Cj4gPiAgIDEgUGFuaWMgaW1tZWRpYXRlbHkuDQo+ID4gICA9ID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPg0KPiA+ICtodW5nX3Rhc2tfY291bnRf
dG9fcGFuaWMNCj4gPiArPT09PT09PT09PT09PT09PT09PT09DQo+ID4gKw0KPiA+ICtXaGVuIHNl
dCB0byBhIG5vbi16ZXJvIHZhbHVlLCBhIGtlcm5lbCBwYW5pYyB3aWxsIGJlIHRyaWdnZXJlZCBp
ZiB0aGUNCj4gPiArbnVtYmVyIG9mIGRldGVjdGVkIGh1bmcgdGFza3MgcmVhY2hlcyB0aGlzIHZh
bHVlLg0KPiA+ICsNCj4gPiArTm90ZSB0aGF0IHNldHRpbmcgaHVuZ190YXNrX3BhbmljPTEgd2ls
bCBzdGlsbCBjYXVzZSBhbiBpbW1lZGlhdGUNCj4gPiArcGFuaWMgb24gdGhlIGZpcnN0IGh1bmcg
dGFzay4NCj4gPg0KPiA+ICAgaHVuZ190YXNrX2NoZWNrX2NvdW50DQo+ID4gICA9PT09PT09PT09
PT09PT09PT09PT0NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2h1bmdfdGFzay5jIGIva2VybmVs
L2h1bmdfdGFzay5jIGluZGV4DQo+ID4gODcwOGExMi4uODdhNjQyMSAxMDA2NDQNCj4gPiAtLS0g
YS9rZXJuZWwvaHVuZ190YXNrLmMNCj4gPiArKysgYi9rZXJuZWwvaHVuZ190YXNrLmMNCj4gPiBA
QCAtODMsNiArODMsOCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IF9fcmVhZF9tb3N0bHkNCj4gc3lz
Y3RsX2h1bmdfdGFza19hbGxfY3B1X2JhY2t0cmFjZTsNCj4gPiAgIHN0YXRpYyB1bnNpZ25lZCBp
bnQgX19yZWFkX21vc3RseSBzeXNjdGxfaHVuZ190YXNrX3BhbmljID0NCj4gPiAgIAlJU19FTkFC
TEVEKENPTkZJR19CT09UUEFSQU1fSFVOR19UQVNLX1BBTklDKTsNCj4gPg0KPiA+ICtzdGF0aWMg
dW5zaWduZWQgaW50IF9fcmVhZF9tb3N0bHkgc3lzY3RsX2h1bmdfdGFza19jb3VudF90b19wYW5p
YzsNCj4gPiArDQo+ID4gICBzdGF0aWMgaW50DQo+ID4gICBodW5nX3Rhc2tfcGFuaWMoc3RydWN0
IG5vdGlmaWVyX2Jsb2NrICp0aGlzLCB1bnNpZ25lZCBsb25nIGV2ZW50LCB2b2lkICpwdHIpDQo+
ID4gICB7DQo+ID4gQEAgLTIxOSw3ICsyMjEsOSBAQCBzdGF0aWMgdm9pZCBjaGVja19odW5nX3Rh
c2soc3RydWN0IHRhc2tfc3RydWN0ICp0LA0KPiA+IHVuc2lnbmVkIGxvbmcgdGltZW91dCkNCj4g
Pg0KPiA+ICAgCXRyYWNlX3NjaGVkX3Byb2Nlc3NfaGFuZyh0KTsNCj4gPg0KPiA+IC0JaWYgKHN5
c2N0bF9odW5nX3Rhc2tfcGFuaWMpIHsNCj4gPiArCWlmIChzeXNjdGxfaHVuZ190YXNrX3Bhbmlj
IHx8DQo+ID4gKwkgICAgKHN5c2N0bF9odW5nX3Rhc2tfY291bnRfdG9fcGFuaWMgJiYNCj4gPiAr
CSAgICAgKHN5c2N0bF9odW5nX3Rhc2tfZGV0ZWN0X2NvdW50ID49DQo+ID4gK3N5c2N0bF9odW5n
X3Rhc2tfY291bnRfdG9fcGFuaWMpKSkgew0KPiA+ICAgCQljb25zb2xlX3ZlcmJvc2UoKTsNCj4g
PiAgIAkJaHVuZ190YXNrX3Nob3dfbG9jayA9IHRydWU7DQo+ID4gICAJCWh1bmdfdGFza19jYWxs
X3BhbmljID0gdHJ1ZTsNCj4gPiBAQCAtMzg4LDYgKzM5MiwxNCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGN0bF90YWJsZSBodW5nX3Rhc2tfc3lzY3Rsc1tdID0gew0KPiA+ICAgCQkuZXh0cmEyCQk9
IFNZU0NUTF9PTkUsDQo+ID4gICAJfSwNCj4gPiAgIAl7DQo+ID4gKwkJLnByb2NuYW1lCT0gImh1
bmdfdGFza19jb3VudF90b19wYW5pYyIsDQo+ID4gKwkJLmRhdGEJCT0gJnN5c2N0bF9odW5nX3Rh
c2tfY291bnRfdG9fcGFuaWMsDQo+ID4gKwkJLm1heGxlbgkJPSBzaXplb2YoaW50KSwNCj4gPiAr
CQkubW9kZQkJPSAwNjQ0LA0KPiA+ICsJCS5wcm9jX2hhbmRsZXIJPSBwcm9jX2RvaW50dmVjX21p
bm1heCwNCj4gPiArCQkuZXh0cmExCQk9IFNZU0NUTF9aRVJPLA0KPiA+ICsJfSwNCj4gPiArCXsN
Cj4gPiAgIAkJLnByb2NuYW1lCT0gImh1bmdfdGFza19jaGVja19jb3VudCIsDQo+ID4gICAJCS5k
YXRhCQk9ICZzeXNjdGxfaHVuZ190YXNrX2NoZWNrX2NvdW50LA0KPiA+ICAgCQkubWF4bGVuCQk9
IHNpemVvZihpbnQpLA0KDQo=

