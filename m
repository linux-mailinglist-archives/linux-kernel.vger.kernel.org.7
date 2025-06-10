Return-Path: <linux-kernel+bounces-678983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6FAAD30EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 10:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E131719ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16100284682;
	Tue, 10 Jun 2025 08:51:29 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1140283C9C;
	Tue, 10 Jun 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545488; cv=none; b=M4KSb5jCtqxGt5XhT8C+aLy3yQ50y7LVgjA3ijEYcThKNtnE89HdKQ4tNtN/3xiNXtWeo3lnA09hTmynQQySsPf3Ez4a6VpMTNbYhKf1QCUIdE1XFldXWFFmIJ3VxZKOEyhxrHTu56CSmbpQms0PUhcvw64nKS3kFx0JiflsGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545488; c=relaxed/simple;
	bh=/CmCfwUrlqZ/KgrfU8/4sPIIn4fIpC5URk58i6ZZoI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IDMEXBXPkRuEdylqEv8NrOe75OtkzEJotk1JhGg+rDk0UBJLG4LZVgugXnp0Bzil70vjsCURCEl82KSpoIWNfD0/91Z34YjnjTB+/JHVHu0Ds9i35o0WmudAe2DC5Zfy6kYN4aWLqt7p80Om/GALiJWdQ2wNN1NzErd3YS818HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 10:51:18 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Tue, 10 Jun 2025 10:51:18 +0200
From: John Ernberg <john.ernberg@actia.se>
To: =?utf-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, John Ernberg <john.ernberg@actia.se>
Subject: [PATCH v5 4/4] arm64: dts: freescale: imx8qxp/imx8qm: Add CAAM
 support
Thread-Topic: [PATCH v5 4/4] arm64: dts: freescale: imx8qxp/imx8qm: Add CAAM
 support
