Return-Path: <linux-kernel+bounces-722144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A7AAFD5CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872731C240C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE72E6D1A;
	Tue,  8 Jul 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O44mnGdX"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8E22FDE8;
	Tue,  8 Jul 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997332; cv=fail; b=GC54FC6tO5a2Iv66W6lj5bIBo1fnqCKcuPcdIax5DEP4Fl9G8p7b0OH7J5b3kXIUJO317A2DnY51oBXWRr0FXjtob81IhAsL++E5YtgdWqEfJyce/vLP0yF3cRMKeSvMzk+AeetOdNGlRIBGp4ab7PSPE8kNDI+o+2l3hM45Mm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997332; c=relaxed/simple;
	bh=QGKPy3SiDwXOY5HiH05SHsJgDIP33W8v3gUMPxbNAwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q+1oQdUkdhic/Tmtq7GYgwyWAdup6IIIdXT8HODvBG4TCZiQ/wmwVwAzUhCHNE+76Q8nIcYtGJYmxL6Os+AoH3WuNLQEaDJlpOO7VcPebDCDQnjBQQ3ltrUxJrptUg//J9lxe13T5ldVzzW2ELjEB+LbD2DiMcvgs3ydlMofCns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O44mnGdX; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6Eofo2REbs/T+OueIJ3OZwtXbR/345WF6Cfj2NJG+3knJ+P1AkuuAD1OUQu2lKe/OBgs3we6ZoZmx/1QXlezy2Xg1CVQsnbFWnsIcFVc313IBANntYKh6LSLOgFs1pyeNgm31o0aowHdeYqQF4sIQ9jx5TH6AvZvRjhAE05E7BRitIMYldgwmdNrRZJOmRuonoI5W/wlpl9wPhoC27d0JYRxW2o7o1C5RD2utIQaktKkxl/vjIAjj8DWXA0WVGpZ7X1Q0csm2STjnyWsU6ZxUOGaSR1HCjZpYTDRb6XH9sZa4EGHKtIhya/Qrs+wutJ4w6p49hkT9KodrnRi5GrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAOTt1W07arGNB4YgSmARkjoOYgz2lD3jk3TTdJ0w98=;
 b=yttbsEPJAwwn4TGQ/OQTPNE8/j5sueFq6HujijtLEHgu96dupOQfWOrOObkNujOaoEssGCAvp7vE5tkquxHr6iq39dW9+6JEGXEpVbp6xg2ou0EAIAj+JVA3GZU5eUUR1Zqp4ZbB3Zr4DIAxGDfI0II2LoY8ft85Tn5mdvdAolBHUqgCLdE+01/7Zgat6yClDlHHX1zKJn7ODH03Rkx34fX7lPZAko64xVQq5mPtkPLlAB6LDIuyxG8gVNVyUbIkosVrNAyUtpujjr/6muOHYGQU1W0G7tQe83Wsm0IM+o9a+VU1lO3Lb7UGYRkQqomzZT0f1wO+HRTDCjLo3Hv7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAOTt1W07arGNB4YgSmARkjoOYgz2lD3jk3TTdJ0w98=;
 b=O44mnGdXhLxI2/l9owcYyoK3uR4SWtkFdQnJs9cKcxihvrOWg646hQFrGwXbfyV+mPOy6p/VrLsecNNm2bJ4TcgblsIlLtHgQqQXLuPG6ZzBfSDrAPSyncCGbHc8b11EYQm1Vl+v1o0NEvcF/viJ64QmeYz8WrM2XL5ZCYOdh6TgN6lcR04QP4pHFSLYFRtXkkg5k2elKsO9MD1OUEA6Q18XD0Tjf6zrWFhYlT0tzmjjP6X8n5L9E7Tfyl8GN84K3CEsi2V+uw7Y4IsND05Ta1MGIeyIIHRqvXzI1zPUX4iXQtne+VUmxeIgy+rGd+F1DdKW2L6084ZIwXquTtkbwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10453.eurprd04.prod.outlook.com (2603:10a6:150:1d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 17:55:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 17:55:22 +0000
Date: Tue, 8 Jul 2025 13:55:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] ARM: dts: imx6ul-kontron-sl-common: Fix QSPI NAND
 node name
Message-ID: <aG1bhbwV85GcjFaE@lizhi-Precision-Tower-5810>
References: <20250708125607.66113-1-frieder@fris.de>
 <20250708125607.66113-2-frieder@fris.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708125607.66113-2-frieder@fris.de>
