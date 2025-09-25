Return-Path: <linux-kernel+bounces-833362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A855BA1C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D953B45FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FC42882C9;
	Thu, 25 Sep 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TGILIuAE"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894931CA6D;
	Thu, 25 Sep 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838903; cv=fail; b=tVnFoZd4IeM2FOH29sk2+s2pQWOO6jIKtu3O9GSVY/p6QYbyHUpai924nOLsGNCazrqwLkeA6q7jHb+/4W38wS5oY1zzL6nZg1rBgRYleF0O3HWHLZMUa1lI7F5zyyU6AUlTJ3owg30uns446xLJWP5ay9nIj3EFSp4yDmsNbVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838903; c=relaxed/simple;
	bh=65PPOdTYg+rCyXRTzfa/IqbhNnApwDCYv4+FjwnqaFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pt2RNKl+GqAyKSBGgWeiOMGhviE+Ht9hXjwBr2awYFPKOJVOXqTPsSL/o/yzOTyOoYSDAWcIRJKc9Q5/yZ0BgFLWAQU7uHZuSwDYRYKAs3aue+HwXeTKttV9mJAYeQrqBMLEYXkePzz42G9zP4KO8kKId0cdrUe17adX3dtogPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TGILIuAE; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qR3zQPI6ZxLHoq+PgyVZGsDCmBLgVBSE/VhF6suqcCswV0Ps22MUhPBzcqF4jQlBVqSn9Z1t+AxukPlNPNTMjefQRYVBrsMHl7QxyLK6JNJzt1Hw4c9AlJRctYNVyqXi3D3gbDt+c04p3kPjDX9yFhz7soJ+9RdmiPgYwUplq+z1WEFtnyeHYfOjBoS6jaxf2fTnF5GLEKjLOtLs1OoZbLcelUiIrUZta9JW9+62GLcF22wIBdt8S2GktN38OwwFHvr291l6hm2kTV33TQZ/0h0KQiwZiDxPCvFy5vFlzqbW6OzibUK6BGzr6s5hC8TrIFENijZO3/y4KWmmzAEEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PWlajqaiB/vFlMiroWpQ69Au6RRDckpnFzWuXBINmA=;
 b=g+fQ8IPAmLol8IJnJCioUP6RO2+1ZjgxR5amm4okDzkT8M1DnL05WV+gSfkpt1eyi/FjbTwEFC10jPz8QVQ+emTvhV7CqbAHvEPWVAcQ1gjHW6ScdfKBpyjTJlqlVhI25JDw6SV9z+4vu0VEdbUkZVkOo/1GHzrKxSxOyYMXM2QBWAOlUuvKmt7UpYZ1Y1hhEIirn8/c7wS0X5g9J6LKgGBf7GVKKL1nJhq2lt/EEm6xhD9kmL0ebsDIH/tJKN1pnpK+juhTVqvs73IMuaCEKHdPGeZs+FytsmrwMJZ+TlAcrE/e6qTkuOPLWFz6a8N6Cqld60D64O2oxlSDZf71AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PWlajqaiB/vFlMiroWpQ69Au6RRDckpnFzWuXBINmA=;
 b=TGILIuAEZWQC3dCPA98Rpfltl8NLSTxa7lXhPdPyApICye7RfYjFq0AL5q/gMuRaDUrLqScjcBxn2KT0V+RIqgtYnRw2SyXYjdpBxg7e4oe9tIn5wt0ZPEkTYwMI56h/WnOZZvgsxJyR50wSh9PlgGIEf/5T0iz7WckfFISACpu0lBuPUXUtJGLvLoVBQDdwZSJeQUw4go6HidS84X2BxaTfSAndoiQbIrq8SDMusPLbIJzwl8tXHxYc26uxNBCf+IcfFw5Qg/xrAm89Zx4JVjzqke0jrm0WTqNupSt185Uy1aGomoSoY3kZv3zG4+HJDRUD+i+d+bfvalb3MMkc0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 22:21:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 22:21:36 +0000
