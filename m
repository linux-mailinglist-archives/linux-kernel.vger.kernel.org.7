Return-Path: <linux-kernel+bounces-776112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63624B2C8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1785E5B67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F50286D5C;
	Tue, 19 Aug 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Si0+e+cT"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4726E707;
	Tue, 19 Aug 2025 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618630; cv=fail; b=N+zpVFVHrrs8fCBdkEDsrRb9DCNMbIUahJ/MmJwyL5EqxPauKqxfPMBreRBjOr+du18hEhp1yLjy1MtUj6I3eoxPozil51MIOdbgP8NPiUOvHrZrjJ8SPjE6z29zvp5UIaSn0ggpzFVsZKf2Lm7lLTsskkbTJK7XeSJuR/TCIzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618630; c=relaxed/simple;
	bh=Mn/roBORrUgfm33xCn4qg8pVd70uoxfebN8//soPXTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RH5DV+Ar94MiXn2mKjBN2DM3zmyHpRjW63EG7ZVarYHIDgGkAOTRyGxGcIE6Eo42KQyBJeYKMhrJAV9ntZcIMb5k5MPyUxj1PnyhSp/vXAYFVjrBIW0V7LkRW0BK8e4Hv5rtUFcy4umjwOarFBY+SnSt1WrBd/jvh4wgOr75m2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Si0+e+cT; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyG4ZAMFjCJSk55VvFngRqisbgpZ3g8QHHilH3z7vKm8ofZg4POxyCYXQHXO/BGqSzY7Biet42SxPDAr3OBnkAoqUwGsd5akHxSzYXvEqpm3CyuxiBo/76xS/xyvhGHlsL2hsOeFcs4iTjzku282SPgIWJUyzwdxRP6/EotX4CRuD0LQGyNg7j5H5bEvgEDI0+kt5qOg2ZXhdSwHHf1dLNnAiXfdV3PsUxwQznuI94CYvwGQL3ZG73w6cqLtf2npVX7fvo/LhZxo6ucIMWXKEG24LK+3v2U/6R6PBwX4CF4GScpxezLkvgu3KAeRmC2qtz/b3VlI43btAbK1cZulew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQz98ARWz39MAHvpD6GXoyQImXGNx1AH6IJWaX7Lka0=;
 b=Xbing3ziIcMMVC6l6xVKFgBaNz4HHhEHUCUmkQWhdsmmWdHfTk6RlN7l0ccSD3nzycjhJrWrjPgzM4oa2iUjcCswKXnH08gdN7B9gNVAzJs5y/2tG6O8UVxLXs8/SHnitBY3SnSwedINo7aVYwsMUwHNZjnRIIyVGoL5sYPZcUH3RmBafRhTvBMMBdxKy3Vqmi7jD2fF9UdHdZSH3F03DpEK7197Xt0UAAGbi7IwznZV6ENSkF4r+n/JhpL+QML77716KAM0w4WvyvL/kccPGK/T9VQRTX9Lv1C9uUB9nYZyB9oSZ6iQzXeZldTCGCBvN3qWyxWzbDql1MxelW22FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQz98ARWz39MAHvpD6GXoyQImXGNx1AH6IJWaX7Lka0=;
 b=Si0+e+cT2txpBI5M1lXImscQeolMSUogXcsQqMsFUOBpK6B06ZIsVEi5BhRKtbO4tZwSdfuf0XaMmuyJmsHMEsuyDc0muT3Y8CaxO8DSOyegUM7Ns4/r5Syzk9CaQUIf6erZX65u3IYBOh0AzKaShC8hyxp1LHBOHy+fZN0uOaNU80FHw6rh5X1/hl+qIHD4kHyVuV1LorsjWD42N/ooixWmF4UEKWvg3Va9tV16CD+0eaaBJxuzHdw+4XTqzuQ6g9YJqaZKT2f6xUtaP+qyaCmGaeb5zq51QNPLim9NuIOLjYNOhqd5uGVTsmDNhkBpsIqmcmspJcpCz6ZfKytuyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 15:50:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 15:50:25 +0000
