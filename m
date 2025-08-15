Return-Path: <linux-kernel+bounces-771182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78A8B283E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B61AE02F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11883093B2;
	Fri, 15 Aug 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RxUHenhw"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E019DF8D;
	Fri, 15 Aug 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275729; cv=fail; b=pURvAXUAWXj9EhAheoWb+MzP1YqxBxZ2fB8zmO5Sw1/Rwvin3or4y4BQ44QNO7lc5FhdBYfvgqb4fyzRf2Z5IhA+QpPYo1j3cvg+Ft4yf3B7qyE40IAJvztSkWaOHnSj+7jC1xw+TythVkhEd1kZ9dLeIpQpclh+eiQC0Zma6Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275729; c=relaxed/simple;
	bh=0AK/LEg+gSLbA2Fg49sTp/ePx4B4Bm0q7ml7Mx2BBAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WlrwqmapXWnGpXEYMhb9Co1mZQYjLGcwSHOwvMDvyT0Zw6pzzYmqILpkvLcLiw7tSPxRlxr9NluS/wV34YbupRG2wQ7XsJxQQlWc/+S/pzv1L0tnVkZ+XPfWC1byTcoORqpSjXirrvAIGud5wuaD1dix+aJAhVw5Q+kO/xAiRpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RxUHenhw; arc=fail smtp.client-ip=40.107.159.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxXIXnyhK40jbe3cykBU8DVqS7HPtlni6YvAZMfH+eqzDPtx+I/QpYnvUgvG+VoJTkSUJzT1/kSRy9JcAnjPKKEoECcWQHZ95EpuGZRfX5ANCRahXQjwgjwI8LwXctu0HdBiuqFPdbOqqmvOJWJSHgo6b0G5zOch7qS6XAea0cmkrd6StlUwmbcQBXpQstim2HkhsJL0H0jhFQjWnqeiYF/bOKHPjKloIKT3jqGOoqakn6PMBibgHCRUbD8vumEYZPwhaVtHXOhMSnwgAzzcGrCKw9oaZCo4lADEhrsTFtnoFrH6LKyy9H0FdTJs3re/Lb5ouOaZj5GiLapjfxHJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xGhUYC5u/DptX32uZqGmLNHemrjMSJz4WRw8XeMIbs=;
 b=FWfRXw0KlPYoTxdke+ULlR5/1qIaGzHVM3OPBNPx9rxGZU1G85wSRyrDgU2GLLEGg0qGRlT5hypP6H//33AxAWMM1XqcJJOF7LYWYuFC2uZGQTLMeF2bCH4fsJO7E3I8dwzRuACTsqTboJIk0tVyUXutfukjn/D0X4UKha2QkzlopE92LuwtmoOJveCDGpkaKgjntF+MvldhOsxcHoyu/O4W/wgJKEDPBoCaOGzST0zwvM8cZDZ50bYebpfunZ8V3i7SEQpCR+fDgR68VTagFxvYsTFdKQs6oKg9ZDAUlY3UQybrnf+igVl6Buy8HSVG6ULidRtAjUPbHS0VCchwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xGhUYC5u/DptX32uZqGmLNHemrjMSJz4WRw8XeMIbs=;
 b=RxUHenhwlrEXG3qVdqmCrXStszjgvOM0+l5fe4vH0qSOqjJ7o1jZizy58QzhlGryKJTDsNtyTENpTHcRRR5bGwqgPPPyox87MiafsbBtYEZi5dBKSvsrgwSU/EjNuwov0Fn68DPWgR5MZzkk5OtQqYuvs6o7qqz+0bznIQSbvEGl1kbIVPoD2v1MGv864zBuQJz+pdJ+ZyfWl11XhPinEfMvxLOrvo22wChnyhcA1DL0lEh2w1RpLdKhUStqQpuXiKnFLMUU4ByU0gtzoFZrbX76UstKb24EjCI2PkmXBO3fV7RTQuAlSfx6IeE+dVsfdfLdq32tkPNo1njHFUrbmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10655.eurprd04.prod.outlook.com (2603:10a6:150:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 16:35:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:35:24 +0000
Date: Fri, 15 Aug 2025 12:35:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] arm64: dts: imx95: Add OCOTP node
Message-ID: <aJ9hxLM8BOd7USht@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-5-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-5-e609eb4e3105@nxp.com>
X-ClientProxiedBy: BYAPR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:40::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10655:EE_
X-MS-Office365-Filtering-Correlation-Id: d56470a8-817a-449e-5849-08dddc19bc35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?osJZzoN5ef8bI70tQsCZMXYNIH8RhKJ943k5Ja50PvbSIceJ4GWjIjbZKQsl?=
 =?us-ascii?Q?O0UjK0Mq4X5H/BKViSv+yIIZNi4z4PZrNhx86j0Ky/W/jT/rK1tHzoP2GdOm?=
 =?us-ascii?Q?bQENlDi/nfnYCTxjN4TgXWZqZfMXAEFVbV5z2iwY3YsnzklTf6UxAW5Ws11N?=
 =?us-ascii?Q?J+8yqf74LgEaliDqiZ3AzRehNtSMVzjHi74h8aF0U1lggLv7JFzhKl6sIUE6?=
 =?us-ascii?Q?sVbvqHzAB/17unk/AwbZQSaKyRdNV+gAqYUFZdnPlwOY+QQigYC7gkw86jk5?=
 =?us-ascii?Q?hBxnoSIbqM55KNCWPZsAuYuwuv8ci61a2TcWF84o+vilOC/y13kT7Yczl3l4?=
 =?us-ascii?Q?QJu/C1Rt609RDnj5bYTgEJgSAjGdBGq8frxhrRaFus8AChWVv7DjJJbB26Fe?=
 =?us-ascii?Q?joNyC5uhwhQD8so0BZVhy/CBK/o/Lz7orhhbvAq7RDBsOypGqzdYgF1rEggK?=
 =?us-ascii?Q?uha7AePpX06nhtpqI7xeLgbm+xwKWrm8Dh7+9p/LdINRKQ8zP0GJ9deC60Bi?=
 =?us-ascii?Q?dXJJqUskoqi0LSUm2ic8EQn0iHDfZFl8O2Sg1h8MElzuVxC7/AVf+GCXZwke?=
 =?us-ascii?Q?Px7leYt0FI1JPMyRAgeSnDYu59Isd3x0y/6o8NKyTY90KKdR0QG2iVAhh2Tg?=
 =?us-ascii?Q?ToJbYkkA04I9qIUX6zo2fJ/omnQ7ztRlmYJaLn1jiwHNQ/jWLl8frD0IyM6/?=
 =?us-ascii?Q?QTfG9xD2utJ64pSMDYonublNPRiFLXuCbKWBk2HqCJVXTVozITljtrVEIH12?=
 =?us-ascii?Q?xDvndw2iXnCAyzh/5vzOTGpxmUb/j2TO2vSG67gTWsjMekgajPRyr7MhiOPK?=
 =?us-ascii?Q?Zqnwjdwo4mB+0uL+bFAVqSJBQPiuTymQrqoS5waVlEu8qP32ZQkhsM4rrz1Q?=
 =?us-ascii?Q?MVm36zn9OeDxkzB4Ws4k5tvosP0hbu4e5yHE6zgeMrfQd0AqjcKgeEx1DDR0?=
 =?us-ascii?Q?t+2RxRGPinRVlB9AJh+9ZDGlGLxN06zyZFoh2PA2C4Ku4qA6uujEIhVnmHlD?=
 =?us-ascii?Q?w30bS8KgA9dJEJpPF6eY50+08WSy9t1JFoV7+uO4IhBoaSTwDOZ3ZISt9Lg0?=
 =?us-ascii?Q?Z6i1Ljt9jLU4lb9hzICEjKWX/27Z3P3Ssd0JinFtpyW/fqL1CNZ9JqU+sH71?=
 =?us-ascii?Q?ogV14wTviVvEZOg2nd39Ob9gyWZds+ST7FzFNqLSQbo3gUps/5fzu8G73UxY?=
 =?us-ascii?Q?vK3aI5wuc9/FdeI35Z8gz8+eig07z1ft9a1JwTPwNclGYPkQT69JV53iJmk0?=
 =?us-ascii?Q?bLWsUexFSY/g9SbltB9Qh9NTTnJzLBlT3NPY6N1Cdor3cR3DVjkZMYQ9y9HB?=
 =?us-ascii?Q?zkFgJwFGSV48lYK7gf+WS22FwgGO/pX3q7UYbjOgvpYIYLiPLQ7QgwjqpG1b?=
 =?us-ascii?Q?1q+G0B/dxTEIkcD4tidzVKHLQrEX1cpgLG6IcaQXBo7Y5XUIlSGadQyd4qtq?=
 =?us-ascii?Q?XeMaiHz24Y7LNe6wwUAIiXZp5QfwlVs8z9wVzNjkPVURRnWDJORoNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y1BA8IXvQLRYnQ0XmntwvIioxnMIXg7RYG3cOQN93LUQmz+iWeRfG3MKs2EZ?=
 =?us-ascii?Q?/pMAtaG82aTU5sWBnHjZt8/tZR11Vu7LKb4YwO2mfQp2TyWE/uX1G93vwtbj?=
 =?us-ascii?Q?QLuXkXKFCdaf8POGMiUBhSldeHpyj4aWvoFMZykA9OSW2DGC3ddlHONOXk6C?=
 =?us-ascii?Q?cLyjvP7p/8ZTzbA54hK2Posq4eMesvbbU1UFC1EGZkBo3cErWKE9t2tgkjLy?=
 =?us-ascii?Q?cFwyq2VFpI5NTgMgQKdMlaKCjWTgr59bWht6VKgHwcAxdXpipcQZOaXrxe6k?=
 =?us-ascii?Q?5ZLPZFaLq5i/qKOA99TosQtjeEjiC6PClqSJYG3HPac2VaxpxYIGKJ10vINb?=
 =?us-ascii?Q?LKOxvZZVFtkvNcn8L3HZvuvlFQThEO/3CDUTdlh73CkBOEEYvFDokcw2WES8?=
 =?us-ascii?Q?UX12/A5xXfscrxzZxFcZXneFUXBnUiD8gYy1NuqH3gz4+WrI0fFXbLLHZHDK?=
 =?us-ascii?Q?0RdYa0N6iZIQHBFU8KzI9pSVjci0spWPaRaCg66exAwEWYYub6z1Bca1Apyg?=
 =?us-ascii?Q?9sdL/PUNtBld11jw70tOWJFqXRsp0LJuENjQGIjZ91RCEHYb1UvWLM1goqxt?=
 =?us-ascii?Q?HHzxXmZq/2314yePRCvlQ0SYcyRIUpdD+Qxixn9a3KUdZDLzZkL4Ta78V76x?=
 =?us-ascii?Q?dkwVrwQiHbOFNVC+gTnoP/D+/PvTfJeple3MXELr3RLQXejdpDOUVHsE03gR?=
 =?us-ascii?Q?XR9A4WJB4mRQcUBkDNM29i/s5gMIXw/oa3vb5zttk6zxmJxlFrysIJ9pTK3S?=
 =?us-ascii?Q?+Zfc/qc7keu7rnWBbDeVvIx82vZqDGAxj6gnOedXj+g8JELmBWKpY9mWeRV9?=
 =?us-ascii?Q?21hYUwUCAHb/q5uF4HH9Nu5jdiSfiOc8GR3NmUJJjat30EqFk50o7YKWBC9Y?=
 =?us-ascii?Q?am/VdeQEJbFIsU4Tpp+av1hDOzwSWIqJF1fW+VZb4mW0EQrKn1iC6THFxr/7?=
 =?us-ascii?Q?/hrLulEFknvMEyAo2f3Kfp8B1MghWdH0DSdxd3WGA1mPtQDmD7oSxvJ7hv9E?=
 =?us-ascii?Q?FGHmZgsgQe2DKsC7NbWeVSWeKleoRJIEVlgNfu2FT/QLnjkVB1MJSCbHaYKc?=
 =?us-ascii?Q?7Zdu6gcYVz1eB4rRoG352bfI8fAnTrsgGh4814QXruUBTq4kcYYtElVu3vLY?=
 =?us-ascii?Q?VkSxvsquj3kbkgwXItM7nhp4ZjLb8Q+PH4ZBpPnxvDR0syObYlwdv5TV9kp5?=
 =?us-ascii?Q?lh3cXwXKb8VMYAoI67KUOPTj6q75p29cy+mpJj+Lg2UVjLD4FZmG+X22vq/v?=
 =?us-ascii?Q?T1H8p7XS4JhU0O3tAM93TAfPTseaWyLK65+aYOWHHuuEQZy63SwOdI1Zzu1p?=
 =?us-ascii?Q?4kI83kGLBWr4kQq+1AK76xDlPmrK3LU6m7TQRle/ybKHDOyB+nx3a8q8NM+q?=
 =?us-ascii?Q?MO78k2pMAkQN9ykBVlI3MooqUaFMzVblhb24Xvnzw9mFl3mC4w30PYbPfEMW?=
 =?us-ascii?Q?yvHgYxpJ/w8wkyiPrVLxtvjbvZJoYg2WVbGKuJmSSDJBgzxUdyOW/N+kP0Sw?=
 =?us-ascii?Q?nGSqYWiH7XK0pTWANpQpX8tAe7kw+3HsTyJNza+iVipjyF4dx7Y0kq7wJTXv?=
 =?us-ascii?Q?laJQXMFgXqA5EAfZPDCX5vWwm6DSckExFlHEXj0/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56470a8-817a-449e-5849-08dddc19bc35
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:35:24.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHs59uenqnA3OS03A68eDhCjMc0SjBA1J9srlk0K/JNkoT0JIeS3bAe4+9SHFDN/j5Df7+vuDmWQmRD9XUJtwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10655

On Fri, Aug 15, 2025 at 05:03:51PM +0800, Peng Fan wrote:
> Add OCOTP node to allow reading fuse using nvmem API
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx95.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 02c0422a7aa3877c8431c9b050d85f43f5ed7bde..adc63448aa15b148ca0eb8499ff5bc217fe8208e 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -1553,6 +1553,25 @@ gpio1: gpio@47400000 {
>  			status = "disabled";
>  		};
>
> +		ocotp: efuse@47510000 {
> +			compatible = "fsl,imx95-ocotp", "syscon";
> +			reg = <0x0 0x47510000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			eth_mac0: mac-address@0 {
> +				reg = <0x0514 0x6>;
> +			};
> +
> +			eth_mac1: mac-address@1 {
> +				reg = <0x1514 0x6>;
> +			};
> +
> +			eth_mac2: mac-address@2 {
> +				reg = <0x2514 0x6>;
> +			};
> +		};
> +
>  		elemu0: mailbox@47520000 {
>  			compatible = "fsl,imx95-mu-ele";
>  			reg = <0x0 0x47520000 0x0 0x10000>;
>
> --
> 2.37.1
>

