Return-Path: <linux-kernel+bounces-823960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA72B87D20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E5D1C27EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3776B23AE87;
	Fri, 19 Sep 2025 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hnswgbXb"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287D70809;
	Fri, 19 Sep 2025 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252856; cv=fail; b=FlI4JrcikRGCsT+p8AHjSoKwxpnLfbkJ+dxFI/Rfzvn8Nf+nbS+sl4uGkQjTgT61U1wL6qAr4gdkcaAdL3JUuRK8zkbbmJKDsH6wURYNH1cJu3Pc7z1JhapHzatDKe/kcdI17rRXn6o1vcGvyitEBRHkZPVlZi+JfG1Ms0sYCYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252856; c=relaxed/simple;
	bh=xcZlP270AD4nK3GBXl+JNBjWHbmCBpASxSGVbmEN6MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eJOYnKOBAnb8vpJfJ+UD4YT2ER+DDbmYaqojBKaJjdRZ9pKXNUbfHhATejyhdYDzM2kkR4HfGrpqFLKlINhXF5gpBkWLFkmv3iTDfygxt4AX/zGVnB35YPoEkKGaynKpZEh8vxivD1GE1CqGEn4OjZxZYcj9jc3dGdqPimP4eJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hnswgbXb; arc=fail smtp.client-ip=52.101.72.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVAMsBsuqiKwme410NaoTwbhHPABhhdiKA2BZ2ZZuv/lwPYTCiStMi9TMiSx82Lm93hh1K5xaImHfXvzxY+DSzZrwq/ei4SusQ65okoi/kGp5T3CsZfK+hm/iBM8iGTt+ywU1TAker5b58JwSxkYelAdW9vgEu5VTeM+9CAcJISiWQ153oQHNGFik2PorGonsi6JQOeG+f/ufNiPGLMg15EnjFJU7vLgj9uFkMgvlAj8KXpdE72PbsPR3tIsYjVw3Hp3TQfmcJeE6jh1hHLBXoxpj5ds3KHcPIjEYP8rAUZsIPqfDCj/ZRVIIFEi5KTOr+23p15MoBuH6eMv3dkKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcZlP270AD4nK3GBXl+JNBjWHbmCBpASxSGVbmEN6MQ=;
 b=pMcay0YuVnjo9jUis4iO9J3paPfWzC0EwbF67EZCTVXsqLChvLtHymNq7BRaBqRe0gGy01V4DoNB02ArlIiIWxLxfsxOBymXmXIHqkWgGu5iAKeELgaRbIQpldcOpU9W1kak8SMb9+XGI3STxXHS6GRWpR081Y75DFRNHahjxg2YfGFU8Casbv/DeQtgNri7sEqMKi2JT3aScjsuhB6fLNrub3c9rNTxiPdQxE75fXjLEdqIky/cMzclwU5N9F0DxWwrDFq5W9NUAukt0NypozkA9kwwu/UQViMSR1YVfyT6LUrgqZzMkdkaY2ZCldjSX7Gb3Y5NLYl9vPbQhaFnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcZlP270AD4nK3GBXl+JNBjWHbmCBpASxSGVbmEN6MQ=;
 b=hnswgbXb3xfH7JP3PwRLMT7BVS+ywVK9mJWMQc+eFJJpzqshxc7ZOzpF2HdX9dWXyscgU0//oY1KL21zdseWeWR3TGSYMG+pEv71j+oF6S51vP+KDkTwaxB8aGzfjuAHxFQ1hoVmuRD5Fo3B8XOddC354vWHjnBZox0pWbHj60C6JU5Baa6qwi+FUFunvHnIhw6DkW6uV0pr2NhJ6sIUZGbM8VOAejeehD0weBH4AQh0MJd/LkLxwXVk0wqg9SEDznsr1J3kkMqrFGPS8gsVB3u7kphB8rQWdTIWhvR3ylmwDl/LQzHtj6FU6/CPLadca4UFC1KRVvsu6hVm8BxpMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 03:34:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 03:34:10 +0000
Date: Fri, 19 Sep 2025 12:45:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] arm64: dts: imx8mp-venice-gw702x: remove
 off-board sdhc1
