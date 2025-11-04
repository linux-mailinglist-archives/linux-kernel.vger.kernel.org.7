Return-Path: <linux-kernel+bounces-885393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B787C32C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8741893BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511D2D8DB8;
	Tue,  4 Nov 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lvdCeUEz"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDEA21ABC9;
	Tue,  4 Nov 2025 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284497; cv=fail; b=lIzjI0kFFPp0pWBMPTlN3yAE7XqBRLREOdgMMB1jlYrGulTac8PR+zEHsQ/DagaqBuQOP3f4wJ6OKGaGh3z8cYfRh5569Ldw6I2DTUcxWf203RiP3S9lugopB/Q+eW0sqjIlpURYh9a/hyxsoPiiHzKD1zvGcTC96Z+aqXDOMp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284497; c=relaxed/simple;
	bh=/nOkU0Qt0d4resfDReaZj9LjUVmkK3u+CUIifbHm3mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cbpS72mnJk1rlr+HrnHAv1JRsqcHjlZp1kP4Ma9RowHCJ+WeG4lLV2j+qJQ1Se1FBm158C1Wi2h65+XUmI1yGhSYBxQ1QD0RWSKbBO1Idd0+8Xn33xkL0ujhS6XF6YDzl8sVXDfJZBV27bWAZIOB3iV/0wrgPxtXmiRO8x61Qbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lvdCeUEz; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHnKs7yxERQjQvVXx0q320D6Yx11MQSxengSWb04a+9lpn2E5NK4EyE1rM1BnhbG5K3Q1ugFup9SMg3U+2h2pNK9/e2Gi719vfn5Ese+8vI1Q7v0gtZ3jCeca68khpBhYVgotvAcClrW+KH/yWAGVlWmM88VaNFsG46OuqhD09axui1cSTHb4QSVRKVkFy9wXfDiUDQNhGqOeClpXmmNSLhgdxhKizWm9QKdP1H7ybiut9qYj1Bgp9CEdTXdb92+FqPhICNvRvKyxokX+xj1ulpa6uPPRCm5uCCpQG21UVSXA5Vxn46jD217porUa8W1MmvobvLAfWHpzNKLsWJ4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1C9ISv1vp5ZH5J2U1FrEzCsnx8pbGaT29BdYUFl6cBA=;
 b=RT88caONocWNzUP/Yay5eHAEsodYswDnaRDDR2HdAyzrUKbBVq+F6BozXukkZeAtv+huqCVD91xrQbTPDtmU6cFaPWygJusXj5LCw1N6JQGSwwj6pKqVmnYv0q/VzinEcDfYUnlJ0ZwdKPKW06ope0/+vGhiG87s9DR8D/9TF0I21n2gUh/SG3i3HdvUOqpVTln+k7GNCbsLUaC7HTRJrmW3es80yMR2Xsxd6ww13pUJEFgE1JTTPR0zkHlkp4yUY5FcGgYTfh9DrifajREygSF1Mvk3o+kFPPW8W16ocT8mrBYGleKTrt5rkP5HDj6NRQNol2yQfIAxvX3KvRHjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C9ISv1vp5ZH5J2U1FrEzCsnx8pbGaT29BdYUFl6cBA=;
 b=lvdCeUEzQ5HxW+lXbFakHrM5n0DVGbYNc2ptsBrEjsHEaXfG0bsGjmwjR+SBGRKEM3UcdpeCnOeI0FxYx2Z9lcckX00KtAIqC4HjIm08i8P60/3lpqkkY97M3Ai9HYTNgWcAo6Zb0kOd6XtQpwGJfEiTfwSwsEV0DpXgX7VfmaL45NsoQV7gxv++98jypWkwvR/52h8rQHh2RlB/ZKjJLOsTUQCBw8NS3JwhPtFIJCX1NsXGiLhj3HUqGlfovihNE44AmcWNVQn1x0i5oTvvCSXBTzX6hlV2D/QE2FwotgHup+BhjLe/ZXGxah8zIMmtasG8iaW2yscD7+5K5m2M7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10684.eurprd04.prod.outlook.com (2603:10a6:150:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 19:28:12 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 19:28:12 +0000
Date: Tue, 4 Nov 2025 14:28:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: adrianhoyin.ng@altera.com
Cc: alexandre.belloni@bootlin.com, wsa+renesas@sang-engineering.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] i3c: dw: Add support for Device NACK Retry count
Message-ID: <aQpTxBGY8vbAQBmI@lizhi-Precision-Tower-5810>
References: <cover.1762245890.git.adrianhoyin.ng@altera.com>
 <0098b646e37db167958505afc4ba040ceb511f66.1762245890.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0098b646e37db167958505afc4ba040ceb511f66.1762245890.git.adrianhoyin.ng@altera.com>
