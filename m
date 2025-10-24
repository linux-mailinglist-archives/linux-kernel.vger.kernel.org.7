Return-Path: <linux-kernel+bounces-869249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C0C0768E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 573754E5B46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA9933A01C;
	Fri, 24 Oct 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c1mUlgtV"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B63272805;
	Fri, 24 Oct 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324914; cv=fail; b=oOTi8H/0QftgrItVPD6jA6YqyMiJMWt6RZW/c50/cWpWQ05cPEcu1VlHpwxO0XTS1I4oh5SZ6IV+JGK6eZp4DC7mAnaYC3mCmsywfNuObrg+O1GAV0zTIwRW9fHbulIA7RX+U1Xb6LuCWGWn+39379JPHKeL8iKAKUMPmMkpm9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324914; c=relaxed/simple;
	bh=x+xcEXNU2ks5BRgmgA15xjfGdZpgAJtjzTh+7EqXNNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=URIvEcnf0lhkPUAl8e3oTHjKnHzKI7bqpIpofUBdhW6/BkRCqy7SWjAS7FyUaAlBr/UB5/aa4+HBHC477YaO3C1p+7LlqIOI6yo4NCzsEjtRBQhcl0y3Z477iLbFSCMaAoacmZdYLuibLt/UMyV9T6mOu3sW8XGbaBcrzlgC+DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c1mUlgtV; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7t/fEFrZGIr5H6mbb2Urib/AY/DQr8s0P892vbheuu2JiV38ClqClliZd6KTrHxe+f6GaZP0YnTXmj7+NTLfIASi+0ueAytCzxTz37jtPdJA2xb4AsaVgJEDRyxsbnqPvYVej9TFq1t5VkkgKiqflgMUeNdv2LhAXMxiXWHwy6CIFsAuw/NVUq8STZ1kt9Smd8T/2LwFZWoB8VFFVARtB7BeLbrQkEYs5cBkvL2eL1O5Yzikmp09h95LCi7IctWHzONJzI+lST6py1pit8hefWGRQorJGTPAwkgmFx3CmXEmZtzDTkw00hzWSjNv4HNVhRxgVb0lDh1n8s4InNM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwyxrebxxTLPi3aPqlj54jYcdh+U2OWGjI7SY7ZuZe8=;
 b=ooitzNVwZR4SY6uDnp5L9yis6DSvIJ9ikWCvG+GrE0x2xy5GreACCAsJMSVi/sBRXAYl05sQUU6kawur5wP0dP4kk+MLDQTiL4NetgAzrM/14Xrn0qzWcKHPKef3ynxm9O1JJYQOWaEbBzwX2hzRhaW+OfVr9VOXjOsXIhuY2zlbfDEiDlICvlkNvtlmtpmSXGw4TiFHZ4F1GlPVnbnJjPREZNeQ5h8VPqXpjRbjcxF0YE5kS0MXgJNQg/xq2UwrFNBKiJ3+WfImnyd+g8xujllucwUE/7OBY/yGaBGRwtM56GhckdzXfAeO9ovM9X8CrwQmKRQA0/l32xIdZ+totA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwyxrebxxTLPi3aPqlj54jYcdh+U2OWGjI7SY7ZuZe8=;
 b=c1mUlgtVoBPRHCFBgHs983oBa6ItXyh9T77DeE1Xlxinc9kJjblHP70Of5h6/zmn07CdbU16z0HbC/Hu2Uz8gTjuD9W2KfBKrJM9pX+k2H/dpP6Z3XRSBcU7z4xZ9Q3ovKnaw5As0HYPsTOd3TACpY+uQb2ipWOBcg/5MGpWSaHo3XMKPrxzOuk37JvXEwEINYCvBloR0uLVeKw5ZmWtHDQBPb9w5KJCV/xqf+wP4RytCYk/g8gI05wswZfDQmw9RJrIlyTWWM6DC7VloRe2bk+F1LpPbgyucV+HIvce6RGcT3aGKwKMvrNZAKcDqmkK2mXtlV2vtAdQHTofkv3PPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI0PR04MB10137.eurprd04.prod.outlook.com (2603:10a6:800:244::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:55:07 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 16:55:07 +0000
Date: Fri, 24 Oct 2025 12:54:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc: Primoz Fiser <primoz.fiser@norik.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] arm64: dts: freescale: imx93-phyboard-nash: Add jtag
 overlay
