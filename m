Return-Path: <linux-kernel+bounces-824843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66CB8A479
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0F11CC0453
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23343191A4;
	Fri, 19 Sep 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M9SLDLMu"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00A318141;
	Fri, 19 Sep 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295603; cv=fail; b=pyzsMcE0tYSVVw/g9XlsCmO/tYi475sSdkqoHU5OGMVm/hILzfDwDB4KK5pRQYaAH/i8Q3l/WBhnha9Zb4w37A3EsCSJ/PYTxngRM3lEqnYTv+KBA/GDOxg9dsTof554Xaqfuu8yEVGnU72YxW+wtaXIFM6U10grYXTwda+7H5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295603; c=relaxed/simple;
	bh=5uhpWn2lUTzGBceoElrUPKuQex+4mHgpgnh8GYMFU2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NSEiUBWYxNHM6VtLXBrj0GhaRmu6zHDLOCYNdswAeZHYCDy/8yHX3n4Tnbc+hoZbJwGwLKUa7OkOHRQrqx5PnqjN0S+ufcplvoBTr3xCikypiQTF86cFxEp72s0R8ozAcy7uoTj94ON42dSVqpvVlpYbuqB4PB5tmm6Cs4nLxN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M9SLDLMu; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nL0LpmTutKa7+bEZj/QP+Ji9fAoZh7V0Vz/iXdXUTzfcn061z+b3pxKMGkpFd1sqssQzpsDv/2qmxABDm3fiImdwCha3elu79DLcSk65M5YhL9atNzHJYeTbmdgVmgl8VrpChcoNNR0XJQ2TxdG5Fd78yeP/5X+k9TbbUk9D4a/d45ZYegaU4gGopUsGfa2dAQj2JoovJH4CZ3+oFo5DtjxOhJYCWI6xAeCuH9mtOuP53oQJUy+a8Ipb+iOt5c5N4Aua+Ko3X4kQsD98LVtQxiHYkRChWPpyKsthUd3+U56rzPOjfN7kOGdsUzITMRD+uG+AUx/LPX7VnyXSYt+f9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5qVhNxx6LIHyVPEm4y1NXgWrQ46w9RVMHlq+w4fVDQ=;
 b=Fl5xmN4OKSosBIdxqvuLrHowwx+2zsqzyKGTiSL+gXSIcmSqYLv7YZFqCRPRw4S18JC+4VzPr4XdRyhOdVDDxj9z5HRPHnwVJ+/yCKrjoPwJR5IfgpM4mxNNmZopmJ5YbLJvfkZwhq5FY7q674JDnk6fNXTOAXR6HP71mzw0ObDXFZojgKpf4oxxeCivY3/KLik4fT0Bc1AK2saRwx0c9SepzdnemcjKiOHUF+cH2uB7u8JcakpxKT8T7f8D8+eBumzYywgTpq/emHsEKNeOMSzGROLGSW60yY12a4/vUsmHgnYCkG9QPSEJioOWPbJFeeZWDhrVLLmKBvwVgNq4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5qVhNxx6LIHyVPEm4y1NXgWrQ46w9RVMHlq+w4fVDQ=;
 b=M9SLDLMup3b0kFZwfBpJyyOWlHAWGh7T8Dx8E9G3aCrZLJIw9oXOtB4RuVuR5YjZbtk1h4q5mtGNa2Jur+8aAWqihflRlMMk8ga/JXhlWy9j9a0kRQ9mVFWDfekhDn4fL7sIz/tI67gZ7b8w1ajXR8Ktd46ETt8FSmGReC2+KxFF6aAALRTRHpZdGCPWy9WjxSAm/HRf7N47aYuQA97PTHpjcJ7a+QyTpWqXOGCUMTpF2f/cxEwfl28X9MrJU3o+QQEzOKGi62rW6sr16qA63Vy+PtKWauqtKI/rY0OhGPJrmBHTRtgYqeeOqk5mPPlFaUJKWRAFEiYsksJVO8aclA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 15:26:39 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 15:26:39 +0000
Date: Fri, 19 Sep 2025 11:26:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/14] drm/imx: dc-lb: Support getting secondary input
 selectio
Message-ID: <aM12JjG7LE7Nk9ZQ@lizhi-Precision-Tower-5810>
References: <20250704-imx8-dc-prefetch-v1-0-784c03fd645f@nxp.com>
 <20250704-imx8-dc-prefetch-v1-10-784c03fd645f@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-imx8-dc-prefetch-v1-10-784c03fd645f@nxp.com>