X-ClientProxiedBy: BYAPR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::39) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10684:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ce0352-56d7-46aa-2792-08de1bd84b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iarM2FL1dbqTiTmQTyl3x1oP72Sz0vBT9vLKiL9EdY+B0kTOXs3AeBtkc0dv?=
 =?us-ascii?Q?f62LfncgCKR6Fs/eWaSZTTE2jcGcVwNqxhiKTrGTYjCU11ZOYWGRA780ZJsa?=
 =?us-ascii?Q?JEMAwK1+C400SAcexFK+1m7mFzuoWl8bO2OQzoCrY70t7CJXJHVAfmHu0mjX?=
 =?us-ascii?Q?MgqxPBSDjgMlElqi8ksInes96qrXSouqr95Q9QnYQNahqIJqppPoU1uz9lUS?=
 =?us-ascii?Q?9yDmB8Rl6dStWZmGYxEzS+5e18NFRJki09ksW5QhfA0gFL/HmDKsa7cvrrZ0?=
 =?us-ascii?Q?QJZFmuiEIw6H9gbwWLUTxgXg+nJOKJzza7NK7hzQlxha9SnYMQ4dLlFwiVci?=
 =?us-ascii?Q?W9GIEtHACh3CGlhput84WjMaCu/n2BReT7TzhEKlt9T4nOFwnE6y/GZ2EV6I?=
 =?us-ascii?Q?MsWbCNgcnAc730gNj/D12EO30pWhEyvq6CF4dIiT3NpAR0EwWfzb9yFZcwJh?=
 =?us-ascii?Q?ALHXqkn1OGAAO+jINZX85yFaAgpGU99jiIE4A5rpTHfovT31GTSQoU4V80nS?=
 =?us-ascii?Q?5Jc1pbiOolJ7OgnkyPHyj38uAm64f4Ol9DIu0NJGx3tyv4h6fgf5iNJV8KFE?=
 =?us-ascii?Q?+0XnPiKT79ccppBNGTYs6ILNI+mWx7ctBye2z9aLlM4pvK2r76bDAMstb9RT?=
 =?us-ascii?Q?y39GvxhdwhfN5jVwq31ClZEx3cyhYSoKnR321LYoAs1KhOdwb4f59jACQGHM?=
 =?us-ascii?Q?CdkBa0QZAjW1Ka3dv0JmEETl6KrNWtxQkMJX6YsMlppZMbZzOWWUrAL1OMni?=
 =?us-ascii?Q?Q3HXl9tzkSriWHf/v2SCn0+/pFM9106Gga4eO12iOT/aNRou9HoSWP9R6iLD?=
 =?us-ascii?Q?wNWRIrDSy8BL+i1SRhQh9EZuvpPdQIGl+T1OUTuqfvfgsjKRwc6yeJ6HxknR?=
 =?us-ascii?Q?IcHzNgVqRIbtm+IwhJ3F5DW7rD4BUwlLoyUQIptpsnGRm9YOsxs0NQFpk/8v?=
 =?us-ascii?Q?cdJwy3C78rPaKalKs7EyOPy0gJ9QfJ0MFICFLDoV91SfKILVWZcZpuVEuF2V?=
 =?us-ascii?Q?yjVPmWcYp+ktllHIhs9H0xwyX5LdsUrZ6180X9T4dnvWOWZLCTRjc+MX+qTS?=
 =?us-ascii?Q?OJublQQYmdQ0bp1rJhpFDJlP+ckVdgi4xfpy55BbNpD3luf9INgsj1PiT3RK?=
 =?us-ascii?Q?cd4JuczpIVAlOF0VmNXc+nmkLrIu13+LWh2hwQsBGPn+rAoh8JfrKbuWNt7a?=
 =?us-ascii?Q?qnsaeJibIZH7VGNzP2HD269wzjD9WZzmlYv/GYGy9qDDgQxTvApaNEYjSH9H?=
 =?us-ascii?Q?dUl9JoTrVBrztelvggx5DENGN89Ht/A84vQ4FzdSGoXgFSOurRTh3Qlxs/0B?=
 =?us-ascii?Q?fpPdwq2URDY6b70dw9fjWcUy/gTMxtNTrQuoWJA6d/Fft5zp/g7v8dOx9fUF?=
 =?us-ascii?Q?biAyq7xMzyY+7iNmd/4aVUEyC7HZ14aigx3cPuawLVJhN956n1GGwS0u8Gmx?=
 =?us-ascii?Q?6IRaAUsoL5MUeAq1kkkwc8VhMSLgZB6634dhJeMBCaPh3LL8ESQvwNeAWkzF?=
 =?us-ascii?Q?EdzZJ2y2TTbevLg/DI/iVjt9HPrp0JuCHQHo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?37S0c5648HxjmdNQcLi8IZOCCJu21w17sNzs9MvRjkDwm1Yv8RZeG5DbyAA7?=
 =?us-ascii?Q?RWNor1beaAct5wwCmypOpS2TxCPi87Kw6fhmXXszD6QwfeC60g5KWkEW6MEF?=
 =?us-ascii?Q?Up5rsOOvhqhUe9zaGO6ib+kagHHHMSuTUV6uEzd2Qv2yNzGIFDTS6MeJkjT3?=
 =?us-ascii?Q?0u++5NGDIOTBLHb41RbvVd07UcjrnPR9EOtbdFbiFJobkDpBAXje35R30Soi?=
 =?us-ascii?Q?e31h1s7EyKStZEkysrABG2MOEWahhlpxsac1yxkZWl0nEfemgC5yEyv1AoB6?=
 =?us-ascii?Q?FHHylBXs89EdduGDCe6J3hf6B3WsfGbRHuUzU34BA2wwnsRXo6fov+tG/byZ?=
 =?us-ascii?Q?0juh+r9LNBKB5k8JQidQQfJfF1aRl17yw+RkO73JN5LTXjmow2AWhhwgXEHs?=
 =?us-ascii?Q?PUd7sWWN5B16s4AdpLoH5nQBPkCkZGok3txWhbI00cw5Mo2IABKuuLnD5HZ1?=
 =?us-ascii?Q?BIBye7eDMwJDt9h4m1HMlm3cZ7cgvteilS1LNugkkKkIy7B8vZgewMjAh8MN?=
 =?us-ascii?Q?UM08FKTrNBQrPFGhu58+Z+hLcz79yDFdoqqsQrKmGomFA6v5C56oqZVH9gUa?=
 =?us-ascii?Q?51OqRWa7Q3W6Rrs2365AxQLUp8GPHf69wKY34lBbC+7IxiXXUKuWi2hTwmQE?=
 =?us-ascii?Q?VZ3XeZF1tBrQOQupLv1EE6W8qzMHVLumebNrtWZRCRxx1Dea0HHU+FVLluC7?=
 =?us-ascii?Q?0ayOc3o/lHKUpfTXu6CxrZMuF3TL9I+rj9L3WANOBmWrl0Zi6EhNKe2WGOQ8?=
 =?us-ascii?Q?9rhaHq8PwHqSQI0V3L3mze4eiwxgXD+Tza3xIO19nMB/gRr6cSLerAMssHGs?=
 =?us-ascii?Q?3rqlPBzQYM9Cp2XxlFoXurSFYj3SWcpOaXqmogU9P2DD8ROP/z60LXTqYxrv?=
 =?us-ascii?Q?NWanZ8LUTp7EXHlFBPO8WA0gTzq0GzxpNq42IP5pS94ya4abrvOMp7V46Gu5?=
 =?us-ascii?Q?dmlvr1E/xyo1CGbmVAEme1K0V+77bI6LJTOJniBt4P7u4T6QNq+/VcGF4Ww/?=
 =?us-ascii?Q?TCzaOWj/zU3hTAZaAvFf+yaXJ+vDFVz3C30ycikaCrEKMJE9F4zs45Npe2kY?=
 =?us-ascii?Q?ruK9nGJ8wuTI2tifmDPPGJxFKzqCj4JRECHKnAhkzd4gJD9LuY6q2yS8wZuu?=
 =?us-ascii?Q?YMXQY2rvjjlA1EDHP9sj36QJuJHV9hhwY+XW62Mz0KWuQ6cnK2mfEChiXqzF?=
 =?us-ascii?Q?o216Gt3pSl/MeHV9KLtX4KmBmHtLtxgaRbgmk1t5O21c43TrAMvY+1brUmZN?=
 =?us-ascii?Q?SrFJbagsvl5vlYtBuD0/c2suoxGzfpZiIqFFj/C1QcAK0Lh9cbduprfbsy4O?=
 =?us-ascii?Q?mJsIboUinWkR2DKVyDVOqoCH4eZjiJdqXlBNdXrS8pw+1rHKPAYtqhdqzu8T?=
 =?us-ascii?Q?TQw7e1kK7F7flsfVB4ON3tiBPtlFxWZO3dE9rzU53ZhC/XkSBY1CcjjCzz3j?=
 =?us-ascii?Q?4ZuCxxoQs9kmWShClGj3qcgN4NsB9I5My2IPn7PMx1A6nU+PXZBb89toOOW+?=
 =?us-ascii?Q?vsUhifKUSuhPWEDFnwq/w60hf0jyAlFpW+SILWAt+3kcrv3rDroTe7X+S0aj?=
 =?us-ascii?Q?5aPJPrr9bkzgoj6MCqsO2unLRstj3+rsTTa3GP7Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ce0352-56d7-46aa-2792-08de1bd84b36
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 19:28:12.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOUpDeMdM8PwUgZ5HTmtoEZPPIye5RksQVgCMTQld46Z4C+mKxWIo5uTZ3/R1zhlq6AgdzZIrNDlUT9FHdp25A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10684

