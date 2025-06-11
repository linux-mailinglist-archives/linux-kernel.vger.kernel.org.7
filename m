Return-Path: <linux-kernel+bounces-681558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32027AD543A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 13:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1513A4017
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 11:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F0926E719;
	Wed, 11 Jun 2025 11:38:23 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC525BEF2;
	Wed, 11 Jun 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641902; cv=none; b=lbAa8zGELncRxImkAGTBzb4mK/JhRNtTJlRck9GxS+EqbL99JjyUGframPs6s11lcgVLtgax7yjMbKs5SDIWsNWVUDjD6qnthwQzY4DmTticoVotYff/PzuiO0eqI3qheDqgtG8NJaHwgeRXM1f9H9uC13HE/ITfc4taIPQ+/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641902; c=relaxed/simple;
	bh=RF8tZiWdJUUbfAebIfpZ2EQt2sn5aseOWwh3y5E2b5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J/GmoSb2a6ii0dU6dhvE/+6OvqqcvkKdRUYCWbNNcT8wKQnePnn/DV2emnmtD1NnXQFXKRfGbHM+IOc/Vj/tSgvMQbsXcg6HdSLDuV2ff/En4ptNzk8jdjKXXeAW7TLEinShPGT0KQ43zsbIsWIGO0sWc3QsOaD/oUAJvi0SIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:38:09 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Wed, 11 Jun 2025 13:38:09 +0200
From: John Ernberg <john.ernberg@actia.se>
To: =?utf-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, John Ernberg <john.ernberg@actia.se>
Subject: [PATCH v6 4/4] arm64: dts: freescale: imx8qxp/imx8qm: Add CAAM
 support
Thread-Topic: [PATCH v6 4/4] arm64: dts: freescale: imx8qxp/imx8qm: Add CAAM
 support