Date: Thu, 25 Sep 2025 18:21:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: stefan.prisacariu@prevas.dk
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl: make VAR-SOM SoM SoC-agnostic
Message-ID: <aNXAaewv/MpqL78M@lizhi-Precision-Tower-5810>
References: <20250925104942.4148376-1-stefan.prisacariu@prevas.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925104942.4148376-1-stefan.prisacariu@prevas.dk>
X-ClientProxiedBy: SJ0PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7933e966-f9b3-4311-d73e-08ddfc81e431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fXEWFtmuCjoAeYrDJOI9HTw+1DtS45iDFg7gCyefRCqeeW4SxwFB+rK6cKwc?=
 =?us-ascii?Q?NOozMRxtDPhV070eyW9v6r8r0aLmhx0E6VxuGXuEer/Ev+bHfEbsOtFrOLjB?=
 =?us-ascii?Q?urap483HygMdzDL8k51EsSvlYkCWECQYv7z4/QW23LdC/t6KWQ7qtfqZw80B?=
 =?us-ascii?Q?e8pLrvHKzk/JS02ge74MwxukAbEaw6GGPYaHmXMuTprTbvUZwDT8s7OBLI97?=
 =?us-ascii?Q?aW36X0MsPDB3wHTyyLCeq3eF2B7lGT1z7sqYr5yqrcRKAlFK+fvSsTkM4g9J?=
 =?us-ascii?Q?l3pFZLA22sBsohIWRSRjPIZYAt/wFjn5g2OYvx0a1fDzmgps6wBjYVNAIclO?=
 =?us-ascii?Q?SzbMnb+NdS+XH011sA12MIQqLSutk755hL+QEd5eo+RkEI6/VhkgxExDyFjy?=
 =?us-ascii?Q?4F4xN8H5TxfghPZFWHBphBU5gciCXoJkKH31r7YEtwrkbRS5RDUy/wsUqMdU?=
 =?us-ascii?Q?a8oYcitwTRo80+hUnl8I2opXK+QP/EfXCVRYcqJ1GTpHd425s9osoL6ZWVjr?=
 =?us-ascii?Q?c40DrNegkTJL7IgMpxe9ks3hQbJlvZlWifwWTKH2t4uLMqAUzO9HOfzwNrYE?=
 =?us-ascii?Q?kwmg+j/1FKq72ABxZXnqtZ+ZXrmWx+VTAvMFx9nXnWJhDlh6fVHeIAzxBas0?=
 =?us-ascii?Q?nP8Jb66ZpoIBG2YTxO2vP74VlO4S4cOnWQOXoTq+gR1HQUa5jcWdP1fNZ2jQ?=
 =?us-ascii?Q?S0nlUi3xFwES7pLHi/2zC3aeKxfgEyOrWHcu/9rjQ3N6hVx9s7iiNn15kPnp?=
 =?us-ascii?Q?at/y/w9GxYN8S+AohzrmO1ErIQUZeFH5mSgAzrfTnaoqjFIcGG854ME6l2w8?=
 =?us-ascii?Q?8uyUTg//JS7WG4aqowSXXli9P+DnJUBFJJ791FLp7YcfVVDUd0Ksth/QWnJT?=
 =?us-ascii?Q?endew9f3v6117xO4YKDZBiQsJ6SCBkjBMudx7jBDwOMq68DQjT0foa/AG1MH?=
 =?us-ascii?Q?5wwSQxtq6R+PLuLObdOjIts23wKGOzx8JvIjNeIzkBNmTolgAE+wusOXlO3O?=
 =?us-ascii?Q?xQJ4iKG5qcpBI4bsSAVGLOBkHOJeTWabKNVHE4c4CJTPr6Ia8bI+narSmtCW?=
 =?us-ascii?Q?Agv+3UkHu0DZK/5Vd7TE6vN542WEyvD+0p1XiJMTq86boK3zfYLL/yd82WlC?=
 =?us-ascii?Q?pDo/OrTZi/CLeAYhuGv+zRpSAIBmmEyv2be78p9DVIw0Ujee9An5ScrIY8ZS?=
 =?us-ascii?Q?+p/Tb+moeZfZ/lT/+Bm5x0NsMDt/fp9dQY/ibXHF1TxgppoGl5EifwoIblpx?=
 =?us-ascii?Q?A5ArtCnsd0WHPoI744dmIWCaGj1p5V7tGHDYYEIstKi0oLXCOltnGD0xvDjm?=
 =?us-ascii?Q?rNMU0bQ45lioHgiEHfjETvRMhwKFgyoJzHL8tler+gUSjEmrBW/EtYAu7icQ?=
 =?us-ascii?Q?azmQk04Gr0qyqMXWef6LhHQFdjQotpLPeuGQQd19UbH+PzKLtIr9yR1+AQHs?=
 =?us-ascii?Q?mzRleU56lmrSRP7SBh/E5PmxqvALPYubNxu+RVGtJohbgvU083Wcat+vPcKl?=
 =?us-ascii?Q?QKUOqGjOeFhuk+SXRiCR9Im1lWZw6kdSphS6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DSj35pNsny5wIof7JXK5KVEake4DT68yPhlFJjINdh1zzZSu8m6PeaLuv3g1?=
 =?us-ascii?Q?oJj98a+THhZRKa+lH7NCfThSglIcNNJwgJ7lo+b3PSdDchely7iCJrlReILB?=
 =?us-ascii?Q?h7O68UlaAtuxc3Ir/DuXCrD8LHgvRhgmA0k7Q/tgRDRKbXjrE4KUHHKzdzU9?=
 =?us-ascii?Q?aXmqOgBLSSfZLvOvB7qO7fC+gRbXmswoEeDO4ktqlWHThwnHe1kr84th5xHA?=
 =?us-ascii?Q?2ydN+ttP+BS4eMZ2ngAmRbVc6TnJfxDZvwwb06kuDtMByMjC/wg/kERrp8Ty?=
 =?us-ascii?Q?kPXwi9t96nLHgSZYT+hFhlrgN0EV6v3Qms4trjAbCr0Qa9ogU5dQlxnHahJu?=
 =?us-ascii?Q?fND5MWbKSwXEpEOnHK9FQLfIOml3a5wdeVKRP1iNDO8qvqNhzWgh6ZPYikgn?=
 =?us-ascii?Q?T0r5aWISMyoJTdE6AjBeUL9/J14bvGpMXQ8SvrR4riQbsMnqS6jNqC08cRGE?=
 =?us-ascii?Q?fd+Jbz6aABNpeW7MCPWvv9ZwF8N1x5fmbkf6Qjkps23VwacIYbsaP2izBx3o?=
 =?us-ascii?Q?hvIKzCYuhi2QaOoI6ypb/EWgST+e9RncfujQ+8sIOhoiBC/Vxi1qyRQpZhkY?=
 =?us-ascii?Q?dS1uj4BaDO9ATAbeFBPB1SiZTyp+fDJy28iPcqD8IAELVXD7YxJyQd+f8PDm?=
 =?us-ascii?Q?lPR3ODCGb0+jjuchI4dBgtmjJcwsXxzLxqf2rwltgpDS4ERu+/vHxVZHwmv4?=
 =?us-ascii?Q?opbDmv4uq6U5whA/GkR1LXvpBhMIYXXBMvjTVszzgv19r8CuO7R3timWIKrR?=
 =?us-ascii?Q?WQxb7LOvpu+Tv8J+kjo//YdnaPfDs7JSzhbKzTtSvaJqU7BgAe6cNJtYo3MN?=
 =?us-ascii?Q?Y7fpe6yS/mzMzz/ZaAJEiRvF/cSm177ohk/CD8hTiRUihzKtGjz+KatOpZN0?=
 =?us-ascii?Q?1VkL0DFeMHFoOqdIIclLqHEBPRT08+4+mI/1+LlsRT5wMzgJRlOGAz+rhL2a?=
 =?us-ascii?Q?0Ry/46eZol8VuBGcL6zKtZSuRwh09Cv0vaEg0hxu5VTkNoRlnV99thAjHb2j?=
 =?us-ascii?Q?T/rsECFttlmwceYpKYNkpU18hot/k5quR7UKpkYn9awiLxqMtXB1gTsgO2Tq?=
 =?us-ascii?Q?fjg66+QXFqgAXtoU5MoiY0cVENX2RZOCfJbW/YjE2L08AW+EDAeReyCswZnj?=
 =?us-ascii?Q?H7FrAuYCmSTAiW/clF58EOOW8ott5EX2fZn3M2HC4CUMstu098m6mlXSoAg6?=
 =?us-ascii?Q?B//B5IQxR414/JqINgDNzK1LrsMQ+KYyOWPx65Q2H2mjkLaSLkNYlz6gz2OD?=
 =?us-ascii?Q?mF1dW3E9eQi0KtvMNwoRABsvu4xfr5KcQL3SO1FV09F4r86x/SNWTP/+Grbm?=
 =?us-ascii?Q?pXpvcok9nsTn7LjwnbvcjqPAf80JCPNgB7KFuuQC91yzM9mwuX9GRR/AQSLt?=
 =?us-ascii?Q?SGfrtWq7PJDWBMWBtm8FIhro6UteW4oVaZ6MwNUl1CW09RPJmlbZNXahgNwj?=
 =?us-ascii?Q?DawhSmcHDD8ysdjPopMJ/xeQRqIxGx2jSvEh2YMiKr+gO1l6frgxHVnb0vP7?=
 =?us-ascii?Q?so1dzM03KFm9U5XzuX90B+mnBsWAqclgy9u3tr5HO8ls/1OK+bG4sDdBokCO?=
 =?us-ascii?Q?PW7COLu0fwMSV1mXfqn+0OLLn/LVG30/lwljbyiL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7933e966-f9b3-4311-d73e-08ddfc81e431
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:21:36.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wohNf7UItvTdeD79BhPUM/d9h0pL7BdkDRT2dE+E36XSY+cWQ+gV/2PnCMguKHfgM5R0YzvNLDyjHyTIbsr5eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039

