Return-Path: <linux-kernel+bounces-829578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BDFB97631
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A313320B77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F011E305972;
	Tue, 23 Sep 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EIFqfoZC"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CDC3054E4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656719; cv=fail; b=FxQ75bQqHp1y9T41uhGGiKijPqMdkSBxj+fuPO79mjg7PEUGSWdMWkVFc9KPC258AIe7Dllvi9/E1rcl4Th4QTnxOvyp/fQQufRQXO/MDzdBCnG9DIRM66x15G6bPUgZwQYYeS2oDCFDWA3fUm4tsizc14MkPdYl/k3WEMEF38Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656719; c=relaxed/simple;
	bh=u2Aopn6ay54/pGd0rMuhsUwb0o4gHT8LZe3V8DGibUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cEe7r7/9+th0Vjk9FAlG64zj+iNMP65n40SRScoCr8usXYQ2ycx12reDPHONebGgrf2Benu/1L7ICjCZ88PZLzVM7nRr1+DSmYsz3N/DZasFGqh9jt4x/qWHmaf/CGxfOnszKmww43+x5Ptop5y1p4p6x5921UKys8/N+E80Fms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EIFqfoZC; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+XL44ZbESTo5GaVoMpsAbr5+Wmw52a52f/rNw0X7WlxnxwGOnMUKZ2AQZ+qRi0LKTYWnILBnPPFamWPFZBLI8CwKCsjV/OgE6rFcGbdnYtg8bt8NDMM/n1Oomxt0aqxmRXhNv3cd3unxACAfQ+jlznbpaSi4bucGGD8IAl3VvBbDPNXAhtg465nk1vJ7/AXMxEFCYCqjipTvnrJZz5CHNU/jy6LNRMJJI9iKRO7JByCw8gxz7bJwFmFre1PyP5CczYwPMrHYdOD2s/xK5LGnLB/DlWCAXbvI4ZikfBU3SSZAoobn0WwQdXa0YY+865V3nD8hYI6Rw4gAZZo0a+NpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwA32ol/4M5wPuMARUc6CGZGmdYLR6/zof6abUnek40=;
 b=fHl2Bk4KsEGt/UdjyEKfbsX5C+ZL8NQGacYXqRlO1Urlw4+9mdaEmCczm5islF2TK8xgv0nA3C33NtKsDcePSzHF6WwS1m/Ua5D6fsm94w87Ixjl7V5jpzOkq+1fEhUSlK3JFWp56UTJ1nmuxFIYpSDl2YOc77+ydD+m1ZbypxwpwYyfgH+cA4JA4tgLUMO/eOoI67iw2BQM9Nhb08a1diJ/h32WDFua7YNTOTW7XFEQGQHrmnkOQ+ODj9xBuH4VXkdaGyak2ebnNLLUDBzHlWUboo+PINHx3mpBIoDF8554PmInH7JP0GZ7e6yEXi1/2N7TZmNpiPv5vz1n3gc8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwA32ol/4M5wPuMARUc6CGZGmdYLR6/zof6abUnek40=;
 b=EIFqfoZCpNt6dlKpF4/MTNHF9yNq9a6z9nebNaKjl/dby+oTrslLEYBgWTsdcKI2Am7nOc+m6cxtkjMSDHZbrGXf3t+GreucCAQ7/1x0i1Fe/pb+U2qSsVTUGA1z9dEEq5mGOgv4H+4wqVjt3b1Trvq335hmV+HBzn+661EwDkdTRo4ZvuDqtT/G0CvwfNVdabo0lgqeMfv+SH+6RWFjJ4GXzocYz/duJuIi9tyxRsqQAufNnGUp61J86B8315WES7VWrQnNNLZNAynqlpjKst0+hnpGfJJscTUn/Ulr9/AxzJ5A9paUMFQZP6YY+BaKiD++k/cI47/Q/gbIAlkiMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:11 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:11 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy 01/16] phy: lynx-28g: remove LYNX_28G_ prefix from register names
