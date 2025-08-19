Return-Path: <linux-kernel+bounces-775980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC7EB2C703
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D420D7A3BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF21D272E43;
	Tue, 19 Aug 2025 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nxe3PSd9"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22007258ECA;
	Tue, 19 Aug 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613742; cv=fail; b=ToPysMJX3/9rPJIF50W/YDo1AHCi2P9VBO+CwlvrPhXGZB3902xc06qwtlavtI6z9iGYa0z8xwCi1Xbwd37tBqRvW4GOOAINsW/Wo2xO0i3zLcP29fIghfH6zgMH+fNpp40/KpDSkhhjvhkFLKnI1wZPxQh74YaFc16+kL6m+q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613742; c=relaxed/simple;
	bh=jDTDmBoQVH3AixRyA5tipv67Z1W66Bz4C/wXvwg86Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jUaH4YHLUQJELJmKgN1X2wC1tyHxIKxaHLN9XhDgwFVm/vSG5iLYyI97pLsZk5qWx/juj+rU7Ux9+c5EX9mQ0XXFDXFqs+/3UYybY5HrtLYKxs7R+6hEDtJ/fZUjjZKi3lcQ6S6dHzeEVxnDaB/Qhlmxfq9j59Fr6jxGRI3wLeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nxe3PSd9; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORvgsebNf6a5Vapy8fCmrylVjuC9q4Fg6yjshLkMSvWj/eFqUCDw44QoYRPEm5quLDQvh88RFKGXkqsj8hmxHRFge8Us4h383xs/fbQ0sPgwhHie8+YH3/zWNiS0UZeBw0S4EIFOh7UzrmOWP1T8EhvpNfb1yMMNRXRBg8XQqsLCnmFlN6rh77tqvX8E/hR2cwmdzxrKlow/a9kVdGiweQK/cPNvGR/sPGZ/s3suqNGlSiRjMYaAq5DT8gXTOK+PWu2DgoeV18EOV5lj5rAE9zgoEX3zsc4UwlX7l0Wqv4NU4E/SZmHLNtbGvAR7kOr9U2z8lkhw2CAm9Ylx+GciDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8gGtTZsq06Kf4Xdx85ZmhcrVksVXXczfC78+UGRS9M=;
 b=v/BIiXP8Kg6C0+YvUFxzFPWINgdcvp7GePPjmxzgRzbPw8CpTZU3J5qwou8bdRLcYowGHfs7KudlkWlyiBWCZRrG05+gfh90SeMZnEGO1Te+vn8ZSMVg/i+IuXmg2S4JMTC1VE1QvTltuti3TblO9V8phCyZ89TQx1iXbrwiLnU3jzaExEciYwqv2rXpD1k5t/yk2ACgTwsF4bRa+0RsBaV/V/TtY00qcf8OESxpJ43sE5Hpiwhwmc76ubRKIyyIx0fXxvhpqzJKbeoYuT9akDuntxA/4FwSgfSidWftB416ObUmi1FRiFML9dD6fcaQbzjPebA1U8d6CYRO9FCDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8gGtTZsq06Kf4Xdx85ZmhcrVksVXXczfC78+UGRS9M=;
 b=Nxe3PSd9P9JFD7bpfcAeoHyZO8QzVYopfqxAAV1bcEUHusJ2+pO6eSkkoPq4xO67nOgz74ZrhmcZ5j/WdIfkoyIJxa1B7f3akSJBAGxl237AVfGBdIIRlNNXWmBjsV9gb3v3Nf6dtVgJs7o4lnX8WTBUeFDPfx/WAznt4pYMLF3/LHeq3JAw82rhC2CPzSifYgaagGNA5Ha5YrQwCmxfDOXdpItSEh6REYuvXtHcyOudsgGHJMcPl9J5vA2etgv9ULGRQj+ajK4ImfHrNp2TuC5XpSIO2mkWXdUsaVa6YTgdAiKQB299LvrUrUXny02CLRfWOpv/DO3kHKhPInQUKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 14:28:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 14:28:57 +0000
