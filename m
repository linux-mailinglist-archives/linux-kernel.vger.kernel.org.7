Return-Path: <linux-kernel+bounces-674526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1914BACF0A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 15:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A49169868
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 13:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F4A247291;
	Thu,  5 Jun 2025 13:28:22 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D4246775;
	Thu,  5 Jun 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130101; cv=none; b=rzGdcFXYDpaI7yw1pDqrMDTpFN6g1GHutTTRrbyM6Wv4fx88ORBN77lRE3cCGA48RWrXwhNlNgpIK1tY2aJ+MftlU7TqcrfOy04De9rQAVTYO9SYl5X70jO101MuBSEvkgEa46LfNQRCm7ZjctxcMXPUC+SdpiRpYEZZnJe8/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130101; c=relaxed/simple;
	bh=Y/PkaHnmDJIFCq7JUHOIoqq0JufPEvzABwQKtTywsGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qybFOEW9+36CLWM0ABfutKBDz1DppWbohA/GDqsQCSGDi5vHJ1Yj81NQc00UbKx+8ZhOB0hUaFOQzmE42/rSphVQlJDja6PQFOCqaKjbFCGIDpzy0DtQexBeKNGJ2es+Z6NU1Kb08NhIh9bBHalrRtDopN/8T8dY1q/IylawIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Jun
 2025 15:28:02 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Thu, 5 Jun 2025 15:28:02 +0200
From: John Ernberg <john.ernberg@actia.se>
To: =?utf-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: Frank Li <Frank.li@nxp.com>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, John Ernberg <john.ernberg@actia.se>
Subject: [PATCH v4 4/4] arm64: dts: freescale: imx8qxp/imx8qm: Add CAAM
 support
Thread-Topic: [PATCH v4 4/4] arm64: dts: freescale: imx8qxp/imx8qm: Add CAAM
 support
