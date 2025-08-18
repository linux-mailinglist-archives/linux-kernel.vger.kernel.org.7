Return-Path: <linux-kernel+bounces-773907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7CFB2ABFA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A047A4A92
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5194246BA5;
	Mon, 18 Aug 2025 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="U9YFu4K6";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="kkrLVXwR"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF5245005;
	Mon, 18 Aug 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529231; cv=fail; b=Abbies05cjGwEODEmQ+81y9OWxi/K8YwLob0NokiSAtAblHJRy3IWE0++kuXE/sJ3OCXgd6dHJKXTc2NCty2VrHoJu3V2SL1FblWHmUWjx5MyilfSe8ZGyzIYQi1pNhVRCXcMwW1CNpIDzq4YgB7pwB3Q8J+CPO5sj0AZjkcIfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529231; c=relaxed/simple;
	bh=vOuJcZrz51TbFvIfXbRADFWl4rfINDYLAdGTeRQ9H0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kIJeDFW8GKyGvEH2IbE6OnriycRAnjib9RQR6XtYHPAossPLsdfYfeJbo7S4z4Xv1OHIXvIHZXF9O0yZQXFfNVFzHn9WOb7PhaYT9WLfUvWUxOfdp7VPzy+wuIvwB9mdhH8sIWu9sKnF8fs6X3FXVhuToSBVHY+49t7mykL6GA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=U9YFu4K6; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=kkrLVXwR; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57I9lHQv775602;
	Mon, 18 Aug 2025 10:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=E78k1+dpdHm3v+8M
	9SAvFV9XKKw09rKFf5hpXcAVMjA=; b=U9YFu4K6rZdSxchzFWscmtpdScghuwjp
	994q8K8it2ZJVu4wQQKZIjcRXrSj5xf4Jyl39AEFYGtwlAEg4zvhNUnPSsVuE5pK
	CKUGh4eJI+im5bdBfQ7lwvXJOlnKfd6wv95qQ8hOo6dgXDtZQ/a+eJLLM6NYsVc4
	JGPihpDrUNmLF/xi7WQeF8lBojLO8jIhQZYjLzpH6G8b+Yp8eQ6U3SywGhkMZ6Ih
	vjKxTF2zj24Qx9V5Z0QlcIcVOQxz5aUSAweMbyMbjzh4TO9l5aaMZLqcWgnT1tps
	uCjg6Ny+XnVwT/XoMhqvoTjjrJbXuTB2B2Ipv04NYX+ZHzSmTQAYlQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2131.outbound.protection.outlook.com [40.107.102.131])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48jwgrhxuv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:00:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FejkSSGx86B5B6MeGK+MROofyZ4R0YuzbUJPZvA/R3J/PbwoavF0ydoqFMCk2Sc5INEtVvJifcIMvahPwG3GO5VtJf1oNq/yk0HbdfzL4rrMAnuNraVHDHVy1YqVROWEDrt8p559kjAm69Dpzf4AEeV4Og4Ch04PGL6Uy2yoPnz6ZaoXsonkNHr41dWYRGQ1pEeNRV1xRtQyKTI+emHgfuxOC7ledMYWaDKM9B43Rim6vRtwu2wuVe66Xq3PBYfPC5pM3v20p4TlwDOScVSaMUB16GeqqOlkWzAt6Jkg5aPnAMAk235em7+zoUaXktegcg0RFjAbILjC6oDQuIufBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E78k1+dpdHm3v+8M9SAvFV9XKKw09rKFf5hpXcAVMjA=;
 b=lW3JSxcEMEiLJJ1Q09p7dG8HpYO8BiMI5m1zWQTQ3KhpIYZQDetj9lTPb3h6ZtW2XlKiCsmGQ+y5szeZyCtwGYOr9vmdC/r/7UH9l1E+Qo2C5y++xhJKKf5pNtlSgF4aOaAkBKl6mdiKnSU2PKFJyQRkhkJpzTqPW+xn6fvqLpv9mGX/GoGcBOPr9kInXFn1ngYpJQ0HTju0kv+uE/8EeBt48NgottaaGSZwcmlripYIsfW2p9MXHkAiiKfAddsKv5HkKZTqTCeZyjQQyPj/Xzo6AkEENFl6O3C2ujrpVwirxT10uTzGAfRc3jNijK+mlbflsx6LRdBFwbAqtyGP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E78k1+dpdHm3v+8M9SAvFV9XKKw09rKFf5hpXcAVMjA=;
 b=kkrLVXwRENOJSpu7wCedJIcBxQTpmcky/oYIMoFHkJQoo9NgJhqdKDLV7nRhSTq0xF6GBOqfEnwYWN/bXcq3vAXu6ZaqMMmCgzm1crQJ2kwDByOcxqcg/vftfDZytH5qf9R1sYgidDAAno7MBtp+A8d4II5XUdjDtdRcqPhKUKE=
