Return-Path: <linux-kernel+bounces-771178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16011B283DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115A1B00B33
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33698308F19;
	Fri, 15 Aug 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I82aCP83"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13BA23C8A0;
	Fri, 15 Aug 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275602; cv=fail; b=NFddCASC3Y4E/I74XBCdkRQkHP5YYTYWb6PNC2msd7IHAe9SrRrc+ELxkz1m3zVJk/VeU/2fU6fRaxwB/u3UHO17TwKSKa62D3PE033iV5BCeI9Fu8BXpAoNydO9606T4qo0ZeIkbmh7Svs9xydZVtUo+qm+XzUrBzdFHgKSv44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275602; c=relaxed/simple;
	bh=+k7g2d5pZAONxofAo/FJskQt/q0ISk+gNl8iXVu6v00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z900JYsTRFbAcUYvBqSlV+0B3ctwWMEmyI0RJB2N4LQMRzafiLvUzWCpbKbvIAt6at/n5v9vAWdPjW2I3JTmgUtvKysgDYobAw0/OV0K7crWgnCIOPrLP6jgLQbgstJL0xc1jF7bNoWP8iyJJqsINVAO11H1i34LdMqOgIxUUG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I82aCP83; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AusCRdLF7FTGNE+H4dOKnLsy3ZbDx24U+MDYHolPgYt7OgLhq91l2ORIssUGy/oSaQqjp5tB2hqAuVzNorsFgl9vMmoNE42WlE8+iao7gwIKsFIR+sc3tvG+gI3i0X2abdnhvfSY8cLM/xoEmw4gpymRfIb9UwR2rPdxU/+an2jPrywD4AlZe5405W8omu80MQok93/MqaD9HTUAx0m2n4uSBywIvoQhTJNbFyADUSY4JIThL8uziiCQSRaX7QvfqV46FVm9ZTNoqibyC4FHJQt+oQ+7AmCCkjoMQjTPZ0rHIc/rq0VefrxKfuZ/CBalWcm2OSAWpoe4YOZYa4hGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y5Sm/MqG9muMyvvLUOTBpsxbeVB6Ug/RYwquaht1rk=;
 b=DmG+7FqhSGJgWFMmUF/PD7dQqyh6BxEEy4KxW63C5FVUbsGxRbYu9aFB2gFwAJP6R4qS0K4tLQVreRRtPC/4tMyRyKUNmMhPCf5jzrG0wePYMK9KEhHmi/Df1d294dO+DbN12k7JI5tTW0v4yjqDggtL7oMYmVEqLSKrPddH2SICKrDwJgHvFxIcyaBft1NyEc2WTECqCvOZPscQE0dH+Hk84M6EtgZU7LVMkffHDFiLThjn/A6CWOcqm1EGMXE/9DOOyN5xDfzxT2AxVJRbML0twI0g0Ipadp/G1tiMf+1FXmjdHn18mcNSxi8HG+fHfQQSpXD+PPXhhMNi2GFZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y5Sm/MqG9muMyvvLUOTBpsxbeVB6Ug/RYwquaht1rk=;
 b=I82aCP83QlNSgsPQF3Gx39lEPa0etUYYWSVJUPRxx1kxVIup8G5mU1Ye9v0iv4iM1Jh4vxdLO52h+wUMJEaQ5yJXUKyipbZ0UDL1/dQrrNnTXn/zEA/4sTyK+aS5NDNLARvRKirEULEEoCb0P6FjNgyIkUo6rEzq9L2zJbuvC5jzER3yRYSlIoqXn6qJfL56Uah2DW7OpXfaopvOtLtyxNB3APl+pxQeA58qHtGlhMs+3LJWC6c8L2FL9n2zh4uSFSkRBNPJqz91vE7frPEFT/D84sbZ0Kinw3KWKijhbmOSBD1seT8qnyN3r2giojF1PsCL7638MetkinZnEn/ABw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9595.eurprd04.prod.outlook.com (2603:10a6:102:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 16:33:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:33:17 +0000
Date: Fri, 15 Aug 2025 12:33:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] arm64: dts: imx95: Add LMM/CPU nodes
Message-ID: <aJ9hRp4AgfNVOseX@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-3-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-3-e609eb4e3105@nxp.com>
X-ClientProxiedBy: PH8P221CA0056.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: a36da833-f998-43e1-a084-08dddc197085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ByHu9NiAfVz69J8cpTfhFyq1JbMjTNHgQ3SUtAIEvca+2ELOlz3q3bGlsyRU?=
 =?us-ascii?Q?XvEwCvsgoZma5W+NlO9/WpRcxO8PkgJdyXj1esr5QyxgBiYaYP+nc9HHTzRt?=
 =?us-ascii?Q?/HQ/gXidUdOpUotV+uT2RQJMzzmgJfdAlVQ6P4kHCY6FBtw41CbA43FV/lYd?=
 =?us-ascii?Q?8+NkyYLnYlXGFGlVIogcxvdSFxjVRCFOm9BItSGupIkAnOCpQiRCQdYqDgYE?=
 =?us-ascii?Q?Dw3lCCR1TJIFjHdG6kj2IUrT75NfNdGsTc28iH/FQatZO2lCXdEs4RBPjtp8?=
 =?us-ascii?Q?vjXaMkIxr3AFSZZ2DKrA/QZscA7sib++y3oHhaWsOEXdJZkFAHlJmtL0008A?=
 =?us-ascii?Q?dPNEaaQweqfSoDv/6b381qjMKs3Eu+BZniPIrZAGWQv+KMA0I7u4PhFRXx7F?=
 =?us-ascii?Q?DdUfsz6Ix71yfy84QmDgOVG1b23L0QB6CIYOp82GNvEe88mD226H9l40D848?=
 =?us-ascii?Q?FFYI4apxUnzeuFFAnbIDuHdOC35Fp7x2D2gBpy0D8JJ0XewDDpd6x/zRUE5j?=
 =?us-ascii?Q?1WIlT5p8leAXCea7ifS0LMrfx8rLVankl/srtt0Nz09j8W3aCg24rV8amRYo?=
 =?us-ascii?Q?gbwo9E5ujkgekIcRz4OsJYoaQRCsSxr8S8L5TDkLdx9MSiIEA4B9FN1Z73/3?=
 =?us-ascii?Q?o/sg8P1lGfAHSYzwZQat78PyEJWcuBjWkKLqSthjUmaz+Pm5152TplLF/VyK?=
 =?us-ascii?Q?Wn5wAfpDlIURQ+JEPZR+K8cP7htMER2poo8MkCn15SGi/nuVgeYnUjIt7K/U?=
 =?us-ascii?Q?/wSbSgcL/F8ZLyOQyOPvxFh7QQ+Q4pE4HrgAKrq2XcK6s0vHvIT9Qoeervgx?=
 =?us-ascii?Q?UMw74hfXJfvD1fG8Hd8pbUKTxi30uWEOtkvLNQYCYLTMLcIWiCa7olldZBG8?=
 =?us-ascii?Q?AoCNF7DGdZrss7mBkd9jUEP9pH10bQOIRtlZNE1fNXBj5D7A2hJP8ZJNLU36?=
 =?us-ascii?Q?XfL3zhFPnXnV+RKPrqW4dhQKgpmYO/4kAj0dEggH9LehRSQlZuCpwj2dg9W5?=
 =?us-ascii?Q?Qc9+Q5nHk5nNaIEb+/6zwVsO286k1T7GQRc5WCcvM0MdpiB+IKdzvo94RFKA?=
 =?us-ascii?Q?dMZGy4W6PJj5byXm8M1LdKltv7wda2GclJ/hlNEDqKOufvcz4L8ub6TN2vqv?=
 =?us-ascii?Q?MPH6zBdlGMu8mvynSz9kc0tJ0sYbd3/+UhGLPl9pPCu65xFoNBXu/OVH+cRh?=
 =?us-ascii?Q?TEl4WatFiZCDgHSISE6vd/G9GI4Ht9RnJFB9Os0x2DNgTcyl57VBUdg7Luru?=
 =?us-ascii?Q?h8lyxJpoVVBEZAeY5erk5D44QowctOmL93yXAX7Sbsm6Ykqwhn6Q5Rd2fAV1?=
 =?us-ascii?Q?8SZ3G7mF3P0iJzoyErcCPcGJ53WcRhhWBXN2v5PpNvy5mAX86sBu1oGBW3pj?=
 =?us-ascii?Q?1cFCMcnUUBo6CGJsVcJnaab8+jFgF049C9uy51B4+vT3m68b8u9KokYFREa8?=
 =?us-ascii?Q?kePbDzNRmIdKuA5KI7VYLD1G3y5/Z/Fx5zY9fWFjlCP95HnxUoAJQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oQH8vxjq8+K4PppxJAfUuznrGex7v8xgMwhXoRXaCFM1Xw3tWagoH6PzEoEG?=
 =?us-ascii?Q?2fHpA8TZpYtorBB32D+k9isHNOxbdRB9LXt6gPXuc7Y57Uu1BRzHuhJGdG6w?=
 =?us-ascii?Q?S1/laBz7sJ0LNOU0s7a9x6gGKEivtZFVRplsZZxaHE/FL38smuv/Esn6AObZ?=
 =?us-ascii?Q?dMdNNNbRmaPVLCq4usT/Hv0ncEEv7o2ordaHIGN81JekX9yJ042x81MOYB1S?=
 =?us-ascii?Q?Us/6coB3gAC60legg4KhTV+lIZv7GNnmYNBkf9ToYIAeLLH7EK9FsMbVthqT?=
 =?us-ascii?Q?BSGdA3oubqkRhAA7jrR/MT1adSCKtvoDTmHXL955D+YT1O5/6M/Ic3RvyBVA?=
 =?us-ascii?Q?ZDevNHTGWTU0PQaGb6WVdgViXt9rgI3uaEzItltOjioNgXrUaKPzsdhNYkos?=
 =?us-ascii?Q?HoJPDlqk2ET3/pf4jlyFWrdrjLRB5rpvQTu9Lfv4jCFcTav4GzQaAPP8+vXv?=
 =?us-ascii?Q?UGM0PtkXTCElGDc3xrumMTMe/HG0h3SZDPtgaomd6jDcDO/yPhtX1/ynChSe?=
 =?us-ascii?Q?leyNxJVrWf9ICKowVQcrYN9+T72YfrCss3UU4MS/hw5R82rJSCdqxMLm9T0w?=
 =?us-ascii?Q?AGQ2ruFVGA1rt/2j4KXjasPSBUhKX1zfGfER4VXP/yB/C5yUh9VcHIwH7zHM?=
 =?us-ascii?Q?9UzNSRMQZPC9KBu9pa/cHyBS57C8CvJmDABxUnlplg5tnTSLmzaDG9lQ44Yu?=
 =?us-ascii?Q?FW2mWB7mAYG+meHbhvHjsmnSUXT5ZD4Sa75PFVD0uZVjvFK4XuoNFBXoHWqs?=
 =?us-ascii?Q?oLy3sHHyzWbvzbvmeGKo1KzqBSg5aLn6S8e96io4J9bHGROd/iYRByAcAI0A?=
 =?us-ascii?Q?EIDHmKrco+neVEgpqQ90ZkWVqzN0L173RCor7eAI/FDd6UDQDdYePgrqdjyM?=
 =?us-ascii?Q?daMs/iogdI3mN1slrIz0FD33Q3rpvIOjuk1AatZJSydEHOKC5bXJ10z9qWkz?=
 =?us-ascii?Q?CK1N+VEmNTI+xrOntqi4B9nAolvsNq7y8c5kQ18CIi/1naHk641BPRvGtbSj?=
 =?us-ascii?Q?EdAbdM6Wr+ZKD6qJyiG8vphmUBUY1yHwhVLK7vV17BVh3WVPaOyvE7JYYBA3?=
 =?us-ascii?Q?K03nzhFCs+SIvKN4OwpJACuNK9n4nE6a9n0fJ7nfZ/kj8TfFqq73vPj1yvD2?=
 =?us-ascii?Q?jPp+VNQdGSuvz4XQSVIf+9RqZsJv5rEOB0F2RycysFxdr37oJV+WVenUtOOm?=
 =?us-ascii?Q?L1whRAstzbD36tQJIROHWCPnhyqB3bPfbcfaOAaZ482te7o2ledk7fORpdE1?=
 =?us-ascii?Q?2zCfT3L4iOa0lQxvbn/+MeOyLrZFv162AanH0fPPsPVl+Rx6VNiJLe5tB0Ea?=
 =?us-ascii?Q?9T4OOLx7kkb8qi4WuRdv/gjQaNRuYN90Q75BffJHVvCf5YZrYDV8EVi/aFvk?=
 =?us-ascii?Q?pmnOKOsLx5tWsYJkpuZchKSJoaCStbwiDIqr45MhbHBzVzWqVjBsNk2Imy0p?=
 =?us-ascii?Q?Y8O/Bp96BM9WQO3JEl7y/jPt4S90xhVRNrQi/7SybmWzvF+yCMaws2Igf1is?=
 =?us-ascii?Q?h1Qtsfr3agY9gW2h9WaVc85cZiKzCA4iThAXM1bqiVmFl0vWiuRyYysrCVCI?=
 =?us-ascii?Q?iSLj0BUOj3raCFxKvajeDl99W2clvK3kzluaRspJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36da833-f998-43e1-a084-08dddc197085
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:33:17.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRFZylEoxIm43W2objQY2oOCM8DhQk5NZAsMF12U3MpRIVINyX3kJ5m/IRdbrjfnDR/lgoEkBAChmZ82s0L/4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9595

On Fri, Aug 15, 2025 at 05:03:49PM +0800, Peng Fan wrote:
> Add SCMI LMM and CPU nodes for managing Logical Machine and CPU.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 642dc4b7a4770be50960f53a73db965ea4374e24..e20feb1bcec6088949e7dd1ab2fc1c108393fb81 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -351,10 +351,18 @@ scmi_iomuxc: protocol@19 {
>  				reg = <0x19>;
>  			};
>
> +			scmi_lmm: protocol@80 {
> +				reg = <0x80>;
> +			};
> +
>  			scmi_bbm: protocol@81 {
>  				reg = <0x81>;
>  			};
>
> +			scmi_cpu: protocol@82 {
> +				reg = <0x82>;
> +			};
> +
>  			scmi_misc: protocol@84 {
>  				reg = <0x84>;
>  			};
>
> --
> 2.37.1
>

