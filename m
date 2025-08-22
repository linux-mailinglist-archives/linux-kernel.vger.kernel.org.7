Return-Path: <linux-kernel+bounces-782207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E58EB31CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959D6B411E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45C730AADC;
	Fri, 22 Aug 2025 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X5fe7XD6"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21130AAD2;
	Fri, 22 Aug 2025 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873837; cv=fail; b=QDZ53F00UMusg4KSsWStEJRBbrZQpvebkDnnozpn5V/2ize1Jvg7PU0+U9JL/HnQvEwS2BlW9sz+t+MrMrCDVi1BEy38xGxFwIKgqRH2QOfOQ+mNTIdvGWBKdPVq/4LqBFcKVGrUz6jtgffpReFAqT7FpiOv870Y1wm/4MhBlcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873837; c=relaxed/simple;
	bh=ZjH8u5BVIQRTCOh4H5w+dKLKAI3WrRCgytUL3mx/C1E=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T3GscvJT3eWUR0nh7SxTH+rVBoWywyqwp+/DfScJKd3HSrxCE2ECAsg6FqAYRz2mqxbChV2LYIgHjbrDb5v9lfgQ0xuX0ti2IFcYFLkkavJF5QbpRUICLx4jWdxEi3wwGdxkJR1/bs5I8ap61eizh8FnpK5cjWkjNb5mMt72sU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X5fe7XD6; arc=fail smtp.client-ip=52.101.84.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORESvRNmoVYBVnM+gSSt6me1jF1S3CLGMrimParHJRwXwEw0QBD/ekO69uTH8+DUj9ZlQPq577h64YdHOWmfgvF5BSQQx/k/+T4ZsiDowHDue3UGfIA3DhqeS6Rvjq58I9jG9gTB3p1yz4PjjZuAHDGOH9wMqKuY59gGrPLoMQxioeH6KZQMnZBHWMYxwjrg7KwkBybZNPX7fQxRh4AQgYHrk9UZ42nC0AUp+oGPGUNRqnjVd2mpQCJ3pgW810GVTOF2S7Wo26B3ihMZiihIINbRMBojXlrTDXvMacEGVmOTAyWJWScrFxAI0FMOUKS3GFRm0DdUAfY78jilIZ+rzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwrR/T3hJ0k4Yy4mDwBSBvC8MzVLkNsX3p2twa7fO3Q=;
 b=mrm+Jf+CwDCgHgeeKFQBOOcgSsTLwadEFnVKbzyVQ6XKYznq8EuyC13mTiN01KI0z+q2X9f8chRy3PtL/hvSWvkFknv25+3zTz4HNCCeO6AM/3j6k9DNqSpb+A5sXBP3C2crFZ7goLIMH5qQINg7GgvF8U79IZNmHTCWJb2m3MKmfsFtM2GZqL76IsLzcsGOMsY0dReKtOTlT1gizFgEZqHZd6ZDRjxBOBQdRaAzfDrIfUifqHpnJsEUuG2JkHAwQZLcY5/fdozrxbwy3t3741gK0XIjIDpxUGHHgS7KHZCHfskBC6m3wHpuiRL1szhzhvQIolAHyK4yn1g+rK/UfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwrR/T3hJ0k4Yy4mDwBSBvC8MzVLkNsX3p2twa7fO3Q=;
 b=X5fe7XD6ZZgWJqVRIMoevshzAAV0U1tbwY4wGAlJCNmVvMASjq897IgfE+xqZ91toePr4+feE/8DQm4Tn3xOSoZ5JZMaLvBfJjwXSuj3CxX/WVR+jQ5qngIc7giCH5Jxa/LH6dRxSG88zvF9/x17QnPgvFBq8NwSj1iO/h7o8o/RvrvfN6ZrAIAYSgB6hu/aj7btF2jm600/U7iCh6e3pGNX9KEvAEVkVajt6HA1iPlTLeSYa/t11+k/xKzltZKr1bZwyK14pI7ZPyZVwlKieF0KgdkYn3lSdcCsa9zhF7PlR3/wpEjLWG/puTGaUmxoCXVUuebEggAjrcPRhR8Smw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 14:43:51 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 14:43:51 +0000
