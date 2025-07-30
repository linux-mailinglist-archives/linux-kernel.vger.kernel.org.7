Return-Path: <linux-kernel+bounces-751038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B9FB1647A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D4B1888C53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876FB2DD61E;
	Wed, 30 Jul 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L59ercd4"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3BC18DB24;
	Wed, 30 Jul 2025 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892281; cv=fail; b=GiPSyPSkzEBlUKo2Ue+kaaTze9bvuBMne1KiYebr21ATFJ/0okHC348AQ5JyypcBWO1QuS6bHsC0P88BKQLP1XW8aZ4qm/2hWnDJKlQ4tB+YN+guVfUCTGMdt6RGBVrq91sTkRycatUS9RL3mJPHmdXhOLyRxD6LcmUOcWbOs/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892281; c=relaxed/simple;
	bh=/6q4hJ6XP+qHPZlwOFCLNHVYYGdRXDY+7aiGDH9WnoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MmwZh/Zdr5jw7pW8jrmAHBlPM4mVRapVjVxnYpUi3Nqqx7UFyGigKheSVfhbKR6NjcbfUjakaTweHzRomxidsCC2gBe8WhrFunu46qt/cksKMMsL8/olknMSEGzeOVo6hC4uji1ihGdzvg2Lzng0j4IpXtVgfsLrBrt6iWRu1dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L59ercd4; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xC3W/2qUMAedtIsF0bLZKLVe7FyytF+AAnoOfiks2zvEAk+jdHjHjP9isEsMgpgP24lyJBYn24zVW5CIE6xZ4G/Bf4WBUkSL+XM7poePbJ0xRGazN3z/yaVEgj/CN8fcoKyfhzvyGh96NhTElOeuKDVCUawH+7f+jLGs4Q6asxvjVHdrVhHMvdi6u2uWDsXQpIbzam2PxyCPlIh2xh+Ocsq1JSREr0/Q62KhR9p7Gr/oB1Kt8X91wK3KnYDtceiX/9zwT4pPS31HTCJtUqXXtHxIN7JbtRPd95+sblkJ14NaVP+tigAWBCxyzQ7On+GY31aiaaI4usO6vLpePXEiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpaYBNfI2D1LsSYfjmaFKmpXg/k/3ym8x+tmmN5WlIg=;
 b=aQjoNOGDjgYL4SudNjKiH4+IABlrPHBYjZVCUq9cHhTX8p3spFdjDoAa9OnYl63VaiyWC8nit4PBaUBTryxn9uB7CJFoeH2xoisKxjbt/l2GCDVR47QmWpEuhSyVRNlVKJ9DgSBPFKtat6H6KwG/pqzXyTe5zgbUrDyWViM7t2WQ5ISp3VTMZVdGJgOzdQSTrk8CMVN2hGppuHoreBYc3BoH9C/jcWM6rweV3xZc2YugLD7va4NbupQguS2h+ETxDWpiV93fJ/zfXtfI6sn8EWAUk/1Tp6pVpo82L5gJnnUp0nSWTTLKPl+/uIpLlBsQ3hXn6sqZbhrpoAIi7xxaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpaYBNfI2D1LsSYfjmaFKmpXg/k/3ym8x+tmmN5WlIg=;
 b=L59ercd4zn3iw68oa8ubrmydGcXp77kPs00VwZZVRA61v/hPxMDJiIMm57VapcLwICD+jjuCgHKvHcaTa/8kqaIzpKb+XUwkwhNV6ErDkY5dqZi1GsoGdYqMYAlzZ310JxsTT4j7jGB8sZSOtrZT5+fVY/Iwmz0PbjaNpPX00rdOq7xpE2QiSZLSdFuhM/BKXTUh8jF8Vn2h68YWSvRUVZP6YBYwUKT0TQR8eSUeGpoYwjl+A2v2lewT/n4ACTclXqgg64dqmO4QDWD7yuuzGRFz5N386LOJYwFBFvD5JeXT0E9XI3mJySNbnDc/WYuJoFlIJQPWGDPAOLUsRPZGbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 16:17:55 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 16:17:55 +0000
Date: Wed, 30 Jul 2025 12:17:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: imx95-blk-ctl: Save platform data in
 imx95_blk_ctl structure
