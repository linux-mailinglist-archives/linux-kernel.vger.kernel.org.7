Return-Path: <linux-kernel+bounces-696528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BF3AE2867
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3C41896802
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968171F237A;
	Sat, 21 Jun 2025 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SBMQWhnp"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56B1A2632;
	Sat, 21 Jun 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750499427; cv=fail; b=t7fsieizuOUQpXMmvrpVJpoh4y2H95eRoHQAtOBqQPoJr1BcO2Nn8sddNv171aFo93eL+2uGtH68ddaLf820fZvrIyCDHQU4bG/XInEPpWUYcnM6rutQDjv2KgKGSuS5oM/ElyF8o8yJAF4TILa94DzO8E+HHrJqtGCTaQ3bneI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750499427; c=relaxed/simple;
	bh=d3oH/jm0hVley4rBqx0hTJxM90/Au7C4bLJz2I2Gozw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KDXtHTjSwUiZkGhPzLSNOvC9//uz4bZfEuXJclq4bg7C3ur3/P/NC69bbqnKb7Jgw9XrBCj72G/QthlPvsmG36IdQT7CTgY81MplFFWjWFvuwYoJd28xQSqkPoK2b6w8kBng8EutcCANKCeHqNKzBimY6QWmPbBpYaG1A0kdQj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SBMQWhnp; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yc8404Jq/l6nRSZRj7R8FAACFcX/W2QAAKIT/uuMD49mvSZucZPS5cFMbhAjyh0d35PsJT55yC+c0r/oPyTa7QT6E89T/np42sfdIlMUNe/awvxYJCnow5032rfzcZxH4MlkXWnZXpqpRRq71hxzkcGfU6tg37E2YZLJrdySDvLKp7fWq+TaM3jCFw2H3C/UyL7kDRzYaBTy8pkQQk+R4g676cF5Wansv+33Y3MLs60YxJWFC+QwOXOQw32/h7cc2GG/hR5IxtvFR59br+ML7dcYR72ncSybOSYFRQjHskXjih1wl29P13MwOGj6DUZ7e9xGGjD2fThXvm2M0f12Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aiKXv+BWPK812kC9y//HntNm4rrxvyo6Lw9cyPny2Q=;
 b=Jx0sC2A0qNR7q/nEjBxlfilo90AFhQLz+1N2qzOMcr1Qhoum6fkTZ7CrpuE7/ixCR24KVp/Pz2t+VFPZAyrD4UDsAYMkqkPIjJitCLw5iOCTfOjjnuRTuUb81urlfMzR0Q8G3QhQ4oOod3cY8qT6kv0zVheYT70Oh4bzkPYSDKUszWfWpPsaNVJA6IwJrxZHIc3Ewg+mX4+YZ/Wn3TZfO3KHkqf2LS/yYFXAXwe0oWJ70AWNV5y04RZ6dDilFWiNPlCvBCOq2SnS5fTXSso8KXm/EFNEasd/7HrihPlRRL2f17WasC7VYg0miaRQqoirA0Ywh+YXRkpSu7i+ZBsXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aiKXv+BWPK812kC9y//HntNm4rrxvyo6Lw9cyPny2Q=;
 b=SBMQWhnpYFFqye8SS5BMxAeljstkMWplZLG04orRp5fffU+Zhpg87/RZyz5foj5WGbsgQ7xvp8/hadSBW1HP/CcFF/mB4SSb45c3I+Ux9wUFnPvQRYkNVp/6ymg9Zlmprtt6DPu5Jq05B9DEp0Qnxe9wCqt0DzRnkBN4TsxoIJU=