Message-ID: <aPuvYwwG5N84MwGA@lizhi-Precision-Tower-5810>
References: <20251007084028.1125185-1-primoz.fiser@norik.com>
 <aPt/d9svTeUIRljW@lizhi-Precision-Tower-5810>
 <aPuO+FCeeIFv3bQm@alb3rt0-ThinkPad-P15-Gen-1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPuO+FCeeIFv3bQm@alb3rt0-ThinkPad-P15-Gen-1>
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI0PR04MB10137:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd7824a-8fc3-4258-b41d-08de131e1632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D1MtHEY4AfobLJ38zNLIr/OhLHI745Z8WPaGj1Km9vd0h9MUs8h/r7Sw674q?=
 =?us-ascii?Q?Uhds0ReAtTavQjMB3oE+k0T2nt3gZy9k4HPk0qNTLaP4SofUPU79LJakyCAN?=
 =?us-ascii?Q?+kwNauDio0961V7+5jkCwOQt3ixXkgu+PkWq3t3CQzqGFn5uBjHjuX9gHMJ8?=
 =?us-ascii?Q?P208I5HX0XXi5vVk5lfk1UJqc+bJK5+lPBszHAW1/RedL4vYwGL8q5v9mj3m?=
 =?us-ascii?Q?hYqIVd1dFuBK7/6h61i1VvbF+4EGlIXQq4nMBM0FrLgBQ/lPmXBUQeBehCA3?=
 =?us-ascii?Q?5aNdYqVJQEpEkcQWZHFzc57/ZKSR3FhLhwx5ms7fZlsqH+nbrlemEnB5TEEP?=
 =?us-ascii?Q?y55pG2ubiSngx/baS0RrO1dDrOdZ1ltztfwGKLlu4DYJZavb1JUI57N9npi0?=
 =?us-ascii?Q?j6fwggaz0XEW0LpliFFlpzscuDoXFFvpkkFcdl9y8igGg2o95jMU8/HBsf2K?=
 =?us-ascii?Q?vIFWXjcOTUjbuLNbgev97doexUxZX8CeOGV8ZTIaRGvjc+obvy/PNOqfpasX?=
 =?us-ascii?Q?onSlM4Nv2zgljtbX1oAu3pr5/bMgIo0+pfBZVXtg/pMW6Ix3r/q4BgGZAvDa?=
 =?us-ascii?Q?PcPTF66LXntxnFEp/M7LoigI5MAGQtA8F+l+FlBByPy3RNDS53b4KnEN8yXm?=
 =?us-ascii?Q?q8Sy7dxgU7/9E+PzJX20ZY67k8hXwXA7rfhwALAa8OzrVoLwshe/2wTqWt9p?=
 =?us-ascii?Q?bLidDEiQ3pCnBVPXg1Qn6W2rr4MwMNgctMjtJdzBNVdkFMF+NK+g2DaVbnYs?=
 =?us-ascii?Q?E9n4QrA9vAgmGLujjWUV4vCnuCMbO61u1Y6DPwloM6iV3q69njkPd5hYzNuX?=
 =?us-ascii?Q?Bxou3DgKJ0JB+8CAOaH9BqxgAmKmJ0GdJ8SIYfJjaec7b5+a4IYPi7YaPF14?=
 =?us-ascii?Q?8RqXtPxCg0UpPtVTPd7uWJPkFMLQRLmWzOm/7YYUrP+J6bLGoXZfWj0X3qT4?=
 =?us-ascii?Q?mU9bejiKWMrcqLlp87C31HC6bLPTjUP9xIV60uNbTRGmb4wRGZAsZ01FNC94?=
 =?us-ascii?Q?+6LWCimXeKcs+cThasDnrz2KOQCKmyZ0e2TuDumv3NurRmMkWegkthBLH9eM?=
 =?us-ascii?Q?JxdmJ9lGTC6jNPeLlzIzF9mnPpoJVG7STDULpZylfmEA2KjMQ+u/aNplXCxs?=
 =?us-ascii?Q?AuCgG5AVbMQTZLlYc9tFMdMm5ha0v7JlCTrXxkTs+YqgbBHqawrq9yAp6/Q5?=
 =?us-ascii?Q?tfBgm8aOvMeoZNu/P0LiG9NTwnYLbNCoEMjQlKEqGCuwp/oK1vpqpLRMogvp?=
 =?us-ascii?Q?7xVdXM7bEpWJoK7GhVZzprUlQpudGMMnO0v5B+LPkwfts+Dq7pB0SzrOhz6x?=
 =?us-ascii?Q?B3SEuqxUB+w1lCEwKa1PrSepLVg8Tfks0wlgHFH/dq+mNLF0WGFb2TW17jrQ?=
 =?us-ascii?Q?uTZRz6w5clfjMGdNi+ECmuWX8f9a10G7FfH0VABsPkZRoRmzYqK079Mp2Z/V?=
 =?us-ascii?Q?K1ctvNF0kP5sFJlC9bN7LPMLrbpP6TFuNJrV3fIW9wxY2Oi8PLXzU1v1FMke?=
 =?us-ascii?Q?+uGrreEc+RkClqctz79KNWGpwafi3XUS7zRh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jzLkyEJ3antXBbuBogBk9lD60uElxZi1RwUYcUy8TzMIVJhFiYKVbKw14uLd?=
 =?us-ascii?Q?5bGlymNqNG5dauhrgGCoAjY9UQTzK86h3jEkc5nr+vlh8gV9I9Wrn06I/7WF?=
 =?us-ascii?Q?v5MFUMZV1krnCXSjllcHlg12AdDQE+IuxUl7DEWmDTGN2zxedY2CB4QesIU8?=
 =?us-ascii?Q?cF0PtJ4IUTZOauPsnN0xdWHd5eUopdo7iu27Kpt4Uslbpe82QonR3zMtC6BA?=
 =?us-ascii?Q?UMCuYjF+W2J0Dp6QCHpzi2q99mW0KSk6Fk5ucONBnSE5/Ut8DCvzIs22eqwQ?=
 =?us-ascii?Q?fkot5GbCaL9eanYrkbxB6hrQNL4i7WSn2+XZlcSREuz1igG2i6Y4mnlXS8WD?=
 =?us-ascii?Q?usk/cpLhW5mzkMeKwNNrAPCKoK9ubaOLipJcPgxVv0XBRmlRrRFPoUsuKaNM?=
 =?us-ascii?Q?FnGT+SvnWInK3ms3CeuEVKX9tq9omOnX8dBuBkqMMkp20BMUYe+ZoAItv9g8?=
 =?us-ascii?Q?VGdu9L4T+kdl36vI0/kSSzlzykVSqaSNySzzOrPPpfvdOy+L6+/sdhdvMrgk?=
 =?us-ascii?Q?niihsTNE6vKbvnZnV7oQxaJLEbsbk+bwWNiiiNmZ57yAV5dJZKlLM/Emz+o1?=
 =?us-ascii?Q?cA7LRH+zTLCpUJtQQuejV9GnXkGf6APoS+5O0X/Ru4gr0P2fYsrXitPfw5XU?=
 =?us-ascii?Q?aqW/WtQUwG+9Z+iJLPBV/mOW9g/tbVTdAJJRMwFw93eMJ0Vk9UMRfyVcnl1N?=
 =?us-ascii?Q?F5e5wbwav9Xjv11YvFXysbtr+/xoInrg9Kc8DhfVvWZEbcd8ITXgussi38mF?=
 =?us-ascii?Q?66ry+Px5JOGNHBW/i/5DtDa2ceaEXEnuqJK4hUPgFdm5OSjYWqEXmTiKLqFW?=
 =?us-ascii?Q?4HSrEuthrH7oGphHjx8mPfyPvLKWKK6WNbwTooZz6CYVQ2CW0za0fbSaNsg0?=
 =?us-ascii?Q?DsDZSgpd+thgdFBQpAp503XAnv4+XHatz2SpnIUgKq4wLIASaNwJcWUut/P6?=
 =?us-ascii?Q?p4dGnOPgYXAClTy4ULuzIUbIVxJV7pu7GTaIbK189NQiPD2lA4K7RfFvLwGt?=
 =?us-ascii?Q?pwRFi0QIxFhZh3CZD/dACVe01N0wChRGyzczFdvIvx541JXWmm4rvUz2nLQP?=
 =?us-ascii?Q?bbpzjMI2i+ATGfOl7c5fnHRv/F42olMP8kUWtKFFNYD62Yd4n3KbyHIDoWGj?=
 =?us-ascii?Q?43jtvoNP0/wzqOTEFE9gcyY7eJexHBMrM8hvAqnN/0IdaVBMBhHBKfZE4fjF?=
 =?us-ascii?Q?TS8ZKjQ+h6Vi6hAdsBQDOY5VSBPlrpy9zKG7jXVIcyDvxlMCTC+1G4L8ImlG?=
 =?us-ascii?Q?jnGLM5c//ZDhnN+CvqnQXzSWRJCbOF68ev7tRTrWRcJZ/13RVy+F2tPtO4Va?=
 =?us-ascii?Q?uQD4BEFsruxndhV26/JC/zBjNAie1iLEqnNcSI+gmoT+F9G+eZzRXoEC05Nh?=
 =?us-ascii?Q?GdZi0lW9hgzFMnLyvN2W4Jfca6GhLSyezmu8zH/6/0Mpt6UDwVWAYyINovQQ?=
 =?us-ascii?Q?CSOyHakUoWxJCqsYYWPKqd3I+nxwzTqlQ5xVucdri/Ov+uJb0gxQmWsMqAMZ?=
 =?us-ascii?Q?Euf4tKKNPqUmRrK4nAxF5Ja4PRvlrikeqW08A+lRU0MVeVvIsjEbR+F4rGgs?=
 =?us-ascii?Q?cvAOhSmUpHaTmN24uNg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd7824a-8fc3-4258-b41d-08de131e1632
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:55:07.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OP7u4d8njtxzsIpHmI2EYuBK/dX6DfJQBw7gBweIg2w2c9HmpsCTS0xKLf0ZPyDOPSaZqXue7xJh48ccul267Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10137

