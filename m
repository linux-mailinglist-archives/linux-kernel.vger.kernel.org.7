Return-Path: <linux-kernel+bounces-861230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB598BF222B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06A4E4F90CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8D20013A;
	Mon, 20 Oct 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fkj8HNqx"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033E26657D;
	Mon, 20 Oct 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974306; cv=fail; b=KFWJWNdNhdBTKYpYNF6nBeBb7ZAUYI8htBNnBFTYYv5v8EXrDnnBBvrr4LCC0W/k5Bv7xwKk6naaA8lgUwBU7T9CRKYilMCuQZFeDlYHgDeTSyc084HzSmsHtOMisYA7/f86X+jPazB6DZ8CfjGeRzt7o+wzvJIq5JUT2SXp42s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974306; c=relaxed/simple;
	bh=5egbnLM3gNSQG/JLMruAe9uI3OSOGgKDXgO6gHel2g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AsnKh4OjBBWKpIsk/VPmACbNyms7Qb5561BXcN8MWXEukDs81HTsSADtkFU1ghzw8MH/0eVZ1iC1wii+5hZZ59Z5J/Jau5hfIJZCzIqSbXIcpF4rGjy++S6EE4a6ngMcmkuAowQCYQazMkaNCIfv3g6f7+4an0qpHDnm/OHw0e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fkj8HNqx; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isJ8hH9E/O1Xlx2BaIkXJJ9040cDZR8sQ71HKwWgrCWfJNxbF8a/2XrF3xFDNVI6fPwTQL9N8KZPYB/urmEEZ+UJuQ5R2SzDUexQc8iur5gc8pZ7xooN4c8F6dQQRiWKmME7pFUKMk6upLu1FjuHVIpX8/9jZH0npfbQ+H0vFwhKsGQyeIuVfhhhsgXMCIV2FOS91aYPUpJXJfZYmqtDVq92vB754yy2hxPL/wjHeUWiUEdjCsqJgGwVbQXrwD36tjx5b/st8M5tl9hNTd+2NpLiH8a5b5cxxZ1YT2zJ2B8wNmxGn8nznxGf48zrE+kwIOyIhgP2F9+Vfe69Zzefbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRT/yHCcavZeqeku5Jwu9RgXzuW0WvVIpzS2avLz5SI=;
 b=PQjZB5gQVBsE2XfD4bRQCX7gmXTjNq8Hy90brinVae9euEgH29SqAApvKNDzK/nb5RSCs2gd88H6bZw5196qw4M7cM59HXMJxOMMNzoFVQ5o/xv2LHFmrEHAfeTfLksTRCUYBr4/2iE2XHjuO7oPaHel1IEmxixYup2l7b2MjMWREFmNyixkFPp+IMwLbYBHtBjCvBz45iyZP8i1OG6W3qxxxWjNPEcHtqu5LSSRaqmPLfnVIx5UfRvnEsVtQMg/oTgaLhp/sDIcPnJp420Xa7EtBLZ6vS03Myg+OxB5rtabyOaEOtFwD1TLDarf5cFK4vO4bk27KNKRDyCv2FiEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRT/yHCcavZeqeku5Jwu9RgXzuW0WvVIpzS2avLz5SI=;
 b=Fkj8HNqxEXSy+71KJXsWdCu28kCl79MXnGdBE5IVPkJsMzJ8IKxLwpWIaX5lXlr2KcnFrCxiAWnqP9iSZ3iMA5oP3aTI35au7wcpqzkP6DKxbkk9vvbjwEl9X9mhA7nkWwPcnnRBGVb6f19gFtoj6VqO+IeWvP2Eph4zsrswYTfpjlHMU3ZnI0Dw1EUenx35kU+uqSuhr7LGC/BgPsUrayeIGur3DCxh4TbIM9Ptv5oG7YKqMs+BadjB4G/Kl5kH+1X0YzaffV+ERMOqJPIl0HRXf1PLnWBbpK8lB7uiBFEU+lhcXi56irdvHKy9KiDzxYiAsJoIYx17bWHHMzb6FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:31:41 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 15:31:40 +0000
