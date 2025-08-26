Return-Path: <linux-kernel+bounces-787041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB608B370B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2275E64DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2EF2D238D;
	Tue, 26 Aug 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QZqAuFU/"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A342D23A3;
	Tue, 26 Aug 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226783; cv=fail; b=MWAmkoVAqWuP+9Ejpl4oP/4MJAlY73anrKL2OiUOtAZ0ke6GkZurjzUjPZE11voOzyA7OdCgcZULlQUOHHHcY93Drnopp+8I72AXEtmwUuaFFdSWZTXRw3WUQJ4X5XNSgqjKlXTRDVLu1YQ2Fb3EUQl3JGzMYFnn61rO10KufQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226783; c=relaxed/simple;
	bh=zmcWhwdSvXIK/nXWx3ezcfBde2A1vWF8/K9F6ukjOMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mXqZKIAx/jSc4q9aDKxVGS6Eir7QnPo63IXgYam8Q9KgyerT2wronv1GUhnRgRcqIyxVRsd1ib8763L6YpFU8VJdKc9TZ1Ox/EnUxrIlyfiY9YCSwsN4yTYJN6PeUuXo4CwUF745mtKp9rbBon18nBWKcALyM5+X/7NuYqz8iTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QZqAuFU/; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdYT6qJlTCAFSobgDrLyA79yrDhED+043O64uPr/UqPOOlr97EwYTbiZddO5OS/1fl2pDWnFceu5WlOujkoex45RYMXSQpZg+UDEiyV6Qtg9jm6LFTfZTKysW6Jxtn9rTYwdSAsAZ37fjFN31QfEnTF5ABEQqew1UpsyTUKnwm6I/YpvWg7dFHU365whIJuPVUkT8lxgyDmpH7eRS7voRzuIE9ZZ7O6G4YUuLtUXCXGmxHNqgGdbEKTcq61SGG46qhZ9mWFNK9RfwyGOVJhtNCLw7/5fcN05Y3RAbrFMahJSw+/h9+E7QLHRR4r8GBuPaOEjLus7HTtsJfyH2Nm0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8ULSF1q6g0h8ynmkldzHJLNzalR7z2xFIc5jqUEvcg=;
 b=n9vd8xfA6sNrbPxTHnFSXFjUGsOifRaSdiLRghrfQLpU+JhQHRVqXTUrLZ/vZ3A3v0Tvjoio5xkFU1tsfpS4NSYcqbfKayq0joYYyyTtQJJ0kBrIh2G0Cv7yG5z3NHa+qMkvNSDo1FXIK69IpCf1HBcDrYMhMry5BVIXAoIBRWwfAZbBrzceRMZhgVj2VjfHtMpcmRJLBQ7s/Fzub+rbX402IdixesrpQDUlCMcPEnu58v0pTbRnaSywxqPgr5cy7o0JZdZLyE4pR7yx8EtmFRdytQrqZFCyEVQ8ltiu+n/Yjp1zaMllZH+9fcOi9cRYRZTB18EY0N1lbAt+Fn5q6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8ULSF1q6g0h8ynmkldzHJLNzalR7z2xFIc5jqUEvcg=;
 b=QZqAuFU/pbLYxLYes0lbXa1JzlmSEYdfp/+UjRL+QAYrstn/oOUzdwoCkbk6y5RXCi0fHQWdTXaFINvz8BocRaegHTyB60Q+SZgCy6+p/BWaRQkJ6HHFfjhmM+qnlQBbFiO8P5cIcu2UbRqyEH5Vl9RdhnaNOGoE6aCfV21VxhyPJ1iIJun5SIJLSc+CluG5xYZso4OyD/8cg/W0HH+paodG69tacyKjQyXqPe3ycx2Ei8yZ5ejrWnneU7ffkSHVNqkhNSqoZ3uihDmhyj8SUmfDMKaDaF7LcGkZGF2FyDoCbAa0LK3/uW9C5y1Al/IFqRq5FDUTPy8BM1nzPOSnag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM0PR04MB7138.eurprd04.prod.outlook.com (2603:10a6:208:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 16:46:18 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Tue, 26 Aug 2025
 16:46:18 +0000
Date: Tue, 26 Aug 2025 12:46:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org
Subject: Re: [PATCH V2 3/3] arm64: dts: s32g: Add device tree information for
 the OCOTP driver
Message-ID: <aK3k0REdrXJytXAm@lizhi-Precision-Tower-5810>
References: <cover.1756219848.git.dan.carpenter@linaro.org>
 <ebb194fc26ee6aa7816f07ea891469ecb780d106.1756219848.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb194fc26ee6aa7816f07ea891469ecb780d106.1756219848.git.dan.carpenter@linaro.org>
X-ClientProxiedBy: PH5P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::13) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM0PR04MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 047272e3-12d7-4287-4d1e-08dde4c01430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DZl4BTaO7u3EgdKTZDxIjAB8Adsax8s70R551KcOKLsA7HiyUdROI5Nz5QvZ?=
 =?us-ascii?Q?PwPf9+n02QrXRtMbsIDzBf/IiJIVBPxumCgCua1vC2lMYcty9GX5wcDzxSJB?=
 =?us-ascii?Q?yl31HKEX7GlYXTsIPEuiZwB2YTsbwaquNE8ROZgXxD7TXkfFmGh//ezu58IX?=
 =?us-ascii?Q?IfThDsNUFI9PKVjiwEl0fUPIfPVmFwURnQc9sneEbhYLVVrWa6W50DoJf+Th?=
 =?us-ascii?Q?X9fSKGpFcUDR1Bkx1Z4epRJ//ClcncABX3DiykVukp35umZu50esdrWDQ6RM?=
 =?us-ascii?Q?XpIfQ0LUyK95peDWAdgG1/ECuKDJ0sem8PBrPj41EdMtM+4dN+5VZX0b0Rtu?=
 =?us-ascii?Q?QbOKSrwRC4Bj5MXSDajr4U5LRVeCqQOMiep5kNiilnOYIa2fXhTEe5AnAx5T?=
 =?us-ascii?Q?QWtFYw4BcEOYjV1ktGZCYlhh+lXDP9jyQErQ7pvUlnSgfKZ+cPz0A2Jff09u?=
 =?us-ascii?Q?peeejfwTxHuxv2AYULfeDHKW88fM2kdFvyqn/pfLiWy2cUYd0ZaO2KMaBmQY?=
 =?us-ascii?Q?qr3LvWEgoKgfr/yVEYd9hexXKide6kUmqHboNt48io5QoLNMPQ/zyHOkg/7i?=
 =?us-ascii?Q?UMaFEeva0rR2lRRVEGNn7ji57NOuI2tcq+4bv7KypCQ3sCa5mAay6QzWT4vH?=
 =?us-ascii?Q?woKBVqf8x5EJO+M+9zb6gUfjugFlqg8GPxzgJYhFUM13jO2CUN8skDLnZ2mv?=
 =?us-ascii?Q?n3d8AmAd7R1F/Pt60mQ7sbqKgYMNSHvRd55wxH803Ig4JZxLmUmtZQVMsele?=
 =?us-ascii?Q?Ugd9KTO/yfBNyhnWcrTDL5h/HR/vh+nGsRfzVeqAj/u7rJzUkmJJC1xe04eZ?=
 =?us-ascii?Q?FeyUNl3X64QeCsjJV1R5JFGrf0sRJZSKYxNEa4wNXT0/PIp0C2smN+R6z4Oh?=
 =?us-ascii?Q?xVTtjU+xMGG/4veinipfsRsLwq5rL/PtqqRLzkTdJGUFe/X7CzxuhrtAtU3A?=
 =?us-ascii?Q?K4bo2vHWkCogdVtDYz2+4haGzhJ7eNcvfrElloSmN9BNYbd1PDRrKSn0FYze?=
 =?us-ascii?Q?9qPJLkCBFFDR8ldrx4Xm3wbtB8um8BqnFN24Z61gED2b1hZO9i2JtWhA4LLA?=
 =?us-ascii?Q?rZuZfWt59kv4hB5wwk20BZqkGw8vDEsYcaScpyzMSQI7ncqaBD167Co7hi+2?=
 =?us-ascii?Q?x95yauob7xcMNVHYbTDAKLLuPfQQe6SSewR1lZJykx7xypffsV+LFjyY7Ul5?=
 =?us-ascii?Q?jM7AtRAN1ZMox8YQFkgziFAsBd+3GzeWxto4O1wZhcyFAqu6HYgVCnJesCLj?=
 =?us-ascii?Q?fu70dmte7kmJgS54kLPsmvtBqxJOyuEzU2Y/p+sKwyVgx0eeY/Z4rvQceAsb?=
 =?us-ascii?Q?mEhjrygBtV9w+lhmh1Udk5zB402zRkPRsVGt2vxOY62Xdb4xIyA92uGDWEkA?=
 =?us-ascii?Q?Swk3ff/ka6iAekHOPxyVn5hGpKivhcek9aAdIQ/LZglFNB/mLhEwFAM9N395?=
 =?us-ascii?Q?BMDHldS2IXccdfSUgMLDl47VNGsAe2FWYNzDWzNeF2H1ePJJkHfogw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cX+GMOsRD5p3TxpeaNziOf1Dsq5S6iLBXLoIB9RoTJAkmeQ1UiAqewSZpTnd?=
 =?us-ascii?Q?MIcCyBY11Q/EVt73Fdt1TH3NHRgZYH3DYNt8utQYtJi/UO/tHVxNDLhzahaM?=
 =?us-ascii?Q?MRnqQ64v6CMj9WIBoCkfANT7n6LYYPjk0OuGGYtpDGO8yC9NhyLiDlP4eTar?=
 =?us-ascii?Q?xFlZrVCjK114t0Plze6uFHBF8EYPXObwFMDKcd7/ax0XXResEGdTbL8rnaEz?=
 =?us-ascii?Q?MdBKXze75Xd2VixAeKM9YFdgKCRQ0xH0v/uw8pvglje/SW4/URwWWizk+IUP?=
 =?us-ascii?Q?o/bdTEp7KO3+irv1ABXybpCAnhRgasZznojna7t4zqnkZQZjAiik9B4s31tE?=
 =?us-ascii?Q?lBdC19d+LVUv7XHA2jGqbQQgVKy0yq+4d5wSIPdr8b1rPBiWP/IxBzitCqf0?=
 =?us-ascii?Q?M4osc8mEA6qZYcZBFJ5L4xnqq4kmuzNkkH5MHlNYbfVgcxoieUVq01hpmvU7?=
 =?us-ascii?Q?MW8I68nQXG6q+bHfs6VzsSgsUBVp+S5mPI/Z37l5o7M/IO6FoIPWgbalgFb+?=
 =?us-ascii?Q?0f3kSGL7kZcIKcku14GaODFePdhC3gzkDoxpTSK6eRnQESvDlHvuc0fXc4UL?=
 =?us-ascii?Q?n/riOA6WNJY7rsqPb7RBka5hqCcm46/YnAfxitaoAbrVUtKPHh+X9BxmIZcA?=
 =?us-ascii?Q?t9fWeu6/IJuqo4ESxQSRjrhtZUuUj3iNXbNbS5E/aZwsvYmNYZa8BC+im+Id?=
 =?us-ascii?Q?E+wv6S9URGkIVK9/ctky+GqJkj/PZwWUTIHFOpvE6MXm+BD3Ah+/XeHajjfe?=
 =?us-ascii?Q?h38yX4WuVhdjbSw/wQo3x6Kyx7kr9I86DvX1bZozfngf5j6t2svRigoenhzO?=
 =?us-ascii?Q?yEBM3f0oAnPza1UOmAJJgwM2ehhv2jyKS1dAzQ61BxEgFzDZFYIYerEcqlO9?=
 =?us-ascii?Q?DuYOQGddb+7VOm8TEtlJiAPGwGN/EMrzDF1zPWtCrBRON1a2HnsuVh43tig/?=
 =?us-ascii?Q?02iVWleEpa3+f2jrefWc8sbdBDVBHkfYzaqQbgLwOsOAwhuiY5A8tR7XR6xY?=
 =?us-ascii?Q?oiNbQqbBkMnOiO7dMJqMRIxmzU3GJqdpboKrsgeSose/Ev1RuvrsHoq3bEC4?=
 =?us-ascii?Q?TkZLnQxLmyVr/t1mpaiusk8mv71rAKJwoIMzadIdXlxJRKS/FnMMaQpPIBv7?=
 =?us-ascii?Q?Nl6sEkkX2TIpteUFulNJauVLSlfrFgIk96h9ZIJUKlldIPJU9dJ7OacMFYUL?=
 =?us-ascii?Q?K/z36QgsJ1KeiJvPy7N6UC8zrPWUFFALSz91+2wphqag6lLiSnLwjrT3CGqN?=
 =?us-ascii?Q?5S6N3p55/Mpm6fGiQ6c0uxWwFKEgezV9x2OOrVBI2XhV60Scn7v0TZpI//DG?=
 =?us-ascii?Q?5hc80hsazt0Kl3VTbpBchBkSoQKedtyeuNGdhauRGw1vbpTlfd1vFUHojLtR?=
 =?us-ascii?Q?mWs/XqqTIvI/EH6rtB0mh6WB/+BKZM87E6AlFiE9nv5Wt9+CmTw1LnqJp3m3?=
 =?us-ascii?Q?fipxsmU8/XuI35ZWG7O4x1ZIsnZrLVUOqCuJU7fZlZ9Z649oyOoZhSmgImaU?=
 =?us-ascii?Q?W2MFjjRd73X//UPmjTtWTsOyK2/BNtgDqD5L/81ksLMCHfxKtZAo4JhOW5AI?=
 =?us-ascii?Q?v31jGMZxRN6Znk9nPFE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047272e3-12d7-4287-4d1e-08dde4c01430
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 16:46:18.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4l5HJTkXZUsBq0JLayVrNNtflq7kvL6nn6XWte6aZhHJDBZTiVN72+rL+7QOBnCetzO6sB42kbha24uvcn8OnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7138

