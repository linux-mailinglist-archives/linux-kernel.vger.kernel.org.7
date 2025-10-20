Return-Path: <linux-kernel+bounces-861005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9F7BF18F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2051885769
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B196D3126DD;
	Mon, 20 Oct 2025 13:36:58 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8531197C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967418; cv=none; b=dXuKFbcNTh4YM7TXRqcHwvwL5JcnZoQXPaGpVWOofSHJC7OfmG32tOKYc5fWXLEgBfgYmGLSEhYELyrILJ/L2fMYQgMaToa5CRQSxIDUYNHf2A+9OUwAjup0nSBQblT/ujSspUBnBL6IQtRcBvGW3sFrSUWUyKsMN5nGvKRWI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967418; c=relaxed/simple;
	bh=R2r0ttQeYjXU3ks8wc0z5VyvyCo5ZRrYvVuJMk1CWcM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h28+35GegkJiO3OtL/seq1bDXxkrs4vDacjmqVZqfAezcq/gKUQGP6jQxH5lK1+10Ar37kJHK25cVSKZBt98HCXfVHY119yuWZuVYMtGTatWogJoyjTXO6YA8iiWcP7LExmyg0XWVsmrsQs1cQ6M+p7ffkgAdVoZIS37Xu5MQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-02.fintech.ru (10.0.10.19) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 20 Oct
 2025 16:36:44 +0300
