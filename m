Return-Path: <linux-kernel+bounces-769191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6889AB26B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABEC1CC3B59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D1522FDEA;
	Thu, 14 Aug 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wQALEeC0"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E348025525F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185738; cv=fail; b=VoQ0vjZ0xff+ZgfR0IBhAuZesb09EASiXKwFbqF6xUe7yaqGqXui8N3D0M8ttJpRTELoeOQRaxpecx+CDeGe68MvFlYfTz6h0vMLlTT/xQcxhDp2OjhmSPHxGmt9c+E4TTUVepDiWGj/2TbNndPXehX81DKUPVH/XSDxD17wlmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185738; c=relaxed/simple;
	bh=fNddrjGGNiCPLgz+xPLVQTySO215kqA3Zr0a4JmDTdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtngddM8P9ThgoFB0w6sWu3gwR6R7T3a+QbXUdWn3bRCvdrvnLNb5wsIa0fXyWXfFD8OuNYvgzbFpDBNHHksgLbxP/OaGtOvXgHDjtVtkygJAKqI6vvDO2P1lX9c1CEfcC7m9CpEMf+oLDWIAMlE/oExi/mWcNLzdeEs4ADoPyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wQALEeC0; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI1Fs44ai4ciArbbhRbU1oz3kPL6Gws5tB2Hz1hMav1LYtOf44QDm718J4QrjYC/bsUEll6GPqSCZHENlSGFHYneRv0c21v7wBxUlWihIXIPPWubcGxhk91wvJ5SRoZu3mluZFUVR+jqlIsXl5yu3Dc2ZN4CLVjC0NzIt7/cGXAsuavg2ZlftZGmWvq/y3WGDAETUMK22gt+UERijGqBSLoxvTwSMa0J6JifDO1VcW3N+Wu6VUt9rTJNPVA9gujmd286Uqo+aP5uRIw47tQo1svjMo0JBOGeLH4/qgnBDkSv7yqQR8/wAD3calcQPFsUW8gdBu2+hFWkAaOOgZb0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1tgNC8I1gFvD95n4ns5y9DfXvdC88aWsx9sa4P1GXA=;
 b=HaaTcEG32EySgQGowGvmn0CsNqZs9Zzp5TZ87VinV33Xa3Wj3SJWSVXUSAPad8Lmvqdaq0On2PcXwkqebu3uAa1rbFHUe43HJDTEryRFHJ5fUwubmBUK+vb4OMLYhMZ19tgHG7SCZmMVFNM7ewXsm03eZ+TOqN0qVNSrIZRR5pMRwtyjqHB13N9L0vb5hTvdesfaYAKguHF31dMkHYS5fu3qE+tcRnkXC1GZVENh9tZDuPQt4cRgg3mw7NVLR1T17s2VKvr2lZlNohtRaajnD+j1KYLBY06PIzZe37UUoWaXnF0l8KvaISm3lKSPcLeWNbXek6oDFJop0W8LoErZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1tgNC8I1gFvD95n4ns5y9DfXvdC88aWsx9sa4P1GXA=;
 b=wQALEeC02joMU1Ker+/z7y3C+gw6G3Ly3g9JL4/JenbPY0rvMPtVfmQOyyywcNXoFijGYync5RMWGcWoiWoFwxuKhVYUcpPOKozzRXSZKtMHs7qremcEIsInJex/ZUKIDFHRyVRVgQHbM36ANgWWpBDaJqUZULc1AdnRDVdLfmw=
