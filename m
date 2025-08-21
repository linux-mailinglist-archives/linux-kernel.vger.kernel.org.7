Return-Path: <linux-kernel+bounces-780119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8BB2FDDF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B47BAC2586
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735942236FD;
	Thu, 21 Aug 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a4IVIWah"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4752561AB;
	Thu, 21 Aug 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788622; cv=fail; b=jTs2MEJquGvms+FVPKL58C1FD/p05Xqpto2hKRC0LBf5wD5VDFS2nKTSI1bz5WRQc+yerV2z21ijvJNK7Fnvh6yyd4SNcA2tr11tu8YJzoSkjJ/uGdfHUmGxMCvEXpwzclZi1l7ai9hmM4xbIfL2HdfBIn2ivTV5zRl4+Hi6SAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788622; c=relaxed/simple;
	bh=0za4mHfGWA472iWXYlUQH7ve5fcvnMzAWmAT6uA04Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V/wSbCyNdsZGWDqGNYJXQwgVPWKwbuex8J6rJk0djak36SYlfFbi67ueroeyItHlyVQHw0Bn7wQdz2jyQn7eBr5iJtGuu48FQQSY8OZ5cQXamW24RUFcJMGpYl0w8TWH/G5HI5F769fJ4sAFkU2bSWvNuDvvqW18/Hf0DTSYxT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a4IVIWah; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZde8ZZzfMYCS08K+gc0MPgZm2y5PIVbSzU1xwF9sxugSG/d0QFMc5K+mpOgj772eI/uByBXSPLFarxeX382dxOkCYdZq3IHKPGWyElhl2FPacj9Sk95w03KUOmxqSWHKvguzzv1JvzQjUI80b4VJ73pglZPvG8bz201cVzU29zgktNemtUoE0/FAhfSIyfdwRipQAjWi559MiwkkGBdnXHYFYgULL+DouEOBdt1IHos8cIc6qYSCVaehNPrRegpPxekik5XtTp4sIvbdP8kAjvOp8OEGr9CQemMyuKr3duoLSKyFreUg49q+L1DAyjVvXKjGXc2zW6P+P+SYYBa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfC818ldoO+wuxLprsTPM079vZ+cF5TseRpZdVgzgCc=;
 b=S4neb2/vUW7YGLfcG2SpsMmh+ZYHIwnyeSnMeJQVUuSFmV3mFIFwI8+LxPfJ6w1jQvjNgurAmGMpGiBKf4I9nkNDkDHo/DRWExdxhniZBhpx58hNG/SUcNfGYwtvuWYnQPVWqlpfjAODVImPw4DNQzJqKHY2JiDB1oe6CcWgDpZ/I7TUd8sZzYqPK4vBMbnDPlM25RuznKkGgeGrTz9VI0Zq9dl7Yi0I++FjsT27dKEAPWGfp3R67b63ySVlHJNomYs1I4mVS0b7EFrhKbG4l5d5uPUjD1Z4P7RK30gdq2YJfjPyxnzG19qecqBUv5xj+F8tgSMJgxNJ/AvBoK/glA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfC818ldoO+wuxLprsTPM079vZ+cF5TseRpZdVgzgCc=;
 b=a4IVIWah65taKH8iQGHjd9pBXG+8GMNGtGbUj3f7h5p47CkAkUWKI1H6HgNckOa50ZNN77GWeQvFCNGSzyIwy0pWgZ+h+cKNOFR50VCfchMiqivtdrm9Z5Nxd8UNJ96XkGks5rwJpcZqSQ+bLe8MeAs//wMIOMQNGKYUgcX922NJ8zRNYeLxSzzUowK295BWpuGqj9PJnGFFDpqc5PhVv6vJmHEu2h5xHmEj5PRpMPogzlE8IQA/uBfdKXJyrK5f0qZbirP4Bx80UmNnhhvROVPGZvQl5CqUCwzAq1Xgy9/XpvI1+f2jymJWRW9sGzkrUmDXFL8mmkEog3gyR4BFcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 15:03:37 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 15:03:37 +0000
Date: Thu, 21 Aug 2025 11:03:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx95-19x19-evk: correct the phy setting for
 flexcan1/2
