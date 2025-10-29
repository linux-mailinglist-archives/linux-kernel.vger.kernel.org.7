Return-Path: <linux-kernel+bounces-877040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7FAC1D0B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D262042455C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59A35A158;
	Wed, 29 Oct 2025 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kDSPlLpP"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5133769D;
	Wed, 29 Oct 2025 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767164; cv=fail; b=Y4ebI/M/UmlagTKcCnKCgf/wws9EohBY4fca6aMAJ/B3buIPasplBKY3zPjXAppbqmYQpkSauPfOIub13uNpbJHxFax23csf1Zbc5qgPMzGRBnigVMMuzNwuVn9CUUDvHDtnn0h1PgP+aP8uy7JZ+XbCq502bfClbKgyURRNEWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767164; c=relaxed/simple;
	bh=wrlZbqcL34PagipXA2Q1zINCRe3+c/0L8DooFaJMAnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UamJ8ucvyxxmE5PdHkMeTixsmEAfwh58pXnC7p+62PsOqfNlBh6tF2yjuoSYSk6QqEsPNjmE6zlErG7OtlXi58V/5M3Cwcy/qT6cssCYQMOY0W/xMbgt4eb1Igb15tzB+e7ZhmSUts2yv4+65S/9rx5/PCW3jpnC9iVhe6zoGIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kDSPlLpP; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WscqvqwEqGep7fuvu6YXOrxGSTqbWM4xmjUqC6gdvFOVxUG5VCKnToMoJu1Js4qQwRdCRiguPcx/n/Vm37N2YGn9JGJdM++hrydrdfenniewKD7ts6G4P9QCZbxqn5dJTnsjIH34tktN3AlaFD9dwNJdaxA70sXgtiDdV/8StJN0koDLR7i0j9vlU3535FDrcZ/tKzu+Mw31oOro23CYoNjwnm79DfFr9Vm+cartXdGLYsztf+g6edQsj6urxtok7WgDp5mz8kePV6J0F9hGfCDKsEpaf9KSPpi6xHDEYcwjRZH5Qrh8NTZdm/1/tiWAq1MPAsbeJ0G2Z0R6cNVMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6ps1X2/bbX2B4eu5+SHKE4iXF5sg5cVX9paDaM+9XY=;
 b=QRCmEIzEK33rZ7zM/OUL53IpU7KZKO9QJr6vDBcDx1XuXK9tP6TZtt5oCyhqQm5hzE4TMossHbNoXb40HP9EoFCmYIHqHQMm+V/+Gq1xwZp0+OGuINIvkWheDwDNJ4GNw4RGE0AxFqD9D1fs0d+pOXM9xGROoXoqcI820AdEuTUDnUVSm080R4dnDjj6bkJ13ZzN7mH4I1elXCqZh0lFJEwQ/7F1+c5zTyjcFDnTbrGSU/WEWpUQmOUun7ynAQ82l3vLN6nN60tFhNroQFsp9E1Oq5ovl2rENu+dlsN2Y4vlII+tp2C1KmdxnHkb1vKuZrRzbxa6acv8fM3S2unYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6ps1X2/bbX2B4eu5+SHKE4iXF5sg5cVX9paDaM+9XY=;
 b=kDSPlLpPn5g7RM/B9qg2eOL/ODgf40MNHCwf1KY7F/MlbUFDvzE29tfkQatYA9HBLvL945AiY23kmlO8caU/UV4B2NdYuP9DQoQ7ZFGzETAUb3IXTX48bkD772VlGhf45CPf5/KZjZCShyOLQX5ETgDX9HoDyzhxh/JF1pWwEat0zAK5Px+j+MpCmrRdltXZcutMzTPfuz5lQQvE7ALcU9eNq3d91o7q+P5RNjA03ByrUg4p4gELl5oe25qu9VSSJEnCPBvaJx9KgmjJQwOTFVOttFd/UlkOVBQrC2NaklhxjMDu+7HS8MwZDRe47m6x8z5TwiSlr1pkxle7RcnyWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11903.eurprd04.prod.outlook.com (2603:10a6:150:2ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 29 Oct
 2025 19:45:56 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:45:56 +0000
Date: Wed, 29 Oct 2025 15:45:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/4] arm64: dts: freescale: imx93-var-som: Add WiFi
 and Bluetooth support
