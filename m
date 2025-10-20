Return-Path: <linux-kernel+bounces-861245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1186BF2294
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0833F4FB735
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4246226E14C;
	Mon, 20 Oct 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UWaWz66F"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E9E26D4E5;
	Mon, 20 Oct 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974710; cv=fail; b=b9FbjuOWI/KQXBzRdheLkj1zE7lBzpfPu+tsvBP/pP72glzg+zgQYEtZSwXDaeZrQpkp/VdDYFXdiR/cYjQlT1OiwOeOpvXpvgW11VsuvY74i0qTxdZvI8/+JnleHopfR9PlOEXHuF3V3qq6OXyx6C+AatDATkSRMMFH8nbwOhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974710; c=relaxed/simple;
	bh=I633+9uX4uLaKUQH+3gn7mTvIG/B+UvmvGvnMSdaSnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g7pW07CDe/Zb9YfUPRByUIU1ywe2AqiyoxXk20Ps4gKsX9mYmUzq0EKyBGwRMkJBS0dMY5wuqlGtCEpKTtHRejKMRrfU2aSCT5yz5XJt8UtKnIHO29hCIy25kEqy5aVU2TpY8L90u6O/Dlof5c8Ateyd4YNlmSTuozSUnD62xXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UWaWz66F; arc=fail smtp.client-ip=40.107.130.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtlS1Fa/iXoHOs6ZMx8M+i4PPmZHOv1NY/AHKrAve3BoZcVATCsrd5bLl72Uh1WxeUjcU3Fou/KZarcSp+ZLgLo3gFM6QB9o8Vsgf9tQ1fJliAjalZsiBc18sVTHDk194FjaAsp+K2iluPWNareBUQ3/nuBys2tTj/c/wmFBnDJ72x8LU9cEPdmDLAiO/n9CRoorOMjD3/A3H7DvUu4Nob1GL295bi4cbCvjpHGnvUz0PRXv3p2A3YSeUhdzfdBrxZoWK6CSwIvh2GoVmiQYi8bC+G3Klxv8NGD+cTEX8n7ij30g6NHTnMyY2g8NdYd1E4k42GuSzI9FvoMPWMmzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C23jaLxn6FDEJhrmg6+pI+clq93K0/cfF4fVSuUPy0Q=;
 b=GwT8PDJAFU0TLxf5oyluxiQ/4BCNIrd7NqXrg3JYaqfA2TTFmk0WOqpy3qpHhKCEVDTaZ1wvFfrAhRj1kG7xHRuA2Mc3ylHgIHA+8PMrdBYh7Dmk1xH57VYsfcZTA8nmITbERdvmAYaE62F9/aWWGo/ChR0LIxGwhYMc6rZjg8LcF7nyz0FKbc2H4q7Gy8yFAae3uYo4aohQMMOWJ1XlhYS5HG6hOmQt4aFD4NEySEwtD9LMOkG/lxcrwolP1k4fZWrOQEbtq025jWJ/2zKHxCAgZpnTvgIxtl2H1hbcOJV229yPZnjruv5htd7QDrvO0Qr8vLbxESEoPUnXfN/V6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C23jaLxn6FDEJhrmg6+pI+clq93K0/cfF4fVSuUPy0Q=;
 b=UWaWz66F5Jw4B7QC4bpm6mFzrNQRXx1fdGNtDDPCets4pZnavAi0ApAWL+1prt8C3i1g2wWqUuW7+OCBB9+KGEfa6C3Vy/taaOqjcS94mGxzA1ZwHUOekcA+JHBmE7DkpXDKqYZAqRTVHFiQDj47ycxSwTXASWLKsAHK/OckO+NZWWQ5x6fGMOVXnOKyS+BZaCGIi035IxoZ3n2qwkw2NdpCeLdJKLgPxRKMO61vciqzaWGwIytkddwYaR7EphHoJA6kyNzEfZz9nycQ9O38F98mJKOISCeRihRadvkz4RqzGkj2ZkDr5/6agVImKsH5OYMTmNmQTyIJeOxOfi/+zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8672.eurprd04.prod.outlook.com (2603:10a6:102:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:38:24 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 15:38:24 +0000
Date: Mon, 20 Oct 2025 11:38:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, upstream@lists.phytec.de,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Riedmueller <s.riedmueller@phytec.de>,
	Teresa Remmet <t.remmet@phytec.de>
Subject: Re: [PATCH 3/4] arm64: dts: imx8mp-phyboard-pollux: Enable i2c3
Message-ID: <aPZXaC8HL+Rg7rax@lizhi-Precision-Tower-5810>
References: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
 <20251020-imx8mp-dts-additions-v1-3-ea9ac5652b8b@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-imx8mp-dts-additions-v1-3-ea9ac5652b8b@phytec.de>
X-ClientProxiedBy: PH8PR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::12) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: f619be8d-e8ed-4d08-1558-08de0feeb46d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?yHo51dzWY1LsD/pjTa03CHif+WjLCjXhJdNIW6mcU7Ny7PPwkFV1wi0JmcvV?=
 =?us-ascii?Q?tEsOsv0OX6ks5MbgYIMdXERC0xhH5whovHDptUEYQ2UwMeCzDI1L8vN+KYX6?=
 =?us-ascii?Q?q5eKOhIweq5BF8hV9dbsNl5sMW28tDmvBri7ewWz0gga77NiF7+P6ePqmFlt?=
 =?us-ascii?Q?Cof0d8w8+3TKtYk1LTL7h0B9rFXE5eOq1g8prnydpBSz5r6cLhQI5iAkOwwJ?=
 =?us-ascii?Q?LYEtt7n8ZH3Yaow/equEBk4jcqZTMSWP7nPijm/CE4k2TcCbhWvvIxxIOK2b?=
 =?us-ascii?Q?pQGz6YTnGrndwUTPjzFxCxyKVyMv847xX0IjGIRlw1XRAeVZsRDOV/ZdNIzL?=
 =?us-ascii?Q?PZRci96xNrrFju4+UCXhoZPcHSffTOuOEg65pTvPwdS4YrNLzqpwox28qFCY?=
 =?us-ascii?Q?wbemodAYkwvgkW3FYplO57gW4+mE9LzlyAk+Uj6Dl90HxC9LOVfyQhxo6dXl?=
 =?us-ascii?Q?26VX/yAdwOhwpZlwGicVh4+ConvEzC9goJMvWqOX8unw6ohWtKoQOUITfEun?=
 =?us-ascii?Q?AR98ezt0qiclFWvTG+QwJ6pSgzUSlI1UYo1HorkoPESe2mRes+XXqAk5egpw?=
 =?us-ascii?Q?GEUwQQexVVuB1FPxJu/cjThK+0oSULszomTa3v8ydAd2bT+0iM6++xQeQWNS?=
 =?us-ascii?Q?Xmmwovkv5R+cQp9dvqOTgVN4shqOIWPetoSJ/CmY663dBT30qBksnOamATLi?=
 =?us-ascii?Q?+2Uf0E80vjbEJT072aSMlZP0SzStloNwFjR/cnyeUz/sWREUl8CZYkerC38q?=
 =?us-ascii?Q?ZZm28Hq0qRMkVZhoc8nZkC/oMlS8fr6HGc2Xn6d2iX1O2veWWansLpjIH/oh?=
 =?us-ascii?Q?P7GWhFNDODOQfY5MIuPn7uhzDUFkNfWxlQFHeALy/+52n2kY6SmG2TpWl+bs?=
 =?us-ascii?Q?cSfeI2v0wEUf1FDUjQog/z5npYX0OLPnGEuqmY+2wICihQV2SDHwH2iazABG?=
 =?us-ascii?Q?+65FXY6ZB/G8VWLJ7vyhg5jH7HjB7cNNRYyuHPnDkaTi6UpPWmV6jORVASzy?=
 =?us-ascii?Q?tyR9f7OclSU+bjpS7zFAkaKyiCxcUB7yND0SthZ2rS2q+87Uiek6Yn6MpSft?=
 =?us-ascii?Q?q8o0Yq0EEyeXpde+qroqBuJHyecHip1EgDJHAPcl71IsUdBzx/mwHWolQEEM?=
 =?us-ascii?Q?qsF7QhtGMeu0E0WyEyOGbBq6jzSsZaNKyFZI9DJLZJOaJ/CGSJJvw83BXKlK?=
 =?us-ascii?Q?bKiL3fDLLnpMm76yKElkrSo0TAFnXWGESiDqTGeMnLhwHGv00ojGR/jM4SXV?=
 =?us-ascii?Q?w7uYea23htrwwRif1X7/lEVY6B/vpO2r4QkQ9ujOYoGvWp8cxzmnjMIshbgU?=
 =?us-ascii?Q?MfFvhlABMVNfJugOmXj2zjFK9jlzAk/+qQ+iSwwkY2mvOubP6RW5cI/Cdwwz?=
 =?us-ascii?Q?jp3Ew2ZHyHSqvS1RufK0RLlQ31sePh23zmpqbFL6d0y2bPDLGM3tbpK0wJ1/?=
 =?us-ascii?Q?cJ8Ds8Vlp/di8ZQ9s5pvWuzVRo+ZXZkQk7DP/7m3YQrN2aKFX9DoQh8qt9/U?=
 =?us-ascii?Q?57LXPc3u027WnZrbUWBh3dZsowz4E2egaw2N?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?kWDtx6VdI3UJwNrKnv1gOOkle46nWOoZiP2XpH1ZlczNyMOGcYynKJBYuMLT?=
 =?us-ascii?Q?RSFeKEY9vjlY4XUUw+UWwuWSztRiBsc3IsB6VzUSKNbaQdtpp7NgAwtsvaCD?=
 =?us-ascii?Q?cmGZm7601rJEQYXtm1CViA4qhz4OKJNE27vH+1BKgbduFtBGAggLOIlPmSiU?=
 =?us-ascii?Q?3VT5IXR9wXzoV30R/WEy5nZ+n1ehYH0tKze097B8t6n0t+oHoKHUxNbtpMLY?=
 =?us-ascii?Q?7qlJm5IVO5aR5ZF2aMdl0/Da8rL5QjCknR+8fE60+vvJ2aUcX2xCX7FtjaId?=
 =?us-ascii?Q?nchPBclmYCX2jTplsv1XLtO/GSxU9dTnzu+EGy8VNR2/vdIxNP+kcbs06SGP?=
 =?us-ascii?Q?5Z06vPvetskLSUcJxjCumWoyl4NdUn6dvtoyK2arXxrrk0usNVZzsEWqJa4Y?=
 =?us-ascii?Q?jCjDZglaiyFWylUuU2ecFI1l9UXiUr7xOkBCGInfcGCvoNK26YWV4KZqVGpn?=
 =?us-ascii?Q?O2BkSzCBPWLLGVNCuTrP6xqBmZhUW6ZRJjwgGOHEUEUOc6aM0a1HAh+OoR0a?=
 =?us-ascii?Q?GgyWRJEGq5RsPvcBG3fQzU2AS6loXCh92cF4qi6RN7Brlq/1VZYN32itnyMc?=
 =?us-ascii?Q?ui3cyqzw3+H08+MeA5xFrPNdFe+SwZ6FRnNrTNl6sgcYlQmk8SFKutICsO35?=
 =?us-ascii?Q?WUCW+RSrk5jOq/c3xzHpSf+VV44F4y1UJ0ryhOY2UhzlLJiQqSKNNyNkNBB7?=
 =?us-ascii?Q?2PKwpjzd48cOkFcIo/VIzRlOyeO/X/ZtHY8G7JxJdpTfDasv3/8n1QJIkINq?=
 =?us-ascii?Q?csqGbQ7c42G1xutBQhFm7ZcDlh2BbYPbvJAApGjd3mEsUYLGlocAdDCKz2NO?=
 =?us-ascii?Q?l5lvkkJ3JwothmRrIz8hVqKWGC4zBe16d2tQMjpNtl0G9NdY9L3I43PqRcqD?=
 =?us-ascii?Q?LPSbXBDnYhW0WqBzKNsamXiWcppaV5ySS3IvVXNPg0Zh11uDHzfyvIrTYyd7?=
 =?us-ascii?Q?+JJvJLqXKqwKAbBIxdQRh/ekqx1F6QX0g0zUDsDGukqPWDFS4ysMMb5rl0Tp?=
 =?us-ascii?Q?FMVxJowuYN+Ki2GZNuF09KAdid3ZulLu0KW3Ix+J62CKIxTr8tnLVq8E77Yo?=
 =?us-ascii?Q?bzaKnBxxTd3jVcGJ3c7PoEVpFQUXgsA2LV6i7kDc3fWodZRJtQNheunFH3Q3?=
 =?us-ascii?Q?t6Goy1nJytjeD7/D6nyjqBbNhU1Jkyu823DBWgd2daYc69b6ocdKOYDyil7M?=
 =?us-ascii?Q?bwyCWA1OjvqJ6Hl1rtQgWNFqwaieg6Gg95YUvfDQnVnS7eugsp1AEY2XjsSj?=
 =?us-ascii?Q?fHd9DTEEftkU528TBRU7wr5P0TMlA/aks3wa2GH0RJicfwxDa5wpSExiA6W6?=
 =?us-ascii?Q?nri7xRuIvcsXtC+ahWH5fO9tJ1fCFK56gvgeCfc1dhgjh3EA5qZOuxi8jn8X?=
 =?us-ascii?Q?bhaksRFNjAPUEN8MuuQCXE8p2/VEzI/deKUigsv42Hg8rk7QTEi9yi54e4Dp?=
 =?us-ascii?Q?qWln72bJus/ry7U4TquTj37yhIY16pH6DY6wq3c6mC0AQdE0FJK8fxgLSZVv?=
 =?us-ascii?Q?Wgc4eGPo7K/+7t6NiOtngk9f5Z7GVcVacbea/Yo+eU2Urt+Mry58RwP3CMep?=
 =?us-ascii?Q?sF7k0TqNA7ZpwGG8GNY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f619be8d-e8ed-4d08-1558-08de0feeb46d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:38:23.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCdUOHyu6TRWd/dHmUZJZ1eCXnuO7depWB4g0ZO/2B4Z7GA8zNBgGZJhvMjRYIm1SzFuxwDyocV1fcYEqZTzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8672