Message-ID: <aKc1Qg9aiVsKfMft@lizhi-Precision-Tower-5810>
References: <20250819-can-dts-fix-v1-1-e43e7d98a544@nxp.com>
 <aKSdOeeS04waVwTg@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKSdOeeS04waVwTg@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 325eb20d-23d4-4de5-1cc2-08dde0c3e843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bFVUMSlqCyDXkcqhIcOYxViBFhhePYuZQz0+g8O6ygrCoMjnh1XjZ0sgi1m/?=
 =?us-ascii?Q?cdK1YD1oOh6KHxRd5AVk94KfZPdZdfbqtdCeA8kQmyPJrDOqyveK5yqNPS7t?=
 =?us-ascii?Q?t5fwMbUFZGWofBs3lcnZYodOSZlguSAW83wbWzLcjI5UuHSj53h1c8x5QuYY?=
 =?us-ascii?Q?J6cM+loY9za+OmK22Rv3GWGW4Fpk913seYE4dG1il8znOr7es+xhA4seZZN5?=
 =?us-ascii?Q?lj0WcSxywYyxmTEHY1iKeFkXQgOBUBV5NVdf3igZDa0nddIqo+XqhU0d9zBl?=
 =?us-ascii?Q?I6j3ALw9Tpd2/qY4ahdz4ofnr0YMWvew0D6sCcgbK7thaUW9i1H5CU6pyhdo?=
 =?us-ascii?Q?71hrTTmyF5xnHeuqdYfeSdRaI5i6qMcODUTG8UXe/tBnvkNrw8O53ZG1g5CO?=
 =?us-ascii?Q?rx3o07EtjptGR5x2TnvHuNrfnFwPjmg99WpWE10ApGnB0x/8cdVgJyybjKWJ?=
 =?us-ascii?Q?Pa74rnpcluiloeq+0vDER0EvtL3oV8C6YtO1Rt8VMjb/enQyz/MnFz2Zh8mQ?=
 =?us-ascii?Q?uvz94jdlQLHAZOJQwVmAmMuh31p+KNtMZey+Iob1929mbhs/QOHPRXhRkkkV?=
 =?us-ascii?Q?CgdwIabRrzf1zr3W7Wzomzg1vAb5Q9xK49uqKBQsg6WN1gjAdtwbsg/6xKY5?=
 =?us-ascii?Q?IfiRTQqX2L44p4Ap7kUGzWHcC191NZeeUlmSLnUuMTLLp9B52td7prg41nPI?=
 =?us-ascii?Q?k7TxAH6nuZDP6zU8wbT3IS9lIENtDWNaHZDuQS5UjRgRbdVy2OX/70ESV0d8?=
 =?us-ascii?Q?6aiOsacjiUWCSec1K4nB2tLppXFkznXQlpVlUgrVTRPkYbXSipPZmmlneVzr?=
 =?us-ascii?Q?70WVsXrq8Kujemym+KtmYlWXnYLsFGbGTL7pgRu2ZPWvBn4gXCPvhRKyDqxN?=
 =?us-ascii?Q?jGt5QRDVTM7kCfXFtqmWSQ/EOEltHSHZoADCQQ7PXhUkNFmPmqYITjKaNmR+?=
 =?us-ascii?Q?tMsO5m6VVj8RX9v2vMvlqf913RRorYFyJer6z2oZupOT67tAicoksRtvLNdT?=
 =?us-ascii?Q?pli7060R+M05XYp2e8VdIweMsXmcmTfnNLHYOitDEE8D9tpEl8JlOoprVDNu?=
 =?us-ascii?Q?mXdkyAPsSjpShQnnf08aBuYCYcM3xxdCj4n7DJZuuvTpF//mfeWYDLzVO4D8?=
 =?us-ascii?Q?RbG3OLN/qN5kEETGpQdIHIl7KBXzktsHcFeVys6p3E74kA7FDL4OjS+kXe4y?=
 =?us-ascii?Q?/VIcGlPz08L7gQWdef4YqD+xzShJsgGtthtDv0MEGeQgcanOc7nmyHgOgX0Y?=
 =?us-ascii?Q?C428UnrGZuMaoRdUAljDgeudc85fIc3cM9BDEIz/wJRBzc0aK9A3/TgcdlxM?=
 =?us-ascii?Q?z9/zT/v6TruvzN6HAmk076KqmfzZI389NHWR5I/MARz3D8X9sLDLcUe3uQX4?=
 =?us-ascii?Q?OashCZSRRgHA+rmBasiOkc44ma+35PqJBq2IZy8aZh6SL2g9yLyaEva1wRK6?=
 =?us-ascii?Q?CKYWPOSFfEUjo4wNicvQ46jEBHjiKyaDBK/GN5kMqPDHjY1Iso9Oa9odZtvN?=
 =?us-ascii?Q?apT07PzmqkerVZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ArqXpmwyRoj7fxHo9fxNsf0zLrQ25O4py+JGoLpgsdcq1JhnnX+/asx2SAoH?=
 =?us-ascii?Q?AchhTMF4v5ONdcasNHrXjx9bTnAlfdSh4+RFhh0LvpoRdKvUKmsB7z1zCTiY?=
 =?us-ascii?Q?Ov+coxFgXBshnHYRVX4dvjsQDMonP48FBKbfMN7/6TvHmFDVQl5eLkJf4m9H?=
 =?us-ascii?Q?VEfB6KnsP8uc82vS+yl/fFuhT3voX3k4AqhRlZFqzWC5cwUN+dsHoWLt53+6?=
 =?us-ascii?Q?CWK5RYlNPqUNuXWzM60ttNm8XC5EYfYElfTGmb4nYalWnBwWXd3C0K9w0Uz8?=
 =?us-ascii?Q?jm6Vw84bf5TqzRsPUCEnVRL+Q0SeY41kxDZhgzBHIh6tud2urnKuNw1glVvc?=
 =?us-ascii?Q?/kPKUMT3dl7ZGd/C+1x+dFU+UXWc7SAA71PKLix93l3zQn6mm7wXnFMxcTp8?=
 =?us-ascii?Q?qoISeT/caHoD+Dc8oR38G+qoCJ2YBG551/f25HaEOtfP5Jy752Qk+IJaOxmc?=
 =?us-ascii?Q?QFXE+dVI9+4sdQ7R+4UQrrnOLFMzc7eKvrpHJARk4IW2fdhohPZSvkRRjtHa?=
 =?us-ascii?Q?8iC2zQFYErS6DbeXeV8CgPLZ9SuW+gLuoj7VV4PJHELwwrMZ2zE0eB6SFbdi?=
 =?us-ascii?Q?y/huO2h0trQOtT36hcVNYSy+Xb8ho+jCnlqfnjfTRVDPi+ykXzITZhfYNr8i?=
 =?us-ascii?Q?7fSKpkCECD2pqyI9ph/MB14aAa5c1bL1q99m1FS10mvc4PZSlR06LUPC+T30?=
 =?us-ascii?Q?+/r/HjqeEqTQCYcM7Dx3vMd61V0oKMB2ZZFj0rfRGBBeuQyYrGk+UWhn2n/c?=
 =?us-ascii?Q?ZuQbnhepIO5Ygr1IxpgxCYDRYXcQBDN1ejZ+Ge2quHQ3PPbATvlZ0h5hxEBz?=
 =?us-ascii?Q?xci4FDN7bAUotUZFyt5CcgRn2HAs1oi/VVA9QnhMYKzPq8A8PoO+EltYl5cY?=
 =?us-ascii?Q?e8ECVk8qYSmb+61Bv/0C0oqrXgE37VisNyJTHHiX5WlD7HyTe4gxUOm3ZA88?=
 =?us-ascii?Q?+PoVG9Hz6vT6uC581qsdFOJCrR7jvpDYeg06MljQwiSFy+pEwycul2QkSjBX?=
 =?us-ascii?Q?QoXBBKCBiOY2a+groUiUgWIB2iWIiwVEjadKEKItPUVwgGOcTRPm/I7ynh0p?=
 =?us-ascii?Q?CJYR1vXYFOVJlkZsz9J6IwhKr1VX9v9S9aKwVjyN76kAOCFf8zXa04OKcIuI?=
 =?us-ascii?Q?zNEciBjPsqYBt184AH1E6W/DPsQWRmBLXNp7EN+hsCUk8sz5Wd2W3sRNrW17?=
 =?us-ascii?Q?ZC6lqMzoOebXg3sW92GbTSJRWBsqpOYUrieidXJZcbLwuqLUKBsQ3x8Xj152?=
 =?us-ascii?Q?AtIsuGDYigwXqJypiwh5PNBqcbD0J9NGslqqBrE7nNDN5czR+L0Bp5car1OM?=
 =?us-ascii?Q?fkXMmjbmL58+l9xeZVT4BupX4PLmQ9rrxIk90zx9SF4C2rghsbFUiR8xJYgk?=
 =?us-ascii?Q?TmpXFa8IbWCJkPWaNV4phUDya+prAjl8XAqtqQS1iK20cWFg57ZcNZ28GXgH?=
 =?us-ascii?Q?RkoseSPM6+7z3Z/Jm9SMHWbRpYKuENho6/B0+durOX4RjMLuKUliAtcn9K53?=
 =?us-ascii?Q?6djpLDzs5LNogy520UQYBuQUCa58CzlUHb6eMzLQUwblzRnov/x8pvZmmFS4?=
 =?us-ascii?Q?/SsDr2tcwbBsDFXW7GrcaYYpCbYwddIdP3+XZuUz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325eb20d-23d4-4de5-1cc2-08dde0c3e843
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:03:37.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJGGSPzN++UaZAq4R5ICBt2RB7oWK9k9s1UlUzOomnXgEB5PAlQ3YWaZ+LDK3i1xV8zZWINZWb/iqoEtGs+kLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8585

