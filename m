Return-Path: <linux-kernel+bounces-807241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79790B4A1F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2793C16928C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D293019B3;
	Tue,  9 Sep 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PaQyXekD"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9218A93F;
	Tue,  9 Sep 2025 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398818; cv=fail; b=nzPHzjIREnZMCuYLLBdYhT8Ott2bq/do1FgDAKjQl1R2qs6dO29gtvlaVufppkt1lehTBU7eioR9/UPviKhJBDBw3uLfWROn/uQkhUomrob3SLaFf4hqYtnT20o9ykzIIWujTpUFweWTiLlAAMy+8T7/3jrwUb4TJ1DizmXFJKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398818; c=relaxed/simple;
	bh=RBOiKMXLv6uE2+GYYieMzqyx5eDpUmbcURXUGi5kSY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E58luswdPsnueF9W+v5/x4FPD3ia19Evs1ruhiUuVjMCfE4AXRcp1shU+ljX5dBJqvaW8HxoaCoaIbNsxRlTAlhiFMrkf6VJLQkKHTxFG/3jh8p6Q43XdVlhlRkmznXTLHrSHDfJV1T9FXePOnFZXNq8C6lYlYRa+WkO6bPTcH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PaQyXekD; arc=fail smtp.client-ip=40.107.100.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQkbzzWUGAiwelegFW1vFl13LtOPrEGwMEoLzC2cGQRTSdZz9yGaoi+8m3R/vfZPelVI6JKfov0h31fNkYv+mU4i82YPiKJrP4830Lqpz0nNVzVH9+87rLYyBWJGOIKNEaFAw/0tBXy5VPT/JI1mwLG/MjsfFvg6C6233oQfGdQAlCpzp4lnAT1jRsh/OndUzkJJPu0r/oFnPXbQt/il/O5lG3XSLgU37C2u8PcOp9OZvatzY9ZHsFgjkwf/UVg1M3qrj1R6LQmaLD7kFmxNm4rhQ74D2vX1UfsLixyLCkdj6+11nb+rQi/nSq0nLT9+a60jujSlX7rK4qYGx6TmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0UGYSPyT+PTQVjFy04USbvvntQIu7mNnkD9kwYJzLM=;
 b=pCbw9IEkNBhxsCNujxWffVSQ6ETpXFpgO7XCsvVnBni5obmpY1pq9Z4HNLk4gZMkL1vqRyShln1+pyaiqU0zZ5SwusBFqei9WpLdkyUzE+Cr0kpWBncNgSNVNLLb6e5nw46ifC4ZBp03L+VwKFxjBxK5HFqueni+R8xBt5PjGZedmdBGxiNlGSx6q1BOn6YrPAv6QE2xlKO51dYfcPs9Pp2O//Q/EzHz2CRh3rGz1xLW5DeEjVtV8k0h8yoQFRy0eGHD+/tsqTH3LmCO7Gu6D+Q227gU++Bk1c0FtkEsLWSBt9OH1HmIkssP7RQ67gRg0oFs/TU6Pku5mMNUlL2KhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0UGYSPyT+PTQVjFy04USbvvntQIu7mNnkD9kwYJzLM=;
 b=PaQyXekDCv+Skju0ecXsc8v8le2YPlrvJaVgJ6XyYTqMALeD1OcMuep0jOdygkt/t8etAyCF4ABuZ6SNFo227VFYwa/IX1J0zMtF4O/tLH+LR5kcsPKbLhRW5lLHG1xiCuOLRf9Us9qAFRvh7V8OMuSadO9/4t4aBu0PA+RVzhI=
