Return-Path: <linux-kernel+bounces-790762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E7B3ACB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465A4687843
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC512C11F5;
	Thu, 28 Aug 2025 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="lPlc/fxq"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FC28153A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416131; cv=none; b=dgcHzo4AbFqvmTxfUJJWxAdSEb8Zgikvaeb5USPXH7Q5AsM7IWvvb5mQJNsQt4ZEuUrKQIrutiFzPojQrp5dlxTZTJ+gRCKrRedVAQ4+ooAJY5FtGt5HVfXvvLs+Nr/DwKq6bLyUYH6bbmCzwCeVKUEi4o5y5Q4YZUFAfYyvBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416131; c=relaxed/simple;
	bh=P/0XnDjjkYSpBEKxFbX5TnoxJtaTlc7T3bqpxvFmesc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XLUE/zhb/EJcFbiP8AhjcWViGCb1n56xChlmifTynFJ8Lk34RvsM9d6pCv4aQFSWTffP2Fwx+/KzbO2KXby3cnhKuQwpMNchXFXSh1OjYk0Og1baWpvl+q3U8RrmXgBlXCed/0fpR4YR94bJYgob9biUzVP3pOc0cE7QoKo1IKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=lPlc/fxq; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D12F12C0619;
	Fri, 29 Aug 2025 09:22:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1756416125;
	bh=P/0XnDjjkYSpBEKxFbX5TnoxJtaTlc7T3bqpxvFmesc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=lPlc/fxqwI5kw+EK77PvNB5IEb065nQ9/qxocImdA0tiJWCj/GRdLQytA3l7GfWeO
	 pMHuM8xiSzaZV1wT5UGVB6ZoO7xx5NjSlRMy8UbS6LSwXaOpgGC3lbdjHtO6sJNEHF
	 8i6nOg02huNpfSzP5LxErF3wHWu3TjD9Bz1c5YHYaz9frU6LMcJBhwOFAQvdur95rF
	 EAcfB+BpLk8R1+rEbqqcO6Z1kigHy6L4YJCx+IyCvMu5U49RVf/KJbIsxds4Z8Hlf1
	 aoVvdhv7On6v2AF9yUiyG8cUOpIj2llDWB9xrgo69j3E3i571uZqn1GC0tUt/3Lwc5
	 qFQcvuEUNaYwQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68b0c87d0001>; Fri, 29 Aug 2025 09:22:05 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 29 Aug 2025 09:22:05 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Fri, 29 Aug 2025 09:22:05 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Guenter Roeck <linux@roeck-us.net>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] hwmon: (ina238) Add support for INA780
Thread-Topic: [PATCH v2 2/2] hwmon: (ina238) Add support for INA780
Thread-Index: AQHcCBFCT9dgOoAuzUOPUPjlGL2uJ7R3T9IAgACae4A=
Date: Thu, 28 Aug 2025 21:22:05 +0000
Message-ID: <d5725c87-ff96-4a25-995a-d4c3cbcc13a9@alliedtelesis.co.nz>
References: <20250808030510.552724-1-chris.packham@alliedtelesis.co.nz>
 <20250808030510.552724-3-chris.packham@alliedtelesis.co.nz>
 <6e51d4b9-23fd-401b-afb1-2df943f85c3c@roeck-us.net>
