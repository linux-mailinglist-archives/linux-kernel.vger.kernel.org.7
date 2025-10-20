Return-Path: <linux-kernel+bounces-861238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA28CBF226A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B2834FA1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA58F26CE2D;
	Mon, 20 Oct 2025 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W//buRLC"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9C1A316E;
	Mon, 20 Oct 2025 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974613; cv=fail; b=eJDwY+x/nctgTSrNjiYQkGdfTIEwMwcu+BEJgVJd8wupA1Em/wG8ovLZI93mUvdmy7tBXgzhWjVxYA/at83LW3gmwE+z9f2fFIXkM5Y7CvwTPA8n+e8rCt3JyddteXsA77MCqGYZ+VEfUF0in/KNJrCJSixoLCa0jrwOsKDdmUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974613; c=relaxed/simple;
	bh=NITujgVoAhGr4opbYfNheKlr3zm9OYbcnSVjxfEfKXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ih57Dzo2GI54gpPuCBujL4VUZ/5SLTqxK1WOz7FRgcEoqHU45jFKuacXoXtmCfhOe/byZ17CwmSyPGyQ6xQ/dwuxGoI0+c50bfExVEMOQQuGd7LRYAFmlwtC1W56GUx7dyE04y18Et+WOslHmv3YRXMaH2ww5nB46M7M59tVotk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W//buRLC; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQui1TzNCEkKy0hTZzVQ0R4Ipjdi2gD+8zodiqsuyVKjO/074j3g4WoI5070g17ymKRtdd1//waTHGzvmv+M6HOFeEKCyi+tWBm50ywkqADoWsmtWFgBUIdvmiHwIxGKBR663tqLWb/XzXgSrI+GjiRcqLuTUqTLpCZXR7oRSMkeYoFxJD4XxldNWBLFPNYU0MXEeiKDF34Mo8Ir4Q/KCSaDvh1U8arWl/X/yFHm8WvYbopXmEvbQXOc6hAqp+h9rii0s9SAWog7yaylvOdcK9+BpSrQtTJQe+nKmk74Fo6KKMBPYpQ2nwRkjB8hB3L4lkCPRVpZd72QbdP2frHvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxy4T3gLHLl4cZ4T16goKf2BKNsohDQuq/0jbMKxLqM=;
 b=gU/TXLODkb8l001X/oUXRVNA4pwui37JZtNuZHWK21opomg4dNbRD9pSZJnYJWXb6M3iKBiAFg7qmXoNxv5pl5+LN8DMOgiGPpZFr0N/aJqKeTV4rmSxkkn4BVHOGBeBUwhK2H2qaRlCvx6zJrwRWRzA8YA/7fzZSQ4b8dzexhDLw2qQup6M/1VpLmK+qLIOanSbHsvEzwMPYXu/bvQzLEgLAyQanSR0eIysmAJ2EpTx8nDCgCsRIKFOlCjGzsppX69ia34CyFa9Ce74+537AAM3phg7OMVKHoMBTw9VmV7j0z33qp8aDKSXaGU/U4kUadwhi9yVyZU5WaxsXgsTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxy4T3gLHLl4cZ4T16goKf2BKNsohDQuq/0jbMKxLqM=;
 b=W//buRLClfP4ip8vHoPrs6XzPa+xRRzEDe90Q/po7nWmpxSKSpkXHSOLz7C6RgX4PXUqi6IRSdOT0g5LyWfOhGYy6FIKDx7nIrXgLw25d5FpIxlvZr61XSVJgcq6+BzeTwJEF9jGdJHFo249V9OoqRuQchkKu8reMRCnt66D4U5A2E+E7WWGOkEz+GJf3+ci+npROvUSu9wGKBOpbMjldaGDmeWkaYnBp6X34DL40hgBr0z+OPqX8h1iaptaWqbleKpKWpeA3EFvNre+I8TnfDKIBp3CFOblk6EWnXAfEnJtiRKe+OYbfdfEASGu2FvQZHow2tzyO+/oUEE4068m0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8672.eurprd04.prod.outlook.com (2603:10a6:102:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:36:48 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 15:36:48 +0000
