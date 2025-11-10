Return-Path: <linux-kernel+bounces-892388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA33C45001
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF233B1816
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CAD2E6CBB;
	Mon, 10 Nov 2025 05:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J7aaShja"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076602D7802
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752277; cv=fail; b=RTDIn0mHx7k1kSPGmkp0W7JsueyM+kUWmW6TupNnc9ihmRKV3dJq0GtRcjOkL8XwIgFsXXcZ7hP6MC7GRCNXs8Wviw6Oqw/4elZQWyW5JWAYMsU2WOlIam0f6aEeoZArYoN6cBGI5T3c2oh4j591BYGTMuvmStucSShAyeZNs34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752277; c=relaxed/simple;
	bh=3KdAxd7WKauYcI2Rzz5W33ayFi+hck8naHHEYbQAXsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUxeoByGuep45VlUw3eBHi3Ftcv63dCk6oCsrrocMScijEe1MPCpEMPPyKf26cNXJVBEhLg6XdjHXNolEbjDz94TjKSUiAkx4HD9ZJHQUojjpvvyRSKehFU97RhUu0gVuyYOfUy4P3HI+R1aLtrF6TcH/f7ti/zfW5ZZJDI1JKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J7aaShja; arc=fail smtp.client-ip=52.101.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4kS1Zf2qXqi0kWQXTaNQMA5vmjtE8hoAReqoIdo8rE57eLvFajIa04v8NPwbs8QtV2RaUWvZwpPXYSK6fjz1fFkF/N6S8kcLYuk5dQTELTIepHi8Kp4sODUNRO8ibyFMsBy2ADn4OUQPit88zn/6g7Mqacy6tOJFhixl/GEV7x/roV1ROKCXvXM/aqQVbiNtcuedsY8LuFQm+qD0NDpG2hjtLAklFXGEzEZYA5M55yOKA8Q4Up90/ZV7AOkdFOlMobx9h96oLGnxj1K5pb8ZmUcR5tqkuuLTZtiffJeN6W7jdas65uD7PZXE+LoTOc57YEwmf+1jJSq/yMm3IZNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Csunv4ay0ersKu9D+/xbcPqUb4eanrv3W4tEcydndrs=;
 b=p/iP0fOppOfa1hseFtX7+dVCS9e83apEHujEN71oNL3o62gLzi1qSdeEwkXyOyVbuyFmgxjlVHjDn3Qhbaj85na/siZlqUOAlWfgwMviv1OCS9ixC8FvJ2wPBUxdkIlm9pJpP8r31rjSGLJuggigZ/3jcZ1TqqByFv1rvRWPIvICK1cHzx34g5Ci57atlKapUNWDZ2R/M7toOgfvrNt7IJcNPDxjhsTMYlaONEGe+XoGc1fJznQEE+4TOyn398HQyO0VaYsKXsmlW7FyoDiCQhy1JhHVWK1GHfegNhmg5hSn3kaH+PBvS+3sjsOQV0KTZz9x0NHviJ+wn9bhQ46wfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Csunv4ay0ersKu9D+/xbcPqUb4eanrv3W4tEcydndrs=;
 b=J7aaShja7ZKFIxffQ0eG84o+DBxZJE+4mKHGZhpMvDPvwcXLj0WVhi8IqqVqakX+OuZLegP/R08FBsdluMchRmCTgE/rLF/gBmkK+GxgXmW+aAUq2998EIPdA7Ud7TOzKST7EHuGQuZatM/JgZ3sAYIlDxuICwGHM9KA7CiMGXo=
Received: from BN0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:408:e5::22)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 05:24:32 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::c0) by BN0PR02CA0047.outlook.office365.com
 (2603:10b6:408:e5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 05:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 05:24:32 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 9 Nov
 2025 21:24:24 -0800
From: Bharata B Rao <bharata@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <Jonathan.Cameron@huawei.com>, <dave.hansen@intel.com>,
	<gourry@gourry.net>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<peterz@infradead.org>, <raghavendra.kt@amd.com>, <riel@surriel.com>,
	<rientjes@google.com>, <sj@kernel.org>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<dave@stgolabs.net>, <nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>,
	<yiannis@zptcorp.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<byungchul@sk.com>, <kinseyho@google.com>, <joshua.hahnjy@gmail.com>,
	<yuanchu@google.com>, <balbirs@nvidia.com>, <alok.rathore@samsung.com>,
	<shivankg@amd.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v3 1/8] mm: migrate: Allow misplaced migration without VMA too
