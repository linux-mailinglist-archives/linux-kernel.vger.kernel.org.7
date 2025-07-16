Return-Path: <linux-kernel+bounces-732983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D1EB06E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E7F504C14
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DDC28937A;
	Wed, 16 Jul 2025 07:02:04 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E35288C37
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649323; cv=none; b=mKvF0BYmct/f4T/jXkYB+CbQYlX0JzaKYzA+jYEeUnGGAreMV3RvfDbIlLeadk7nFJWaJukIND9TlX/70frHB06HSrbmZNMSHAPmyxYmeZzBrubQekNK96stU72+FShmh+I9oLNsyKMFvM1qlZgBAzojuO7H7evihOA53JK3FiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649323; c=relaxed/simple;
	bh=l1mCwU/UAqJpitjQKQAf0VtDhJtI7nZ/jUOaeDsPe6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jj5F3n73YTAHNUmuoPMFhvmLvaB7ZS9JCxtCQPg5SI6X5ZVzVogSNAETbBNhxeaNh1KCmDcwNGIa2RMxFbOJTwXQhmkhkBby4dEdgPYLQT44jNPskNasHx3+U7ozTM39gXmdFl5vQJwD7Suy36gIQ0exnhgmro8tv8u9myBE23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 56G71YUo039376;
	Wed, 16 Jul 2025 15:01:34 +0800 (+08)
	(envelope-from haiyan.liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4bhn176KQXz2K5mNX;
	Wed, 16 Jul 2025 14:57:15 +0800 (CST)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 16 Jul
 2025 15:01:29 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.048; Wed, 16 Jul 2025 15:01:29 +0800
From: =?utf-8?B?5YiY5rW354eVIChIYWl5YW4gTGl1KQ==?= <haiyan.liu@unisoc.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Miguel Ojeda <ojeda@kernel.org>,
        =?utf-8?B?5ZGo5bmzIChQaW5nIFpob3UvOTAzMik=?= <Ping.Zhou1@unisoc.com>,
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
Subject: Meet compiled kernel binaray abnormal issue while enabling generic
 kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS on
Thread-Topic: Meet compiled kernel binaray abnormal issue while enabling
 generic kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS on
Thread-Index: Adv0awkF3quLQs5+RfaRTr3Yr7SnUQATGr8AACy4DEAAAOVlAAAqFjnw
Date: Wed, 16 Jul 2025 07:01:29 +0000
Message-ID: <24e87f60203c443abe7549ce5c0e9e75@BJMBX01.spreadtrum.com>
References: <4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com>
 <202507150830.56F8U908028199@SHSPAM01.spreadtrum.com>
 <c34f4f606eb04c38b64e8f3a658cd051@BJMBX01.spreadtrum.com>
 <CANiq72=v6jkOasLiem7RXe-WUSg9PkNqrZneeMOTi1pzwXuHYg@mail.gmail.com>
In-Reply-To: <CANiq72=v6jkOasLiem7RXe-WUSg9PkNqrZneeMOTi1pzwXuHYg@mail.gmail.com>
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
X-MAIL:SHSQR01.spreadtrum.com 56G71YUo039376

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IE1pZ3VlbCBPamVkYSA8
bWlndWVsLm9qZWRhLnNhbmRvbmlzQGdtYWlsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0
N+aciDE25pelIDE6NTENCj4g5pS25Lu25Lq6OiDliJjmtbfnh5UgKEhhaXlhbiBMaXUpIDxoYWl5
YW4ubGl1QHVuaXNvYy5jb20+DQo+IOaKhOmAgTogTWlndWVsIE9qZWRhIDxvamVkYUBrZXJuZWwu
b3JnPjsg5ZGo5bmzIChQaW5nIFpob3UvOTAzMikgPFBpbmcuWmhvdTFAdW5pc29jLmNvbT47IOS7
o+WtkOS4uiAoWml3ZWkgRGFpKQ0KPiA8Wml3ZWkuRGFpQHVuaXNvYy5jb20+OyDmnajkuL3lqJwg
KExpbmEgWWFuZykgPGxpbmEueWFuZ0B1bmlzb2MuY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBydXN0LWZv
ci1saW51eEB2Z2VyLmtlcm5lbC5vcmc7IOeOi+WPjCAoU2h1YW5nIFdhbmcpIDxzaHVhbmcud2Fu
Z0B1bmlzb2MuY29tPjsgQW5kcmV5IFJ5YWJpbmluDQo+IDxyeWFiaW5pbi5hLmFAZ21haWwuY29t
PjsgQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+OyBBbmRyZXkgS29ub3Zh
bG92IDxhbmRyZXlrbnZsQGdtYWlsLmNvbT47IERtaXRyeSBWeXVrb3YNCj4gPGR2eXVrb3ZAZ29v
Z2xlLmNvbT47IFZpbmNlbnpvIEZyYXNjaW5vIDx2aW5jZW56by5mcmFzY2lub0Bhcm0uY29tPjsg
a2FzYW4tZGV2QGdvb2dsZWdyb3Vwcy5jb207IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBBcnZlIEhqw7hubmV2w6VnIDxhcnZlQGFuZHJvaWQuY29t
PjsgVG9kZCBLam9zIDx0a2pvc0BhbmRyb2lkLmNvbT47IE1hcnRpam4gQ29lbmVuDQo+IDxtYWNv
QGFuZHJvaWQuY29tPjsgSm9lbCBGZXJuYW5kZXMgPGpvZWxhZ25lbGZAbnZpZGlhLmNvbT47IENo
cmlzdGlhbiBCcmF1bmVyIDxjaHJpc3RpYW5AYnJhdW5lci5pbz47IENhcmxvcyBMbGFtYXMNCj4g
PGNtbGxhbWFzQGdvb2dsZS5jb20+OyBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBnb29nbGUu
Y29tPjsgSmFtaWUgQ3VubGlmZmUgPEphbWllLkN1bmxpZmZlQGFybS5jb20+OyBDYXRhbGluIE1h
cmluYXMNCj4gPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPg0KPiDkuLvpopg6IFJlOiBNZWV0IGNv
bXBpbGVkIGtlcm5lbCBiaW5hcmF5IGFibm9ybWFsIGlzc3VlIHdoaWxlIGVuYWJsaW5nIGdlbmVy
aWMga2FzYW4gaW4ga2VybmVsIDYuMTIgd2l0aCBzb21lIGRlZmF1bHQgS0JVSUxEX1JVU1RGTEFH
Uw0KPiBvbg0KPiANCj4gDQo+IOazqOaEjzog6L+Z5bCB6YKu5Lu25p2l6Ieq5LqO5aSW6YOo44CC
6Zmk6Z2e5L2g56Gu5a6a6YKu5Lu25YaF5a655a6J5YWo77yM5ZCm5YiZ5LiN6KaB54K55Ye75Lu7
5L2V6ZO+5o6l5ZKM6ZmE5Lu244CCDQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBm
cm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlcg0KPiBhbmQga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IA0KPiBPbiBUdWUsIEp1bCAxNSwgMjAy
NSBhdCAxMTo0MeKAr0FNIOWImOa1t+eHlSAoSGFpeWFuIExpdSkgPGhhaXlhbi5saXVAdW5pc29j
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgY29tbWl0IGNoYW5nZXMgdGhlIGZyYWdtZW50IGFu
ZCBkaWZmIGlzOg0KPiANCj4gQW4gQW5kcm9pZCBlbmdpbmVlciBzaG91bGQga25vdyBob3cgdG8g
aGFuZGxlIHRoYXQsIGJ1dCBpZiB5b3UgYXJlIHJlcG9ydGluZyB1cHN0cmVhbSwgaXQgaXMgYmVz
dCB0byB0cnkgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSB3aXRoIHRoZQ0KPiB1cHN0cmVhbSBrZXJu
ZWxzIChlLmcuIGFybTY0IGlzIG5vdCBpbiA2LjYueSkgYW5kIHByb3ZpZGUgdGhlIGZ1bGwga2Vy
bmVsIGNvbmZpZyB1c2VkLg0KPiANCj4gPiBPbmx5IHR3byBydXN0LXJlbGF0ZWQgZ2xvYmFsIHZh
cmlhYmxlcyBpbiBmbXIucnMgYW5kIGxheW91dC5ycyBoYXZlIHRoaXMgaXNzdWUuIFRoZWlyIGFz
YW4ubW9kdWxlX2N0b3IgY29tcGxpZWQgYmluYXJpZXMgYXJlIHdyb25nLg0KPiANCj4gSSBhbSBu
b3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGJ5IGBmbXIucnNgLiBBcyBmb3IgYGxheW91dC5yc2AsIHRo
YXQgaXMgaW4gdGhlIGBrZXJuZWxgIGNyYXRlIGluIDYuMTIueSAtLSBpc24ndCB0aGVyZSBhIHNp
bmdsZSBgYXNhbi5tb2R1bGVfY3RvcmANCj4gcGVyIFRVPyBXaGljaCBvYmplY3QgZmlsZSBhcmUg
eW91IHJlZmVycmluZyB0bz8gSSBnZXQgdGhlIHBhaXIgZm9yIG15IGBydXN0L2tlcm5lbC5vYC4N
Cg0KICBOU1g6RkZGRkZGQzA4MDBBN0M5NHxGODAwODY1RSAgYXNhbi5tb2R1bGVfY3RvcjogICBz
dHIgICAgIHgzMCxbeDE4XSwjMHg4ICAgOyB4MzAsW3gxOF0sIzgNCiAgIE5TWDpGRkZGRkZDMDgw
MEE3Qzk4fEY4MUYwRkZFICAgICAgICAgICAgICAgICAgICAgIHN0ciAgICAgeDMwLFtzcCwjLTB4
MTBdISAgIDsgeDMwLFtzcCwjLTE2XSENCiAgIE5TWDpGRkZGRkZDMDgwMEE3QzlDfEYwMDI0MEEw
ICAgICAgICAgICAgICAgICAgICAgIGFkcnAgICAgeDAsMHhGRkZGRkZDMDg0OEJFMDAwDQogICBO
U1g6RkZGRkZGQzA4MDBBN0NBMHw5MTFEODAwMCAgICAgICAgICAgICAgICAgICAgICBhZGQgICAg
IHgwLHgwLCMweDc2MCAgICAgOyB4MCx4MCwjMTg4OA0KICAgTlNYOkZGRkZGRkMwODAwQTdDQTR8
NTI4MDNENjEgICAgICAgICAgICAgICAgICAgICAgbW92ICAgICB3MSwjMHgxRUIgICAgICAgIDsg
dzEsIzQ5MQ0KICAgTlNYOkZGRkZGRkMwODAwQTdDQTh8OTQyMzM4MTYgICAgICAgICAgICAgICAg
ICAgICAgYmwgICAgICAweEZGRkZGRkMwODA5NzVEMDAgICA7IF9fYXNhbl9yZWdpc3Rlcl9nbG9i
YWxzDQogICBOU1g6RkZGRkZGQzA4MDBBN0NBQ3xGODQxMDdGRSAgICAgICAgICAgICAgICAgICAg
ICBsZHIgICAgIHgzMCxbc3BdLCMweDEwICAgOyB4MzAsW3NwXSwjMTYNCiAgIE5TWDpGRkZGRkZD
MDgwMEE3Q0IwfEQ1MDMyM0JGICAgICAgICAgICAgICAgICAgICAgIGF1dGlhc3ANCiAgIE5TWDpG
RkZGRkZDMDgwMEE3Q0I0fEQ2NUYwM0MwICAgICAgICAgICAgICAgICAgICAgIHJldA0KVGhlIGZp
cnN0IF9fYXNhbl9nbG9iYWwgc3RydWN0IHZhbHVlIGlzIA0KIEVOQVhJOkZGRkZGRkMwODQ4QkU3
NjB8PkZGRkZGRkMwODJFREIxODAgMDAwMDAwMDAwMDAwMDA1RiAuLi4uLi4uLl8uLi4uLi4uDQog
RU5BWEk6RkZGRkZGQzA4NDhCRTc3MHwgMDAwMDAwMDAwMDAwMDA4MCBGRkZGRkZDMDgzNkRDNDMx
IC4uLi4uLi4uMS5tLi4uLi4NCiBFTkFYSTpGRkZGRkZDMDg0OEJFNzgwfCBGRkZGRkZDMDgyRUVD
NzgwIDAwMDAwMDAwMDAwMDAwMDAgLi4uLi4uLi4uLi4uLi4uLg0KIEVOQVhJOkZGRkZGRkMwODQ4
QkU3OTB8IDAwMDAwMDAwMDAwMDAwMDAgRkZGRkZGRkZGRkZGRkZGRiAuLi4uLi4uLi4uLi4uLi4u
DQpUaGUgYWRkcmVzcyBvZiB0aGUgZ2xvYmFsIGlzIDB4RkZGRkZGQzA4MkVEQjE4MCB3aGljaCB2
YWx1ZSBpcyAnL3Byb2Mvc2VsZi9jd2QvcHJlYnVpbHRzL3J1c3QvbGludXgteDg2LzEuODIuMC9s
aWIvcnVzdGxpYi9zcmMvcnVzdC9saWJyYXJ5L2NvcmUvc3JjL251bS9mbXQucnMnIGFuZCBpdHMg
dmlld2luZm8gaXMgJ3ZtbGludXhcR2xvYmFsXF9fdW5uYW1lZF8zNTcnDQpUaGUgb3JpZ2luYWwg
c2l6ZSBvZiB0aGUgZ2xvYmFsIGlzIDB4NUYNClRoZSBuYW1lIG9mIHRoZSBnbG9iYWwgaXMga21h
bGxvYy0yaw0KVGhlIG1vZHVsZSBuYW1lIG9mIHRoZSBnbG9iYWwgaXMgJ2NvcmUuMjc3NTg5MDRj
Y2VlNGM4MC1jZ3UubycNCg0KICAgTlNYOkZGRkZGRkMwODAwQTdENEN8RjgwMDg2NUUgIGFzYW4u
bW9kLjpzdHIgICAgIHgzMCxbeDE4XSwjMHg4ICAgOyB4MzAsW3gxOF0sIzgNCiAgIE5TWDpGRkZG
RkZDMDgwMEE3RDUwfEY4MUYwRkZFICAgICAgICAgICAgc3RyICAgICB4MzAsW3NwLCMtMHgxMF0h
ICAgOyB4MzAsW3NwLCMtMTZdIQ0KICAgTlNYOkZGRkZGRkMwODAwQTdENTR8RjAwMjQwRTAgICAg
ICAgICAgICBhZHJwICAgIHgwLDB4RkZGRkZGQzA4NDhDNjAwMA0KICAgTlNYOkZGRkZGRkMwODAw
QTdENTh8OTEyRTgwMDAgICAgICAgICAgICBhZGQgICAgIHgwLHgwLCMweEJBMCAgICAgOyB4MCx4
MCwjMjk3Ng0KICAgTlNYOkZGRkZGRkMwODAwQTdENUN8NTI4MDA5NjEgICAgICAgICAgICBtb3Yg
ICAgIHcxLCMweDRCICAgICAgICAgOyB3MSwjNzUNCiAgIE5TWDpGRkZGRkZDMDgwMEE3RDYwfDk0
MjMzN0U4ICAgICAgICAgICAgYmwgICAgICAweEZGRkZGRkMwODA5NzVEMDAgICA7IF9fYXNhbl9y
ZWdpc3Rlcl9nbG9iYWxzDQogICBOU1g6RkZGRkZGQzA4MDBBN0Q2NHxGODQxMDdGRSAgICAgICAg
ICAgIGxkciAgICAgeDMwLFtzcF0sIzB4MTAgICA7IHgzMCxbc3BdLCMxNg0KICAgTlNYOkZGRkZG
RkMwODAwQTdENjh8RDUwMzIzQkYgICAgICAgICAgICBhdXRpYXNwDQogICBOU1g6RkZGRkZGQzA4
MDBBN0Q2Q3xENjVGMDNDMCAgICAgICAgICAgIHJldA0KVGhlIHNlY29uZCBfX2FzYW5fZ2xvYmFs
IHN0cnVjdCB2YWx1ZSBpcyANCiAgIE5TRDpGRkZGRkZDMDg0OEM2QkEwfD5GRkZGRkZDMDgyRUVD
QTgwIDAwMDAwMDAwMDAwMDAwMjAgLi4uLi4uLi4gLi4uLi4uLg0KICAgTlNEOkZGRkZGRkMwODQ4
QzZCQjB8IDAwMDAwMDAwMDAwMDAwNDAgRkZGRkZGQzA4MzZEQzQzMSBALi4uLi4uLjEubS4uLi4u
DQogICBOU0Q6RkZGRkZGQzA4NDhDNkJDMHwgRkZGRkZGQzA4MkVFREE4MCAwMDAwMDAwMDAwMDAw
MDAwIC4uLi4uLi4uLi4uLi4uLi4NCiAgIE5TRDpGRkZGRkZDMDg0OEM2QkQwfCAwMDAwMDAwMDAw
MDAwMDAwIEZGRkZGRkZGRkZGRkZGRkYgLi4uLi4uLi4uLi4uLi4uLg0KVGhlIGFkZHJlc3Mgb2Yg
dGhlIGdsb2JhbCBpcyAweEZGRkZGRkMwODJFRUNBODAgd2hpY2ggdmFsdWUgaXMgMCBhbmQgaXRz
IHZpZXdpbmZvIGlzICc8JnVzaXplX2FzX2NvcmU6OmYuLnZtbGludXhca2VybmVsXzlhNmNiOWZk
N2M4ZGZkNjZfY2d1XDwmdXNpemVfYXNfY29yZTo6Zm10OjpEZWJ1Zz46Ont2dGFibGV9Jw0KVGhl
IG9yaWdpbmFsIHNpemUgb2YgdGhlIGdsb2JhbCBpcyAweDIwDQpUaGUgbmFtZSBvZiB0aGUgZ2xv
YmFsIGlzIGttYWxsb2MtMmsNClRoZSBtb2R1bGUgbmFtZSBvZiB0aGUgZ2xvYmFsIGlzICdrZXJu
ZWwuOWE2Y2I5ZmQ3YzhkZmQ2Ni1jZ3UubycNCg0KPiBDaGVlcnMsDQo+IE1pZ3VlbA0K

