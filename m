Return-Path: <linux-kernel+bounces-769188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 145CCB26B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD881CE201F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3847C224228;
	Thu, 14 Aug 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PUvuD1/6"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10565221F11
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185717; cv=fail; b=Ray6Cl0m7Xas1ctrjQgvavNAyTMwvEjFc622GEbS7Ha2YLIvLlVRZyrNlgCUG0QzIOMudI1/iiz4c8vhi2sRDAsWT5AP7iYWVkqBWwes7bSN+8PdqJItERIU66PRUfeOvw+flkEpQz0YEnKkN6Gu0dk74R5z2q3zNJpD0c9QIiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185717; c=relaxed/simple;
	bh=JrRmM7OePuZBNHbaPopJvYEkUqfDESztrs1tUUSpe5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTvSX0qIdFx5rVzXg9ZuhP3lKzOccnf2md7JX4ahyUn6NUBECozFvL1mLg7WfyQbTK44fk9GVw+kKPN3Y/0id2xxmsMDdC5/BtHs6hOXIcdMNVFtN4eif1g8Gi7jV2HeGfAUM2FjXbLLbUEEvcGGyp/nV34ETfybzqXDXsQ7F7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PUvuD1/6; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqLqiiGXd+X+F4PWXy7oHVaixU021X9evXbmT0oV7tf4O77pWi6rnVFNoJmcEnsKM+7oDTyzjt5w0NmH8kFCV9/0JBmFzDyc8RdHGH6XMfxX7eYJZSUdMwqDZPtWvY3BalzWimVTmyI1+ngAn4b9ihFRQUc+CAfTikCzfYA82Fg6p/4WQQssT2IgDnFtoLYIN9qePgiZTiqU0L/Dct42zGnMbTS55GvtWUZZO8o7ximPj2eY2zaF0uGH72UnEj2qpujg/ZweDYR9nsGNoKWHqXCA9IEYr+CtbxJt1LBvCCfj8Glo471+os73wKGUxtmZIwJeFS5RmUtc0X5f+oI4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woX07bXSCoSE29Y9wKE+L2cWmZShzkBFCGt3WmiIeoM=;
 b=EgcQ+ku1jnYow+WowCfw7LmTuuIwMEC3PHH3C4ttQwOxdXcNX+UPoJELH82WIjyMiXl1KA6rFbDhs9i6abc3qQfLrEnOpDJ2U6gEQt5eQQmEPUSi7XkfzjHtKXA0ryF4oMN/sVVTHQiUslZYTi0ZWLDvAJESjm3AkWYYW0OxjwA7viZIK3amrb76fszrF68DZ2++BPShw4Zgn2hviRRUSPPGn71//7hJJD5po/KkNcgbGnw4T1OHZ/Sg5W08kkIVY2i6/g6Y2pBkRKnDzWblRUW7vFhRcdHCz5+HxuItVeC/oSKpzDSUjlYGk0J2OBQ2xLVV0XVY81bvrsIYSBFdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woX07bXSCoSE29Y9wKE+L2cWmZShzkBFCGt3WmiIeoM=;
 b=PUvuD1/6HsdFcViD08WTKKHmf4JIxXhBQigPGPz5j5Z2OyOXq391aUDXV7fgMV6jJgCkkSVkzryx5IZZlOhkjPckUhaQK06z/NdI7LEXIsAb++Nq6/sFLs/QOp6A6SYcPQvfy7n1CgwGhJeE12tCewGefgSJUMjS91KpyO53C9k=
