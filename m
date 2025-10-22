Return-Path: <linux-kernel+bounces-864731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89201BFB6B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C74374FB3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD130FC07;
	Wed, 22 Oct 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rhTlm3Dp"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87028031C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129211; cv=fail; b=HEyhJpncCyGrhCpcAeETVbOf1TRDyT6wQlknMh7LmpmG60RPLkc4nED/5Xj6RHKdOJpoqxWLTnPiXlogBK8DRhT6VbARCaH0YUWLCb8OhofgaUkyrv/jP7UHmhayyIrFXbZzNzlaR+OelbqzCoDJsxj7oNM5xDxDZdcOnlyX/4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129211; c=relaxed/simple;
	bh=do8ng1FP6CZ93p7kJbmBG2UCGkH0H8RNqW/LWh6RpyE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XplXyntbO/rDEiq8hAiXUwsbZ9YCzMw47aCCn4ac3Mt1b7yR0wC4fYM0WWwuF761tW2eKhPhg4t9jOySP0SRXguU9QdFtfD3+rw1tPEh3nACW8prDHWetfMpI3jcPyVZbRaFHCwLv6xeJNzUQm0hEX2vdNGEp9DDUo2xPX0jaYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rhTlm3Dp; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qM3x0WeKkVC5NILdam1CPGo4sMz3/tpAhixaFglTBEFDH0etXRysiscCbjoUu9fZlh8tC5XchgcgOZKS5qLruozvhH8bu5kpphe387YZdvRLYbbx/DOPkEuWjj7SqOhW/SS2TRhCla1S7crEc1JB4WC8WHw4ImRqAExobittmMI8CSkP2D7q7jYl6GP8ZQgE1/w2oTTTUwUP1TtII2BP85BNhrLVU1CGlF7dBfZLYg6z4Zt9QvsZQvgGOquyK6Yldn5PCsKO5rG3AIcChUhU6oVQwK9LZfb94QE78TQ52jRT225gfzBrmOxp6O4SLZmnCsWWtW9tVcYVHUr4gklBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zoNPTxvzM0Nvl3Ha//rXxv+LgXCwayC93WgZex9svE=;
 b=Ou+PfvkuFDm9jUC2f3UjXpeDlAnOM5T1xCYvcB0dyQ1MHeS/d3W1WnaDgs5n203jind3VKyDsByoKYRLPQL8ZKVc7L56X+fPDcnZPH0sXGZV7EgCC2W+rVh/qY2HyeTgu9iDiXGCsvLNoHk3r2JroefeAqwgV1xBjZ8ZqsDQVlDvvr2IrIya41wd3Frc4Bcq3bCa3hxGsYoc2TMd3JuIx0KtcKqpGsL0FbO+bwUg9oSlV7SGke7HWk2r5tFQwWtMjTh9LlhVP4e02mvVP7BuVp6jyAhT3b2IgQe2I4eVhZMaO1xk/Wswf+Sw7k8pglzw8w8yk3rHY0boqAqO9vz41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zoNPTxvzM0Nvl3Ha//rXxv+LgXCwayC93WgZex9svE=;
 b=rhTlm3DpugFE4L2DlnaHTEyOPtqEjbzKGtT/kEo4LS6u/LPc07Cat6MobyHaIK5wpHIkidZoDUoMbtIt4fzPU55j9KhOovCJQf1r59k9aChtWzJPegZyPdxYVMEfHCkOk2XZ4Mm09TXhPlEFWb0cuhUu3bsoZh4ejqlxImpbDmeAGSbIV/+5448LicWZK55fmypBYOdQDTbJTN7WFkbg6VS2WdAyD7NPxHYBmV43b5iOHAwlLwc9mWDGxK8L6UgaTVmOuLvTarVRtYF25Wgz6hKVV1Wl4fDhiwbD0oBLYxPw/JxD9bl6BMokRKCSE6ekV/Au9QJRS+CEuLFHfwFwgg==