Received: from SJ0PR03CA0367.namprd03.prod.outlook.com (2603:10b6:a03:3a1::12)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Sat, 21 Jun
 2025 09:50:20 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::18) by SJ0PR03CA0367.outlook.office365.com
 (2603:10b6:a03:3a1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 09:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Sat, 21 Jun 2025 09:50:20 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 21 Jun
 2025 04:50:16 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: amd: ps: fix for soundwire failures during hibernation exit sequence
Date: Sat, 21 Jun 2025 15:17:34 +0530
Message-ID: <20250621095002.1336167-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 85143ffb-33fe-47c5-2b71-08ddb0a9090a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6p5xWJ5h8oQfl1o3wwo6ssYA2k7n0g1tm7eJZKGmbHyQOzSzeqeKzpU/iyja?=
 =?us-ascii?Q?F37+492QBRgE7z7S5w1QNWMfFy601TN0A/QtZUSW76y5i+0G5zx++Ls+Sy2t?=
 =?us-ascii?Q?p6bkf3De1R9XNI0TTFmBhYLGmm1m1YEnITOhCCC//kyIT6vL+HGD1hHzB3jK?=
 =?us-ascii?Q?NnNxNPFjRZaHe0PUMVmbi3H5EPQX30/Nk+sRhXx1pQQAhKaBCT51HEZfBnJR?=
 =?us-ascii?Q?aKwa9XkKY7U3yKUYdmpOqpVkuvSBqKVzb3m5rcKGwkYGuT9/g9Sud5i9zB6T?=
 =?us-ascii?Q?j60/M3HMn7crfFhwithS9SccuScY7m6eOpoac2gGK5vcG6QRGqxTmbosYVkX?=
 =?us-ascii?Q?YSTU6D2njjophywWU/kpiHF6mQEmJRDjFRUG3CnaclHOS/rDtaMr1bZ/3l3a?=
 =?us-ascii?Q?csmbafei5Vyhj7/0aAg3ToUTUN8/+OGETldggfBoRWDLhemaiw24KJxekVf1?=
 =?us-ascii?Q?iOSK4pcmIXdASk0Ac/o4HXT7SbQeD8dLbHgf7ZfRxCIT8wMeKxpnuc/eyqhb?=
 =?us-ascii?Q?zF46T7UQ5JVdzrA0hW6PhWSipWD8c2Acn8mJPffF/DFQANqLzXFPFNdfyfF9?=
 =?us-ascii?Q?tTsknV5wFIhyyJMXF5jmiVirD7VQxJycVYe8NdniZeJnb50kEpzqU4oFDRCM?=
 =?us-ascii?Q?hwVfGZQrCN84GleE814efQyhoNfG+gI9iAfDNF2ouB2BWVMbD1BTA6U6cMqJ?=
 =?us-ascii?Q?6262RaPvIRCyK7br5iqMV6pEhPyxpzHTSz4MKSFLyz3Wl4YXKOTpNNPILesa?=
 =?us-ascii?Q?wN5YzHfaPdJpEuKBiW+tOVYl/8I0wSDALdQt+cStzjVHbQzzFDm5Kqsiru83?=
 =?us-ascii?Q?aqp/ELy07+bUiLELfKf609fgZ+RuafumiRRzCFN8Cyy50QbqIsRRrobZaRjT?=
 =?us-ascii?Q?R1VheFFb3ok1yyS8z1EXo8OkMAqVamCOpelGC5lQFaaS6+GGNTWPNiXNm+3I?=
 =?us-ascii?Q?A3NR30jBPVxbryo1qrC1XDbEYEbeUg0VYPZr1QPXx9Eid5gRFN0jIPVJPLXD?=
 =?us-ascii?Q?/xnbzEGkpjjCPY9sY0IB8pXhUGtpayC39x24//PJ16uB6BoCaWZ0U9vwoeoz?=
 =?us-ascii?Q?/yrQllcKfud6Pdh8ro+4JSM6VYSH7aQw0eWfLSUlhJeOl7bTc9fYBXVeYdG/?=
 =?us-ascii?Q?fTO8n5KFX9gn81SEg/eMoubfwtvF0TmxRTADcRxKR9s+g40eHYBWJXYZ+7di?=
 =?us-ascii?Q?B9cEB/EuuIH2tSjvfpcVQsokPrOMCv+DUA78Ilu6T545UkSxMfrFEDEBclYd?=
 =?us-ascii?Q?HeOUp+Ddjx+cN2tCy3KwZAoO0QaHFmvf/Xg4ZYivtKH2N9m7ywgwWyllVDzn?=
 =?us-ascii?Q?fZ3yPij+m0rMO6SGd7fDx4RtNaHsuOE0rOf1xyGFJNRdD5QPz8hMx5wtgfqq?=
 =?us-ascii?Q?NahOk/sYzYHyreSPQHQS9bckb/LA5zZ4wM4zZMA+IS9LMnTZUDkYi/4SPm+v?=
 =?us-ascii?Q?Bren9QzRIgxcBuRpqrYYnjBV+uWWRhMzb3WjZSX+cAodJKP4Q1X4q0E33IMe?=
 =?us-ascii?Q?yF65wNjc5+1DKwewcJb1ou3tQUyl6bFjkiAo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 09:50:20.2763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85143ffb-33fe-47c5-2b71-08ddb0a9090a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643

During the hibernate entry sequence, ACP registers will be reset to
default values and acp ip will be completely powered off including acp
SoundWire pads. During resume sequence, if acp SoundWire pad keeper enable
register is not restored along with pad pulldown control register value,
then SoundWire manager links won't be powered on correctly results in
peripheral register access failures and completely audio function is
broken.

Add code to store the acp SoundWire pad keeper enable register and acp pad
pulldown ctrl register values before entering into suspend state and
restore the register values during resume sequence based on condition check
for acp SoundWire pad keeper enable register for ACP6.3, ACP7.0 & ACP7.1
platforms.

Fixes: 491628388005 ("ASoC: amd: ps: add callback functions for acp pci driver pm ops")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h     |  5 +++++
 sound/soc/amd/ps/ps-common.c | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 85feae45c44c..babf2fa7ea27 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -82,6 +82,7 @@
 #define ACP63_SDW0_DMA_MAX_STREAMS	6
 #define ACP63_SDW1_DMA_MAX_STREAMS	2
 #define ACP63_P1_AUDIO_TX_THRESHOLD	6
+#define ACP_SW_PAD_KEEPER_EN		0x0001454
 
 /*
  * Below entries describes SDW0 instance DMA stream id and DMA irq bit mapping
@@ -334,6 +335,8 @@ struct acp_hw_ops {
  * @addr: pci ioremap address
  * @reg_range: ACP reigister range
  * @acp_rev: ACP PCI revision id
+ * @acp_sw_pad_keeper_en: store acp SoundWire pad keeper enable register value
+ * @acp_pad_pulldown_ctrl: store acp pad pulldown control register value
  * @acp63_sdw0-dma_intr_stat: DMA interrupt status array for ACP6.3 platform SoundWire
  * manager-SW0 instance
  * @acp63_sdw_dma_intr_stat: DMA interrupt status array for ACP6.3 platform SoundWire
@@ -367,6 +370,8 @@ struct acp63_dev_data {
 	u32 addr;
 	u32 reg_range;
 	u32 acp_rev;
+	u32 acp_sw_pad_keeper_en;
+	u32 acp_pad_pulldown_ctrl;
 	u16 acp63_sdw0_dma_intr_stat[ACP63_SDW0_DMA_MAX_STREAMS];
 	u16 acp63_sdw1_dma_intr_stat[ACP63_SDW1_DMA_MAX_STREAMS];
 	u16 acp70_sdw0_dma_intr_stat[ACP70_SDW0_DMA_MAX_STREAMS];
diff --git a/sound/soc/amd/ps/ps-common.c b/sound/soc/amd/ps/ps-common.c
index 1c89fb5fe1da..f18d2a0d83aa 100644
--- a/sound/soc/amd/ps/ps-common.c
+++ b/sound/soc/amd/ps/ps-common.c
@@ -160,6 +160,8 @@ static int __maybe_unused snd_acp63_suspend(struct device *dev)
 
 	adata = dev_get_drvdata(dev);
 	if (adata->is_sdw_dev) {
+		adata->acp_sw_pad_keeper_en = readl(adata->acp63_base + ACP_SW_PAD_KEEPER_EN);
+		adata->acp_pad_pulldown_ctrl = readl(adata->acp63_base + ACP_PAD_PULLDOWN_CTRL);
 		adata->sdw_en_stat = check_acp_sdw_enable_status(adata);
 		if (adata->sdw_en_stat) {
 			writel(1, adata->acp63_base + ACP_ZSC_DSP_CTRL);
@@ -197,6 +199,7 @@ static int __maybe_unused snd_acp63_runtime_resume(struct device *dev)
 static int __maybe_unused snd_acp63_resume(struct device *dev)
 {
 	struct acp63_dev_data *adata;
+	u32 acp_sw_pad_keeper_en;
 	int ret;
 
 	adata = dev_get_drvdata(dev);
@@ -209,6 +212,12 @@ static int __maybe_unused snd_acp63_resume(struct device *dev)
 	if (ret)
 		dev_err(dev, "ACP init failed\n");
 
+	acp_sw_pad_keeper_en = readl(adata->acp63_base + ACP_SW_PAD_KEEPER_EN);
+	dev_dbg(dev, "ACP_SW_PAD_KEEPER_EN:0x%x\n", acp_sw_pad_keeper_en);
+	if (!acp_sw_pad_keeper_en) {
+		writel(adata->acp_sw_pad_keeper_en, adata->acp63_base + ACP_SW_PAD_KEEPER_EN);
+		writel(adata->acp_pad_pulldown_ctrl, adata->acp63_base + ACP_PAD_PULLDOWN_CTRL);
+	}
 	return ret;
 }
 
@@ -408,6 +417,8 @@ static int __maybe_unused snd_acp70_suspend(struct device *dev)
 
 	adata = dev_get_drvdata(dev);
 	if (adata->is_sdw_dev) {
+		adata->acp_sw_pad_keeper_en = readl(adata->acp63_base + ACP_SW0_PAD_KEEPER_EN);
+		adata->acp_pad_pulldown_ctrl = readl(adata->acp63_base + ACP_PAD_PULLDOWN_CTRL);
 		adata->sdw_en_stat = check_acp_sdw_enable_status(adata);
 		if (adata->sdw_en_stat) {
 			writel(1, adata->acp63_base + ACP_ZSC_DSP_CTRL);
@@ -445,6 +456,7 @@ static int __maybe_unused snd_acp70_runtime_resume(struct device *dev)
 static int __maybe_unused snd_acp70_resume(struct device *dev)
 {
 	struct acp63_dev_data *adata;
+	u32 acp_sw_pad_keeper_en;
 	int ret;
 
 	adata = dev_get_drvdata(dev);
@@ -459,6 +471,12 @@ static int __maybe_unused snd_acp70_resume(struct device *dev)
 	if (ret)
 		dev_err(dev, "ACP init failed\n");
 
+	acp_sw_pad_keeper_en = readl(adata->acp63_base + ACP_SW_PAD_KEEPER_EN);
+	dev_dbg(dev, "ACP_SW_PAD_KEEPER_EN:0x%x\n", acp_sw_pad_keeper_en);
+	if (!acp_sw_pad_keeper_en) {
+		writel(adata->acp_sw_pad_keeper_en, adata->acp63_base + ACP_SW0_PAD_KEEPER_EN);
+		writel(adata->acp_pad_pulldown_ctrl, adata->acp63_base + ACP_PAD_PULLDOWN_CTRL);
+	}
 	return ret;
 }
 
-- 
2.45.2


