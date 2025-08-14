Return-Path: <linux-kernel+bounces-768939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C3DB2682F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0D19E4279
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD4F3002D3;
	Thu, 14 Aug 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SpqgDs2b"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E13002AC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179371; cv=fail; b=OiyR950DFF4YWr71W1ncSfAlyAykpKHAJxNqJVYdwWKOW/+VoHAq7tnfPzzaVx967P/UZ0FcxzRKBsc1iREPE8JCniJQahsCa0wEYhrAVYwjp1AMVIbskAnvsdIuYHuNPc8CZ2flB4MTZxRbEMFk6chFaT+fvlnfsL1gatQCTmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179371; c=relaxed/simple;
	bh=CRDQ3cyJnFdeLSo6plNMFFy45vRx1Utq0o4FlZLz2QA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7GyTaIdsMeDUYt0rPGJT3J3Smc1HJhQjpcEl9aw6Hc9T72o4gt9XunkvO7ikaLAuvBPU19j54mzbp+OnZWYLOprNFmujNHTDG38PAaBjSi3AdCK/sfH+cEN+5D7p1kcKvfCVUcI1ICN0DVAUhpeMPSY6k5ZxkteFBDZbLr81h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SpqgDs2b; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APA+EtQBEqf+0xEVM+K5SfV80x68kWrv5r78yFXmRhxKsTlP/p4avHA3TIbXBq8SpJTpjW3TM1NnmObu6rqAxHr1COScm1b+LttHi2AAGLy3mcxkQt2975bFbpG07N28sDrwi+mBUqj7GgkZ9S+fdPjfStKLXtKGjd39QOPiVOxA4djifz/+KIeVUXWu8xXa8fpGiWLtBVriWr+un9NUKAOGfPCmx+7u63Oqa3GbMNh5XN13zwy206j9rYMUusA/ChOarNz0/X7phesKBubUPn9ybN8nZpW6Hxj4npJ9Z0zljPhQOmfl4IXKc48+Yb5RtBE13qIPiWkimh+nt4Lqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkiW7fONMc9c0vXFrI/z6XSVU9crPq1YeLdZf5pAqUA=;
 b=YR0FHtsJDSOX7UIw1sXKZ+jDHaq3XssCGuPlr2yqbo6CVVVcJDWAlV+MrqfciJR0+Fi+79cs0YC+0VKNeeithES8bvIt4YkgnEKHZiT0XGdh2weuNqsUXBWXvJXiFKS8bTtjexpHVZY7vXOYRDkR5QzHqn6lG1/YN0uoInkxf9tQi4raiCQjN6NMWEMnLMzJ9X/E2BqiWy4h2VdFu2fXK0O1tuiIgyIPUK3BIDfsP/5k956hiIa9SppvSsQOv8AomOq7R1yx3r2p+gFK5aJhbMD4QyKsC+Op6JTFi28Yg9257ZQLMqG7tHvp9FLQC18ZEvbgUOEZncGfijs0arFI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkiW7fONMc9c0vXFrI/z6XSVU9crPq1YeLdZf5pAqUA=;
 b=SpqgDs2bmX9ZM+6CjOTEt9neBjtewckkFZ3EKrd+bFCDo56LekifWDLCxIWoOhgB979lsrIOWfX5whHJYOd1edZ684gYafnpajzLhntoe2r72dDERY7F2TYcQ0Wmrm3PTvQYt9KC4gReOQTbAGwEf7F2rnspj0NJHU32jqxKG2o=
