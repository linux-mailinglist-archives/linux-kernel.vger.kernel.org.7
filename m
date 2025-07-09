Return-Path: <linux-kernel+bounces-723760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C226AFEABB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A58D5A49E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF832E6D12;
	Wed,  9 Jul 2025 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndigital.com header.i=@ndigital.com header.b="c34C23dz"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2132.outbound.protection.outlook.com [40.107.115.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8E2E62C2;
	Wed,  9 Jul 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069025; cv=fail; b=K/6OqQ6Pqsoenzh8P4irdvJFG+OXRlnolTGrp/5pzrM6PCSWJZ1QvvldXirYBmCha3vnJTSSOKndTHAkuHpmDbP3+6nU1ePHRSSBdlRl7Cmd+GahXxfZ770fhMcGQGO+y8S/0WPA3bLuqF/fDfu3ykVqykh9d5tt391ek6KY4nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069025; c=relaxed/simple;
	bh=F7PBfRXlP1eOtriqCp2AKGS1GfAtPuCj4TM1pQoVoD0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kFRNgFxyacxA+1nTp811Dv2i5GGtjbWcV2lKpI6GAemyF8W2B7Ldn7Geb4rkwf1JVjwsOx9uuUFXi21qyL7e3BGN/u2ogVzWZAm/ZIvKaD6HHU/tVcQ8maCD74lgn8fUBWgM4Btt0d9QEaHh3z7rq3NucIAZAcT1Sf9nYmmnPJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ndigital.com; spf=pass smtp.mailfrom=ndigital.com; dkim=pass (2048-bit key) header.d=ndigital.com header.i=@ndigital.com header.b=c34C23dz; arc=fail smtp.client-ip=40.107.115.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ndigital.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndigital.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGvk9AbFX3h4d5069pDIOnq1UUdFV23b4Q6gKfO7PXQjMapD0PrX7P5jQtbPYIlze8fNjqCEaRwJcKLnjHYYXYHk6FPoE+Jp8CjZsUaFFjLbiVGiBGurU9Pe0v4WMTyK6ZXvq9PXv1D66QntYmNFRpINbXNliuxTPlpFEg+uCBJoc+tc2McdMi52j+k58yU+c2cT9Abn4ci2XsiY24pm6Tt6hJwKTrAm5JSqOmO2D8WXcB75HMEvzpZ8QWxJ9oyXcc7WA3ijv/dplRl+16RFOBEG0+SHFqsTpDFpNOxxPErr+53boruEyU1Q1FBfh8Ng94W9Z0x3WNatETRWjXzgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oTQYuywaxz9RZer/A0x8Jel+GRoureNgBH8AlNKouE=;
 b=lGbjq4ghCBtrDeVThcfAymgIuKC3pVsn9LNxpXVv/JiFWDbdCXw3yLPbBW+waKxujUsodoDBL24CCJzgh56E+uLpzty0DUFb7Xbu86lGRz/jCCHI5d/AtsRaxR2jWpvbGWMB796rsZsbd2HVpcV36B4khoeoLA9QkS6UXhaEdR12YD256RN5GmKRD+ODaoG9cZNEvwVNXizxNeJhGm1aR0BYxGSvtnxgwLirHwnw2JBxpO0gd/us88zuWmqktRAE7cTTCz9wL7j51CgdZCPKubO5fP96CL5O/nsSNLKc3f0JKR8tQOSHZ+lnZsY5CXRZ292XbhC4yooB6wD6oB1ypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ndigital.com; dmarc=pass action=none header.from=ndigital.com;
 dkim=pass header.d=ndigital.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ndigital.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oTQYuywaxz9RZer/A0x8Jel+GRoureNgBH8AlNKouE=;
 b=c34C23dzN3NXaGr86l6gIQJAe26S9yOdIpifd8ixAHwLXsx0mh9FOP2bWqJYNKh0211KT+zNf6Ov/ddFbeVrthp73EzTYwlR6zecgYRXfyTCGbzCwifNES9qT3kv+er3Fd32YyM+y/OIyhYCtos6VW7ByXa1CmCcL0o8JK9eUkotuxOL5qrb/YhkT3PoNFDPLKdZP8sad4OKYJNcyUATt7dYqnVLFsiRinqntk9JD4jK7mKLvAVY7N8ggZhkkRkY+PMYwNCmJJdH4V8BimYZXfazfA+DtzYAbe4fiHudqduwyJcfIDlqWO6H4g9eIrMuAbFZJS/7DlN1OHKMSZZ3jg==
Received: from YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:27::5)
 by QB1PPF5BF03A7F1.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::245) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 13:50:15 +0000
