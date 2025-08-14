Return-Path: <linux-kernel+bounces-769187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC0EB26B35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4B31CE1825
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B13724634F;
	Thu, 14 Aug 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YRsAZaMm"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE799242D66
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185701; cv=fail; b=bNdQr0U7+nyGDOXWrXXwvv4tOUx2Swaiwgvb8mGOsSreekYsefyJ99avF8hXUbkDwZHNDYua0Quv1tLMq5pVmsje6OXp11tyQ1bJ/DMhgab0JDop5ZIpenzOR2wJNHf1yM0wVLypBtvwf1ad+4bKkjBVtTZSqi0TEMqB7tBdNuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185701; c=relaxed/simple;
	bh=K60BnPefbd/XIvlmDbBMuNUeYFmJPAar1pEwSOoAFZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRVi687GX+SuOAuNbJAyGY6060a9maOl/i+jLtNuOrjCvOy/EXjPSsAcjckivEIOl8suCD17lw0FD/2nHaWwItsIcx4XkO1nKiqy88DfHYpBQ/QKJenmtNAMfNMYoQFOSDBxMWB4JM+L+zPJysnrFpAsWypd8QvNCWo4LWu4bjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YRsAZaMm; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvM6iM5ceCuOQVC3oj7oefy6BqfmFH4zAg9bOctTrjnPidNrKzWMNShVITc4kD/R5tDZI2kCAeFQhew2o0fMz0IrQ+WNK67DpksJ2pdXP+1tuBmpmZdQQVWlrnj64crhOrKeXxdCiMaRyqjKqSDy3gLnUYF843c1/iKcM1EvA3BLGAS2LjJ6WREwIUuvoJ0bJ45XcoZNumLiioga2253CcaM3r9G2cychZQ8ap2BZjulFhS6gglgHCMFZSDlq623B80sNeys96iBpy6RpWK+3wnCy3uIgwiNx+nz/aAOMEifMTIdWAZNRmmLFWZ6Tkl+AwA+pC/spLj83DoKdXI6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPVAyiNS4OZw8nJS07dTRaK/Lrchm9e7Lwh000KIeVY=;
 b=zVIPLjSHaLLEdiflPThM90/Ii5UTJQEekvz0MotIe9w9BiQbkMxK4NJB0ZNt7wp2wrQOxHMTqPiDTY744jZrjz29TFk0tq7md4FeYTW4f8uwXruqpjSm3q5dunrfxkFfS+K4bZCyaTBHwzzMSC2v58JX26/+CMbiQXZkh+ITDUNr9sD2xcJGnjSKOe9AEBGibOlFOchI9pgTNiifTWJCllZ7w1b9ExjTcsB0AIYWryMjXbt3ubXpzkm57faW/W5grU6ToPC2L0kygYKn7I3X0iGVhgsyecjrRrR8x6/pxvC1jpU1UFPo/5oB0FjR2sOqDJTWXbSRyEQukBa6Wi2OIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPVAyiNS4OZw8nJS07dTRaK/Lrchm9e7Lwh000KIeVY=;
 b=YRsAZaMmtP9uVLef7zKlohaEvrxMzJvTta6J/mQh3kmFZ/yZXA9vsfI1T8buprz+yMsIT2kwuKO0wEnvbkw55Zyv3Z96xscyV4wTgAMG9/KYArOWIsPGR97c4FDrDJnx85jeM0atHqxSBOYmzbXyyV5ftboTd/6OBT31rMDQfhc=
