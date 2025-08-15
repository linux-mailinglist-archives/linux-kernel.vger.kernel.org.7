Return-Path: <linux-kernel+bounces-771181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E200B283DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A046032CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB4830AAD1;
	Fri, 15 Aug 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jnw+EA5z"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011060.outbound.protection.outlook.com [40.107.130.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96A2D47F4;
	Fri, 15 Aug 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275641; cv=fail; b=E8rGXiwl0uQ7Hdp1l9d57/zifpdfAkwQlo+//UBT0AQaC0ayUnrTwX8zQkIpH/1BzcY+cbLaaI8p5/KzcqX0TUgH50CCAbOnZkrdKX1bpDyaOmcZZ3vQXJRsLiQ374sl6rILKZCwD+7qrB+xasanIQgEDdGrmgYrXGzny7ERWow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275641; c=relaxed/simple;
	bh=ID6dRBTbRv1xcgKngsHJ3AWD4jq0gbnNNNeXoZi87HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sG+ZIMhzGkOenULV70RWCKefrt1Mz3Z4hgDrpZZaVU4r3MeyaepM2Me5w6fOSpbkWXZXyzP7ykI3Pcxkcmpt7/jWHKySZGFyIKDdqSUtLHoq2WxXA6e+2SVo0JdQHXRmbgoQE3aOI+7yvp/nLtfsUku5Ug5PSpZ60rtV+k7FAq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jnw+EA5z; arc=fail smtp.client-ip=40.107.130.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVLIdb2o4T5+DYLmH6GRb396nhXbe6u+WHVWLI84uZOTWlpjCjkrQ6OTLLbO1tqE5Oe+7Z5v4/YbWtNSnLw+Eja36PhwLf1Xr7Qi3eXMZK9GbJ9JC7ZQlGffwUargjKTWeatS4bhRk/FLed1QU58ELMzM23+o20WbgBbSINckKgeo8moCSdRqi2QTEir8P5I85HWWG3wUS2XdlH27Ef9guZF0yRn29k7K0bsKLs262994GZZ2COtLq85N23LhFAjFdnlDW93vpUxXoOaCuTrVJ2nunF6uqqcu+sRxaN4OG1miXrO3C5I1Ft9mxKR6nkjx9ZhfxiS3zn9ZXxZ21oXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xyRFyv8bRpMKQO94kv4safNVESBh/g4X+brCTw7fi4=;
 b=ywOUvMsApycb8FuDBkDp7rg98ROTrNCKfEfNFjaisJA2umTzviosBoM7fEagxDX2e5vwZS5PHg2bl1rTUn5WUKPTbmzd/29IchOaWFFjzHiKhzyev8XAm+QT0TMBcVGWltjXKy6DxOzmnsR4qmnw3vaNb44oS8slwgOJOqHIN+BqDE9gozKw5zldw9Mk8HZHIERIXVpSoDLX91JstJMsBaCjcRSD7mhbMvNlsNTegkZp9Xr1ikW5RgTm8pRFSMRvsAknCufLOth5T5wzYrmyBP3fas4h+8BJ4/86lflFuhHNOYoFY43zf3TY+IcJXYHMocu5UfokGa9ZiU8NfYjVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xyRFyv8bRpMKQO94kv4safNVESBh/g4X+brCTw7fi4=;
 b=Jnw+EA5zGXWP+c/UdgXh/s+fmeeGH7Mft9A+tszH2kNsD8gkjw0YUIGlnat2sTYptciFctZhFg8oenKpNAGZAs0pglQedcwSBovMiQ2khN5/kflLDAU1/UHOD7MLgbKfz7Zq20KHsvPVMXY4/+2I8m278ZGmOgcXrgTKpxzNziifn1qm8WiORSslQBzebaNxPDtCetxTNeVYiF+D5Azk8bU3/Tve+8vb0D36H/NsUnr9HQbpiXIYRjnGc7/ii7NByD319SCdZUAKH8sjIXZ17RXEa9h6oHGqkdJokQg8Vz+uiaotiAHKiAzgxDME2AEv+Jpv+y9h/ecXoa/r1G+wJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9595.eurprd04.prod.outlook.com (2603:10a6:102:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 16:33:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:33:57 +0000
Date: Fri, 15 Aug 2025 12:33:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] arm64: dts: imx95: Add more V2X MUs
Message-ID: <aJ9hbkSrEiDL24dS@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-4-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-4-e609eb4e3105@nxp.com>
X-ClientProxiedBy: PH1PEPF000132E9.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efb2a6b-ea92-4a67-fdc7-08dddc19883b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5SKBHT8LlYDj0cfCj0I3XiMMNvlq+kSQqWvHop3VyA3vf5xV3nh9POqScKxL?=
 =?us-ascii?Q?Ccv+CjwWaF/TptutYNT6iOBRLLLgmwmsSKJOrNgc995u8PvQWvY+dgSQFJ/+?=
 =?us-ascii?Q?VLLiBTbVQm0hO/IKUtvwCQGMcYhSuw+L73RMU7J9ctKY4psVS9grZGrpXqHr?=
 =?us-ascii?Q?gp1G1nC7+x6Efh6bdn+f8piaqXtsiORQtd4LAMkuhKHtdZUdxvUGfo577iPp?=
 =?us-ascii?Q?giIA58iiJrs2snotb+T0Wo1r19581mR9V08BW4hEOt8cNfMNL5QSEiDuDnUx?=
 =?us-ascii?Q?PB6nWQZYsEX+aCUn6GKvHO8RtaBXL0XRNbsagvjpm3LHMZ2h9r8DgpbQ/1/7?=
 =?us-ascii?Q?iOm0d/iQgD0iFIT7tYMqI/srrn3c2NzU44qoAWf1/KsSldqraPtAmfOn5Qu6?=
 =?us-ascii?Q?Yz4N7E9vy7IhuGi3hbqcRNN0gRQrSqT9tzl0+JSi+6cgRGGS11iUTmhHi2xT?=
 =?us-ascii?Q?qe4Sa3SG3aF0eT2BmrlgW0OkQo/tj/4llwGLppisy19mlfZOWeFWTww85nWd?=
 =?us-ascii?Q?D15fwd5dnh/bHtmlasIixoeNi+R7MFhyqk5WkCTidDrkow2YKfBA743FCjbi?=
 =?us-ascii?Q?PjAnZyl90BWXmvF9pVoD1G8CHiGNE0t3guv2svKQD0AZ+vY7vpfjEw3MBVCO?=
 =?us-ascii?Q?YUBm4mCtO67JsJK7BkT9uEvAAlfZ32Pgm5vRRFi7Tuw5Otzazv60d3pghe7q?=
 =?us-ascii?Q?TrTNumcr+0hB67PD6IBcfhLtVvbC/Qo7E7AihuAlex1Fc8xhVFP1ARAXbrxe?=
 =?us-ascii?Q?8uIBxZPebdTRqurNCnvaV4jZyP+f/kipWfcryRJ/qtdL8fXs2yhGisJnkdM6?=
 =?us-ascii?Q?rXPXU4ti6tWW1Sxi5cClAxezrfhp8AHtwiohAKdLaOTWhr6hstpsp5o36huB?=
 =?us-ascii?Q?lmI+LD+DO0wEDqQ9zRIk1Ulh+ISZq+SWWieBhbQOqJfi8nglc7VawTgqUDMR?=
 =?us-ascii?Q?cDqPmAuN22umjI0MJ5LdccdlOe0/tXu51F3j9CD8sI/v+JUo3sIKkBxfJlmJ?=
 =?us-ascii?Q?AVwKOMRXJmh6NBZwYQGfzvoJAc6uqKp7ZM8dWSJJQnqn3q81lbxjEFhzZ+wS?=
 =?us-ascii?Q?kf964PDC08XGpvVmpbUemqlgdd1DoWH5gBodZSBLtOOD73bYbgokWT23Xr75?=
 =?us-ascii?Q?SoYO0Yn7dOEgzhyjHlCtlDx+jmwY8UMDcCQun31UxdxS79vF9uECQy9qWja3?=
 =?us-ascii?Q?wl5FRn8x7JnqWlk1QI6Tsu1xS6Xvd4IL2i1O5poq3E9mG8UXI8qmdjtG1ghV?=
 =?us-ascii?Q?bdChqahsB+ST9YmCJwDrIqo+yuDBGxpUSkJXZrihVK5U9CSkYgFGq1Jx7eYV?=
 =?us-ascii?Q?j5+jCAmkYzlzsG7cQgtr38B2wC6IyEABa4k7gDKSamqLOIfBRb/QIwVH1IXE?=
 =?us-ascii?Q?Qm3OA3mWF2EFONx7G4TSYb+xQ/VWsfB0T4xkLGKEqb38rqL9BWw7JPTJmMH2?=
 =?us-ascii?Q?EbiOpDWY+hOdXgn+OPnRX1e2k7EzTsePlyxPuMA6VUdUmx+z3wQuvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zru7F5Sv7D4f7MK80MqaaJ93D/pa/pT7GsoKmJGjPkRhvB1Eca/Zz3i5jhY3?=
 =?us-ascii?Q?8mxvxXo3h5f6f+k+iDnOuU5G2M6oxnUPG3Zd6yMVQNRfiNZ3wVDbzShzm7l0?=
 =?us-ascii?Q?Np1iSTF4g3sW2IA7hkYwQmg2IZFvLuopAMx63/fHEeDX94QYugNO8tWcyi/u?=
 =?us-ascii?Q?vMzdbQ6S3CeFedLmvb5CcMWJMSccJBKgFKvwlzY+gzN52npLaPvIdKLohEMo?=
 =?us-ascii?Q?AwCA//tM0XjFWQx3ivx8CaHcdOXJzb60m+w9uC4wU0+iTH2EJzOsQuuT96w1?=
 =?us-ascii?Q?x752LkJEzKFm3vE/dNRK3M3lSN8TZIso2ky+g3T/1fyVCk6X2UcY1F7x/0D3?=
 =?us-ascii?Q?/WK11G0G/gZNVIwYUBgQ2S/haM8ZczgljvAHrcNbc6gZkwh0U84Pzkh3Q7rY?=
 =?us-ascii?Q?64JY20uYuqqG+FQzZcsEJjc+R+1eavpXyp0kvVqUviRSyCPSyZXu5j5mIMds?=
 =?us-ascii?Q?yNhgK7BwnDX08eNTJEv0ziLBcIz2dE32w4t/uuoTvGs6PaQnpbZ6dCJVRTy+?=
 =?us-ascii?Q?OdHkkfoW7MjVHI5e1n7L1zUiVdeulcZdz2LI+SrHIR713JotjxNt4lc66wlE?=
 =?us-ascii?Q?1mtfA0BLkP3EoAmr7yE/Q6hS7RmS+BMdHVd80/Y7pgFzjtwExoFCr3WZdu/1?=
 =?us-ascii?Q?KEFo5XjOrDRFWGK7Nq90QtBYB6bubvdxu/zGz6Lyw6yA2HS0k2tFWMLfvdb8?=
 =?us-ascii?Q?nWl8GG7+mTs8DcyYsxoDomETYXHT8putlm64I+dy+v8WGZq1TIfy6U9Y6eLX?=
 =?us-ascii?Q?3/6OXYG11DjxG3H7eVldtIfgq8bcHf7ZwtOmsEqvp5l1TxwWkcG2o2PpvI8K?=
 =?us-ascii?Q?RlurZ5Gkiki2k/SToS+8PfcgNh99eNDxwsiqQbt2bnvwEdZyYvcjxwEW1UjF?=
 =?us-ascii?Q?kCotv/2dlyLMhbxpKZD9Y0uDEsoWuCOPKmzy2NG3uijv3pdzNHUe3floK0SU?=
 =?us-ascii?Q?JgjFvyAjZ+nTAUWLlT1xMt0/MkYz0eG3CFg2rWQPWsj4ZuBF6rr5WvEY+HgA?=
 =?us-ascii?Q?WKBv8P/5bHZfskQRdmAOO31u+v2xAS6/Wojt1mUmh+jsgLM5jzs0NLx4plrX?=
 =?us-ascii?Q?+ik9bIcs6UAJdQqrtUWGRK+giB7ankH++NUOPbhFX2GsZBFdT2Pvyt/Y+Cnd?=
 =?us-ascii?Q?Za00rM5WMB9VxSC0coRDv68T91GdQVF2pQhL0baiYbBLHmQsiMKH5Ww/f0ye?=
 =?us-ascii?Q?bpDw7iUgGJl+n3XvceDW4X5QBs3vt7C4/slNpKOvNAR153SCT846Gku4+Q2q?=
 =?us-ascii?Q?2FQU5u8LmMjEDx6zYYMEMesERVgaDjBCtbr3B+MyVLmUusxZ0qx1holYNj1G?=
 =?us-ascii?Q?YR7pNGzGofWbvnMfcbhxE4OAxe3YVXuGYse8X4dEz9KyeKDcLF6Tu63Chv/V?=
 =?us-ascii?Q?OW22rO64Je0lLeMP8IiatajGeNsHEqIm8nUhzv9RtnVnXdUr1FT0ozE2V5s2?=
 =?us-ascii?Q?Rce9aqqVBqh4k8vmaVsL98TrS6O+YRTsI6V+zG+dxCXGuRXABmEZfLLkBNeu?=
 =?us-ascii?Q?cY/iH3EWd9MpjVwBKhKeUh3RhvkkhEamlZKBIW4ZCJ7/MJwEADyv8oNdv4W8?=
 =?us-ascii?Q?xM41RQkFbvx3nEonG1Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efb2a6b-ea92-4a67-fdc7-08dddc19883b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:33:57.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bn9wr0eEAqYZC1I6EBfthAMIfnBh8PVLZiiMbJxO1bBvytwZTGtAxXWo3SrMx+uw72MdePuIBdh53N8Ye/Uw8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9595

