Return-Path: <linux-kernel+bounces-829433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41425B97171
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01A54A695B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2B27FB21;
	Tue, 23 Sep 2025 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fY5cveic"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE9284B25
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649724; cv=fail; b=Lnqb2mmv7mHEfvjweY34XqorxY8jElI1hQq2l/v8aPjX6fkeMDAFhzHGQQD8//+Ke/h4lOo5+/DDvGTZcHauFKHWe4K5MGmFu330kVXZHyXp1xQDW/O7OBFYDAnBoMT3SNKKpb4gOu1++NNAnz3xguplhUtNreN9X5B6vlHLgdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649724; c=relaxed/simple;
	bh=NWFASIMQpnXhbyOjQB7sqvAq6pClKFwXQwP8yXTsR0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSHS41hQT0frTZ4zQk9mQ41Fg7XlkX0dLesd7eMApM4SU1bl2QcFdvKcsLcUnRzSI8sbI56tKcPzRmpz3ueTJEgw4g7hLEiDpaTGO1cdBtVkxHT64hptMZ0jZRHVWV5oms6Kt6Xx9SeZy5tGlx7PIbumPNljEudQbHHIlmBexLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fY5cveic; arc=fail smtp.client-ip=40.93.198.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okWvd62QOAduesI5W7Is5Ly3i2hCzQkIZEldLMY3wMn7wlo60KW5/ygNoqgm7oxdfSSW14GDm7jWbg1FsHZ8y0nu6DVl0pJSEbrPChEmkXJfy2EJLcx4hbMv4Tckq9NfKiQwTDr73wahmlgCbQHAaB8YMuvRmQVH1zGfTd3nfZAoYN0psf6tAcL9v/XZF7NBGapbFxUHtkDQqZeJCANIDs/RdzjgBnqjvQrA4a8Q/D93KIhPpU9IcbmTvv2qvDwQfyCBvTLqJOCFkf/MD/xpBY4cT0X97gTuhNcce5gk5cm+Q+FM4lBljaOHfZpM4sfHW7OCYKrVC9znkxm7wHaa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/XSA7C0+VZv1xAdsgXYAZVX5Wrmi6R5gU5c9V8a6tk=;
 b=Yz8JmmtZ7kiuAPxG2b35No9kfDn+J3QaGSqhZTGloPo+G+Q1zufbgtcMBWBSzktFOZ94TLKzX4BjxxfM4TVaCjX7LpqwYL1eSTYuQYYPOjMYPeJXkoxitWY5NXVB2I+9ExFKAnP5DryTEKXb1YJ+08lQatv2JKx+qg0FAIZuwfApFm136wpndx/WDIVzwYkId46NVet7aGhNu8/h8JkutifbDDaMfvyZ+K7s3z8TijzGcD2bUt04Oymr69Di1pKZVcSJ77IDN4YJSzeGz+UCrO46ZOuZfnoN7aaF777fIdlAfkXzZuDRo6sf1kKhN50vBnor33PPm9UnKAxCdhjUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/XSA7C0+VZv1xAdsgXYAZVX5Wrmi6R5gU5c9V8a6tk=;
 b=fY5cveicdNW0tfUsWMHYDWGWt8Ot3wKGJmEgQMiPiXYTzgCxWSKwE/55ENlLLkNgo/n8nkbzc0yez2wzZcGRyR5tkPjREPCZ8l5qIdsHyNyXwbO+cMxid7rGQQiNU3sSz9C6znBbp+oKarehOBLSn3o8ScQ/mCQeom60+i+kkiY=
Received: from MN0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:52c::20)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 17:48:39 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::50) by MN0PR05CA0005.outlook.office365.com
 (2603:10b6:208:52c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Tue,
 23 Sep 2025 17:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 17:48:39 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 10:48:30 -0700
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>
CC: <ziy@nvidia.com>, <willy@infradead.org>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<vkoul@kernel.org>, <lucas.demarchi@intel.com>, <rdunlap@infradead.org>,
	<jgg@ziepe.ca>, <kuba@kernel.org>, <justonli@chromium.org>,
	<ivecera@redhat.com>, <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <rientjes@google.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <bharata@amd.com>,
	<shivankg@amd.com>, <alirad.malek@zptcorp.com>, <yiannis@zptcorp.com>,
	<weixugc@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC V3 1/9] mm/migrate: factor out code in move_to_new_folio() and migrate_folio_move()
