Return-Path: <linux-kernel+bounces-888897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7F6C3C349
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1717318892A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC02F5B;
	Thu,  6 Nov 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DMRvk+RG"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612962874ED;
	Thu,  6 Nov 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444696; cv=fail; b=TTY3+FwP0bQC8DFqhaDmA2zO6SpkjsX0EVrbfmyGaabFGAY76yMLR11xuF/I9gf74g0K6MdwLCXZsb+aKjtbC/nh7Gs/4tfZL/fCeCyW+XT5vBlVU7rES0WeWzKAVETHZWKa1jBmp5P3rcOPwAcXASnkB/qNPmB4X+lxAlUTA0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444696; c=relaxed/simple;
	bh=nLU6oH8Pgf459t7d+Ef4K2nnfXPlxKNAtDVB9r25YZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vkp8feBnRxu2vM6BhisW132psSY5/uC+Ss0+ECaGSi1n0fEeSaPnCvmOYwukFuwCUQblFBl85ysjnikhgysEENe6kxmwjBzEbsBV9faUV1VkzBdrKoEc5YuC/OcO/QJXZQ8DEaPeZ6rAaqIChQJUeBUrPY3UxUpRz9WjknvF2w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DMRvk+RG; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUM6iFQU3j7Fhd+cROMhAmt9Fj3z3GPuREGFSjlC3582/duuxybKIpKXT8oEJUIADdlOyCMdzVhlMGZTyxFltExauHOLk58J/zYLPVHckfxP94lS43WnOjVQysqtuTLAesy08y20oNt1exOtjORVq3lh6FFJFP+fXoyalYt88rLlHLobQgEE7W/v2KUdPA26A+xbEYEkCzgxTrS9htUKfbkSCAOlGDHe9U53dHL4qMqTUskCOZAxf0GGO+OTMeQOrA0YmXYuCQAnGqer1CjBas189NTsbCzhTTWQWsOqifdT2yICTUSlxkPfJzhwVFVpgaceumNb2Du2t4NethP4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXAxixt9GM7maY9WiyNJ807ZjQvjfYIYPaHuIp98CD8=;
 b=LjmIv8X/IDJsoPe10Tfq+/5r9tPjgAmR+7GeZG0s35kzJ0w+wqPFbiDOd5h5IOHedHKS34Ne/V5FG0zemMZRNHXsv+IrRNBvuoMLDRdPvdPFax2TfC3nC5um6xZX8Qj9u8GmYry2bCIQejSXjl338AwZtkMFgWFc9Yl+pJxN00Uy8wospiPcf7Ek0A9x58lB+iIQIW/JbB5hQeC+WfGYf8+Z/jgo+9P6+oAg7Q3lStGWAeP/Z9F4Z0g/VMUKpIzhgznz9xnqAmNKSeaWwwMdsw1yT3GEcxvbE78aQ5wJfoANEw9ju4fBVeEYWRfRVhFbtNXuqIZl8UEyQs0EDD2eYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXAxixt9GM7maY9WiyNJ807ZjQvjfYIYPaHuIp98CD8=;
 b=DMRvk+RGRKSx4TRAeIBJpzgqCjQ4wh3L9v4Lhil6Wpx8HaRUP15VrzZB/Va+ka/tIZijwQSe569hqcIW/k+a/m6ZJfWzlIttOhJ2qLC5+kxyc8LdcoYm375ZNQLFKd/6DdFwRfoQff5rSmp7Z0Ub6/N4VSIehHEWztx8domX89rc+alNdXFJmAJzAXzAqtRYW8O9pPCw/qnRaksfeqnOX0TzLtMsfJmzUI7MBivcQPb6Yp+DHjf+iE8ENeQ+++B7XyCIYnrZsDHcuetxb/dHAekfZVkeEekeHefbIfwihoIWpS9EZSgfu6BkUD8ZScxj31rnrZRvZiDFdEXGlUA63Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6950.eurprd04.prod.outlook.com (2603:10a6:20b:105::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 15:58:10 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 15:58:10 +0000
Date: Thu, 6 Nov 2025 10:58:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rui Miguel Silva <rmfrfs@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Alice Yuan <alice.yuan@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Robert Chiras <robert.chiras@nxp.com>,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Hans Verkuil <hans@jjverkuil.nl>,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v4 0/5] media: imx8qxp: add parallel camera support
Message-ID: <aQzFiEOQvtZjHIsr@lizhi-Precision-Tower-5810>
References: <20250729-imx8qxp_pcam-v4-0-4dfca4ed2f87@nxp.com>
 <20250805010822.GC24627@pendragon.ideasonboard.com>
 <aLbcpEZXm5G1Onq7@lizhi-Precision-Tower-5810>
 <20250902123920.GM13448@pendragon.ideasonboard.com>
 <aLhJDXnz9HPGrWcp@lizhi-Precision-Tower-5810>
 <aQuDSROHLGHIhtlh@lizhi-Precision-Tower-5810>
 <20251105171928.GB6046@pendragon.ideasonboard.com>
 <aQul/VGG8e3MJxhx@lizhi-Precision-Tower-5810>
 <DE1JMG95RZME.2YSV10RI9AME4@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE1JMG95RZME.2YSV10RI9AME4@gmail.com>
