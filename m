Return-Path: <linux-kernel+bounces-865273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E04EBFCA76
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D63118C090B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493B834C820;
	Wed, 22 Oct 2025 14:46:05 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB34035BDC9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144364; cv=none; b=JOhZLoITtawPdo5aaH8opVcYh+pPx+H3gX6eSzGtq65pfvzNbZzJzNWZxZ1k5Zz7uERTSS39t2MyEBctaKL8q+IdVDO0Dp26SmNaOpQSNUIdmyOtTY5GaczJzKAQ4ZyacfZhtfm4NUArQd9Cg1S0zdP9Z3KHhc796XmO+roItCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144364; c=relaxed/simple;
	bh=5c3Ea/p3qh2XsT/osMiBm24iydwTiHK8/YdhUV8WAzc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQrWXiJnIFWRMZWy9j1itm/bc8hBsVRrSIAkWZg55BM5NzmPhlc4bgnnjIbOkZQ5AU48VUGa4CRUfJVLjr8vNto/NBz6Asg1jNosheBOCqDUaN4qkIIQEpBRL7yA33JNLQQDkcu2fMaz8Rz2MvCYA78mx01xi+d9Mr3I1v81lO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-02.fintech.ru (10.0.10.19) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 22 Oct
 2025 17:45:55 +0300
Received: from Ex16-01.fintech.ru (10.0.10.18) by Ex16-02.fintech.ru
 (10.0.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 22 Oct
 2025 17:45:55 +0300
Received: from Ex16-01.fintech.ru ([fe80::2534:7600:5275:d3f9]) by
 Ex16-01.fintech.ru ([fe80::2534:7600:5275:d3f9%7]) with mapi id
 15.01.2242.004; Wed, 22 Oct 2025 17:45:55 +0300
From: =?utf-8?B?0JbQsNC90LTQsNGA0L7QstC40Ycg0J3QuNC60LjRgtCwINCY0LPQvtGA0LU=?=
 =?utf-8?B?0LLQuNGH?= <n.zhandarovich@fintech.ru>
To: Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
	<hsweeten@visionengravers.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hillf Danton
	<hdanton@sina.com>, "syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com"
	<syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH] comedi: drivers: do not detach device if driv->attach()
 fails
Thread-Topic: [PATCH] comedi: drivers: do not detach device if driv->attach()
 fails
Thread-Index: AQHcQoz/N5sZ+cmYV0yMvUjLGu7yJrTNyoGAgAASoYCAAGGtUA==
Date: Wed, 22 Oct 2025 14:45:55 +0000
Message-ID: <2760bded4e044bc888a7415bec8b2cd6@fintech.ru>
References: <20251021131656.164783-1-n.zhandarovich@fintech.ru>
 <fb39d407-622b-4480-a146-2e754f74bcbf@mev.co.uk>
 <df307a5e-811b-479d-a287-7a670a337bb2@mev.co.uk>
