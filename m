Return-Path: <linux-kernel+bounces-714365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234A1AF671D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 03:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D777B415E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 01:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237211CA9;
	Thu,  3 Jul 2025 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Tjs/zAio"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8992F5B;
	Thu,  3 Jul 2025 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751506080; cv=fail; b=YDIC3R7kdVtTOk/gHTbjEHK3gbRHHg2+yI0FKUBSMOaZcqzXrQWScT6KdsaqXp9mWT+QsVplD/Yi8ba7WRs1jaiginFbDF/lcknlDDrNhqd9nLRLuObJs+U8Pb0gVy8ccpnRBkR6kziavF/PThG+XnKnbpXodi6Y44nDplp/pGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751506080; c=relaxed/simple;
	bh=xEFhqlYHH6O++wO+Dd1ZCXVeMaxafHhaMGR+LfhELX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLbEK8Ry9yyQpkeCt1LdbIzzTqpovpA9lQVjUMxcCt2wUM5Pd7YtTWm6gzTNbuaYhkNGCOqrfIkRur/9R3dh1c4s8CPrddSMu1Dr8zQJVwuhJKVEErB3tWpanHP21DwSUPIMDqu/NvACiYZTP46hRU+DFbWZJJrpF5ttQ6poSyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Tjs/zAio; arc=fail smtp.client-ip=40.107.159.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZqNzAJNKV8+iBlVQeoCZGAXveTUPSRdXO+MUpiLuPOLszBXvZDAeQiemlSCXOyi6/6CmtQN9l/YO6vB0ebTvo31F7LCTivqBVFF6SIyCYlTTbxCfPqbET6OVJZ8M+0a/QHYBuXGErYFHXH9yyXYpOHDG1O7oMniZMEreHHJA+HPVuh46uE5mAnUJWOYG2T9cc78hoN6OEQKq0c/cK5/6Wc8Gl+5HcNs4obLWfCRO8dw/OZKC/CmcO0cIfvSmIEEeCtCi7arL1mgHN4iG45vCssK5+2oWblkNSRiRxyRr3GKnumOJOvwjw/k+ZTST2HA/P3zQCWqgeMqQ8liQC7bFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEFhqlYHH6O++wO+Dd1ZCXVeMaxafHhaMGR+LfhELX4=;
 b=a3Q6hDPJnuE2tIQur2ZgfMT+V5jVT2SYvEDoFyFF+3Y9qHvP7z44/6i0QIrvrmFcjL3BD9E4/UMQK8hajGlxqmJerGCrqGCu9gEFBYphFAwfMQtDZimilmjQsDT2i0BA2OIz569+kKzNvOYNowwoYOcAZKxAM250lH6521NCVvRpmiOdOpJuXfSYMoAb/Xwpfb/+h7yiE0FjgPkh4lvYEP9Rxp9BBuPcfx/52svBDIm5aqtVxJbJxOfqJY2wtT0pC0hy8/aR/+CThFb6xZG78l0RTJMjoZr2KXsLhDCel/XF6pN86u/pY/mYX8U6BnGtGnsHOHKB5JdhFgRULyHCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEFhqlYHH6O++wO+Dd1ZCXVeMaxafHhaMGR+LfhELX4=;
 b=Tjs/zAio4p/2AyifGGjWPsHLYGlUp1Ope674qypdWoUjvArosuNjUPfPLHhiZ8FM7kDLys/szGjN59kIAzLCDs69CDqAY5FCzN0VzK3Rhgen9b74oO05jOc/Xc8ueHLi1Q6ETCD1SWsG1viWXEfmF531SOY/8zG4CJpzJ+2UQCXSdM6m9FcoIKU0TxqJ/eHToN157mH7sauWXU6KSey5mTI18YA/DvrnGWH8cT+5b2W6SZBIGDiOWP8Da73cM+NH12s9pgyMOsgxa9epyD/saHRpLC1gvxM7byKpE4kXkcIZ1xxhAO09d2TI/vei/x6EAqZfifUfowJDaD7n6iY5ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10910.eurprd04.prod.outlook.com (2603:10a6:10:589::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 3 Jul
 2025 01:27:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 01:27:53 +0000
Date: Thu, 3 Jul 2025 10:37:57 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, cristian.marussi@arm.com,
	peng.fan@nxp.com, sudeep.holla@arm.com, arnd@arndb.de,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] ASoC: fsl_mqs: Distinguish different modules by
 system manager indices