On Tue, Nov 04, 2025 at 04:51:10PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>
> Some I3C slave devices may temporarily NACK transactions while they are
> busy or not ready to respond. To improve bus reliability, the DesignWare
> I3C controller provides a mechanism to automatically retry a transaction
> when a device issues a NACK.
>
> Add support for configuring the Device NACK Retry count in the Synopsys
> DesignWare I3C master driver. The retry count is obtained from the
> 'snps,dev-nack-retry-cnt' device tree property and written into the
> Device Address Table (DAT) entry for each I3C device.

Most like it should come from sys/debugfs interface. Or just fixed value
should be enough.

Frank
>
> If the property is not defined, the driver defaults to zero retries.
> This behavior is consistent across both Device Tree and ACPI-based
> systems, where the value is only applied if the corresponding property
> is explicitly provided.
>
> The value is clamped to a maximum of 3 (hardware-defined limit), and a
> warning is issued if a higher value is specified.
>
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 34 ++++++++++++++++++++++++++++++
>  drivers/i3c/master/dw-i3c-master.h |  1 +
>  2 files changed, 35 insertions(+)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 9ceedf09c3b6..12ee4c4afedf 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -204,8 +204,10 @@
>  #define EXTENDED_CAPABILITY		0xe8
>  #define SLAVE_CONFIG			0xec
>
> +#define DW_I3C_DEV_NACK_RETRY_CNT_MAX	0x3
>  #define DEV_ADDR_TABLE_IBI_MDB		BIT(12)
>  #define DEV_ADDR_TABLE_SIR_REJECT	BIT(13)
> +#define DEV_ADDR_TABLE_DEV_NACK_RETRY_CNT(x)	(((x) << 29) & GENMASK(30, 29))
>  #define DEV_ADDR_TABLE_LEGACY_I2C_DEV	BIT(31)
>  #define DEV_ADDR_TABLE_DYNAMIC_ADDR(x)	(((x) << 16) & GENMASK(23, 16))
>  #define DEV_ADDR_TABLE_STATIC_ADDR(x)	((x) & GENMASK(6, 0))
> @@ -989,6 +991,7 @@ static int dw_i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
>  	struct i3c_master_controller *m = i3c_dev_get_master(dev);
>  	struct dw_i3c_master *master = to_dw_i3c_master(m);
>  	int pos;
> +	u32 reg;
>
>  	pos = dw_i3c_master_get_free_pos(master);
>
> @@ -1009,6 +1012,15 @@ static int dw_i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
>  	       master->regs +
>  	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
>
> +	if (master->dev_nack_retry_cnt) {
> +		reg = readl(master->regs +
> +			DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
> +		reg |= DEV_ADDR_TABLE_DEV_NACK_RETRY_CNT(master->dev_nack_retry_cnt) |
> +				DEV_ADDR_TABLE_SIR_REJECT;
> +		writel(reg, master->regs +
> +			DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
> +	}
> +
>  	master->devs[data->index].addr = dev->info.dyn_addr;
>
>  	return 0;
> @@ -1020,6 +1032,7 @@ static int dw_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
>  	struct dw_i3c_master *master = to_dw_i3c_master(m);
>  	struct dw_i3c_i2c_dev_data *data;
>  	int pos;
> +	u32 reg;
>
>  	pos = dw_i3c_master_get_free_pos(master);
>  	if (pos < 0)
> @@ -1038,6 +1051,15 @@ static int dw_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
>  	       master->regs +
>  	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
>
> +	if (master->dev_nack_retry_cnt) {
> +		reg = readl(master->regs +
> +			DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
> +		reg |= DEV_ADDR_TABLE_DEV_NACK_RETRY_CNT(master->dev_nack_retry_cnt) |
> +				DEV_ADDR_TABLE_SIR_REJECT;
> +		writel(reg, master->regs +
> +			DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
> +	}
> +
>  	return 0;
>  }
>
> @@ -1592,6 +1614,18 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>
>  	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
>
> +	ret = device_property_read_u32(&pdev->dev, "snps,dev-nack-retry-cnt",
> +				       &master->dev_nack_retry_cnt);
> +	if (ret) {
> +		master->dev_nack_retry_cnt = 0;
> +	} else if (master->dev_nack_retry_cnt > DW_I3C_DEV_NACK_RETRY_CNT_MAX) {
> +		dev_warn(&pdev->dev,
> +			 "dev_nack_retry_cnt (%u) exceeds max (%u), clamping to %u\n",
> +			 master->dev_nack_retry_cnt, DW_I3C_DEV_NACK_RETRY_CNT_MAX,
> +			 DW_I3C_DEV_NACK_RETRY_CNT_MAX);
> +		master->dev_nack_retry_cnt = DW_I3C_DEV_NACK_RETRY_CNT_MAX;
> +	}
> +
>  	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
>  	ret = i3c_master_register(&master->base, &pdev->dev,
>  				  &dw_mipi_i3c_ops, false);
> diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
> index c5cb695c16ab..45fc1774724a 100644
> --- a/drivers/i3c/master/dw-i3c-master.h
> +++ b/drivers/i3c/master/dw-i3c-master.h
> @@ -51,6 +51,7 @@ struct dw_i3c_master {
>  	u32 i2c_fm_timing;
>  	u32 i2c_fmp_timing;
>  	u32 quirks;
> +	u32 dev_nack_retry_cnt;
>  	/*
>  	 * Per-device hardware data, used to manage the device address table
>  	 * (DAT)
> --
> 2.49.GIT
>

