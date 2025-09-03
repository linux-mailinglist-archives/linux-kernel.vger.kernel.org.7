Return-Path: <linux-kernel+bounces-799410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3861B42B45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5858C1A838D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6812DFA2B;
	Wed,  3 Sep 2025 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carnegierobotics.com header.i=@carnegierobotics.com header.b="E+2nOlpk"
Received: from 005.lax.mailroute.net (005.lax.mailroute.net [199.89.1.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCAB285053;
	Wed,  3 Sep 2025 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932408; cv=none; b=O7PWYqXsp6xBBbgOmwvQkLdbtn4KWS2WI5YuOOd21L6s2dahd569aYFZ9TIbVuXe80POGcL7gaeLHrr1AsszbjShuBPPVGbK5Bl1reCRz4Hp0Mc1o9euU0b3QIv/HjM8HISBviuDe3hrId8jm+GUcsUgqRcU46FUc6qmRUL5Q+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932408; c=relaxed/simple;
	bh=Jh8YJTI6x+CDN9DdHtnOFTsKzYbssGelp2jGpmIMkrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UKfq3WUIkv8OsuYBd4uUrH6MSr0dvOE5Bpvg5c3ku9lSz3gfGCKfBzA5ILAdvlnXOqE+5Pfow2yoEtrFuKtPmIHCguTHc8oQ3Lt1o9fkvcAEj1tjAIjITCu269KusYd3M2uuf33ETEkBa2x3i9wjPQq3RVTYkRN4af6Lm+MQdkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=carnegierobotics.com; spf=pass smtp.mailfrom=carnegierobotics.com; dkim=pass (2048-bit key) header.d=carnegierobotics.com header.i=@carnegierobotics.com header.b=E+2nOlpk; arc=none smtp.client-ip=199.89.1.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=carnegierobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carnegierobotics.com
Received: from localhost (localhost [127.0.0.1])
	by 005.lax.mailroute.net (Postfix) with ESMTP id 4cHF5X2Rb9zmDP4q;
	Wed,  3 Sep 2025 20:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	carnegierobotics.com; h=mime-version:content-transfer-encoding
	:content-id:content-type:content-type:user-agent
	:content-language:accept-language:in-reply-to:references
	:message-id:date:date:subject:subject:from:from:received
	:received:received:received; s=mr01; t=1756932399; x=1759524400;
	 bh=Jh8YJTI6x+CDN9DdHtnOFTsKzYbssGelp2jGpmIMkrU=; b=E+2nOlpk9kB7
	l2Z1ZwvEE1hxebt0XWUp6DjQcTyA4Qa+PK0apomA/chNaRjDfmaDjIOxLjG2RGnW
	A3fYXV7aPOSYSs79PdVfZv70UV2JBmH+T0jhK6ztUaONJjv2H8MY/V6b47rV9A7k
	7lZYKyxjExH+E4kHXcrMEP0mtXsNOrDr/eYoIWWiKqAThGveQVFncqW5rWHbv3kw
	jSpyepflTQsEurPzLddHdEDgkHsVzIpUsW0sT5JrEZATDHa+pPeh3aib3nO8Zw+u
	8J/bp2QLNGWVUq395k2rRwXXTJ55sLfhg9RJfKNwfmW/yvSNNSCHXFDc13LUYGZe
	2gMwFVIcUA==
X-Virus-Scanned: by MailRoute
Received: from 005.lax.mailroute.net ([127.0.0.1])
 by localhost (005.lax [127.0.0.1]) (mroute_mailscanner, port 10026) with LMTP
 id ny3V4AAdRe_U; Wed,  3 Sep 2025 20:46:39 +0000 (UTC)
Received: from mail.carnegierobotics.com (static-108-39-229-99.pitbpa.fios.verizon.net [108.39.229.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by 005.lax.mailroute.net (Postfix) with ESMTPS id 4cHF5Q4Mj9zmCQWV;
	Wed,  3 Sep 2025 20:46:33 +0000 (UTC)
Received: from CRL-PGH-EX19-1.crl.local (10.1.7.176) by
 CRL-PGH-EX19-1.crl.local (10.1.7.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Wed, 3 Sep 2025 16:46:32 -0400
Received: from CRL-PGH-EX19-1.crl.local ([fe80::81d6:ea84:15d9:67d4]) by
 CRL-PGH-EX19-1.crl.local ([fe80::81d6:ea84:15d9:67d4%7]) with mapi id
 15.02.1544.033; Wed, 3 Sep 2025 16:46:32 -0400
From: Woody Douglass <wdouglass@carnegierobotics.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] regulator: pf530x: dt-bindings:
 nxp,pf530x-regulator
Thread-Topic: [PATCH v3 2/2] regulator: pf530x: dt-bindings:
 nxp,pf530x-regulator
Thread-Index: AQHcHRH7NxCOvr8uJ0qr5q/ZrBTWhrSCMJMA
Date: Wed, 3 Sep 2025 20:46:32 +0000
Message-ID: <40798d54-fb25-45b1-80c8-b378adb545d9@carnegierobotics.com>
References: <20250902-pf530x-v3-0-4242e7687761@carnegierobotics.com>
 <20250902-pf530x-v3-2-4242e7687761@carnegierobotics.com>
 <175693109173.2632698.2374155993251530154.robh@kernel.org>
In-Reply-To: <175693109173.2632698.2374155993251530154.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D935D938058004396B4D0A21BEF59F2@crl.local>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Um9iLA0KDQpUaGFuayB5b3UgZm9yIHBvaW50aW5nIHRoaXMgb3V0ISBJIHdpbGwgcmViYXNlIG9u
IHRoZSBsYXRlc3QgcmMxIGFuZCBydW4gYG1ha2UgZHRfYmluZGluZ19jaGVja2AgYmVmb3JlIHN1
Ym1pdHRpbmcgdjUhDQoNClRoYW5rcyBhZ2FpbiwNCldvb2Ryb3cgRG91Z2xhc3MNCg0KT24gOS8z
LzI1IDE2OjMzLCBSb2IgSGVycmluZyAoQXJtKSB3cm90ZToNCj4gDQo+IE9uIFdlZCwgMDMgU2Vw
IDIwMjUgMTE6MzE6MzggLTA0MDAsIFdvb2Ryb3cgRG91Z2xhc3Mgd3JvdGU6DQo+PiBCaW5kaW5n
cyBmb3IgdGhlIHBmNTMweCBzZXJpZXMgb2Ygdm9sdGFnZSByZWd1bGF0b3JzDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogV29vZHJvdyBEb3VnbGFzcyA8d2RvdWdsYXNzQGNhcm5lZ2llcm9ib3RpY3Mu
Y29tPg0KPj4gLS0tDQo+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL254cCxw
ZjUzMDAueWFtbCAgfCA1MiArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDUyIGluc2VydGlvbnMoKykNCj4+DQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5p
bmcgJ21ha2UgZHRfYmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IHlhbWxsaW50
IHdhcm5pbmdzL2Vycm9yczoNCj4gDQo+IGR0c2NoZW1hL2R0YyB3YXJuaW5ncy9lcnJvcnM6DQo+
IC9idWlsZHMvcm9iaGVycmluZy9kdC1yZXZpZXctY2kvbGludXgvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9ueHAscGY1MzAwLnlhbWw6IHByb3BlcnRpZXM6ICdh
ZGRpdGlvbmFsUHJvcGVydGllcycgc2hvdWxkIG5vdCBiZSB2YWxpZCB1bmRlciB7JyRyZWYnOiAn
Iy9kZWZpbml0aW9ucy9qc29uLXNjaGVtYS1wcm9wLW5hbWVzJ30NCj4gCWhpbnQ6IEEganNvbi1z
Y2hlbWEga2V5d29yZCB3YXMgZm91bmQgaW5zdGVhZCBvZiBhIERUIHByb3BlcnR5IG5hbWUuDQo+
IAlmcm9tIHNjaGVtYSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMva2V5
d29yZHMueWFtbCMNCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2R0LXJldmlldy1jaS9saW51eC9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL254cCxwZjUzMDAueWFtbDog
JGlkOiBDYW5ub3QgZGV0ZXJtaW5lIGJhc2UgcGF0aCBmcm9tICRpZCwgcmVsYXRpdmUgcGF0aC9m
aWxlbmFtZSBkb2Vzbid0IG1hdGNoIGFjdHVhbCBwYXRoIG9yIGZpbGVuYW1lDQo+ICAJICRpZDog
aHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcmVndWxhdG9yL254cCxwZjUzMHgtcmVndWxh
dG9yLnlhbWwNCj4gIAlmaWxlOiAvYnVpbGRzL3JvYmhlcnJpbmcvZHQtcmV2aWV3LWNpL2xpbnV4
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvbnhwLHBmNTMwMC55
YW1sDQo+IC9idWlsZHMvcm9iaGVycmluZy9kdC1yZXZpZXctY2kvbGludXgvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9ueHAscGY1MzAwLmV4YW1wbGUuZHRiOiBy
ZWd1bGF0b3JAMjggKG54cCxwZjUzMDIpOiAncmVndWxhdG9yLWFsd2F5cy1vbicsICdyZWd1bGF0
b3ItYm9vdC1vbicsICdyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCcsICdyZWd1bGF0b3ItbWluLW1p
Y3Jvdm9sdCcgZG8gbm90IG1hdGNoIGFueSBvZiB0aGUgcmVnZXhlczogJ15waW5jdHJsLVswLTld
KyQnDQo+IAlmcm9tIHNjaGVtYSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3Jl
Z3VsYXRvci9ueHAscGY1MzB4LXJlZ3VsYXRvci55YW1sIw0KPiAvYnVpbGRzL3JvYmhlcnJpbmcv
ZHQtcmV2aWV3LWNpL2xpbnV4L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1
bGF0b3IvbnhwLHBmNTMwMC5leGFtcGxlLmR0YjogcmVndWxhdG9yQDI4IChueHAscGY1MzAyKTog
J3JlZ3VsYXRvcnMnIGlzIGEgcmVxdWlyZWQgcHJvcGVydHkNCj4gCWZyb20gc2NoZW1hICRpZDog
aHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcmVndWxhdG9yL254cCxwZjUzMHgtcmVndWxh
dG9yLnlhbWwjDQo+IA0KPiBkb2MgcmVmZXJlbmNlIGVycm9ycyAobWFrZSByZWZjaGVja2RvY3Mp
Og0KPiBXYXJuaW5nOiBNQUlOVEFJTkVSUyByZWZlcmVuY2VzIGEgZmlsZSB0aGF0IGRvZXNuJ3Qg
ZXhpc3Q6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvbnhwLHBm
NTMweC1yZWd1bGF0b3IueWFtbA0KPiBNQUlOVEFJTkVSUzogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9ueHAscGY1MzB4LXJlZ3VsYXRvci55YW1sDQo+IA0KPiBT
ZWUgaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2RldmljZXRyZWUtYmluZGlu
Z3MvcGF0Y2gvMjAyNTA5MDItcGY1MzB4LXYzLTItNDI0MmU3Njg3NzYxQGNhcm5lZ2llcm9ib3Rp
Y3MuY29tDQo+IA0KPiBUaGUgYmFzZSBmb3IgdGhlIHNlcmllcyBpcyBnZW5lcmFsbHkgdGhlIGxh
dGVzdCByYzEuIEEgZGlmZmVyZW50IGRlcGVuZGVuY3kNCj4gc2hvdWxkIGJlIG5vdGVkIGluICp0
aGlzKiBwYXRjaC4NCj4gDQo+IElmIHlvdSBhbHJlYWR5IHJhbiAnbWFrZSBkdF9iaW5kaW5nX2No
ZWNrJyBhbmQgZGlkbid0IHNlZSB0aGUgYWJvdmUNCj4gZXJyb3IocyksIHRoZW4gbWFrZSBzdXJl
ICd5YW1sbGludCcgaXMgaW5zdGFsbGVkIGFuZCBkdC1zY2hlbWEgaXMgdXAgdG8NCj4gZGF0ZToN
Cj4gDQo+IHBpcDMgaW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUNCj4gDQo+IFBsZWFzZSBjaGVj
ayBhbmQgcmUtc3VibWl0IGFmdGVyIHJ1bm5pbmcgdGhlIGFib3ZlIGNvbW1hbmQgeW91cnNlbGYu
IE5vdGUNCj4gdGhhdCBEVF9TQ0hFTUFfRklMRVMgY2FuIGJlIHNldCB0byB5b3VyIHNjaGVtYSBm
aWxlIHRvIHNwZWVkIHVwIGNoZWNraW5nDQo+IHlvdXIgc2NoZW1hLiBIb3dldmVyLCBpdCBtdXN0
IGJlIHVuc2V0IHRvIHRlc3QgYWxsIGV4YW1wbGVzIHdpdGggeW91ciBzY2hlbWEuDQo+IA0KPiAN
Cg0K

