Return-Path: <linux-kernel+bounces-677635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A90CAD1CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 14:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B30E7A4573
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 12:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF762566F5;
	Mon,  9 Jun 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QF08ff1h"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058692550B3;
	Mon,  9 Jun 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749471185; cv=fail; b=tK+QmfjD4aRjO/Pqz4zxPNMi4O97/yg4bghJ7AjkaRF9L5F9VFs6PTz+oU2H7O9D8qney5x1Aahkna9SBOrm9GTIj2136MOSJMxxuNUPs0tLjfO4fkFNW+N7vYVJ0aUyhYKd7/Y9orgZzOp5lFJWhg5UAx4EXNIRjcZomW2R/SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749471185; c=relaxed/simple;
	bh=t40cmaha6ipJo0AH+2OyiPNpIjHDl7OZeUBk7v55T6s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HpjklwE34aUdMWvHC4aFqfnzwbQmhM5TDgA1Zif773Tf+iBK7qSJszuQGnLsvOmdFF6ZcjVfogfRAR5T0/2uGsrSGvw5rVCngQmaDfxcGmUrdwUQj6WikYI6MLn1pjUJUcMo3lyboAlSQakstfk79GewaWaQLZgDzA8pm6gEORk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QF08ff1h; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2jyrM0UKNE6WGFXoHtcdOyMkQjIFcOlaqVWeYUsiYt3uokmUZbriRKyYm8moUxZKKReml6NrzvgUWi4trddR27/86bSgHq+lgUk/cYZf5IpPTPLAoQA9BsefAS0AYOmhm8waWvu9eBfBHaCQlE2IwQVzBYL+GxlUVQV7PHnRYMh4A96MIdDRO9170aGVHDbp7Xo719n3mXzWZNxF0jZgXiqyNDLM+i3Gs8eQXmtPWw8ZOiksJa7usxksz9nrvsCBxxwjlSam+z9TqUUQrzqDjOsOlWf0xz/qrFE7Ai23hLrvig0tyd026qXYg23EwqIYiwWhdOxE7XtO7xUfbOB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKTHUJzaqJ7iOnzEAz8ylKhwoyebarNEyFVcISo8rRc=;
 b=JhC33clSpLP1iFpwYT7NP3Z3Q4oVY30+BDST/OdcZIBk5swBsqzuTLLXHjF5SpLLVKUPrwFSLGsU/GSkDaiJW4Of75jhyAaCOJcnLil1HuyfvmoMoNiXZOe2vowIcbGkby92gRNvaM309MJZa8fpbHJvvCsCMYWsofSa8HN4DdIBJYTPQY3cTiXP2t1+uRYpUvrTd+8LFxz1+9FU2/BYpcL02+VCBL1zcDWMmWBTqCjwlth7PT99xoAH1s6Vd4GlfGJdcIoLhDmqYX3sEXjSJw4uMwELiPX3Y+VrkYAjXCRabSXv+7cDd2YiEEFK38D2KINKixVNTcVNhkDDHov1DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKTHUJzaqJ7iOnzEAz8ylKhwoyebarNEyFVcISo8rRc=;
 b=QF08ff1h6lKGXlhmjNkZ2/qkA0xHVWLsuU5J+N/CT2WqR10qF1s/C0AeUpGC596d+833K1TX3RG/m+9YdfbjSmlnMFsj/73Ze4wHWB+/qVGGHpjki+a+p4Bo1OJ2NkOIyO7SbBikHzGtK8Ud7362KGLuze5ccVBBzTi0VbP57qI=
