Return-Path: <linux-kernel+bounces-774004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDBEB2AD7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87F45806E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B71322A35;
	Mon, 18 Aug 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eC6SCvp8"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092327B336;
	Mon, 18 Aug 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532485; cv=fail; b=gdFZX1YEajSKeilZt0IiIOJ9hNXkIB9CYf+epSmEvZ2v4BOMhkZEFpF/lGQHgxKgUNLNCjsVqC90yGnWRQ91yBeas5xnF0mNhhLLHLi1rIvLaOpcW6UzBoDl6S2Plpk7ev/pPys36vr0R5ml/OkrRrlExerxmAA59V0/cnv68gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532485; c=relaxed/simple;
	bh=KpAvjqE7VZH1wka2C/G98chY1wLjiKIpEMXktu90mdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RSnoCHOXZFr4YVoi5ZhAlEfR8si0NQWyqmxrKi+8auhUVjgRYbKQ2xzgOlseninEW62TI0VCt+4cyPEUS7PIf3updYZJ6N8SbaMernzzAeSnSH4qVO/LhSw73wDk4vaJvIiP1Q4wJOB+rS+0Uxgu/aQaA5GguF518AfY1R53PWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eC6SCvp8; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujZoShgZPpPWbV3Qw7leQMmhiUipYI73Qv9iuhrSsAiXxY5ZmtXW+t/9vlftT84gYVjXVtcUd3csLTdDE3NWG6NEmIiYGLfvnQaHzyVP7vjHKehGCtHpt46cWvQ+w8C2vEaI0iZHGhBLALLwrvCGXlDgBGTr6tDX+hmoS4YYNY98/aqbhztdZT/2a4DMNPl3anByKmOLmcTNkoh9xMVBlrV8WJ5ZiXt3xwBzua1kJVXtvELgkvbCZn3stgHlXAHX91N4Fr99Z9c/azHHOjeYbfqpJGnC+N8M0CAohBV+LXflnuRpBwnr0j07zUiSOY1YskWvXajpjFSGkUfPx79yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3NkvZbJ0pvrJruEEacC2CiERr19HSlQwwx9qhEG1H4=;
 b=UVOh9C9NtkmsvezWMonpr+mPrwwSImdBMApOld5Xbj8GA6IplW6C1LBd7SjB4g9IsfER2k6h0H/PlDC0aqhdYp5YxIPWLeVDuBxI7MaXeYOmFKUgFKmkQgnA7LownF4ANyvQLD1uTNjvijyWybBTHn8/QFKN45dHzXNHwxN87hCiaY0ITwCoU8dwEOYhR3RDRwt8o/z5KiDp0mg7OYrG+ciOsJnUo2ASyOCAogublWXC7xxgLqeFwx661kuF+I9VhxIESYoc2hdbqbA1YXY7f70UosH/npVl199KBiOV3shtB/eILlWnQsDnvXhuAFH5r5xLQQGoqYD4D5oblj92YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3NkvZbJ0pvrJruEEacC2CiERr19HSlQwwx9qhEG1H4=;
 b=eC6SCvp8t/Xjv3KAn9aKFcSiVR2TuOMWTNnkgZ0D6ZyqbNvqV9IOoCMV3gzcXNS0dtKUxNpdSIas2JDHEk4+O0p8E9nAMM+5Z6+jPnqp1a8Jt8uBAWN4PJXnmYTeeB9bCUJyBlPtIXQrjqZDey5pcAbNg3M6VGBtEunQG8H/Adj1gus0Ml0bcFvbz0qQUBjDTrADMj6+vQVzahd7ZZjC8ipRxjDN+ZHfMzsv0CuHBzsMtQvwmlV3BFXQ2VJ8l1HJVhaLOjaNfF0YR2mHaIU/U55XMKJLl1Usfnohyca+pzQHaK9ks4BQoWftZ0MdPgggvdu6/f5RiXTY+m3HWCWEgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7787.eurprd04.prod.outlook.com (2603:10a6:10:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 15:54:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 15:54:41 +0000
Date: Mon, 18 Aug 2025 11:54:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v2 01/11] arm64: dts: imx95: Correct the lpuart7 and
 lpuart8 srcid
