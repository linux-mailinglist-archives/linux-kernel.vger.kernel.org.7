Return-Path: <linux-kernel+bounces-737278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EFBB0AA3C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3674C1755CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83702E88BB;
	Fri, 18 Jul 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fao+ZwZ2"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D82E7F31
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863878; cv=fail; b=gJyfLwa+3aH6+wj9fnJtU6Op5o28ic/6wxsL1S5+tIDQqUBgseB/UIppGDsWO+oD+Wecjb9ey9tNDqTYwe9yRb8ioVscY0I6fHwo/3N1YH2s1mAfXDtiW2IFrLKIf8mYu7jVvSNGZRjnSKlrRw50kH3XUe6Ra0X/Mg7wvBfUd1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863878; c=relaxed/simple;
	bh=mkcLkrv/jkP/eoWbkDK4dGL+Xxn658ZIOKNa/dYgefc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X72zkF1POeHSWY1gD/LyrvapddU0nvqIST2ADJa25fZn/3FUSF3QpH6P5EtzXjKG7vFv3fseDG+fFTBxnb4jeOEfgN80VH/Izwr2GtnJNRw8g89YE4dUIXHOo7/sWuDWpvCBlb0yTg4SvsllHVGjgvICXCcf15gx4fAmJA1T18U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fao+ZwZ2; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCrnICmzbakS5IcwAerNrZ6ShTcA8tWmjv/lpsZXMBD4GOy6V8uaT/WNsiYPzcMnLY8ukMvOqt6uz/eQMTiR8jL4tO+uRusAL1+CmW8lkshcWiyW5ED5JpzAFx98SrDPBAX/fsrjeBgUHQDGAJzJKYwGsgGRILF0gzON02AMcZv1LpZJ+Vdrn2knGO7tknXqiMKwtLd0uONZj8vv7NPlAY77GaXiDTOcAf3yLrJf1h2hzR0+c7fy+S8Xro35koeqm8Y5XLJbCY3yNGK94Wp4L+rl9hKuSn8+p8Qp1okfhnUYhvmnp523I/z+SfEyn46O3CI/gZZ9hZmcXoQ2S14Ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egPl9g9InP7chuEeEkMYM8eNExLny2cXFxlMLTs/SEI=;
 b=GjFlbTCeeJsz3u2BIlmukIS7CDaS7Zkwt45KSVJdFm5i78Cd1bqJoQQHnZ0kf/KcU8vE0FexhGwZw00sx8DgifCkJgpmPpe4hzgWxAdMAIps8W/H4V/9TNVJi+6XPcVLWuEVgUenAFVtt1rvBJ4Q8iYIrKYwRAKUCi9CX2I38hdVzFmGZYGSJOTmk9KISG3X3DDBMI6KrWMUinIxVcb4JFRzGcZyTZNJbWRwCDN8s9DOK3bc+dsZAOH17sXahwELJkfwjJiZkV4ZyaFkmZBtiphlzp1oH0dWq5Gn4SFAorH5rI/QoAqlnP/+NMw3H3Z0VPhw6VYV0Qgbiwg/hyWgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egPl9g9InP7chuEeEkMYM8eNExLny2cXFxlMLTs/SEI=;
 b=Fao+ZwZ2EoMhp8XBNAC3n3WHM44Q6w7uyD2SEnqZJwyzP0m7RYtEG5GgFXNF1nLmlHhxZYrkLUKaBVCT/bJenEGKqP4x2TmkIZrncktVZwmGiqWHmKFBZGCSzL/jn92QU+/0arpFGS/Rs6HxdvvSlTgEHRRU5d4xjJ5RnD8FbMbo+y/MojO12t2bGHkI33UOGEvmZu06HjtKp+vEao7Lc7+0qvSwLLJDnaIlTiD0YwE8Rrgn/cJ//nIcr3RoiLZ6e566XnmH1kG7q4+xXoz4TM7+VjN71UMocAfXZcqMjqqx6saIAbvboYTYKlogjsfQZ7b6zyFxJawiBTe+O2kIkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.39; Fri, 18 Jul 2025 18:37:50 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 18:37:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Hugh Dickins <hughd@google.com>,
	Kirill Shutemov <k.shutemov@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] mm/huge_memory: move unrelated code out of __split_unmapped_folio()
