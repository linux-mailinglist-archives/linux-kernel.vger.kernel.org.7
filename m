Return-Path: <linux-kernel+bounces-608447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49202A91390
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 08:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4777AC137
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 06:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB2A1F416D;
	Thu, 17 Apr 2025 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t8sKJ0fl"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC51DB933
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744870204; cv=fail; b=PUjlQWM1WVziIp0HWDq7hSAEu4l1xZ5neLsFVF69sJiu1V0HdRdIFUtxQ6f+axrOq++cgc5vOfLSK0OM/baqu6hq6Gicm8WSEXxFeF5zYiizue03U0QWqSbCLNkXo4V0JZBHfPIQpsgZim3dJOmFNHbDV/7MPbW9dg9wmtFQYQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744870204; c=relaxed/simple;
	bh=ozP8KSGf4IEv0qJ9m7LbjwMZrtHP8a8myR2w4ivj7zE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiCOb7Dkr9ZSc2ff10T+V1BhHyORKsyXa6BvaSWdEr8k01QtccbEVR/o2qevpG8Afay2+9sQoZ4IT+eHaRxEFMTjF9fC1tNOCKGokM4Ih4Lh50ngEZWi3p8Ne88YUlwAAQBIUPIPvVVM41NrEQXB1fVio0cUjNRC5X9eFBNk/+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t8sKJ0fl; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dy1IZFaFrpKFj8960VZCJj9kZFMPTApM880PV0YNYD7IgvIMrBwk85by4CU/jz6UYnwlJL6+gFNCzQm8pTR6jzJVYUzox3DaPezL1AFZz37XKqDAWTP+eZP8VgJWZlvi4SWRvtLdIUY5+Hm9AP4shAWrEqOtvdXnaJB13lj6G7GMkx0JDVY5gE3BzB9fKKgaZTwSb0m53vVULtzvjWh+xs5PCqavCV75aFfDVUUl2B/WnwylIHfUj34+LmPS56TfHukhyeLHUklUuGzgAofdlw4ZzK/JLTmy+AKPVZskTVRipt9lLKnW7pF931yRiruK/diwaI36Z7GrmBa2cDGreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76khvO0poRuCvreRg3JvNl1lJMM7D8X1ZRniHN8NBWo=;
 b=xC79+9O7elNuVgfM9iTGeb6jHYHmSMItchRhav3VPjDjVBf8nwObJRYptN1RU9u286OnScCNjmgXlRASGNIycFOXmMqVtaMc1Vu6Kn4vTtFImeeWBOhpMUQwgSaINYKo35kFwNths/pXlZT82BjWrirEvLpGOvMeOqZW1ZifAP6US/IT54yTk9H3Mzbxhd0Xo4tbk6UmChjx1ZlIS62Dlzqjv0XwHCfuAO7ynYWPV85ZQb92MAEVXD0C2ikLhfrKBcU2M8njsdF1Ml2wiKRMwNZx+s/QMnnJ7eBcMaM8SuewbJpw5a8/95YcyBIlD1+xweyxfsbeVyvwkiEwsBkYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76khvO0poRuCvreRg3JvNl1lJMM7D8X1ZRniHN8NBWo=;
 b=t8sKJ0flV8LXA+jZuPmw+hDWE5lVdHvI/M/IL5oBepj2f5LDkjyztTZK3ld2Os1bwuXOtO9H+YVILpm7dIx7PjbrJY07VlGxqg1MP7wdgigyW72V2Xu4S9fbjzOCuixgzGMpGdz48kfIrCIIfJewKia4/qVEtA0T+le8z/oI8lw=
