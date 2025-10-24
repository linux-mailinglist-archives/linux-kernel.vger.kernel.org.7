Return-Path: <linux-kernel+bounces-868527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF1C05662
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57748358D22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C2930CD8F;
	Fri, 24 Oct 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YqvelhV8"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57A30C359
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299097; cv=fail; b=tD7Vv79EhHULxU7tUWI7u4dpTNIX9fmUom80HHnHnjk+SxgDVCliI5T5zuB26gGdo7oBHB6AcHsy+U5SqqYD9IluGXoBJ7JrCCuSsIkwWqjXDBjr2bz5UOM31nTy7MK4OT4k+K200tNW0UN2igY5qO61UE4VOxvG4WgmY6xHRkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299097; c=relaxed/simple;
	bh=o3s1Ha3TV2RX23kywxnpdGxbU1A37eIb8sa5Ut1cmzs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R9TmX3vji2wBvCWnN7RsWlZGLUqhr5R4NogNEi1aeP9tF/xVWWC9jkHJYZfpjcVkfwB7+xmcjiu43lPqo3RJyqGWf0IIWnp5RvZA4wV/XfKK9seU3ZIPfTAzGqZcRaMTADnFrtliyUYChkEYLdG86GHu3110Nzvt4y/O7fSyFQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YqvelhV8; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOVP1FZ2VxmsNKxZRJtVfyqD4SlgDtI4fCRLut/Ac0W6goW9cTFzES/stowgMo6hDD1ZlidaTJo5Egn3SUlRJ0uQqGiIwpsy4hL0Wlk7nVs1ZuwxSN51kAURuF8mk7Lox6zamPbDvG+Lq7HG8jz5VtNbaYmzlmgRR4goUHOfMSBvO+NXuEkkhMPvEDxRAzIYTKgTdFUdUtKa57nscnGR1zXpxXxAB2BhfGdNw3dUG+UiRuJOune9W3WpFn7r+17cprodYswLST33sxeZ7RPWrDrBRrCets5WlNs+rRPJbGa0pvrk/9sOsa7iUaACz0KgfW7j21Y3UKno4zmK1EGQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA0wJ4kXict9x77V/zSDSfaP7Xdt2ODGuQteAEucV2M=;
 b=GjD0uq5aTZcWlrK4bgS2ghw169Ob+QJx+m0nHynXcftKmj96yGi24OjP3u5xnEYHj95ZC03H7QWGuK+97+Q6ggPvg8WQJarRigBTKHvEHchbl56reN/25ntQP8+CaeahPY3UYwXRN5CEWpiUJ3kHgQ/60SsDI/XW9CFMnRPkGydtMfpdcw1dpC/oZoVunRtlwC0yj8mhNunv66ICEH2wIaRpxK92DuuVYRrcjdxbplf9Izjp63M446lrORIfMlYBfhTHZyc8T8P9z3E7MU95yGKLPzpvR9ROlCTeTCcDskRzXIgZTjAYivUuL3n1byMjSJu7DKefvZ2b0qR060HdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA0wJ4kXict9x77V/zSDSfaP7Xdt2ODGuQteAEucV2M=;
 b=YqvelhV8ksgSkxCjHh8Ij8/1V0rCTC6Wd4bKcz1ZkVRoUE8IAKggoyAxiciV8G7iJJ4NcBPpPZ4pA3r7YqdOYTAsEj7YbIBq1bgxxRNEY1bVNLpRcj+A7t+AC/7ptmM0R1Z+ysA3gjO8VZP4XzSiMbVyaNqP1orvjohixZPZw1WyqP40I+5Wn1kV1CLp0ScHiv8fbuc0yd6cj8bfHkjvm37I4nCndTYcnqcEeojFdZuX6l8quCTpTOaGU1rH108mX05h9X1lS9ChgMPmyYu+Y5KUu+n/JaOs5DIDx580NPCn/N1WBH52+1mZ8GBv0FOHaA+VHhuPf9C2i1c3X9LWfg==
