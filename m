Return-Path: <linux-kernel+bounces-726808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A3B0117D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAC91745CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB71953BB;
	Fri, 11 Jul 2025 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e85CeZqy"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2AA95C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202999; cv=fail; b=OBCKd184detprOZeG3SdRDFdCNAxomrRHadSm01PTh/Unv/HNqSTZyDJckEyZnWR97wAYq7zmM+9BoPmx2VbNMmdoo6XkaEwxierr7SQd56D798osGCznhT7bwXN1+IdomLvDRoy9/mm6gYK+8rbwqOAjGgHmjDuUUZTmOAWYHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202999; c=relaxed/simple;
	bh=5QTVrcTrIoBQdoHj4ekL0kTcj96514NWx1jyVB/VMcc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZJaq6ZAM3WzseIMv7za7Uw1PFwIQr4UyulpncKtDzxZwqU6guD+VBIQlvkitHhiaJLnAym4T6GFq1l3rFDlwNfqaqMeoxlvtv72tSYbgZ8srIJsHuMWVKpbuW9udw26JMRXLQ0ag2bgoW+9kUGWlE+RKGsqRO5MymPrTT+U2KBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e85CeZqy; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UM9XnauKPdi6dpp1re/K98AZU1oQrWaymJ093muVJeieZoG0ofTM1pfSqdsA3kceJ3oRn9py8RJvL+vcRlc3fDudjor9AE1Eh2ZcBOQ/Df6slIeL9E/eRvcrfnM5uPCiYwdmO8/UEoDa4a9304TQ7Zl4GrKOC5Iif8Pv6qEyPSlow4vzskIqp/WthoPiVKkXc73pc+3BBoK1lhD9I1CSS4rFec59RwYaB7wn6Jt532/YoIbWfSnIXQOH3dMIcmq7utiUqf2UWAje8Fxo2nVwhgjoPG3EatcbZ0U4pzXYLWsSnFFi1QbmInHuxgvwPP8Py2oY6sFv31I1maPONxuwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKWQ1oN74KhSV/2h3A4OeV5bJwqsu5XswmSNrmNNyfU=;
 b=owvtot7YX3V00bVR06feGIj607sKCM+HEjfMKaL1rtt9RBz1/KUdn1lhKQxFg2+JerRTv+uaP4BGwukB4GrdKsW8hmLkjeQ1mgvfH2LRXyNoVrPxD4vEKP9iqAH99ld26h/jykZra2A5ZLnGq/IcheQ27b/qzlGdvFAy07jKxoeaWSKG0Y8nqbibp9pRbXq5aWNVAoHeBswWGGSBb4vrA0jqnH9mq55YzbuqSka8jnUT2d0Y8VnIzGHy8/JYdtNa9+QXCBzX1mX07epfie5+6J70pxhZym2sgqmtFAvtoxGdDJAHJPeIhUJzcTesiaK+OESzSdwz2ga5drvdXNsLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKWQ1oN74KhSV/2h3A4OeV5bJwqsu5XswmSNrmNNyfU=;
 b=e85CeZqyxECn94U3BFCRB+T18nbKPFnXQQa0MazH8TJbcoVrWp293feyTdvz6WAhu6ep000yFC6LVh/WlZfVSWzUXl7y2zDroZtp1+UjlSi9rGHj9ZvhjXIg50LuO4AIDMD9hsC0e+Zuzt4dpqdcRafpNfOTc+lAawq56aEBHVJDB4Z+oeXVjBLUXgyLkDczYtdCEVtwvPUtD05FOuhLotIFp54M0R8MzFw2AhOxFzR8R+fdTMOmIU/HwlEeQmAGMOfJVsvPukooWxOrdrYxxQ1aXtIeLvnzrzVuEbc/sEMo64CoDUA6udFFpejDUfv0WfFXu+EWLd56+CiH30T5rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 03:03:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 03:03:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: Balbir Singh <balbirs@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/huge_memory: move unrelated code out of __split_unmapped_folio()