Received: from CH5P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::23)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 10:33:24 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::19) by CH5P223CA0006.outlook.office365.com
 (2603:10b6:610:1f3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Wed,
 22 Oct 2025 10:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 10:33:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 03:33:09 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 03:33:06 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <muchun.song@linux.dev>, <osalvador@suse.de>, <vivek.kasireddy@intel.com>,
	<jgg@nvidia.com>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [PATCH] mm/hugetlb: Fix incorrect error return from hugetlb_reserve_pages()
Date: Wed, 22 Oct 2025 11:29:56 +0100
Message-ID: <20251022102956.245736-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ede4c20-af30-4c98-b7f8-08de11566d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TslloTYUkKn0v/JnEkOp3qkq2nFOJF7MR5DA0id2ZsDrKYCC/hcKZ30and62?=
 =?us-ascii?Q?eOROfftS6h9/CXeUC0ao8bgZ/58PoqRHyx6wxid6jgEw1ucqkMyN1PVI9CK+?=
 =?us-ascii?Q?/vfVGP4sb0s8XNmvc81HfRzZCb8aMZzPxj+mSFX+30O1bfgfdUMfbmnhUSwB?=
 =?us-ascii?Q?GZUnZ63fw4ehi5nDxxaAZI9Vpgh+fLMnBaUaAGdaRTXwS+qhH2xkxoa8/Eph?=
 =?us-ascii?Q?OFpIDWTQI/VFpMrGxQkMhN06j0rr+2nA/1z7aCZP+y/qtNJKXvOPwrMquzkp?=
 =?us-ascii?Q?5pb4c2+2sEGh+yZ5r3uNgScMLzAYEcRGzg7ZT72muko4Glysskv6AhJZCQ1t?=
 =?us-ascii?Q?nO4NQo/i5JVGFCvtVlBYFBFKmnHXTp1TqXWzUd9C6pUw3lCKaF6GHemkxiqj?=
 =?us-ascii?Q?sM2HSjWFIjbu7npTASeLCQrdE8N2JjD5f3OFGy73/vWKlE3sY1fp9BeCKHdJ?=
 =?us-ascii?Q?SaT/3ZG6iYIqT19/LjdnKmpyFAVp82C9fU6f+P0dWU4pNXZq4no9F5dEWFQi?=
 =?us-ascii?Q?NNvmgKbclqlnOzptSOlCzTMISZCuZRQZuf4UuC/Hsq3mTTruqXQOv90RVwej?=
 =?us-ascii?Q?fxwV1WzieSd6XzLPgREe7doMEVNt2NpPvfSd2+6DBu6zSexx1VXHH0ckBt60?=
 =?us-ascii?Q?qjDPZLXys/wNuUM3Wazfn2PtPLMONCH6T67LLC/2EyMpCoiYnzRgUJjQVo23?=
 =?us-ascii?Q?MaIZPVeuLWBe8A9R0fYLxFRkU9Rgn/u908zhHdWgwSw6L4YqULNMi3hWbXTb?=
 =?us-ascii?Q?r/6YVQM7F7l9HVPYIbhqCEnAXKTIeBHw3aw+s/8yMvSVcGZf4n8wfIZ2yRsv?=
 =?us-ascii?Q?/KSyqRE217jP8Qq5bONe0iSTIS5ERQi8jbUe6JRjuUmWQ0EhVSFs76j6uj1S?=
 =?us-ascii?Q?IjWAdrU2ZHpAArSxJlNsuhLAJgIO7m138PtyyQhFtqn8vrIKCZ4o8dycSYmG?=
 =?us-ascii?Q?I4AIWfX3iDtDL4dr7N43OhZNRMGnY1ve3eJfzFNmF8yqXzQclYEOqOzXGinO?=
 =?us-ascii?Q?z9ukanh4g0oVO3EvcBnMfzXSwSaCc8KvYAhYrs06NAlkiwofODSO3oHIygxf?=
 =?us-ascii?Q?n46ma2ezDTn3AcICbChd3P5FldQTiEKnBS/T+5mIJFKG8l1BU6v/DdmmlttM?=
 =?us-ascii?Q?mwxGWHF6uTjlQX44o11XeBl4aKmzfo/mGyXt3TO/9PFdpLrpaXztCmUdhXSJ?=
 =?us-ascii?Q?VImQ1kSgAZIKQfYzgc4EHkugT7rkmZdmIOpjo1V3CLSXas+y+2yqdkDVD7/X?=
 =?us-ascii?Q?MG1oL4LZpSApxz29mkpEPJUM0xCiJxfPE50qM4/MUJBCymwlGk2f6IGrsvyW?=
 =?us-ascii?Q?T7O9+UXFyK4vNkibCvW5Cz7Kz3Zqjk0mn1GytuE/2Xz4s43PVM1LfWJlSaln?=
 =?us-ascii?Q?gq8ULhaaKK3Ro5QnUcv2A1+5HuNszGVkGD6UIhvNR2k4aKnU2o7eUIDuEeDl?=
 =?us-ascii?Q?H+ZbEYZuCUY201OqZo9T7kqJ2UfpeRxLUAepDhYAzyQK3sCZZMbgyaF7SYxA?=
 =?us-ascii?Q?BNLZ5DQugU6KT/rnLWlGgxGxCS4P1F2t2f68/moaMC1rWQAuAY+KEHMNXNIg?=
 =?us-ascii?Q?44ca/aX+uGKqwQIenqU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 10:33:23.4513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ede4c20-af30-4c98-b7f8-08de11566d8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

The function hugetlb_reserve_pages() returns the number of pages added
to the reservation map on success and a negative error code on failure
(e.g. -EINVAL, -ENOMEM). However, in some error paths, it may return -1
directly.

For example, a failure at:

    if (hugetlb_acct_memory(h, gbl_reserve) < 0)
        goto out_put_pages;

results in returning -1 (since add = -1), which may be misinterpreted
in userspace as -EPERM.

Fix this by explicitly capturing and propagating the return values from
helper functions, and using -EINVAL for all other failure cases.

Fixes: 986f5f2b4be3 ("mm/hugetlb: make hugetlb_reserve_pages() return nr of entries updated")
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 mm/hugetlb.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 795ee393eac0..1767f7599f91 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7269,6 +7269,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	struct resv_map *resv_map;
 	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;
+	int ret;
 
 	/* This should never happen */
 	if (from > to) {
@@ -7308,8 +7309,10 @@ long hugetlb_reserve_pages(struct inode *inode,
 	} else {
 		/* Private mapping. */
 		resv_map = resv_map_alloc();
-		if (!resv_map)
+		if (!resv_map) {
+			ret = -EINVAL;
 			goto out_err;
+		}
 
 		chg = to - from;
 
@@ -7317,11 +7320,15 @@ long hugetlb_reserve_pages(struct inode *inode,
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
 	}
 
-	if (chg < 0)
+	if (chg < 0) {
+		ret = -EINVAL;
 		goto out_err;
+	}
 
-	if (hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
-				chg * pages_per_huge_page(h), &h_cg) < 0)
+	ret = hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
+						chg * pages_per_huge_page(h),
+						&h_cg);
+	if (ret < 0)
 		goto out_err;
 
 	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
@@ -7337,14 +7344,17 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * reservations already in place (gbl_reserve).
 	 */
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
-	if (gbl_reserve < 0)
+	if (gbl_reserve < 0) {
+		ret = gbl_reserve;
 		goto out_uncharge_cgroup;
+	}
 
 	/*
 	 * Check enough hugepages are available for the reservation.
 	 * Hand the pages back to the subpool if there are not
 	 */
-	if (hugetlb_acct_memory(h, gbl_reserve) < 0)
+	ret = hugetlb_acct_memory(h, gbl_reserve);
+	if (ret < 0)
 		goto out_put_pages;
 
 	/*
@@ -7363,6 +7373,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 
 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
+			ret = -EINVAL;
 			goto out_put_pages;
 		} else if (unlikely(chg > add)) {
 			/*
@@ -7423,7 +7434,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 		kref_put(&resv_map->refs, resv_map_release);
 		set_vma_resv_map(vma, NULL);
 	}
-	return chg < 0 ? chg : add < 0 ? add : -EINVAL;
+	return ret;
 }
 
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
-- 
2.43.0


