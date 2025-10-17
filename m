Return-Path: <linux-kernel+bounces-858192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A17BE9400
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13BE94E1F34
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BC632E156;
	Fri, 17 Oct 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PTz9tnVz"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C083396EE;
	Fri, 17 Oct 2025 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712134; cv=fail; b=llmNoAo2+QU+aUfzRNHMMUgspPLUATmg1KtTnX34je6CCGV2DkwjI66WJ2Yn81e7fNdrrZWBCchC06z1FGalwtL7SsSjEo/rRpYRcWDerKiimC8jIxIE0xNuMEPuNzOATkjz4ZiJ5oglyug2hXszaLfBbrnZ8gvi/dlPXp+KgjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712134; c=relaxed/simple;
	bh=VEqPQO1PCs5oD/I/oWoxsIJekoStdoUhvUU5MHWgvvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TEPsolzhvpbVYaFQLkmZlzjEeOx3rqZfPL9CWyAlKNxUUoD51EQq4afVF3ImjlYIsmCv+MioZZ3zfFJp9p5fsS+Dg3mkmjcRNBRBzPMoNncs87O2XshT48jhyN1A+rxKJnYtx7RTROzwwT0fDRfpNtNbEk4kx168zqLIq1b1bB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PTz9tnVz; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEq4kk2LCy8O2mFNR2AwAAMvQwxrxqFh0rK/5eRV3CN5Ws3pMAUeq5waYsL5qui4cXLebI2u5XyhtuhYUz7Uvl49ixRXgKicywbXCnSfamUFB5A3TtjPH/d4nGz8QVNsnOGjO1EvQiH1b4RZQ+D8ZtHqmflCcSaUFKwRgP/Vqhg3krjkekXuHfi7Bcq1QuW4nRJ4FkRmjDCUBzLeSogd2IMPKrluZRnz9SiMQAkwUZPpvCKSHCzfNzaBUvcb/ENd6kVXbNhEzuTG7+IOaLf/WPdb1dB7EWBd2zQaG6itBU8WmEX+jnFh2UXPd7UIrT/QMYE0Yf2jPy6JLA2bN27Rog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdTbljZyM6bUUzUNsQtwpIxMKm9votaUdNV6jyXxd58=;
 b=ZXbKI/HNAlwXu8RBWVfSYMclOyPx0hTp9BhJkfJLZBiBWGcLN9m2y+mz5yaIFyWtE68a9dTiwtSRVJrnvuBHKQk+FPf5mOw55rWEt/W2zw8CI509xZnpfU7Lm51STN3RXCSQVjOWvk7o46rbjYRDRw8IDcRUkhegdoMVmn5OpBmeoauJ30GgE0aLicnokTOlhTxLXH6mrVyLE8Sia/xmF5PAo84xHQxi3Jq+lUr70vQiYmIooEoZ6+Pk/1IzrmX3tbG25t4aS34ONf3TtvPL4YDnikPvbyXRT1FDW97VNsTm6B6AQbKtFfIiPltYUHM8+FNh/bDrnGj/O11Cf4XZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdTbljZyM6bUUzUNsQtwpIxMKm9votaUdNV6jyXxd58=;
 b=PTz9tnVz+SIxTzCeIbaRmrOgSe+I8+r3qcLOb3bmg1AeYW3+jRja/PYM4kdJ69vgE4Yxk9p1a+SzTm627iI4Fl0WtYmSwxsLSbqPSZfpQz1YjTvU+yqkVbarI4Wdp07siB1sj87YmwtRgv09bf4Ne7h37mbaqq3gd8Mm4VnwFI+VXLN5x7O0uegIrNifaOghWCQrxnNTjGVKg80/zR9GD2ywmgipEPmmhRf8Hk5hGgHS7Vx5Yt5YD7HlWcskoLd0r3Rv1AJoCNPScce37xmWE130t4FJa0pmuYYgAMnL5JQ5Knpr8QTwrVKJbo6PZ5oqE/SmTLH1Tjy29JrE1avRhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 14:42:08 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 14:42:07 +0000