Date: Thu, 10 Jul 2025 23:02:59 -0400
Message-ID: <20250711030259.3574392-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:208:52d::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: 2082c57f-1547-4221-8ab5-08ddc0277965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bH5dYDU4PW3GoAAFc4pdj6tCYci6mPQEsim2PzwKKAZHCbUrXHoQPka2yX6J?=
 =?us-ascii?Q?qXCRe+clH9BR80m0+sX58GqBlxotFnoqUPfSAO75YVmDUgk2vI66R+0cDbD9?=
 =?us-ascii?Q?/Qtbr46/mxA4JZx+fQl9RafCAS3xp+6rbaXmEhHHK0JwE67hLMyC/4vbUwkG?=
 =?us-ascii?Q?CH4el/X5MkELFF66RUk4u2kTe4Pb8ePzZyn0t52j/Z3/sZlUhN4EVInEgWCM?=
 =?us-ascii?Q?S+gTG7x3mzg8o4T5WqtB3dFeGLAcNJOHjp9Cxc1XgSEExyWxJjPgqWHQoWvY?=
 =?us-ascii?Q?kb5buEcg9wrsiXDv/At1weMIGs98WVryLYJN1pNn5e+g7cdkKTXaS4cLN2M7?=
 =?us-ascii?Q?jfp+1bWFN3jfG2c4HGh6WfcybHireZqHOouL/7XVmB2Cp8eTstXvyZFOLPWl?=
 =?us-ascii?Q?RxUH4V0L2XsFq/+N1hE40i4IUL7Nc8agjeOe1d4qa6g2OuLXGXlHXi6kUAng?=
 =?us-ascii?Q?MXqTTecU8N6RGKwxwr0IDT6ID9Y2RVgHl+5OSBH3P1bLmT7fddx2hboxmm4l?=
 =?us-ascii?Q?HvvwA/EWJKnD8a5GDY0Gjktqmzl/usjmctyDOtglARhkb0iwPGskXBVy4c8i?=
 =?us-ascii?Q?I0NB07fyYKerkg0yCV7/vzbmPSNNwbnhRyp1a7QVo5rHqDY6p9xlsBy67q5s?=
 =?us-ascii?Q?taY7jzigHO0EHf4tFALyrbsHHzmLsJ/Rbq+Xl4SAlAjR1pAeH6d0uc3ChgGc?=
 =?us-ascii?Q?kAsgkdKP0ULTxNHekMnJRCHmdP7+XLz1een7JmkApMUnqPpGDw92PibN6zQe?=
 =?us-ascii?Q?AW/9kam3WakHK9NHEwGA81QWtmCYz4l7NmGxzySMLl+jUkwcvsLruMnIg4x1?=
 =?us-ascii?Q?7R2EFzt6KveVyH/+LmH2zC2qYfh7a8vBn5/ZOChsC4ANx0FNNF7afvGCTXfn?=
 =?us-ascii?Q?xbovz98+SyP0GLk68hbZv4FgPYxs0+aOrIyokBqo/rpAgMCMhyvQWYVhNnwB?=
 =?us-ascii?Q?T6aTK29Eha3JFLwUV68q9Ttt0ogdn286XuIDCvi/eGzElpEC7AIRtEjUtiC1?=
 =?us-ascii?Q?XQbXpsMsUqr6WPX2vzeQ7ZRA9da5PQhUBp4wKgy7zcAxPJyPW6qacgYjgOGm?=
 =?us-ascii?Q?yNE68bf8iXncw21InjP1RumAskveRbnvug0CmkYfMUjK4kN6aid28zmGhX0T?=
 =?us-ascii?Q?UNwJl7DSM7HPQZ1DhvRMt1QZkRbBJNRMI/q3becUQE69vKv74KUjN7fB7kpN?=
 =?us-ascii?Q?C6chp6aHm3JayeN6tF0rpZFC7HbwaCu3d4lpeCednMMT3gonWRyUX0VjSuj1?=
 =?us-ascii?Q?qpJAmzJ77C+sTWbmCDyDxw2j/TuLr/WdsnT/vTsiz7mgzBe5B70G5pxPagnF?=
 =?us-ascii?Q?c0J5YXVJSMUq+SMZHPQxNIYwd0uWhD1+BEeu08AwFiovaE1RWj4wL6a2+plB?=
 =?us-ascii?Q?P7vLiM4E4Q1J/ooA05uR/F05K3NFzkqxMtLHyVv3rQcLYAeiJZa54S7+NdS/?=
 =?us-ascii?Q?h4OEYszRJvs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lb1JTXLVOeg24Ky+ewvY4YNbpWaBa6lkGnVMgsNdxV6/44U0kF3yxX6A8Qen?=
 =?us-ascii?Q?klT8vt6c8HnrkY/qeNiF7EeVkFM1cbAlGVv6HuxerIF6oCs98ftD3odpIHVi?=
 =?us-ascii?Q?0+LIcR5Emcwl4f5LYGJ0OFj5NZ6ELtOVdqwxm9oKSnBuN1z4MaqE+hnzxBg6?=
 =?us-ascii?Q?xFdoXFIQq+hmSAzI0Fh3mKUZlNGJj9jwY20cZvPVecXZNH58/jyUNljcLYP3?=
 =?us-ascii?Q?L4EHTR9YUjJ8xKQadmUs3WP87qyTSVHoCxOr9URIUtbggmRLbAts7iFSwjT2?=
 =?us-ascii?Q?bZqmLmX5zOM6YY2Db5xtOIk/Ee05KBFYPS7hCJE+FOft8Mnem1HtdPbO+omM?=
 =?us-ascii?Q?WDxZnLoE5iz6DJ3Wn7tDIMe+yFiwrkTeWRNfQkLn2UR2EY4g1RT/dXoeDy80?=
 =?us-ascii?Q?Sh5Enc42c+YEKIKOrvVQS20UfohSPAraWiMxqrAYWulFVfVEZVNbt79U2VA3?=
 =?us-ascii?Q?s3da3euKOJjaKAPrBoFdk8kjB8BZr1h0f/oxq9BcPn5wOE4zEdMtajeK73ks?=
 =?us-ascii?Q?MWnz+ZKwjhOs3XrcEeN1865TdJ4hr8QmXr4gGmDhqHMa+96lUs5jGbLyfCEH?=
 =?us-ascii?Q?gPaIqNQ6H4Jt2ZZgu+o9Vk1126nzf4KIp1adzRab8ycSaiz9DtlgqJW1B4nf?=
 =?us-ascii?Q?s25KyvD/brym+Qv/dEKGerXDZoz2P1SCYlTVzI5iGRV+zai18mbCwy69wKc6?=
 =?us-ascii?Q?8ZDhiZIvhtAWC9szzN69pJzUEm7DKJosomTDoGn8YG8Fe3QMaDvrLRa4dt6Z?=
 =?us-ascii?Q?8jogCxjfeDDtD0RCKpf4ZuaWekK73DG6TGQs0xDnGV7gSSJlZOa24upW1R7j?=
 =?us-ascii?Q?A3jd9XO6KJ0LZMBKW9m7dp+FTY+FWFzhI3AnWDrmBxHuq7oM+sPzsRwPoBjp?=
 =?us-ascii?Q?SSa72P7MSbFJOxSoywqLvCMwzbOuPw3WIK66jdkr1AkM8IHZGdFT3IddaCzz?=
 =?us-ascii?Q?lOPnBdm95fBa64AIW36krGzPYgCyVwy0cu6Paz8tqsOtabuhxLHtSD7xKKGD?=
 =?us-ascii?Q?Tf6en2OcNm4v57jxM9TuhJninOeHpTB2xuRUisAkmBNXDq4gHbvioheZiuDk?=
 =?us-ascii?Q?Q5lXdeW1wA1d9igazrpKLhAM2/5+lEfCQPiywbmoI+scio7+r2C+kaaCdfrW?=
 =?us-ascii?Q?z7d6akpx2l8E7+l0hXIro0fExXy/0jGp9IrNriuJ/sDNCXfMrS5uhbAgl/vG?=
 =?us-ascii?Q?B6XlzSVLBHis37SHFr+fCnGzjM9AdSbeVdzCdCcxEqSqmPS/HCnnRZfa9NbQ?=
 =?us-ascii?Q?OQFapW2iYuSzLquqX9hvuORRsrBijgDhFHsg0kC/5GnQj/ErbZuG4XBI2PuM?=
 =?us-ascii?Q?eCu1K7KPGzy4SlDcLQgQ1OmOpf3TZjntd07axm3xRSefwk5zi8vBU+lxxzsu?=
 =?us-ascii?Q?ZJv39/nT8m6ZF5cZWgNiUjbq1MwfskPkCrnXZnXyWSaq5dBiChlUQTwPDHlC?=
 =?us-ascii?Q?8p+BAqNRha/UsbtXfZiiIoLtjfRYKttbTKNs1fyllff/qsaLPxsw0uZI6Hmh?=
 =?us-ascii?Q?WNTiAaln5ERyV5T9OLWbPzYI+2dEOpjz6ACUHZLIDFkIp/NLY/KZ2lePgqFV?=
 =?us-ascii?Q?8Rp7yXI/BQ6oLL96cEsRIvR6ag8sUkfzAPrvLueQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2082c57f-1547-4221-8ab5-08ddc0277965
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 03:03:13.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6aq4F4e7RdGdouoqc/YU0zUG4KGRKXTlf7hAGRd3bE6twiSFY/543Bsw3cN9Afr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664

