Return-Path: <linux-kernel+bounces-790535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F102B3A9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCA57B65B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13EA273D92;
	Thu, 28 Aug 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OeuUGNGn"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F2272E42;
	Thu, 28 Aug 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405596; cv=fail; b=tiJ0pM7e5HfFS3KoC+2YlsD0kzM2+Jt8A1ommp1qmefAVTrAhXmtNkVgeC0lSqnmG6bmfnN7pdTCl+pC8nlndRyw4MGvSE9fLUjhfNoc5sHLqVJgFmRWC2O4JNStev9c8QdsFHeBWhXjlwKICJdrIqGhT6FEjlqeOMplobFY+/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405596; c=relaxed/simple;
	bh=tkLrGmgyH/jbR0xez782ogqPbe4+AKFyjNHBb9gj8OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ulwh723eVQwQoSg4ucvC/rzUwmDroawgOZF2CI+FGlxzvOYQWKGYX2UCs16BW0TDF9UpVWJX7wv2dsT1/P/u7iKTYx1J2MSv424uY3muFZnc7bYJ3gwHAHmc3ULR6v4jfZyklsC5AN3gkZkdVXeUTtiXFBemgulTrPoDHmSWnBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OeuUGNGn; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwjhNsZbfd+IZlQK6aU1eB7/+UfkSkUCCsX/y760NHgmBSg89Rd4QHlFBTGrxyZRxRKZKU224bO1p3otEabLyGHPtzboyREMPJWjFgdgaewhNukmkzj9Lnho/71XATYQ8cH0KZNl8WCHOkOuQGIV/12HVIk4UEErGxPAaXjWDZH2wovw7TKO/tCBWdjeW3HXp9Zh7KNc5EHxJeYfwJSGf8kdQFVymvVsbSWUSZzBm/A87leJ27SI9sh2GtJPolx3YfRW36FHLEW5EtaBkxswGkykOs0YH4Hn16tHc7KkeEy+KQ28v1OfRpVMQgin8fqAX8l892I6B/zhKt32n7BuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Eos7j262cZfroGjeLWiNnpfDq1ZJE1QgJTfJtnDpX0=;
 b=q0Jh9ibyyPEQ/Fg1r5qHGNqDaNGsaGfP4n4Y3CnFITX/JNVYwr75LyHnYPF6b81bIDweXMdshWv4/pli6owjaklueazKV4LtaUr5AGsUtrrecPtl7uBlukJDePI7VTQ/2slwupEj1f8EH8EGZzAimHEEy7iBMV/W79Q10pJ6D6MmByYgM7OtKhlnP7+dAc1ighIcFvvSJxCYpbZzi2bZ2dEGsf5ytNv3qMLM4ORHA/Z0Unth0/P4G/7fCoyoOcSpt+5HcxyFIANk6I877JfTRvVpGPtehpq8i3F7jRyeeMdxQDMAd6rJXQiWTSx+ogeqTb7KjwIdF4zYv9GWAo3ZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Eos7j262cZfroGjeLWiNnpfDq1ZJE1QgJTfJtnDpX0=;
 b=OeuUGNGnjTmz/9rya0au3qPhA/68QvWDbsbf4yO3X9+jzfxvTh1GpXuDNgeW1xNEr3tl+8vv3HXPxSlE9LdngPEWIEhvAIohVkw77tGkUFqIPXV8D2xT6FIxUYIW1NKjaQQ66VNSjxWJthOIGf9y9UFnl+YV3emOu+un0ifUAf1ORdQfEEG42W0huwrphebSsIS1R7AYx8iAsI2YJ8CVLJsZ5hhaeSnxgXWrYsyf0glWXiRhIxsNOa1ysqnoGLa4Yh2CmRZw7QlAb5XBxy0rV/qHvvixsYURA26wY8GnKwYsXfOqy6wSYPgEe+w/S1dic+Z/RiWQCvdEaEmMFYwcXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB10252.eurprd04.prod.outlook.com (2603:10a6:150:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 18:26:30 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Thu, 28 Aug 2025
 18:26:30 +0000
Date: Thu, 28 Aug 2025 14:26:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH 2/2] arm64: dts: freescale: add initial device tree for
 TQMa91xxCA/MBa91xxCA