Date: Fri, 17 Oct 2025 10:41:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
Message-ID: <aPJVtzVyTYAhIFGp@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-4-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017112025.11997-4-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: PH7P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 370e33ce-4c82-4eec-7558-08de0d8b58e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NBKTbdj/C6rhk24M/1XCmGYDtAsNPC0lHFYEV7jUDG5okwHOHwX0EX9HprIk?=
 =?us-ascii?Q?5t/bfFfVqqOZyZKVO62VBbt910k/utBVkSVh4foRdbiNwf6Wx0RWUSn+Gsm9?=
 =?us-ascii?Q?xXIo0UOBVKHavxCoS918DBG3nJm+XoemOf4OyA9c+vY8OhDixQbAERaabfL5?=
 =?us-ascii?Q?Hcryz13HZN8RswYq6SWFQd7XW83nlsavmDfdGkI/jcVTK0uc8TfM2yL9x2Pb?=
 =?us-ascii?Q?b8dhzEQ0dFkQd+ZSKOT8azaCuKUW2LKK4rW7sXlGgyO4eVrwfEDIDcT5zjmI?=
 =?us-ascii?Q?C1mnnRGHR0Nnrmekzxc1/XC/Hn53WcWIuChjkG3pKIsKtTkgp8BFJ6plBTmX?=
 =?us-ascii?Q?VzmgC1RucSJA9+izPOrZ/CfmK+yyGxqVmOHgAGpBlq/vZ/dlt5oskZOhQZjX?=
 =?us-ascii?Q?bgrHLoUZ0u6ArBQAl0VFe3jKaHVl5Qa1a//u6Mdo3QpnfckvmAzZfyzuYszH?=
 =?us-ascii?Q?KZenZ818D+BylSw6ROV2k3rkqeDPu0eOrbzkrfpZysf3p1rwIUjUw9X3HSQQ?=
 =?us-ascii?Q?7pT3Rjk67QsuAL/uw7lVmj1Ljz1bMqnVvv2SO7IDJ3rceXf0VmD4yCki3J7T?=
 =?us-ascii?Q?+9l13MYrk787GnGlotxgUYHgHRjHBxp0Hmr/N6Pag1LSjL1jNed8gJqlI7Hr?=
 =?us-ascii?Q?39pNxtMsK8/SIEDP6BgKgT7Ztd0V0w83u2vwF4D/FHuej6b62CYxNgglC4Cf?=
 =?us-ascii?Q?iQQEeQC8ehnbnd8QTJpkD401RjvP+Fu5phQ8D0W/rR3iJvm+7eK7vlufLC4a?=
 =?us-ascii?Q?yT2BI5WHTVZxbYJpo3H7nH3pYFTlSvC6r56Mi1RJn6Klpffcj+qlZoOKqK12?=
 =?us-ascii?Q?FN/KDZaTCSaTq48A+T4QVsW46fypAkVrQglvGiJOESi9/HkZjVAhg+zY3rU3?=
 =?us-ascii?Q?vY4TMMLMtA1ypZ4ikVqjzZEvz4qHzOlljcvMMlkB5L1hBXsK1nDVB7OYyV42?=
 =?us-ascii?Q?2sh3nRPogOqktobrSl7vNCtty+9lEBCwh03fXRTZiJCMgyIJX3bMcTpOMmhQ?=
 =?us-ascii?Q?9+VwmapMdr5IscVO/H1VQiFjhEjE9v2Pu91UbhyVwVRt9g7nq7bm2hdyDIEs?=
 =?us-ascii?Q?wbq/pkr0ykV2m4ZSTVSV1OfsbSrLei0o/DrHLu+7QrKdnjhT/LwY1X1QWxoa?=
 =?us-ascii?Q?fEwh6OP6uhswBU0wwSGOWQWuiQjRt/9gsgrspjuAO7ZR3YSVqngOVq5DRNwv?=
 =?us-ascii?Q?mDUrKnHb7XhlUc06UXbXrG49uHHlBJOIItXO00WWTwKGtYxVRExLKgFZZEbp?=
 =?us-ascii?Q?2d9Xi7su8v79YklEY0XveubPNj+VYoNvrwcnhXLKD1+Vij9IGaAsWlBlUPeK?=
 =?us-ascii?Q?U+brCHXXyAwIhIjLOBow4rs9qkgitOVhduFuDtBSAed9pxq2sAbZtuAmfSWH?=
 =?us-ascii?Q?Iapn/8opo9Vi9PJmapemmxu6h9N2b8JXYHqIZiQBNwulgVkCxMRdrJZYBusu?=
 =?us-ascii?Q?GSY47G0+jOuVQ9aUAtL716eLqIC8hI95aiHuGiw/cug5ay1MiQW3XxKGJcZE?=
 =?us-ascii?Q?LpNoMeyyCsNIm+LjLBz6d0eJsmy7Xaynx8J2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k77K3pfnbpN+zTpEs4J41nA+NvMsXsTTL6+VCrSKfoxlrYYgMC0/Axh0gZYF?=
 =?us-ascii?Q?6OJm84PbG3EHw+7hVMGL2xYdAa5ISxWIJgA9uj8+OE4XwysXO2hqhCkCpAIW?=
 =?us-ascii?Q?T3gExa8pmgEJQ3DHqSNJ1b70zKKI9IFQjAVuFb6DkGbjcV93kWrBX42Uisun?=
 =?us-ascii?Q?wlB0af1NOXQfAZxiqEcnflPfuOLK8hkYyjfeq1uBPC+ukSW9s1Ll1q4rGvSj?=
 =?us-ascii?Q?d1JTrJQf7jRxtnepDpbtbZSrm09PnxMCgbO5Qb6PvcFZw8BIsC1zuDY0MUYm?=
 =?us-ascii?Q?bvhngd20aeT410neLxETxl9GNTHljxIlcAnJQlw8CnG8yP8uRBaMrEemqHgu?=
 =?us-ascii?Q?NH0FYRRbMYHGHhyg/ggE8gA2KXosSPznZ5GeGkEruzEIuYO2hO/fzP6Prt3M?=
 =?us-ascii?Q?YUZYcpI+z60grSRFXpVsDudRGFNc24lOl29NmDjySvOd9qa/YzR4MmoYiVMo?=
 =?us-ascii?Q?LeY6ItwhklR8uJQPVlg24Sy1Yz5dewgPciZX5BBCRqsF5VN90F/25saE7Er1?=
 =?us-ascii?Q?WUZ4UUtqnUk3gs8Ho4apX+wveD667BbXsisc0apnL8A7VW9IL1fRYBk0NOHl?=
 =?us-ascii?Q?y5iHP4wKI7jCxqWM59LPKLxg/qldMLoRlR7WvBYNFHVL+3VKKXQWiBvaFbjE?=
 =?us-ascii?Q?Q3Wgi8//xyd4EsvT4yTcaMXsX3oUy+oD4WTaVOo+k47CWRLWbr02CSSZVCfM?=
 =?us-ascii?Q?iVq9qhMU3VN4ucOcdQXQI10nEaY9ScHMpFKH8cj0tOZ/cXcF0a1/YQYWnN5D?=
 =?us-ascii?Q?ePrVNymfiIJUpnp/9xe9vtXKDFl0fu+vGsgXD6Ym6pa/TJ4fcfP23QtcMNQE?=
 =?us-ascii?Q?n5/CPm2LSRCYHtEXVWFVtR1kZqdDpxCn5okaXd2lv/75N6ScnezRsnqxClxs?=
 =?us-ascii?Q?StUH4jId9yyzlpDgBZxJJp5AsPXI/QnQNvNVfA9ghKTbyfdx9Rgz423agzkJ?=
 =?us-ascii?Q?OjkPTl3PhsPu7UduvVllbGIJEmFgTGk3816NKh8gp65qRN+GMKMG01JSEC6g?=
 =?us-ascii?Q?nNrxf37+rwgc3t0muo/RbTxXLJaFKCVlKR48HX1CF4TCWPslZY+Kx7qnnMVH?=
 =?us-ascii?Q?dI9EJKdAQmF7a1qgMuKpKIpnzRBufPpNgtlTBEml2q+nTTgYsFWXum/9UDuK?=
 =?us-ascii?Q?jl7Bpm4nWGz8wbUcD4CyjH0oFU/k+ZvO5Mb9vdq/h7Ks9glljLwgTyF79lmG?=
 =?us-ascii?Q?1ynb70AIhdn4HlOTaJpz6FrqV+jTazHIO4JG23Jac8+1ctwLvF75b+zr3nEI?=
 =?us-ascii?Q?3SswEG7trDG7w5pslax15zc4wENCz7A2MVDqVlNYBFNSmdZSD4fTnN/Gamzd?=
 =?us-ascii?Q?fsY2H+9amH0/zSNsXF89jD6jjJb9b/3E6k0BUX8xolAPFB7Nn7UTKf0BU4kk?=
 =?us-ascii?Q?jyNBeUwoh/AIMPdQOE6DADbkFsNO+apRJAthjWIbwPEa6Opx6ysqu4s9GYjz?=
 =?us-ascii?Q?Knf6pTWYZYDVwzwIC6Ats4vcYLtQ5Q9xYzyl7xxmDKJ+ErXTKH7/LmySRGR+?=
 =?us-ascii?Q?rnfxk14GTzTmQBb+1efb6U+7vlCKM+/TJSYFL5x51XhzXBNNMgMvf14+sR31?=
 =?us-ascii?Q?3IVN0oBDv3aNkbPxYg61K4w6wmqL92lGi2zne4zC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370e33ce-4c82-4eec-7558-08de0d8b58e1
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:42:07.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5yOaGVuI8XrJeTV99/jIj+TyOD6ACM+el1PSUeclwnu/ripik5zYkNAI7FuKz32/F7HegNNPQ6OPWgasgZhsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885

