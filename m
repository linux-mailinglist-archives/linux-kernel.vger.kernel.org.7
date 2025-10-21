Return-Path: <linux-kernel+bounces-862031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF9BF44AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D68318C44FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002F25BF18;
	Tue, 21 Oct 2025 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DN9NYl6L"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4C23EAA6
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011042; cv=fail; b=QLAs9p4BCK3NkGyu3S+Gpz+ZpU9vsMYhrQBJJJB3s4gspjW6zPvgFCmBmJeSQpTm+bcQn9lIlI/nnkPjbpwykhGCr6TVyRpD1XsqZ/I+4uqqvxA6iZY495j9QRapRpDJocKyQEZqp6O8hboKEdeRCCr9vKfAqVvuygm7ACebE7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011042; c=relaxed/simple;
	bh=L1o+fPwP3iQgZ845uumg/DXr1Fyq+bMbq/IaXwFbBWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQrbn6Q9xertM1lm0DOxgGa+Bl3lp2Ec0gOo2+OsksDsLUVC6KaHSAdIIy6hAqxylLRpLFLAUI8byOJ0grZIXDrUj5uY7ysOV1CcDaLf5jDZhIFK2LpjkXI+fbPC9oRoJlznm5L0b6VULmRPTIz4g+VNAfIdx/TxKFL/RIwhtgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DN9NYl6L; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rV6btvDfBPo/bPqxzobDiDTdFm7UOZgbfjOCbqvQpPXysZhOGRmRJN6xk8fPlxj1E+k0pM01e/hRWZKRFNvF+XGs+ckhFcTNj+BFMCaGolUauUgE0+Di2kCJhd5qGXuW/UyvrP3ruWluAHiBWKrda35C3QD9N6qM0Y+3mwxwB6Eh/YTcYIyPwDjbQnj3MifY7ATqDYcOQJT0E1bhEz32YZFKQIk5qAQJXbIdj8ft+3fy9QlhP+loMAE5mglVmFbtyQQrmljM8A0FblmHqkCj4xjNYVism7kXc2VqyysgCZ9oh5MtB87+3UgjZraDMKW8PUcMEwfITOqAnUtt1avmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6toszXUe1Ds/fq20+NhRrkRrjPtESk0AuBs8KWj6TeA=;
 b=fEysMArR38r9wEr3H2RiPpui8mh8ytfxaL8Wvm9kmFmoT0RJiWRjWpQnrR8neSSU71QXwbJNCMcZ2tXwNDRchUHVNmS69uI6UEFia33+ReabWjpNGToQUNoAJnOBuaEI9pJTezrzzVs1fvaau3L0fYjAGz3+h26YJ8y/IvQQHgt7IAnAhbGgX/6WLKWqUQYWts+8eUJu2PjjJcFqhiXT2bNTNjeblU976qR82G2ZP/Qc5NmX+i4krc9X3G4RvvViJVlk87/UKM7CcQkqhJkvzXMQZdSgqLRa4df3psemwiM2T/r7RzKGCsB7dXetUElvSmxly4npLLD92sS/0SvbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6toszXUe1Ds/fq20+NhRrkRrjPtESk0AuBs8KWj6TeA=;
 b=DN9NYl6L5QoGlWv2WVngBeQEzwIwtGGjg4WU8+sTPFxTq8kn3kYIZ9LRu9muICi3OA8QdLrVgkbROYBOVtmWfPa7Dftxqi3cvRnFpq6lnKHHo4+atS7PI5ORDFo2FylaWew5WwWnkSrlg9aw45XOGX7930j5SDahpu8wSyXjI4s=
Received: from BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20)
 by LV9PR12MB9758.namprd12.prod.outlook.com (2603:10b6:408:2bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:43:56 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::f3) by BLAPR03CA0135.outlook.office365.com
 (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Tue,
 21 Oct 2025 01:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:43:55 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:43:50 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 01/16] iommu/amd: Rename DEV_DOMID_MASK to DTE_DOMID_MASK
