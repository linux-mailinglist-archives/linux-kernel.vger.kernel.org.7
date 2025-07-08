Return-Path: <linux-kernel+bounces-720681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37D5AFBF31
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325404A5F96
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBE132C8B;
	Tue,  8 Jul 2025 00:24:52 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5733E7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751934292; cv=none; b=jRQc1n/iCSco8jrVXM/64+f5NhjYWGFqnur92ZqHjyLuzViIfnYAHKhy/lYRb42Vx0ol4xv0aW1mXLlfRobV2WHXfZ56yc7Nv3M7oW/0GL8oKFGHMDpZqeBeS82uBK7HZzx9wqGT1B6v8xQHyKXlEpW3oaZdigdmOLP5lpE6OZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751934292; c=relaxed/simple;
	bh=hbNvLinM16BrCm6vTJOEcgotGXkSVCqKKKzVL38PnuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iALuyz+cn5m+Zz7em1l1zuYEBmu1qp15pCfWp+M27KHVD1C2uxWdzqibzHTjJ+/5AfaKPZSZUIE1KztOEIeWTaAhMIOOaXQMR7ohW2I0BXMGlnKzp9ZS8sa7llhifgmSFroLGd1muPA5Q7htSWXXXC2+hidqRDTTyiJNQHz69BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	David Laight <david.laight.linux@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "bsegall@google.com" <bsegall@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBkaXZpZGUgZXJyb3IgaW4geDg2IGFuZCBjcHV0?=
 =?gb2312?Q?ime?=
Thread-Topic: [????] Re: divide error in x86 and cputime
Thread-Index: AdvvFOeRwP1XMiJ8Sh6ojy4vzov+4AAM96oAAAC7wQAAEo0PUAACA05w
Date: Tue, 8 Jul 2025 00:23:36 +0000
Message-ID: <2b98f7946cd0411ab588ce9b55c2f8e2@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
 <20250707220937.GA15787@redhat.com> <20250707223038.GB15787@redhat.com>
 <2ef88def90634827bac1874d90e0e329@baidu.com>
