Return-Path: <linux-kernel+bounces-769197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C2B26B42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA30AA4D85
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342C248869;
	Thu, 14 Aug 2025 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dpO89jon"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403802F60C7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185786; cv=fail; b=Tqk3whpyRLsX08XHQ3sBTaV2ix3PUjpy2kRG/QQHAYEJQuGhOF2gJTBFIKE+cTQrn6PBJIYn2xaJusSIqr4lMx+brVXiIuj4S2AbBr+j5ZHFFI+yce4d8RSvBJAEEfgdOVfvu++wvu0T5isYt7JwHNVnBABAywJj7NRj5hBEcUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185786; c=relaxed/simple;
	bh=y4V15B3iYTlTUAGf1eUhOzHHTNW5w9o/RpgT+d04N5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dq2DPmVlFFG8HzjiqtI9Mk8UvfkhHh1hPRY/BHZHbgjptWxlAnBjeFgFjkI2RqSZOCalImzhI7ceg/C9WA88JE0y5LfbaX+gwmLAJc+qkuKNSmulxiXlxbhFqMVFm8/o/Jdt1oOZcMHe1VAbuhjJu7m8feuKoZV497l2kkfmjqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dpO89jon; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCx7MiG7z1QWmZG4n4gjHbwqrYpoIo9FAFpnv8cSsbiGR2wOr9uZs6T14eS/inD0phMQ1t5nkk8KCR2fpcgp2gS7u/WTH5fXNfM3JkMupbWn+cG7vj+ujudTMGy5KQjMnE166IiNkfT1/+OfyCWjJoQHHVd1jbU68pYxFKYV/PTDWZw2R3pGcf8RCk1FlylSrNMBwq5za4+OFdb+dbwuKMiALUQ0vfsRGddXL57sQ4dlFfMjzGnxeOQ+ZDocdupjRXt34l+Lr0P4dsXJrCcqm6DVfCRug4dqFkGv9xlBl3Hz0H4QEdqiuDKyz8qVLu11BZn4rgm28kHPrVXbcPyrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JidjaM9jyZU+0KQmXw5u/FNar0F7TNpXCByTADsZ7fE=;
 b=wIa7iuZxBQUscRC4RBBclmhdJYVI0vP0XrOTIkqtIG/cTWCPqUibqCHaKoYyIoAl5zbDEllnsMVFtyf5KIO7A+eHwvaGYiXrcApULT4rsj8mMCMrUfUDJTcp/mkwl7n0Tquh016b8HGK1BlAFw1MMWsnAZ2ssjKAIDYvDjZOOonzyKlFuyS2/mG/NWjuva5/aHRXHhSsCW1Wkq8OL4J1UBjarWnB7RSVOLKontPZLUGRtBEar2dQIT4y1Ra8k0vZQv32f28dfYzxEAprBEG3y3hqa/WOHHzTKE8C+2i479Xc/wRohP5ovFotbU/Jcz52o4TKAZ2tMGmX8UiFb+Soiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JidjaM9jyZU+0KQmXw5u/FNar0F7TNpXCByTADsZ7fE=;
 b=dpO89joneZc8e/tzjujX3rgPjYN7c7YCa2od75DjpAq7rLe+GE6RWch/tVZ2/1kMd6MC+4Z210j2tSk/iITlEaiwxSlLQgWJJacmRu3YAN9Z1GsDesVC3TgJMLk4d0Ixjw2oXzYSBK0mCL/7oZpuQ9ixJKtnXGfUzvwrmjeeyug=
