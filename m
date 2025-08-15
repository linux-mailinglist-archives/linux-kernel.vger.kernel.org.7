Return-Path: <linux-kernel+bounces-771198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25057B2840C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D73916A74B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279F130EF8A;
	Fri, 15 Aug 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oTGR1hOm"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011020.outbound.protection.outlook.com [40.107.130.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507493101A2;
	Fri, 15 Aug 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276010; cv=fail; b=RAFrjzZaTZN8vYqRtj2YxxYFtFIdho9+sGzlW4uhP+eB82O2CuZzUcIqnNo/1EXacCmH11jrEmr1ZarmxnGgpp8tporO4UI8Ua5CbHHhLzwVa+yb7nHVqjA5sGgwdW6YK5i3Vzis/WoFYnySP6Rh7Rc8srUWXQv0zwyhPehPmgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276010; c=relaxed/simple;
	bh=rWFITO1KBaa9X9ybvwb2YYHnVS871YcwecAPb1MvHXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CRuTPpff5RWUsA46VJbeYxHiegnI2m1S2QAJ7SEYlfyXgh2Z+BA0n6ypX+nKevoZZxhGTGtVjmB6D/6b4dw7iu3Ns2kMSCqxad+NaLv+Xp/qfiv0DzreKYiiQmYBzgxgAu8hE7km2Tx2sm2PlZhtbo6JgRmJ07BstKj2IbmOCbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oTGR1hOm; arc=fail smtp.client-ip=40.107.130.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csSXM768nKFMtNhutW7hn/k8uqejcrkFZXEzXvtikrOimN3hheQ22HBqMlZffcBlNyAkSARNCL/TDA9Yqb5SFznea/r6MIrR0YR3zXnqpayDCTNItH0hi3Ou7pPeT5jwPjQe4730plYpqctWJDUGIKXZi+8RD5MaJxw00vbNFVNbuHnfZV679KxFCBQBBMiSiqz5sugnxKuxcQUvGEyFtcuEDjNq7pxjaG8oWo/TYJSCDnDHU4LFjDw8utiEDHXDNzIrtMn5QwpqlCpluE1a3Ps1drVr2ClaB7eu+/JkHQZOL3kJfdgezQVY5GdYl5IlKG7vnVLWz1ghc29ks3Bazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI+p5rgjK1NXd7x/s8ongXD9rT0CoT9cNYve08cVkuY=;
 b=O+OSpCl54M0XNoJJSg8blivUIdltRrnteguXnhFSyEqPpx4u2N3uheSZTerSNtbJkCDROmDQVrjEBGs3UaBXtC6KGSS45EWnH/AUEfQfGASnJ7Z3K3zezE9KnNskqCsu7yTMwVWXI+OQ94MPgfYjEw38BcTZgGcpmaVWIgE6fLgzIxwQkw6Bd2hgdqRrtjXHcH2WYW/JdyuWBJGRtEeP5akxccOv1B6HJnig6acMDfMsCY/oayvOuXxgc5pqA1gF6IvDw7919CrxDe8bANmnNU5K8fy6WKek16EPI6qHrk98Wn2shrmNocTSQaHr1n1JTBhslxDcK3HC9fJkABfhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI+p5rgjK1NXd7x/s8ongXD9rT0CoT9cNYve08cVkuY=;
 b=oTGR1hOmycmWuw+VWo2h2waD9GD8mJHeLoWhqdQXsyKR5Ml3HmFH0yQNpf0zMh0t24pSUy5kX4PElIaZh9yNnjLYpl6XbqLUBRrPGu1aVYofeNAbBwXKuxX0C1EgQ8icmwbRZY618VwUfZeksqfFwt9cbaV3ginFKaRV2cbmzCXWqOvkvPWrVTIZt2riE7C5JrABAxdjZijd0c7nAWz7VIJE6k1+63qM/ji/RmpTXzsoRO4z17H+2bueYv9DaYGAz5+Ay0h077bI1bgI/tBGEMqRTDQw+f+ItccTqVjEt5LqHkn2P0D3hiwQKYTAgf8VeLTdvijT4or5dZMJKYUJfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10655.eurprd04.prod.outlook.com (2603:10a6:150:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 16:40:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:40:05 +0000
Date: Fri, 15 Aug 2025 12:39:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH 09/13] arm64: dts: imx95-19x19-evk: Add Tsettle delay in
 m2 regulator