On Tue, Aug 26, 2025 at 07:38:15PM +0300, Dan Carpenter wrote:
> Add the device tree information for the S32G On Chip One-Time
> Programmable Controller (OCOTP) chip.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: change "ocotp: ocotp@400a4000 {" to "ocotp: nvmem@400a4000 {"
>
>  arch/arm64/boot/dts/freescale/s32g2.dtsi | 7 +++++++
>  arch/arm64/boot/dts/freescale/s32g3.dtsi | 7 +++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index 6a7cc7b33754..e8cfddabfc24 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -701,5 +701,12 @@ gic: interrupt-controller@50800000 {
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  		};
> +
> +		ocotp: nvmem@400a4000 {
> +			compatible = "nxp,s32g2-ocotp";
> +			reg = <0x400a4000 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};

Please keep order according to address,  0x400a4000 < 0x50800000

Frank Li

>  	};
>  };
> diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> index 61ee08f0cfdc..8fe1fa35e9ac 100644
> --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> @@ -765,6 +765,13 @@ gic: interrupt-controller@50800000 {
>  			      <0x50420000 0x2000>;
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		ocotp: nvmem@400a4000 {
> +			compatible = "nxp,s32g3-ocotp", "nxp,s32g2-ocotp";
> +			reg = <0x400a4000 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
>  	};
>
>  	timer {
> --
> 2.47.2
>