Received: from MN2PR06CA0028.namprd06.prod.outlook.com (2603:10b6:208:23d::33)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 15:35:32 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::85) by MN2PR06CA0028.outlook.office365.com
 (2603:10b6:208:23d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 15:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:35:32 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:35:18 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Michael.Day@amd.com>,
	<akpm@linux-foundation.org>, <bharata@amd.com>, <dave.hansen@intel.com>,
	<david@redhat.com>, <dongjoo.linux.dev@gmail.com>, <feng.tang@intel.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <honggyu.kim@sk.com>,
	<hughd@google.com>, <jhubbard@nvidia.com>, <jon.grimm@amd.com>,
	<k.shutemov@gmail.com>, <kbusch@meta.com>, <kmanaouil.dev@gmail.com>,
	<leesuyeon0506@gmail.com>, <leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <riel@surriel.com>,
	<rientjes@google.com>, <rppt@kernel.org>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
	<yuanchu@google.com>, <kinseyho@google.com>, <hdanton@sina.com>,
	<harry.yoo@oracle.com>
Subject: [RFC PATCH V3 11/17] mm/kscand: Implement migration failure feedback
Date: Thu, 14 Aug 2025 15:33:01 +0000
Message-ID: <20250814153307.1553061-12-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814153307.1553061-1-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fc2e25-db10-4c11-096d-08dddb48349f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hUslX89EqrE6EzGD1eNDlDq/roZUKF7lpU53Qp1EDZFV3agUNnp7wCASyiAm?=
 =?us-ascii?Q?Sngbvb0GJRqnZUT2gommcV61KvBXw7c0bJbT11G5SMnDU+MIAGfyA2ViTvOJ?=
 =?us-ascii?Q?SUQXqQUWsc7yBOXbfV/jAPRXnkXvg3E8j/PzY22bSsraWEIm3jmfmwKFU4au?=
 =?us-ascii?Q?JYxqQQqKegjM0VfV0qhtcIcmezJt34RCU/8fr87uXhrmdeu24vFq955O/ceK?=
 =?us-ascii?Q?1Ii5N9uzS9pf6D46swXSUlq14plFL/G016Ss9lSlhh6kOemOi0gjZ3kDQ3bY?=
 =?us-ascii?Q?T6a7LKFhoOxWll3erhaJd1sjwFjK2zblyZTMOd4g7YCId4cV9ndRj4gT8s26?=
 =?us-ascii?Q?aCkJrVfgfS8vMGeXIsFdR//mMnkVq5gi5ONVjRpJ+zMB2rCd796XGadj1fti?=
 =?us-ascii?Q?dHijn2uAJFMVWXHOo4x1kKVfYUa81e52A7pj/Y7AdmdQ/e1sblFq8UwP3skE?=
 =?us-ascii?Q?Pi5Gqj7M2JXmmFtXoo2Q6sRgcqinmhYHSDhZ72kL+UeGouk/jQEpo+jwQveP?=
 =?us-ascii?Q?ac6xB7DYl4Eol02yGksjQZMTXV1+7OuYHVKlZpUuaxPrTjCK8U12FCxIduMe?=
 =?us-ascii?Q?c4H9RIZ8FaNwBKPc3fnvUwC8GBXDrLuQWXo8108tahOVUDs7dCJAnIVb5ML/?=
 =?us-ascii?Q?w5cz7CP//7dJ9FNNbm465SAvV1K0m4AjKIguMNvOdRvnH5kUZAv2zJyQ36/a?=
 =?us-ascii?Q?mvTsRZeONoeZxTtS6pWd0mek1ZdZBawAQ0XSerHjaPD7miEMoCwX1wKodzr4?=
 =?us-ascii?Q?OODXk6vRW/62CchtTB3+/kuhIlFvoFoZwFDUWELmt6MuL/5w6KwzHU/DNsBV?=
 =?us-ascii?Q?rSdqf+L5BGhswoFq4iKUr4YV8ICUbt462o0l6W80SI5+s89PPhbEcSkyVeZU?=
 =?us-ascii?Q?GVQ9rhtjTC6GvxkJrpKns/9M2ya0S3HiRXwbqNELoU6y91avrzVi03w/S9MG?=
 =?us-ascii?Q?O07TK+Yrf4/k0x1OB36GdJUnSnQ5Q/Gy6lQT6VBcQtJoIT4I2K4w26IxYQvt?=
 =?us-ascii?Q?mRCvMuG6/WxrOqcl1Khfk5qT1RaBvjuOVPf+nmtWczJOqk8T1Fb6VmD5ulFC?=
 =?us-ascii?Q?ZBHYMUciKdGavpn6WFfcIoTXfWE3xJQDjz+jCLbJi+kLrv7zz5DJWz8nnN30?=
 =?us-ascii?Q?yulz/q+JjTwseOGG+cAd1kVGisXNfhvNxJRFe6ZSCCtitet34vf/K19MNyut?=
 =?us-ascii?Q?OORLO4AD5w+pmRUHxAGpbZbAIDwWdbs9onp9MKLIS1Xh7qZXPZiLJe+uBUEK?=
 =?us-ascii?Q?4uAErYFp5xTOvhQf1rSKsX0N1xjYi9U119I5ycFjlB1uMk6K7AxoJhz/kKEa?=
 =?us-ascii?Q?hjk7aaqZjZap/sOXTgZb/NgXLDy6tE1VxITzrD0vO/7NBT1yW2LKkYKH+QuB?=
 =?us-ascii?Q?rsYORHC0uVsmoW9OiSvguqEtOYxus7sXrwAbHThxxtUQd3gOddmP3kjgQdHw?=
 =?us-ascii?Q?AsjX0pUkCpTZz10J4fvbJqM61UDuu7tijSD3ieDYtBMPDXx7xblgyAMaxDuN?=
 =?us-ascii?Q?ywSWT59+VutPQotXavrvLL0OHazt6FytMLgn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:35:32.3020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fc2e25-db10-4c11-096d-08dddb48349f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554

 Before this, scanning kthread continues to scan even after
migration fails. To control migration, scanning is slowed down
based on the failure/success ratio obtained from migration
thread.

 Decaying failure ratio is maintained for 1024 migration window.
The ratio further contributes to approximately 10% scaling of
scan_period.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kscand.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/mm/kscand.c b/mm/kscand.c
index bf975e82357d..41321d373be7 100644
--- a/mm/kscand.c
+++ b/mm/kscand.c
@@ -146,6 +146,8 @@ struct kmigrated_mm_slot {
 	spinlock_t migrate_lock;
 	/* Head of per mm migration list */
 	struct list_head migrate_head;
+	/* Indicates weighted success, failure */
+	int msuccess, mfailed, fratio;
 };
 
 /* System wide list of mms that maintain migration list */
@@ -812,13 +814,45 @@ static void kscand_collect_mm_slot(struct kscand_mm_slot *mm_slot)
 	}
 }
 
