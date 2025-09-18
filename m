Return-Path: <linux-kernel+bounces-810441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7FBB51ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5ADA05708
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4409D353342;
	Wed, 10 Sep 2025 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U9RBzGoJ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8932A821
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515849; cv=fail; b=bYbqECgAALFCY8nG85MJQv8mRrp6LDBZZer1aaW2qxCAdk7oG1HP0VdwT83ELVZWwIIYHbCGiQVcOsL12AoMrituxe3EXRrElWfoSUOSZ9wM+wAgBeA+f47tneFYR2Pm75qMVmSy94sUCOIE2qg/NLcV6Sv+3Fk/wWUiBGPUFRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515849; c=relaxed/simple;
	bh=8GFCMFyZcygw91Iwpw0G1bqszElkPrIf0Soft7Q1hBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbNDhuCLkmhKH9y3FBxAt4/wguuh++op7T7NUDIEaLSCm7WPj6RSEaU8WOZTKsNM7qNPE++PaBPzs5+VrJ/9egcpIKhvLDiNnBphPHE4bvzDEuy8AuhSI57RtzXNRUkP/jNzVlfPP/7MoYKdiXOLKno+KTwNUXhvvvFoZa8cYB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U9RBzGoJ; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqQnViLDvUOCpozg56SVGuNkPLoYjfYCqlQfYi4PMY96cMRM9kNMjF+WrKXVWDoDDXWu/04FmAtXbU6Q2QeMlW8XaDowXOHOwjGFzibpXMA4sPptHaf/7lQaLLAzsA1+keYHUAtxh5CZmFlpWs+83wpXhqkOqNZ6/eE5HLy7pHp9tP04l1t62QTaHS5H232RoxGz80g6HMzGdG+x4MkG/yfbX5YKIwW08LthqViwnqPwd6gE1jryK+pVioqgfJI1i/6zS2okdSxEA6CXkJ+AJ5Tks07SIElBHWwRXeJohmrJeDshafqLQE1JK3ytLi/Mv2dKrs/5816rkn33kHj/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=En4DH7fO2JySYtzsyijxzDN2SB5CfkOTNNwCnytukWU=;
 b=M/kINP/9OeeyX4g7XB3ttU8YG8bivO991jjrmlH6009y6i3nNfzW/UNHvxbgsqoZXcLfWWmVZGW/mzp3x9CL1j6CYQYiF3XINJ4QfnOGcC6sVqES4OveDV3fGw8+v+yOZdf4PAbdkcLfOm6NbUqYjANRP0HjrM8BlBJ6Umj3qGrkGuBZfqmP5fTOEF/x4+9la7N4IwMvUSdcSUIxEBgNmZDw1Zz8s0WhGMUeqy5N6SCS2PHPWewDqgFDlHl3uUZ8aVh7NX7zBArit1Z+6BlTkFDEIK55/Cbhbi1c5Zh1VpfOLZ5M7OdjB7OYVulA/ioLfyLfoLxYQ86878KMRaKMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En4DH7fO2JySYtzsyijxzDN2SB5CfkOTNNwCnytukWU=;
 b=U9RBzGoJ+pzeITZdFkI/I/FGT/TvYgA1bMM0FaLlQcKvx8zWLCoLj8N8qqgyX/bQfMFGWZRy6pLfuOx9R/wEJfmi+ojYq+vIAf9t/LEw9KqQAaWOruLfWyFnGT0GUGwZ1nlNja2jGcXX0kHmgZNBeXj0l0rp4kuXl0yJeoEiDQQ=
Received: from MN2PR04CA0034.namprd04.prod.outlook.com (2603:10b6:208:d4::47)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:50:33 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::74) by MN2PR04CA0034.outlook.office365.com
 (2603:10b6:208:d4::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Wed,
 10 Sep 2025 14:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 14:50:33 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 07:50:22 -0700
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
	<alok.rathore@samsung.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v2 6/8] mm: mglru: generalize page table walk
