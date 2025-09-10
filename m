Return-Path: <linux-kernel+bounces-810554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F466B51C48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315C27AAB88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD95327A20;
	Wed, 10 Sep 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GOWFjTVV"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75803321F3B;
	Wed, 10 Sep 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519153; cv=fail; b=o9ly/MCGgkG6SehlSzxZJkYV5QS+n4PowpWczD1jiF1j3+ZBSizDkhnxuc6iDhq7RV3wEK9Paf7kAX3FiENKxraJ3J7ILQLz90HHJHJ1nASBs2urXlgp7LdI1NGHeT9em2bM1ASSwDwqrHOpga3bIBEvB4vPXT/yjq6nSg0s9V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519153; c=relaxed/simple;
	bh=Ae8/mdTzuXqcYkI2TJGCYRW75JmI+FhagqlgXfFMv/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pxBa8ndZYv6V/69FXD19950Ia2IEArQ1xMnxniEumMCX5Fgk6dHJdDfEyqdM6nHfTK7TFkvOMe8nAXf0VHGiJFgiDI4mQtv/fO/NK03onU9IEQmbtnqYGvinKM54r4Te0sai/vOnHkdl9QY8yfLfaVZ9mGl9yh8UF4Vx6z8IR60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GOWFjTVV; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6GCWrg7V6Lryyqlth2e3uc3mkM+1DVo33knL7LzEJ6aKnfTY8aiHrIQ+mJvAMuyX4uVxGMmVA3TqLBOp/BT4K95OfyR+j1fYovUDk5L8axiiQR0H3JD8gjsd8NxPutwoYfXqIzEfyVDJ72MilGu09gB1IoiR1uO4gp4JRUSk6gQWugRiESzjH1k9SeBbiL/IEqrTgY5CsYt4WLwysqT1zMkMc9VXQgVj2AgAxQzh3N54C911mOa2dAV26f1H7QeHTnZB4W9mIP5o6Ia3bXRT085Ou3Uxk8wmFLq5iM7eojIgvAAIjW7mUacy1/vT+hGLo/yJ4kyA8aGuvRqfJ78UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dCBas39GICBZMUwfMRsUconcBnn5Gt+YGB9oKIwWxM=;
 b=KHlnhTHCCnA4XAqA6B7mfCYBh7wSOzzMDIgIelqTAgkY5pcnqfzkHYT/8c3AJHlSfNoC4NISFgJuIlri61WT9zjlm40mJ29rfbIdp2Hn45UrcEcNttMEx7WGMvoS9RTxVmJa8C4J7n/59NvykjxKZeHzWr2o07CCjG8bhLX5hArpR+vBGV5RyOiT+u0DuFe7DEHHlQhMvB/U2PzFCTG/M/igETu4QgSsirbxUdYo0yd3l0ObLD2OPaNaamY/NDnmyX4PDyzxZrXVYBeXf6gpU76y1bfZlyaRW/855pi3UqqeqZFMn2UYTobM4tRPIEToCckQAYJpd8gcLy6l3L4QXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dCBas39GICBZMUwfMRsUconcBnn5Gt+YGB9oKIwWxM=;
 b=GOWFjTVVGGTiwWjViAMXYB758gXfHJnzeu2C0vDSd29kl1rOb7+zuNY4+mOdBSSUlUmjViEBNPi9XaMVlkRvKCieow0l9jRUbr97qHualv3vsuGL7Cvoxp04rScwtgvygXxuKYPTQp8O3+wbz9EVJ78nceLvdbHb11c+X5key4dv7ziSSnSFxSZvb/A+43/cP7+3C91KR7LXVrUfpeXugCeJI7KVBC6AeeIdpowdQMk42de+tC2p5lHa0BZSzJcLnNiE+kB4ydRwrOhkG2KMcS1kBdBbvT1mhCJ4qn3kLwQYD+Dcbw3mAAMf+xwZCmg2p3zeabQ/7sYaTTUe04Q5iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI0PR04MB11503.eurprd04.prod.outlook.com (2603:10a6:800:2c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Wed, 10 Sep
 2025 15:45:45 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 15:45:44 +0000
Date: Wed, 10 Sep 2025 11:45:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andreas Kemnade <akemnade@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alistair Francis <alistair@alistair23.me>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: sy7636a: Add missing gpio pins
 and supply
Message-ID: <aMGdH7Ab+9t/v3CB@lizhi-Precision-Tower-5810>
References: <20250909-sy7636-rsrc-v2-0-cfd9f44fd259@kernel.org>
 <20250909-sy7636-rsrc-v2-1-cfd9f44fd259@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-sy7636-rsrc-v2-1-cfd9f44fd259@kernel.org>
X-ClientProxiedBy: PH8PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:510:23c::8) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI0PR04MB11503:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d78fb6-b981-4438-d3f4-08ddf08119e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rYyHjhNC8QV0nT5hDMqHP2wC21IkiKq7cLVdTY/mDS6sSBxjpQP7xXJzcHNc?=
 =?us-ascii?Q?HeC9qRToG7OSPfQMAvec3fdpZ0PTeVRZXGz5P6VYa4XwVd3iWOsTnHuE9eci?=
 =?us-ascii?Q?0CMp5cVJXr2yCDpxnlBntwS0PWGlrbMpjrJqxcUNEEjUvWw8YgMz6CyLUj62?=
 =?us-ascii?Q?mZqD7xlSq51YvP36MgslKoINcOUKQJqSVo+j+j5h9vLbN7IAgSh1Z9HWQVd/?=
 =?us-ascii?Q?Be81IzwZDKMZKLsqXWtOjwLwLJbKa8oktg12L14BDgPclsjpBzjrwgodJYLO?=
 =?us-ascii?Q?oPseKEB3Ufz2dQ/Vpy8yc0t701xRU6BX5b4ZC70klNeNv2U0lwF9s5gZw4j+?=
 =?us-ascii?Q?Bt24EAr5MGQxUxtrKvrPGzwryuSclldRFqsOBDlg+TEZw/22S4dX5LqcwE1h?=
 =?us-ascii?Q?lfMvJ4u+hqJt90cY/oqJaxQ9Raqgu5pRr18yGM3CCtCsWU2qSwGRwSGPIkMT?=
 =?us-ascii?Q?iczq82eKfWLmMGTw98N02nF42o2+/IyLnpAA78rPTzm6n2UoDqZrDwtjfOlt?=
 =?us-ascii?Q?JWpK/aJxlvb0g0zEDVuHg1LtTdEmD30xbdM4DhXy5BTg6/Ta58DOsKMaE5gZ?=
 =?us-ascii?Q?TjDh1qhKVc5qx7X/e3j+qw/TuBTP/xuUzIlL7Cbv7GuCD5XUXRW49LJxqGsy?=
 =?us-ascii?Q?M6e5bG9dyTYw/DTtUGaGvE3j+JnSrKDuapcJfAT70Q7LRnX4+gMH8+dX+8ym?=
 =?us-ascii?Q?NNbIKHqNos3AvSZb6FjcdLkUDAWuv90cVYKH806ZMyqtAIQqbptikkbbNZYL?=
 =?us-ascii?Q?1a0uR1cUCwrhtMlBIdJg0kkvShsqxuXh0ccJwstUgBf6oI7lHXWGsMlb+8Lf?=
 =?us-ascii?Q?9yDVSu5R9CqJYd0YJzhyyJkYCz4/IT5wQ57lhYrFcXpuwtkqRjryA1u9oA2Y?=
 =?us-ascii?Q?8ewwiheo/+VI99img/JQqywJ9+FZxNbnIlEmLKT7hDZk1j+NylmcpZmoTBR3?=
 =?us-ascii?Q?/mmXdIKtCBN5MPSZrgZnOV9keLAy/L7gpMOuFzuXuq2GY5MNEs9kWwVVz0g8?=
 =?us-ascii?Q?vC9pgWsOZhwo1k0TPwo7HVm4ZTdf4Z0uNGXcoE8txSiwaA5h6SN4W6rFqZmE?=
 =?us-ascii?Q?9iZiae2eCUYLM+tdIWfwbIpyRwuboYjc5xBDIS4g8omBHu/xQOJcyG+FGAiB?=
 =?us-ascii?Q?L4Ffdm5dlhBDONyBphQx7U5LdoZ+ElBYr/8U/mdMMz/VUqWpVLFiom99oAHL?=
 =?us-ascii?Q?BjOu9QsQr7inow6Xbx/hHkHs4B5EwDbo32OPtT9pHmU1lqMqnc2h8anI/eV2?=
 =?us-ascii?Q?wPm5jOU/AyLTuu3aULW6UTpQV8YZJ4tEMElnTmLI7krEJ1AVIt/d60Lid92m?=
 =?us-ascii?Q?qpMQhUEfFlEcuNekIMgDFZkfvsSXu+M68/qoJcWDCVR5AXpHnGlgXV1J4XzO?=
 =?us-ascii?Q?vpl1OvZcuGVOKG8pIaXVOXbfCnDc03S0oxU/wkeWIRrQJFHSU1EZg6J+eIwm?=
 =?us-ascii?Q?Qe4Euxq6F6a3JXvO0rlvhJC71vrCzgoccsAe63BIPB+rTEe8ZVwgbd7SAJk/?=
 =?us-ascii?Q?vQH3s0W4AJYtQ2s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8O2yZVqVsmAY//FrZdf8FlsaWUp1e5b8no1z7hijAEpd7X/Dvl1WwqV8nupW?=
 =?us-ascii?Q?DNLHwJJOE02BOY2YnpnEvGTuE/pvAyvurKwUiphWmok+8q8z1NibnXRJvbEv?=
 =?us-ascii?Q?A0LMSZBuF8nJDySFmuzD7KipJzKEIbyoVlMLyOCQLuEvDOBzyihhbXyrVcsZ?=
 =?us-ascii?Q?78DqBVVln6VYZuOTXyU22dVVUA5FoIHt83BRyxcyCPHmfdSUxOJE6D0hO7+S?=
 =?us-ascii?Q?O8ldxDvlTXSA7MGdn04895yFvHkUCusfjxRZZw0UjknjemHf7a7AkVyxC6MH?=
 =?us-ascii?Q?kefa02K6h7f2incSuNkETflb1XWAMrY4vrkysfP9yhuLZnRFmQs49TCs3O6O?=
 =?us-ascii?Q?Mc5JiKuUZSHA0kn2e9H+tkZPY5rtfAaB5MTOS0CqjAZZoxMSwFvt6meQJqnw?=
 =?us-ascii?Q?hPtpv1QRRLIsg6r3DyO1tTWVzIIOdQhB15u7jkjVnBhglCjVr/wOZG0JwRKz?=
 =?us-ascii?Q?Jlv8jCBm6vzFjh/mJaFKpGW9PU+vDq+MIimw1VbBK/qDa6jG89SHOuzPixGJ?=
 =?us-ascii?Q?lSYGTibNrBmXderSKB1apFKxVRmEiPjoxugtiNyr7LafQcL6z6zvw1GfaZUl?=
 =?us-ascii?Q?zbN5k1ab6oMQZ2SCRZs2d6+sbamn89awrxFheARHrz8QGGv1xUT80NI2shNs?=
 =?us-ascii?Q?2CfCkDWlW2DcpGy/NnnNs1nA9CC+Nh++uqEgjJPAlgXKFj9ielKF2rvE6uJM?=
 =?us-ascii?Q?TlE/rZLzwKtc5JDX1R62Lm/g/gdTAmghO3MBifJ5jmaF8xzXbhSv84+agHMx?=
 =?us-ascii?Q?5TvCejX+ISnTzLVlq+2/4l1GbnoqsGNDPuqCYHeXkz08rN/IwmLHZRIa+5tI?=
 =?us-ascii?Q?GScSAuxKD3VGRAH/Y+waO8kx09i7UAGBxsrCwpSao6i3k8kx7N99GbmnKrZC?=
 =?us-ascii?Q?eJIuQ3y432vBqE9PKCRnCeIvmNm6As70CY4CU55lw6a1x1mFlGl2xb04qQV1?=
 =?us-ascii?Q?rolg8FYVIsqF365aYu/b1g8NcAeewd4o0mFfFLCrhRfspcYTc/Kt2P2Vd7eO?=
 =?us-ascii?Q?BR12DsBpMiqyiiy5eOE6rlBE3tq6Srm/o4MmCiSeFMDx1u7sQz0NAhv1C2Ke?=
 =?us-ascii?Q?6YQu2tHDpDXBoOTxZ/sKTECp8SEngI0lVZoVTInu377fCd2cswbq6fxkBQJB?=
 =?us-ascii?Q?bcH10IEv0SXF5q95Hv0vPujKOVS2i6HZe9Esn3okdZKydDJ7eWRdAGuloi4c?=
 =?us-ascii?Q?FQnvIAttO5/2dLIRswc3pzWsMlUGj5Htt8zh7xoUY4u5YeW9wDe3lYan01AT?=
 =?us-ascii?Q?6Nl+Q2Uuuh348z+u8PBUego7mCE/Xab0Z4j5BJCQZkqc2AGi50T1SAav2O0m?=
 =?us-ascii?Q?EceuDMAe/B11KSZUa7FY1zxJ78Y9jRcyg5PexrNDFr2k4tVBJK20uZbsr9g4?=
 =?us-ascii?Q?DFpIVFDY4vG9ZnnvmgvMpfeORubKlFjRcBHTT8GzsidjWzLdn6XZpR7WRkhr?=
 =?us-ascii?Q?L1GCehvJBK5RCxec3GnTwXSLQq0K3zi9aRVsDBRFcj5e2M/ACnBwr+3zi0nj?=
 =?us-ascii?Q?YZkhFHST7KKJ99MP3NIeILZehX83aRy81snMRB+DO02HT2MUdDXJG3kfATMc?=
 =?us-ascii?Q?eouT4mOE5/vrYkh6MIfEyLmHotPvxDeVYrv1Hjmq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d78fb6-b981-4438-d3f4-08ddf08119e3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:45:43.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xY0FESpAjICxHIHc/hxBeGoP29SfFF/hYKqQpZYM69Jv9Nrj59Wgt/1U1uNZQPag2dHYsRHLYiDFkB+R4tUNcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11503