Message-ID: <20250703023757.GA18168@nxa18884-linux>
References: <20250620055229.965942-1-shengjiu.wang@nxp.com>
 <20250620055229.965942-2-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620055229.965942-2-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10910:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcf7397-409f-440b-c2af-08ddb9d0d527
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zX6MGUZuaVsEeyX5vOL9twfKV7mJiJ9sqFj++DDD1kglf7B/lF8gR7LKNcAc?=
 =?us-ascii?Q?RJITp3B9d7C2YODBNlixhGBjFcqtYA3FfTGYcxnHh57asKqiam8z7l+gum9R?=
 =?us-ascii?Q?AzAbTLJRJKMMnW6E+yzU7c+BsvbsAkDhFhvO8a5fxiIAsVX0XsgDR91+pZTp?=
 =?us-ascii?Q?raHJjkMlk/1Gg51X1BQ/gmmNyVTE7Gmgy7idAMMflAjPjGkWFMEro21ckoFT?=
 =?us-ascii?Q?36MXnQsffGGP8KS//9Za+xbYxL4bLmG0xrOSClxPQZnySifDi3Wl8nqC/JUM?=
 =?us-ascii?Q?IYW8UQvmKEPYnsdYHC1QFiSfYlYq2WerBRefHugTUpN11K7lKcE1CMTWMjSj?=
 =?us-ascii?Q?cnUEU3QyK5F3wzPicy4avOyryJgUfzQeVPr3NlkTFW8iZX2ycmG3nmnSfBNC?=
 =?us-ascii?Q?cm0kmJITq+qPIKxczE1LL9t+RijZsu42RmQnumndxNbAgAXcV8RZGLQWLxHx?=
 =?us-ascii?Q?MifYkNyUMeqxHi/QcJJnmDUgwklL9K+8clilJdmAcIZjoblsTtcPqbwTO+zf?=
 =?us-ascii?Q?G7kTYpIeSub4ReL8UshUQ/9zafES7fGYWbpLXJ+OFwfh4J+dHhY66qQkLp46?=
 =?us-ascii?Q?yTi2nXsOzChFp7Z/WqN+PI1UYzr+OPHBaFBOgc6/aFIoqVul6DD8dlnUltpK?=
 =?us-ascii?Q?yIulWiSi14qNK33teaU85kpRGMegWNSVBGxNAbo0kRWhr4xBx/OcqAryfgPm?=
 =?us-ascii?Q?TiN0rWBRiPdndplkDdTfZqahajYY6JvsN1B38eyYCbbVyCwS0SyUUPR4yDUB?=
 =?us-ascii?Q?/IkDMesx7rFrUAWArSrrkyLgWe6Qf2S64JV4rgGeim0hSr5ruyLknAgDOeOp?=
 =?us-ascii?Q?ATaWmzVemDfvuNtmi+xOIPzWR/Q0H1wIu1/5xFwslIxdGvFmnAY6D6ruFCey?=
 =?us-ascii?Q?GiJQy7bqDmfBut4OnQyZvgUsNEkw77GIddaO89hQU2KdNTc8mzlS+ifiqRml?=
 =?us-ascii?Q?Ydq62GCT/03wjtGxIHEwFkIGq7bnqudazKeQc9DGhx/PeBGoppIE2zgIgc9k?=
 =?us-ascii?Q?MwLgwYjRMW3O4tTpnLseLXp5zj2fHuiSE57SSxetkf2ZyfQ8AoojUFDhYKo3?=
 =?us-ascii?Q?DJvjjmkrT8hw+mle9qLUoHCtk9HwvQNrkm/RIEN00Sw092Im4tWomjCCW2PU?=
 =?us-ascii?Q?DSjhqpdJKSfJRfXgZuBxEvrJCdCx05jK1hxRgYc3tgrvlRPVihnZJSA+qojP?=
 =?us-ascii?Q?Txg46wHsZ/5Wi9zi6shOVf/3YrepTd+q4iq4J+SjUBhxw2piotOq74Z6JXGm?=
 =?us-ascii?Q?lA8X0FqC/g/Qq+SjXgsfT77m3Aeuv9a+lvtEV8ylLju+Q4btnBnRcyAtPdev?=
 =?us-ascii?Q?Pug11raO7noUx2mMd5fJnzWWYlAhmaLz9mH8EMm19nBS/rt/5yuelsl48Fjf?=
 =?us-ascii?Q?4z7TXj+3daMW475HHtN3AO8nec9kMJM+poVx9yTq69FOG8xqJgadf00oKN8+?=
 =?us-ascii?Q?nvZkNbOhwYOuskRhfs4GZoBkBTmUcs4IxU/8tsHDqfNShln5h1Op7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QfvTIt16hKhwhRCqz4O+nR45junBIcRhYj4yi1YXTVgOsq1QVtnStKvMop/6?=
 =?us-ascii?Q?QdW2XgRkP2g7KxLUuvb6MOEBOYoLpp08lDjfOszWrKHxv12JTC5YHUHFmN5L?=
 =?us-ascii?Q?+06lIE4fN/M/69+19UJlW4gYvo65Vs8SRRj5ozkCHpaeCedIE2eipQ4eWegk?=
 =?us-ascii?Q?+1eCTod3TIGFFW9Da4vwrUAjUGjhigWIIN9ShJ7ccHKTUS3zj0duuGAY7/z3?=
 =?us-ascii?Q?zn7zxXMT6QoN4FKm8GxYhVUf1L51OiX17DQVQjGU417m+XNv41T7XcoYz8Zx?=
 =?us-ascii?Q?gCkhTqsKMW1T6szTkmNpkFjqj1xwOOPBSBh9nfPn0Q/X85vQ3rHErTQE+fZF?=
 =?us-ascii?Q?tBJmZsJrskrCBoWJSF4aPiq0blUTGxQu8qOQiDWpYJNc9ZhUG24FcOOuccpA?=
 =?us-ascii?Q?3sFCdbGH6jK/232fJfTBph7/8OPYyV6e3KWmeZIzQCl/WPushTi3WoaJhsvD?=
 =?us-ascii?Q?tshJ73JcH86i9P8xdEjpZtl2VmvpAE/Iy/VKSR3GpIRM/iNHjJTX3BusXyqb?=
 =?us-ascii?Q?EjDNFqgXZVsur97T3kiSGi1+PliyLaqTedPtGTwMfh2BFgl9MAWXN1NE1DZP?=
 =?us-ascii?Q?IEwxEsO6RR1JEpSUSMpYpdtfQ/ilRKbWwzPua/k4RWRK0l5B4Gi1sL+NBR9z?=
 =?us-ascii?Q?bVLdXsmhimCFoq5WdW8kVxfKpMKAJ56sjQic+Yg66dF4D0dkngynrEmefBC/?=
 =?us-ascii?Q?7sIQhqsyQUQS2l5SuKSQLP/od4Srsp11AbMRQCfKUagtLFxIyI5OoS4gUuNE?=
 =?us-ascii?Q?0W6IYCgXYdmwnRjfhEjbhOGbvPEcrCub3k2+3zin7OakYLHrkFH4oILjUA65?=
 =?us-ascii?Q?gMaxW4vvv95VdcsUJ4sm4cj0a1WspWQabilr7Jg/LXIamTxehzkBmWHOsIRG?=
 =?us-ascii?Q?pjqWbh4NkUyEGpxsFvI7yUr1/rGhY4ea9VSwjAeXSfnjhapXNP+bxmiwAVtr?=
 =?us-ascii?Q?sZkN5b1r4x+K5IPft8dWd2JkAnfZJJqbI+cf1jls5Z5+PwPaBJMfstNS/lX3?=
 =?us-ascii?Q?EDqzZbXaZm/In7EY10Q2X3Wl2P3DcqNBsrqQ5Lct4WHgC0c0pDZfxUaz6vKe?=
 =?us-ascii?Q?RUEVdpLZVHCsn/+rnKORcROxNSXBkcxLZFiBoAyhca3jBDIhIfLfj26cPBLf?=
 =?us-ascii?Q?xBvZKiquNfb70i5zyiNGqVSv7yhdQIifzEUUVEJTAjVp63sUKM69McAPlrrN?=
 =?us-ascii?Q?ErW2vP5xOFF582vP00K/r7UXY6iyznhos/swOyZ0/f5rplvxMmqFhQD6fY72?=
 =?us-ascii?Q?SzW5PZdkvbDoCmEbdv3uwim+EsAWo2h9nlch93/UKibskGfHSm9QlFj44Bqw?=
 =?us-ascii?Q?6AhaGA6rBpCLlpIaW1WviQtdbhLJiqZef19Say9+WrP7e+4FJfq8L1Q8xNS2?=
 =?us-ascii?Q?s5vT5vI6Zx3OZXzG7cOYa8JoPMvWbH061sOTCQ/UQW24QweMiER7XrKmWx4v?=
 =?us-ascii?Q?choLXhBVemnwkI1W7pVeO89792ipvqTw5MFx216ZxYSsSEAxDIivjxzJ04bH?=
 =?us-ascii?Q?Vis/q8BS97r2Qju2eKknZln4I5g+lYI1xrJR3yX+gDk4deHe4vKqKEWiSeid?=
 =?us-ascii?Q?2hIZN11+YP5+23TnDK0h6LzzJK4HnHLrClYKj3Zn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcf7397-409f-440b-c2af-08ddb9d0d527
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 01:27:53.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zE/jPxaSIAo4n8jP50nzRB7rynWnVqV7sxcmS4jkaT23ARskQFXQddopWD0Bd5J1mBj1m1BmklddNrC3L1/j+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10910

On Fri, Jun 20, 2025 at 01:52:28PM +0800, Shengjiu Wang wrote:
>On i.MX94, the MQS2 also needs to be configured by SCMI interface, add
>sm_index variable in struct fsl_mqs_soc_data to distinguish the MQS1 and
>MQS2 on this platform.
>
>Add the system manager indices for i.MX94 in the header file.
>
>Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

