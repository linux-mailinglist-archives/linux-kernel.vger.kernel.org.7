Return-Path: <linux-kernel+bounces-731584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A10B056D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851747B0F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291F12D4B75;
	Tue, 15 Jul 2025 09:41:13 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF372D6612
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572472; cv=none; b=RzPpoRmEEVpsNpIpkjIjVWFR3Q6DxDQ4TkPc/hIHzptrm1j9ej0TaUoaXHefFSsJ+go3lqWrnbQDnmvB36cxtgmP3S5FoBQa5//JhkW+JGcnkrXAzsfR7tvWJqqBF9zQWKs9isTWB3C5NbpTcYdqp8F2g+vQeszfAXmWI54gJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572472; c=relaxed/simple;
	bh=5SjDOtjzW9fZx4Am+5lLRHubgcbDf0fDM13w8lVFCws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HQVvK/gqOLfVbqC6tXFNc/hYXCeTwYOsRx2k9b2Q1E9+pDtgXAqCn3353xIRSqgDhz4DsCVymmgRMb9oyHCgUay+jXw4usiJC4aWCEqi2pEoD8WCD/nmVLy3XDZIrsICvzy9EK+F/nPYLDn0VrJrOfoyDnOiSe473wIxknHmfog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 56F9eb1Q093836;
	Tue, 15 Jul 2025 17:40:37 +0800 (+08)
	(envelope-from haiyan.liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4bhDb50sFvz2K4cJr;
	Tue, 15 Jul 2025 17:36:17 +0800 (CST)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Jul
 2025 17:40:31 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.048; Tue, 15 Jul 2025 17:40:31 +0800
From: =?utf-8?B?5YiY5rW354eVIChIYWl5YW4gTGl1KQ==?= <haiyan.liu@unisoc.com>
To: Miguel Ojeda <ojeda@kernel.org>
CC: =?utf-8?B?5ZGo5bmzIChQaW5nIFpob3UvOTAzMik=?= <Ping.Zhou1@unisoc.com>,
        =?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>,
        =?utf-8?B?5p2o5Li95aicIChMaW5hIFlhbmcp?= <lina.yang@unisoc.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>,
        =?utf-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?=
	<shuang.wang@unisoc.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        Andrey Konovalov
	<andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino
	<vincenzo.frascino@arm.com>,
        "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?=
	<arve@android.com>,
        Todd Kjos <tkjos@android.com>, Martijn Coenen
	<maco@android.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Christian Brauner
	<christian@brauner.io>,
        Carlos Llamas <cmllamas@google.com>,
        "Suren
 Baghdasaryan" <surenb@google.com>,
        Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: =?utf-8?B?562U5aSNOiBNZWV0IGNvbXBpbGVkIGtlcm5lbCBiaW5hcmF5IGFibm9ybWFs?=
 =?utf-8?B?IGlzc3VlIHdoaWxlIGVuYWJsaW5nIGdlbmVyaWMga2FzYW4gaW4ga2VybmVs?=
 =?utf-8?Q?_6.12_with_some_default_KBUILD=5FRUSTFLAGS_on?=
Thread-Topic: Meet compiled kernel binaray abnormal issue while enabling
 generic kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS on
Thread-Index: Adv0awkF3quLQs5+RfaRTr3Yr7SnUQATGr8AACy4DEA=
Date: Tue, 15 Jul 2025 09:40:30 +0000
Message-ID: <c34f4f606eb04c38b64e8f3a658cd051@BJMBX01.spreadtrum.com>
References: <4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com>
 <202507150830.56F8U908028199@SHSPAM01.spreadtrum.com>
In-Reply-To: <202507150830.56F8U908028199@SHSPAM01.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 56F9eb1Q093836

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IE1pZ3VlbCBPamVkYSA8
b2plZGFAa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0N+aciDE15pelIDQ6MDUN
Cj4g5pS25Lu25Lq6OiDliJjmtbfnh5UgKEhhaXlhbiBMaXUpIDxoYWl5YW4ubGl1QHVuaXNvYy5j
b20+DQo+IOaKhOmAgTog5ZGo5bmzIChQaW5nIFpob3UvOTAzMikgPFBpbmcuWmhvdTFAdW5pc29j
LmNvbT47IOS7o+WtkOS4uiAoWml3ZWkgRGFpKSA8Wml3ZWkuRGFpQHVuaXNvYy5jb20+OyDmnajk
uL3lqJwgKExpbmEgWWFuZykNCj4gPGxpbmEueWFuZ0B1bmlzb2MuY29tPjsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBy
dXN0LWZvci1saW51eEB2Z2VyLmtlcm5lbC5vcmc7IOeOi+WPjA0KPiAoU2h1YW5nIFdhbmcpIDxz
aHVhbmcud2FuZ0B1bmlzb2MuY29tPjsgQW5kcmV5IFJ5YWJpbmluIDxyeWFiaW5pbi5hLmFAZ21h
aWwuY29tPjsgQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+Ow0KPiBBbmRy
ZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdtYWlsLmNvbT47IERtaXRyeSBWeXVrb3YgPGR2eXVr
b3ZAZ29vZ2xlLmNvbT47IFZpbmNlbnpvIEZyYXNjaW5vIDx2aW5jZW56by5mcmFzY2lub0Bhcm0u
Y29tPjsNCj4ga2FzYW4tZGV2QGdvb2dsZWdyb3Vwcy5jb207IEdyZWcgS3JvYWgtSGFydG1hbiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBBcnZlIEhqw7hubmV2w6VnIDxhcnZlQGFuZHJv
aWQuY29tPjsgVG9kZCBLam9zDQo+IDx0a2pvc0BhbmRyb2lkLmNvbT47IE1hcnRpam4gQ29lbmVu
IDxtYWNvQGFuZHJvaWQuY29tPjsgSm9lbCBGZXJuYW5kZXMgPGpvZWxhZ25lbGZAbnZpZGlhLmNv
bT47IENocmlzdGlhbiBCcmF1bmVyDQo+IDxjaHJpc3RpYW5AYnJhdW5lci5pbz47IENhcmxvcyBM
bGFtYXMgPGNtbGxhbWFzQGdvb2dsZS5jb20+OyBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBn
b29nbGUuY29tPjsgSmFtaWUgQ3VubGlmZmUNCj4gPEphbWllLkN1bmxpZmZlQGFybS5jb20+OyBD
YXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPg0KPiDkuLvpopg6IFJlOiBN
ZWV0IGNvbXBpbGVkIGtlcm5lbCBiaW5hcmF5IGFibm9ybWFsIGlzc3VlIHdoaWxlIGVuYWJsaW5n
IGdlbmVyaWMga2FzYW4gaW4ga2VybmVsIDYuMTIgd2l0aCBzb21lIGRlZmF1bHQgS0JVSUxEX1JV
U1RGTEFHUw0KPiBvbg0KPiANCj4gDQo+IOazqOaEjzog6L+Z5bCB6YKu5Lu25p2l6Ieq5LqO5aSW
6YOo44CC6Zmk6Z2e5L2g56Gu5a6a6YKu5Lu25YaF5a655a6J5YWo77yM5ZCm5YiZ5LiN6KaB54K5
5Ye75Lu75L2V6ZO+5o6l5ZKM6ZmE5Lu244CCDQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2lu
YXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlcg0KPiBh
bmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IA0KPiBPbiBNb24sIDE0IEp1
bCAyMDI1IDAzOjEyOjMzICswMDAwICLliJjmtbfnh5UgKEhhaXlhbiBMaXUpIiA8aGFpeWFuLmxp
dUB1bmlzb2MuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFmdGVyIEkgZGVsZXRlIHRoZSBydXN0IGJ1
aWxkIGZsYWdzLCB0aGUgYXNhbi5tb2R1bGVfY3RvciBiaW5hcnkgaXMgcmlnaHQgYW5kIGthc2Fu
IGZlYXR1cmUgd29ya3MgZmluZS5Db3VsZCB5b3UgaGVscCBjaGVjayB3aHkNCj4gS0JVSUxEX1JV
U1RGTEFHUyBpbXBhY3RzIGtlcm5lbCBjb21wbGljYXRpb24gd2l0aCBrYXNhbiBmZWF0dXJlIGVu
YWJsZWQgYW5kIGhvdyBjYW4gdGhpcyBpc3N1ZSBmaXhlZD8NCj4gDQo+IEkgYXNzdW1lIFJ1c3Qg
aXMgZW5hYmxlZCBpbiB0aGF0IGtlcm5lbCwgcmlnaHQ/IE9yIGRvIHlvdSBtZWFuIHRoYXQgc29t
ZWhvdyByZW1vdmluZyB0aG9zZSBsaW5lcyBmcm9tIHRoZSBgTWFrZWZpbGVgIG1ha2VzIHRoZSBp
c3N1ZSBnbw0KPiBhd2F5IGV2ZW4gaWYgUnVzdCBpcyBub3QgZW5hYmxlZD8NCiANClJ1c3QgaXMg
ZW5hYmxlZCBpbiBrZXJuZWwsIGFuZCBydXN0YyB2ZXJzaW9uIGlzIDEuODIuMC4gSSB3YW50IHRv
IGtub3cgd2h5IHRoZSBwYWNpc2FwL2F1dGlhc3AgYXJlIG5vdCBpbiBwYWlyLg0KDQo+IENvdWxk
IHlvdSBwbGVhc2Ugc2hhcmUgeW91ciBrZXJuZWwgY29tbWl0IGFuZCB0aGUgZnVsbCBjb25maWd1
cmF0aW9uPyBGcm9tIGEgcXVpY2sgYnVpbGQgYXJtNjQgS0FTQU4gaW4gdjYuMTIuMzgsIEkgc2Vl
IHRoZQ0KPiBgcGFjaWFzcGAvYGF1dGlhc3BgIHBhaXIgaW4gb25lIG9mIHRoZSBSdXN0IG9iamVj
dCBmaWxlczoNCg0KVGhlIGNvbW1pdCBjaGFuZ2VzIHRoZSBmcmFnbWVudCBhbmQgZGlmZiBpczoN
CitDT05GSUdfQ01ETElORT0ic3RhY2tfZGVwb3RfZGlzYWJsZT1vZmYga2FzYW4uc3RhY2t0cmFj
ZT1vbiBrYXNhbi5mYXVsdD1wYW5pYyBrdm0tYXJtLm1vZGU9cHJvdGVjdGVkIGNncm91cF9kaXNh
YmxlPXByZXNzdXJlIg0KK0NPTkZJR19LQVNBTl9HRU5FUklDPXkNCk9ubHkgdHdvIHJ1c3QtcmVs
YXRlZCBnbG9iYWwgdmFyaWFibGVzIGluIGZtci5ycyBhbmQgbGF5b3V0LnJzIGhhdmUgdGhpcyBp
c3N1ZS4gVGhlaXIgYXNhbi5tb2R1bGVfY3RvciBjb21wbGllZCBiaW5hcmllcyBhcmUgd3Jvbmcu
DQoNCj4gICAgIDAwMDAwMDAwMDAwMDAwMDAgPGFzYW4ubW9kdWxlX2N0b3I+Og0KPiAgICAgICAg
ICAgIDA6IGQ1MDMyMzNmICAgICAgICAgIHBhY2lhc3ANCj4gICAgICAgICAgICA0OiBmODFmMGZm
ZSAgICAgICAgICBzdHIgICAgIHgzMCwgW3NwLCAjLTB4MTBdIQ0KPiAgICAgICAgICAgIDg6IDkw
MDAwMDAwICAgICAgICAgIGFkcnAgICAgeDAsIDB4MCA8YXNhbi5tb2R1bGVfY3Rvcj4NCj4gICAg
ICAgICAgICBjOiA5MTAwMDAwMCAgICAgICAgICBhZGQgICAgIHgwLCB4MCwgIzB4MA0KPiAgICAg
ICAgICAgMTA6IDUyODAwNjAxICAgICAgICAgIG1vdiAgICAgdzEsICMweDMwICAgICAgICAgICAg
ICAgLy8gPTQ4DQo+ICAgICAgICAgICAxNDogOTQwMDAwMDAgICAgICAgICAgYmwgICAgICAweDE0
IDxhc2FuLm1vZHVsZV9jdG9yKzB4MTQ+DQo+ICAgICAgICAgICAxODogZjg0MTA3ZmUgICAgICAg
ICAgbGRyICAgICB4MzAsIFtzcF0sICMweDEwDQo+ICAgICAgICAgICAxYzogZDUwMzIzYmYgICAg
ICAgICAgYXV0aWFzcA0KPiAgICAgICAgICAgMjA6IGQ2NWYwM2MwICAgICAgICAgIHJldA0KPiAN
Cj4gQnV0IEkgYW0gZGVmaW5pdGVseSBub3QgYW4gZXhwZXJ0IGF0IGFsbCBpbiB0aGlzLCBzbyBD
YydpbmcgS0FTQU4gYW5kIEFuZHJvaWQgbWFpbnRhaW5lcnM6DQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3J1c3QtZm9yLWxpbnV4LzRjNDU5MDg1YjlhZTQyYmRiZjk5YjYwMTQ5NTJiOTY1QEJK
TUJYMDEuc3ByZWFkdHJ1bS5jb20vDQo+IA0KPiBDaGVlcnMsDQo+IE1pZ3VlbA0K

