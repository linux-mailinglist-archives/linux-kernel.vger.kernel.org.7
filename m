Return-Path: <linux-kernel+bounces-728087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4833B02391
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783EE3A3A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECDA2F3C0E;
	Fri, 11 Jul 2025 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YtQUq5jg"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629142F3626
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258245; cv=fail; b=XqTfX5NCmZdvhAk6Xf7ZZUlpHi/JkzgjIhsDNsbYomy7OII1xwbwrHu8iSo4dZDkGEPMg1BgXLrJghQ9q2mClFPXh4o7r60Mi349A0u3FPhBr26qMhXwTLIwZvrdAVt7DzN6MptmdX/plv7cD7p7XoeyXGeXOjMp9ia79QxLWkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258245; c=relaxed/simple;
	bh=9MDJAgTLM0w56yeQulLQLIEwCmgMQEfCrMmX3g2rI/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7CiunKIL0YPOzCDkAQJwGdHcpTTbHautkAIXYhLJAPVsW7K0gMhP8zxLSRezMiilavssTem/oMU/Ak/l0hSMhHJba7LuMzx33yy1uqlw7ZEBQOklev07sBlnjFsbKBBBlbG1hRD0+6FGyW4bpwSiQVrmhUuALgxhy89i20yx+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YtQUq5jg; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3DEygysrdpcJdGbqT0x/62V/Zhiv7CMAdBoo3MD+6SFKgbtKzzzl2PSpZJ/+DSULBcBZILnIIzUYUzzcqAVe7AhRSQ+K8C2wcUqdGrpKW0gJ1WF6FziN1gqb1uIlnX9d43Df224t0E4qH0YMPilOpiVs+HT56NVA5cEisbSaXnfHZpioNn2lXSKNCSYFAS1yZGdQ1VSQQFmSyGFD4bCMzYSf0FfZIm5YaI2J5mWXILLCMTz2vTXdJmm2ic2S9fG9v4JCX564MXS9OIWMxAj2/BKtNeFfaN9E/b141Gjex/IDQhwZUGVlUKROrjoB9Jt6G26BXKv5l4blStThkDnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGnCv3ktad15mv+kb9Ocrbj3h3Td/GQT/iWaRDQCLRE=;
 b=xmBlONtVB5t5GraSwTvHrA+7mN2Ye5gGnyWfqpY8oA2FQXy0/Vzqy1tLWnK7zRWyV/e3CaQ96s3TetSkc465qaccOX/Q8odfaJ2H57Tz91/wPsJvkCrGC4gX9l2keD15S4RJVLjltb/NHhMnOa/cvHLlNgesNlesM2a4e2tvlk3XESpNYXkM+3dUTQ8FVe9zgXyx3+ug07i4vZah+wOzrtcu0q+Ts1hORt6RiLd4Oc77MS2S4mg82P7curmxNLqO4xyLFCjm91vPSBcYBDoQU/MixHbKcgWCK7RmuTSbUaHSfCri09+EqZlsLbXF4KnwsJw5DpR/S0uqHeP0pnaAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGnCv3ktad15mv+kb9Ocrbj3h3Td/GQT/iWaRDQCLRE=;
 b=YtQUq5jgfoWBkTeIGlGcHDvgQ1Cdz3n/i2x0hOZdgmE00Ty1wwDHCt37RQCSmmwiLjWGDCWyrWIfjiAmuzy6TGlEhUwmkTUQu0c/hGRcyNujurJpn6hsPIntQ/1TkiV5knFL+KfkIOsrqTJ0Kblk/hX23VucDFgBSDoFHSAQZ8h+lqwLDTviIwAhEn2XxSd7TZk16W53HsWix4ZDSeXObZrM+5HeE9ysNPpHW2GH0C2QVkEHDnqn5eTqKdrCdLNuA723NfN/Dg8MDEOmu+vbhRVi4vGPtN5bGOkS1udBdGjstcv2Le8ueZGntI5SCd0Saebbi7hiY4bhQy8IdQBkwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.25; Fri, 11 Jul 2025 18:24:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 18:24:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: Balbir Singh <balbirs@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Kirill Shutemov <k.shutemov@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/huge_memory: move unrelated code out of __split_unmapped_folio()