In-Reply-To: <6e51d4b9-23fd-401b-afb1-2df943f85c3c@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0328DDB173F624693B30BB87058D327@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Yo+sRJYX c=1 sm=1 tr=0 ts=68b0c87d a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=WZTWi1HEeU2toEpxRV0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyOS8wOC8yMDI1IDAwOjA5LCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPiBPbiA4LzcvMjUg
MjA6MDUsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBBZGQgc3VwcG9ydCBmb3IgdGhlIFRJIElO
QTc4MCBEaWdpdGFsIFBvd2VyIE1vbml0b3IuIFRoZSBJTkE3ODAgdXNlcw0KPj4gRVpTaHVudCh0
bSkgdGVjaG5vbG9neSwgd2hpY2ggbWVhbnMgdGhlcmUgYXJlIGZpeGVkIExTQiBjb252ZXJzaW9u
cyBmb3INCj4+IGEgbnVtYmVyIG9mIGZpZWxkcyByYXRoZXIgdGhhbiBuZWVkaW5nIHRvIGJlIGNh
bGlicmF0ZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFj
a2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPg0KPiBZb3VyIHBhdGNoIGRvZXMgbm90IGFwcGx5
LCBhbmQgSSBjYW4ndCBmaWd1cmUgb3V0IGl0cyBiYXNlbGluZS4gUGxlYXNlDQo+IHJlcGFyZW50
IG9uIHRvcCBvZiB0aGUgY3VycmVudCBtYWlubGluZSBhbmQgcmVzdWJtaXQuDQpTdXJlIG5vIHBy
b2JsZW0uIFRoZSBpbmEyMzggY2hhbmdlcyB3ZXJlIGRvbmUgb24gdG9wIG9mIG15IGluaXRpYWwg
DQppbmE3ODAgc3R1ZmYgc28gdGhlIHNoYTEgcmVjb3JkZWQgaW4gdGhlIHBhdGNoIHdpbGwgYmUg
YSBsb2NhbCBzaGExIHRoYXQgDQp5b3UgZG9uJ3QgaGF2ZS4gSSdsbCBjbGVhbiB0aGluZ3MgdXAg
b24gdG9wIG9mIG1hc3RlciB3aXRob3V0IGFueSBsb2NhbCANCmp1bmsuDQo+DQo+IFRvIHNpbXBs
aWZ5IHJldmlldywgdGhlIHBhdGNoIHNob3VsZCBiZSBzcGxpdCBpbnRvIHByZXBhcmF0aW9uIHBh
dGNoZXMNCj4gKHN1Y2ggYXMgYWRkaW5nIC5oYXNfc2h1bnQgYW5kIC50ZW1wX21heCBvcHRpb25z
KSwgZm9sbG93ZWQgYnkgdGhlIGFjdHVhbA0KPiBhZGRlZCBjaGlwIHN1cHBvcnQuDQpTdXJlLg0K
Pg0KPiBPdGhlciAobm90IGEgY29tcGxldGUgcmV2aWV3KToNCj4NCj4gSSBkb24ndCBzZWUgdGhl
IHZhbHVlIG9mIGFkZGluZyBJTkE3ODBfQ09MIGFuZCBJTkE3ODBfQ1VMIGRlZmluZXM7DQo+IHRo
b3NlIGFyZSByZWFsbHkgdGhlIHNhbWUgYXMgdGhlIHNodW50IHZvbHRhZ2UgbGltaXRzLiBBY3R1
YWxseSwNCj4gdGhlIGN1cnJlbnQgbGltaXRzIF9hcmVfIGF2YWlsYWJsZSBmb3IgZXhpc3Rpbmcg
Y2hpcHMsIG9ubHkgdGhleQ0KPiBhcmUgZXhwcmVzc2VkIGFzIHZvbHRhZ2UgbGltaXRzIG9uIHRo
ZSBzaHVudCB2b2x0YWdlcy4NCg0KTXkgbWFpbiBtb3RpdmF0aW9uIHdhcyB0cnlpbmcgdG8gbWF0
Y2ggdGhlIHRlcm1zIHVzZWQgaW4gdGhlIElOQTc4MCANCmRhdGFzaGVldC4gSU5BNzgwIHVzZXMg
Q09ML0NVTCwgSU5BMjM4IHVzZXMgU09WTC9TVVZMLiBJIGNhbiBraW5kIG9mIA0Kc3F1aW50IGFu
ZCBzZWUgaG93IHRoZXkgYXJlIHNpbWlsYXIgdGhlIElOQTIzOCBpcyBqdXN0IG1vcmUgY29tcGxp
Y2F0ZWQgDQpiZWNhdXNlIG9mIHRoZSBleHRlcm5hbCBzaHVudC4gSSBkaWQga2luZCBvZiB0aGlu
ayBpdCBtdXN0IGJlIHBvc3NpYmxlIA0KdG8gZXhwcmVzcyB0aGUgSU5BNzgwIGJlaGF2aW91ciB3
aXRoIHNvbWUgZml4ZWQgdmFsdWVzIGJ1dCBteSBtYXRoIA0Kc2tpbGxzIGZhaWxlZCBtZS4NCg0K
PiBGb3IgdGhlIGluYV8yeHgNCj4gZHJpdmVyIEkgd2FzIGFibGUgdG8gcmVzb2x2ZSB0aGF0IHF1
aXRlIGVhc2lseTsgd2Ugc2hvdWxkIGRvIHRoZSBzYW1lDQo+IGZvciB0aGUgaW5hMjM4IGRyaXZl
ci4gTWF5YmUgSSBoYXZlIGFuIGV2YWx1YXRpb24gYm9hcmQgc29tZXdoZXJlOw0KPiBJJ2xsIG5l
ZWQgdG8gY2hlY2suDQo+DQo+IFsgU29ycnkgZm9yIGJlaW5nIHNvIGxhdGUgd2l0aCB0aGlzOyBJ
IGFtIGJlaW5nIHN3YW1wZWQgYXQgd29yayA6LSggXSANCg0KTm8gcHJvYmxlbS4gU2FtZSB0aGlu
ZyBmb3IgbWUuDQoNCg==