On Fri, Oct 17, 2025 at 04:20:20AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> The i.MX8ULP System Integration Module (SIM) LPAV module is a block
> control module found inside the LPAV subsystem, which offers some clock
> gating options and reset line assertion/de-assertion capabilities.
>
> Therefore, the clock gate management is supported by registering the
> module's driver as a clock provider, while the reset capabilities are
> managed via the auxiliary device API to allow the DT node to act as a
> reset and clock provider.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/clk/imx/Makefile               |   1 +
>  drivers/clk/imx/clk-imx8ulp-sim-lpav.c | 211 +++++++++++++++++++++++++
>  2 files changed, 212 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imx8ulp-sim-lpav.c
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 03f2b2a1ab63..208b46873a18 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -41,6 +41,7 @@ clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
>  clk-imx-acm-$(CONFIG_CLK_IMX8QXP) = clk-imx8-acm.o
>
>  obj-$(CONFIG_CLK_IMX8ULP) += clk-imx8ulp.o
> +obj-$(CONFIG_CLK_IMX8ULP) += clk-imx8ulp-sim-lpav.o
>
>  obj-$(CONFIG_CLK_IMX1)   += clk-imx1.o
>  obj-$(CONFIG_CLK_IMX25)  += clk-imx25.o
> diff --git a/drivers/clk/imx/clk-imx8ulp-sim-lpav.c b/drivers/clk/imx/clk-imx8ulp-sim-lpav.c
> new file mode 100644
> index 000000000000..a67a0e50e1ce
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx8ulp-sim-lpav.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <dt-bindings/clock/imx8ulp-clock.h>
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define SYSCTRL0 0x8
> +
> +#define IMX8ULP_HIFI_CLK_GATE(gname, cname, pname, bidx)	\
> +	{							\
> +		.name = gname "_cg",				\
> +		.id = IMX8ULP_CLK_SIM_LPAV_HIFI_##cname,	\
> +		.parent = { .fw_name = pname, .name = pname },	\
> +		.bit = bidx,					\
> +	}
> +
> +struct clk_imx8ulp_sim_lpav_data {
> +	void __iomem *base;
> +	struct regmap *regmap;
> +	spinlock_t lock; /* shared by MUX, clock gate and reset */
> +	unsigned long flags; /* for spinlock usage */
> +	struct clk_hw_onecell_data clk_data; /*  keep last */
> +};
> +
> +struct clk_imx8ulp_sim_lpav_gate {
> +	const char *name;
> +	int id;
> +	const struct clk_parent_data parent;
> +	u8 bit;
> +};
> +
> +static struct clk_imx8ulp_sim_lpav_gate gates[] = {
> +	IMX8ULP_HIFI_CLK_GATE("hifi_core", CORE, "hifi_core", 17),
> +	IMX8ULP_HIFI_CLK_GATE("hifi_pbclk", PBCLK, "lpav_bus", 18),
> +	IMX8ULP_HIFI_CLK_GATE("hifi_plat", PLAT, "hifi_plat", 19)
> +};
> +
> +#ifdef CONFIG_RESET_CONTROLLER