Date: Fri, 18 Jul 2025 14:37:15 -0400
Message-ID: <20250718183720.4054515-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718183720.4054515-1-ziy@nvidia.com>
References: <20250718183720.4054515-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:208:234::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 816d8c4a-49f6-48f7-6376-08ddc62a3301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nRstsZ4L/Db/IeRX52SvK9Ue08Yb2mfqiHRe9eA3Sm+CYIfbicXMVC/yUvXA?=
 =?us-ascii?Q?fJDwXODlbB65N86wQHv+rjKbMlILut/8xSTFJk3jgIhrVlXQT3lo6rSKyeiE?=
 =?us-ascii?Q?G5K+1Nq4F0DaKKM/xUucQiVR0jPz3IfAPdgQO0ZYti9nlxjnWTmroqdUz5zM?=
 =?us-ascii?Q?7UtXNrrqeiUjz4QXuVQbCDkbJuLL0IXwsv8njnKbylyVEMfwYBxQi13xU8SV?=
 =?us-ascii?Q?TDP1umZaoIMXyBpPMu2orXL3yIoEJKDjYoGbJrRijJG0bee17Y+SbWKC2zfN?=
 =?us-ascii?Q?rsbjvqi9lxDTukDEQLUL9Q10ZcaIhir9ajD1VRahPVRXlEgfhVMBFzMUvEFQ?=
 =?us-ascii?Q?BiUVpcf9BLA+YAOjpeGCBQO1NLMKoQDytkLAyg5Lk+YraSJaJx0XRZtNDbB7?=
 =?us-ascii?Q?i9OfGnx3L80v5+/P+Tj21pJfP+884IH4XluhBud4rOqQNfOi8k83N08a6XWk?=
 =?us-ascii?Q?7F5sWvn6GxnSN+hxslwqUW5lU52xrb/q7Ol2xLqDxs8TR4mefOdSeCgOokCO?=
 =?us-ascii?Q?WECXcWyRm1bWABDD7AxkSnZjn7AHf46X6uXsqDCQsYje18Z6G64B+wI6XOQe?=
 =?us-ascii?Q?2R+5gn45aXWNzuF/WMB3iG4/BcQ4xbxythdtAG/ynhc6plMrtb5mnaRkb2AH?=
 =?us-ascii?Q?QL9lc5rq3PT8UA4ukc0f/s3Ca8cqbv5xvh3OEW9LTHUm7BVbfcM0DyaRPIxi?=
 =?us-ascii?Q?ltXK3aXGN0JP6Mki3Jh2hhJk/5Pl+kRQeDNvBMIvZNOi0jIiYnWhAMdlNteP?=
 =?us-ascii?Q?L8YBKC3m7Xl4SDRSqDUAPTtPW1SsfCO/OnovMzfmrVeBA48ahdYGCUMDC+LO?=
 =?us-ascii?Q?Pgv+ckeOhvQy8jc8VT0LYC6dcvEh9xt2m1vdS4ytNI0ROG+gfdMuI/z7VH0g?=
 =?us-ascii?Q?4cb3CftqIWfNtFNCgy76Xohw6m+DXRYVADnHtAqcBwaEmso1zEqYs2O9KJVf?=
 =?us-ascii?Q?HZ4g5PLV4GDVZySobXiAmOt2vHno2gGxCKsgu4KFAhlhsXeKoCkJYrPd8w3R?=
 =?us-ascii?Q?G/hAOy0HOdW/sCVFG8tV8PmI5YJnbtsA7uIkASc8TKoF8FapqUlCfNBVqBAc?=
 =?us-ascii?Q?yyaZdrckNmai4zizsFZrl4mEwy+dYs3xGvMBGZmoYyS0rwPuyO6uJQhFSZPi?=
 =?us-ascii?Q?IRJ22XcDK8zRQEa72Wm13nPGhOOCqSp7eETisT9JMpK4lRtTj+WRCAWDacbq?=
 =?us-ascii?Q?07C4FRGKLc6La3KGJsIT1uG9tPmeqqnwKPinWwd2P9eWglGyHuP22Hgt/omf?=
 =?us-ascii?Q?yrYXrJ0ESYDZ/I/07KUEDTe8mMIwwUV5MNJTozjn3ArdGplKLn5MH2r1s3lY?=
 =?us-ascii?Q?PaThFKINglaEjlZ/N+IAuQauJqp15Tu21AmGVMbpSwgy6cRxgpqieAquVCOI?=
 =?us-ascii?Q?lKIh66WcembpuvVCL3T18bLFGUt+RsWD0WjBb6pEYmW2OcwWa38zwKnGSaSv?=
 =?us-ascii?Q?FZx7pr2SnAk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cD2Fq300Ryemb5a7WEbyuIslb2kYcyyljWmfXMBIwg6Rr6kPYv5LoAsQeYO3?=
 =?us-ascii?Q?TH0qWU3JT8VYK6MGdfyhDlWFjd7JHP078BV9jb+xvDTHBe7xstB8w0WPDPIh?=
 =?us-ascii?Q?iTLossGx4D03mSfJObbrta0soWllYpkA4SFF+3pkgi5FQiYOjV91mqC/Te7k?=
 =?us-ascii?Q?8eM79ZLMRe4IT9fe/DwOSkpVC79U65yo4EE9WJMIRmd3uIxyXRVGJ6WN6m6n?=
 =?us-ascii?Q?tSGPMEv6gMuGfmiJWeBHm/DWx3peD2uhi3VfVU421b7USevUCe2HkSk0fpZ1?=
 =?us-ascii?Q?fePinNygtkatmxkeNrjSBUrdKoQi9K7yWugESbeG0p7Yo007I6LxUKQJ4a/w?=
 =?us-ascii?Q?/n9KErwAkiv6/vS41yNDe/skQN3AZQ+Q0h5mOLF++ey+MxGpI3O/nm2Xvoga?=
 =?us-ascii?Q?3lB1v5x++PaeFuxC4TBUXV3PF/I2e9vr84l2bfjImh1C5uC/zapNIUmhg3VW?=
 =?us-ascii?Q?YUPP4jKWwazVaHhWnK7vMC0n7kDRIiLc9hdfGCJRPsNytIky80D2h3+lDriq?=
 =?us-ascii?Q?RtF3kT4koITW2lKPk9re0rB5KLulIgmB/UbTUikv3ImWE9cRFejjBvRm+USm?=
 =?us-ascii?Q?99AcNPgnoeJxzP6yOuzhSE5/2iqQTZHcCI39wb/Rh9tgeCe0Q3THK1lfLIdP?=
 =?us-ascii?Q?JUe4s/N4PwFd5zt+Z9FgUCZeg1XiMH6J6CGt8J7DsdzuQZPeHBWDQ6kU6VVf?=
 =?us-ascii?Q?fT8sAwLmw1VpY79LPWuyVd3wG5X+6UaCD/bg8fXy9J7HtCviQsrdUvnQRnA2?=
 =?us-ascii?Q?BVxr62jTvHePvOK3KOz4c6/BSQ+hG7smCThYI+SFWKFM2rXV1EnptwcEkF6V?=
 =?us-ascii?Q?mPTZE+VVmXxv01CTp8V8g+no09Al9jigZzCM5CAjWLkexHAQ2tx0xgE84yo7?=
 =?us-ascii?Q?+w6i+rj46041HeCF6tU93nIBWImhPYgnXT9ZtFT9RH0W04Lr51/duIzIjbYa?=
 =?us-ascii?Q?wWJOE+n27D5dAIOXvQQOPeTN9R/R3wkKgbOSkPdvpmzaMQ0wt4j56vRUDnbE?=
 =?us-ascii?Q?H0nNGAi8gFYgVERjNj00y8gcKLlVSnYWMNn6Ejru4YycS26KiAzMxzDvC0o7?=
 =?us-ascii?Q?uqM6VBtEWiomqLnCSOOku+MJx5yVNfV5ddXgZkPjTbSwVpsF1+FuQAsrHqHu?=
 =?us-ascii?Q?OWg8CZgHHTJmuiTEAWdTPCAda7kNiXFqR+gZB2l/7wCNFurPgupg3Bt+ZI5y?=
 =?us-ascii?Q?e6h7MofBTAFOkbOeXuPPaV6RD+UjJB4ayA9y1MHNV6e8S1ZI7yC/g3ydvHV/?=
 =?us-ascii?Q?EzY/zBgwCKnOGVmP7pWFO+UvN8Xrq8sQR51+GZmw2DhSjvhlZmwlgBJi6Twg?=
 =?us-ascii?Q?kZQUHhLJ+ynzZvjVk7yOJAcoIsNYs8+l9HH5K084uhiCKQgn3WVacc1YmX0I?=
 =?us-ascii?Q?arXMEqmWONJ7oMd7oovl4TwYO9Nu4n5NkzxTiUG6aSuyAi2E+8DYTN6SG6K6?=
 =?us-ascii?Q?Bq/vG2SWYPBnZAa5GihNXMMKzF1ZyzrZoA8G8S9GqBJ0aZBDMrhKSN+NfPAP?=
 =?us-ascii?Q?yVAYiXv4F99L3U4E2JW2sjrazDHFGtiHrNb7z0kN6qQ7ziVh0tgz9CAH7Jt0?=
 =?us-ascii?Q?wya+L0+CfQWx/8n2l8WKZamxnn9N3IV7o5VRWWxT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816d8c4a-49f6-48f7-6376-08ddc62a3301
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:37:50.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxvtOjjBb6YbQNJkY+TMtHVzAU5V9XAl2CyfwO282ami2B0+02chdbuEjL7t90cY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
splitting unmapped folio operations. Move them out to __folio_split() so
that __split_unmapped_folio() only handles unmapped folio splits. This
makes __split_unmapped_folio() reusable.

