Return-Path: <linux-kernel+bounces-748716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B9BB1453F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6353C17C1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E977483;
	Tue, 29 Jul 2025 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QzOuCsZd"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECFEC4;
	Tue, 29 Jul 2025 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753748220; cv=fail; b=ti2lQ3OO19P5F/sC943AXBCDMDxPBD6cAjj3uR72rMd3skrdDBYYNJwSPYlIV2BHCPAhDejLSi8rUDhPjny6viHPhzQC6L/H+7TEREyP4ICWG0V+E9UIi/cQxjSS83B6Qd3D/xkR74eHyQ/bhmQNx3QYk3Sg375XeKWpmAEDS9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753748220; c=relaxed/simple;
	bh=9MPXrP9mRmPwT9X74vVAgQAU/Cmcr9yHQ5lGRll2jr8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OT4e4HYzZazDxkjwsi93I/JgHBpASLsg1YKeh+FfNCVc2mhs4fS+TdzWTCrExIDfWaeow9X1Y4dxIUfShPPfUhk4gBWfzVRXpoS9PVwEFW2L8MrqlVNLag8RiLHeQtOOSB6ii92jVe9RU3MD84lqRs7sIixSDZyhO6rioPAS4+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QzOuCsZd; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ov8RZV1qhcUweUi44FnrIGceTrZ4IkdzB+pY98O6+phnqAdJGaprf/0oaO+LpxAnck9E/7Z6T/QBaGw+1bWEojJaWewf5PCQX3g0W8Vm6qcTZMFqAeQiiMJEtSVzM7pMuQtlMV/RioPqzpz5KgDZ2SBhU7wyH4HhKd9oEqOJMWVMx9Qou7wDiW35zh09yBGs3M9wAZk0k+1UZDqISDyhT5wqKP9XRUpnC5A+pxEajtrF97f2HDE+h7TSMJijO8f2fz7TxqWU5JbBOGKUuwOTeiOSkVHDa74akjcSxbLTnq76oJl+RlXCjIa4RLFUbbQOJXN+ulVHbK9cYAm7dyR2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a10CziVtIabPURgOc2T4qFWOtNL9pOHr8LFyLlEtcDo=;
 b=K+fPPYoQF/PdZ8SLY/zWlV71BbrVbSKuShWabehRUG753dR6HDFuZw5pwwZz5oi+7636bHSxFFSJWutAGQl87mwGm21gpgx0KNvDELcQb2yOYLseP0uzuMSWxiHgl3h910wwaOykGnvPkxXUFSgomGHQNGXVmwltEQaAae2jkxQNFnMyxZ8X+kaA9h3qr6Syc+UkUTk4fRRerNz1pahOH7Lnk6K0iaSLkC/SfMIvO+5KE0luC20x60Np12s3biAb1Gypr9/GQp+CUQAmqOxL0H5PuZwfIJGXbDkQ/M3f4WKjyZ0TvRnRtYscSPKo/G08hbaeK6VcD9DRLkR4ct0Zag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a10CziVtIabPURgOc2T4qFWOtNL9pOHr8LFyLlEtcDo=;
 b=QzOuCsZd7ZtuI5Ybf5HsKwE9OHK69I7veUXqHlcHbEU8SRAMRR6j+iglGnx3mO9in6Tgxv8wwYT9ICbK4Ngi4VGMAmkaeu4EFUs6bSMZ+GMqZbfhHdjf/kHIJksslgHWdSbA3SYxjFMgdVHTjnaseXncdJJ2pMMhhH5wB1CFWyE=