X-ClientProxiedBy: PH0PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:e::21) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a0f516-6fba-4105-d0fe-08ddf790edb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sgqCRPRTyQo53fmXsMeAqB9s5X9UTnnrBC848xGFqPhTg4MqlQn2EwYWY6GG?=
 =?us-ascii?Q?Y5vb55vQ15we0jH+xmK03x9Ivzejyi0Qk3MDkRQBmudBZhWmlQJXjvXBkeDW?=
 =?us-ascii?Q?wGBR5hv0nceb0xyE/8hIaR1YqLSqzegNdn6w/Skrd1ha9TRuR76sWispyZSV?=
 =?us-ascii?Q?55VjLfvJRLxj3t+Ok1eO1WEUzdOQe8wX9LpKJZzF3mA4EtBWsrVb7PrM8scO?=
 =?us-ascii?Q?5kZLcRRWy09zApsWOa00dzOuIBmazjuUfmrryc2dSoMEGyxMxaIUVpzqFjm7?=
 =?us-ascii?Q?haR9B54+Lyla0qRhiRM2yiqeGqtGc2tNNTPIbC4zCXpchGDqUi4oKlA26TmV?=
 =?us-ascii?Q?BZrFYu8bYAFflyqphqrX1JcuM9fcgEB68rZLCjDpP3NVekfjdqRMBYRTFT9c?=
 =?us-ascii?Q?t9BfqXQMpel9ZocPkvwA66YVs0c/ZU1o7CG3erfI7UNcl++wemY4+RwQsoIm?=
 =?us-ascii?Q?kBcRP/OdtdeOA1thH/yovP31YIup+Dhg4aNPxkTCYKb76uOUxuyvF1XcO87u?=
 =?us-ascii?Q?ZpbQl4snUWtCFJ3lCtxfEXIIJe14/SaDrd7JTgtQUsYFkoeWhT1YhvZyJLo5?=
 =?us-ascii?Q?EdMthBPhxk2HvsVnBJ4U6jFMZeJCGoXBkv5V/8uVKcZpJwzhI+CgQN/O7nTi?=
 =?us-ascii?Q?pAJvj9CkIV6kzuqzdU5sHELTGwyJKF4oUvQ2AGk/AsWTT+wqyyDQW1eP0O2n?=
 =?us-ascii?Q?c+tBL8WYVguGFDH19kW6JLnXs/xi/YKG5nctAfJ8HpsGI+AMdGUIC1NvwlEx?=
 =?us-ascii?Q?6EUAM9bYCWEUgyuQsBhoLbE4AO3PvHMNSeWI1vwTNiwaAAcjPp3xq/WoRJwJ?=
 =?us-ascii?Q?yGCEkoY9EgSHQY3oA6vU0B9nnc0QiIZ+Cz/pY1qAojp1M9TUUEyrMUEQkc+s?=
 =?us-ascii?Q?0c9Hm1tLpQSqk+3dLvgzvWdt8c52l4Ow1hnSjxaZ+j+6zzhlIxf06fvrcMGA?=
 =?us-ascii?Q?Rg5x9zSyIjJOZZeZ9k1L1ILcP7e6ir0s1/3CU7lGRxGpv6g4AbAJM0iC3IGm?=
 =?us-ascii?Q?3CjgTjlUfBYp3UOeTxJ/MBMgN0vzk5JkbbvZKRdhPieEZkjKv7N98icwNMkF?=
 =?us-ascii?Q?6G4793Z0muUBAcKhvZQcgSMZcPro8GZgIsFvuvygz9JpspyTIAvxxi+0tE3B?=
 =?us-ascii?Q?wyYHXg0EzUP8kCVQm3oeW6/H3x78gzlPO9yLa7hfyIID14Q3ccnboZA/8dfv?=
 =?us-ascii?Q?YWM7dwdZAC0yrZnxKtaJd8e95KeC7KBimeAvcjHtEJ1v3F234nkqXSo0gXC2?=
 =?us-ascii?Q?dPEQIUC8wz9IPMbUcII5T3HzQ0ZY50ucdrGv1BN4aS80kv/Wu1zizyjGcMCF?=
 =?us-ascii?Q?nAXd9at2BDLggm7bvsukjPxNdkPRcgAVNtSTT3QNu0BH4l9Vn5kfEF3VwtHG?=
 =?us-ascii?Q?7FaJApqZv21rVE7huhIzbkXZNH3h+O4LIG3Wcxb4tS0pk2Q0wOsPNCTLm+uX?=
 =?us-ascii?Q?TET5rYtDxA5zE2L78ZMewPEW+0+Nux1ZWV4m5zfjo7suAUJQ5D/MDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oxgEuway4Ii3RGkMNcmyLklqOpPKJ1VKzC59g376Oo/katN7FvfNIWSoQ4n2?=
 =?us-ascii?Q?sx0Z7A1P4REuFIvraaHwP3S6ADoSZPpBPpy9k3krT3TMe7/vKJhJCzDJ0REx?=
 =?us-ascii?Q?C1N/qBOwNg7mfSfoJdcPrgFruwHYKIY0LJDYNdqM5VvmcauYklYExs6LVw8h?=
 =?us-ascii?Q?r38GiovVBlC2SX6/RLj7/HrODyOS2i2N446ba9OKzmplxYgt2r5YTTMghUtt?=
 =?us-ascii?Q?J4C52M9l7pWmsfRoTt1MzPhkBAN7geGVlhRaI27foG5RV1Y0y+1QmjW9sEAP?=
 =?us-ascii?Q?bBLdXFYslETmfwXlgzVYFdg08YTV9nL8RrgCexyuBcnckUfwmCj1EykMU2Q3?=
 =?us-ascii?Q?ggiZ0Gezsrb0kenE+DU5VGSQFsKOfmUGGKoTdGKGk0iGRE24Mk8wXWpIlvqI?=
 =?us-ascii?Q?/cIZE3veUmTN2VfD3HxLoPBj0GBXDdVSifdYpuQXOoakvp364+vtv6OLT6fe?=
 =?us-ascii?Q?5ZPCMnMSUiefX0zTLvgtFSydrJJ6v1N5AeQk5j+LGnENPtE+RgGn43vD502V?=
 =?us-ascii?Q?qllpIkkeZ1rgt1zfdB1aM8tVxOmU+NwGAi9ZtMAmQeAwg0ymlEHtAhmKdbQX?=
 =?us-ascii?Q?Lkt7+5fk5EbPSF37s7h2D+9il2gudyZ2h92/8YBIQaMVVkASI2Ma3C6JrC6S?=
 =?us-ascii?Q?e+W4+xrZYIYq+1TvjwMEEs//ullgWJ4M9ZhlQbTdA/WFYuD/kOxE4nVZr8ts?=
 =?us-ascii?Q?/sUIfegvB/7wPofPNOht9YFP4XPRLjDRPf0XKRJqmebDUy6wLsSVhBEeBFNh?=
 =?us-ascii?Q?t3CKJ3rF4Wh8xGWROxpyR/Ry3orBjeGuW/N/VpYjHR+fu7LtL+jNZOFPNB1H?=
 =?us-ascii?Q?MhPSTafSLHijw5py6QeFIqaNRkcE5MchxDXq5gmhMQhrbtun10Gre8FKvAfB?=
 =?us-ascii?Q?Q2lGsmZGBNsl5XX9NsJ8jp0sMNcOQ8wc6XVWWfWu8i1IjxXSB5j1k9rf+ksi?=
 =?us-ascii?Q?c/rVa2/JuwtPAbjBJhAGkvT2gyLQNKutNWkiaDbMS2ucYIwPrkBUHlrCqJmH?=
 =?us-ascii?Q?WZYtStoWCXW/YW9OSz8vrl1X7zBe2soGkbEklK3ZgCPO1h0GFfhraczmslhS?=
 =?us-ascii?Q?hbufsn/TU+5KqRIuPgeLHLA1ECqEoOtLYCatzAYGSotsymK0QWzW5ZKar0D+?=
 =?us-ascii?Q?PEk2qX24kCtA5qCJ0eeu1itA/zKvJpOjJo5FMzf5mYw5GtiHLHw5a8wNrhON?=
 =?us-ascii?Q?77AeSWxlU2VAJYQ+XUApijkihvYj6NcGdZoxwFeiUL55FUB0WwfOxnJd3KdO?=
 =?us-ascii?Q?8hjYCxXNUspiotZjhRVy/J5Xtq9nBnPztdQU+ZiyiOtvG9ya8QkR98SYVd8h?=
 =?us-ascii?Q?fQ94O91+5IY7Hwde/Df/7xp+DnIIRI+NUUU/2Lsyc9N5AnmhQ/S0G6+HIV/P?=
 =?us-ascii?Q?4YOK77e9EsuDD/Qc/28eALH+x+nqACru56WQvT6lUc/CiBcPIggmaxHvloKH?=
 =?us-ascii?Q?i41Q2OeVv6KTZ5Cy+h1UDn8bR8HFcp1lexOfSOUfQjj9Og+z/YA0s4pHmeDy?=
 =?us-ascii?Q?hm4oTtpiu8Vl16XOC7S1w3Tu1IUwZI4L6+CEdg1jPkY5sQ2qhEdEYZtsgfaB?=
 =?us-ascii?Q?ddZilXpBAN7+WiSBrJYLiXh+XdXSI+bZey6vTVL3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a0f516-6fba-4105-d0fe-08ddf790edb3
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:26:39.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvJMQUd0z4cRLVzYKhB087A+i7mTkDjG8m2FXu21bOEDwGtF8khahm6TpfODrcdwMKtp/oG06Yhp4TYjjEGLmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098