Received: from YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::206e:a5af:7f5f:76a3]) by YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::206e:a5af:7f5f:76a3%4]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 13:50:15 +0000
From: Ryan Mann <rmann@ndigital.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"johan@kernel.org" <johan@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] NDI FTDI USB driver support
Thread-Topic: [PATCH v5] NDI FTDI USB driver support
Thread-Index: Advw2GRSB9Yv2CEkQnuozIy7DI7+4g==
Date: Wed, 9 Jul 2025 13:50:15 +0000
Message-ID:
 <YQXPR01MB498735732651163477C995B9DF49A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ndigital.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQXPR01MB4987:EE_|QB1PPF5BF03A7F1:EE_
x-ms-office365-filtering-correlation-id: 04b34b0d-e412-4d73-594c-08ddbeef8873
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8Kf+VwGcK4UiefZ/zkZqIlJsALxDzRB2xi5ZV9zrk0LBZRIzS5AE1KmXO3o+?=
 =?us-ascii?Q?Lg7C/7yGwQZ3p1k6snc+Gz4nLr+zTo1hov6/f8pHi0eiS/INqZkgeN5ohVag?=
 =?us-ascii?Q?rpCvMMgXytGQKb1oqJw4PO7RrN539jLCgvUrRjpgVYmxeFDUiQtoy2DzohHS?=
 =?us-ascii?Q?yf8p0T3EHx8GpIVJUoa/FPxKQxTfed5nOJJvSS+DK6J0zwt6GIKmXM/ulQTX?=
 =?us-ascii?Q?tZe6zCz97UFxYPlbK8WApMEXQlNPribAMs/tfN/nkIFYfRoT91UayGykj0RE?=
 =?us-ascii?Q?12oxMw4t2IboV0AAqafLFBtR0d8SKok3NdqedTLDkIyWtjJI78ZKPF3Fgiqd?=
 =?us-ascii?Q?LbM/1ThobnFrffAy2CK2Oa/vy/L5if87kRjdQyyPVsqzb76+MHBOY9e6+PBJ?=
 =?us-ascii?Q?BNiKXwSe+tndbzq6zChVmeZFg90v7w/WYPZ2zgoGgv2z8AHutfdygkzq96av?=
 =?us-ascii?Q?YeIFEScNWap14l3EBOvg5KGBw6nuSOLpleJ8D0U2sAw3cXlGGdC2wWN6MVMj?=
 =?us-ascii?Q?IIVAccDScGaWRdqn0iPJJ3TzjdPh3pgeUduKskSnZOyPYNH6SjOMuWkvdPi/?=
 =?us-ascii?Q?fkX9Z8Si13d2xqKYHlASFXPIVpaR5jcHKS36llQf6ZOgRyyIchx5Hw3YKnS4?=
 =?us-ascii?Q?eoMBnbAJMTVbJfSU9QAfQHDKAKw7tkJ9HECkIuUU9z4NE2HwSZwp0PK4ELU3?=
 =?us-ascii?Q?cxB1Q7GX5YF5/L5bWnT7OoJKvXg/L0rtK+mXEMuLlbgmlyq35jVSTroai2pT?=
 =?us-ascii?Q?9ALKOXd7iO9hH6uuo6BQO2usw/L+lpKdH7vLdWTzNRrBFhl07yI0/eYEA4hG?=
 =?us-ascii?Q?Kcz85TbPwUzqvUNRFExGd+6AElEbaeseYW1PVasxJHWPboWK3k+cqlyg4jqd?=
 =?us-ascii?Q?DLK0Cs4PYivWEWw6Osc492AqGDK0mskGO+XklPFg7o10OYTHb715mSlWc70s?=
 =?us-ascii?Q?HUSofa25x23BkqjQmvRFSIILMBjsJCvhkwn0T0Q40/jkzwJBBp5heVS/9ZU0?=
 =?us-ascii?Q?XuNkif7gFiFCCwp8pY4kED89O3rUNwKC2AWTbe/lQOOPSKDy2iU5Wu+MmX1a?=
 =?us-ascii?Q?B/v7UC91QCpBLHb99OmznmRGiWVMqNnKsQdnEEGUb1AMiD2z5wDXSTfpS3Nh?=
 =?us-ascii?Q?7br6Eevw1FQW3IjziUdb3yNV3YavL6+5YHRdtcu1uYM/OPEvDZP3xI94i2og?=
 =?us-ascii?Q?1mLD//w9hnw+fMAqB4mn9hcNiSUJd534ymqrmiAyyoJNVA1HmKrp4IaMDFaL?=
 =?us-ascii?Q?CUM47km/Vi0LGvGSQzLBX+QpJKdb0tjxLt76hMSjSF6XX4KgBmP3+Evo0GWB?=
 =?us-ascii?Q?lLupDrHTF1EP7DcrDz5EdrM+BOuuCKmfEbO5FJoKIom4204EZebeVoesVRIu?=
 =?us-ascii?Q?gZypKaj3oYMdV3v2ZTm/mIoWibpKpbN3nbuwyqcwzswLoUjPrWuhQtdEprTn?=
 =?us-ascii?Q?qYYEFB3SsOk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dzKbcTdNc1y+HxoX5L+w0WPyJHs3+cH6d+Dw5KdALwWW3odngd6GlHfqxq3n?=
 =?us-ascii?Q?UjKJHBFh7oF7j2YGqTHlow0/8U2z3LtiErMzAJj4SceSR/DY7/cJa8/dgqBR?=
 =?us-ascii?Q?Nn1zXDYyb8+GLMpN/b0iexg3JA4C3NiStYNWuD/cDrGDeM4nRnClmaod3DJw?=
 =?us-ascii?Q?4imwVIH/oZZo9J9hhAM6DiNdkLigp/gakFgrEQC78I/L1A1IXjxg4cN9Yzd0?=
 =?us-ascii?Q?MZ6oCH4wfx0qS89LBNeO0WVGgKbkEftPpCmWlmUaKn87j9w3yhCWg4fSuAPh?=
 =?us-ascii?Q?AKJOzyNVdfONuIjBbl5dtURHbWkLlKNoVLYhAJm6bNqyW0hvi7gucT7pCOcH?=
 =?us-ascii?Q?cy0XEwOpPPXDHgFsv6RUNZRnS0X55Isyr8CSgTDAopZ862P54enBgMx0ADU3?=
 =?us-ascii?Q?9cVGuHTVWYThnul2pGlc831H+7IwY8lGe9DkiuHITz8CYTN/K3u59iaNOfq+?=
 =?us-ascii?Q?L66YRKgw6ReWeYZoK1xjTiQE+pPtpg/1Ic1FlbBpm+rWN3H4ostqJpbVjTt7?=
 =?us-ascii?Q?enwxwvo1+SUBRNLnh7+jf0etBMeWE5l58Femb0ff0IJvbUX3TeUyqplZoRTF?=
 =?us-ascii?Q?CmDIyOUrxnq00beZbQna/wP9hhocJvdopjjuGcx94ZoKnjZ7SgDVuqAlOohx?=
 =?us-ascii?Q?x0Dc+H4Ot3pzovKjABfgFPGl2FrfOEeVI8fDxcqoOsQLEJSXexoAI1yf16KG?=
 =?us-ascii?Q?jmNeK4gzUYQTdJwnEhazbcxJcD47F1WrntrBR//dF9dCVaEgiehDSVc6IjB9?=
 =?us-ascii?Q?n99qm6kkRVm591nzG+IJXLjIOkAPt+9WJJMheL13QYJ9KciXiqbQcg9q6qJ4?=
 =?us-ascii?Q?9bOYXc/pPAFn0XhNs9mcDGIjukN3p3UpOoI/fclW/o/XSFGiTNS7N0LRalfk?=
 =?us-ascii?Q?hpy5qKNtrqquJxZAU2q8fO+gprlWdRHbF85pcz7JW3mP8Yc4ozTYaig/KsDE?=
 =?us-ascii?Q?So7pFvzr4EGuF2D5t9RhUsBb8PWauB/gYCaJiFdTcIHndSxe+7SK0BIfUJ4J?=
 =?us-ascii?Q?17JmfyyzDfO0+TbpdGehcr2PkkxPVbHGWshQp4Ecy42ng468HA9Mm33XILHX?=
 =?us-ascii?Q?e/Zo/rkh61JPelYHrMl+4qaZpqJlx2ssYeIds+K0sTwjiLIXdqZ3qNE64S1R?=
 =?us-ascii?Q?Ht5YzkwiZ3rhkeQAUBrtVJw5qLtWvjqzGLAbgzilpT2zyvWoCI5Yd0QyTTUc?=
 =?us-ascii?Q?S/pYXlV5y7edcoqfzPkv0Wg1r/WEtFRd1UXPsNrvIrE3OQsb1IxWehMTIFy5?=
 =?us-ascii?Q?fCeWtXpF1P13CJ6+c0wipBK6nU2xvJp8PR3dhJZoodGdhorU9nlov9VwB3Su?=
 =?us-ascii?Q?qgkFsCFxY26Ld5hKaAFUtw0Zz3CmhdtzIXv77+TyTaZYpWFTDOgmquyTJmDX?=
 =?us-ascii?Q?yt7/FMvpp16EPpi0mFQrMxyfc7qD2uqlW7Y+i2gF5zVudAzDdVUo+L1w04jB?=
 =?us-ascii?Q?ky3Jw5xpIsQHZ5EBrH16bYNh9duSe54jhAYhO0iaFcpWnTosxxq1UWWFjS6m?=
 =?us-ascii?Q?kC0oe9VF6Bz0RzUr7J2RctQmV6Eu7XMdvyJDcUSWJLcFOxHFKE0yPWPLHYxQ?=
 =?us-ascii?Q?ipcp/C/wV2qaimuI1ZS/3pHG1LCkvD8ml+h/6eGf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ndigital.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b34b0d-e412-4d73-594c-08ddbeef8873
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 13:50:15.1977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd6f7980-6d04-4a6f-86bf-8f6d0297dd2f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xINb7lA+ia9ZdERFkYQ0TRXuLzhMpaW3aXsATknoIZXFcK07m5bV8p95Se5205JT9qtEkbhu9zrA/ap9GRTlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF5BF03A7F1

