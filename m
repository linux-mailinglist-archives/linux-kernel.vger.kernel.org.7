Return-Path: <linux-kernel+bounces-769198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E6BB26B49
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046571895067
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77038235354;
	Thu, 14 Aug 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BePjrkNr"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD22253FB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185800; cv=fail; b=Lpm1WEGRojKtpVfgBG7uAvIvJJqkmkn2B9qapO6tRsaDW+jkQOFzVAeuvknF/N5g0h0G6ByeQDwCrU9ReoXB4iiyRC4Bg2onyXXcrZZuIHtVQbNEjPOPb3mypRi+GHgesRL/yHsqy+m9AKStvLh4O0L4IXffsl15nub7cmRPvV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185800; c=relaxed/simple;
	bh=Iz4FGAEph09umivSHnfvO5ahBpuinVOsK4petaymIwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDRU+jpltFIUOTjbY97bHcVJjqjULBCUTfstRk5qrk14pWzdYjWKDSYGbdrI5SkraV5u7AeOMHUuRpskifJ5YXHsjlCrDeSAUkiQiUovG675QM3yeS+FeTN9vQ70iPZjimqYnO7G5ubaTdt8ujr+akZ7A0ro609h52n/BexUsvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BePjrkNr; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KW9cJXZxGlDaWDwnRsfKH9YURp21qxiqxC7qBoDNBK5wei6eT5CuMyaS9ndfeYNa1Al5zHGqx7I3ZbAwT92Ehi2EbO42+N7XvTSViJzgb/hm1F7IOblJRPgejIsXXy9AFkKnUZf84MKDlXiW6YXmkGEWp6rxQbgIdwlVAIuRYlNCn3mJsVgLLfqWD7zo/kBh68RdeBBtW5LLTNoubwUayGpWfoa8vNcBqzoThlH6kAZ4dEvzfS7UKOF0FBkECq3tjtBgun2jjj0xN7cKlF+DvCMU7Zu+8sXI5g4krhHfGP7YNU5Plf7vSLc+fy+ZpntYvjBSrcxqBU0iDpxiFZWmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LpyqC5iH8cjBqeEES0QKxJ0Bd/2XNjJ6HVXe4kFexg=;
 b=X8CPB+JV8AE1QeJkujYlAsXaQBZe/kMn/uqdkHt9HT7hXFzELBF7WbbZg1FI6Aw/RwM2RY0jTnnq9mFcJ/QhvBUWzjMksa3V3Wikf6QRZU6vjIN+WYzPf1U+939SpSELooPCKUf2Z0bGMHyQcjN9sNZ5/RUKwFwLXkxfgOYBQDgtZfFbVvYbhnK1jSZAMWV27pAcul3rdzlUee98aVGidNM5BzMA2p8E7GHfsq3CY2aN/GXEQdMriLOHd2h1zUCMT7TaFQzQe9ltquytTkHO/HyDsLcZPdR1L916Y8EdAcD2WXbmSagWMEcJ7pGIIpbJJKLEb9aib5XPSRTH3p2v4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LpyqC5iH8cjBqeEES0QKxJ0Bd/2XNjJ6HVXe4kFexg=;
 b=BePjrkNrymGMIzHMP5zuaP4sN83kyt9VCTHzuMYCPH+GbnNnCM59hEb5xt66TuLk71TOHInmYJtEHFsT/DQxFtNENucxATOgOOhuSjTdk9d9Vgy3NsFbYCbrRXs1zZElNb7HCmHd9FB2dD6LhAHQfqyLJma3bMNdcC/SmOCb/oU=
