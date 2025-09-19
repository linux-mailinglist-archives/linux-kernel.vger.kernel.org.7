Return-Path: <linux-kernel+bounces-824905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070FB8A701
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C501B23F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284431D75B;
	Fri, 19 Sep 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IrbYmxCK"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F92C21F8;
	Fri, 19 Sep 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297260; cv=fail; b=EXBaKaU7SrBpDPxDG9+FTRhQ+KJP9Mwu987vR+27nkcAtjqP37OJR0DB7778vo3G+Hpeqm98kRlqaoAEtePS39K5Yd3738dGGcPNC1/FPtqGsE2YUV6uT9HX/tFreLmuEK1y2mz3j05zMTBi0nW1MW9JDAqdb0GiMN9LHdVbx6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297260; c=relaxed/simple;
	bh=o6v3F4MmcygIt8uMYDtpAO6WqwuKvtFlRIQtOkNEzaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7HuHKH9e3BFiws4p5N1FoNpvN7aquvXEDSiDhryHn+tl4xD8aYhmtZGGdEOzTmxitCPJe/J5rmqzha9fFJ4uSucIMbANfewX39/Lsnt5ywHkcIJZLCwH0s7vtV6uG5gPBVWum3B4WkZptbcS7v3SsbVsXKH1hbVhIfRL6oZbz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IrbYmxCK; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9Th/eiCWOWt+8ktpYBScTZuFClPpP9jBcfcK3VgM/oXwgdpPXHj8A/kGBgJR32cdV+P+y++6Wo1LBcGicXSsxGjJJ6MPZPCEuhL+r7xx/z4+hE18xSME8Fn9rqoDiQ5BeMz4duCo+/KtbF7wyvLZHXR0necswZ7ayX4ETIVA0aaj+Zin/IBsb9f//v/gQuOlWeyFWBYxj0FBOskfNG/uVRK8vz+eLTPIYREXPp/njWqBFVgXmA/NSlUakCg6GXSujh+carDFLj1JYBN5Gd0yUXZix2R/i1GfMdtTYCqNHNwua34sm0jQ0oZMZimF1CsWdI3/9JUpvDyKQM/nV4H1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygtKTxRCnJwuBIMZLqtDmxiGGGvbDaHDG5hKDmvdWo8=;
 b=pUn2SmgXeQYv2RzkIE1WBOPl6SCtCk62AMwNS72WD3Z5nmXibCTefTaGx4TQA+kH/DENk+lkuba2MzfnT03KU9Hm790f7dZRv/N99RLCWx1YQPyFwvk6mz51a0b+/nzdpyA0kPMS4hR7lI6jFuHeba2bdXjS3YQRirzKiNoTNMziTYaVkPfE4P+wmtwpCOUxKmi13PJ/4vumioyTkrL7cdQcmfFfKkLtmXai+okBYxwqPaqgdh2hl7m/A5dOCE9/NVzJS9Ns8UyfJVlZ1va726RtwB6YwfDzFMXk/0Rivz8kPEB/0KWpIv3kMaRBQGQHZMfqXvgV2GYWPBd7nXFrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygtKTxRCnJwuBIMZLqtDmxiGGGvbDaHDG5hKDmvdWo8=;
 b=IrbYmxCKJet4ULcj5EwVrzaJgg2o+DmG33pnp43wT7cVkdPx2SC7R9C5E+CzOHCKHLBG1Kf3Amp+BohHbMNPAdj5h7IY9rGi8I+4fESDXlHj8ILatpQzhRZjC0LaNZpU/7khAtZ/PGH7fJA9swCLhJGb5x3jbxhy3X7crATKcEeSo0C0LGgn7ua6sRZT8hJb+TcmF0h+HWmo81inY8ZDRzfox4i3gId4EElMBlzLkt8s7R7x3f0wAqgHLypYiFhzMv3XH3yZIN59XJ73Dm9D3v+JuSxhtpf9bGxioM1d2/yBvjfZ26FLmmFqv1gNB8tZSVgs4OiGx1P1V0KSRyWU4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 15:54:15 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 15:54:14 +0000
Date: Fri, 19 Sep 2025 11:54:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: phy: imx8mq-usb: add alternate
 reference clock