X-ClientProxiedBy: PH7P221CA0064.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::18) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: aa88fa88-c183-4ec5-079c-08de1d4d48cd
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?tSJu5Uamk0/q4Gov6av7nCcjbITiuHg0X383kC7yIp2JF3WzGidkB+I4pNfS?=
 =?us-ascii?Q?W7Mod7tViTYXgb/rloFfYJ2T7vrT/wKHC2tEL935spfWbzdrsmtAd9T8aQij?=
 =?us-ascii?Q?33BrKgbAUFxD0hUoVoKTuJ0AI6ZmnUk0FKSJzj7et7QEbHvjfSVwDsMx7oL+?=
 =?us-ascii?Q?9abnSexwnS8maLyVbr10NuIVB7oBOHCFMr4dqVLrLxuOT/m9cNMkHue+HVAP?=
 =?us-ascii?Q?bOKWCeNFrVq4FKa7wx7VIEzKGP52D67KfLHJ40t16fZvCA/ix928ijO8ohTM?=
 =?us-ascii?Q?wBEjCHMedOfqOztEfCAbV4JTM6vElBvNV0WWBN5zKYisGdLfGiPpm1vScA3t?=
 =?us-ascii?Q?qBNpwx8TFGpMqp8Guf5WgZuS5sHS3mA65Pb8ZcSSpfsNFRJ48UFt+2UHWBkT?=
 =?us-ascii?Q?XlOAM0ZddXv2vWapVPzaraZC1sWArJ/VkCV+Tqv9pOkZlzvWLJif/bhuZi59?=
 =?us-ascii?Q?yk0/a1CoUWXbJVPFt2uWOEywx+/2Zp4eWfrxq3Bzd6JofQ1bPKiivdAUDGY5?=
 =?us-ascii?Q?V8XyBNMK6PtUdmjEieIsQlB5usYPI0l7M+1+Ga7TvI7L5mNkEOxui5WaPKNa?=
 =?us-ascii?Q?/gOEaHdtJDryMJSBy+68T74shFdPe7uV0WXmhz1J0u+U7cEuRUersQRcU2Rc?=
 =?us-ascii?Q?EjX20RRhgaVJVVliZ4g2gd9DDD50zLGxclMlA6E1PK39HRTX0vOVaCOkYmLo?=
 =?us-ascii?Q?VYkY/fgH/E78nZDQxJzjgZDxnKEYhM4dbpJ4BG/oYAJxqVH5sAoPMfkZAtUa?=
 =?us-ascii?Q?9kMClmJ8xKYc+Z/UJcuX7QXdgwcDgkem6OSxpR3bJ4BeluWVK/4AT2/fbCZP?=
 =?us-ascii?Q?CIb//GKh9n5J+Vnqd6VI8v83n0s5TAb+tIYrVDEJ1M8jsLCirG5IHYeOAylF?=
 =?us-ascii?Q?mje0EuBdPTs/aWUtn6vujArh5OYHwgwAIDJVQij49TVioY2eTWWoxGrk/J+w?=
 =?us-ascii?Q?jPv6viE2GFRyesQFt6nsm+PK4miiqOd2RkkliyyXx/JP8vZeBRzvP1QGIXJV?=
 =?us-ascii?Q?QI233wdWwsz8vZYqivUsYb/MswPctB86Pp/3PBnjS7+aQv6wJ9bR6DgDHReT?=
 =?us-ascii?Q?Y+7TA+97lrWvV8pPdViKnfFiGNSvKzzktx0pI+3rc8KDuurD+ojv4uHeR6+5?=
 =?us-ascii?Q?4HYxwSNCgS6XZTdqnw/hjTPvG+JLWPiGPB/W3rxstASK8MbUnXRGdAMqM4pM?=
 =?us-ascii?Q?SIbGfRnpFGpLCSnTwcgncY4vZtazMZ5wvBMQs5iBrkTARH+S3vDnvV9Lar8R?=
 =?us-ascii?Q?sAeqla2bbCwwqMuOkGlb2LkDuI0dHyiUtemsFbayanFBTED7Tp/MwoPMRsj9?=
 =?us-ascii?Q?p5PlGpdGlVF90yVYDJ8Iwb0/iBSSuYYFiD6+wGpKkTwfE5CqWOyxcCdR2ww8?=
 =?us-ascii?Q?cX2a3ASkepBL0SnaSjHAcQGXBbezf0aXsfb6r83aBehZoxVrLFES2EVJD2fx?=
 =?us-ascii?Q?KwD6WHtz1nYrUtTri9d7dLiv5/jWuGDGfhIXTyW1mUu1ZLuDW7ge2qJ9Zr2X?=
 =?us-ascii?Q?MO+GHgj6FyPzdIfR2d8mfthEwrA01Il9PAHg?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?HwB8JS9bBFaZO0LHMZlo0NXNvBVxCEDlBukCgGTAx9VQPzKAkiDB0gC19Ysn?=
 =?us-ascii?Q?StIbLQVNMXOYpoddDI+b11k1xYb7Oi6n2sqYdWPfx36ZTxKYd8efGKL0mAn2?=
 =?us-ascii?Q?v2QdiUGX07nCh9mB8uhzAt+678vPztjxU0k5IluMTerSsZwB4W2vwHgGvDZ2?=
 =?us-ascii?Q?GFbw1Ongg8HkLoo63wVSL56vcZBtkgXF18WuwRkxcaxyHWXfiKjjayQAHk0S?=
 =?us-ascii?Q?SVTRQy4F8l+Bg9eDjJzSY64oNrHZPn9Phy+K0OYt0GhitbOFn46YRrkGYBOc?=
 =?us-ascii?Q?7Zw/MSWC0zrs89Z0q/EFjCLsQrfGMlLmWwtnMRAr4o572XXw0QxdG+A2Vlxk?=
 =?us-ascii?Q?ObKt9vDo6VKFPCPWIag3HmyGfNenNdpiFy4VUROTsWOTfmfVD2+A77wubwrn?=
 =?us-ascii?Q?ab6+cZL9SxwiasTuQM7u0E9qQUuTOewQ5iUUyoAFNFK9YC8cZ9pHu9YunYfW?=
 =?us-ascii?Q?01MyFjp3s1breJZQUyU5rK3PsLD7XwA9g5xLydvr2LYeWaetW8vHdIHhhwcK?=
 =?us-ascii?Q?8nz2LaVx19d166aStaHOPIMpmCFLTQOR88okRXBUNNa09/ooF/OzwzxeibbS?=
 =?us-ascii?Q?h8IkpwSiAuqp/5BQMmUoYo/suysA2Da6/PCRSpl7FEHMle5KcAvwsacquPRk?=
 =?us-ascii?Q?BMF29tqhOMqOiVpFKAqnrKlsSW3SIPg+RbWvKszrP1GrvRLQjIa8J5vECRiN?=
 =?us-ascii?Q?atngg+4hlwkxT7x056QnwHgkZWTacdmb9UZxFEs67Tt5WEnGLIT2IK8TU73T?=
 =?us-ascii?Q?TacCBu4L0KrQAsqUFEQ3c6hLtGImbhIIDFEbT7zo0adCvW/5QoOu8UAs0882?=
 =?us-ascii?Q?Cu+sfg3wtudbKvAfP6UTBCFvOdM3xQxy16x6PUnyN5tBhBBEh4cdP0QzLvpY?=
 =?us-ascii?Q?AAdLWuCgEu/4PiUelUl9IKxvDZR49gTxQ9dr3nDTn3B/G3YPb2sQz334/iK6?=
 =?us-ascii?Q?NrJb4Wo5gxcdlfk/i9Yc4GPsZXHmC6Wzn992ZkZ3D3xRgthAM1uFWLrsIzpJ?=
 =?us-ascii?Q?EiBg8/SVbv9fIIEROb9MBLTy1zkX2shlqW20d6S9hRUVDc55GQDTjVRqF8K3?=
 =?us-ascii?Q?8mfd4Lh7c6ZuJ9xVUILQlw5TbGy475dvJk/7KMSroxxXZeN9gQ4xH6pylQxx?=
 =?us-ascii?Q?SLRboBuLT6arsE1ucqyAgIAVWKBK6GY4KSTcoaryD3JOw6i1gKWcj1/tzCeG?=
 =?us-ascii?Q?4kytw8EDIEb3Yo4PxQ9gJzy0AfM31M9cHRf2QORSHP7t3XEhUhN854E13SU2?=
 =?us-ascii?Q?CsGL1bw+0Ki6UXedULDuvjNHEJLaFnTSCSga3XJGIYoZcf8gge6pj6A+x9vy?=
 =?us-ascii?Q?vj+O5DlvE3OzwDN/SDxVDeisibOWIv+Y/gHmrbFo2cRLrDRr957xWaPDYCH4?=
 =?us-ascii?Q?rikxCMvf4QwOP/CnMaQSwQGxVH6+KvQotck8iAl1kYhs5CueSDTE4bkVtKgk?=
 =?us-ascii?Q?eU2Vhgp3Nuq2uNIk/QF//scl2CQR6cBJXdmLD5dpXjeqGyLs+FRzHCO+lytX?=
 =?us-ascii?Q?VNcou0qm+CLT5qAXyWSOX1GNPboFpk10sA47Nq6l/a0cm05YmFkhwFZ1bMnU?=
 =?us-ascii?Q?KcLg0h6Nmbt2CCIJYvabFleQXaSv+QQsdqB7Z1X7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa88fa88-c183-4ec5-079c-08de1d4d48cd
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:58:10.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6LwQzwR1VPu/vgD5cCgUb32ngstnMly1m2xJKxtflA5/p1p0UYB6G4L/RwW1ut7X3wFMVMmr1D34aIPVwn7WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6950

