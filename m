Return-Path: <linux-kernel+bounces-868927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E61C0682C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EA91B85112
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60A31D368;
	Fri, 24 Oct 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C8DfRHoT"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD628643A;
	Fri, 24 Oct 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312646; cv=fail; b=tu2eMTrg1GNvOPDLQJVjsFyMiU1azTIpPaLCl5R7bvku1X6pTXhfUBdC8T/2O3Ob0/DcDZh6hhXPMCtgNWlOH6N5FGMzy0DNCvTCxJY+CEXt2lPYiBV8X+PWvNnZkILMiM6UH9ozA1ThXbCiQUl1KTaMuOZ+O+nEVS9wn0REoTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312646; c=relaxed/simple;
	bh=Ovgs9xmVUUefnu3Kf9beAiJYMLjtsl7jJJvv9Al4N3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FBCcGVHSw1S+OhTqSbVaxC+NCcZ5uNVkLhlULg8V9Cjt8ZMdtRS6PCyoqagg3bOUI+BScjgLmaTFWso0vCn1w0IGw0DhoAnLpnUXaunkOvxfYerlDEqEBMxOAE3PPdIWIYLfksp255bsX7m6L/nwBc2KJU6J2QO+m1WAopLHXF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C8DfRHoT; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjlVb6JuZbOSQb7yqqJ/kZgJOWkQnylPh+KU3I3Cv49ssNOoXhlNmTyNo2M8O0OKtVLwfmyZ4Ru2ctX871MuLanDCCD+o0LmcJ/1AlTU5LxRqkNIJj/843YUOo45Slf3jZK8OoOAR12sJ1Ocfbz4gKdT9owMOswrMufR59s8FykIhdcvDQRhlkl95yDHmO3FPMCjkC2RhDh0uLXe/Mip4XnltKDusyvnqB5mMMd9mXrSIVvcWeq0q0NKcIu/O2B0JbTDPfZnG1aRZQYb3AkkeKtIPA3r+cEV12F1/QLYk9/Ec573Ttolxi/hc/3UbOYf+j8/1enXweaGIC/5biPthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2XJTqkxjD21FCS8sxEADTsaMDGEwgVkTmaCWHEQlm0=;
 b=fZXKA5em2AdWh/FJ1xrZ8PDl196HO1Ox85g6K+Q25M7Ciw5JKLSCgmwySZCQHJdRO7rzAYdovZhOUVCZlDAE1x4mleOW5bNZU1z5x9D/ymJhpMud8pUmVmXBLstrQx0gJcg+djkFvsxw8Bqi6gDYkgoLTSahY6SYoheShbUhtU4qoxzBMZe6nVjQqlyzuTTYL6sXyZwMauOpIAKijKk/wJP1zFmGksOsa5fqU9HBzd5Zzn70J0ScRNCUhrfEJAhhbfSnCXVyIsYi3I/gyjR0fdFOwmyAbmuztPpK4aZd+bSbAwbhaYNtX/CVC7oEhLKl5hxa8cAfqWQqnFvYXsc0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2XJTqkxjD21FCS8sxEADTsaMDGEwgVkTmaCWHEQlm0=;
 b=C8DfRHoTbp8ueXTUmNe/rmN0XFqdwDKQdHKxhUa6WPi9kqCuL90qoYlWvgzkBkjm4UUKJS1iUEmFsNM1/gnGuR/UFqMhgZeZUi36ztmsjYnTnYVPXMLgQLBN6wg/gIAs2Yfr2t75uuJu/iHrTh00bo2o+MUlak3RLQZ1Ep47RRKBEUDbXM+NP2HGAsRM1hTqBk+AwcvXKguzP8kETqav9yslFK9xExo4Alccocwg7HHzNJOX/3gMFT8QyNHLZ3xeyONtxmDPibrcNe4DnYG+BIKPDAgbgZf7Rh8DpPYRV970bHwK7ABINJKF2xTK509S0kly8HojmHJJRNm/mDcDyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB10249.eurprd04.prod.outlook.com (2603:10a6:150:1a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:30:39 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:30:39 +0000
Date: Fri, 24 Oct 2025 09:30:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] arm64: dts: freescale: imx93-phyboard-nash: Add jtag
 overlay