Date: Mon, 20 Oct 2025 11:36:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, upstream@lists.phytec.de,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: imx8mp-phycore-som: add spi-nor supply
 vcc
Message-ID: <aPZXCJZQaNnrxC7p@lizhi-Precision-Tower-5810>
References: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
 <20251020-imx8mp-dts-additions-v1-2-ea9ac5652b8b@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-imx8mp-dts-additions-v1-2-ea9ac5652b8b@phytec.de>
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: 286a82de-f825-4942-8e25-08de0fee7bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kKfJAm2dj4kcEmU7of6QBuU59yKkTNAj99O439Cwhy8jKMHzUlS9MZyh731N?=
 =?us-ascii?Q?uQ72uobC38ORkhL8tQ3p+m5RmAeXJtpYhft9EFRiITcIjyX7DK2SUxwcUke+?=
 =?us-ascii?Q?jMGzfmwYZ1YQJTx9To7upPq+aNH+Nv/kwea3bucFSzDj5dT1P0nWyYV5UIGc?=
 =?us-ascii?Q?AC5TTT5/rMfMOypnw180NpJ1qOstf6Ot3BGfA5X9Rj+5Ln33WfCg380a4dEI?=
 =?us-ascii?Q?SY5rrS/++t6p0XmONR+KuOMdD8FUEG/FX+Wz/mFUfp/gmErE6LwPf4C6epi7?=
 =?us-ascii?Q?bJU1Kr4jPjmnGL3HujVorJIZnQbBYvRT7u+ny3AMEWEAt409KJGM3S4bsjKC?=
 =?us-ascii?Q?advkyOQznr3V2+pi1Hl4KLqZLHq6CtUG5Hv89RWtT4Ijp+gTF3ejTRpA7uM3?=
 =?us-ascii?Q?tusryb3PRK+zBGxcxXI+8jyZw55XBZOgg3ZB7mHb5tJeOKbUn9OxW4CvaG0E?=
 =?us-ascii?Q?/w45yz4tknn/RMFrtCq3LEewl8wHOFUk8RbftBR+ZC2gdXW17/iGqxzrUOsL?=
 =?us-ascii?Q?3/2loxGpRz3HkENeZHB+Ju9q7g8/kXn2lGD+nA5434cGzBg3lzhDVzqG8xaG?=
 =?us-ascii?Q?fOH+AqD0SBh/g0LD747f5C7EkrlvqkggdVOKDQuA493K7KDpNFGKrw0sAxwO?=
 =?us-ascii?Q?xMizdc64fT2Gur/4hcWDF2UdmevwzU1sk3G+H3zjscIiciyCve0Bhz5LqvpQ?=
 =?us-ascii?Q?F+7BNQOHlsLjAQVk072SV7mJMiyLJMZMNxPkHE7h8W9o/BWBOtxj9YKetBdI?=
 =?us-ascii?Q?XnOGdlj8Nf8nC4afafSErurq+QTydC0ZdwjlqMBeD/tDbbicNPB/XFe+GniL?=
 =?us-ascii?Q?JToTDPXP7P3pgUgZg8dZgayH5QrNEbASK7hQY9eQFc132UY/UoGzNrp5Cxx8?=
 =?us-ascii?Q?HnRD8vMbEqEXzyw7jzd1kWEkHNSRp/+3Tv3y0k0miAn0XaQ1AYRxM9dOeaM9?=
 =?us-ascii?Q?1ow3CWOC/bRCN553wXkpjX3jsGEpvSBDbC/xK5PxeuWzTsLN3uK0seiP635W?=
 =?us-ascii?Q?67tB3+ONqWrCBf0s5klI0/Bc6Mo2Znx8OvW6sasLGb4LUhKU4WgsUWual9FA?=
 =?us-ascii?Q?Sy+C7H82tuj0d5LMz6/8bZ9Z480fBxRixFpMtlmLILnRGJetL23eI3XU9Xmz?=
 =?us-ascii?Q?50OKDXjLu5JpnFoDG/E2dKZe5i2nB62+U4Aceg5WONgExje2zsWC38HmJz3K?=
 =?us-ascii?Q?D5zZN6My4RFPJfJaKfLX8te58hP2aH6eT8b6Exrnv5fZGcV0sqYTT4nNnfcH?=
 =?us-ascii?Q?9BQhMjVWF/dc5xxMsR6wOzIWlBO+vJ9RfiUfOu+0wyPUE/GcGMMSLuc98P+0?=
 =?us-ascii?Q?GnfF9KYhXyNEsGLgN6Vaww3owvTSYLPL9op9O3QUcvSPMmlSVKgqdiIMOQ/8?=
 =?us-ascii?Q?GmTFYcFVQt0aYUZR9kId9RvQ2zh/bqgaSJlPopSg/6YAOtOLKILrWSu7KmVZ?=
 =?us-ascii?Q?nvfMT7ak2cNgNVLRsRi4qf45QYJLG25bqbB8wjJnMm84P/0geeC0qNeSagE/?=
 =?us-ascii?Q?LqtB/BFLtcKAtsfKQGL8jLg/HnrS7rQ4JTCg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/0gTLigrCHEGMcRHmRu7cfZqvkTPhKQaq7yYMQpCwK0UGAg7F0D3yAyeKqZQ?=
 =?us-ascii?Q?UNjTtF8B/Rb+OfRk+K/QckY3RfUNav+lGJMzyoflHla3fh+uRV0XIkVCrC4Y?=
 =?us-ascii?Q?jsImkAr+9yAVsuk463dTjb0lDiaIbou0eU+2JZrqSy+YIZiju2ghgjVA2AZc?=
 =?us-ascii?Q?n+4tcj/QptFmcsfFuYGrQWo7gzsGwi+J43gGjge0z/AOYkSCTEP/+cS5BWX7?=
 =?us-ascii?Q?/b3/5/0iE/XnuGS+/8fgDYb5IlU527IzKXuippQy66qMOhbsf0ZNYkpp4t7u?=
 =?us-ascii?Q?tjlfT9zHl10QpHbWtTbLulJCJXmNQ2tDNn1VJAB2Ty7nYSaVe0V1sisC899/?=
 =?us-ascii?Q?uJ10T7v+KPhCcKDVLSjephLDE854r0hCXVm2NvQMN3AMpCmNMo3Lt3aA4Oln?=
 =?us-ascii?Q?sP9XiHx/gxyKDpLQE0XxPJyhN7SxYUAymyfPWW5ZXpZKpxrtq4UO3v7ZM0cB?=
 =?us-ascii?Q?Xci3sJLOkhMpwDU0YHhEyzvODhLY6xphGevOLz3opvBu9Xx48OlUejSxNpCf?=
 =?us-ascii?Q?NGxYukuBLWwkBvE5oriak9rgFBQ9E5Kxa2psylqXC51ORv6Y+Kh3gknJ/a5h?=
 =?us-ascii?Q?D9MBRylw1jkUlAgUFTWx2mho4Zolqc4IkhcqK8he/Y/bsOLmBi38CrmjK74W?=
 =?us-ascii?Q?q+9EG11UzDkky6igOVy/eHz69nVsZzaF9ApcoIJDPJ3/EbmwR/ha3BEwLxPC?=
 =?us-ascii?Q?9cmIMmvjOzRA7RMx+cTryHjNKQD3etwXTeWAcGH79RQDyMvU1zU6XzKyw1yQ?=
 =?us-ascii?Q?E9tzUHdwSqJSBscTmabcpA3Gs2X1zC6ive05D4pn1fdxywz30rIE9cVgL0wF?=
 =?us-ascii?Q?JatcLq24q+j6/FnzGtHgV6P/6/fn0+QWgWpd2TJ+K1wsnZV+egOjqEP37JTi?=
 =?us-ascii?Q?GtdPrdfACwbDU7LtE0MPoL5wfQjHXEJIxpczxmRBD6aZOh0H8g3LI4eyVg6a?=
 =?us-ascii?Q?TcDjbmzq6GxxiReTdxRSmCPiJLZPIUUYr+wFXharSf+m9bxMQ5lbZCHvkrEG?=
 =?us-ascii?Q?5Ez6wLo5PgDCe8h6/2TeCIFAOTwlGT3ds0PRJZq69pBl4SdNs8sd9ESwminI?=
 =?us-ascii?Q?piJSx5y4a5ofsTmvCx9bNjK7gpXhTfp8lKVFXxuuKCq78MffZB/Ezhf0Z7nN?=
 =?us-ascii?Q?M8No7HozK0/rckvThVVUtgWjsIaG5WJ0Bi3GFSWtYVb0tcNty3Sgfj5pb6oO?=
 =?us-ascii?Q?LG7QrbG+IaPz+eC6z0iHE2c1IY5Fb+n0aXe/JcUOJtyf1AfXvKmSfhB3IBv9?=
 =?us-ascii?Q?Ma1c124CXfg6Cw8fOViVwzrG5llRnUUbxMDMWO4KZEvHtLPvYCmBW9Lg1sGZ?=
 =?us-ascii?Q?cX50xpjACbE26W7pdakkpaQl/3B9tEnEUqShwRuEoj79N7gK401RPBExeWhg?=
 =?us-ascii?Q?1V7ctRKrC58TZJLb1N7uh3PoBdGcYtQ+CiSmRAFcSSVDCW9HvKXU8R3zQsSq?=
 =?us-ascii?Q?Q3NK2Nv4AmPGqK1jOdvratMz1fc5oDXC5sy+aCuFYmTx9ckcHSMTq2xl2fWk?=
 =?us-ascii?Q?86NvmguknBTBZEwjdwSl8UXBfLjzgAJgNDe557jswE0kQLyhMRP4dA1F3yBF?=
 =?us-ascii?Q?mW8jPLv3lEEDnwlGic8v6sdpUrVwlbn2numIxzKw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286a82de-f825-4942-8e25-08de0fee7bbf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:36:48.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03YFbNuosk+TN7hdLGJ4TLBm34BMJijTo2oQI4pxnIYzUbwzmRcU4Pm0adFtOYHYPcAd/Hv5kXQYBUCBgmXpig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8672

On Mon, Oct 20, 2025 at 03:11:23PM +0200, Yannic Moog wrote:
> The spi flash on the SoM is missing its vcc supply definition. Add
> missing regulator which supplies the flash with 1.8V.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> index 88831c0fbb7be3db18910385e4e15691b1c74ef2..d370e2a3a00c5e3e91a606ac0fbed30cf5e6f9b2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> @@ -28,6 +28,15 @@ reg_vdd_io: regulator-vdd-io {
>  		regulator-min-microvolt = <3300000>;
>  		regulator-name = "VDD_IO";
>  	};
> +
> +	reg_vdd_1v8: regulator-vdd-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;

Needn't regulator-always-on and regulator-boot-on because it is refered
by flash@0.

Frank

> +		regulator-max-microvolt = <1800000>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-name = "VDD_1V8";
> +	};
>  };
>
>  &A53_0 {
> @@ -83,6 +92,7 @@ som_flash: flash@0 {
>  		spi-max-frequency = <80000000>;
>  		spi-rx-bus-width = <4>;
>  		spi-tx-bus-width = <1>;
> +		vcc-supply = <&reg_vdd_1v8>;
>  	};
>  };
>
>
> --
> 2.51.0
>