Date: Tue, 19 Aug 2025 10:28:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Minor whitespace cleanup
Message-ID: <aKSKIkUTyc391CYS@lizhi-Precision-Tower-5810>
References: <20250819131800.86990-3-krzysztof.kozlowski@linaro.org>
 <20250819131800.86990-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819131800.86990-4-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: PH8PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 752085d0-9b37-44bf-537e-08dddf2cbb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U8vLRI4NKPk2XMdeB5/LR+q8Xor35xbxlyf79qYWpWsdD2tH0E9AX5y/dYh8?=
 =?us-ascii?Q?vZqZ+kYLSZAjJi5RvvUGi2QpHs0ZijCgsvc3a+1w0kswWw15c/yehrUhMm6o?=
 =?us-ascii?Q?Cu0mOKB+JzAhjwLXQywL/Yd6VT6W2wImLWMJdn1U/Le134x/2FERVVJ4/dSg?=
 =?us-ascii?Q?f56zkvkM83OWYn5y5u2ie/7QkKr91i6Jvb42N0rSXtb0IKCVvVdI8UzWs9xa?=
 =?us-ascii?Q?JjuhBCRvnthwmpQrAg1BrDtyvFXvrpM+9Ih43j/HPExEWnoEnQNKLPqImjDb?=
 =?us-ascii?Q?zKOul1qO0RYAIDmhLEBzjgf8GYUlA+nZzAq+Ju4FKY2FlcqKiFXClVf/ZUWn?=
 =?us-ascii?Q?ie7jVpRI2ES9wxPiuxSU5YydCH1bj1yYzQcxVBqGTy6nnb9jEarBFQMMuoWa?=
 =?us-ascii?Q?VxCgiGcdN3lWfmfHHi3ANDPj3e8F1jCroNtwrH82UA4YiFmZI1rKEfQrxFkb?=
 =?us-ascii?Q?mR7o+OohZyrP6gLDTrnqbNh/1LuQvpJ58Ny3mcNeWyOvFtFHG+S1tUdo4iiu?=
 =?us-ascii?Q?hVEmWcbdDWu4Qi3QrHveQ8mS6bfsyrcdjhi8nosnGX4xQ1XR/69ZEZohwVBm?=
 =?us-ascii?Q?YFrk9CCb/ejzMYugZCwzIXTBqSjpdb1f/Gmk8VsLZL4Pe4Agaq/P/phbCbz1?=
 =?us-ascii?Q?wysXh8ys3NaHfqe+MYBL8hUK3JotjNOTjhjYMiFk7pqtGyoPxaXG7+2lsnEu?=
 =?us-ascii?Q?22b1P+5lCOYNZn/sP1ZLAoCRxD9X4pCnRuIsOwIiXalbV69Sd/fBHvAH2eoA?=
 =?us-ascii?Q?jW6FrVKtBAA3AvDWowGzyZHrVobjTWU4pMnlodsRtcr9YTPiPi+ZcaiLWZet?=
 =?us-ascii?Q?xUk85fcuUdyJlRJnU7HBzGEIa8Ki34tPl1qn8NB9772SlMkRaTzZN3aVdcbG?=
 =?us-ascii?Q?vbtZ8f1cwWJPAKgylVbhm9N8UiOtDKnzOZlZ4ityRtqewjaR0uU+QgLbkcoa?=
 =?us-ascii?Q?qn6+cq0SaILTbMBZjRtGA7xIAPlgZO2DRO2C6PggbRP01gHuMKo0/ufrJ2ny?=
 =?us-ascii?Q?E97Z431c6IhKCGa9ADg+625ELaGSo6QzjmiTlBmdo0W/O9+rh5V1ht4s1NdU?=
 =?us-ascii?Q?w8w13m9r3Dy+cgLC960rtdXUMahX3t1/3UwBbr3OMZ3S+zpkZoQUVa7nGnX/?=
 =?us-ascii?Q?zli7oRbXxqEoqML91KMxt9uznIjAMjIrePFBqjd31m6p+iG4idxf+I7z7OXE?=
 =?us-ascii?Q?I20m/ntcdX1GvjEyhXQpBT1kto9WR8Nw75GKXZmIDJgwtDnRDK7aW1MfTYbG?=
 =?us-ascii?Q?C58qwQrSt/aE3Cy7cgvyyiOgcp9a1Sexvax+99dtit9LHVY5kZ01eKd/vPok?=
 =?us-ascii?Q?ymILRq8xZmQkY+xIyZA1EbKCO1WmSmTKkFpmL3cMaR+nkvZvijhwSK6EDA1F?=
 =?us-ascii?Q?MAnKuI4+219c5FLbpzPQOIuTha0EEE0TaYriHDtnkfZTEugZPOU4qGmPPKEq?=
 =?us-ascii?Q?dz3l2l15Awna5zFT333b2V6hqpYnCTbZ7eTEgXyfbkY7ZkfGEm1Csw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R3FD+JTrrLEIN13GYZEYM7ICs698kKOHSoLul2uKoIRKNoKqJZkdU5FrYZ2P?=
 =?us-ascii?Q?kIz+ST+Y2tnyQ5EhHtviA56N/NAbdWLW31fnr34nl6f4gzZnlDPJo87F2uvk?=
 =?us-ascii?Q?b6k3uukiiVj+NYbnI3gSjfmn1MobVk1LSQELFhSL7NBXRt1D3rz0pxIrjrOh?=
 =?us-ascii?Q?vZSgzT4Fi5b96yxmNcOsrqURM+E71dtKZjZ0Q+C3o7IJKy5V7pyb9rR3ioL2?=
 =?us-ascii?Q?rCgH8hmwqiYfyY4VrCx/5o/15JZVZH27s9bTE84N2X6eD/DS5FevIia5aUmU?=
 =?us-ascii?Q?RiZHKDY59L5WFUV+oHFPbVSVAVRISDrPgXkgvWdpQ1ts937QscEVg1DPxsLE?=
 =?us-ascii?Q?RCWe038DW1kdBfWkNBHzk2QUObzOd5bu0T4js1LHNlK685k0BzNTeszFlJTp?=
 =?us-ascii?Q?LmxXrC9izOMGhVAyCt4ybF4CENlmglyg03HkkXJxXOh6GBZCAwfgLP3exv8R?=
 =?us-ascii?Q?7mKE8kQeMEAAIDpbAEiqD7bNjRrERTLuuENLPgBguKUk9gRzg772WB+Avrd+?=
 =?us-ascii?Q?/Zo9zCHIjwop/7l+qgumvxlFclcI4Hje/HtR1k2d/y3vQGyFax9XW1zmmhMa?=
 =?us-ascii?Q?a6kg4ZKMwkNO1k0Xesjym440bqbRgzCypd97CM0fFlolVSDTma52PvU4P3lW?=
 =?us-ascii?Q?Fae7AHbeoPd69f4lasGL7vZK3Bc/s5KOxUb6O/wt4KY6h/1oRd3SyQstomxe?=
 =?us-ascii?Q?B2zMnavFVvsTtO1WwhBZtJTJu8okiQ8kGyG2jkWOjlTcADNHuswOtvR8ANnO?=
 =?us-ascii?Q?zqRwyZ39L3mLAF5QLuEA/Iqdp3GzAmyjatSTlViiQuv2INYtZlJIKLQKUW5t?=
 =?us-ascii?Q?Vb2ya9DhDlelJc6zi2VmOLlOdaU5taxNy9n7yrinONH2Zm2L3kS5JXsTz0SE?=
 =?us-ascii?Q?gsRkLXtCIHR3jG5F9Q77Pz0JnZPD2tQ2rpW680SFBOjo6lIQWzjCRsEWBWwA?=
 =?us-ascii?Q?EmIsiej3auhpmnE8tP0OE1gx/91zqAeVliqUgmYjw+LFhZe1mc4i6GU8vhWW?=
 =?us-ascii?Q?LbOq6hETa0LDoMO+B8t/Aey0FAshmXjR9sfgvgtkwj3PwQ4K12Oira5+pFnr?=
 =?us-ascii?Q?93sBN+RC7n+gus8Bkh1ttqPtWErTwC1/1oZWHpdzrcjeH8cMVyhmGX94w7vG?=
 =?us-ascii?Q?mKift7VBwoea1rY9uBZrIkny5mV9To8H5J1M60LoZVzJm7s7G55idGg8SGMX?=
 =?us-ascii?Q?KY/8fcnn9q7GBBcsMAQc07ON8XdYS98+6Hcvji4QVl5vr9Htz9H3Y6kSPtU/?=
 =?us-ascii?Q?ZFwIZjd6TrdndJ9RiSP/huDh9aO/gqK41JmWHGA4gpGxjFPLJnvKb94a85AS?=
 =?us-ascii?Q?hzEpvyjyL8BdeJb+eXtiyAf/FpHP0zK7+jNKnss0e04YNBA3VOJ4SBmOabD6?=
 =?us-ascii?Q?eXuEh19necy3ON1CETWfHw+rZfIzkI3p+zMOGguZXR3p+gS59vcXY36WkNQ7?=
 =?us-ascii?Q?1q52zfmSToX1JFCQuwuDLuTl+N3UbrGF8A9M0hfLp4kcSb/fGbxYPGBGvwXR?=
 =?us-ascii?Q?Ae3EiSWZxWcP1EIoAq/5IcSny+HPdfAXCdSvY+iGlla8Sz31gldtHEVHCeJ0?=
 =?us-ascii?Q?BXz5n8OVD7YV19XTViY8G+4OrZSs8tPfud9KTRGg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752085d0-9b37-44bf-537e-08dddf2cbb7b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:28:57.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSZObpkVwRiCFpkGn6em2zqCRgwMNdPu2SaB5chu3B7Ya9kdRIETIXum/d3NjCmIqPI4RvNM9tZZHx6k9ilmDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326

