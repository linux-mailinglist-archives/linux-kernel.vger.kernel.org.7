Return-Path: <linux-kernel+bounces-721653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DCFAFCC1D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EA44862B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BDA2DCF5E;
	Tue,  8 Jul 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SbvSm5WA"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012024.outbound.protection.outlook.com [52.101.71.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C62DEA78;
	Tue,  8 Jul 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981199; cv=fail; b=nC+mxQ6ZhLrqW6tOP8Jme1JzQFbSFTn0CKkJ5qZJwdFNnUdNRtJplZD+E8ebbHBqSTlw4+ZLtBcMjWOlQ/hhMvGwKGIDyQr+5LWykzQtK4E0LpuDoQdpyzl2xria6WCB9dQfcaAopP9lrZq7cAiMf1BVUbN5++TX+tPRInOwZvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981199; c=relaxed/simple;
	bh=ApQxQ2lppQWseneQc3DS7LDh6SkhL/C8vezEttdY7dQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hMeGaggnQIvi/Ijj+nSafq7paKeJXqonlOgfO/1x4wYUv2z4IEqhVlyl3MphInkvzS92TJwFE6Nus7fyeQ/8JzDvmljfwxbJSDs+GVHrHT6en4Rdq4SHm90Pa3V0yoUJDWxEQ0c/wF6JR6hzHDa831ldVQPFzyjkQOhrbPgaef8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SbvSm5WA; arc=fail smtp.client-ip=52.101.71.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQCEbXf6QUIPMFj+LTEJZyPnBxpfbe4ue2DQuDsWZLDCTXAWrxiBH9eXSh5toggtOgtusXWS7Isi8fY/jNc8ChDxXm8eI41a2zV7sL1XEF0069u0mX7ifwPKegNoyLX1VLFUKp8evD5NrIOdQfsZaN3zOoQcejCI4w0/jZp5YoH7UECaC8Xtt0p7uzU4rlNUeYkbY6rM7PxiK4Gnp4LO/xGShjgRuIFxOFcjRQISBbzCGEGxiA5nMPar5ZkoB3s9ceeIoHboike5OemTolNfjkGo3RQMU1LQoOCFdWvw22QxfI58SYhSX8GBPxIqSlz3Yi4kn7Y514jRk00133WOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApQxQ2lppQWseneQc3DS7LDh6SkhL/C8vezEttdY7dQ=;
 b=SrPDIoesDrlQZz0pxTnnX8c/yiPi2GGfUdFNNpZcV1aA4yHY1yK2FT4Xks7sq7z6GAejtE4n1e89gfu9WpwkSB7bIPAAMTqMCrlH+BGmBWI2tufBjg9b2BPgJZEgtxNNxbltAjqIqKFx0lR2UTcZZAtRICrcn2NO1b9yN9Ro+NKWG/rXjcP/sStq9XTkeTso4Q8A5tQAXZeH9KrSV1Ku7rqqRPowBjmnZe9Ctd63ZFAEN+HwtRjL7XmdbQb8fHCzhAxwNaKJd9l+9XVGpTmxz73vneiyZw59PkO9h1qGvTMNsHXF7Dz/dxxBl6IWvVudOt6ylJonsBQQsYauiV7hTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApQxQ2lppQWseneQc3DS7LDh6SkhL/C8vezEttdY7dQ=;
 b=SbvSm5WATVXHt54HAR+sVSmHhigTHeXgdEXqwFiABle5oktgjDurtNDldTr4oOHixv6S8U7SiALiAHSmtENae20Jr5JO/NYnOCOb+wwOorKThg1RrsitG4uF4FV74ENyBth6q+cOoomtedAAHagzKjt2sPQI3G+J6ki6vGlc1zTMhg1e1VYbFMv0sOZidwRWbYDochnjydvNnciJW1j0zog9Mvwf/nmZWHaVOPETdeITQ6ZBA71DlAF/j87ua5bQnCAT3z7TNrDJ5sHge1CHYyPLJJwHBq7Q14KV7rUpUVpN3kP5snJF+3gRfWxhdTLbJHEx2FTbLasG+SAtmiALpQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10787.eurprd04.prod.outlook.com (2603:10a6:800:26d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 13:26:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:26:31 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Abel Vesa <abel.vesa@linaro.org>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Abel
 Vesa <abelvesa@kernel.org>, Frank Li <frank.li@nxp.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Laurentiu Palcu (OSS)"
	<laurentiu.palcu@oss.nxp.com>, Sandor Yu <Sandor.yu@nxp.com>
Subject: RE: [PATCH v3 0/6] clock: imx95: Add LVDS/DISPLAY CSR for i.MX94
Thread-Topic: [PATCH v3 0/6] clock: imx95: Add LVDS/DISPLAY CSR for i.MX94
Thread-Index: AQHb7uaPiYKsRO22VkG0qOvyod5AK7Qn9TmAgABDrvA=
Date: Tue, 8 Jul 2025 13:26:30 +0000
Message-ID:
 <PAXPR04MB845974EA50A29C478394CCB3884EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250707-imx95-blk-ctl-7-1-v3-0-c1b676ec13be@nxp.com>
 <aGzizyLX8HDWsWWm@linaro.org>
In-Reply-To: <aGzizyLX8HDWsWWm@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI2PR04MB10787:EE_
x-ms-office365-filtering-correlation-id: 8bc5a710-fd23-44db-94c5-08ddbe230d41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2S9K9EKuWZuVJaQTRveJckM3LOhUTRA5bt9+Gg0GT2dIpPR2RzgCMVYiY3vD?=
 =?us-ascii?Q?uv+ZRWmEXgyAOtbPluWNOdYJIPqdKELI3VNUaKM/rpfKzxoBk59E5nuCsydL?=
 =?us-ascii?Q?GJDILgoa7caZHLB5umDRVz8NHihCtFss60ds+ZRoPKjNo0JrS0YqVlXjuZb2?=
 =?us-ascii?Q?WcH/Ak3vHQ6+owfr8aYbG/vZnI17TTxbrQb4Y9AXG+37rSMf21YrURCSOg44?=
 =?us-ascii?Q?hMvXra8O5atKYNCckApyHiFYBSTZZ6qMOm9R6GwI2CsKmg2/RoetI1+73xwo?=
 =?us-ascii?Q?WRStxC5fv6LUlLeiNGQHY1zPOTQ/OjBv7Gssf5A+yT/wYh369xWZu3DocDEb?=
 =?us-ascii?Q?2ZOkhdKhZFrqZxuTPgrxMPdES6WyH9vTDf/a1BWCnw4Ni/AezJXRNuVkxXT8?=
 =?us-ascii?Q?Q/ODVMgi4CpW6jx9eqZrIxDxYTWVOCBuqwpk8xJI8eSF4/ltR5bQSsFiCRQG?=
 =?us-ascii?Q?4AKooDI3Ct3uvWz0T+SujndUsIynQEkRvT0NofnvTQss/NgpAP80Laly92Yt?=
 =?us-ascii?Q?/QuVwMMTo6rsTUYHN02ElbF+PNY6Va2DFwUU0rtfBb0ArQvsYuQ7dUyh59Ao?=
 =?us-ascii?Q?QzDBLUfKvgJLt8hqlC5P6869lh+fidKqcCiRIkqWEljyN7Wnm1ZUMesXErhN?=
 =?us-ascii?Q?4UIV0wWzemY1k2oopmT9z+TOrg0cIgEqEcrjwEXTWsv8wMDnOeuwMHOrilRq?=
 =?us-ascii?Q?zBD7yvDnZwMIRMYeYLmkytEqmKX27EWH7hvWRLSJb11IXRcnsRPv6fXS7wyE?=
 =?us-ascii?Q?ibPea61uy3gYxpC+mpNwTVWRT6RI4KO62DjJWohtUyHu36LWgsE7HqVVw4pU?=
 =?us-ascii?Q?2i/f2q0D2C0wySmxDwaanTMkiKlN5GKDOVeFT+D9xjG4EKvHVQITufKVibJS?=
 =?us-ascii?Q?pnvvYnnI0TF/+8pWursmvIKITMtUjoFD7NtLNAqZZAqcPdckP8NYWTAwUfjV?=
 =?us-ascii?Q?xr9qmcCra+f30wpKustKkKJnNHbQZo88e9CroG6YdDGCH0Ez9RzT1Ec6rEv3?=
 =?us-ascii?Q?Td7hlXEdD0sq43RZd6i7SpcFy1+mPovvDABBrPkOaJxFhsPry8u/rBOO9u/D?=
 =?us-ascii?Q?9z5+lDrf+j98syWQcgH62v0eLoORMZyQKvT9TO7kM+Y2Dwtnxvau1hGwy4aQ?=
 =?us-ascii?Q?s7HHxMD/wffRSdIZBqnaqKIo+IDn1Ws+Npk56iuXwRA5NRtET0dgE091jlWc?=
 =?us-ascii?Q?0bqdX4RT/hrTlf4fdgelZWeo77jxWJWHrU6RlcvE6PKHVfFAu0e1CLAZ7bZ+?=
 =?us-ascii?Q?oJpsT9lE9CfxiI/Vk578sKcGJQqncF17P6aSlQQ6yXzrpwkVP1NeAODr3jS7?=
 =?us-ascii?Q?CZREXXwIWOL2gYsXUtrBq1HyY7zN6h/25zcWC+ICqFFVkhuPLJAFPTOuepuc?=
 =?us-ascii?Q?madM9CPwt4LFvrqPis6Emtex2GBYmcne5HX8b6hFABz+DXvcMx8TQkYMHJnY?=
 =?us-ascii?Q?8L4oe66d7ri2ytJQxOb1c0igVE39Q4lNq6DpM9FvH/IZEa9asdAjJQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ok64L3eJPXeuEsW0oD/bgQib5IVnhPr7uRAr4MTnpkSTfdw3XkYr703UKvC7?=
 =?us-ascii?Q?EuqGdtbfyfFX4Qi+huZrNr8tGV8jaCzc6fdDWk2uH1/keIIvBUKsEZfWuio9?=
 =?us-ascii?Q?WzcY0w9QuaAFO3hAwxzCoQBvXBIsTfzFoXMd6Yd6oJvbFtOzczjJsNX9q3GI?=
 =?us-ascii?Q?GWSdc+neMmQBCX4yHYJq2dFy7gZmeGjJH6vnA03BCkI38cB6q/sB9n82yzHs?=
 =?us-ascii?Q?Seq7OtTjoZDkbHIDm2oBWBf9K7orgGNMQbV3GlQPhxiaoJ5svWVoOfEAGMAH?=
 =?us-ascii?Q?fBVxm2rAYZizGnn9wIAYSLOntEOnZj+W6D2Vx0NheVvo4htt+v6BoIEEesuB?=
 =?us-ascii?Q?YgOt83bebR9A4D6ZLC0mUz+6wcN9BsJfYCrqiWOztn7znYPES4WGkiYMwZyd?=
 =?us-ascii?Q?/3jqjm9R9klgbh+Oajd3GHDeijP5LDCGRG1fNTrgmPwai/Cqpi/IXWpCPmAZ?=
 =?us-ascii?Q?S2KYV4aUDaXjVPeB8MaYQjQ+3ygYVyd4qDhqR4zb0SYMOUE4xUXzYxZBPi8C?=
 =?us-ascii?Q?XBn3sHP7qi0otefhATKTZ760tFQrIdvr/cVqrytJttIDTeFpbXR9Hw9rBMhS?=
 =?us-ascii?Q?1/gyaryfKLwNgMWkjK7UZi1xCnkb2IaqP5pjG2J7FGTpP7k+HTCDlmgBYxK1?=
 =?us-ascii?Q?CRoJdVpMg7cLd8Y0RL4VFM3yDFP6n/u1BTwXqEGbPw4PkYT4mHt1CKHWHTwi?=
 =?us-ascii?Q?fUMzNGGycWPqDOHyVB68vCU4O2GTo8reSrgzNp++Ja/bEoqLT4ZqzlUa0Z92?=
 =?us-ascii?Q?hjY7C1vw0lOWJzaKH7eRO+Di0AaDQWmMhf42PKSwOIz8rXZYbSrWgzg2fck8?=
 =?us-ascii?Q?MPj55wYyJGprfRzh2pejSlVX/pgAPXrDzQB1yFPX4DqlI4vZBFCyTVZya+pc?=
 =?us-ascii?Q?Yt4XKC5dCcbsyTcO3HUDyzb4kuwLYpd7HnJwHRFT1PDLY8gridSdFTm4SH/j?=
 =?us-ascii?Q?HujjsUa+Utf5Bb5v4G8G6AL/00HX8QV6lT2f911qgJoUMyzwgTicfCpA5Z+6?=
 =?us-ascii?Q?xKDX0sF+Vu3C/7lz1M5YAwCIgFsGonO/paD34Q3Gg5q7fT34iwCBpi1TG19P?=
 =?us-ascii?Q?8omWtbdmy7XHG//Oz4zFJIpg3H8RFwhv30eHuLs/OrYBaQpEpBWDFHbySyte?=
 =?us-ascii?Q?3m0YfyWtTsez1b6yqsOXBY5pVPVTG77XaqqgZp/6DrwV8nU8DiBEXkhVEzbG?=
 =?us-ascii?Q?tE1Ra9ovXqXjsM5mRDLoOOD7jm/b+Sd9kXHzbekhX1sZ5R6Ivk6fhxNhQvBi?=
 =?us-ascii?Q?auHnQ7W2Y0wK7nkJ4aIeOokOW3NROHYSMw7JG75HNhR6QkBy7zoOMG4EDwyj?=
 =?us-ascii?Q?S8L/2GqUW/1EXA67x+y3dLTPp9Uy+M+u5tVxXzCnu8HWod+xLc+/dWzSe8Dr?=
 =?us-ascii?Q?22R2qeTjpV0T6XdseRLuGsBFmVpubtkQYVw5gAnBXkPd6cr1UDGDtH6xeB38?=
 =?us-ascii?Q?3LyJhXCBl43F5xcwCMLa6YmiuQNGLmPXtKlGHzHPgRChC6pddU8x+2rkt7e9?=
 =?us-ascii?Q?qSa0K7r5ilJv2xeZ9YkcmWdRFFxg7hEH6lDFHCSW6MGbO6KpQZBwPx9Fx1l6?=
 =?us-ascii?Q?AzsrYwq0VLm1E6uXINE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc5a710-fd23-44db-94c5-08ddbe230d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 13:26:31.1460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bP24oE5k3Sa0M9jd7Yn85jely5A+WEam7TovUls5hr+qXs0yWaZqo8N6Omtrs4MZiLplV7zLHkrFTvzz4SKNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10787

Hi Abel,

> Subject: Re: [PATCH v3 0/6] clock: imx95: Add LVDS/DISPLAY CSR for
> i.MX94
>=20
> On 25-07-07 10:24:36, Peng Fan wrote:
> > Similar to i.MX95, i.MX94 also has LVDS/DISPLAY CSR to provide
> clock
> > gate for LVDS and DISPLAY Controller. So following same approach to
> > add the support, as what have been done for i.MX95.
> >
> > Patch 1 is to add the binding doc.
> > Patch 2 is fixes when supporting i.MX94, but the issues are also
> > exposed to i.MX95 even not triggered. No need to rush the two
> patches
> > for 6.16.
> > Patch 3 and 4 is to add the clk driver. Patch 3 is almost picked from
> > NXP downstream with a minor update. Patch 4 is modified from NXP
> > downstream with a few minor patches merged and updated.
> > Patch 5 is the dts part to give reviewer a whole view on how it is used=
.
> >
> > Thanks for Frank Li helping do NXP internal review for the patchset.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> For some reason, this doesn't apply cleanly.
>=20
> Can you rebase on 6.16-rc1 and resend?

The patch was picked by Stephen as a fix.
clk: imx: Fix an out-of-bounds access in dispmix_csr_clk_dev_data
aacc875a448d363332b9df0621dde6d3a225ea9f

Your tree does not have the upper patch, so
there is conflict when applying the patchset.

You may need to update your base.

Please let me know if I still need to resend the patch
without the upper fix included.

Thanks,
Peng.

>=20
> Thanks,
> Abel


