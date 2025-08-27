Return-Path: <linux-kernel+bounces-788646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0856B387D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2213462391
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390F429B799;
	Wed, 27 Aug 2025 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q3h0u66i"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11D20A5EA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312462; cv=fail; b=GqWRZyZh/FZrt9x/tRYgPDVfnhmVT2BVdiTv2/Qyc5RzIvop5jxgbJSWf4BlviNM3kFW9YqtsQwBt1V24VWCS4KwbV/CN5p33Rf/jXqozHf71LZE51lPmvz7s5vhNj1AcLbrGof5016acfz3uucHRxTFiPh0iafeY84BTxzzDFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312462; c=relaxed/simple;
	bh=EL3PRkTXvMBHj2DlBNrpZbbWfUdc1n8z4fL/x7bRj2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y8XKl8+WoFALqjVDqeHhxj+UPOToEp49xi9DENqbGWML43kxP+hNAkzAYbV873STrhnk/rC7aJn8Z4ekbiHuMW2+l6E7FVQyT85+EZ3u5EyUC6qxRDziu7auvT7aLIpKlmAiXDmkov98ivQTomwCtxYyp+pFRFCQ6iaiWmWy4Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q3h0u66i; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyBV6QRXpLlgMbciaC3ozuza01/HJAH4+CtG6yWY3H2OOPx4NVo80NexROj9UvOm42moBBuVEu5bThFHxYperdyVf7d5lbJJF1keYu64OMFiiNCGO/jm5CkscLGSo4utS7aVILtaDxitArnqXIxn8pVkLmk8NdynElNKvGB4/JRlBqR3N2aju6xuwdVnDJnd0yjI5NFETWOdOGwe5+SeWaVA3deqJx0s38Pb4iFxH04KJelGZTkUWjDKIo9p3dZurkg0mWUQWVBKlfWJOLIiTTNAOEqvAp5TCvh0z1UhP0SsGtglKJgq7Rxf+2UpkhbpdI7KcULezIMfTQPPdTDY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ikGRxCK5RZO5F/VHNhPesyQgUMbVU3iPeUJKWnDkEc=;
 b=euX6fx+vqx1bOfIeBJFNAFF+0Yfcdfcy8T7FAHOtkONQPLYJXmvbBSKSFWp1zrQnVhoPdblLJjP877qPBgfLTzyyN6zud9scuv8MG4p8e2WHz/4TYS66aOP7tIXQkm/Yf4OfOUSKXXFbLUgDTAkX/TwXGHwj+GoMd+eyQ7mkUREpni9oWfgngiG3YdXMcvi26+3vSk4dzVq1ou/nPrpoKrLlKmOhHZ+BjSc31ZlAp1hVQz4tTf9FlSo4wzArZvQeeF/uhAxlNFPnilxx1WrojsDrPdNFheNPhSQVMqMuKvbToRvIOgQoYeHYUireH0ad6dn7mtl8S4Jab822EGRhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ikGRxCK5RZO5F/VHNhPesyQgUMbVU3iPeUJKWnDkEc=;
 b=Q3h0u66iNUqr8XJPv0klU32WWTAkxILNw90E7P3A1Xwp0qu98WWeKed3LCEXvxTod1p0GNUcOO36VZbLLIXNxMF3OENoO18gsLscSCdc78BWi7YivJiLth8sv8lVxVg9oRvqYrfXnM/57P1l8zb9UvH8+iJr6cEXLDo8vhMOzVDBtjnpBn7kk0vfwak/TD6b0XVl3K2N/1IMS7WtY2Aag1ucJVIKHmgK193Dvj8MXahFMrfuT6pL0NQoCvybNh0+qOZuMiicZnRa9M9e+YJNaPh/KKC2bfnvES8WC/PrmHyn1X86eINvPzzgC9BlY3/4bWf9O+5Sin9diFJYrBQiGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8348.eurprd04.prod.outlook.com (2603:10a6:10:25c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Wed, 27 Aug
 2025 16:34:17 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Wed, 27 Aug 2025
 16:34:17 +0000
Date: Wed, 27 Aug 2025 12:34:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	NXP S32 Linux Team <s32@nxp.com>, linaro-s32@linaro.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V2 2/3] nvmem: s32g-ocotp: Add driver for S32G OCOTP
Message-ID: <aK8zg3sA4csHwAHU@lizhi-Precision-Tower-5810>
References: <cover.1756219848.git.dan.carpenter@linaro.org>
 <dce51c4706ca4961a2ade23756aab750803b12ec.1756219848.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce51c4706ca4961a2ade23756aab750803b12ec.1756219848.git.dan.carpenter@linaro.org>