Date: Fri, 22 Aug 2025 10:43:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Vladimir Zapolskiy <vz@mleia.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 00/11] ARM: dts: nxp: clean lpc18xx DTB check warning
Message-ID: <aKiCIZf0eG2F0nvr@lizhi-Precision-Tower-5810>
References: <20250706-lpc18xxx_dts-v1-0-7ae8cdfe8d7d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706-lpc18xxx_dts-v1-0-7ae8cdfe8d7d@nxp.com>
X-ClientProxiedBy: PH7PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:510:174::20) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI1PR04MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 963e6e83-cf86-475e-69a8-08dde18a4f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HtfLdwchwrmS5B0vIoG1ZQXft9n6R1Bw1y16dcJt1uFuTRJCo/zlCh4+RGLe?=
 =?us-ascii?Q?S5Q/EYgFyb/nzkrb3UPwSndAL+oP65mR3raLrQhdnuk1tfe8M7qE273Di3Vl?=
 =?us-ascii?Q?nZDWM1DxOVE1YdO3c77MalGeeIcGRd/eJ8fizGiSdR3DMfHssF1M1dqDIu+U?=
 =?us-ascii?Q?anLxY23s9PUpLx5qJuEEr5Fbhi7SOBwWO8XhD9VBo4RkUYtmu/leOx4CB1RH?=
 =?us-ascii?Q?88QJcMIg/TJL+IhkYheUORqEoeH5+9CxbcqGJn1ZOtC3PeMQzXDF+bCIlV2g?=
 =?us-ascii?Q?m4WJeN0VATT1x5BQsLT6HC5OYR4FjZfC0S72Kd36iH4kRQUg0hfxBddeqOXl?=
 =?us-ascii?Q?IlYG+zXD0G+73nZ3cV7p4ssV4eEQn70hCXMTIFlB220GbrBdyi1ODDrOjHAl?=
 =?us-ascii?Q?1H0Q7XMWLnnK3C8a3txHaBgcATx1zb/gPE+646ioIH38ZXm1xuhzZwDOyH2x?=
 =?us-ascii?Q?B0zfjYReSsaJrArOtKR0FyN7UeJ+syOiXBZotz0MVpqwwc5/WwRPcsEqIRzB?=
 =?us-ascii?Q?mwxMJN07xTCe3Jnrd/Nm11liPSz0dtOvS2cAqHnH0k4DHMfS+ezfC4zdeZuo?=
 =?us-ascii?Q?qf5ouHly1Ly2x7RMAneQC4OMtysNT7+blfFjl59O5IHTNUlsmBjLcM0xx5kl?=
 =?us-ascii?Q?ibZl3CZnLLUuhuRhEBxvH74bAVVggbivLd4GLdsnIw30pAwHl6SYA3w35mJb?=
 =?us-ascii?Q?AeC+BVDy1Um+S3gXlcwBNzTcKNBGYHoIGtjVXYvwLBrCgNhPpaZsSQIRS5DA?=
 =?us-ascii?Q?85aNnCXONBNSeuWj+1m+NFTJcvxsh8mdn8dQpTK+rFvHR5Zwj+9YzRlNoRM3?=
 =?us-ascii?Q?mw3o4SNgMwRDaWGa3eUPiD1NQ0NSgk3cCZsOuyZc8yMQy9erFU/tvDTcCQjV?=
 =?us-ascii?Q?zwRRVeWOTby3ERN9tlPn59pKPvOHz/y+8N6k1GIKrw0iyQwaviAs3z1qpb9o?=
 =?us-ascii?Q?Q3AqgCFpcx1S6lQWSwW/X9AxdQIHCYZnThAx23S0nQUNxT5Op6UulYWSvXZc?=
 =?us-ascii?Q?aWbSAPs54yjGgnBrpHN3selx7tUdpgBQhqDnE1HLL9ASrNkS8TWYyx3pV2Vd?=
 =?us-ascii?Q?jGUbThQuSEgOlmfi7tVSF3aUPd40bkioU+YEi02okkk+/KGIcTAbDR+2Vdci?=
 =?us-ascii?Q?V9It0kmgFkDULbvcyGbhBNfO/orxYHrmSUCmXNNUtaMbS3O1h3A0/OWted+f?=
 =?us-ascii?Q?k4b2VCGLhTmwPqY1LI9g9EdHRoLWSgb88zkTAgFIf+43MlnERgQPphG9tqx/?=
 =?us-ascii?Q?ky8i4kdTQOHzbWcy18q1zSmyg/Hs1xjP4hIv2ZajWxgjLfAHeOtRFGrjgaV/?=
 =?us-ascii?Q?XFuyIdTO0ZepHxU62vRiPn8nwsM8Cgcj8O2sNQ+yPPXSGNYf4Bd8m6uTihVC?=
 =?us-ascii?Q?QJmOlUqcoBIh7bC0JAOx8RQzjIF4eNm60IbF1y7xCU62hkMNaXuZ9w5wrbUp?=
 =?us-ascii?Q?NofL8odjZ7yYTTJ6xd4Zlrr03AfV+TYwbyf3l2Bqvpb+kHMTfsYenFILZxf7?=
 =?us-ascii?Q?FLw3ZgKT37frh7rgq1/pchr2vQFouTqTgRDE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3KRiRIiiWt4GBsGg1PdDlQ3/Z5Ge9PQaKIwzTrj6xON/8a7rtOfNjSXe4C7?=
 =?us-ascii?Q?VhZ6q2nsiRiJziUuAXtD4HH6K7B2TzVNnino0nObZQlleMzGDvSjfEzzPCXm?=
 =?us-ascii?Q?MgK52E5S/rbcSyn0KRty8qdMawrSJ3ArdyVIkrLRlX/4qJQFRdc5Xnz6SOfK?=
 =?us-ascii?Q?2Mo9T4noUfz9xOnN0pnJAiYZALh8bSeKpFNSo+kdMydjckMbIA2NbVVLp05b?=
 =?us-ascii?Q?KvtbdGakvtnlZ/JvrMcYRzuf45K1O73lDDoYbg0HwihZHCFPYbbKM1kF/rFi?=
 =?us-ascii?Q?txfrgHiGQlx6Pwc2SZ0jH+OZhyfdhyscm7tcy/6gGn3Qau4puBlIu6V11OCj?=
 =?us-ascii?Q?SJ8YzM+NQwIp85FyMAr+oxyboandWIqAVIBIOArDz2aQKpRhiieYfMjAvvag?=
 =?us-ascii?Q?xvGUkwEK7mFGmdFo6TtSpepENl3GoWq+0eawDk7LPG0pJDlfh+mdf5qYVeog?=
 =?us-ascii?Q?w4miRagghPjia9tGgvujKmWr5xU88/dlFL51daDFVSayAFmbghbSTVa7i/wT?=
 =?us-ascii?Q?9f8EGMCENZNF8re064nYUjwzPuf8YOkQq3+Kzz1tkJvx/M+ZvMwScrU+KFj5?=
 =?us-ascii?Q?VbYijGb+MFJclvgxTemg1wzXz9RflLauL5G7YaEsnVCZXVZcuqg/Yc9xn1Dc?=
 =?us-ascii?Q?5bgkHRFtosRxZLuWAHtCKdfiHVDfzITbmp7vWTVokKl0OkzjsDn5m13mwUtd?=
 =?us-ascii?Q?kZXAn4HbHi3rf0OCHYUGXXwcVxtROD3plaYEad5pGHd0vRpQsfYC+h7mUXJy?=
 =?us-ascii?Q?1cVhqw5JNqQ4D3CTeNBlhaD12WOpGpyuJo4nocrO5/iXY62SviwVbdvERqFl?=
 =?us-ascii?Q?dKe0sSEuujQrYsvbpO+EjgepD0R55bDMP9Ti8Te6vLtLklmJb6Rfc9++FjfM?=
 =?us-ascii?Q?+Unlhypek/NFEZFydki00nYrPVzLO4q2OfyCMhy/KJDHy3BhdDdu0qoiT2fr?=
 =?us-ascii?Q?Z7PpTm/JRS0V1ZnBv+LyswP6i30NEqRPOp/mLcrCRwB2AI6ORwn4iAihk5NE?=
 =?us-ascii?Q?Mv2FfjwMdgidi35HdbEVG2dzptfrCsWxSefE9+jlur14nDXy4Ow+65jg4PcW?=
 =?us-ascii?Q?fwAiY2h4Z6mUIx/netBPHHAGADjn1oPyMHbxdwEVMpVMkycxV6QsH3pGxkhT?=
 =?us-ascii?Q?tIfW73oDpL3X+L+SMCO1ea2bp9ibsSbuKCjibCrGOHgOcxZXRBBTlHazcvvA?=
 =?us-ascii?Q?Kw90Q6zBjWZjG3Z+FJaakLjXF1q2wvKOGTf1JhjoElymqV9XUUJHcfL09LhK?=
 =?us-ascii?Q?cwi2HGQT1F5yOMyqjRehluLo824ixpS1rLYQoDjBm98XtCrSAIqFdDBsilb7?=
 =?us-ascii?Q?ehDxE6xuX0l3LTvspcW/+Q5vlnkymnE095fNgoZRjyIGslnh5C33Q45Y5op8?=
 =?us-ascii?Q?GEZ2A5lNP9Iua7RuA/zWf09X2bb8gmwErl8+Eb+IJf57fci0Ju7VEvisWjjA?=
 =?us-ascii?Q?FdXs3wy4E4c0VxZDZZEAg0XE9cccufXlr/0pIU8D/ChyknyIT6q2FhjTB9x6?=
 =?us-ascii?Q?ejYcbRJPpuV2hrcLB5yIsm5oxEOnIdcrtMIRrGWV9XUS5vTDx1XnRa3fqDES?=
 =?us-ascii?Q?QKtjyAiI3Gezm8ekmOJOXuUTjqjKcQWewd0rKr+M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963e6e83-cf86-475e-69a8-08dde18a4f97
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:43:51.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kATZf28QiH9ZsTKriOam1N00Tk56a/eDFHna4l4IgJBts+4IuLbyx8lLEC54vWabyA3AvDuRiAFLT1AIlB3ZSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7055