Received: from MN2PR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:c0::39)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 15:34:57 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::46) by MN2PR05CA0026.outlook.office365.com
 (2603:10b6:208:c0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.6 via Frontend Transport; Thu,
 14 Aug 2025 15:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:34:56 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:34:46 -0500
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
Subject: [RFC PATCH V3 08/17] mm: Add throttling of mm scanning using scan_size
Date: Thu, 14 Aug 2025 15:32:58 +0000
Message-ID: <20250814153307.1553061-9-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: c99a4623-ea3f-43c3-16d3-08dddb481f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pJli8E3NtzuwHCX561DIowNErRI4bURBXTfcsdjZytezFdcXJSQ0cuEHOmD2?=
 =?us-ascii?Q?fZe4x6kQPhXGpRrfFGzViJPm1SwqCCo57tloOXRtTCoLPEOUA7GCRzUUAFkj?=
 =?us-ascii?Q?AmtPHZgZNE/xFQaYAy2yR0al9QqTcB94VfdRHaf58kMn2nHzIIwFqU9YgCzG?=
 =?us-ascii?Q?Jw0t8quDaUpUy1H2IU5tpr6JnUeHbZxkUyzP4OZ1lsPqIZwR/Vmbn6FakIsp?=
 =?us-ascii?Q?O9No9dlBVMkznNvehmCOE7qlRKVMwSVVvRow6T6FD6jBluqGSb602z3xREVa?=
 =?us-ascii?Q?HU7Nf3crg/GY2C2UsjyuW/IO0UWP1XmB4c+Xg1d4+15c/cQkvaVhjAvvRsGV?=
 =?us-ascii?Q?2xMVBy2pfkZmbuzkUv817UPAuwvsYYQeOKGE/16s/Jj4nMm1wEZbSjZSvUtv?=
 =?us-ascii?Q?pTdzGv7/xgkqZUwgqGIbhAe/96LRWA/dXNjpb+qVVGVOHbbdNkXXQAIniUlJ?=
 =?us-ascii?Q?KwblkJOsGm0zkTfR2tEQm0b6Aeb7DA6O64fSgmyXzo9UYsH6oaYver017kaM?=
 =?us-ascii?Q?n4910WMlfnYlPhHXeRrLA3Vbcom5j2rxoXZcT5bwk3dblzvJ/4djtXjNhYRC?=
 =?us-ascii?Q?vsTqzydQTwqh8WOtfZQ9ydwvUOTk2zAdUXK9kMaKTI/M97Sko+2s6+lNhG5x?=
 =?us-ascii?Q?QeYkvVGPEyIzAHHserlmVmQBHFm2R/Bazt36VMEg57YPlaH8vz/GpnOm9mxJ?=
 =?us-ascii?Q?BqDY12XkrcNSJgh1j2W8lbwlQ9ISO+Q++KL1JnV+Ql0IObiSgALh+ml1G8Ps?=
 =?us-ascii?Q?4yaKX0JPuqiwKO9ubnZjRqVxx6rgoIPe/fLk7bkCOAfhPrQMEFWAMyeikT+T?=
 =?us-ascii?Q?g/yAT8m5MS7qPg/o9NANb6XTq+jPd8/bPLHFrnWu6XfuvdslGKAgIMHHn+kk?=
 =?us-ascii?Q?44gbIZJftHwHuMPyA/mvFWuJxJxsp8nFrtetzfdGa867RdqjLA9OCxg1EbPA?=
 =?us-ascii?Q?77o38tpBTJunSWKQcw8vJ2gIf4uQAfl+G9zQsOXkeHfS9fK24Y0MoqODYVTu?=
 =?us-ascii?Q?z0S+MXLlARcdo1ah4kDxzzgCmoY0wTLWIXK4VJm+CQypuz5PaX1N+XbTVuH1?=
 =?us-ascii?Q?w77xerjpkKXDDtXpNaYuZy9sbn6ziC2/xDVzoqhLc/Z/UDCC4kohOFeW6LOE?=
 =?us-ascii?Q?OJZAnowGD+P/cKSL2DEYgc0yEDrqO9ZhGf1yAnka5d3w4gUtejnilGlCE4sU?=
 =?us-ascii?Q?7pzTCO5ZzynUHTmIf7vPHA4TIGxbeVZ1mOMx8pJCEZ9iFOBtnrJbEJFVXiqq?=
 =?us-ascii?Q?1Q9W/sGTG9uM+to+bwurWxG08FKym/LHuMgyBeP/Cf1LC+7G1kf8Fscgp39x?=
 =?us-ascii?Q?upkn7e9e05rnh9Jn8OtCAzXapWPdWF2ReTH3uQGDBetshpH2PFbRDgrhl4mU?=
 =?us-ascii?Q?DnhS6+sH5UjJwSEpUUYeI9hUvzarldYtRs4K4S77al8Z7O/oy2b9AjvB6e1h?=
 =?us-ascii?Q?v0m9KZKMMbxz8Hw1PG1Vm3nrgPP7uovuFP6ZqwVssd7YqRh27SupNT/NMzUp?=
 =?us-ascii?Q?AqynZMFH8d3NbBKM/xcZczIFtJtJHkkDo6f0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:34:56.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99a4623-ea3f-43c3-16d3-08dddb481f81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

Before this patch, scanning is done on entire virtual address space
of all the tasks. Now the scan size is shrunk or expanded based on the
useful pages found in the last scan.

This helps to quickly get out of unnecessary scanning thus burning
lesser CPU.

Drawback: If a useful chunk is at the other end of the VMA space, it
will delay scanning and migration.

Shrink/expand algorithm for scan_size:
X : Number of useful pages in the last scan.
Y : Number of useful pages found in current scan.
Initial scan_size is 1GB
 case 1: (X = 0, Y = 0)
  Decrease scan_size by 2
 case 2: (X = 0, Y > 0)
  Aggressively change to MAX (4GB)
 case 3: (X > 0, Y = 0 )
   No change
 case 4: (X > 0, Y > 0)
   Increase scan_size by 2

Scan size is clamped between MIN (256MB) and MAX (4GB)).
TBD:  Tuning based on real workloads

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kscand.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/kscand.c b/mm/kscand.c
index 843069048c61..39a7fcef7de8 100644
--- a/mm/kscand.c
+++ b/mm/kscand.c
@@ -28,10 +28,15 @@
 
 static struct task_struct *kscand_thread __read_mostly;
 static DEFINE_MUTEX(kscand_mutex);
+
 /*
  * Total VMA size to cover during scan.
+ * Min: 256MB default: 1GB max: 4GB
  */