On Fri, Jul 04, 2025 at 05:03:57PM +0800, Liu Ying wrote:
> Add a helper to get LayerBlend secondary input selection.  This is
> needed by disabling CRTC at boot in an upcoming commit which tries
> to get the selection.
>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/gpu/drm/imx/dc/dc-lb.c | 21 +++++++++++++++++++++
>  drivers/gpu/drm/imx/dc/dc-pe.h |  1 +
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/imx/dc/dc-lb.c b/drivers/gpu/drm/imx/dc/dc-lb.c
> index 38f966625d382487e45c2e0c202e15c1417f6e65..b0f3fb818799b58597e8ae41d868338c3fd40800 100644
> --- a/drivers/gpu/drm/imx/dc/dc-lb.c
> +++ b/drivers/gpu/drm/imx/dc/dc-lb.c
> @@ -23,6 +23,8 @@
>  #define  PIXENGCFG_DYNAMIC_SEC_SEL_MASK		GENMASK(13, 8)
>  #define  PIXENGCFG_DYNAMIC_SEC_SEL(x)		\
>  		FIELD_PREP(PIXENGCFG_DYNAMIC_SEC_SEL_MASK, (x))
> +#define  PIXENGCFG_DYNAMIC_SEC_SEL_GET(x)	\
> +		FIELD_GET(PIXENGCFG_DYNAMIC_SEC_SEL_MASK, (x))
>
>  #define STATICCONTROL				0x8
>  #define  SHDTOKSEL_MASK				GENMASK(4, 3)
> @@ -182,6 +184,25 @@ void dc_lb_pec_dynamic_sec_sel(struct dc_lb *lb, enum dc_link_id sec)
>  	dev_warn(lb->dev, "invalid secondary input selection:%d\n", sec);
>  }
>
> +int dc_lb_pec_dynamic_sec_sel_get(struct dc_lb *lb, enum dc_link_id *sec)
> +{
> +	u32 val;
> +
> +	regmap_read(lb->reg_pec, PIXENGCFG_DYNAMIC, &val);
> +	val = PIXENGCFG_DYNAMIC_SEC_SEL_GET(val);
> +
> +	switch (val) {
> +	case LINK_ID_NONE:
> +	case LINK_ID_FETCHWARP2:
> +	case LINK_ID_FETCHLAYER0:
> +		*sec = val;
> +		dev_dbg(lb->dev, "get secondary input selection: 0x%02x\n", val);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  void dc_lb_pec_clken(struct dc_lb *lb, enum dc_pec_clken clken)
>  {
>  	regmap_write_bits(lb->reg_pec, PIXENGCFG_DYNAMIC, CLKEN_MASK,
> diff --git a/drivers/gpu/drm/imx/dc/dc-pe.h b/drivers/gpu/drm/imx/dc/dc-pe.h
> index 0b81dc6b251c452e7ca72f1cd12af065bafaa198..4e38aead69bce6e9ad4cf2a7cd1fedbaeda60650 100644
> --- a/drivers/gpu/drm/imx/dc/dc-pe.h
> +++ b/drivers/gpu/drm/imx/dc/dc-pe.h
> @@ -93,6 +93,7 @@ void dc_ed_init(struct dc_ed *ed);
>  enum dc_link_id dc_lb_get_link_id(struct dc_lb *lb);
>  void dc_lb_pec_dynamic_prim_sel(struct dc_lb *lb, enum dc_link_id prim);
>  void dc_lb_pec_dynamic_sec_sel(struct dc_lb *lb, enum dc_link_id sec);
> +int dc_lb_pec_dynamic_sec_sel_get(struct dc_lb *lb, enum dc_link_id *sec);
>  void dc_lb_pec_clken(struct dc_lb *lb, enum dc_pec_clken clken);
>  void dc_lb_mode(struct dc_lb *lb, enum dc_lb_mode mode);
>  void dc_lb_position(struct dc_lb *lb, int x, int y);
>
> --
> 2.34.1
>

