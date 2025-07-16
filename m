Return-Path: <linux-kernel+bounces-734087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4EAB07CED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E9B168A55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796E429A9FA;
	Wed, 16 Jul 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A/XeN4Is"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D217B425;
	Wed, 16 Jul 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690552; cv=fail; b=PYZM1uHWA/7K70/zr2p9q9/cuPiqP5hUR4/2qsPOgKVeUNDfEzUJDZtXkA1H0roO9z7IXzMC0bXusvggp7D0YmABNFEhJmu6wLaa2uN1NhsZ4U5mR5GIViONuagyJwiZCN3MOdfSmVii8Y9DosUFAYX+eynkd9scSr6plWCO6sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690552; c=relaxed/simple;
	bh=1xGjA4u9k8SxS+96WKDe2plg9FczDoekgaiROyeQBHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pdzTGp0AGOY4rNWJEPhHKv3tuxY1Ya1faamYdeGIG9ezscSETK5EVHAoT9DDJeqYjzfNERG0roHfamTe7Kcd//wwW4y0fhoC+va2Ks2RMUaxSQyaMA96VR9pk1WMCcf9jkrpFLGmGk6WZcSJKxwIe8hxfXhtqlwFxqcY2Ru1Jo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A/XeN4Is; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv/0jxTHgs5h4FRkeDodTZGWGU8Fisgq9gbehAildo/MqYQfWnJbE4qhlyuZVAOyyIZ2ZdNj7YnQgl+kbk3SHAynXKXdd3DJoEch8hcOj8upLSOZOgvw/nRalYtyoI3xAzaU4hyggAbptfyKW4g6PfVxfV6Y/+0VNSI/OVYucbCw/SznwfqLhz06tHt33sN6ssspzdGBqaMMGPDSBDyadPWhhPUnBo2P1a+xdJi73+Vxx9BWPJCZC2WdjbceBgG54g71Mc2K6XezvuNKbZDo4o3jm/2unFwdYx5OBs93j/mKorO3BaKwk0vCOXDzjXEjoSOcdHgZAckPs9aozp7/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MvPeDxnQIKzouYRxth6crNBcHsftrEYqwDcR1H/Zd4=;
 b=eGFcw42iQMC6Yi5FnF6AFBi6chAl2KX3emm1cEn4UJbmKuyBxSo9AUSZc2VwThBWesIMX6wu806kx7rJD3bUNKyvxOvUEI4/AQUV7pGHCKYUykpApDjB+r4dDoPu9DKxlITuTv1XM35PxkTEF8tX7Nl5v7M/hZW1yHC9b5fSKNPDN/7uIymDo54MsXDbaz2C/iIk1EEQC+I5gEnjBSMqtWAdpelmx8HJyeO4Db+KAq7+6fEUmkue+3iMyX9eVoXWKelEdvICKsfeiuGNuEfRqPDtrvRmyFMYYJ+1xe0EYzSgm67K9Cmps8hLMQK54Haryt/VfBbACsN9fWZbIwUF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MvPeDxnQIKzouYRxth6crNBcHsftrEYqwDcR1H/Zd4=;
 b=A/XeN4IsfbetJFTWrK5qo4/wNGW/XxEdOUQ7uO3NFYR/6dUm78ObNV1TvfjdhlYk1bEXK0u+uFbiS+KYrDqbW5xw9Ld0yoqo8649OvzV7MQzpinUm2qO+XpN1sr0FeQU0ERvTm1bGoNLpqzHfvoZWuqWvLf9ATx23RNjFHKnNir5k4L/7eq6tLUIw9JZ+O2Jkzp+yE8ePoiA1MJjmO8KXDgajNFsDTc3i5oyL8/lWuDxo5CJgHKgByWwyJOM/jVyKXSKHUK8u+JtV+aU4INpt+i8PCvFKb8b1x9PwOglRlnBYQGoO06eyZJZg0Mf26vzwQPNVNgDYwZ30dqc3nX+Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9919.eurprd04.prod.outlook.com (2603:10a6:10:4d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 18:29:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 18:29:06 +0000
Date: Wed, 16 Jul 2025 14:29:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] clk: imx95-blk-ctl: Save/restore registers when
 RPM routines are called
