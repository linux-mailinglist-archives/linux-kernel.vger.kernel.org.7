Return-Path: <linux-kernel+bounces-801175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6AB440DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40495A2BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC062F0699;
	Thu,  4 Sep 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YYRA+/2/"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BAE2C21D8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000664; cv=fail; b=RFQpxsOgfPj2NM4dUrmEBT5AL/IL4m0EN7uyfnLaqQtRmOd5zxA3FVwgxNBJlKVi2nmJB0/p8niDeNB0Pri4juwcalTm+o/222SPwWZ77bQyIZMQzukGk1EOvuOmuaWLM2cVWtC5GitSSeva73dgMMI9CFaIyvj+SUUf+jgXiwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000664; c=relaxed/simple;
	bh=+oAnHzB8KB+cfu4K4wfILKRSMNhIcbP/sMisnK2+OqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XqBAKQXqbgOlcYCPT10LFlj84XMF0Zpo4IAlOP5BYBQrkpqTv2iixytygSLU0w6NrBn+3T4N+vri7TglLKusNVjpOeCu5kORB7Z3INg+nher3bKTXfts47JkVdAEv6TPNn159fywsoOFR2OcO/3+grwDNNe9U9cN48oYCnlAr00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YYRA+/2/; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1j1px8wd8pL0tNfDJVnfhp1LlnHJjsedLYb4fPb2dijrq7mrWevkG92rw2rELSUSEpPL90cCYci3kfxyGsF+PdhG7J4mGGxo5OEA5mzqblbqMB51NxmhdUTMWKb+5AAUtsH3lFjltrfD3ssfLX6qtc2B7p8/59Xuwh4TxB+Vi36lt+SSGbsvQ9ofbusHeiHu46iMQh2AqVJdLrYUykGfNiEq8+a6pcqOO3lSxJjFsyxaxrz69fJIWNccCIY19lJijDwZSAhvdo078A7oclygIcTJ2xObCkkHbBQBP/O1/ThA58ZiKWpEH2YqHZB0p7q5aluAOV9FcNaZIhvtLjy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gaSJEc8OmvzBfRVKRV/E0kshVA6xf3Ow5sxXbj+BlQ=;
 b=YnOpsxXNzWJ/Q/Z26mesZCC9nOEm58hHkPgOJ0fFy7W8hQDQay+3IYfpoBoDaaKB9T7g+zhP84WedaA+RbR4PA5f3vxGoyDzLF5EIRihOxCqtwt6rG8TYz3zAZ7PsHCl/G7ZZ4TUJoAB9+qiudoqnPtvqwddl8wlPdCW2JhyhOXPkPl9GT+QFJYsaitJiT/nMJ0J/EaAqA+hxxEgk/CS6iLWXz6utnrmHajgQGI3JrRSf0MShfLrgZtgoC3AGWL5JkKbOvGvcSR0A7nQgZ19A2fKydnYE6fcioQvNnvEJfeIxqWNV2isA/X//lasdPvKU96a5UtcJEOicEHPKsG5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gaSJEc8OmvzBfRVKRV/E0kshVA6xf3Ow5sxXbj+BlQ=;
 b=YYRA+/2/Gksqwj15pAOrtwyVcTsZTUKXcOw2fFKpPUkmsSNofyvNI0r7IASkSh9q91HxMJ66S4GaQ67br0Tvd7Z01ykOjwNs862BaMFGVQQx7rBun6GsIV26hOkkESU9fYdbMUrdKAlQbfJUs9Rs25BlCFEuedxHgaPhxjiRjvljxW8brEsyCx2UFliUVIGub7ikR0l+9zpcw97Old++u3m6SReJefz8At5n4znwCnjyioUJ+HBQDxTwYI9C2GJbthHjgPf5rozQgxXmkhIlnQObnaPWvtemgqLOAnf7ZFXU3+zRwvbalXao4XRMgG3vZi+SX1RTh1h4PBlNi3e4dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7635.eurprd04.prod.outlook.com (2603:10a6:20b:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 15:44:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 15:44:15 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 05/14] phy: lynx-28g: restructure protocol configuration register accesses