Thread-Index: AQHb1h2ph2TtuHQV/UyvhoDM1n6IyQ==
Date: Thu, 5 Jun 2025 13:28:02 +0000
Message-ID: <20250605132754.1771368-5-john.ernberg@actia.se>
References: <20250605132754.1771368-1-john.ernberg@actia.se>
In-Reply-To: <20250605132754.1771368-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
x-esetresult: clean, is OK
x-esetid: 37303A2956B1445363726A
Content-Type: text/plain; charset="utf-8"
Content-ID: <256320B80A75A6469D813BA76D6A1239@actia.se>
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
biBFcm5iZXJnIDxqb2huLmVybmJlcmdAYWN0aWEuc2U+DQoNCi0tLQ0KDQpJbXBvcnRlZCBmcm9t
IE5YUCB0cmVlLCB0cmltbWVkIGRvd24gYW5kIGZpeGVkIHRoZSBkdGJzX2NoZWNrIHdhcm5pbmdz
Lg0KQ29uc3RyYWluZWQgdGhlIHJhbmdlcyB0byB0aGUgbmVlZGVkIG9uZXMuDQpDaGFuZ2VkIHRo
ZSBjb21taXQgbWVzc2FnZS4NCk9yaWdpbmFsIGhlcmU6IGh0dHBzOi8vZ2l0aHViLmNvbS9ueHAt
aW14L2xpbnV4LWlteC9jb21taXQvNjk5ZTU0YjM4NmNiOWI1M2RlZjQwMTc5OGQwYTRlNjQ2MTA1
NTgzZA0KDQotLS0NCg0KdjQ6DQogLSBEcm9wIFsgXSByZXdvcmsgZGV0YWlsaW5nIGZyb20gY29t
bWl0IGxvZy4gKEZyYW5rIExpKQ0KIC0gQWRkIGFuIG92ZXJyaWRlIGR0c2kgdG8gY2hhbmdlIHRo
ZSBjb21wYXRpYmxlcyBvbiBRWFAgZHVlIHRvIGNoYW5nZXMgaW4NCiAgIDMvNC4gKEZyYW5rIExp
KQ0KDQp2MzoNCiAtIG5vIGNoYW5nZXMNCg0KdjI6DQogLSBVc2UgbmV3IGNvbXBhdGlibGVzIGlu
dHJvZHVjZWQgaW4gMy80IChGcmFuayBMaSkNCi0tLQ0KIC4uLi9ib290L2R0cy9mcmVlc2NhbGUv
aW14OC1zcy1zZWN1cml0eS5kdHNpICB8IDM4ICsrKysrKysrKysrKysrKysrKysNCiBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0uZHRzaSAgICAgfCAgMSArDQogLi4uL2R0cy9m
cmVlc2NhbGUvaW14OHF4cC1zcy1zZWN1cml0eS5kdHNpICAgIHwgMTYgKysrKysrKysNCiBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgICAgfCAgMiArDQogNCBmaWxl
cyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtc3Mtc2VjdXJpdHkuZHRzaQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLXNzLXNlY3VyaXR5
LmR0c2kNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgt
c3Mtc2VjdXJpdHkuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtc3Mt
c2VjdXJpdHkuZHRzaQ0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4u
OWVjYWJiMmQwM2U5DQotLS0gL2Rldi9udWxsDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4LXNzLXNlY3VyaXR5LmR0c2kNCkBAIC0wLDAgKzEsMzggQEANCisvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCisvKg0KKyAqIENvcHlyaWdodCAyMDE5IE5Y
UA0KKyAqLw0KKw0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9maXJtd2FyZS9pbXgvcnNyYy5oPg0K
Kw0KK3NlY3VyaXR5X3N1YnN5czogYnVzQDMxNDAwMDAwIHsNCisJY29tcGF0aWJsZSA9ICJzaW1w
bGUtYnVzIjsNCisJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCSNzaXplLWNlbGxzID0gPDE+Ow0K
KwlyYW5nZXMgPSA8MHgzMTQwMDAwMCAweDAgMHgzMTQwMDAwMCAweDkwMDAwPjsNCisNCisJY3J5
cHRvOiBjcnlwdG9AMzE0MDAwMDAgew0KKwkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHFtLWNhYW0i
LCAiZnNsLHNlYy12NC4wIjsNCisJCXJlZyA9IDwweDMxNDAwMDAwIDB4OTAwMDA+Ow0KKwkJaW50
ZXJydXB0cyA9IDxHSUNfU1BJIDE0OCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJCSNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KKwkJI3NpemUtY2VsbHMgPSA8MT47DQorCQlyYW5nZXMgPSA8MCAweDMx
NDAwMDAwIDB4OTAwMDA+Ow0KKwkJZnNsLHNlYy1lcmEgPSA8OT47DQorCQlwb3dlci1kb21haW5z
ID0gPCZwZCBJTVhfU0NfUl9DQUFNX0pSMj47DQorDQorCQlzZWNfanIyOiBqckAzMDAwMCB7DQor
CQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHFtLWpvYi1yaW5nIiwgImZzbCxzZWMtdjQuMC1qb2It
cmluZyI7DQorCQkJcmVnID0gPDB4MzAwMDAgMHgxMDAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxH
SUNfU1BJIDQ1MyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJCQlwb3dlci1kb21haW5zID0gPCZw
ZCBJTVhfU0NfUl9DQUFNX0pSMj47DQorCQl9Ow0KKw0KKwkJc2VjX2pyMzoganJANDAwMDAgew0K
KwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxbS1qb2ItcmluZyIsICJmc2wsc2VjLXY0LjAtam9i
LXJpbmciOw0KKwkJCXJlZyA9IDwweDQwMDAwIDB4MTAwMDA+Ow0KKwkJCWludGVycnVwdHMgPSA8
R0lDX1NQSSA0NTQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQorCQkJcG93ZXItZG9tYWlucyA9IDwm
cGQgSU1YX1NDX1JfQ0FBTV9KUjM+Ow0KKwkJfTsNCisJfTsNCit9Ow0KZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS5kdHNpIGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OHFtLmR0c2kNCmluZGV4IDZmYTMxYmM5ZWNlOC4uNmRmMDE4NjQz
ZjIwIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLmR0
c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS5kdHNpDQpAQCAt
NjEyLDYgKzYxMiw3IEBAIHZwdV9kc3A6IGRzcEA1NTZlODAwMCB7DQogCX07DQogDQogCS8qIHNv
cnRlZCBpbiByZWdpc3RlciBhZGRyZXNzICovDQorCSNpbmNsdWRlICJpbXg4LXNzLXNlY3VyaXR5
LmR0c2kiDQogCSNpbmNsdWRlICJpbXg4LXNzLWNtNDEuZHRzaSINCiAJI2luY2x1ZGUgImlteDgt
c3MtYXVkaW8uZHRzaSINCiAJI2luY2x1ZGUgImlteDgtc3MtdnB1LmR0c2kiDQpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1zcy1zZWN1cml0eS5kdHNp
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1zcy1zZWN1cml0eS5kdHNp
DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi4xNWYxMjM5ZGFiMjQN
Ci0tLSAvZGV2L251bGwNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhx
eHAtc3Mtc2VjdXJpdHkuZHRzaQ0KQEAgLTAsMCArMSwxNiBAQA0KKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wKw0KKy8qDQorICogQ29weXJpZ2h0IDIwMjUgQWN0aWEgTm9yZGlj
IEFCDQorICovDQorDQorJmNyeXB0byB7DQorCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtY2Fh
bSIsICJmc2wsc2VjLXY0LjAiOw0KK307DQorDQorJnNlY19qcjIgew0KKwljb21wYXRpYmxlID0g
ImZzbCxpbXg4cXhwLWpvYi1yaW5nIiwgImZzbCxzZWMtdjQuMC1qb2ItcmluZyI7DQorfTsNCisN
Cismc2VjX2pyMyB7DQorCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtam9iLXJpbmciLCAiZnNs
LHNlYy12NC4wLWpvYi1yaW5nIjsNCit9Ow0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhxeHAuZHRzaQ0KaW5kZXggMDUxMzgzMjZmMGE1Li5lMmU3OTljYzI5NGMgMTAwNjQ0DQot
LS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCisrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KQEAgLTMyMSw2ICszMjEs
NyBAQCBtYXAwIHsNCiAJLyogc29ydGVkIGluIHJlZ2lzdGVyIGFkZHJlc3MgKi8NCiAJI2luY2x1
ZGUgImlteDgtc3MtaW1nLmR0c2kiDQogCSNpbmNsdWRlICJpbXg4LXNzLXZwdS5kdHNpIg0KKwkj
aW5jbHVkZSAiaW14OC1zcy1zZWN1cml0eS5kdHNpIg0KIAkjaW5jbHVkZSAiaW14OC1zcy1jbTQw
LmR0c2kiDQogCSNpbmNsdWRlICJpbXg4LXNzLWdwdTAuZHRzaSINCiAJI2luY2x1ZGUgImlteDgt
c3MtYWRtYS5kdHNpIg0KQEAgLTMzMiw2ICszMzMsNyBAQCBtYXAwIHsNCiANCiAjaW5jbHVkZSAi
aW14OHF4cC1zcy1pbWcuZHRzaSINCiAjaW5jbHVkZSAiaW14OHF4cC1zcy12cHUuZHRzaSINCisj
aW5jbHVkZSAiaW14OHF4cC1zcy1zZWN1cml0eS5kdHNpIg0KICNpbmNsdWRlICJpbXg4cXhwLXNz
LWFkbWEuZHRzaSINCiAjaW5jbHVkZSAiaW14OHF4cC1zcy1jb25uLmR0c2kiDQogI2luY2x1ZGUg
ImlteDhxeHAtc3MtbHNpby5kdHNpIg0KLS0gDQoyLjQ5LjANCg==