+#define KSCAND_SCAN_SIZE_MIN	(256 * 1024 * 1024UL)
+#define KSCAND_SCAN_SIZE_MAX	(4 * 1024 * 1024 * 1024UL)
 #define KSCAND_SCAN_SIZE	(1 * 1024 * 1024 * 1024UL)
+
 static unsigned long kscand_scan_size __read_mostly = KSCAND_SCAN_SIZE;
 
 /*
@@ -94,6 +99,8 @@ struct kscand_mm_slot {
 	unsigned long next_scan;
 	/* Tracks how many useful pages obtained for migration in the last scan */
 	unsigned long scan_delta;
+	/* Determines how much VMA address space to be covered in the scanning */
+	unsigned long scan_size;
 	long address;
 	bool is_scanned;
 };
@@ -746,6 +753,8 @@ static void kmigrated_migrate_folio(void)
  */
 #define KSCAND_IGNORE_SCAN_THR	256
 
+#define SCAN_SIZE_CHANGE_SHIFT	1
+
 /* Maintains stability of scan_period by decaying last time accessed pages */
 #define SCAN_DECAY_SHIFT	4
 /*
@@ -761,14 +770,26 @@ static void kmigrated_migrate_folio(void)
  *		Increase scan_period by (2 << SCAN_PERIOD_CHANGE_SCALE).
  *	case 4: (X > 0, Y > 0)
  *		Decrease scan_period by SCAN_PERIOD_TUNE_PERCENT.
+ * Tuning scan_size:
+ * Initial scan_size is 4GB
+ *	case 1: (X = 0, Y = 0)
+ *		Decrease scan_size by (1 << SCAN_SIZE_CHANGE_SHIFT).
+ *	case 2: (X = 0, Y > 0)
+ *		scan_size = KSCAND_SCAN_SIZE_MAX
+ *  case 3: (X > 0, Y = 0 )
+ *		No change
+ *  case 4: (X > 0, Y > 0)
+ *		Increase scan_size by (1 << SCAN_SIZE_CHANGE_SHIFT).
  */
 static inline void kscand_update_mmslot_info(struct kscand_mm_slot *mm_slot,
 				unsigned long total)
 {
 	unsigned int scan_period;
 	unsigned long now;
+	unsigned long scan_size;
 	unsigned long old_scan_delta;
 
+	scan_size = mm_slot->scan_size;
 	scan_period = mm_slot->scan_period;
 	old_scan_delta = mm_slot->scan_delta;
 
@@ -789,20 +810,25 @@ static inline void kscand_update_mmslot_info(struct kscand_mm_slot *mm_slot,
 	if (!old_scan_delta && !total) {
 		scan_period = (100 + SCAN_PERIOD_TUNE_PERCENT) * scan_period;
 		scan_period /= 100;
+		scan_size = scan_size >> SCAN_SIZE_CHANGE_SHIFT;
 	} else if (old_scan_delta && total) {
 		scan_period = (100 - SCAN_PERIOD_TUNE_PERCENT) * scan_period;
 		scan_period /= 100;
+		scan_size = scan_size << SCAN_SIZE_CHANGE_SHIFT;
 	} else if (old_scan_delta && !total) {
 		scan_period = scan_period << SCAN_PERIOD_CHANGE_SCALE;
 	} else {
 		scan_period = scan_period >> SCAN_PERIOD_CHANGE_SCALE;
+		scan_size = KSCAND_SCAN_SIZE_MAX;
 	}
 
 	scan_period = clamp(scan_period, KSCAND_SCAN_PERIOD_MIN, KSCAND_SCAN_PERIOD_MAX);
+	scan_size = clamp(scan_size, KSCAND_SCAN_SIZE_MIN, KSCAND_SCAN_SIZE_MAX);
 
 	now = jiffies;
 	mm_slot->next_scan = now + msecs_to_jiffies(scan_period);
 	mm_slot->scan_period = scan_period;
+	mm_slot->scan_size = scan_size;
 	mm_slot->scan_delta = total;
 }
 
@@ -814,6 +840,7 @@ static unsigned long kscand_scan_mm_slot(void)
 	unsigned int mm_slot_scan_period;
 	unsigned long now;
 	unsigned long mm_slot_next_scan;
+	unsigned long mm_slot_scan_size;
 	unsigned long vma_scanned_size = 0;
 	unsigned long address;
 	unsigned long total = 0;
@@ -843,6 +870,7 @@ static unsigned long kscand_scan_mm_slot(void)
 	mm_slot->is_scanned = true;
 	mm_slot_next_scan = mm_slot->next_scan;
 	mm_slot_scan_period = mm_slot->scan_period;
+	mm_slot_scan_size = mm_slot->scan_size;
 	spin_unlock(&kscand_mm_lock);
 
 	if (unlikely(!mmap_read_trylock(mm)))
@@ -994,6 +1022,7 @@ void __kscand_enter(struct mm_struct *mm)
 
 	kscand_slot->address = 0;
 	kscand_slot->scan_period = kscand_mm_scan_period_ms;
+	kscand_slot->scan_size = kscand_scan_size;
 	kscand_slot->next_scan = 0;
 	kscand_slot->scan_delta = 0;
 
-- 
2.34.1