Date: Thu,  4 Sep 2025 18:43:53 +0300
Message-Id: <20250904154402.300032-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904154402.300032-1-vladimir.oltean@nxp.com>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0060.eurprd03.prod.outlook.com (2603:10a6:208::37)
 To AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 31186487-011c-4f42-b485-08ddebc9e6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lGbkWHzHinSVLaaFja3zGXOUTNfVB4Ge/FkhaRw/i6JtXpPEbsim3dBfadAH?=
 =?us-ascii?Q?fSk/YrEvv+hCeFJcC4JCJ0qe8zAyhMS1UjOFAYTfuYp0SFIYobJxh5sT4rVd?=
 =?us-ascii?Q?r32r0sM9vvQkoFwyGuZsE++F7W6vzGQTFKUiVwsyVFgi2jMm8SvEPqnjj8CE?=
 =?us-ascii?Q?Qq8yQMZ3i6H69ZoObv1uj4aAo03l4/4Yek39GqrzfvyDwuUXwQNu+Ka7AVMo?=
 =?us-ascii?Q?JTyjYtU+yuVobIj9LokwmRvE4n0nVm6hJsbIwxybKsm3vRQbwue/HIgM5oDh?=
 =?us-ascii?Q?n83OpAQFR9NOKQtuvlF/cm/Fg9c4FnBkFwtpfz64NB5h4A+n0pAdtrhnJszI?=
 =?us-ascii?Q?bL1mHF/Hq30oGNAQ67uu3t14H8BaqXU7uxEIg1o/AHM6NVoKUfzQdpjRPMTg?=
 =?us-ascii?Q?ktXi6gWv3KTKKRFYpyt5atxOJQVhvgO2ObjNHEK+9iqqZDpfmJ2lh5d0LQeT?=
 =?us-ascii?Q?OsKx5zG3PvP82etjUbU23LoLk3tiBNSOE55zUoUD3I5by+9YpxLkrEy167m+?=
 =?us-ascii?Q?+t2tiA4wR/nfI9vcYB9gnZtJwCFU7D6r2ulusRi+oWHiAJ/rDBBz0YCySgXn?=
 =?us-ascii?Q?BPiz/XilaGSH9iidBlx+5+a3xlhnehTYI2d0Xh9vhExVCaby76CGRfFz0S04?=
 =?us-ascii?Q?EYUCEnJyvsv4VtkpboHBpuVX0fM5PFlVVF6wSEDRdFZ7l9CFjDhw55lTQiVQ?=
 =?us-ascii?Q?wPvVIjQbybR92DrtNFn4Ff0Am6e2X7WDVdBMP4vmcTKeVqkkwBykharV8LYE?=
 =?us-ascii?Q?ENuEwe8b2vUt+sApZeyspY4CY/X5bfGVjIY460ZZ3n11bJbUdFd3oWxGpyQV?=
 =?us-ascii?Q?AqZO0R/dQ3p7CBPUAAVNpdM1kN87eAYuW9HELcjeDU63kazGgOAcALcCW8+0?=
 =?us-ascii?Q?8n7mR4G4mVhgE3UUA0Rvxt8QbZQA7aLgrLylOJ1bwt8ViQDsw/UbRky4+0og?=
 =?us-ascii?Q?mVZa9ttHMf1tg37RnXCoAT9IK3dRoUE46a/cfPefPr6pskrTrYLvxf4qF63z?=
 =?us-ascii?Q?reEvhutdvnRvdKaIoxkcMYXPWxwX/viSmqRAzbEuVZ0iQrQPXq0yjN+qbDAO?=
 =?us-ascii?Q?AugViXIwYbbTtr7db/fD1BzvSg1yBa894pYqWIsy4SmbLft90d1XGbyqEu4A?=
 =?us-ascii?Q?6xxlpEj6Mm1cSek9gvDSGCBPEDLyDspmSuFrYM6fOzBqeIwdoXTxzI3E6IWg?=
 =?us-ascii?Q?j2EtpdaO2fZEGWmuvghGvirQ4PFK0wK3IYOyLV3aOfwUUOD/H6Vhq/I1GaCw?=
 =?us-ascii?Q?gvC9TzoKNhFGUrEUB9wT5O7DSr4n7kCJ0QQqlqDuS2BwQ69gvmVSoNz8+4Qh?=
 =?us-ascii?Q?qzP5afMhAL7VnOQRWGUr5S4Ftm3jzEpb6ceEsNyI3UzBSi5FYCZfzf5e+KX3?=
 =?us-ascii?Q?RGVavIW8rnAPqlHMvin2neurvg2ATuQdYoZn+Vu+TB7tnDjufHHd/ZrnbIVY?=
 =?us-ascii?Q?Rxpxej1EMbNwfMEAarDOdpaSoaLuBtLhWzntRQA9LJG47bUDIc3Dww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ieovRtpkCJIxvIG+V5BHS8GpVL3hjmmis65L8ayBKxT70ETYP1fom9+xWDp3?=
 =?us-ascii?Q?sfHcDlVHu/47mHCkuI+4fiUxH0Ux+04DbOJjk1YwZ3d/rmLCtLMdpwb+odcD?=
 =?us-ascii?Q?t4TVgftVNAycUg2HxVxGnAQbY5GNFKiVJIDDadUD8lgP+a98BvhlRNU6m42T?=
 =?us-ascii?Q?XVmTBbudUt/q9rM0WuTWBEyYjfB5lc70tEk4yTBryEROmu5oiifJkW4NDP2S?=
 =?us-ascii?Q?I3BNM30WNhvWy1EbvYK6Xgv8WUEHrsRYIWbs26beDuPRS3z98hIhyR+NdpFg?=
 =?us-ascii?Q?GgHekdhLtuWPOdc+Sa1f84lYX4oDDniC9v8bVnQlQk1KRZfU2sc1s7wwISV5?=
 =?us-ascii?Q?AjR86O4E2CDWrmZDCD7mpSwDUmSGl+RuVsA6++AxPd1LiBidYWXBqVJniAjW?=
 =?us-ascii?Q?dZu0hWhukRSMXvxGqZ59yZv+Rwn1Dm8vYENBw8ES41xfmnksEu3eShj2fk8p?=
 =?us-ascii?Q?ErS2eu+iqaM/ZXSQSCLvSELSl9vZ6uPSP895HK0Ew3RN0Mm7dOfIu6NOs+Qg?=
 =?us-ascii?Q?GEOgup+5yPclYC0QdtGVw+fsDErcQHb5SPsKg5FG9ym1FL9drAH2MR0T80/i?=
 =?us-ascii?Q?0/+Lic4C3OufarK4ugh9CAj1EZ0DsC7jWENHDnbYmbmBRtBCagnfBD4jSF43?=
 =?us-ascii?Q?bBcgq+EWCN0OISOVgYVuWWRxVy6fafUsBcLmXWnbtGkjg6wEzrZe5miwvIzB?=
 =?us-ascii?Q?6IbQx1WblYJRhFV4aS775JcBUAJRwv1rbc1E7+vNB5NzhMEdUz4G1kju+PNn?=
 =?us-ascii?Q?+NLQTFdlkrFpRcm7s5uhXkN3RJODpnA8Tt2XvpMxl52HYnYu6ALPjRfuzNw3?=
 =?us-ascii?Q?oztgsxh+9Xn8uOpwWWPk67vD6wGQooALoFYmkSoOIF4ibW1Un4BrF9tcJA8w?=
 =?us-ascii?Q?oK01oTqeXRQXfSwNYbUbeWY5vCBV58kVqfhAS6h8EmJ0cO0vTbHpxWn9+oD2?=
 =?us-ascii?Q?R/cdjEhopg1cQxJLuBqdqDlCM/FR3JMtSyVaUM+0LkQfYqMNpovY9WBnfQHe?=
 =?us-ascii?Q?q7jDjI7CM2vzbsfAPP4s6QipcFbU0VusUbqX8dzuPhl7RbdyX0qNAW3mPevV?=
 =?us-ascii?Q?Ra+DsAb/W8fhpZMc/Xorz/fo1hmzTO8DUjDnGSpwevMhwdUNIFVIu+fTJ6lO?=
 =?us-ascii?Q?sO1MMBFS1nb1z5+FUUrxF55l+MhQ7AycHG0OEHm/4LxVGfr49cq+XbmerpBg?=
 =?us-ascii?Q?FugiC/k/Hk9ax6wsV+q134Mtr4awvYsdQrH0NCZ26JK/a0wSqPaJAcLd8ij0?=
 =?us-ascii?Q?ImWaIHYHKFz+mMZx3iX/CA0ph0JzInTMyaDzSMbBvIoog/lML72YJQO3wt6i?=
 =?us-ascii?Q?57Mgtc9vj87hwPhwqG5+nHU8jrlKRrB6gAhxDaZfU5uBqvw1MqXZM9d91Jd9?=
 =?us-ascii?Q?c/yjrOjzds1/Ny2I52hrD9VXjmGO1/X7OgIOOTBoW4Fpbld/F6tDcXr3UD8S?=
 =?us-ascii?Q?mCIOH2m6LqNnQARsl7LFfUxIxIK36lt2hxjUehXosdfLSxmdjVdbWKcm08yK?=
 =?us-ascii?Q?FI1fESmxFeJP+QE9inZoLut7zt5dwUzvxqmj/xKXrVp3GUwFtsc7aIUXNvfj?=
 =?us-ascii?Q?hkIRzVtf1XhgwYGhLsAT8hZcEhXESWfKE0B831+LXmer+gL1iXzV5Y4mJH+J?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31186487-011c-4f42-b485-08ddebc9e6bc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:15.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCW7vnXNODxyaCM8lPFDs+Z7zYG1FGfEUVnTJn4Kgj/9P8vm4r2nVBPd4Z+Q9bRqKU92oVf1mfC9bLy+7pNzfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