Thread-Index: AQHb2sVOAXmd4TEBjUCisdSH8JiddQ==
Date: Wed, 11 Jun 2025 11:38:09 +0000
Message-ID: <20250611113748.2986988-5-john.ernberg@actia.se>
References: <20250611113748.2986988-1-john.ernberg@actia.se>
In-Reply-To: <20250611113748.2986988-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
x-esetresult: clean, is OK
x-esetid: 37303A2956B14453627160
Content-Type: text/plain; charset="utf-8"
Content-ID: <45207C18BEFD1A4599757711765979BD@actia.se>
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
PHBlbmcuZmFuQG54cC5jb20+DQpSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5j
b20+DQoNCi0tLQ0KDQpJbXBvcnRlZCBmcm9tIE5YUCB0cmVlLCB0cmltbWVkIGRvd24gYW5kIGZp
eGVkIHRoZSBkdGJzX2NoZWNrIHdhcm5pbmdzLg0KQ29uc3RyYWluZWQgdGhlIHJhbmdlcyB0byB0
aGUgbmVlZGVkIG9uZXMuDQpDaGFuZ2VkIHRoZSBjb21taXQgbWVzc2FnZS4NCk9yaWdpbmFsIGhl
cmU6IGh0dHBzOi8vZ2l0aHViLmNvbS9ueHAtaW14L2xpbnV4LWlteC9jb21taXQvNjk5ZTU0YjM4
NmNiOWI1M2RlZjQwMTc5OGQwYTRlNjQ2MTA1NTgzZA0KDQotLS0NCg0KdjY6DQogLSBQcm9wZXJs
eSBzb3J0IHByb3BlcnRpZXMgKEZyYW5rIExpKQ0KIC0gQ29sbGVjdCB0YWdzDQoNCnY1Og0KIC0g
Q29sbGVjdCB0YWdzDQoNCnY0Og0KIC0gRHJvcCBbIF0gcmV3b3JrIGRldGFpbGluZyBmcm9tIGNv
bW1pdCBsb2cuIChGcmFuayBMaSkNCiAtIEFkZCBhbiBvdmVycmlkZSBkdHNpIHRvIGNoYW5nZSB0
aGUgY29tcGF0aWJsZXMgb24gUVhQIGR1ZSB0byBjaGFuZ2VzIGluDQogICAzLzQuIChGcmFuayBM
aSkNCg0KdjM6DQogLSBubyBjaGFuZ2VzDQoNCnYyOg0KIC0gVXNlIG5ldyBjb21wYXRpYmxlcyBp
bnRyb2R1Y2VkIGluIDMvNCAoRnJhbmsgTGkpDQotLS0NCiAuLi4vYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDgtc3Mtc2VjdXJpdHkuZHRzaSAgfCAzOCArKysrKysrKysrKysrKysrKysrDQogYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLmR0c2kgICAgIHwgIDEgKw0KIC4uLi9kdHMv
ZnJlZXNjYWxlL2lteDhxeHAtc3Mtc2VjdXJpdHkuZHRzaSAgICB8IDE2ICsrKysrKysrDQogYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpICAgIHwgIDIgKw0KIDQgZmls
ZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LXNzLXNlY3VyaXR5LmR0c2kNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1zcy1zZWN1cml0
eS5kdHNpDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
LXNzLXNlY3VyaXR5LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LXNz
LXNlY3VyaXR5LmR0c2kNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAu
LjNlMDQxNDJhY2E1Yw0KLS0tIC9kZXYvbnVsbA0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OC1zcy1zZWN1cml0eS5kdHNpDQpAQCAtMCwwICsxLDM4IEBADQorLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQorLyoNCisgKiBDb3B5cmlnaHQgMjAxOSBO
WFANCisgKi8NCisNCisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZmlybXdhcmUvaW14L3JzcmMuaD4N
CisNCitzZWN1cml0eV9zdWJzeXM6IGJ1c0AzMTQwMDAwMCB7DQorCWNvbXBhdGlibGUgPSAic2lt
cGxlLWJ1cyI7DQorCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKwkjc2l6ZS1jZWxscyA9IDwxPjsN
CisJcmFuZ2VzID0gPDB4MzE0MDAwMDAgMHgwIDB4MzE0MDAwMDAgMHg5MDAwMD47DQorDQorCWNy
eXB0bzogY3J5cHRvQDMxNDAwMDAwIHsNCisJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxbS1jYWFt
IiwgImZzbCxzZWMtdjQuMCI7DQorCQlyZWcgPSA8MHgzMTQwMDAwMCAweDkwMDAwPjsNCisJCWlu
dGVycnVwdHMgPSA8R0lDX1NQSSAxNDggSVJRX1RZUEVfTEVWRUxfSElHSD47DQorCQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCisJCSNzaXplLWNlbGxzID0gPDE+Ow0KKwkJcmFuZ2VzID0gPDAgMHgz
MTQwMDAwMCAweDkwMDAwPjsNCisJCXBvd2VyLWRvbWFpbnMgPSA8JnBkIElNWF9TQ19SX0NBQU1f
SlIyPjsNCisJCWZzbCxzZWMtZXJhID0gPDk+Ow0KKw0KKwkJc2VjX2pyMjoganJAMzAwMDAgew0K
KwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxbS1qb2ItcmluZyIsICJmc2wsc2VjLXY0LjAtam9i
LXJpbmciOw0KKwkJCXJlZyA9IDwweDMwMDAwIDB4MTAwMDA+Ow0KKwkJCWludGVycnVwdHMgPSA8
R0lDX1NQSSA0NTMgSVJRX1RZUEVfTEVWRUxfSElHSD47DQorCQkJcG93ZXItZG9tYWlucyA9IDwm
cGQgSU1YX1NDX1JfQ0FBTV9KUjI+Ow0KKwkJfTsNCisNCisJCXNlY19qcjM6IGpyQDQwMDAwIHsN
CisJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cW0tam9iLXJpbmciLCAiZnNsLHNlYy12NC4wLWpv
Yi1yaW5nIjsNCisJCQlyZWcgPSA8MHg0MDAwMCAweDEwMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0g
PEdJQ19TUEkgNDU0IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJCXBvd2VyLWRvbWFpbnMgPSA8
JnBkIElNWF9TQ19SX0NBQU1fSlIzPjsNCisJCX07DQorCX07DQorfTsNCmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0uZHRzaSBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhxbS5kdHNpDQppbmRleCA2ZmEzMWJjOWVjZTguLjZkZjAxODY0
M2YyMCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS5k
dHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0uZHRzaQ0KQEAg
LTYxMiw2ICs2MTIsNyBAQCB2cHVfZHNwOiBkc3BANTU2ZTgwMDAgew0KIAl9Ow0KIA0KIAkvKiBz
b3J0ZWQgaW4gcmVnaXN0ZXIgYWRkcmVzcyAqLw0KKwkjaW5jbHVkZSAiaW14OC1zcy1zZWN1cml0
eS5kdHNpIg0KIAkjaW5jbHVkZSAiaW14OC1zcy1jbTQxLmR0c2kiDQogCSNpbmNsdWRlICJpbXg4
LXNzLWF1ZGlvLmR0c2kiDQogCSNpbmNsdWRlICJpbXg4LXNzLXZwdS5kdHNpIg0KZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAtc3Mtc2VjdXJpdHkuZHRz
aSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAtc3Mtc2VjdXJpdHkuZHRz
aQ0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uMTVmMTIzOWRhYjI0
DQotLS0gL2Rldi9udWxsDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
cXhwLXNzLXNlY3VyaXR5LmR0c2kNCkBAIC0wLDAgKzEsMTYgQEANCisvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMCsNCisvKg0KKyAqIENvcHlyaWdodCAyMDI1IEFjdGlhIE5vcmRp
YyBBQg0KKyAqLw0KKw0KKyZjcnlwdG8gew0KKwljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLWNh
YW0iLCAiZnNsLHNlYy12NC4wIjsNCit9Ow0KKw0KKyZzZWNfanIyIHsNCisJY29tcGF0aWJsZSA9
ICJmc2wsaW14OHF4cC1qb2ItcmluZyIsICJmc2wsc2VjLXY0LjAtam9iLXJpbmciOw0KK307DQor
DQorJnNlY19qcjMgew0KKwljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLWpvYi1yaW5nIiwgImZz
bCxzZWMtdjQuMC1qb2ItcmluZyI7DQorfTsNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4cXhwLmR0c2kNCmluZGV4IDA1MTM4MzI2ZjBhNS4uZTJlNzk5Y2MyOTRjIDEwMDY0NA0K
LS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQorKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCkBAIC0zMjEsNiArMzIx
LDcgQEAgbWFwMCB7DQogCS8qIHNvcnRlZCBpbiByZWdpc3RlciBhZGRyZXNzICovDQogCSNpbmNs
dWRlICJpbXg4LXNzLWltZy5kdHNpIg0KIAkjaW5jbHVkZSAiaW14OC1zcy12cHUuZHRzaSINCisJ
I2luY2x1ZGUgImlteDgtc3Mtc2VjdXJpdHkuZHRzaSINCiAJI2luY2x1ZGUgImlteDgtc3MtY200
MC5kdHNpIg0KIAkjaW5jbHVkZSAiaW14OC1zcy1ncHUwLmR0c2kiDQogCSNpbmNsdWRlICJpbXg4
LXNzLWFkbWEuZHRzaSINCkBAIC0zMzIsNiArMzMzLDcgQEAgbWFwMCB7DQogDQogI2luY2x1ZGUg
ImlteDhxeHAtc3MtaW1nLmR0c2kiDQogI2luY2x1ZGUgImlteDhxeHAtc3MtdnB1LmR0c2kiDQor
I2luY2x1ZGUgImlteDhxeHAtc3Mtc2VjdXJpdHkuZHRzaSINCiAjaW5jbHVkZSAiaW14OHF4cC1z
cy1hZG1hLmR0c2kiDQogI2luY2x1ZGUgImlteDhxeHAtc3MtY29ubi5kdHNpIg0KICNpbmNsdWRl
ICJpbXg4cXhwLXNzLWxzaW8uZHRzaSINCi0tIA0KMi40OS4wDQo=