On Fri, Oct 24, 2025 at 04:36:40PM +0200, Alberto Merciai wrote:
> On Fri, Oct 24, 2025 at 09:30:31AM -0400, Frank Li wrote:
> > On Tue, Oct 07, 2025 at 10:40:27AM +0200, Primoz Fiser wrote:
> > > Add overlay to enable JTAG pins on the board's JTAG (X41) connector.
> > >
> > > Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/Makefile        |  2 ++
> > >  .../freescale/imx93-phyboard-nash-jtag.dtso   | 26 +++++++++++++++++++
> > >  2 files changed, 28 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > index 525ef180481d..c72a6fdc5412 100644
> > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > @@ -356,10 +356,12 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
> > >
> > > +imx93-phyboard-nash-jtag-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-jtag.dtbo
> > >  imx93-phyboard-nash-peb-wlbt-07-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-peb-wlbt-07.dtbo
> > >  imx93-phyboard-segin-peb-eval-01-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-eval-01.dtbo
> > >  imx93-phyboard-segin-peb-wlbt-05-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-wlbt-05.dtbo
> > >  imx93-phycore-rpmsg-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-segin.dtb imx93-phycore-rpmsg.dtbo
> > > +dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-jtag.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-peb-wlbt-07.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-eval-01.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-wlbt-05.dtb
> > > diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
> > > new file mode 100644
> > > index 000000000000..4744eabf95f3
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
> > > @@ -0,0 +1,26 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> > > + * Author: Primoz Fiser <primoz.fiser@norik.com>
> > > + */
> > > +
> > > +#include "imx93-pinfunc.h"
> > > +
> > > +/dts-v1/;
> > > +/plugin/;
> > > +
> > > +&gpio2 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_jtag>;
> > > +};
> >
> > Use gpio to set pinctrl to no-gpio mode is strange. I am not sure if there
> > are better method, but at need comments here to show why have to do that.
> >
>
> In old imx6 platform we use pinctrl_hog for that purpose, is not?

It'd better than gpio, but I am not sure if pinctrl_hog still be supported
because I have not seen it for the long time.

Frank
>
> > Frank
> > > +
> > > +&iomuxc {
> > > +	pinctrl_jtag: jtaggrp {
> > > +		fsl,pins = <
> > > +			MX93_PAD_GPIO_IO24__JTAG_MUX_TDO	0x31e
> > > +			MX93_PAD_GPIO_IO25__JTAG_MUX_TCK	0x31e
> > > +			MX93_PAD_GPIO_IO26__JTAG_MUX_TDI	0x31e
> > > +			MX93_PAD_GPIO_IO27__JTAG_MUX_TMS	0x31e
> > > +		>;
> > > +	};
> > > +};
> > > --
> > > 2.34.1
> > >
> >