Date: Tue, 19 Aug 2025 11:50:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx95-19x19-evk: correct the phy setting for
 flexcan1/2
Message-ID: <aKSdOeeS04waVwTg@lizhi-Precision-Tower-5810>
References: <20250819-can-dts-fix-v1-1-e43e7d98a544@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-can-dts-fix-v1-1-e43e7d98a544@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0ce2b0-dfea-4198-1249-08dddf381d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Dq03VeiPlw4hUp3bhiaqc7vVq3RZaWgkxnLNLZM8YP8gFMruUVVSZmKv7jt?=
 =?us-ascii?Q?m6fH4mmPt7dh7eRouDO0UbwVRvo39zqhBHLnbSRinKPGnkOW2ipJH5XDVGRi?=
 =?us-ascii?Q?qym5GJ3yVQA0TkrOCS48gU34fZRLjjO5kinGlrbHnLowvEceHK4gWfRXAD2j?=
 =?us-ascii?Q?bNejCHv2r5k9+MvFu5rSas2Sdop5zM8oed5pYa4wT/913KGYOaU9MTGZda1g?=
 =?us-ascii?Q?VuZ6zwXiTxKGyMOa2KskgqkdR2ER+WeCitHjjaW0hGsrntbcWbhsm91QeNSb?=
 =?us-ascii?Q?NEWyR0gDRoY0aD+WOeEmYL7qzPWNdhX2qezWlfNFyzXCp3yuovJCsZ1j3OUw?=
 =?us-ascii?Q?/B0H3rACMTENcO4/o654ihAc2xSg+zEyvAl6fJABm+awD9PzUekNuIc/jQmJ?=
 =?us-ascii?Q?2YJ8zSXKoTEx5No+ZuUDLCZnSzl6C9sbhRwKCHJOA/35A4LnKWb1j+3t5Gs7?=
 =?us-ascii?Q?mA92JF0HQrxkGrkOsYMqorlz6HOIdjrYbfjTsCGFKtzrvduByKL+kBdIYWGA?=
 =?us-ascii?Q?0t/z2O/vpuBVtcbWHljYAtySj0xvT26s1zTjxBqWmAjZ24m6bgOFI4MUzjz8?=
 =?us-ascii?Q?uYRnetxSKRtUvDmsZ4rXerf83KHDGs1OWviHB4a1u3cPwg+elbm0iDjttZA5?=
 =?us-ascii?Q?OPfoi9EPHOFERwiS/+MICltAQBr9Q5LbxbYzxgrGd2SZb7C/gh1lVkwvenrH?=
 =?us-ascii?Q?7coPv547zJRkspF4zIxkJwgOJmFRzjSrZqzWidennoolgVe5h2cOo5LU+0DJ?=
 =?us-ascii?Q?Dm4nDCgGhhT12mJo7/y8tQPnuIyfuUEwW+kRDUWc3b56cayS29uLnA8f4XSI?=
 =?us-ascii?Q?TJDsmkUGrLE+zuRRJhrpw7c5mh1bflBSF4xM5ZTdC6DJ8KGyW4sHzqg9uM3R?=
 =?us-ascii?Q?YljQnm5p4RKYmA9hyxleIvZvHbQHLZs3wliCdWYnJBpcOj/hJ4nasD8Jp4VI?=
 =?us-ascii?Q?l2Ni0Cp2P9WK6ZoqIoKplbIVvc9i3Rhmczhl9zJwcxJVvOf7Bi2fOBaltwpa?=
 =?us-ascii?Q?d+Zv8IiBK0UNxVF2Z7622V8+Py8AXWmJdaAa2O1B56iwcGbUhMXHaS5zyXyX?=
 =?us-ascii?Q?fp+QZXixjchfXjxnCJ1c91FJlmbsVKFrQSwM5vxgDRzwE5RjOW+ez6Rf1qYB?=
 =?us-ascii?Q?CGczlmz0namKgQjQikvoT0Yc0iSMMp3+psVGQOLtdeLxDs5T/Z/HSqWtZf28?=
 =?us-ascii?Q?39BWiRIlpAQncWKDH7t1YSjSSXpGH0h98cDZNKluInMAUvIn0jJpiGaC4wUX?=
 =?us-ascii?Q?NsLTboKl0uTGwT2onQSlj0UuCU6fkhUQNo7xhMRilho54WrCLNoKdPUMgXab?=
 =?us-ascii?Q?ucu+jqnfZJugGW7FdPhD6zjC7yHd46pOwEx/UcAv3L4zdSsDcPkNn/yfoAb5?=
 =?us-ascii?Q?Gz3vsbUb1YIp8HkrH/wKSI/eFbSRsO5Wrex1xWVOwwxguE3gcP8sqaE0zIou?=
 =?us-ascii?Q?+OC33SETOg7TGtIUUtX6kXHmMqHw5Nvl90BRDAHzoydDTWlX1pz4ttrrEWG5?=
 =?us-ascii?Q?JPShSaue2UDRLbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r8VCHLum4JML2XGsWVzJexHKWlOgprW0qhgehLXeO05f/kuMrDxas3x/qKJl?=
 =?us-ascii?Q?cFRali36o/9jEFmOWkwvj7yB6uyzwldLBKUZg+JdVajx8tdXzis6822Eyv8v?=
 =?us-ascii?Q?zW2xyCbSWgFQ5R33XY+6FniifrpuxwfLRnmAphohlMUK+Gyj8HxZiHs0y94o?=
 =?us-ascii?Q?4C1I/vf7omWMDUvkEsAueuwKeqyo4p6R7RoYeje/WP9xKxtc3+/9MvY4AfS1?=
 =?us-ascii?Q?k8gKTORWUxg7ulrMOZ/k4WvpO66qDOEEvXpBdONWXBwIlbywTM/bOJmuIeus?=
 =?us-ascii?Q?72j6dvmEEFZmth+dIfo0QmaDNrHDpqaVjcpL3foIy/949RRQmSI7LWvPixZD?=
 =?us-ascii?Q?gK7ypvQWlPXA9bWzuyA9cF3oXkypd8t4sToPVYjonbYnz4sDUiPzW5e70Idu?=
 =?us-ascii?Q?DanhkZYe5jZC0EKS9YlWwMy4nehbWRV7e7hxTMz7jK5xUV2+OEb8j4M77ipL?=
 =?us-ascii?Q?liEaV08ArxAWt03ZJqggfQjHEhOayxOmFqyHmD0VmxZIi9BKjSJErZCy2AtD?=
 =?us-ascii?Q?TG8QaUsYhootpu0i8bm0idsb4OLrpYRcNwI6p0+YwqGDf+ixuuHkjflUdlgT?=
 =?us-ascii?Q?rs+A2CFAVbqJsj3d9tBlCZE2m9tIGgaSFAp1mZg+TknN57+TedJHZAPcwlRl?=
 =?us-ascii?Q?ueZ5+PsrEIbZZ36Nnt8T9g2pHBHkodY7v4aOOkM7ApScqR7Z4nrfEH6EJTMn?=
 =?us-ascii?Q?qy3urmOip+s8K7vdUSPzoQ9tncHe5jqGEvqo5xQW5A+FNjFLqvKX8iy+ZB9q?=
 =?us-ascii?Q?1P4jn5COXFkuEuxerZ3HurjMkBFnRGvy8vgwMrAKt9FFDl/4NxjY7a0CyIAO?=
 =?us-ascii?Q?J6nZbTz77UDDg83EswNK98NASxgZVk7chMZeBuQu3HvklYtcXvLfagW+N54V?=
 =?us-ascii?Q?HNjBwa2ggFFJhDTLUknDKk5fMgZttIbKDm2oKlXovFarJef7LomUP1EQd7IN?=
 =?us-ascii?Q?tKauAjtNTCdeIdNG8EToasBVnJ+9ZbbrIpdhiXmJ9g/MAsF/eBHhJaPbtJ+6?=
 =?us-ascii?Q?AIeBRCg+p1Q9UoE6mjkK1BEEhM6/qyal69kzJQyG4K1o5nwfuJ+y/f6fIQcA?=
 =?us-ascii?Q?EAZTXS/7eAC1e/BWP5DwoIVU7LkgAgRwc7nWU/y6Zk785XFZjjzigTKCAqVS?=
 =?us-ascii?Q?DW8ktA9TjwGM+QIdi6ak4CYSxSeRRVS2fA8K/mnOHqjuEH1ISnwsb7JRD10S?=
 =?us-ascii?Q?HumrW1IM7mKR8bSMFHi0zl/Dc1881VCaMMAgnH6VJCnmObCt4qiAmr9WozIl?=
 =?us-ascii?Q?0lN0UILLlImXniijWnbkrkwegRIGSBR9r7PpzvRd8+9ZeedDBD1C1TSAn8y+?=
 =?us-ascii?Q?ljxYeoT6HU8QeSpo1IF6vRuMj9ZtphAzsNegD+IpSTN6XVZLImnspVNQwJaK?=
 =?us-ascii?Q?/oMDzu2SBkdw/2LSn1hbE29ug1eSStfpuaWFLJLh1bYi8Gz4wwrr4EZ+eh8P?=
 =?us-ascii?Q?4xF3BlZRJrKv5c6rINa8mWqMe7CeDj01MABJttWCRflxqffw+vghVbYZDHuW?=
 =?us-ascii?Q?NS1Iu5gzjaWDfmU9skaCcq+8Gd4615inplcyupVYGZ08tJ3LeH4+uyzULnT9?=
 =?us-ascii?Q?9v5x01uQwtnzrWlcqHY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0ce2b0-dfea-4198-1249-08dddf381d2c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:50:25.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8v77ktTkCxYOFdlElBwjJy5pMNIFsKM0tOAF37N3WIE8j1mLeDSvGU1a3fk85jBQNohsWb+6Q1oLF56alJg+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825