Received: from DS7PR07CA0005.namprd07.prod.outlook.com (2603:10b6:5:3af::15)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 15:36:22 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::3c) by DS7PR07CA0005.outlook.office365.com
 (2603:10b6:5:3af::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 15:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:36:22 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:36:10 -0500
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
Subject: [RFC PATCH V3 16/17] prctl: Fine tune scan_period with prctl scale param
Date: Thu, 14 Aug 2025 15:33:06 +0000
Message-ID: <20250814153307.1553061-17-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: f725ea02-d89b-47c0-1b76-08dddb485277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0V3LN+pINwsONuEG0fMkpEEYC8MCG+x9nbBKeqAHeSn98sEbY1bgxrrMJFty?=
 =?us-ascii?Q?WT+iILxlniKvWhP5lyrs076kuHCODtD0RsFBX4wpohJMbROmowxBMZ/QF9f5?=
 =?us-ascii?Q?VxArbrzoJVzgmEcz8GhhGsFvef/LZGkDLpWWqINzJFj94pjc984oas862U6w?=
 =?us-ascii?Q?2FrzK1k3ELjeLzYV4x4DFg9tjuqEc6KSIwJSAmddao/0tRm2WfC8dwq12CtP?=
 =?us-ascii?Q?19x84zK9UqitqBK7ooJ2E7FKSOJQGSOEECcB/aBQSMivDN4Mltdm0Wwn3oPq?=
 =?us-ascii?Q?qq7SagcZ8XTEMwN9K4jRHcdy/XqTHgkoF5wL/m3x2c06tPlNiSiFfojhG8CR?=
 =?us-ascii?Q?D71ufEaE30O3O1RheW7PUVssNicXh9UXrtV1yBL1yo5dLVQkF+Fx/5XqMOvy?=
 =?us-ascii?Q?GF1f/kXi50ynXEpXru7fuHIK6cHEXle9ulmQRlmbqtoGoWuds0bn6ydzpzcX?=
 =?us-ascii?Q?zpNUfTRCEVrbSoLacdoVORANGzdyO8YwWtMgPagMo+60cN312LQAz0XRVcmY?=
 =?us-ascii?Q?DTXU1IxzzRZjTofuTgSnr0gdtdsQYZy/hWk3yKy1xyMZQn5fS1amUnxFKYct?=
 =?us-ascii?Q?GmFBQlPzOccnAF+lpTPuEi6KZvf5ZB3B1VRHCYKQK+KQDVskTMnYypJfYXEx?=
 =?us-ascii?Q?YgDsxfKtgJcFK5DMybtZhGthk5sOzhLGf4dwI+lk2sBCRpD321VTnuek88o8?=
 =?us-ascii?Q?0TyZgkguCKknWuz+nuIpyMj03Hsh7yqE5gvYpjInqKH5x0IJS/FvTcCgqq5t?=
 =?us-ascii?Q?wd+azj8pfg0j0HqNS4DqPVh67gvO9ogWBJtESC+EGCfQ9qq/lM8kNQokHtRJ?=
 =?us-ascii?Q?zZW4+uTSu/7gzYzDOVuIdEDfWq5VKi/Zu6Ma2K68IB8rKUzxJZ/Uf9RrPThS?=
 =?us-ascii?Q?r3Ey6ee6r67k1MOe+drm3YjE9XG+db7rxMnr9mKZy3aDarktWQhujlMFkx0n?=
 =?us-ascii?Q?hOxsJrCMvXaLQQnz2vCH7F0JWeJib3/BtVBSRBrcwW13wXQ70tLSSpgV1IzK?=
 =?us-ascii?Q?5iHhiQLSn/HbzStlyznthx108pF76KtUNgVBDYHxx/bkIlk1nMn0b9r5tP1w?=
 =?us-ascii?Q?HTAxTIgnIT56Y1xX02le4vAkdSdEvF9rCYl5DCaBhfcgH7hmAC94QEHoHu/J?=
 =?us-ascii?Q?W90LrcnVW2+XPsZaMZuHVN5HOcJd7ftQcgg4VGvi54m0i1mANVpTcTnXuyyI?=
 =?us-ascii?Q?DwlnpLsIpKiBej9VcNUpn7qpnM2+J05hL+csVeGpYUUuUnsug1FliVoqYI7j?=
 =?us-ascii?Q?8Y+FR6xpIIpZBCGxdQzMvVXXM48zk62Gt+R9sX4Ee1DvnP4a8KceoDUur6cb?=
 =?us-ascii?Q?n3V10VEbIWHNLxLm5y3TJEu4xta7Olz0IgYDwTUKF0h8mus14G23KEHLgNjz?=
 =?us-ascii?Q?so3dJ3u1mWtNL4ZsyFs7iCIgPmuYunK6ragYRfxocqMDJVBdFHFtjJLAFljX?=
 =?us-ascii?Q?i9jg9aqfNUlVbMLuKSlf+gesPNjSExfqfK/GrPtDRha969jaqY+VucN+t3of?=
 =?us-ascii?Q?MnBYh4ON1Nw8GDe4yk0516Xpve0nM+yLC9P5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:36:22.3337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f725ea02-d89b-47c0-1b76-08dddb485277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

 Absolute value of pte_scan_scale param further tunes
scan_period by 20%.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kscand.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/mm/kscand.c b/mm/kscand.c
index 8aef6021c6ba..641150755517 100644
--- a/mm/kscand.c
+++ b/mm/kscand.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/cleanup.h>
 #include <linux/minmax.h>
+#include <linux/prctl.h>
 #include <trace/events/kmem.h>
 
 #include <asm/pgalloc.h>
@@ -1157,6 +1158,26 @@ static int kscand_mstat_scan_period(unsigned int scan_period, int fratio)
 	return scan_period * (1 + fratio / 10);
 }
 
