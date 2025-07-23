Return-Path: <linux-kernel+bounces-743167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAB6B0FB68
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0155D7B5478
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6F1230D1E;
	Wed, 23 Jul 2025 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pn5jJrKr"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543220DD42;
	Wed, 23 Jul 2025 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302470; cv=fail; b=Vxx7rXAvB90ndGYkzxpDTJK1IJknK2Mc6JC35GvuE7ca/qi4Y8smS5FYeI9L5mCRsQX+IRaRrdZDBP+AClbtXwBYUnln07zorpcsUhdg8dzF4eKGOpvRFZFgXfPia9HvmtuLxN1bHmW4LBwT61+hqJi2daInER/PMEitjRqF7HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302470; c=relaxed/simple;
	bh=3LqfXsb7tnG0RFeAjxIa6XSXrxNZ3wECv1G5NAYAbSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b4+n7D9txfqKFHqunMLIuW1k/5uQDGyIlc67NEo9VW4YMgv59oRZg2FSLIpeCISVTenCxsPR1XZ1sWVsseKJ7Q+rnwIYJj//onQ/J6WSIa2TpCoORBXtPMR/DNHdV9GfbxVUXwFf2JWWxR79kN2kvvzj//lLJe3PsAmE/fW7krk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pn5jJrKr; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeSoSn2uHn5fxlX0zK6jwP7Ri0ymFvZiGsV1mkONJQs8sx9hzl55of0BtQ4m3DCa3pKD5ZE3n81uzXzRelNUBXWGcry0UDshbCpRvlxk0eOIKizAk0CHhXOs4sXw53zAumquU4gkI/cRiOfrsQtlaW5CYhVWTeyk2CYVTWTrD13Lgbn/AUQPpXvcB9ByvTjjudKly5YDk1kdZhj6XjkfPORIHWEwSU0yx+zFszjh8e1s5gR7C6fWsEdveCKGzLkVIx2A2TVJzU5EmEgtUH5oxN+85dPS0F+4tCSSV5dHakfYiw/jrzD1pTD1RAwRUDPp6QQ4R2tkxct2hErA/GGjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bkA37Pvz0u0vmU27Io2CFnuTqLizJdgh9WXfH4lKzs=;
 b=J+EXXSjAe2qmzIhc5h8TmnjYXQbVkaJ8lX3st6vS9OvnbYvs821XGFh7QHfOCnEDMHYcb7LtlQWhJ4+9STnOgOBL+U6fz2fHAKucf96AoJYP2iRebtQ6NyiLAxQjiblepUnb80pBn2VrESHi8RLL17Po0SZTR0TxL3V1a6v+YGmM1qMID9cZAtWO0+1tM2wrKJGdtFFMdNTqd7HFLMKqNsshALzDtAiDsdvYFXk+rciowaHadrvpVn+rgL100yRwn/GpEFAU9MK/et9E9MJ9T5r60qdd+M2xW7TVYIv+AXTzgC0JmKCScclBgqUTxjVv4l31tjIGjCci+srYLK1ZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bkA37Pvz0u0vmU27Io2CFnuTqLizJdgh9WXfH4lKzs=;
 b=Pn5jJrKrN2URwTPhSZrD7xpyPJ1AeXKglvVIFg1JcsMVDpcJ73Gypc8gRhTCaG8HdVYpmKNcALvuXLCE6n0OTwaW2/QYH3sEK242RdhnQ9cRyLoOO/6zyxBWs55MDgyRRY/iPx9Ee1hk2naef1FV1tG2jhFygD7V7odJtye/NHA=