On Tue, Aug 19, 2025 at 11:50:17AM -0400, Frank Li wrote:
> On Tue, Aug 19, 2025 at 10:43:37AM +0800, Haibo Chen wrote:
> > 1, the phy support up to 8Mbit/s databitrate for CAN FD.
> >    refer to product data sheet:
> >      https://www.nxp.com/docs/en/data-sheet/TJA1463.pdf
> > 2, the standby pin of the phy is ACTIVE_LOW.
> > 3, the phy of flexcan2 connect the standby/en pin to PCAL6408 on i2c4 bus.
> >
> > Fixes: 02b7adb791e1 ("arm64: dts: imx95-19x19-evk: add adc0 flexcan[1,2] i2c[2,3] uart5 spi3 and tpm3")
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > index 2f949a0d48d2d8066388884703c3b3cd678f16e1..9d034275c847606919af8ee4a80a00599abf4d8b 100644
> > --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > @@ -80,17 +80,17 @@ linux_cma: linux,cma {
> >  	flexcan1_phy: can-phy0 {
> >  		compatible = "nxp,tjr1443";
> >  		#phy-cells = <0>;
> > -		max-bitrate = <1000000>;
> > +		max-bitrate = <8000000>;
> >  		enable-gpios = <&i2c6_pcal6416 6 GPIO_ACTIVE_HIGH>;
> > -		standby-gpios = <&i2c6_pcal6416 5 GPIO_ACTIVE_HIGH>;
> > +		standby-gpios = <&i2c6_pcal6416 5 GPIO_ACTIVE_LOW>;
>
> It use go though CAN phy.

Sorry, I mass up. It is correct.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Frank
> >  	};
> >
> >  	flexcan2_phy: can-phy1 {
> >  		compatible = "nxp,tjr1443";
> >  		#phy-cells = <0>;
> > -		max-bitrate = <1000000>;
> > -		enable-gpios = <&i2c6_pcal6416 4 GPIO_ACTIVE_HIGH>;
> > -		standby-gpios = <&i2c6_pcal6416 3 GPIO_ACTIVE_HIGH>;
> > +		max-bitrate = <8000000>;
> > +		enable-gpios = <&i2c4_gpio_expander_21 4 GPIO_ACTIVE_HIGH>;
> > +		standby-gpios = <&i2c4_gpio_expander_21 3 GPIO_ACTIVE_LOW>;
> >  	};
> >
> >  	reg_vref_1v8: regulator-1p8v {
> >
> > ---
> > base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
> > change-id: 20250819-can-dts-fix-62ac1d02c007
> >
> > Best regards,
> > --
> > Haibo Chen <haibo.chen@nxp.com>
> >

