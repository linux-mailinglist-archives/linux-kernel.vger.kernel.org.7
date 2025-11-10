Return-Path: <linux-kernel+bounces-892390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 119F4C45008
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFB5F4E7846
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD6C2E7651;
	Mon, 10 Nov 2025 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nH+ueapD"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBE2E5B3D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752310; cv=fail; b=N/8aZpkE+geBK6tTgLCr+7cFdnr8FH5/UXTiTt3aBTBElE/W3ge/f3VYNLACBIKrtzjejJA0UpGL3C+dhvBd033dj4GXHGY+1EKcuylmml/ogXzsaJg6YDXIMv+3KKRPad2KzN5nq8XZ9lTYOL2kUJ/0P6nz37PJL/wTMEpd8/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752310; c=relaxed/simple;
	bh=hKfN7Xibhq6UgZVU9u4gWrX1H+5J+qZn8+2XDK/Ornc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOg3my7JoCfPyGISGPUON736cv4lZYPkNN1iLSfBWmwutyz9t4mpP13BVxzbnqktwhXO7GwxJbXQ3qaNAb6pLDEP0TKBvSvRQFLNDP5nEoiQA5eu6L6OSin4P+xoj+gv/Tz6A3s7n669+zAHEYFusn1p0BILteMQoMLsKcXRfKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nH+ueapD; arc=fail smtp.client-ip=40.107.209.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti0RQv+JbTuPZQSfdauqeuh/l14xOU6LppwTy+1BeBsnH0ae7YQ69wTuamjR9rUkVG+/6jPl6D2GmrWDcyes3tGXUHTyzwonpeSYhWMHyto3dJNgtS3KKIrb0+qCaqeA2IKBMKmklweNN6y9VUSRT7qSYUpPrrFLdrksKJzgy5yV2u6qreAqx42zca0CctcM4Fth+xGL4BnGbNq5vNaAMq3rhALk/HLRaQyJ8lpzxRvs2mUrbj/NgQhK8U8OFw0Xp9q1gDBuYpIZk46cDgMAx0XFHcn50952lTuCuGRUxEqu+Q2G3xh7g/51JAdOQ6R1Q9c9zSEv6DDUH8azSkefww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSlsZqPpQhjSCl1AN3kFWhBrwlT/ll2LHD4n/2ZWo6A=;
 b=c/ZTlyRUcC9zDs/s9sD9vqZ/EJGRruc/4fhC8HRlyT/Ql7Mec3CbRHGjMd28GP2Ux9GSN1iyp4RngfBF9gulIP9PDUdqMpfs3nP1Rq0kUldfPfv9CMn39mXPpRec1ZSR/J3DmumOJvSt0oIipB0SHykJ6dENvDwZ2c5+sUvvSg+Y6P53i49VUvx616fwFESEGmkad9VoVF1TW1B8FP0NZ8zbXrfwCI4Z74Go4Aqv18gGx2Ew5io6kzFI6yZdx8ru9RRx7OCNK4SkB8WjYe+5q5qXZGy4oajpQRKCMDwclrYYTKyXojHUonUtETLHmOnvfaNueLZKOVYh9RkGs4BMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSlsZqPpQhjSCl1AN3kFWhBrwlT/ll2LHD4n/2ZWo6A=;
 b=nH+ueapDci5/Kk7r04pj7hwnAOLaewZywKYGq6Y1LeFPoWcIcohVM5lCQ5LTKdXd8Pe9iVcHtF4el7PhVQgnedG8kHvRFPQemQ8wNdG1barr0eO8fqfD2zRISjwMw5UUV2RYnDSCxAcd6kWqKmDzyWYtni230zUdRd/F7UR5xHA=
Received: from BN9PR03CA0148.namprd03.prod.outlook.com (2603:10b6:408:fe::33)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 05:25:04 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::c7) by BN9PR03CA0148.outlook.office365.com
 (2603:10b6:408:fe::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 05:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 05:25:04 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 9 Nov
 2025 21:24:56 -0800
From: Bharata B Rao <bharata@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <Jonathan.Cameron@huawei.com>, <dave.hansen@intel.com>,
	<gourry@gourry.net>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<peterz@infradead.org>, <raghavendra.kt@amd.com>, <riel@surriel.com>,
	<rientjes@google.com>, <sj@kernel.org>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<dave@stgolabs.net>, <nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>,
	<yiannis@zptcorp.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<byungchul@sk.com>, <kinseyho@google.com>, <joshua.hahnjy@gmail.com>,
	<yuanchu@google.com>, <balbirs@nvidia.com>, <alok.rathore@samsung.com>,
	<shivankg@amd.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v3 2/8] migrate: implement migrate_misplaced_folios_batch
