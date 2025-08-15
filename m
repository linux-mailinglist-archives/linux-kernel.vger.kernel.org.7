Return-Path: <linux-kernel+bounces-771204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873ABB2841F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6B66015ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC630EF9C;
	Fri, 15 Aug 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nPRTM+8I"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4CC30E85D;
	Fri, 15 Aug 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276124; cv=fail; b=ESWna92uvvedO4KyW9iCcmYOgsvmxtg9wdlLqJO/6WBfu+CQbd7S/B7vYSEhbwJW0Pwc/ARwK8+4DXGJrLX03ALCrUUZcx/tHzEnHJKLVMZet6beNcjsoQpQX+aWAVYHUECoxoWyCR6Pc3Lwu8y8JVcWsQ2+HjbipaRLzjUY1oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276124; c=relaxed/simple;
	bh=dy5z4n3lAYNG9YBRQ+tjRyxaqYTTy1Vq8e6rwgZ7SMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sy07g423OlnkThDBxWMrBcJR3RWYeHl9itW6qkq9FCpCeDH0em2hHAbk5yIeZBbjXHU5YINT4NlTLrNiR2Ux22DDnnL6hYs9oyz/8QFv86LDglDHFhHUeYpSci8eVW0sXT3QKH7fpi8lWCHaBjOGljpTOle8tTPhoXmBD34LM7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nPRTM+8I reason="signature verification failed"; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MASqvV6n9upCyjuffQSdAHu9F5x0QaCARYEE7MX1GZgniUIZaoOgp1cOHHx+6vmYNmqZgY57bhqK37HTzb39yS9LDBgglwjMvsLhdY+EeezqcsuHH2c7h26IOwwRXVV4gczjDAzXgJ+4pj+y6OKvn+3fmTrFJ9kmJNoPjdxaVs+nzfR3AizoynNlfTNUvDTx7im/nzrxixonhvEFkr0hi3IiD8GjwEqnCAE1qUqjhhVfd8kwQt+dhIV9VXZwQ/fmuFujX6Cpw+5pJgJw94pNZwXj17jHfI5I10NpfX8YLKy90q8jd80O9j59PFf6OyaMU9TJduDGG7yKVThBTE9K2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukEp5cPBZSgX80uWv309RXd/pj2SHRypfq2+jZ3ytJE=;
 b=a9R+FnLUl6sHoai+OUXwFzjP8I6ckoyWbHaldC/1cJWjZg4zsYdQlHD0ljS3Pv82bPTuCK/DySopq7xBaHb7uTikF/ot13K4dR12PK+9d6Js/y4tOTZc9babinHDiZ0adDB6T+OQgbt+7cKkxW609LrK4Tekis+CQY+rgfcnpbf4Vr9MqsswWFh2k5cRNX/6+5xrsehJpBI35uGvWZfU/Xv1OFX3mTuxltYLQxsD6QnHUMR3ZvaBt3Wr7WKcwljUnY4OFohqogbIm3O1FPFMbDhCBfJa4HkKdcr0aDxMPfUqtiFWlgz3TwrLSFWPofeVC7oYAdDt26Edzuhq8PFcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukEp5cPBZSgX80uWv309RXd/pj2SHRypfq2+jZ3ytJE=;
 b=nPRTM+8IXTw25+DE36oTa5lwklGrrOK/BTPQjcawanyPZmo1JRXlt+RRd/hIgfA1fQbVrHw9sKpvkxwDQzIPltn775/D71seLS5lGPmuUM5vB8jczMTCq5zYiAysrWUAVLCms4ufwKLcBiV5y0EyN6Wg+GH4VgXKG8fnJDwwtoc6saDPaYqkusizdX7UbugLESrI5PnuMKlERfYBnExgXLzp1NESBGCJmpTN8gEk2P0YkCic+kNLC4WYPo9UMhYKNyIX5U7XRxzLGf6sKZuUF0QIsM1r1gvxDETonOo/AoSkSRNyWFHBYUMAcJucJjHALmvcoYyk7ZAZODcNEkHm1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 16:42:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:42:00 +0000