Needn't this ifdef because if CONFIG_RESET_CONTROLLER, reset driver will
not probe, just register aux device is not harmful.

> +static void clk_imx8ulp_sim_lpav_aux_reset_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +
> +	kfree(adev);
> +}
> +
> +static void clk_imx8ulp_sim_lpav_unregister_aux_reset(void *data)
> +{
> +	struct auxiliary_device *adev = data;
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}
> +
> +static int clk_imx8ulp_sim_lpav_register_aux_reset(struct platform_device *pdev)
> +{
> +	struct auxiliary_device *adev __free(kfree) = NULL;
> +	int ret;
> +
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->name = "reset";
> +	adev->dev.parent = &pdev->dev;
> +	adev->dev.release = clk_imx8ulp_sim_lpav_aux_reset_release;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize aux dev\n");
> +		return ret;
> +	}
> +
> +	ret = auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		dev_err(&pdev->dev, "failed to add aux dev\n");
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(&pdev->dev,
> +					clk_imx8ulp_sim_lpav_unregister_aux_reset,
> +					no_free_ptr(adev));

use devm_auxiliary_device_create() to simple whole code.

> +}
> +#else
> +static int clk_imx8ulp_sim_lpav_register_aux_reset(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_RESET_CONTROLLER */
> +
> +static void clk_imx8ulp_sim_lpav_lock(void *arg) __acquires(&data->lock)
> +{
> +	struct clk_imx8ulp_sim_lpav_data *data = dev_get_drvdata(arg);
> +
> +	spin_lock_irqsave(&data->lock, data->flags);
> +}
> +
> +static void clk_imx8ulp_sim_lpav_unlock(void *arg) __releases(&data->lock)
> +{
> +	struct clk_imx8ulp_sim_lpav_data *data = dev_get_drvdata(arg);
> +
> +	spin_unlock_irqrestore(&data->lock, data->flags);
> +}
> +
> +static const struct regmap_config clk_imx8ulp_sim_lpav_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.lock = clk_imx8ulp_sim_lpav_lock,
> +	.unlock = clk_imx8ulp_sim_lpav_unlock,

why need lock/unlock here, regmap already have lock to access one register.

Frank
> +};
> +
> +static int clk_imx8ulp_sim_lpav_probe(struct platform_device *pdev)
> +{
> +	struct clk_imx8ulp_sim_lpav_data *data;
> +	struct regmap_config regmap_config;
> +	struct clk_hw *hw;
> +	int i, ret;
> +
> +	data = devm_kzalloc(&pdev->dev,
> +			    struct_size(data, clk_data.hws, ARRAY_SIZE(gates)),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&pdev->dev, data);
> +
> +	memcpy(&regmap_config, &clk_imx8ulp_sim_lpav_regmap_cfg, sizeof(regmap_config));
> +	regmap_config.lock_arg = &pdev->dev;
> +
> +	/*
> +	 * this lock is used directly by the clock gate and indirectly
> +	 * by the reset and mux controller via the regmap API
> +	 */
> +	spin_lock_init(&data->lock);
> +
> +	data->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(data->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->base),
> +				     "failed to ioremap base\n");
> +	/*
> +	 * although the clock gate doesn't use the regmap API to modify the
> +	 * registers, we still need the regmap because of the reset auxiliary
> +	 * driver and the MUX drivers, which use the parent device's regmap
> +	 */
> +	data->regmap = devm_regmap_init_mmio(&pdev->dev, data->base, &regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->regmap),
> +				     "failed to initialize regmap\n");
> +
> +	data->clk_data.num = ARRAY_SIZE(gates);
> +
> +	for (i = 0; i < ARRAY_SIZE(gates); i++) {
> +		hw = devm_clk_hw_register_gate_parent_data(&pdev->dev,
> +							   gates[i].name,
> +							   &gates[i].parent,
> +							   CLK_SET_RATE_PARENT,
> +							   data->base + SYSCTRL0,
> +							   gates[i].bit,
> +							   0x0, &data->lock);
> +		if (IS_ERR(hw))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(hw),
> +					     "failed to register %s gate\n",
> +					     gates[i].name);
> +
> +		data->clk_data.hws[i] = hw;
> +	}
> +
> +	ret = clk_imx8ulp_sim_lpav_register_aux_reset(pdev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to register aux reset\n");
> +
> +	ret = devm_of_clk_add_hw_provider(&pdev->dev,
> +					  of_clk_hw_onecell_get,
> +					  &data->clk_data);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to register clk hw provider\n");
> +
> +	/* used to probe MUX child device */
> +	return devm_of_platform_populate(&pdev->dev);
> +}
> +
> +static const struct of_device_id clk_imx8ulp_sim_lpav_of_match[] = {
> +	{ .compatible = "fsl,imx8ulp-sim-lpav" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, clk_imx8ulp_sim_lpav_of_match);
> +
> +static struct platform_driver clk_imx8ulp_sim_lpav_driver = {
> +	.probe = clk_imx8ulp_sim_lpav_probe,
> +	.driver = {
> +		.name = "clk-imx8ulp-sim-lpav",
> +		.of_match_table = clk_imx8ulp_sim_lpav_of_match,
> +	},
> +};
> +module_platform_driver(clk_imx8ulp_sim_lpav_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("i.MX8ULP LPAV System Integration Module (SIM) clock driver");
> +MODULE_AUTHOR("Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>");
> --
> 2.43.0
>

