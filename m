Return-Path: <linux-kernel+bounces-828367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D094B9478F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135833B6A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13FB2E7BCE;
	Tue, 23 Sep 2025 05:48:48 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023137.outbound.protection.outlook.com [52.101.127.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DCBA34;
	Tue, 23 Sep 2025 05:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606528; cv=fail; b=CNXoeWZ44AMhR0JXZQt6ALNhAC7E2jVVXwbd6whIjcp67FM3NXs3NF20T68EQfKJNdGTUOW1Pc5nBeSqmEokJf41guSBzLjhzlDUTWjrv4dTpSvct7OqSN+9cWgZUitCtskDvGAvhxS4ZPaW2mhfqPF2ZrrKstzWoUPbuW4dWYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606528; c=relaxed/simple;
	bh=Yi3fJ2ELYBC0V3KGWwlxBkFR4wb6f829Yw0YmVe51do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK2zY6Ozb7AGbhaHKg7lxF7pZH/spnziZpEzikDi+Bj5Q19tTqNbzr0HsplXLR4p/lWvSDdfeR0dpIYbxnC5C4zomQxvQhK7kYf7BtAOBcoKJxNLaAD1vc2cq1AeVhhHF0oj1zAeffr+jQrRJMRX2jJCjDBWhole9ZuBmbBBtEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyUbYXW5cOy56uvuuF29vEUBUvQlmJVG6puuvquCOdZ495nlWii6+aoxcAMrdgPibsNiHEbBo30sd1NbS2obOB9+ujaQC8LdiI9SwKjfUusf6GJocb7pGDzrX820Fb6p1JLLt/uXpB8LzX6QPLRCNFDKwPTsQYIcEsvVKj6cmcDpT5rV1ykWn82ZpniODC+XEkAULOEkT+zK1xi2FgKRFtPEplOZf2dnKkGGt9b+rudbWcL3C23byx6q9FU704fhILnKIFPnqELZ2k0M4tz50LUnhth5uacR83R6S/bfF+HopgcT1F76Xrbi/HEQ2i+K1xmQx273UJKeCrEvcpZdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4fLJldb8Zm3c4/aGiWqHNke47b+S3OzoDHIgUtntCA=;
 b=FjJCPKqI6zzsMZw6XEfTfk7P/mJ9xM5bAIMOb4YS06woC+tK++VXhUWwm8u0o2v8I0ORhyXkhG12308TgjUs/aP8gdIUDSIhpi17WIj1RklyuIEsX6AzD3ZiKb8/Hr6mitaGYNsTMHqJAwQT6yhiOiQN4afuWaEXOdDjneBXiLX4ZPANCzmzstzBy1OBDpJKs9DokJk34cRz337WEl73jjXc2PXYTbMOc0M1Ap+bDZufpjQgSMIIC/AQgm8/emlGsg3m3xFi+GnFUz4AHEuE2ruZsIlW1329cv2CNg3F4B6AOmPEwjoLlYWVvhxaQh9q6GqhwO3YMES390MMUXpLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) by JH0PR06MB7293.apcprd06.prod.outlook.com
 (2603:1096:990:a4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Tue, 23 Sep
 2025 05:48:42 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:28:cafe::93) by SG2PR01CA0170.outlook.office365.com
 (2603:1096:4:28::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:48:42 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D942C41C014B;
	Tue, 23 Sep 2025 13:48:40 +0800 (CST)
Date: Tue, 23 Sep 2025 13:48:39 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Jun Guo <jun.guo@cixtech.com>
Cc: <fugang.duan@cixtech.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cix-kernel-upstream@cixtech.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: cix: add DT nodes for SPI
Message-ID: <aNI0t9tYGG_CN1do@nchen-desktop>
References: <20250919013118.853078-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919013118.853078-1-jun.guo@cixtech.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|JH0PR06MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: a00bf145-eeb6-441a-c38c-08ddfa64da41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gnHI4WtS1LCJ3mGNO5wUPjCeMYzvQu4eOOWcNURYiNRKboCVhwgmcJvos8UJ?=
 =?us-ascii?Q?5IjqkY/Hjqj9xogaYGdfEnqa421BxGlSCQHwlsIpsidh9GWP4BagkCp5VPqt?=
 =?us-ascii?Q?OAQdczpWYBMkY7IjG1s2qSrr68m37BQozWflSVI9em7qcliSUy1ABruVYqvw?=
 =?us-ascii?Q?BTNb2qssqKkHl+f9HY1cd2mVgKkm52aLoaWpXBUBhLgS4Z2RkJ+AGSdX/lzK?=
 =?us-ascii?Q?UH9iLqGvr9GbEv/aWFWbL8GKEq2A+I8+zsALSAGOGO4Xl4QnHHxKxvjqui0O?=
 =?us-ascii?Q?o12SeLmtNAIxLCuiCxn1pe1mTsgSsUQcbUUmHgcLGmwAq81ueWc4zqnjOEsb?=
 =?us-ascii?Q?lE79JMx731CUUhvbklX7EyUKSI9KQZhUQLUGMRwoYELjUx2qoIRMH7xHiE9x?=
 =?us-ascii?Q?kU3MIIY3wBntChQ0THSbkAF+FJEgGqg9hH35ci5KYeghT7ATPCFKK+OX+QOK?=
 =?us-ascii?Q?dFkRG23Plm0UlT9FVCwVd6BYzg7f6H0XGCrxYgoGXBhiQ0WhPd0h6RmdIpWe?=
 =?us-ascii?Q?rUaFdTIkqCwlWefrUSDH5o76SEzdG8Y8UoW0cGSHI4hf3vpws0Mi9imqRNZl?=
 =?us-ascii?Q?X5tc2yPBSkdsX1+2Zvab0N6aWX0PusCafkHbU/O5hD2ZrqVm4tPkGzy5Zcrc?=
 =?us-ascii?Q?PBcdC1vXu4CGpFDjA6+UyVoYSa1HS6YMAI72MfD/aL49BIY8NMlmjEf2FxRL?=
 =?us-ascii?Q?EztWaWfq7x2mGuUZu2BG6gc8Ir6SMu1g4CsJ2NXNsTHIMUcOjJw5i79mRMuC?=
 =?us-ascii?Q?9rBQ8MpiIipmXX6pmhJhB0hO0T7LPhb8G4a1IdZGk3YUcaaefSrd6Oqp4PUn?=
 =?us-ascii?Q?wGaArZSphS7K3/UpXKz5rFNJkRYJnh/m3BGPUdmKrHfHC9pgB24bpZVvKPGZ?=
 =?us-ascii?Q?cG3B1xJ26vOwE/cLoefgZsb00H33CUkY+nENiW30vPTH8fzmnMJIEGNvN8jj?=
 =?us-ascii?Q?Q1Gge9V7gjUCPVkH4Rk/rL/WMrqV47Hqp8H4U0AaoXnvbXOppJgINA/lL1ga?=
 =?us-ascii?Q?wbrarD0EIMqY+jaPI9kfzubgPQvT0vtRWoUKf6FdpFFAjXJ7UWBn2LqRDZlc?=
 =?us-ascii?Q?YSLEKIU5boRg8+SnughhK386G6vKPXEZWuU+Nboy00YkY3QJk5Jrc4XRp9tt?=
 =?us-ascii?Q?nxIW8DXgG8/rtefYF1XA9/zjYY0GfAXJEINGkViwLBaE+A65mS+si5XzqOdz?=
 =?us-ascii?Q?VFcAR3AmAJH1OBL2Tf1zp4fS77sF+4FR4MhxiGc7TAloxtlhhmOJ4Ylu8Yyt?=
 =?us-ascii?Q?j5AGhTxwQSdUOEjIPdKH0hFpiD7C9rAGLFWXGfumh5DORzQ+/ib8U1hFF9C7?=
 =?us-ascii?Q?Kwr/gSdvoGZDG9g9I2lOVZm3kmHzsuwGVvBMM7Y0ylY6ZNnsHv06oZ/0V+dI?=
 =?us-ascii?Q?9XCun/fNb7lSwf+MBo2wop7SiDN1GXed3hGYIUUtjErxQ+ndg0zBaxV/8S4M?=
 =?us-ascii?Q?0jizg+cUmFueS4ukIVK4E41ACGbLsl+0Q481QDXPbwDrybn2yUtTL53nf09h?=
 =?us-ascii?Q?LNCXRb37fG1cgbSgYkFO00p2N4NMzEiPSgb/?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:48:42.0076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00bf145-eeb6-441a-c38c-08ddfa64da41
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7293

On 25-09-19 09:31:18, Jun Guo wrote:
> Add the device tree node for the spi controller of the CIX SKY1 SoC.
> 
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>

Applied, thanks.

Peter
> ---
>  arch/arm64/boot/dts/cix/sky1.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
> index 2fb2c99c0796..ea324336bf34 100644
> --- a/arch/arm64/boot/dts/cix/sky1.dtsi
> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
> @@ -264,6 +264,26 @@ i2c7: i2c@4080000 {
>  			status = "disabled";
>  		};
>  
> +		spi0: spi@4090000 {
> +			compatible = "cdns,spi-r1p6";
> +			reg = <0x0 0x04090000 0x0 0x10000>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_SPI0_APB>,
> +				 <&scmi_clk CLK_TREE_FCH_SPI0_APB>;
> +			clock-names = "ref_clk", "pclk";
> +			interrupts = <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@40a0000 {
> +			compatible = "cdns,spi-r1p6";
> +			reg = <0x0 0x040a0000 0x0 0x10000>;
> +			clocks = <&scmi_clk CLK_TREE_FCH_SPI1_APB>,
> +				 <&scmi_clk CLK_TREE_FCH_SPI1_APB>;
> +			clock-names = "ref_clk", "pclk";
> +			interrupts = <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +		};
> +
>  		uart0: serial@40b0000 {
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0x040b0000 0x0 0x1000>;
> -- 
> 2.34.1
> 

-- 

Best regards,
Peter