Message-ID: <aJ9i3eKARrVZwI0v@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-9-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-9-e609eb4e3105@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10655:EE_
X-MS-Office365-Filtering-Correlation-Id: d09d2c64-ba88-433c-1ced-08dddc1a636f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pu0RgntC8ausgNm6j6ID/t1PmZch3vSn79ECay9nQ96rPbIqng+NOYkqhZsa?=
 =?us-ascii?Q?cp0ggRFI6OM0sBLKFDdLAHl/JjnEnsfH5XLnnBegvZoU7hJNaASfNyHRpzvn?=
 =?us-ascii?Q?CWg1RKe6cc34Yuna4HsZ2MVOvuJin7TVG5uANnvx71Yvh1jvwdEmjuOqm92O?=
 =?us-ascii?Q?Hw1vGDEqR3laBF/pX5+ewaVqjmPGbt7DWyQOZJ4jNcBdRBhSDpP8UCumTCMY?=
 =?us-ascii?Q?bJv7a9HFFFheCoGkEKMWP1vPa+G1reWJk/qSWgtBpbpuZTiBU1R/8K2YNccF?=
 =?us-ascii?Q?dqXLs16oLubOc4SEUukhRS1tgG9o0quTvVbt3HCr/Lst6BPrgaEWBRV/c3K0?=
 =?us-ascii?Q?AHX+BiVK0oVJoRjsRHl/z37Gv7JnrwGITCup8UB+LMCK1b0CjDNlKyi5Ghvn?=
 =?us-ascii?Q?75QRMjSN/Gs48fl86tUBZmNjO/pyCog4vyLdv3aHm7/dSruUPdtZaPDJzb1x?=
 =?us-ascii?Q?ROL2+49+/TYqf5SOH6f6teQl/9oKm+r6oD6LXlhGSXRsna6BZ40Xh1qDejOg?=
 =?us-ascii?Q?O5yQ2MIvZi6a/XHh6OMUEzJJrPeqk4w7yZeTOyj+X2bW24z14hjd+m9BjVaW?=
 =?us-ascii?Q?jnNtODzMb9zrcMJHVDAMu1JXoo39V06bPsMmYTZ4zNFrO2ktM8/7uU5Pq+lT?=
 =?us-ascii?Q?LmN1hxKfR+5TumIwnhS+gqtC0sV0CBkdj2v7JcRLZNOqPb1yB9sj3JkoAd9E?=
 =?us-ascii?Q?PniN+d6yRl9AplJqTFNskA2bnN1TqFlpuw9qGWTFYaZOiB1bRIMNzGRTQ+Ci?=
 =?us-ascii?Q?SC+yovwJ3voZSoCIOziqCFhGtHHh+6T0KTiRGjXnDNg5yRRFSISaboGDJZ+p?=
 =?us-ascii?Q?dayfSi72teqMaomqs1USlNSEBB71T5YCPR1QKokPWKk8cN4BZgqpUXEbjgwa?=
 =?us-ascii?Q?1vNk3LXiXdntRiQNycXAmsUFxW5BSdZKPOsqHGE6zJWSq1UY+o7anHzWMyu6?=
 =?us-ascii?Q?Kus7hdSQVhlICgk7CgKtP4lw/T/QNKdJXNvRprPOt/RSazm1nJvog8nU5/Oe?=
 =?us-ascii?Q?/qRGySbGjPa+8Ly3XxQyOPWjbMEVe/GxtP0//tcOuNV/cuSwhy76MGHmMlcL?=
 =?us-ascii?Q?pJ2/4CVTGn/ZdgKnZnPsYXMopX9auIKSwp4ijCcNMYP1YUDHg23XG+Ct7UkW?=
 =?us-ascii?Q?P2UBx7VBooUHWAhMj/vSVwa2Ptk+91Mq0i8Y1vxYuZqIAoDcS1yWdC6egMJr?=
 =?us-ascii?Q?uSblZDjNojL0PepEOnqG1MjoPRZt2R63xpZcw96cLjGknt5cCKeyirmBWrQd?=
 =?us-ascii?Q?UYNbTVBzHhloeYJXDRb3ZASYGrHZGNOxUiXMhlYxRwqQ900PgHEGnjBQ/9NV?=
 =?us-ascii?Q?xkhmaRYxL3u/2Igk3KZV5iEIMFsrkovIPNmyYFdYvKrAdIkktgqBa+DpyAB5?=
 =?us-ascii?Q?kGYmiyxb37EgbDGI4BGSXVIjUzqH38S5BoDZ7kynoAI8CjmvqwaxWv+6WDkG?=
 =?us-ascii?Q?tBtXJV09vqRvYu0LJWNwNbmx7GpajXpGZFC1AKRT6tAV3/rynqiV7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IDUQLmTNuc6PldsQvHleGn85tTcZJyIeffwV65Rh0dq3vVKxjjd6p1qXe1tK?=
 =?us-ascii?Q?o75QXVTS38yJwYDamflKkN+0qPl2IyOhMwxYqGLzJG5p7QTE9Cj3ci1FLXK3?=
 =?us-ascii?Q?OinfBIMvHBvHE2S5pJpfm4QoN1/pF3C8YjrHNQpkdxP0FJ2TrfUwQDhiQUx8?=
 =?us-ascii?Q?6NNqKBBW2pLnPMYHS1rCWTFlmsXHOXeU77qrPyo7NWS161j1tZAclrnIDUB0?=
 =?us-ascii?Q?DtB/pNkN4XuX12hJ2HA7JTAphZ7EwwpkX1UPLbW2FiIy3qVeFNBUcCb+UWPz?=
 =?us-ascii?Q?W1HBobYtnGeo4tqod3oHvz2z/C96hzWYqUsMF7drxwoYqUApHWWtoTHTdBc5?=
 =?us-ascii?Q?sB/luvT7bTX77pv9j0sgy1bSBftlTEZzS4VRlJYADStkMzAC/NzUxb6WcblX?=
 =?us-ascii?Q?auOm1A8rXVJvk/wy/9i3ajrLtuYTpi2PP2qauzDT+QxiM55PV4AdZjdAXJOf?=
 =?us-ascii?Q?TgCQoQVMq7P1eiEuvm04G145Yc5AdBTcMm8d5ugAS31bQnkVmXhuWyEoXgFR?=
 =?us-ascii?Q?wGEoReK4r1vBz2r07cUJVmMG+LtwUBRmL/x35Rb3B9AP9F9A8CLki2uzzc0F?=
 =?us-ascii?Q?PWX8P2h3BnXyrkz0Z7Zouv7Vn1z33o3/sjbjEpGVQfVSjizd2PWWF4aELILx?=
 =?us-ascii?Q?gzatpx588d3QSzEjy43/aRmmDpKuF3zjhGLecg6tIgXDurqCMSUzYYucAcsR?=
 =?us-ascii?Q?uU4FnVrU+gUL8bOri5zY1Jj/msdaA1IQBCYmO0Vzguej8MUl7qLUCzZp1qzr?=
 =?us-ascii?Q?50mCR9iOzJiHpDPVTFcYFIICfIF7cVVP7sHK7twH5iHTqvMQ3pTu74C4nq9M?=
 =?us-ascii?Q?uL8qD4YBt7ccIfQT7XFgaDPgbXYUcM2r5iFJT1thJ00Z1b1PwvxxOpwYd6m2?=
 =?us-ascii?Q?2j36KxmA1mNEz71TlweWI0lsFSjFiOFWBFCf22YCfjWkgOGzGuInsbrMRQfv?=
 =?us-ascii?Q?fqKorB/0vs7Om1l6M+DMPYB5/51qz3Vp3E/05DWdUo8YrvOFRIPJIdX5Pe0l?=
 =?us-ascii?Q?XDM23qHDOPd8C0s79fWtnGW1X7M1jyv2s5NGoOhD4wBjuttU+kyZKI/wqmel?=
 =?us-ascii?Q?q/auFSQd4ixpLWtnrrFkkFO6gOmXwydpX1gxs4jaBMea4bR+5DhaKyzMGpzn?=
 =?us-ascii?Q?tNSQJXAqtnc2BaOY635lWb/wZartVSlXUvyoK7lflLRIt24/fELQeZtuwxJv?=
 =?us-ascii?Q?9oDiGsIHkd1mvKfxqfC4z4k+pKq6okqFZJhXeQk7vX1VPazgoxoAh+8tns92?=
 =?us-ascii?Q?8kpzbxl4vSVzO8PzZx59MHnPF3QXBacRRU8WxA8LlJsyIr4FbsRzE2/VazyM?=
 =?us-ascii?Q?oJ2ebHeMM1myYVJdSibgrFTx2elQFodJVHVB69t5nMXxkC5EtJbsLURRkOYn?=
 =?us-ascii?Q?DkZvVWZBQDS5bURnP9kTIOB335MQ2NukdUy1HwwSzOoJt69bPQ6mChADzV7O?=
 =?us-ascii?Q?ppYxdI5d9Jw+AoDkhsnrgQ2hBAvCTwgqcgKQ4LI1qDOLnw08PvRAUUK3W8vV?=
 =?us-ascii?Q?WTwRgL/VtWh6ax6/YL6kvhdbt2ZJKByOGKhcWXlpxdg8uGXJTDgQ051dDR1f?=
 =?us-ascii?Q?7Hkv0aTQk5NH3fmtEPU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09d2c64-ba88-433c-1ced-08dddc1a636f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:40:05.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSiZerSMl3lzIrvrDD0CwJRkFuWb5pz4iAsA1nmqv4NqlbYNvDiaq2Pihv50DJLUP5MOLtNY4VvajzS4XuYarg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10655

On Fri, Aug 15, 2025 at 05:03:55PM +0800, Peng Fan wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
>
> M.2 device only can be enabled after all Power Rails reach their minimum
> operating voltage (PCI Express M.2 Specification r5.1 3.1.4 Power-up
> Timing). Set a delay equal to the max value of Tsettle in m2 regulator.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index feee6da65d37cae7413b09216014d6fe2b76b032..82e183dc581012a7c5be3d2bf749463d0a8a360d 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -136,6 +136,13 @@ reg_m2_pwr: regulator-m2-pwr {
>  		regulator-max-microvolt = <3300000>;
>  		gpio = <&i2c7_pcal6524 20 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
> +		/*
> +		 * M.2 device only can be enabled(W_DISABLE1#) after all Power
> +		 * Rails reach their minimum operating voltage (PCI Express M.2
> +		 * Specification r5.1 3.1.4 Power-up Timing).
> +		 * Set a delay equal to the max value of Tsettle here.
> +		 */
> +		startup-delay-us = <5000>;
>  	};
>
>  	reg_pcie0: regulator-pcie {
>
> --
> 2.37.1
>