Eliminate the need to calculate a lane_offset manually, and generate
some macros which access the protocol converter corresponding to the
correct lane in the PCC* registers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 55 ++++++++++++++----------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 60a7d1a63dd7..911c975040a3 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -12,17 +12,32 @@
 #define LYNX_28G_NUM_LANE			8
 #define LYNX_28G_NUM_PLL			2
 
+#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
+
 /* General registers per SerDes block */
 #define PCC8					0x10a0
-#define PCC8_SGMII				0x1
-#define PCC8_SGMII_DIS				0x0
+#define PCC8_SGMIInCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
+#define PCC8_SGMIInCFG_EN(lane)			PCC8_SGMIInCFG(lane, 1)
+#define PCC8_SGMIInCFG_MSK(lane)		PCC8_SGMIInCFG(lane, GENMASK(2, 0))
+#define PCC8_SGMIIn_KX(lane, x)			((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
+#define PCC8_SGMIIn_KX_MSK(lane)		PCC8_SGMIIn_KX(lane, 1)
+#define PCC8_MSK(lane)				PCC8_SGMIInCFG_MSK(lane) | \
+						PCC8_SGMIIn_KX_MSK(lane)
 
 #define PCCC					0x10b0
-#define PCCC_10GBASER				0x9
-#define PCCC_USXGMII				0x1
-#define PCCC_SXGMII_DIS				0x0
-
-#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
+#define PCCC_SXGMIInCFG(lane, x)		(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
+#define PCCC_SXGMIInCFG_EN(lane)		PCCC_SXGMIInCFG(lane, 1)
+#define PCCC_SXGMIInCFG_MSK(lane)		PCCC_SXGMIInCFG(lane, GENMASK(2, 0))
+#define PCCC_SXGMIInCFG_XFI(lane, x)		((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
+#define PCCC_SXGMIInCFG_XFI_MSK(lane)		PCCC_SXGMIInCFG_XFI(lane, 1)
+#define PCCC_MSK(lane)				PCCC_SXGMIInCFG_MSK(lane) | \
+						PCCC_SXGMIInCFG_XFI_MSK(lane)
+
+#define PCCD					0x10b4
+#define PCCD_E25GnCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCCD_OFFSET(lane))
+#define PCCD_E25GnCFG_EN(lane)			PCCD_E25GnCFG(lane, 1)
+#define PCCD_E25GnCFG_MSK(lane)			PCCD_E25GnCFG(lane, GENMASK(2, 0))
+#define PCCD_MSK(lane)				PCCD_E25GnCFG_MSK(lane)
 
 /* Per PLL registers */
 #define PLLnRSTCTL(pll)				(0x400 + (pll) * 0x100 + 0x0)