Received: from MN0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:52d::27)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 15:35:13 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::53) by MN0PR04CA0028.outlook.office365.com
 (2603:10b6:208:52d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 15:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:35:13 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:34:56 -0500
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
Subject: [RFC PATCH V3 09/17] mm: Add initial scan delay
Date: Thu, 14 Aug 2025 15:32:59 +0000
Message-ID: <20250814153307.1553061-10-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: e20a28e1-8ea9-475c-d4d7-08dddb48293c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QjItbxSWK55f9S8dJPN8kJzmutDu8gaeU6Xz9KXs8LZZMM34wtS9STeL9+W?=
 =?us-ascii?Q?OYL0PNYV7vQNcydspLuUb0nqjxBUWzXcx+pgJA9L2BvXFFjI61q4SPdhtDfC?=
 =?us-ascii?Q?MrtI3KBLNT1rtTZNc4FD578qGHhlnGjpMTIeAUC53qFu/6qZ92XpoWC2J1D7?=
 =?us-ascii?Q?iBRzOz1FAuxNOWrxQ7gPKBkyMCjsusEaRFVORB2zD1pOfLx9U1ptXeCh3R2P?=
 =?us-ascii?Q?dVlmpKb3GC4Zj8HPLEI9hcQ5sxRTUNNV4saROoJ3nJBQ2dqn8eFibYLrrwA4?=
 =?us-ascii?Q?p8x+6j36Ptx6XOCVD8ROZXGJvjvYgqh8KPqfwBpsZVWpjkWX36pvHkaTPgAp?=
 =?us-ascii?Q?HJijaOmxVwHc53J0r1EMTEhMBNlbPYeXGyTjJs1VBirKO4NG4wy4WFoI3IJW?=
 =?us-ascii?Q?wiNgqEFic6FuTtzgD63rKM0BttRE68RsRnJVk4hXcbZzvamtE1/vQVBX75CB?=
 =?us-ascii?Q?v7Mv3XAzY3vDE1DQ5OSOcZlbHQ8ytJXpHw+/tXjC5WMi6hSAIUMNrWhopMk5?=
 =?us-ascii?Q?CS4G0L6W40dC03xp9qm49+EyDyIq44GOVGoLyrTuWvaXrpMpjo7B5WDYIPvx?=
 =?us-ascii?Q?i8T1MxPhW04PS2s4VAtP1oFyIXJG3T44O6jImDHuCHFm4yrFDJWjqnqi3Ri+?=
 =?us-ascii?Q?kylzML5OLz7GCxPCaAysFykHeO49UBm/6dUi+7hiEcs0Ko4XjQ2R4swR9nD2?=
 =?us-ascii?Q?0CKGvnKy8XQIah8utA8HSmbqT83dSiceivXXCc95d83sCg/OtONnp/yDLc4M?=
 =?us-ascii?Q?hZD6DWBERWURUUgrAqbbczkgSVxre7ND1brrrCDb5Tt1VRNu4lpgxDcBsTV6?=
 =?us-ascii?Q?ozFQ/AR9zxaFW5rxwhPpybJr4J3YzjNSTt7rRtS3ywuYs4adN8S1vzeNK9J3?=
 =?us-ascii?Q?Td7WsK16v96H3chF3QO9cfY2iIteFNyoxhtJD7CsH6+rIG3uAqBD2VWesFqa?=
 =?us-ascii?Q?NGJ27Bypi2bQIcIkTB6L0G7yxyl+beKYLnJclcFpmzzVgQRtTF1Z1Dh8XHoO?=
 =?us-ascii?Q?VqLMlxD1C0iod9410TxFn95pw2bEddocbvBClPRHtEq48+if+iUv2d5ruW0t?=
 =?us-ascii?Q?4TEFhzy6Vu5nPrz6mPHqWLEfVuMGo01R+f16LJQTGPg4Wfk8X/F9A0NtH7Oy?=
 =?us-ascii?Q?nhmXPYPT3l7wVRoRgvJal+AZghPGjiSnSddXF+VKGaKO0KccoeFttOr4YdCf?=
 =?us-ascii?Q?UydJWOrV45w6yulZYrZx0W2pcRLoFCdOUw4y4JLOq5tGOGp8F7fK0FmgsB0W?=
 =?us-ascii?Q?1OKu53BJxBrb/zZVHe/XzD8c2YGdR/F+1irRmrZV/Cm1fOmxkCpFqJLKcD6a?=
 =?us-ascii?Q?UVzZtnguNs4je1g9wPrliyKE1pi3SuQxgeVdeJ9KxrjoGTfsTQjtaAL0NF4S?=
 =?us-ascii?Q?rgc2opJGtNiDNxdugTJipJtr/LaLDZp3+OBZn87IZWKTx55tPe+P4zDLkbWp?=
 =?us-ascii?Q?np3nduxCmOMVU+IMnHwhJJj6e14WIVLCGbMTogSp2Jh0Z/zTMcN4WyN25+vj?=
 =?us-ascii?Q?n9YvFSQygAYKao6TJqTTusOKllbpWarJaEvn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:35:13.2043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e20a28e1-8ea9-475c-d4d7-08dddb48293c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980

 This is  to prevent unnecessary scanning of short lived tasks
to reduce CPU burning.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kscand.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/kscand.c b/mm/kscand.c
index 39a7fcef7de8..880c3693866d 100644
--- a/mm/kscand.c
+++ b/mm/kscand.c
@@ -28,6 +28,7 @@
 
 static struct task_struct *kscand_thread __read_mostly;
 static DEFINE_MUTEX(kscand_mutex);
+extern unsigned int sysctl_numa_balancing_scan_delay;
 
 /*
  * Total VMA size to cover during scan.
@@ -1010,6 +1011,7 @@ void __kscand_enter(struct mm_struct *mm)
 {
 	struct kscand_mm_slot *kscand_slot;
 	struct mm_slot *slot;
+	unsigned long now;
 	int wakeup;
 
 	/* __kscand_exit() must not run from under us */
@@ -1020,10 +1022,12 @@ void __kscand_enter(struct mm_struct *mm)
 	if (!kscand_slot)
 		return;
 
+	now = jiffies;
 	kscand_slot->address = 0;
 	kscand_slot->scan_period = kscand_mm_scan_period_ms;
 	kscand_slot->scan_size = kscand_scan_size;
-	kscand_slot->next_scan = 0;
+	kscand_slot->next_scan = now +
+			2 * msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 	kscand_slot->scan_delta = 0;
 
 	slot = &kscand_slot->slot;
-- 
2.34.1