On Tue, Sep 09, 2025 at 10:33:02PM +0200, Andreas Kemnade wrote:
> To be able to fully describe how the SY7636A is connected to the system,
> add properties for the EN and VCOM_EN pins. To squeeze out every bit
> of unused current, in many devices it is possible to power off the
> complete chip. Add an input regulator to allow that.
>
> Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
> ---
>  .../devicetree/bindings/mfd/silergy,sy7636a.yaml         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> index ee0be32ac0204..054b97dd0c5c7 100644
> --- a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> +++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> @@ -32,6 +32,22 @@ properties:
>        Specifying the power good GPIOs.
>      maxItems: 1
>
> +  enable-gpios:
> +    description:
> +      If EN pin is not hardwired, specify it here to have it set up.

Need descript function of enabel-gpios, you can ref data sheet sy7636a.

"enable-gpios" is good self documented by property name, needn't
description at all.

> +    maxItems: 1
> +
> +  vcom-en-gpios:
> +    description:
> +      If VCOM_EN pin is not hardwired, specify it here to have it set up.
> +    maxItems: 1
> +
> +  vin-supply:
> +    description:
> +      Supply for the chip. Some vendor kernels and devicetrees declare this
> +      as a GPIO named "pwrall" which does not exist in the datasheet,
> +      disabling it makes the chip disappear on the bus.
> +

The same here, descript function. such as power supply for whole chip.

Frank

>    regulators:
>      type: object
>
>
> --
> 2.39.5
>