Message-ID: <aIpFqB21VWlLgHVy@lizhi-Precision-Tower-5810>
References: <20250730125932.357379-1-laurentiu.palcu@oss.nxp.com>
 <20250730125932.357379-2-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730125932.357379-2-laurentiu.palcu@oss.nxp.com>
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 9130cbc3-f811-4930-36cc-08ddcf84a3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|19092799006|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bwb3os82+nF+jyJKttga2w7jV/E1brzgITGScA18ncuSVNUExfyKYoGlEyEf?=
 =?us-ascii?Q?LdnHhLcZmsRaEIltreih8UyGoJRmNVn5sjlZJ3Gnnkd6TAqzogspIXLQBbgY?=
 =?us-ascii?Q?px7Ue1bByGWBYKhqoyg+JK6XepHgXQRUvp3adhQnwct6GFP2TSTNfS7gK7Le?=
 =?us-ascii?Q?Vb1HQwiRUoI/lSVBP+zMGEMATsSZIByhwS8Ndk8nZxhIa6s/aK/C3FEo8R8o?=
 =?us-ascii?Q?UwQMOlqPgNSZzbTnJbzGutt5KGg6dv9F9B8T1aFbFVklbU+FePrmTgdmSxat?=
 =?us-ascii?Q?evjgIzWeJNf8oOao4HTAeBuGvUKeTUTV6xAiO0sAhGfNC4pNtjzR9aYo7aw6?=
 =?us-ascii?Q?gfOTCEO36v85dYyIk24KQmWb2+WHoRk9TJIJgFXQMANbvUHH/kJ/1nnVeOM0?=
 =?us-ascii?Q?iJEFRR2APGsXKYmnP39Thfpo/oekiDK7d9jZwOhVm+7q/B8kVXFo9T1wvaEG?=
 =?us-ascii?Q?s2mr1Gs/tAoP1cc9mzXfUHiCaEtMEt01KVvaDiY+qipl61KZq2suk6gbYehX?=
 =?us-ascii?Q?n633BqmUSQAHLwTYCWdogSV+zjTXH6GtqQ1ps9ooHQh+byPLbYYik3C0AeSb?=
 =?us-ascii?Q?QiHWHaa2b1QueA5C/akc8pGEicvHBgmX1+1Pf0+gcOHzpuiv577+L+OtbV2F?=
 =?us-ascii?Q?y6uTRl0QKIKFPi6aFpTsQYS5ANJ1JKwpwjn+D/nnMhbt9CEynBW89/YwnB2G?=
 =?us-ascii?Q?IjY8EkRC4Q48BLsxHBQ4AVHzVwfjvC48xfpj8c6Bglf8zKWbvkVTWYp0AQHC?=
 =?us-ascii?Q?pw9HcXdVnXUiDf10OUHANc0B0j7KUcqb3gwkgt10UXDtMKhArtTmlUXbP7HN?=
 =?us-ascii?Q?EZKdcbHQwzfEKZ8A+AK5GrmiOJWN4rvYtNL6w7hEURdYaR+YYaHyPwx1EA0A?=
 =?us-ascii?Q?xvHPMv3NAHN0Pt42Qtl4cAaGU2uMkp5tp+cErSruuEbY8zehMsg1uIMdy4jv?=
 =?us-ascii?Q?7U836Us7FqdrNfJHXYfIWT8doS6go0cGxKV9MofH8gLuPgXXWTHSCf6PfN4+?=
 =?us-ascii?Q?6jM/dLVYMubM4bz5xOm/UPvgvUUVaKco02KA5Zy7yQYrN0Tx3oF7ZMpxZZZv?=
 =?us-ascii?Q?PgO2g5PPy1wkCxzFI/AdIJ33w7vut4jPF7gRTaJWkpEfQdaGaUOseZjuB1Ky?=
 =?us-ascii?Q?JR1VgRFTU0qwJeAvx/7t0NSLww2P5W/Wxa4TSCSbqZzgfpQpf6ORd4y8FvJq?=
 =?us-ascii?Q?dwL1a9cEMr37Oop0gHZeYxa4xPN2RMN0CjNy7+iwXYyi0Eywi0kb81opCnrn?=
 =?us-ascii?Q?E6KhtBDL3oDLkv1Au/lY3d24QZrsTXkN96OvPAiT9fBT5XvefVdLOgGHlgCr?=
 =?us-ascii?Q?31xXH82jkrfWxZbjT3I9QzNWr15VFyxXrVZ+fUktIzpp8G2Ct6S5FJqC8nE+?=
 =?us-ascii?Q?QPw349qOml/AJ/nFrLOJ3jEmfGzAj1KKXa77ZOln86lwhzTyQXf2DwdnJa/7?=
 =?us-ascii?Q?tf9YIsX//yvqsrz5ML/wxtaP+iLuVRNgcujP+/1KpNe7+0J2RIGHzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(19092799006)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRe/yztC5b5pnEwZy14u44ZqLNRcVt+xM+smwEzys0vlCnJ5Vei90R10MJEs?=
 =?us-ascii?Q?eF78qv27cKs48Wx4Sl4oShn1UGpxr3BxSoWKHaKJGWlamO4hZwLnGOsmaIJZ?=
 =?us-ascii?Q?cXmX0jBJN+AT/dEXNvk1UkKGRqHuKi/VzJ+Szh2aCKJrGFWVxRiU9cCHi0O7?=
 =?us-ascii?Q?arwBNGcQwajPGqVfKRpu9k4y1l0bCB4BmJsvOGwMYBogBdhMa1pazJyKeSjp?=
 =?us-ascii?Q?nrhfUV7wbT5Yo9x15FDP3B96NlH6QKRaa0TB+EJ0grM9fSjocYi2ZQb6GIY5?=
 =?us-ascii?Q?JiFVO3GfiEhyJPbCztESQ4SVsacypDzVdqzoNCCZJOfBs+7xHR6++2qKU7nQ?=
 =?us-ascii?Q?hSxDMYNynbw6rdHv87WJgup6Bzor+I4x/Jz2BIfWz/QSaG3PaCUe6W+o/6o3?=
 =?us-ascii?Q?dvfSBWvpyfTd+eg4nAlF/4OuUz2eS0EwbJBwuHnUGwcVD0noUdOuWCt7+OuO?=
 =?us-ascii?Q?ddRQGTSozoxPB3RdkrOrauFS/TnzPKImk8zVVJWPW3pdkRIV2WM8fUmdvSnH?=
 =?us-ascii?Q?ohGf7ioXB/iMmMtgtq/HA5Tm82Md+A64GR+0BsO7nXan6cycp/bBewosshKR?=
 =?us-ascii?Q?zw/58cLc49DDGG2e7XV3EATPBfDZQVXn86ljjZb1zvK4xG4sS+Qesvvf+LcG?=
 =?us-ascii?Q?/Jj5A4ztzbcaL09wFhlfB6TaFKCFcO/x5q/lRtNCNLVcWMNJU2m39YMKFvaf?=
 =?us-ascii?Q?W2OSUfYJWKs1PLitCVrA4qgWdn5Q8rqat+CE8rKXDv8JiJUPbI4tre7WdDs5?=
 =?us-ascii?Q?NZM3umqBMugtqu23Yn2Z63Cnc9M9hH03lABozmxojztD7J1jUavn87/YZdL4?=
 =?us-ascii?Q?1hiNpr076R3j6BGocsF5jvbtizdM1ZEF9BWvxGAkiJ8eNdF9J3uyvhiNHqwE?=
 =?us-ascii?Q?ID420w+68Q96OHv22qrWXrYJcFKm5uB6O+hpFXVxz+DxQdQjZZGWi2qCAfOi?=
 =?us-ascii?Q?fU1vNGeDuQGlg9dv/8I3RUMboiroK22za2ueuK6kcLQ9VJj4WD7YPvx/7QEh?=
 =?us-ascii?Q?VD1Ks7FW6giPzFr4iYVbBCiUIwa1EXFttAvbHaKbAvTBpY/iLrXGqwfw3Xuj?=
 =?us-ascii?Q?XH5Oqo9WOeT1Z3x71i5xvrzYqr9BXHBnIWHPF6BjE9iIjbptd2/JXerPz5WZ?=
 =?us-ascii?Q?DIbNHNsWDH5WjDTW6o/sa8cfRPMs9TscegOO5gAvCU7a9BSHhCkxjVKgXVg9?=
 =?us-ascii?Q?6nVQqvmS5G3LhN716mdfs5cgJq1I+OmSBtiJweS81778BHLzE5cgxmxAOxRY?=
 =?us-ascii?Q?O4rB9BUxRAplnQuMXzx0W4j5JjXt+yJhkashl3SCwV+Tjjzp4HtizFpZyLno?=
 =?us-ascii?Q?WKkdqf8jebsazTnwdVh7Y5ahgiyPFLL7iqDqSRNVNKxaTULR32XPRc/ETbFc?=
 =?us-ascii?Q?/V7Wt2RgTDwE4o70cZrQ36G3hiof4HR3oVVw7fLn9KogD7m74IN4nVnCWG/E?=
 =?us-ascii?Q?JcOaZmKeL9vixUYouJxqSvs7W0HnOG4H5wIIynXiMQBOUpPGoiuupyg/2gFs?=
 =?us-ascii?Q?oQSUEfb9/qH/744KdOYX34IZ35dEVb+IyZNxkYxkmBDELd+3/8GIr/31jR/1?=
 =?us-ascii?Q?J4/TmTV6QoXu/PAnlgAPWIwtB/hs5za7OfUaGM2b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9130cbc3-f811-4930-36cc-08ddcf84a3c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 16:17:55.4088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dLTB8ST4jyhrSwLDv190dk4ZVb0bWT+sVj37iDE+vVWxHD6BzMyWpWrlAnFL4VG05VcZx2hUSGFLZRBA89ubA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101

