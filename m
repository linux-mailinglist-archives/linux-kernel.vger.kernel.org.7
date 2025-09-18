Return-Path: <linux-kernel+bounces-823180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F38B85B82
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071495476E1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A11F3112C9;
	Thu, 18 Sep 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d0JIEnv/"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8992B30EF9D;
	Thu, 18 Sep 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210259; cv=fail; b=bM63yBF9ZqeWwJv1CuG3uF7GGX7Gbv1ktMJk/1HmiDD0tsGeDP9RGCN8Mwol8D7gJtI7JO9G7FwP/qP7L2JCQi366q0c9v7ujSNhchUR5eow3IbDreJW3Yc/wRv+DkpMGjR//LC0miU6KShAF+q/Ijb8gnar089R2q4UUMtCWXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210259; c=relaxed/simple;
	bh=DdFLJdrEC/wNcyfbVxzKE+rQfbA2laT6eO71mq//hxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oKEbnv2ACfwUHwXjAClUL59+NoiWH7qcQfbFdsTot0S4w6CRJieRAaJvxDhd7fIxv6nBRvza3vt8z6tSF8sKiTI45cWsOtZRvTivEArKeIiSbAHzbmTdmo/HcJtA7IFrMsbmfHbfUcgHThcEVEXpq1Sxce+6WeXkC6I2H9NSSHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d0JIEnv/; arc=fail smtp.client-ip=52.101.84.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwAbrywTziSXaGT2k/JFke3K8ZXo6q8aV+L23nT+BAApIt4J97miVsywYdpFJ8izWf01Sb2gWpFb3ekfIqPZqMhLhZNXEyejfidogqeEQQlep0T0faSvCu5jTCcuQfhmxRK3mLiTvWCb3sFdRHTQLPCIqHh9Zb7Vr15I0OQtpnXxdzY7T4SkmiR+YOVh1PwJlLFDbyt51J3LGNSJRETGBBw2k4iCbNybmoJiMPwdASwg3A8yD4vLpM07cC9eLmAaVuoviqhd2/LoDRkrLihAEDn8A+8EwdPX1HpfgMGkXfwJJseicLnmBRBbEK2QXHv+nnkWVzgibaMw8z7CXWbEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9zlmJ7RLkLWzUxes4B0Erhs6WA9RJyvBUelnTG6j9A=;
 b=q5srtrfpizC0wp5e/572yfWqY7AmRVClP8DhxBIYa4oc8XLVKOYLEP51iysbi+CjA6N4Ts3N5Zx1EMs+fnFqxIUkzJCbBy/cpaZO3hlyYHRTptTqFb8xnCEp49gjSvz2ZPgXUyGMI9B52rJPlq5vVoxxl7LO6F40YEu8H+YDOv0E2UCXuxKjg35v5WNzJR+NWDJTPUwk065ZRe+eaWw7FhBCLIFKs0f9d3CKUE5mQe4WVfR3y6xspSXBNTbe0iTZ5ldCYRsUOtUzE7QZKchPOAbwOivMHsywqf6GNxDt44f76dWXomkUwXtkyaAmojqCml9xn30OEEIs09RlZPKAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9zlmJ7RLkLWzUxes4B0Erhs6WA9RJyvBUelnTG6j9A=;
 b=d0JIEnv//8b0xoMRyECZKiZEZbm9nRTSLKy6iYeSoM3Z2vXcwPusMHvdTzghA2XWn3WTsDzjTjfiQ9vXSlyDQNK39AfXIYttf6esB3OA11mTMuIaBlj28PtwyQ7FP+cvrznpEwgHxbAZ0+2BzgxsC6K8myf0QS35WvMO9N36XfuMt/cTrywg4/sOQR2TXnjE9e89eTTsC0lwBPGJ3b23JJe1jCbcztTiFc+UkZxVmUA0PeIlT+6Jc4Fx0g20LLK94zZseHgLoA3L0C3aRKqSLFElBsaS6WP/M/7re7awgtvCbB7QoJtq1i56gI1px5erkeO4LnO0UdQ5oqczQC/4Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 15:44:14 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 15:44:14 +0000
Date: Thu, 18 Sep 2025 11:44:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Durai Manickam KR <durai.manickamkr@microchip.com>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	balamanikandan.gunasundar@microchip.com,
	nicolas.ferre@microchip.com