X-ClientProxiedBy: AM0PR02CA0112.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10453:EE_
X-MS-Office365-Filtering-Correlation-Id: 604bc02c-fcaf-4e35-68b1-08ddbe489c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wA1kziHpaMhrJBVAxJulG3eMJW5xOomdBaQasdDSKgTDl/dw5U18JjQuV6if?=
 =?us-ascii?Q?EKSLxe37jsZV3lhUbvL2Qp4Ob0rp6uMPc5V1JG1TCUcZZpE83tjFZf8cNK86?=
 =?us-ascii?Q?W1WePAKHQehjIk1rpHLwWCeviFudN9nznHoM8precJYby1SwxbRWvPj3jEqT?=
 =?us-ascii?Q?lwrpXmo+BJgeTnr6plz6UAQkaYp//Z/wHAGEuhupsVMtG/pJ+ZMFXleikCeI?=
 =?us-ascii?Q?hzOMWEBstJHnmQ+uBmgHhw05XzlN85DvXFUdg1kS2u4S8HmD38MLnFVPqdCb?=
 =?us-ascii?Q?YGEqBWwn8l6fsPFPkadDsJTEMeKzK5ViQnHDWs+efA86l5opBge4UgsNigly?=
 =?us-ascii?Q?F7L+U4wEHxuG7Esu3MBSny8jIdhGBUqlrsNgJX9dF3TYKTq+bpiN3tj5OpCj?=
 =?us-ascii?Q?8x4HDBqqQoA2hWkbo7pVDSm3pq8tJfIGgGoWh4ddHuDLyA9OBM4YnVD0yVe/?=
 =?us-ascii?Q?4KU3SRs73pTDmBiUU3Jkec2FTyglUwFVKDGqePPbBc2lV7gfQ/Ojzm6f/5Pz?=
 =?us-ascii?Q?g/J1rKiFmPcAdZOgSeco8XpZdUY+2L590ei5NzMvVQdf3CteWnXLUbD3YUrV?=
 =?us-ascii?Q?5XnjN1jQYZQjC5NrMR38l+3StMJnB+qeoayVN+VlHzOVzhViJRTmDhWcMkaI?=
 =?us-ascii?Q?qYk7KVgBcQaSVjvuWo4cojshnyuxGFBSzvCnHC9ISfoNSwxN0DFHunTb0psL?=
 =?us-ascii?Q?kKgGoWvraw45ZeyKzNXVVocHCXLLbgUPsPh2LlEsugXjKjo/miCT75g6Cr/C?=
 =?us-ascii?Q?mIp265pLqHoI44KFW1lb9CbznADu+c8AGPXUmgMd4qncthQNkr9w7em8CFHd?=
 =?us-ascii?Q?whQ5+gBd66zhmplFi9Pu4GUoQpOUssSRw8EqgrJLj78zY1Fc+4Wv5SOve2F/?=
 =?us-ascii?Q?Y3ixZwV7CNsFNs+8VG4ch7FNBL2eSl4tJooOmP+7zgg60O2NhYWSapj0lSTj?=
 =?us-ascii?Q?8zSVpE3P8UwUpSjYbRquVKv4UKMdLP1tvDX7dNHShHS8q/Xl3Tu/zgenyYMv?=
 =?us-ascii?Q?cWYUXktBjTF0wYCdGbY/ZpPp9H1tUbCQKYxIHpYFfL/vhJk10SBB4/iLplVD?=
 =?us-ascii?Q?ujcWGTCyVkWewFcBojDwzf+DL/6kriEk+I5AMwB1cO7XhiZtyfJqdEOGmqlB?=
 =?us-ascii?Q?KL2WibeGvgQB5jVbRG7O1KrFtgukYjpLWSt7JGkAc1hdYB5/sAwy0OUHiEFM?=
 =?us-ascii?Q?VmnIXIm8Gf5+LD1DjqOVSLPGCVQ/YohzF8WWVezVPoXTlXsPVQO90ZSAtq0g?=
 =?us-ascii?Q?5AMBJ1cIa25De2c/7v/qP9mHEnRJF5TqdlawXgfr2iGe5G88eQX1rWAk++Cx?=
 =?us-ascii?Q?2WKhl9CFY0Fl85Qqomy9jiz9X+l9NVmVxY3/JtWeizhGasrW7jMXbdyMtm0l?=
 =?us-ascii?Q?Kht+KwH9PADOG079eOsp8M/bBmpFcSJXFKEwVxxcL4EDh2XKKUUmtDJhLjkb?=
 =?us-ascii?Q?QBGu0zT/1ijWcmnj3JFIuaxk9QYD9QoSj58pD0Mp1ZzLyFWKTszS6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y4T7Os2C57P2wyg9tqnk2qrES4AvAl2u1AJEJzSOnYKTNQzpFD4in27rv+ZJ?=
 =?us-ascii?Q?8obYCvWZkSNQW3CRPB/xb0sSJtBM8iS/1YHhZfA9+3Z7ZYFQhu56r6+wPmW3?=
 =?us-ascii?Q?M2fDkoevdqStQEDaCWaIgWfPZKrtvRPRareqEJIIOTdTO48JR/jcYfii0q3l?=
 =?us-ascii?Q?fg6TCgu4DpGCJHWWK1cm/wE81UaKq3k8MhGDm4HSvfXurS9G3Xwb74X4uev3?=
 =?us-ascii?Q?0odsEZJWqs4/EUY8nrehjFVeolJkEZkljpBGHhO2IcIWuGN2JlG2IxZrkXss?=
 =?us-ascii?Q?A08KqqbtMT5rduIJZqIUU4HBQJbqcvN9yGwva0ZMIshpOgm858txzFcOeXgR?=
 =?us-ascii?Q?BoEUjwSjlzy13cq/gsLTAhWpqIfUg8bgK1QfYL4Z3aP7SC6j8YiRZgTC4O/P?=
 =?us-ascii?Q?CulMpmVGydpu0btblxTbecpoyt7Rcinvuqsix3b5ckX8JexawLaOq1NFQTFh?=
 =?us-ascii?Q?N9jzAUxDArYUERt+2yitYXAJE5pUS1wUsKEF324CphzfYav0teG0u/r085eV?=
 =?us-ascii?Q?b3eyHs9gbGNix4x0f/o2k/Zeej9C5u3DEbuJ4xXuTHWksFOhmXqKyLVxUDD0?=
 =?us-ascii?Q?vYBAMOoXj3btrcKK6BnxaLPDbzmttmZhqd617a7l2IrDMQvoHy2TRIP8Icef?=
 =?us-ascii?Q?hrGwaQnSZA0usq/s9o42NqdSCxh+w8EndsNSKlM2yQ8smP9393sWB5Y1PuMn?=
 =?us-ascii?Q?2n8m+1bBIcda0I+Pawx66LT+obhM8eIGNhReStZGK89DrwSRRs2QwX1Kcsdq?=
 =?us-ascii?Q?unYYNB1w20fyhurZucvkN8y2X5DrnX+sbwMz8uT5+NB90xdchNxyDNS2bHUf?=
 =?us-ascii?Q?5fCwFPCv8G1UlsmbNAx/ynJC7uItp87DuxI6XQJihOVkZj9Z//OZBx6Tidqs?=
 =?us-ascii?Q?3g5QbhoQughNAkghHW8QEBEwpTSpVaZcI82/j5CUkwS2ic4lEpZHouDrvZGa?=
 =?us-ascii?Q?damZW9h8ax96O9iWQWTmMmMa8iC4qe5t0hRKLHXw7kZmFVCIcI3QXzRsJnfM?=
 =?us-ascii?Q?har4pgJay0qs3KJyCS0GmvqUNX1pUM7bCD7NQkJuuuJFhjrS2wNI4fdaEFF1?=
 =?us-ascii?Q?z62ZAJZ6csLHI9LG1kiS3JuTISvnuMZaHHWQXOFNjxbbNuOTK1uQGN6+mUAA?=
 =?us-ascii?Q?DbJYbzmfKxY0r0dbzIbGre6hGMpsXtLRYKFhlKaZq9H/eoYSYuC2AwdCq/ZL?=
 =?us-ascii?Q?ano8tFLYxXgru5Y5YPSmrZd/fF22SdJNmTnFCteTY9Es58FFusH2DrH/WXWQ?=
 =?us-ascii?Q?lbHCuENUqzUlY0KdFGppklu2gLbXoUQZEo+wYanYD0V0+LsGPyE1RK4eoJLJ?=
 =?us-ascii?Q?bgpudnjWlJYDwFuTKF58fC9K/rGTovtsd7iryZK3tIqYVIScXKwRGGLjs9dS?=
 =?us-ascii?Q?fg1jHWpvhxnOXGWT76O3iQA1ebrIL77c43TR3ANHROpeyn6ccj07mqSD5edD?=
 =?us-ascii?Q?LIi74r3h2sDbM6q/e4PGtCLxibHT0sercjKCo41LAy3i4IaoZ3FVaH3+bsM8?=
 =?us-ascii?Q?O+agYUVDC97AP/uWzmCSb43FNFiJi1S7hU3PyF6rGUe0bCnmO6ECYxlXQfka?=
 =?us-ascii?Q?rCex/AgAEunpuX8cgi7pamwqa4C58F6F1rY60pAJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604bc02c-fcaf-4e35-68b1-08ddbe489c2e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 17:55:22.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRcz5r9TuVlkmxrcCVw9LgSrKBz7RbKM9CEKhw/V2bM1ryTRDsmEkQ7ui/KsIRKSoaijnfKUUtTIV4lzWqrb+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10453

On Tue, Jul 08, 2025 at 02:56:05PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Rename QSPI NAND node to 'flash@0' in order to fix the following
> dt-schema warning:
>
> spi-flash@0 (spi-nand): $nodename:0: 'spi-flash@0' does not match '^(flash|.*sram|nand)(@.*)?$'
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes for v2:
> * None
> ---
>  arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
> index ab149c40a9cc1..793c95d44c7d0 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
> @@ -82,7 +82,7 @@ &qspi {
>  	pinctrl-0 = <&pinctrl_qspi>;
>  	status = "okay";
>
> -	spi-flash@0 {
> +	flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		compatible = "spi-nand";
> --
> 2.50.0
>

