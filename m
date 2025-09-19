Return-Path: <linux-kernel+bounces-824930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB68FB8A7E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31EAE5A6591
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C56431A543;
	Fri, 19 Sep 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EojGlzkB"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802A17A2EA;
	Fri, 19 Sep 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297875; cv=fail; b=RlBcNXC4VkuLjzLAXB6pghalVrczCBDSp86Nm9N6sW3+aD6CzL6ZnjuUM82N631cv7JSOj/8R2Gj15yuL7ziOeuCCmYa0hqSaIhFRxwzBCuWoKEpjNWN2IhbcKVIp16tOzGbHF/h/3H+YsdepcehSXysezG7FvCt5QynvyNb43U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297875; c=relaxed/simple;
	bh=I3uUBorp9uAi8/sqmljN4TF5m3fU3Ko2jFBcHB1CjR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ugx95MH0JwRbOohXemTFPUnQ1xsIEArcLJnUYzPPHSKZjZbsNnCL5T/YlNbo/IIfyfhctIAoxdAJeOwslz7kYhI/DwLz8meCJBPBpHPX/MRGnfY5hoisOxlYyCYD5dqhP5dRuBQVvAL4/Iv69OtmZAk9QtbP9qwdQm8bv5Dt4S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EojGlzkB; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuFdRavyXtJW+xHd0DYyO9OUrHFCAYQ2JncP0/YpFJdHB5KWhQc6U8Nplv7PGTSTicL77rLOjz4c71wGqCCVQposa6ZbspcS2+n5htXBzZY2DzG86Qec9NWC9B3Hby0VcUVue4X9efxiYO+Un+AARM+4pspXMTm+JM7qKLv7Coyzmt3l1ggeSAjixkQewshPpIUq5ukSatMwIsx0kmakyrotFogh06xDU723XPn9WGfNTyrDij3kENIZoDVf1IdNttxip+RMMOxolAhk0rOmqZBmuaOJqTZsEhSUSUjeqatVWaYcBw+ImwNjbRzmeadrZd/nNq7ZTuScgjvO0rsI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc+8V3sOVI66vb6IvQWfZtyk0mVtVLh3TuLOrW/2yjg=;
 b=jb/OBBxOcwMzHl6gTKrHsj877xvimKwKNOynupm0QnyC/vorC/0uA9j4nlKi1Fzi4jNla+E/Kp/rAofmQZ7YNWrqLqDNR5JPQVrhvbSIqJe4+tHCq/R0DkXaPwice/il6f6CK/GML3IPO1rpcJEldMO3Mszy1/r3Ft3dfLAlda0TNRSezDAYHVkfM7B2aQWvZokQUWnQpMZJNh1nKIya0o2MkmHeZl28/0QuUlY/chBDTsB7R8RFoE8x/O81wctEFsxIMW5wLHhZr7131HMFVEzkhlOpsOtvKnVWuClfKb7/y2yHyr9rqjyMJEy4wM3hGUDfPW/l/bEtMsc3ayTrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc+8V3sOVI66vb6IvQWfZtyk0mVtVLh3TuLOrW/2yjg=;
 b=EojGlzkB0UAWIhu8u0vm1AkUj0LtOf4sbunqZC8msgo4xGQZCvbG4xEsweIpIbuGPVTEVkN1HsPTEbHuI2id0yFzvrF6cs5Y2OHHMVDklDCwiGue79Sz1Mvc4qJqIK56/DznRk4QcP+emxM5gjTjF5Rw9zqEYwXThr0eI95YexVez+VXW9FBclEbM+YpsdW7y6McUTbGkr3rOFPfLJS0w7IeE9yOAaWVQFwtF7gKKwsmmd8KZe+Apxou6rDOwBRCVejrEdrh0WJG8y04SXNCFYOdCWSUXESLKo/C5NJGobOTIhNhMihaoPfKGaPrWbiwt1WYGYRl1SH+YkSn9TLWnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB7846.eurprd04.prod.outlook.com (2603:10a6:20b:2a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 16:04:30 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 16:04:29 +0000
Date: Fri, 19 Sep 2025 12:04:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx95-15x15-evk: add fan-supply property for
 pwm-fan
Message-ID: <aM1+/XSr9+oninEW@lizhi-Precision-Tower-5810>
References: <20250919-b4-imx95-fan-v1-1-c9127bd975e9@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-b4-imx95-fan-v1-1-c9127bd975e9@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a03:505::25) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 6190711e-c442-4f42-5b0a-08ddf79636e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XKP/VRdhW0LBlRzWIBNjA210XAMmXV5hncNN8ll7ajBqm3+DCsG5PnjdRxrP?=
 =?us-ascii?Q?PosUpNcTntoVaXU0iBMIH9R2Sepy7S+T3npSxm3W1QP5refYX+e8+LdKCb2s?=
 =?us-ascii?Q?6WO6T1AeIhbxB/ykWJl6EuVkRj8tXyOc/cKiY5D6EcvtIOs+Klsil947vNmL?=
 =?us-ascii?Q?JZpDPKlnqetQRNqTGQqlRJz1+qTbYrnZ90WXzicA/3DebaDOiz+ScrE/3Wsa?=
 =?us-ascii?Q?evlAIGyUsGI+lCc0xRsT3e1+x/u8dHBrjWGFJwV1hAsfbtKRWkDCjsQ11B23?=
 =?us-ascii?Q?MHRY44woDUu+UWmerr1Hx/ngJDUx9dcZZIqAH88AYBNRtwGANxDBvlsePDay?=
 =?us-ascii?Q?VBxsZmrPYatHsBqQo0bS99LjtllgpAMtYHsiDDscMt4syzoFP2tJjV0dvkFS?=
 =?us-ascii?Q?rCQutwbzMsmilC76AsmEkjz654FMnlLwTlVUF5JiErX3OFNMuRGDaVBJGgvl?=
 =?us-ascii?Q?tY2g08bQbjqSv6t+iOmyTLVc68ttWPI1hm2CN6ISAgihDXX7YGKVWIn+sRbt?=
 =?us-ascii?Q?mQPHf2IpsG4I3CtqMolgr3BnrumRXximnZ3GvvTEVjV1aOp6KE4fX1/3rpcr?=
 =?us-ascii?Q?mU3I7ksgs93pLeLdv9WdVpC3aeerMIBth9bQbf1bNSDoWQtVYVt6ZL4iLF8Z?=
 =?us-ascii?Q?WLS9m3hQl6aJy761mFPE1MRUkszOlLhN3MFcYefgr8UQeA2MuDiY7DvGo2Vw?=
 =?us-ascii?Q?3RFMMF0F24phzkRGIYA9eg/vpV1adhKnzPcsu3oYZ4G6rD4u8asTVaNJl6/y?=
 =?us-ascii?Q?BCYLoeb1EyHbu70i3Wr3QjVk6oCCdpltgliB5tIs49YKYYt1zBe4DRmZAxjA?=
 =?us-ascii?Q?jM6tN1wxU7YpialB/vtreI1/swG36dVYw4lPpWSeOJjvnV6mbj/9yJSRNznH?=
 =?us-ascii?Q?lU4g/VejPkwkCBO2J2R6CzbWH0d4rMXxrmaw2fa3q81sz5kMdCF9iRu/+5y/?=
 =?us-ascii?Q?SZBt4KFAB9pvpw4zS7aI0qqYfsZ1tewn3G6MNQuJzdXNIw01miX1clSPeW/F?=
 =?us-ascii?Q?wOCcHd9T4XC7CIRkC8HdnufZ6c0leeSwZL8UHrML2wEWZV0mYbSmwLWTPzdc?=
 =?us-ascii?Q?Gny3rpn094fFJT6uYsuPogj0VKS41KpNmRAHsCWIFrA4I1BBdBeLAtr7rFEo?=
 =?us-ascii?Q?T2Din6xP7N0yxREKJcz0j4ey6LyzlW5IWn2/JQ2TDYIqs8Q0I1hLV8c5g78J?=
 =?us-ascii?Q?RluCdZFDdqpWaWpzpldhvqn6v4zXuIaAH/888Xam2/Gop9qF13+bjt5tOfRO?=
 =?us-ascii?Q?pWl0mj2Vw/ljeA6ifOtemv+riuIYMIankNy/zT0gunWfSEieStWvUNHtF0Ug?=
 =?us-ascii?Q?byCl0Ecmjz4X34CpD5x5fY2sbi7Y99XwNaSL2PJ8mSXk3X7riD3TSVEsbv1y?=
 =?us-ascii?Q?H4SfzWGFroKAx/sxJRmU7lazIhTFcv56ZUemXzi2O8mIll5mKag7+c1njRER?=
 =?us-ascii?Q?ZtSe5dG3Sqq2zecBJDJ+OkANQJGxEIY3WKNYOn6wpeJGIVTx7nXTYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ZX9fmgrZQCZlmCHlI9iN4NSa15FXodYAALs5XsEL4qIgJac7m4zuOmBVN5E?=
 =?us-ascii?Q?md8XNRddUHckE/st9hb6gyDWBUBMAvOZrMk9/lgV27fEqItE0m+19TDrcPbd?=
 =?us-ascii?Q?ZvDwVMNu9W6XdkPT9+gS1YXQxfmGJ63WypGEd4ETt18QgGPkXl6S9IOUO2t9?=
 =?us-ascii?Q?11cCU1I73bHUdlghGzETwONSgkr5R5gA8qEKo9u8GNBHru6SAcS6iNAHuMpm?=
 =?us-ascii?Q?09FxIfOGBVfrCGdYnMXDXqNpRnqnhyTfHIaSPhGA7QZLE6L6vafcLcD882WD?=
 =?us-ascii?Q?gAqS19GcZbrm23pBLGWTuQUrvvpvHR4M9rHW2e1lDmVIFx+Vc4eSMntCqrVA?=
 =?us-ascii?Q?bylidhwP6IPnTeQ9wRStNOCsCwNlUdgALYTW6MlRKYPaHYjR1jjmMSe3w75V?=
 =?us-ascii?Q?s7cYGw3TLkZH6P3Al7t13MspyKyGMB6gusXyxMxN/l1rUzvUDLM7+eJ576QF?=
 =?us-ascii?Q?ub0pWSpBHxJuYSoqFhxmDKGPPndQTxoUuq2rTkzY+iJ7s+k29hV+pyL0xWnp?=
 =?us-ascii?Q?teE6qb43lS2BdqhrjbvRFIJoByIl3vu95MvB1X+bYWHWpQvGchdj3zmpIjFP?=
 =?us-ascii?Q?NbOfpwiBfEt/84ySkJVCulAtrmocv32pngjDUAmPMGr40HsrTQT5tUgwaqPf?=
 =?us-ascii?Q?QrkYu45ec1qW566sYV2+/dtW1H7rfFYEb4LYtvPg9BK9e2BrrNVNo7HA+Ty5?=
 =?us-ascii?Q?un67BYC/3A3JFvd/y1w1UbhMhixbyDDNv4xXl3zSBV9RtmLCpyU3GaG0hK72?=
 =?us-ascii?Q?kx3eTFdXWzufv4PJ4SVYeSI+RIOYh7pd4iALqmITT8LK9m3udbysiBixuZaT?=
 =?us-ascii?Q?p/Bw4vFE43zdBea+igyyceNW6fRLqcsu5H180E0D6wd678rnZyTxF1K87/th?=
 =?us-ascii?Q?Z6+tvglDyCMnVJ0oMnXhazV/i1vxtBXb1C14i/iv6TcI3TmG0c32f4BxT0Zk?=
 =?us-ascii?Q?Rpq11ggeWmzYSqXxVBoHjL2Hq9aEsQuT0dV4Zat9Jf3Bpj5wRbkEN5pplBrr?=
 =?us-ascii?Q?jF0QeJEwwNIJPEZYIWwgQyajoq54gOJWMB6q2K2C6cW/mvHc/1bDwk+e7t3X?=
 =?us-ascii?Q?NzvX6MW1STudWOVLNPU4qASYCs0um1KtJ4j846io0DlyT1Ti+ug7akTRO7nS?=
 =?us-ascii?Q?E5oCeaoqbweVaTJX05lGZJh96d5betSzbd5CT7pnvS1J43pVIcLEl+oTgrdU?=
 =?us-ascii?Q?TccvhGTYVZd39BRCTICfzsARyk3dTL2mdiV+PUcs7y+/j+QZsLrmItlb78JE?=
 =?us-ascii?Q?VH10QWXakE0q4zZFpDxIDgNmFb3afC244D9amTnqULqmuWNhbe50t8HNP4Tn?=
 =?us-ascii?Q?g2xFnQuAsf0MhQMhW7WOa/W0LSVqedfUKeUGY//e9ecgV5b7+J7KOHKuvf6c?=
 =?us-ascii?Q?WHdnR2/SuqhucQfAHjWDAWsEKieKJt85PwU6eA0pt5zMuC80BfXNCfx5cRH2?=
 =?us-ascii?Q?520b7+CiICryY/hN8wyPD8QbneAkbK35bwEhIzCFU+ijUpwdN9ySDqM1nt4e?=
 =?us-ascii?Q?oG8Se2VgZAYjt3QhM95D54pADIXI3lkUoFL2JOlaaRQOKompVr49ecbXPm5y?=
 =?us-ascii?Q?GGNKyLiN9rL/eYRVUVdW39iOocJ7kr+Xl6W8uwf8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6190711e-c442-4f42-5b0a-08ddf79636e8
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 16:04:29.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSgDDkq5GLIPA8b+F5vlVLMJPlrOlLo3l1e5Zafg4LCT2EX+vfWQF2EfFz9/x7MrEdhJ4LTnY6pVMwZw3/Yi/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7846

On Fri, Sep 19, 2025 at 10:27:04AM +0800, Joy Zou wrote:
> Add fan-supply regulator to pwm-fan node to specify power source.
>
> Fixes: e3e8b199aff8 ("arm64: dts: imx95: Add imx95-15x15-evk support")
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> index 148243470dd4ab03afdae949c8316f31467d1377..0953c25ef557684a3e78ef27a5e3f5aface33e3e 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> @@ -61,6 +61,7 @@ chosen {
>
>  	fan0: pwm-fan {
>  		compatible = "pwm-fan";
> +		fan-supply = <&reg_vcc_12v>;
>  		#cooling-cells = <2>;
>  		cooling-levels = <64 128 192 255>;
>  		pwms = <&tpm6 0 4000000 PWM_POLARITY_INVERTED>;
>
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250918-b4-imx95-fan-9a371ca858f5
>
> Best regards,
> --
> Joy Zou <joy.zou@nxp.com>
>

