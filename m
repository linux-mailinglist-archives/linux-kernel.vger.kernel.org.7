Return-Path: <linux-kernel+bounces-800987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610FB43E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBDB34E5C4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D962303C87;
	Thu,  4 Sep 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carnegierobotics.com header.i=@carnegierobotics.com header.b="Q2SBjQFQ"
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DBD2FFDFC;
	Thu,  4 Sep 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995620; cv=none; b=ZW37jXxs5mVcdRwb+VDFtvITZff/MFG+/9cvGU0mSjOE1v3eP9cYOkQ184GO90eNuFmnSzAgm3gyfuBCRHKAKS/Hq1uaeQX+kkVuy+Inchz19TaA5ffqyyVKXZrCjSDseXqUxqf5iMgun5XBkUM6wPw9ZAIlFkYcWhCfq4FWxzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995620; c=relaxed/simple;
	bh=K1BPoJ85OJrgvmG5MfwpmeB5WDcuB8xbdlvveBnF3dc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rD4hoLxzanheC+ymlJe5s4Hgaoeio9Ce5sHvCjvFhnUzBWdAza+uhHMeAXZS/LK0gNyOT1/nyirjBi5X9DNxAp6zHjO6aAcoCSqjjQHAx6fwTjjF1Rmh9Ks9cDElhy+dTkZXVs5LDQDOy8T6gepsiD10aSQWbN3SgMruN56UArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=carnegierobotics.com; spf=pass smtp.mailfrom=carnegierobotics.com; dkim=pass (2048-bit key) header.d=carnegierobotics.com header.i=@carnegierobotics.com header.b=Q2SBjQFQ; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=carnegierobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carnegierobotics.com
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4cHhT85zrHz60X9;
	Thu,  4 Sep 2025 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	carnegierobotics.com; h=mime-version:content-transfer-encoding
	:content-id:content-type:content-type:user-agent
	:content-language:accept-language:in-reply-to:references
	:message-id:date:date:subject:subject:from:from:received
	:received:received:received; s=mr01; t=1756995610; x=1759587611;
	 bh=K1BPoJ85OJrgvmG5MfwpmeB5WDcuB8xbdlvveBnF3dc=; b=Q2SBjQFQp3xv
	CtSfWwH1hNHpz6kB+phVgd1KMiZfRh9CRcBXS/+oZKxZsdC+8tvcLvSHCK5ZLpqh
	9h0PF65YkHVSkmzqOPSJtyrqLyVqKsfAls4eozKZ+1UT9lK640/mKFiWXd3yoKFB
	wjol3MUlG8802oLZ2HJ0AkkXPLxC/0/lCaPp1WmZCq+qjvYoIcBvOSq8vnLPr2RN
	vbxbemaXaOK64udL1NEalwSD6fHN+YkivHc02qKzkX+IWNLxak4eRFTwWBUSkxZR
	g6rwqW/UlqF6k/KxcgwHOVi9y4XED1Mno2J3PM6S+AZ1R2x+lxFYcsmJjTmzMR7U
	NNiMhYCkDQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10026) with LMTP
 id aeQvhz9ZRsQy; Thu,  4 Sep 2025 14:20:10 +0000 (UTC)