Received: from BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 09:44:50 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::b1) by BL1PR13CA0248.outlook.office365.com
 (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Fri,
 24 Oct 2025 09:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 09:44:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Fri, 24 Oct
 2025 02:44:31 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 02:44:28 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <muchun.song@linux.dev>, <osalvador@suse.de>, <vivek.kasireddy@intel.com>,
	<joshua.hahnjy@gmail.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>
Subject: [PATCH v2] mm/hugetlb: Fix incorrect error return from hugetlb_reserve_pages()
Date: Fri, 24 Oct 2025 10:42:40 +0100
Message-ID: <20251024094240.337630-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: b16330fb-16a4-48a5-4bba-08de12e1f9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8IN1yS3TUTYbHxEIwZuv2kMDQg1h/f+PZ2PxQMcYn8Ia5vtw3SgAvZhdPn5f?=
 =?us-ascii?Q?Q+DdFh/esv8MXlGMIJ4MRyGTPt7Tds6kFI3jILjDXhaDurbKzM25E3qrsiLD?=
 =?us-ascii?Q?s3ghJmnNdrx07jPxzU0BI7v4I1Kk4GL+mn7GYrRD7bPKhpjGnLd840Ax0tvS?=
 =?us-ascii?Q?NiJMyt89rQjQTkPE/xpWrPcK7N0NPipaQ/uH0901fpvBAKDGva6rsfn/T3IN?=
 =?us-ascii?Q?oMS+vLfv4nvwuUOG4teM2a1mH8/k8ehs1HLGFqVRYFbBM9x6LbdiHE8LM5pH?=
 =?us-ascii?Q?h3mfjNQgNSMx4qStlBSciitob+u1knUMq1p+zG1pR30Qy3qPlRxKCS6eudmW?=
 =?us-ascii?Q?ReccAHQ67ZdZQKnEF1+HyWml1bZX6NCIBsXt67lEZJfdkOz0y5MrB3qLaTxw?=
 =?us-ascii?Q?UUz6nAJIPE7W+IMIqCbMZHRcmrn6+znzcKeYe/WOOqSbZlrVS+IFBkGeV7X1?=
 =?us-ascii?Q?oSp1qk1PzdkuiXoiv+o+nQmwnu9TQrJdyC4vmeHaJBsg182jewctdfmNMxRT?=
 =?us-ascii?Q?9lXp3JBaHUVQ1rCuNaeRPGCTbI8qJfEYz3Du7k42xh93H2fW5GZSLVod6vzg?=
 =?us-ascii?Q?bgyjLYpFIlPMXGCtqXNK4IiLp8heX0VNIyLnc78/xrVbJqTx6T/n1vDhRzRG?=
 =?us-ascii?Q?RioRGaOkU2d/I2EZSh6BxpEZklufUS97bTLfStE4Qdu5tm5pcPik2OvkVdue?=
 =?us-ascii?Q?XCZYiLbSeZ/+wWftI9e2k0mCwUh6/Smz9nTOKE99zQGblRFM40WZcPPUmNu7?=
 =?us-ascii?Q?qxKqMoTj5qZcY4HHPbE62+5X6gU9hzfcVRJltkrNjsIAmixkl6qaTHAoYytY?=
 =?us-ascii?Q?dFyjpuuWKHjQhFRQ3fECIe6iIXQckO6c+v0UxVWzd74ch8gQvprFKpUrQAdn?=
 =?us-ascii?Q?EEDC68WxW9Vzjr/ubEwG0SIAfqrBwrT+9JymxdzTjE6FhS+bbGEthbh+u8yC?=
 =?us-ascii?Q?LOn5bsK3+yA24acThIaD7Dl/CRfvge24WJ7yoPt28qiBZGnSCjYXuvIrzRb+?=
 =?us-ascii?Q?5xjA+RX04TSZynmRU2t7Oqp3OgVWmftb3Gev+pYzIzUoo8WUSp2SjeAgma03?=
 =?us-ascii?Q?i2WZg9rt31gc24qSnExQSSTy0j3MTGCaqxZyy5HYpWAx3nwGhv6RnEi3bYf8?=
 =?us-ascii?Q?+Z+ojfyuojVC6rOWdyI74Tamoc1QjO5KbNU8pJ22zAlxDKTdLPiFpB31mKnx?=
 =?us-ascii?Q?YAaUsLwFTGbDgEXtM8iHlf6QczY36higCvzDe1scy3DLX/JWkBpWOHUeQ5q2?=
 =?us-ascii?Q?uJBLMvPYeVSI2kfYHs7oqDwlck80P+tpIKVWnuEAdDjb2xeoLyvG0EfESl3o?=
 =?us-ascii?Q?5N7AZAifwUxBkLjrZvj/tZa2M8HUxwRQT7UOAZLea3vUgbMByMDLaNucKB3f?=
 =?us-ascii?Q?tcnXNyjwEY+65hoepTlF0yecClMim2rBrqBdjJ+Hm4GhRpIAV5UBVMHLDE6d?=
 =?us-ascii?Q?fmuwHzNgKYqE+8TYKheRq42qD0OPEC9Kgj5lASp5kK18qVymbHqlFrfRB+rD?=
 =?us-ascii?Q?mt69PAt8Hh/G+lTO+/SjkwOABSP7hMbZnElCjyLg7YcY8T60MfedlCJCqo5F?=
 =?us-ascii?Q?NcJVS08f94kKRuzzzRBGLVVbFunq+WQVt2yS+hBS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 09:44:49.7344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b16330fb-16a4-48a5-4bba-08de12e1f9b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788

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
 Addressed commenst from v1. Thanks!
 https://lore.kernel.org/linux-mm/20251022102956.245736-1-skolothumtho@nvidia.com/
---
 mm/hugetlb.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 795ee393eac0..b6c0024ff5a5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7269,6 +7269,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	struct resv_map *resv_map;
 	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;
+	int err;
 
 	/* This should never happen */
 	if (from > to) {
@@ -7308,8 +7309,10 @@ long hugetlb_reserve_pages(struct inode *inode,
 	} else {
 		/* Private mapping. */
 		resv_map = resv_map_alloc();
-		if (!resv_map)
+		if (!resv_map) {
+			err = -EINVAL;
 			goto out_err;
+		}
 
 		chg = to - from;
 
@@ -7317,11 +7320,15 @@ long hugetlb_reserve_pages(struct inode *inode,
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
 	}
 
-	if (chg < 0)
+	if (chg < 0) {
+		/* region_chg() above can return -ENOMEM */
+		err = (chg == -ENOMEM) ? -ENOMEM : -EINVAL;
 		goto out_err;
+	}
 
-	if (hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
-				chg * pages_per_huge_page(h), &h_cg) < 0)
+	err = hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
+				chg * pages_per_huge_page(h), &h_cg);
+	if (err < 0)
 		goto out_err;
 
 	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
@@ -7337,14 +7344,17 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * reservations already in place (gbl_reserve).
 	 */
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
-	if (gbl_reserve < 0)
+	if (gbl_reserve < 0) {
+		err = gbl_reserve;
 		goto out_uncharge_cgroup;
+	}
 
 	/*
 	 * Check enough hugepages are available for the reservation.
 	 * Hand the pages back to the subpool if there are not
 	 */
-	if (hugetlb_acct_memory(h, gbl_reserve) < 0)
+	err = hugetlb_acct_memory(h, gbl_reserve);
+	if (err < 0)
 		goto out_put_pages;
 
 	/*
@@ -7363,6 +7373,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 
 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
+			err = -EINVAL;
 			goto out_put_pages;
 		} else if (unlikely(chg > add)) {
 			/*
@@ -7423,7 +7434,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 		kref_put(&resv_map->refs, resv_map_release);
 		set_vma_resv_map(vma, NULL);
 	}
-	return chg < 0 ? chg : add < 0 ? add : -EINVAL;
+	return err;
 }
 
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
-- 
2.43.0