On Fri, Aug 15, 2025 at 05:03:50PM +0800, Peng Fan wrote:
> Add more MUs for V2X communication
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index e20feb1bcec6088949e7dd1ab2fc1c108393fb81..02c0422a7aa3877c8431c9b050d85f43f5ed7bde 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -1500,6 +1500,13 @@ mu6: mailbox@44630000 {
>  			};
>  		};
>
> +		mailbox@47300000 {
> +			compatible = "fsl,imx95-mu-v2x";
> +			reg = <0x0 0x47300000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +		};
> +
>  		mailbox@47320000 {
>  			compatible = "fsl,imx95-mu-v2x";
>  			reg = <0x0 0x47320000 0x0 0x10000>;
> @@ -1507,6 +1514,20 @@ mailbox@47320000 {
>  			#mbox-cells = <2>;
>  		};
>
> +		mailbox@47330000 {
> +			compatible = "fsl,imx95-mu-v2x";
> +			reg = <0x0 0x47330000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +		};
> +
> +		mailbox@47340000 {
> +			compatible = "fsl,imx95-mu-v2x";
> +			reg = <0x0 0x47340000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +		};
> +
>  		mailbox@47350000 {
>  			compatible = "fsl,imx95-mu-v2x";
>  			reg = <0x0 0x47350000 0x0 0x10000>;
>
> --
> 2.37.1
>

