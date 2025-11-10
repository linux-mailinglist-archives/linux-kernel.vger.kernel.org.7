Return-Path: <linux-kernel+bounces-892682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83DC459C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925DE1890522
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBDB30100C;
	Mon, 10 Nov 2025 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JVGz7Dw8"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8893002B6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766587; cv=fail; b=Ym+54Dpu1qbmeqWwHnMARI54/E0ljS8C/Fa7u6kiNZv+QK39mT8ple2f+CHZXkWecFq/dgTsUPZaLuM+DxelU0W/jWHSs7726RNS7+qeG32Q43mQLdPAj80rTwRxzaZ+JiBfC/ZdJ6kD0ea1oyTZjIs6cU0CUbsFsexSoEVLmn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766587; c=relaxed/simple;
	bh=Vv+o2lCSwuSauHgd/+K8bUHVM72HiFCZ+k+GkBZ8KB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AWv68mxhcKLW1hLnD6M608wRagcZ9QEBuexyBfnrOuaCLPkddle9IcHdl751NvOieV7G1u8HARTunFe1yUUww4MF4xQjOjSJnflK6oTbhCVqmvXckDz5ciJuYsiVoOOjFkl2lQCJptatpW/g3CL7U4Yl076vht+5muysTZHCHa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JVGz7Dw8; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFlJHZb3OVwS+v89mD9HC4MkbNiHZzvr0INLPq4qfbkE/7WsBafU4f+grv4BANfM1i0hLjwkaKq2rWHjYHaIL8/enUUA+Ly64JgQ3pxQqx0Dw5vYlV6nnJB4WQRklPd1ff1t5WRULwHj5ansTSnMRL1UarGoXL6+X2d2r2gQEUdnfdse6EWNuxlMOEvB/gYc19bkKtsZTBwDQpLf7UjhMtPIuAkXTR1B96DvbOigH36d1MKHQZOj4/09ZQJ8HYh34a4bPmFOCAjVxh1HP1BSqNczHiAhIzTFe3TQAMc4rH3AGY+Lz3o26KO9F2G6UC7I8OSZq35t2csf0WKZq+W7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec9Q/DPFzYz79jsF7xHnSwtDIhjTVefPzGGvOuV/Wfk=;
 b=fTTbqFHIfbfNaBn8tV98yILCW8SvhUjnMf+LHrN/9zNUkXiiNMSP/turTArRC8EfFKNV7C3VmejZO2u+pOI87HcfWRPgMFtG9UDH4RFOu2tbJfv1ovXsu5pnHWRUSCJLZ3STfACIu6e8t67FgMHxkNMEUJ56FChAvQfOkm3DlZ5Fr3TKxXfV6vnQeNfpbpiRD1clbappjJq3jJ/ZBKw6AOgEQBhB5QaOYX4+iryW9tJO4AEElIhpKtiPcyvR3zdVtZdsZrAKEua+9LRmPyJr0mokn4UN+JRXiYxu7R4eEGV0YUrbCZq2U5ySZr1Z3op4BdSLzyZfeXYvjj6lT4ghkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec9Q/DPFzYz79jsF7xHnSwtDIhjTVefPzGGvOuV/Wfk=;
 b=JVGz7Dw8YkJ87TjcXQxTR+HFH8CMnCzc8x2exluL6K4uB51wP6L++s5hBPQvqTLPy7cImLKNr138+ZBGCKDIhesU+xusEWe81JSB3Is2GZhtgYd3OqWNjuM0e23cenO1Y0skp/P/q/ZcOnAB+tCbjnb4Jt/cpfz4grZMf58gtJWIFAqQCeo5HhBNPfcfcRPxUn2KvAuN1aQTSgSRHALxxQBFR9dvvhoUpUwcJS8hbEy3OLVhpvvDHperoS/E/V3C4ZfKdmezNBp4TvVQhltoAX9WLKn/YdhmnXkwHIIbYCzsSHNAyICKZkgh2jEFVz8QB1mcLUWSjarVrYph2Kxh8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:22:58 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:22:58 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy 04/16] phy: lynx-28g: remove LYNX_28G_ prefix from register names