@@ -315,20 +330,21 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
 {
 	struct lynx_28g_priv *priv = lane->priv;
-	u32 lane_offset = LNa_PCC_OFFSET(lane);
 
 	/* Cleanup the protocol configuration registers of the current protocol */
 	switch (lane->interface) {
 	case PHY_INTERFACE_MODE_10GBASER:
-		lynx_28g_rmw(priv, PCCC,
-			     PCCC_SXGMII_DIS << lane_offset,
-			     GENMASK(3, 0) << lane_offset);
+		/* Cleanup the protocol configuration registers */
+		lynx_28g_rmw(priv, PCCC, 0, PCCC_MSK(lane));
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
-		lynx_28g_rmw(priv, PCC8,
-			     PCC8_SGMII_DIS << lane_offset,
-			     GENMASK(3, 0) << lane_offset);
+		/* Cleanup the protocol configuration registers */
+		lynx_28g_rmw(priv, PCC8, 0, PCC8_MSK(lane));
+
+		/* Disable the SGMII PCS */
+		lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
+
 		break;
 	default:
 		break;
@@ -337,16 +353,13 @@ static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
 
 static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 {
-	u32 lane_offset = LNa_PCC_OFFSET(lane);
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_28g_pll *pll;
 
 	lynx_28g_cleanup_lane(lane);
 
 	/* Setup the lane to run in SGMII */
-	lynx_28g_rmw(priv, PCC8,
-		     PCC8_SGMII << lane_offset,
-		     GENMASK(3, 0) << lane_offset);
+	lynx_28g_rmw(priv, PCC8, PCC8_SGMIInCFG_EN(lane), PCC8_MSK(lane));
 
 	/* Setup the protocol select and SerDes parallel interface width */
 	lynx_28g_lane_rmw(lane, LNaGCR0,
@@ -391,15 +404,13 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 {
 	struct lynx_28g_priv *priv = lane->priv;
-	u32 lane_offset = LNa_PCC_OFFSET(lane);
 	struct lynx_28g_pll *pll;
 
 	lynx_28g_cleanup_lane(lane);
 
 	/* Enable the SXGMII lane */
-	lynx_28g_rmw(priv, PCCC,
-		     PCCC_10GBASER << lane_offset,
-		     GENMASK(3, 0) << lane_offset);
+	lynx_28g_rmw(priv, PCCC, PCCC_SXGMIInCFG_EN(lane) |
+		     PCCC_SXGMIInCFG_XFI(lane, 1), PCCC_MSK(lane));
 
 	/* Setup the protocol select and SerDes parallel interface width */
 	lynx_28g_lane_rmw(lane, LNaGCR0,
-- 
2.34.1