On Thu, Sep 25, 2025 at 12:49:40PM +0200, stefan.prisacariu@prevas.dk wrote:
> From: Stefan Prisacariu <stefan.prisacariu@prevas.dk>
>
> Make SoM .dtsi SoC-agnostic by moving SoC include to board level
>
> imx6qdl-var-som.dtsi currently includes imx6q.dtsi, which makes this SoM
> description Quad/Dual specific and prevents reuse from i.MX6DL boards.
>
> Move the SoC selection to the board level:
>  - Drop the imx6q.dtsi include from the SoM .dtsi.
>  - Add imx6q.dtsi include to imx6q-var-mx6customboard.dts.

move imx6q.dtsi from imx6qdl-var-som.dtsi to imx6q-var-mx6customboard.dts.

>
> This keeps the SoM .dtsi SoC-agnostic (it already relies on imx6qdl.dtsi
> for family-common parts) and allows boards using the DualLite or Solo to
> include imx6dl.dtsi instead.
>
> Why this is needed:
> I need to reuse imx6qdl-var-som.dtsi for a board based on i.MX6DL
> (VAR-SOM SoM + custom carrier). Without this change, the SoM .dtsi
> forces imx6q.dtsi, which is incorrect for DL and breaks the layering
> model used upstream.

Can use simple words