Date: Mon, 10 Nov 2025 11:22:29 +0200
Message-Id: <20251110092241.1306838-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: 160ebcd2-454a-4a8e-ed5e-08de203abc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Qc14h3o5FZlS7isHxdcuc6j4g0Wp3Pt/IIB3E2yPqgzMGOTGXODImu695J5?=
 =?us-ascii?Q?ZgzanhINU/zgoTuIzDM0NApo15dDn+MML/Spg+TlmiknpeCmB2TE2fBAQa8I?=
 =?us-ascii?Q?FgS+4H/Cy/zrruVB2a6+e7cVQar89/4ViJAC/cxlDDbZwi5R2klJupz9ttd4?=
 =?us-ascii?Q?uwJUY+3oeqygkHhCEJn/oX18f5ix3B/v9BYQv1iA2go5ZapC1bpIdhuQSYm+?=
 =?us-ascii?Q?+Ifq+OHBcKIjoV/KW7QPwpcEEU9Pq1ceia7UslERZFNqdDL3LKRzFV+UMp7c?=
 =?us-ascii?Q?dI4R60fzL1KUXdfbzqDAOX6KIZ5ATDNR0mNWTAg5wuqGsJs8EjCWeWAEtb++?=
 =?us-ascii?Q?H3nOejepRaMGwev91EfmALDyg+zjZBf9TQXQZt+kzcR0m5q1AGZzojnPW9oU?=
 =?us-ascii?Q?P7thCRNrUMouviFYIBkmsTGiwsB6eXWSreU0qccmk96PKW3TMSOYyL/DfcoQ?=
 =?us-ascii?Q?DuzxemVG07eJ9PIZRuAcRJwf6ZdSWzKjLAKPY84v1trhR67jWvJxxFyRCtHg?=
 =?us-ascii?Q?zJoAu+hh/2a8w3emj/tCYj3bouMgCuIfbY3RzwYD5wSuA/9U8AFUCDzA150+?=
 =?us-ascii?Q?bQBofsFV6hXa5pW/cwuOFOSdBjLGbp0ntPs2etlS8fn1XeH1IDhbBihgGygN?=
 =?us-ascii?Q?XwVvDiLy3OpQIzFFZtTvc/o/dYvgAaz4pIFfYKnCXRbQPA5HeARgmT1bfaZ2?=
 =?us-ascii?Q?+lhFEDN/8FB8A7IQEoXqzo/iSe/nrlZNaQixU8BUARRazENvxXvFM85E7mIa?=
 =?us-ascii?Q?oRLKos9u1FOOmiThhrEcKX6ZzKF+OgfySkqd4OwEFV8T/7FZYzN0s/boAwEr?=
 =?us-ascii?Q?GBM34OJp4LJncZPQnkdHb6Ru075sRYUyihXFeX4jCTYcWaqm4mEFoh3JxWMC?=
 =?us-ascii?Q?BjIAc0ikdQn7CC5QDhRBIoN5rp8bkd/k98DDnbgg1CPAhgmggfM7LCkFXKj+?=
 =?us-ascii?Q?6dLljxU4LCrmiVI+37bWfMKqKZZW8FAooe/sg8EazJ4Y5vY316ytafu72KAX?=
 =?us-ascii?Q?2DKQhDNgFtP7yf4Dn+zGeSCVIFmRZ4lNQWmlot7NORytnO/ueDCGOHQCtwfI?=
 =?us-ascii?Q?IWgEYcNaIEnkjQJFVmQWQdUDC5AnojqiubulRUts4OzaztVp8GtOtjl2uHxy?=
 =?us-ascii?Q?EybI9fUnwURSN7+03FRAu968sBosrEvrPiq7w3jHp8ap+SsLPON3LFG0ajoF?=
 =?us-ascii?Q?QfKv/rCjZKpNEKY73GzkXPriE0SHJmmX0fQ9zmViXrY2j72GIxntJrEuEqk6?=
 =?us-ascii?Q?RbDIDlAM3Q5whZJ8hvIc1+gPhCh2YY3IDqeIKyalh6Kwrm+fhSOyN769etGP?=
 =?us-ascii?Q?hjjKFQCE7+UsNGckdJ005WAPv1WxWPtzR8NxPr6gN5TK0W6L8r0Mrs6ew6PQ?=
 =?us-ascii?Q?/uJ4MHYn1RD/EMD9y1BvoC/Kydsd6q3mo0SOiwcGB7Xyk7DW3CHV1bSNu7jp?=
 =?us-ascii?Q?BVJDpBQN3/txLzUX3S/82TDtUKRn8u5Hbr6c88EvJlb752Mb2V6HAvCbvhPq?=
 =?us-ascii?Q?IAKupHzK6QzrX78L9MPvjl5WPQO1dQJZc7/z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V5zUjrcc77U+uspKIEwSdjUifeNl7eTSKhif0VrVkGmGQutkVj8VaI+0TW/L?=
 =?us-ascii?Q?/bkBfJW++Cd5QCc2Q+LUlXw36RUHz+DqD857UapiHs2Oz4xVrpeD77icT7Bu?=
 =?us-ascii?Q?hgFkKqXC0MXaG5/Pece4n03vNODEzP28rHzfFbJkLX1KGDxP/S5To7wqMF+J?=
 =?us-ascii?Q?mMtiDCoZKQiStNZOTglw5+7Oks6yvzDN1yJrLm8cmZIcp78a0XgJ72k6IytT?=
 =?us-ascii?Q?lQy0gkj/EKl9WfJBPoGDh0ddnH7LIuwCc5jcHyusGMGBZKkNuWo3vCHrJu03?=
 =?us-ascii?Q?GM7hmzT6WlmwzojI2ThJLURMXw93U8ncfvxrCTUrON9TKmeLjdo3VxfgSq2K?=
 =?us-ascii?Q?VyKZ1n0TJkwnOVYcv+dJllx0I5h0jI6HHb60JF9tw63kA5YrAxut3Oag+UAa?=
 =?us-ascii?Q?n7YDwBnaERVeIyrFnbbb6h4FMR36w1S5MJuvothrIPjQK/C+a57swEK94vfe?=
 =?us-ascii?Q?9W8o8x2thAVvEgte41X+ffAseMT5slAcXOv8a8OWovIdbgN6TUs/zr31tzpW?=
 =?us-ascii?Q?RvLE/GOWLJWjrS6KcADctR1plNB9Smq46/5qbUGtJRytuLkHTajuYIunGa3c?=
 =?us-ascii?Q?MPA/pCmnBP6gXsf60jS1Jgdl0sh+Y2YGposX3X/8qGjf3WxCcky9kbplPJWG?=
 =?us-ascii?Q?bJM1qrvnTWBbxoSeS9PMOgFGWjFigzG4n03sKf9jDKJs5kv+DilwNbx/jfkm?=
 =?us-ascii?Q?XMUhCFhme50cW402NJTqmFeMwtFIOAzufBKD4f+xlLi3w9ksQ9qNuNRSbtKO?=
 =?us-ascii?Q?85wS60BFjfZANd3BREMm5vfhES1SejrsZ4GSbuK8SyL27VmXzi3YkDC6X7bO?=
 =?us-ascii?Q?l1jPVlcdXeyvBI8t0kb49mxOqykpQX3h5GqHsSomZ4LDk9PP4FZGD3tfevyV?=
 =?us-ascii?Q?FvyN2V/3V4vENf83D4TkmDnf7iLAFxLrN3m3M+OhWlUsrTMXnLgvcYTfZfKp?=
 =?us-ascii?Q?Sj3jMGQjZ/2w0qcZTjvEugMie+CrP5OAnHx/tYu/v0zp7JvbwduP6efvFz7j?=
 =?us-ascii?Q?YwHzU+wn5BcLCnZIOT2GlCpHH+QjuXsPgMe1O9tsZqKNDUbENeOdxfClb0FI?=
 =?us-ascii?Q?n0Pe7Yfr860zybRsg7ayelhptUgaImOtvMj9UtUKZWpsDZAB2Sf8vteBYV0G?=
 =?us-ascii?Q?kuaqEnTF0AnIRpsmaM7ZGxktF95G8ibpe6TFFcCvh38Bj5gHbGlclz7jxLdh?=
 =?us-ascii?Q?iBowUr/xSkbEjsW9qHNiPw/yAFxJkrnCDFFX5LcUK1COpujdVbEmG8fngK3d?=
 =?us-ascii?Q?NupqS145lGN3Xxj4qumyrU4Y23TBRiuA+ZAk2Po9VdyJ0jErg3aE9Q7ECTZS?=
 =?us-ascii?Q?9s+ODlJtHbUHYPgSJzW/s8Hj7VaVpT9X+ZEreidB1XvSyBXJSrG7uP54IS5H?=
 =?us-ascii?Q?PvAk1Yp1kVaTbEmUkI/+v+NuyoI1cQv2LPT1n0z88WqnmySG2JUfzc0SYrTX?=
 =?us-ascii?Q?3FGf6SDIWN23oNUOGH4PL9CQMJe9udFzaS7clorHT9rZ/3r2yW0re4UVnHYT?=
 =?us-ascii?Q?gvYqWJQXl2IPWGwGG2ssk5oeA7dXIHpqZf5PCJkI1XlFFf6NqdcA7GxxK/Ut?=
 =?us-ascii?Q?PopqLmQYkicsRc9+EOiQjvKoVrzOvs6NnaDa5V2JNrHz024JMpPrm2Gd99Zc?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160ebcd2-454a-4a8e-ed5e-08de203abc96
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:22:58.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BV/Sj47J6ioDlGJ0ycCOmNtjhwBPVE3Iqnq/6a9kbB2U+O9Lp2DkJ8wa8g6RaGBnmpxmruS+QC9hp0QZu5GwNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