On Wed, Jul 30, 2025 at 03:59:30PM +0300, Laurentiu Palcu wrote:
> Add a platform data (pdata) member to struct imx95_blk_ctl to store the
> result of of_device_get_match_data() during probe to avoid redundant
> calls in suspend and resume functions.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/clk/imx/clk-imx95-blk-ctl.c | 36 +++++++++++------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
> index 7e88877a62451..c72debaf3a60b 100644
> --- a/drivers/clk/imx/clk-imx95-blk-ctl.c
> +++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
> @@ -36,6 +36,7 @@ struct imx95_blk_ctl {
>  	void __iomem *base;
>  	/* clock gate register */
>  	u32 clk_reg_restore;
> +	const struct imx95_blk_ctl_dev_data *pdata;
>  };
>
>  struct imx95_blk_ctl_clk_dev_data {
> @@ -349,7 +350,6 @@ static const struct imx95_blk_ctl_dev_data imx94_dispmix_csr_dev_data = {
>  static int imx95_bc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	const struct imx95_blk_ctl_dev_data *bc_data;
>  	struct imx95_blk_ctl *bc;
>  	struct clk_hw_onecell_data *clk_hw_data;
>  	struct clk_hw **hws;
> @@ -379,25 +379,25 @@ static int imx95_bc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> -	bc_data = of_device_get_match_data(dev);
> -	if (!bc_data)
> +	bc->pdata = of_device_get_match_data(dev);
> +	if (!bc->pdata)
>  		return devm_of_platform_populate(dev);
>
> -	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, bc_data->num_clks),
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, bc->pdata->num_clks),
>  				   GFP_KERNEL);
>  	if (!clk_hw_data)
>  		return -ENOMEM;
>
> -	if (bc_data->rpm_enabled) {
> +	if (bc->pdata->rpm_enabled) {
>  		devm_pm_runtime_enable(&pdev->dev);
>  		pm_runtime_resume_and_get(&pdev->dev);
>  	}
>
> -	clk_hw_data->num = bc_data->num_clks;
> +	clk_hw_data->num = bc->pdata->num_clks;
>  	hws = clk_hw_data->hws;
>
> -	for (i = 0; i < bc_data->num_clks; i++) {
> -		const struct imx95_blk_ctl_clk_dev_data *data = &bc_data->clk_dev_data[i];
> +	for (i = 0; i < bc->pdata->num_clks; i++) {
> +		const struct imx95_blk_ctl_clk_dev_data *data = &bc->pdata->clk_dev_data[i];
>  		void __iomem *reg = base + data->reg;
>
>  		if (data->type == CLK_MUX) {
> @@ -439,7 +439,7 @@ static int imx95_bc_probe(struct platform_device *pdev)
>  	return 0;
>
>  cleanup:
> -	for (i = 0; i < bc_data->num_clks; i++) {
> +	for (i = 0; i < bc->pdata->num_clks; i++) {
>  		if (IS_ERR_OR_NULL(hws[i]))
>  			continue;
>  		clk_hw_unregister(hws[i]);
> @@ -469,14 +469,9 @@ static int imx95_bc_runtime_resume(struct device *dev)
>  static int imx95_bc_suspend(struct device *dev)
>  {
>  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> -	const struct imx95_blk_ctl_dev_data *bc_data;
>  	int ret;
>
> -	bc_data = of_device_get_match_data(dev);
> -	if (!bc_data)
> -		return 0;
> -
> -	if (bc_data->rpm_enabled) {
> +	if (bc->pdata->rpm_enabled) {
>  		ret = pm_runtime_get_sync(bc->dev);
>  		if (ret < 0) {
>  			pm_runtime_put_noidle(bc->dev);
> @@ -484,7 +479,7 @@ static int imx95_bc_suspend(struct device *dev)
>  		}
>  	}
>
> -	bc->clk_reg_restore = readl(bc->base + bc_data->clk_reg_offset);
> +	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
>
>  	return 0;
>  }
> @@ -492,15 +487,10 @@ static int imx95_bc_suspend(struct device *dev)
>  static int imx95_bc_resume(struct device *dev)
>  {
>  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> -	const struct imx95_blk_ctl_dev_data *bc_data;
> -
> -	bc_data = of_device_get_match_data(dev);
> -	if (!bc_data)
> -		return 0;
>
> -	writel(bc->clk_reg_restore, bc->base + bc_data->clk_reg_offset);
> +	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
>
> -	if (bc_data->rpm_enabled)
> +	if (bc->pdata->rpm_enabled)
>  		pm_runtime_put(bc->dev);
>
>  	return 0;
> --
> 2.46.1
>

