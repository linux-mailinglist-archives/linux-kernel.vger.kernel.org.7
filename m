Return-Path: <linux-kernel+bounces-861683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CF0BF3570
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279AD18C0D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EBD2DFA21;
	Mon, 20 Oct 2025 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YSmNyDtl"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204B2D47E0;
	Mon, 20 Oct 2025 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991096; cv=fail; b=Wj/O7iKDBEO4cYz3h1qhRL7jTUikHLPxjb84ZQ74bMtUSs0RF7BDL7aaHoDeuHtZIPPjrQhNg93sLP95RqYnWPKcrPFLoCxJZkOBvVkWfHcxOWKZAuQR3declw8iAnWYbp6ieWGFhYLjb0cTRUBaDxpAZyhRl8ONBs98gxjAI6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991096; c=relaxed/simple;
	bh=Ld7Q7VrDn0oFNZztTeGtpWIEwkpYPEq5X5ktJHPyv5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tyrMumr0fUygRpvf0bp8oecEdAbFHRXX3GoAvhroi6VOBNK0gRh2YRWIVcFBcAJiEbRj7FDAygPhA9R1GT2iSJN4elOhNrBJJyW3nP8HDaFl4m2nom5tKY6WsV5nkyij03yym2uX1und41eLd3trbLTz2PfIXjleTFU9xH88XkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YSmNyDtl; arc=fail smtp.client-ip=52.101.84.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7unm9Q/i4SsrDOkNRw7laaJZ1Ch9eQLYemv+7UbToyVv4OtYL6t0H9mxuKG1r/0JF4CN+7i4YhEKoQQYs8et2YO2415HOM0rblhPWZZpOKNRmcVYQCpKB9LM8HF9PgYGJhY1GNZqQNY6i4fFQOEkfkH+RkOhKVI5xTRcAKEBCU2TxdsMnQxtgM8VyDHBl3M/qM977MRHYTwBLey1EnenSxsm1ZQl3+RM94ShxmnKO28FDOOMXyaK4iNiQtx8nDxG27dU4/nCAHnpndHJvns4fzpemi48KbgBLB5jWcnTUKzWQspshIfnm0sYs0vdCkRoOvDJgh/kLzz8U7s25NVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCRUL55erqluwDc09HrOkyqDRBdAAtSmu0ZV+qy8P+4=;
 b=LH8SLmwXR8A+gaqRgGSdeQpZxaJWWUJrX73g9oJ5QfuHrxbRS7n1/P9xmKws0da/1+amRh/PdOvE3UKT+TdKT2u+j25Bn7Y/HW/DnMm1ht4CjMT91LxjyLYYyS562gH9cIOHglu7dc1y+ridLgipX8HDWQrKeeKk+zrzQUUDLaCPzAwCSKfvg26OdS1yGF0zue6YUbcAUDRXeAdD4n35tWdAv3LztIrC1QkfwToDC6F5IXwqXSLqyynxwWLmOyWbAWhjwOM/pkLCCs897fqKPZdjzK0LbHDAxAPfYZ7T8grBJwUd1xStTvHxgsuZ1eUF7+lisLpJBx6jEOJl6eX1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCRUL55erqluwDc09HrOkyqDRBdAAtSmu0ZV+qy8P+4=;
 b=YSmNyDtlcLrlxhWX6y9eKtjXrt/FAt3mT+fOVQVxOHfytXNl104TKQXGRAVXt7l31UvKQlf4cbLSMgxY8I8ZF5CuBqG6SyFhJlK6uViktBe3IkgE/BgpYp2DowEIR6e5Lkz79YD2dpWoozZGtRPH/ptIrEW3A0chnLDGDVbUc39XAlgV9+Od/3Zg5fRArz5pd/s00CS41OXp/StzEBJM2yyThTj1r/0jtvWl1msPDuZdlUUyEw62R9+7aQnzybxhJuFYVk+ogHSjv+2Yr28knm6hF/4vN4VUFSvZaRE1SLgxl1D/yYCz2k+mM+FYj4WymU+FmX65iA+AhYHSLE1UOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 20:11:29 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 20:11:29 +0000