Message-ID: <aHfvbTpQ4LmexJpA@lizhi-Precision-Tower-5810>
References: <20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com>
 <20250716081519.3400158-3-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716081519.3400158-3-laurentiu.palcu@oss.nxp.com>
X-ClientProxiedBy: AS4P251CA0029.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9919:EE_
X-MS-Office365-Filtering-Correlation-Id: c2abe7ba-c142-45f8-e305-08ddc496a606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|52116014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iAk4BQP5wP/xZwrJy7CvHZq72ZgFtOmrv69P4N5fNu9U/SVwpC1XI0TD2Enx?=
 =?us-ascii?Q?3FScKVurGMe6pNEUMxPwXlhu/BSgwKMrIINM+LsOpZqLNNZFiz7IU4Vi6r7l?=
 =?us-ascii?Q?ygp79cB9N5zM/dxVikWQ1iquwHRFkEqL834SZ0mULoBS+HfujkKP/7hRpi5i?=
 =?us-ascii?Q?PpCxir/CHycjid7fAYDseG9iEo9IiApMjTTXAvLZEqFuOba0reIP8/Xh+vpC?=
 =?us-ascii?Q?EIaJxZ4J/u819/PKG6tyO6QM2vB5UxBxSeecn/PU/+k0I+q5NssNaid3nZkC?=
 =?us-ascii?Q?0TCdAUJ6clQr5BPRGs4/zbxpZQBVZn1Kwm9OXLIAw05CbH/qvryH+xCgOZp8?=
 =?us-ascii?Q?4Y7jDpDdEx6CGSCAqzuokuiyql0Ms+613YlGn6HikNT5K+7DwoXLTEiXLmfl?=
 =?us-ascii?Q?j3pXVn7l+moOmDhjDLEgN1MV2v/TASZ+G6cTCqVNnqqNDOPtpmkHaB974sLA?=
 =?us-ascii?Q?i7d8tKIJA5Gp3ko3nZ8QxYkbgHK3CWUoUXmNKNjW2LfvTLEmlQuMcJRm1oSI?=
 =?us-ascii?Q?8D43JE3IOZvsAGqiEbObph0T/DN59htg6fkDND+IRn7PoG694OZiPC+8g4l9?=
 =?us-ascii?Q?cHQedyL9cG3+QNQ6uYo9qiVOLEIk6xJwYk36SmGouJeBWGdvAUmyzhQP0q7j?=
 =?us-ascii?Q?T/VxX58kqBY+vBiJCZRiffj9q06yDpVECQZEe0Hq0wiAyATl61Bxew6eMmWX?=
 =?us-ascii?Q?g9t118rlJfFuqof7mUgQlwOabJQD/Hq5xLrGTnmXlkJjoG6F3sE9+kIxTCVN?=
 =?us-ascii?Q?8nW9Mi+Dvu34jklgIPI17+PKZ6eubQVU3wnzjKKfPSQEbSkZUdQsN5BxjdnX?=
 =?us-ascii?Q?ezRLkDv6jsockAbYAZQO4IeYw2t3Z6KPZ85FCB4qgUoolikRbC8ka9o1uD6b?=
 =?us-ascii?Q?IMd9QUu9t2jFCpwaq7qykFdbX8xMRm+SyLGFezEqCVWTCQy7Cvi4SZnMpN0y?=
 =?us-ascii?Q?ojX0sLNs9F8ZF7QKW/bfJLhSmumcCYVfYKgzDVixPkOOd+VFH2rt4i5Kk74/?=
 =?us-ascii?Q?H4GnkgcZQuXAO89TfZQ7OXfjpcC4J2LmzAPyPqXvwyOPw9peSwJK24OSeB89?=
 =?us-ascii?Q?gOHm16CHV+5EpTB57tQLM8FcVS77MbdQsUo+m38WPPhdkeHLNZOWHKoULYox?=
 =?us-ascii?Q?CpzBKXeDOEZtsQqUiRnP20LCiLcNmqVUUU15JzUlLKwo6NdSPOyPW6BppRmN?=
 =?us-ascii?Q?IjjahRLzL6jGKT8V8fEUP37DlfewiqXB6MB0G+3BfaDC3Pn3zX++D5hyHWtb?=
 =?us-ascii?Q?xd59IbEpTDS670uUGqBdf8/x5/6LgcwyUbeGpuJnK8o2S9olz6IGxTOVZl8B?=
 =?us-ascii?Q?Eo1F8S6bVnKG0OG6LZ86sAwyf6ss0U64sh6/J/iX/tRHstPHJfjZ83ENf7QF?=
 =?us-ascii?Q?yhDEfrDE2Ab+1kWvQZhLs/GV+p3DluwhhGAKjNnx4BijPPh3ebAHQjZk1vgv?=
 =?us-ascii?Q?trsnagDtWYsbGCA96QtZ68t9O9cKhJo228EFbFrHRC0xGMqNwv3fQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBHms3Au/We2mrx1RCfgwwDwKVZlTl9TfJAHAIpscZH8y5Y3FLKus8dvuOVY?=
 =?us-ascii?Q?JhvRAG0pxASAjRJmX1w8ppcUKWdbFlSuc5V/cCwmVVldKQRHrgM9Va03ZW/0?=
 =?us-ascii?Q?EytbC9y8sx/sRFUSXZNNWDpsWuKM1b268urJUw8QiYkROvr94nM0dr9w9YoJ?=
 =?us-ascii?Q?VNi6P3li0oCMK8LgL1D1uLRggMoUC5WTA2gvOOhtMpamUSQxHsMcfgGbq2kG?=
 =?us-ascii?Q?wA6goHd9D3S3cXQ9Yzd6odas0y0B5h6tSmSk4F3vY8JxeJHkBV2rO4glT0ut?=
 =?us-ascii?Q?yRZWPG2/Ru/TDIklvEHwlvk7nWYpV3ulalTvtkOXHvFgJL7gXxsN6fw3eqwb?=
 =?us-ascii?Q?xPVEedzOEh1uNwYnjYy5xwt8G9cvdHrSgBHNAO9lQM7UcjEKcIH2YqFKMrzC?=
 =?us-ascii?Q?p6lNW1e8kCzfzCPUESB9b9K2CunJ22C8Nw5U/Wu1d30emw0NjQgi+R8Gdwib?=
 =?us-ascii?Q?okuH7CCaNzjrqMyBiMcHitz+n1eHvgaK6gT5dU487qEBWfgBgaM25hSMOI/Y?=
 =?us-ascii?Q?RLVlQTrP5QiZyenogoSit7nsWF8gKPfYP7+uGN45zF2GyF5gqIwqn1Bv7v42?=
 =?us-ascii?Q?K8mi6YSLo6eB2XSwC1AnNjJ75R5R02cSRTj2dlB4vGP/Mkg+/lUEIDINLpBa?=
 =?us-ascii?Q?AlIe3gImIfSlulH7atMCn7mv9VOI9Gwr2EelqXdRujm70Q4EZWxKTJdf5730?=
 =?us-ascii?Q?b2FSPETdZP778nYcuZ7PEc+D5x5tYBFT1OOcJCI+TDD9+5yiiqh15RmtQswi?=
 =?us-ascii?Q?DU0k234JXumjmFd3PVDoaRHjiXv/xyFXkyOPa3lMufo3mKgL6Gomm9BFEueU?=
 =?us-ascii?Q?Pevhjza4cfR+5QqFLDNA0w6EHHujS18HX0JeDC/vj+3MxfHqOHaD6cJafnUR?=
 =?us-ascii?Q?fN1CpxblgfinYu6RkhgBPV9F343/ytBzkkpI5XpqjZ6nWWuaXOfCy8ugeuYx?=
 =?us-ascii?Q?T5oaYY+VpaLU0WOLNKlXE1uezSAK/xJAGxgXuO0zPuK90YlFjusoqpTZPBnL?=
 =?us-ascii?Q?/Uq0OdXgwqPUOYOXGRBf3yjVSzZ+FX+ATt5jTYbAL3vyuNbqWq7P0jslDhzz?=
 =?us-ascii?Q?XF8HIOwL1Q4IerXFt3N2ad4ELwD7oz46aC64xBEFzbcFyYJQQ6iZZUTA7em/?=
 =?us-ascii?Q?tDdmqjgJqhsHftL3sQ0+nKEGPJbdDXJquwtx6vuXzdL5QpgiWcKlO1M9rQHp?=
 =?us-ascii?Q?Lgzimp0vV9r1VUj27o7uFKTyND8WH52sZw+Sr7qKuNij2x7BHrVbtz8jRGxc?=
 =?us-ascii?Q?cJSooD2RaHzXkQdBPaZWFHP/LVb725sunTh1/f5GgmO8IhveA8SyPTvDbq7k?=
 =?us-ascii?Q?VaCcAZwsETXF7IZ6oCDbi66fE3gMdd3thr0F6bX/j+9A4Ojovi4eyXZ5n3sX?=
 =?us-ascii?Q?rWYH7VQhtPESLvNO2BjguR0BgCdwOjinrAkp5TCvoyeDkkj9oYT1cbb0zXqS?=
 =?us-ascii?Q?YL5TTIPJQ2IA+R6XcYsUOhL3DRuz3K69l3nOntiMniAqEFGRl6wBC0Vr3dFn?=
 =?us-ascii?Q?Gmb6U//cIUJW8lrXroxaBdHNWus+kWhb5RRqquHNUHGBi9Lk5deudyDGLmj2?=
 =?us-ascii?Q?PsZQfIMWklMkTmgOTcQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2abe7ba-c142-45f8-e305-08ddc496a606
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:29:06.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ0ddrDMB4tIDA78Xm/YhOwBx40HyVvZDi8Hd63SrTlOVwRDoGftufW1QKqDW6UnLvC9s9ZajWfvEAy6OjUqjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9919