+/*
+ * Scanning aggression is further controlled by prctl. pte_scan_scale value
+ * further tunes the scan period by 20%.
+ * 0 => scanning disabled.
+ * 1 => current min max is retained.
+ * 2..10 => scale the scan period by 20% * scale factor.
+ */
+static unsigned long kscand_get_scaled_scan_period(unsigned int scan_period,
+								unsigned int scale)
+{
+	int delta = 0;
+
+	if (scale) {
+		delta = scan_period * (scale - 1);
+		delta /= (PR_PTE_A_SCAN_SCALE_MAX - 1);
+	}
+
+	return scan_period + delta;
+}
+
 /*
  * This is the normal change percentage when old and new delta remain same.
  * i.e., either both positive or both zero.
@@ -1201,7 +1222,7 @@ static int kscand_mstat_scan_period(unsigned int scan_period, int fratio)
  *		Increase scan_size by (1 << SCAN_SIZE_CHANGE_SHIFT).
  */
 static inline void kscand_update_mmslot_info(struct kscand_mm_slot *mm_slot,
-				unsigned long total, int target_node)
+				unsigned long total, int target_node, unsigned int scale)
 {
 	int fratio;
 	unsigned int scan_period;
@@ -1243,6 +1264,7 @@ static inline void kscand_update_mmslot_info(struct kscand_mm_slot *mm_slot,
 	}
 
 	scan_period = clamp(scan_period, KSCAND_SCAN_PERIOD_MIN, KSCAND_SCAN_PERIOD_MAX);
+	scan_period = kscand_get_scaled_scan_period(scan_period, scale);
 	fratio = kmigrated_get_mstat_fratio((&mm_slot->slot)->mm);
 	scan_period = kscand_mstat_scan_period(scan_period, fratio);
 	scan_size = clamp(scan_size, KSCAND_SCAN_SIZE_MIN, KSCAND_SCAN_SIZE_MAX);
@@ -1384,7 +1406,8 @@ static unsigned long kscand_scan_mm_slot(void)
 
 	if (update_mmslot_info) {
 		mm_slot->address = address;
-		kscand_update_mmslot_info(mm_slot, total, target_node);
+		kscand_update_mmslot_info(mm_slot, total,
+					target_node, mm->pte_scan_scale);
 	}
 
 	trace_kmem_scan_mm_end(mm, address, total, mm_slot_scan_period,
-- 
2.34.1