Message-ID: <aKNMuV1K9S1fr86+@lizhi-Precision-Tower-5810>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
 <20250818-imx9-dts-v2-1-8ba787fb5280@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-imx9-dts-v2-1-8ba787fb5280@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0207.namprd05.prod.outlook.com
 (2603:10b6:a03:330::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 85182310-6d07-4ff9-095c-08ddde6f8af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KK30uEeUvWZdjymx6yELVz/z7cXO0HMh7TNxXWNXK5Qwmx4nCT7mHCI/1vrA?=
 =?us-ascii?Q?eYRqX3+sDFdaJ+hT6bnGPxbSWYWEgCzP7A6A2nOJaBRwO33HNTH3omNvwCET?=
 =?us-ascii?Q?iqu4cTSEVWqgtJJWjngYDwKqBDyyUaL4Ly6aWh5RcPM8DK/7HaQWsMPZ9aQY?=
 =?us-ascii?Q?MLeF7rxo4Yj3cUTszQBl+YjXergRiOvgQgsl3HMmYst2x8yMV+34zZBhKOXr?=
 =?us-ascii?Q?RH8Y7vctn22Xt86GfAGMRe5UFXusD0jAmfvwniVDafREkR2wQzGa3cE5hTjL?=
 =?us-ascii?Q?mv5JdpkGvgZXOVATDVzfQEny2hiJieXWmY0OBYE5ZYEvGox2OmM4NWibHJKB?=
 =?us-ascii?Q?CVUMB1qPE/kagWUVOUyaaUuFQDrQAmLKiHic9GgdOK5zGKqjaPWSekmpvlK4?=
 =?us-ascii?Q?F1c96DpqC5mzrUVN3UXGgWIj5w6KQa3fx/ZUrgGlmmbTQ5AP9VADB5CijWRH?=
 =?us-ascii?Q?zfUIWyJbZPHXz5O7DL48z0nVlRMYSAg64D4YH5Cb5ezc1ytYIQJoDfPcKt2k?=
 =?us-ascii?Q?7tQyWsfDf64Vc03NrVcn4JBuzmcTYcBowqbieAwZtMje70cF0uhj7u2GrRaa?=
 =?us-ascii?Q?k+lJHk0YYkyfxdBA9u+8jvW7GlaH8W5PdzvgPNYAlkh1/Z8uCah94WbNfDOq?=
 =?us-ascii?Q?kukrv0Ag8VVVhm7ZHuLdeAvNtj7Pq8c3ADeJRFgP1fxL0mNlqASMS90L8VWR?=
 =?us-ascii?Q?xxWfNO7FM6e1D4oZBbnwZGcSDBHF31VDXEJBBXsfytMjYeN1LnHsi+Bn0hHu?=
 =?us-ascii?Q?O+tJhQMjweDuGd7If1ZI4iqX6nl2IaMZn/4/vrWI9LFDzR/HzBPl/Ph34JpE?=
 =?us-ascii?Q?VhsepvErXY8X/K6B6BKGVfzcibbnyaGWHxAbxZHve2rddLjoBh75JwbDv+4b?=
 =?us-ascii?Q?bNGMjnuilIHRjzptsXjDSVw4kniAVVTE3/ROz7o7t5rzLdgm5WUC1Jk3cg4c?=
 =?us-ascii?Q?F6o3fejbsx1c6gx9HgDqte0N2CrBDtBhWvIlrvn+cOPPSXPT2/aTVAFNRRza?=
 =?us-ascii?Q?L9mCq/D59rmfdct9D0/DhBGkeZDA2XAw7nx8yBYyAQ5Rj9qSwPKF/Ui2J+2W?=
 =?us-ascii?Q?KdzWMAtT/1BvqKc+U0VExd0yPDrTLq0bDg5RraGQKQpWoeBMV4xNTt8TcGhY?=
 =?us-ascii?Q?W50qGh3NIL14gzdGfr2DtkIIdaYazCmMb60M7vnsBd1/9nOXOs0tZ/hPzLci?=
 =?us-ascii?Q?wlYARLpAjkgSCmq7VO729FG2NW0mfD/+Mlih/ZIlvPvKo7I5rYuljHaI01jc?=
 =?us-ascii?Q?8r3IpqLUcL5tm6AIOQRXM0se6qSoaienKZVGvkGteDiwQFvo+bFhudzuT4OI?=
 =?us-ascii?Q?x38Dh/qz50udjZgYpOhR/w8/rOk4sJZ35xYzB6IKTg2VxOCpXf70qGldJFHh?=
 =?us-ascii?Q?b93HNJeIF117hwNjgyUQoHUXv0QE9ARKRE5Lyv2bjgcEcAHcE48PftRo1VE1?=
 =?us-ascii?Q?jih7Qa0GWeOR9WoUPIdJOJn7heG/vjVRj5t+DLPU5KzvUxN+aZiwMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIf4l+wg04AA8OJfDI0hVkWStitUV8TBOdMVUfXwEkJddB30zSKkqSRqKD42?=
 =?us-ascii?Q?z8kWMgdOhxGzbZ7UYoIsCkp8I7WfXD31P/NBFs9E0F5RbSM8jGBlnp2xU1Yg?=
 =?us-ascii?Q?ruCd+Vp+bTJbeawPTOX47xSLA//dYmUftm3JUVrpkEf9AXyFcHyDGthzvJsQ?=
 =?us-ascii?Q?+c8O/n1YjQqBXKCVjwdhSL4LyUA04NlvcnlgpM8GYjPldQGCR3DgC+71jVCq?=
 =?us-ascii?Q?d/pYIpjNn8s7hwWd8HidUtxQWqFcTT8RB1A+6bOUrv9IqzjFKS3lBaKiRrBB?=
 =?us-ascii?Q?WNFbh7Cr8Q7FK3VE1cw6jQOlaUGqrkB8UcUvLI/rDVdMNxVa1SSV9TrRx0bR?=
 =?us-ascii?Q?2X5A5ixH2O4VpaS82eyWoKb5PzaIPVzNGdiKj4K0M6Qf/HJIbeXQd6gbOdAY?=
 =?us-ascii?Q?bg1MrwORph4ku+UDvrHvhq1uluARInXciOP9E5YA7KNPxDkzfXe/ihZ8HOTx?=
 =?us-ascii?Q?lUIsTnJKr+cjkoS02i1GO8tpdqO8PzJqkAixLXMC1e9x21zUreQhjG7XkMop?=
 =?us-ascii?Q?9oXZxsZ3W1PrDzn9L/UB0bOoPpgJp3eHrwf1A9bItAYH3NrzJjnnYPqOV/RC?=
 =?us-ascii?Q?s5maaDwDY2B56ThOxK0gT4iOfBA8BXBK2mix4OXmjymqFWOAhizDq7qfhsL6?=
 =?us-ascii?Q?/91BLin9vPT+cEd5Ax+ZspLeHRMDrnkCVsglBUKouezEYKi/++/YMMPUaYvx?=
 =?us-ascii?Q?QIYlV/AWmzPj28C2HetZEFo+eQnveCxAVziIvH83ekIwPomeKFLTbRdWbtLf?=
 =?us-ascii?Q?ST5BaL1E+eulYFGvHiHZiwCcUahRxclRfMMNeco5T3rYTqj0N/gaV5JSufLy?=
 =?us-ascii?Q?aZXxRVJqsiMC7eaBrlzG/3hfsre+sPWXinzCifvnDzrH6tGTZZxm0O63Iqqn?=
 =?us-ascii?Q?MGRRw68coZDAja+4/3IySY9LhSwrJi6kl9sDGSObeTmCEpDGteqPBJiRTzCi?=
 =?us-ascii?Q?JNmhRDPDKw/e2Bd5z9ThSVF8RPVFOmskrMXLrzDti9m7zKXlwYuaNdl1jcnZ?=
 =?us-ascii?Q?lt0gGWexmQuuNvMuplWB0HOzPim6r6eUXgPrwzktvPvKb5b3KnD8IZsRXCV8?=
 =?us-ascii?Q?mLLL2ITIgso+T5UpzG8tfPmzhLdQgwOCRZasnjBG+w3IT45mYRRi7DqMLkSe?=
 =?us-ascii?Q?ENQcLtnjrWf4aCszisi45eAWAGcFcaiECWCqd0ti/9MktYFeLj4evq3fjgoZ?=
 =?us-ascii?Q?jbZQhnrX9lYEXbrgQu2BoHzRjgZnjc0HkqvObfGW+cG11s9pQOy049mKABYX?=
 =?us-ascii?Q?/8AavYY24++hSMAxeiIZgZizZwRzc/UtConZLMjMCjmqbY6XnJuF8cwgdvFR?=
 =?us-ascii?Q?Hmac/JdCNhffI2g30E5PTyQQWlZGbAn2Q2eLSYBdLz2KanihQv0EauvULbb/?=
 =?us-ascii?Q?DRyzC3B6vX2uNGtKUzaP0YDe1V2a7dQnW+1mE0FhCymoq6jBbNAKKORDoKeR?=
 =?us-ascii?Q?KD5crdtUI68YyxsmHORcvS08k0ykaw2P/dJrokDvIt2/7JY3vK4oyIJed0uV?=
 =?us-ascii?Q?ET7kQLZhaALWqk3IsnT0cec0yYho001l9hzNuZd67HtY4sNFzkP4TTrnkaiL?=
 =?us-ascii?Q?4TWzGCcipHbw+MGOpix+9dkebHckaMAkHgSGpXmj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85182310-6d07-4ff9-095c-08ddde6f8af9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:54:41.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4Ix2gkikUgdGJuKgczaEj5hM8PWG+SO83LdnAGbp5H2XxIQMZUy8qoglNtDUR2r528rdYZ9QyWyyUaIW+ltIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7787

On Mon, Aug 18, 2025 at 09:25:31AM +0800, Peng Fan wrote:
> From: Joy Zou <joy.zou@nxp.com>
>
> According to the imx95 RM, the lpuart7 rx and tx DMA's srcid are 88 and 87,
> and the lpuart8 rx and tx DMA's srcid are 90 and 89. So correct them.
>
> Fixes: 915fd2e127e8 ("arm64: dts: imx95: add edma[1..3] nodes")
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx95.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 4ca6a7ea586eaa5fbbaa56be8b821f7c929b7dc4..dbcc557d07f5b8a0ef27d68b7211b07d26fdb9bc 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -913,7 +913,7 @@ lpuart7: serial@42690000 {
>  				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&scmi_clk IMX95_CLK_LPUART7>;
>  				clock-names = "ipg";
> -				dmas = <&edma2 26 0 FSL_EDMA_RX>, <&edma2 25 0 0>;
> +				dmas = <&edma2 88 0 FSL_EDMA_RX>, <&edma2 87 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -925,7 +925,7 @@ lpuart8: serial@426a0000 {
>  				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&scmi_clk IMX95_CLK_LPUART8>;
>  				clock-names = "ipg";
> -				dmas = <&edma2 28 0 FSL_EDMA_RX>, <&edma2 27 0 0>;
> +				dmas = <&edma2 90 0 FSL_EDMA_RX>, <&edma2 89 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
>
> --
> 2.37.1
>

