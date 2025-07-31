Return-Path: <linux-kernel+bounces-752270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A76B1735C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F614E7C28
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B0D1A0BE0;
	Thu, 31 Jul 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="lGO/kfav"
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E61991D4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972976; cv=none; b=MFdrPoSy2G8WxxTUxTU0CIcO+wXHuGIeKPwOM05CaWtYmxll+2YgNetWaIFJBa10AjEJG5Cv3ao2K1yUieIIgLvhbXThzNHzTHwVS+AG5Mku0fzxjmbqBcESIL4D2IvztlZ5LcMBs9itKKvNBToCWBfRJ30l1RgqfwiSz7XVHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972976; c=relaxed/simple;
	bh=ixuWO1YxXetsb0vKDaPTtXokCN5YiCh9UxDA6aqBHvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P1OLpYU0Msnpf/ufFwdxGkfjILRViK70I+cQrnL79cB8qInpErSKnAcU7+AP8cjzpCxA9ljTIgJJg83K00MzRdyqBLLZeVxk2XAVNM8/SuPnxV2k4i35kvy0r6Qb7YSAyVcwj4P141GiZYIVT5iqvBTDuvO0Icmulz1GQKrCKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=lGO/kfav; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 693C620870;
	Thu, 31 Jul 2025 16:42:44 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yjZZNbvuM48n; Thu, 31 Jul 2025 16:42:43 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CC25C207AC;
	Thu, 31 Jul 2025 16:42:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CC25C207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753972963;
	bh=ixuWO1YxXetsb0vKDaPTtXokCN5YiCh9UxDA6aqBHvc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=lGO/kfavGR4YVjOWN5moetoj2sZGjyw/M5e/Ny9ZZdgfU4inULrfJ7RNqCt/UZWaI
	 pxxqZKCDKu7cn86DrKbzIHXzLy8O3YkLXFwbgDAdzudMU9A8UllLJMSZpky6gD5TVX
	 3nOpz4rI/w0uPIcp8q0LrKyT7NlFY0KJpF1TVgH6BTvVPqO0oQ9F7NIsiF2NYse85U
	 lqpfH9x7at2x8fYWR3xYrC7S0dlnLEN5kRgS4SFmYP9y82AtaTwdZAN7HKHZd5MqQB
	 +Th40YOK8VvKXO4u5QjwyPNfQUsLg6dp/I8pLQq55mW0sx094GhMGUD/7DaAzcVq7C
	 kWYznbz3spGvA==
Received: from EXCH-04.secunet.de (10.32.0.184) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 31 Jul
 2025 16:42:43 +0200
Received: from EXCH-04.secunet.de ([fe80::f0d0:317:aa9d:ee57]) by
 EXCH-04.secunet.de ([fe80::f0d0:317:aa9d:ee57%4]) with mapi id
 15.02.1748.010; Thu, 31 Jul 2025 16:42:43 +0200
From: "Heijligen, Thomas" <thomas.heijligen@secunet.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"lee@kernel.org" <lee@kernel.org>
CC: "Schumann, Peter" <Peter.Schumann@secunet.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Huber, Nico"
	<Nico.Huber@secunet.com>, "michael.brunner@kontron.com"
	<michael.brunner@kontron.com>
Subject: Re: [PATCH] mfd: kempld: Switch back to earlier ->init() behavior
Thread-Topic: [PATCH] mfd: kempld: Switch back to earlier ->init() behavior
Thread-Index: AQHb9NPB/wnq4hn0ZUu7P6EQBYYsO7Q/ZQWAgABWDoCADIx6gA==
Date: Thu, 31 Jul 2025 14:42:42 +0000
Message-ID: <752a83bc9a55ef821288254d2a1b2c4f7fe35b37.camel@secunet.com>
References: <71883d70d1b99f58c96ba1b0016751f41519025b.camel@secunet.com>
	 <20250723095647.GS11056@google.com> <aID6D-1SsJ1ish5_@smile.fi.intel.com>
