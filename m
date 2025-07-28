Return-Path: <linux-kernel+bounces-747769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095A8B137EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021A63BC9CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38E52580EC;
	Mon, 28 Jul 2025 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="physhgb8"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E925A34B;
	Mon, 28 Jul 2025 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695776; cv=fail; b=NknZ1Jf7i3aA7HiJBCI824g0iRU1mj7lphOfL7Cm233Yfn1n+XQWIDZDjHgclQdEqomnTYDkhzJUIgASEx5GMDkKclkPth2FHPZrd6QEdn5RtNzlsjHe2ZRvA4VuhAd7Z3JV5/YWZAfAdZ5y8Rs9XwSzuQ1as3KXimghCd41Sfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695776; c=relaxed/simple;
	bh=Ac/e3WOlI1BK6L0MOb2bSDzeMco9hftuTLwPesefgWY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bgbvgkX5zi7KolsuqOWWSMrbtQS89/UemJGAjo3DfBfagRB4WB2SVDK55+VfUUpOzPD9bd5DY38/tXlhG0nwVaiCYlHciIXXxggk4mWzNenTsrMKO3ZAlWMGnfBnPMjMjGC4N1cQe9WHLJOkGj6sqB1xgPuemUCxm5h41HwGEkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=physhgb8; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xa2kh30wh+lqIiLhKApbecNn3bei5HYllMnVXTLWmayUS4Ekhfz63Ytlt1NLA6fIyoHVMeDF3rZz5YzbOiYrNhINGA/Ibuw3n2VUYMjr0uaS0f8H+NJIcB0E0TBw0cwx60jWapVxG7eAwcpnkkAtYSpfmGOSXgjG1Wcw6EbsX2lPtNFni3mW+/CSAD+iSXOxmuvQorBSm0GlR3M4AbT8uMBN6WR5DfTc9V1nYW2Y72y1ec86B/p1kZfVQP75x1ggeXckmnqwZmel924xcZTsyU57NP1jZjAWGp4fnM+4bt5xMKkadhN8Re1t/qXbiaCwTOzIpUqws/3zF55zE0vQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3exCClgwMZGUEiF2WOxyqU1W7XFOhZdQBiEwgfAbFEU=;
 b=CjDdLn+QcSE2PHmWB7wq9/Jy36AYwSMlSRhqtZSWyup2kf7/FDslDQvWJjblncjV9XXQXltHUOXDLykJ7P7Z4zq71zzgA7VsB+Hj9+dwx6jB1LwIH5udreM5nWaethHKejSn9xTxuUQjwZTVHBjvZ4F93iYSEL86Lo/iKRaEI2SmIkU7detpRDscvugLQ65QVNuYWqVqWKd25SSI1QqBiDLQhINeEOK9QbHSxCgPv2t/HjUNGtSAHaLToIX1oNmhdu2JtpD06NWyuAfm8XP0hv7nKMNYSnmOptkNC8s7gIBiZjUTRBMm4L4clTQDvSrLU1MZc2kbsCrwhdLRG/vV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3exCClgwMZGUEiF2WOxyqU1W7XFOhZdQBiEwgfAbFEU=;
 b=physhgb8BKYfRcCLRU1TbETTIOmDdZgd8MxMQmAp43fI6qQl31NmI91w0tELAwrz5kvxSRVU7RYje687kQji/8zS0jmOTsSjheCS5pycvtjGkssNVZj11S1YvgLzuuQC5vdJrqiZifwqXQrBs3wOgiU2kDm2N82l4yn3PxTlABg=
