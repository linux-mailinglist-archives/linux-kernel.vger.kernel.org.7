Return-Path: <linux-kernel+bounces-768940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3948B26835
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714CE1CC82FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B842FCBE1;
	Thu, 14 Aug 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UFHsVPxH"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A314A4CC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179399; cv=fail; b=uBx+UcfqO4ItI2mTG9jBfpDDZ0OrwXT7NwNL5/N3MlnwqzRK5cTiyJ0R1H3ft058cKtJAGxmy4IvVnwO/Dgp2rOmWY3mC2gH4txmhIgvkCmg+KvbGznsqoUQ7/OH4d2P1nm/mWzRCJnhQG0s03BJfu2drYXTSGuLHKHN51+9I58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179399; c=relaxed/simple;
	bh=7KV61dZpsL/NjzTtfAJ6X/ejNo3WpSOP1eNRTAAh5+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CF3i21OeAqJg8Hg+RclHU0vnzWkfM87+7z4QKjXlg0HQV2FKpHwWM2cybSJHauimhB03W4dVyh5/pULz0lgCa3hhpr2fSuak4OHVAnl4b8InidFWjGRSItxcYRcc8btKL5aOtTd9ODlhFDMv0uodvFEKRTCXnpoAz7GFVHVEoQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UFHsVPxH; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bf6ApQpTRaGqJy5WAwgl6mW5Z5H4DN9vCSERa0DIx6//pn1RnZhN7ERANKRUnENB2c3wgTlMsXm9/btVrOTrcFRCudLM/LPPzAfs0Npdd+JIWTZNTjV72CE3z+1NeEcfrdthbUvcZLMigGDoMyC2U/9QzUDukE7p5UTIQLLit6EPihWS9ANQC/s/5AV3AYJIHRP9ArZSwowGa5p6zz2l0LmohhGFhYpgwFByDoOMsSWAOJoZ9s5mpq7wciZPLolXAP+hnEvVpEcFz9jKrrjGCppdnJlVMk8+kLcK6ytCiytDipRuI6Q6vDU5uDyT0WSgiFOcfW/m9SfyVoNOQQQxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pFxsh/MnX5KgYbH3aeIt2sca4RFkSKRgN95HPx9EdQ=;
 b=j7Je/POXIU4gTrgjTMoqB62yc2DponArTQNdwJYucMvRbbIGGMhoezyoQo5J/yAtLDbEGLSdHpDnDfrwPDnU1QydywF2XH7u8QrZT4RtV8Lbzzk2PFYX1zDKggjMK0q4Nc7kkKHuySh3W5+BOG+yh94k2+dI3OJIGOr6f2cbUQK/Vx1bKw6lrt5t8phYy8Wug9H7t9uFC/LnRnPIfeH5YmgKCA/gD6VQRDAzFDwnrmZiWAbWP7Ae7If7PiY3vOv40sFH8pOBESPB3poNsk/Q6CO5rkRm0+BxMZpjIX1gIgqlW88yBwGxK6E3dKs0VGi/U+AlnqYTWg/JwWPaXPl+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pFxsh/MnX5KgYbH3aeIt2sca4RFkSKRgN95HPx9EdQ=;
 b=UFHsVPxHRgIlK08MJ5U/ofR5AOnbMVR2A6sXW2R9HJNVRoSabcDtDhVVGQBFPT8K8PcFF+C0sPGSUuBBNw+tvarz8xgytTgX9a2VzroVuBEXxnMayHVXKHltKGQzqo653TmVsyyij89anN/6VufMXPM6FPRRh7Z3G5zn164usn0=
Received: from BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::8)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 14 Aug
 2025 13:49:52 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::81) by BY1P220CA0012.outlook.office365.com
 (2603:10b6:a03:59d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 13:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 13:49:51 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 08:49:43 -0500
From: Bharata B Rao <bharata@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <Jonathan.Cameron@huawei.com>, <dave.hansen@intel.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <mgorman@techsingularity.net>,
	<mingo@redhat.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <sj@kernel.org>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <nifan.cxl@gmail.com>,
	<xuezhengchu@huawei.com>, <yiannis@zptcorp.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <byungchul@sk.com>, <kinseyho@google.com>,
	<joshua.hahnjy@gmail.com>, <yuanchu@google.com>, <balbirs@nvidia.com>,
	Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v1 2/7] migrate: implement migrate_misplaced_folios_batch