On Tue, Aug 19, 2025 at 03:18:02PM +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '=' or '{'
> characters.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  |  2 +-
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  2 +-
>  .../dts/freescale/imx8mm-emtop-baseboard.dts  |  2 +-
>  .../imx8mm-phyboard-polis-peb-av-10.dtso      |  2 +-
>  .../imx8mp-aristainetos3-proton2s.dts         |  2 +-
>  .../imx8mp-aristainetos3a-som-v1.dtsi         |  6 +--
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  2 +-
>  .../dts/freescale/imx8mp-skov-revb-lt6.dts    |  2 +-
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  2 +-
>  .../boot/dts/freescale/imx8x-colibri.dtsi     |  4 +-
>  .../boot/dts/freescale/imx93-14x14-evk.dts    |  4 +-
>  .../boot/dts/freescale/imx95-19x19-evk.dts    |  2 +-
>  arch/arm64/boot/dts/freescale/imx95.dtsi      | 40 +++++++++----------
>  13 files changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
> index 6f27a9cc2494..86d018f470c1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
> @@ -256,7 +256,7 @@ touchscreen: touchscreen {
>  };
>
>  &asrc0 {
> -	fsl,asrc-rate  = <48000>;
> +	fsl,asrc-rate = <48000>;
>  };
>
>  &adc0 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> index b6d64d3906ea..25a77cac6f0b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -652,7 +652,7 @@ &pcie0 {
>  	status = "okay";
>  };
>
> -&pcie0_ep{
> +&pcie0_ep {
>  	phys = <&hsio_phy 0 PHY_TYPE_PCIE 0>;
>  	phy-names = "pcie-phy";
>  	pinctrl-0 = <&pinctrl_pcieb>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> index 90e638b8e92a..87fe3ebedb8d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> @@ -333,7 +333,7 @@ MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3             0x1d0
>  		>;
>  	};
>
> -	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp{
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK         	0x194
>  			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD         	0x1d4
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
> index e5ca5a664b61..79e4c3710ac3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
> @@ -20,7 +20,7 @@ backlight: backlight {
>  		pwms = <&pwm4 0 50000 0>;
>  		power-supply = <&reg_vdd_3v3_s>;
>  		enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
> -		brightness-levels= <0 4 8 16 32 64 128 255>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
>  	};
>
>  	panel {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts
> index 2a736dbe96b4..58e36de7a2cd 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts
> @@ -36,7 +36,7 @@ &eqos {
>  	max-speed = <100>;
>  };
>
> -&ecspi1{
> +&ecspi1 {
>  	pinctrl-0 = <&pinctrl_ecspi1>;
>  	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
> index 231e480acfd4..f654d866e58c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
> @@ -167,7 +167,7 @@ &clk {
>  			  <&clk IMX8MP_VIDEO_PLL1>;
>  };
>
> -&ecspi1{
> +&ecspi1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs2>;
>  	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW &gpio1 6 GPIO_ACTIVE_LOW>;
> @@ -565,7 +565,7 @@ &mipi_dsi {
>  	status = "disabled";
>  };
>
> -&pcie{
> +&pcie {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_pcie>;
>  	reset-gpio = <&gpio4 20 GPIO_ACTIVE_LOW>;
> @@ -574,7 +574,7 @@ &pcie{
>  	status = "okay";
>  };
>
> -&pcie_phy{
> +&pcie_phy {
>  	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
>  	clocks = <&pcie0_refclk>;
>  	clock-names = "ref";
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index c0cc5611048e..3730792daf50 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -309,7 +309,7 @@ &dsp {
>  };
>
>  &easrc {
> -	fsl,asrc-rate  = <48000>;
> +	fsl,asrc-rate = <48000>;
>  	status = "okay";
>  };
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-lt6.dts b/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-lt6.dts
> index baecf768a2ee..e602c1c96143 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-lt6.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-lt6.dts
> @@ -83,7 +83,7 @@ adc_ts: adc@0 {
>  		compatible = "ti,tsc2046e-adc";
>  		reg = <0>;
>  		pinctrl-0 = <&pinctrl_touch>;
> -		pinctrl-names ="default";
> +		pinctrl-names = "default";
>  		spi-max-frequency = <1000000>;
>  		interrupts-extended = <&gpio4 25 IRQ_TYPE_LEVEL_LOW>;
>  		#io-channel-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> index 95523c538135..de971af87f3f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -407,7 +407,7 @@ sound-wm8960 {
>  		audio-cpu = <&sai1>;
>  		audio-codec = <&wm8960>;
>  		hp-det-gpio = <&lsio_gpio0 31 GPIO_ACTIVE_HIGH>;
> -		audio-routing =	"Headphone Jack", "HP_L",
> +		audio-routing = "Headphone Jack", "HP_L",
>  				"Headphone Jack", "HP_R",
>  				"Ext Spk", "SPK_LP",
>  				"Ext Spk", "SPK_LN",
> diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> index e602d147e39b..8e9e841cc828 100644
> --- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> @@ -462,11 +462,11 @@ &lsio_pwm2 {
>
>  /* VPU Mailboxes */
>  &mu_m0 {
> -	status="okay";
> +	status = "okay";
>  };
>
>  &mu1_m0 {
> -	status="okay";
> +	status = "okay";
>  };
>
>  /* TODO MIPI CSI */
> diff --git a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
> index c5d86b54ad33..8c5769f90746 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
> @@ -276,7 +276,7 @@ buck2: BUCK2 {
>  				regulator-ramp-delay = <3125>;
>  			};
>
> -			buck4: BUCK4{
> +			buck4: BUCK4 {
>  				regulator-name = "BUCK4";
>  				regulator-min-microvolt = <1620000>;
>  				regulator-max-microvolt = <3400000>;
> @@ -284,7 +284,7 @@ buck4: BUCK4{
>  				regulator-always-on;
>  			};
>
> -			buck5: BUCK5{
> +			buck5: BUCK5 {
>  				regulator-name = "BUCK5";
>  				regulator-min-microvolt = <1620000>;
>  				regulator-max-microvolt = <3400000>;
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index 2f949a0d48d2..0bfa4a8799a5 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -671,7 +671,7 @@ &wdog3 {
>  };
>
>  &scmi_iomuxc {
> -	pinctrl_emdio: emdiogrp{
> +	pinctrl_emdio: emdiogrp {
>  		fsl,pins = <
>  			IMX95_PAD_ENET1_MDC__NETCMIX_TOP_NETC_MDC		0x50e
>  			IMX95_PAD_ENET1_MDIO__NETCMIX_TOP_NETC_MDIO		0x90e
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 4ca6a7ea586e..3279a9b9c3c2 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -260,35 +260,35 @@ clk_ext1: clock-ext1 {
>  	sai1_mclk: clock-sai-mclk1 {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> -		clock-frequency= <0>;
> +		clock-frequency = <0>;
>  		clock-output-names = "sai1_mclk";
>  	};
>
>  	sai2_mclk: clock-sai-mclk2 {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> -		clock-frequency= <0>;
> +		clock-frequency = <0>;
>  		clock-output-names = "sai2_mclk";
>  	};
>
>  	sai3_mclk: clock-sai-mclk3 {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> -		clock-frequency= <0>;
> +		clock-frequency = <0>;
>  		clock-output-names = "sai3_mclk";
>  	};
>
>  	sai4_mclk: clock-sai-mclk4 {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> -		clock-frequency= <0>;
> +		clock-frequency = <0>;
>  		clock-output-names = "sai4_mclk";
>  	};
>
>  	sai5_mclk: clock-sai-mclk5 {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> -		clock-frequency= <0>;
> +		clock-frequency = <0>;
>  		clock-output-names = "sai5_mclk";
>  	};
>
> @@ -1100,7 +1100,7 @@ usdhc1: mmc@42850000 {
>  				assigned-clock-rates = <400000000>;
>  				bus-width = <8>;
>  				fsl,tuning-start-tap = <1>;
> -				fsl,tuning-step= <2>;
> +				fsl,tuning-step = <2>;
>  				status = "disabled";
>  			};
>
> @@ -1117,7 +1117,7 @@ usdhc2: mmc@42860000 {
>  				assigned-clock-rates = <400000000>;
>  				bus-width = <4>;
>  				fsl,tuning-start-tap = <1>;
> -				fsl,tuning-step= <2>;
> +				fsl,tuning-step = <2>;
>  				status = "disabled";
>  			};
>
> @@ -1134,7 +1134,7 @@ usdhc3: mmc@428b0000 {
>  				assigned-clock-rates = <400000000>;
>  				bus-width = <4>;
>  				fsl,tuning-start-tap = <1>;
> -				fsl,tuning-step= <2>;
> +				fsl,tuning-step = <2>;
>  				status = "disabled";
>  			};
>  		};
> @@ -1685,9 +1685,9 @@ pcie0: pcie@4c300000 {
>  				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
>  				 <&hsio_blk_ctl 0>;
>  			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
> -			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -					 <&scmi_clk IMX95_CLK_HSIOPLL>,
> -					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> +			assigned-clocks = <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> +					  <&scmi_clk IMX95_CLK_HSIOPLL>,
> +					  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
>  			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
>  			assigned-clock-parents = <0>, <0>,
>  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> @@ -1719,9 +1719,9 @@ pcie0_ep: pcie-ep@4c300000 {
>  				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>  				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
>  			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> -			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -					 <&scmi_clk IMX95_CLK_HSIOPLL>,
> -					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> +			assigned-clocks = <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> +					  <&scmi_clk IMX95_CLK_HSIOPLL>,
> +					  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
>  			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
>  			assigned-clock-parents = <0>, <0>,
>  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> @@ -1759,9 +1759,9 @@ pcie1: pcie@4c380000 {
>  				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
>  				 <&hsio_blk_ctl 0>;
>  			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
> -			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -					 <&scmi_clk IMX95_CLK_HSIOPLL>,
> -					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> +			assigned-clocks = <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> +					  <&scmi_clk IMX95_CLK_HSIOPLL>,
> +					  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
>  			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
>  			assigned-clock-parents = <0>, <0>,
>  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> @@ -1795,9 +1795,9 @@ pcie1_ep: pcie-ep@4c380000 {
>  				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>  				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
>  			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> -			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -					 <&scmi_clk IMX95_CLK_HSIOPLL>,
> -					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> +			assigned-clocks = <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> +					  <&scmi_clk IMX95_CLK_HSIOPLL>,
> +					  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
>  			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
>  			assigned-clock-parents = <0>, <0>,
>  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> --
> 2.48.1
>

