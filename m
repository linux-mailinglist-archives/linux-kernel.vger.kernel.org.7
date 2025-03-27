Return-Path: <linux-kernel+bounces-578065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C263A72A51
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 07:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9C5174ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 06:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EF01C84B1;
	Thu, 27 Mar 2025 06:59:06 +0000 (UTC)
Received: from invmail.skhynix.com (exvmail.skhynix.com [166.125.252.79])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E761C6889
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743058745; cv=none; b=RkbNS5MfO2O1O7P645hTD4PQPZZdbkxxDafy7YYMAHKhSJIJtndXtyrjISTvW65GOCQNgT2+YRvqyOLhF1z8h86l8vbZBPcSjUl55RXy+BrwPh0oMna6BUrlQbHVmmxki3WFILIR/C2n0PZ+gpzjNyMH5F/VLIt9Z5h1MMqjABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743058745; c=relaxed/simple;
	bh=qilFpGbta7/gcGLItWMYaKO9y4dlnH2ag6LWOQTDfyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uk/VOibQTqINTTvXlsjGQR0+ko+hDf9FyM2qiJ5zSu8pw02kIsQ3wTT/qlfFZEXUe4U1Y+GBOxQvH1sgVhkNYrtVhjUjcUti/hyZrTCJZSmcctZXGbJNBKHR5C/raOVKWTmZtduvbeNl+QDEuvWMR4QjGtKfivqMmNpt5uEG824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc4e-97bff70000022046-14-67e4f3a7d992
