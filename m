Return-Path: <linux-kernel+bounces-876760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75430C1C3A5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241511895614
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86792343D70;
	Wed, 29 Oct 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YSYM+IiN"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3DC33F36A;
	Wed, 29 Oct 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756239; cv=fail; b=MrqvsvxtNwi6du7L3x2xnrn1fM5Wd8FlOWYuxPVJk6pClxHtdst2JPJfMptJLymEe3bdq7i4H1NO/CVNsOCFjeh2rtgkecRRgiL3f1Jc4+i57FKW5FUr1PfH7RwLxwc67W+/PHMs4JDSV53JnaQVrTir2nPpjZmLiOtlc2rto1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756239; c=relaxed/simple;
	bh=d8jo27Me40Lcei2MJyRqSAFJ3p64Cr+Ti9+hD3GLX3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V2iJAhUFGHfppP4EVcdho792TDOBjSGV9TXY8kaGgFNOSlvrRqKopFMj3o50ofVpqmqmDrGF/PdSAfDKSBxArHd8gl+eeUcBFHN6KlgEqgn1bOWvgOLvErSkkGiX0bbbuwGKmKxZ5fP29EArlf+WReiexmxoCALiJgDcuvAK83U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YSYM+IiN; arc=fail smtp.client-ip=40.107.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzggwpTkYeYkRjZ62E/qIKkSmXAwidqaYxt1LYXKgiUlypSa/9FwLt21RM66hzhKkqSmO01k1SU4lvMDBebZvQvXfQZtBCeZvWIh41/SNkDqW+gLG3Ui60tgs35FEI99yH8ZsN9KA0K5cgEl4QBQkgR3t0L82SmKZGqwLA/h/ghtwFahjA97z5ZNQUBt06lhEsl+UhJIcHMpxHx+hOR2tLxIQpAGL5165Xv8gd23/t6Lev0I2Rey4hlIyK+HD6CTyFgo+uUe6UpNPTEiC4WtvPo6n5fWR5+3OiDW7hQN+FslUz7Sum+Ro57qTQ8r1IJeMFhuXE8RcKr5KXhgpJnyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZLNatS42c/9tFqhauLlM8uceU6doWfQw7uPZe4wyJ0=;
 b=tbdCX/HkAzh6J1B/IgwOCokURDnMwpKAcpvVE5Pqa5sZr7k6RZmW3cqhnBN8YPcMCkqpkmjde/NQqmpCwe/07AiswE6c3B91dtzarUCaLaD99zeozptmFTKQT967FPFto+4eS6U3ZTw6XqSksqeJ+YZZZIRFm2505JTAkjaBv3dOBIyqKDdwy8KeQjyE9bMkK1vd3dkinYyCri6VNBn8RkNm8fSLIoGh9Z8XNVVb9PG2qqsTl0An22z7o5v3jDovQcjfd/Tvz5MXulhJCTg5lz5BxXvtgyq1YTeBwkundZTkwBiOnGkPdpeyrV3FilDY9qQ3AufAX6fYaiir3wNm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZLNatS42c/9tFqhauLlM8uceU6doWfQw7uPZe4wyJ0=;
 b=YSYM+IiNoats3NWSP2ZJYgSmhNSEdFHOtmH0G8NMjlwMJKiVHCa74Z3TqwbbcBTJy85eP0O5LKJDHJvKAZcWGl5OUqUxPqc8DnWm9CxocYF2NbptlThdXKK8Uw5W5UBzsiyN+0Na0ZL0DFcpHftGAtzylASweKu98qb1Zw3RPZgiHmXAHJFVmu/jpAnPhJBuZWUGDCg7u/q/PYpDSqpFs4g6Zl7pCUjuHcj393xWd8CPsoGayJhgJmxJsiqBg5wHgDkqAq3dYapvS5T00Mjbn85GGdamGCv+NciLQaenOJiSriOYPysz1g9QxT51pgxGwUpcRWZ1QmC0AvVikecBUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 16:43:54 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 16:43:54 +0000
