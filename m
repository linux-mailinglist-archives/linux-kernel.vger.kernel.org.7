Return-Path: <linux-kernel+bounces-771217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED21B28445
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DF417B415
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C29331814B;
	Fri, 15 Aug 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TEcNqJgX"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A723112C6;
	Fri, 15 Aug 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276391; cv=fail; b=q8trfH5OiqytrzghOYZeMnT0VY8l7b8erXDJOsxFJL1rNzTAopRkbPknhTXZts7s07hChbZn5qASEOSPpd2V5PuRRA3UEJM8wwaftaSdcNvETxA/NdgDK4cGdUHx0ehOBwIw0WGEANHjJwTN6F4fl1p+sRvYjqot3HrVubmUcTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276391; c=relaxed/simple;
	bh=DFnntiloImdAebURhLCqHaJaYcMA2L34d1ClsipNX3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L2LC6QwYX1Tt79cDAYyyBMu7jZFg+4EcD5IgwBujhAOOFUwOFJhe4A6A4UGrM83ScbuTrRQjbGro5MJf2GbNdndoubuLfYwGVa7G/6DW3Ks28GumiaaTZtTpH8O3f+2jUUWWHAtHeJQcKWzSwUrco8h2OrkdvEZBLQ0gvyV3Dso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TEcNqJgX; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDNccHJ9KzKpiihXLDKhaHNM+PN34M2EFgL/BFUFzAXRwCeL8Zv5tDmucLJa/VndvNNPel7ZaMeqAv5g69yeW59LI4ZfUXp2ZnczPgt+2JiOZJfYnclCINw4lF1YJoyI7YWF7vj6vSgLl3p+UYdD4L4dAk+kFX1oH0AydLInrT3iO/gxJgqdrSyKjj6drwBJ+UBr38/jOD8mO0/S1TgmNtgIMMZxwvhPqCVRoLBD+OtIEelcVbIpmBWUvAez+c6EBmerayzhkx63sBag6UNod7BX5EbjgBZcAOitPCMUbwpkVspjp3zO0p9M+VA3UrrZWyVYkLwcWk+ZUwx3VEG9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8WZMWdfjlB2A2BPGoQn01Pgg5POSyW/k9VHOloxn5I=;
 b=tPs9VgQQfbNdD1hj1X8x69+RVdjCJFJNRB7ETn5aFNWgPN59heVj/W6A7ZAQTL7R4ri/awlbWe338EyO3y5bQEyO6d/qn4wYLLbaTAPDJjrpTk4bSMivUofL6LFvDIcc5lj0KKq0MC8Sev/3cLgM2aUG8vzd/y5t05no3tLKxmzIvPe77rkuMhR4cp7YnCFru1+k6r7EfjnDbelcVekWeSwBY9tKz00Fcvr0HdpNr7RJeem5ETaZVN64zBSije+R+8GB2noiRRf8kZ35h+8UNyeF/OeknW7PiqTtSlgswdznIded2iOayjbZYcMCLQvb/btplBfnyCqk0IVaAKRKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8WZMWdfjlB2A2BPGoQn01Pgg5POSyW/k9VHOloxn5I=;
 b=TEcNqJgXdRh+iLWK/8XPOdhGmk8YRbDM7/43TxsetIw6l6l8d/HJXVMICWuDIJ18BtI7gpEzZDMt9WYHHaStK+xIz3NWe8rZa2Q5ImZBoSrPDpGAXRxeoRNWOlR5OuIbWvxifhm2sIGmL5BSxSQjcSsC6592JGK/qvFsQi1kN0Y1DTGbV4h8LJKxKF6wR98qWxDP+gOSpSy3HFYMFThg5JC0laytX/0vxjGePmZoZYJxigaenUSuHNHGNXNMi9uHQlWIXcP/cMKi/pJn4IVrMHJ+HriL9ioebqZsQ3UXYuKRBmQFvx6M5n8IrsdbyqdwRDdVwvTRqjbMsXLM0wE4Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 16:46:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:46:27 +0000