Date: Wed, 10 Sep 2025 20:16:51 +0530
Message-ID: <20250910144653.212066-7-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910144653.212066-1-bharata@amd.com>
References: <20250910144653.212066-1-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: fbed8f6e-7b8d-4be9-99f5-08ddf07964f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XO9CACAURuVs68nZhBkGXKV2DGEcKiutVK8tnExBw71tYGwEAiLxtdl1p6bH?=
 =?us-ascii?Q?bPkoOYcmzamS6zd2OIyYCbqtVHfQ7TpVVjrzhM3UK9zxm0mnVo7ByHw9AisQ?=
 =?us-ascii?Q?bC0nEQWaRBR+ADkSkiC/laSFPr9x4tyScEQyKU4A1fw+vVRYpHwz/OACcdWx?=
 =?us-ascii?Q?gAgr5mr8Puf37ieIaSjyr2DVoYrv62u1tvv9T2qQhOz8EMmwQx20dDKCDMbF?=
 =?us-ascii?Q?2V1vkhDTSuAr+e8ufTK9LOkhcctarJ3wzv95/5eClcf9UvhGxQCbPUK561Tk?=
 =?us-ascii?Q?65ImZ2bzYRb9/Xs3w+Grlt4qrvCwOpPwDMUktmvRYXlI5UyIsg8nj/Qh1wou?=
 =?us-ascii?Q?0RSnrQOAzig9Yt4Xgs3AxW0dmYPwDAnkHvra2fXE/jrtgGAuP+0RF7/PV/Y0?=
 =?us-ascii?Q?Rm92vDGxz6O0CK8vupwYzbtlojed1CFn33qHdl6DIBG0O9+/BcvUQriSHQDX?=
 =?us-ascii?Q?cVxeFgrBlO4iLtmcVt+baRb8I4+vamWdf1CTWTQIRiA0xU7a4QQrBFM6oyGy?=
 =?us-ascii?Q?3UUCXSAVtLb32ba5K/Uy82AoCPxS0z0DDUC+8/YIeLd0y7xVxT5Nvhn5zxwm?=
 =?us-ascii?Q?SODH7lo9w7V9NnzEA5wN7gVOZ5ZC3F6M6Fb+ICAdeHeOHgMjzSCUBbdeuRnO?=
 =?us-ascii?Q?HH9I+CHh+S/7nmURZ3veytuGPoW/lNU/jd0HiTtEoBBIX6eBALjjqagZ7tP8?=
 =?us-ascii?Q?JXXkEwSYyDh3O5AcHk0fXw0ZX727AxV3CeXzuq+F8djkuguiFqenJPxZkTQE?=
 =?us-ascii?Q?EjkqKRyp6DuwhH/Qv+dPpRtnmZJAA6dpv23uVpVhnDhPlpmD64EvxqBbPzAR?=
 =?us-ascii?Q?eGBBTpcwWKAleyiJyW3LW26ZK1qlwWLbo9YfkrQJ2XREtna+RszcmjacX42M?=
 =?us-ascii?Q?iI3vqf7czFlfIVZT52fTIg5s16NsNGDvPxGo2i78aRDMAcZLDTI3M/mQtOIJ?=
 =?us-ascii?Q?Ip4ZisHVCCW8iCzCUw4h8ODoVSdkomhCAXU8kP7KUNQDEPrPdaBIkGHW+U0T?=
 =?us-ascii?Q?6x1lML7j+pzmA0HU2yzZOK5Un7wgnWWoHsH/aD9MjWF8MXJo/T3pXG2uMzrj?=
 =?us-ascii?Q?Oq+BQ18nxcUWUXY1LMgRLu7GVZlQp+lJDzxwQVmfrv9C7Y8lPh7MNyDvQLrq?=
 =?us-ascii?Q?enR2WodUzm2plpEr9DEeVxHmNe7p2rbFXqIzq+GfZN6gY9gVlxR9RULbCp/g?=
 =?us-ascii?Q?mVm9pg0dc5yWaxaLy+G7RjoQcS2UiSC4RpNxdBVMQ6Bu7HcnK2gx5VZhSP+b?=
 =?us-ascii?Q?O+N+4zug7C5eVkdyMX/LT8RZNHG4SbaXQbxUN/rCgJ7PZmkS7fG/Zu5RHFXG?=
 =?us-ascii?Q?f70i3EIYIPQGVNospskceMkHW3pH1ALzpVoDAecKjQ/FYoKWsymcLkvOAG94?=
 =?us-ascii?Q?YLLvzT+5L9u/a5akAFSe9Fpybtr9kPjixXetRq5MGqE2IMspXyJa510x8Spc?=
 =?us-ascii?Q?rU9u44o+Sx/5S0MIyAZl1E52mMYX9fQzidr4cL18CAi11zcGAzaW5K1BGtQp?=
 =?us-ascii?Q?ITr+nm4xZxgwZW8v2Hv0PoUoTTGJhBRvCpBU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:50:33.1503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbed8f6e-7b8d-4be9-99f5-08ddf07964f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832

From: Kinsey Ho <kinseyho@google.com>