On Sun, Jul 06, 2025 at 02:46:56PM -0400, Frank Li via B4 Relay wrote:
> There are 3 dt-binding patch wait for pick.
> [1] https://lore.kernel.org/imx/20250617-hound-of-improbable-intensity-e7c3c9@kuoka/
> [2] https://lore.kernel.org/imx/174916907717.3619367.3745642154654809311.robh@kernel.org/
> [3] https://lore.kernel.org/imx/175087864578.2055525.4510390315154712025.robh@kernel.org/
>
> lpc18xx related DTB warnings reduce to 0.

Vladimir Zapolskiy and arnd:

	I asked shawn, these are not owned by him.

	who will pickup these patches?

Frank Li

>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (11):
>       ARM: dts: lpc18xx: rename node name flash-controller to spi
>       ARM: dts: lpc18xx: rename node name mmcsd to mmc
>       ARM: dts: lpc4350-hitex-eval: change node name flash to flash@0
>       ARM: dts: lpc18xx: swap clock-names bic and cui
>       ARM: dts: lpc: add #address-cells and #size-cells for sram node
>       ARM: dts: lpc: add cfg surfix in pinctrl child node
>       ARM: dts: lpc4357-myd-lpc4357: add power-supply for innolux,at070tn92
>       ARM: dts: lpc: change node name 'button[0-9]' to button-[0-9]'
>       ARM: dts: lpc4357-myd-lpc4357: change node name mdio0 to mdio
>       ARM: dts: lpc18xx: add #address-cell and #szie-cell for spi flash controller
>       ARM: dts: lpc18xx: add missed arm,num-irq-priority-bits
>
>  arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi             | 14 ++++++++++----
>  arch/arm/boot/dts/nxp/lpc/lpc4337-ciaa.dts         |  6 +++---
>  arch/arm/boot/dts/nxp/lpc/lpc4350-hitex-eval.dts   | 22 +++++++++++++---------
>  arch/arm/boot/dts/nxp/lpc/lpc4350.dtsi             |  9 +++++++++
>  .../arm/boot/dts/nxp/lpc/lpc4357-ea4357-devkit.dts | 21 +++++++++++----------
>  arch/arm/boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts  |  6 ++++--
>  arch/arm/boot/dts/nxp/lpc/lpc4357.dtsi             |  9 +++++++++
>  7 files changed, 59 insertions(+), 28 deletions(-)
> ---
> base-commit: bb0fde92b56b76f7a0c90a6e9d9f050919fa835e
> change-id: 20250706-lpc18xxx_dts-b2137216e6c0
>
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
>
>