Remove the swapcache folio split check code before __split_unmapped_folio()
call, since it is already checked at the beginning of __folio_split() in
uniform_split_supported() and non_uniform_split_supported().

Along with the code move, there are some variable renames:

1. release is renamed to new_folio,
2. origin_folio is now folio, since __folio_split() has folio pointing to
   the original folio already.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 270 +++++++++++++++++++++++------------------------
 1 file changed, 133 insertions(+), 137 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ce130225a8e5..63eebca07628 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3385,10 +3385,6 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
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
@@ -3414,52 +3410,26 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
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
+		struct page *split_at, struct xa_state *xas,
+		struct address_space *mapping, bool uniform_split)
 {
-	struct lruvec *lruvec;
-	struct address_space *swap_cache = NULL;
-	struct folio *origin_folio = folio;
-	struct folio *next_folio = folio_next(folio);
-	struct folio *new_folio;
-	struct folio *next;
 	int order = folio_order(folio);
-	int split_order;
 	int start_order = uniform_split ? new_order : order - 1;
-	int nr_dropped = 0;
-	int ret = 0;
 	bool stop_split = false;
-
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
+	struct folio *next;
+	int split_order;
+	int ret = 0;
 
 	if (folio_test_anon(folio))
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 
-	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-	lruvec = folio_lruvec_lock(folio);
-
 	folio_clear_has_hwpoisoned(folio);
 
 	/*
@@ -3469,9 +3439,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
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
@@ -3506,113 +3476,32 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 
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
+			 * @split_at page could be split again, thus do not
+			 * change stats yet. Wait until new_folio's order is
+			 * @new_order or stop_split is set to true by the above
+			 * xas_split() failure.
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
-						MTHP_STAT_NR_ANON, 1);
-			}
-
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
+			if (folio_test_anon(new_folio))
+				mod_mthp_stat(folio_order(new_folio),
+					      MTHP_STAT_NR_ANON, 1);
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
 
@@ -3686,6 +3575,11 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
  * It is in charge of checking whether the split is supported or not and
  * preparing @folio for __split_unmapped_folio().
  *
+ * After splitting, the after-split folio containing @lock_at remains locked
+ * and others are unlocked:
+ * 1. for uniform split, @lock_at points to one of @folio's subpages;
+ * 2. for buddy allocator like (non-uniform) split, @lock_at points to @folio.
+ *
  * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
  * split but not to @new_order, the caller needs to check)
  */
@@ -3695,10 +3589,12 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
+	struct folio *end_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
 	int order = folio_order(folio);
+	struct folio *new_folio, *next;
 	int extra_pins, ret;
 	pgoff_t end;
 	bool is_hzp;
@@ -3829,6 +3725,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
+		struct address_space *swap_cache = NULL;
+		int nr_dropped = 0;
+		struct lruvec *lruvec;
+
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
@@ -3862,9 +3762,105 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			}
 		}
 