Date: Mon, 20 Oct 2025 16:11:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: fsl-ls1028a: fix USB node compatible
Message-ID: <aPaXaFigEh50sdZC@lizhi-Precision-Tower-5810>
References: <20251020133754.304387-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020133754.304387-1-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU0PR04MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 445b596e-e6ae-4883-05a0-08de1014dad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uI5pjZjF/lTzz5se0efMa0he+kER/cOke/erKHzuRO8h8wAGHutdPTnGsGZz?=
 =?us-ascii?Q?UpZMGvJWVj1JSRu7+b/dHaDT/QPLLkcVqw16OBHmT4mjcymxp38MZSMAxtpj?=
 =?us-ascii?Q?TttSx4rXvsC92QTQPblHmBHy7ognYEMrs6Uy+ADLL0S0zWXmK1cYT/FAZPyk?=
 =?us-ascii?Q?6pg+vOU3osp9ZLoHudugDYGGHgmzBGDovghyRJA1WZP/EfQSWSOzjbr7IImZ?=
 =?us-ascii?Q?A9RguhDzB/P1ISXyuTs82csqzPzfUjLHsXMy8ifxUBsB6PvPq6gt7vBR6AG/?=
 =?us-ascii?Q?AvSkSrCLc+9O1Je0+78SssoUqA4AcfnaF3LRwdr3d3HeYBu7d2Rj45onXA3s?=
 =?us-ascii?Q?jF2MY7fsjLcNaxD53T3rXKBpTq0gD6CJcIWdmbvMwCdVNYYPyjiKbKNtD98o?=
 =?us-ascii?Q?Jr1sLTghC0EY3cu/VWxO+QZsPxzWnm2KoEpt3V+yDql0oEbXuCXsr9nJ6I35?=
 =?us-ascii?Q?CyLrHdfnohlRByKDWKHqDpsAcoiJ/RXvWleO2N+v+sVf4X/VnQ9eDOvQilfl?=
 =?us-ascii?Q?sZNuYmiZVB4MAWsDuKQbkeT41D+P+OWSHlz7qhs6YsFdTaVC1/H2QsZZ5lPo?=
 =?us-ascii?Q?xMlvu8y1tfM+x/1x0GGNL/mJeS/uwdIs484FWWmrjtpdIRc96jDKpt2KP9PM?=
 =?us-ascii?Q?8M7/L06zfzxR2VdociBQmDxRobmfrPl9cLhOhi1dgbeEX5v2z+0OTNhjUMTA?=
 =?us-ascii?Q?nyEtOtDoasc4C+cWnUA0xZBKPgXkiRvtil30ktohukTZDBOxEeuPk2PzRxuv?=
 =?us-ascii?Q?KJYQCwdP4YrLkngvyaIhu1Af6Xqub04Jl8G8B/ccT3cUp8VogoKZ1faTftGt?=
 =?us-ascii?Q?Tz3XlRbCLS5nhI/QzAAMvxMHx2/h8gLWnrPe0D6JyQdIjy7jNRARBt1fBBXB?=
 =?us-ascii?Q?8TUOET2CXFK0IHbuJ7rjbZkRM+/6iCI0YlB44EH22fwqW9T9rHNVM/DV1V7D?=
 =?us-ascii?Q?E+bzwCfJ+Eenv0T02VMy1/kzp/FGMWvC5P7f1vRyUw0I7ZIocDP1gUa9fg3J?=
 =?us-ascii?Q?e2HuPhtL3Qwa0g1B6CLBWHDGKqTeUXcQR13UULZsiGl/aslzqiEPpN4VDdJb?=
 =?us-ascii?Q?80EUjPpuRouGF/TRjaAo4/MVjn+ywZUT9/r0Wr6Cfn/9ujO6PN05rmyOfI6k?=
 =?us-ascii?Q?UA6oiKETspo/PijlyfeC/AverHuIbqRFSCnR0l5KPO48b1CZO+JsrdIJ22Wp?=
 =?us-ascii?Q?LC5XcnxaY7OtpWUfk0Yd1FpGAwF/5j1bsmItjL3cVTQnp5axYMzn5tsbHN94?=
 =?us-ascii?Q?9Q7p04oQmwGRBowljigKJIO3B1rqG6xIKQ11jsSr3YkEJHGhlS4WCR0lZ3V2?=
 =?us-ascii?Q?MIruiOED1C3FLSJzVtlfRYhTOjhdvW7pidkBTiUn5//tYHCw7F8xPMldwmgb?=
 =?us-ascii?Q?PE4cdYifWsi95VwGJrKV9QRmZ39ghlnA93o9dI34yb2eS7Ca6nWqECQrLph1?=
 =?us-ascii?Q?sfvBRElSrwcHwvxdjYrqKoaJpYSrTAbxT3H2g2xQxi6BLIqX0X6XwE35GpFt?=
 =?us-ascii?Q?F7KB9lbVJA9VHRseR+yUCVl4QouMp+DjQuLG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GwJu3MiT+mw/zazmHE3YswzVcl9iQQTTOYm6C0jF59PW9rITwqvjeYwU/Bd3?=
 =?us-ascii?Q?dPqXzVUkpB+Mt+HCYRYgN++FHD9xFgBSMPS95AbSt7Zw0wzFS9b+WnrVhNMP?=
 =?us-ascii?Q?ttLoLIzmUI1PC3FeJ4JAhClSSuPasUM+8KcfOGR4GOaRNEBZJIvKxf/bzJQV?=
 =?us-ascii?Q?jFtZtpQKpKkd8c5sXJGR1ji8Xnd5/A6qsIlcFadQYiIK46mrnMeG/JHzX81h?=
 =?us-ascii?Q?z/JqWjK12lIhqJyhoEp56XnYgPdjL23cQd2xHBoRvBs292u4+fzxMREKrQb9?=
 =?us-ascii?Q?cW9b1gAG3b6aMGiSh2ePShuQfTO3mSe+bNHio3Bn8t7FqK1SnrOlUuQg/+bZ?=
 =?us-ascii?Q?ZhbsY8eexfNXGhDu6dnWlehsxL2xwYABZ0zioL0JcUua6JpqpdOTfmVZxRHW?=
 =?us-ascii?Q?On+4o2VmtmACMnEDCSLJvmsXHZOYwZys3unfdyGiO+3V5mu6eobxooPRFFs3?=
 =?us-ascii?Q?i3LqvjX9fu/oldV39CTzpdSxCYrFErAT8tgXCNqibDYI6a76iC9UvMtujoVQ?=
 =?us-ascii?Q?8jt7XJdbWcbw6kX9bOXHbndpz28h8DQyZz6mwiLe5YJhp4PhR4Zv8taOVQoq?=
 =?us-ascii?Q?/95NoYRAOvBbb2QBIyIvHU6fdEl6Q55uvKdNFaEabVz74gz5xfJt3hhEu3f8?=
 =?us-ascii?Q?edFFMu6/zxgjbyQ84glSo8E5GlRFvo859L/hbGCgV/ZAh8WrRE5hunNT7iXj?=
 =?us-ascii?Q?m3rkYCs6B9/fjgEWEPhNYM6vvneUQzFBmop1dzoujdSXdUHHzEbsbt/BKIBa?=
 =?us-ascii?Q?xHMAFedlBf8BCq4MxIqeEkKoomwuIgcyqDpsBhStbgG+knXcnek0sNghbO1t?=
 =?us-ascii?Q?otAonN0ltjkg5dRbtcJyWXDg03cAivn6uispmC8n/ACUUogVuaCb07zzX596?=
 =?us-ascii?Q?wnf9zi5y2pVkycIdpeb07DZTtvSe33fWd2cNgTP8HPENjTdYlqxg0wOv/hb8?=
 =?us-ascii?Q?mYLD0e+i5NjeGIq6HE6cobFgLTm/CC/jPvezejkQ0WgKnt+1COJHi3e1WleS?=
 =?us-ascii?Q?GhkfHrpY7BW79VFPeprB0xORtgZ6pMNduDwAyO++NpaBd1/oJtRK0YNjtazC?=
 =?us-ascii?Q?H9VL/paJ+VMWXbTFoG7mBG/9kxzjPLYqdcjahyItqWHTuawON4aWOu8Ca1V6?=
 =?us-ascii?Q?B7iaqGbiNRAnVocrf4zNszRDIiR5wcJoGrAouV/ia0aDaGNwjFd99G5K1he4?=
 =?us-ascii?Q?XfCE4j1sbQma8YhgYyBTOdGf1v6UQHXq2qE/F/+oaNNcQSvxn0++PyeTtu5F?=
 =?us-ascii?Q?j4NKbrum2aq+dJxsvbdd7AofXsDfXtmGIbbjrAhazHMrdie0i7NaYj1Xqyw4?=
 =?us-ascii?Q?ZWl6mBU/hUFYLkSbQd6zUxW784a1Yg47CYfw95KCQDmz/PlC50BBUMyisHYM?=
 =?us-ascii?Q?MyxknrKT9NePL/lAq2PTS92X0Ri/VfM4osEySwOQZqSgqpJ27rIWltweiQBG?=
 =?us-ascii?Q?bgx2uP5ZYJkCXbvW1YFDpWVcJ2WTXBf9u5H10P2rFE40jdKamyANPYrBYHwc?=
 =?us-ascii?Q?byPdDJeyrE35kAVIP8sa8iV4PJxOnRQ3coyGkYCdOGPZa85onl1I9je+Sf7O?=
 =?us-ascii?Q?v87MtED//25WW3BCYDFzWmRuMlQtiI2vG0iu9P1X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445b596e-e6ae-4883-05a0-08de1014dad2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 20:11:29.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aH4XjKUWvMyg5SmoXOYeJ4f69zLrPY82XtWFUjoq/zSU5Yap1hGMrsVUm2kp8MWPO9EVzkB3rU6q5kngTU8ouQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

On Mon, Oct 20, 2025 at 03:37:53PM +0200, Alexander Stein wrote:
> usb/fsl,ls1028a.yaml says the compatible is just a simple
> 'fsl,ls1028a-dwc3'
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Thanks, but it is similar with last patches of

https://lore.kernel.org/imx/20250929-ls_dma_coherence-v5-4-2ebee578eb7e@nxp.com/

Waiting for shanw pick dts part.

Frank

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 7d172d7e5737c..ddfb007dda920 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -613,7 +613,7 @@ gpio3: gpio@2320000 {
>  		};
>
>  		usb0: usb@3100000 {
> -			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
> +			compatible = "fsl,ls1028a-dwc3";
>  			reg = <0x0 0x3100000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>  			snps,dis_rxdet_inp3_quirk;
> @@ -623,7 +623,7 @@ usb0: usb@3100000 {
>  		};
>
>  		usb1: usb@3110000 {
> -			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
> +			compatible = "fsl,ls1028a-dwc3";
>  			reg = <0x0 0x3110000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
>  			snps,dis_rxdet_inp3_quirk;
> --
> 2.43.0
>