Date: Mon, 10 Nov 2025 10:53:37 +0530
Message-ID: <20251110052343.208768-3-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110052343.208768-1-bharata@amd.com>
References: <20251110052343.208768-1-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 42eef232-1082-4579-e9c2-08de20198133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zUB4HTXNfMPQkzNyB3FJun6JchcWLwH5eHiYqlXH5UKCh2b5SAC0ZZcTWlSl?=
 =?us-ascii?Q?UiD9nQWJKvGCb7EggEv5Frfe/JbwIqhdfdw7lagGNevRNgxRbeU8KURzJL0V?=
 =?us-ascii?Q?63F+WEMoEonkOSKhSBhyXGTd2YwkYgmAr+cMxpAeCyhD3VnZR4BFY2mYHfEA?=
 =?us-ascii?Q?N1kygvSMkAE0p4NuXg5KhxN7YsZINoMn+kKr+jvT5LQhMGXc3swUUr+SGkOJ?=
 =?us-ascii?Q?0nJgB+BIrSOu19D+Vx7hNn49JX3CViEkg+TfvMktCme06SG3zoxf7MCycHhJ?=
 =?us-ascii?Q?DSY2aNKk/Hof7zGVM8cfrFldqu+yh0citoa9O6pBz7HXAKzG70M4FhEGuhhr?=
 =?us-ascii?Q?vRRqSg1X7okkyyxm/Pm2IZCLcg2/phpbqzX9cVlKyO5T37U499s5O91RgyYF?=
 =?us-ascii?Q?sA/oXrPwggPUpaI9KmuF1XPOlmSqA4w6Mivl9ODeaDJQsPZ1LeHCYLeMchcb?=
 =?us-ascii?Q?lLxocx/RXo1oR9p3xNCQ04Tj242/iO2d9OKnvP16Z6DqJ6OnNPhBKEY2cyut?=
 =?us-ascii?Q?fMX3M9Qn31Qc4TV4WYYVBbNj0y1Flq5wXW/Io7MNRiD/SCHMtSGBh1LHt9ge?=
 =?us-ascii?Q?AvNT3/d4F0A4cJTZGxrbwp5CEZlC4oGwkHAA4e7rI/ZOJWFh+7ynDhUc0/oc?=
 =?us-ascii?Q?RoCkBB2k3gkfLigIsWB5m7RigjhK9jl/2d5ZPj0r1YpXo7fNs7k4Fn8wPQVF?=
 =?us-ascii?Q?YI2e4J9aKIgU/VPKVst+nczUXime1hFry6Lt3O73S+Kl821/VPj2oU0Hy6rI?=
 =?us-ascii?Q?uvrEKufbms7qYKVJu+JmLRyoSiUXpRog9UUp7ze+EzHBGsmrgRMdd0Zv0wva?=
 =?us-ascii?Q?4XC2/iz1CGrCrcNDUmdF6fpTP0He6wkn/ky0DMTp+TRCMa2GSGxOQs2JAveh?=
 =?us-ascii?Q?OMUE84AssZGqWFeZfHppyAs+fuxIy2G5PIC1Qov5upST7jZj0fhiLDGlQFyJ?=
 =?us-ascii?Q?Ba9LUY1sAsBFFhsFo9v+w7qzFHKlcqy7RVptr/3l7JI/tMUOlHtjWHcl42s5?=
 =?us-ascii?Q?oYiob73qb1xX/Rjmu1fxFozQ7ORNoOsSAH1ENOaZufx+6syZWbYsAywXrgnj?=
 =?us-ascii?Q?9kw8DYiMOjwIc08ZCcgz+8UfTDnDEmMHHbDIS9P9IbqyqN5I+TgmdpzmlIEV?=
 =?us-ascii?Q?jbzk7fwM4igVQxAkxbALCzS8p8WhJAa71lCz4W+v4vaib94eYXmY+uxzQ6sw?=
 =?us-ascii?Q?rGukcRGQM1oMS32FgOrwMy2pLfx1GvKTuli9guZ1l+dnSN04T/GKdZKF8C2N?=
 =?us-ascii?Q?24CjZYBNbuC4ge181d2BbnbvCjJI31cRcvw2e4tlb4qhqc0tUpgo47rEQIQD?=
 =?us-ascii?Q?/Y+bIH23QAekWOJ+26zfepzDiSxzuKzGIi953q1m2o0F+ttLxSPzhwo7AiEh?=
 =?us-ascii?Q?L+KAzELECutyoOLwt9SdA9uyY69t9sKC/Baamjn0vTV5lJF+iiFtolIUj9hW?=
 =?us-ascii?Q?Wl/h5y/D3il9MKCUAbinkayXGLVJ7KzxgtsM0pLU3GZiOfaPWKisF/vnxK0c?=
 =?us-ascii?Q?u08jxSFelObLTzxklVI3M1AzJpS8bFvwWk6jwxCSDwz4uCQXGB0mENwUjMbO?=
 =?us-ascii?Q?V8o0YmkxZbSskYYhYic=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 05:25:04.6692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eef232-1082-4579-e9c2-08de20198133
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081