-		ret = __split_unmapped_folio(folio, new_order,
-				split_at, lock_at, list, end, &xas, mapping,
-				uniform_split);
+		if (folio_test_swapcache(folio)) {
+			VM_BUG_ON(mapping);
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
+		 * list. @folio should be kept frozon until page cache
+		 * entries are updated with all the other after-split folios
+		 * to prevent others seeing stale page cache entries.
+		 * As a result, new_folio starts from the next folio of
+		 * @folio.
+		 */
+		for (new_folio = folio_next(folio); new_folio != end_folio;
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
+					nr_dropped += folio_nr_pages(new_folio);
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
+		 * Otherwise, a parallel folio_try_get() can grab @folio
+		 * and its caller can see stale page cache entries.
+		 */
+		folio_ref_unfreeze(folio, 1 +
+			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
+
+		unlock_page_lruvec(lruvec);
+
+		if (swap_cache)
+			xa_unlock(&swap_cache->i_pages);
+		if (mapping)
+			xas_unlock(&xas);
+
+		local_irq_enable();
+
+		if (nr_dropped)
+			shmem_uncharge(mapping->host, nr_dropped);
+
+		remap_page(folio, 1 << order,
+			   !ret && folio_test_anon(folio) ?
+				   RMP_USE_SHARED_ZEROPAGE :
+				   0);
+
+		/*
+		 * Unlock all after-split folios except the one containing
+		 * @lock_at page. If @folio is not split, it will be kept locked.
+		 */
+		for (new_folio = folio; new_folio != end_folio;
+		     new_folio = next) {
+			next = folio_next(new_folio);
+			if (new_folio == page_folio(lock_at))
+				continue;
+
+			folio_unlock(new_folio);
+			/*
+			 * Subpages may be freed if there wasn't any mapping
+			 * like if add_to_swap() is running on a lru page that
+			 * had its mapping zapped. And freeing these pages
+			 * requires taking the lru_lock so we do the put_page
+			 * of the tail pages after the split is complete.
+			 */
+			free_folio_and_swap_cache(new_folio);
+		}
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
-- 
2.47.2