Date: Fri, 11 Jul 2025 14:23:54 -0400
Message-ID: <20250711182355.3592618-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250711182355.3592618-1-ziy@nvidia.com>
References: <20250711182355.3592618-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 06517d7c-37c8-4682-a05b-08ddc0a81b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fjFWStd0VVycNOfbXQAsVuznjY1dLfB9z3udpCX5i+3fZowD7HhYIHMSf1hc?=
 =?us-ascii?Q?NuK7/QBqyZNiQgKfuQFZRt95EoVVZF0R0YgIi5/MJttYqGrYMjAgr6chSVgn?=
 =?us-ascii?Q?aMeiLSXlGF7XQqC47yZ3rCrXtl5OZ9Mb8Q0xnBrug2GONFaXrvu4xuvyl3sL?=
 =?us-ascii?Q?oQU6rqJ75LQpaKpNAkGlZEE/g9SpI616cRdYu+j/6DHPttHlHll2QBQQdzap?=
 =?us-ascii?Q?aHtX06XL2ZnxRMGHwBQKqYdcnHNYzZxkfLDnhuAtcCJZiBsO+sLYok8rjpOX?=
 =?us-ascii?Q?Nr9y6ZbyCFBU+PxLrREoFpCAGM+wB4CKKldvwWEuXn2mhPCWKozwk/mr03JU?=
 =?us-ascii?Q?QEAbsNZxcDfNAQ4T5F6GCu7r/YwUiPCW2bVn05hqg+mf143FcsyZeBuTT6Bm?=
 =?us-ascii?Q?E/NNpTo1BQsIBCi7VpxVHvv+2UjVSgQQEEZX9e5Mrn32D/gfWkWFJ0SkAHwS?=
 =?us-ascii?Q?FrYsBUmb2IerxgLuD0IThuTurt96CPYPTfmNg+6HlMHfwNDNtCLUaqTeA1x1?=
 =?us-ascii?Q?NRkZY1gagSKSmx9OUiS6kUZGxDRidb9cU+roCpZjgdH8jz16iz45qUjm6qPh?=
 =?us-ascii?Q?x659mpUsjVBluX2fKgIelIsGHM6m2mDWw+APQH+M01NqnwzJpXZT+Nj5HqEL?=
 =?us-ascii?Q?UdS4ULavxJHMbwDsJbX5XDo1SZ0/oTAPfdXHJx1X0YSC2D5GHrtVuTtqGvuc?=
 =?us-ascii?Q?ZiXGzQVnj3Momz2P+w4BBGMynT5/0BkoTke+7aJZ8VUvxuW64kvQUQvbjNuh?=
 =?us-ascii?Q?GXqPP4YLoH5A7oHwghxsnH/MuT8xhY9j9ZWnwU2HEwvEZb0EtlZ6cbamXhxe?=
 =?us-ascii?Q?sVRl1XLhF+u2FjzG8iwCA11dmAVYNKu0u0BmffHCOGrsVU9iU9U+RyzI+aM4?=
 =?us-ascii?Q?8bYRmShejYlOnAXCl6VQ02kr2wqY88VB8wLHlu+d+NFjtutMXTfrDst223wo?=
 =?us-ascii?Q?0VOiillzuzSIr4N3cU+gQ+AwbnLouQQPd9YeVITRlcDB/9myIAtwJfxz5LRB?=
 =?us-ascii?Q?PmwT3lbae28NwzJ6Iv5eQajVXxRbsduxWdr0dpCJE4w+XyFJe79xUlQeSqzj?=
 =?us-ascii?Q?bSOOU9JzOQafK6CjTSVglOwYLYkzQyd5pruzIgB5oNP+lkNukU71LbGiOm4/?=
 =?us-ascii?Q?8M8db3amIUI0wZyGt9LD1y4O44ckRiG+He4KizKqWd3Y+S74JcuqPgzruBLU?=
 =?us-ascii?Q?URzy6hcoVmFFgHkDeJtw/I/PDltBBlqhqu8z3mJ2ukQxr3n2skwIeXd54y4I?=
 =?us-ascii?Q?IR+9qx8MTDfBqsJw6TCm8DQvSUVPFnNlCNvhXp8kk/mI9XxKpN7HO/B0mjW0?=
 =?us-ascii?Q?e8CWba2clI7cVGuYjr6O9CZ9SEKgnpWWH0ylVtSr/vbA+QwDaB9+8dnX+qkg?=
 =?us-ascii?Q?DxEiyDy4PyzC5ICo+CHvgAPt8mQtIjNY6CMREUs2cAj7fe2E3hY5O7pca6AR?=
 =?us-ascii?Q?VRLtkw9pmsU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?66w6R0bEC3rQcuzXVEet+Pwr8L0I4iNX2UqHtDI23NZj845cNGc4rBV3x7AA?=
 =?us-ascii?Q?WYN/Y7lwGBMvVNtAEk8oWlSrziAyC6FgnUD1bYAhnuWsf/o+A5f2O6mOAr8a?=
 =?us-ascii?Q?SCTCgxNJAdHS7DhAiPajXISfpkVvutAS2EfR9B+ysGJMfLOByHVhGLKDNPgn?=
 =?us-ascii?Q?F35B/wsHV5ljfcd3bffXXBcGp4oZySzucH6jC4iFJ2/UEG+8CHoeGNwwkJu4?=
 =?us-ascii?Q?/sJZhHWEkuZkmaancyEqf1H9f7Ezvm4PjYKUVhAwhel+7yblUGvRYcYw8y3u?=
 =?us-ascii?Q?+EVtR2Tn3saB3j6R9ZReEtyoSFup3gFl8c7DT1IgU4Pb2NKcRzK1jAlmuemI?=
 =?us-ascii?Q?yCYAdFOxKfmHGutYPmX73RHhOJfUYBkB0s3dCN+s4Pn5HWa29VCImiwmgmcP?=
 =?us-ascii?Q?2wd2eUynTZu01pDtBKju1o0rRTF8FPCz2nVMgI07gU1I6/IJga1U/aDARvwL?=
 =?us-ascii?Q?T2i8/DzSleAqi+Z998tVHw+bWgqVHhcZ766p/IzcPvu2LJ1vpG131sQ+bZsi?=
 =?us-ascii?Q?E6vWxcCjhMc3K1ZF8GJ0Ddlsc4DKf5jnQppO2jXgItAV/BF/4KOWwOulF4Uw?=
 =?us-ascii?Q?HcykLn0zAtDfduBgJ3rGTLfArp+WBi2HbrD+LqEY6LGE8W6l4ktwzSDGivsg?=
 =?us-ascii?Q?SQwdWCC1CFDq2VEYF70WAgHLqFAkHI2SOuHIEF/Y4V5w6nReuWckVoYV/2Nj?=
 =?us-ascii?Q?1Lkf1if7WRE+Eb6dCbM7asqvuQu+059d29Y9Wi/5Cis/X++8Awijjju7Aedl?=
 =?us-ascii?Q?BZ7cqUGd7GxCs/NpQcY8RkrEvw6vbzOeKtldAinVKR9NA5owdAN84uqmJvDH?=
 =?us-ascii?Q?QdDBbd+MgnZbz8lMEz5C7jWYCZVVVogNbBlmOiTNHucR1aD7pKEOx61oX8Yy?=
 =?us-ascii?Q?DWWWzQyKIGNKUzEpyf2sRQweqM6PTpXxdgJc7vtx99/5iWS9wLIWDucDRtiQ?=
 =?us-ascii?Q?JkK8lfjj40gRjwCdMw0wvZekFRP2/UsWWi+wSOiDrzUZJYgBX16sujd9BgGk?=
 =?us-ascii?Q?ATecTgDO3+8gan7QcCH2FUwP1/8TNTh6flKq57NyYtBbmuXkuAzuBzJWxosq?=
 =?us-ascii?Q?Gd/nABATcOWNfE8gn3FZ2mVLB7SSYlcFXyEsWKxTcdrl1109v8wlf8851k9N?=
 =?us-ascii?Q?kKTSfZRgqJYX1ckWt4khvaTBsnLBUyGj0bnsoRc7qDufvxxm3dddVaNMGF+9?=
 =?us-ascii?Q?yp4jDxmWoYDtgQorY1Q13TqAk+QfGDw02X4S6kLI5uT4Hd284MefEMpafQ7t?=
 =?us-ascii?Q?O3kQhFuJgcMm8oHmkWYR1RdhIuOW1qo81/uWP8Px6tYdvCyK3KHJrCOvmOGg?=
 =?us-ascii?Q?AMYOjNwajB/Cl3ymRBPh3toD1gQKgdSMLMmY2DGxqFHko5DXUhevAacj+8Wr?=
 =?us-ascii?Q?2Vmgl+SVVbmyDtKYc0KRRbyMSaVX/QDufZUPWIxVL4MAgpxZt/vcQQ+sBeAD?=
 =?us-ascii?Q?PxVC9WagA7UxMbt99OeKsw/1JmzTafiCvb8TX6IdJjHNNV5lnYBqpiMgb/1E?=
 =?us-ascii?Q?mH7fOE0SN89sYZw53sZqrJ3GD+FvEfOuLhhkkI2KzSrx8l8DVpKyC0rhjLhS?=
 =?us-ascii?Q?dvMRHfg+grN2qNNJkxEyJJ/OGVIE2Cs6MfeuICXR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06517d7c-37c8-4682-a05b-08ddc0a81b3d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 18:24:00.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fuK+jOoQnlHB51WYVSJk2bxCIrcMzUqwuaFlYrUZb2wMl7/eocT9erlPShwLNr8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016

remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
splitting unmapped folio operations. Move them out to the caller so that
__split_unmapped_folio() only handles unmapped folio splits. This makes
__split_unmapped_folio() reusable.

Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 273 ++++++++++++++++++++++++-----------------------
 1 file changed, 137 insertions(+), 136 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3eb1c34be601..818a6bd9f0d4 100644
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
@@ -3425,51 +3421,26 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
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
 
@@ -3480,9 +3451,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
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
@@ -3517,113 +3488,34 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 
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
 
@@ -3706,10 +3598,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
+	struct folio *next_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
 	int order = folio_order(folio);
+	struct folio *new_folio, *next;
+	int nr_shmem_dropped = 0;
 	int extra_pins, ret;
 	pgoff_t end;
 	bool is_hzp;
@@ -3833,13 +3728,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
@@ -3873,18 +3773,119 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
+					nr_shmem_dropped += folio_nr_pages(new_folio);
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