Subject: Re: [PATCH 4/4] ARM: dts: microchip: add I3C controller
Message-ID: <aMwoxsACdicpAFup@lizhi-Precision-Tower-5810>
References: <20250918095429.232710-1-durai.manickamkr@microchip.com>
 <20250918095429.232710-5-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918095429.232710-5-durai.manickamkr@microchip.com>
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a4543a-4e32-424b-1d6c-08ddf6ca383d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7m3E31UTp0X8GdeCWeFcVBOQbvcsOoCOCoR8gaLR04YQub9TJbEnjDwjFLYX?=
 =?us-ascii?Q?DcdacyqHrNNrcKypkCQxtagQC0kXTV7xKo19KZIJ5IaqFoD9hul+yVvf0GNn?=
 =?us-ascii?Q?t2rWzWOjTPBXZMAN6OybHWftGtiTY390kQaVSYobdN4NjAXCetNJh0cX6LNF?=
 =?us-ascii?Q?w8p48vEuAM+lZNnJQxw4/+GuMJ9hna7ZFd3juOSJYCPJ/OxEeALsD2p5i7m8?=
 =?us-ascii?Q?ys9eV60AOn39UwL4PM9UdXnpkGYX6QYFntXqGzLB9A8JLqZJb3Fefct53jCO?=
 =?us-ascii?Q?IV8mnUzb+0EUhF9Q8WWLkIP1dSPhIP1MDiOXqxB2L1viB3pqvMMtsnxOzl3L?=
 =?us-ascii?Q?fbwoS97c9E+kKjbFcUUPQPbNcV+1O/3I9dI3/7A3A02qPvA0A+3WfgHi8Ph7?=
 =?us-ascii?Q?UgLxPg2cV/vq1mGhYRS2of+0zaqNYUW7tTePyQWXcrBAizr+Alh1vn3ar5vb?=
 =?us-ascii?Q?xoBjAClkMi+RTgsLwoxXJKB7l27QceAhSV6pU0NWsKT1subD6PlPebvqtzjm?=
 =?us-ascii?Q?5yuZaMey4fzLU48QHWdx3KuOIW8X/Ao0AfsMnWziyTpujl2bfh+GHIFoNbZ2?=
 =?us-ascii?Q?54LL/C6V+CPCVgGfMUmhVL67ta3lIYELQVDOWPNPZqfHDGE/GXqhOz1wQyEO?=
 =?us-ascii?Q?zCP07y3IkVi/jXlHTggR8Zoh7snlzeWJwHJA7vRK70MEYIzXEySJMnrBqLJA?=
 =?us-ascii?Q?OalAQIGAfgZXGXCCFq71zxPcML8njqrYzLF2CTbjY4ZgKEfmOC/pORzt3nQ0?=
 =?us-ascii?Q?H22swBcP+FYYY2U6g//jldcurRURZ/bEHUAChl0tJh3YF7iX32VU1pjewrX4?=
 =?us-ascii?Q?TUlLJch0TRbeCLDaAc0SyDMbXdhmyB/AiYmrvF5Bq1+n61Q5YbdflZzGjNYc?=
 =?us-ascii?Q?+FHE8na1j0ELW/+xqZQwLzVTLtnduJLejLzMEecuEiJVcBCHlooQqWNUkfPB?=
 =?us-ascii?Q?43EBShJHPyGutSMsTlqpV2RMwOzcOTs7ovhpb2odfvkz9ALk9l7ffqiyzT9b?=
 =?us-ascii?Q?LNIKO96HvyJR7/KJtH+gcxijkLuPC2n91sgwUtJbh6H+H0HC7GHVOdDsH7O+?=
 =?us-ascii?Q?dqTso9EmF108mO58ckWuWW1w+1z0IAvCEGxjKsGjRTRUNANPXdCWP3T+Go9i?=
 =?us-ascii?Q?pbCyCQtzsiJAe8k/omAtmV4YKR5rrBbu/qcetE5w7Xzx+usbxfddM86XpI0h?=
 =?us-ascii?Q?YGWdjyyjfM9hmdFEezp5sPhqMNOcXIn6DwHYjepWo3VCsR2ngpbV4MtARsxr?=
 =?us-ascii?Q?QG01w9Gh70qOzhHW0nT8+qTNa7gtQSaL2x+dn38dKCMWa09JYWanc8r+tDU/?=
 =?us-ascii?Q?+xa4GiBEY8Mrmnjyxvz5cnOO060TZJm5OU4osy5DtE3YKIfjeS3LrUjqbfSD?=
 =?us-ascii?Q?cDr1ZZJlu9DsgeA5L3KbRv80jlXbYcCZJEhvRjH3FRtgVWnqxSZztExejlKV?=
 =?us-ascii?Q?Vs3wT2dhREh8KLNKcnJNr8dl2wofY3cA2VFH1RhOIXqJ6E4RjFhByw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9XFEmS09B+VtER35c+vFnJD9IrqUdux1CJe990HrCNzIBCud85vCEx1aECur?=
 =?us-ascii?Q?n3ETUZdaduo15x+4aYxr9nHVSNfHJDS6xz3UFNVg6+aewZheEIESle+oSj65?=
 =?us-ascii?Q?q/NgjdE2G1ML37BCpylaCOsRryceCuo4M9A1OIMyOjUukFntaKqE3iOb6DZ5?=
 =?us-ascii?Q?5NUU4GxJkGTIeRL6MBidOv+8V0wSPLsiQ+uffGhj+lMXsOGjacSxvAsg89jp?=
 =?us-ascii?Q?k2zIdOMBF6rANzAtmqd16NR/4y14/7XIDsH/EKKTTz/Vjj15KAmg8uFrl4sW?=
 =?us-ascii?Q?Ho37cHQzMaHeY4SuMfS+umXjh4T4Ccytos5uTkYrQD/rwWFk8wAfNzUS4sdw?=
 =?us-ascii?Q?UKBB5xXaxcQUNNJNQSw0ZG8+AsoFiSkhvrYDqOOcgTDQBioGrrbGPdozGVp7?=
 =?us-ascii?Q?FDPNIZjwB4sL9CutB9MSNcHkOY37w8VMw5QAD2AfwTQ9Bf71n1+A4XqqmYyQ?=
 =?us-ascii?Q?9lVNnNS8rsYhOxu8xtB/iP7OiWJe81siEeMPO+1g72f7I1jsp2t/3l8nZ2Km?=
 =?us-ascii?Q?oVWN5vYqxgO+/O+QUrtfDB1YFatFOPAP5FysqkrDMinRc/Y39V4ceKTbm95I?=
 =?us-ascii?Q?lXvFypQ3m9z3AmV7bV7inSw5bxszQ8AJ2ToCkjcSrvhK+9ESzeJW0iEmpdQD?=
 =?us-ascii?Q?OCX+JQL+R6vnvhTH0N248FJKK+8JBQKE/eN6BqKeoHHzG4OlJSdCAN1KEMhp?=
 =?us-ascii?Q?sYtzUaFiAtwZgXjs+0V/ZGOIF0Q3qJ/r1sUrbLMXcsvHlcQJdIqeMHiKwhBh?=
 =?us-ascii?Q?Xguvi2X9BVrCU5RnXhIjPG7taNk0zqHtlwo0pSvfTroP0Woco8m6eQJ9K62o?=
 =?us-ascii?Q?PXIz40ebR3TaaFY9DeycbyqHdA02UzWJZIOQ5eqwX+40R2E0ot3/9N02FWPq?=
 =?us-ascii?Q?gUWcEJiHTs9Q93jv8+GLG/36l6JUQ909/LS3NS6te0UriANunhAfLECE9Egf?=
 =?us-ascii?Q?dy4eOhO27n93kg0mHx+bQtM9W+eyvOYTC6ayuLwsy50lPn07utYfGSPQ2OL1?=
 =?us-ascii?Q?eKeP3nfJ5fGzHb8vensbVyq7Au0nFNoW8GADIV2JkeGZbD48DffGmcwPoEOx?=
 =?us-ascii?Q?7YxOJQ5EabINo1+aUraecYflVhkTI9pkgc2GJy8SNKW5Lq4iHPZ+wZK+eEBa?=
 =?us-ascii?Q?KZfmMTiTTfuifWVRbilMaYbGDoDVfZy1W6KyrGfCwGr4On1HL81r3+aUHAPN?=
 =?us-ascii?Q?r9/O1dgJBlmy1bR0sMwy1U/Wvd3VNGJXifgQ2S7Ac0SbtVVsrxQYwcOgYZWH?=
 =?us-ascii?Q?r+f7nIuQiGbyvXUdCNt2wg22VHQU3FAvvqGecnzKPAjh2vGJj6rdHIlVUNXm?=
 =?us-ascii?Q?rixwc6jsUu8GbkWgEhWaijcHtvSr+N/wr5k/Nzf+BQzqwntnyr+0aDf5oSFj?=
 =?us-ascii?Q?kPTfGGO5fQ0oOlaeOhd0a7Oqb0LpgI3eIyEEL2SGPMKUdUbIRDBvUI8l1NxH?=
 =?us-ascii?Q?8fkuvsAaXL1nf7uyiC0mm4h1uq2inPXj3ymJ46pF+9lEvizvL0cAapftRpi0?=
 =?us-ascii?Q?2N6+oMj4q4Eeuk7PslKOdBLDeaNlg5ZCAq12Ne3J5oXh9+VQayBryAVHb8wi?=
 =?us-ascii?Q?wmy066DiiMwO3/zFxqkygYLq7+goZJ+CdWmpSf8M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a4543a-4e32-424b-1d6c-08ddf6ca383d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:44:14.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOO7oBPOAR39Z+qJWQzg9YpqL+yoqTOaXp4D7VEqeiw9STetjpPeHvQQfCxDmnWMpciSlPDf7mUn4Rb4M4h8Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

On Thu, Sep 18, 2025 at 03:24:29PM +0530, Durai Manickam KR wrote:
> Add I3C controller for sama7d65 SoC.
>
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/sama7d65.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> index c191acc2c89f..3a5da27f7d83 100644
> --- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> @@ -721,5 +721,17 @@ gic: interrupt-controller@e8c11000 {
>  			#address-cells = <0>;
>  			interrupt-controller;
>  		};
> +
> +		i3c: i3c@e9000000 {
> +			compatible = "mchp,sama7d65-i3c-hci";

Need update binding doc for "mchp,sama7d65-i3c-hci"

Frank

> +			reg = <0xe9000000 0x300>;
> +			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 105>, <&pmc PMC_TYPE_GCK 105>;
> +			clock-names = "pclk", "gclk";
> +			assigned-clocks = <&pmc PMC_TYPE_GCK 105>;
> +			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_ETHPLL>;
> +			assigned-clock-rates = <125000000>;
> +			status = "disabled";
> +		};
>  	};
>  };
> --
> 2.34.1
>