Date: Tue, 21 Oct 2025 01:43:09 +0000
Message-ID: <20251021014324.5837-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|LV9PR12MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3a0220-9650-401f-47cb-08de10434c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jan/u21UjMzL5flLNHHpImRWdehOozo/4PG5/olFQut2aXg3x+ldVtqn4u9?=
 =?us-ascii?Q?WSCZN/Jvu00V2scD0qKvpK0sDKQOhIYhpWR6hTnj9FjeKyDxmC13utOZM+AJ?=
 =?us-ascii?Q?eUxIsKKOe5QsadYfN+BDWHs22UFVPFHgteyLkUHvE31McW6FPVB8SIrc4V+7?=
 =?us-ascii?Q?HR1llDDTJOJDwpde54GSvi7jPPIRdhefryoQx5IilC/QbVHruN7P9ViJ7xL+?=
 =?us-ascii?Q?YB4+5VeZrcy5H40aN70Dxt9V4GNTSnl3dA8GQaaX1roJsi0r1EY1mh7NPQfU?=
 =?us-ascii?Q?fC9rj3g8tqXXQRxoIaYAeU96X+FxGEmRqCdh9H1Gia9Ed7cLE66IKteksX47?=
 =?us-ascii?Q?vzKdzKwK9+bbSsrWAg21dnvrG41CqBK5UrZo30W+T9C8VhhZV4cQXnVV7qTX?=
 =?us-ascii?Q?Vw/MiMSoTybqiYwec1beeTFSJwpBDwvTOHy9An7vuDWB2qSY4KuUgT+wGoNW?=
 =?us-ascii?Q?fZb6lhGA1LY5dCp1Z52PIgz9hOIcRVthCU4h9Y4Q6PIcHVqQFRNDBbbKvrTI?=
 =?us-ascii?Q?Eiimb52CaaL2UIr/voJmhiYFx2IOlCcdXMuxhPQauV1W4OV58FcZ2ReJ04dM?=
 =?us-ascii?Q?ZKbFyhnL5DV/CwPinS5k4RXcm8IbMdkeMu1KzuBv1WaKiuv5mzlIYMQ5YFFJ?=
 =?us-ascii?Q?Z6XIAGa7yAtVFR6p2YvKEfgknmAvSWmYMRu4FAYzuYxitdD9V+1g5Vm0LrWh?=
 =?us-ascii?Q?ypvzS9One9EVneIpOZ41UGyFl2ntvM3PcmcvKncHSo+tZG8zq7REpocQ6SaB?=
 =?us-ascii?Q?PN5VNhfJa+mLjfOrh7gJBrJl8DPBlFwC6EBZBHZv1jEB2PCrjwS8rx2dFJp6?=
 =?us-ascii?Q?tEmsVNCB10nuqt8ETgqktU7X/RGkSlIiwOmFMoEGP7tA1TkUBp3t3OHJ+/UG?=
 =?us-ascii?Q?W+SyNV4ChFXlAz2akI0vVhi/1SphvoLDz6nItQvy+yDksyn+8QPADAUS+6lo?=
 =?us-ascii?Q?EZq83XeGJsj2SIoy2f1owiGZQEmzW86+Ih772Bq04kB37ic6C6Snl0Sz2jN+?=
 =?us-ascii?Q?kz4EDx12hTNCTk1p71kzypXL7ZXNA0SpDLEWNAGbD4rMorZZGhDGtRVNsz4O?=
 =?us-ascii?Q?PvZtTd5MrFWZGjHxB1N2x1CCeBkOXIJAYzFf85ewIDhrtmapaalRGkTSaXak?=
 =?us-ascii?Q?34Od64NV+ht5AU+uv7N10eHZzUFl4Hz2elapjJYiz8AfWPxZ+PDDekFPckqQ?=
 =?us-ascii?Q?0U205X1FFACAavDPpKOFA5e2AdthUJS7Tt4H1yxbqTj7NsLr162WZgchHlWX?=
 =?us-ascii?Q?r7aZLACwm4rXkJhLY86KcAJpzxtTveEUKHSEhJSa/ctvngutIHQCunljpDWl?=
 =?us-ascii?Q?EpgNZV0OeWGE8PKH7ZndodZgryqwltusiyMqfaP4DQUCixRY9jFjUP1FBgkZ?=
 =?us-ascii?Q?rz4bWHBu1s0dmZCL/Mf/7YIePXPp86wU/Po/Qcz9wKVhDYv/qnBT+wb1Lmu0?=
 =?us-ascii?Q?1C3bWjbpJ0lSrnQA/LeWjVTRlTJnlOBtsUwutl4Z2sEz9Ebfowkxbf8n19P0?=
 =?us-ascii?Q?JvHYVpHxkH0oXAEezR4jbSqr5aAnOpgqwcg8gqy5veLHtv0UHJyjNNDYj3BZ?=
 =?us-ascii?Q?bp8eaIfDilonbNuoA90=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:43:55.8149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3a0220-9650-401f-47cb-08de10434c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9758

Also change the define to use GENMASK_ULL instead.
There is no functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a698a2e7ce2a..556f1df32d53 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -422,7 +422,7 @@
 
 #define DTE_FLAG_IOTLB	BIT_ULL(32)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
-#define DEV_DOMID_MASK	0xffffULL
+#define DTE_DOMID_MASK	GENMASK_ULL(15, 0)
 
 #define DTE_GCR3_14_12	GENMASK_ULL(60, 58)
 #define DTE_GCR3_30_15	GENMASK_ULL(31, 16)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b57a6993179d..a9b17d31a969 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2094,7 +2094,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	if (dev_data->ats_enabled)
 		new.data[1] |= DTE_FLAG_IOTLB;
 
-	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
+	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	new.data[1] |= domid;
 
 	/*
-- 
2.34.1


