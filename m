Return-Path: <linux-kernel+bounces-757697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C282B1C5A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 706357A4BEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B828B4EF;
	Wed,  6 Aug 2025 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="HSokbQ+u"
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ACB18DB01;
	Wed,  6 Aug 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482496; cv=none; b=BJMxHJZ/EpD90qff+NMyrtK06+hb2/J29wF/Gy/Lzh9w9Z+yPFaBS4qXkHL9OGSD2rnu1P2zCtyz/61iUINox1swaWE7Mj1jf29krSiWt2yvbT/8do2HmC9tyip17gGEZlsWYS97THqSAp0Gf69rn6nIRo0hC/q1sN9UWtDPWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482496; c=relaxed/simple;
	bh=13aXrdq9n5uV9GofeOg/n4r/PFcpRJlUXucuVagEBKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLd0yJAVflFdlZorR6+/hsmE1vLcxqK9PmzBK63C0tdH0jvYfiE2NGlpaFpFxI2EZsWyI/W7ZnKhIMIvpO4Gws4pIpGBtF9FoaAgKYqMLky7af0IJuF+VWPkAQevTbkmrffJChneKYe4ShJQz4gFSljUEFIhgtXa4C0JE/GraBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=HSokbQ+u; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=13aXrdq9n5uV9GofeOg/n4r/PFcpRJlUXucuVagEBKE=; b=HSokbQ+u84qyGlDHP1IrxrXJv2
	5G60cRettZaiFEXkLd3XWkgyOxIyOgWcBP8uZ6ef101gwTM5Rzva8sgViTtAkTeFKg8DWkdE29PH7
	O2P5DNQul5UOB+y5SwmZbNbJjUCApQzJy/1OWeVdZT3lU0vQYuwhy9vpRBixjNENRnv3BuyzcAFgT
	QbJOu2WI3LifVfsg+ID1GllZJoS0YWfcZJf9QZn85nW19/jKIilYNM3noJD7yDx35SgE2AySJWnsR
	KeItQhF/1i6aMYwOO0cM8/b17Yub+sXG+UQn0wlm85xZDuWNJUy2kcBygCXmy7wxVUoRQQrSf+MGB
	T+5fP0pK+GrcB2VBAUAClAiXFwOok4+WBLLRuxG4J4vYsvzaC2VDINrkM4ADjnPqAXR15ZPL2Fy5s
	SFzvgHX0gKMDEK0QUoHl4x2cl9ea/IFKO96zGH21R2N6t9d7GOKNZGSv+wBrk89QiCN0PKrLBcDtT
	e3GbvVal5EeX3D4AWiQ/zeZL;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1ujd2h-001L8C-03;
	Wed, 06 Aug 2025 12:14:51 +0000
Message-ID: <d12e1d6a-d9e8-4bb3-abe4-9bcef1cb8f77@samba.org>
Date: Wed, 6 Aug 2025 14:14:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ksmbd: add kcov remote coverage support via ksmbd_conn
To: Yunseong Kim <ysk@kzalloc.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey
 <tom@talpey.com>, linux-cifs@vger.kernel.org, syzkaller@googlegroups.com,
 linux-kernel@vger.kernel.org, notselwyn@pwning.tech