On Thu, Nov 06, 2025 at 10:34:48AM +0000, Rui Miguel Silva wrote:
> On Wed Nov 5, 2025 at 7:31 PM WET, Frank Li wrote:
>
> > On Wed, Nov 05, 2025 at 07:19:28PM +0200, Laurent Pinchart wrote:
> >> Hi Frank,
> >>
> >> On Wed, Nov 05, 2025 at 12:03:05PM -0500, Frank Li wrote:
> >> > On Wed, Sep 03, 2025 at 09:56:29AM -0400, Frank Li wrote:
> >> > > On Tue, Sep 02, 2025 at 02:39:20PM +0200, Laurent Pinchart wrote:
> >> > > > On Tue, Sep 02, 2025 at 08:01:40AM -0400, Frank Li wrote:
> >> > > > > On Tue, Aug 05, 2025 at 04:08:22AM +0300, Laurent Pinchart wrote:
> >> > > > > > Hi Frank,
> >> > > > > >
> >> > > > > > Thank you for the patches.
> >> > > > > >
> >> > > > > > I've quite busy these days, and I don't believe I will have time to
> >> > > > > > review this series before coming back from OSS Europe at the beginning
> >> > > > > > of September. Let's see if anyone on CC could volunteer.
> >> > > > >
> >> > > > > Laurent Pincha
> >> > > > > 	I hope you have good time at OSS.
> >> > > > >
> >> > > > > 	Do you have chance to review this patch?
> >> > > >
> >> > > > I'm going through my mail backlog, which is really big at the moment.
> >> > >
> >> > > Understand.
> >> > >
> >> > > > I'd like someone else to volunteer to review this series. It won't scale
> >> > > > if I have to review all NXP media patches in my spare time :-/
> >> > >
> >> > > Yes, but none volunteer review this in passed months. Expecially key
> >> > > reviewer. I am reviewing i3c patches. but Not familiar v4l system yet. It
> >> > > need scalable solution. I can help filter some common and simple problem
> >> > > from beginning.
> >> >
> >> > Laurent Pinchart:
> >> >
> >> > 	Do you have chance to check this serise? this one should be related simple.
> >> > 	This one sent at 7/29. Still not any volunteer to review it.
> >>
> >> I'm afraid I won't have time to review this for the time being. My spare
> >> time is already exhausted by all the other drivers I maintain upstream.
> >>
> >> > 	How do we move forward?
> >>
> >> I think this is a question for the subsystem maintainers. Hans, Mauro ?
> >
> > Mauro Carvalho Chehab and Hans Verkuil:
> >
> > 	Laurent provided great help about review and land i.MX related
> > patches in past, who are quite famillar with i.MX chips. But he is quite
> > busy. So the whole reviews cycles takes quite long time and offten cross
> > some merge windows.
> >
> > 	In pull requests for 6.19:
> > https://lore.kernel.org/all/4989c563-47f4-478c-80c4-41f7e98597e4@kernel.org/
> > only 10 patches, and 4 patches is trivial clean up.
> >
> > 	In reviewing patch queue, there are
> > 	1: media: nxp: imx8-isi: Add ISI support for i.MX95
> > 	   https://lore.kernel.org/imx/20251105-isi_imx95-v3-0-3987533cca1c@nxp.com/T/#t
> > 	   This one already review, but I am not sure if it capture 6.19 cycle because
> > PULL-request already sent.
> >
> > 	2: Add MIPI CSI-2 support for i.MX8ULP
> > 	   https://lore.kernel.org/imx/20251023-csi2_imx8ulp-v7-0-5ecb081ce79b@nxp.com/
> >
> > 	3: media: add imx93 mipi/controller csi support
> > 	   https://lore.kernel.org/imx/20250821-95_cam-v3-0-c9286fbb34b9@nxp.com/
> > 	   This one is quite big, but first 10 patches is simple trivial cleanup patches.
> > 	   I post at 8/27, but get first feedback around 10/27, I am not
> > 	   sure if missing somethings.
> >
> > 	4: This series, laurent already said no time review it.
> >
> > 	5: ap1302 sensor patches
> >            https://lore.kernel.org/imx/20250811-ap1302-v4-0-80cc41b91662@nxp.com/
> >            binding already ACK, most maintainer want to pick binding with
> > 	   driver together, but not an feedback since 8/11.
> >
> > 	I jump into and help do some review.
> >
> > 	The questions is how to move forward pending patches, like [3], [4],
> > [5]. How to keep good community channel to avoid long time pending?
>
> Sorry, but like Laurent I am really without spare cycles to go over the
> patch series that have arrived in media (also I do not have any hw anymore).
> So, Frank or maybe Laurent knows someone that would like to be add also as
> maintainer of this drivers for me would be great, that would also help to
> avoid such bottlenecks.

If there are not other candidate, I can help maintain it although I am more
familar with dt binding, i3c and dmaengine. I can start from simple patches
and we have test team to help cover testing on the real hardware.

Frank
>
> Thanks in advance,
> Cheers,
>     Rui
> >
> > Best regards
> > Frank Li

