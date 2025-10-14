Return-Path: <linux-kernel+bounces-853044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F7DBDA86F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576E0540E54
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABC6308F1D;
	Tue, 14 Oct 2025 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bjyi2Qfr"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2D301487
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457313; cv=fail; b=t4WOKaJq88w8IhoEkvhQTyQBu0t1ZUOXAX+rlAxasrqTfAI2dD1pu9FCp/bXrsGvelKqKQQf98YpD3atq08bbJZxSoNRYEg63C3/C6X3ne5IFBm2JQqYbKqc0r4sRHGve+XUa3CrC/Ep5W5o0u3hIke5+EYOCY5w5JgNDq8LCEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457313; c=relaxed/simple;
	bh=ZF2TAYCFT15VyvOUDpCPPhipXLsWdfYhI6oOrq8+gGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KTrVQv75BPPXGAKV2LsA7/BVYxoQVwN7Zr7xkftKreHSE09B3OQfCZVFcojhy+FfN94qhxy5c4MsSIAYKUvtUbRCRyTBIT09sXXBNSVoKxtsjybQNN3vyEI6Iwkpdmt8/vD1djlemiQgenuqCzgGCrGzHqda2iFBxJrM++jE2+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bjyi2Qfr; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqNIXvOf48tNz00wpKON6KjeLJoHMLDLNhbG17Ktie/EGFqZJhEAAzVMRrQ+3id7Dlc5nbBpIUeDpVT+SoXI007YB3+rcvRZMPI8AZtZ0Lcb6NhZjlqak8HCi7g1U8ZXbu+18IIvYWgn/ERPYT6R57Gc1BHEdm+uPs049hpDSKe9m9k/Kb/IXmQFsw8wMV7/TeW7Ldzux42FJz/w8j1yhp4v8TkodfUk2jMP/Y6VjFEJ60SynI+sibhnqbjDeazpNWbotbDA6aiSVMctUDAGEJlgpmIOio7mhVyODt+EKkhgx4ETRuv3908ZbKSEDqT4EFtY38/4tzECOLFU+NJlvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ6wjSLN2KstU/hkQl+wJzako+/OOxsBsLTvnuEy41Q=;
 b=nADypHAEu93nhKtlgRCVmxbj7Ev6rSx08lD9Mv8GM4ntICyIZt597kVcmLy4KKSh85ugqfLQaHGLpG4H31zN/amydjsPeHBahLkbcFSi9m8G2Td5QbLqZ4BwP3eM8bxPZGqf6GnseSnV83pabb7BIvGJiB1pg7RqE9DkYb6EJMZ74ge8CEd6TBgVjUAl8fd+jNJ+HhnQ5V0sA/S453bf0n/7frYphWld7Gjd2iq+AmzbhrcD8CmW60z4u5V0yUV40eFT01C7QylrRV1MmoTcwBQF6F24L0lP9weUW2YJfhqNMsa5jTZnyWo5FXDd1DbABxPNqyTm/ZtsQsZ+J0JYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ6wjSLN2KstU/hkQl+wJzako+/OOxsBsLTvnuEy41Q=;
 b=Bjyi2QfrLitLbaViS1yMWCmNYTpNePFuO5IH6ZzF/PVV70zBdsOUzHCbvOF5WTJfI/Mu8fABZ1rNeYPDK2tgaOaXAv9l/a351IsJ6Lnj8gnNpaWnWRAmtGCDe5+H65cb0sW2pr2BijSatAtN2J/zYhhZYMNVWx5lIyeM0FFgietSqLZT0otxoywWUe1a0Qch4A0ICbOFDqVPrHBlZA0twjO/zngGB+ZkXn2gFt58nEhy+GlZRGGTx/79kgOHa81lZO3jSITDnMfylIfAiNitEjUeOUJlFpku4us9LaM5iv69oFMfh1d+I230NqExVqu5ONKH88/qN22T7TeXx4LLwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM8PR04MB7266.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 15:54:45 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 15:54:44 +0000
Date: Tue, 14 Oct 2025 11:54:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] firmware: imx: scu-irq: Free mailbox client on
 failure