Received: from BN7PR06CA0065.namprd06.prod.outlook.com (2603:10b6:408:34::42)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 00:16:52 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:34:cafe::7e) by BN7PR06CA0065.outlook.office365.com
 (2603:10b6:408:34::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.26 via Frontend Transport; Tue,
 29 Jul 2025 00:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 00:16:52 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Jul 2025 19:16:50 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-hwmon@vger.kernel.org>
CC: <linux@roeck-us.net>, <jdelvare@suse.com>, <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v2] hwmon: (k10temp) Add thermal support for AMD Family 1Ah-based models
Date: Tue, 29 Jul 2025 00:15:43 +0000
Message-ID: <20250729001644.257645-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 2089807d-79bc-4dcf-781e-08ddce3537ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YlDYGTf/DqiiTz82FLIncqcFw+xTJjd43tLpfixXGWgRBMcaKcUm4UTt9+HM?=
 =?us-ascii?Q?hNeiJtVif94S3v4XTs1mBjGH+/+PbdRaHb00T0LMQzQ9b+XXyzvgT7/9vZk2?=
 =?us-ascii?Q?yugXSW+NZQoE3Xy4Nir7j4z23dlHaiuFPMdjsdlcFe9TYfko1FGlb/sorXg9?=
 =?us-ascii?Q?/uflzKIHeMiLvIPYOfcN2QRlCamhoZhQ6Tpazx1nBOXZLfiOnZqrn5xyz7Yb?=
 =?us-ascii?Q?WMXNKhuo7/NXLXbQY4SDSR8nfXRT8A256lU4jOnWn5mKfxXtlHOTccHqeDxz?=
 =?us-ascii?Q?1YR3piAk5TvcPopmmFdQIY7cN8mMzulNnSRxztRpuTo5zetyw8Lys8Pl9YIL?=
 =?us-ascii?Q?y0XGoDjtrHIxKMGKgKDJafBpDraEA+DuywrvT8uY3lqNfxury02vTSGHuwag?=
 =?us-ascii?Q?8Fp/0O6knf23qD7JVU1vDoUNMxESGvbjBnAC9INPPCN1YXTXNQQTeqRYuV3K?=
 =?us-ascii?Q?zbwFXR/4xbM6FDFkYVYA9oKK9eCFa18f5BFc1yWMN3p6YC9ujy5XEfItZUAY?=
 =?us-ascii?Q?gVVQIvh0fGF2e67orTKXqclYEqWFk0rahLKlhG2Hb/OEn6CJPu3rvPoLLMrp?=
 =?us-ascii?Q?6e7rQljh9cUN66/tRVg1LOdtu/R2cOVhEHzhIRnbe+boSP3jB0DIhARv8zP4?=
 =?us-ascii?Q?xxiX6L6nA30JKPGNwKieMLzLhwm6kQNA/y0tzDp49vKTvCVIUGKxpVlPHFKk?=
 =?us-ascii?Q?j+pL7kv6c9N/xGCqOPj9HStYxo6aIQh20oH5WFGYPgoLKBGrymMrY+YOl5ul?=
 =?us-ascii?Q?3ebzyR0HeEI6186z+yAPlxUJvnZzqdCwbe84Km/MnVgdyGM2ymZvMSfCTjP8?=
 =?us-ascii?Q?eLJ+l+T1AKNilyLsLWe3M38ynavaNsZWCjzwJO9CnJYaULndMbxAoECbGlXW?=
 =?us-ascii?Q?HphW72bOd2xlUt0gR9yt97r54aWqy34UemhJ2ScOTiKM6N+dczJcvLASm+lE?=
 =?us-ascii?Q?Id8WYeDD9Bdouk2b7PLv6DCJmQ6HWuRtKCvQD+mSUMkpOpwj6uUH4yzyJz/m?=
 =?us-ascii?Q?1GEtqVLaKLKaUPzaDBF1k2F1i6T8ttUvl6tLgZtrwVp51I0F/cvBlU9KqOV+?=
 =?us-ascii?Q?eNh6w1PChpb0JopYiWduh4u4N5azSNvreJn82HPNsB8By1wMi0gGoiMgcFub?=
 =?us-ascii?Q?cuH8cRY/6l6Ef6E0uH1M3xaEAdeRTHC8JrDI+4l4Nnr/22noxCXC1+XCnQXu?=
 =?us-ascii?Q?PcwrJI1jleXLy4omaUw446MoUD42vMR26McCxTrD1VhEvgj5B1/wBHHNlJYg?=
 =?us-ascii?Q?R1txYipMMqtV7j9rjC4gmq8fZySOQaWOv2czdNYV0gJ2d16s0Pc3F8ztTsvy?=
 =?us-ascii?Q?xrhI5Rgtm31jhi52+tdAgBTewqP9oWYYHVt0yV99m+FTfu6dAYMwX7Pzctv+?=
 =?us-ascii?Q?ZommVU8Q5tVQnRj/k3HAvH+7WbiCdtUvJ/mYQxQ4jn69sZfr+dKOQshnCLbO?=
 =?us-ascii?Q?px4pv74oe3867lOpf6VQGMXcsMbGUs/RqWp7vms7HYqsnUzHNET/TNHuK/x5?=
 =?us-ascii?Q?z7ZE1h3m9oHBur+YbyLw/+UN4E7Usku+tyFj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 00:16:52.3070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2089807d-79bc-4dcf-781e-08ddce3537ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185

Add thermal info support for newer AMD Family 1Ah-based models.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v2:
1. Move PCI IDs definitions from include/linux/pci_ids.h to the k10temp
driver since they are not shared.
---
 drivers/hwmon/k10temp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index babf2413d666..2f90a2e9ad49 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -84,6 +84,13 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
  */
 #define AMD_I3255_STR				"3255"
 
+/*
+ * PCI Device IDs for AMD's Family 1Ah-based SOCs.
+ * Defining locally as IDs are not shared.
+ */
+#define PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3	0x12cb
+#define PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3	0x127b
+
 struct k10temp_data {
 	struct pci_dev *pdev;
 	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
@@ -556,7 +563,9 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };

base-commit: de1fffd88600c5ee1c095c84b86484cd0329a9e8
-- 
2.43.0