Currently, in macros such as lynx_28g_lane_rmw(), the driver has
macros which concatenate the LYNX_28G_ prefix with the "val" and "mask"
arguments. This is done to shorten function calls and not have to spell
out LYNX_28G_ everywhere.

But outside of lynx_28g_lane_rmw(), lynx_28g_lane_read() and
lynx_28g_pll_read(), this is not done, leading to an inconsistency in
the code.

Also, the concatenation itself has the disadvantage that searching the
arguments of these functions as full words (like N_RATE_QUARTER) leads
us nowhere, since the real macro definition is LNaTGCR0_N_RATE_QUARTER.

Some maintainers want register definitions in drivers to contain the
driver name as a prefix, but here, this has the disadvantages listed
above, so just remove that prefix.

The only change made here is the removal of LYNX_28G_.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v4: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 248 +++++++++++------------
 1 file changed, 124 insertions(+), 124 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 61a992ff274f..c9bdd11cc48a 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -12,99 +12,99 @@
 #define LYNX_28G_NUM_PLL			2
 
 /* General registers per SerDes block */
-#define LYNX_28G_PCC8				0x10a0
-#define LYNX_28G_PCC8_SGMII			0x1
-#define LYNX_28G_PCC8_SGMII_DIS			0x0
+#define PCC8					0x10a0
+#define PCC8_SGMII				0x1
+#define PCC8_SGMII_DIS				0x0
 