remap(), folio_ref_unfreeze(), lru_add_split_folio() are not related to
splitting unmapped folio operations. Move them out to the caller, so that
__split_unmapped_folio() only splits unmapped folios. This makes
__split_unmapped_folio() reusable.

Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
Based on the prior discussion[1], this patch makes
__split_unmapped_folio() reusable for splitting unmapped folios without
adding a new boolean unmapped parameter to guard mapping related code.

Another potential benefit is that __split_unmapped_folio() could be
called on after-split folios by __folio_split() to perform new split
methods. For example, at deferred split time, unmapped subpages can
scatter arbitrarily within a large folio, neither uniform nor non-uniform
split can maximize after-split folio orders for mapped subpages.
Hopefully, performing __split_unmapped_folio() multiple times can
achieve the optimal split result.

It passed mm selftests.

[1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B54845@nvidia.com/
---

 mm/huge_memory.c | 275 ++++++++++++++++++++++++-----------------------
 1 file changed, 139 insertions(+), 136 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3eb1c34be601..d97145dfa6c8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3396,10 +3396,6 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
  *             order - 1 to new_order).
  * @split_at: in buddy allocator like split, the folio containing @split_at
  *            will be split until its order becomes @new_order.
- * @lock_at: the folio containing @lock_at is left locked for caller.
- * @list: the after split folios will be added to @list if it is not NULL,
- *        otherwise to LRU lists.
- * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
  * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
  * @mapping: @folio->mapping
  * @uniform_split: if the split is uniform or not (buddy allocator like split)