Message-ID: <aPt/d9svTeUIRljW@lizhi-Precision-Tower-5810>
References: <20251007084028.1125185-1-primoz.fiser@norik.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007084028.1125185-1-primoz.fiser@norik.com>
X-ClientProxiedBy: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB10249:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c31a857-69f6-4f6d-1ed4-08de130185b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k4NqQEwwPGQNBQWaRAddI/Xs2QT4Wyfxwy+MWdM86OzOYOgEY8zAmbmSaWBH?=
 =?us-ascii?Q?TJrHFgVeE48J4LhK1ftxCCdGRdfxKZlghOqvHqghayqwa7euZ16+288YOK47?=
 =?us-ascii?Q?W9VQDusMRsDaTMTxlqn286cgll4s/6dyxyG7Af3FBrQofOM7Hdq/OSDY/R93?=
 =?us-ascii?Q?QZxvJ6TVH6yJFZ6E2SN3DCCnQaf4ba9wdU0BTzjXJ2Dt5MKemPdjrJltoc4M?=
 =?us-ascii?Q?gSfBWqofTbEdYFFoBmsB7IVjwPKX03wBf+bGrsldqBDMly4brvLHhnP1tJwj?=
 =?us-ascii?Q?HP9DC3RvyEz/MrTlFZ/tvXKd9qJ/Pf7xxCiyH9SjH0MVCqnJmH0jwK9+t5iD?=
 =?us-ascii?Q?oPgSVsPmkk1fInkj88KDz1vaOu7GVhs4eMzeTMdpLOMZkLJW2GYl5TtPCcSO?=
 =?us-ascii?Q?AfXhnpB1tbcf1xbN0jixptn8qzf8E6CrZKyVf5cq43BQETnnyibkmxxthUDo?=
 =?us-ascii?Q?Hmwk8UxPCo90l7Ckxtzdw651t40bJEr6na1Y8MUmMqhiNdpkfUrX0+1hri9h?=
 =?us-ascii?Q?z4GvC/CsB2mkFbzDiZIFQ+Sa+/D05vRlduWo8TexDzP78YycheMpTk/Ygdsv?=
 =?us-ascii?Q?4SH9+dEaU+wZ5J6hBjdNxk8ldSD1MzFju8w8VLJ8pI6rcV9QODxyJThq7OLJ?=
 =?us-ascii?Q?fQDvLHY3RBNQLSHndRJ030WrODrju5HWLhKJxn9SybkkaHBnqP9aburLe2k2?=
 =?us-ascii?Q?CjEgBI2XvvBkJPRdc3x/eEaBBWpuX6ujp/W6N7gsDGRNEdQQEnZAD3JRNWC5?=
 =?us-ascii?Q?gzIkYl5c9kovA4n4X5JiAOWucop72YXuhCYzLxPXG+zC0CDEJweqVISn4RA4?=
 =?us-ascii?Q?xC3s+6xioRMbfobpC/MzFyK9bcXpQDZFIrzXlfu7tp/c+qMshFqlcYHRZTtT?=
 =?us-ascii?Q?ZZ2HbFqPt89ePskmgnk8ut5mJjGzfuM9TJdvTpb2OYnuImp6quoFs6szxA4z?=
 =?us-ascii?Q?T3Dvnf+k31sBCdyN7iZuunY3QMF6HHs8ocdM7BRP6O278jbU9of+AehKuhIh?=
 =?us-ascii?Q?+pTT9BDyE3m7zPtKvVF64+GDY1XAOKcu+eHh8ffrs67vmHY4ChBDeb9Pjkg1?=
 =?us-ascii?Q?p1Ocv/PXKI/YAdDejSqHt823reGEik5VwaWqeeao1IR4B8zTpJQmXJDSH27t?=
 =?us-ascii?Q?ejcw3IyYF9mNevYCsqzrcTHOSvAs1kWV+ozSr5/SRa4J1MRztAUnj5jEIAiE?=
 =?us-ascii?Q?6oKfzLryQYxo4RGyIjCakoIHiq09lRHf7kis5MmjD172C/jLBOmFT3AWbOVk?=
 =?us-ascii?Q?4Juxv1mq53ELp4RSbfFqHrqgsn8VEEO5gfksa9oj3JR/oMCHdBt86kJCjujt?=
 =?us-ascii?Q?rEe737Ami3EbubuC5KsJ6KAENPNOelPPyueXNqXT+rE2LXePDwUI+KmCYV51?=
 =?us-ascii?Q?Ougo7g9/0WbOhPoQcR0xKOQH2ntN43BHYcBOQNkkCknXzWjfS344NRC53CvU?=
 =?us-ascii?Q?MyNLKXAxo6Pb7YBcPdedOjKqW0uSAUlK0DO1G9xYYaSKg2MCOV8mkL+hET/3?=
 =?us-ascii?Q?/9NQvRiiP++6SxsPtjrFB0fTsFpa4SQ2W1L/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QPYcWXe1527rjvIG8bSLf2G3R9pjfoD8hZGluYb8uasku46aCgF1729jGVgH?=
 =?us-ascii?Q?kkmxBQfjuo4rF6nViU78g1+MKokmiP6mYcIPxXJGotL2mc+8ea95y/wa9kCd?=
 =?us-ascii?Q?KzPEogtItchsoaZG5GDfA2Qi8ZvgaHIWZyZcJsfA5/Ojzw1GPi6g+efQDslx?=
 =?us-ascii?Q?Dtdd3E4lPqmyrH+kVIhmxqf45rd1WYzRVAO8CHJ0T+WfgCktmfQT/zq8BpWQ?=
 =?us-ascii?Q?wnCDabJTiVe8Ge989vJv7zxI95bunec+/GkqOSRJ+OwQTllEcgMgNYvoExII?=
 =?us-ascii?Q?+lB205ZG6rUbRuPb6K2WL8aPAIo7q8KPUC9HaRZx+VO7YxTNTKNGX4a6+97h?=
 =?us-ascii?Q?25lcoOylQFIe7ilUeYcKHW++vdnYMeR1DtyQUMpM0kSO++FrPWUlTsfteYaw?=
 =?us-ascii?Q?pcI+cITx5f5zic5voVR7hoIzay47e2XUn/UNS1rp1JQ3Hd7gmPS309WJGXFY?=
 =?us-ascii?Q?ZPKU/3STkmaUNEoap3SFOGxC/k+BshjP8ItljLtOY2P4SNtkax8bUfgc294y?=
 =?us-ascii?Q?lJe6Usv2rltQl1r5LdV1J/C3zsdLopyhN7TQQ0fl9qJwEekrsCoSaOxf+i0N?=
 =?us-ascii?Q?Ow9YFWQnnSze7+HM8bVKkqmAoM4lcxJWKIHcPI9dNyDQzAzi7rXx3BzGVbPv?=
 =?us-ascii?Q?7WOVMZQQFRl3AlSz0LFvRysqOci7fCBf/EzSscuieAFBQPc4Q/D/+aNu/NV/?=
 =?us-ascii?Q?hcca3276Kecz+k38Vt8zR8BxsFq00vCiY26jUp4Ov6z5zQJife9xf7st5Ewj?=
 =?us-ascii?Q?N5ZRS7lPRxS+jdI8pVvQbegK30sDlLnC1ng9+WYf0PxFPHEvJpgli20z8EBs?=
 =?us-ascii?Q?+85ECqO/DSeBMjiXi3bhxYtjx+Xqi3P4ksaCDHbshIDdm+fTM1S//jo+7Fh2?=
 =?us-ascii?Q?Fz1WKCuz2+d0goQY5JjZC5VTZGqzXE59/wq7KWYmMfcIvPry3q/TFf4Mj8Cm?=
 =?us-ascii?Q?U3jUd4exzHNABYfNLoCnQ7yX1clHmJEPA49mTdM6oww21Kt6vQOb7SaWwbJb?=
 =?us-ascii?Q?4Dskh0m+zgBg685s5+hTDTB3pidpXbW59dRLm9dJAZ/yE0Xemw58iS4nUu7i?=
 =?us-ascii?Q?VqJtr7ftd8IH+CXhcgzE1mBEVP/umFxx9n6u5dN0XtaombUiHkKuIagGMeag?=
 =?us-ascii?Q?FmzMevG34daGzlyd3i+q0S+Es/OVWY35tNP/qImWxOIZLf6rAk0hyrrtc4EC?=
 =?us-ascii?Q?v0guWXq9DrO4ugTqAS/WakXKQUKrgIPBKNhnlaChu+X31ufvq+Fp9Z5a1Obp?=
 =?us-ascii?Q?jJRQElP1+OHmhJqkS3ga/vINq8L6HZzzuIs2T8RL81QSjnyacoGUGtrXAGFa?=
 =?us-ascii?Q?8ISoq1vDTAHVDCjq8++WNeHEgAfM/kyWsbWWR1giYXJQQny/N2Ja4UpT/0T9?=
 =?us-ascii?Q?m8r5RTjF8ZNMQFDvq5NayzKV8RUrqD3xfqQlS68BlWR9ukuvd0HDmtEPM6uz?=
 =?us-ascii?Q?6bMlq0bEqdiir4DzWUF9FuJ3QhMS4d5P5n5r7/zRXgRRj4u/QrKl4ThJPEtq?=
 =?us-ascii?Q?ue1EiLPCmD5cDbWZ7eC4I9Gq4rkrRedrlH6jB2dtq4yTUhHFxxq6V0fQEYks?=
 =?us-ascii?Q?MM0JkWrP9SywD39EDOYulCa1F+GGbCZ17WoTVVEI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c31a857-69f6-4f6d-1ed4-08de130185b1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:30:39.4080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqB02/i6UKpV/eRwbdJ/zAGj6hsufApG7zjosYS5NEcGc89/uBamGNt1apH6MiocUAbAQ8at/A6XKGZTME+XIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10249

