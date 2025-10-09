Return-Path: <linux-kernel+bounces-846999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9198BBC99C5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEBD18976E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00DC2EBBBC;
	Thu,  9 Oct 2025 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L6FjVyPM"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EAB1F936;
	Thu,  9 Oct 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021312; cv=fail; b=A548KFImsx5ribuHofRooRdfH1pjnaIk5kyBrnmanwMGn2W5rYuWHUHM+r3zOBERPXKl3n5DFSWqHY/prLSczXiIdGeh/TV9hMipI1v0ehxXqpmrzSYo2T2BoTtDkbuwBPX00NVyj7hX1wDrHdqVBw4nc7FU2dO4jVuPnz5Aymc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021312; c=relaxed/simple;
	bh=tIo6ufY77eeqNzZx0GiPczuyD0qruu1W6TloN7wyroY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Eexc9228ZqquobPORmYVPI2OjpNhjX9WLnv0NoBx7zDhTsZIvk/h6Eok8VTi4GIZcPPWYjYV0zSfwBupawpTT/C5azTnR80QPmeE5WHWhHkg4SWA46LcmYo76CJGM5EAk3YMl8LBtabkROId7kPK7DkT7HR9KUptQqlVDKsE7qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L6FjVyPM reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ3r3uLBXFCem2Mpb/8dZWSFfh8j2PAxn0//EfQ0+1yV3LDqwHeB4CIcQSfuYBDHmBLTgAdvta6X/4VlbUkibky5tcUcPya7eOjaTV1MTzs0NCS53aZndyPuQOtpbto8jtfJSma251SRzUCFTY6NdN39dFmkWNEAnxi9PHgCU9raPOgNXHLAyxQp4I7iz/7ydLWstoWNdlkPcSWCb5yeptKlc33Pl86ZdPy5639wmf7+NMiqMUbxmE//OI0GfyqAgj5IMxn7Ki7zvMGq5oawHd274xNmkSl9DnwYc8c9OBPGKF1JrL52OZ9cOG4C6jCwVPWlyR0pC7MgltFZquRERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYat3DJP3EcQf8Vr5bn+JppiSTQxs2FuSoP0Gb97iBc=;
 b=hu59yWRwT5qSfrRwRxSH8tTUPX/LxeQ9Hakqh6d0UnOp2DStUhXV2O3b4vssLiVs0/Ms8pkB2iAth4vE6R8pzWAG+wXLtC8dBnLBXQlicY+PfLVvECQ/BiaLiX1/gZGgm3J/ySIhTSOOUR4dUxOG6KKr2maFK52yprSIhp7n4UDHAEDcIGBg8Xbw8cgcgToQFSl2Wdlx5zfdtE3DpVTgMHhmxs3DxGjLkH+w/ij74KzHpIFrxlaHXLGjdkvZ6iBFLoTz3Z22nbWSce3FxC3EOQgZJ6mYvNGJL+rtYZ++1XdqRut+LykUtnLSqOCNBHvNnIZAp3puhaB4tAFwVdFvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYat3DJP3EcQf8Vr5bn+JppiSTQxs2FuSoP0Gb97iBc=;
 b=L6FjVyPMLZtVLVkxxSVUdiZg2f46yVwT4a6ggzUiXL5//LqY5wgXVk/5jYZ0WN+gDo19+H70ZIn4fBQRqNHzLpYdnGTfVAa9PaNBASlgMsZ0duHwYxbHjkziUuTe9SWar94WLXgEgV/t64A3E34eN+NWUmyyNAtn5yopymY5ALnrC0188IpaoOzTD/VIgKlJM5f/DLbAIv/J90lqFWd54biNWd6hoF4bv3SxUBkBWtvmYTKx1hqHrwpYthTOlefLk4g+fEs53F09F+MUDoO788Mx5FfMmSwXwsbnRN5bAEE5IzvoGVnt0yK2s271IXAU7oUsvjtaJ5Ep7SEbza5JRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8499.eurprd04.prod.outlook.com (2603:10a6:20b:342::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 14:48:27 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 14:48:26 +0000
