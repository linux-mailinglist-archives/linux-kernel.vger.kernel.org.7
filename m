Return-Path: <linux-kernel+bounces-722155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA84AFD5F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F0E54027D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6756A2E762A;
	Tue,  8 Jul 2025 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AVMuX3YA"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311732E718A;
	Tue,  8 Jul 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997940; cv=fail; b=dIGOQm7/NCwCfOiDysC5H63gnvPIr+MZ3HSghvtC1ziehJgpAMF/6/1obAarO4FmD1fLbz+OFG70W/MA3ChAK20ZGsblX84nEP8yM5MstA9VMXpDu9EoTT5YUOoGTSyjmLeH2M0zu+A4C7qjMpgAcklobR8ACuRz7GVDQMISKOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997940; c=relaxed/simple;
	bh=249i1UVs8UJ1g1Zp6ZbJ578GlBpa0h6p+SwLOJ5ggvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h/L34l2rPEapbX/yBh4dQz6AJWUR8KTeekdrzrFBjZfhCIuHnvf/ZD3MUJCIuUegVgnbPk85jXZWvR7GluA1aSu0P7ZAqbAHgbApg3fEXfEQYrbk+RCr8g8UmeOcvwGeZuGrkGQh0ZLqLJvZ1fWeSb71HzHpFkRIkg97RlHrlwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AVMuX3YA; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsYFtnVqfoP9di44dSV2bXlAwC47KaV6AZlR5MRSsWxhJ3dEqNc/Hih9buj4JHRcifVxCM8c8MQTRUvrGpX438RUopgc37jSGQzyAtFIJFT5sngamF2VfscCHVmsPaZDyvJ+1boMcuTi0lJHop0BmqOSkBeuvprg+voXh22Tj3jGBf3L6+351On4oTkdSAJwIhyn5z2J+P4xNusmH8wLnn1Pz6BmV0SZTfPKCMLV4TOQYSv5a8QMaBKvzSxHvJ9LBA5NPunLudIYci2ilusEBYpAttLS8NpO9DHMx8/kjQ76TS+4xHdsLYbquzojDDiymXYLmS79QRwFcAZaH58yRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AI02P+wBpvfm357E33ko9raXoeTfBeSHWtT9nP4KDQ=;
 b=mncdExglPwJ4Owf/YyF7WG+xwYfwLhvr4kPG2ZVaTbcOUZNLMiA4OSi7X/3oSYLSfMxdLDSsooeaPK6qE+SuJKF4R8I9l/0cY8kQ9gRS1yUV/ebXl2rUHbvq9ONbgISZGgPKGArV2HtLuQXCrqsktvT8X3+6RV9GtDfUBztDKNh1XyVUIbHSeOexW94JFUAulQj47TtG8kUJf5HotdyemCILzRM4ymtjKKh8/rtopVXXur4beUATVF0DGAjdH3+ftdq749RHlyp2nMM12nIE9wxb1egQhF8ERjyRKyTQxJwAdPHrkI7bCQQ2vZegV3NPiudRNDs1TznQaAHsdzymZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AI02P+wBpvfm357E33ko9raXoeTfBeSHWtT9nP4KDQ=;
 b=AVMuX3YAEyrwi/tGEX3Su/CLM/P3MnHwrE1YBaNp8sS7kNlTERZJ9S9hl5/5QtAdBnAAyY0feH/qWn8LktB/huqrXS5kJ9g7hnVfRC463Fyd2uwuSbIyJj+XOgZ4dXOyR/moXxSq7dyUSe65mgwwwHXuu4TSEVrYPD07dised3UGNYlbm4r8cejeflle77YbIBnVseqgt8g0XvKT+C4ZvSacOxq62geNwaknCqcFvFP63bYV7L3pNqCW9/OLpZWU0eanwAeeosPp2A7nSrq067DvTaCbNHNDjPx1/zhUpoLX1voZtle3Ay/1hA/nqTRvpuzb8LODk24Spl5ZuEV29Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7807.eurprd04.prod.outlook.com (2603:10a6:102:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 8 Jul
 2025 18:05:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 18:05:34 +0000
Date: Tue, 8 Jul 2025 14:05:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: lx2160a-qds: add the two on-board RGMII PHYs
Message-ID: <aG1d6uwjGJWQqZ/C@lizhi-Precision-Tower-5810>
References: <20250707153331.1372606-1-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707153331.1372606-1-ioana.ciornei@nxp.com>
X-ClientProxiedBy: AS4P192CA0052.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b047284-dd40-4a2b-2137-08ddbe4a08f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mEBrjbXMucMe+avhjUvIu96mRuZuKsnpmUD0tcxGg7jjebh/JStq75q7CBwA?=
 =?us-ascii?Q?49w0CFFvAUBM84XcrqxEFc4i7sze3cJZ1zAOVnW+ixZSzaFBPo65CXythxtQ?=
 =?us-ascii?Q?cuRIv0kHr4n+JuJAGI3J1XLwRhBwtZXsVfTDVfcVz81laAFihdRz43oajm5W?=
 =?us-ascii?Q?eCO5SIrUc3hNxjT3kurk0t7Itr3lva6IIuP0wseZaGu3V27O21ZqgUGwRTIj?=
 =?us-ascii?Q?mXinDQhfQUU9vbRU0m+ZUG4NVyNudQQSwb5CBWMSI7lwtFw+PqssOAapbXsh?=
 =?us-ascii?Q?BF5WCKR4IOPW1McmkKMZKT44jwU9PFN1dtw7IEBd5ERbadXroA96O/McO5X+?=
 =?us-ascii?Q?p/DyixCbAeL3tY+6H2qLsLvo7E2MmMCyRUQAwGQG9JGh4jcPAFKrRiOS/vDY?=
 =?us-ascii?Q?eG/KKBozwWayJBr1aBwoEUgIec9JLg2IBZadLXwLJ/GxB59w6FYmNw1TrQrT?=
 =?us-ascii?Q?VBS7HdGp+2iBIUvuH1psTSk47oJPj3iaJ6lBnTai4J3I+JP5Mgi4plGOZAaD?=
 =?us-ascii?Q?mq0GIewKTZpVjC2PCBkPfmVSmNGTv/gC/UsJX0F6d8C47lwXguKFAc8D9kV/?=
 =?us-ascii?Q?mRITKe0Ri8u+BRv8DMvMjanwAX88HIQQ/u/ivAfW+AD/yUvI81DhKOD/By6E?=
 =?us-ascii?Q?Qj/3AXWZyjoJ1YzV7pLAkuMUOS7b/EeHZR9/H7+zoOYbhPUc0aCz3/PMMQNf?=
 =?us-ascii?Q?iAHsFpwjgWBlmNmwtF3Umb074xsbxoAoHb7MiE/UO4CeLsPZQ7zApWV+tMmo?=
 =?us-ascii?Q?gQ6B0fY0AedpC0oMByzSEuWl/loeKKMk+G6+hdfVKdhLzG8618+CeOT7QIW0?=
 =?us-ascii?Q?p6GlAO63dfWN0vjhqxAdIxjXMVYQ3s9uzyXYDrhTcDCdg/B0iZOsJBTZlc+l?=
 =?us-ascii?Q?NhHrNKTksta8vZKFRvqW2ZaHrlSJwmCCcvW5aajbClxnJo0OEqf/VPSP1RZt?=
 =?us-ascii?Q?EgwWEHvmlMA2dR1pAdNAG+2bDJft4jhgqGxfF1n/YcCyf3BmoN75yBcx4SZQ?=
 =?us-ascii?Q?lt6KGid6Ce7J6G7IvpJG4dLQVWX70BrhcbgaduQRwMIdeIj8gHPCdwhlpmdg?=
 =?us-ascii?Q?x9qxXdiest9fN3KYW0PH2RdTBK+IoB8XXuH9lxIVQ7Hnx8HsuWtPp38wxnSx?=
 =?us-ascii?Q?dIl8rni6Vhhim3c71tunQJwMV8LcMAO4MPNHVq+eXHBza6Y5R3WG7yAjF/kw?=
 =?us-ascii?Q?Azfeall6cCgiti+PvC6bFwnJqq/F3tbcbduaYSYuAvmOtf1I/f6SqLxDFmRx?=
 =?us-ascii?Q?8XZKxuXjyt5nUjPetdmIcb+Zz6fedeBL/A2nLPQ9YfeIPP8OplCjt/CYUT67?=
 =?us-ascii?Q?csBtEr/KNwdB6RZR8p17tU/UWEjwWqewD4iNnTBwaf43MnpKV8X9FfqvVVLg?=
 =?us-ascii?Q?bJJVU5ISd+yz1AfWVV7usXtunozX9AvGR/2FyrmPxQHtxyGxq+Qntwo23Cqu?=
 =?us-ascii?Q?VAvqj5p8FZY1hijOC/Bbl0/ALq2I4ARmQV3ZGr+xToNezWardBhQGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s28r7RHLGWdDPbHa7kRHW/g43DwfxbgVPsnb2/OnC9dTJ5tpgZ3EeVDMsvUY?=
 =?us-ascii?Q?Oco/tlwiBz1i/QhbkW55dsSFRAyePw3Ldc0kwKge9rPT8w1X/yPqkQEc1XIP?=
 =?us-ascii?Q?7ZRyL1dnpuyoDXMKjFNpLw0wzq1RhCeCS5vL4Sv9nv83HIOv2fZ7iAob56pH?=
 =?us-ascii?Q?QHNt1st7NtQRV0BW7irOQrPRwLkvqvRex+om1ROwQjj+FZSVYBvnzGEIZbzB?=
 =?us-ascii?Q?MO0yOknPu6BI0simTtd9qCkZkj20nYNvl4oOMBjATXH9MoQSzp46GTl9Bp5K?=
 =?us-ascii?Q?9vo9aGnwmpbMXxUop9pTwxedBibl9Bf/m8yWMhMfUXS1xyBz3O7Sswf5KwKE?=
 =?us-ascii?Q?3VxvhRx+4VG3UumfKQ/O59fqlhu7VbK9mmDunYKaKf19K5a+Wl24ucOickSD?=
 =?us-ascii?Q?qfVJKz6xJtpiV0G2b2bfmCZ6/VUBUsYiVTHa7G/Q408lEXyZ9KUUgltMnsve?=
 =?us-ascii?Q?KHC6Mv9/5WdgKbNWJg5Ldx9Qw2kcWQCyfXAP6SXi+J5fATgewPZCPheUvqHs?=
 =?us-ascii?Q?0uayXVs2gf14VmssRp8YM/urCfjX5t2vuExj7zg9it+4OuWgJtaJn9TJjj5l?=
 =?us-ascii?Q?GZ3XTrYhyC+zD/9D9SZ2Fh1lnRZpFC9wTu68PuocgoKao9GHt0GudmMgJAWT?=
 =?us-ascii?Q?Loo10UiMGOJjD8SAWcHiSwHuTWP1zrZiG0DmqHpoLs6iKc4WZlonE8vxoz0o?=
 =?us-ascii?Q?IncfpL7u1ljet1F1qzqAKd+ZHpkmxjWGFKKGbMJbGta3AS30wW2v9a/66UK0?=
 =?us-ascii?Q?QC1KG05KIz2wheiqA/r6A8qrHrchJkO+pAnzaBOFJ00WDFeO8CIz35UTHX83?=
 =?us-ascii?Q?Ff+we/kDeBNL2ugR2gEg/nvfmBKunAfM9qQjBvj3q6fkdYUh6/O6GBqurdQL?=
 =?us-ascii?Q?hLJF8zJXkEjFnQI3owkL3u/thgDeXD6Yvu9c42VCu3T5yVeB424U6rDbvbgo?=
 =?us-ascii?Q?ABpsiWM/OkfgDsZFiZRXo8Wjhvq9FY4NgXJ7lCwMV2GUfJm2zoqj0dScctxb?=
 =?us-ascii?Q?1XIKPr/YLlcBmzgc6HT93KH6BQzTKPPhoFyQskoKJXXEsoocWjaxyGKUXR8D?=
 =?us-ascii?Q?vzGsVhxYlqVDhja/xpQVs66faAK9UUbYIoCvLg5RVcPpIqrcWQKAII+YMv5P?=
 =?us-ascii?Q?r36pOMz+vu4oQTnYxxrbgzFoZVjzzjiJ7Xe6xmd8txy8I8B774ZubzxjOEBG?=
 =?us-ascii?Q?vm0v8c18ciViQTFWm40alAeahFQjISvCC3em+z1ZCbq4Dt8fQsCuoTcMy8GI?=
 =?us-ascii?Q?ciJcYYnLVq/oFVdMDwX2E7WPtSqE6/MwgxbuOR6sq1SkP43HF1zk3ezujhN7?=
 =?us-ascii?Q?2tEQYIW9ocrzKiAHZ6oFYjq1huAPjBIQGBH+t8NkvNRpFvwNQdp79zwdcFLu?=
 =?us-ascii?Q?qurPtGXlnK3fun+bnN767D2xnmBCJGuvNTuyf5BpufnACym4fbPmSHRABNwO?=
 =?us-ascii?Q?d9ttPDc85749ubWDT0SDhWLFF1HDvdUozU0VNx89CEVMhX7ql6x2bxN69Tkd?=
 =?us-ascii?Q?9KDvD9QHc+RlC89p5RSrdF+MsDhO0VXmNgNYsVrQl4c1Z5Yvv7dDjLGe9fbF?=
 =?us-ascii?Q?JHlusnvMMSxY0Wff+8chM78JPBoo7gk/qKT1Tlep?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b047284-dd40-4a2b-2137-08ddbe4a08f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 18:05:34.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Myo3qwzIOWhmk4ynpRh7kQ8V2Y5ResQZPtBf5pdEcTC5pVp8r5ZAgW06VZkSLKrwUir0Kzl39pO9VaxYh/VgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7807

On Mon, Jul 07, 2025 at 06:33:31PM +0300, Ioana Ciornei wrote:
> Describe the two LX2160AQDS on-board RGMII PHYs on their respective MDIO
> buses behind the MDIO multiplexer.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../boot/dts/freescale/fsl-lx2160a-qds.dts    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index 4d721197d837..2d01e20b47e7 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -43,12 +43,22 @@ mdio@0 { /* On-board PHY #1 RGMI1*/
>  			reg = <0x00>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +
> +			rgmii_phy1: ethernet-phy@1 {
> +				compatible = "ethernet-phy-id001c.c916";
> +				reg = <0x1>;
> +			};
>  		};
>
>  		mdio@8 { /* On-board PHY #2 RGMI2*/
>  			reg = <0x8>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +
> +			rgmii_phy2: ethernet-phy@2 {
> +				compatible = "ethernet-phy-id001c.c916";
> +				reg = <0x2>;
> +			};
>  		};
>
>  		mdio@18 { /* Slot #1 */
> @@ -169,6 +179,16 @@ &crypto {
>  	status = "okay";
>  };
>
> +&dpmac17 {
> +	phy-handle = <&rgmii_phy1>;
> +	phy-connection-type = "rgmii-id";
> +};
> +
> +&dpmac18 {
> +	phy-handle = <&rgmii_phy2>;
> +	phy-connection-type = "rgmii-id";
> +};
> +
>  &dspi0 {
>  	status = "okay";
>
> --
> 2.25.1
>