Message-ID: <20250919044548.GF9196@nxa18884-linux.ap.freescale.net>
References: <20250918154451.2531802-1-tharvey@gateworks.com>
 <20250918154451.2531802-8-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918154451.2531802-8-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 581baa51-3ef7-4d42-5f96-08ddf72d6583
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Nmc2j5+CpRsXWJ5xGOjX6oZeRUy8EoZ0Ep+W8Z93+bafeCUqV9quHVpE+UDT?=
 =?us-ascii?Q?0ofX7Yzs0KJn3HGLrUjZpZE16KACRkBmO6/+dIaxZ6S7hJVxfz7aTQfhGoKh?=
 =?us-ascii?Q?y+b15Jc5P8PmH3gsY7bI5C9fXCNxU4tEzPYKL+nkkBj+3rG2cSRZvfSGMyAk?=
 =?us-ascii?Q?R5ubTWAVtQ08SV7bM3mytXSBpy8KoOQIwHei87qKyQgrMKkJQCUUF4FVktn5?=
 =?us-ascii?Q?XhDJHeUV2RJuHekBv4kaye0uuWGcmoKDqrAedalXK6QQWccWsvl0cMnCTfoj?=
 =?us-ascii?Q?b2e4kxGH1ZPovbFibIe499oMQ3geA6nCoJ4wCqgNXovTZRJgnlZ2sssJs2D0?=
 =?us-ascii?Q?xiekk6uELVr3pD9lN7L3MOp+I9OC5GWqVtSrKzAnnODDYI6iYpLYBWqfd86Z?=
 =?us-ascii?Q?HRU+Fau5IE0U72tX/Vr0bGb/BJ/e9wH15wSkMMyI8qBOnTyRRBtn7MVYRbhe?=
 =?us-ascii?Q?EIwhIyhceMomqhsg15CgAyUZGnrjJ0FF9S2A75Nrr2zxQBst+mUeyc7y59up?=
 =?us-ascii?Q?Opw/S4mtApYTBty7pV1KFk2whwAry6smFK0fctnp7HzI275CDO4E/oJmoL2L?=
 =?us-ascii?Q?L2Y9k/kJy9OrS6px0mvUtI8LwDrSFkt0LFOqRVeSnrCdG7xKRb79svwc2iYl?=
 =?us-ascii?Q?lx8YEbt8bCTkJaqxW9lTR22MKLXdkThm8mA6IGNlj0zfqNO0iWvtkdfHnFnj?=
 =?us-ascii?Q?+iRnUKqwny7d2PyVK6MXBM5ZSiJNkYMamHhCVYD2CMSGAjACcH0j8jazbai2?=
 =?us-ascii?Q?n9rOshAMqZ1iU++rprMdGR0WkVIJ8XkOgpQm/2wgrrg/slB5yH/LzxqcDhuM?=
 =?us-ascii?Q?OTA0cfvkuB/NL+dXwlP71GecFFcBAEIpRoPtQDvLPohssY5nUTOriaSM+y/n?=
 =?us-ascii?Q?DTJ1EfTVibJwtZsqDLQmyGlRsSHAZi6K0PylOH00Q2p8Dz0UF9q4xX1paWz3?=
 =?us-ascii?Q?ldxJlv6bVVROUT9AGUr1hDEk2mADR1OjlclhmH9CQvz5zWFY5E5iVI5NHh7/?=
 =?us-ascii?Q?g68HuPn1V0ojrrwubqX+w5HisX5dgQ3E8tK6uzt+HdkTg9nygB3Wpuv4u7aF?=
 =?us-ascii?Q?0HKX3QlsY2yStg01knzBgwa8sD3Y+Uj2Voaurik3xG8wQ+MaFHHSL/BXXV1y?=
 =?us-ascii?Q?tT+rVgATasLVgsmUvSC3MvD2Y2coc/7GxV+cVl8Keui45ixOJj2NB2TqdCMH?=
 =?us-ascii?Q?XTuSyy6qkIbNIOoIS0Gs54YFBX5Tejrxhw1MGG2xNssEpNOz7ZEJL+2l5Y7R?=
 =?us-ascii?Q?U0MOyFqHTZMQGSYmQAMB0ggjCtDPKulfe0ZCqVC2KDyBn5WseZCWTR95Knlp?=
 =?us-ascii?Q?iYuTHymTp8bcdcqkOWGpx5QRMkdqG51ydXRxwEmbQDfQmBG/J6+lRnMbLrYh?=
 =?us-ascii?Q?4dQNEv+Ngm7zBx/LJdxWWDSW+zQfUlXZscobLFNiq204iibnYR4Hsviy+zzE?=
 =?us-ascii?Q?DbMUbIxEoYGsayCrs7Rwz42rbXDThkTWhR5zRmI8pyQzyuhu/uctpg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?GczcllWeAGg3hD7fGV89TLwqkDMtV03OOyjtAB+pApRF50ooIcLuznDZwaAG?=
 =?us-ascii?Q?pqhhu3KcONxoF+vljQWRbg39cOQQ4uw4S0fzqso2SSX/iDJvwwlp9k3NHxs8?=
 =?us-ascii?Q?CG5jWif9IyKvRJHKIdkEApAjcouneSVXSS5UnDzqi5wVW5cnxt4AHbjYFeFr?=
 =?us-ascii?Q?1QuiC1HLLG0aTw6LmkSoYC3U8OjQmLwXL0Alfy/iSGhbz+C6xik9qsGMue1Z?=
 =?us-ascii?Q?rHJwkpUfxtPE1MT/cxH5v3eX/ZQs9Jr5S/+2sUkYHygEJ1ZoZuXMeujPvC89?=
 =?us-ascii?Q?TDFHDM9o3QA9gH72LUVUoxy1INolvKQiMJR7KCQMILDgTrFpX/bBaD0rgi9M?=
 =?us-ascii?Q?cyA8XdZkyJkB+tUYvl5BBoObd8Vlv6zp/mzD/ZHhKcICZusoxPYDMD637NKg?=
 =?us-ascii?Q?Dxo5qF779cXG6Bs8txARvZG/k7bPOGOH/PzoRS8zBD66RhGH6hiJIE8gvwJI?=
 =?us-ascii?Q?jXJ3REO+hPBFirpvjFZF3+OPgZxJcVrIPlRDj5+dp9BiAPAyEZQhVSbH3Av2?=
 =?us-ascii?Q?4YBvzGgaOTnoaFcHEp8IAIoIb2JdGlBDf/Av+suwQfsGdwFrkI9LmkYVXNIm?=
 =?us-ascii?Q?BqnXuf65CMi1KWGz7hoGdZrfkREtVTdd+6Qp4tG4TySxfuVxS04UTZg2G5lZ?=
 =?us-ascii?Q?yu42vmp2m5CvM4PIy8jbNuPD4B5Jn84ZPAWp/3uOZaN4pk8OR7p/lz/ROoOV?=
 =?us-ascii?Q?gmio4d0PvJHrG9YQ+/cRuA5fwycLQgf//bCc/nn2FRpT0/Hv0a1zKkcLiLR4?=
 =?us-ascii?Q?Er5ni6/4jD2W+EMrnmTnzUBZO64t/gWOW4zgBHaL+525Yb6d2wghI6/2upEj?=
 =?us-ascii?Q?EhR+Nx2JAQo+RMdbHBZPSd/f/v4XtTw3PSsT8C6tvp7oYRoD/cozru9/UtPU?=
 =?us-ascii?Q?Dm2On6QVFn5o2vjm0FvDGC1UZY2dcp/i5Fmzo89fZsivyOBJjwKFw8924vIj?=
 =?us-ascii?Q?9W1CFge3Je4byr25zR0dKIlFxno/LFoGCFuWJ58kA0JqcHw4JxEymtdCOojQ?=
 =?us-ascii?Q?t/koFvSBA7xadpYBBI26FNuEANq4tGnHzyNmj4kvIEyQwBnGhJzKQf1AzZqI?=
 =?us-ascii?Q?lajPJDCUOBHUcEm27k+fsUr2THtUhzyde/330uahzbepaF7dyByOCxLQxzqW?=
 =?us-ascii?Q?p56M2IeEJBQkjDIbAz4Pq3D1VJBzrziPzUHQ2/o0p5kUej7ab/6HEEZqfemR?=
 =?us-ascii?Q?oUJ1pV84nWRbJeOZsPJ3DA7+36M46oQs+yTX0kQ089gAZtTzZlcHRJG25awR?=
 =?us-ascii?Q?Jql6tkfaSjaoe37Z8W1k8wvFUqYD937R9PvjtS3rkCZo+Kp1K66RbUHC/OnO?=
 =?us-ascii?Q?sfJ1atFVc3FOpifpusptLD4L0U8To0qYeahf1Q2guj0y3cNhB7GDR8Jsa3Nh?=
 =?us-ascii?Q?t8kUIGRll0kPos4jSh9Hg/KKRNmgWiCDiyL92nRPB+8J76fhHQ6Z/jbHGfYv?=
 =?us-ascii?Q?+in3KxX9sN/2zn4SIDXoaYYrlOS+DkLEnG8dde/wQHl31peXOxEjrpzhU6/4?=
 =?us-ascii?Q?N2S17DiQ6AGZRjBzwuBWHYFhG2iecU/a9YBI5Xz4qZzHHpdD4a3LLCRwOULk?=
 =?us-ascii?Q?wm0pvV5CUw/Re/qGn+9PF/hcfLF10na4BhOIV1LJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581baa51-3ef7-4d42-5f96-08ddf72d6583
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 03:34:10.7740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s20jdwmVSFv8L8lF/WsGhRYmErmSxzPBnWuHQszOLyDw8Z26PeIFGQpKK0K5LXEVzph8i62orovKcrhLbBfmRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872

On Thu, Sep 18, 2025 at 08:44:51AM -0700, Tim Harvey wrote:
>SDHC1 on the GW702x SOM routes to a connector for use on a baseboard
>and as such are defined in the baseboard device-trees.
>
>Remove it from the gw702x SOM device-tree.
>
>Fixes: 0d5b288c2110 ("arm64: dts: freescale: Add imx8mp-venice-gw7905-2x")
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