In-Reply-To: <2ef88def90634827bac1874d90e0e329@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.41
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBub24teDg2IHN5c3RlbSBtYXliZSBoYXMgc2FtZSBpc3N1ZSwgb25jZSAoc3RpbWUgKyB1dGlt
ZSkgb3ZlcmZsb3dzIDY0Yml0LA0KPiBtdWxfdTY0X3U2NF9kaXZfdTY0IGZyb20gbGliL21hdGgv
ZGl2NjQuYyBtYXliZSBjYXVzZSBkaXZpc2lvbiBieSAwDQo+IA0KDQpDb3JyZWN0IHRoaXMsIG11
bF91NjRfdTY0X2Rpdl91NjQoMHg2OWY5OGRhOWJhOTgwYzAwLCAweGZmZmQyMTNhYWJkNzQ2MjYs
IDB4MDA5ZTAwOTAwKSBvZmxpYi9tYXRoL2RpdjY0LmMgcmV0dXJucyAweGZmZmZmZmZmZmZmZmZm
ZmYNCg0KDQo+IHNvIHRvIGNwdXRpbWUsIGNvdWxkIGNwdXRpbWVfYWRqdXN0KCkgcmV0dXJuIHN0
aW1lIGlmIHN0aW1lIGlmIHN0aW1lICsgdXRpbWUgaXMNCj4gb3ZlcmZsb3cNCj4gDQo+IGRpZmYg
LS1naXQgYS9rZXJuZWwvc2NoZWQvY3B1dGltZS5jIGIva2VybmVsL3NjaGVkL2NwdXRpbWUuYyBp
bmRleA0KPiA2ZGFiNDg1NC4uZGIwYzI3MyAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3NjaGVkL2Nw
dXRpbWUuYw0KPiArKysgYi9rZXJuZWwvc2NoZWQvY3B1dGltZS5jDQo+IEBAIC01NzksNiArNTc5
LDEwIEBAIHZvaWQgY3B1dGltZV9hZGp1c3Qoc3RydWN0IHRhc2tfY3B1dGltZSAqY3Vyciwgc3Ry
dWN0DQo+IHByZXZfY3B1dGltZSAqcHJldiwNCj4gICAgICAgICAgICAgICAgIGdvdG8gdXBkYXRl
Ow0KPiAgICAgICAgIH0NCj4gDQo+ICsgICAgICAgaWYgKHN0aW1lID4gKHN0aW1lICsgdXRpbWUp
KSB7DQo+ICsgICAgICAgICAgICAgICBnb3RvIHVwZGF0ZTsNCj4gKyAgICAgICB9DQo+ICsNCj4g
ICAgICAgICBzdGltZSA9IG11bF91NjRfdTY0X2Rpdl91NjQoc3RpbWUsIHJ0aW1lLCBzdGltZSAr
IHV0aW1lKTsNCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIEJlY2F1c2UgbXVsX3U2NF91NjRf
ZGl2X3U2NCgpIGNhbiBhcHByb3hpbWF0ZSBvbiBzb21lDQo+IA0KPiANCj4gVGhhbmtzDQo+IA0K
PiAtTGkNCj4gDQo+IA0KPiA+IE9sZWcuDQo+ID4NCj4gPiBPbiAwNy8wOCwgT2xlZyBOZXN0ZXJv
diB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiAwNy8wNywgTGksUm9uZ3Fpbmcgd3JvdGU6DQo+ID4g
PiA+DQo+ID4gPiA+IFs3ODI1MDgxNS43MDM4NDddIGRpdmlkZSBlcnJvcjogMDAwMCBbIzFdIFBS
RUVNUFQgU01QIE5PUFRJDQo+ID4gPg0KPiA+ID4gLi4uDQo+ID4gPg0KPiA+ID4gPiBJdCBjYXVz
ZWQgYnkgYSBwcm9jZXNzIHdpdGggbWFueSB0aHJlYWRzIHJ1bm5pbmcgdmVyeSBsb25nLCBhbmQN
Cj4gPiA+ID4gdXRpbWUrc3RpbWUgb3ZlcmZsb3dlZCA2NGJpdCwgdGhlbiBjYXVzZSB0aGUgYmVs
b3cgZGl2DQo+ID4gPiA+DQo+ID4gPiA+IG11bF91NjRfdTY0X2Rpdl91NjQoMHg2OWY5OGRhOWJh
OTgwYzAwLCAweGZmZmQyMTNhYWJkNzQ2MjYsDQo+ID4gPiA+IDB4MDllMDA5MDApOw0KPiA+ID4g
Pg0KPiA+ID4gPiBJIHNlZSB0aGUgY29tbWVudHMgb2YgbXVsX3U2NF91NjRfZGl2X3U2NCgpIHNh
eToNCj4gPiA+ID4NCj4gPiA+ID4gV2lsbCBnZW5lcmF0ZSBhbiAjREUgd2hlbiB0aGUgcmVzdWx0
IGRvZXNuJ3QgZml0IHU2NCwgY291bGQgZml4DQo+ID4gPiA+IHdpdGggYW4gX19leF90YWJsZVtd
IGVudHJ5IHdoZW4gaXQgYmVjb21lcyBhbiBpc3N1DQo+ID4gPiA+DQo+ID4gPiA+IFNlZW0gX19l
eF90YWJsZVtdIGVudHJ5IGZvciBkaXYgZG9lcyBub3Qgd29yayA/DQo+ID4gPg0KPiA+ID4gV2Vs
bCwgdGhlIGN1cnJlbnQgdmVyc2lvbiBkb2Vzbid0IGhhdmUgYW4gX19leF90YWJsZVtdIGVudHJ5
IGZvciBkaXYuLi4NCj4gPiA+DQo+ID4gPiBJIGRvIG5vdCBrbm93IHdoYXQgY2FuL3Nob3VsZCB3
ZSBkbyBpbiB0aGlzIGNhc2UuLi4gUGVyaGFwcw0KPiA+ID4NCj4gPiA+IAlzdGF0aWMgaW5saW5l
IHU2NCBtdWxfdTY0X3U2NF9kaXZfdTY0KHU2NCBhLCB1NjQgbXVsLCB1NjQgZGl2KQ0KPiA+ID4g
CXsNCj4gPiA+IAkJaW50IG9rID0gMDsNCj4gPiA+IAkJdTY0IHE7DQo+ID4gPg0KPiA+ID4gCQlh
c20gKCJtdWxxICUzOyAxOiBkaXZxICU0OyBtb3ZsICQxLCUxOyAyOlxuIg0KPiA+ID4gCQkJX0FT
TV9FWFRBQkxFKDFiLCAyYikNCj4gPiA+IAkJCTogIj1hIiAocSksICIrciIgKG9rKQ0KPiA+ID4g
CQkJOiAiYSIgKGEpLCAicm0iIChtdWwpLCAicm0iIChkaXYpDQo+ID4gPiAJCQk6ICJyZHgiKTsN
Cj4gPiA+DQo+ID4gPiAJCXJldHVybiBvayA/IHEgOiAtMXVsOw0KPiA+ID4gCX0NCj4gPiA+DQo+
ID4gPiA/DQo+ID4gPg0KPiA+ID4gU2hvdWxkIHJldHVybiBVTExPTkdfTUFYIG9uICNERS4NCj4g
PiA+DQo+ID4gPiBPbGVnLg0KDQo=

