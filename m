Return-Path: <linux-kernel+bounces-849154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C1FBCF4E1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06979406264
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C0226A087;
	Sat, 11 Oct 2025 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w+R/thve"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A45CC2E0;
	Sat, 11 Oct 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760184135; cv=fail; b=jN4Au9RwMPM/i9/+2yOEr3zLsE7EKL3AIzfHOAOSeD9CIvD19Ipd4+cbDqBzvN6xCUGAwzjtXQv3R+c07P/hAtcpOagNMxcmZMFdqxdUSZEinoK1AWQffz39g0BtltFbPXZQGLgulT7PDdy0NuqTkKAj3l1XJpsrasiBZZp2diE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760184135; c=relaxed/simple;
	bh=EhmwmjfVPvfwIo+pr1yi/lvQFsbgQe39nPa9+qtplkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sRo2Ra3y9vF6xQhUvE/06SW1cU5dbePY1eFxCXWInUSeBid8ZJZtJskTT0k8Jj5EQqNhpe5f5jfr85CNUKiOiCWtA7VFzIbeZrJxvJZs7NoeUG2pbUeNl6gxeRYguthHi9jBXkH1nUZ+Qp6ZItYMI3zB1CIrJRwQNNNPywDKlmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=w+R/thve; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOpSE3C9EdHaEewf+0m562OHLwxE0aG6UuzReowk1UiB7YDmQQNnCL9C7/1n95as3OhGdRHscEQ3GW+sQJ+ZhHB9ONqD7EQQ+SwitujZEtqVBtu/bqj9Uugc+NhMbz+yoLlJIbA0Kyfe2Ul5h3fY+cbcsVG1wX/Ajpvi61Imau3gylK2Io5YXyN8mI9mQvUrPm7nj5oWLKF1kYxUfCtFur18JOWAGib5NWAC+ybfkW/mKxeiSSG1BGqq1D1qh/Y3vtUtzszrNd+JKYr7AijgqAcZbK8psrQBoccoTRrtbC7sOfejN+/t9ryf0lh61LE2eFDTxN1AEP5+LC72YHSzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhmwmjfVPvfwIo+pr1yi/lvQFsbgQe39nPa9+qtplkI=;
 b=B4eTKdcb5ElPyB8QilIqjN8Vt06yFEwLuSzFPNidZk9Pg1QQ/4CNeA3XvMF7feTKuRnZzTLiQQQLLgo6f5oneAMd99OOgaxV2PmSvYO2MSNnkW6A0ucK0Sy9oC4vCTfYK02NPftZ5He36qKeC+LxNZ1SCAaW54EJtzBuv8pef+mtkmTYnSjZpl1gdQ1fxxHWAssYqzygbU1yW54xjrrYU0QBPo9C3Pmg9p/sp4uceNav0s1bFZdUMQmXrQ0AtQlYxPBTF8r2bR8tLdYtGpL9lNRf2oWyl2OefyeCVvmR/SKEFrm86ZWd5CaXi/MKhZY61DUcaZBn+h1pTSuQHDMtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhmwmjfVPvfwIo+pr1yi/lvQFsbgQe39nPa9+qtplkI=;
 b=w+R/thveHv3AzWcbL7MnA2gTj2or1eMk7ydy0PYXekkuOUttCW6dtY6bCcAGcT7aAcs5MoLM2WlKUdEdprfcqfNrjeH3jGD9izXuNxixBP6av1lDvWjVJu4xccBABuAA4cRcT4aMWQGBKTbXoob+yfsJMADWBcLQUvRO3jmvOw5yAYkRZhtJRLPXGD4b5VBfK03MabeuoAip7c+LR3g/hdDXIdw/v5cGmDPDCKhVRCMT+9yzhb+ubjBlJvvBnCBm/ggOuGi9hfgMjGXdw+2CxqToviKWu7D5VCuwQ3mFpX/nNp4Wc40KipIQlhiuLcOzdB6ogmSj4hxz79XsXe22zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU4PR04MB11364.eurprd04.prod.outlook.com (2603:10a6:10:5d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 12:02:06 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 12:02:06 +0000
Date: Sat, 11 Oct 2025 21:14:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH v3 4/4] arm64: dts: imx8mp pollux: add displays for
 expansion board