Date: Wed, 29 Oct 2025 12:43:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 7/8] reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
Message-ID: <aQJEQUIP13ry4f6S@lizhi-Precision-Tower-5810>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
 <20251029135229.890-8-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029135229.890-8-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BY5PR16CA0031.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::44) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM0PR04MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: d82a2d4e-d59c-4447-1d1d-08de170a592f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JAudRy9wX5G25UwyEPm9EZRsWzOBUH4vwvHsIRDjqRjPOXIn8tXEeWsPSoQC?=
 =?us-ascii?Q?MJpBC52oE5C8321/hy/nOxjq2q+1kFlfwb7KZzUh5P/LJR2Qoqn6kyIE15M8?=
 =?us-ascii?Q?gK+BzxzrqAdC10b6moubWWB5ybkLN+dTfg0ym4Gtti2NDpW+vzeE0NEIk6Fe?=
 =?us-ascii?Q?VGERLllTzD3eoHhv3L1kmxJuKrUUYhj0wZR8GD4WQuk1O3nlYV6bAZe4fiei?=
 =?us-ascii?Q?zEIOeqezcK41jNXu7UQS5VoUyI/KTFFHQJ2UZV1ndYRbTfqnsuDCbLJSo7qo?=
 =?us-ascii?Q?+IyvYFk31E0eiNiU0AvE+/dzD9t8CY4RGWPt6h/UaKHSio27yo0NlojfOTYJ?=
 =?us-ascii?Q?PAP4GgInNEsioKC2P5NhpQI+nJYBWgTmh7sR5poaCQGDgfbXRUntBX+aYZcq?=
 =?us-ascii?Q?8GKs9eZ75vd5UBQfazuMvLH2Q2OIQ1CfWQL4KTutoS0mwB92sV/1PMK/dGJH?=
 =?us-ascii?Q?TXGqvxId3s/IrTkDbjl4iFI9Vx+ohCM9yOjHnTqLP8DAqbObEkhS8B6hR2dm?=
 =?us-ascii?Q?jSWH3yhZ2wjHUsyxEjTpygHnSSO6YSHEzlX820j6ha84xQq/8ypEh85mfoSs?=
 =?us-ascii?Q?U0cYUc6/zx2/BtGtA93Zsc+rcotkmqsvRYOa7buR1pKrFoiq9x7iWeBxgTrg?=
 =?us-ascii?Q?33P+9w9TUkrFJHfhx7dU1jPmi3CsK1YKpE/sXfR7Sk5ZqOmjuCc/i5xGzHrG?=
 =?us-ascii?Q?6qC4iVK6G155ZZW3YcSPVdAC+LdtqyMwfzodu+U2xmvw0uFMND2j8k2tjSOX?=
 =?us-ascii?Q?KY9Gga8lVLutaEyyhLSh8nwZpqzvr8ou8zsvZBjdXFdR7ovYIrjh9Pv0i017?=
 =?us-ascii?Q?OzcDmvekgmh6f0YmN/XU92OR2G448BExEbPzauJCuLP67+uw47J+Dfbh1+pl?=
 =?us-ascii?Q?UYq2qhLvabvz0Md4Fj/GMt5TmYhlhso3opVImB+PTHhRIN7aLwS/wudfGVOJ?=
 =?us-ascii?Q?Oy6wqaKLE8YB4AZvRuVv4JNxysxAhwFdpFrTpXixMKe6uz3xDgL3Y53oJYt4?=
 =?us-ascii?Q?7hBxOi6vEpf20TjWYMXdikYf4jnyCJOLsLPPWAvfnm3JYzsusucOoyJCa9eZ?=
 =?us-ascii?Q?+QwSrXou7E9sg4R3nzN237f2MP6Dnk8r+TDaIYmTuEjTZzk81YN4jRJVcle4?=
 =?us-ascii?Q?UijkH5x5Iph/Gwdy5N35fkwBbCb9BMVTv6IRHJeL/mvxuRttJL+z8zXMGfnk?=
 =?us-ascii?Q?525N+BBHe2Ab+dO9IAQYUZJYndxddU+Wb7xESb7phM/vd6vnQosf2Td9hAA2?=
 =?us-ascii?Q?1owF6kNsMsduWCBaH64gn8HrveSqNP7BynnA5+stB/oKnadVaH5uoG9hUVQU?=
 =?us-ascii?Q?EoyxdwaNBVtQB3nBi6XDVPPaa87jTHSqdNeKD7ZBWpV7h255vINTnTiT31vp?=
 =?us-ascii?Q?6lDDvnxHcE/2POtUFu/qiKYu4MxeG646w54W2dmgpyKgXjpbH2Mok1ZBFR/J?=
 =?us-ascii?Q?KqBmp9mOpLcsQEhbOU8/Kt5/6wBmKrEAaw4DeXdlsFm6lTjQRasnDdl5PFqq?=
 =?us-ascii?Q?UYA1SkMeRS7/hknQjU2LbcvdaN84edMkyrMp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6H9pPgt9kOR2K+Q8J0tBGDNi6VrBuQToOL1VtwJCyC3YX8z4OVmqUpDkPrkM?=
 =?us-ascii?Q?hJx8CM0aajSgiPOFNfX0fr38Mh129B/RpOydnEVe0Xt+EHZAU7c7JwmTvPZS?=
 =?us-ascii?Q?ss/hZTfAWiW97br9yOj3cCiEi3FJf2OMg+w2FxA4A+O5iHm5RplDkPR54kY/?=
 =?us-ascii?Q?TRSHVPHMcNBN35Zk1PhqKX8AAPl6GRTThqlNgneG8YJYTbV/28HnImiAj/q+?=
 =?us-ascii?Q?QPNTJAnqHUTObQVwz1DFyXN9S8+mscAqfEDyHN7UMFFBGD4JEnbHObP2kOcg?=
 =?us-ascii?Q?oYOAu+HwYt9X9PlFyYCrHjOIOSI/2sd1gmSVbLS0ZHGdcyTFgVGYCONke/G2?=
 =?us-ascii?Q?kanRtjthHqJFTXAULzDRkT9GUxs1+hbTSiBRfsHOsXxIHyMIXBfETQGxdKeb?=
 =?us-ascii?Q?VdBLrcDP0V6y2Pf68ZzwUk1v1SwzC7qkDNV9bQWtrYCuIKxTPgPs0QgZUzfX?=
 =?us-ascii?Q?0THlcexfPnHsQ6SXBMA5kq6px8VqWCdRNjrt2vv1KbSRWLlDUW5W23uEbXED?=
 =?us-ascii?Q?RLtcf9uEl8jAt2EV77zBWlyRa6O//21eCvqYCBwYYrxuwSvgBsxO5q7RFtoc?=
 =?us-ascii?Q?6XmcvNSRBcsV4jKXXTI5Cs+RpF0U6o8wy6cI2fQ2AWCEkugxLwF2KnOL2U4T?=
 =?us-ascii?Q?hosNxMk/DSA3fvkHlAg9nLASaKXL7n7iHKKEEJyIT4/ADFeQKfRKOKrH2nSj?=
 =?us-ascii?Q?RPaG2hHaD0lKn6O43ppyN/RF9jdLTsVmVerMgyW9kWBESIyOouDL+OWG66xA?=
 =?us-ascii?Q?CFKrqOSinBuZK12Y3bLYrCV1odPaRpzFbkzwfl4pag42wkj7qWyswz0mNGPq?=
 =?us-ascii?Q?hRxX/iu2Ff+qWP4nbodpYr9Jso0FFj5qXIcqjnH9hotSvs3tF455xVn/9IuX?=
 =?us-ascii?Q?3JqAmMK+cHqWhKMjOOibPjjsPhAnbir/DR1OA4u6z1guycpPgMrnpoSQfY4s?=
 =?us-ascii?Q?U+ZEAezHkK7HSJaYt4LZUycEP/zfYcRTLJG6LXdrXqkT7piUmflf1uCD7F3p?=
 =?us-ascii?Q?qN2F6xpK6k44j0jDPhQHovFply43cIabzlaBkLfIgJ9EasAn6q/DcFE2XRcY?=
 =?us-ascii?Q?9q7JAQp0KF/46ek+YgTaDJFoHbc0YFHUZWfpzBCo4dmLxq7YvIjCBSvLf9k/?=
 =?us-ascii?Q?BDxEmYOAjL+agQP1ZXbbg4DeYFnvJjBz8nQhOCnm7GITV/TuC+Q0VNJozfKN?=
 =?us-ascii?Q?2+g8rtX/DXLqukhrAoFDaWrIG65zlX2ei+urdHNWGvHS50oJ3i7tUruQf4i4?=
 =?us-ascii?Q?5ryFfV03bQjQAinCDF1/C1LH05GdtAZeEVRP1TUKNuIzzK3Rj2U/PcEyI+Xe?=
 =?us-ascii?Q?bHTB1n9i0X6bOLOouG+qBPMV67Cu7grQNf5AnvVy57u+afhvCTM1sixGSBri?=
 =?us-ascii?Q?ftWZf4yR8+il2MsH4je6LV6DuXfaRR0iNUBoibrniZL+JjOFQcj8k71/miq5?=
 =?us-ascii?Q?6zfenzgmeQLdHqidsYx5O+zTQ+MdPXwVApUB9R829Idnq6lLTywHVjF66sH0?=
 =?us-ascii?Q?XgVqbHuo8BUgY5jboadQk1g6aG4NMOySWveQ0hE2MYVJFRkGs6TVTXXh1I/N?=
 =?us-ascii?Q?SbzMPWLu9ZxNhGdYovGsipnAXm+pahymoM2XkgRF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82a2d4e-d59c-4447-1d1d-08de170a592f
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:43:54.7644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBWmY2+7o9F6dzlQeBVixy/zPMZ3JRampHDepkbT6d/J1hBmw9GVIIL9k3m065W5jdsJbKInEuoIwWuoSWJv1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