In-Reply-To: <aID6D-1SsJ1ish5_@smile.fi.intel.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <0332D3E8827A3E45AB854142B8769E4F@secunet.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI1LTA3LTIzIGF0IDE4OjA0ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIFdlZCwgSnVsIDIzLCAyMDI1IGF0IDEwOjU2OjQ3QU0gKzAxMDAsIExlZSBKb25lcyB3
cm90ZToNCj4gPiANCj4gPiA+IENvbW1pdCA5ZTM2Nzc1YzIyYzcgKCJtZmQ6IGtlbXBsZDogUmVt
b3ZlIGN1c3RvbSBETUkgbWF0Y2hpbmcgY29kZSIpDQo+ID4gPiByZW1vdmVzIHRoZSBhYmlsaXR5
IHRvIGxvYWQgdGhlIGRyaXZlciBpZiBubyBtYXRjaGluZyBzeXN0ZW0gRE1JIGRhdGENCj4gPiA+
IGlzIGZvdW5kLiBCZWZvcmUgdGhpcyBjb21taXQgdGhlIGRyaXZlciBjb3VsZCBiZSBsb2FkZWQg
dXNpbmcNCj4gPiA+IGFsdGVybmF0aXZlIG1ldGhvZHMgc3VjaCBhcyBBQ1BJIG9yIGBmb3JjZV9k
ZXZpY2VfaWRgIGluIHRoZSBhYnNlbmNlDQo+ID4gPiBvZiBhIG1hdGNoaW5nIHN5c3RlbSBETUkg
ZW50cnkuDQo+ID4gDQo+ID4gWW91IG5lZWQgdG8gQ2MgdGhlIGF1dGhvciBvZiB0aGlzIGNoYW5n
ZSB0byBnaXZlIHRoZW0gYSBzYXkuDQo+IA0KPiBUaGFua3MgZm9yIENjJ2luZyBtZS4NCj4gDQo+
ID4gPiBSZXN0b3JlIHRoaXMgYWJpbGl0eSB3aGlsZSBrZWVwaW5nIHRoZSByZWZhY3RvcmVkDQo+
ID4gPiBgcGxhdGZvcm1fZGV2aWNlX2luZm9gIHRhYmxlLg0KPiANCj4gU28sIHRoZSBlcnJvciB3
aWxsIGJlIHJldHVybmVkIHdoZW4gQ09ORklHX0RNST1uLCBvciB0aGVyZSBpcyBubyBtYXRjaGlu
ZyBlbnRyeQ0KPiBpbiB0aGUgdGFibGUuIEFuZCB0aGUgdGFibGUgb25seSBpcyBmaWxsZWQgd2hl
biBwcmVzZW50IGluIHRoZSBmaXJtd2FyZSBhbmQga2VybmVsDQo+IGhhcyBDT05GSUdfRE1JPXku
IFRoYXQncyB3aHkgdGhlIG9yaWdpbmFsIGNvZGUgd2FzIGl0ZXJhdGluZyB2aWEgRE1JIHN0cmlu
Z3MgaW4NCj4gYSBjdXN0b20gd2F5LiBCZXNpZGVzIHRoYXQgdGhlcmUgaXMgYW4gQUNQSSBlbnVt
ZXJhdGlvbiBhdmFpbGFibGUsIHdoaWNoIGlzIG5vdA0KPiB2aXNpYmxlIGRpcmVjdGx5IGZyb20g
dGhhdCBwaWVjZSBhbmQgaGVuY2Ugbm8gZXJyb3Igc2hvdWxkIGJlIHJldHVybmVkIGlmIG5vDQo+
IG1hdGNoZXMgZm91bmQuDQpDb3JyZWN0DQo+IA0KPiBOb3cgdG8gcHJldmVudCBzaW1pbGFyIHBh
dGNoZXMgKGFzIG1pbmUpIGFwcGVhciBpbiB0aGUgZnV0dXJlLCBjYW4gd2UgYWxzbyBhZGQNCj4g
YSBjb21tZW50IG9uIHRvcCBvZiB0aGUgZm9yLWxvb3AgdG8gZXhwbGFpbiBhbGwgdGhpcz8NCkkg
ZG8gdGhpcyBhbmQgc2VuZCBhIHYyIHBhdGNoDQo+IA0KPiBXaXRoIGEgY29tbWVudCBhZGRlZCwg
eW91IG1heSBhZGQgbXkNCj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNo
ZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KVGhhbmtzDQo=

