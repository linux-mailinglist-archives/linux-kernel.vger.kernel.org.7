Return-Path: <linux-kernel+bounces-771220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F857B28449
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4A61654D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F79D25783A;
	Fri, 15 Aug 2025 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KaQHO28O"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8F225782C;
	Fri, 15 Aug 2025 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276422; cv=fail; b=Ye5NZNU30LIo3W94bvV8nFo58M0UdKU8qaP9w+lyMaOhUkWgg3JvfAIdRfKPZa5YseX+mQ1NMXIi1NAytvWbdsbcAir9JQhHpad9zVLPp/UxOKWe5KE1WpDpoTG6DcT6olnDbYF7Wj/EDSrWK06y5zSasbFzy/LRrv+CcR9I2mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276422; c=relaxed/simple;
	bh=1KCvoNXEQwwTfSTkT6H+aEYSxX6g6LulFyU9n1E2lvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xa+0Jrr+V/IdjmlpGkDIT2IuaYHGifyzySCewLC+w8EbPfAyfmbelqXAx7owI+ZZmekNFsvaVL4xKGpDLyJAVT2WmQui04xxnUfbjTAF3YWzo2+K1rb0OJw/XWPJQOd9xCSSLnfkXMPZNUk1e6906pd+m7NipRJe3nsesfQPjic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KaQHO28O; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hixplmxPWo2Fy5wMAm9qQwEyOX/nUhVhgc7/9NYVJ7DD6qq0tOEzkt9odxG279wMTgH0DuYWOIAjOD6URJc+Wtd+JkNaYGX6VI063U5FvqKYcQMwNZ6PQLm7amedyXfZ6jnRCfluxUbKgS2LfJTZs7n9+qkHAY9w63jgFkm3z8Ld8wsQdnUHCK9PcSA/3sXh+j7VYNFY05Ikc2qGLyZS2rpbyn0SMc85a+iu2yxe/IVbdlpkUrVC1eGVJSrPxyoquw18RnODUaSiAnVWFipIuyW98NDFWx+ILEyACyCzGhZR8rbDC/HyfV/1imeu3ghenVdLxrxABSX7b8bhmi6p3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQCoOxbtXCq6kYlT0FL7pzMbxSHRVHFvhdOCLZEksOA=;
 b=Pu6yskqohwdeooJ871CQz5qMosYKJP3njsAa6ae+FEqFA5fz7IdiOaZODbbEgd29s+m5+14PKLunZTtB8cCQR0uxyAfiKAwKSJD4lbIt28Mmk13Rrg+dl3lt+mPg6UR6JZV+D9xgqrblEXjhVK/eQowotz8JoywhQ9BuJeVEVrkXvh8AHgT4mUAf5xBEZs0SgFbVJt3n/pBs9U0WkBnwxYxhcxULVxJf6vRPdtuB7SrkZ5UddQASqGsj4xsEYQKul66nyPLjiCqAa84EELEav320jRuyUU/BrbpK1IcwBzgu/8Mngf0WiNp7ilg8WA0Kt/2erT+qajlcOBrQun8jkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQCoOxbtXCq6kYlT0FL7pzMbxSHRVHFvhdOCLZEksOA=;
 b=KaQHO28OGPyK4cYe82oXKLD9x+unEGyHEVF3LwncCQsaOFLDasH9zWDjWop3I6OrKoKIGfD96yS7FYX/PJGeyZ7YQn215B0gSibVjjvCbNiluA+W/+MiqvsjV7GW/4K9nN81HQwA/IL4FbJQLdXV/jttdAC9FBQU2lgK4H/cktYxytPq54u51nz1aaDPl6u4dLFOVl88CuYn2oXgCw1fbpqOdmGJ/tNNRc34N+JBBqTLH5MYfGcGvWjbAa4Zk+0dkI8C8sHEmOLXvAPB6LJR11cn14hpjkDFvmr5sWEpg4Fyzcsv7HyBHmMc+GjYQB30o/keuABPgHb8A3vBEC1RWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 16:46:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:46:58 +0000
Date: Fri, 15 Aug 2025 12:46:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Luke Wang <ziniu.wang_1@nxp.com>
Subject: Re: [PATCH 13/13] arm64: dts: imx95-15x15-evk: Change pinctrl
 settings for usdhc2
