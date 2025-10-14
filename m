Return-Path: <linux-kernel+bounces-852964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E411BDA4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD05188C138
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09A92FFFA0;
	Tue, 14 Oct 2025 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fKECmIlk"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB53C2FBDE9;
	Tue, 14 Oct 2025 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455146; cv=fail; b=rq2LE6qTrBpxthAwosAbEB40pia5Z5zFaLYTFjQLEgUaxco6nLKqMrH4U3M0PfPbiRTaq8Vtadwk8FVC8DcC70lXMQ763m1fGrFCp8IHCzWmdgUycW6kOAxK9ca8sUcO726hn49Ra8/sTygLXJyDXZYna9Uz69pSn5rohFOVpLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455146; c=relaxed/simple;
	bh=OSCJ6MWFp6sIOt6NyfFXqZo5uwTBxCoWIwbiK3VqN8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sgj1hPXxbWb5JwXR1y0o0CTATuwk3FHjYBc191xw83xyuiXGdJ6r27tI8SW0S5Vnb32VuKl8SqiBSNVwHRS6NKo5W15rOMp4OARVBAxbtNbACUkYuFlhczyQXuszzP/5T8JL+l/4ZFlzzx/qrt19SYvZYR8FkHCgC2E3/B9/8DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fKECmIlk reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGcnmyl3Hqa/9WT23nd1lBXdbq0tgkJN1xaTuhT29chi/slho+3KpYET0T5oOOal9wdLgRMYYWMfWCGYeQ2sHsIsV3FrGsOWam4DOYQ78JYAbQaL1cycFR/WnQNjFa34v7fLXUmYYZTLdueXDa5Xjbyy2FdiO2x/ufanZS2LoKcRhC5KMuB9fWdczg/JJc2znLl9PdQOilRAOpreGwc2MxHvKcvs0PkwZVQQNCvmfq6lt86eliibCI8tKr0zUpBuMFaGojAfkxUeDwmgF3Xv+Az8ntX9wO/3qpkljJD6WuS8IIf6FPjuGfQT91GA52TfDnQAwu/ma3czaRf06/2qYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CeuSpryyPLgvTzVZ4OIJ0Wb8LXC0CyBe4d1HXrVifQ=;
 b=drcwx4OgQJgSADR+Dl100X79s9CkAhZA+5gf6arIG++tIKeYbo+c255NSBaFybYSD/7bAMQnd98U5N8ABFr9mClqHQ5mwDhktlDxzIhyJGKWEo2fzzDg2cnDwOh6mmu/gsKXrnQ6JCcgocQyjwRHfctvxW51bhdRm0Ru+YXayFwfL0w5av7YG9OdZf9B/uqaJPeRJRK6sRzn/+1GcfIhpMVSv5Ql0LZBYqT5G7765GPgHSzBRTDrbOQP94BBN9n6AoHCUa6mcBfnsBVJ0thHDrCbqNsPdRSmu8R1ud4rgdszle8JFCJXaIUIARDSHOiGkkf6aHd82cg8HmzlkJGfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CeuSpryyPLgvTzVZ4OIJ0Wb8LXC0CyBe4d1HXrVifQ=;
 b=fKECmIlkK4g/9gwVaN1WFNkpHnZnvU8SkrbO5OCBTzkKQtYXtCHeIG0dCz0kago19eoLJsx7flHyb2c/rRID79aKThEzqvNL2KkWQW5/wM6p56DoBfu7QmaLuRGMMjQ3VHCVXQzHCAOi83OKMjUrwFhOiw1vCEIj+JHLIsTw1uFE2Se++ZTwijFOVqQvo20Vd1Q57qU1c6t6dbAJjOMZxiYvZHj7TEc7BE06PE9TfvMpabXHu3AWaR/fnpN/R7R9Kw2ySZIbnn4/mpJmx0hqL4MqYDtbYka4rC5bVBlSs0/HhWzovlht5viLqpRNjXgX66GDUrWulyDnNsF13JWMUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8745.eurprd04.prod.outlook.com (2603:10a6:20b:43e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 15:19:02 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 15:19:02 +0000
Date: Tue, 14 Oct 2025 11:18:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: imx8-ss-img: Avoid gpio0_mipi_csi GPIOs
 being deferred
Message-ID: <aO5p3hSnnOv+evtk@lizhi-Precision-Tower-5810>
References: <20251014-imx8-gpio-csi-deferred-probe-v1-1-62dd1b949731@toradex.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014-imx8-gpio-csi-deferred-probe-v1-1-62dd1b949731@toradex.com>
X-ClientProxiedBy: PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a024c4-d81e-4f52-f80a-08de0b350175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?TlNf4SuynQHOrWxN7p7NhzQm9IaVumvP2k7nxYFBF6E+5GxYAsCHfiSigC?=
 =?iso-8859-1?Q?88JzDie89rCwXjuFyfF7maRmL87xynpxOFNdiqf5gWFNRfPno4flLpyAmH?=
 =?iso-8859-1?Q?UI+YVqi2+9j5wdKPpKQI7chovYqyrS2J4cPMHmTZdohLaJxOD9rU6ssr7R?=
 =?iso-8859-1?Q?/umEl07/e1A4n4us+yZS64YVFFBVQtvZaTg0R8aNlyg0m8Qk/zIzfacmD3?=
 =?iso-8859-1?Q?szh6VitTH7ywJu/k1foEU5z0REaTOrxik5paiZ1z+IdHhDkVJ06NgbP8bs?=
 =?iso-8859-1?Q?GGOiVybbljkFC6zJtncgW8qbffMMQBxKdDXeY7OoMEdmYFlBOhj1yK9+BX?=
 =?iso-8859-1?Q?SyddvAFtgfVs6ECc1kv6b+CG/r94+VMBr6Rq0TAHRxz8R9ws0plw6a4yJO?=
 =?iso-8859-1?Q?uIjLVKSQ81xXn15x8EYR9MF5U9X51eSg0DNIk/RN+hbgh/GcxynNb6Ra/m?=
 =?iso-8859-1?Q?KuPpYvMZk/IFgiy7lritu9b8u73TEv5gDHB3JgsM+71nCUchxL2aOhX/m+?=
 =?iso-8859-1?Q?m3tPLqx7KqADxIByO+GyMkpFPV98MQwDPvfzNdA9sq6vy36KxB1FhoL7DH?=
 =?iso-8859-1?Q?GrDjLTf0EATlCuIvwqgjxLJ6AcC9isJekpotXsmlokmY2r7xV+YabxMMSg?=
 =?iso-8859-1?Q?0+Hv5jtyZhHrvJU6kCcKHf4InVuaj4CxhvuKCrkEdKPLbIxuqOkMo5WmAr?=
 =?iso-8859-1?Q?jwT27xN8MM1F6gvKBu34tIbxcmSLktzJlM7LXr9gzxvVIIkW5mYr1z9LqT?=
 =?iso-8859-1?Q?NxeqFynFImRFNSiQarBfwCokfMTj0T89yLt0ywX7ozdgYgNJzL3hXqvFk5?=
 =?iso-8859-1?Q?PKBZRkezqtYHRT6crVbRxTAsykFSK76CanxsSQSYa0fi0FFCt0MMliql4r?=
 =?iso-8859-1?Q?U8shz+lvQ30F9yTGcNCOEj1xArdDc90AQHeBYalp3DC2rEF+ayDdWDQuCT?=
 =?iso-8859-1?Q?u/PPJw/CGdwqPNQJLrczw1FYJ8B2kri7NjvCOIkqcmd/e0YkD598qvBivg?=
 =?iso-8859-1?Q?ovQS190lVOINI0b7K6qryTm2C1GqzwYcZV/ekLDXO17S1RzYrjV7V/1RPJ?=
 =?iso-8859-1?Q?NsDmlgknOqqUp+noccfxqX4nsb/DMNQJaCl0qXRVd6QYI52acibcOwVV18?=
 =?iso-8859-1?Q?j8rVZX25uJHMl2dzVXuwEt+hfY0eUNRSjSulFmMkWzgov52XNoXDKerD/I?=
 =?iso-8859-1?Q?kRu0Xr2LHJc8u8XuYzEs+10yLHIMpzUGQWYp06Sw6Kr40nJ/L3Non4RSy6?=
 =?iso-8859-1?Q?xbs5CmeVd7v6QyuMGHam9fCaVv30ZbzecgUsytiDvzEO30ZznN9cBzYr3b?=
 =?iso-8859-1?Q?rYLtPsEeT67VaMDgU+MmwgP/f5Skc16iFNJvtzgA95fLrQWHKujr6GoNQJ?=
 =?iso-8859-1?Q?Z5w1dooc/6CIk9YzkUu1ItFR2ssNaoX3zzus6z0osre8Z0n/GDAkGyTlfm?=
 =?iso-8859-1?Q?QrN0u5Cg1bduu4LY6eTYznRR221ZVO9EGlxHYEGSQXZOHEBQOMFKMEIrUl?=
 =?iso-8859-1?Q?q25VgP8SffI+fTnxR60f2CRRiEasY1tikFZoZs6AlHBCiyvtsE9zvIsXvI?=
 =?iso-8859-1?Q?2rIJ5SMXOe48gJ82BxpnlobYzTW8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?IcZnhHPjvaQuB9sqzRqYW91ot70z+8nDTwpJYeFRenhAkmSgF49FiurVz8?=
 =?iso-8859-1?Q?WdzTqWS03ZUgmo5cx/PZU4gT9ictlBZyMIKVkPLCRk4un4+AQYvutxR91L?=
 =?iso-8859-1?Q?O1AW8KdZ06BJXIdQzOp0f/tbMAuL3WVxXb0ApeJJEiuRXR1ILSdjaPgFlu?=
 =?iso-8859-1?Q?RW4K6SHVz0hDxIg7FVxbbK/TRj4/Y2xfRLqRGh76t8K0B5jboAqwxac4r+?=
 =?iso-8859-1?Q?7UqUaHLRzMv7/Sd3oLREtDuMdpngjmdu4ijW4lIiG+Uu0jfYCloHIlY+EQ?=
 =?iso-8859-1?Q?4IdVYJiMlxZCgj8QNfSBxx+Lo9/MdiQh2qmsPJHYB0Kc4W4VWXMEsNM49S?=
 =?iso-8859-1?Q?4HjInylRfaqWuIRE3lsjeIxn9JiOT/pIp6/YRXXtobSDEFoMstyc8aRqQX?=
 =?iso-8859-1?Q?QGaaNuEXVSNuAJzGbHOKdjQSUKv+49d9w9D2TGUAXVIL7JnpRgT46+aPvW?=
 =?iso-8859-1?Q?DVF0rHYgNO/56qpFEGFS/pFoREebXmRGYFIXheVxaRUpSCEpP9dcKqYGLB?=
 =?iso-8859-1?Q?h26NVTwicSZQwsnu03dnq+F7u01lrlGPYgklOLM4JgY9JjD0exAAalR6en?=
 =?iso-8859-1?Q?S2is9Xgik5oyw+G2SBsBzWwZIjHh+arjVL/z3VQSAYtXu2b+7CF2zfz67o?=
 =?iso-8859-1?Q?3Nqnz2U6NH0cS26g1Q5c1KvJsVVbgL/RaMZhgeWMsyFS++uh6ndszFgmqU?=
 =?iso-8859-1?Q?gf6ynOB2BH25FL4LxIkU3pFQhwvaQ9olu1hep+HM5YzTwcc5/acMbNeb0/?=
 =?iso-8859-1?Q?qHk9QttAR/xbtn+3U4vc+d0/NV5SEIaq3+4oE7LPe0lRUnb9J8/TL1z9qF?=
 =?iso-8859-1?Q?d00Eibbr3OPVJ3UtIfR7EJ6VeTgK/xiFi2VA8sNLhCIVeDrUic7X5jLYrh?=
 =?iso-8859-1?Q?ZXRFveEYjQzeKfKmgx13RRDAwr271sQufHcXxLMJC+TOgy8wP0UR02amab?=
 =?iso-8859-1?Q?bs3eAtXpS/ccM8ttSN56MQk3yvhP6S30DDPBW5xs7lhufvL4UO+II9zn0Y?=
 =?iso-8859-1?Q?bPEOJOqHYcomutMz78eXGpYr090Ohk4qnkCxLOsttmJaxx8Vg/LfzKzEVO?=
 =?iso-8859-1?Q?+JswzDfLdHNPlWRdDxubdiYsod5XFOzVtmurHlYM25xzuptoUyinNPZHue?=
 =?iso-8859-1?Q?yH8s58Q4JYz8ncIi3R8xKBwRFHyCIwGT/CmPurw1AA/8lRnHGPvhV3CDaV?=
 =?iso-8859-1?Q?TQUhyqDvPmC3KaqODIKfkJNmF1ptCqSCwlF6xWeg5lbzt+bQ0ZM7YWQq0q?=
 =?iso-8859-1?Q?R3X3gcPZN4f/mfnSWLLiwLryEs05Iyfj0+WwxpFewnGVlYz5kLsW/GbMo6?=
 =?iso-8859-1?Q?mnLDnbScC2vqGF1urijuiBbXGsZGoLQ5p5djQEf5+/OYzh/geWU10fXyz9?=
 =?iso-8859-1?Q?TzhnQ94HVwPIoyAtnDDzcfHTw5tGMs67Q3GUnuvKuRMsH3UU75meqZDnhp?=
 =?iso-8859-1?Q?ouqLTqETLRvoDamJFcCzg1KasXLiotjp0l31VvxiPakMu2xL7QEWpTao3Y?=
 =?iso-8859-1?Q?HydePdw5+oOnVEp0+S+WrVTsWBDL62ft3DB8t01C7PPtNGWWpPtewBuTGp?=
 =?iso-8859-1?Q?Tsa3oW4x57D0sAF7xQTL2CmJQp6f/4H7dY2jnA6SQpOeLsqL7jYmx/TLji?=
 =?iso-8859-1?Q?BqnNC8QgUFXX1NWZa9dAO4Wb8va62EVJsp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a024c4-d81e-4f52-f80a-08de0b350175
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:19:02.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FnGcrQOyCS55cdqR0MegotNIG7F7UxN/TdtZQNnbCQKnvyiGJsvqpjv0390Kta7L57HlM8GvHhYNQjgd73QuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8745

On Tue, Oct 14, 2025 at 09:56:43AM -0300, João Paulo Gonçalves wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
>
> The gpio0_mipi_csi DT nodes are enabled by default, but they are
> dependent on the irqsteer_csi nodes, which are not enabled. This causes
> the gpio0_mipi_csi GPIOs to be probe deferred. Since these GPIOs can be
> used independently of the CSI controller, enable irqsteer_csi by default
> too to prevent them from being deferred and to ensure they work out of
> the box.

If enable irqsteer_csi[0,1] default, all &irqsteer_csi in board file can
be cleanup.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Fixes: 2217f8243714 ("arm64: dts: imx8: add capture controller for i.MX8's img subsystem")
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
> index 2cf0f7208350a416d77b11140279d2f66f41498f..a72b2f1c4a1b2ef26196c810b33ecfdebdbc1675 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
> @@ -67,7 +67,6 @@ irqsteer_csi0: irqsteer@58220000 {
>  		power-domains = <&pd IMX_SC_R_CSI_0>;
>  		fsl,channel = <0>;
>  		fsl,num-irqs = <32>;
> -		status = "disabled";
>  	};
>
>  	gpio0_mipi_csi0: gpio@58222000 {
> @@ -144,7 +143,6 @@ irqsteer_csi1: irqsteer@58240000 {
>  		power-domains = <&pd IMX_SC_R_CSI_1>;
>  		fsl,channel = <0>;
>  		fsl,num-irqs = <32>;
> -		status = "disabled";
>  	};
>
>  	gpio0_mipi_csi1: gpio@58242000 {
>
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251009-imx8-gpio-csi-deferred-probe-eef6c56a35aa
>
> Best regards,
> --
> João Paulo Gonçalves <joao.goncalves@toradex.com>
>