Received: from SA9PR13CA0141.namprd13.prod.outlook.com (2603:10b6:806:27::26)
 by SN7PR19MB4783.namprd19.prod.outlook.com (2603:10b6:806:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 15:00:11 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::4) by SA9PR13CA0141.outlook.office365.com
 (2603:10b6:806:27::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 15:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Mon, 18 Aug 2025 15:00:09 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 41081406541;
	Mon, 18 Aug 2025 15:00:08 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 120CE820249;
	Mon, 18 Aug 2025 15:00:08 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ASoC: cs35l56: Fixes for CS35L63 for production silicon
Date: Mon, 18 Aug 2025 15:59:40 +0100
Message-ID: <20250818145952.124199-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SN7PR19MB4783:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: da73b152-00e6-4d6c-8525-08ddde67ed21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sBaeTwwMyxCaFpKpY15PTTqd/3Lzl1AwTKEE/lX0bFWRbE5nOYm/3YtYCruv?=
 =?us-ascii?Q?mylvnaxMTlyuTtkinpYRLdTWuc+lplt2pNY1DYJ4bXsdiXAQjDTYeFd0dkeE?=
 =?us-ascii?Q?M5uy3V3I+D3jtrd7LfxhPeO8RpjjK0tbC6UP9tisoknSNEINIFuWpw9CuRiO?=
 =?us-ascii?Q?C+Zscjeg9ICzo2a/iUXQb365hC/+7FnBI3q3qdP+8Y/kYLX218Q0bowniVfA?=
 =?us-ascii?Q?vVfu6/fzIH/PkCPDEnp0CZsZ96yHUeNAun1CsnYW5V7gcQ8pb+K05YU4maJj?=
 =?us-ascii?Q?4HeebaruNd3lBcpOrKAXgKYF7zQOcptMgtYtHEsG+Uf44c3qis8WU1X6ut9C?=
 =?us-ascii?Q?jTmltiz3/OJ1jQKqh3OiV+5n/peFLuTv4ivwUd5eA3OVUBWIWQ/ELmm1Fg0i?=
 =?us-ascii?Q?b5VvvdtanwXgqZZot0jVQ3sb2OaHPyfMFHm3f/HpCHJ/8U03lvhgZyEzGPMp?=
 =?us-ascii?Q?XvTVBWmIoFppj+4j3Ri8o3ASN5HTPScEAYB24DvqwaqAvnFAaKcaHICBw8mO?=
 =?us-ascii?Q?Mpbf8lxPGG5KiBIlHDjJdIBsHTBXyjPMFtAI4C1+O3W/zD6pckFv8R+0nEa/?=
 =?us-ascii?Q?85hbHk/fT7HuRv2N2C3tZleTlyVmMcDLiAWNOHJhj4xOSbxL2T9kZHAlMyr9?=
 =?us-ascii?Q?WnnUDxiKFUHhTy2OAaoPohsncNKZ/r2k7vTmZG2nkGjm5o/I7g+itLFLVtWg?=
 =?us-ascii?Q?S5f4nCKrUkG8kiM2WO6CUfZVT2hO4ckliwA/6jLm7CCurCROZxk/vg6baXLA?=
 =?us-ascii?Q?DRlP4hnlsFWqBV7TeOHqlyqNgNWLNDbE1jFnHu+ebdBG+uCLEM+lENS5jSVb?=
 =?us-ascii?Q?Oz+psOu/3GTItGXPifVa+K8E2th4/JalQOWHvNW2PFHuCpsQ2Og29rhqLTUE?=
 =?us-ascii?Q?M/K2IsZUFtck8yoZ/3AqFZNi/0OTz1YDQvuuaqhXoGfZYdffxA0sc1hmDcw1?=
 =?us-ascii?Q?39xQSKz9cthLQwomXz9E2bSIhZZdijmk1LMacAMCjTSTCEVnyGk3Fgf6FAg9?=
 =?us-ascii?Q?3onvS2u5IVCy/ql2l9ztavFWR1h+ft+iPgLEpdxBMJ3c2lG4wV6HI2FvuTrm?=
 =?us-ascii?Q?IFbn173OamA0f9ciBQA5h1HYRZyWQ8LjiY/ACHgnkKH27NP2oA+jZv0WRDD3?=
 =?us-ascii?Q?/4Hx3WoSffsQFeoznM6vJ8+2BAu/AW1pY4ngxyhK3oMBGZffEEN+stENYobt?=
 =?us-ascii?Q?F+BpnMhx3vkGGrFjZ4sI1PcJ5cKjoMPAXO/tzdzcMRFCK4CZPUPzNPMf1QMC?=
 =?us-ascii?Q?7sRasQUKkvDh0v+sT+9845ar3FHRZlAxRFr7Of5zZxX6Z/GaGEHh5bmuuf84?=
 =?us-ascii?Q?nPyT5kDF5I8nfpK+wBQYWXt3q0X0ZvNxYb+V1Gw0TIRVLDhCqMXS6gkwnMvu?=
 =?us-ascii?Q?g6TKTotRM5ijLkrToYJlW9CRhmwnxLS8QxyXCHCoKv49O/Hp4rIipGufjEwV?=
 =?us-ascii?Q?c8D6f66zyzLy9f2MVzZ4Z3tudlZyQ7tUt9ggXqF2z3i9LTpFrkoc8p4cpga8?=
 =?us-ascii?Q?cLOobQSPeiBqkLdN0SxdMD0smHzGs/9Xks2z?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:00:09.5029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da73b152-00e6-4d6c-8525-08ddde67ed21
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4783
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0MSBTYWx0ZWRfX1KIt1pkSL8qE
 VLKScMMY4PKVD9tjsLbEGg0goy0m862PC1nWG2hb7X03/3HqKKfirUEzwXs9ubum9ZfPoExKtAe
 ZJHQp2qrWFQej5Oyqm1jRzoX9d7Vxifo366Jk0X8qMRTo0PZGDGbMn0gYtXMrA3nPnWhabTNam8
 n8OvC1INJ8nMpTRz5zBAhurQQmVj5N95bPhi5NlfAUYWQ4K7eLHSsrmCc+sKfubjZkLFAcWV5PI
 gruUFHiiM4Fifsh7qUx4uytEc4jThaWElmkyI5kk5A4kzo/FNp5ORUYU6zzyoQl2XpDGozUxJXb
 3icEvo0ezqZ/g7xuNOwQtiQXGavj3K9c1OHUE1b5ck8fyggXROmGVonoXZN/3Y=
X-Proofpoint-GUID: PbnMuR-_hShOHFy1LYFAdq7PLiFVIrrG
X-Authority-Analysis: v=2.4 cv=M99NKzws c=1 sm=1 tr=0 ts=68a33fff cx=c_pps
 a=ikxvSTmorgjviMIT8H7Oxg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=2OwXVqhp2XgA:10 a=RWc_ulEos4gA:10
 a=w1d2syhTAAAA:8 a=EEvN3FwK76vxh5bl4N8A:9
X-Proofpoint-ORIG-GUID: PbnMuR-_hShOHFy1LYFAdq7PLiFVIrrG
X-Proofpoint-Spam-Reason: safe

Production silicon for CS36L63 has some small differences compared to
pre-production silicon. This requires small fixes in driver.
Update firmware addresses and remove soundwire clock workaround as no
longer necessary. In addition, different calibration and tuning
algorithm IDs are required for CS35L63.

Fixes: d3197a09a117 ("ASoC: cs35l56: Add initial support for CS35L63 for I2C and SoundWire")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  5 ++-
 sound/soc/codecs/cs35l56-sdw.c    | 69 -------------------------------
 sound/soc/codecs/cs35l56-shared.c | 29 +++++++++++--
 sound/soc/codecs/cs35l56.c        |  2 +-
 4 files changed, 30 insertions(+), 75 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index e17c4cadd04d..7c8bbe8ad1e2 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -107,8 +107,8 @@
 #define CS35L56_DSP1_PMEM_5114				0x3804FE8
 
 #define CS35L63_DSP1_FW_VER				CS35L56_DSP1_FW_VER
-#define CS35L63_DSP1_HALO_STATE				0x280396C
-#define CS35L63_DSP1_PM_CUR_STATE			0x28042C8
+#define CS35L63_DSP1_HALO_STATE				0x2803C04
+#define CS35L63_DSP1_PM_CUR_STATE			0x2804518
 #define CS35L63_PROTECTION_STATUS			0x340009C
 #define CS35L63_TRANSDUCER_ACTUAL_PS			0x34000F4
 #define CS35L63_MAIN_RENDER_USER_MUTE			0x3400020
@@ -306,6 +306,7 @@ struct cs35l56_base {
 	struct gpio_desc *reset_gpio;
 	struct cs35l56_spi_payload *spi_payload_buf;
 	const struct cs35l56_fw_reg *fw_reg;
+	const struct cirrus_amp_cal_controls *calibration_controls;
 };
 
 static inline bool cs35l56_is_otp_register(unsigned int reg)
diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index ee14031695a1..3905c9cb188a 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -393,74 +393,6 @@ static int cs35l56_sdw_update_status(struct sdw_slave *peripheral,
 	return 0;
 }
 
-static int cs35l63_sdw_kick_divider(struct cs35l56_private *cs35l56,
-				    struct sdw_slave *peripheral)
-{
-	unsigned int curr_scale_reg, next_scale_reg;
-	int curr_scale, next_scale, ret;
-
-	if (!cs35l56->base.init_done)
-		return 0;
-
-	if (peripheral->bus->params.curr_bank) {
-		curr_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B1;
-		next_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B0;
-	} else {
-		curr_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B0;
-		next_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B1;
-	}
-
-	/*
-	 * Current clock scale value must be different to new value.
-	 * Modify current to guarantee this. If next still has the dummy
-	 * value we wrote when it was current, the core code has not set
-	 * a new scale so restore its original good value
-	 */
-	curr_scale = sdw_read_no_pm(peripheral, curr_scale_reg);
-	if (curr_scale < 0) {
-		dev_err(cs35l56->base.dev, "Failed to read current clock scale: %d\n", curr_scale);
-		return curr_scale;
-	}
-
-	next_scale = sdw_read_no_pm(peripheral, next_scale_reg);
-	if (next_scale < 0) {
-		dev_err(cs35l56->base.dev, "Failed to read next clock scale: %d\n", next_scale);
-		return next_scale;
-	}
-
-	if (next_scale == CS35L56_SDW_INVALID_BUS_SCALE) {
-		next_scale = cs35l56->old_sdw_clock_scale;
-		ret = sdw_write_no_pm(peripheral, next_scale_reg, next_scale);
-		if (ret < 0) {
-			dev_err(cs35l56->base.dev, "Failed to modify current clock scale: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	cs35l56->old_sdw_clock_scale = curr_scale;
-	ret = sdw_write_no_pm(peripheral, curr_scale_reg, CS35L56_SDW_INVALID_BUS_SCALE);
-	if (ret < 0) {
-		dev_err(cs35l56->base.dev, "Failed to modify current clock scale: %d\n", ret);
-		return ret;
-	}
-
-	dev_dbg(cs35l56->base.dev, "Next bus scale: %#x\n", next_scale);
-
-	return 0;
-}
-
-static int cs35l56_sdw_bus_config(struct sdw_slave *peripheral,
-				  struct sdw_bus_params *params)
-{
-	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
-
-	if ((cs35l56->base.type == 0x63) && (cs35l56->base.rev < 0xa1))
-		return cs35l63_sdw_kick_divider(cs35l56, peripheral);
-
-	return 0;
-}
-
 static int __maybe_unused cs35l56_sdw_clk_stop(struct sdw_slave *peripheral,
 					       enum sdw_clk_stop_mode mode,
 					       enum sdw_clk_stop_type type)
@@ -476,7 +408,6 @@ static const struct sdw_slave_ops cs35l56_sdw_ops = {
 	.read_prop = cs35l56_sdw_read_prop,
 	.interrupt_callback = cs35l56_sdw_interrupt,
 	.update_status = cs35l56_sdw_update_status,
-	.bus_config = cs35l56_sdw_bus_config,
 #ifdef DEBUG
 	.clk_stop = cs35l56_sdw_clk_stop,
 #endif
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index ba653f6ccfae..850fcf385996 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -838,6 +838,15 @@ const struct cirrus_amp_cal_controls cs35l56_calibration_controls = {
 };
 EXPORT_SYMBOL_NS_GPL(cs35l56_calibration_controls, "SND_SOC_CS35L56_SHARED");
 
+static const struct cirrus_amp_cal_controls cs35l63_calibration_controls = {
+	.alg_id =	0xbf210,
+	.mem_region =	WMFW_ADSP2_YM,
+	.ambient =	"CAL_AMBIENT",
+	.calr =		"CAL_R",
+	.status =	"CAL_STATUS",
+	.checksum =	"CAL_CHECKSUM",
+};
+
 int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base)
 {
 	u64 silicon_uid = 0;
@@ -912,19 +921,31 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_read_prot_status, "SND_SOC_CS35L56_SHARED");
 void cs35l56_log_tuning(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp)
 {
 	__be32 pid, sid, tid;
+	unsigned int alg_id;
 	int ret;
 
+	switch (cs35l56_base->type) {
+	case 0x54:
+	case 0x56:
+	case 0x57:
+		alg_id = 0x9f212;
+		break;
+	default:
+		alg_id = 0xbf212;
+		break;
+	}
+
 	scoped_guard(mutex, &cs_dsp->pwr_lock) {
 		ret = cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(cs_dsp, "AS_PRJCT_ID",
-							    WMFW_ADSP2_XM, 0x9f212),
+							    WMFW_ADSP2_XM, alg_id),
 					     0, &pid, sizeof(pid));
 		if (!ret)
 			ret = cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(cs_dsp, "AS_CHNNL_ID",
-								    WMFW_ADSP2_XM, 0x9f212),
+								    WMFW_ADSP2_XM, alg_id),
 						     0, &sid, sizeof(sid));
 		if (!ret)
 			ret = cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(cs_dsp, "AS_SNPSHT_ID",
-								    WMFW_ADSP2_XM, 0x9f212),
+								    WMFW_ADSP2_XM, alg_id),
 						     0, &tid, sizeof(tid));
 	}
 
@@ -974,8 +995,10 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 	case 0x35A54:
 	case 0x35A56:
 	case 0x35A57:
+		cs35l56_base->calibration_controls = &cs35l56_calibration_controls;
 		break;
 	case 0x35A630:
+		cs35l56_base->calibration_controls = &cs35l63_calibration_controls;
 		devid = devid >> 4;
 		break;
 	default:
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index b1c65d8331e7..2c1edbd636ef 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -695,7 +695,7 @@ static int cs35l56_write_cal(struct cs35l56_private *cs35l56)
 		return ret;
 
 	ret = cs_amp_write_cal_coeffs(&cs35l56->dsp.cs_dsp,
-				      &cs35l56_calibration_controls,
+				      cs35l56->base.calibration_controls,
 				      &cs35l56->base.cal_data);
 
 	wm_adsp_stop(&cs35l56->dsp);
-- 
2.43.0