Date: Thu, 9 Oct 2025 10:48:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: maudspierings@gocontroll.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
Message-ID: <aOfLM9/+S8q0cbsf@lizhi-Precision-Tower-5810>
References: <20251009-mini_iv-v1-0-f3889c492457@gocontroll.com>
 <20251009-mini_iv-v1-3-f3889c492457@gocontroll.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009-mini_iv-v1-3-f3889c492457@gocontroll.com>
X-ClientProxiedBy: PH7P221CA0049.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::32) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e69794d-8b1b-48bd-fea5-08de0742e791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|52116014|7416014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?PnRu8mmN4ogU71MAJK4oE3HaM4lfqeqfEpDlnMPDqjQf24KvBVVHjg9o3X?=
 =?iso-8859-1?Q?brqL5A0nyaudrYQ7fyfG21B6ttT3n8T8NjzuYVPqrLCtFQQnhgKVNy0v2v?=
 =?iso-8859-1?Q?HPb3pcrmBCjJbF4B13sA70DY769LZMpoH2qe36ik1iXEUgc/MSvxhvamZt?=
 =?iso-8859-1?Q?Ro0w4ZHT7TtYHOxRD46uAYnvpKTcrH8piQxPhT08zfL873dMiydLhIG05N?=
 =?iso-8859-1?Q?Q5xe9phaGZFAbyOyNWmKrLBfqOvAtksunYth4ZzT/tmYdNkC5f0i2lgSw0?=
 =?iso-8859-1?Q?oe2G0OQQkhsN3l8OPnoOPDj4tjecHgTPaBnL4+3sX77DxZrF6qcqnFyF1H?=
 =?iso-8859-1?Q?V93pYQuFk+ZVUXRFold1FAljtM8+OiNjVt8/U56RzhhLp3pCQO8XNsC35i?=
 =?iso-8859-1?Q?rMXKB8hP+Na08L40MG/5rnRV9kPIfKM6KBdsqcrCTqcpSCO4zMn2FgQcWV?=
 =?iso-8859-1?Q?DbsPe/+OIdv0xHYDkkxCNG1Qtd9epcPFVuCPr4b7jf82V/VkHHuuHkctVv?=
 =?iso-8859-1?Q?1H2fSukO2ibaYgDDQRlArEXopz19IinbAG6mSbvTLbeW7LANlTuxX8QSfJ?=
 =?iso-8859-1?Q?s6sfbqtZlaxR59Sbv/M2aYjCaUIC+08SX2a2Ph3qyhkjTMY8Zg+LFg4g1Z?=
 =?iso-8859-1?Q?9xg2OHZ+DKwu9OLhdMM9AgtRxe6v0h3T2iT3FphcD1/wUfeMDlbPWK778Y?=
 =?iso-8859-1?Q?r9iox3hMxySf9/FswHhoVsP6H4b/RLqhCc/V2HX/6l3bIhlkS89/RvcM2B?=
 =?iso-8859-1?Q?6LhGgCdcjZ9MVHIOdaOcH12jl8GTheNY5yHNNjUNiC7U71exowNPb9tPOk?=
 =?iso-8859-1?Q?DF+7bEfgrsg6fA2fWftgP5x3pGEYi9FM40q6bQ43b//E3gAgJ10aX2vqVY?=
 =?iso-8859-1?Q?fQgvMx6TucweyjERZFCs/tUws9kfr0butVHY3uAEKKJuvI5ax3pto3Ej4P?=
 =?iso-8859-1?Q?DuMHI8RtVu1nq5eSIMjU9mXLXcmuDFabfPx4+3hoC/JhXwNhedflUKu8bv?=
 =?iso-8859-1?Q?SyD2BkRfCen2b/aX9ETyAEpTHcvU0exJOAj5kluZg7F21g7KkvOdsKoTKN?=
 =?iso-8859-1?Q?Y88eveZl8P+lFm9LjKr/hXbVZLf8zGsJMVaIXKU0QdxdKR9zeLsclstVrt?=
 =?iso-8859-1?Q?jbm7bLWf4/lu0hW90tyc3S1XG6CDSxIbE7Crz7QQ+pXD6TxHbhchcjrjbL?=
 =?iso-8859-1?Q?QCmS2Uxp9fowxm0TVvTbnFIt+RR3AYFBjbTZZ1ti+8T/Ru125j6rTFksDN?=
 =?iso-8859-1?Q?0tBXHCaJX//T5jLHvy4oLBF1N/yp0HPAtFqXM1UOPkJxtbYuBDbXLxSoVi?=
 =?iso-8859-1?Q?Os2zmGqvKkqzaDiFRKdDXS4XlxllljYWDP7F+LMGfd3wA5wOX070BumKLX?=
 =?iso-8859-1?Q?FjkZRs6oohq6ICiA2yEg3H0Be5D4Q+BvwJQEHtM3jzxJ7tfuOaNHdy3iCi?=
 =?iso-8859-1?Q?Ji5QI6Ft2B1qJF0eUevGtjl1jmgy0cx7E+y8YUvg803SqDZrYD8nP9w6/M?=
 =?iso-8859-1?Q?SIo+k1yZ0/imc6FDn3U9KXiuiwCyZPnT6xDhzMcKosX6gJo/y3TXq/SGsa?=
 =?iso-8859-1?Q?ipOOuPH7x1pU5SCyFijRz+THVlQL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(52116014)(7416014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?4bSX3ou6ntSl3mo0pwivDuySG+2u0391mUdG/1r/8ks6MKJDJ7s66xlRMs?=
 =?iso-8859-1?Q?oU/I8Zuztr+HoysWFNAVJmvDtCeAaxR+Ogi3iVOPH2kicmQzKCGD5WGExZ?=
 =?iso-8859-1?Q?w0V+l28wock6DE4xh8EUl7k7EDqaxTYcoAcOBv4LYV9615sLJrrT+Pwp0k?=
 =?iso-8859-1?Q?94Qh2mnyuCTiKJPqJRAAenQ75BONQb4TkNzpwNmhizJ5fd4l26jCf55Sy+?=
 =?iso-8859-1?Q?2vgVePtHAA2j56jW207fO8zwHCl406YCPT8c6L8q6zoCyPfnp5dTp8IZGF?=
 =?iso-8859-1?Q?qSydUdrEvDth7v6tZEjX+uh4QqDYDcu4aAStKMdZHD7cxbkWS8ijyoGb0i?=
 =?iso-8859-1?Q?mjD8EsH9wrqyTwgTVkr6dWpNtbVRQlTsvgnM6Htgx4BZlEX+VC60H46pCb?=
 =?iso-8859-1?Q?3zSfoK7KK7zuR59aJJ82rmis9ST/I6XpRE9WH0tqSCtmKq+auSRNQwjzp8?=
 =?iso-8859-1?Q?160FWBiDDzSvzS3uE6ULRZ/ASiN6si4DKdH9BTLyQb0x23z52q/KvRQX0q?=
 =?iso-8859-1?Q?NEVRS41yM3K+p52OEea2UbWUhPr3XmchKptwiLNfHfbDyCQm8DjU/IQQjh?=
 =?iso-8859-1?Q?Sem4FfzyHmW4YmzXtT9yZuEJay0RYTNoYV/aoz7upQ502o6Y2RUPLrIysn?=
 =?iso-8859-1?Q?YVKFyxRZrH6GAhKjPi1XJ1jCiLCbeyA7igRip41iye9zp0V/f19fanoPNI?=
 =?iso-8859-1?Q?Ssh3qEXzCP2ouVdyCeOt4YddLfbQn7rI44SJ6i9UI9nRFN3/LNmbiGrdYH?=
 =?iso-8859-1?Q?mggyDoAlpWy2B3MdI6TIa7FYQICFwOE72KNUNz/0YLHzyNB1Wm57g+7DIS?=
 =?iso-8859-1?Q?FSagAD1dxJe4Q1ifo8aZ4yas8NQOEXJKcrm/MbPzmM+xO32Tnrj6QArkud?=
 =?iso-8859-1?Q?b6C+hNmiXBbBA0rdq+MfwT8v88xWJkf+gll8i9UlFtkhwoNxlDTH9Pgc5J?=
 =?iso-8859-1?Q?x9DkiEI6Xvy/hnhlI39MnXAVoMgnftbIY+Y6xn5/hgRkSMd6WxdwXBnvPl?=
 =?iso-8859-1?Q?G5B3aXhwLQudG2mPveBs3AnU+Lo7EIEz/uD+4SgyaV/dX8mYUmtN35JbSv?=
 =?iso-8859-1?Q?ewn9+s7V9wErg7IukktzWGZ1CGJVatXke2PaxGkLZdmgZpznqH41chptq0?=
 =?iso-8859-1?Q?duU5y7Nz/UqJHPihapZEaDU0iKE3PxShwLiAR26yzFYOzQAAj9N4Ps7dGp?=
 =?iso-8859-1?Q?567wFwfMuXBA2/nsscbbgF7rcwmZol3+Wq9O8lJeR3RlERyGroX/VAIN5i?=
 =?iso-8859-1?Q?aiRGJzMCvFF05W4BqOFefH64Wx7FJTMppcUROHFaad1vrCijSeuFQ1/JmS?=
 =?iso-8859-1?Q?Nzj/XVVujYgz5A3GScD5YKwElkbinP8NONk/9nplY+LX91bIxAaGP8FAvQ?=
 =?iso-8859-1?Q?Njv9Cnsu2Zk2kqVsMsuR8/rzZ/n+Dri1+zu0rNPFRlQoKbL+TT1+tKpike?=
 =?iso-8859-1?Q?CS1yEZLjUq098SLg9PY5gjeCaB9JvWU6+G4UUPnm1eYJCwPLi1qjnvurkC?=
 =?iso-8859-1?Q?eYIVYI3FsRnnRvBi64v6MfgTwnGiXEcC9MicNfIhneg8w3qFEhZeR/3K48?=
 =?iso-8859-1?Q?FGjdAV0FGZUgPZi66EgWo7dTqdd7tnrxjaOpPu2C5YnaEc9SltkdTm8viJ?=
 =?iso-8859-1?Q?qpY8DbHaUjouyLpDHSunnqS5w5bgptz5OT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e69794d-8b1b-48bd-fea5-08de0742e791
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:48:26.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6d1PyTtOFjVPcA0sMchc26ZmwzVm8/t4j1Dxvw5B4bu6l3XCoaabjkLVfi1bV7J01CMcMRrV13OKTS/fRlIMeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8499

On Thu, Oct 09, 2025 at 12:54:19PM +0200, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
>
> The Ka-Ro Electronics tx8m-1610 is a COM based on the imx8mm SOC. It has
> 1 GB of ram and 4 GB of eMMC storage on board.
>
> Add it to enable boards based on this module
>
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>  .../arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi | 562 +++++++++++++++++++++
>  1 file changed, 562 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
> new file mode 100644
> index 0000000000000..6ed86b10c4310
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
> @@ -0,0 +1,562 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 Lothar Waﬂmann <LW@KARO-electronics.de>
> + * 2025 Maud Spierings <maudspierings@gocontroll.com>
> + */
> +
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	reg_3v3_etn: regulator-3v3-etn {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 23 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&pinctrl_reg_3v3_etn>;
> +		pinctrl-names = "default";
> +		regulator-boot-on;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "3v3-etn";
> +		vin-supply = <&reg_vdd_3v3>;
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&ddrc {
> +	operating-points-v2 = <&ddrc_opp_table>;
> +
> +	ddrc_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +		};
> +	};
> +};
> +
> +&fec1 {
> +	assigned-clocks = <&clk IMX8MM_CLK_ENET_AXI>,
> +	<&clk IMX8MM_CLK_ENET_TIMER>,
> +	<&clk IMX8MM_CLK_ENET_REF>,
> +	<&clk IMX8MM_CLK_ENET_REF>;

Need align to previous line <

> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
> +	<&clk IMX8MM_SYS_PLL2_100M>,
> +	<&clk IMX8MM_SYS_PLL2_50M>,
> +	<&clk IMX8MM_SYS_PLL2_50M>;
> +	assigned-clock-rates = <0>, <100000000>, <50000000>, <50000000>;
> +	clocks = <&clk IMX8MM_CLK_ENET1_ROOT>,
> +		 <&clk IMX8MM_CLK_ENET1_ROOT>,
> +		 <&clk IMX8MM_CLK_ENET_TIMER>,
> +		 <&clk IMX8MM_CLK_ENET_REF>;
> +	phy-handle = <&ethphy0>;
> +	phy-mode = "rmii";
> +	phy-supply = <&reg_3v3_etn>;
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pinctrl_ethphy_rst>;
> +		pinctrl-names = "default";
> +		reset-delay-us = <25000>;
> +		reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
> +		reset-post-delay-us = <100>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			reg = <0>;
> +			clocks = <&clk IMX8MM_CLK_ENET_REF>;
> +			smsc,disable-energy-detect;
> +		};
> +	};
> +};
> +
> +&gpio1 {
> +	gpio-line-names = "SODIMM_152",
> +			  "SODIMM_42",
> +			  "SODIMM_153",
> +			  "PMIC_IRQ_B",
> +			  "SODIMM_154",
> +			  "SODIMM_155",
> +			  "SODIMM_156",
> +			  "SODIMM_157",
> +			  "SODIMM_158",
> +			  "SODIMM_159",
> +			  "SODIMM_161",
> +			  "SODIMM_162",
> +			  "SODIMM_34",
> +			  "SODIMM_36",
> +			  "SODIMM_27",
> +			  "SODIMM_28",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "ENET_POWER",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "ENET_nINT",
> +			  "ENET_nRST",
> +			  "",
> +			  "";

I think
	 gpio-line-names = "SODIMM_152", "SODIMM_42", "SODIMM_153", "PMIC_IRQ_B",
			   "SODIMM_154", "SODIMM_155", "SODIMM_156", "SODIMM_157",
			   ...

pack 4 lines to one line to help readablity.

Frank Li
> +};
> +
> +&gpio2 {
> +	gpio-line-names = "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "SODIMM_51",
> +			  "SODIMM_57",
> +			  "SODIMM_56",
> +			  "SODIMM_52",
> +			  "SODIMM_53",
> +			  "SODIMM_54",
> +			  "SODIMM_55",
> +			  "SODIMM_15",
> +			  "SODIMM_45",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "";
> +};
> +
> +&gpio3 {
> +	gpio-line-names = "SODIMM_103",
> +			  "SODIMM_104",
> +			  "SODIMM_105",
> +			  "SODIMM_106",
> +			  "SODIMM_107",
> +			  "SODIMM_112",
> +			  "SODIMM_108",
> +			  "SODIMM_109",
> +			  "SODIMM_95",
> +			  "SODIMM_110",
> +			  "SODIMM_96",
> +			  "SODIMM_97",
> +			  "SODIMM_98",
> +			  "SODIMM_99",
> +			  "SODIMM_113",
> +			  "SODIMM_114",
> +			  "SODIMM_115",
> +			  "SODIMM_101",
> +			  "SODIMM_100",
> +			  "SODIMM_77",
> +			  "SODIMM_72",
> +			  "SODIMM_73",
> +			  "SODIMM_74",
> +			  "SODIMM_75",
> +			  "SODIMM_76",
> +			  "SODIMM_43",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "";
> +};
> +
> +&gpio4 {
> +	gpio-line-names = "SODIMM_178",
> +			  "SODIMM_180",
> +			  "SODIMM_184",
> +			  "SODIMM_185",
> +			  "SODIMM_186",
> +			  "SODIMM_187",
> +			  "SODIMM_188",
> +			  "SODIMM_189",
> +			  "SODIMM_190",
> +			  "SODIMM_191",
> +			  "SODIMM_179",
> +			  "SODIMM_181",
> +			  "SODIMM_192",
> +			  "SODIMM_193",
> +			  "SODIMM_194",
> +			  "SODIMM_195",
> +			  "SODIMM_196",
> +			  "SODIMM_197",
> +			  "SODIMM_198",
> +			  "SODIMM_199",
> +			  "SODIMM_182",
> +			  "SODIMM_79",
> +			  "SODIMM_78",
> +			  "SODIMM_84",
> +			  "SODIMM_87",
> +			  "SODIMM_86",
> +			  "SODIMM_85",
> +			  "SODIMM_83",
> +			  "SODIMM_81",
> +			  "SODIMM_80",
> +			  "SODIMM_90",
> +			  "SODIMM_93";
> +};
> +
> +&gpio5 {
> +	gpio-line-names = "SODIMM_92",
> +			  "SODIMM_91",
> +			  "SODIMM_89",
> +			  "SODIMM_144",
> +			  "SODIMM_143",
> +			  "SODIMM_146",
> +			  "SODIMM_68",
> +			  "SODIMM_67",
> +			  "SODIMM_70",
> +			  "SODIMM_69",
> +			  "SODIMM_48",
> +			  "SODIMM_46",
> +			  "SODIMM_47",
> +			  "SODIMM_44",
> +			  "PMIC_SCL",
> +			  "PMIC_SDA",
> +			  "SODIMM_41",
> +			  "SODIMM_40",
> +			  "SODIMM_148",
> +			  "SODIMM_149",
> +			  "SODIMM_150",
> +			  "SODIMM_151",
> +			  "SODIMM_60",
> +			  "SODIMM_59",
> +			  "SODIMM_64",
> +			  "SODIMM_63",
> +			  "SODIMM_62",
> +			  "SODIMM_61",
> +			  "SODIMM_66",
> +			  "SODIMM_65",
> +			  "",
> +			  "";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	pinctrl-names = "default", "gpio";
> +	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +
> +	pmic: pmic@4b {
> +		compatible = "rohm,bd71847";
> +		reg = <0x4b>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		pinctrl-names = "default";
> +		rohm,reset-snvs-powered;
> +
> +		regulators {
> +			reg_vdd_soc: BUCK1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <900000>;
> +				regulator-min-microvolt = <780000>;
> +				regulator-name = "buck1";
> +				regulator-ramp-delay = <1250>;
> +			};
> +
> +			reg_vdd_arm: BUCK2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <950000>;
> +				regulator-min-microvolt = <805000>;
> +				regulator-name = "buck2";
> +				regulator-ramp-delay = <1250>;
> +				rohm,dvs-run-voltage = <950000>;
> +				rohm,dvs-idle-voltage = <810000>;
> +			};
> +
> +			reg_vdd_dram: BUCK3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <900000>;
> +				regulator-min-microvolt = <805000>;
> +				regulator-name = "buck3";
> +			};
> +
> +			reg_vdd_3v3: BUCK4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-name = "buck4";
> +			};
> +
> +			reg_vdd_1v8: BUCK5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-min-microvolt = <1700000>;
> +				regulator-name = "buck5";
> +			};
> +
> +			BUCK6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				/*
> +				 * The default output voltage is 1.1V, bumped
> +				 * to 1.35V in HW by a 499R/2.2K voltage divider in the
> +				 * feedback path.
> +				 */
> +				regulator-max-microvolt = <1100000>;
> +				regulator-min-microvolt = <1100000>;
> +				regulator-name = "buck6";
> +			};
> +
> +			reg_snvs_1v8: LDO1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1980000>;
> +				regulator-min-microvolt = <1620000>;
> +				regulator-name = "ldo1";
> +			};
> +
> +			reg_snvs_0v8: LDO2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <900000>;
> +				regulator-min-microvolt = <760000>;
> +				regulator-name = "ldo2";
> +			};
> +
> +			reg_vdda_1v8: LDO3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1890000>;
> +				regulator-min-microvolt = <1710000>;
> +				regulator-name = "ldo3";
> +			};
> +
> +			reg_vdd_phy_0v9: LDO4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-min-microvolt = <855000>;
> +				regulator-name = "ldo4";
> +			};
> +
> +			ldo5_reg: LDO5 {
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-name = "ldo5";
> +			};
> +
> +			reg_vdd_phy_1v2: LDO6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1260000>;
> +				regulator-min-microvolt = <1140000>;
> +				regulator-name = "ldo6";
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_ethphy_int: etnphy-intgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ENET_RD2_GPIO1_IO28
> +				(MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT)
> +		>;
> +	};
> +
> +	pinctrl_ethphy_rst: etnphy-rstgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ENET_RD3_GPIO1_IO29
> +				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
> +		>;
> +	};
> +
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC
> +				(MX8MM_DSE_X4 | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
> +			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO
> +				(MX8MM_DSE_X4 | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
> +			MX8MM_IOMUXC_ENET_TD2_ENET1_TX_CLK
> +				(MX8MM_FSEL_FAST | MX8MM_SION)
> +			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0
> +				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST)
> +			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1
> +				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST)
> +			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0
> +				(MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT)
> +			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1
> +				(MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT)
> +			MX8MM_IOMUXC_ENET_RXC_ENET1_RX_ER
> +				MX8MM_FSEL_FAST
> +			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL
> +				MX8MM_FSEL_FAST
> +			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL
> +				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST)
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL
> +				MX8MM_I2C_DEFAULT
> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA
> +				MX8MM_I2C_DEFAULT
> +		>;
> +	};
> +
> +	pinctrl_i2c1_gpio: i2c1-gpiogrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14
> +				MX8MM_I2C_DEFAULT
> +			MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15
> +				MX8MM_I2C_DEFAULT
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3
> +				(MX8MM_PULL_UP | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
> +		>;
> +	};
> +
> +	pinctrl_reg_3v3_etn: reg-3v3-etngrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ENET_TXC_GPIO1_IO23
> +				(MX8MM_DSE_X4 | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK
> +				(MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD
> +				MX8MM_USDHC_DATA_DEFAULT
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0
> +				MX8MM_USDHC_DATA_DEFAULT
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1
> +				MX8MM_USDHC_DATA_DEFAULT
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2
> +				MX8MM_USDHC_DATA_DEFAULT
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3
> +				MX8MM_USDHC_DATA_DEFAULT
> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4
> +				MX8MM_USDHC_DATA_DEFAULT
> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5
> +				MX8MM_USDHC_DATA_DEFAULT
> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6
> +				MX8MM_USDHC_DATA_DEFAULT
> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7
> +				MX8MM_USDHC_DATA_DEFAULT
> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE
> +				(MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B
> +				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK
> +				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD
> +				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0
> +				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1
> +				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2
> +				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3
> +				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4
> +				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5
> +				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6
> +				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7
> +				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE
> +				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B
> +				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK
> +				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD
> +				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0
> +				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1
> +				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2
> +				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3
> +				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4
> +				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5
> +				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6
> +				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7
> +				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE
> +				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B
> +				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
> +		>;
> +	};
> +};
> +
> +&usdhc1 {
> +	assigned-clocks = <&clk IMX8MM_CLK_USDHC1>;
> +	assigned-clock-rates = <400000000>;
> +	bus-width = <8>;
> +	non-removable;
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	vmmc-supply = <&reg_vdd_3v3>;
> +	vqmmc-supply = <&reg_vdd_1v8>;
> +	status = "okay";
> +};
>
> --
> 2.51.0
>
>