Date: Mon, 10 Nov 2025 10:53:36 +0530
Message-ID: <20251110052343.208768-2-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110052343.208768-1-bharata@amd.com>
References: <20251110052343.208768-1-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 41be58c3-f603-430e-d046-08de20196dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlZJbwUgHr7pyJ/sA/zcvofFaxhcdOBndiNcFJSe8otb4N3BE/At+SBwRbiV?=
 =?us-ascii?Q?5ZuSOaN6t0cliqUgOKgtECHKlFz+u+EmghmDro/u9qNL5LDaOcAt4lffAqgY?=
 =?us-ascii?Q?wz+Q77PlX8NA4ZpFoDN6hWfeWQYi/6BnST3bHKO9hHCV2kO2ZEm64AX5eKST?=
 =?us-ascii?Q?oLIZBHsj7uNeI9MmMD/DCT3c2SKwUgQAdxwDHabMp5jNPdscSP48Qf76Llpa?=
 =?us-ascii?Q?V/iPH0Efj6mqdJcnupoFJQ+e2MedudaLpOqK7o/W8hZ249xNKBJze+rZw0UL?=
 =?us-ascii?Q?tXPDTmKEW2x3J+qkyeadbncma4rZdGcEAlGafAISZtMj9L+DMlspEpKhhG4X?=
 =?us-ascii?Q?h7jwYthi2Q5Gd9U+xLsjNCZjcTizeso5lsUsOHvG7pNG62Qo+Fj4+YoZBd+s?=
 =?us-ascii?Q?j7vkXcMpML+G8fuAMyBGLRBFRPqYZtm3i7e9a6BdApxI3LwMTsQ0woKDJupF?=
 =?us-ascii?Q?HBmHZBd6BCarWpAvcKl1mjDIw7GOJpdwMBjMwTcwUjV/EQFvPdyhjj+w/Y+i?=
 =?us-ascii?Q?cqJu7qpSEfxDJe4f8lees84Cmp7GUIXZsiSKOcQKsqFU84yGQDDG1xtVmfGB?=
 =?us-ascii?Q?pUb2S62669CXpUWy18k5OPetmYbtPxrMP1TNd+gIgnxQtPABv+2qEqvJKG5r?=
 =?us-ascii?Q?oEVrzFgRNb/QJuFWix8SgbNHyQjSj5skk5F05Tiy5dha3H2S2fxOWGQ2Tal7?=
 =?us-ascii?Q?7VbEJQwz2E7K6ECZ7YSRXoZX82H2A9lULW3DLRFocn6AHwH60DEOkyQXTAgl?=
 =?us-ascii?Q?y8OYaHKdzotVVO+p/8FZJBM0JpSOI3PyRps3SRHovHDQSAeF9grI0kRzEA+7?=
 =?us-ascii?Q?tC/lOQ8eT9NsGuIDigrILlkvgAyCTyf6U8BHMxN9EmJQFnx8xcLYksAjAEgV?=
 =?us-ascii?Q?CusEzoSbCE1MoRuzBIWVXSGuKXFBxufV43smabD/Z9+v5mkOAckI/+RtTi2S?=
 =?us-ascii?Q?GYKl1hrVcnZ9DQcaa653F3ecLYNkiQ34wuTkCGDuZGVu2k9s+SngozTNxv3Y?=
 =?us-ascii?Q?GH0thVBQC2QveNIkwnAY5qUOXZI6MOHNZE/5z/x3C23TTSU4iUCOWXmkIL2v?=
 =?us-ascii?Q?TozDYwqlX+G0umKmxWnWjtaKEDwHSvRfz3jjudK5titJMwoUxOxbQcjtbxw3?=
 =?us-ascii?Q?yo+NLN3agUrni8AyCCJj491kKsQRaihNZZhPPtNlys9WcGb9vJZHCpRbjcc3?=
 =?us-ascii?Q?6xi0y7xA6IB7yvWGpo6Rbfe5mBtv+k14yYXKe8aarzk6Zd99vJu7NuX/UbcJ?=
 =?us-ascii?Q?tK92skPpyQLZpQQjw31Zz2Pxx7Q/kr4IcVqL2kXvQ+ZyxFZ+9ePo3+Oo5Y4c?=
 =?us-ascii?Q?nh7MrP5pxqfp2lzDP0EQVjOGbV+jZNfug08aKwcKkdLqzpNHpi/wWRntYqdt?=
 =?us-ascii?Q?F6iJg+nlBrIaa7xVGA3tTaWFZSX+IknlbPY0Geli0ZxZThdxyWTRYZRQF9WL?=
 =?us-ascii?Q?aKdaA/55OP6Z9y9biCJPg9yuNqzx+q4KntV7pD2Nsbf/7Sq8WQurSggqeE5b?=
 =?us-ascii?Q?xYDN7CCriaDiq3UbdoFNSV14/F8KD2IhuJ8PzwrVske+l2FKD8rpA9sYPx+2?=
 =?us-ascii?Q?vvpLU1TJzEq3hnhiAuw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 05:24:32.1631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41be58c3-f603-430e-d046-08de20196dd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

We want isolation of misplaced folios to work in contexts
where VMA isn't available, typically when performing migrations
from a kernel thread context. In order to prepare for that
allow migrate_misplaced_folio_prepare() to be called with
a NULL VMA.

When migrate_misplaced_folio_prepare() is called with non-NULL
VMA, it will check if the folio is mapped shared and that requires
holding PTL lock. This path isn't taken when the function is
invoked with NULL VMA (migration outside of process context).
Hence for such cases, it is not necessary this function be
called with PTL lock held.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 mm/migrate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c0e9f15be2a2..189d0548d4ce 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2644,7 +2644,8 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 
 /*
  * Prepare for calling migrate_misplaced_folio() by isolating the folio if
- * permitted. Must be called with the PTL still held.
+ * permitted. Must be called with the PTL still held if called with a non-NULL
+ * vma.
  */
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node)
@@ -2661,7 +2662,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * See folio_maybe_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
+		if (vma && (vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
 			return -EACCES;
 
 		/*
-- 
2.34.1