In-Reply-To: <df307a5e-811b-479d-a287-7a670a337bb2@mev.co.uk>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIEFiYm90dCA8YWJi
b3R0aUBtZXYuY28udWs+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyMiwgMjAyNSAyOjUy
IFBNDQo+IFRvOiDQltCw0L3QtNCw0YDQvtCy0LjRhyDQndC40LrQuNGC0LAg0JjQs9C+0YDQtdCy
0LjRhyA8bi56aGFuZGFyb3ZpY2hAZmludGVjaC5ydT47IEggSGFydGxleQ0KPiBTd2VldGVuIDxo
c3dlZXRlbkB2aXNpb25lbmdyYXZlcnMuY29tPg0KPiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBIaWxsZiBEYW50b24gPGhkYW50b25Ac2luYS5jb20+Ow0KPiBzeXpib3QrNjYxNmJiYTM1
OWNlYzdhMWRlZjFAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbTsgbHZjLQ0KPiBwcm9qZWN0QGxp
bnV4dGVzdGluZy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY29tZWRpOiBkcml2ZXJzOiBk
byBub3QgZGV0YWNoIGRldmljZSBpZiBkcml2LT5hdHRhY2goKQ0KPiBmYWlscw0KPiANCj4gT24g
MjIvMTAvMjAyNSAxMTo0NSwgSWFuIEFiYm90dCB3cm90ZToNCj4gPiBPbiAyMS8xMC8yMDI1IDE0
OjE2LCBOaWtpdGEgWmhhbmRhcm92aWNoIHdyb3RlOg0KPiA+PiBTeXpib3QgaWRlbnRpZmllZCBh
biBpc3N1ZSBbMV0gaW4gY29tZWRpX2RldmljZV9hdHRhY2goKSB0aGF0IG9jY3Vycw0KPiA+PiB3
aGVuIGtlcm5lbCBhdHRlbXB0cyB0byBkZXRhY2ggYSBjb21lZGkgZGV2aWNlIHZpYQ0KPiA+PiBj
b21lZGlfZGV2aWNlX2RldGFjaCgpIGV2ZW4gaWYgYSBkcml2ZXItc3BlY2lmaWMgYXR0YWNoKCkg
bWV0aG9kDQo+ID4+IGFscmVhZHkgZmFpbGVkLiBBdHRlbXB0cyB0byBmb2xsb3cgdGhyb3VnaCB3
aXRoIGRldGFjaGluZyB0aGUNCj4gPj4gZGV2aWNlIGFuZCB1bnJlZ2lzdGVyaW5nIHRoZSBkcml2
ZXIgdHJpZ2dlciBhIHdhcm5pbmcuDQo+ID4+DQo+ID4+IEZpeCB0aGlzIGJ5IHJlYXJyYW5naW5n
IGNsZWFudXAgY2FsbHMgc28gdGhhdCBjb21lZGlfZGV2aWNlX2RldGFjaCgpDQo+ID4+IHJ1bnMg
b25seSBpZiB0aGUgZGV2aWNlIGluIHF1ZXN0aW9uIGhhcyBiZWVuIHN1Y2Nlc3NmdWxseSBhdHRh
Y2hlZC4NCj4gPj4NCj4gPj4gT3JpZ2luYWwgaWRlYSBmb3IgdGhpcyBwYXRjaCBiZWxvbmdzIHRv
IEhpbGxmIERhbnRvbg0KPiA+PiA8aGRhbnRvbkBzaW5hLmNvbT4uDQo+ID4+DQo+ID4+IFsxXSBT
eXpib3QgY3Jhc2g6DQo+ID4+IFVuZXhwZWN0ZWQgZHJpdmVyIHVucmVnaXN0ZXIhDQo+ID4+IFdB
Uk5JTkc6IENQVTogMCBQSUQ6IDU5NzAgYXQgZHJpdmVycy9iYXNlL2RyaXZlci5jOjI3Mw0KPiA+
PiBkcml2ZXJfdW5yZWdpc3RlciBkcml2ZXJzL2Jhc2UvZHJpdmVyLmM6MjczIFtpbmxpbmVdDQo+
ID4+IFdBUk5JTkc6IENQVTogMCBQSUQ6IDU5NzAgYXQgZHJpdmVycy9iYXNlL2RyaXZlci5jOjI3
Mw0KPiA+PiBkcml2ZXJfdW5yZWdpc3RlcisweDkwLzB4YjAgZHJpdmVycy9iYXNlL2RyaXZlci5j
OjI3MA0KPiA+PiAuLi4NCj4gPj4gQ2FsbCBUcmFjZToNCj4gPj4gwqAgPFRBU0s+DQo+ID4+IMKg
IGNvbWVkaV9kZXZpY2VfZGV0YWNoX2xvY2tlZCsweDEyZi8weGE1MA0KPiBkcml2ZXJzL2NvbWVk
aS9kcml2ZXJzLmM6MjA3DQo+ID4+IMKgIGNvbWVkaV9kZXZpY2VfZGV0YWNoKzB4NjcvMHhiMCBk
cml2ZXJzL2NvbWVkaS9kcml2ZXJzLmM6MjE1DQo+ID4+IMKgIGNvbWVkaV9kZXZpY2VfYXR0YWNo
KzB4NDNkLzB4OTAwIGRyaXZlcnMvY29tZWRpL2RyaXZlcnMuYzoxMDExDQo+ID4+IMKgIGRvX2Rl
dmNvbmZpZ19pb2N0bCsweDFiMS8weDcxMCBkcml2ZXJzL2NvbWVkaS9jb21lZGlfZm9wcy5jOjg3
Mg0KPiA+PiDCoCBjb21lZGlfdW5sb2NrZWRfaW9jdGwrMHgxNjVkLzB4MmYwMA0KPiBkcml2ZXJz
L2NvbWVkaS9jb21lZGlfZm9wcy5jOjIxNzgNCj4gPj4gwqAgdmZzX2lvY3RsIGZzL2lvY3RsLmM6
NTEgW2lubGluZV0NCj4gPj4gwqAgX19kb19zeXNfaW9jdGwgZnMvaW9jdGwuYzo1OTcgW2lubGlu
ZV0NCj4gPj4gLi4uDQo+ID4+DQo+ID4+IFJlcG9ydGVkLWJ5Og0KPiBzeXpib3QrNjYxNmJiYTM1
OWNlYzdhMWRlZjFAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiA+PiBDbG9zZXM6DQo+IGh0
dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD02NjE2YmJhMzU5Y2VjN2ExZGVm
MQ0KPiA+PiBTdWdnZXN0ZWQtYnk6IEhpbGxmIERhbnRvbiA8aGRhbnRvbkBzaW5hLmNvbT4NCj4g
Pj4gRml4ZXM6IDc0ZWNlMTA4ZjllNSAoInN0YWdpbmc6IGNvbWVkaTogbW92ZSBkZXRhY2ggb3V0
IG9mIHBvc3QtY29uZmlnIikNCj4gPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4g
U2lnbmVkLW9mZi1ieTogTmlraXRhIFpoYW5kYXJvdmljaCA8bi56aGFuZGFyb3ZpY2hAZmludGVj
aC5ydT4NCj4gPj4gLS0tDQo+ID4+IMKgIGRyaXZlcnMvY29tZWRpL2RyaXZlcnMuYyB8IDkgKysr
KysrLS0tDQo+ID4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NvbWVkaS9kcml2ZXJzLmMg
Yi9kcml2ZXJzL2NvbWVkaS9kcml2ZXJzLmMNCj4gPj4gaW5kZXggYzllYmFhZGM1ZTgyLi4wMDEw
ODNmOTYxMzggMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvY29tZWRpL2RyaXZlcnMuYw0KPiA+
PiArKysgYi9kcml2ZXJzL2NvbWVkaS9kcml2ZXJzLmMNCj4gPj4gQEAgLTEwMDUsMTAgKzEwMDUs
MTMgQEAgaW50IGNvbWVkaV9kZXZpY2VfYXR0YWNoKHN0cnVjdA0KPiBjb21lZGlfZGV2aWNlDQo+
ID4+ICpkZXYsIHN0cnVjdCBjb21lZGlfZGV2Y29uZmlnICppdCkNCj4gPj4gwqDCoMKgwqDCoCBk
ZXYtPmJvYXJkX25hbWUgPSBkZXYtPmJvYXJkX3B0ciA/ICooY29uc3QgY2hhciAqKilkZXYtDQo+
ID5ib2FyZF9wdHINCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgOiBkZXYtPmRyaXZlci0+ZHJpdmVyX25hbWU7DQo+ID4+IMKgwqDCoMKgwqAgcmV0ID0g
ZHJpdi0+YXR0YWNoKGRldiwgaXQpOw0KPiA+PiAtwqDCoMKgIGlmIChyZXQgPj0gMCkNCj4gPj4g
K8KgwqDCoCBpZiAocmV0ID49IDApIHsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGNv
bWVkaV9kZXZpY2VfcG9zdGNvbmZpZyhkZXYpOw0KPiA+PiAtwqDCoMKgIGlmIChyZXQgPCAwKSB7
DQo+ID4+IC3CoMKgwqDCoMKgwqDCoCBjb21lZGlfZGV2aWNlX2RldGFjaChkZXYpOw0KPiA+PiAr
wqDCoMKgwqDCoMKgwqAgaWYgKHJldCA8IDApIHsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29tZWRpX2RldmljZV9kZXRhY2goZGV2KTsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbW9kdWxlX3B1dChkcml2LT5tb2R1bGUpOw0KPiA+PiArwqDCoMKgwqDCoMKgwqAgfQ0KPiA+
PiArwqDCoMKgIH0gZWxzZSB7DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCBtb2R1bGVfcHV0KGRy
aXYtPm1vZHVsZSk7DQo+ID4+IMKgwqDCoMKgwqAgfQ0KPiA+PiDCoMKgwqDCoMKgIC8qIE9uIHN1
Y2Nlc3MsIHRoZSBkcml2ZXIgbW9kdWxlIGNvdW50IGhhcyBiZWVuIGluY3JlbWVudGVkLiAqLw0K
PiA+DQo+ID4gVW5mb3J0dW5hdGVseSwgdGhlIGxvdy1sZXZlbCBkcml2ZXJzIGV4cGVjdCB0aGUg
YC0+ZGV0YWNoKClgIGhhbmRsZXIgdG8NCj4gPiBiZSBjYWxsZWQgdG8gY2xlYW4gdXAgZXZlbiBp
ZiB0aGUgYC0+YXR0YWNoKClgIGhhbmRsZXIgcmV0dXJucyBhbiBlcnJvci4NCj4gPiAgwqBTbyB0
aGlzIHdvbid0IHdvcmsuDQo+ID4NCj4gDQo+IFRoZSBwcm9ibGVtIHNlZW1zIHRvIGJlIHRoZSAi
YzZ4ZGlnaW8iIGRyaXZlcg0KPiAoImRyaXZlcnMvY29tZWRpL2RyaXZlcnMvYzZkaWdpby5jIiku
IEl0cyBjb21lZGkgYC0+YXR0YWNoKClgIGhhbmRsZXINCj4gYGM2ZGlnaW9fYXR0YWNoKClgIGNh
biByZXR1cm4gYW4gZXJyb3IgYmVmb3JlIHRoZSBjYWxsIHRvDQo+IGBwbnBfcmVnaXN0ZXJfZHJp
dmVyKClgLiAgQWxzbywgaXQgZG9lcyBub3QgY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBmcm9tDQo+
IGBwbnBfcmVnaXN0ZXJfZHJpdmVyKClgLiAgT24gZXJyb3IsIGNvbWVkaSB3aWxsIGNhbGwgdGhl
IGAtPmRldGFjaCgpYA0KPiBoYW5kbGVyIGBjNnhkaWdpb19kZXRhY2goKWAgd2hpY2ggY2FsbHMg
YHBucF91bnJlZ2lzdGVyX2RyaXZlcigpYA0KPiB1bmNvbmRpdGlvbmFsbHksIGxlYWRpbmcgdG8g
dGhlIHdhcm5pbmcgcmVwb3J0ZWQgYnkgU3l6Ym90Lg0KPiANCg0KWWVwLCB5b3UgYXJlIGFic29s
dXRlbHkgcmlnaHQuIEkgc2F3IHRoYXQgYzZkaWdpbyBtdXN0IGJlIHRvIGJsYW1lIGJ1dCBjb3Vs
ZCANCm5vdCBzZWUgdGhhdCBwbnAgc3R1ZmYgbmVlZGVkIG1vcmUgZmluZXNzZS4gSSdsbCBkZWZl
ciB0byB5b3Ugb24gdGhpcyBhcyBJIGNhbg0Kc2VlIHlvdXIgcGF0Y2ggYmVpbmcgYWxyZWFkeSB0
ZXN0ZWQgYnkgc3l6a2FsbGVyLg0KDQpUaGFua3MhDQoNCj4gLS0NCj4gLT0oIElhbiBBYmJvdHQg
PGFiYm90dGlAbWV2LmNvLnVrPiB8fCBNRVYgTHRkLiBpcyBhIGNvbXBhbnkgICk9LQ0KPiAtPSgg
cmVnaXN0ZXJlZCBpbiBFbmdsYW5kICYgV2FsZXMuICBSZWdkLiBudW1iZXI6IDAyODYyMjY4LiAg
KT0tDQo+IC09KCBSZWdkLiBhZGRyLjogUzExICYgMTIgQnVpbGRpbmcgNjcsIEV1cm9wYSBCdXNp
bmVzcyBQYXJrLCApPS0NCj4gLT0oIEJpcmQgSGFsbCBMYW5lLCBTVE9DS1BPUlQsIFNLMyAwWEEs
IFVLLiB8fCB3d3cubWV2LmNvLnVrICk9LQ0K