Message-ID: <aLCfTswvqXDLtAhm@lizhi-Precision-Tower-5810>
References: <20250828094745.3733533-1-alexander.stein@ew.tq-group.com>
 <20250828094745.3733533-3-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828094745.3733533-3-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB10252:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3c6fad-5464-4ac3-5aaf-08dde66068c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XoJnD+50Xb5u35o6CvjVUBj4476Zwl5gBlHI92spg1trWy8slaonN6u7qzHY?=
 =?us-ascii?Q?mYB10GW80I9ORijJ2hjoGhhvS3bbf1Gim5VtGL1mzmH3R0nybWYMFv01XbC4?=
 =?us-ascii?Q?VjNI8+6Ov/FbWr7dLns5etv5D5wmab8/eiMhBhRWsmjom9fecnTJv46jmsnD?=
 =?us-ascii?Q?fYBzjX3dN4jFM/m35xQQyBbxZ5mE0rt6FL2OyXSqZsuuV56udPr303fixpGR?=
 =?us-ascii?Q?mKuT0TmSccjD1ZjEIAYDANOVNEG+6Og42U7pjMTIYg/mUE0ftuJTSUy1xXwi?=
 =?us-ascii?Q?+qewN4M3em+jryhJP0UB5fIDegKxV99DZwIVIniaPV/vNNJGjjRycCcpOhvn?=
 =?us-ascii?Q?fewmvoqv53+nxwHINoBglPePr914jp0trYupgeL+JuKZp2sMO2gidKopG7wR?=
 =?us-ascii?Q?D0DrGUn7LKp4NYfI9a8IdOnmxKUkcPEaX+dv8Q+XQawZafMRpaQln/r4tJJQ?=
 =?us-ascii?Q?nxSJoe+6ewozYATfhICXs4ZnDw/Pl1xFDjNAIt9al9/q2HWQhGGGaGOoXwLh?=
 =?us-ascii?Q?iKMBlsjdug6iZOz/mIrVRI2pprmvZNBNJ4tWieZPjjXgQRKpoakTmYp1830R?=
 =?us-ascii?Q?PCpvTC2TTtuhHtYaN1lBuW1/s3rpNaLWmzuTXMjArTN0ZbqZsEiFJePOsk2A?=
 =?us-ascii?Q?WwptOTWjynsJ4o3/knSkn2niUI+eobMiTxbBYkYjJxP/M/3wWJd/0BOvokaG?=
 =?us-ascii?Q?3OyDPwZPR1q0W8A45BOyB7/jINxeBCKSXMbJN+UY3nAbyWKujAutn8oPAqe0?=
 =?us-ascii?Q?oMx3iHUBSC3sG8AVz1ntZbBbxQYU6lTxpqs07Y6fBXzgB5jt2JSqzC2teGn4?=
 =?us-ascii?Q?OhxgxDp6EZzuxNYYnfsjM8GXonco4bzFsJM8d8Yhqvg5DxZxkygJ/5GkY4/w?=
 =?us-ascii?Q?CjFaYkFVAfyuaqVImm8NU3T/Ey9BP9yZdbzAxxaPmaIotprlUVE0zOwuWdLG?=
 =?us-ascii?Q?euqOuET66j4ECf5Hde2RvYT1WEgNUV+h5Z3GNMr5ttz27j+Eocz3H1JSb6is?=
 =?us-ascii?Q?rxCHjx0vIYjru0y8Cm33nyOPFE04Es7ToqiZ8Hg2Z/qGBEQ8E+XXb5siiZKm?=
 =?us-ascii?Q?01D20nehRTpyHgVX+9j4GFRsA9G6haHvHWsIzweKquL5pKFRctMCpSHI5Yap?=
 =?us-ascii?Q?yLega7ZRJ/FS2ZBn9t8KasgDIWthJdjUrLY1Pekodf3hi/I2ktob9a/NTRzH?=
 =?us-ascii?Q?A190xCYZBUDc38AHdz5srdaR2xcLkFa4IaMvVEvkbnF0Sz3lALhpfoLBZMgu?=
 =?us-ascii?Q?BUJ1LKVlQSsJx3lrW524Z7lfkk0qrozIiVFKOV1K1X1oL9jUXyfAP76NySnV?=
 =?us-ascii?Q?fekp0h84qLIdkW1s/KMh7g1/0DVl4QAbAYJ7a2g/tWu1zAP4pv7jS4M88me6?=
 =?us-ascii?Q?xWOo+vgTv/Py/HBKfkL8FxoQ7vzMnq2oN2p74Hanvf/BrWSNmGcBkw928vgw?=
 =?us-ascii?Q?noX0cM844iBUkquBM04tg3vc4jXpfU6bbd2RlBxlkcgkXpwQjLPUKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?so6uYnKb967gBHg9UAXQIeHD4jaoWeQ/CE6erZt4BGtruyUGPg9zrQV1CZiH?=
 =?us-ascii?Q?s2ESctSCDEaGuBGCc6tSwofKEXq8PoxwWqysTxcklEf4wpgPDKiQ+/FSv1o8?=
 =?us-ascii?Q?InsN0iMue5OLAfswGc00e/6HSuvk/Gr/7zeym4K9UA/Q5A2s30fmmuSvHud9?=
 =?us-ascii?Q?4p8Osnkabj9Wh0f9GfOociC4j9mD1AxTYGK5nPZoytmZ2Ze43J+yBdOAQIi/?=
 =?us-ascii?Q?qjlfgHNJ1SlP029L9BZ8LV5cR10iJiwdhn1qTqfH4KltqhOWA0RoH1JOuLGq?=
 =?us-ascii?Q?p8z6ox9KW/bKw0p/GUWmsb1inr2ShkJR7SQhibUM9LWx8HKKPY/GxIwIVrz1?=
 =?us-ascii?Q?s7hcKd4kAZ8WHggLaOJ69ExVTjFjmz2g7s8GsjnTlwHOGbVBHyu/EHllv+kP?=
 =?us-ascii?Q?p3cTRy0HONR2v14RukC9DjVi0W3oV3+pZTRgLKNaOofPtsj4MflVO2UKdt23?=
 =?us-ascii?Q?7l+crYBanqmLfWJzh6tkrsfUfCPbnjrzTwxQuxHNkBEUwOwwGGZS/cOzpJh1?=
 =?us-ascii?Q?vl56iokg87IdQG/Leb89/1Rx0QRrOtVBvJklv74RDxJbDqDp5zcx9gWON1jC?=
 =?us-ascii?Q?eQOartbX6WIYEq/fatThvQxi0/Fc03iIFJbcsGd4orCFQgvkEI+g8LjmEiYP?=
 =?us-ascii?Q?+4SeDfIIeyozkqMu+VT15hJKxt6gmkl+jxXbg2a1qsbPDELsZLG7WqeP7aqc?=
 =?us-ascii?Q?JHJW3eIcraAg0+bFOqnSF8lQo1Bb/zkJR9ITmFm/tAK/cdwj3WAq+Ylirbyr?=
 =?us-ascii?Q?pDHxxD7fpW6re7gqYR7eIPIYS3gki5OTPg3HrtvFC2FWWgy/eJ8P9VjvQQtv?=
 =?us-ascii?Q?7R46cimH3wD0z4rPKQF2OvCEllPbfkBGsLg4npyPOvZmIzB/Tizf+TgfwW+7?=
 =?us-ascii?Q?SO9je3PIm3oC7SOsk6QDUucFrzyYM77lT0BwsjzT4wtQ+V42yieXWEAQxqlo?=
 =?us-ascii?Q?ZyoR+ZFdlVnVEPs++OrUMmdwOeKzhWCM77RGUAiiLNWMco0iegih+2W3MSln?=
 =?us-ascii?Q?BxEpYmYh2zzV85FpUjVJRpJARcXsWmQwanuIEiqWfzRQbeMkaPl7SK+xuKDP?=
 =?us-ascii?Q?1xl/n9x4LZ5E3hEXQyUeZLS4D4EKhFZdyzCAf9fh+spMA0C+kRtMNn0pkCw4?=
 =?us-ascii?Q?dmtyPTC3rb4ZcBxTsE/xYkFpo692iSmzqo4fI3pLvdugvE16D/l6xGTlJKtB?=
 =?us-ascii?Q?TsiBPnwrztjPmOX29dFzqRe2Fgkoq7S8uLf313kb0CtjBEypg7KbkKduOyzd?=
 =?us-ascii?Q?Plx/+IkWAeJFCvarwuhvb/cRe+3sXGa6FuwL2+V6TpyASkCuj5uIfe1x3Yvt?=
 =?us-ascii?Q?wFWThdJ40R85EN9ZAAmrZaqeo+ILLFyUdvuMtA98cmPbhO/A40JiAZDsoy3q?=
 =?us-ascii?Q?J8+/qr/y1sMv4C7PTkbq2MnXOrJpsWHgK0ravh4vmR/lf5SW+CZxayHH5s80?=
 =?us-ascii?Q?RTHByRe+PKDt3MGTvwEzdp4pkV7L6P4SHIaSiKTLWSoxO4g7UXJPlUJL5Xyi?=
 =?us-ascii?Q?vVC0icKRp8tNYfiNe8lorSXZqEgdXWqVdi5sA+Wb789GNNTYVWPuIxrBsr7n?=
 =?us-ascii?Q?wUa9sJzPTTV52/Yje86Irg8Kq6yiDaQ8QPhSqs/8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3c6fad-5464-4ac3-5aaf-08dde66068c4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:26:30.7549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIOfUED9tBpbMVvpiMx7LRne+0dUPWIGuza9KW+4v1wj6mu1lqV8obukl4CYXCO9ZzgOWMfbeQwt82QpfTADAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10252