X-ClientProxiedBy: BYAPR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:a03:54::44) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 5244ce75-8b2f-4757-a5cd-08dde58790f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E5yCIRcKBLnTb5SLDrYbavfE/qnqSs/T8tZSLPUYlGBf/5p3oAfv6rx3Gg6G?=
 =?us-ascii?Q?RWcq89TpnbM5XgAqANcdlIMLNAAS3yuFTRxpe63IIo7rJTLl6LEPAz5ka7lC?=
 =?us-ascii?Q?Lu4+8yWB44NsQX1miB/D80CpkxqtEF2g9MXHOayWo/ggYxpB5eunKqTxhlMQ?=
 =?us-ascii?Q?wvvtjETGWkKfvrcjbjQA634d8tJbMDV3UNMWw/LaDMzt/aEE17wZq3JymkgH?=
 =?us-ascii?Q?PdySFvb8Am63+CRovSztxCsWI8UYfHBbHeWtkdK1etdCdWHI+mo1dQVd2ZCs?=
 =?us-ascii?Q?NRLpLQAOi3hgHOkt1pBvzrP6Dm7z9jC0zDtxyQRU5gGDLL+Pvzy8EFx9PwYU?=
 =?us-ascii?Q?Xqn24hjwghSac+vDVWou1g9Rck/rkZlfiPGLcF2ivVNOwXQZxVZ3a6csA7sc?=
 =?us-ascii?Q?WuLX+hsOnIkVL+N9CMaCoBhJndOqPC9PGS0JdVM9jCaEDkIdi2+jkoxA973n?=
 =?us-ascii?Q?hrYlIeyDFS9Wmj2ORQNONM8pOgItH/fucbt1Pz11sFfaD/sEa5tBJFxoRSDE?=
 =?us-ascii?Q?rOfLQn+TdEURwT7lX9Tg2Y2hl7MVQeaHHybq9mhsmNt8Ok56Fv6g3BAXwkSx?=
 =?us-ascii?Q?+DU+WvF/eVt3q4ASe2azV6Sh4/anE4kwxQXd6LjhIr5cHDx7/aoIaedxNrO7?=
 =?us-ascii?Q?q8IHIdMEwtCeTrODyIekJETl8eO76fCQxPz65xYAyGOSH8XM7BS8xopSLN+r?=
 =?us-ascii?Q?vknDGad1bRp31QDvSTKKcSmCEmd+HelBlfrlFw6MYL3yA+XKtgFzENgJB0Dj?=
 =?us-ascii?Q?BTZwden1P3Af7PZBy9hAOwqUWhIYsvtQ1x48TsMQvdLVHL0MUxJA2exO+L8S?=
 =?us-ascii?Q?itNPU/SvyFh926gYodAFs5S37Qn03Zw9jt66HOXUZsRq+f8rVPC2Jgflbk2K?=
 =?us-ascii?Q?pclyTeg3EdXO1AGFLvM1aEerQa8+rsteMIH0Rn0rTxV4IlPImNH60nIlkD0Y?=
 =?us-ascii?Q?5atJuF4P4j7kVaylsftTgbf1WqHImEHbBL/HG55DuPU+CkOXw92zNfWY1ISu?=
 =?us-ascii?Q?JKpubTVUDJp2BikcxzlJCj3ZjPC8FagiawR9gGR70by9xX8FlVgDQzXNAjWf?=
 =?us-ascii?Q?L9vKM2sbbmzRJIlm2QX1z+bmMF8wHVVcRti6ZhPt76EvopyLfNCxHemH+4T/?=
 =?us-ascii?Q?VJK2NhPlG0aTOTaj3EyHxaqQiOouOcSk7wdNryi+BDzGwaFRnLyv28+bac6g?=
 =?us-ascii?Q?v/HCEm6RfkYyV8RWx0Q1HILBndnbFMzqlk2a/a56qRTJtglf7zaPgH92wwZk?=
 =?us-ascii?Q?+uG9tZDpIihTCcJadcW/SS6gjV3Zip5leii044ZB8tgMUF1rDnT5ERFtalOD?=
 =?us-ascii?Q?u6GeoUalUa1iAKMXv5OuWUwBvS6hTqKALrDyzWXl0pvrR/Ek4nVqKh3nll+n?=
 =?us-ascii?Q?jw0fOGtKlkc3JNQxM3+1dGcgQaS6KR05LYl98Of2D+hzd8xZzhswNTW9t8So?=
 =?us-ascii?Q?bULk/QYvwZ0HU//xfMC3C/R2Cea6Skb79FnQ4+TuWizqW76uasdcDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9VqFHKq8Fx/Aox22rqjFAWEnAlxKkFsB0Qb80OOhMVU+VNUfaXbfqcx2gN3y?=
 =?us-ascii?Q?fS+nWiIjh+G50GJGtNLPy971rjVgaF9q1hMZ3A428c+JhbAmpVY+nJuRjvcK?=
 =?us-ascii?Q?BxMQT9xh3HT+83D5D4d+E0JVvwE9cftsZBPLkpNgoReaQjYMtY2Ns0O5l4VL?=
 =?us-ascii?Q?2lZQkf2vKmLT/Rlt55Et6n86nxMlRspP/Hn4Z37Sx6HIIvVSfx2dBS7787ZL?=
 =?us-ascii?Q?qSfPwaOBvWKokysR/zEC5auyMgg8edgfg341GA8/i4VQU53oPt/z4KzndzSF?=
 =?us-ascii?Q?b6pTvoZozGhOZKELF06TXRm3uXY7ijXDni4gaocCWuVmbLNMiIarnUnXzfhS?=
 =?us-ascii?Q?1XWqZj9w+iwZFPaIlPnyqOKYIlx1pY1rv+K/ScZDkcRv6zGgdVhE4Q0njTnZ?=
 =?us-ascii?Q?M9lhnNkaBTDGErC32zALzDES8/XMCE4Nh43ULtHm62fD4q9luYi+37NReg3K?=
 =?us-ascii?Q?jjF7iEqPDv9TJpxl2Gz9zejRoBKX2TaYhJr0DDSpN3Nj/PIbRhg/FkLuk/L5?=
 =?us-ascii?Q?BHiVd4zRljtadx6tviVpl4xLYQjfw0U9iQKCTopAet4rIlKPKMa761d4trD7?=
 =?us-ascii?Q?CubzowL81UsIppsMoc/QsHCTTa1OAWIT53yRQ97tBBoFwK6wtGU8qd0bZoyX?=
 =?us-ascii?Q?5beiRa8/Ft2nFA67aUaJLpKVRGfliEeKyICdluqmI+hStPWvuGYlAjiiDAbQ?=
 =?us-ascii?Q?zE8E9VBdKFtJ6ZYT5jp4gsCcx5gjinLjRhRLG2ogIJ/eazfG2royaEBFYXKV?=
 =?us-ascii?Q?HxlpGBR6+W4ZdzCiEirTb8gv6mFoaa3gtutOyvl9HgWxYgiV0UdtEnJNAihS?=
 =?us-ascii?Q?ZGiFMD7pezt/VpjQOn1hY9q8Fda91YhNK8PCXzumwPbOU0oFXdF+wQ2ZHCJK?=
 =?us-ascii?Q?I3i22sudVzMYTuz1aEqG54B2fzAPfbNbVjqMi0G7eCQsBulVaLS0RLeYqWbT?=
 =?us-ascii?Q?UYfbwDneWw0HJldbzBWMTLHB3UnJsboTiXZkmjVJbQXUaMU+Vq+k7R4XhsQ2?=
 =?us-ascii?Q?AEbwgOflpiFVUmknoGgyekNgtxs0MJZ9Ffqef0rsM9zoOsMmHI0sxM7hTkAL?=
 =?us-ascii?Q?5YGw9ZUmcGAWZblQYuTmPKjtxawsbOLfjuWo6VHFHk+2l7Rd0nbBzLtWH1RE?=
 =?us-ascii?Q?YActpB2vNIg2fCJy2/cZZjvai1QnEjzQprc0z/eGCZznFzZR1T3I0HlRX1Lo?=
 =?us-ascii?Q?dS/yNfjY1Cq2CJ16IWscnlNMM3N4t103xiHhMJBZzyTIm36LhmQ58TCFpLWe?=
 =?us-ascii?Q?SEkoVE73ah7z0Oj4OuJo3DhRg0PSlwauQbUG7TF7xwBJWvhoVA82OefKT/pM?=
 =?us-ascii?Q?NYN30gJDqKwFp2B61IfBrxGIeCRljUZAJWPEA0OfTWZWDIceu8F0QL9P+01O?=
 =?us-ascii?Q?gzoCc1Gddde0lcHGj/N7uKiujteyx01VFXDoldozz8CcRYrAz665CU4OXZ0Q?=
 =?us-ascii?Q?2S3JTAYOjRH8GxvpEYPnCuYakZPiVNY1voAfBF5QiQHD0qimXFC9wBRBhzYU?=
 =?us-ascii?Q?JJBBZlG1RA8GeiikPkwnc093pK9On4XvNMuzX1dWolr1Hwx1YWK9Io6D8NoE?=
 =?us-ascii?Q?VKiXMY2b1YwMHsqXcldDtq2b4Fku8r+LDIx63kyJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5244ce75-8b2f-4757-a5cd-08dde58790f7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 16:34:17.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TaVvgXBH5kqi+dG2g14gTsR5cmXBb6Xu7mQ1S6QCzUOqUIDi6juJsuAYwXJ/k3K0G34HFtmekH4wTuQ6L4eug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8348