Message-ID: <20251011131415.GE20642@nxa18884-linux.ap.freescale.net>
References: <20251001-imx8mp-pollux-display-overlays-v3-0-87f843f6bed6@phytec.de>
 <20251001-imx8mp-pollux-display-overlays-v3-4-87f843f6bed6@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-imx8mp-pollux-display-overlays-v3-4-87f843f6bed6@phytec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DU4PR04MB11364:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bea00c-491f-4f67-7ed7-08de08bdff81
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYK+ESJmsqMVEjgH+XMyQTCMq2jE5OdRbGVZCFuTEsOsTMxTHp1S3zqFNht3?=
 =?us-ascii?Q?vMaHiXR2z2/txsugSW4DURlnkjqIHo+pY16bnyvUh+Iuv3j3vR2g0Ynfiyu6?=
 =?us-ascii?Q?5ulxQ4nUB6a9yrA3itArWfe4//5yXKC4+mbTTfUWgTv+ep9ey9t4TsTxNDFG?=
 =?us-ascii?Q?9DaStPc53yyM8zPrLKMCnRw+lg/YfU0ygHM+byQJa8Xt8xdjgt/eCyqlGpP3?=
 =?us-ascii?Q?pnNKfuRmix5V5Mpl49yYMwD0GwPTLtPHGOj9zDN5rL3g90glvZ/SlvMVlylr?=
 =?us-ascii?Q?pqWOwwaXBnCiW3sK8xXO/oo1pz/DjBOHiJKMx8Ckj7nXOryklONfsCXuiXpY?=
 =?us-ascii?Q?LdOVqCX9JSVjlulfoX7hrqAoL0k11GWLMekbZyodbZjHKK364phgG/L4NWo/?=
 =?us-ascii?Q?vIYi+rorG5zD+pjts+BUQJnDVz0+Tmw7iNry5LkZr7NxMgzQm6PB3RFDuJc6?=
 =?us-ascii?Q?4Cjsr8eJMhSiHACrIUlB3ZuEtB7OhNyetq/W6lBUurVIm9DpeK0+h4MWgGJU?=
 =?us-ascii?Q?MId/XT/Gn/7EUrjpmdixB/RvKxxGlgCsaPL0FDSr89SgMeAZIhT8e/kl287u?=
 =?us-ascii?Q?2Ns4lU7HooagafHlxhqq41mte4Je0+byuz+VBoJYxxgLtrqaQTDQ8AHzUxQ0?=
 =?us-ascii?Q?6oUW9mSdSLrn9ZmOLqezeB2yRPuZ+/F2my6VuZp9kpXZocpOJp14KVx3jkix?=
 =?us-ascii?Q?YqWi4f+ktzD1QPAneRttJUtBZPuvmGwUN4KR+3hioJZ6Dz7ltji/Lzh+P6bd?=
 =?us-ascii?Q?RuV13Fo+PqOVx9mKtTZARlZyj+60DztQbAQeN8X2Hq0j7ish7wI1KJl8CJlr?=
 =?us-ascii?Q?L/zIw07vWIiZZXgOBpRw15wdEXwqQHnNPlv89lFnBeT6n4wqs+RAXsFHyfsT?=
 =?us-ascii?Q?j/O2rJlAgrPkhAMUnjWKPLlYQTwmlRXSkBUEzWDxtHLajMsB0tkUqSfSFnuQ?=
 =?us-ascii?Q?QjPXOh6twl3aDq0A3GQvRiG0az7pooPrcLLffBIEf4kupuQ5PJvfCgzsRehh?=
 =?us-ascii?Q?IEthTEiKpVLcV1yz8KrpSW6kMFkpmMbByOQX1hGSzu1UymC/fb1uqsYPDuz5?=
 =?us-ascii?Q?kKDZAa7qWox4iuzJ/NyY5tqQyQCGUIzS7iTpsrdWmU3tctcB3Ewvdaqv56Q9?=
 =?us-ascii?Q?akf1waxFatvmSY1QJQuDind1/l1LNS55ITNkpjHHiZAPuwXPfTXqeiU+uO6a?=
 =?us-ascii?Q?lVrrmVjIUZHc1zZ1vhTqNQv+1t6mggOIA42SqgOjsO9El6Dp9hg0RnB2NC+A?=
 =?us-ascii?Q?7WucdtWk71VmCOBkheySJ5Sc0/ZW3l/5m5MXWrw1K5Ti3JvqPt280zB82Tdd?=
 =?us-ascii?Q?d4m7Ioxl0ULtcrhE5OxUWthWmTNuIyXcVyw2j1BSipSoNSnWNxs917NWX7HB?=
 =?us-ascii?Q?9ZnwZgpU67P9NIPDpUeZGGP9HKYaV409NnpFvW+Do4F6+4ErB4hdLGfWM6w5?=
 =?us-ascii?Q?qWKvDiR7bZO/7JbWq3HG/cdrHfM2Js7EqhuZOph3iwRKpmiE2N/80B7TuJLG?=
 =?us-ascii?Q?iMuBgibzHAUFOqfJKib6EmtYBB+SGwRSein4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZO61OiAMuwGHMfXzP4J15CA7ng8mhO0JS4mv2W9WydDW2TUdmC1U9KP2dvs7?=
 =?us-ascii?Q?IU6reYcFKxvAY/hhIHwrSSjkX5FpT2CruU9Tb08PFT9xxuzdnBllx8DQAzjr?=
 =?us-ascii?Q?Gpx6EgzPIe7T0rRLpbtMx/Xkz7MZ0KUoRy3bZgLYYFnozDnZVkHkD/ApKm8K?=
 =?us-ascii?Q?4jHVsr8UVDDlx4p0no3z/tFNeXpbcY4aekMwi2JS1Tyq9wBu67mxoOBE0Zd8?=
 =?us-ascii?Q?bUU8RhDbnkSOlbL/rmjn3l3q+QR64GtlR3RB+znIyV7z2L3GPYc4u4OjfxlL?=
 =?us-ascii?Q?vEgyK6ZRQ/Wyb+GAnD2jPr/vrTZgWDm7RRUHxUI8JoGAJDEQG/hLSG0q5FsQ?=
 =?us-ascii?Q?W3S7CkRKSZajIqPQVtA05irZR6Oq62SWvcWOsNxwpS1Ilx2y7ih/ltkdmXXN?=
 =?us-ascii?Q?gQvePUphO0F4Jkha25COuOZw9EbwJy/V/uY0L/e7PEP1QiBgWCGJUKdZssl+?=
 =?us-ascii?Q?Ddys4u8nwZEv9+KQtooBqruaDBDyYdOwLHZ5UHnsBC7mvYdUwyVpBfEAP1r/?=
 =?us-ascii?Q?gezbLSVfzSeRw1c/h6dyYg3CmjB5BZ03/iUWyj6kRTtq3UEzy/lGrARddKeI?=
 =?us-ascii?Q?fGuc5J0zQzMAV4+tMnl7A+m/A3jIhnoThGav8AxqKE6xGQD7GE8jr2Efsjr3?=
 =?us-ascii?Q?MPfgQL4FYTn3H/vRnOXrSi5PMacQMFJ/AEMg/zQwEpwYcLveeGiUAxQGZJho?=
 =?us-ascii?Q?2c8UST7LH7zcTMqZ0J6ag/BJnjPwMoXt7i1d+hJjMvhklXkINA2+kiuJHU7z?=
 =?us-ascii?Q?GR9iqK5ufSfvf+9HdaWp3ckqCAg9QlOI9PqBG2fUPkcc255e1wk4ECaq2K0E?=
 =?us-ascii?Q?/6nr3XBca0uPQT7pwGfW/9ZANGGWRTJZyo2MccKvcEDCcW0iLp9idGTEoFQ5?=
 =?us-ascii?Q?0g6G/XTE9ClbUPu5QSIWStYhN/SQPSC4jfP76V66n8FdTIbH5BepWcqQr7UF?=
 =?us-ascii?Q?S5jv6vRJEAZEedbGlOuiO6QeZcLijX/WD6lj0yVde+4qcH0YlYEZv85TkfNW?=
 =?us-ascii?Q?BZAFh+iRrcs1dXKBHucPBPWLmXRUjkwkgZtGePaGTDfVMjUlwx2jDt5yH3nE?=
 =?us-ascii?Q?GEWD3gRExbqek6SyDyg0hJ9EUNsu6wWzkVchaI7bpa9Q5OUYZGacYgCmRJxF?=
 =?us-ascii?Q?xeJh/buxIMhAwu6QFU/43Hb1TG3XLwhCCT4Mwd84SteT0c3NYsVAHV4iu/8v?=
 =?us-ascii?Q?MNI7Mr1fjRwqvp+qQtzOPrbHSsKs8g0OmOQyuu1U8LAmtzmkJniXnMaW6Gn1?=
 =?us-ascii?Q?gzK49VS0Gq0MRMNjSbLibsQtLLsUiwr4vCQFr8hzaVWGMVnt/ZDLZidfI3U3?=
 =?us-ascii?Q?YUkVqq5x0Hu5c8mxTG/o/o1AAG2E9dXCji7M1HO97/7+UmRG2GhyudNvsicw?=
 =?us-ascii?Q?889xc+w5UfURtFwesvzIC0nEs8eP6fCHObFs/U3rEhNWEcQBBlesqa0ybQsy?=
 =?us-ascii?Q?Mtgm9YUW5+YurVB5HWo6EYOAOPBfBLF4DvAWqbmvB7acWT4JaUXIXADHpNp+?=
 =?us-ascii?Q?LjeVOfOHz7yFGJBSBIvTxBWMuAaaos3uXu9pwjFqa8wmsXQTEzPDsEaxmBzY?=
 =?us-ascii?Q?XUnshETOodC0cpBM+lVE40PU2uVaFmACTf8WaCVw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bea00c-491f-4f67-7ed7-08de08bdff81
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 12:02:06.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQsIWsx7SyFcU8w1Kq1Zh1xM4Zrzs63voYC4LDIR/USdMN+WNR2HkWE8M22C3wCeB9q3HuyMjZcdEQZCevzETQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11364

On Wed, Oct 01, 2025 at 02:33:54PM +0200, Yannic Moog wrote:
>The same displays that can be connected directly to the
>imx8mp-phyboard-pollux can also be connected to the expansion board
>PEB-AV-10. For displays connected to the expansion board, a second LVDS
>channel of the i.MX 8M Plus SoC is used and only a single display
>connected to the SoC LVDS display bridge at a given time is supported.
>
>Signed-off-by: Yannic Moog <y.moog@phytec.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