On Wed, Jul 16, 2025 at 11:15:06AM +0300, Laurentiu Palcu wrote:
> If runtime PM is used for the clock providers and they're part of a
> power domain, then the power domain supply will be cut off when runtime
> suspended. That means all BLK CTL registers belonging to that power
> domain will be reset. Save the registers, then, before entering suspend
> and restore them in resume.
>
> Also, fix the suspend/resume routines and make sure we disable/enable
> the clock correctly.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  drivers/clk/imx/clk-imx95-blk-ctl.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
> index c72debaf3a60b..3f6bcc33bbe99 100644
> --- a/drivers/clk/imx/clk-imx95-blk-ctl.c
> +++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
> @@ -453,7 +453,9 @@ static int imx95_bc_runtime_suspend(struct device *dev)
>  {
>  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
>
> +	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
>  	clk_disable_unprepare(bc->clk_apb);
> +
>  	return 0;
>  }
>
> @@ -461,7 +463,10 @@ static int imx95_bc_runtime_resume(struct device *dev)
>  {
>  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
>
> -	return clk_prepare_enable(bc->clk_apb);
> +	clk_prepare_enable(bc->clk_apb);

Need check clk_prepare_enable()'s return value!

> +	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> +
> +	return 0;
>  }
>  #endif
>
> @@ -469,17 +474,12 @@ static int imx95_bc_runtime_resume(struct device *dev)
>  static int imx95_bc_suspend(struct device *dev)
>  {
>  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> -	int ret;
>
> -	if (bc->pdata->rpm_enabled) {
> -		ret = pm_runtime_get_sync(bc->dev);
> -		if (ret < 0) {
> -			pm_runtime_put_noidle(bc->dev);
> -			return ret;
> -		}
> -	}
> +	if (pm_runtime_suspended(dev))
> +		return 0;
>
>  	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
> +	clk_disable_unprepare(bc->clk_apb);
>
>  	return 0;
>  }
> @@ -488,10 +488,11 @@ static int imx95_bc_resume(struct device *dev)
>  {
>  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
>
> -	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> +	if (pm_runtime_suspended(dev))
> +		return 0;
>
> -	if (bc->pdata->rpm_enabled)
> -		pm_runtime_put(bc->dev);
> +	clk_prepare_enable(bc->clk_apb);
> +	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
>
>  	return 0;
>  }

Look like needn't imx95_bc_resume() and imx95_bc_suspend()

DEFINE_RUNTIME_DEV_PM_OPS() will use pm_runtime_force_suspend(), which
do similar things with above logic.

Frank


> --
> 2.34.1
>