Date: Mon, 20 Oct 2025 11:31:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 2/2] arm64: dts: ls1028a: Add mbls1028a and
 mbls1028a-ind devicetrees
Message-ID: <aPZV1aGxccYjJqNP@lizhi-Precision-Tower-5810>
References: <20251020133536.303471-1-alexander.stein@ew.tq-group.com>
 <20251020133536.303471-2-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020133536.303471-2-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: PH0PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:510:5::25) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6a3684-9691-40f9-8485-08de0fedc3fc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Zllv7hLFc6ImDzBpjUNJodyv2CFbxgdQV1ZYEj0GZRXVcGQMblGlHadd0O3M?=
 =?us-ascii?Q?gCrC87dDRaxXadST9xGAjN1hPzfzFBrClPfY03X8baQJPT5MxYsx2fCetxQ0?=
 =?us-ascii?Q?am1h8DfyD1GjzpJBVrWFHVNsmujyEl70zaXyKdnq9xcEEHW0/zNwe/yUoCNF?=
 =?us-ascii?Q?vKQYfHM6+H6P9uOgTUrkyTTfbYXIDOaeF7nxX66v8fGeISG2Tld1oT72nbRh?=
 =?us-ascii?Q?mVVxgzn3vfICIOq0KdMKREXANlI+ln51+2z4zwwYlp6F+E1TUtah0fksBSK9?=
 =?us-ascii?Q?icZo4R1c67yM7U6U/Wr2btPK3XoGviZujjYlYmX3lOyPyuC+5xcs/RsyCpxS?=
 =?us-ascii?Q?Mp3tvHEWdHQKdKSUeNhS9SWpjnzUOMUWdrjVPFOLauyWhZO5ivGxATTwmj6G?=
 =?us-ascii?Q?kL2HKsNj0cS5hRCApESETaPRbyw1ruYWHxyHEPso+FhK1yRSUg4nLQeluljC?=
 =?us-ascii?Q?uXwItWpQi9Wsx0+S0Uk43yKeJO9/J0vp4G18mQTJ307zCUYs8cJgyvGZJD/V?=
 =?us-ascii?Q?Qh5ZiHSJCAsm520jybdM/3pG82vwH4fY0/OnE7LygQFaDlt6NS7h6TkhpPIJ?=
 =?us-ascii?Q?REapEqILDqz1soIa9Wfi76qUMLFJ09PPyCI6v4CGvmDi9DJYumeBmkwhrkex?=
 =?us-ascii?Q?bV5BAer626jvuWyRHoGEDhnavVkiKpNd7/bHGRHR6d5IwxJBGFoSeRnOlLA7?=
 =?us-ascii?Q?T2I3IIpL9jbYOwF0inTuBH2iy0S7pYFeBacLByOtTwYfiiKj7N3W8kZOCzCM?=
 =?us-ascii?Q?o/4WejQVcDh3DnN2Zdf/kFVuiE6ASxsz7T/FnhOTc2rqNuCaMFPRGrX+QECU?=
 =?us-ascii?Q?Xowzlews+2ETU1/iRJnccleqC6h54vGO3RVGsIPHCDC0JeTzauuwZTYMlcJF?=
 =?us-ascii?Q?4K+/CXBzrYubSxPlJJrgfqeoV/O1lcsGPs3C3IQxA3i5vGZ2Mk5L9u8ON0MG?=
 =?us-ascii?Q?dCndg3InlIpY6iXQ2IA7JhXXZpbIN803wp3dhtIM8lsPIr825flLMWa+J+ev?=
 =?us-ascii?Q?DXmfB3AvWuxsUq6mpcDiM+XB6pFqx2r4gsBlOl0H6/P155uBIeYO+2uk8lbe?=
 =?us-ascii?Q?+LkqSZ5CusqPF/+Xxu83oxrK8PXkJW7fv+3hnH9rgCZBHorWGTG/yYoXP3rT?=
 =?us-ascii?Q?hahzZRbmD1sG8HTz9/e+pExUFcH14GtVCRQ+wq+4RK0iQSvaak6L4FwbeqH3?=
 =?us-ascii?Q?M6erInwWFDplsHnOSLT49aX92mJuZDTzQEc6Fd6S4tJO0msAeVj2e/UW6IZY?=
 =?us-ascii?Q?AUNKLelE7V3BYkGLtoSA5zXsotAVr98BKVFp8Zs2KyXrxhQ5Iq+Jd4vhnoFT?=
 =?us-ascii?Q?N+MsaxP/lL549f9cJZbkhtZRJ5OVTpY1j0/9v9NoqDkb9JKeYGTM6TSu8+Tl?=
 =?us-ascii?Q?3I3jnPOD+9P9gLLtwuxNHQhWLjm15mJCx9OiI8lxjOSnBEi5t7zvkAfYuUlw?=
 =?us-ascii?Q?kIDbnW35wI49Ly4x9aLa3APoi09xlez/dKcQFeVkyvk1NajaA2VykQ1W7nUu?=
 =?us-ascii?Q?/rY3SJ/+N2qPnkieVzUAFnnn0eePqoTDEqH8?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?J3lOpqrAQjgj31X6hepialFkzwELUIntD0YtNVG7xKakpPhuJaDtS5jzc1Ua?=
 =?us-ascii?Q?ZCw+hd31s5SzaHaU+ZfkwNzaZ7PG0hmgPXpAEi0kqJtTAYuE3WnM2z02iec5?=
 =?us-ascii?Q?rQyQj/yTf0UbJsrsdTJrzUHGK81fwLWyxAWYpVLpSUk43F/1pC4PIJNOUUvR?=
 =?us-ascii?Q?t4bCkGY7vvGhFAAsVjnNAKCKYME/5TDcuACRgONEYoBueLudpG4YIZ19NfEt?=
 =?us-ascii?Q?+A5s0Xx/2e0nqGxwdh9TZD0ChvSZdY5y3dYNgNOUT0HkqQ9lbbCe6/a5Z0Bk?=
 =?us-ascii?Q?zZ9G7ko7mVSIqetrE22ft8uwejk2mL3BMNC4jJogf0Ldo+84H9E4nAJc7DTH?=
 =?us-ascii?Q?kWZFl4pQOtDaQbzAcHK3EFuy8P2kL5SlOlUxMAGyV9nt2ZhwTUE/v2yB22rP?=
 =?us-ascii?Q?agXCLGmRdruVCvBIo/0svBpeqH413yEqsnPQiqAr9+/KcXOtgaapRbjMRVnX?=
 =?us-ascii?Q?1x+Ioq6EunekdxqwECHLHZ0Q+NAj/yYNXjqVGtbxknckqvTTF1ybzudS4wfJ?=
 =?us-ascii?Q?kRTs5ocetA9ScgY4Q+WTgd1hr0gH6Bf8C/iHvtk1bqqGeSHwjGKEvaSJnDeu?=
 =?us-ascii?Q?FhOAtdWnYS88IOAFigZFWoeA+ZDsdWf+QmRRun/wfvsWREUz+klW1E82sgZe?=
 =?us-ascii?Q?6+JN0ajmbvb2CdRnNFpc4/W9ardVSKK5oj6b53N2iOIWglsaVVpr4A2jGVzh?=
 =?us-ascii?Q?5KcSgraODY+Ejb/k+voMbstyMVnOFylStXgs+1fznQI+xLJtjIWm3fLTYC1Q?=
 =?us-ascii?Q?EOTOeOG8reVAw2PSLcvoqS9EFU0R7FXnfNPg3/x1z63gk/8B3CZTruLhAaVJ?=
 =?us-ascii?Q?Grd1H0LSN4mLo66mGs00+XoaX0ptB+cZ0YAA4n+OSJMY8bDl1O3cKhR8UXZ1?=
 =?us-ascii?Q?U6MhPnRHK8wr8G5c2m0xU1lPz4L6n8YUdtQF5Mq6sKr771PIewPt6ykFFWJE?=
 =?us-ascii?Q?Dxo28Przuc2mJ9HRSB26KMVRDZoQr2ZUDLC3G/YQLg32ZU5SRIGX8kMPgwi6?=
 =?us-ascii?Q?W2A/LLNZcqpKPERjVkXxkoscy5pQU/M4RsvryyA/w8wIAB7DHAvCu3yA+Ry4?=
 =?us-ascii?Q?/836KLanveGxHGQZNHxFd3zTJ7tyVKdIcVe0hUm7RZEhSBhnsHqrFjxsd7pS?=
 =?us-ascii?Q?jeJlo/kGvVHUX7kqJBi/i3Ottr2xko/5iJFaSXz+pUi5OEqFiePvbCwWO13Q?=
 =?us-ascii?Q?444cH6zD9xgGYLk7fAa5ZhtHco7NUY5djEbxkVxvF+ew88ygQOpIRJG2Hn01?=
 =?us-ascii?Q?bFCoa0s42XPwMuxq8Q8SCjkOj1zq7eX0dAGmW3DJ2bXRFUHa4eD6cPWfCFhW?=
 =?us-ascii?Q?avbgWi2vrqbsqFR5/ECfuDxYRZk7W8kHU7TmT/8+t6louJFcg3/DjBWT1BXE?=
 =?us-ascii?Q?YGOwBU9U/gH53eWXWE/CCBUZbsTRR4blyXqGVIyOafUQ7VqM7YPV2h+IpTIN?=
 =?us-ascii?Q?TOPA8nYWbiqC4Pe4VqnZzQhjVdJnBtltwjl7DFZRSyqaytx7yz8ZIBOvwbSD?=
 =?us-ascii?Q?NuI3hnVOIr1OJnaKBmYx6e6IYhr4pcrJb4dCCNi11FUDUDgRaRLbFISnEClL?=
 =?us-ascii?Q?AI0vxvTCthGdjLU7/sE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6a3684-9691-40f9-8485-08de0fedc3fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:31:40.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AM8b9yE3Cj5o9eVC9aggciie0m860DRm43tTSHBppup6k1OwYtqhOm2vM4x6hDHzwVrHALbW0DWLXEneesjJYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543