-#define LYNX_28G_PCCC				0x10b0
-#define LYNX_28G_PCCC_10GBASER			0x9
-#define LYNX_28G_PCCC_USXGMII			0x1
-#define LYNX_28G_PCCC_SXGMII_DIS		0x0
+#define PCCC					0x10b0
+#define PCCC_10GBASER				0x9
+#define PCCC_USXGMII				0x1
+#define PCCC_SXGMII_DIS				0x0
 
-#define LYNX_28G_LNa_PCC_OFFSET(lane)		(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
+#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
 
 /* Per PLL registers */
-#define LYNX_28G_PLLnRSTCTL(pll)		(0x400 + (pll) * 0x100 + 0x0)
-#define LYNX_28G_PLLnRSTCTL_DIS(rstctl)		(((rstctl) & BIT(24)) >> 24)
-#define LYNX_28G_PLLnRSTCTL_LOCK(rstctl)	(((rstctl) & BIT(23)) >> 23)
-
-#define LYNX_28G_PLLnCR0(pll)			(0x400 + (pll) * 0x100 + 0x4)
-#define LYNX_28G_PLLnCR0_REFCLK_SEL(cr0)	(((cr0) & GENMASK(20, 16)))
-#define LYNX_28G_PLLnCR0_REFCLK_SEL_100MHZ	0x0
-#define LYNX_28G_PLLnCR0_REFCLK_SEL_125MHZ	0x10000
-#define LYNX_28G_PLLnCR0_REFCLK_SEL_156MHZ	0x20000
-#define LYNX_28G_PLLnCR0_REFCLK_SEL_150MHZ	0x30000
-#define LYNX_28G_PLLnCR0_REFCLK_SEL_161MHZ	0x40000
-
-#define LYNX_28G_PLLnCR1(pll)			(0x400 + (pll) * 0x100 + 0x8)
-#define LYNX_28G_PLLnCR1_FRATE_SEL(cr1)		(((cr1) & GENMASK(28, 24)))
-#define LYNX_28G_PLLnCR1_FRATE_5G_10GVCO	0x0
-#define LYNX_28G_PLLnCR1_FRATE_5G_25GVCO	0x10000000
-#define LYNX_28G_PLLnCR1_FRATE_10G_20GVCO	0x6000000
+#define PLLnRSTCTL(pll)				(0x400 + (pll) * 0x100 + 0x0)
+#define PLLnRSTCTL_DIS(rstctl)			(((rstctl) & BIT(24)) >> 24)
+#define PLLnRSTCTL_LOCK(rstctl)			(((rstctl) & BIT(23)) >> 23)
+
+#define PLLnCR0(pll)				(0x400 + (pll) * 0x100 + 0x4)
+#define PLLnCR0_REFCLK_SEL(cr0)			(((cr0) & GENMASK(20, 16)))
+#define PLLnCR0_REFCLK_SEL_100MHZ		0x0
+#define PLLnCR0_REFCLK_SEL_125MHZ		0x10000
+#define PLLnCR0_REFCLK_SEL_156MHZ		0x20000
+#define PLLnCR0_REFCLK_SEL_150MHZ		0x30000
+#define PLLnCR0_REFCLK_SEL_161MHZ		0x40000
+
+#define PLLnCR1(pll)				(0x400 + (pll) * 0x100 + 0x8)
+#define PLLnCR1_FRATE_SEL(cr1)			(((cr1) & GENMASK(28, 24)))
+#define PLLnCR1_FRATE_5G_10GVCO			0x0
+#define PLLnCR1_FRATE_5G_25GVCO			0x10000000
+#define PLLnCR1_FRATE_10G_20GVCO		0x6000000
 
 /* Per SerDes lane registers */
 /* Lane a General Control Register */