On Tue, Aug 19, 2025 at 10:43:37AM +0800, Haibo Chen wrote:
> 1, the phy support up to 8Mbit/s databitrate for CAN FD.
>    refer to product data sheet:
>      https://www.nxp.com/docs/en/data-sheet/TJA1463.pdf
> 2, the standby pin of the phy is ACTIVE_LOW.
> 3, the phy of flexcan2 connect the standby/en pin to PCAL6408 on i2c4 bus.
>
> Fixes: 02b7adb791e1 ("arm64: dts: imx95-19x19-evk: add adc0 flexcan[1,2] i2c[2,3] uart5 spi3 and tpm3")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index 2f949a0d48d2d8066388884703c3b3cd678f16e1..9d034275c847606919af8ee4a80a00599abf4d8b 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -80,17 +80,17 @@ linux_cma: linux,cma {
>  	flexcan1_phy: can-phy0 {
>  		compatible = "nxp,tjr1443";
>  		#phy-cells = <0>;
> -		max-bitrate = <1000000>;
> +		max-bitrate = <8000000>;
>  		enable-gpios = <&i2c6_pcal6416 6 GPIO_ACTIVE_HIGH>;
> -		standby-gpios = <&i2c6_pcal6416 5 GPIO_ACTIVE_HIGH>;
> +		standby-gpios = <&i2c6_pcal6416 5 GPIO_ACTIVE_LOW>;

It use go though CAN phy.

Frank
>  	};
>
>  	flexcan2_phy: can-phy1 {
>  		compatible = "nxp,tjr1443";
>  		#phy-cells = <0>;
> -		max-bitrate = <1000000>;
> -		enable-gpios = <&i2c6_pcal6416 4 GPIO_ACTIVE_HIGH>;
> -		standby-gpios = <&i2c6_pcal6416 3 GPIO_ACTIVE_HIGH>;
> +		max-bitrate = <8000000>;
> +		enable-gpios = <&i2c4_gpio_expander_21 4 GPIO_ACTIVE_HIGH>;
> +		standby-gpios = <&i2c4_gpio_expander_21 3 GPIO_ACTIVE_LOW>;
>  	};
>
>  	reg_vref_1v8: regulator-1p8v {
>
> ---
> base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
> change-id: 20250819-can-dts-fix-62ac1d02c007
>
> Best regards,
> --
> Haibo Chen <haibo.chen@nxp.com>
>