Message-ID: <aQJu7Czj8zsq+yMO@lizhi-Precision-Tower-5810>
References: <20251029192852.656806-1-stefano.radaelli21@gmail.com>
 <20251029192852.656806-2-stefano.radaelli21@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029192852.656806-2-stefano.radaelli21@gmail.com>
X-ClientProxiedBy: PH8P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::14) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV4PR04MB11903:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e02b9b-ac37-4d60-f86e-08de1723c6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5N+KJdqwGiePQCiDcb0KDYzNWdnGkgkPb++5pbwIZdUJCL9/P6rUNHar14R1?=
 =?us-ascii?Q?vizNbecn/6APQUBxE74ZVq//s9YzeZcEmOMuBvyE6bkZ20HboWeBRDV8ZFqr?=
 =?us-ascii?Q?85gEqHY1oR/vJJgqqwSLAJao2BMQwbVnfJ6g7YGtTHes751E9kkGVItWMMQI?=
 =?us-ascii?Q?XVzvTyAqnhcaaznHm8ZQb/MaOcHo5UgxEYkjAwRAVphAtFlkNbAgaVaKTbqq?=
 =?us-ascii?Q?g2zMXadjVW8xc5fOnzaHYsaR9HFWi+xu2Z5yzi3lBh7B7HtzAs2r1T0Greg8?=
 =?us-ascii?Q?Cc6ckr7AzN7nOB9HGKZ67NhV27tAFDJE6C0Xhs46cAiJPbCYJVL3gcZ37IcT?=
 =?us-ascii?Q?Or6KKTSNvaVY+LDb0G9551h6/GwPhqiKQq3A0ShSslY5gWYt+9/ExmV/sZW6?=
 =?us-ascii?Q?fpUP86Fy5xA9xXOgoQzhquRjdZZyJXcV+hK9RkJyulbK0PCsq3op8zDYPBA+?=
 =?us-ascii?Q?TDYJxmIlC2CPVwh3npYqmYO0Leo7iH13QnLsCu87K+5fLQF2zfvDh2XrXD3n?=
 =?us-ascii?Q?S4TCS7Qh8ouuulQ20e4kxLmJHS3ICti54DtBoq7+IYB9T5x4Bq5NXZQo7lap?=
 =?us-ascii?Q?VWKaxHr5k4PR+yLt5Ih/IR9+gfByFpffv/JaZrxkhkgzdXeZaEl/OZd0J1g3?=
 =?us-ascii?Q?gXiRq2H9WQgGG7Pkme5pRH4MhdUVWjr1snfobEBxL4D4KvD5bg7I9p763qBJ?=
 =?us-ascii?Q?zJBTJqj1t+CWlADvEH8QyCmiBdRZW20scfd0H2dm73L2SUEklon6vmVjhRux?=
 =?us-ascii?Q?fl6hWCSkRu08LXl0h0a19ezGlqV2eAVShojG+4opLmT0/tBARCwy7Xdw8DZI?=
 =?us-ascii?Q?ptXL838tCmu7AD43PJhV6r6TsOzuYzNygBcHkzY962EWiSfI1ZuOA031hAtZ?=
 =?us-ascii?Q?JV/IyBrEzHqMdLPz8KYkbFWSujoUCaHcY5f1xjlQaOn1pnuF3eBlL69le0wn?=
 =?us-ascii?Q?kFQh24j4vezbPL0WqlQipz70fweNbCffB/IlkL1pEKWq+YSVvTxzYF2aAEx/?=
 =?us-ascii?Q?8yg9M+I13GgW3eQLvYU49o15fmDhxrmAC+ZJe1qWIfix8H0O697kRnmkwT8n?=
 =?us-ascii?Q?OH6gH/d944uY/3cofKPfmqz85SyiiL72gUTPjdnlNZP1fPQp9RJgJ4ba3bbl?=
 =?us-ascii?Q?y6WBUyhti31IPvu1C9i7GCE/WoaSvxZJ0wNDfDp0u3YD9a9ckD8oXxcdZao3?=
 =?us-ascii?Q?72uFnaWK4IPdtn8OMTLBz3WxjTXB7NhUEnKqhtwl5OPUYdumKeOyqE/QO0dn?=
 =?us-ascii?Q?KOQrACffBuERWpVS+1GW/yTJkAZif2MK4Q6wuKAc6nRwvUnZfIrLVvSB5NHF?=
 =?us-ascii?Q?n3WB53WoDgyO+uTX7mXGIwfc4MXxkTjProKayqUnsi6xsh/oOXoYb/43hsZY?=
 =?us-ascii?Q?7r+R1sv1RJctmRt2ob+oX3m0tlOJUVkYyLvF8+fgoPxVa291CphC08fgvhgs?=
 =?us-ascii?Q?3ShEZsjAKHjOMuMck2hMuSv+UZhS4zF8rtGHHoh2Ciql8Baq1QN4jbsFQwMk?=
 =?us-ascii?Q?Y7FVoYW0nuerc878ahvKajm6l0jPAiSy2H5S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gFfLJAHkRTNdHya0uzOEVPGgWtvMcbKyhcKA6l7fCOsza8RxP7tlgXtBl5Vt?=
 =?us-ascii?Q?oehuAEgrcm+ytwaOEYPFrLnF8XZXhif9EJH9aHaT0NIKXcNQZ9y+0ouIDmxG?=
 =?us-ascii?Q?YdIW2nE/l/8LlRotBH+1WtogSFmM+Ims5rFwyLSWQINyi220J57hP9WhZmzS?=
 =?us-ascii?Q?m2GY9wBosCVy+RLPP+At9EltaBG5e+ZcTd7EGQa6v3ZoiHvSLgCN4IuhilI0?=
 =?us-ascii?Q?dgwzwAscVc8HS7uvqmbnx0bwtIz+QadXPX7Zdv/R7AxsI6/LBphk1xZl7hYm?=
 =?us-ascii?Q?nxX1/y8DcrsKCDGYGe0IWwmKETRM6PgHsGLlt3f9YMMX9Tsxfs2sI0QUZAwH?=
 =?us-ascii?Q?f1shJAeVlK9hrT3uNomO9VH/Il+jF2UXlGfWmN0ugOSvL+jG6uuq8ciDAo3P?=
 =?us-ascii?Q?NcyN7Z59My4AqMDjrQC7E0p1xyn5O56MUhBdJBQu6ckMaijNV0MzYAfv6IEA?=
 =?us-ascii?Q?J2FqS/J3pc8xrxWWSE+vCjDqeMzBUnEBKFOf757SaU8VideDFeJJTQLNlhb3?=
 =?us-ascii?Q?Bx+7sCBp36QFPCc4/C1LcPQMIZZ+1nAtY1rl6t/CoYxk54tjH5F71ZWUSjeP?=
 =?us-ascii?Q?Y6Ql/COUgNx3Tw0oX3ri9rpaArpr/IHl1wWilpglDxuHXBre7JqjyJ3Xc05O?=
 =?us-ascii?Q?Eyf29iS4BKwccuLoWeKaq49y7s5lL/7LUVbanU4B8JzsUOWvpgcLssE9HJ7E?=
 =?us-ascii?Q?q25+n2Hp6CicrOf/vRh7adIg+bCwpLGJqGP+WN0UO2EL2GRwjzGw03HjYfxa?=
 =?us-ascii?Q?TUnvvOhbsiB4G76MDh6ER9t/EL10bP7hHbqu59x93h7+gT3QBUDQFkDCUlv8?=
 =?us-ascii?Q?lPtoSTET/wdaWULLtOFfTJDbsUkCGmKJf//6Gy6shSWm+YRO2vtes8zbKG3l?=
 =?us-ascii?Q?oX3ROX0SbkYD44t6nVPt8YT0g1Haa6MPLk8cZZ7a4G09b3oi9v9+4niB7s0F?=
 =?us-ascii?Q?M8YqjVMDkh0iinzX5294ZY/1xmrZIhiqsaK/geB08gmP72F60d/LIr/Ync+L?=
 =?us-ascii?Q?l1EqQI4kcE1TCW1fyca+/vbPLnxUuuhOjEH8EuSAmCL8EczaBroyJIVQOY3x?=
 =?us-ascii?Q?PcnIdpawvoRgaWJtx0kXtagmThY9fBeuncTYs9ucyH8d05UGUJEVieX6OQE2?=
 =?us-ascii?Q?4G/NwQLNlXSwCduDVqoTuRJGhgnSe4do3r+kDy/bMuMx3z6X0CXhS1F7IfJM?=
 =?us-ascii?Q?1clEqPPOV1h7LDqXM5lRp1Q7wngWfOWKpJrVwylq4JpHSBrKoHCD96Yxty+Z?=
 =?us-ascii?Q?iqP7hIvzbqU8EDrGPKw/nIpaRaSy7Y6JKF1/jjvgqZxJ34onEq6P+i5v5pDT?=
 =?us-ascii?Q?gT2aYfiMjXu8jYundm3k+JubEYI+Xab3JFxyjcd9rhqUrzJ+vzvC/vqrzXsW?=
 =?us-ascii?Q?0lDUQ0CHikB1naeC7XvxgVHEC+vaJfxe67tIXA++LLr+YjlorC+2vvAZM6Xe?=
 =?us-ascii?Q?gFWDSBsW/8k+Q7XthMVxmoriQzYWosLLjkt87fpXNVQ6B4+ldUnH7FbLc3zz?=
 =?us-ascii?Q?/rpJFsLeOPNwToROsl+7+Vj81MJEg5ngP5sRC05jURIFB4WmqXxjarG45GBV?=
 =?us-ascii?Q?y02RoZESZkL37HfC10hqxz+mbxKT1stFG/qSdaIP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e02b9b-ac37-4d60-f86e-08de1723c6cc
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:45:56.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: li9SoTd/l0V66FARrg3zljrebIKDBGtBqAu7L3TZXdS5pX1frW8yqenVKbfqB9FMy9XQbsGDFQM+rkqf1ajHsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11903