References: <20250805155627.1605911-2-ysk@kzalloc.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20250805155627.1605911-2-ysk@kzalloc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgWXVuc2VvbmcsDQoNCkFtIDA1LjA4LjI1IHVtIDE3OjU2IHNjaHJpZWIgWXVuc2Vvbmcg
S2ltOg0KPiBLU01CRCBwcm9jZXNzZXMgU01CIHJlcXVlc3RzIG9uIHBlci1jb25uZWN0aW9u
IHRocmVhZHMgYW5kIHRoZW4gaGFuZHMNCj4gb2ZmIHdvcmsgaXRlbXMgdG8gYSBrd29ya2Vy
IHBvb2wgZm9yIGFjdHVhbCBjb21tYW5kIHByb2Nlc3NpbmcgYnkNCj4gaGFuZGxlX2tzbWJk
X3dvcmsoKS4gQmVjYXVzZSBlYWNoIGNvbm5lY3Rpb24gbWF5IGVucXVldWUgbXVsdGlwbGUN
Cj4gc3RydWN0IGtzbWJkX3dvcmsgaW5zdGFuY2VzLCBhdHRhY2hpbmcgdGhlIGtjb3YgaGFu
ZGxlIHRvIHRoZSB3b3JrDQo+IGl0c2VsZiBpcyBub3Qgc3VmZmljaWVudDogd2UgbmVlZCBh
IHN0YWJsZSwgcGVyLWNvbm5lY3Rpb24gaGFuZGxlLg0KPiANCj4gSW50cm9kdWNlIGEga2Nv
dl9oYW5kbGUgZmllbGQgb24gc3RydWN0IGtzbWJkX2Nvbm4gKHVuZGVyIENPTkZJR19LQ09W
KQ0KPiBhbmQgaW5pdGlhbGl6ZSBpdCB3aGVuIHRoZSBjb25uZWN0aW9uIGlzIHNldCB1cC4g
SW4gYm90aA0KPiBrc21iZF9jb25uX2hhbmRsZXJfbG9vcCgpIHdoaWNoIG9ubHkgcmVjZWl2
ZXMgYSBzdHJ1Y3Qga3NtYmRfY29ubioNCj4gYW5kIGhhbmRsZV9rc21iZF93b3JrKCkgd2hp
Y2ggcmVjZWl2ZXMgYSBzdHJ1Y3Qga3NtYmRfd29yayosIHN0YXJ0DQo+IGtjb3ZfcmVtb3Rl
IHdpdGggdGhlIHBlci1jb25uZWN0aW9uIGhhbmRsZSBiZWZvcmUgcHJvY2Vzc2luZyBhbmQg
c3RvcA0KPiBpdCBhZnRlcndhcmQuIFRoaXMgZW5zdXJlcyBjb3ZlcmFnZSBjb2xsZWN0aW9u
IHJlbWFpbnMgYWN0aXZlIGFjcm9zcw0KPiB0aGUgZW50aXJlIGFzeW5jaHJvbm91cyBwYXRo
IG9mIGVhY2ggU01CIHJlcXVlc3QuDQo+IA0KPiBUaGUga2NvdiBjb250ZXh0IHRpZWQgdG8g
dGhlIGNvbm5lY3Rpb24gaXRzZWxmLCBjb3JyZWN0bHkgc3VwcG9ydGluZw0KPiBtdWx0aXBs
ZSBvdXRzdGFuZGluZyB3b3JrIGl0ZW1zIHBlciBjb25uZWN0aW9uLg0KPiANCj4gVGhlIHJl
bGF0ZWQgd29yayBmb3Igc3l6a2FsbGVyIHN1cHBvcnQgaXMgY3VycmVudGx5IGJlaW5nIGRl
dmVsb3BlZA0KPiBpbiB0aGUgZm9sbG93aW5nIEdpdEh1YiBQUjoNCj4gTGluazogaHR0cHM6
Ly9naXRodWIuY29tL2dvb2dsZS9zeXprYWxsZXIvcHVsbC81NTI0DQo+IA0KPiBCYXNlZCBv
biBlYXJsaWVyIHdvcmsgYnkgTGF1Lg0KPiBMaW5rOiBodHRwczovL3B3bmluZy50ZWNoL2tz
bWJkLXN5emthbGxlci8NCj4gDQo+IENjOiBsaW51eC1jaWZzQHZnZXIua2VybmVsLm9yZw0K
PiBDYzogbm90c2Vsd3luQHB3bmluZy50ZWNoDQo+IFNpZ25lZC1vZmYtYnk6IFl1bnNlb25n
IEtpbSA8eXNrQGt6YWxsb2MuY29tPg0KPiAtLS0NCj4gICBmcy9zbWIvc2VydmVyL2Nvbm5l
Y3Rpb24uYyB8ICA0ICsrKy0NCj4gICBmcy9zbWIvc2VydmVyL2Nvbm5lY3Rpb24uaCB8IDE0
ICsrKysrKysrKysrKysrDQo+ICAgZnMvc21iL3NlcnZlci9zZXJ2ZXIuYyAgICAgfCAgNCAr
KysrDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvc21iL3NlcnZlci9jb25uZWN0aW9uLmMgYi9m
cy9zbWIvc2VydmVyL2Nvbm5lY3Rpb24uYw0KPiBpbmRleCAzZjA0YTI5NzdiYTguLjZjZTIw
YWVlOGNjMSAxMDA2NDQNCj4gLS0tIGEvZnMvc21iL3NlcnZlci9jb25uZWN0aW9uLmMNCj4g
KysrIGIvZnMvc21iL3NlcnZlci9jb25uZWN0aW9uLmMNCj4gQEAgLTMyMiw2ICszMjIsOCBA
QCBpbnQga3NtYmRfY29ubl9oYW5kbGVyX2xvb3Aodm9pZCAqcCkNCj4gICAJaWYgKHQtPm9w
cy0+cHJlcGFyZSAmJiB0LT5vcHMtPnByZXBhcmUodCkpDQo+ICAgCQlnb3RvIG91dDsNCj4g
ICANCj4gKwlrY292X3JlbW90ZV9zdGFydF9jb21tb24oa3NtYmRfY29ubl9nZXRfa2Nvdl9o
YW5kbGUoY29ubikpOw0KPiArDQo+ICAgCW1heF9yZXEgPSBzZXJ2ZXJfY29uZi5tYXhfaW5m
bGlnaHRfcmVxOw0KPiAgIAljb25uLT5sYXN0X2FjdGl2ZSA9IGppZmZpZXM7DQo+ICAgCXNl
dF9mcmVlemFibGUoKTsNCj4gQEAgLTQxMiw3ICs0MTQsNyBAQCBpbnQga3NtYmRfY29ubl9o
YW5kbGVyX2xvb3Aodm9pZCAqcCkNCj4gICAJCQlicmVhazsNCj4gICAJCX0NCj4gICAJfQ0K
PiAtDQo+ICsJa2Nvdl9yZW1vdGVfc3RvcCgpOw0KPiAgIG91dDoNCj4gICAJa3NtYmRfY29u
bl9zZXRfcmVsZWFzaW5nKGNvbm4pOw0KPiAgIAkvKiBXYWl0IHRpbGwgYWxsIHJlZmVyZW5j
ZSBkcm9wcGVkIHRvIHRoZSBTZXJ2ZXIgb2JqZWN0Ki8NCj4gZGlmZiAtLWdpdCBhL2ZzL3Nt
Yi9zZXJ2ZXIvY29ubmVjdGlvbi5oIGIvZnMvc21iL3NlcnZlci9jb25uZWN0aW9uLmgNCj4g
aW5kZXggZGQzZTBlM2Y3YmYwLi4wN2NkMGQyN2FjNzcgMTAwNjQ0DQo+IC0tLSBhL2ZzL3Nt
Yi9zZXJ2ZXIvY29ubmVjdGlvbi5oDQo+ICsrKyBiL2ZzL3NtYi9zZXJ2ZXIvY29ubmVjdGlv
bi5oDQo+IEBAIC0xNSw2ICsxNSw3IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L2t0aHJlYWQu
aD4NCj4gICAjaW5jbHVkZSA8bGludXgvbmxzLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3Vu
aWNvZGUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9rY292Lmg+DQo+ICAgDQo+ICAgI2luY2x1
ZGUgInNtYl9jb21tb24uaCINCj4gICAjaW5jbHVkZSAia3NtYmRfd29yay5oIg0KPiBAQCAt
MTA5LDYgKzExMCw5IEBAIHN0cnVjdCBrc21iZF9jb25uIHsNCj4gICAJYm9vbAkJCQliaW5k
aW5nOw0KPiAgIAlhdG9taWNfdAkJCXJlZmNudDsNCj4gICAJYm9vbAkJCQlpc19hYXBsOw0K
PiArI2lmZGVmIENPTkZJR19LQ09WDQo+ICsJdTY0CQkJCWtjb3ZfaGFuZGxlOw0KPiArI2Vu
ZGlmDQo+ICAgfTsNCj4gICANCj4gICBzdHJ1Y3Qga3NtYmRfY29ubl9vcHMgew0KPiBAQCAt
MjQ2LDQgKzI1MCwxNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQga3NtYmRfY29ubl9zZXRfcmVs
ZWFzaW5nKHN0cnVjdCBrc21iZF9jb25uICpjb25uKQ0KPiAgIH0NCj4gICANCj4gICB2b2lk
IGtzbWJkX2FsbF9jb25uX3NldF9zdGF0dXModTY0IHNlc3NfaWQsIHUzMiBzdGF0dXMpOw0K
PiArDQo+ICtzdGF0aWMgaW5saW5lIHU2NCBrc21iZF9jb25uX2dldF9rY292X2hhbmRsZShz
dHJ1Y3Qga3NtYmRfY29ubiAqY29ubikNCj4gK3sNCj4gKyNpZmRlZiBDT05GSUdfS0NPVg0K
PiArCXJldHVybiBjb25uLT5rY292X2hhbmRsZTsNCj4gKyNlbHNlDQo+ICsJcmV0dXJuIDA7
DQo+ICsjZW5kaWYNCj4gK30NCg0KDQpjb25uLT5rY292X2hhbmRsZSBpcyBhIG5ldyBlbGVt
ZW50IGluIGtzbWJkX2Nvbm4NCmFuZCBJIGNhbid0IGZpbmQgdGhlIHBsYWNlIGluIHRoaXMg
cGF0Y2ggd2hlcmUgaXQgaXMgaW5pdGlhbGl6ZWQuLi4NCg0KbWV0emUNCg0KDQo=