On Thu, Aug 28, 2025 at 11:47:43AM +0200, Alexander Stein wrote:
> This adds support for TQMa91xxCA module attached to MBa91xxCA board.
> TQMa91xx is a SOM using i.MX91 SOC. The SOM features PMIC, RAM, e-MMC and
> some optional peripherals like SPI-NOR, RTC, EEPROM, gyroscope and
> secure element.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../freescale/imx91-tqma9131-mba91xxca.dts    | 737 ++++++++++++++++++
>  .../boot/dts/freescale/imx91-tqma9131.dtsi    | 295 +++++++
>  3 files changed, 1033 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 947de7f125caf..3a937232d6f29 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -338,6 +338,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-9x9-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx91-tqma9131-mba91xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
>
...
> +
> +	pinctrl_jtag: jtaggrp {
> +		fsl,pins = <MX91_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK	0x051e>,
> +			   <MX91_PAD_DAP_TDI__JTAG_MUX_TDI		0x1200>,
> +			   <MX91_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO	0x031e>,
> +			   <MX91_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS	0x1200>;
> +	};

Any one use it?

> +
> +	pinctrl_lpi2c3: lpi2c3grp {
> +		fsl,pins = /* SION | HYS | OD | FSEL_3 | DSE X4 */
> +			   <MX91_PAD_GPIO_IO28__LPI2C3_SDA		0x4000199e>,
> +			   <MX91_PAD_GPIO_IO29__LPI2C3_SCL		0x4000199e>;
> +	};
> +
...
> +
> +	/* protectable identification memory (part of M24C64-D @57) */
> +	eeprom@5f {
> +		compatible = "atmel,24c64d-wl";
> +		reg = <0x5f>;
> +		vcc-supply = <&buck4>;
> +	};
> +
> +	imu@6a {

I am not if "imu" is common node name.

Frank
> +		compatible = "st,ism330dhcx";
> +		reg = <0x6a>;
> +		vdd-supply = <&buck4>;
> +		vddio-supply = <&buck4>;
> +	};
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1>;
> +	pinctrl-2 = <&pinctrl_usdhc1>;
> +	vmmc-supply = <&buck4>;
> +	vqmmc-supply = <&buck5>;
> +	bus-width = <8>;
> +	non-removable;
> +	no-sdio;
> +	no-sd;
> +	status = "okay";
> +};
> +
...
> +};
> --
> 2.43.0
>