Refactor the existing MGLRU page table walking logic to make it
resumable.

Additionally, introduce two hooks into the MGLRU page table walk:
accessed callback and flush callback. The accessed callback is called
for each accessed page detected via the scanned accessed bit. The flush
callback is called when the accessed callback reports an out of space
error. This allows for processing pages in batches for efficiency.

With a generalised page table walk, introduce a new scan function which
repeatedly scans on the same young generation and does not add a new
young generation.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 include/linux/mmzone.h |   5 ++
 mm/internal.h          |   4 +
 mm/vmscan.c            | 176 ++++++++++++++++++++++++++++++-----------
 3 files changed, 139 insertions(+), 46 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index f7094babed10..4ad15490aff6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -533,6 +533,8 @@ struct lru_gen_mm_walk {
 	unsigned long seq;
 	/* the next address within an mm to scan */
 	unsigned long next_addr;
+	/* called for each accessed pte/pmd */
+	int (*accessed_cb)(unsigned long pfn);
 	/* to batch promoted pages */
 	int nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* to batch the mm stats */
@@ -540,6 +542,9 @@ struct lru_gen_mm_walk {
 	/* total batched items */
 	int batched;
 	int swappiness;
+	/* for the pmd under scanning */
+	int nr_young_pte;
+	int nr_total_pte;
 	bool force_scan;
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc03..6c2c86abfde2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -548,6 +548,10 @@ static inline int user_proactive_reclaim(char *buf,
 	return 0;
 }
 #endif
+void set_task_reclaim_state(struct task_struct *task,
+				   struct reclaim_state *rs);
+void lru_gen_scan_lruvec(struct lruvec *lruvec, unsigned long seq,
+			 int (*accessed_cb)(unsigned long), void (*flush_cb)(void));
 
 /*
  * in mm/rmap.c:
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7de11524a936..4146e17f90ae 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -289,7 +289,7 @@ static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
 			continue;				\
 		else
 
-static void set_task_reclaim_state(struct task_struct *task,
+void set_task_reclaim_state(struct task_struct *task,
 				   struct reclaim_state *rs)
 {
 	/* Check for an overwrite */
@@ -3092,7 +3092,7 @@ static bool iterate_mm_list(struct lru_gen_mm_walk *walk, struct mm_struct **ite
 
 	VM_WARN_ON_ONCE(mm_state->seq + 1 < walk->seq);
 
-	if (walk->seq <= mm_state->seq)
+	if (!walk->accessed_cb && walk->seq <= mm_state->seq)
 		goto done;
 
 	if (!mm_state->head)
@@ -3518,16 +3518,14 @@ static void walk_update_folio(struct lru_gen_mm_walk *walk, struct folio *folio,
 	}
 }
 
-static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
-			   struct mm_walk *args)
+static int walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
+			   struct mm_walk *args, bool *suitable)
 {
-	int i;
+	int i, err = 0;
 	bool dirty;
 	pte_t *pte;
 	spinlock_t *ptl;
 	unsigned long addr;
-	int total = 0;
-	int young = 0;
 	struct folio *last = NULL;
 	struct lru_gen_mm_walk *walk = args->private;
 	struct mem_cgroup *memcg = lruvec_memcg(walk->lruvec);
@@ -3537,17 +3535,21 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	pmd_t pmdval;
 
 	pte = pte_offset_map_rw_nolock(args->mm, pmd, start & PMD_MASK, &pmdval, &ptl);
-	if (!pte)
-		return false;
+	if (!pte) {
+		*suitable = false;
+		return 0;
+	}
 
 	if (!spin_trylock(ptl)) {
 		pte_unmap(pte);
-		return true;
+		*suitable = true;
+		return 0;
 	}
 
 	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
 		pte_unmap_unlock(pte, ptl);
-		return false;
+		*suitable = false;
+		return 0;
 	}
 
 	arch_enter_lazy_mmu_mode();
@@ -3557,7 +3559,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		struct folio *folio;
 		pte_t ptent = ptep_get(pte + i);
 
-		total++;
+		walk->nr_total_pte++;
 		walk->mm_stats[MM_LEAF_TOTAL]++;
 
 		pfn = get_pte_pfn(ptent, args->vma, addr, pgdat);
@@ -3581,23 +3583,34 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		if (pte_dirty(ptent))
 			dirty = true;
 
-		young++;
+		walk->nr_young_pte++;
 		walk->mm_stats[MM_LEAF_YOUNG]++;