Date: Thu, 14 Aug 2025 19:18:21 +0530
Message-ID: <20250814134826.154003-3-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814134826.154003-1-bharata@amd.com>
References: <20250814134826.154003-1-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 2866845b-8127-46ad-3d54-08dddb397108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hcPRhtAGzIONTGD6qadvCEezoeCZG20/4VXd76bigPqfUeCedXdQnZWg+FvC?=
 =?us-ascii?Q?UyCG2hm77btwpYdq5QnofpXclBtSi7a087gxAidMY4ToaFj3s1Rxo+lsn3v6?=
 =?us-ascii?Q?nkt6SZ+bDaWP8+0pIPoNyERjAFcyn/IJbsmW5gK3Y/S4hpYF861lX+W2ik8B?=
 =?us-ascii?Q?WyoGMAGxvecdq6qgco7QkJcTS5Q011vjnN0AbkpFvgDUGnM5Sdxad1A4UIVM?=
 =?us-ascii?Q?3n2/FfytfA5Uv4vtnmfI61JY5G6OBp8SJyxiSYMHYD/lylnuV9rnAviZEJgt?=
 =?us-ascii?Q?/7ZOQNSmnMZVuJoBM1NI4BXb0qzXb3Sj0LRTmT8t4KWxvhRaLeOYJn+2plkC?=
 =?us-ascii?Q?gEpOvfpOLrg9HLAFu2Kzll+s2F4CERiA3DIwi6/WD7xWQoneCFDGTtCT3+D3?=
 =?us-ascii?Q?DrUfUajE4sOWPBfreWNOEABA0bvaM133dNaxI3dEoSRsTZa0kc/c4Wo3ss0e?=
 =?us-ascii?Q?dNNqsPg4WnuK2e+ebO5GP9f7LCK4/VWO42n8VZHLShZ871dxP+zwnAWizb3f?=
 =?us-ascii?Q?nOh4zI9+UF7cJGYPc+Cpnw9EuNjdBeSOP57AegzdIgeuXLKXSLbjrrI7PjGW?=
 =?us-ascii?Q?ek9rIZwSM4aW0ymn9BToiRTIpTmWD7QD/2ZJIXPzCZuOvwYI0FeOm84mmSo6?=
 =?us-ascii?Q?8ACHwVeqWQhMG8lJjNhC5iCrewKJxCGkMjEEZYB+96rDYAWN24Sms4pry3CC?=
 =?us-ascii?Q?PhE4HVk4WLGftFrtEI7J4JaytB+lc1lxfFo45YzvgdIEM4FLpaNtAsU/knOG?=
 =?us-ascii?Q?/drGs0e+gHQ+HecE2h6801LcHABHQ9SBp5Emktkb7xn2W4BoJIGmQuAty2uo?=
 =?us-ascii?Q?r+IdEvjdbq2nHl2tcBub2XOS+whon2O3AZ44g9ZIt9rEZdOcyBr7FlCRa8lr?=
 =?us-ascii?Q?aJKHHEiG35iNJRbSJoTVljZQh0X/WjFQSDH2Jq6Cg7zT3qHnw+ljAGeDs8/N?=
 =?us-ascii?Q?iFcaFZfQww7wXCOQFr5G4xWV5ICsAcAc89R/5y0XE8b8A9gN8nkZ4KkoXxxo?=
 =?us-ascii?Q?dbjbiq/ZIcpqDaDpu9BN/dJ2qAm6F+z593vaXBZT3MQrmZJYT9J2j5Y0l6C3?=
 =?us-ascii?Q?ID0DKNpHX3/c7W9m/w42Zm1Y3KbBrxvbeJzBdLZ7UL00fjYouWPZQ9Zngzg1?=
 =?us-ascii?Q?DNhmufWVDMXhOKfjAuJzmpOFHSgVcJpzqi0aprXjYREw55izzYMHHwvOZFHs?=
 =?us-ascii?Q?9Dg7pnoKWrYNnYPtPbAZpbPkv4DqkguvOnhX/gD37fJAYxkMXwSjRCgcIg6e?=
 =?us-ascii?Q?o26MKuBGbGucBz46LhGAWZ8fDF70wB4IxfBWmNbftbr2qPAgDCD3uaK52lSe?=
 =?us-ascii?Q?1MTSOgx8FjE8LfnFunryFw3vw5DjvIB3AMQPKP08FXwrK2HKWDlPtY5t3ny4?=
 =?us-ascii?Q?dajT1hTXz1ZgyDNc+PK8a4Oauk3sKhhEMF8/Oh1IYK8dvk6WClOeGT/PgunM?=
 =?us-ascii?Q?hdC0Vm1j3arW48dXOFqUnkq3G0W3nNS54fhMEDFZlPiQr6ieYbRok5s50Uhx?=
 =?us-ascii?Q?ci3qPB9O6TF6i/cJ6Mfz3T4mNxa1kQ8z9FfJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:49:51.1735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2866845b-8127-46ad-3d54-08dddb397108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316

From: Gregory Price <gourry@gourry.net>

A common operation in tiering is to migrate multiple pages at once.
The migrate_misplaced_folio function requires one call for each
individual folio.  Expose a batch-variant of the same call for use
when doing batch migrations.

Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 include/linux/migrate.h |  6 ++++++
 mm/migrate.c            | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index acadd41e0b5c..0593f5869be8 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -107,6 +107,7 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
 int migrate_misplaced_folio(struct folio *folio, int node);
+int migrate_misplaced_folios_batch(struct list_head *foliolist, int node);
 #else
 static inline int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node)
@@ -117,6 +118,11 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
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
index 7e356c0b1b5a..1268a95eda0e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2714,5 +2714,36 @@ int migrate_misplaced_folio(struct folio *folio, int node)
 	BUG_ON(!list_empty(&migratepages));
 	return nr_remaining ? -EAGAIN : 0;
 }
+
+/*
+ * Batch variant of migrate_misplaced_folio. Attempts to migrate
+ * a folio list to the specified destination.
+ *
+ * Caller is expected to have isolated the folios by calling
+ * migrate_misplaced_folio_prepare(), which will result in an
+ * elevated reference count on the folio.
+ *
+ * This function will un-isolate the folios, dereference them, and
+ * remove them from the list before returning.
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