Received: from DM6PR13CA0035.namprd13.prod.outlook.com (2603:10b6:5:bc::48) by
 LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 15:36:33 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::67) by DM6PR13CA0035.outlook.office365.com
 (2603:10b6:5:bc::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Thu,
 14 Aug 2025 15:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:36:33 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:36:21 -0500
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
Subject: [RFC PATCH V3 17/17] mm: Create a list of fallback target nodes
Date: Thu, 14 Aug 2025 15:33:07 +0000
Message-ID: <20250814153307.1553061-18-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfae0b2-3562-4f71-f1a7-08dddb485905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6XAnzrlC+zYps7hyt54mj3KEkuiHz32UlByyDXWGDDNcfREmiVaAGyD7vqY4?=
 =?us-ascii?Q?J4oX0boUGlRvyIUOeebWNh7VFPkL+lWmbnY61ZzPbKbsgO401zXr658RLwQ7?=
 =?us-ascii?Q?VxRNluu7Q/c2WgBO3OsHEcPfLAWe7PgU877Y57ktx+Ddw8Elq/Y/vFeTiuff?=
 =?us-ascii?Q?67CjpnEgOnQcEAlLnNZ2ZsaqkHoNxt/IirdsKnb4Ic7QMLbKrIOXi+jUYtKi?=
 =?us-ascii?Q?mfqqpXXvCvSzeMSc4BV8KOP7/OdWDpDa+speV4ycOfCTdGyGBO3oHONgY4GI?=
 =?us-ascii?Q?RJCyVv5kpC1QXlgseOUIEOoNkvTaUjhttzzl1v6nsecf4tTY8A46p6wzb7nb?=
 =?us-ascii?Q?xedFQVfqXyaHlYdvs5KM83iv3b1mSoDlzJDnkqwOkRMDf1fZKm5pFurq439t?=
 =?us-ascii?Q?ZfsvwD+vWLXbqBz/VmF6RXLJrLRcZMpufcP+lKIUrHDMAPtK4LVbsog0/5LR?=
 =?us-ascii?Q?mZvYJUPOakUU5dgoWdbZWnAL8YgWtajejlVwOb4W3qZy6uRjHKyQ1xAl9OYI?=
 =?us-ascii?Q?9EK1Xd5ZWBQ293qPKaQ4P3nAOuDMjsyzbmHhLTGI7uv9ieFHLVzWRc1pc1Ho?=
 =?us-ascii?Q?1jPTu8y86hvT7TNpLEMgR56+1UuBEdIGeWMMCODWidOIkplLNsHgYhSi2xlH?=
 =?us-ascii?Q?5TTBOzUCPCdgMlDrkFV5RpcM9IoFLNQ57Lxa0idHJZ+hFZz7OeRjnsJdJWjm?=
 =?us-ascii?Q?xNSmU+BdfbmUYIvGjj+weeIq7huGuumKgWuopS4P6Bfwh6sgMqjw+AIc/z0M?=
 =?us-ascii?Q?eaJic+j9lW91OgzwrsxHBt9uQWbDuaViMAQ1mOW8UqTZaMVDCZv+WjZEs9/p?=
 =?us-ascii?Q?hC4wJxh2gktKrUPr1qfnKbDrlYOE7OqdP9YihoxWfxq0jQEH37uW5s+uY9+e?=
 =?us-ascii?Q?ke8veS87AsgoCDVS+53JofoQ8RsflC/0vjJxwKqxeO11GNgloDVY56vcsdZr?=
 =?us-ascii?Q?lqGTAY1YOWlFkyB7MUUANuSGnRsgDDU5bQ/2ty1gPFaUFBeiWtcqXr73C/r5?=
 =?us-ascii?Q?MCkP1BfcbDXdIpsBBJlLOpop5r0/oqTiuMHgAUk9Oa2A7yfwlN9tnNLh3QaT?=
 =?us-ascii?Q?HLcvyKUZKSjYZkl5CBQBfq5qWBXole0yw6JKKtmzEKGYfqlaG6XYihNJvrf5?=
 =?us-ascii?Q?Np53gTdJ2gIURdGOSEVHjVSPHYtMGy7ILZT9d+4TL+nRxJyopter2SAyk3AP?=
 =?us-ascii?Q?RuKQlRi7Eljzc5JYNGjp54P4fQbLVRgG6pN7mAQOtzFzvF4JXWZ+vwNEK+lY?=
 =?us-ascii?Q?TlIInYgMAsuKa3oC7ViLW0TD4WhiqN1v5HL1PyGUI3uXWwwuuhgrTtFy32DE?=
 =?us-ascii?Q?MxS5Zfo35Cyk/xKcU49QlNDsC09K3jPrLNG+7Q11S9wtmd/bcogSJiuhmHr8?=
 =?us-ascii?Q?2E4NuI+TRfJt8P6GHGrSVJifaNR8LSwvEf5OG8zhtLIIFuiVqwNVoMYvNi9H?=
 =?us-ascii?Q?qGFyqh+c1JJqgJWbxVF75hk2T5TGc4Bi4G8nytRxAlu754fr9jghVclw/ZT/?=
 =?us-ascii?Q?cUF3h3eJjK9PohMa/VGCwcbsOIwC3LPXyCLb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:36:33.3359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfae0b2-3562-4f71-f1a7-08dddb485905
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336

These fallback target nodes are used as hints for migration
when current target node is near full.

TBD: Implementing migration to fallback nodes

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kscand.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/kscand.c b/mm/kscand.c
index 641150755517..a88df9ac2eaa 100644
--- a/mm/kscand.c
+++ b/mm/kscand.c
@@ -136,6 +136,7 @@ struct kscand_scanctrl {
 	struct kscand_nodeinfo *nodeinfo[MAX_NUMNODES];
 	unsigned long address;
 	unsigned long nr_to_scan;
+	nodemask_t nmask;
 };
 
 struct kscand_scanctrl kscand_scanctrl;
@@ -148,6 +149,8 @@ struct kmigrated_mm_slot {
 	spinlock_t migrate_lock;
 	/* Head of per mm migration list */
 	struct list_head migrate_head;
+	/* Indicates set of fallback nodes to migrate. */
+	nodemask_t migration_nmask;
 	/* Indicates weighted success, failure */
 	int msuccess, mfailed, fratio;
 };
@@ -522,6 +525,7 @@ static void reset_scanctrl(struct kscand_scanctrl *scanctrl)
 {
 	int node;
 
+	nodes_clear(scanctrl->nmask);
 	for_each_node_state(node, N_MEMORY)
 		reset_nodeinfo(scanctrl->nodeinfo[node]);
 
@@ -547,9 +551,11 @@ static int get_target_node(struct kscand_scanctrl *scanctrl)
 	int node, target_node = NUMA_NO_NODE;
 	unsigned long prev = 0;
 
+	nodes_clear(scanctrl->nmask);
 	for_each_node(node) {
 		if (node_is_toptier(node) && scanctrl->nodeinfo[node]) {
 			/* This creates a fallback migration node list */
+			node_set(node, scanctrl->nmask);
 			if (get_nodeinfo_nr_accessed(scanctrl->nodeinfo[node]) > prev) {
 				prev = get_nodeinfo_nr_accessed(scanctrl->nodeinfo[node]);
 				target_node = node;
@@ -1396,6 +1402,9 @@ static unsigned long kscand_scan_mm_slot(void)
 
 	total = get_slowtier_accesed(&kscand_scanctrl);
 	target_node = get_target_node(&kscand_scanctrl);
+	if (kmigrated_mm_slot)
+		nodes_copy(kmigrated_mm_slot->migration_nmask,
+						kscand_scanctrl.nmask);
 
 	mm_target_node = READ_ONCE(mm->target_node);
 
-- 
2.34.1