Received: from CH0PR03CA0231.namprd03.prod.outlook.com (2603:10b6:610:e7::26)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Mon, 9 Jun
 2025 12:13:01 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::98) by CH0PR03CA0231.outlook.office365.com
 (2603:10b6:610:e7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Mon,
 9 Jun 2025 12:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 12:13:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 07:13:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 07:13:00 -0500
Received: from r9-mach.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 9 Jun 2025 07:12:57 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>,
	<mario.limonciello@amd.com>, <yung-chuan.liao@linux.intel.com>, "Venkata
 Prasad Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER
 MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: Fix pointer assignments for snd_soc_acpi_mach structures
Date: Mon, 9 Jun 2025 17:42:32 +0530
Message-ID: <20250609121251.639080-1-venkataprasad.potturu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: a000bee0-2270-429a-9f79-08dda74efae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xkx6jexUzzN70C1o37UaJyYWQGP4B1FwDeLyuWNPWx9GS1AyduNUcAgxwy6f?=
 =?us-ascii?Q?hnZmesgduj7IxD2WZ0/bIZ2P18bFBxguStoal77RO51ZabLl+enmv0ukzUAO?=
 =?us-ascii?Q?fFlnwdRRemQcymmZjb77CGONiv2ZY/PB2xp+4LLQjsHgUHEjm/kRQlKMDyCd?=
 =?us-ascii?Q?OITHioB3vPx29q7W6mqJbw84QAAXsUQx1rOelnqvB7W4mO1BlP5VwztCdBH1?=
 =?us-ascii?Q?mjZDhAYg03oZE7FXnRq4+Vn+pBtvOSMMgSQh5BKYcUbE9ffYkvAFpwd7m+9R?=
 =?us-ascii?Q?wbT1D1V66ns0kVrugt/sHqjplwhDuCc8TcO21jOVvGLvLX7cw8zp3Iuehwly?=
 =?us-ascii?Q?oOMfkWBCUTAFN3cjUumu2bWIQBljqNuGWs7wKHixEsSO7dJ4yQmxyv0ZlyRM?=
 =?us-ascii?Q?E2iV9Lp9NVCm6nhILX5nPxakQx9kNOy3dMrLgrXN+iW1Undrqnyv5sFNQ4Ec?=
 =?us-ascii?Q?u5mAnknKu2LB3/cidtX2qwHzBSEsHvjoDqfhBull7hhfUTAq0GMZqyIaY1wq?=
 =?us-ascii?Q?F1Vf1UObsGApu8F6T0lDlT5YIYDx4bAPRbEsn+7ykTaUQR2pi3ZGHd5SQ0Rs?=
 =?us-ascii?Q?U0M21SrSeKGXvQaWd9qSIdFZL8ALwMlCFbZdPpDHp4rJnxK3uS077/T94xU4?=
 =?us-ascii?Q?F6MbFl2pqRSoPpGfrJ+m+HkAafz/64H+Zn1BweEL+wNvO7djTEKzxaBka8Jy?=
 =?us-ascii?Q?w7xdtZskx/w1u3f5zsghCMUx33nASLdXZOQGhPkdou+hKW7Gs1fU6JBlrvy7?=
 =?us-ascii?Q?ZTRhaclM8o47zir37WlJwOCme3nEHrUuxBDqMQUmbCAPgXWH/Ma1sXHh6a9B?=
 =?us-ascii?Q?e9NMTGqJc6/D0tNxpuELRh6xAKa3/ybDdnXcB/v23cRnbvXGjoBtet8ecPSx?=
 =?us-ascii?Q?XcD8890iT38APDcthxtKPCBT3h11Te6ULGd8utQtJw2BWwv3ujZ44SVnf1Pg?=
 =?us-ascii?Q?g9WSn07p7Msk+tkByJ1RxDuiMwMl5lbcg3Z5jfvq3Ss/0hp29ROFRcML/3Bo?=
 =?us-ascii?Q?OQVQKzA2qugsDs+Yi4kIvXNfOZz7P7D/bxHda7nn9wuxJ7+bfgR8WFeP8Nl/?=
 =?us-ascii?Q?2XR/QJhDKdRaUyz0KGkWkTdxXAqx7QBDdI0qUrTKkdKvsWuLYODcPH9Zs3+j?=
 =?us-ascii?Q?tyUE6UF3kZ3EvkMcwarM7L/TU2t3K82dI0Mu2zbqLmwXipPQllydUdWCd4hd?=
 =?us-ascii?Q?jfND8bkNPzNHgjcQfI7BirlxuGVZ0UcyOXClpwDDk0dVupoBHlOM75uExRdN?=
 =?us-ascii?Q?+aB2AWz72wQ2gUnlSFAU6RQYUvRVx6JnDAtWGiU4taoCx2XvJ6Q2FK6icFr4?=
 =?us-ascii?Q?CrmhaPuRXv+cCf+Vczljq1cac56UsBUwZeATJfA698W7cb6z0dSN8KNJAw/o?=
 =?us-ascii?Q?7z76GjITKGWPitNqWiTnWCUDCiTUZfZMwNj87NZBjnpmqQ36QhFuZgnYtWll?=
 =?us-ascii?Q?TG5EAmUvXl1gR5eMNQvrKJcHQBIX2/vhwhbC9ePNR+aT6PKV6zw840+76VK8?=
 =?us-ascii?Q?RVZ0kIEzXQfwlvyW+eQtUmXFbWKj6cylw8/y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:13:01.4723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a000bee0-2270-429a-9f79-08dda74efae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

This patch modifies the assignment of machine structure pointers in the
acp_pci_probe function. Previously, the machine pointers were assigned
using the address-of operator (&), which caused incompatibility issues
in type assignments.

Additionally, the declarations of the machine arrays in amd.h have been
updated to reflect that they are indeed arrays (`[]`). The code is
further cleaned up by declaring the codec structures in
amd-acpi-mach.c as static, reflecting their intended usage.

error: symbol 'amp_rt1019' was not declared. Should it be static?
error: symbol 'amp_max' was not declared. Should it be static?
error: symbol 'snd_soc_acpi_amd_acp_machines' was not declared. Should it be static?
error: symbol 'snd_soc_acpi_amd_rmb_acp_machines' was not declared. Should it be static?
error: symbol 'snd_soc_acpi_amd_acp63_acp_machines' was not declared. Should it be static?
error: symbol 'snd_soc_acpi_amd_acp70_acp_machines' was not declared. Should it be static?

Fixes: 9c2c0ef64009 ("ASoC: amd: acp: Fix snd_soc_acpi_mach id's duplicate symbol error")

Link: https://github.com/thesofproject/linux/issues/5438
Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-pci.c       | 8 ++++----
 sound/soc/amd/acp/amd-acpi-mach.c | 4 ++--
 sound/soc/amd/acp/amd.h           | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 0b2aa33cc426..2591b1a1c5e0 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -137,26 +137,26 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		chip->name = "acp_asoc_renoir";
 		chip->rsrc = &rn_rsrc;
 		chip->acp_hw_ops_init = acp31_hw_ops_init;
-		chip->machines = &snd_soc_acpi_amd_acp_machines;
+		chip->machines = snd_soc_acpi_amd_acp_machines;
 		break;
 	case 0x6f:
 		chip->name = "acp_asoc_rembrandt";
 		chip->rsrc = &rmb_rsrc;
 		chip->acp_hw_ops_init = acp6x_hw_ops_init;
-		chip->machines = &snd_soc_acpi_amd_rmb_acp_machines;
+		chip->machines = snd_soc_acpi_amd_rmb_acp_machines;
 		break;
 	case 0x63:
 		chip->name = "acp_asoc_acp63";
 		chip->rsrc = &acp63_rsrc;
 		chip->acp_hw_ops_init = acp63_hw_ops_init;
-		chip->machines = &snd_soc_acpi_amd_acp63_acp_machines;
+		chip->machines = snd_soc_acpi_amd_acp63_acp_machines;
 		break;
 	case 0x70:
 	case 0x71:
 		chip->name = "acp_asoc_acp70";
 		chip->rsrc = &acp70_rsrc;
 		chip->acp_hw_ops_init = acp70_hw_ops_init;
-		chip->machines = &snd_soc_acpi_amd_acp70_acp_machines;
+		chip->machines = snd_soc_acpi_amd_acp70_acp_machines;
 		break;
 	default:
 		dev_err(dev, "Unsupported device revision:0x%x\n", pci->revision);
diff --git a/sound/soc/amd/acp/amd-acpi-mach.c b/sound/soc/amd/acp/amd-acpi-mach.c
index d95047d2ee94..27da2a862f1c 100644
--- a/sound/soc/amd/acp/amd-acpi-mach.c
+++ b/sound/soc/amd/acp/amd-acpi-mach.c
@@ -8,12 +8,12 @@
 
 #include <sound/soc-acpi.h>
 
-struct snd_soc_acpi_codecs amp_rt1019 = {
+static struct snd_soc_acpi_codecs amp_rt1019 = {
 	.num_codecs = 1,
 	.codecs = {"10EC1019"}
 };
 
-struct snd_soc_acpi_codecs amp_max = {
+static struct snd_soc_acpi_codecs amp_max = {
 	.num_codecs = 1,
 	.codecs = {"MX98360A"}
 };
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 863e74fcee43..cb8d97122f95 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -243,10 +243,10 @@ extern struct acp_resource rmb_rsrc;
 extern struct acp_resource acp63_rsrc;
 extern struct acp_resource acp70_rsrc;
 
-extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines;
-extern struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_acp_machines;
-extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp63_acp_machines;
-extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_acp_machines;
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_acp_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp63_acp_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_acp_machines[];
 
 extern const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops;
 extern const struct snd_soc_dai_ops acp_dmic_dai_ops;
-- 
2.43.0