Date: Fri, 15 Aug 2025 12:46:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] arm64: dts: imx95-19x19-evk: Add spidev0
Message-ID: <aJ9kW6SePooeCLIz@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-12-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-12-e609eb4e3105@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6fd8cb-00e9-4b78-0351-08dddc1b46d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3P1ZeLJ+fW0Jx4Hmpl+iTF2VuMglULmyHZ4FrOi+JKEDACkTerFKL3bj8eIO?=
 =?us-ascii?Q?rsSD0gLJ7YRMCzXffkbunUjzW9B8+fR9ymBtizM6Y3u1wacjKESlXD8WGJwR?=
 =?us-ascii?Q?wpn/HpTU/lIu5qhBqz6XZUIIfOUYPSW2IWRtRGog/2qH/Sd+ebMd16nTInxI?=
 =?us-ascii?Q?7J73ZVQBZ0gd+wZpDWapfWTnLm5YWNmX7rVc9RFMHSQPhwfZo7gjMcGWEtXG?=
 =?us-ascii?Q?ZpVSuhguZ+Mq+ruTIpaB1gSjYgLxastkt37IngDFTJ8RGJdVtbS8hC6dATee?=
 =?us-ascii?Q?zB43I44kujgkIH4RFH4yzdCV/p6Gn47wdhUv3wYfealrs2o4o3KejLzx3NdW?=
 =?us-ascii?Q?ns3Mikrt6ukQTD7xQySq+Lpqj7ucMykS+/2XWGoo5DrEhIQ+so5gAi4yRCQU?=
 =?us-ascii?Q?9fvJk757YM+oFft95wXvXT7PPJOStSxEBbgRPxOmtoIdrZbaoi/M7Upg6Fpm?=
 =?us-ascii?Q?0JUF0urZ5alaDbKk0j5mGuLex5CrUEG579Uu1OwlnbFRKuhYop/60E6bK1/4?=
 =?us-ascii?Q?bhTrup9lj70OzJz/8I78PkzPJ1AJOrUaemrJOrhn75Z3lhZPbSo1iIOtT6th?=
 =?us-ascii?Q?wG58yJm5RKUHz9w25URGPwU3Ig6Gyr5khp2UlmIssMSrDQ/laNp7JkqxtU0p?=
 =?us-ascii?Q?g9SDBl4bN1tVixKPhGhIQunCia1/r1lRZTXStD6OwkU7Xd1QStyIPt5LGRuz?=
 =?us-ascii?Q?NnHXNVhWkes629MvE5+dD+DmUBcRUVSmxABwrfP1JSLQ/I+olX+vOnGwl1Tg?=
 =?us-ascii?Q?cq+jLV/8KD26BSka/tEotKC1yX1TWI5ldiQeczJMx04efAxDKX7MRUqFJwIC?=
 =?us-ascii?Q?WM4wEY5V8R2XkPjMBYamzZD+L/myeMxRLzC1MUcacpa+gxwx3spLWBdzOvtV?=
 =?us-ascii?Q?kXlKAvzskLALBvA5Dk/HM+hBhb+kYC+EVLl4+xRCO17Rqw7s6fV6o0RchUZ+?=
 =?us-ascii?Q?7BerRG5N5waZLQyvMY+KwmLsGn0uISVWMT0no7njV46PR3NK0cqpQoQqvtK/?=
 =?us-ascii?Q?FGy2MNFn3dpL4SugjQQnV0giTIsl/u/02eJIlM/s87GytLsqUkYnHvvVT6pu?=
 =?us-ascii?Q?uFInkfjnkTDCqzYBfYIfzI8I5q+ZT/WHWnCIHIlz7+VexIgWVZNMnxohi9HP?=
 =?us-ascii?Q?E00vlXrjl9LlU8dTgj4nvvrrlOFAajAqBvQwvOmbh+ieGmw7inBx8MekVbLD?=
 =?us-ascii?Q?FnNOAfinQm1jY2gwFdPetiI29fRppQeInMAPrdj5xxVE/yJrM76RTEVMsOpK?=
 =?us-ascii?Q?iGvyuCL3qhM58o2HcgZzCnyXz8Zzs5m8WXNpDE6tgFgjRik5c+c885vrHpGT?=
 =?us-ascii?Q?tGZFJcze8Oi4dmIJWiBbueE2/ZjgoypR5rHMsGpDQEFhVzR2Szg1s0iILXcu?=
 =?us-ascii?Q?pPlkwsXY+qPGkNQuYMRi7lKGq03a2je6HO+xT266qurnDKG0FZfFJQMM8xGv?=
 =?us-ascii?Q?AGJLXipEiD7c/TYJSqUREcpX5dkBYdiocbR65l35ZUX4/T5edDDWy1iC0yxV?=
 =?us-ascii?Q?vbPaynf00KQqJpI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vgyDL6jOB++9qIO5LrKXgsgfKccG547yvB+UjP9eBUr5nkmX9DM1vXfwAqUm?=
 =?us-ascii?Q?iqkvqVURGfvWRSWsBbmIBqLDI8B8eroTlYTKsYbDtPtkDOqmXsjvXKxe/G9O?=
 =?us-ascii?Q?WkyjvsUa8/ZfhgZiFvLtny5d3BRDoO/jRaWZJM340BduyHGl14biOFdC5hwL?=
 =?us-ascii?Q?CYBh9Hax7rTbGenN3ZfTdilasF50UuGofVwWzMlGPcjk2jdaT5zHeAogMdz9?=
 =?us-ascii?Q?hGijLVG5/f2ZRoiQsrniZDh3KeNmdtFi0D42bnEGCjVPAdghKtdj33sKl9RA?=
 =?us-ascii?Q?g/M807usce281SYXxpihC9RPAtuZTYp28RQZr+SL4Teo6MTxNDhYUJVA/hZh?=
 =?us-ascii?Q?mQgRpbpd1ODWrBau5JagM3Yx5CldmVupLldIv/CtN1KGQRj6TJi03gN1uUIc?=
 =?us-ascii?Q?K3WSe+as7t7i7B1H5GHf/Mpx5UPQMlD5jGz/tthaN7l9jYO60+665/j03hBx?=
 =?us-ascii?Q?w+ByTzLM7xPb7P6vCB5XFXjtpxqIyY3n0xyVNA5aofvckYMtZOnu+qKp5ITh?=
 =?us-ascii?Q?BWpCZ3eWUWXntXcaQ7AcDfgyVm+IloZrD/TAtutnW2sulLyoclL4CIJWxbwF?=
 =?us-ascii?Q?MqRglkF5h7CtL42VORJ/ikJFV8lWrn1uZoELiifF11ZcwG2N34EeXFeMwaLf?=
 =?us-ascii?Q?q9NPj85923+9tf8Hy504sFkV8hEdN5IH5Tr+rWBl93jZRjXr4ET2zFalolD+?=
 =?us-ascii?Q?jxtRDdLcoTf4YxfdduwSVR/4c+hDELYag1SJZDSBwfIs8q/FnmmKjDWSS4Li?=
 =?us-ascii?Q?5QuPmvDPbhv9n02bX6wwGbhuRfrpMxHg9lV4j31AhUqKUYkdttqVM5ItNDr8?=
 =?us-ascii?Q?j/2AAuMnxoVJNo/EF0pTDq39JxM0cY8RXNSREz1zge8LlRme/czLI5k6K9Vp?=
 =?us-ascii?Q?X6tjrqV+emMB+/UCvKQ+l9XjaCeDqOQxPlwt3SGAWR81sfFLVYPO4aWHrCc4?=
 =?us-ascii?Q?2bG6xcAghMgBm3D8Xb1MSJwWvH6w1z/F7s0PHKePkPGLl9TiENuGItgqvT0H?=
 =?us-ascii?Q?FQhuOfbNS4+WdbjzNkpPb1vsT9Od9/yR06tR1YXdpVb6T+/8Ds5aVdXA2U3X?=
 =?us-ascii?Q?TyfVHIskS76TOzoWUCFvFplC0DG1GQ1xtCDne12EKK1mhgUbmvOcbQYaJheg?=
 =?us-ascii?Q?VP0KgBMhwQ4xuXrymp1EBA0kfBhMKorkIuyXH20GiY9npM2YuGX0Vj775n6E?=
 =?us-ascii?Q?Cp5+Ft0vwJQe9PtaxV+la31nCI4pRojMl48NOq2hpuM+fucYdzp+v0XWR8kY?=
 =?us-ascii?Q?TIVbroaSumuqxJsuCh9xkqzNKq0MDW8649qyEtd/DAbXsWvUyg3HdeUK1+It?=
 =?us-ascii?Q?KenCp1wwFFacZ0oOkmtmz6nKanmYcD1eBBYnLPurn/GSm3OEyyAKUy+brEZF?=
 =?us-ascii?Q?OruqaUCb1KGrF4kRA6epurOFmiIrVxSLT3AheVRbypJ6kRYXz0KGLcHB4C/H?=
 =?us-ascii?Q?6uhBmAVTksayiZ8REAYF9fRRDMYg7VWof2o4E+AxCYIjwEls+oo7fiyODqvY?=
 =?us-ascii?Q?mSPvlxRrH7jGNWH9f9t2B0C6gaHGdDLDH+3cHhWdsbyEMMCnthA/rMhGSRhS?=
 =?us-ascii?Q?a4p/tFa9Ba1ShGX2qlgldkeaklTy0BrCoNFMY7aL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6fd8cb-00e9-4b78-0351-08dddc1b46d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:46:26.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UC5iNgEomv5P6mssCGHWSQAlM9tgqT6QOhWOIcnQ59S4/RhXDLYf7KooZQHGr2j96ob2kyLDufU+WWaobIBKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7051

On Fri, Aug 15, 2025 at 05:03:58PM +0800, Peng Fan wrote:
> Add "lwn,bk4-spi" compatible spidev node under lpspi7.

Previous NAK by Krzysztof Kozlowski

https://lore.kernel.org/imx/7d4ec7c9-c95a-4e7e-9750-f6310ecb59fc@kernel.org/

our board have not SPI which attached to big lwn,bk4-spi boards.

Frank

>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index 0ad5707314fb225b74d8940908b53dc2a444ed5d..193fc2cc9ac92bc3f0ff0e14ce0b1f84e91516c5 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -507,6 +507,12 @@ &lpspi7 {
>  	pinctrl-0 = <&pinctrl_lpspi7>;
>  	cs-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
>  	status = "okay";
> +
> +	spidev0: spi@0 {
> +		compatible = "lwn,bk4-spi";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +	};
>  };
>
>  &micfil {
>
> --
> 2.37.1
>