-#define LYNX_28G_LNaGCR0(lane)			(0x800 + (lane) * 0x100 + 0x0)
-#define LYNX_28G_LNaGCR0_PROTO_SEL_MSK		GENMASK(7, 3)
-#define LYNX_28G_LNaGCR0_PROTO_SEL_SGMII	0x8
-#define LYNX_28G_LNaGCR0_PROTO_SEL_XFI		0x50
-#define LYNX_28G_LNaGCR0_IF_WIDTH_MSK		GENMASK(2, 0)
-#define LYNX_28G_LNaGCR0_IF_WIDTH_10_BIT	0x0
-#define LYNX_28G_LNaGCR0_IF_WIDTH_20_BIT	0x2
+#define LNaGCR0(lane)				(0x800 + (lane) * 0x100 + 0x0)
+#define LNaGCR0_PROTO_SEL_MSK			GENMASK(7, 3)
+#define LNaGCR0_PROTO_SEL_SGMII			0x8
+#define LNaGCR0_PROTO_SEL_XFI			0x50
+#define LNaGCR0_IF_WIDTH_MSK			GENMASK(2, 0)
+#define LNaGCR0_IF_WIDTH_10_BIT			0x0
+#define LNaGCR0_IF_WIDTH_20_BIT			0x2
 
 /* Lane a Tx Reset Control Register */
-#define LYNX_28G_LNaTRSTCTL(lane)		(0x800 + (lane) * 0x100 + 0x20)
-#define LYNX_28G_LNaTRSTCTL_HLT_REQ		BIT(27)
-#define LYNX_28G_LNaTRSTCTL_RST_DONE		BIT(30)
-#define LYNX_28G_LNaTRSTCTL_RST_REQ		BIT(31)
+#define LNaTRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x20)
+#define LNaTRSTCTL_HLT_REQ			BIT(27)
+#define LNaTRSTCTL_RST_DONE			BIT(30)
+#define LNaTRSTCTL_RST_REQ			BIT(31)
 
 /* Lane a Tx General Control Register */
-#define LYNX_28G_LNaTGCR0(lane)			(0x800 + (lane) * 0x100 + 0x24)
-#define LYNX_28G_LNaTGCR0_USE_PLLF		0x0
-#define LYNX_28G_LNaTGCR0_USE_PLLS		BIT(28)
-#define LYNX_28G_LNaTGCR0_USE_PLL_MSK		BIT(28)
-#define LYNX_28G_LNaTGCR0_N_RATE_FULL		0x0
-#define LYNX_28G_LNaTGCR0_N_RATE_HALF		0x1000000
-#define LYNX_28G_LNaTGCR0_N_RATE_QUARTER	0x2000000
-#define LYNX_28G_LNaTGCR0_N_RATE_MSK		GENMASK(26, 24)
+#define LNaTGCR0(lane)				(0x800 + (lane) * 0x100 + 0x24)
+#define LNaTGCR0_USE_PLLF			0x0
+#define LNaTGCR0_USE_PLLS			BIT(28)
+#define LNaTGCR0_USE_PLL_MSK			BIT(28)
+#define LNaTGCR0_N_RATE_FULL			0x0
+#define LNaTGCR0_N_RATE_HALF			0x1000000
+#define LNaTGCR0_N_RATE_QUARTER			0x2000000
+#define LNaTGCR0_N_RATE_MSK			GENMASK(26, 24)
 
-#define LYNX_28G_LNaTECR0(lane)			(0x800 + (lane) * 0x100 + 0x30)
+#define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
 
 /* Lane a Rx Reset Control Register */
-#define LYNX_28G_LNaRRSTCTL(lane)		(0x800 + (lane) * 0x100 + 0x40)
-#define LYNX_28G_LNaRRSTCTL_HLT_REQ		BIT(27)
-#define LYNX_28G_LNaRRSTCTL_RST_DONE		BIT(30)
-#define LYNX_28G_LNaRRSTCTL_RST_REQ		BIT(31)
-#define LYNX_28G_LNaRRSTCTL_CDR_LOCK		BIT(12)
+#define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
+#define LNaRRSTCTL_HLT_REQ			BIT(27)
+#define LNaRRSTCTL_RST_DONE			BIT(30)
+#define LNaRRSTCTL_RST_REQ			BIT(31)
+#define LNaRRSTCTL_CDR_LOCK			BIT(12)
 
 /* Lane a Rx General Control Register */