To reuse imx6qdl-var-som.dtsi on i.MX6DL board.

>
> Verification:
> The DTB for imx6q-var-mx6customboard was rebuilt before and after this
> change. Both the binary DTB and the decompiled DTS
> (via dtc -I dtb -O dts -s) are identical, confirming no functional change
> for the existing board.

Needn't this section (good place for these informaiton is cover letter).

>
> Alignment:
> This also aligns the layering with how it is already done for
> imx6q-var-dt6customboard.dts, where the SoC include is handled at the
> board level.

Needn't this section

>
> No functional changes for imx6q-var-mx6customboard are intended.

good

>
> Files were introduced in:
> commit e5c810848d2a ("ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6
> SoM support")
> commit a5b59a3f41bd ("ARM: dts: imx6q: Add Variscite MX6 Custom board
> support")

Needn't this section.

>
> Signed-off-by: Stefan Prisacariu <stefan.prisacariu@prevas.dk>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts | 1 +
>  arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi         | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
> index 18a620832a2a..a55644529c67 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
> @@ -8,6 +8,7 @@
>
>  /dts-v1/;
>
> +#include "imx6q.dtsi"
>  #include "imx6qdl-var-som.dtsi"
>  #include <dt-bindings/pwm/pwm.h>
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> index 59833e8d11d8..51bcaf04546b 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> @@ -9,9 +9,6 @@
>   * Copyright 2022 Bootlin
>   */
>
> -/dts-v1/;

why drop this line.

Frank
> -
> -#include "imx6q.dtsi"
>  #include <dt-bindings/clock/imx6qdl-clock.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/sound/fsl-imx-audmux.h>
>
> base-commit: 8f5ff9784f3262e6e85c68d86f8b7931827f2983
> --
> 2.49.1
>