On Wed, Oct 29, 2025 at 08:28:46PM +0100, Stefano Radaelli wrote:
> Add device tree nodes for the WiFi and Bluetooth module mounted on the
> VAR-SOM-MX93. The module can be based on either the NXP IW612 or IW611
> chipset, depending on the configuration chosen by the customer.
>
> Regardless of the chipset used, WiFi communicates over SDIO and Bluetooth
> over UART.
>
> Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
> ---
>  .../boot/dts/freescale/imx93-var-som.dtsi     | 94 ++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
> index a5f09487d803..97198007b545 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
> @@ -12,7 +12,7 @@ /{
>  	model = "Variscite VAR-SOM-MX93 module";
>  	compatible = "variscite,var-som-mx93", "fsl,imx93";
>
> -	mmc_pwrseq: mmc-pwrseq {
> +	usdhc3_pwrseq: mmc-pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		post-power-on-delay-ms = <100>;
>  		power-off-delay-us = <10000>;
> @@ -70,6 +70,18 @@ led@1 {
>  	};
>  };
>
> +/* BT module */
> +&lpuart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpuart5>, <&pinctrl_bluetooth>;
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "nxp,88w8987-bt";
> +	};
> +};
> +
>  /* eMMC */
>  &usdhc1 {
>  	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> @@ -81,7 +93,27 @@ &usdhc1 {
>  	status = "okay";
>  };
>
> +/* WiFi */
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_usdhc3_wlan>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>, <&pinctrl_usdhc3_wlan>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>, <&pinctrl_usdhc3_wlan>;
> +	pinctrl-3 = <&pinctrl_usdhc3_sleep>, <&pinctrl_usdhc3_wlan>;
> +	bus-width = <4>;
> +	mmc-pwrseq = <&usdhc3_pwrseq>;
> +	non-removable;
> +	wakeup-source;
> +	status = "okay";
> +};
> +
>  &iomuxc {
> +	pinctrl_bluetooth: bluetoothgrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET2_MDIO__GPIO4_IO15                         0x51e
> +		>;
> +	};
> +
>  	pinctrl_eqos: eqosgrp {
>  		fsl,pins = <
>  			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
> @@ -108,6 +140,15 @@ MX93_PAD_UART2_TXD__GPIO1_IO07			0x51e
>  		>;
>  	};
>
> +	pinctrl_lpuart5: lpuart5grp {
> +		fsl,pins = <
> +			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX   0x31e
> +			MX93_PAD_DAP_TDI__LPUART5_RX            0x31e
> +			MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B   0x31e
> +			MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B  0x31e
> +		>;
> +	};
> +
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
>  			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
> @@ -123,4 +164,55 @@ MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
>  			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
>  		>;
>  	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX93_PAD_SD3_CLK__USDHC3_CLK                    0x1582 /* SDIO_B_CLK */
> +			MX93_PAD_SD3_CMD__USDHC3_CMD                    0x40001382 /* SDIO_B_CMD */
> +			MX93_PAD_SD3_DATA0__USDHC3_DATA0                0x40001382 /* SDIO_B_D0 */
> +			MX93_PAD_SD3_DATA1__USDHC3_DATA1                0x40001382 /* SDIO_B_D1 */
> +			MX93_PAD_SD3_DATA2__USDHC3_DATA2                0x40001382 /* SDIO_B_D2 */
> +			MX93_PAD_SD3_DATA3__USDHC3_DATA3                0x40001382 /* SDIO_B_D3 */
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD3_CLK__USDHC3_CLK                    0x158e /* SDIO_B_CLK */
> +			MX93_PAD_SD3_CMD__USDHC3_CMD                    0x4000138e /* SDIO_B_CMD */
> +			MX93_PAD_SD3_DATA0__USDHC3_DATA0                0x4000138e /* SDIO_B_D0 */
> +			MX93_PAD_SD3_DATA1__USDHC3_DATA1                0x4000138e /* SDIO_B_D1 */
> +			MX93_PAD_SD3_DATA2__USDHC3_DATA2                0x4000138e /* SDIO_B_D2 */
> +			MX93_PAD_SD3_DATA3__USDHC3_DATA3                0x4000138e /* SDIO_B_D3 */
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD3_CLK__USDHC3_CLK                    0x15fe /* SDIO_B_CLK */
> +			MX93_PAD_SD3_CMD__USDHC3_CMD                    0x400013fe /* SDIO_B_CMD */
> +			MX93_PAD_SD3_DATA0__USDHC3_DATA0                0x400013fe /* SDIO_B_D0 */
> +			MX93_PAD_SD3_DATA1__USDHC3_DATA1                0x400013fe /* SDIO_B_D1 */
> +			MX93_PAD_SD3_DATA2__USDHC3_DATA2                0x400013fe /* SDIO_B_D2 */
> +			MX93_PAD_SD3_DATA3__USDHC3_DATA3                0x400013fe /* SDIO_B_D3 */
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_sleep: usdhc3-sleepgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD3_CLK__GPIO3_IO20            0x400
> +			MX93_PAD_SD3_CMD__GPIO3_IO21            0x400
> +			MX93_PAD_SD3_DATA0__GPIO3_IO22          0x400
> +			MX93_PAD_SD3_DATA1__GPIO3_IO23          0x400
> +			MX93_PAD_SD3_DATA2__GPIO3_IO24          0x400
> +			MX93_PAD_SD3_DATA3__GPIO3_IO25          0x400

Can you align these number to one column with usdhc3-200mhzgrp? at least
it should be same at this patch.

Frank
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_wlan: usdhc3-wlangrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET2_MDC__GPIO4_IO14                  0x51e /* WIFI_REG_ON     */
> +			MX93_PAD_SD2_RESET_B__GPIO3_IO07                0x51e /* WIFI_PWR_EN     */
> +		>;
> +	};
>  };
> --
> 2.43.0
>