On Tue, Oct 07, 2025 at 10:40:27AM +0200, Primoz Fiser wrote:
> Add overlay to enable JTAG pins on the board's JTAG (X41) connector.
>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  2 ++
>  .../freescale/imx93-phyboard-nash-jtag.dtso   | 26 +++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 525ef180481d..c72a6fdc5412 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -356,10 +356,12 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
>
> +imx93-phyboard-nash-jtag-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-jtag.dtbo
>  imx93-phyboard-nash-peb-wlbt-07-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-peb-wlbt-07.dtbo
>  imx93-phyboard-segin-peb-eval-01-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-eval-01.dtbo
>  imx93-phyboard-segin-peb-wlbt-05-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-wlbt-05.dtbo
>  imx93-phycore-rpmsg-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-segin.dtb imx93-phycore-rpmsg.dtbo
> +dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-jtag.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-peb-wlbt-07.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-eval-01.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-wlbt-05.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
> new file mode 100644
> index 000000000000..4744eabf95f3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + * Author: Primoz Fiser <primoz.fiser@norik.com>
> + */
> +
> +#include "imx93-pinfunc.h"
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&gpio2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_jtag>;
> +};

Use gpio to set pinctrl to no-gpio mode is strange. I am not sure if there
are better method, but at need comments here to show why have to do that.

Frank
> +
> +&iomuxc {
> +	pinctrl_jtag: jtaggrp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO24__JTAG_MUX_TDO	0x31e
> +			MX93_PAD_GPIO_IO25__JTAG_MUX_TCK	0x31e
> +			MX93_PAD_GPIO_IO26__JTAG_MUX_TDI	0x31e
> +			MX93_PAD_GPIO_IO27__JTAG_MUX_TMS	0x31e
> +		>;
> +	};
> +};
> --
> 2.34.1
>

