Return-Path: <linux-kernel+bounces-769182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17918B26B33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EDD5E0063
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3662623BF96;
	Thu, 14 Aug 2025 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TzcMM+zj"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6A23C397
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185659; cv=fail; b=iVqCschPYojrMBqljpN72MIO4H558wcP89XbuqeZYXu++o7rtPeIL4v2xvL+kIuF+hvGM2xQu5P/LDWWO/W8r+m61ge/h+RcQPoNqJ+HJniHWOisqVjjrKjoP3ngK2p7JRJHW2mw84cWhMg9lCK+kKFYUnZ0WzoFBWns/kvlphg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185659; c=relaxed/simple;
	bh=iAf9ugzP/ndFqsUtIJq9llrrTSdpsL0RraaHlI4sh1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBMMlfhRXJyFhn+osTsV2pcygsMdOC7cywvPLOSDr35rSt4ROcJtVS3TCcXMZJctQjwdg2GTLaAV5eENBFyWh/1V23g0MzshYi4ktdlPQRo7cJgiQzbnlaYD5g09R1o9uJcqSyNt2lL1dJA11VUTxi/qzJOQDjuWZvJ2f6aI4zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TzcMM+zj; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiesXj6Vt15HwW8viwr+36okH4RmOlARHzF/lAV7QcpIK+oykFwvdWhaAlIQAC9IyfcWqmd3lLGzf/J2YNOhbjMC1ZuPTHwN6b0CRY1ou4DMgPrUA2dkdNwSUnVtjyeW7z91+Oj7RUOFu/EgiOnopDWhDqCjAxSl8/ihxQj3402ZlBdYzMeFjqZQ9R0vaNcJYaKm3fYWp3+nrghp6ctrlgk5jRYiKlke/6VRJ52/u7AqnOd83/DBIf4l+763ilZY9Ze1AgjQo92eLxnT1ytqJZGzIMtmGVyFlRWliFZDzqJn3S/OhMk+mvV2JY19ntILRPn6br+B0bGOGy976WzllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqSNVJKUarTtk4qidv7ivgZ7qR/WuPYJzNjNjEwUemA=;
 b=D9J3jVrft9yXHV9f+NZlEc6rTo49bacxWeRD07HMEqSLeNICOMB0AB4YrM039EE98R+/55FSQspg6xTvoHrxwptmtWtlIlR4WodDWyAfMvkCmvSSoeAzhyQNB8mWeqVE2tilipMi5QiqdvZQfOY3eXW2tcOlx6uqAXkh9sKZAdeZe7tjlFNgVcNjr1yPSbpFrAA4cbpj5PoQhyQbRl1PqzhHr13hFGT37z8mQb3v9I3fHxB1dVtqAxehc35fVftI3xCR+oxWebjzut4u951vdvr8JhSOtvKiJ+wjVbyr10gQV4awhSpPgC427rsfuJrv1wF6STYtfARdn1SGCGr62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqSNVJKUarTtk4qidv7ivgZ7qR/WuPYJzNjNjEwUemA=;
 b=TzcMM+zj7gjlJuVeAXy9JYPHrebnaW9ZgV7cGOfvy2GXwshmVYdJNfE0m08oQV1fKzRY2qhFzt4c2cY27JGvKswvRu85KXtk5jhO7KUEa/7BKsXkrKXevYAsPAoCyfyTPjTqktrW2JzI8StsapER/fmgb6RDomWUgNcKShO0WOs=