Received: from PH7PR17CA0011.namprd17.prod.outlook.com (2603:10b6:510:324::20)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 06:09:56 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::d1) by PH7PR17CA0011.outlook.office365.com
 (2603:10b6:510:324::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 06:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 06:09:55 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 01:09:50 -0500
From: Shivank Garg <shivankg@amd.com>
To: <shaggy@kernel.org>, <akpm@linux-foundation.org>
CC: <willy@infradead.org>, <shivankg@amd.com>, <david@redhat.com>,
	<wangkefeng.wang@huawei.com>, <jane.chu@oracle.com>, <ziy@nvidia.com>,
	<donettom@linux.ibm.com>, <apopple@nvidia.com>,
	<jfs-discussion@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <syzbot+8bb6fd945af4e0ad9299@syzkaller.appspotmail.com>
Subject: [PATCH V3 1/2] mm: export folio_expected_refs for JFS migration handler
Date: Thu, 17 Apr 2025 06:06:32 +0000
Message-ID: <20250417060630.197278-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417060630.197278-1-shivankg@amd.com>
References: <20250417060630.197278-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 2984443b-8969-46d6-2416-08dd7d7679b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0F+4f7Mnt2y2Q3ABxIXDv/2F1/RcVpkI16t4XxO30FjuWYyf7tpBWVKv7L7r?=
 =?us-ascii?Q?83LlWe03C2cV2eYdvnUrLsjdKqlOR1/nsyHFiyn2kB26zeiy06VQ1IHmAoAO?=
 =?us-ascii?Q?numeVakEqCkeFZPIdaVOgRnyAejw0zKqCeB61CATfA+A6OgZqev3o/uLadZy?=
 =?us-ascii?Q?maSF7ArV0e6hTq3uiv0IkTmPPX7SGFGmavxSY8qFQlg9d9KbaetSR+K4ftAQ?=
 =?us-ascii?Q?6cr1uOnjJHlv526KJmGog1oW1gWy+VRapHugFw0uSj5rSzVpLLgz+/ChPH93?=
 =?us-ascii?Q?to9+8lajTYputV0vBgUeTcGkqnVomdyjyMTQJbJdvM4hmTI3/QmiRXdl09pM?=
 =?us-ascii?Q?J0VCQc1LUKfMV2naO+Pbs1gp6zkB1FM3q1v2/Uske5cEtCW/FUcZJoc5F+/a?=
 =?us-ascii?Q?UpMYJUoMv0Lf2fyH/hbx/mu97T0Qks1gM2dy+JJ1brn0LCT12ZGYl3H6fqj6?=
 =?us-ascii?Q?5F8aFkf5DIQ/sraNskT39IVXzFEGqLGYPGWZlBvP84Fppr9L9lzt/bMleAjk?=
 =?us-ascii?Q?ldy2DWUh2hQizDbgXKKhQHbIHs20TQNDGHaEx+Ruj04kZrFkDwz0VlmdgDk9?=
 =?us-ascii?Q?Hll/mJPEoFrfsDGMvVE0BiG8zTsxC/CUZ8I1bSiw2FMhRqkMj1tyt79gT5NH?=
 =?us-ascii?Q?oxP2j9MrwhKjEjjjiduR/W2k97wcUfyeSMUSZHEWdSIApamsw5oJIXTyz64o?=
 =?us-ascii?Q?9a0k6EWPWSMNEGSlX74bMdjYHZosCHXNAssgPxFiTzcmxO6crzDc9WNHR9Jn?=
 =?us-ascii?Q?D6y7dC2EhlnFQ8+kZWsidH/Bo3XM2W6cJtrY8QHG33NqaDfZQyhMFUrGaLN8?=
 =?us-ascii?Q?e76ux+0oS191R9MluVY1uaGqCSRLdZieMXBomgu1936pKH2f89Zcro03PedF?=
 =?us-ascii?Q?XgdjxfTpA1Knxw9zoYSXzPGhF/a0FqOsBj+zhJAkxUPG/cTK7vOw8INgPV+n?=
 =?us-ascii?Q?2PcVDV447nI2TnUixBEkc5aMsQFfezsZ1STRH1Y/yaGLscPAmDi/oGqDnHNP?=
 =?us-ascii?Q?cQ6EdE6pQDgR2/O3ZyGbKTQODvstWAABGvQiTXcwG2VKba4E4/98OqocEJfO?=
 =?us-ascii?Q?LDD4CEntHv6lpb3AxToqGvg42UDcCQ+u3ZgyJkU524QTqKyN1rP1R8v5zcF3?=
 =?us-ascii?Q?w9ptdBPrKwvfwww95uNsaRhOO3bXgKznjMB4PPLa4U+W89FhOplh6QfOd8UC?=
 =?us-ascii?Q?KqLYZjIO/YUFj/Q+iaHJCfQW8SxuIknyWJ0nIDYqHMU/u1l20EM6i9GDuf3e?=
 =?us-ascii?Q?8t6NJCOVfOrBffzX0RIFPkBV8WWHPRkBeK0D8/E5mDeFKLPASt5BipitBr6r?=
 =?us-ascii?Q?ZOf1VXTqQpOXPloyrHvkw32Uuiaztr6seg3cH2aHmuGm9XjYE6sNuU0c/PRE?=
 =?us-ascii?Q?lWu6scgx9blxggpxp69svpX77q2vqzyio1M7Z07qEoD696JaAC+2pc1PN/RJ?=
 =?us-ascii?Q?cE8d1X14lGAdir/xh5kNq4141bZOg+JIIH5ChYM/L4jF2MwVzlFX3beZZ8eX?=
 =?us-ascii?Q?338LPYizZ1hMrsgSERcllommrwHZWYnogJR/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 06:09:55.6246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2984443b-8969-46d6-2416-08dd7d7679b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039

Export folio_expected_refs() to allow filesystem-specific migration
handlers like JFS metapage_migrate_folio to properly verify reference
counts before migration.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/migrate.h | 1 +
 mm/migrate.c            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index aaa2114498d6..cb31c5b1eb6a 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -60,6 +60,7 @@ struct movable_operations {
 /* Defined in mm/debug.c: */
 extern const char *migrate_reason_names[MR_TYPES];
 
+int folio_expected_refs(struct address_space *mapping, struct folio *folio);
 #ifdef CONFIG_MIGRATION
 
 void putback_movable_pages(struct list_head *l);
diff --git a/mm/migrate.c b/mm/migrate.c
index 6e2488e5dbe4..0f01b8a87dec 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -445,7 +445,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 }
 #endif
 
-static int folio_expected_refs(struct address_space *mapping,
+int folio_expected_refs(struct address_space *mapping,
 		struct folio *folio)
 {
 	int refs = 1;
@@ -458,6 +458,7 @@ static int folio_expected_refs(struct address_space *mapping,
 
 	return refs;
 }
+EXPORT_SYMBOL_GPL(folio_expected_refs);
 
 /*
  * Replace the folio in the mapping.
-- 
2.34.1