From: Gregory Price <gourry@gourry.net>

A common operation in tiering is to migrate multiple pages at once.
The migrate_misplaced_folio function requires one call for each
individual folio.  Expose a batch-variant of the same call for use
when doing batch migrations.

Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 include/linux/migrate.h |  6 ++++++
 mm/migrate.c            | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 1f0ac122c3bf..2ace66772c16 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -103,6 +103,7 @@ static inline int set_movable_ops(const struct movable_operations *ops, enum pag
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
 int migrate_misplaced_folio(struct folio *folio, int node);
+int migrate_misplaced_folios_batch(struct list_head *foliolist, int node);
 #else
 static inline int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node)
@@ -113,6 +114,11 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
 {
 	return -EAGAIN; /* can't migrate now */
 }
+static inline int migrate_misplaced_folios_batch(struct list_head *foliolist,
+						 int node)
+{
+	return -EAGAIN; /* can't migrate now */
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_MIGRATION
diff --git a/mm/migrate.c b/mm/migrate.c
index 189d0548d4ce..990a251aea33 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2739,5 +2739,41 @@ int migrate_misplaced_folio(struct folio *folio, int node)
 	BUG_ON(!list_empty(&migratepages));
 	return nr_remaining ? -EAGAIN : 0;
 }
+
+/**
+ * migrate_misplaced_folios_batch - Batch variant of migrate_misplaced_folio.
+ * Attempts to migrate a folio list to the specified destination.
+ * @folio_list - Isolated list of folios to be batch-migrated.
+ * @node - The NUMA node ID to where the folios should be migrated.
+ *
+ * Caller is expected to have isolated the folios by calling
+ * migrate_misplaced_folio_prepare(), which will result in an
+ * elevated reference count on the folio.
+ *
+ * This function will un-isolate the folios, dereference them, and
+ * remove them from the list before returning.
+ *
+ * Return: 0 on success and -EAGAIN on failure or partial migration.
+ * 	   On return, @folio_list will be empty regardless of success/failure.
+ */
+int migrate_misplaced_folios_batch(struct list_head *folio_list, int node)
+{
+	pg_data_t *pgdat = NODE_DATA(node);
+	unsigned int nr_succeeded;
+	int nr_remaining;
+
+	nr_remaining = migrate_pages(folio_list, alloc_misplaced_dst_folio,
+				     NULL, node, MIGRATE_ASYNC,
+				     MR_NUMA_MISPLACED, &nr_succeeded);
+	if (nr_remaining)
+		putback_movable_pages(folio_list);
+
+	if (nr_succeeded) {
+		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
+		mod_node_page_state(pgdat, PGPROMOTE_SUCCESS, nr_succeeded);
+	}
+	BUG_ON(!list_empty(folio_list));
+	return nr_remaining ? -EAGAIN : 0;
+}
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_NUMA */
-- 
2.34.1