Date: Fri, 15 Aug 2025 12:41:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] arm64: dts: imx95-19x19-evk: Add pca9632 node
Message-ID: <aJ9jUXG2eq5Pfu+d@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-10-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815-imx9-dts-v1-10-e609eb4e3105@nxp.com>
X-ClientProxiedBy: PH7P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: c460dbd0-5943-4a9c-d7af-08dddc1aa7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?FjvGvzw7Y0ADDUAB6R0vG6A7nbQEffejWrpLYlv6J22wXmPfcWuDfP256n?=
 =?iso-8859-1?Q?BZN8P9Zgo6nPkHvoTOWKNbiS75+m7cab7EIoLFi1UgMJVggV5efQ7MOn+S?=
 =?iso-8859-1?Q?nSZq/kY7YFdLUaiDTcUu1OdhKfvVg4DAwewab51cAPULZ7yOBqoqhqZnTj?=
 =?iso-8859-1?Q?oIfSkc3+tDKqNDBNMPdx8nCexl/+4+49qLrsPTKEQmQr8oZ8fg/jdZsD8d?=
 =?iso-8859-1?Q?29J2Kppo/BpCEbT2UDSH2cEWGu/jqiTMwcYKXP/CZmZRB47H6JJeKymMtm?=
 =?iso-8859-1?Q?ho/NGAzvD94SuAqN0QVPpWmvczzNWtW7zkZw4i9pv1V9Sa+ipQfnSadBmp?=
 =?iso-8859-1?Q?VEfwM8nJDbDOmW6WwWKpSfBau89bclvmmU9QXgalboFVj7jgcETZ7fvnEr?=
 =?iso-8859-1?Q?Njp5cUr8HlAjL2wV53EXY+MZqAIXNO/oYcz8z/wz7fynPtCojMBQ9vZUkb?=
 =?iso-8859-1?Q?Ft4IHcT07XRYlGq2mIxWwAX4zOdBxHdp8m96iH5YmKR3MEq14o9TIGgGXc?=
 =?iso-8859-1?Q?TonXP38cHJdUnLZBDxE+9h6XeK4N/r5Y/xFb8xgWCXxcChP9EvnRcYi4DO?=
 =?iso-8859-1?Q?hKb5AsRMMKZAZZhITmaME4cAYpMBqjgSYwDlHuneIBdk34ltTkYTfrx7mU?=
 =?iso-8859-1?Q?3CvMRlOC4VOiJiFHsRtC7Wao9ZRGhfujVVrfkXO9IUIN2aPo4PsZ5KXJBv?=
 =?iso-8859-1?Q?hm3F8Lr7LdalEo+z1A+PTVENP4K0pXDgyTsL8DNXpP+dIff7iiaEkpBVYx?=
 =?iso-8859-1?Q?OcQx5mQIoeN7/zvauCUTJ3qFJGaNIBrivD9QEy6dvP+4gfxpPsNsm5FeMO?=
 =?iso-8859-1?Q?AbGBa/CoZl4cg6P9Zu3zsicTcxSVYtQdpTygMmO33ruZ3eF8MlZhynPdbZ?=
 =?iso-8859-1?Q?zoJB1yzAqXl2saOfcK2IpoHd9pubb9WxEFD8qMO2h35yBbKzzNOxMGKtqJ?=
 =?iso-8859-1?Q?OVoYQ/04s0+qVPEh79oc7/lJv7mQAN4tzHqMuYj2ydqIUzifHS1K2f3xcG?=
 =?iso-8859-1?Q?4+ViZ6b0tgN+9AVv+3x1CadLZt6Jwvtp1tlS6Vh8OQnRvQM0G1CFoapI3U?=
 =?iso-8859-1?Q?IXRN9fgDYwmyOxHd/cnNJiN9WY+dgvae5Bo6AHDqhXsYCdEWIbv9tcKFdK?=
 =?iso-8859-1?Q?bnnv/LkpHygc/Up7AW/X2RQGl9tjki6OvG+ecM6ootB3m1KrQ9cFXS4ETT?=
 =?iso-8859-1?Q?Ub7HAjwToz5T/xHtceiYwE2Dprw9rZ8sa+EnqB99joKFV1IxAHatIyqyce?=
 =?iso-8859-1?Q?q6Mpgt+/5wn3VP9xXn4N8o1txa+P4uElmomKRlLb7M/n1xP1KJzwAFxKab?=
 =?iso-8859-1?Q?srPR1T2BTcIEnPPizeXqhpLSibwsM7liDGAAkTrJHwhHUYkfTqud3VK14W?=
 =?iso-8859-1?Q?eAyLsgahnhr1j4VZ6mdFxQLe5XmBp9GgLWQ6pUsNQwlD1LNgWT9Os5GZwc?=
 =?iso-8859-1?Q?mIveFVJdHs8BUzsVvgEFLpreDyY+03ks55j4drD0MPZurODCl8FGYg3qLY?=
 =?iso-8859-1?Q?0JRgRE/WqkF3aEqGrcbUunjyvQV/cqZvSlY2g39CVWQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?JBiRTc2VFT5nbOwNoo1Z+QL3l6NSyiOjwJ/6A9wfcRuhLmVS9SLQaWfiZq?=
 =?iso-8859-1?Q?F4PvhjL3UcmPB5O51/HiFGWmoMTwdsOy1FGQofHO0hwhTRmlI1OfZJi4OU?=
 =?iso-8859-1?Q?qkUgj3NArW6OPmiVQRe9H9ZllgAz7CH6lUp7zwymN2UA0CbdfqdA7VIG6/?=
 =?iso-8859-1?Q?06OKBnQ1/Kfq8AtQamcydBkL/kf5+SLz2oSbt2cndIP/yColJ3ypFTcAS5?=
 =?iso-8859-1?Q?69Iw8G6cL2AXj8JVR0mfoxXo8u6ez8MnRNa/KD6nHnp7BF4AVDx1bs/s9X?=
 =?iso-8859-1?Q?QRScBFQYUqYQ55OISSNDeTD4S0AQJnPNFyvPgdnw6P+LYE2uWezzZk68ul?=
 =?iso-8859-1?Q?e16/EbYEZ3xtsVl10GRWWppEPZFhU99NFjo4vV6XYFSq+Wa0LF+rf82GMc?=
 =?iso-8859-1?Q?35+Yyks1CtUryR5bmFSVjVfncRWsj7sM9l70AbDJniAD9lzG/39pXkmlCC?=
 =?iso-8859-1?Q?OprfL5Pm/J0vMtZ3GwaZHu01zbefmP7nxHqF0XHZshjr9UcdSUxWlpzNfq?=
 =?iso-8859-1?Q?jZF9gyBQ6xdzcdHc0dSRCvqGkWw47khL50Z39wan1bn3tXaAvKYUmfVNZ/?=
 =?iso-8859-1?Q?NNDKuR9Xt/QOLYAHSfAJophK02/3UL/rHpcCURYbE6KW/csHVZKsDjhQBN?=
 =?iso-8859-1?Q?4P5NP+ej9dbSrXPcnubUqV63XavzV0fGTP+DBiCY9bDcMZNC2clQDF2Ygi?=
 =?iso-8859-1?Q?Ewahxg6rCgl+E7YL+QQV3m3vrsHfTMlPwcxBuL9OJoJSy9RkGd48Rt/2JN?=
 =?iso-8859-1?Q?Q5vb0eCa+fnTEj9Ki7zMafJvdV/OX23oNPmAdK0qN3QgSHv8l3SU3fxJ69?=
 =?iso-8859-1?Q?4MAD/bWBHzJDohIlIwgXiV2S7l7uhvXa9UW3SmMi3Mi1YiblZaBVIxCRO4?=
 =?iso-8859-1?Q?uvnsBfrTalkC7TW8SV70uVt1aWpmbheWx8CZAPGhMxizxA2Pl5+VSPPRJi?=
 =?iso-8859-1?Q?sNNEfKQQeV1eklGgxysF9e3el3qo5ueSLSORf9ix5rr0wganaE95nGJM6K?=
 =?iso-8859-1?Q?DxkHhF6H314kR9NIeg46IDhPF7XR3x/B9liCDQ4mNJq7QkANR8IzOKOamG?=
 =?iso-8859-1?Q?WRqGvyOHyQKKv/5kVk+symVQ0opw3jwOZIGDSx3+YU9dPdgDk1jIjxTOdO?=
 =?iso-8859-1?Q?gekbzsIvzPjWqIBv+ANFFqSsK+SktxDKyXkFf+L7YUwWCZ0u29J1dpPYqo?=
 =?iso-8859-1?Q?QWDOoFWexT3J+gO2pMtCxpz6sgduVeOofS3uTLNW7CDdURnGg6VRZ/MJXc?=
 =?iso-8859-1?Q?2KqKMkrZctv/F7TYjRfuwiDp4jLS+tZVrNaPK3RwR8OkRaDKxCw/klsh97?=
 =?iso-8859-1?Q?gO1/dxPF0zp65G496EvqyU7a2DjrO2+WSCsTyBjsruk0Zh9AkWiHNIOF5U?=
 =?iso-8859-1?Q?MPRHdQUnXx5cUoPS+GfFDm8C1dZX7M64+j0AsbnEK1WCi9zdiONdWMIcQW?=
 =?iso-8859-1?Q?7c7SagLCx5oKknP+0NkyQ/sVG4LHjAPOc5W3y0TNvm2ojAk2s3Wof2Ge1c?=
 =?iso-8859-1?Q?9aasalCPckrWjEId6QSU3Oyv2dtU5E/o2jhH/ZM+40mliesGhwwLBzfxJD?=
 =?iso-8859-1?Q?uCVK2wBDpuKGrcgOFTxKgZxGS90HsPiGskjCn10kqowsePfOQ8X9Tfgtq8?=
 =?iso-8859-1?Q?tlM5kYYwI7A6nMwThUudswQfRqlvIptZ26?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c460dbd0-5943-4a9c-d7af-08dddc1aa7cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:42:00.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AX9lTY2nC6lgre3MJSkumqqazAoRgzv5522/0MUwGInKbC5GBsf6rbsZ/ZmWWZJGhmkGtWYIl3g0sltOWdmcew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7051

On Fri, Aug 15, 2025 at 05:03:56PM +0800, Peng Fan wrote:
> Add an I²C-bus controlled 4-bit LED driver PCA9632 under lpi2c3.

I²C not sure display correct in all system.  I2C should be enough.

>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index 82e183dc581012a7c5be3d2bf749463d0a8a360d..c35a5083c837379804e07f98163c0a5d4301abd7 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -329,6 +329,19 @@ i2c3_gpio_expander_20: gpio@20 {
>  		reg = <0x20>;
>  		vcc-supply = <&reg_3p3v>;
>  	};
> +
> +	pca9632: pca9632@62 {
> +		compatible = "nxp,pca9632";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x62>;

reg should just after compatible

> +
> +		led_baclklight: led@0 {
> +			label = "backlight";
> +			reg = <0>;

reg should first one.

Frank
> +			linux,default-trigger = "none";
> +		};
> +	};
>  };
>
>  &lpi2c4 {
>
> --
> 2.37.1
>