Received: from BLAPR05CA0042.namprd05.prod.outlook.com (2603:10b6:208:335::22)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Wed, 23 Jul 2025 20:27:42 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::b) by BLAPR05CA0042.outlook.office365.com
 (2603:10b6:208:335::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.6 via Frontend Transport; Wed,
 23 Jul 2025 20:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 20:27:42 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Jul 2025 15:27:41 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-hwmon@vger.kernel.org>
CC: <linux@roeck-us.net>, <jdelvare@suse.com>, <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>
Subject: [PATCH] hwmon: (k10temp) Add thermal support for AMD Family 1Ah-based models
Date: Wed, 23 Jul 2025 20:23:38 +0000
Message-ID: <20250723202735.76440-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef12c6a-068c-466d-6055-08ddca276058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DjiCzzeR5UPNmlObBWCgooagxAP7aI2bqajnHN26Szf6aQGk22n7z49lHmV0?=
 =?us-ascii?Q?xiVMEF4SWsdh7zz7G9aJNOG2kNFPtunmbYNNey9jLq71gEjrZ6ghmXIM0KYw?=
 =?us-ascii?Q?KdB8Voq3LnaQu96hViS9zkgG7FSc8y56+jbvhUctkQELZ5M8Mt2nH21mLTsA?=
 =?us-ascii?Q?CH4sTtEsUwhKBAxkP3Sik3/zczh4/hrzgF7AMunav6e7gwMJfkIuCJ0FxgJ9?=
 =?us-ascii?Q?TWVd5kR1KWqS5ZmbDic2xB5Ut1x/jHbfJ9z3e8uTkxYHSpOlYLqkY9cqK0gf?=
 =?us-ascii?Q?MTZxrcWjFuPz7Q+iM3HiX67PuW2LYYZp9kUJLzyAIlOlMYn0DO1dwJYmIQni?=
 =?us-ascii?Q?1gxqHbsCKhzFQkPLxs0bKHsGIQfx3cZZo5Jnrf5WUwVRJj+J1UBluOPyAExS?=
 =?us-ascii?Q?3vXVFf3OlEEK1f5Q2tyvF2NIcW/E301Bt29aO5Jd4pBKKRSPS7LyiD4R8uqR?=
 =?us-ascii?Q?7/OOokvxOU4MXpetskm+c+xmnnE4dH5rIQ0X2y6HUdeHKUS0NM+RE57RAfOF?=
 =?us-ascii?Q?HdWVx1f7VwzcT3FtAASYFswKV8KARH/EPe9Jg80dARZ3pYy+ZaW8v6GI3kJ7?=
 =?us-ascii?Q?TEdvY8kAqdI487RSxInkcn8NMqxJdUE5JrXHHqcF9etT30SKCJDCuWArp432?=
 =?us-ascii?Q?EKIMYPeuFpW+oH7gHPUzLfVhBE/nH7eRkVYLs12m98TlGf5FN6cYD84oZbUl?=
 =?us-ascii?Q?3L6ZmCu6W4+c0fKEoBoddoHwEfgWMsWZsguuirfzgMU6DjGw8d2VGD1OARd/?=
 =?us-ascii?Q?tKLot+hCIzkPRMb9f/n3vG95GcKqsMua4StCC6lNEooX3SpssRmGCJCRk1aX?=
 =?us-ascii?Q?RYKrGWyOgMSYpXnrWHo0xCuT9c5VrosotGXD1SmZlh9g+7pN+/t9Wp8a+Igq?=
 =?us-ascii?Q?tvxtz3LNH3cxz8Yr2XURNfyiaqz/Mzpr2BfmUObjMXuwRKSYdr9iNb2bB7up?=
 =?us-ascii?Q?1445FugeMC0ceO1O2yMZNm+yUiXdxnGo7WBKyMwYSNPr0RSwBjZv2YUvQ3/w?=
 =?us-ascii?Q?EIVncMbCjm4kmLTIdRtSanESwNdaHO3082fh0aqfa2/Ox7uy3hnSOOozVl1E?=
 =?us-ascii?Q?cHGGd+CHBipcUj7MMkMgLS1E/gzdHBCUYX6S1f2z2usi6iqqRGlfRywZ0u/T?=
 =?us-ascii?Q?aqydRzSm0QsA2DLAdY6BsDRtWt7Pug4p78z8QIpZEs8YPT/o6qgf50VtsLGz?=
 =?us-ascii?Q?OGcJMWH/80rFSGK04ws4z3mXTTZH7HtC3g+4mCjjYWDEnq6yj8Yg3L+F8E9C?=
 =?us-ascii?Q?oWDpFGxlTgC6gwzssmrHuhugdoTJTPKkVmgabOpVPNUohPtripVklqyXMeE2?=
 =?us-ascii?Q?O8LY8cieQPA4rUWMMiVDsKW9/3k1Weu32qiNs2Vkc1G/zC9ct9o474td/GLw?=
 =?us-ascii?Q?vpB8eyrRHd/aPfcRplo28EZINrGPED3h1v8JTiJ0DVYAbh3Fv0NqloNowihZ?=
 =?us-ascii?Q?wFG1yBSmrRJJxWDEG04Vuv8MBgidinWClu1TM7KprGxoaw/FFaU/npzwh/Tb?=
 =?us-ascii?Q?NUCj7aCxhloOOVOodVdRu8Cge6hYp7yiuwmF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 20:27:42.4981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef12c6a-068c-466d-6055-08ddca276058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252

Add thermal info support for newer AMD Family 1Ah-based models.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/hwmon/k10temp.c | 2 ++
 include/linux/pci_ids.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index babf2413d666..7765cd57d746 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -556,7 +556,9 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e2d71b6fdd84..ae87b6c72981 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -583,8 +583,10 @@
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
+#define PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3 0x12cb
 #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
 #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
+#define PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3 0x127b
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
 #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a

base-commit: a2609b707b58561b9e52f92f3f571d0510201f2f
-- 
2.43.0