-#define LYNX_28G_LNaRGCR0(lane)			(0x800 + (lane) * 0x100 + 0x44)
-#define LYNX_28G_LNaRGCR0_USE_PLLF		0x0
-#define LYNX_28G_LNaRGCR0_USE_PLLS		BIT(28)
-#define LYNX_28G_LNaRGCR0_USE_PLL_MSK		BIT(28)
-#define LYNX_28G_LNaRGCR0_N_RATE_MSK		GENMASK(26, 24)
-#define LYNX_28G_LNaRGCR0_N_RATE_FULL		0x0
-#define LYNX_28G_LNaRGCR0_N_RATE_HALF		0x1000000
-#define LYNX_28G_LNaRGCR0_N_RATE_QUARTER	0x2000000
-#define LYNX_28G_LNaRGCR0_N_RATE_MSK		GENMASK(26, 24)
-
-#define LYNX_28G_LNaRGCR1(lane)			(0x800 + (lane) * 0x100 + 0x48)
-
-#define LYNX_28G_LNaRECR0(lane)			(0x800 + (lane) * 0x100 + 0x50)
-#define LYNX_28G_LNaRECR1(lane)			(0x800 + (lane) * 0x100 + 0x54)
-#define LYNX_28G_LNaRECR2(lane)			(0x800 + (lane) * 0x100 + 0x58)
-
-#define LYNX_28G_LNaRSCCR0(lane)		(0x800 + (lane) * 0x100 + 0x74)
-
-#define LYNX_28G_LNaPSS(lane)			(0x1000 + (lane) * 0x4)
-#define LYNX_28G_LNaPSS_TYPE(pss)		(((pss) & GENMASK(30, 24)) >> 24)
-#define LYNX_28G_LNaPSS_TYPE_SGMII		0x4
-#define LYNX_28G_LNaPSS_TYPE_XFI		0x28
-
-#define LYNX_28G_SGMIIaCR1(lane)		(0x1804 + (lane) * 0x10)
-#define LYNX_28G_SGMIIaCR1_SGPCS_EN		BIT(11)
-#define LYNX_28G_SGMIIaCR1_SGPCS_DIS		0x0
-#define LYNX_28G_SGMIIaCR1_SGPCS_MSK		BIT(11)
+#define LNaRGCR0(lane)				(0x800 + (lane) * 0x100 + 0x44)
+#define LNaRGCR0_USE_PLLF			0x0
+#define LNaRGCR0_USE_PLLS			BIT(28)
+#define LNaRGCR0_USE_PLL_MSK			BIT(28)
+#define LNaRGCR0_N_RATE_MSK			GENMASK(26, 24)
+#define LNaRGCR0_N_RATE_FULL			0x0
+#define LNaRGCR0_N_RATE_HALF			0x1000000
+#define LNaRGCR0_N_RATE_QUARTER			0x2000000
+#define LNaRGCR0_N_RATE_MSK			GENMASK(26, 24)
+
+#define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
+
+#define LNaRECR0(lane)				(0x800 + (lane) * 0x100 + 0x50)
+#define LNaRECR1(lane)				(0x800 + (lane) * 0x100 + 0x54)
+#define LNaRECR2(lane)				(0x800 + (lane) * 0x100 + 0x58)
+
+#define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
+
+#define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
+#define LNaPSS_TYPE(pss)			(((pss) & GENMASK(30, 24)) >> 24)
+#define LNaPSS_TYPE_SGMII			0x4
+#define LNaPSS_TYPE_XFI				0x28
+
+#define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
+#define SGMIIaCR1_SGPCS_EN			BIT(11)
+#define SGMIIaCR1_SGPCS_DIS			0x0
+#define SGMIIaCR1_SGPCS_MSK			BIT(11)
 
 struct lynx_28g_priv;
 
@@ -150,19 +150,19 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 }
 
 #define lynx_28g_lane_rmw(lane, reg, val, mask)	\
