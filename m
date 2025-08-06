Return-Path: <linux-kernel+bounces-757223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7086B1BF64
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCF018A4F52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004511E1A3B;
	Wed,  6 Aug 2025 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="eRBQ6UIP"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4741C8610
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754451707; cv=none; b=NewJB6d3Bd82uIaHtQlinAr9qdxSq9TniRz+vOjSN8mIv3lvkPDMf8v2bUcWdmrc5UkASWmOkN47uLPr+sclJEei+s2tl7dZB1K6PgXe/fag1zCc4NBsl+hXUmNz2vVKLKrsZYPOm8G8tYMDPy65mBIF1mjJUvXT0ASAvdxSiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754451707; c=relaxed/simple;
	bh=d75mbpsX8RQ3NybfUutsz/AWNUxpxg7TXiUsHrhVkGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aBHCUFwVk/muRjhM18O26oWiU80YrbTs5vkeKow9+9LIqb9C3omfb6QYIPTYvHkwTxZjmleJKAR6mbP/5MMJkbqHCbGJYcG4jUWosAMrnaNGcmb6SCXPzOI98PGfwX6fno4ffvWdri0OV1eLenMBb8m4HayHydPkZEFclmAyefA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=eRBQ6UIP; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D12C52C00FE;
	Wed,  6 Aug 2025 15:41:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1754451701;
	bh=d75mbpsX8RQ3NybfUutsz/AWNUxpxg7TXiUsHrhVkGg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=eRBQ6UIPJTZC0trG+YnrkQZqcnBUVqBCd9+uu4mwGY24ngo2j5yzqYblXz2VLeU1+
	 265ZrShHK+MoxnQrjkIeEsB4ZUSLRIEwhs2h9ghi7aBvnugwl36onlvp8Lb4M8B6Up
	 y2mJYrtuLmP8NnZeavHHC0FbVRSBP4qX4FoJDmhhiqSsQJ8gKG6fDzFolV3hMRE1hx
	 SvN3m5g9jIwlqgOKLDjJ4YI6B5Vv5oBmQNH3Sly6EX0p4cmIXw3WjbTqM5M/cWaX9A
	 tJQRQHKnuScMkSykYpS3qMvf1TXneLloIrM+GaNfwhvXb7ISh0cwIYLZPWwazba3nL
	 6Ncwsx4mcgktA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6892cef50001>; Wed, 06 Aug 2025 15:41:41 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 6 Aug 2025 15:41:41 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Wed, 6 Aug 2025 15:41:41 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Guenter Roeck <linux@roeck-us.net>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (ina780) Add driver for TI INA780
Thread-Topic: [PATCH 2/2] hwmon: (ina780) Add driver for TI INA780
Thread-Index: AQHcBmxCTEWvZ5TWkkCoS1XTid0nk7RUKo+AgAAHdwA=
Date: Wed, 6 Aug 2025 03:41:41 +0000
Message-ID: <7f621788-372b-4a0b-a126-4c2d1d9a926c@alliedtelesis.co.nz>
References: <20250806005127.542298-1-chris.packham@alliedtelesis.co.nz>
 <20250806005127.542298-2-chris.packham@alliedtelesis.co.nz>
 <fa1b8f0f-23a3-4baa-a424-9b1506a9699c@roeck-us.net>
In-Reply-To: <fa1b8f0f-23a3-4baa-a424-9b1506a9699c@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <90294AC783469245A47949C90DB2C716@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=6892cef5 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=JIY_GJIoiM6udwNnU9sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgR3VlbnRlciwNCg0KT24gMDYvMDgvMjAyNSAxNToxNCwgR3VlbnRlciBSb2VjayB3cm90ZToN
Cj4gT24gOC81LzI1IDE3OjUxLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gQWRkIHN1cHBvcnQg
Zm9yIHRoZSBUSSBJTkE3ODAgRGlnaXRhbCBQb3dlciBNb25pdG9yLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4N
Cj4NCj4gTG9va2luZyBhdCB0aGUgcmVnaXN0ZXJzLCB0aGUgY2hpcCBzZWVtcyB0byBiZSBhbG1v
c3QgaWRlbnRpY2FsIHRvIA0KPiBJTkEyMzcvMjM4Lg0KPiBXaHkgYSBuZXcgZHJpdmVyID8NCg0K
WWVzIEknZCBub3RpY2VkIHRoZSBzYW1lIHRoaW5nIGFzIEkgd2VudCBhbG9uZy4gVGhlIElOQTc4
MCBoYXMgdGhlIA0KZXpzaHVudCB0aGluZyAobm90IHN1cmUgaWYgdGhhdCdzIHRoZSBzYW1lIGFz
IHRoZSBpbnRlcm5hbCBzaHVudCBvbiB0aGUgDQpJTkEyNjApIHdoaWNoIG1lYW5zIHRoYXQgYSBs
b3Qgb2YgdGhlIHBsYWNlcyB3aGVyZSB0aGluZ3MgYXJlIGNhbGN1bGF0ZWQgDQpieSB0aGUgc2h1
bnQgcmVzaXN0b3IgdmFsdWUgYXJlbid0IGFwcGxpY2FibGUgYW5kIHRoZXJlJ3Mgb25lIGxlc3Mg
DQp2b2x0YWdlIHNlbnNvci4gSSBkaWQgY29uc2lkZXIgYWRkaW5nIGl0IHRvIHRoZSBpbmEyeHgu
YyBidXQgaXQgc2VlbWVkIA0KZGlmZmVyZW50IGVub3VnaCB0byB0aG9zZSBjaGlwcyB0byB3YXJy
YW50IGEgc2VwYXJhdGUgZHJpdmVyLg0KDQpJIHRoaW5rIEkgY2FuIGtpbmQgb2Ygc3F1aW50IGFu
ZCBzZWUgaG93IEkgbWlnaHQgZm9sZCB0aGUgaW5hNzgwIHN1cHBvcnQgDQppbnRvIHRoZSBpbmEy
MzggZHJpdmVyIGFsdGhvdWdoIHRoYXQgbWF5IG1ha2UgdGhpbmdzIGEgYml0IG1lc3NpZXIuIElm
IA0KdGhhdCdzIHRoZSBkaXJlY3Rpb24geW91J2QgbGlrZSB0byBoZWFkIEkgY2FuIGdpdmUgaXQg
YSBnby4NCg==