Received: from CH0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:610:11a::32)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.26; Mon, 28 Jul 2025 09:42:51 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::df) by CH0PR03CA0346.outlook.office365.com
 (2603:10b6:610:11a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.25 via Frontend Transport; Mon,
 28 Jul 2025 09:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 09:42:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 04:42:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 04:42:48 -0500
Received: from r9-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Jul 2025 04:42:44 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: Adjust pdm dmic gain using module parameter
Date: Mon, 28 Jul 2025 15:12:27 +0530
Message-ID: <20250728094243.3824450-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkataprasad.potturu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f052d3-51a3-4d80-48cf-08ddcdbb1d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M7N0dtsqisR71kn8TKAfdAsTgdR3blfJu2SL2VMIBlXKPeWfzX2qSOkxqtFO?=
 =?us-ascii?Q?oO40h3LTu77McRDJ1YIzXlyuyiu7Z7Sj6jB7qRDLeL1G6g0cmFVfo6CrHM15?=
 =?us-ascii?Q?4c+6V5yPfVgy2MXzQ2oxZht20OK5gOQ1SsFyJ4pk9B3PSru/qoLPG4ML3w1Z?=
 =?us-ascii?Q?y9xgTd/83N8Uq+uWeft44SJaL/4hx6k0gNZfweE+DbQLlFKoPLKwRrEaJk9/?=
 =?us-ascii?Q?MI9cB1GZDMSrt3B2/A1+v7xg13bSnNXJiqZYhHoYRwCIVMXOIg7ElVyZ421P?=
 =?us-ascii?Q?ukLCa8X4/wXeo5o0h7nAXYSOLGw06Znc7TZAjuyAixyig8VRwyGOSNjESmmA?=
 =?us-ascii?Q?lAFlmiULbG5PhQaumnu+pXBW9zdG8sn7OzEhgNIQU+9AaxYPEL0xdUffI4GK?=
 =?us-ascii?Q?dtHs9ytK5WFMrdT5YOzNvJP83s8bJ1uHNT1jEX/UdZFdDW8ZVaTYyYEDAVrp?=
 =?us-ascii?Q?Sq8fqqTFN5eme4sHbDtkpwA8+SBn5XD6l13Cng+kZibA5u6qRf0ASpvZ1Lgh?=
 =?us-ascii?Q?V9I6sOXVk2MuyLv848xVynGWswg0wQFKJ4o3HSRYxdzimPpjuWegGO5zW+51?=
 =?us-ascii?Q?LTXT+NNSFCVnyU5YzzYV9f8TmNhAY94rQYw5+W2XHBiSbkbIsxxEchOxXdxK?=
 =?us-ascii?Q?X0my9UWF7iaNzkVgm3bj0rZPPLAqVFdf+gk9mD65iHfx4tMIKeydP7oiNrka?=
 =?us-ascii?Q?Ib9AlpFfwTXCiA8DNNKw/Jb1zg1/GxR7VXptDl3ENreNWjyNsOly7uQVSq2d?=
 =?us-ascii?Q?ldxeF2n6QvudlWVGi9vGfZbbHAJTSjIRWs8RQnvu0222FST4yutCijIuCD8O?=
 =?us-ascii?Q?G86xtGTtb0fB/HSNxCxTLE3XYLOHRfockLSHsMgi4djmeaYUtofKaVaZL5Dr?=
 =?us-ascii?Q?HIFz4N6Deg21b3OFOzJeERQviBcwqT7qCydvnXdmmS5Bha8RZTpCl1QKaq0o?=
 =?us-ascii?Q?L2yDCHlgGv/tLdxKt3yaS0pdDIXN15R0T60aNYiuMt5cEZdufKNiDNJytrYL?=
 =?us-ascii?Q?EIvjx+o+1s0eEeimXPr+pdeGYDdUkfi06xYnE7+2GOY8FhZN9WXatkGy51mP?=
 =?us-ascii?Q?DX1Qoj1L3HYX86BNoeJHffdJsS1fnUDeo23/YXFP2bML2i0AVZehKPisuyz9?=
 =?us-ascii?Q?kGMCGP6ohlTWTRCCkKxTdAG4Nh6FfQI0+t+cAwmbzR76ce3IQQNmZ4ALn29D?=
 =?us-ascii?Q?FtLjU+rLT4mQzF3MUGq/fhk7jJlYoY2pfJftvCJ6wAxafi/ZmxVkZvHRhBCg?=
 =?us-ascii?Q?IIySpU5tVBKL1xvC246uXWQMmVR5Vuk7M1l2DlnIKuvlAs0YE1jz6qv+Ldx1?=
 =?us-ascii?Q?MRZWq+Pxf6Vc9K2W6S//qABkzGJsVyQLnXAlS8ARXei/pqlMTsayy5qi53+E?=
 =?us-ascii?Q?r9qzuCx6rPKI5T7aTt0PGBnXf8+AEaXTXZiXUC/RMOs08ugwu0n/ze2zmvAv?=
 =?us-ascii?Q?iIRShse9a/d4fy3etFyhAmBB3Etl0Pt+qsLDuWG2R4NRuDIuhh2cXJxVsF27?=
 =?us-ascii?Q?lRBZ7IX4+8ecOpUBHAyM5p97t6k9Up/lQIRE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 09:42:49.4571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f052d3-51a3-4d80-48cf-08ddcdbb1d95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

Adjust pdm dimc gain value using module param.
In case of regressions for any users that the new pdm_gain value is
too high and for additional debugging, introduce a module parameter
that would let them configure it.

This parameter should be removed in the future:
 * If it's determined that the parameter is not needed, just hardcode
   the correct value as before
 * If users do end up using it to debug and report different values
   we should introduce a config knob that can have policy set by ucm.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-legacy-common.c | 3 ++-
 sound/soc/amd/acp/acp-pdm.c           | 3 ++-
 sound/soc/amd/acp/amd.h               | 6 +++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 57982d057c3a..dd804fb95790 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -173,7 +173,8 @@ static void set_acp_pdm_clk(struct snd_pcm_substream *substream,
 	/* Enable default ACP PDM clk */
 	writel(PDM_CLK_FREQ_MASK, chip->base + ACP_WOV_CLK_CTRL);
 	pdm_ctrl = readl(chip->base + ACP_WOV_MISC_CTRL);
-	pdm_ctrl |= PDM_MISC_CTRL_MASK;
+	pdm_ctrl &= ~ACP_WOV_GAIN_CONTROL;
+	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, clamp(pdm_gain, 0, 3));
 	writel(pdm_ctrl, chip->base + ACP_WOV_MISC_CTRL);
 	set_acp_pdm_ring_buffer(substream, dai);
 }
diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
index 1bfc34c2aa53..ffb622a7a69a 100644
--- a/sound/soc/amd/acp/acp-pdm.c
+++ b/sound/soc/amd/acp/acp-pdm.c
@@ -38,7 +38,8 @@ static int acp_dmic_prepare(struct snd_pcm_substream *substream,
 	/* Enable default DMIC clk */
 	writel(PDM_CLK_FREQ_MASK, chip->base + ACP_WOV_CLK_CTRL);
 	dmic_ctrl = readl(chip->base + ACP_WOV_MISC_CTRL);
-	dmic_ctrl |= PDM_MISC_CTRL_MASK;
+	dmic_ctrl &= ~ACP_WOV_GAIN_CONTROL;
+	dmic_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, clamp(pdm_gain, 0, 3));
 	writel(dmic_ctrl, chip->base + ACP_WOV_MISC_CTRL);
 
 	period_bytes = frames_to_bytes(substream->runtime,
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index cb8d97122f95..f2567e06ccd3 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -130,7 +130,7 @@
 #define PDM_DMA_INTR_MASK       0x10000
 #define PDM_DEC_64              0x2
 #define PDM_CLK_FREQ_MASK       0x07
-#define PDM_MISC_CTRL_MASK      0x10
+#define ACP_WOV_GAIN_CONTROL	GENMASK(4, 3)
 #define PDM_ENABLE              0x01
 #define PDM_DISABLE             0x00
 #define DMA_EN_MASK             0x02
@@ -138,6 +138,10 @@
 #define PDM_TIMEOUT             1000
 #define ACP_REGION2_OFFSET      0x02000000
 
+static int pdm_gain = 3;
+module_param(pdm_gain, int, 0644);
+MODULE_PARM_DESC(pdm_gain, "Gain control (0-3)");
+
 struct acp_chip_info {
 	char *name;		/* Platform name */
 	struct resource *res;
-- 
2.43.0