Date: Tue, 23 Sep 2025 17:47:36 +0000
Message-ID: <20250923174752.35701-2-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923174752.35701-1-shivankg@amd.com>
References: <20250923174752.35701-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: cf309ae3-de53-4fd0-8253-08ddfac96dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1LbizjOFSdnI1QfLxADwhmq90ITfTCdaPsWhKkxDxp4DM9wF9nw8QjdQEIjY?=
 =?us-ascii?Q?+0DcBk/R8US0YHkgnZsFOXAVaxOnM9gOOE5gnw5sfYSFdj+0+E3/h+HZUU+U?=
 =?us-ascii?Q?4zIje0y8s3DdhfQe8y4Bi/TvfBFB/azoKvriea15iOkG3glr+TP4t9tbvszK?=
 =?us-ascii?Q?yl+3n8I7xMc51sfAWLBmEawlcLYEKkAInPT0G4f19T3r4W4HLaGf6vqr+y+i?=
 =?us-ascii?Q?gsWPtbB7RxlLkJZ1lS25xXZ53Y54UYoDTE6ZrlTJF1A0rbYKcxR0Ga8QFYkR?=
 =?us-ascii?Q?g/pm/Dw6q9ZNJLVm8RcHhYWFDbGlcyk5Z2GavXqquomFbO1yFGtsSrjlvgxl?=
 =?us-ascii?Q?AJ5WefOiLrPyTWW2F79FCAEf6ieXi2M4U/S8o3NK9iE8DSTRQ/OWI4yid5A0?=
 =?us-ascii?Q?J75ZlJjhr0Ngj991xUAJjDmFteH+jtz06j+nzkeJjuxblA1yxPM9iY3D6mXc?=
 =?us-ascii?Q?u6a1jJqWamCUFYqYTVCLfZRb+Q3qd4yfJREaVCZj0uK0SM/6xQYQxvYDyWC/?=
 =?us-ascii?Q?8bwGG56wiFhJ0ozqquoqeyMRrM88IOkey9OQsV7fClN6Gjqlu0/VXYtQpDTp?=
 =?us-ascii?Q?pM0ephTW2boHrMA19x/6ijNgYDBv7gYZrAsL1D8dlqcqaacbvsB0en5blmqE?=
 =?us-ascii?Q?yaBrie9dIN3tJQXPFhOLq3jBomHfqZShwx8iUX1zkiiVrsr3Fas8JoIz/bGB?=
 =?us-ascii?Q?wPWP/jZt5Y5K4QALj1SKAALILJI0/rgYbPo0w0twIa62sanVaLYD0+12sHV6?=
 =?us-ascii?Q?GuB1SMB9BelXN4Ydb+enlw03hgRbcWc/idTFxybKmbODvyhX75ItraAR7amf?=
 =?us-ascii?Q?leMwZ9BSRwiTVEXTwZlrzCHMTPgLlooWiq047WYD94R2avXACv4NW6MKxm5V?=
 =?us-ascii?Q?LoL1cQz2oPZU9aG+EduIYwR3irCWaMPNVVcyMOY+V7/RNLPEJscIiKLxpDbF?=
 =?us-ascii?Q?W6iqbmBvTdMOyFQG86OWxsb/7CWqw+q69s+FZcxCpiswvYS9shP45CGWV4M5?=
 =?us-ascii?Q?YkooxLbusZ9IffZJB8BCM2szb6MPYlgOFSGsqLa/WnVR8zKbx/iOPw1K7YEw?=
 =?us-ascii?Q?EepAEwB9J6ZXXDNNCssP9VaoFQTAfSwlslUYYR80cxh2WmUsC2BfqD6XxOlt?=
 =?us-ascii?Q?a74Rd43Kt0hcX4+9+J8TAs6Xjx219k9PwddpP4G+LAEoP2M9AKr8Vz80NsDD?=
 =?us-ascii?Q?7QbJstUeb5chuo928mfkIVy/UHw79L9ZQa5lwU+ek7i+Cmehp3iRBfc58/kQ?=
 =?us-ascii?Q?bMs+iDHbpqQA/NfIRFO+LXW2kXqlq4G4u0av+WfhBy5g26YULmyt6BKN5QaS?=
 =?us-ascii?Q?ylcZy/FyL9s+PYzzu5Pm9G0IeYdfE2sDlyqFNXAiFKeTPGY/qW7I2J0iDWug?=
 =?us-ascii?Q?yT0IKheAU4yf8U+A0X8minFgj3lkLa8t9BqzQWFwUVVMCGn7ajbbgiEp/si1?=
 =?us-ascii?Q?DrVL0RlJ7Z5cy1fvUq96iRPhZQau7QpiMWLl6l4jAXUE9EUuyYjJTGdMA867?=
 =?us-ascii?Q?2O2ufwk0MYNiRjKjS7VYifZMbihcWdLtSIgR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:48:39.3667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf309ae3-de53-4fd0-8253-08ddfac96dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168

From: Zi Yan <ziy@nvidia.com>