+
+		if (!walk->accessed_cb)
+			continue;
+
+		err = walk->accessed_cb(pfn);
+		if (err) {
+			walk->next_addr = addr + PAGE_SIZE;
+			break;
+		}
 	}
 
 	walk_update_folio(walk, last, gen, dirty);
 	last = NULL;
 
-	if (i < PTRS_PER_PTE && get_next_vma(PMD_MASK, PAGE_SIZE, args, &start, &end))
+	if (!err && i < PTRS_PER_PTE &&
+	    get_next_vma(PMD_MASK, PAGE_SIZE, args, &start, &end))
 		goto restart;
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(pte, ptl);
 
-	return suitable_to_scan(total, young);
+	*suitable = suitable_to_scan(walk->nr_total_pte, walk->nr_young_pte);
+	return err;
 }
 
-static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area_struct *vma,
+static int walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area_struct *vma,
 				  struct mm_walk *args, unsigned long *bitmap, unsigned long *first)
 {
 	int i;
@@ -3610,6 +3623,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
 	DEFINE_MAX_SEQ(walk->lruvec);
 	int gen = lru_gen_from_seq(max_seq);
+	int err = 0;
 
 	VM_WARN_ON_ONCE(pud_leaf(*pud));
 
@@ -3617,13 +3631,13 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 	if (*first == -1) {
 		*first = addr;
 		bitmap_zero(bitmap, MIN_LRU_BATCH);
-		return;
+		return 0;
 	}
 
 	i = addr == -1 ? 0 : pmd_index(addr) - pmd_index(*first);
 	if (i && i <= MIN_LRU_BATCH) {
 		__set_bit(i - 1, bitmap);
-		return;
+		return 0;
 	}
 
 	pmd = pmd_offset(pud, *first);
@@ -3673,6 +3687,16 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 			dirty = true;
 
 		walk->mm_stats[MM_LEAF_YOUNG]++;
+		if (!walk->accessed_cb)
+			goto next;
+
+		err = walk->accessed_cb(pfn);
+		if (err) {
+			i = find_next_bit(bitmap, MIN_LRU_BATCH, i) + 1;
+
+			walk->next_addr = (*first & PMD_MASK) + i * PMD_SIZE;
+			break;
+		}
 next:
 		i = i > MIN_LRU_BATCH ? 0 : find_next_bit(bitmap, MIN_LRU_BATCH, i) + 1;
 	} while (i <= MIN_LRU_BATCH);
@@ -3683,9 +3707,10 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 	spin_unlock(ptl);
 done:
 	*first = -1;
+	return err;
 }
 
-static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
+static int walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 			   struct mm_walk *args)
 {
 	int i;
@@ -3697,6 +3722,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 	unsigned long first = -1;
 	struct lru_gen_mm_walk *walk = args->private;
 	struct lru_gen_mm_state *mm_state = get_mm_state(walk->lruvec);
+	int err = 0;
 
 	VM_WARN_ON_ONCE(pud_leaf(*pud));
 
@@ -3710,6 +3736,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 	/* walk_pte_range() may call get_next_vma() */
 	vma = args->vma;
 	for (i = pmd_index(start), addr = start; addr != end; i++, addr = next) {
+		bool suitable;
 		pmd_t val = pmdp_get_lockless(pmd + i);
 
 		next = pmd_addr_end(addr, end);
@@ -3726,7 +3753,10 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 			walk->mm_stats[MM_LEAF_TOTAL]++;
 
 			if (pfn != -1)
-				walk_pmd_range_locked(pud, addr, vma, args, bitmap, &first);
+				err = walk_pmd_range_locked(pud, addr, vma, args,
+						bitmap, &first);
+			if (err)
+				return err;
 			continue;
 		}
 
@@ -3735,33 +3765,50 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 			if (!pmd_young(val))
 				continue;
 
-			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &first);
+			err = walk_pmd_range_locked(pud, addr, vma, args,
+						bitmap, &first);
+			if (err)
+				return err;
 		}
 
 		if (!walk->force_scan && !test_bloom_filter(mm_state, walk->seq, pmd + i))
 			continue;
 
+		err = walk_pte_range(&val, addr, next, args, &suitable);
+		if (err && walk->next_addr < next && first == -1)
+			return err;
+
+		walk->nr_total_pte = 0;
+		walk->nr_young_pte = 0;
+
 		walk->mm_stats[MM_NONLEAF_FOUND]++;
 
-		if (!walk_pte_range(&val, addr, next, args))
-			continue;
+		if (!suitable)
+			goto next;
 
 		walk->mm_stats[MM_NONLEAF_ADDED]++;
 
 		/* carry over to the next generation */
 		update_bloom_filter(mm_state, walk->seq + 1, pmd + i);