Received: from hymail21.hynixad.com (10.156.135.51) by hymail23.hynixad.com
 (10.156.135.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.14; Thu, 27 Mar
 2025 15:43:51 +0900
Received: from hymail21.hynixad.com ([10.156.135.51]) by hymail21.hynixad.com
 ([10.156.135.51]) with mapi id 15.02.1544.014; Thu, 27 Mar 2025 15:43:51
 +0900
From: =?utf-8?B?7KCV7JqU7ZWcKEpPVU5HIFlPSEFOKSBNb2JpbGUgQUU=?=
	<yohan.joung@sk.com>
To: Chao Yu <chao@kernel.org>, Yohan Joung <jyh429@gmail.com>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, "daeho43@gmail.com"
	<daeho43@gmail.com>
CC: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	=?utf-8?B?6rmA7ZWE7ZiEKEtJTSBQSUxIWVVOKSBNb2JpbGUgQUU=?= <pilhyun.kim@sk.com>
Subject: RE: [External Mail] Re: [PATCH] f2fs: prevent the current section
 from being selected as a victim during garbage collection
Thread-Topic: [External Mail] Re: [PATCH] f2fs: prevent the current section
 from being selected as a victim during garbage collection
Thread-Index: AQHbnt3fELlyoJQ1W0qLIYQiUdi4aLOGhdAQ
Date: Thu, 27 Mar 2025 06:43:50 +0000
Message-ID: <2d95428375bd4a5592516bb6cefe4592@sk.com>
References: <20250326141428.280-1-yohan.joung@sk.com>
 <bf3f571c-a6bf-4a17-8745-039b37ac4f48@kernel.org>
In-Reply-To: <bf3f571c-a6bf-4a17-8745-039b37ac4f48@kernel.org>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
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
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsXC9ZZnke7yz0/SDVpa5C0u75rD5sDo8XmT
	XABjFJdNSmpOZllqkb5dAlfGpKPb2AtmyFes+X2UuYFxg1wXIyeHhICJxKKpD9m6GLk4hATe
	MErca1rLCOEsYJQ4c2AhUIaDg00gVGLrcnaQuIjAVEaJq/uPM4M4zAIvGSX2XX8D5ggLtDFK
	vDl8iRGirJ1R4v7cB6wgS0QEjCRWrd7GDGKzCKhKnLyxhB3E5hUwlTi6ZjYTiC0kkCmx6+R+
	sBpOATuJxh0rWUBWMwrISly9JgMSZhYQl1j89RozxN0CEkv2nIeyRSVePv7HClIuIaAocXer
	FIjJLKApsX6XPkSnosSU7odQSwUlTs58wgLRKSlxcMUNlgmMYrOQLJiF0D0LSfcsJN0LGFlW
	MQpn5pXlJmbm6BVnZ1TmZVboJefnbmIERsmy2j9+Oxi/XAg+xCjAwajEw5vA8SRdiDWxrLgy
	9xCjBAezkgiv5BWgEG9KYmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkm
	Dk6pBkYh2b273nlfMV68tF99/Vpxox2OCstqpb5euHTkVlHldY7gbe/Xm/z5fNIk+N6/uS0h
	G+UtpzzOXzvlp+oisZi61SxSvzknz+L8N7EjMtSQzX5O8O+Qu2xisUyTapikhKSf+s23bL6R
	/GmO7xy+EI8AQyFGvpDQ03yqHs8XMyr6Z0pvL32ceECJpTgj0VCLuag4EQC1SHXAjgIAAA==

PiBGcm9tOiBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJj
aCAyNywgMjAyNSAzOjAyIFBNDQo+IFRvOiBZb2hhbiBKb3VuZyA8anloNDI5QGdtYWlsLmNvbT47
IGphZWdldWtAa2VybmVsLm9yZzsgZGFlaG80M0BnbWFpbC5jb20NCj4gQ2M6IGNoYW9Aa2VybmVs
Lm9yZzsgbGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyDsoJXsmpTtlZwoSk9VTkcgWU9IQU4pIE1vYmlsZSBBRSA8
eW9oYW4uam91bmdAc2suY29tPg0KPiBTdWJqZWN0OiBbRXh0ZXJuYWwgTWFpbF0gUmU6IFtQQVRD
SF0gZjJmczogcHJldmVudCB0aGUgY3VycmVudCBzZWN0aW9uDQo+IGZyb20gYmVpbmcgc2VsZWN0
ZWQgYXMgYSB2aWN0aW0gZHVyaW5nIGdhcmJhZ2UgY29sbGVjdGlvbg0KPiANCj4gT24gMy8yNi8y
NSAyMjoxNCwgWW9oYW4gSm91bmcgd3JvdGU6DQo+ID4gV2hlbiBzZWxlY3RpbmcgYSB2aWN0aW0g
dXNpbmcgbmV4dF92aWN0aW1fc2VnIGluIGEgbGFyZ2Ugc2VjdGlvbiwgdGhlDQo+ID4gc2VsZWN0
ZWQgc2VjdGlvbiBtaWdodCBhbHJlYWR5IGhhdmUgYmVlbiBjbGVhcmVkIGFuZCBkZXNpZ25hdGVk
IGFzIHRoZQ0KPiA+IG5ldyBjdXJyZW50IHNlY3Rpb24sIG1ha2luZyBpdCBhY3RpdmVseSBpbiB1
c2UuDQo+ID4gVGhpcyBiZWhhdmlvciBjYXVzZXMgaW5jb25zaXN0ZW5jeSBiZXR3ZWVuIHRoZSBT
SVQgYW5kIFNTQS4NCj4gDQo+IEhpLCBkb2VzIHRoaXMgZml4IHlvdXIgaXNzdWU/DQoNClRoaXMg
aXMgYW4gaXNzdWUgdGhhdCBhcmlzZXMgd2hlbiBkaXZpZGluZyANCmEgbGFyZ2Ugc2VjdGlvbiBp
bnRvIHNlZ21lbnRzIGZvciBnYXJiYWdlIGNvbGxlY3Rpb24uDQpjYXVzZWQgYnkgdGhlIGJhY2tn
cm91bmQgR0MgKGdhcmJhZ2UgY29sbGVjdGlvbikgdGhyZWFkIGluIGxhcmdlIHNlY3Rpb24NCmYy
ZnNfZ2ModmljdGltX3NlY3Rpb24pIC0+IGYyZnNfY2xlYXJfcHJlZnJlZV9zZWdtZW50cyh2aWN0
aW1fc2VjdGlvbiktPiANCmN1cnNlYyh2aWN0aW1fc2VjdGlvbikgLT4gZjJmc19nYyh2aWN0aW1f
c2VjdGlvbiBieSBuZXh0X3ZpY3RpbV9zZWcpDQoNCkJlY2F1c2UgdGhlIGNhbGwgc3RhY2sgaXMg
ZGlmZmVyZW50LCANCkkgdGhpbmsgdGhhdCBpbiBvcmRlciB0byBoYW5kbGUgZXZlcnl0aGluZyBh
dCBvbmNlLCANCndlIG5lZWQgdG8gYWRkcmVzcyBpdCB3aXRoaW4gZG9fZ2FyYmFnZV9jb2xsZWN0
LCANCm9yIG90aGVyd2lzZSBpbmNsdWRlIGl0IG9uIGJvdGggc2lkZXMuIFdoYXQgZG8geW91IHRo
aW5rPw0KDQpbMzAxNDYuMzM3NDcxXVsgVDEzMDBdIEYyRlMtZnMgKGRtLTU0KTogSW5jb25zaXN0
ZW50IHNlZ21lbnQgKDcwOTYxKSB0eXBlIFswLCAxXSBpbiBTU0EgYW5kIFNJVA0KWzMwMTQ2LjM0
NjE1MV1bIFQxMzAwXSBDYWxsIHRyYWNlOg0KWzMwMTQ2LjM0NjE1Ml1bIFQxMzAwXSAgZHVtcF9i
YWNrdHJhY2UrMHhlOC8weDEwYw0KWzMwMTQ2LjM0NjE1N11bIFQxMzAwXSAgc2hvd19zdGFjaysw
eDE4LzB4MjgNClszMDE0Ni4zNDYxNThdWyBUMTMwMF0gIGR1bXBfc3RhY2tfbHZsKzB4NTAvMHg2
Yw0KWzMwMTQ2LjM0NjE2MV1bIFQxMzAwXSAgZHVtcF9zdGFjaysweDE4LzB4MjgNClszMDE0Ni4z
NDYxNjJdWyBUMTMwMF0gIGYyZnNfc3RvcF9jaGVja3BvaW50KzB4MWMvMHgzYw0KWzMwMTQ2LjM0
NjE2NV1bIFQxMzAwXSAgZG9fZ2FyYmFnZV9jb2xsZWN0KzB4NDFjLzB4MjcxYw0KWzMwMTQ2LjM0
NjE2N11bIFQxMzAwXSAgZjJmc19nYysweDI3Yy8weDgyOA0KWzMwMTQ2LjM0NjE2OF1bIFQxMzAw
XSAgZ2NfdGhyZWFkX2Z1bmMrMHgyOTAvMHg4OGMNClszMDE0Ni4zNDYxNjldWyBUMTMwMF0gIGt0
aHJlYWQrMHgxMWMvMHgxNjQNClszMDE0Ni4zNDYxNzJdWyBUMTMwMF0gIHJldF9mcm9tX2Zvcmsr
MHgxMC8weDIwDQoNCnN0cnVjdCBjdXJzZWdfaW5mbyA6IDB4ZmZmZmZmODAzZjk1ZTgwMCB7DQoJ
c2Vnbm8gICAgICAgIDogMHgxMTUzMSA6IDcwOTYxDQp9DQoNCnN0cnVjdCBmMmZzX3NiX2luZm8g
OiAweGZmZmZmZjg4MTFkMTIwMDAgew0KCW5leHRfdmljdGltX3NlZ1swXSA6IDB4MTE1MzEgOiA3
MDk2MQ0KfQ0KDQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mMmZzLWRldmVs
LzIwMjUwMzI1MDgwNjQ2LjMyOTE5NDctMi0NCj4gY2hhb0BrZXJuZWwub3JnDQo+IA0KPiBUaGFu
a3MsDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9oYW4gSm91bmcgPHlvaGFuLmpvdW5n
QHNrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZnMvZjJmcy9nYy5jIHwgNCArKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9mcy9mMmZz
L2djLmMgYi9mcy9mMmZzL2djLmMgaW5kZXgNCj4gPiAyYjhmOTIzOWJlZGUuLjRiNWQxOGUzOTVl
YiAxMDA2NDQNCj4gPiAtLS0gYS9mcy9mMmZzL2djLmMNCj4gPiArKysgYi9mcy9mMmZzL2djLmMN
Cj4gPiBAQCAtMTkyNiw2ICsxOTI2LDEwIEBAIGludCBmMmZzX2djKHN0cnVjdCBmMmZzX3NiX2lu
Zm8gKnNiaSwgc3RydWN0DQo+IGYyZnNfZ2NfY29udHJvbCAqZ2NfY29udHJvbCkNCj4gPiAgCQln
b3RvIHN0b3A7DQo+ID4gIAl9DQo+ID4NCj4gPiArCWlmIChfX2lzX2xhcmdlX3NlY3Rpb24oc2Jp
KSAmJg0KPiA+ICsJCQlJU19DVVJTRUMoc2JpLCBHRVRfU0VDX0ZST01fU0VHKHNiaSwgc2Vnbm8p
KSkNCj4gPiArCQlnb3RvIHN0b3A7DQo+ID4gKw0KPiA+ICAJc2VnX2ZyZWVkID0gZG9fZ2FyYmFn
ZV9jb2xsZWN0KHNiaSwgc2Vnbm8sICZnY19saXN0LCBnY190eXBlLA0KPiA+ICAJCQkJZ2NfY29u
dHJvbC0+c2hvdWxkX21pZ3JhdGVfYmxvY2tzLA0KPiA+ICAJCQkJZ2NfY29udHJvbC0+b25lX3Rp
bWUpOw0KDQo=