On Wed, Oct 29, 2025 at 06:52:28AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Support i.MX8ULP's SIM LPAV by adding its reset map definition.
>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 45 +++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index 5ee5a32c6950..4e420c6b8fdc 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -3,6 +3,7 @@
>   * Copyright 2024 NXP
>   */
>
> +#include <dt-bindings/reset/fsl,imx8ulp-sim-lpav.h>
>  #include <dt-bindings/reset/imx8mp-reset-audiomix.h>
>
>  #include <linux/auxiliary_bus.h>
> @@ -17,6 +18,8 @@
>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
>
> +#define IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET	0x8
> +
>  struct imx8mp_reset_map {
>  	unsigned int offset;
>  	unsigned int mask;
> @@ -51,6 +54,44 @@ static const struct imx8mp_reset_info imx8mp_reset_info = {
>  	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
>  };
>
> +static const struct imx8mp_reset_map imx8ulp_reset_map[] = {
> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(25),
> +		.active_low = false,
> +	},
> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_RST] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(16),
> +		.active_low = false,
> +	},
> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(13),
> +		.active_low = false,
> +	},
> +	[IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(5),
> +		.active_low = true,
> +	},
> +	[IMX8ULP_SIM_LPAV_DSI_RST_ESC_N] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(4),
> +		.active_low = true,
> +	},
> +	[IMX8ULP_SIM_LPAV_DSI_RST_DPI_N] = {
> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> +		.mask = BIT(3),
> +		.active_low = true,
> +	},
> +};
> +
> +static const struct imx8mp_reset_info imx8ulp_reset_info = {
> +	.map = imx8ulp_reset_map,
> +	.num_lines = ARRAY_SIZE(imx8ulp_reset_map),
> +};
> +
>  struct imx8mp_audiomix_reset {
>  	struct reset_controller_dev rcdev;
>  	void __iomem *base;
> @@ -179,6 +220,10 @@ static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
>  		.name = "clk_imx8mp_audiomix.reset",
>  		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
>  	},
> +	{
> +		.name = "clk_imx8ulp_sim_lpav.reset",
> +		.driver_data = (kernel_ulong_t)&imx8ulp_reset_info,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
> --
> 2.43.0
>