+next:
+		if (err) {
+			walk->next_addr = first;
+			return err;
+		}
 	}
 
-	walk_pmd_range_locked(pud, -1, vma, args, bitmap, &first);
+	err = walk_pmd_range_locked(pud, -1, vma, args, bitmap, &first);
 
-	if (i < PTRS_PER_PMD && get_next_vma(PUD_MASK, PMD_SIZE, args, &start, &end))
+	if (!err && i < PTRS_PER_PMD && get_next_vma(PUD_MASK, PMD_SIZE, args, &start, &end))
 		goto restart;
+
+	return err;
 }
 
 static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 			  struct mm_walk *args)
 {
-	int i;
+	int i, err;
 	pud_t *pud;
 	unsigned long addr;
 	unsigned long next;
@@ -3779,7 +3826,9 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 		if (!pud_present(val) || WARN_ON_ONCE(pud_leaf(val)))
 			continue;
 
-		walk_pmd_range(&val, addr, next, args);
+		err = walk_pmd_range(&val, addr, next, args);
+		if (err)
+			return err;
 
 		if (need_resched() || walk->batched >= MAX_LRU_BATCH) {
 			end = (addr | ~PUD_MASK) + 1;
@@ -3800,40 +3849,48 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 	return -EAGAIN;
 }
 
-static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
+static int try_walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 {
+	int err;
 	static const struct mm_walk_ops mm_walk_ops = {
 		.test_walk = should_skip_vma,
 		.p4d_entry = walk_pud_range,
 		.walk_lock = PGWALK_RDLOCK,
 	};
-	int err;
 	struct lruvec *lruvec = walk->lruvec;
 
-	walk->next_addr = FIRST_USER_ADDRESS;
+	DEFINE_MAX_SEQ(lruvec);
 
-	do {
-		DEFINE_MAX_SEQ(lruvec);
+	err = -EBUSY;
 
-		err = -EBUSY;
+	/* another thread might have called inc_max_seq() */
+	if (walk->seq != max_seq)
+		return err;
 
-		/* another thread might have called inc_max_seq() */
-		if (walk->seq != max_seq)
-			break;
+	/* the caller might be holding the lock for write */
+	if (mmap_read_trylock(mm)) {
+		err = walk_page_range(mm, walk->next_addr, ULONG_MAX,
+				      &mm_walk_ops, walk);
 
-		/* the caller might be holding the lock for write */
-		if (mmap_read_trylock(mm)) {
-			err = walk_page_range(mm, walk->next_addr, ULONG_MAX, &mm_walk_ops, walk);
+		mmap_read_unlock(mm);
+	}
 
-			mmap_read_unlock(mm);
-		}
+	if (walk->batched) {
+		spin_lock_irq(&lruvec->lru_lock);
+		reset_batch_size(walk);
+		spin_unlock_irq(&lruvec->lru_lock);
+	}
 
-		if (walk->batched) {
-			spin_lock_irq(&lruvec->lru_lock);
-			reset_batch_size(walk);
-			spin_unlock_irq(&lruvec->lru_lock);
-		}
+	return err;
+}
 
+static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
+{
+	int err;
+
+	walk->next_addr = FIRST_USER_ADDRESS;
+	do {
+		err = try_walk_mm(mm, walk);
 		cond_resched();
 	} while (err == -EAGAIN);
 }
@@ -4045,6 +4102,33 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	return success;
 }
 
+void lru_gen_scan_lruvec(struct lruvec *lruvec, unsigned long seq,
+			 int (*accessed_cb)(unsigned long), void (*flush_cb)(void))
+{
+	struct lru_gen_mm_walk *walk = current->reclaim_state->mm_walk;
+	struct mm_struct *mm = NULL;
+
+	walk->lruvec = lruvec;
+	walk->seq = seq;
+	walk->accessed_cb = accessed_cb;
+	walk->swappiness = MAX_SWAPPINESS;
+
+	do {
+		int err = -EBUSY;
+
+		iterate_mm_list(walk, &mm);
+		if (!mm)
+			break;
+
+		walk->next_addr = FIRST_USER_ADDRESS;
+		do {
+			err = try_walk_mm(mm, walk);
+			cond_resched();
+			flush_cb();
+		} while (err == -EAGAIN);
+	} while (mm);
+}
+
 static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq,
 			       int swappiness, bool force_scan)
 {
-- 
2.34.1


