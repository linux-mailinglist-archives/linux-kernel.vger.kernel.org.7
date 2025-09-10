Return-Path: <linux-kernel+bounces-809208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE33B50A09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A3A1C2047B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384371D6DB6;
	Wed, 10 Sep 2025 00:58:38 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022115.outbound.protection.outlook.com [52.101.126.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E1EEB2;
	Wed, 10 Sep 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757465917; cv=fail; b=FbnU3htKIZz1f1VZsf+y+aM9ASwoUfhWuo5d1ycURgHn04UJ+aFdeGFKMh/YrWuHG84adoXgnPcWcwjeSB49vKZUGI5f0WqFKfMXQgti8EuKRTO5ZAE4wsTLfAYstpbkLkWRQjve3dWLQRsckK2I97L1s5H3USKvyJDsvCA+LNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757465917; c=relaxed/simple;
	bh=Jtu9I6AEwtNfstMXIJQoAxIl3hh9bcFpglM3/cr4Cqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1zCk8QqYYiNEUsjPoTqPKHLSJHvaWoPD5HmtMKRZSahQCqDBJo+FNRYxuiUQYSdBUDj/VQuSRu5/1DD+XbybAKh1OhidCAoUTTkJ6At3tRiKkHmJwTqe2OYDHs3SMMm5pf3mNOcD55KoqQrujlxmXL7bo6t3TuxRjEuLg1c24E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkjnDntiZg++R6nxg26RuJlhpu7+hgJBtDsKX+4UbcvPcVN9a8qDfkmHM0EdrDTXf+yMwntZqq6tvBqcKnpQH0H9/3y0wTj9SOQvlwyTzhiNgEIITgJvka3C68ekkfIoN+xh45Md6QMcssnnmxrVvbFz8cZu9JXsAlJvKyjB83z7IcRpEDCxvOCSZpnu4fDZpPj16+LczdAr5z9Iq+XNhyjaQOgnrDq+CzKF3D8ifuuVfLQI3O7q+rzUnvQYfv5+LPXCnN4FIuxQ4CnKA2/F1BPOBP2zEHVacQx/Sf19ERzzBnjL3wf9b8pYbs6NyNj6q9zM17WgAc85xR9QlAqRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1+pHkGLGPbN4wPcHtUhqjZGQLRShR3QHh8OhW47xJQ=;
 b=f6LTxV6S3iCU2zmwSvDQDIlL3p2uddh944Eeipku3+WL4in2s9G8zQX6/IBeUYwMh5dgJxRK8hpMPCPIrS2bYXpxrKH4XTsmFCzQqJy/kISf8dq2tHxpYjUBDpCU/jm5mQmgbyDde+mWMTglZcoTEuSeSw6lYpuXIdzBGX1mQilQo+UsS41kEhQuNM2hluNKPaHKDIpvpAoCbgK4ktmEO8sqaW9G4jdNK3/jZEneK2ClF0LEEwDjJr5DkE3Coslk2k0xMXBKyWGtBsVVVYH0C5ir1/R1tdtqqIK6oVkuKdgeOxzIEuhOoxHniCJ6PS76KXn/YXtUXkByLd9aZ6uQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0027.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:263::18)
 by TYZPR06MB6894.apcprd06.prod.outlook.com (2603:1096:405:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 00:58:30 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:400:263:cafe::5) by TYCP286CA0027.outlook.office365.com
 (2603:1096:400:263::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 00:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 00:58:30 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3C90540A5BD4;
	Wed, 10 Sep 2025 08:58:29 +0800 (CST)
Date: Wed, 10 Sep 2025 08:58:28 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Jun Guo <jun.guo@cixtech.com>
Cc: <fugang.duan@cixtech.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cix-kernel-upstream@cixtech.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Hongliang Yang <hongliang.yang@cixtech.com>
Subject: Re: [PATCH] arm64: dts: cix: add DT nodes for all I2C and I3C ports
 for sky1
Message-ID: <aMDNNJ6u8ZHldxKE@nchen-desktop>
References: <20250903084713.3221907-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903084713.3221907-1-jun.guo@cixtech.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|TYZPR06MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: c4335b3e-cb30-467f-6882-08ddf00528c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zXy8HTN3tPqof/rmt/TdmXQEp3RGwksI93C4VHd8lL7pYuzQ1YkTB1ZEedYZ?=
 =?us-ascii?Q?aJ8HCZTE65IKbmh/DB/uk4sFNyrMQ4yrLGRuYu8MwzfRqT9X86m4iEqpYAAY?=
 =?us-ascii?Q?kjKGd/leTQVI/NXykKAsGBNnrfUJBgSvnA6fTJFOEBo8BdamBMiJwECz3X5x?=
 =?us-ascii?Q?IPGnwwfRT8jowNaTeXSxVqgYrSIMRe3TEu3o7v2E4rcP1drifGb2AFViaDF/?=
 =?us-ascii?Q?DJEci3M1BsHTGgkpR+lyyqny6J9YPQZmcgEEz+2tNTFeawVWuDsX9PWHfQPn?=
 =?us-ascii?Q?i/isVJvg9H2jQOwlPtP03hRM27QFOOYqE/Vz12jtULeUW+TYymaqgwRxMrRb?=
 =?us-ascii?Q?tD+jgDAGv/Rcn/Gs3XcWZl+Jn/tCNp9nSBcYIQs91hBAqaPuoA7vn+OOzw+c?=
 =?us-ascii?Q?yluoU4t/knCLrNevIv72ndqhr9eNcIA71NYZ/kMvlc3SHnmFLqIzvHya4AXd?=
 =?us-ascii?Q?DY309XvEdx45ITSAJ41zlMrCTEVMx0GPvyvNXY/w9/rIoiIAbIfbs+AGUUG6?=
 =?us-ascii?Q?wer4GCQjhdkmengJXZHdmUdnkIHgYzFjlAS/Ej97HMBEDkDaJwFQFKiktKqy?=
 =?us-ascii?Q?cwcLJNpEnXFhMko/mp8DqxB6ePiy0eH0UhzaqZDf7eNaEV2dTu3lucIYwP7D?=
 =?us-ascii?Q?B7ANemjjeWJZq/0550kip93nch1woO8oM5jIkaO+GqK7tRhu7dMv+nCDYWfY?=
 =?us-ascii?Q?gUG99MN8/JwQVEf7Y2qmJcWsIgX5xywJnNUlr3qT+CstzB65wdJgk9bHSDiP?=
 =?us-ascii?Q?SJgvIsKhRV/OQyoRo65UeB8ZsAa296SLmXKzJzmnMHCXqIj+LYiICi92sXWx?=
 =?us-ascii?Q?M7BwhD+l+w/k1Af2IDPNwTYeOJbBbTMe0KlYSgPKE0TU7+YOvWt94wEm/i2i?=
 =?us-ascii?Q?y2bXcBNYBupq5bXNMJl+H2MketF+s4G7iFhLQu2FcBWaHkUCcVzQzGVV0MKw?=
 =?us-ascii?Q?dwJUYEFswrxW39O4L8XGQ1IZY7l+hwY+VMraewPD0n4zr+tecxh2jyi1C4Ek?=
 =?us-ascii?Q?tOTKAVhNe80L5lGWVzYh5A8Mi9nDIYNeKYV4u/n85IU9bw235kyIYfecNNP/?=
 =?us-ascii?Q?+rOu4695kE9+T06ZsZdv32DOFlYqzH2cWPcqEImKC2NLrtiqO+sGhKGfVm+c?=
 =?us-ascii?Q?kySLh2dyu3DqGXTvqEM9fODgMQzw8mIKNA2GNyFO9ui9oI/PiYB5qOCYXhax?=
 =?us-ascii?Q?QwDne4mHUlxbGDX+bBFcik8Ujszto120V2UC+F0nS7O083X/R90JppAGyAHF?=
 =?us-ascii?Q?pNvDdVVVYRWfFBEyInB5u2XfivR+ME0uK+CJuhYWTUOGvkuRz8JbjaXJ4RES?=
 =?us-ascii?Q?ygT5L0dMEVfw8fCXyL4/I7Cq1TVSfm3w0oQq3bAIloVeEsQOAlIklxORBen0?=
 =?us-ascii?Q?6vN4TAu0myPmhjDyhx7GGQlS1qul8zDGGHUiI44OFpKYaEgZumVsF5S9Hijw?=
 =?us-ascii?Q?Texi9YzQsBbHP6R8ElqSUkbHFIDL3hUsdQTXPriALkBS2wtgWwHFT/8lsMc0?=
 =?us-ascii?Q?bVmBoVBrncA2gC7cZJaZ9mvErCj3UeAPjMCh?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 00:58:30.3432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4335b3e-cb30-467f-6882-08ddf00528c4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6894

On 25-09-03 16:47:13, Jun Guo wrote:
> From: Hongliang Yang <hongliang.yang@cixtech.com>
> 
> The CIX SKY1 SoC supports the integration of 8 I2C bus controllers and
> 2 I3C bus controllers.
> 
> Signed-off-by: Hongliang Yang <hongliang.yang@cixtech.com>
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>

Applied, Thanks.

Peter
> ---
>  arch/arm64/boot/dts/cix/sky1.dtsi | 100 ++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
> index 7dfe7677e649..2fb2c99c0796 100644
> --- a/arch/arm64/boot/dts/cix/sky1.dtsi
> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
> @@ -192,6 +192,78 @@ soc@0 {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  
> +		i2c0: i2c@4010000 {
> +			compatible = "cdns,i2c-r1p14";
> +			reg = <0x0 0x04010000 0x0 0x10000>;
> +			clock-frequency = <400000>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_I2C0_APB>;
> +			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@4020000 {
> +			compatible = "cdns,i2c-r1p14";
> +			reg = <0x0 0x04020000 0x0 0x10000>;
> +			clock-frequency = <400000>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_I2C1_APB>;
> +			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@4030000 {
> +			compatible = "cdns,i2c-r1p14";
> +			reg = <0x0 0x04030000 0x0 0x10000>;
> +			clock-frequency = <400000>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_I2C2_APB>;
> +			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@4040000 {
> +			compatible = "cdns,i2c-r1p14";
> +			reg = <0x0 0x04040000 0x0 0x10000>;
> +			clock-frequency = <400000>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_I2C3_APB>;
> +			interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +		};
> +
> +		i2c4: i2c@4050000 {
> +			compatible = "cdns,i2c-r1p14";
> +			reg = <0x0 0x04050000 0x0 0x10000>;
> +			clock-frequency = <400000>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_I2C4_APB>;
> +			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +		};
> +
> +		i2c5: i2c@4060000 {
> +			compatible = "cdns,i2c-r1p14";
> +			reg = <0x0 0x04060000 0x0 0x10000>;
> +			clock-frequency = <400000>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_I2C5_APB>;
> +			interrupts = <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +		};
> +
> +		i2c6: i2c@4070000 {
> +			compatible = "cdns,i2c-r1p14";
> +			reg = <0x0 0x04070000 0x0 0x10000>;
> +			clock-frequency = <400000>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_I2C6_APB>;
> +			interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +		};
> +
> +		i2c7: i2c@4080000 {
> +			compatible = "cdns,i2c-r1p14";
> +			reg = <0x0 0x04080000 0x0 0x10000>;
> +			clock-frequency = <400000>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_I2C7_APB>;
> +			interrupts = <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +		};
> +
>  		uart0: serial@40b0000 {
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0x040b0000 0x0 0x1000>;
> @@ -228,6 +300,34 @@ uart3: serial@40e0000 {
>  			status = "disabled";
>  		};
>  
> +		i3c0: i3c@40f0000 {
> +			compatible = "cdns,i3c-master";
> +			reg = <0x0 0x040f0000 0x0 0x10000>;
> +			#address-cells = <3>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_I3C0_APB>,
> +				 <&scmi_clk CLK_TREE_FCH_I3C0_FUNC>;
> +			clock-names = "pclk", "sysclk";
> +			i3c-scl-hz = <400000>;
> +			i2c-scl-hz = <100000>;
> +			status = "disabled";
> +		};
> +
> +		i3c1: i3c@4100000 {
> +			compatible = "cdns,i3c-master";
> +			reg = <0x0 0x04100000 0x0 0x10000>;
> +			#address-cells = <3>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_I3C1_APB>,
> +				 <&scmi_clk CLK_TREE_FCH_I3C1_FUNC>;
> +			clock-names = "pclk", "sysclk";
> +			i3c-scl-hz = <400000>;
> +			i2c-scl-hz = <100000>;
> +			status = "disabled";
> +		};
> +
>  		mbox_ap2se: mailbox@5060000 {
>  			compatible = "cix,sky1-mbox";
>  			reg = <0x0 0x05060000 0x0 0x10000>;
> -- 
> 2.34.1
> 

-- 

Best regards,
Peter