+static int kmigrated_get_mstat_fratio(struct mm_struct *mm)
+{
+	int fratio = 0;
+	struct kmigrated_mm_slot *mm_slot = NULL;
+	struct mm_slot *slot;
+
+	guard(spinlock)(&kscand_migrate_lock);
+
+	slot = mm_slot_lookup(kmigrated_slots_hash, mm);
+	mm_slot = mm_slot_entry(slot, struct kmigrated_mm_slot, mm_slot);
+
+	if (mm_slot)
+		fratio =  mm_slot->fratio;
+
+	return fratio;
+}
+
+static void update_mstat_ratio(struct kmigrated_mm_slot *mm_slot,
+				int msuccess, int mfailed)
+{
+	mm_slot->msuccess = (mm_slot->msuccess >> 2) + msuccess;
+	mm_slot->mfailed = (mm_slot->mfailed >> 2) + mfailed;
+	mm_slot->fratio = mm_slot->mfailed * 100;
+	mm_slot->fratio /=  (mm_slot->msuccess + mm_slot->mfailed);
+}
+
+#define MSTAT_UPDATE_FREQ	1024
+
 static void kmigrated_migrate_mm(struct kmigrated_mm_slot *mm_slot)
 {
+	int mfailed = 0;
+	int msuccess = 0;
+	int mstat_counter;
 	int ret = 0, dest = -1;
 	struct mm_slot *slot;
 	struct mm_struct *mm;
 	struct kscand_migrate_info *info, *tmp;
 
+	mstat_counter = MSTAT_UPDATE_FREQ;
 	spin_lock(&mm_slot->migrate_lock);
 
 	slot = &mm_slot->mm_slot;
@@ -842,11 +876,23 @@ static void kmigrated_migrate_mm(struct kmigrated_mm_slot *mm_slot)
 			}
 
 			ret = kmigrated_promote_folio(info, mm, dest);
+			mstat_counter--;
+
+			/* TBD: encode migrated count here, currently assume folio_nr_pages */
+			if (!ret)
+				msuccess++;
+			else
+				mfailed++;
 
 			kfree(info);
 
 			cond_resched();
 			spin_lock(&mm_slot->migrate_lock);
+			if (!mstat_counter) {
+				update_mstat_ratio(mm_slot, msuccess, mfailed);
+				msuccess  = mfailed = 0;
+				mstat_counter = MSTAT_UPDATE_FREQ;
+			}
 		}
 	}
 clean_list_handled:
@@ -882,6 +928,12 @@ static void kmigrated_migrate_folio(void)
 	}
 }
 
+/* Get scan_period based on migration failure statistics */
+static int kscand_mstat_scan_period(unsigned int scan_period, int fratio)
+{
+	return scan_period * (1 + fratio / 10);
+}
+
 /*
  * This is the normal change percentage when old and new delta remain same.
  * i.e., either both positive or both zero.
@@ -928,6 +980,7 @@ static void kmigrated_migrate_folio(void)
 static inline void kscand_update_mmslot_info(struct kscand_mm_slot *mm_slot,
 				unsigned long total, int target_node)
 {
+	int fratio;
 	unsigned int scan_period;
 	unsigned long now;
 	unsigned long scan_size;
@@ -967,6 +1020,8 @@ static inline void kscand_update_mmslot_info(struct kscand_mm_slot *mm_slot,
 	}
 
 	scan_period = clamp(scan_period, KSCAND_SCAN_PERIOD_MIN, KSCAND_SCAN_PERIOD_MAX);
+	fratio = kmigrated_get_mstat_fratio((&mm_slot->slot)->mm);
+	scan_period = kscand_mstat_scan_period(scan_period, fratio);
 	scan_size = clamp(scan_size, KSCAND_SCAN_SIZE_MIN, KSCAND_SCAN_SIZE_MAX);
 
 	now = jiffies;
-- 
2.34.1