Received: from Ex16-01.fintech.ru (10.0.10.18) by Ex16-02.fintech.ru
 (10.0.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 20 Oct
 2025 16:36:44 +0300
Received: from Ex16-01.fintech.ru ([fe80::2534:7600:5275:d3f9]) by
 Ex16-01.fintech.ru ([fe80::2534:7600:5275:d3f9%7]) with mapi id
 15.01.2242.004; Mon, 20 Oct 2025 16:36:44 +0300
From: =?utf-8?B?0JbQsNC90LTQsNGA0L7QstC40Ycg0J3QuNC60LjRgtCwINCY0LPQvtGA0LU=?=
 =?utf-8?B?0LLQuNGH?= <n.zhandarovich@fintech.ru>
To: Ian Abbott <abbotti@mev.co.uk>,
	"syzbot+af53dea94b16396bc646@syzkaller.appspotmail.com"
	<syzbot+af53dea94b16396bc646@syzkaller.appspotmail.com>, H Hartley Sweeten
	<hsweeten@visionengravers.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [syzbot] [kernel?] divide error in comedi_inc_scan_progress
Thread-Topic: [syzbot] [kernel?] divide error in comedi_inc_scan_progress
Thread-Index: AQHcPozEkTlGM219TUKRDTlUt6bqF7TKrfKAgABf70A=
Date: Mon, 20 Oct 2025 13:36:44 +0000
Message-ID: <d4f354f0972243bebe81c2c132ac95b3@fintech.ru>
References: <20251016110511.3460094-1-n.zhandarovich@fintech.ru>
 <9c92913c-c04b-4784-9cdc-5d75b10d2ed9@mev.co.uk>
In-Reply-To: <9c92913c-c04b-4784-9cdc-5d75b10d2ed9@mev.co.uk>
Accept-Language: en-US, ru-RU
Content-Language: ru-RU
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

SGkgSWFuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVzcG9uc2UhDQoNCj4gPiAgICAgIC4uLg0K
PiA+ICAgICAgaWYgKCEocy0+c3ViZGV2X2ZsYWdzICYgU0RGX1BBQ0tFRCkgJiYgKGNtZC0+Y2hh
bmxpc3RfbGVuICE9IDApKSB7DQo+ID4gCWFzeW5jLT5jdXJfY2hhbiArPSBjb21lZGlfYnl0ZXNf
dG9fc2FtcGxlcyhzLCBudW1fYnl0ZXMpOw0KPiA+IAlhc3luYy0+Y3VyX2NoYW4gJT0gY21kLT5j
aGFubGlzdF9sZW47DQo+ID4gICAgICB9DQo+ID4gICAgICAuLi4NCj4gPg0KPiA+IEFueSBzdWdn
ZXN0aW9ucyBhcmUgZ3JlYXRseSBhcHByZWNpYXRlZCENCj4gDQo+IEkgaGF2ZSBhIHBsYW4gdG8g
ZGVhbCB3aXRoIHRoZXNlIHVuZXhwZWN0ZWQgaW50ZXJydXB0cywgYXQgbGVhc3Qgd2l0aGluIHRo
ZQ0KPiBDb21lZGkgY29yZSBmdW5jdGlvbnMuICBUaGUgYmFzaWMgaWRlYSB3b3VsZCBiZSB0byBm
b3IgdGhlIENvbWVkaSBjb3JlDQo+IGZ1bmN0aW9ucyBjYWxsZWQgYnkgdGhlIElTUnMgdG8gY2hl
Y2sgdGhhdCB0aGUgc3ViZGV2aWNlIGlzIGluIHRoZSBydW5uaW5nIHN0YXRlDQo+IGFuZCBpbmNy
ZW1lbnQgYSByZWZlcmVuY2UgY291bnRlciAoZWl0aGVyIGEgcmVmY291bnRfdCBvciBhIHN0cnVj
dCBrcmVmKSBpZiBpdCBpcw0KPiBzYWZlIHRvIHByb2NlZWQuICBUaGVuIGl0IHdpbGwgYmUgYWxs
b3dlZCB0byBhc3N1bWUgdGhhdCB0aGUgc3RydWN0DQo+IGNvbWVkaV9hc3luYyBjb250ZW50cyBh
cmUgcmVhc29uYWJsZSB1bnRpbCBpdCBkZWNyZW1lbnRzIHRoZSByZWZlcmVuY2UNCj4gY291bnRl
ci4gIFNvbWUgb3RoZXIgdGFzayBtYXkgYmUgY2FsbGluZw0KPiBkb19iZWNvbWVfbm9uYnVzeSgp
IGluIHBhcmFsbGVsIHdpdGggdGhlIGFib3ZlLiAgQWZ0ZXINCj4gZG9fYmVjb21lX25vbmJ1c3ko
KSBjbGVhcnMgdGhlIENPTUVESV9TUkZfUlVOTklORyBmbGFnIHRvIG1hcmsgdGhlDQo+IHN1YmRl
dmljZSBhcyBub3QgYmVpbmcgaW4gdGhlIHJ1bm5pbmcgc3RhdGUsIGl0IHNob3VsZCB3YWl0IHVu
dGlsIGl0IGlzIHNhZmUgdG8NCj4gY29udGludWUgYmVmb3JlIGNhbGxpbmcgY29tZWRpX2J1Zl9y
ZXNldCgpLiAgVGhpcyB3aWxsIG1ha2UgdXNlIG9mIHRoZQ0KPiByZWZlcmVuY2UgY291bnRlciBh
bmQgYSBzdHJ1Y3QgY29tcGxldGlvbi4gIFRoZSByZWZlcmVuY2UgY291bnRlciBhbmQgc3RydWN0
DQo+IGNvbXBsZXRpb24gY2FuIGJlIHN0b3JlZCBhcyBtZW1iZXJzIG9mIHN0cnVjdCBjb21lZGlf
YXN5bmMuDQo+IA0KPiBUaGVyZSBtYXkgYmUgb3RoZXIgcGFydHMgb2YgaW5kaXZpZHVhbCBkcml2
ZXIgSVNScyB0aGF0IHVzZSBzdHJ1Y3QNCj4gY29tZWRpX2FzeW5jIGRpcmVjdGx5IGFuZCBtYXkg
bmVlZCBjaGFuZ2luZyB0byBkbyBzaW1pbGFyIGNoZWNrcy4gIFRoZQ0KPiBjaGVja2luZyBhbmQg
ZmluYWwgZGVjcmVtZW50IGNhbiBkb25lIGJ5IGEgY291cGxlIG9mIG5ldyBleHBvcnRlZA0KPiBm
dW5jdGlvbnM6DQo+IA0KPiBib29sIGNvbWVkaV9nZXRfaXNfc3ViZGV2aWNlX3J1bm5pbmcoc3Ry
dWN0IGNvbWVkaV9zdWJkZXZpY2UgKnMpOyB2b2lkDQo+IGNvbWVkaV9wdXRfaXNfc3ViZGV2aWNl
X3J1bm5pbmcoc3RydWN0IGNvbWVkaV9zdWJkZXZpY2UgKnMpOw0KPiANCj4gSWYgY29tZWRpX2dl
dF9pc19zdWJkZXZpY2VfcnVubmluZyhzKSByZXR1cm5zIHRydWUsIHRoZSBJU1IgY2FuIHNhZmVs
eQ0KPiBhY2Nlc3Mgcy0+YXN5bmMgYW5kIHRoZW4gc2hvdWxkIGNhbGwgY29tZWRpX3B1dF9pc19z
dWJkZXZpY2VfcnVubmluZyhzKQ0KPiB3aGVuIGl0IGhhcyBmaW5pc2hlZC4NCj4gDQo+IA0KDQpJ
J2xsIHRyeSB0byB0YWNrbGUgdGhpcyBpZGVhIHdoZW4gSSBnZXQgdGhlIGNoYW5jZSwgdGhhbmtz
IGZvciB5b3VyIHN1Z2dlc3Rpb24hDQoNCj4gPiBQLlMuIFRvIHJlaXRlcmF0ZSwgSSd2ZSBmYWls
ZWQgdG8gcmVwcm9kdWNlIHRoaXMgZXJyb3IgYW5kIHRoaXMgZmxhd2VkDQo+ID4gYW5hbHlzaXMg
aXMgdGhlb3JldGljYWwgb25seS4NCj4gPg0KPiA+IFsxXSBodHRwczovL3N5emthbGxlci5hcHBz
cG90LmNvbS9idWc/ZXh0aWQ9YWY1M2RlYTk0YjE2Mzk2YmM2NDYNCj4gPiBbMl0gaHR0cHM6Ly9z
eXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWY2YzNjMDY2MTYyZDJjNDNhNjZjDQo+ID4N
Cj4gPiBSZWdhcmRzLA0KPiA+IE5pa2l0YQ0KPiANCj4gDQo+IC0tDQo+IC09KCBJYW4gQWJib3R0
IDxhYmJvdHRpQG1ldi5jby51az4gfHwgTUVWIEx0ZC4gaXMgYSBjb21wYW55ICApPS0gLT0oDQo+
IHJlZ2lzdGVyZWQgaW4gRW5nbGFuZCAmIFdhbGVzLiAgUmVnZC4gbnVtYmVyOiAwMjg2MjI2OC4g
ICk9LSAtPSggUmVnZC4gYWRkci46DQo+IFMxMSAmIDEyIEJ1aWxkaW5nIDY3LCBFdXJvcGEgQnVz
aW5lc3MgUGFyaywgKT0tIC09KCBCaXJkIEhhbGwgTGFuZSwgU1RPQ0tQT1JULA0KPiBTSzMgMFhB
LCBVSy4gfHwgd3d3Lm1ldi5jby51ayApPS0NCg0KUmVnYXJkcywgTmlraXRhDQo=