Thread-Index: AQHb2eTU9Qch1b2PXkGE3MpymBM6pA==
Date: Tue, 10 Jun 2025 08:51:17 +0000
Message-ID: <20250610085110.2295392-5-john.ernberg@actia.se>
References: <20250610085110.2295392-1-john.ernberg@actia.se>
In-Reply-To: <20250610085110.2295392-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
x-esetresult: clean, is OK
x-esetid: 37303A2955B1445362776A
Content-Type: text/plain; charset="utf-8"
Content-ID: <C892AFD701E58E45B171D4B17EB6CCC5@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogSG9yaWEgR2VhbnTEgyA8aG9yaWEuZ2VhbnRhQG54cC5jb20+DQoNClRoZSBpTVg4UVhQ
IGFuZCBpTVg4UU0gaGF2ZSBhIENBQU0gKENyeXB0b2dyYXBoaWMgQWNjZWxlcmF0aW9uIGFuZA0K
QXNzdXJhbmNlIE1vZHVsZSkgbGlrZSBtYW55IG90aGVyIGlNWHMuDQoNCkFkZCB0aGUgZGVmaW5p
dGlvbnMgZm9yIGl0Lg0KDQpKb2IgUmluZ3MgMCBhbmQgMSBhcmUgYm91bmQgdG8gdGhlIFNFQ08g
KFNlY3VyaXR5IENvbnRyb2xsZXIpIEFSTSBjb3JlDQphbmQgYXJlIG5vdCBleHBvc2VkIG91dHNp
ZGUgaXQuIFRoZXJlJ3Mgbm8gcG9pbnQgdG8gZGVmaW5lIHRoZW0gaW4gdGhlDQpiaW5kaW5ncyBh
cyB0aGV5IGNhbm5vdCBiZSB1c2VkIG91dHNpZGUgdGhlIFNFQ08uDQoNClNpZ25lZC1vZmYtYnk6
IEhvcmlhIEdlYW50xIMgPGhvcmlhLmdlYW50YUBueHAuY29tPg0KU2lnbmVkLW9mZi1ieTogSm9o
biBFcm5iZXJnIDxqb2huLmVybmJlcmdAYWN0aWEuc2U+DQpSZXZpZXdlZC1ieTogUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQoNCi0tLQ0KDQpJbXBvcnRlZCBmcm9tIE5YUCB0cmVlLCB0cmlt
bWVkIGRvd24gYW5kIGZpeGVkIHRoZSBkdGJzX2NoZWNrIHdhcm5pbmdzLg0KQ29uc3RyYWluZWQg
dGhlIHJhbmdlcyB0byB0aGUgbmVlZGVkIG9uZXMuDQpDaGFuZ2VkIHRoZSBjb21taXQgbWVzc2Fn
ZS4NCk9yaWdpbmFsIGhlcmU6IGh0dHBzOi8vZ2l0aHViLmNvbS9ueHAtaW14L2xpbnV4LWlteC9j
b21taXQvNjk5ZTU0YjM4NmNiOWI1M2RlZjQwMTc5OGQwYTRlNjQ2MTA1NTgzZA0KDQotLS0NCg0K
djU6DQogLSBDb2xsZWN0IHRhZ3MNCg0KdjQ6DQogLSBEcm9wIFsgXSByZXdvcmsgZGV0YWlsaW5n
IGZyb20gY29tbWl0IGxvZy4gKEZyYW5rIExpKQ0KIC0gQWRkIGFuIG92ZXJyaWRlIGR0c2kgdG8g
Y2hhbmdlIHRoZSBjb21wYXRpYmxlcyBvbiBRWFAgZHVlIHRvIGNoYW5nZXMgaW4NCiAgIDMvNC4g
KEZyYW5rIExpKQ0KDQp2MzoNCiAtIG5vIGNoYW5nZXMNCg0KdjI6DQogLSBVc2UgbmV3IGNvbXBh
dGlibGVzIGludHJvZHVjZWQgaW4gMy80IChGcmFuayBMaSkNCi0tLQ0KIC4uLi9ib290L2R0cy9m
cmVlc2NhbGUvaW14OC1zcy1zZWN1cml0eS5kdHNpICB8IDM4ICsrKysrKysrKysrKysrKysrKysN
CiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0uZHRzaSAgICAgfCAgMSArDQog
Li4uL2R0cy9mcmVlc2NhbGUvaW14OHF4cC1zcy1zZWN1cml0eS5kdHNpICAgIHwgMTYgKysrKysr
KysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgICAgfCAgMiAr
DQogNCBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtc3Mtc2VjdXJpdHkuZHRzaQ0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLXNz
LXNlY3VyaXR5LmR0c2kNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDgtc3Mtc2VjdXJpdHkuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDgtc3Mtc2VjdXJpdHkuZHRzaQ0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAw
MDAwMDAwMC4uOWVjYWJiMmQwM2U5DQotLS0gL2Rldi9udWxsDQorKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4LXNzLXNlY3VyaXR5LmR0c2kNCkBAIC0wLDAgKzEsMzggQEAN
CisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCisvKg0KKyAqIENvcHlyaWdo
dCAyMDE5IE5YUA0KKyAqLw0KKw0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9maXJtd2FyZS9pbXgv
cnNyYy5oPg0KKw0KK3NlY3VyaXR5X3N1YnN5czogYnVzQDMxNDAwMDAwIHsNCisJY29tcGF0aWJs
ZSA9ICJzaW1wbGUtYnVzIjsNCisJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCSNzaXplLWNlbGxz
ID0gPDE+Ow0KKwlyYW5nZXMgPSA8MHgzMTQwMDAwMCAweDAgMHgzMTQwMDAwMCAweDkwMDAwPjsN
CisNCisJY3J5cHRvOiBjcnlwdG9AMzE0MDAwMDAgew0KKwkJY29tcGF0aWJsZSA9ICJmc2wsaW14
OHFtLWNhYW0iLCAiZnNsLHNlYy12NC4wIjsNCisJCXJlZyA9IDwweDMxNDAwMDAwIDB4OTAwMDA+
Ow0KKwkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE0OCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJ
CSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKwkJI3NpemUtY2VsbHMgPSA8MT47DQorCQlyYW5nZXMg
PSA8MCAweDMxNDAwMDAwIDB4OTAwMDA+Ow0KKwkJZnNsLHNlYy1lcmEgPSA8OT47DQorCQlwb3dl
ci1kb21haW5zID0gPCZwZCBJTVhfU0NfUl9DQUFNX0pSMj47DQorDQorCQlzZWNfanIyOiBqckAz
MDAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHFtLWpvYi1yaW5nIiwgImZzbCxzZWMt
djQuMC1qb2ItcmluZyI7DQorCQkJcmVnID0gPDB4MzAwMDAgMHgxMDAwMD47DQorCQkJaW50ZXJy
dXB0cyA9IDxHSUNfU1BJIDQ1MyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJCQlwb3dlci1kb21h
aW5zID0gPCZwZCBJTVhfU0NfUl9DQUFNX0pSMj47DQorCQl9Ow0KKw0KKwkJc2VjX2pyMzoganJA
NDAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxbS1qb2ItcmluZyIsICJmc2wsc2Vj
LXY0LjAtam9iLXJpbmciOw0KKwkJCXJlZyA9IDwweDQwMDAwIDB4MTAwMDA+Ow0KKwkJCWludGVy
cnVwdHMgPSA8R0lDX1NQSSA0NTQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQorCQkJcG93ZXItZG9t
YWlucyA9IDwmcGQgSU1YX1NDX1JfQ0FBTV9KUjM+Ow0KKwkJfTsNCisJfTsNCit9Ow0KZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS5kdHNpIGIvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLmR0c2kNCmluZGV4IDZmYTMxYmM5ZWNlOC4u
NmRmMDE4NjQzZjIwIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OHFtLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS5k
dHNpDQpAQCAtNjEyLDYgKzYxMiw3IEBAIHZwdV9kc3A6IGRzcEA1NTZlODAwMCB7DQogCX07DQog
DQogCS8qIHNvcnRlZCBpbiByZWdpc3RlciBhZGRyZXNzICovDQorCSNpbmNsdWRlICJpbXg4LXNz
LXNlY3VyaXR5LmR0c2kiDQogCSNpbmNsdWRlICJpbXg4LXNzLWNtNDEuZHRzaSINCiAJI2luY2x1
ZGUgImlteDgtc3MtYXVkaW8uZHRzaSINCiAJI2luY2x1ZGUgImlteDgtc3MtdnB1LmR0c2kiDQpk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1zcy1zZWN1
cml0eS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1zcy1zZWN1
cml0eS5kdHNpDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi4xNWYx
MjM5ZGFiMjQNCi0tLSAvZGV2L251bGwNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhxeHAtc3Mtc2VjdXJpdHkuZHRzaQ0KQEAgLTAsMCArMSwxNiBAQA0KKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KKy8qDQorICogQ29weXJpZ2h0IDIwMjUgQWN0
aWEgTm9yZGljIEFCDQorICovDQorDQorJmNyeXB0byB7DQorCWNvbXBhdGlibGUgPSAiZnNsLGlt
eDhxeHAtY2FhbSIsICJmc2wsc2VjLXY0LjAiOw0KK307DQorDQorJnNlY19qcjIgew0KKwljb21w
YXRpYmxlID0gImZzbCxpbXg4cXhwLWpvYi1yaW5nIiwgImZzbCxzZWMtdjQuMC1qb2ItcmluZyI7
DQorfTsNCisNCismc2VjX2pyMyB7DQorCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtam9iLXJp
bmciLCAiZnNsLHNlYy12NC4wLWpvYi1yaW5nIjsNCit9Ow0KZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KaW5kZXggMDUxMzgzMjZmMGE1Li5lMmU3OTljYzI5NGMg
MTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kN
CisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KQEAgLTMy
MSw2ICszMjEsNyBAQCBtYXAwIHsNCiAJLyogc29ydGVkIGluIHJlZ2lzdGVyIGFkZHJlc3MgKi8N
CiAJI2luY2x1ZGUgImlteDgtc3MtaW1nLmR0c2kiDQogCSNpbmNsdWRlICJpbXg4LXNzLXZwdS5k
dHNpIg0KKwkjaW5jbHVkZSAiaW14OC1zcy1zZWN1cml0eS5kdHNpIg0KIAkjaW5jbHVkZSAiaW14
OC1zcy1jbTQwLmR0c2kiDQogCSNpbmNsdWRlICJpbXg4LXNzLWdwdTAuZHRzaSINCiAJI2luY2x1
ZGUgImlteDgtc3MtYWRtYS5kdHNpIg0KQEAgLTMzMiw2ICszMzMsNyBAQCBtYXAwIHsNCiANCiAj
aW5jbHVkZSAiaW14OHF4cC1zcy1pbWcuZHRzaSINCiAjaW5jbHVkZSAiaW14OHF4cC1zcy12cHUu
ZHRzaSINCisjaW5jbHVkZSAiaW14OHF4cC1zcy1zZWN1cml0eS5kdHNpIg0KICNpbmNsdWRlICJp
bXg4cXhwLXNzLWFkbWEuZHRzaSINCiAjaW5jbHVkZSAiaW14OHF4cC1zcy1jb25uLmR0c2kiDQog
I2luY2x1ZGUgImlteDhxeHAtc3MtbHNpby5kdHNpIg0KLS0gDQoyLjQ5LjANCg==