On Mon, Oct 20, 2025 at 03:35:33PM +0200, Alexander Stein wrote:
> From: Gregor Herburger <gregor.herburger@tq-group.com>
>
> Add device trees for the MBLS1028A and the MBLS1028A-IND and the SoM
> TQMLS1028A.
>
> Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * Sort node and properties alphabetically
> * Add clock-frequency to i2c nodes
> * Add eMMC supplies
> * Add comment about unused TMU
>
>  arch/arm64/boot/dts/freescale/Makefile        |   2 +
>  .../fsl-ls1028a-tqmls1028a-mbls1028a-ind.dts  |  68 ++++
>  .../fsl-ls1028a-tqmls1028a-mbls1028a.dts      | 118 +++++++
>  .../fsl-ls1028a-tqmls1028a-mbls1028a.dtsi     | 294 ++++++++++++++++++
>  .../dts/freescale/fsl-ls1028a-tqmls1028a.dtsi | 124 ++++++++
>  5 files changed, 606 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a-ind.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a.dtsi
>
...
> +
> +&enetc_mdio_pf3 {
> +	mdio0_rgmii_phy00: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x00>;
> +		reset-gpios = <&gpio_exp_1v8 1 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <1>;
> +		reset-deassert-us = <200>;
> +		interrupt-parent = <&gpio_exp_1v8>;
> +		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;

Just curious

how CHECK_DTBS to find net/ti,dp83867.yaml by use "ethernet-phy-ieee802.3-c22"
compatible strings.

Frank

> +		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,led-function = <0x05b0>;
> +		ti,led-ctrl = <0x1001>;
> +		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +	};
> +

...

> + * as its driver can cause log spam outside of its measurement range (0-125C).
> + *
> + * Will have to be reevaluated if this DTS is ported to a mainline kernel,
> + * as both sensors of the TMU are referenced by the default LS1028A
> + * thermal-zones definitions there.
> + */
> +&tmu {
> +	status = "disabled";
> +};
> --
> 2.43.0
>