Received: from DS7PR03CA0184.namprd03.prod.outlook.com (2603:10b6:5:3b6::9) by
 SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Tue, 9 Sep
 2025 06:20:10 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::3d) by DS7PR03CA0184.outlook.office365.com
 (2603:10b6:5:3b6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 06:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 06:20:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 23:20:05 -0700
Received: from r9-mach.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 23:20:00 -0700
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Daniel Baluta <daniel.baluta@nxp.com>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: Fix incorrect retrival of acp_chip_info
Date: Tue, 9 Sep 2025 11:49:50 +0530
Message-ID: <20250909061959.2881158-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 7590eb1f-7ddd-4eb1-e30c-08ddef68ede6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sm+bnQ4bSqG8sWY5n4kNzFw598JFGAwoEU1PP370v57XVCf7j5HOEp9F4h6P?=
 =?us-ascii?Q?iH37kwFbNHBgy+wtIYu11ePe170R76EmNhkGv6ACBUs9LE+VFYZpWGTZK7Ph?=
 =?us-ascii?Q?AQOhOTJLl2FFZMeMpi8q+hvsrHddVPV3N/kdV19nEF4njHKtlECG1dm1sbsu?=
 =?us-ascii?Q?bPjDNK0gQeTYDQwRF05pGPq8hXl/I4XtopE8RFgzT1TwQuvfrJqaFmRqMHG4?=
 =?us-ascii?Q?Ll89bx/7PeKNs5PnUtMjxTJjI+f6mHysNtPntjs/hcPK1Q1/5k6Vf0ixBRRE?=
 =?us-ascii?Q?puTW1+R3wHUflkqXGfe7VKYVIrKtTkE98L4uUWPEQMk6R2rwOgcQK2q5MdCG?=
 =?us-ascii?Q?cn1QiW3MdyRN9G2OnzcaELwCUZquVcDVCN+7nVyEJgWlvFIVHY03kI88W+V+?=
 =?us-ascii?Q?JJxkBuQ+UYT5ocISf+mLeuGgVaLLDheOGmNsYk9s4Wj6xQ2u6JkFyQ4PtL73?=
 =?us-ascii?Q?tIvqy6iDHcVP+Ap9kcAnnHQubxFqbhvCOIWKDfLhzmxevhbVpTuKsa/eEIZt?=
 =?us-ascii?Q?17Iee+dnUmlsuLbxm92UQDIvZzvzXg/fmy8Ea3zHy2efsNFpIkXXcuSUw5Iy?=
 =?us-ascii?Q?mhsbc2Yi1aHKRA00B9xpN0fvtA/ObaIRe8uPhKZCWvwCCg0sDNO/8wUmdTz7?=
 =?us-ascii?Q?CeAzyXH3OloiMcCnE233TUnfFbjK7oisvpsUEom8Sl5fBIW3q+uqaEIjJk4+?=
 =?us-ascii?Q?jCRmJ4dbjFFDnZyXSSsSWBzhKFpFdsRb7zOJCxAOCr1nJcRAcMOw+FAPrXJ6?=
 =?us-ascii?Q?WVRQ1dtOo16zlK1ltF1dH5FOjGrQW4CfRfe+vx6NtKJhBolvmshkxwxquO7k?=
 =?us-ascii?Q?Zad405SNta/nLyx1RlyhyUD7aDUFn1NgdPq8LMgjO/mDrNMOh3srLBhmhl7k?=
 =?us-ascii?Q?7qaTUmFuTSrDboS9jG2zIpUd2f72F4mUTUGmOd8GRSwQAW5ZvCghEPYaSLCm?=
 =?us-ascii?Q?DDpw22tndd+fyHtVt+tsItCcW28ueaWSqQYLzG679L2jJjlrWL4XYys0+jXf?=
 =?us-ascii?Q?jm3QwKcBlP0Kq1cb+P8O9ry4i26p3Bvq04LIzeSbVM0kDLlTJGGeIAHHLDQ4?=
 =?us-ascii?Q?Q5+nVQl8zktPhLEwlJKDtPDxE2VjZVGVfJEqpGGOVHuxokdSPlvkJu2pHplT?=
 =?us-ascii?Q?/W2trZMtKFg6xG7LR9RwaUcgocpwFdqBt5sLq2nkTYtUaVDirVp5G80JPSb2?=
 =?us-ascii?Q?Ae/AkZ3dMJK0kal0DbNygTaqwjajYdX89jPxnvUxz8CNPgb3LilShiooZLwb?=
 =?us-ascii?Q?DsbwGlgKpZlF3dUuDZEvG1ebRG9xQmwjIJlk70BXIhz4hsWlcEZmyRCVgE47?=
 =?us-ascii?Q?Cj07uLqaQMOBj6zIRkLn05I6HcZKk9/pj2K+/L0mdz2JBgHo8C71CuRRD7G2?=
 =?us-ascii?Q?IVQdNSAvoshi9TucfwNyTcjip/zc0637NMgHwn6xacfEzEI+Gq9z9I+pcOW1?=
 =?us-ascii?Q?JFIc2A4mG6GWzOrHkZ06mB+4fTCSMMxBONIPGOBoCptck6eyhXmcyOj8NjZv?=
 =?us-ascii?Q?gUUYStm4JEbEVDInn4kvhE+PU1J9lvlWon5A?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:20:10.2655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7590eb1f-7ddd-4eb1-e30c-08ddef68ede6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998

Use dev_get_drvdata(dev->parent) instead of dev_get_platdata(dev)
to correctly get acp_chip_info members in acp I2S driver.
This resolves issues where some members were zero due to incorrect
data access.

Fixes: e3933683b25e ("ASoC: amd: acp: Remove redundant acp_dev_data structure")

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-i2s.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index 617690362ad7..4ba0a66981ea 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -73,7 +73,7 @@ static int acp_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 			   unsigned int fmt)
 {
 	struct device *dev = cpu_dai->component->dev;
-	struct acp_chip_info *chip = dev_get_platdata(dev);
+	struct acp_chip_info *chip = dev_get_drvdata(dev->parent);
 	int mode;
 
 	mode = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
@@ -199,7 +199,7 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
 	u32 reg_val, fmt_reg, tdm_fmt;
 	u32 lrclk_div_val, bclk_div_val;
 
-	chip = dev_get_platdata(dev);
+	chip = dev_get_drvdata(dev->parent);
 	rsrc = chip->rsrc;
 
 	/* These values are as per Hardware Spec */
@@ -386,7 +386,7 @@ static int acp_i2s_trigger(struct snd_pcm_substream *substream, int cmd, struct
 {
 	struct acp_stream *stream = substream->runtime->private_data;
 	struct device *dev = dai->component->dev;
-	struct acp_chip_info *chip = dev_get_platdata(dev);
+	struct acp_chip_info *chip = dev_get_drvdata(dev->parent);
 	struct acp_resource *rsrc = chip->rsrc;
 	u32 val, period_bytes, reg_val, ier_val, water_val, buf_size, buf_reg;
 
@@ -516,14 +516,13 @@ static int acp_i2s_trigger(struct snd_pcm_substream *substream, int cmd, struct
 static int acp_i2s_prepare(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
 	struct device *dev = dai->component->dev;
-	struct acp_chip_info *chip = dev_get_platdata(dev);
+	struct acp_chip_info *chip = dev_get_drvdata(dev->parent);
 	struct acp_resource *rsrc = chip->rsrc;
 	struct acp_stream *stream = substream->runtime->private_data;
 	u32 reg_dma_size = 0, reg_fifo_size = 0, reg_fifo_addr = 0;
 	u32 phy_addr = 0, acp_fifo_addr = 0, ext_int_ctrl;
 	unsigned int dir = substream->stream;
 
-	chip = dev_get_platdata(dev);
 	switch (dai->driver->id) {
 	case I2S_SP_INSTANCE:
 		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -632,7 +631,7 @@ static int acp_i2s_startup(struct snd_pcm_substream *substream, struct snd_soc_d
 {
 	struct acp_stream *stream = substream->runtime->private_data;
 	struct device *dev = dai->component->dev;
-	struct acp_chip_info *chip = dev_get_platdata(dev);
+	struct acp_chip_info *chip = dev_get_drvdata(dev->parent);
 	struct acp_resource *rsrc = chip->rsrc;
 	unsigned int dir = substream->stream;
 	unsigned int irq_bit = 0;
-- 
2.43.0