Message-ID: <aM18nN23fRwpI9DD@lizhi-Precision-Tower-5810>
References: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
 <20250919-usb-phy-alt-clk-support-v1-1-57c2a13eea1c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-usb-phy-alt-clk-support-v1-1-57c2a13eea1c@nxp.com>
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5af416-7f88-4d24-4755-08ddf794c877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iXRl2d+fqjIj6gBagU70K1kJwvO9Lab/NCTa2l62aeNfQif9byE+dYrX/tTq?=
 =?us-ascii?Q?Hdlje6BZw//GCGynTgQr+YKW299oJjp2/gpApK2qPCKcGJNa7Ydir5pBWI/0?=
 =?us-ascii?Q?xptw/i+EvQnNBSSkncLOX+g5tLXYs8Ie3z9rvFuSsU/aI4HCarT8CNz/vTU0?=
 =?us-ascii?Q?vqcUZUHaSl/EBrPxRjzuv7RMu+5tM8xbHdZOoVjm+oMbHg6uJPbW4TxXWEv0?=
 =?us-ascii?Q?7maLOXfSi7wQDDJYR0WsU8AlUpaEh2abGgcuuMDVIXRmBDOuoOh/0mGlhVYI?=
 =?us-ascii?Q?yF8syE4ywoMCDtJ/+VRFDJe6ScRN0+tzX6VMrROD6e67qQiasuM8fX5yqzcW?=
 =?us-ascii?Q?tWnulWVdtLaSYUqId+6kXkjlN7vE/ZXItvpsBwBK12PtgvTKCqEm+XifGXWQ?=
 =?us-ascii?Q?EBN9eQJb25UISzHiat6+0Q3dEvzkskJEpVfPNWgFulEX0T9EvjjDTeYNIZCE?=
 =?us-ascii?Q?EQqKaLha2bhrLaUlk1BjUnQVz9aAEp7sF4fuEc+MuEd8BBaF5ukUrDlqBfeC?=
 =?us-ascii?Q?QHO5IwNHXYu/0+m9kDiUFzb1HfGtHqAQyxnjf6NWzwgC/y0kc2mg2vXTHoHO?=
 =?us-ascii?Q?7PkmRBcQBs8Nhd/dTpMJ8Ty4u5JxPSVyystL+0/E81egRcrwvS1GWk7Cpg1M?=
 =?us-ascii?Q?FOzYINTt4SnYOAvo2RAA+9g+Carzop6QixqomOaTikgdv77krWwGmbup05Wo?=
 =?us-ascii?Q?oYKKRl3LcwWlZLd5TaVlWBt8LsimoLItwe54y1iqmm0jGiKHFmfyueFAwoxb?=
 =?us-ascii?Q?T2aJRR+GzLiUPXqztH9UOQmiAelEnfn5kF6q3I3JflbQc8DiPAHLn8INtrHj?=
 =?us-ascii?Q?xOyYHSFpfTymYJf2K9h3VVu970WpCFTGQCRIygmftsK96knCyZ/9hbaFZH4N?=
 =?us-ascii?Q?/a0/s7ZUvws/Xc0Az5/CDVL0zVjHRNUBD4bedtuSVJ1VXCys8q4y8UUsoJ9W?=
 =?us-ascii?Q?I5zOE5syfONfXOmtXCBP+oGHwlvX5nLodo4zrWOJZiM0ugxBkvNAV8BAvQlZ?=
 =?us-ascii?Q?P2btDAtQP8XN9poiErLfSXpazjt2sTmxE6Lnqintf6nz0L7Ha5dztv3lk1fi?=
 =?us-ascii?Q?QpIAAXv+GYKCep9Q+lf6ubBaLe51s/500e3XLVhlk1Nlv/tJaRiSzWWgvIlm?=
 =?us-ascii?Q?EVYM5QuhdzPqvOqQXWQHKEHPv0ilDIjBkdFOKgJX3+cbdeMlJcj+Tg30a4cP?=
 =?us-ascii?Q?+ZH+tRrY8kwN7KJWBKPYLBEGQ2fLiMPisnsNLb365/YleZP2Uk9xRPR0xKWa?=
 =?us-ascii?Q?pzb/wsL95IJRsMSXNCeKsyeRBxXH+6oystvQmIIRhlrAhxp53dkQY024uNEy?=
 =?us-ascii?Q?al4gWpB1Vq7mvyZNuOQEHLsu9SGpVGHhqq7jl6FWYpGu05H4k+iY6QGrtR09?=
 =?us-ascii?Q?JC+YhxXtmf//2nBAmhs0iESG204BWGR9zCEgcmUZPCjDpt9j4AcZQXDSWUeg?=
 =?us-ascii?Q?VJH577upu0PjGA42m5x9UXJNicBBe7m2MTfz42B6IfGpYuAG0/wAgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JwkimTwzeyvqpWfrP4sU+s6uisDx7IH5WpYbwTMDEROyUkOS1xfnE2HRTcJ4?=
 =?us-ascii?Q?fO72Bnf2oiKGyQJplm2MLKsp1mmf1+ju+P/tNlnB+SBS3RGsxaqu2HbI0l3J?=
 =?us-ascii?Q?KLz87TVVYBZNeVZMoksra7Hqs2YOjPwSUwGHpoa+RhrIxrr83iv2KWMTnugI?=
 =?us-ascii?Q?KcmI074A9lTtPvJb92Pb8syhMY9LKgOQHpyqgEASNswuz8FvYYisu56gjp9V?=
 =?us-ascii?Q?BsJHcjZ0nZ+VAMzIvnCmwR+B7sT0SScD2YK0IrnbKPW+oJjZV+uxdJnUtush?=
 =?us-ascii?Q?hNMkqt65WDEC8HfG0/aBdQscz1eXI9g2I4Nhsh847cnXl1wrE4GXa9i8j8Pw?=
 =?us-ascii?Q?J11hnQfZhJQSmC8cknFeWR5YRT0TnyATdZsxMip63490WqpV1s3HrGQLvCi0?=
 =?us-ascii?Q?DMEiYb+o0CZWxbVxt9P5BDqM3ePWCZMNkp0VabwKWOnmBi8LH2gl0GL76b6g?=
 =?us-ascii?Q?FoDUxi+o0hb3/mmWkfsEbsd1kdPL0QMH7tdtlColBlgrcXaU3fWQd4WeiNbn?=
 =?us-ascii?Q?ITVdczpZHk2YOgoTJ15z0Tb15nwoHuj7cgFJ8tTACS2mO9e7pFZNml8HTKed?=
 =?us-ascii?Q?oz1/xle06E3EWwTFEtaCjtqR47wNsMYR/MQ6FzHZNb+8+iYPIEBZAOzin7zw?=
 =?us-ascii?Q?gCSdNAS1QenSA/49TStsKI6/DqwdT2S14t+wEdu91Vu4CUMBZ6BIxNX+iDpr?=
 =?us-ascii?Q?PUzgTCPL2ioWqRYiyFXO1gXCQqUvUAJ3J+iRxfyx7boml5EVpVkZQjw4QaGX?=
 =?us-ascii?Q?w5v/b69chj7n/pDeDZkRldzbpSwGcHpsrFQuiEiiWPwDZNWzz4MZ2qmsQ5u3?=
 =?us-ascii?Q?zTxgQ6zUDJBvKpeO8Oy6o5bWWSV0wmMqP+T1d5dwFFcvFJWKyTc4VS3NlEm3?=
 =?us-ascii?Q?V3hHaimFxw5hTTvV0HmxttnHy3Xq4zfgUTgqqapJNeVQuVT3ZturBlCEctzO?=
 =?us-ascii?Q?2Zk9mZq7NlrzpHXRAdOdpj8VgGHCgaEq7Om5pPZYT3yGkHNWdwwkWKVtuYAL?=
 =?us-ascii?Q?kIOvjQ4QDRrbGlUddTJHAz1GmNHgm/c6ZfjKR6402wAsAEt086qbZr3r0Vc3?=
 =?us-ascii?Q?ASZvvKXeOLzPo5kgdnXHHYoQHsQ9G5W5qMQC/rOUIieAXZzjb+TxhGXzRH7L?=
 =?us-ascii?Q?ibeuAlBpNrtE4S4OBdcZHyiwiu1dEysuPMmd2nMIduV+TIr0GgpXKy8bnSYk?=
 =?us-ascii?Q?W90z1MEA2eaJzAZBm3agS/z8JHUwcxhqd2DpBl8Br2N5BD5GaAquwzyWeFRd?=
 =?us-ascii?Q?J2x7mu88R5rxJsEFRrCF1rmAGBWjtWwhTfDDhr1Ng3tgzi3tn0bkkQRu09jx?=
 =?us-ascii?Q?VMcUL9PKnFwskGE8dmNobW/obKDw+pD8e929Wa7/NFvRv9wtdoQFDYuo4jFb?=
 =?us-ascii?Q?JyuHVHSDl3AmKNBB2Ouia90AoUuFjBL2PT+cpqZmYA4uZ943vUc+KEd9J5Yy?=
 =?us-ascii?Q?i9IAFnmLUH6TLVntfx6FtIYtc/na/EwyYn1e68T4Cq7Emsuy05m+vIBMMpw+?=
 =?us-ascii?Q?xiLLSnNKK4c2enYs2K2HRnU/VxAFHEXDEFsQBfrODQyv9zXbDTjFuEaPiLkV?=
 =?us-ascii?Q?TbgZyvrK0dhC6dWlykk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5af416-7f88-4d24-4755-08ddf794c877
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:54:14.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4ODGyOG5S10H9HjQgSjldMCjwQyRnwiebWOKrEl3n/7rg8WOGdtQnb4jRSEqTdBxbl0HcgWr9apRwxI2I75gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872

On Fri, Sep 19, 2025 at 03:02:57PM +0800, Xu Yang wrote:
> Except default 24MHz clock, alternate 100MHz reference clock can be used
> as USB PHY reference clock too. Add "alt" clock and clock name.

Beside default 24MHz clock input, there is an optional additional 100Mhz
clock input 'alt' for USB PHY reference clock.

Frank

"Need emphase two clk inputs for this IP".
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> index 22dd91591a09428214afaa4c9c8e37aae9bd8aba..268f86b04ce88cb81d2c06ee507fe0483d713f8f 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> @@ -27,11 +27,16 @@ properties:
>      const: 0
>
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: PHY configuration clock
> +      - description: Alternate PHY reference clock
>
>    clock-names:
> +    minItems: 1
>      items:
>        - const: phy
> +      - const: alt
>
>    power-domains:
>      maxItems: 1
>
> --
> 2.34.1
>