Message-ID: <aJ9keuX9ul1Awowy@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-13-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-13-e609eb4e3105@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 277ac892-105a-4450-2cbe-08dddc1b595c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OnnTxp0hDQP5KcDP1JZ2IMcpsrM4+iZnNczXtV2n33iiWtzAHCtrHenZpC8L?=
 =?us-ascii?Q?79psC2ArDiDbcak6rtjN7IeWpmjUYi7t2fAUKdIeXKt+RkVCII/lQrueMcmI?=
 =?us-ascii?Q?ePKWHZRYV94YTFTo682z+xHSg7iV8Tx0goxIR/HU+NuZ9V1UDArKyunM+gFu?=
 =?us-ascii?Q?V2PWb0ysTcyvVl3SlKSVDqk8AyuOjxjEwjWU7MQzMXotbBX/9BVtHyV/m7jF?=
 =?us-ascii?Q?50MQJ7f4i3DAF//dXNtVtr4OMLcgu4SMDLUZ/6iuPpNmE400/Lt5dum45W9u?=
 =?us-ascii?Q?1vktOsYq1UYK9mjJKqRq2bmVMXgFgtOeJKRZ9ypqYrfJ5jcXKK9lXNokWoiV?=
 =?us-ascii?Q?yc5J8OEwWRQ9dPbUIuu7RRyO/ncI1bq9R3f/6RHRDkPVcNkoEPo38bK8mokp?=
 =?us-ascii?Q?ngqrQ8WuX/1mRNVU0cf1mAXPTOj4qiKUFQPdDKiDMUQ1O1+3Ddyh1SZRFs/E?=
 =?us-ascii?Q?XwIxzRVw0ZY8WhwmI6r4HJoNYM64iPsjEEWd+Y1Jn9xnXLATAyAi69AFHZtk?=
 =?us-ascii?Q?7nWB0+XCMLnXOse3NM3ggBEyTMBQ9ud9znWnl5XBVZq1HgrTYNt3+YILaVME?=
 =?us-ascii?Q?gEeZupNLgb2/DMgt0INtuf3CnG7/l6kf+Sb5HW2cZKKiXeNEYUiWM4cSIkti?=
 =?us-ascii?Q?6vlg+p7jhdPq7Fzh3OMXcB8d7shE8FQcdUoltGwKS3vnQmlJo3KAQqgaGtHG?=
 =?us-ascii?Q?URS2tj+zjEyJstMbYPYAc316t9r3s0DH76aOGv+KoavKFPrlfNm/mYYYMFYi?=
 =?us-ascii?Q?fuonlMJEzRtUwWcIaseSVcUsPMLgJC9e9rY1EmaMq9VGhwgqWmNx3MsqKKvS?=
 =?us-ascii?Q?tKGn5zulvQfYOFRggE/U0l+FeO/KkdNr5ZpVwXTzGoHc1+R/rXDLdCpJezpW?=
 =?us-ascii?Q?ESyOpGpg8awH5c6PNbyh8wyCPkYaWcOkFIIksDucIry2XtUj7TwBhPgrM6Nn?=
 =?us-ascii?Q?ExTBfkMCsrnjJoiR0xcQvmy+2ARjicx+hJP7VIwCBAK/PwfWqsDOVLBJqBSr?=
 =?us-ascii?Q?yzqq7KvcEAggRjiA+uOinehI7AuMfZWv2wlGbaucqFoFAJKsMqYqjBhrJACZ?=
 =?us-ascii?Q?r0DvyxnAmWnKVpqTWw4L5d6E+btHMxv3iWvLAiVPvNes1Q4xks/jhPMkRIt3?=
 =?us-ascii?Q?EFrXx5ivm3lsoXWLAc4ssx0GJgQgbMdYp77ZuazNO1ocGsVmJPLUMHE62gU0?=
 =?us-ascii?Q?OIssJ06cIuiDkhKyTgAbCGdx2GFtYKUwL2JcsOvv90ehjLyxrPZpj+TKEwQU?=
 =?us-ascii?Q?/vGttdoLa79vDiVMpfkpFyJGHVorzUlIabXvd/6mZKgXJR6x0gjNMDD6ojqn?=
 =?us-ascii?Q?IvRQ4I8CZRPTsoHF+pi9zTie04Mdj3t2Pjut7HjLU4gM9phkKc1eCh+Crr9d?=
 =?us-ascii?Q?zm2gJs0ABWQT7P27+jKhVyXqohdb98EM7MNhCN7gP4FidC4626s5KCO5y53k?=
 =?us-ascii?Q?yZjz2ztMTI1K9kGLxhrIsjV9mbARsiYzgu+m1EWKrpYdYmLlWFjzvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8/ouXlrikOMJaR8BtmpeicPFX2Rc8TGX3WHMsmm0ZJya/Hjy0BsjVHhjxFTv?=
 =?us-ascii?Q?UVkJbe/KFSO6K1AVcQXcvJRp9c/GsEdvMCy19Eh38zFe92WozLuLBpMoah9P?=
 =?us-ascii?Q?KzwWMpDxLvjl2o6oe6GP/Ee1TYLYfXaTfdscXKOJaBOZRE2Q7hprr8R53Rgs?=
 =?us-ascii?Q?FlUgPQH1HBTpi4PuWEEW/hJ6DbvQABbEW/OGeIAGEKWB702CXgjW0UQ4kOMC?=
 =?us-ascii?Q?lW/oAbzOUe8wkjuFP13n7uD+H2Sl5JeusVUZOyss/oXlrkNVL92Xas4/iF7P?=
 =?us-ascii?Q?Z0QMa5A3VLOZ1d4YgX7kYAO4h4RolaRYbsqtNb8K5xNUhJzv21Mu6LVxKwtF?=
 =?us-ascii?Q?0bOSGs9agVT4O9oQ5tEDWZL/FAe+8KRtrmniLVEY69OL1LhN0aJ8WS5SNPvg?=
 =?us-ascii?Q?ChUB26Kmv/moPgb9X2leF2EazGBJ3Nnnnjl8R7CV9v6Dn7IHV4t5OEN6AEwb?=
 =?us-ascii?Q?qgJ0rYByAyhd+H7bo2Kul9iGF2+CXBToXhUAXPJnW4hfyEE3iqsd1le5RM75?=
 =?us-ascii?Q?GZ0aXlmERQXicWg1kQSriS19JDuLBon7BIU1gvDjak1tPPZPg/fUaxcL8vxI?=
 =?us-ascii?Q?pcwkuU15nYjC9Vq2Fm9HtGjf3SRvZP6uWYfRFVcm3KbmW0VVLeFtdVnRgWH0?=
 =?us-ascii?Q?pTX3GJMlWvQ+Js96QS/nS9lOmAYBYpuOMjoX3GILmW8V9zMGHh2mARzXbYrY?=
 =?us-ascii?Q?LmJn3KAMq6Cw1blAOVA5zwKpSlNJx8r5+eEcMLzj7siQZc05DZMy3bfmUm6w?=
 =?us-ascii?Q?z4jIUFKxFj84SHdRaGlV6317CQ4Omlc7pn24loBYqWU6cbNhTgsCSlwy0OOU?=
 =?us-ascii?Q?mjLObaMA9pfEo/pdHwBjvlcDyiNSqu06ddQVed0LPlb8v8zZ1o/EUk6Llz/z?=
 =?us-ascii?Q?qqBJqsokp+KGTRDRNP+S84etMcx9F3S6YXrBW8xLYBpv3feROqrnUlGKYCnb?=
 =?us-ascii?Q?OX478oHTNhzstaxk3eynJuJGh0JH9E/k9T5j0GWmjpU6oY8LVQjeByZoSr80?=
 =?us-ascii?Q?+0oTpxgOS+VwcEmfzuEvsZBw77rEIf6dwtbrlJ+npNs9I/AQLA/c4KK4b62f?=
 =?us-ascii?Q?PAy8M+bdyKrUWaqFziwKRvxViugq39KwGlL7AXVKmRoOeWtpM8RsiTdWZDOU?=
 =?us-ascii?Q?UFzT43QseFvSPzjXezyLQE4X1b7FQhOdBABd/r4GRDaIqTEdvgzQgAVJCbsZ?=
 =?us-ascii?Q?e1Ncr/AZtbdIIPpa4hZP/7m3nFVYk67AStjnCPnW92IlifkmBll/NSNLEh+B?=
 =?us-ascii?Q?nRM+gfYcwMTDeaSltWM3azwUkjIX2Zf7dNHSL3Kb2j8+6xe1PHot/l1/k+s8?=
 =?us-ascii?Q?VnuCoJ9hCVt9PzA8Q+uOcQ/lzlAC1nf7RWHJgLQbC4voTw5aYI/aEC1peZrt?=
 =?us-ascii?Q?W2w9YBnUMv1I9hSmLcmEGWFNx82vo5O6HLM+S/gAHsDstbzLsnj7kF34Htm8?=
 =?us-ascii?Q?Elv4S8aNtRLthJOSuITAtR0pKnxbL/4TXkbb8Q2LzrT3Brc7wdyzoXbGMW3d?=
 =?us-ascii?Q?soc1+Og56U+cOy+Z60p4jifz2JkyUFXFp7wWivt4j8mJfsuRJFO4cku1uRk6?=
 =?us-ascii?Q?mu9oSmq93MOaD7kfwHM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277ac892-105a-4450-2cbe-08dddc1b595c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:46:58.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyab8TrU5Jk1fgWg6YHrMCbbEpVcKR7mVT8Vrycw2cJtkDywYoJ2i4HEPpctFtTGtuBVrRXtmj26McwYnMGDzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7051

On Fri, Aug 15, 2025 at 05:03:59PM +0800, Peng Fan wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> The drive strength is too high for SDR104 mode. Change the drive
> strength to X3 as hardware team recommends.
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> index de7f4321e5f9d7d6a6c46741d3710756dd2b69cf..3c23022923e68fe0f5205d322ad6f8834a46dc56 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> @@ -881,12 +881,12 @@ IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
>
>  	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
>  		fsl,pins = <
> -			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x15fe
> -			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x13fe
> -			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x13fe
> -			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x13fe
> -			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x13fe
> -			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x13fe
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x158e
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x138e
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x138e
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x138e
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x138e
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x138e
>  			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
>  		>;
>  	};
>
> --
> 2.37.1
>

