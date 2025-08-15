Return-Path: <linux-kernel+bounces-771177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B0B283D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F5FB643DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875A8308F29;
	Fri, 15 Aug 2025 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iwFUXpGE"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185618A6A7;
	Fri, 15 Aug 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275561; cv=fail; b=HSWDKiXqtdykFJuOTZHl2H5iFnb/aIOeH2ZrDh4Mh57ynFjyqSGiT4xcFBLGLIgWhxcjmXiRb6RiBueOUJLS5qUAYLp6mmJB3eZn5vxfX+/Q3rHqWL3WY+b8L+fMmGkF5MeNaxEwbOrsc3YpFfuqQ3Fyc2GXD5CHPk+auLn3GZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275561; c=relaxed/simple;
	bh=k8N+vQjpNA7Vxry5E0+femJ0DEn5RIeNGToIlx8CkyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XTPV1rzgMzy7Dmq+UkBA+snqrDKxmBEjfumBvhK6r01LPwnwq2O5E2BEYY2+dYKvGpFcWIe0UDa76vgF/lc7dicTqwqu5rA3Amth6W9tFOMvJo/VcYIIZDMK91J8v4rBod5Lft/W93NjpqdST8GH+l4WYjaY7hpeDfYqbxOcTJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iwFUXpGE; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YALsgkGBh3qCdSJZwh08AcCbAqJAc5F5kdlUPooWZsr4xM4mrd16l4kg7lvZrJ32Ll0hCBEelBWoe8HqLF0f8e/1ukrhzYF+h4IjotUY1wlN5dL4qKAlF2xpbc1pDix5aROBAyHpaYYiDkwsP2EPaNOCvr2OkcgsvLbFS2hObLHcfbXLyS2D+DmxL2z583BcNBxPpOGzIAZBUDz7h+9LHVORIZnqyriCJ7CdPrO+WSCImFwb5ehqX2eSvfKbGX9N1C1RcmFLvRqeigDLPsmtQ8cpPGFwF0QMxh4JJurmdVGxKlVCnZuaeQRcSRUQKFlQm598xbTBvQNuyfVRSMNrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp3O+N7zIW3z8HX9Xv/zpVbfohMfluMfPSnKk2kRyvQ=;
 b=uW4KW3lNBdtNtL6hJ03AVxBfKqRlXhANtoE5947Az6vtWvAtolP4fUnop8+5xUpfnEvjIBNgMNlT0dsYYwgG6WkaHj1ZPMvq/5BeqJH2qWXhKzfwjohSWhKGVu2Inl4lV8tMM4tThUuiF/YmyA77l7vWrjIUAEXtKWECYq4CJiRgmapU9LL3xXobAYqL/VKk5kKGns3Y1iPhHWJGBELeEKPdx184oZXWb7X8OrzewGx9aC5tcxFA7IAYWXmERh2JDE9htRg4FoJmCa/Vvo3lWmXDha06KcKn+vtWYMgFLXKOv0/gq42rPeVHW3Rkov0SX41qf5T8/jRp6Uze6kQVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp3O+N7zIW3z8HX9Xv/zpVbfohMfluMfPSnKk2kRyvQ=;
 b=iwFUXpGED/d8opKSoGDtAXB3npSFVBlyJPhXGhiE98qdsPFlcvbtQpfC5hZfBjUMY2EqgN5k/8xzZKeKyE1lhEZ8go3ynVwUSDCmod2DZOJ9OFxHnwiWuDUNBSOen2aOKnet9h3X8x/fFckBWB9XakHyqo+eDbw9QVAaW52ZAXSpG3VeC6KSoAado8L5+aoXu/CGd7GcKVGb/1MgyfIJLrKfFbqH3PfEbLtQdDPNSwB2ccsQrVhyZ+gj8Vq+8DYaAdlRtkH3m3++79FbD+XxlO8F/AhFjmBRZVVI9HfKq6exRbYdgog3sXCnU/8brfiLcQDq2hQANy0RDXRBrsy+EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9595.eurprd04.prod.outlook.com (2603:10a6:102:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 16:32:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:32:37 +0000
Date: Fri, 15 Aug 2025 12:32:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] arm64: dts: imx95: Add System Counter node
Message-ID: <aJ9hHQjlJQzo950R@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-2-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-2-e609eb4e3105@nxp.com>
X-ClientProxiedBy: PH7P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d43c54-d5fc-454c-fff5-08dddc195849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fpPQvCvYHuY5YLmAaz3bXNr228uglyV+1sRFpu/9kNl0IZyci3b9leIOZ+t9?=
 =?us-ascii?Q?ZyCuGafaaqigxYsVrhw/2b319/Il98zC8/rUglQTS3sI5sLz3HeLT+W+aD/y?=
 =?us-ascii?Q?IbQ2o6m4PlA/Q3ASZNU9u8SFRc4lyFYMv+I2gmQDW3ef8t477nOizcWbcfEi?=
 =?us-ascii?Q?ieEWQV7sOQnKAT406YsTtpBSyJhiYaVY+umCiaYY1tJJCQSElHxd0WgXwLgk?=
 =?us-ascii?Q?MR/ene8N4sFUkDxgyQxJL3ujfX/6QbGNSWwRpGyL6WXKo5XCRx4glgagY1vC?=
 =?us-ascii?Q?u8HpYMAVR2hktjyZHa+R1zS21swZ7JLmJjloqEjdavnz0dcQJ7fy4a2UJEbt?=
 =?us-ascii?Q?T2XBFq7bnV20KoC+YdWcWFAVwsRnnJHEGRZPQ6XGKRV5A1MhzVqg295pbS5F?=
 =?us-ascii?Q?WGYL2J70XjqHrojKaZ3GoRKj4czJ3XhvUDiWrqQ4tH9idPXyxnjI66eCqily?=
 =?us-ascii?Q?YP18mv0uXg6RV4B1NjbI2oD0q+SZ93md7R2jZUfwcoBph1my2nVqiNTwespp?=
 =?us-ascii?Q?bDa5C/TNcKnPbQG9Wi326DL3+q1jJJ5WCZrNv1CUyttbjkPjakCWtLTmTUb/?=
 =?us-ascii?Q?/K7BuWZGZhrrL2J/WCBzz32KWPJouT5FN8Kn+DL7xMyPwjqRBY5fCAzehZHl?=
 =?us-ascii?Q?RgNisgzSjMx+/897veXsNuYIcxhLduWqdHg3gEJ4l7/iAyynuRFq7y4Uq8GQ?=
 =?us-ascii?Q?XiKXPGdwUhwfIhKixdoW4W7oqHRtWBJTC3UmQbPuksZHlBLuNcKQQhUkvevg?=
 =?us-ascii?Q?LB5Nq9j3ruOfAVVGtr5O0I3IuG5BDk/9FvMMJYT/pm9mbeLK0d4+8GMBVCq1?=
 =?us-ascii?Q?//A9iPlqzafQnd/S/AxpYMpXObTbid4+Hbedq7xlo6IDUT75TDJHtvL/ACWD?=
 =?us-ascii?Q?gZMS3jQRU8ePCEnvfJRcphNbkIJUM85hNn35hrLDlddMDS13iFghg8NSfxgg?=
 =?us-ascii?Q?Oa7GiAW5JGZ9c2KcNQh4QloMLdKMj9NHBQi0E52ywTKwf0+ZGIwGpBrpxBIL?=
 =?us-ascii?Q?x2lHJhpy/UHt/Xa6dBvRC2O/NK8OIdr2lzAsNlfAipaDvQx8ItZ8lPxA1cKF?=
 =?us-ascii?Q?0bAohV3iDQR64ARl8hq+AWgdVTb3+7HyYYB0qjYEyIy84oZtSXgdSW6DiHnV?=
 =?us-ascii?Q?hf75ARoGapCPzKeaFojc1jqB0jzuNwmFxEWaDrO+QZ772WXBG4FNcUgm16zn?=
 =?us-ascii?Q?CiQyxg63YrxUoLUEySGKnLdeBH4RYbNaGTIkBGU+cNDwZkNkE3rLSpQLQDAa?=
 =?us-ascii?Q?TRZwvq98RLuHDHMwZRnCv+4IORIAPqFaG+5Isp17K0jjniNrRSJIfbTA7HbP?=
 =?us-ascii?Q?MpUtNBakqMErx+fZZWutyGHunvYPDDvwbFwm1CLslZIVrkXeiGf6uuCCqtqn?=
 =?us-ascii?Q?CWwrTEeDy5Ek+Uju+jQ1c2sofxxHjlPYMHuYY6uMT7JunxYAF1Nr+pdney65?=
 =?us-ascii?Q?7wrLpQYZO42/ouiuc0y/7gR5DwFK9URK1sYp3qzgttuv4LlmGJM2Kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ob3hQ2yp+antIuu0E4P2OYpC5CaqNxR8u5HrtqHEAs95ahpC2IlbOYUMLQox?=
 =?us-ascii?Q?J2qW9Y/MI4zNA6DRflF9wQmLSEXsnotzWJzk2HLE5fNjZsnRdW0A0EnErrlf?=
 =?us-ascii?Q?5VqHBw7SpX43N/1hNvmmW90/vg6b1gR7+YeuzskMuW8I/GGl3MUPZMILDfgz?=
 =?us-ascii?Q?/nyOB3AmogwygwIErDWB4NOeieKZH8+kpQ1tpFsHWcK9L98mKrjv3d0S9x/k?=
 =?us-ascii?Q?WuHsLerI5lTgkCwA26GjacJchp18cRNfJCxVoBbHL81cpnBcpRrhDvBHl05Z?=
 =?us-ascii?Q?3CSZphpiT1tiurAqfEtdNOW8BIG4S2Tz9MSFSIP/JCepDJKbIGimfDzfUbaE?=
 =?us-ascii?Q?UC+Xlz/9c6mN6AtF4nyHV4WAunWmhF4Ek7rshLXqfocgQ17U8FgOLEONZT1J?=
 =?us-ascii?Q?XIccfMNPjiD4lOLLNhwN2SN2StgWjVar6rt+P11eb3F9X25C5tD9UW0cEZ4S?=
 =?us-ascii?Q?T4PfIgvWXmYmqVlXSte0WDFN9ywEGzehSkygaxLFhS9zkr8ZdT5EjbaP3Ud5?=
 =?us-ascii?Q?MhH4odzQCJy4tYyDnWDx6Y+hegqhfoMatew/0nw3mxFcENHbFFWjswkuxp3m?=
 =?us-ascii?Q?1tlmSXn4V0GHuC6EWguCLhH7sfj7BiV0BEisN9bzML9pMn6uSYKnen3F4Dcb?=
 =?us-ascii?Q?kFS+U2RbSeZq95hvlYWAuoE/zFP4qguoYJQbCiZokLgWtzCKJBdclOZG6ltO?=
 =?us-ascii?Q?vJ0tqHxV+rYb/f3iKleCdlzDrFaakmP3rXWBjmM/6vcg22Mg5w4G/n1saKWI?=
 =?us-ascii?Q?AeAj4Nw45FS0SHc59yfElfpvPCB7COVJTRhE3e1a/JeJJRrjMza0kFbA41zB?=
 =?us-ascii?Q?YiJW3M977x6gfQxRqnAbXVBz3qjjofQTrf80UTB7cbq56HalSGBujfroDmR4?=
 =?us-ascii?Q?tIoGtyfj0wEKLHlfYE6SLBweqG3wBoMgIyY9QMW7f0lQIAylJ8JYAdw48R7A?=
 =?us-ascii?Q?PVP/zsnCdeWzn9qQ90n6zl7wdltG5PNcSRZx1qy9SwiULFlV0hg/0tv+Mma5?=
 =?us-ascii?Q?LGJ/rL2XsNFHNjUiER+wkBSjbjI41pcVCDzMvzp/+LaYvt3CZfAlwlnIZhj/?=
 =?us-ascii?Q?4xd3OJtZsLygFv3bMXNCUTXr4pwQ8kfqeO/0SM/4NJUZU/dnWzPVg0bhBp2u?=
 =?us-ascii?Q?LtCsUde/ZQBDRg6B4RJmN4XEpX2FKxyU5hippnnkarDaxJ4DFLrqfpJ04rPZ?=
 =?us-ascii?Q?rkRz0Edy82J9doYUt1otn8L99ssl3tbSMAuwh19BKNmkWDX5k3hDnn+aCsHx?=
 =?us-ascii?Q?fuN/YJ9Cx8JPbH6XANNHuumzlyQSXTqp8DiKH39DQg1LiQBY59WjtAHg8SpK?=
 =?us-ascii?Q?PDKyyty03WkPQUR8lRkhiKxdsw2GW9mXXEfkdntHheamnjtFtAp3EuaXdgtV?=
 =?us-ascii?Q?+XrmzV9kLIGceDimtpOARf1XiDZNwrYjGEGFlOiQKI0gR22bCCTsP1IGJy2+?=
 =?us-ascii?Q?C/TxB44cfLtoNG1rWVCaRtbHQqXDX7Oj3S3QG5oR6M28SfNPr73iQEN2oDBY?=
 =?us-ascii?Q?xkTziGLabxPLyf82UYRkxjgCzRB7p6R8vU8e/KBz9K74ngP9Egr/0oh52cpJ?=
 =?us-ascii?Q?kI1cA8N812helwxW/rA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d43c54-d5fc-454c-fff5-08dddc195849
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:32:37.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw+wc2WOMqq/UN/KGatdUpPJ2WFWi7yVertEGdLWcWOc4TTK019FewCJh01x1q6xaPyhdn0ksHnnX4Xro8UvWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9595

On Fri, Aug 15, 2025 at 05:03:48PM +0800, Peng Fan wrote:
> Add System Counter node to support cpuidle when arm generic timer stops
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index dbcc557d07f5b8a0ef27d68b7211b07d26fdb9bc..642dc4b7a4770be50960f53a73db965ea4374e24 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -1260,6 +1260,15 @@ mu1: mailbox@44220000 {
>  				status = "disabled";
>  			};
>
> +			system_counter: timer@44290000 {
> +				compatible = "nxp,imx95-sysctr-timer";
> +				reg = <0x44290000 0x30000>;
> +				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&osc_24m>;
> +				clock-names = "per";
> +				nxp,no-divider;
> +			};
> +
>  			tpm1: pwm@44310000 {
>  				compatible = "fsl,imx7ulp-pwm";
>  				reg = <0x44310000 0x1000>;
>
> --
> 2.37.1
>

