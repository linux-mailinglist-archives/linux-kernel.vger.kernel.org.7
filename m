Return-Path: <linux-kernel+bounces-886736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61AAC366D7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B21A1A2015C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5969B335070;
	Wed,  5 Nov 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Do9uWj1S"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1628331A59;
	Wed,  5 Nov 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356238; cv=fail; b=G0V12/ck00+Z8Cku89GtVSkri918SGwiaL0MSVwQrXragFZMD54VdYm3a08JNDC1kuE09kDrE46+nyZzIRBbHlSgZc7X5tG0NylrJZMcl569joBWU4op4kVIk0AdQmxv6asszd3gY/UVvvPWsvk4/Ns4qjyWbDsSWSINMrX1j+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356238; c=relaxed/simple;
	bh=HaSddJa8xyiR3to2yVU5WThIUJwmyAYAUJ5nc3xJUA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LCfW7YvDGGXNqchIzsO11O79xBf+OFdKjiMbuTjKKTzS49MpL7qKtkLDfyPKbyMzABvLM+83pQo3SO96vHIxvui0mjYwA1pEHE7uCFUBv4CB2fMwu4wBHTSpxdNNazUmv/6tBBbxoPY6uLgT0qHXZmp0/KvI67uRPu2WqIWFQ0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Do9uWj1S; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmyY52IeAe66U8NICHDDYqML33WeMCvVstd9KMzhtE2MxvpdVfiin3KDtnoU6hDRj5Ux1QKAculzldegM2mCgZV2D/nihDajxh6MohBIXa8LFflu1HwOV0GwUWjkZV/UbOv0Q1ThFxv2hqgWtGpUWEDLN/Nj1Ou1978tyqGEufOnqdnqciJF1FYkfNE6icbvej16/eBx+dpgeD6KNeqaeBIk8mZM470s0mKs1S27cNBX4RL1pUTjKNvbuWIy8YPFhLveuQmRJy1dFHZHn9nGHeeS2cAoFHNsyzSsfTwRqrxcctq9YSxF4uoaI7eRHrfUjum+ZGlgNtiJsTX5fnxLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7tv+JWcsa7YIrCRHQPIVirO6xsIEfIT81Z6+1xuJk8=;
 b=s8AItk8i49+mQwASUCShgiUjHA41fk1RAzBofruggmUfonuVYNPysH7nE+v2pOf3QBysu/jq/ETytyu+IiWdkx23TNACvGZiXUiuY5OqwYwsQS2qQ4RfYJcuLTfmZ39+JD7u32vDnwFMNSbksuTsJZ3GII+T5vIk05MkbZW7W4qKAzD1ClMbGpHPJrbGXkHRHFWz8XpJtrFVFbUMTxh84yDYma2s5iOX6uJ10CHrctL2vRkzXRYjZXyMkrfUxmryoXvoYo/I4K2aYUCRNJNUFRSFDUokn2LKzxDHek/QQl9ifiJV55VxjgrcZGof9vm9+xe6QrRRtNYPcC94WyQiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7tv+JWcsa7YIrCRHQPIVirO6xsIEfIT81Z6+1xuJk8=;
 b=Do9uWj1SD8CorxioVdxHaqnIXf/SKKjpQSIWDHbRvSrDZvZK7QSeCpS1NuwPWRCTtvvjg40Z4yBl/1Rg2XMYoOwky6NvnU86HdSuBZp4eP3iwtaMaQa1LT5n/O66C2ku8hxBG4MFAMDkfPBmcYSlES8NlOa2ILFQAmYX43LJruxv9aPhcZ5KcB6exx4+k93WsrduEappOuq9ylhoq6gUPNIZUNuDkN3PoTM4CZSsdOH4HEmMbaylBy3gLXy0LON/j48woVwFhZejtclGQzij5WMNTWX0FaIXorzOBfAj4TiULlyXwurSgXrthsSzCuyHd4dkfbbyCaVPlL40YuXkgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by FRWPR04MB11199.eurprd04.prod.outlook.com (2603:10a6:d10:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 15:23:51 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 15:23:50 +0000
Date: Wed, 5 Nov 2025 10:23:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v4 5/8] reset: imx8mp-audiomix: Switch to using regmap API
Message-ID: <aQtr/uvGFJEjSKnH@lizhi-Precision-Tower-5810>
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
 <20251104120301.913-6-laurentiumihalcea111@gmail.com>
 <aQothuvsclJoP74u@lizhi-Precision-Tower-5810>
 <e7481838-af1a-46ad-9f94-8de4e20a9611@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7481838-af1a-46ad-9f94-8de4e20a9611@gmail.com>