@@ -3425,51 +3421,27 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
  *    @page, which is split in next for loop.
  *
  * After splitting, the caller's folio reference will be transferred to the
- * folio containing @page. The other folios may be freed if they are not mapped.
- *
- * In terms of locking, after splitting,
- * 1. uniform split leaves @page (or the folio contains it) locked;
- * 2. buddy allocator like (non-uniform) split leaves @folio locked.
- *
+ * folio containing @page. The caller needs to unlock and/or free after-split
+ * folios if necessary.
  *
  * For !uniform_split, when -ENOMEM is returned, the original folio might be
  * split. The caller needs to check the input folio.
  */
 static int __split_unmapped_folio(struct folio *folio, int new_order,
-		struct page *split_at, struct page *lock_at,
-		struct list_head *list, pgoff_t end,
-		struct xa_state *xas, struct address_space *mapping,
-		bool uniform_split)
+				  struct page *split_at, struct xa_state *xas,
+				  struct address_space *mapping,
+				  bool uniform_split)
 {
-	struct lruvec *lruvec;
-	struct address_space *swap_cache = NULL;
-	struct folio *origin_folio = folio;
-	struct folio *next_folio = folio_next(folio);
-	struct folio *new_folio;
 	struct folio *next;
 	int order = folio_order(folio);
 	int split_order;
 	int start_order = uniform_split ? new_order : order - 1;
-	int nr_dropped = 0;
 	int ret = 0;
 	bool stop_split = false;
 
-	if (folio_test_swapcache(folio)) {
-		VM_BUG_ON(mapping);
-
-		/* a swapcache folio can only be uniformly split to order-0 */
-		if (!uniform_split || new_order != 0)
-			return -EINVAL;
-
-		swap_cache = swap_address_space(folio->swap);
-		xa_lock(&swap_cache->i_pages);
-	}
-
 	if (folio_test_anon(folio))
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 
-	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-	lruvec = folio_lruvec_lock(folio);
 
 	folio_clear_has_hwpoisoned(folio);
 
@@ -3480,9 +3452,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	for (split_order = start_order;
 	     split_order >= new_order && !stop_split;
 	     split_order--) {
-		int old_order = folio_order(folio);
-		struct folio *release;
 		struct folio *end_folio = folio_next(folio);
+		int old_order = folio_order(folio);
+		struct folio *new_folio;
 
 		/* order-1 anonymous folio is not supported */
 		if (folio_test_anon(folio) && split_order == 1)
@@ -3517,113 +3489,34 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 
 after_split:
 		/*
-		 * Iterate through after-split folios and perform related
-		 * operations. But in buddy allocator like split, the folio
+		 * Iterate through after-split folios and update folio stats.
+		 * But in buddy allocator like split, the folio
 		 * containing the specified page is skipped until its order
 		 * is new_order, since the folio will be worked on in next
 		 * iteration.
 		 */
-		for (release = folio; release != end_folio; release = next) {
-			next = folio_next(release);
+		for (new_folio = folio; new_folio != end_folio; new_folio = next) {
+			next = folio_next(new_folio);
 			/*
-			 * for buddy allocator like split, the folio containing
-			 * page will be split next and should not be released,
-			 * until the folio's order is new_order or stop_split
-			 * is set to true by the above xas_split() failure.
+			 * for buddy allocator like split, new_folio containing
+			 * page could be split again, thus do not change stats
+			 * yet. Wait until new_folio's order is new_order or
+			 * stop_split is set to true by the above xas_split()
+			 * failure.
 			 */
-			if (release == page_folio(split_at)) {
-				folio = release;
+			if (new_folio == page_folio(split_at)) {
+				folio = new_folio;
 				if (split_order != new_order && !stop_split)
 					continue;
 			}
-			if (folio_test_anon(release)) {
-				mod_mthp_stat(folio_order(release),
+			if (folio_test_anon(new_folio)) {
+				mod_mthp_stat(folio_order(new_folio),
 						MTHP_STAT_NR_ANON, 1);
 			}
 
-			/*
-			 * origin_folio should be kept frozon until page cache
-			 * entries are updated with all the other after-split
-			 * folios to prevent others seeing stale page cache
-			 * entries.
-			 */
-			if (release == origin_folio)
-				continue;
-
-			folio_ref_unfreeze(release, 1 +
-					((mapping || swap_cache) ?
-						folio_nr_pages(release) : 0));
-
-			lru_add_split_folio(origin_folio, release, lruvec,
-					list);
-
-			/* Some pages can be beyond EOF: drop them from cache */
-			if (release->index >= end) {
-				if (shmem_mapping(mapping))
-					nr_dropped += folio_nr_pages(release);
-				else if (folio_test_clear_dirty(release))
-					folio_account_cleaned(release,
-						inode_to_wb(mapping->host));
-				__filemap_remove_folio(release, NULL);
-				folio_put_refs(release, folio_nr_pages(release));
-			} else if (mapping) {
-				__xa_store(&mapping->i_pages,
-						release->index, release, 0);
-			} else if (swap_cache) {
-				__xa_store(&swap_cache->i_pages,
-						swap_cache_index(release->swap),
-						release, 0);
-			}
 		}
 	}
 
-	/*
-	 * Unfreeze origin_folio only after all page cache entries, which used
-	 * to point to it, have been updated with new folios. Otherwise,
-	 * a parallel folio_try_get() can grab origin_folio and its caller can
-	 * see stale page cache entries.
-	 */
-	folio_ref_unfreeze(origin_folio, 1 +
-		((mapping || swap_cache) ? folio_nr_pages(origin_folio) : 0));
-
-	unlock_page_lruvec(lruvec);
-
-	if (swap_cache)
-		xa_unlock(&swap_cache->i_pages);
-	if (mapping)
-		xa_unlock(&mapping->i_pages);
-
-	/* Caller disabled irqs, so they are still disabled here */
-	local_irq_enable();
-
-	if (nr_dropped)
-		shmem_uncharge(mapping->host, nr_dropped);
-
-	remap_page(origin_folio, 1 << order,
-			folio_test_anon(origin_folio) ?
-				RMP_USE_SHARED_ZEROPAGE : 0);
-
-	/*
-	 * At this point, folio should contain the specified page.
-	 * For uniform split, it is left for caller to unlock.
-	 * For buddy allocator like split, the first after-split folio is left
-	 * for caller to unlock.
-	 */
-	for (new_folio = origin_folio; new_folio != next_folio; new_folio = next) {
-		next = folio_next(new_folio);
-		if (new_folio == page_folio(lock_at))
-			continue;
-
-		folio_unlock(new_folio);
-		/*
-		 * Subpages may be freed if there wasn't any mapping
-		 * like if add_to_swap() is running on a lru page that
-		 * had its mapping zapped. And freeing these pages
-		 * requires taking the lru_lock so we do the put_page
-		 * of the tail pages after the split is complete.
-		 */
-		free_folio_and_swap_cache(new_folio);
-	}
 	return ret;
 }
 
@@ -3706,11 +3599,14 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
+	struct folio *next_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
 	int order = folio_order(folio);
+	struct folio *new_folio, *next;
 	int extra_pins, ret;
+	int nr_shmem_dropped = 0;
 	pgoff_t end;
 	bool is_hzp;
 
@@ -3833,13 +3729,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 */
 		xas_lock(&xas);
 		xas_reset(&xas);
-		if (xas_load(&xas) != folio)
+		if (xas_load(&xas) != folio) {
+			ret = -EAGAIN;
 			goto fail;
+		}
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
+		struct address_space *swap_cache = NULL;
+		struct lruvec *lruvec;
+
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
@@ -3873,18 +3774,120 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			}
 		}
 
-		ret = __split_unmapped_folio(folio, new_order,
-				split_at, lock_at, list, end, &xas, mapping,
-				uniform_split);
+		if (folio_test_swapcache(folio)) {
+			if (mapping) {
+				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
+				ret = -EINVAL;
+				goto fail;
+			}
+
+			/*
+			 * a swapcache folio can only be uniformly split to
+			 * order-0
+			 */
+			if (!uniform_split || new_order != 0) {
+				ret = -EINVAL;
+				goto fail;
+			}
+
+			swap_cache = swap_address_space(folio->swap);
+			xa_lock(&swap_cache->i_pages);
+		}
+
+		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
+		lruvec = folio_lruvec_lock(folio);
+
+		ret = __split_unmapped_folio(folio, new_order, split_at, &xas,
+					     mapping, uniform_split);
+
+		/*
+		 * Unfreeze after-split folios and put them back to the right
+		 * list. @folio should be kept frozon until page cache entries
+		 * are updated with all the other after-split folios to prevent
+		 * others seeing stale page cache entries.
+		 */
+		for (new_folio = folio_next(folio); new_folio != next_folio;
+		     new_folio = next) {
+			next = folio_next(new_folio);
+
+			folio_ref_unfreeze(
+				new_folio,
+				1 + ((mapping || swap_cache) ?
+					     folio_nr_pages(new_folio) :
+					     0));
+
+			lru_add_split_folio(folio, new_folio, lruvec, list);
+
+			/* Some pages can be beyond EOF: drop them from cache */
+			if (new_folio->index >= end) {
+				if (shmem_mapping(mapping))
+					nr_shmem_dropped +=
+						folio_nr_pages(new_folio);
+				else if (folio_test_clear_dirty(new_folio))
+					folio_account_cleaned(
+						new_folio,
+						inode_to_wb(mapping->host));
+				__filemap_remove_folio(new_folio, NULL);
+				folio_put_refs(new_folio,
+					       folio_nr_pages(new_folio));
+			} else if (mapping) {
+				__xa_store(&mapping->i_pages, new_folio->index,
+					   new_folio, 0);
+			} else if (swap_cache) {
+				__xa_store(&swap_cache->i_pages,
+					   swap_cache_index(new_folio->swap),
+					   new_folio, 0);
+			}
+		}
+		/*
+		 * Unfreeze @folio only after all page cache entries, which
+		 * used to point to it, have been updated with new folios.
+		 * Otherwise, a parallel folio_try_get() can grab origin_folio
+		 * and its caller can see stale page cache entries.
+		 */
+		folio_ref_unfreeze(folio, 1 +
+			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
+
+		unlock_page_lruvec(lruvec);
+
+		if (swap_cache)
+			xa_unlock(&swap_cache->i_pages);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
-fail:
-		if (mapping)
-			xas_unlock(&xas);
-		local_irq_enable();
-		remap_page(folio, folio_nr_pages(folio), 0);
 		ret = -EAGAIN;
 	}
+fail:
+	if (mapping)
+		xas_unlock(&xas);
+
+	local_irq_enable();
+
+	if (nr_shmem_dropped)
+		shmem_uncharge(mapping->host, nr_shmem_dropped);
+
+	remap_page(folio, 1 << order,
+		   !ret && folio_test_anon(folio) ? RMP_USE_SHARED_ZEROPAGE :
+						    0);
+
+	/*
+	 * Unlock all after-split folios except the one containing @lock_at
+	 * page. If @folio is not split, it will be kept locked.
+	 */
+	for (new_folio = folio; new_folio != next_folio; new_folio = next) {
+		next = folio_next(new_folio);
+		if (new_folio == page_folio(lock_at))
+			continue;
+
+		folio_unlock(new_folio);
+		/*
+		 * Subpages may be freed if there wasn't any mapping
+		 * like if add_to_swap() is running on a lru page that
+		 * had its mapping zapped. And freeing these pages
+		 * requires taking the lru_lock so we do the put_page
+		 * of the tail pages after the split is complete.
+		 */
+		free_folio_and_swap_cache(new_folio);
+	}
 
 out_unlock:
 	if (anon_vma) {
-- 
2.47.2