Received: from MN0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:208:52d::32)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 15:34:14 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::eb) by MN0PR04CA0021.outlook.office365.com
 (2603:10b6:208:52d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 15:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:34:14 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:34:03 -0500
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
Subject: [RFC PATCH V3 04/17] mm/kscand: Add only hot pages to migration list
Date: Thu, 14 Aug 2025 15:32:54 +0000
Message-ID: <20250814153307.1553061-5-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: abce2e1e-1336-42d1-0e5b-08dddb480653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E2Z9490f9ZjIk1Tmo9uHh3dUPiEkAPEmEpWzlAjLZbtFf0kefrowYe9+uRgO?=
 =?us-ascii?Q?75/+aGxffofyj861wjNRpkTOaXE2nsl3A8FO0ET3x0zhfrUezPe8SP0tZLUP?=
 =?us-ascii?Q?eJaGmDeKydl53Z9GdMLKufedOthNptD362eTZxgn2P0wfnKSOufVWjopYWkK?=
 =?us-ascii?Q?4FU67mR2AOqdefyp4r9yX10qni57E8kvtWmFPQzRbDkWgNgQOsC8qIUpQLe/?=
 =?us-ascii?Q?CH9/A59mzXbJSGtfb6/hU46kIyH8civCBTtrZhO5AEdcLCAg9Sf66IbpyPm9?=
 =?us-ascii?Q?aNYZkDr48VhALZqDigVbVB5VtOAVuThAbAKb9q+HwdAHHZxRfb9MF7Ks7a+q?=
 =?us-ascii?Q?4BMKN9f/e0VyWTyrV9tQ5qXI175mhKIg9PulCGZACHeD3VvQWPQ6EMjZM1Q3?=
 =?us-ascii?Q?L4UBEt5qxUlYwYfHvzIP1z1/tEJ0QRRugFGfhoR8nl0I/qSZk5BljXXwQhal?=
 =?us-ascii?Q?iaea52Qbzn/YBDxIT/CWIl/fB8ckFhznn1qSW8X7EkzKVk/pup6p1k12LJcl?=
 =?us-ascii?Q?ps5EPv8wHhynpIPmpcS2TCHVSEnbLxls/HEXYB2dim0nQSihJq/NNvQWA3LC?=
 =?us-ascii?Q?T75QBIIwXlORgrYKg3tb3C/XpgOFaMPerkVS2yKoH+mMaTFIdDxbSS8LsxYR?=
 =?us-ascii?Q?0t34nsml6ee0vfSPT5mxI1fBkeO0ZhzZTx6Ig6Dr0eme0OcUyhQmYuhwwx17?=
 =?us-ascii?Q?DO2XeCcDQvtsycFtGWOhZatUUrRx3t6Vmhb7+WW6O8QFZTcTr94JaDu4Jkj7?=
 =?us-ascii?Q?whkDikCiXGGp+FIZCitiuVFjucIV2tiExFVrZHspP/vPJFgnlxqUd35q3Lh3?=
 =?us-ascii?Q?NRswZMul8gl/2IryNvj1ORsafh1wOewwCAcwRh+7hHEJnCPIAIJ71M10hAVB?=
 =?us-ascii?Q?LEqHC+zqgxJPukrjyH8BaR7BXKP2m7N2Lwn5fHm2bpXkFVtJ0DU9v9RN3UQ+?=
 =?us-ascii?Q?KVIJl67eynCW035vMYDUG2ngF0xpJyXjRZdR75N1JHm6ZYs3EN7hI9/HTmeL?=
 =?us-ascii?Q?P9cJzLuT79zKJz5CIE2g1GX8NCId3wmxb9qDPlDxKa6gNIo97LHC2rg0DW70?=
 =?us-ascii?Q?rIpBpumLrm8Qut1mNGLYc4FtsNt3X6DLiWa/2AOalCZamLdANyV1gK/pj35H?=
 =?us-ascii?Q?lrf5zQBTehpPBhEKjTFu8MzeiLI2B8mdyiqzkR+Yc8uKuFvkXeFiwB/fbVUt?=
 =?us-ascii?Q?tPC60TPfNXUHGPqLO5snDTpfM1VRH1bY8E9VexwT5KzqZ+psKHhWNJoyXq2g?=
 =?us-ascii?Q?xe1Rki5uth9a8o/U9mnMcGq81I/SfHMaPxScjr1jpbBhlqBxWzweaRrCCHhn?=
 =?us-ascii?Q?OY6V5eMJY/07LBuVSBl3UA0durVw2HA8TvOQ0ZhE5LWftF2T0sTVCctSeQFG?=
 =?us-ascii?Q?ymgQFIA/aGShFx9jA51pfgDKJFE0ttc5k9MU4S5wDWca0idcIlGbo8RAmCKR?=
 =?us-ascii?Q?Lb8erM6t/aB27MT0/F5clVmfP+xRHbTlgA0/3EBeWdxflxx7jZvH7ueOP9af?=
 =?us-ascii?Q?gcIImjwaoqZtGohrzuEdNi6BakRjoqQn//Se?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:34:14.6290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abce2e1e-1336-42d1-0e5b-08dddb480653
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481

 Previously all pages, accessed once are added.
Improve it by adding those that are accessed second time.

This logic is closer to current NUMAB implementation
of spotting hot pages.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kscand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/kscand.c b/mm/kscand.c
index 1d883d411664..7552ce32beea 100644
--- a/mm/kscand.c
+++ b/mm/kscand.c
@@ -196,6 +196,7 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 	struct kscand_migrate_info *info;
 	struct kscand_scanctrl *scanctrl = walk->private;
 	int srcnid;
+	bool prev_idle;
 
 	scanctrl->address = addr;
 	pte_t pteval = ptep_get(pte);
@@ -219,6 +220,7 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 		folio_put(folio);
 		return 0;
 	}
+	prev_idle = folio_test_idle(folio);
 	folio_set_idle(folio);
 	page_idle_clear_pte_refs(page, pte, walk);
 	srcnid = folio_nid(folio);
@@ -233,7 +235,7 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 		folio_put(folio);
 		return 0;
 	}
-	if (!folio_test_idle(folio) &&
+	if (!folio_test_idle(folio) && !prev_idle &&
 		(folio_test_young(folio) || folio_test_referenced(folio))) {
 
 		/* XXX: Leaking memory. TBD: consume info */
-- 
2.34.1