Date: Tue, 23 Sep 2025 22:44:30 +0300
Message-Id: <20250923194445.454442-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923194445.454442-1-vladimir.oltean@nxp.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: e267e501-d34e-46f8-66a2-08ddfad9b3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U41Q0uV/oWeBwvOaGE6Kv3di0r58sj25hPYhFQAmztZTPBJRiq5tyuqkmF54?=
 =?us-ascii?Q?8qbdB7E2uUgK75d3DI5hFNfNj/X2rAckxezqNCD3I9gZzV52wOyahbqoZsCH?=
 =?us-ascii?Q?5fPRvkDl7b+LNnD1DMRmNVbu7LhLmMbxW9Fyj/mWhIP2sqPo0S2Pkge34H+9?=
 =?us-ascii?Q?3o1nNnc0zkzaL4rkGVwaNy8id/PWApMoTGemP1yfcXGsVII1eK/FvRNLVjZF?=
 =?us-ascii?Q?WXikr83Gqc+gGy1iYB/JgxSYmLN3CCzn40JpMYomlKyDnDHd0g3gkuYBy61l?=
 =?us-ascii?Q?Jxn+YmwiTa1/+wXyJc6/o26LhqUHnlsmJNiMxfY1qDYA0M/DGX8h/B7gx3Ie?=
 =?us-ascii?Q?5E6L8LNE9iwKxdqfPKfSnlhf73nGW+Q+RhsebxiAy//sMIm1L+kkjkJphEDe?=
 =?us-ascii?Q?vtIVPJUA0gaQiBaPsqIroFxOdMTgB3wAbAjbGycRk9fbzmbZmVaTWsD76zOV?=
 =?us-ascii?Q?zPAZirHN5gnDhRyYe8DbbI6aJlFU/cozQNY7Ugl+WxeRa4fG+zOcgPWf6q86?=
 =?us-ascii?Q?LzrlVKpIrgPPPYl4aNZfb9JXE9aYSfnEKTQuPF9bKllI/TYRdUpTp3SJ18QT?=
 =?us-ascii?Q?mo5g2Ltc0K60Rb8dphqk2Wg/GUDo7DFKNt6sgwL5p2mgRhtQ/NcecCmoqiXx?=
 =?us-ascii?Q?YmDJ6swqboEpmwu+kDu/XSVneJZDt4Q9MUI1HLwSFCSSoR4KytxoBzp2Th7d?=
 =?us-ascii?Q?qnwO73nf88Z0nPwtSjAvC2eeNfC0tULGFriCaas2WBQbfudBy8A3IaauqS/n?=
 =?us-ascii?Q?GKS3mOxul+kFKEQOtq8L5qJ5Ek0xTc1xUQH3KW+puGXrdPr2V8qOF6W42dlN?=
 =?us-ascii?Q?ZLwGcGj0b8H8sU/MC7olwfBgSZLwuaPY/GCvsdIcz49A4KLNSrZDTYfTD7MW?=
 =?us-ascii?Q?J/ZsmhwOYPdhiC1e1ItxpuOxrXXndf/RmPmop3Bm+h76C5VIWKqWqMuiMIup?=
 =?us-ascii?Q?CX/ka5o6o2H8oXrbTQpkDYq8waMpLg3YR1aDEixIFwBMEfr4AhH60G/MCg32?=
 =?us-ascii?Q?Jn2qTqGu9umMFgkNYWeNTxw+6e6doWymjbHROOXa9vpK4HrCN4gWGYVvLtok?=
 =?us-ascii?Q?jqsJ4dX2Vx5+VhHc2peIOlLog8FJwNMaSaDRxsqaMB7CeVABcfJIyivcFODZ?=
 =?us-ascii?Q?PtnBYydb1tKc6QpDLKz+xCElqeSLrzFw3nZ+tMLzE/7ExxSRrakoqdNKbo8U?=
 =?us-ascii?Q?HyXNWEJUWVXi8X0VY0fB2PYYbHnG2ALWJIv2iKpFVtaiLg0NDsIUw8V6CVaC?=
 =?us-ascii?Q?6PZr4uuD+El7LJ5iKjOPJQ5WXFUFJq3dkxzQoymRZb43T7I8vh8bOxy1WxX+?=
 =?us-ascii?Q?uImcXos0GUbjOadJtLQicS75/zp4Jy5jwZHtalL0FvNoMRAC41oh/frFI3pg?=
 =?us-ascii?Q?KWYs3efYqvxdN3zPRriVVD/44UooAX9DJCv6UFKK1zN3MJlfbC+An9Rgw9z4?=
 =?us-ascii?Q?ggS6WYA5CY9PZupWHkLAtP73FDRRQRdcw/BpJ8u38sMbRQUhrfgIeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eGemWU4OV5+Mf9ijaP1qfD+okQvTdvwj4Jj9j8y0tLpHd7wa3Kj/zjYeTZzc?=
 =?us-ascii?Q?rixxn2w7OtzDwkvxCpwF/muI0ISvGr+g6W9YNcmAjw4jk0bP3T1ijwyB0bp/?=
 =?us-ascii?Q?6ZxE9qhfdO1Z7rJzH4R6p5QrdJ0q4/wa+Xd8FcDygCqpk11SixLUDZCMGSHn?=
 =?us-ascii?Q?qs0RvLH9aYcQMMjWT9DTBa1eMB7onxU4VTAA9owUmSkt1wZ90364s+ZSo1Li?=
 =?us-ascii?Q?DedvTSQ+r+hhvth8Zp80RvBvr2tbGCy+5sIf54tyvc4M8WoCxkQ45zW0pTb1?=
 =?us-ascii?Q?97+vzcRE9Z65IuK6KHc0TUEPMoE6wu2wSrsnx6jPx72/p4KMOh8TFVszpdmV?=
 =?us-ascii?Q?jydP7JgOArJSa437G/9UPdJKFHwiC9n9jF9v0vPdM78UXUERDfbjdwJ+OYG1?=
 =?us-ascii?Q?XwcXwvCPfD6K7YC6ducm6bVVzHNjHXyQPfW/yewamR/U+a22I6DycfcwDA1o?=
 =?us-ascii?Q?NTFwvG6p6ahZ8O6YiNSGbw/IdM2NvMQ/duzWPdlDBOV5eBeRtkq7OS/FUrvo?=
 =?us-ascii?Q?gzqJUTwWITDEL5KnsbYXXLYqF3yj/pIO2oEAG/L2+sMN80Wy7iIZj4GgKbmg?=
 =?us-ascii?Q?HCMG7knBrwCTtoD3X6QebkgYugZd+xxHFlE45wP5jIfsFxwXBStb7u96DI3z?=
 =?us-ascii?Q?d5r/22+V+T41p2p4sF865DELJt+XKZr4xUiugzvBnXEJ/oUIte0sxgwN4owP?=
 =?us-ascii?Q?yzLtKh9LoX90+80olK3/tlB+P7o8NfURH98IFu8gmRMVk09jF3KpDtf+uOBL?=
 =?us-ascii?Q?mm97hvdt/QK7MsuW6gtw6+9nLbOwK28Mk3Eaq3uVL9/cpkBupO6r9cU/ts0q?=
 =?us-ascii?Q?IxPpAdI98qVD4dpKgtVNBCimLtaN2BFYPnd/zDZp2yr2QGa/3n25fdVUALUr?=
 =?us-ascii?Q?IRytmy/cxfGhV1kAS5/GdERjqRlL21nCfCXrz0QdEmIv0UJqGTQbr13NfiIB?=
 =?us-ascii?Q?OWL3vM8vy4T3PCvkZb2kiSXiNZur5xnZxjo/7AFDlAliBq+MBEwSv6aCNFGd?=
 =?us-ascii?Q?MEQb0r3ozG5UVjjdUlCZFdXOoKF9U9P1bnKLHBH6oFTbISaG7cyrzbAuCeqo?=
 =?us-ascii?Q?CFV2dE6dTecxNtv61JYmbHDpxjvgYZX5yJO1HAQkib1FOoLb8Czw3C3pelX6?=
 =?us-ascii?Q?5sjECX5hArKFXVU6Jju7AcU7bkggDFbPDMjJPb/vlxtllt39Otrn0NUefI1m?=
 =?us-ascii?Q?gk17tECwj/vt+57fvb27ygrItIbAMNKitFA+LJ7s7vbxoZSwLdrTJfhXMYSJ?=
 =?us-ascii?Q?woN7FyzUePOdaPG+VD4CxWeE/W6irDE79D5aetH8JbGYN6J+d1ZKivirgoQi?=
 =?us-ascii?Q?2wOlMtM6YvOVhwu+y7R5CS5v7Hp5+pOmLBphfTtgP0GyDQd9o59dDMFcvpJ5?=
 =?us-ascii?Q?KenGyxn8WgMzIz/U7UF6vBk7dEg5qfyd15DawSWXGBWQtDTYux3nSviNhUhf?=
 =?us-ascii?Q?XAT8ERIo4WHThGUw5dXZgAGm+WdcoDr6sh5TjivBllOXd4jA0fs3KMsJSRI0?=
 =?us-ascii?Q?evCuzG+STt2MOwAwARbtr5To8v8P8V9YjUVry+ayk5PtcUp8jC+7YSkpae63?=
 =?us-ascii?Q?nfkLHSs5lG7rco9caa0SMyuVv6ZMZGKFI0Tfvrx5XRfiJPW1xhmYtljqSm+U?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e267e501-d34e-46f8-66a2-08ddfad9b3c1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:08.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wM6jp97a0fYmdfDi0+VazMMYIJsXT764IaHQLancTuagPi+WfQ+2+WDOoDTSAM3h3rMrocCx88TupBNK6m9RhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

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
v1->v2: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 248 +++++++++++------------
 1 file changed, 124 insertions(+), 124 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index c20d2636c5e9..4e8d2c56d702 100644
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