On Mon, Oct 20, 2025 at 03:11:24PM +0200, Yannic Moog wrote:
> From: Stefan Riedmueller <s.riedmueller@phytec.de>
>
> On the phyBOARD-Pollux the i2c3 node is used on the CSI1 interface to
> connect to imaging sensors. Thus define it so it can be easily enabled if
> required.
Nit:

The i2c3 of the phyBOARD-Pollux is used ...

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> index 6203e39bc01be476f16f5ac80b6365bce150ae37..7d34b820e3213a3832c5be47444d4e9c636a6202 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> @@ -228,6 +228,15 @@ led-3 {
>  	};
>  };
>
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	pinctrl-1 = <&pinctrl_i2c3_gpio>;
> +	sda-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	scl-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +};
> +
>  &ldb_lvds_ch1 {
>  	remote-endpoint = <&panel1_in>;
>  };
> @@ -442,6 +451,20 @@ MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17	0x1e2
>  		>;
>  	};
>
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
> +			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c2
> +		>;
> +	};
> +
> +	pinctrl_i2c3_gpio: i2c3gpiogrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18	0x1e2
> +			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19	0x1e2
> +		>;
> +	};
> +
>  	pinctrl_lvds1: lvds1grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_SD2_WP__GPIO2_IO20		0x12
>
> --
> 2.51.0
>