Received: from mail.carnegierobotics.com (static-108-39-229-99.pitbpa.fios.verizon.net [108.39.229.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by 011.lax.mailroute.net (Postfix) with ESMTPS id 4cHhT26L5Nz60RY;
	Thu,  4 Sep 2025 14:20:06 +0000 (UTC)
Received: from CRL-PGH-EX19-1.crl.local (10.1.7.176) by
 CRL-PGH-EX19-1.crl.local (10.1.7.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Thu, 4 Sep 2025 10:20:05 -0400
Received: from CRL-PGH-EX19-1.crl.local ([fe80::81d6:ea84:15d9:67d4]) by
 CRL-PGH-EX19-1.crl.local ([fe80::81d6:ea84:15d9:67d4%7]) with mapi id
 15.02.1544.033; Thu, 4 Sep 2025 10:20:05 -0400
From: Woody Douglass <wdouglass@carnegierobotics.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] regulator: pf530x: NXP PF530x regulator driver
Thread-Topic: [PATCH v5 0/2] regulator: pf530x: NXP PF530x regulator driver
Thread-Index: AQHcHaPqZda73QNCTk6YbkyJSCwBkLSDUmKAgAADaIA=
Date: Thu, 4 Sep 2025 14:20:05 +0000
Message-ID: <26fe4872-dc16-4db1-ac0a-e325222d0864@carnegierobotics.com>
References: <20250902-pf530x-v5-0-658c403e6a52@carnegierobotics.com>
 <3c45fe88-c9f4-4606-87bc-726f262998cc@carnegierobotics.com>
 <9050a07a-e94e-4d34-b4aa-bd2e6f91f792@kernel.org>
In-Reply-To: <9050a07a-e94e-4d34-b4aa-bd2e6f91f792@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCA9911085ADE849989238A1B89EB733@crl.local>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gOS80LzI1IDEwOjA3LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAwNC8wOS8y
MDI1IDE1OjU3LCBXb29keSBEb3VnbGFzcyB3cm90ZToNCj4+IEFsbCwNCj4+DQo+PiBXaGVuIGkg
c3VibWl0dGVkIHRoaXMgcGF0Y2gsIEkgZ290IGEgYnVuY2ggb2YgInVuc29saWNpdGVkIG1haWwi
IGJvdW5jZXMgZnJvbSBnbWFpbC4gTXkgDQo+PiBAY2FybmVnaWVyb2JvdGljcy5jb20gYWRkcmVz
cyBpcyBhbiBleGNoYW5nZSBzZXJ2ZXIgd2l0aCBubyBleHBvc2VkIHNtdHAsIHNvIGkgaGF2ZSB0
bw0KPj4gc2VuZCBwYXRjaGVzIHdpdGggYGdpdCBzZW5kLWVtYWlsYCB2aWEgYW4gZW52ZWxvcGUg
c2VuZGVyIChnaXRAZG91Z2xhc3MuZGV2KS4gSSBzdXNwZWN0IA0KPj4gdGhpcyBpcyB3aGF0IGNh
dXNlZCB0aGlzLiBJJ20gc29ycnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlOyBwYXRjaCB2NSBzdGls
bCBzZWVtcyB0byBiZSANCj4+IG9uIHRoZSBsa21sIGFyY2hpdmUuDQo+IA0KPiBNYXliZSBiNCBy
ZWxheSB3aWxsIGJlIGhlbHBmdWw6DQo+IGh0dHBzOi8vYjQuZG9jcy5rZXJuZWwub3JnL2VuL2xh
dGVzdC9jb250cmlidXRvci9zZW5kLmh0bWwNCj4gDQo+IGJ1dCBpZiB5b3UgaGF2ZSBvd24gU01U
UCwgdGhlbiBjb3VsZCB3b3JrIGFzIHdlbGwuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KPiANCg0KSSB3aWxsIGNvbmZpZ3VyZSB0aGUgd2ViIHJlbGF5IGZvciBmdXR1cmUgcGF0
Y2hlcywgdGhhbmsgeW91ISBTaG91bGQgSSByZXN1Ym1pdCBwYXRjaCB2NSwgb3IgaXMgdGhlDQpm
YWN0IHRoYXQgaXQncyBvbiB0aGUgbGttbCBhcmNoaXZlIGdvb2QgZW5vdWdoPyBpdCdzIGF0DQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjUwOTAyLXBmNTMweC12NS0wLTY1OGM0MDNl
NmE1MkBjYXJuZWdpZXJvYm90aWNzLmNvbS8NCg0KVGhhbmtzLA0KV29vZHJvdyBEb3VnbGFzcw0K
DQo=

