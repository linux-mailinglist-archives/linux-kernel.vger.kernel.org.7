Return-Path: <linux-kernel+bounces-849150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9F7BCF4C5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B2E404968
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB6626B08F;
	Sat, 11 Oct 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BqYVsOCH"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D626057A;
	Sat, 11 Oct 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760183792; cv=fail; b=oVa+YIUketejNMcAK+vh6CUsmQLOZ8AcrvMIKhItnoeKyP3QzOu+ViHm5fRVmFOOMfXRKGlkoypqNqQ333E7c3LxlmQbLrbBjSm4uais5xoxoM5lyn2NA0grs9I7SAPWbq8tM8egB4Zy2LuzofzXX6o+ahBtKvWTTs0Zfg5DZU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760183792; c=relaxed/simple;
	bh=sofT64gE6o2qQNJgdkv0RrXs2m60jCL10Wc6AOrbuPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hea0PmzhjPhePtZOu2ua8GFwzteF85Jt0U/fqIqww0+z9wf5tJZbBktvw7dY0bGEQhKDnW8mfxHPKX7YJAcXr/9l3wDTx3INnQju572i6ZRJX18M7bL6XXIYgc4mtjCzIzODxOM4Ro6QMlVnFd9cMy3BMpue8ADjREyIMPvm9sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BqYVsOCH; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdITk5OVuwPtSfxMDpqhjmJfmkf25WC8ZyK8RVXRTCusAOHdvyC3HL/C/bNwGA4Re9V0kWBq5H/cT1Z5F4tzGG40Z2cC/Rs3AkEqvXQXm8rDrOMROPGVEI+N69qleFYBGZgHsYIHgVpt+8GKMpouub/cP7HNwePe26hiD4Y0gneeMtj0GlrN3Ij3UdUf2BwqGkWfexXsmq0BenNy03JlbqYMusUWPFI96fClNSiIwREzU9orGktUh73gOlacp3Jl9YhqDbtX6JNlAn5zE4v6oNHdYKuC1b9Ml1TSU4CjvY0obdAs7OlvY5tkzTbEGRHmDgZ8D+MzRFuhXjwHMT7vwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sofT64gE6o2qQNJgdkv0RrXs2m60jCL10Wc6AOrbuPE=;
 b=FDaX6c6F9siTAG4+0Ml/dmf+XiHGoH5E1LqHF3stG4AmgrOkkH+25ebVbgl1LY7Cwp2/dN98L/xIz4Hq0ZwYxQBOs8kJB2x1NqQivOnMmCAD4iaXIFh1/uxuZnfYGvA+IpJrdlJf253BmnhCiPxiwe7yDz3ns85ZpML5tDmza2310WqzwVq/DjyjKeJT06n4+c/9gYz5s6/YAN6j/FPJy8CxpTjOHYIaNwjl5+CG1qhfU0OypCnUBiK4enWpSW/i7GbeY4QRFnWlhHzR0qAIc9LRlxdAFtAG4Tb9+FWULqC2eQcz/0evKYLGMEq0IWmwWv7vDRkXvz1UrXwDFjroyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sofT64gE6o2qQNJgdkv0RrXs2m60jCL10Wc6AOrbuPE=;
 b=BqYVsOCHkGidvLWLLhrZlgk0r7sg9y6INhB4pwKb9/9KvWRz1K+RWqT/ltRqUvE1QQyOjSiJFqGl7kJ3MpjAzI422gtDD/4et+aEQOcbZAKTCG0k5Fw10BIWsA1DHlPCqZ+kLhvEBtB+DHmkH9yj1XIGTxun4eM1EM+p0tzmoeSdnSdd42/iUHwYP0JKk8ob9gW/VWGKt5q1QBfpLujD+6E4N5P3/6UgCS5VB1BgAGGC0TZheO0DlWcKNatFVL3G1NRUUtrLh+djOFeqsLmmE1UBz1gUsHEmz8EDmShzrViCdRRFBhpZXPvQyEe4nnA/P198+zVWLCHwhSP7Bqvc6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU4PR04MB11364.eurprd04.prod.outlook.com (2603:10a6:10:5d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 11:56:23 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 11:56:23 +0000
Date: Sat, 11 Oct 2025 21:08:31 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de,
	Teresa Remmet <t.remmet@phytec.de>
Subject: Re: [PATCH v3 2/4] arm64: dts: imx8mp pollux: add display overlays
Message-ID: <20251011130831.GC20642@nxa18884-linux.ap.freescale.net>
References: <20251001-imx8mp-pollux-display-overlays-v3-0-87f843f6bed6@phytec.de>
 <20251001-imx8mp-pollux-display-overlays-v3-2-87f843f6bed6@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-imx8mp-pollux-display-overlays-v3-2-87f843f6bed6@phytec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA5PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DU4PR04MB11364:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcf273a-0083-46ee-3f5e-08de08bd3296
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?k6+Y4K2A8gbImXwGFirrTcGyqBff3BY1/O5OyVeLNG3PJzSoNy8XHiME0RJK?=
 =?us-ascii?Q?UgxbwSNCsX1nugfGev9ylKlrlOeJHyb7OEAsz5X8XKh9Toq0RpzXPSEyx0r5?=
 =?us-ascii?Q?Kf0j+9l2C01DY8zG/grAtim/Y1CPfOn6L2djU8bpC61K7iUQG3cTBObBLkxy?=
 =?us-ascii?Q?9xOiTsUJx+t+XSs30f0rZDV0WHJdO6bPEz3+/o4L+WA9pNQknN0wW/gZ2ljc?=
 =?us-ascii?Q?Q/1R4fvKZR7fuPxpVvIKvJ2yhXJsQf5GTc9FTjqke5oGrSWvzpWeaSSM876E?=
 =?us-ascii?Q?Z10JR7tYaIhG9Ie1yJFzbfTIWpdSLfE/n9ECnP+XNVnKq6n4/fmc8FmL61gC?=
 =?us-ascii?Q?H60erwxKkIzOzDjqkZgDm8uBZkyZcs2bE5dXp97QERx2RneMNUq3JpE5wdCD?=
 =?us-ascii?Q?tCiV7lR4kq+fqMEmp8TQSQ7WfhhO0LN9Ry0nFUYCgjS15iaXbzVQ7u3sV6os?=
 =?us-ascii?Q?A9uVPbwc8tq+JvNGH3Y7PQX9PmIL+ncjbxaTJ+6JOk9PTyeUE0bHbb/N5uE3?=
 =?us-ascii?Q?BEE2C2vuXQJXPz8hlGkNniOhCDo0zyYcKeqDv16wh6+DhfyuFblfK97UIUe7?=
 =?us-ascii?Q?JZpJYaZcrrHiAzQFQwGclkDquQrT/EekYOt+TZJ6zAHRbwv2Aktab4uGKwOA?=
 =?us-ascii?Q?XkSObZXpU2Ua7RhzYqTTeicsk5X44gnVSFIK1JPLHG/7e7JnGaGimoBaj1pO?=
 =?us-ascii?Q?ia0zUX5yJyzMUMQOgqgj9jV6EfTBb+f8wx2hcBhly6/su1fRCnAr0H4y3U/A?=
 =?us-ascii?Q?kX6+55WXuRxIy12jhnNTdJB7kEBeqsNTziaN+OyfmDOdjiVinBRIzEdF48XB?=
 =?us-ascii?Q?fafQdJEFC0WxDkKlP4gBWPkI0pR7q8/dI8n07RSRPi8c8HnCDXZgxWXJCcrL?=
 =?us-ascii?Q?m1vNUed6HATBBhbxi1q0lK8p3xawV9CYCtz2hkt893YVfUIxWvocwQ8azLOv?=
 =?us-ascii?Q?eqq54rHVE3xZybSS8e7HNZLwYoU/UK6n9KR/zP/G6H4jTCPw4c0d90uU6KkM?=
 =?us-ascii?Q?IwLQCJf7eJrni7l3HwXZ/Vnx/ww1SCtgBjhBEfmbtLBx50eAqDCRf4Y1iSkW?=
 =?us-ascii?Q?LXBaHt1/F0bRaQ0Au2FHeCdlX3BnjzI0M8IRnCjEEhoCacu23qVDYbe1LheD?=
 =?us-ascii?Q?jPYYOajPU0nGr5hmVxeu1K3XaVzWzMqaJifmbu8IBuufdnNM87iJmvI548J9?=
 =?us-ascii?Q?smKOeHmsooimPqqBA+ssyJI9P/6z7/FUtchyqEsn6gezR0DsCV14H8f00EyZ?=
 =?us-ascii?Q?xXT51UmQpgio+7r5SKEqxtU/f0ViOmuQUf5bDV8/VOPqfFKuTrmqXHA9b9wJ?=
 =?us-ascii?Q?JzYyiJ0kGn1p5rAr64S7JTir8fVMXI8Vsv8wDEILrig7oJKqUF+LtaLB/VGm?=
 =?us-ascii?Q?nRdagfLjSrhPOoIK7hWSIqazC4oJIt6TMcIr4TZtQCCUQzJpxZ1og2xI9c3C?=
 =?us-ascii?Q?Aj10dBjX/y2Q9P36wpuq7AOr7YdDWP51IHAsXu+E/HOSnjHUmrZd3xbDKCRK?=
 =?us-ascii?Q?dk0F9Sa9FY2IvoGCAuwWoOnWHYdbYG30Gg74?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?XYXeWu9Dg/syYC+RpOgbIRFlZEYqgkWe3TVhNOvtqHMc1lCHVSw1h6Qnumep?=
 =?us-ascii?Q?hr3AHAnRBRJNbuIgvuAjXQs24SRvrqi4zBP7JhFSBTcl0WUH13vBa/UGRKgW?=
 =?us-ascii?Q?BVzT2keNY/roPhXIb45HQO+Hu3vDcwhphw3egyyEK4x9IocZKzd5F9RA9UPq?=
 =?us-ascii?Q?0Mt/L4ar3kN8BRj8G+dBt+AB4JfFHHnZyUG9sqgSHd4WklbNlsZtSfHTTzKO?=
 =?us-ascii?Q?OPGlDh1ijhGzpo+g/op5DIubYYmSldZLHmaUHsG4mmCXWVj82yQC6MXSDyUz?=
 =?us-ascii?Q?ddvwrrhfVQ5gItnztdXRbJv480jQsUdptc6lZEBEXuHz1zKHbSAKUqNPbEx0?=
 =?us-ascii?Q?TKz0z1Wmv00EKpzdrNvvLgfuDb3RvFfe3/aao4uBkzI7imNxFQRn/HP2XIaU?=
 =?us-ascii?Q?Ky9f/A2FAPPs6VLxD1ray/LNsINfLmg2UdSKLirgye/vI/Iy1x8mHsfZpJmB?=
 =?us-ascii?Q?jhJy2CV9zVghf4AEcC9bvkBGiGG0/h9QuASjEGhDueL/qnVNRnnNRYqgBYB9?=
 =?us-ascii?Q?qgueTw/Af94mYecrTal3TjcHgEqYBXp1XSX+mIo/aCksvQfkunlEXsC/cFPE?=
 =?us-ascii?Q?BD2v533YPUQXNB1bwITKeLqjsyPrm7PEOAvGCe9FXFU4EPEHbvPct1S9Qqk7?=
 =?us-ascii?Q?xRXawyu7svWl1yLRb8XGUN7ZMPQXiiMk5KKY1jR09LEZa9+WcRbpx+BZ/nNe?=
 =?us-ascii?Q?rZIKho6c+pmhfrx11Pg/A9p18uimyTxAEpGvz+q2tlHZCpY+nFFxaoHKM+As?=
 =?us-ascii?Q?YzzzsqfBrxTbkQadEYV55ork8JZDBuuRUoyW36PG2NXsRHhr010Qm/EvjxTD?=
 =?us-ascii?Q?Vu2wM0kSY8Pu+7JLg+UpGkKffM0u5+QvS4xFmJk6WQCnApLCSqdr1CIML3tt?=
 =?us-ascii?Q?8StRC1MjSNvUkMum+3SrBdBuGk/1vzB9/BKVRcD5PKeMl4gIxayHrErB1FO+?=
 =?us-ascii?Q?+GZ7Y2qeguMwjywiczYXNDOQGXqboG6d4MwAH62jnckjEhrbZv0DhYcj1LNv?=
 =?us-ascii?Q?PncIC1ZdXWo29te0JqiBAd7ZUYu5K2Olge0FXJ3ie9T+pHJBAGoEQh7/yXMS?=
 =?us-ascii?Q?rbOpAI7Q97gyiMbje1eiBSQkF5nkkBei+pYUmxVhE/W65m5mgojUKmXY/uYB?=
 =?us-ascii?Q?jvjJSuALJQ+8U2YfjkhYnXb6irGg/bEOSKeHTXFtt6hrNSIJ6ZbnjxTiGHtU?=
 =?us-ascii?Q?pl3Sj+Dsxv/MCz9tAqPH2R+ul7Zlh+ra5ZXqOm63vGSxZVd0+LpAdfkZz1Al?=
 =?us-ascii?Q?TaPvpPnGYo8bG5ESwSHbweUbXsC8tpxqQjq1lDvTyqakRuUXGVKDhg2DnV9a?=
 =?us-ascii?Q?J/zq6JU+1jW2krjvcpEKI83z4jrfiOkKhtS8m31zDGvoK4Cc3Ap4vxhuwc7o?=
 =?us-ascii?Q?NeCcegPqlVCZOpb49YTmEfzwLhL7CVVGgYHfQ79Pd0FKM8hyllsA6HHS9G7N?=
 =?us-ascii?Q?1XqlxRUByVbIBz5ovtrr+NWhULJmSrpK8IUJvZFiHvoZX7M4VCqbtFG5YeZZ?=
 =?us-ascii?Q?2zVKnUhb1QgqqRAJ5DjMamMQ25/E+LMFCr7wupKmcNOp/05ldgxf76ULSXk7?=
 =?us-ascii?Q?1qDuN4eXzMqFfK3R+1D9GIwsrtuSgDBFCRQHjsCq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcf273a-0083-46ee-3f5e-08de08bd3296
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 11:56:23.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vnwwdTDD4NdGpRm//1iIf7IgWWBg15KiAU4TTZsq7Lr1IzBfjCiV0OfvddiLCNTS5ZWQJB02m2UiH90ZtotIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11364

On Wed, Oct 01, 2025 at 02:33:52PM +0200, Yannic Moog wrote:
>imx8mp-phyboard-pollux had a display baked into its board dts file.
>However this approach does not truly discribe the hardware and is not
>suitable when using different displays.
>Move display specific description into an overlay and add the successor
>display for the phyboard-pollux as an additional overlay.
>
>Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
>Signed-off-by: Yannic Moog <y.moog@phytec.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