From: Ryan Mann (NDI) <rmann@ndigital.com>

NDI (Northern Digital Inc.) is introducing a new product called the=20
EMGUIDE GEMINI that will use an FTDI chip for USB serial communications.
Add the NDI EMGUIDE GEMINI product ID that uses the NDI Vendor ID
rather than the FTDI Vendor ID, unlike older products.

Signed-off-by: Ryan Mann <rmann@ndigital.com>
---
V1 -> V2: Email-to issues fixed
V2 -> V3: Email formatting issues fixed, removed future devices
V3 -> V4: Email formatting issues fixed, removed extra comments
V4 -> V5:	Diff whitespace issues fixed,
			Restored the Aurora SCU device mapping that was removed

 drivers/usb/serial/ftdi_sio.c     | 2 ++
 drivers/usb/serial/ftdi_sio_ids.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 6ac7a0a5cf07..68f425e39da9 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -803,6 +803,8 @@ static const struct usb_device_id id_table_combined[] =
=3D {
 		.driver_info =3D (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NDI_AURORA_SCU_PID),
 		.driver_info =3D (kernel_ulong_t)&ftdi_NDI_device_quirk },
+	{ USB_DEVICE(NDI_VID, FTDI_NDI_EMGUIDE_GEMINI_PID),
+		.driver_info =3D (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
 	{ USB_DEVICE(NOVITUS_VID, NOVITUS_BONO_E_PID) },
 	{ USB_DEVICE(FTDI_VID, RTSYSTEMS_USB_VX8_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_si=
o_ids.h
index 9acb6f837327..4cc1fae8acb9 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -204,6 +204,9 @@
 #define FTDI_NDI_FUTURE_3_PID		0xDA73	/* NDI future device #3 */
 #define FTDI_NDI_AURORA_SCU_PID		0xDA74	/* NDI Aurora SCU */
=20
+#define FTDI_NDI_VID			0x23F2
+#define FTDI_NDI_EMGUIDE_GEMINI_PID	0x0003	/* NDI Emguide Gemini */
+
 /*
  * ChamSys Limited (www.chamsys.co.uk) USB wing/interface product IDs
  */
--