On Tue, Aug 26, 2025 at 07:38:10PM +0300, Dan Carpenter wrote:
> From: Ciprian Costea <ciprianmarian.costea@nxp.com>
>
> Provide access to the On Chip One-Time Programmable Controller (OCOTP)
> pages on the NXP S32G platform.
>
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: Add S-o-b tags for Ghennadi and Larisa.
>
>     Use keepouts instead of the s32g_map[] table.  This allows a bunch
>     of code to be deleted.
>
>     Version 1 only let one word (S32G_OCOTP_WORD_SIZE or 4) to be read
>     at a time, but now the driver allows larger reads.  Set the
>     .word_size in s32g_ocotp_nvmem_config to be 4 instead.
>
>     Krzysztof asked for some changes in the probe() function but that
>     code was deleted instead.
>
>  drivers/nvmem/Kconfig            |  10 +++
>  drivers/nvmem/Makefile           |   2 +
>  drivers/nvmem/s32g-ocotp-nvmem.c | 101 +++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 drivers/nvmem/s32g-ocotp-nvmem.c
>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 0bdd86d74f62..55016f803492 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -240,6 +240,16 @@ config NVMEM_NINTENDO_OTP
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nvmem-nintendo-otp.
>
...

> +
> +static int s32g_ocotp_read(void *context, unsigned int offset,
> +			    void *val, size_t bytes)
> +{
> +	struct s32g_ocotp_priv *s32g_data = context;
> +	u32 *dst = val;
> +
> +	while (bytes >= sizeof(u32)) {
> +		*dst++ = ioread32(s32g_data->base + offset);
> +
> +		bytes -= sizeof(u32);
> +		offset += sizeof(u32);
> +	}

readsw() ?

> +
> +	return 0;
> +}
> +
> +static struct nvmem_keepout s32g_keepouts[] = {
> +	{ .start = 0,   .end = 520 },
> +	{ .start = 540, .end = 564 },
> +	{ .start = 596, .end = 664 },
> +	{ .start = 668, .end = 676 },
> +	{ .start = 684, .end = 732 },
> +	{ .start = 744, .end = 864 },
> +	{ .start = 908, .end = 924 },
> +	{ .start = 928, .end = 936 },
> +	{ .start = 948, .end = 964 },
> +	{ .start = 968, .end = 976 },
> +	{ .start = 984, .end = 1012 },
> +};
> +
> +static struct nvmem_config s32g_ocotp_nvmem_config = {
> +	.name = "s32g-ocotp",
> +	.add_legacy_fixed_of_cells = true,
> +	.read_only = true,
> +	.word_size = 4,
> +	.reg_read = s32g_ocotp_read,
> +	.keepout = s32g_keepouts,
> +	.nkeepout = ARRAY_SIZE(s32g_keepouts),
> +};
> +
> +static const struct of_device_id ocotp_of_match[] = {
> +	{ .compatible = "nxp,s32g2-ocotp" },
> +	{ /* sentinel */ }
> +};
> +
> +static int s32g_ocotp_probe(struct platform_device *pdev)
> +{
> +	struct s32g_ocotp_priv *s32g_data;
> +	struct device *dev = &pdev->dev;
> +	struct nvmem_device *nvmem;
> +	struct resource *res;
> +
> +	s32g_data = devm_kzalloc(dev, sizeof(*s32g_data), GFP_KERNEL);
> +	if (!s32g_data)
> +		return -ENOMEM;
> +
> +	s32g_data->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(s32g_data->base)) {
> +		dev_err(dev, "Cannot map OCOTP device.\n");
> +		return PTR_ERR(s32g_data->base);

return dev_err_probe(dev, PTR_ERR(s32g_data->base), ...)

Frank

> +	}
> +
> +	s32g_data->dev = dev;
> +	s32g_ocotp_nvmem_config.dev = dev;
> +	s32g_ocotp_nvmem_config.priv = s32g_data;
> +	s32g_ocotp_nvmem_config.size = resource_size(res);
> +
> +	nvmem = devm_nvmem_register(dev, &s32g_ocotp_nvmem_config);
> +
> +	return PTR_ERR_OR_ZERO(nvmem);
> +}
> +
> +static struct platform_driver s32g_ocotp_driver = {
> +	.probe = s32g_ocotp_probe,
> +	.driver = {
> +		.name = "s32g-ocotp",
> +		.of_match_table = ocotp_of_match,
> +	},
> +};
> +module_platform_driver(s32g_ocotp_driver);
> +MODULE_AUTHOR("NXP");
> +MODULE_DESCRIPTION("S32G OCOTP driver");
> +MODULE_LICENSE("GPL");
> --
> 2.47.2
>