Received: from SJ0PR03CA0376.namprd03.prod.outlook.com (2603:10b6:a03:3a1::21)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 13:49:26 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::14) by SJ0PR03CA0376.outlook.office365.com
 (2603:10b6:a03:3a1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 13:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 13:49:25 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 08:49:17 -0500
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
Subject: [RFC PATCH v1 1/7] mm: migrate: Allow misplaced migration without VMA too
Date: Thu, 14 Aug 2025 19:18:20 +0530
Message-ID: <20250814134826.154003-2-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c0c6cb-3ef9-4434-fb59-08dddb3961c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLEZctdN0lPs25jh8fqo5HTqWef76t3jWBM1UThnVPadydZYudsLxPHeYoiI?=
 =?us-ascii?Q?KqUQyZMqKcD9V38sAzJIcsJIopwbjRpZQSGm5IbJP82elh0krSw/NmDE5Sau?=
 =?us-ascii?Q?akw4/nemFavUkeKx1XAtvo4wdEM2FnbOReV/e6aWhynSfxufuBZ4oQoWMFUh?=
 =?us-ascii?Q?KCQ7yBKgR29t4TM2vUxwI9OAI6wQXcw+3sB04NKNWvEaWjk6wte45OTwRuix?=
 =?us-ascii?Q?t1V10auBuMBrHWCsEH710eIp5CNNaMDEdmi9QnqLfelsBK5amIeuyGTI3XWe?=
 =?us-ascii?Q?wj0ylZ6lnzxiucyEJ0OAS+GrdW/p3TcSf8WzRUnpJ3LPrjZvcLnZmgLH2G6V?=
 =?us-ascii?Q?t5RbDUZGpRtz4QbjQPIwrkeKqFcLLAIjgqAm8V/2Vtbc7IUgOKyKC0Mt5Qgx?=
 =?us-ascii?Q?OKpnDUw4veeLEOFwrqlkaCG/Uq58qhOOqD9f5aZi+qw/GnlgGDZfVVrujHc/?=
 =?us-ascii?Q?p+7aQ0LdpG3dxLGTq5NPXCAJRMDv/WY2hOfuH4rPplWGyZIRz2I7BQeLpQ+5?=
 =?us-ascii?Q?/BklA1LNh7/QfZ7gS9HmgeulZywb7PNpBjddcjFhyrKeA7Bg7SYC6+cNnl9i?=
 =?us-ascii?Q?7afirE4ojF2+o4pcaPRuM+BWlF1HwT1jBiqY5bBwHLw6YLpOpWz3oHzTqR0L?=
 =?us-ascii?Q?uRaJL2QthedmGVG+sBcJ00Ifm2XZcf6juXJnq0FCyICEDVjBP1cC6cGkVll5?=
 =?us-ascii?Q?EGZZRDC4wpx6SDL1g0ylnJfCTcUGN4ed76eEg3DvveAehvO2usMRFgbjTqXS?=
 =?us-ascii?Q?6W3huPRUfFRCmBTOiUohCvyrV8PU+0MUEVvGhHYLiiLHhFkt+IGo3/ZvSVqJ?=
 =?us-ascii?Q?LsE6GXxdbnKKZdfcsNCwWU6E3TgkKbaDQWlSFl7ln+sYKOLyYggprC0TxaYv?=
 =?us-ascii?Q?ICzgXwfK0Wqj5IMSUK08PKAZPAXu1ZzXrELdBOTdZ5gcap9nUz/8NHl+oJp/?=
 =?us-ascii?Q?KwKz34tpxVxmGiXJu4LAzjYswRuVxC7fXxqkUAWLtfHfqEujxjfq5bCf1FLV?=
 =?us-ascii?Q?RYjrrHiTNvLfISq0/DwajU48EfbpQtsCptxJabIEra8ZmSwCTetkKwpoO1rP?=
 =?us-ascii?Q?7OEobB1XAV9f9beGkf+hf3kGr8ip3HQskR5oIG/EEhtdKkmfbUd7Qa4sIIJw?=
 =?us-ascii?Q?axEH2osDTpjEje5XdaIW1dDtMbhGeFdUrkbU1nCmYaMyamn6zwRhj+rfQfhI?=
 =?us-ascii?Q?YNZdlyY9EDA3vi8M0f3W2AViopEKjddKJ7XIltufudGECXHtdN2L6MacAj3l?=
 =?us-ascii?Q?iUStdyNSEdC695tNRMuyGoYOxxfgQhHqlKES1hAZXkd4rasuYdFmpAo70FNJ?=
 =?us-ascii?Q?wmy3huuhHT4Qc1QG7S0dn8yONIWBbxijcrUa5ZDvM76SjuAsCpIBZSjAU4Z8?=
 =?us-ascii?Q?RJdZqgV8MDZgnu2yieP0F/IqR30hMCuEyV8v9P6P9L9lnRuohK29x7/v/fRY?=
 =?us-ascii?Q?PQdrmcN8QcFND+CabNxrY5scFIn67Vg0nqH0byDmtqrA5MKxo6pK//J6O2bw?=
 =?us-ascii?Q?e7tiS0FCLYbFv/Z9BgBGNDOgDn1ui9w52xrZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:49:25.5915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c0c6cb-3ef9-4434-fb59-08dddb3961c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987

We want isolation of misplaced folios to work in contexts
where VMA isn't available. In order to prepare for that
allow migrate_misplaced_folio_prepare() to be called with
a NULL VMA.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 mm/migrate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 425401b2d4e1..7e356c0b1b5a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2619,7 +2619,8 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 
 /*
  * Prepare for calling migrate_misplaced_folio() by isolating the folio if
- * permitted. Must be called with the PTL still held.
+ * permitted. Must be called with the PTL still held if called with a non-NULL
+ * vma.
  */
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node)
@@ -2636,7 +2637,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * See folio_maybe_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
+		if (vma && (vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
 			return -EACCES;
 
 		/*
-- 
2.34.1