X-ClientProxiedBy: PH7P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::32) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|FRWPR04MB11199:EE_
X-MS-Office365-Filtering-Correlation-Id: 59541948-ce66-4e27-109c-08de1c7f52a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BUXgp3q6/OPsQHlfk+OajyxEgIhVpFDeTNpB5PFZcXRuyqE95i0akQ8c9JFQ?=
 =?us-ascii?Q?RmiCJ/toITbVQOdjQN1x/Zd25QAXPVeCdvdYKnpVlaqkIsbaEuszxBCtxv/o?=
 =?us-ascii?Q?vmsIc4YFZEKvkHTuSCp2Lvz4PiqNG76c0ghPyRhs1s521zWJnm205YOQ1NyO?=
 =?us-ascii?Q?JuD892dqjjo5XsZ72iVs18X+4G/g82IJQWDuN1l5wIfj+Si+irtYBfrYeA82?=
 =?us-ascii?Q?zytt7vnEW/kdUE8+XzlM/CQk4Egc2Aj4nhohFtfsfkr3sR+aKta+jyZLd071?=
 =?us-ascii?Q?DzvOHoanWy3VyR3dKTr66rcWFPOLF0jh8lFh5EWd6UywqY60yj5v2RKZhWL8?=
 =?us-ascii?Q?PumDVQGYO8u+eGt4b5LUc9UpsIpwzGRsbM0XnvOHda2Ue4Lni2CBbAzwuban?=
 =?us-ascii?Q?x+CIwW3sIPwPZK1N9Pj5SNMmpvffMt/tNrtc02RTQIrAvubfFoikmojRa+uF?=
 =?us-ascii?Q?3eTUnGrTIpWp3AIvYjbxGJxoaKiUuRp0sEJM7Thp01eeqhW8ZJ/hl+icdDzW?=
 =?us-ascii?Q?jmX9yDhTtJ38h0ddew7Z0SHtBpbgbZjkaQBqvCT3payL6pex/h7NcsFMfQ8S?=
 =?us-ascii?Q?UvoVqqoCwAyGO58VXLx+HzzdjbhKkyPA3WRX00SS/ho3HzYATq60TtHyZxhG?=
 =?us-ascii?Q?9wKsQL1UwEoWYiPNHAyyzy7ZpOMtZ72rjnSHOJ7TJIHBng3bzdz8ky3CNhVY?=
 =?us-ascii?Q?wLqofKS14l9GmCmX3K32ssSlRAgDPEVz+b/HQQ3ydBpyuhLWjXDHgCzko8v3?=
 =?us-ascii?Q?TbJ5AiNtQhTJC+LX1P2bly6zzxpFtBWRiruNEz+E0DRTT148vHqFgw8IM8w7?=
 =?us-ascii?Q?dUrBQ9XT1snnY7SfiyCNakE4Cvk2R2WrHUwbDS1T4PYT1vw/suYMy/bkExw+?=
 =?us-ascii?Q?udJ4Pwotv4L+o1Zr1wVVWG2kzHjxyYrHkAKph6t5CxYElcEdQZ2+mQFiNqp5?=
 =?us-ascii?Q?CwlIhHeTl9PxOO+vjh9/5A7W4Z9A2bwto07EMv5rWiIEzaDQAOjnkNs9drQB?=
 =?us-ascii?Q?q7g57SwUw/V4ndIvlCenv6j6pOlYkreqfM8j/kcVQfLEP9dKEqa9iuqnlFlv?=
 =?us-ascii?Q?yWNB21mPH05oV/VkiMUmcQqaYyzPW2hZ5JTCK8zsnbsfK7ukWmEUXnsPe6Bs?=
 =?us-ascii?Q?fZFtn20lY9F9qMTq5tUtM8Znwe8ywv6Sy0o2xEQ6VWPuB3opdgX9PnsnH03v?=
 =?us-ascii?Q?iCJqHM3vPDWd1wjaIqez2svrz1qwQauwqhJJ8xN8l9ZATmoOBvasQ0UYZKiQ?=
 =?us-ascii?Q?ZIcGz8PzHhMvMjekA1HX/PDYnSYnJkoAJOvLZkP4aq4E1IkEpJKXAW83pzdJ?=
 =?us-ascii?Q?rXMMVT0TgtvRDV/G427o2Tsz/RmM7S9ncRGiMgV9odUQHOBgz7c/gWeFiCcO?=
 =?us-ascii?Q?Em2JkOqy4ZczgAAUurVUTIcAKyVf03Pv36qxZLL8KJ/T6ocNSYaFQzvr2ZtS?=
 =?us-ascii?Q?O2btp04UsjysILy3Y7tQ+ObkDnf7NbZXz8ZWGGHfHxXpWNFeedNL3hNLm8fX?=
 =?us-ascii?Q?6zBL0HPvQ6MeY80yYRJ7nTEEUksH/FFw4ygd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2bvheMViLm2RjrrG/IeP5peJ01LvHUKhFmvmGcQvS5LE7H7Z4ypKK+J3T3D+?=
 =?us-ascii?Q?8H0dfSS2X/hZj3hbck9K+P9lvIdlaJoJ2yLwG46i6huU+p+rfdfjN4An8sg5?=
 =?us-ascii?Q?dHL28qR0c7AhxYagXYgC5o03hNi/V0NIt7lhaxLnM5VLuLJJmoqt1e3eyPg9?=
 =?us-ascii?Q?QyaPIHjcVAJ3GHeaUwvhu71t44qgFWa2ASF+bFLAPlkq2Bc62xsONkT4SP+i?=
 =?us-ascii?Q?ySW34hcFyrqrn7gFfnY1l3xVr2bKq514L5DPpMOaFrtkbjDfxkGHbIuqzu5n?=
 =?us-ascii?Q?xH7jOv3p0n5m5sfAYdc4Qy0qM0O24mNYlP6hVDGEaJHWBvuQYnC1qOLVv3jt?=
 =?us-ascii?Q?5QcNSZlErIMX/56eO4IGrQXNu0/Qtc7GHKj4IhsCYUjxoXL7df8NYjtZl8w0?=
 =?us-ascii?Q?64MJYwk0Ljiznmj0f3vl9Ems0P5yojgJMvLUeziFx3+nBf5cv5QWaXJtibPY?=
 =?us-ascii?Q?h7cHa68R03sKoGBSQLr6eKEe8lNiIcNuNu9VORmYDwIhQ7w3Mw6MqaQ0jcsY?=
 =?us-ascii?Q?KIKHzmAt6SFTOV6UPnIEe6mS36fMV2TMZLH3UG9oAWt4dcB185iFLvCA6Jby?=
 =?us-ascii?Q?kHelikcXbDqpWC+XnESEbEY5CJaESE1Zt84JyIQidHQl3GQZqHf6CTvuMLnr?=
 =?us-ascii?Q?/57MmpCq8kBbxUTusdywSLG9TTPqY4YhOFmmX/Gg7YAxdu27tIVAcHgUp8we?=
 =?us-ascii?Q?/VdKDq/EqH8Pczck/giuMAyegV/RiG9awHKcbO/7RHAaDP4+Wf2K8x7CgpoV?=
 =?us-ascii?Q?6F0lQRt/ll8if59w/VHRtIZa3JKhbrlIn92r1VV6h035HlnRUtd3+XvImhUL?=
 =?us-ascii?Q?wRt+6ErDXN0WDXkJ0tIAzqt3CoxvXcqd5ZWe3zzejkJFw1ayjIAeNp5tn27a?=
 =?us-ascii?Q?8pP469kpfa+V+ruhEGQzY/GxnimsvwC9DNHreDDSxhuBRywC0JDvq6Y9X3XH?=
 =?us-ascii?Q?DsGXpZ3FSO7xtTjs2orfyq/5kD5rFJHA4j0h8kcHB2kzKU5RLTu+uXFx79qW?=
 =?us-ascii?Q?Xcjedo1ri8Y673q74ASRbXIlXkUT8et6Ekut83cRQnyWytKx4uz2xF8DvKw6?=
 =?us-ascii?Q?kbg7mIzxPyTdbGOsRhHBUzWEwMGK1QnkhLJmeYTDB8TRXzrnge3hS2IboRCt?=
 =?us-ascii?Q?0oOndm7F5ezuNXcoLrsOKuKLUS8VdhhbqPyidqqVC40xq+qmmY13Dq/oUyXr?=
 =?us-ascii?Q?U/C6fFYfP5FsXGgqfUEDQ9eVaJaRWiTUBwfkdeJ/ZiwCzcqCjkfuNsS/xYui?=
 =?us-ascii?Q?RWmHiP8qG/9+f/46gSvaKO4OXIc/cRbcuq4H0oOfs3M0lSrAF8EyMJXA08x0?=
 =?us-ascii?Q?Fj5/QnX7mhKY9NJjCe1wFFxDyjy2oxjYps8r5Q65a29NLreAkWscExIAWQFI?=
 =?us-ascii?Q?gQoj+16Y3EULGlxA4w8FA2DOYuAeaJ1AFxtG96jniD3uNLK64Ua8UyJ2KC1n?=
 =?us-ascii?Q?kjc6MHtPNCoZnLBuF4SksYAuRRGzZMF8Hl3Bh/qEEnnM8glbI/5By1x8Noit?=
 =?us-ascii?Q?cZAkBCWQIllETzL8H+SinaQa/+rKuabN8hpc4iShjVbkdkJtJ9+okgJfKZay?=
 =?us-ascii?Q?VPz92uHOSK6m60BLXZY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59541948-ce66-4e27-109c-08de1c7f52a1
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:23:50.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCOSjwXhZphT0MbpPJyMKRyoH6tizEOcz00o9YlMJJdtf0xz5HGyfhz+bRyWMllIB1F6Q8Jxti3NekaKiMec3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11199