Message-ID: <aO5yPLL9HKdM6yuB@lizhi-Precision-Tower-5810>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
 <20251014-imx-firmware-v1-2-ba00220613ca@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-imx-firmware-v1-2-ba00220613ca@nxp.com>
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM8PR04MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2d7988-1ebc-4a52-8053-08de0b39febb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5uyqa32vuiIWDfnUOWEZ/soXfjRVoUk/OCW/LvRiYZa0Aj/VtkhUUb8u6TkD?=
 =?us-ascii?Q?V+ETw2P6+5+qtCZb8qzQiVL0vNk3NHw846sOAx7zCPJCp8PHVx87ZaTxdlyF?=
 =?us-ascii?Q?cCjEdvHfMwkOnhjtrfmXdUDA7oTaWkHIZNNzAmKOMDZRHIb1PGYoKa4Grkiv?=
 =?us-ascii?Q?TVMg+RVTMNvnmUoWwJR2B7tvmh5cIHcxED+zpCfTOZMK6s4E6ZGvaOFdx6CG?=
 =?us-ascii?Q?VRw4KS1uJyDYuAFbdczcS/+1TtEIN1kGRQXbK8qmFwb89OoKAftC+S0rZqr5?=
 =?us-ascii?Q?kfVDPrkQQ7HHw3bDJ6ztKCYcBdcz5s14g0nGNE8HHWC5uoYE8cuw9wlqsx8K?=
 =?us-ascii?Q?hH9Ud2f7D8001+Q5f7CReEjFS5J3zFpB9WBS6MvBkOkTqheuJAg/5+IQ0cpw?=
 =?us-ascii?Q?//zlxPjAXyxjmF99pD90t+hJieZvO2mGE9MNRf4Lr7gU79NUz4bdxjJM4Hei?=
 =?us-ascii?Q?7G5k7IxW1cCLAkd0p7ye9TggsZ1q4G4wPs80B8FlT5GrMy7GqAtduN3Gx8Ml?=
 =?us-ascii?Q?Ey6zPX04qgUU7hfp77awnubeaYfaEW3G05PGTUxlrpnC1SDMOIJA853l2CQY?=
 =?us-ascii?Q?5xCLZiqZhLz01DhcqTelQ8dhqKSHYWTbdaUO5xFFHE8r/uEQF4dj0ytfWeF5?=
 =?us-ascii?Q?bbr+qAvlFODC0ZI5DixU4t7p0NU1zJJ8JCe09DDTqvPmp7JFlzjtAWl355Ug?=
 =?us-ascii?Q?t0el+BKiipz/jj+ETs08aiUsoClZnJ2vfyaQMLyF7Z5qBx4qvA9ZN/OYpjfS?=
 =?us-ascii?Q?WX0HGeP2IhbHW/5AokmeVr94tQj6IUQcUVWIfVgiGFVHvnsZbyWre9iBquab?=
 =?us-ascii?Q?3NOdMi46fxA821+jnYAl1rOlhnYDE5D/eLvhvyb3WjQFWp26NAbnt0tkZBgS?=
 =?us-ascii?Q?PEhsEQKm3zk9YqAIbAUqjLynvDySSs82aiZguh2ohSAnq7cueZt5RlRiGVHm?=
 =?us-ascii?Q?PhcJbhXLWBT6pewyAy51+LjB610A+aCnxHZBtVLECU/za/3X8J33+Hu9EYW0?=
 =?us-ascii?Q?0bjjRn8fJppaJaM9A9WKco+0tPbIlEZei4zYqpyJRud0CvTGJ7j/U15g4Pps?=
 =?us-ascii?Q?TIZ0CBgkgzXq0wrgqWpBT/nfjhjwXtRx1aCIBSnzJ2y0r/dUfoN+vQb6heb6?=
 =?us-ascii?Q?6vDDXqp09PcxkhCdoHuXAyagYgPl9FThybR7XOu6q3fpXBOOxIboQUlQsN2d?=
 =?us-ascii?Q?t3XkTO3CZHE9z8yO7is1qFQSZQjWzhZ4OiuIicr0sVxZ9qkFdmArmNbd2gp4?=
 =?us-ascii?Q?Oo6IWTlCdHfuHaOfs3fWbl+UEgOx0IlDBWIUAi1jBlnvucTqpVBcJ4248urw?=
 =?us-ascii?Q?WuISMV+qr0fz8zshTQDRzdLWNr2191ePwZfYGpk3G3PSt/0sZM7G9LHl2d3B?=
 =?us-ascii?Q?0Oy9DpUkVpzknuGoQ9DX3/Gs/WYxmojtZgbwye5m2TZl0vORR2tEQA2ChGHC?=
 =?us-ascii?Q?riBwiZ5Y10G9AfgyQuCXQ+yUG2VkOrZVR5eiQndSTmEwovY2ikU3h8Gq6RhL?=
 =?us-ascii?Q?YkMzNoXwdzr219GI48sWIT4kXy05Pxp78r3f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ssrii8nlAHLahwRiVBrXEIIL6oCDAPgqVzw9rOgJki0HHye5A8XETRNp56lg?=
 =?us-ascii?Q?8r2j47/rP4XuqQZ9WeUYIxHxRWUR2YUV4paAs9CrI5MmiWkDVsvoMceyTeea?=
 =?us-ascii?Q?Qn2LK8g6pW31XN2noCF/WWZNFOFdbeDNhNFuYU02F0GvY+i5/396zGPN0/6N?=
 =?us-ascii?Q?f4yJwsnXBNds6akG89khqX1iH9vNGy1CYMBpK8zkyneA9PEx1sPQB9Y3JaV4?=
 =?us-ascii?Q?LiT32a/wOzvltfQKEYbwzqDaW39+Tvq3dhHxB1xWFPcMtMLzUU6lwZOY9Mu/?=
 =?us-ascii?Q?AiPHJQjye0PlcVqA7cdVIPSIFFKihT7AxnH+hH4j1ESEokiV1AU8d5vJOLmP?=
 =?us-ascii?Q?+g1hovaHWuFSXAgmHdKVFvsYzs2ZIo93IpuAR5khZbVeRyzMMbIgwwlscvli?=
 =?us-ascii?Q?K2KsyHAhpUCGHKLxQmWNF1huZkMR4d0ENLV8IGCl0NV8S4b23Lw1p0rn+aYK?=
 =?us-ascii?Q?S5tgqDHlk/ogcs1nwjPRmI5cJVlr22QFmeTPQOZPcFYnyCd+KNWWMJa6ILNN?=
 =?us-ascii?Q?bqD8Pew5YJgz1TJ0acxAD8zUsIZI+2SmjGdBASbNFqTez+WiAutziKCoEZja?=
 =?us-ascii?Q?sKdlKEpWPEBydHIpuXPMS+TiQQQYFZSq42pkmwrcJ48L5INuYQDZ4l8cqm2q?=
 =?us-ascii?Q?fjBxy0p5Er2l+gHNawLE7DTsyjRrYDnANZJSVsWyD6gPKokovHntPxtFgcZ5?=
 =?us-ascii?Q?H6Lg7VByx4AZges20e5tYh4JUKCp/IcJL2I+AIxRY7pAATwQm1/80nHolKiw?=
 =?us-ascii?Q?9nSx05akzMq+42hFKQsn9R91kUtlqOk7qynY0n/i8AkqGm3vrXsXrw1aY1qi?=
 =?us-ascii?Q?0+cKxV75oFsW8Oz2n5JYYHu3s20FbOqO9dwAlR2AYHU2ha7V71k7AKxqOKf1?=
 =?us-ascii?Q?gD7n3Oeyu9M64Bsd2jWCKhOe8Cwh6mUxR8nU7F17O4+93QGFFVeeu1uVIfxr?=
 =?us-ascii?Q?nMbjjD56zW+aeURikoU2W+KK70OvjJ0jFrDCp3LYlIkbn/iQuHWg02P93bAl?=
 =?us-ascii?Q?o8eFal2TkmH0zs7191mF77znRVcm+2SCB2/P8sVkUa9HbWk2yshyQrRxcAK0?=
 =?us-ascii?Q?IsYR+Aua/azYYtp03mSRG/qP9g/3k6NS1fRrmEUDuLg2vZVYZOrVCGMSa82y?=
 =?us-ascii?Q?1IirShVi3GlzSfRbiFyUZ3Q4xXB0Zn8KGasduJeLN31oCT/TZbsgitSoWIFu?=
 =?us-ascii?Q?sSa4ijJIEz/pfCIU14KlBo/94I/SJZFob6zuOKKP94sbEN7CQMNck+W6pktj?=
 =?us-ascii?Q?AhtadOGumXSX4AjmjWuRsLU6gpFouwylnjhTPtXuWvQQCSDpwOVOraikLbVk?=
 =?us-ascii?Q?bWUo7iQxGUq1MtqlOITcy11qZIGVZY7NGOibTk6YsNMDmrgkCJgtaBJysUDl?=
 =?us-ascii?Q?copmjDsKKJpAeWEArUme+lCKj5hgK5Qnr0si2s3s4eFCKYx9auEADSHlVLKc?=
 =?us-ascii?Q?HKFe3kq2KlU581hTw6T36sVgyqQo/e4OqZeYtraj/RyWOhJi3r8gkn1r0Mxz?=
 =?us-ascii?Q?cg9Zi1pblhjulTBnnSYCtIB6jE3WXZOJRC67qJf9o2NyhNXwlS+hbCcwbLp6?=
 =?us-ascii?Q?LNX5Ca6Jxg1/V0ilAfZKmXMoPdOdqidHSRi3EcTC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2d7988-1ebc-4a52-8053-08de0b39febb
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:54:44.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DxifKVyriZc0vXxbWG0qM1jQZedH77Ff3QU085wlL+Fz4j1/LVTMvV/yq4TRGYdsa4ISxCxeU2ZWKGf28TS5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7266

On Tue, Oct 14, 2025 at 12:54:39PM +0800, Peng Fan wrote:
> With mailbox channel freed, it is pointless to keep mailbox client.
> So free the mailbox client in err path.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/imx-scu-irq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
> index f2b902e95b738fae90af9cbe54da4f488219906f..1fbe4c3de5c1592bfcf2334a83776c25d5ca7a3f 100644
> --- a/drivers/firmware/imx/imx-scu-irq.c
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -255,6 +255,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
>
>  free_ch:
>  	mbox_free_channel(ch);
> +	devm_kfree(dev, cl);


you use devm_kmalloc(), when return failure, framework will auto free cl.

Avoid mixing manual free and management free code.

So I think this patch is not neccesary.

Frank
>
>  	return ret;
>  }
>
> --
> 2.37.1
>

