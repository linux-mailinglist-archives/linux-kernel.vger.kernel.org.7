Return-Path: <linux-kernel+bounces-843079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD12BBE5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEAB34EEEBA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBAE2D5C6E;
	Mon,  6 Oct 2025 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oNB3mnTX"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABC82D480F;
	Mon,  6 Oct 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761501; cv=fail; b=klk+CmtSaFKel0EVKY/Xq1EH3OpQTlZBY5vBlj3GyBNvSqjVnrKAmiitejdvmolb8TqbSiDoIp1NpMzC5PRpHnAhLkvvViDqb6HWvdqY/3DbcsP+zOErIo6S1fEiSpKuuKq8L7PrLkilNyHIdWEZUDvAJvAwOK6AbvTWig69YeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761501; c=relaxed/simple;
	bh=JLeSHQCP+ZUnstzoBJBNbrHjKJgn7+K+oQ5YkkaR/ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nF1kl7CyESFDUB/L1mZIShX/KvJAS/MWGoHfzM3VRiZu3IVncmgX3m7eWl/GH4VBxcnl4yWdnebxIsvRvqYZ8Mu7kCismP2gL98maWCZgPcT/zdixEJgrAhQ6LspjpSfnbnvUn3qhTqQkiVeVKVzYrpQRIYDLvCbMeiQqjJbmQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oNB3mnTX; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9cBWI75ejPpTDplEo/a8ufnVm5aI2CBSHVqkLYtV772rxXqaFcmpypllAKgGUuRK7oZDVBcRtSuP6BslvtwjdzIxj5tEuNA+PH0tHtQGPyVSnJ25gyvfmDnKW7xAsIr99JidctZSkw8pJu41DA9j6lvw4IKgbLYrxm3XcUVcem8mzBi0PvTi4oHRf72DvOIPH6pqXU0/9m8G3VcV6xSMw3Cd1BBsroyQMyUxRPp9bft4ZElV79x70a3JvDokRjQJDX9diUqyKBXqok3TlAwHJO2123Xkal7023+Lo1eSgJYiDSEH2WHuq7OF2uBnNghnPXgtf6JT0DXoUArMwECXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueF3YR/BGuDlSXldtbE6qqPf9DIpXetlVuV8iOPdaIs=;
 b=jHsRxmgJ+Bcw+QlUtOWzcQEf8ydrfU2cxuMRG3SBfpLXOJ5Gef/NWEazrH/Nj5pdJ/+GA5JL+yXYj9+jApVJ8UomnJVXF/vIou9F4GaxFwuZoozAVGCBnHVGqja5HqJ29gsL98cAxvB4ujWg0bknhwjTrEymjsEyPG5eEVW9OeYvof93xW4U0IJAivwsZAUy8huXxMJy4Y8GBd6+qUfF3VByQ1mwt6Q2dHJLwOzaZQ/y62FpMQ7dqYozB0JtAmYZIWleGID2xUgj58cgla3ebS24kB74j/gvGXtJtk+I87MqI9sbHi5oYy6mPLlB0LlGtl/NYT4DvU3JtskFAes9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueF3YR/BGuDlSXldtbE6qqPf9DIpXetlVuV8iOPdaIs=;
 b=oNB3mnTXHIQrU5iyNY8izt/KwZxS1iMxumBgT0GhRnplqXQt+63W1SkZuHHJq2ZxQ+lUhcH4RJW1ZFew13B60TcpdZY3zd/mkyehGDs4nzzM65AP0VORL1ct9KF+IbQMDLTJGlla7AN1HdHhCCaBdt4dMDxuC+DcsOCU0AdTeA31u+x4toWuNOwAs3hmK+GNG68il3MAvCyumr733zVuRZc8JvWvzNpIqf3IiWVe6w7vPofci0e5MdPLambD1OUIQmDKueGb+trnHPgoZRjs38rSDK5JFp2jVkCoyYuzn8AZTuOwtsdhSrzmWsZfQMpDi9GE4wjs22Kf/kXT2Od8vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10495.eurprd04.prod.outlook.com (2603:10a6:800:235::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:38:10 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9182.015; Mon, 6 Oct 2025
 14:38:09 +0000
Date: Mon, 6 Oct 2025 10:37:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: alexandre.belloni@bootlin.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6q-evi: fix rtc compatible
Message-ID: <aOPUR8UAVND5SDNy@lizhi-Precision-Tower-5810>
References: <20251005215146.3804629-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005215146.3804629-1-alexandre.belloni@bootlin.com>
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10495:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b10d957-41bf-4b46-18e5-08de04e5f873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VYYEl+aWb8vJSGoTS7m9ajeArG7wlE43NxgYE4RuGhQzrQ/nRtj9xm7Ctdqr?=
 =?us-ascii?Q?HgUc72epWojDW5j5HYpPqa0+MoKk/ituhtQLgRuz/fpOscfbTut4jdIxASB7?=
 =?us-ascii?Q?1W6vJbeO6CASLD0AGdDlehify5Gtj3M5J36FXpPbv7xj5AkgNmlYjGCHRUP7?=
 =?us-ascii?Q?Ub9Qtm/gGUyyJYZvkb/HcvLj8P90s6zR9E6g7fBtm3uW+Oj1aN6ZZfsmhkq2?=
 =?us-ascii?Q?m+18vaNLqs5iXrwoYAL+l7ZxR2hTw3WKE3GvaI9UMTNmGmZHMmTo+h8sMVOT?=
 =?us-ascii?Q?deMPuaf2gc8hRnV1W1cVTVWrry55y18TaqOua6/mUI9oyFkSsiOcU1rfhwIu?=
 =?us-ascii?Q?XX1sJj0R2UXlaKnIkz85axvOWGlKg4kx5QdSj/36JMcgvjsPxL/TUBCu8jro?=
 =?us-ascii?Q?VLre9fy/9QF/74lQLYMdAI1BjQq1rwyWiknYiB9IXGixoCHXf2AJUcCiLn3U?=
 =?us-ascii?Q?bQpiRo5Ne+T94q8oZyDgUXEL7Ufb3gRXqG9i4j6K28JT9OCj8ynUq/y47tgU?=
 =?us-ascii?Q?9FB0hDsngAGVhZnvUh4wwBqmCGQ8sFjfg/heVNC/plDjvb8Sjgcw2Cl7Iagj?=
 =?us-ascii?Q?PqkH+yPMdqplgQq2JEmstEWTXmGN/jgh3p4agaNcPB8Qe7COfvGDXnm81CEd?=
 =?us-ascii?Q?Pn6dd7HhRVLP5QdVTe/Hh+o7rJkHWhl/loy/+VbSZYGgBpjn1+iC947hncvN?=
 =?us-ascii?Q?yK2KX+qxm/zgWZczMJz1znv7RIZEq+iaJ2DoSX/Z9IFurYDmmkwDSQAJHhc4?=
 =?us-ascii?Q?MqXw051LCLXNs2q75KbkQyaxjJOA2JLI66vj8Dy1kxYbqSBxN44HwtpK0hGi?=
 =?us-ascii?Q?v2/ouTBsn+dXzXgLvcdnd9Fh8tZXXusm9Fwfx0yITDZ39LyUTN8OylcAAch8?=
 =?us-ascii?Q?6h5Vr8crRSItIrAY7lF2kWB7VQPYlTC8EmvVEYNbl2rmldc5HOJJWwbGdNQy?=
 =?us-ascii?Q?I8zh6OO/Sj9fXAwAuci5er6PSiDjlNTGfZ3I1qP54mGJ0cIX/7s04rlzNX+F?=
 =?us-ascii?Q?BNFix2rinDKD3Xd83g/lyDlavJXQzYKb6G7U2JJxynHNCwJoYmOltya8K+cq?=
 =?us-ascii?Q?hIsBxF+b3YV1PTMBSfhR1RkqcALRHsszbZKbes9DPe8te3FfGp6o2Mj4BY4i?=
 =?us-ascii?Q?ZZO/phoTwwqyvq/8u5s4X/VIgKDxm3S82mf3Js0RejJCXZsqoDQrnqhzHcUt?=
 =?us-ascii?Q?93UA9B/F9yZQQog/Cjja9t7cH+YttReaB0EC4CUBrFUAPo541OpjMQaST9qz?=
 =?us-ascii?Q?KdRJBJTTNqPPtzLCVlhp18FQ0s0kBkCcWRG6gInnjIraFNsh4nSobu8Blk4y?=
 =?us-ascii?Q?V9UOSpVkxzniD7MBlZ/Pl97yq5GVtaFzHV8LtSgdO+jThDncfh9GnoJEyim1?=
 =?us-ascii?Q?cLp5jZOdovopJm6+38EH+LZuLa4zYQTPo7P3MZVGbTzdIAjz45fxMPSDxE4u?=
 =?us-ascii?Q?18dNzfT5xlukdKZ1vAd2lQmyQ2cRYbvzykfJyZLAJKL3WSKnsmFZoUfPeq5C?=
 =?us-ascii?Q?4Xc7K/lviaNBhIYMyfDgy7wVG5SMnCdo6Mmc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PBmd403ZHsla23gJk7Ky4t32vkiVIJY863r60XADvIgNk3YN/ooVO7ZIR1UG?=
 =?us-ascii?Q?xGKslycdH5hxVFMq9oTNndj+SgGIdoMpmmPpdDo8+sKb56lvBXxmWf12H8av?=
 =?us-ascii?Q?YQppOAaDDZ/ba80SJHgZmOMoM0cTnKpVeCf1PDXUhhRAMikn3OLgF7EwBvE/?=
 =?us-ascii?Q?weDxYGoucvXot1epfmpM2Po5fHD0h74YL93f4E5dqcQyXvyrhOJMXOFKU+iM?=
 =?us-ascii?Q?nY/QGVSDool7ZF6JZGtIW9JFrTmwuily4yrWjtigu518fWiCtQFsDvj6Hk3u?=
 =?us-ascii?Q?c5guF36Fm45EfB+699GvG/SfHSPyOK6GaTwL7ro8ke6Sj92pR304q1585Br+?=
 =?us-ascii?Q?ZVJxhxUm21Sq41yuwpZRcPSnDzkk4k+jOmRw/DwZNs55/ubdy0/4Q0ein4vF?=
 =?us-ascii?Q?G8QHBucAueg9PeAkdhSlvXiR0JRjXtm7V5vFNC6cfPZZzJ+xLlyWaJJ9icDW?=
 =?us-ascii?Q?ThuoGkeH7oq1V2jh7fz3yWDaVTkUSuh9Ga/9Vf46846XsIECGEFEYz0MYQj5?=
 =?us-ascii?Q?tZbGzbFpwCWlyXSlgPDpKr0s5fmZe4baWHVqwgqDfs2XegWW1WsXpax4zk/L?=
 =?us-ascii?Q?FevVSq5XdF9xDNzRwO6dbelexl+a6Byd8TnZbSXhk+pzHV+5RHInZg9keL29?=
 =?us-ascii?Q?f+76qldaxDIEkQlDkNYK4EW3qXMgjjimcjTvvdXIzSqBLuWz8wS/X/FsYjKw?=
 =?us-ascii?Q?2S7dH0o5bi0GfrCuOJFz38wWVYMA7k1IpJujpyNVz9+clPAl3OA6izio+Zei?=
 =?us-ascii?Q?22J96FyOFuPh26PrS2TOSDswLnHmB7Sn702CGrSZcwO/Fc2Ve8brYtSMI/vj?=
 =?us-ascii?Q?I1vWU8NGIkTcZd2UJGFqoY62g0H/gBYqp0InRa2L4O8x3aCAEC7dvNUmdY9g?=
 =?us-ascii?Q?JpQfwI0akfPpy3eqSavZKFKkkGYSw/6setiX5MQqm3imDEZgi19mwGzQPWix?=
 =?us-ascii?Q?ggrtEpNlOL6rkt/x//HiAy9Os88P37wTb8C7qYGMkGxa6YWYDHPKU5Vm3aRP?=
 =?us-ascii?Q?WSL+gQV78UynVx4WFibu9Wyb6vVgzYtmmSN5PjY7xPjhps1XoM1JsX3FSgqf?=
 =?us-ascii?Q?Os0olJWvRf/cl0RIKfaCJefAR+5zw/JUZ9ZzjzTifjYqF2KTHfJzdq1y4c2S?=
 =?us-ascii?Q?Am/yGHr4xp5zmS4ai1VwtMeVwU5CP3rIo6yPL7Q+0IPbW4tnkS7RRH6ey7tc?=
 =?us-ascii?Q?O7/NdAN+0FmtiWL8lAEENgcwVpf6OzwwELQYs8JCfWlqVERpgF4I+7WPKpda?=
 =?us-ascii?Q?ul33iXTZVLZXLuLDLYJKWTN+DyJR7VQqAU1IS4og3WODb1+Ui/0U2UPBRJ+7?=
 =?us-ascii?Q?jmelXij6sScpBrirV9fNSGuKckYr1TI0LV4ucSAz0Ubi4T3lkTpvml4AtvIN?=
 =?us-ascii?Q?hHUHKCKZf0VSS010pbQ2AS3y4AZBAn677v3tsJFzQ5RrU5k2KBLy6WKlbrqA?=
 =?us-ascii?Q?nPSL5IJJbERfHYdlm1gbI31czXYu7X7b0AqIWNBNu6ZnLrywo4BM2puALBBI?=
 =?us-ascii?Q?d6+gf9IGgocdurv2NRNVNQ4BFnniV+XYjvxEQZmjN3nscBC3uxbOa6qiVwOv?=
 =?us-ascii?Q?LJqOc1EXro/C8TGamcWHW/vCzHY4jQxeRNTL2DO+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b10d957-41bf-4b46-18e5-08de04e5f873
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:38:09.7952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt1x0ABinkPiBE9YeKKOqdJHtsRRLn0hm1+gExuDXklNge5w7JPUhd3ceL8IChEVYnnDVEDHk6TwcuWyFDuMtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10495

On Sun, Oct 05, 2025 at 11:51:45PM +0200, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> The correct compatible is nxp,pcf2123
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm/boot/dts/nxp/imx/imx6q-evi.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
> index 78d941fef5df..5da9631cb3ec 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
> @@ -134,7 +134,7 @@ eeprom: m95m02@1 {
>  	};
>
>  	pb_rtc: rtc@3 {
> -		compatible = "nxp,rtc-pcf2123";
> +		compatible = "nxp,pcf2123";
>  		spi-max-frequency = <2450000>;
>  		spi-cs-high;
>  		reg = <3>;
> --
> 2.51.0
>