No function change is intended. The factored out code will be reused in
an upcoming batched folio move function.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/migrate.c | 106 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 39 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 9e5ef39ce73a..ad03e7257847 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1061,19 +1061,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
 	return migrate_folio(mapping, dst, src, mode);
 }
 
-/*
- * Move a src folio to a newly allocated dst folio.
- *
- * The src and dst folios are locked and the src folios was unmapped from
- * the page tables.
- *
- * On success, the src folio was replaced by the dst folio.
- *
- * Return value:
- *   < 0 - error code
- *  MIGRATEPAGE_SUCCESS - success
- */
-static int move_to_new_folio(struct folio *dst, struct folio *src,
+static int _move_to_new_folio_prep(struct folio *dst, struct folio *src,
 				enum migrate_mode mode)
 {
 	struct address_space *mapping = folio_mapping(src);
@@ -1098,7 +1086,12 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 							mode);
 	else
 		rc = fallback_migrate_folio(mapping, dst, src, mode);
+	return rc;
+}
 
+static void _move_to_new_folio_finalize(struct folio *dst, struct folio *src,
+				int rc)
+{
 	if (rc == MIGRATEPAGE_SUCCESS) {
 		/*
 		 * For pagecache folios, src->mapping must be cleared before src
@@ -1110,6 +1103,29 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 		if (likely(!folio_is_zone_device(dst)))
 			flush_dcache_folio(dst);
 	}
+}
+
+/*
+ * Move a src folio to a newly allocated dst folio.
+ *
+ * The src and dst folios are locked and the src folios was unmapped from
+ * the page tables.
+ *
+ * On success, the src folio was replaced by the dst folio.
+ *
+ * Return value:
+ *   < 0 - error code
+ *  MIGRATEPAGE_SUCCESS - success
+ */
+static int move_to_new_folio(struct folio *dst, struct folio *src,
+			enum migrate_mode mode)
+{
+	int rc;
+
+	rc = _move_to_new_folio_prep(dst, src, mode);
+
+	_move_to_new_folio_finalize(dst, src, rc);
+
 	return rc;
 }
 
@@ -1345,32 +1361,9 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	return rc;
 }
 
-/* Migrate the folio to the newly allocated folio in dst. */
-static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
-			      struct folio *src, struct folio *dst,
-			      enum migrate_mode mode, enum migrate_reason reason,
-			      struct list_head *ret)
+static void _migrate_folio_move_finalize1(struct folio *src, struct folio *dst,
+					  int old_page_state)
 {
-	int rc;
-	int old_page_state = 0;
-	struct anon_vma *anon_vma = NULL;
-	struct list_head *prev;
-
-	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
-	prev = dst->lru.prev;
-	list_del(&dst->lru);
-
-	if (unlikely(page_has_movable_ops(&src->page))) {
-		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
-		if (rc)
-			goto out;
-		goto out_unlock_both;
-	}
-
-	rc = move_to_new_folio(dst, src, mode);
-	if (rc)
-		goto out;
-
 	/*
 	 * When successful, push dst to LRU immediately: so that if it
 	 * turns out to be an mlocked page, remove_migration_ptes() will
@@ -1386,8 +1379,12 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 
 	if (old_page_state & PAGE_WAS_MAPPED)
 		remove_migration_ptes(src, dst, 0);
+}
 
-out_unlock_both:
+static void _migrate_folio_move_finalize2(struct folio *src, struct folio *dst,
+					  enum migrate_reason reason,
+					  struct anon_vma *anon_vma)
+{
 	folio_unlock(dst);
 	folio_set_owner_migrate_reason(dst, reason);
 	/*
@@ -1407,6 +1404,37 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 		put_anon_vma(anon_vma);
 	folio_unlock(src);
 	migrate_folio_done(src, reason);
+}
+
+/* Migrate the folio to the newly allocated folio in dst. */
+static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
+			      struct folio *src, struct folio *dst,
+			      enum migrate_mode mode, enum migrate_reason reason,
+			      struct list_head *ret)
+{
+	int rc;
+	int old_page_state = 0;
+	struct anon_vma *anon_vma = NULL;
+	struct list_head *prev;
+
+	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
+	prev = dst->lru.prev;
+	list_del(&dst->lru);
+
+	if (unlikely(page_has_movable_ops(&src->page))) {
+		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
+		if (rc)
+			goto out;
+		goto out_unlock_both;
+	}
+
+	rc = move_to_new_folio(dst, src, mode);
+	if (rc)
+		goto out;
+
+	_migrate_folio_move_finalize1(src, dst, old_page_state);
+out_unlock_both:
+	_migrate_folio_move_finalize2(src, dst, reason, anon_vma);
 
 	return rc;
 out:
-- 
2.43.0