On Wed, Nov 05, 2025 at 03:53:59AM -0800, Laurentiu Mihalcea wrote:
>
> On 11/4/2025 8:44 AM, Frank Li wrote:
> > On Tue, Nov 04, 2025 at 04:02:58AM -0800, Laurentiu Mihalcea wrote:
> >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>
> >> Switch to using the regmap API to allow performing register operations
> >> under the same lock. This is needed for cases such as i.MX8ULP's SIM LPAV
> >> where clock gating, reset control and MUX-ing is performed via the same
> >> register (i.e. SYSCTRL0) and different subsystem APIs.
> >>
> >> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >> ---
> >>  drivers/reset/reset-imx8mp-audiomix.c | 93 +++++++++++++++++----------
> >>  1 file changed, 58 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> >> index e9643365a62c..18a7f68aa59f 100644
> >> --- a/drivers/reset/reset-imx8mp-audiomix.c
> >> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> >> @@ -11,6 +11,7 @@
> >>  #include <linux/module.h>
> >>  #include <linux/of.h>
> >>  #include <linux/of_address.h>
> >> +#include <linux/regmap.h>
> >>  #include <linux/reset-controller.h>
> >>
> >>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
> >> @@ -42,8 +43,7 @@ static const struct imx8mp_reset_map reset_map[] = {
> >>
> >>  struct imx8mp_audiomix_reset {
> >>  	struct reset_controller_dev rcdev;
> >> -	spinlock_t lock; /* protect register read-modify-write cycle */
> >> -	void __iomem *base;
> >> +	struct regmap *regmap;
> >>  };
> >>
> >>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
> >> @@ -55,26 +55,15 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
> >>  				  unsigned long id, bool assert)
> >>  {
> >>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
> >> -	void __iomem *reg_addr = priv->base;
> >> -	unsigned int mask, offset, active_low;
> >> -	unsigned long reg, flags;
> >> +	unsigned int mask, offset, active_low, shift, val;
> >>
> >>  	mask = reset_map[id].mask;
> >>  	offset = reset_map[id].offset;
> >>  	active_low = reset_map[id].active_low;
> >> +	shift = ffs(mask) - 1;
> >> +	val = (active_low ^ assert) << shift;
> >>
> >> -	spin_lock_irqsave(&priv->lock, flags);
> >> -
> >> -	reg = readl(reg_addr + offset);
> >> -	if (active_low ^ assert)
> >> -		reg |= mask;
> >> -	else
> >> -		reg &= ~mask;
> >> -	writel(reg, reg_addr + offset);
> >> -
> >> -	spin_unlock_irqrestore(&priv->lock, flags);
> >> -
> >> -	return 0;
> >> +	return regmap_update_bits(priv->regmap, offset, mask, val);
> >>  }
> >>
> >>  static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
> >> @@ -94,6 +83,52 @@ static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
> >>  	.deassert = imx8mp_audiomix_reset_deassert,
> >>  };
> >>
> >> +static const struct regmap_config regmap_config = {
> >> +	.reg_bits = 32,
> >> +	.val_bits = 32,
> >> +	.reg_stride = 4,
> >> +};
> >> +
> >> +/* assumption: registered only if not using parent regmap */
> >> +static void imx8mp_audiomix_reset_iounmap(void *data)
> >> +{
> >> +	void __iomem *base = (void __iomem *)data;
> >> +
> >> +	iounmap(base);
> >> +}
> >> +
> >> +static int imx8mp_audiomix_reset_get_regmap(struct imx8mp_audiomix_reset *priv)
> >> +{
> >> +	void __iomem *base;
> >> +	struct device *dev;
> >> +	int ret;
> >> +
> >> +	dev = priv->rcdev.dev;
> >> +
> >> +	/* try to use the parent's regmap */
> >> +	priv->regmap = dev_get_regmap(dev->parent, NULL);
> >> +	if (priv->regmap)
> >> +		return 0;
> >> +
> >> +	/* ... if that's not possible then initialize the regmap right now */
> >> +	base = of_iomap(dev->parent->of_node, 0);
> >> +	if (!base)
> >> +		return dev_err_probe(dev, -ENOMEM, "failed to iomap address space\n");
> >> +
> >> +	ret = devm_add_action_or_reset(dev,
> >> +				       imx8mp_audiomix_reset_iounmap,
> >> +				       (void __force *)base);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "failed to register action\n");
> >> +
> >> +	priv->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
> >> +	if (IS_ERR(priv->regmap))
> >> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> >> +				     "failed to initialize regmap\n");
> > Does anyone still base?  Supposed aux device probed by parent devices,
> > if all parent already switch to regmap, you can remove this part.
> >
> > Frank
>
>
> both clk-imx8ulp-sim-lpav and clk-imx8mp-audiomix don't handle the clock gate
>
> functionality by themselves. Instead, they use the generic clock gate driver, which
>
> doesn't use regmap. ATM, I don't plan on extending that to use regmap (how would
>
> that work? would we want that? would it be useful for other people as well?)

Okay, I suppose parent clock driver use iomap also, which cause map the
same area twice. Although it works, I think it'd better pass down mapped
address to this driver. Anyways you may improve later.

Frank

>