-	lynx_28g_rmw((lane)->priv, LYNX_28G_##reg(lane->id), \
-		     LYNX_28G_##reg##_##val, LYNX_28G_##reg##_##mask)
+	lynx_28g_rmw((lane)->priv, reg(lane->id), \
+		     reg##_##val, reg##_##mask)
 #define lynx_28g_lane_read(lane, reg)			\
-	ioread32((lane)->priv->base + LYNX_28G_##reg((lane)->id))
+	ioread32((lane)->priv->base + reg((lane)->id))
 #define lynx_28g_pll_read(pll, reg)			\
-	ioread32((pll)->priv->base + LYNX_28G_##reg((pll)->id))
+	ioread32((pll)->priv->base + reg((pll)->id))
 
 static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
 {
 	int i;
 
 	for (i = 0; i < LYNX_28G_NUM_PLL; i++) {
-		if (LYNX_28G_PLLnRSTCTL_DIS(priv->pll[i].rstctl))
+		if (PLLnRSTCTL_DIS(priv->pll[i].rstctl))
 			continue;
 
 		if (test_bit(intf, priv->pll[i].supported))
@@ -181,7 +181,7 @@ static struct lynx_28g_pll *lynx_28g_pll_get(struct lynx_28g_priv *priv,
 	for (i = 0; i < LYNX_28G_NUM_PLL; i++) {
 		pll = &priv->pll[i];
 
-		if (LYNX_28G_PLLnRSTCTL_DIS(pll->rstctl))
+		if (PLLnRSTCTL_DIS(pll->rstctl))
 			continue;
 
 		if (test_bit(intf, pll->supported))
@@ -199,9 +199,9 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 				    struct lynx_28g_pll *pll,
 				    phy_interface_t intf)
 {
-	switch (LYNX_28G_PLLnCR1_FRATE_SEL(pll->cr1)) {
-	case LYNX_28G_PLLnCR1_FRATE_5G_10GVCO:
-	case LYNX_28G_PLLnCR1_FRATE_5G_25GVCO:
+	switch (PLLnCR1_FRATE_SEL(pll->cr1)) {
+	case PLLnCR1_FRATE_5G_10GVCO:
+	case PLLnCR1_FRATE_5G_25GVCO:
 		switch (intf) {
 		case PHY_INTERFACE_MODE_SGMII:
 		case PHY_INTERFACE_MODE_1000BASEX:
@@ -212,7 +212,7 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 			break;
 		}
 		break;
-	case LYNX_28G_PLLnCR1_FRATE_10G_20GVCO:
+	case PLLnCR1_FRATE_10G_20GVCO:
 		switch (intf) {
 		case PHY_INTERFACE_MODE_10GBASER:
 		case PHY_INTERFACE_MODE_USXGMII:
@@ -242,20 +242,20 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 
 static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
 {
-	u32 lane_offset = LYNX_28G_LNa_PCC_OFFSET(lane);
 	struct lynx_28g_priv *priv = lane->priv;
+	u32 lane_offset = LNa_PCC_OFFSET(lane);
 
 	/* Cleanup the protocol configuration registers of the current protocol */
 	switch (lane->interface) {
 	case PHY_INTERFACE_MODE_10GBASER:
-		lynx_28g_rmw(priv, LYNX_28G_PCCC,
-			     LYNX_28G_PCCC_SXGMII_DIS << lane_offset,
+		lynx_28g_rmw(priv, PCCC,
+			     PCCC_SXGMII_DIS << lane_offset,
 			     GENMASK(3, 0) << lane_offset);
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
-		lynx_28g_rmw(priv, LYNX_28G_PCC8,
-			     LYNX_28G_PCC8_SGMII_DIS << lane_offset,
+		lynx_28g_rmw(priv, PCC8,
+			     PCC8_SGMII_DIS << lane_offset,
 			     GENMASK(3, 0) << lane_offset);
 		break;
 	default:
@@ -265,15 +265,15 @@ static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
 
 static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 {
-	u32 lane_offset = LYNX_28G_LNa_PCC_OFFSET(lane);
+	u32 lane_offset = LNa_PCC_OFFSET(lane);
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_28g_pll *pll;
 
 	lynx_28g_cleanup_lane(lane);
 
 	/* Setup the lane to run in SGMII */
-	lynx_28g_rmw(priv, LYNX_28G_PCC8,
-		     LYNX_28G_PCC8_SGMII << lane_offset,
+	lynx_28g_rmw(priv, PCC8,
+		     PCC8_SGMII << lane_offset,
 		     GENMASK(3, 0) << lane_offset);
 
 	/* Setup the protocol select and SerDes parallel interface width */
@@ -295,25 +295,25 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGPCS_EN, SGPCS_MSK);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x00808006, priv->base + LYNX_28G_LNaTECR0(lane->id));
-	iowrite32(0x04310000, priv->base + LYNX_28G_LNaRGCR1(lane->id));
-	iowrite32(0x9f800000, priv->base + LYNX_28G_LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LYNX_28G_LNaRECR1(lane->id));
-	iowrite32(0x00000000, priv->base + LYNX_28G_LNaRECR2(lane->id));
-	iowrite32(0x00000000, priv->base + LYNX_28G_LNaRSCCR0(lane->id));
+	iowrite32(0x00808006, priv->base + LNaTECR0(lane->id));
+	iowrite32(0x04310000, priv->base + LNaRGCR1(lane->id));
+	iowrite32(0x9f800000, priv->base + LNaRECR0(lane->id));
+	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
+	iowrite32(0x00000000, priv->base + LNaRECR2(lane->id));
+	iowrite32(0x00000000, priv->base + LNaRSCCR0(lane->id));
 }
 
 static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 {
-	u32 lane_offset = LYNX_28G_LNa_PCC_OFFSET(lane);
 	struct lynx_28g_priv *priv = lane->priv;
+	u32 lane_offset = LNa_PCC_OFFSET(lane);
 	struct lynx_28g_pll *pll;
 
 	lynx_28g_cleanup_lane(lane);
 
 	/* Enable the SXGMII lane */
-	lynx_28g_rmw(priv, LYNX_28G_PCCC,
-		     LYNX_28G_PCCC_10GBASER << lane_offset,
+	lynx_28g_rmw(priv, PCCC,
+		     PCCC_10GBASER << lane_offset,
 		     GENMASK(3, 0) << lane_offset);
 
 	/* Setup the protocol select and SerDes parallel interface width */
@@ -335,12 +335,12 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGPCS_DIS, SGPCS_MSK);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x10808307, priv->base + LYNX_28G_LNaTECR0(lane->id));
-	iowrite32(0x10000000, priv->base + LYNX_28G_LNaRGCR1(lane->id));
-	iowrite32(0x00000000, priv->base + LYNX_28G_LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LYNX_28G_LNaRECR1(lane->id));
-	iowrite32(0x81000020, priv->base + LYNX_28G_LNaRECR2(lane->id));
-	iowrite32(0x00002000, priv->base + LYNX_28G_LNaRSCCR0(lane->id));
+	iowrite32(0x10808307, priv->base + LNaTECR0(lane->id));
+	iowrite32(0x10000000, priv->base + LNaRGCR1(lane->id));
+	iowrite32(0x00000000, priv->base + LNaRECR0(lane->id));
+	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
+	iowrite32(0x81000020, priv->base + LNaRECR2(lane->id));
+	iowrite32(0x00002000, priv->base + LNaRSCCR0(lane->id));
 }
 
 static int lynx_28g_power_off(struct phy *phy)
@@ -359,8 +359,8 @@ static int lynx_28g_power_off(struct phy *phy)
 	do {
 		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-	} while ((trstctl & LYNX_28G_LNaTRSTCTL_HLT_REQ) ||
-		 (rrstctl & LYNX_28G_LNaRRSTCTL_HLT_REQ));
+	} while ((trstctl & LNaTRSTCTL_HLT_REQ) ||
+		 (rrstctl & LNaRRSTCTL_HLT_REQ));
 
 	lane->powered_up = false;
 
@@ -383,8 +383,8 @@ static int lynx_28g_power_on(struct phy *phy)
 	do {
 		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-	} while (!(trstctl & LYNX_28G_LNaTRSTCTL_RST_DONE) ||
-		 !(rrstctl & LYNX_28G_LNaRRSTCTL_RST_DONE));
+	} while (!(trstctl & LNaTRSTCTL_RST_DONE) ||
+		 !(rrstctl & LNaRRSTCTL_RST_DONE));
 
 	lane->powered_up = true;
 
@@ -495,17 +495,17 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 		pll->cr0 = lynx_28g_pll_read(pll, PLLnCR0);
 		pll->cr1 = lynx_28g_pll_read(pll, PLLnCR1);
 
-		if (LYNX_28G_PLLnRSTCTL_DIS(pll->rstctl))
+		if (PLLnRSTCTL_DIS(pll->rstctl))
 			continue;
 
-		switch (LYNX_28G_PLLnCR1_FRATE_SEL(pll->cr1)) {
-		case LYNX_28G_PLLnCR1_FRATE_5G_10GVCO:
-		case LYNX_28G_PLLnCR1_FRATE_5G_25GVCO:
+		switch (PLLnCR1_FRATE_SEL(pll->cr1)) {
+		case PLLnCR1_FRATE_5G_10GVCO:
+		case PLLnCR1_FRATE_5G_25GVCO:
 			/* 5GHz clock net */
 			__set_bit(PHY_INTERFACE_MODE_1000BASEX, pll->supported);
 			__set_bit(PHY_INTERFACE_MODE_SGMII, pll->supported);
 			break;
-		case LYNX_28G_PLLnCR1_FRATE_10G_20GVCO:
+		case PLLnCR1_FRATE_10G_20GVCO:
 			/* 10.3125GHz clock net */
 			__set_bit(PHY_INTERFACE_MODE_10GBASER, pll->supported);
 			break;
@@ -536,11 +536,11 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 		}
 
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-		if (!(rrstctl & LYNX_28G_LNaRRSTCTL_CDR_LOCK)) {
+		if (!(rrstctl & LNaRRSTCTL_CDR_LOCK)) {
 			lynx_28g_lane_rmw(lane, LNaRRSTCTL, RST_REQ, RST_REQ);
 			do {
 				rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-			} while (!(rrstctl & LYNX_28G_LNaRRSTCTL_RST_DONE));
+			} while (!(rrstctl & LNaRRSTCTL_RST_DONE));
 		}
 
 		mutex_unlock(&lane->phy->mutex);
@@ -554,12 +554,12 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 	u32 pss, protocol;
 
 	pss = lynx_28g_lane_read(lane, LNaPSS);
-	protocol = LYNX_28G_LNaPSS_TYPE(pss);
+	protocol = LNaPSS_TYPE(pss);
 	switch (protocol) {
-	case LYNX_28G_LNaPSS_TYPE_SGMII:
+	case LNaPSS_TYPE_SGMII:
 		lane->interface = PHY_INTERFACE_MODE_SGMII;
 		break;
-	case LYNX_28G_LNaPSS_TYPE_XFI:
+	case LNaPSS_TYPE_XFI:
 		lane->interface = PHY_INTERFACE_MODE_10GBASER;
 		break;
 	default:
-- 
2.34.1


