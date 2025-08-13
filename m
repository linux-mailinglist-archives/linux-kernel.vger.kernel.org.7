Return-Path: <linux-kernel+bounces-765921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F7B23FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728271AA7E60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982F28EA72;
	Wed, 13 Aug 2025 04:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="newIlYZ/"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A82405FD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755061017; cv=none; b=MICvejp8fmy5JBZB7OLDi0SOJmdkLHsO2tFqMwaguh2wdI2I0fDMh0xUPr0McCpxwYbxA0wHoTDOaRKUHGes4BiNt9Q9W/0kF86HaL74y60z9UAfhPTNd9XfpGKB8kcLDvtO2uN8UzcnARzZZaPeeSYgRfw6BnXvuUd+oH+VBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755061017; c=relaxed/simple;
	bh=i9HAB2BknolEvf3NnJy79vTeSKi7hkKdxt+pkfaeJNM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NBPxrUasAm0yvAI/RDP2qTA3gfgr93G5grgfQq/qfM1ef5+EDIIgb0fR2fRKyFYzSpxzhP09ksg0vbVHcmRmvGg1VAH7Fcmsi65CjcPhY+IjN7lhPXZuq5lbOaiIW0IJeeCrDFwvuF2qRxcuG5btc/313tCbvxS94j8fqKDskW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=newIlYZ/; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AE4042C012E;
	Wed, 13 Aug 2025 16:56:46 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1755061006;
	bh=i9HAB2BknolEvf3NnJy79vTeSKi7hkKdxt+pkfaeJNM=;
	h=From:To:CC:Subject:Date:From;
	b=newIlYZ/2YcMFyA3MU4ZgJPCX4FnUWgiiH4SmPCieXRtU93ZC25oqtaOXJv582W0S
	 ZJKAti0koVtxsrFuzF31KR2YP4ZYowHc/VA5DLIjun7ucHV+px9vwtGolyzUnQB3JR
	 S0/eEV64WmnisyWOzWUjLxpJTeTE71sVWYSmcm9zvA0ku8KMULrbtuN0u5NrCZ3Ce+
	 GRec0OlfoxMmE0nTWHQGsYBTALaN2KzEWuz+tPympK8du0WQl9RnIj7wwnbeEO8+tI
	 GXlOwg5lcHQ4H+rstbflwf+AM4zo0qt+dr4Dwfr+kyt63KtUYE0m9+fjvFrS0+wrJq
	 GTsFYzZlKqhOQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B689c1b0e0000>; Wed, 13 Aug 2025 16:56:46 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 13 Aug 2025 16:56:46 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Wed, 13 Aug 2025 16:56:46 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: "complete" dt-bindings for new SoC
Thread-Topic: "complete" dt-bindings for new SoC
Thread-Index: AQHcDA6rJilEkNg0QUajYrO/hETw/g==
Date: Wed, 13 Aug 2025 04:56:46 +0000
Message-ID: <82c09e95-9856-42ec-b7a5-858fd06b888a@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <612AFAC5CA15154EBE0D0F5C1210FDEB@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=689c1b0e a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=jGRUliSn7nfH5Q6_R60A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgRGV2aWNldHJlZSBFbnRodXNpYXN0cywNCg0KQSBmZXcgdGltZXMgbm93IEkndmUgYmVlbiB0
b2xkIHRoYXQgdGhpbmdzIHdvdWxkIGhhdmUgYmVlbiBlYXNpZXIgaGFkIEkgDQpzdWJtaXR0ZWQg
YSBjb21wbGV0ZSBiaW5kaW5nIGluIHRoZSBmaXJzdCBwbGFjZS4gSSBmaW5kIG15c2VsZiBsb29r
aW5nIA0KYXQgYW5vdGhlciBuZXcgU29DIChhIFJlYWx0ZWsgU3dpdGNoIHdpdGggYW5kIGludGVn
cmF0ZWQgQVJNNjQgY29yZSB0aGlzIA0KdGltZSkuIEknbSBhbHNvIHdhaXRpbmcgb24gaGFyZHdh
cmUgc28gSSBmaWd1cmVkIEkgY291bGQgcHJvYmFibHkgZ2V0IA0KdGhlIGJhbGwgcm9sbGluZyBv
biBhIGRldmljZXRyZWUgYW5kIEkgd2FudGVkIHRvIGRvIGEgYmV0dGVyIGpvYiBvZiANCndyaXRp
bmcgdGhlIGJpbmRpbmcuDQoNCldoaWNoIGJyaW5ncyBiZSB0byB0aGUgcXVlc3Rpb24uIFdoYXQg
ZG9lcyBhICJjb21wbGV0ZSIgYmluZGluZyBtZWFuIHRvIA0KdGhlIGRldmljZXRyZWUgbWFpbnRh
aW5lcnM/IEFyZSB3ZSB0YWxraW5nIGFib3V0IGFuIG92ZXJhbGwgYmluZGluZyBmb3IgDQp0aGUg
Y2hpcCB0aGF0IGNhbGxzIG91dCBwZXJpcGhlcmFscyAoc29tZSB3aGljaCBhbHJlYWR5IGV4aXN0
KSB3aXRoIGEgDQpyZWY6ID8gT3IgYSBmdWxsIGJpbmRpbmcgaW4gb25lIGRvY3VtZW50IHRoYXQg
Y292ZXJzIGV2ZXJ5dGhpbmcgaW4gdGhlIA0KY2hpcD8gRG9lcyBpdCBuZWVkIHRvIGJlIGFjY29t
cGFuaWVkIGJ5IGFuIGFjdHVhbCBkdHMoaSkgZm9yIHRoZSBjaGlwPw0KDQpUaGFua3MsDQpDaHJp
cw0KDQo=

