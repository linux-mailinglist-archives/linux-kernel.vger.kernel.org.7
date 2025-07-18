Return-Path: <linux-kernel+bounces-736179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA63B099C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4BF4E83EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3656F1922DD;
	Fri, 18 Jul 2025 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hrXikbZA"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26F1BD01F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805816; cv=fail; b=IhDlMadOLzPIIXyBW2SlnVbNMqd9Edb6GXjyXx31S4NBj2V4kf0pgU57tBL3T93cOKOWsemCoahTRmH9yRo0bDfcYzqy9s73jQqNpl/3lf7VsHkp0T4OxFShyQW3M+LJykIGlYmManYAaEpdwvfDmKNx7RN9y/E7ay6m8TAtehE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805816; c=relaxed/simple;
	bh=uUOfqsBXLrpg3PLRoeM2u1AR7ZBedex6AWOaBPB0Rnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kZ/q7T3vcd3HT1Ljz09D9v8wxKpQKkbu2Fx6c9dc/GGOi/MAF62hElUhs8If6QzAU6IQRxN51N5uiNR0qV9T0MYwkuyfKZfTXVJ9KUlOhbikp0oR333rfFH7ynpdq/gR10Jms8QuuP8gsJhf0qOaFAj8P5RmafFS2SmJ0MVSLns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hrXikbZA; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lbfe0TTjQiKH8ILuBEkhLe7Icd9n1q/0KPPEbajYPuT5e499ST5XjrHTNSleWoE1YOaTiSy29tDmqt91Gu2et+4QnQYoR1n4SK0O4isjntHqOczITnU4PWH/DwVKrYAgrOvhsjrd0XCtWnyTIlGIBzF2VWzQ2BtYAWPLcI3fNVxxtW8u2HV4JbJIOikWzEra25xdMbub4q1K1Ggh4RYmsZ6OovW5DK/sRx54B8K5hQhQ09K8kDgKUCihnt6Oz0sjnS/d7zD4iZV6bVGuu/mufhiCJ3uOeT8fK+JCEgz/UL+yMoU0lTYy4lagfINbKj2uxB0CbW1mmC1Jgyshgne/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xjun7XvdLoafkm/qATsHjnvpS3DLiaaE2BVgzS2Giqc=;
 b=NXTY4AZ0euAfecQiwxqu4PnrgNRb8Oatv0JZtJXeghza1Oj9MRH56SV+bmCw7LaqLrGRBCCQSaxQglfUd6j8Tb4mnMvCOw4w7GP2+1vKMVzd6Rp+eN9Ep81mhVvYVJfXKhZ9FxpuC4KGTXqfGCb9RWd1bN3MlibiJ2wJcExrrxCRo2dCb5GcOc/Yx/nYVqjyFImFtfulqU9L/I69V8GVzPh6/NlmsRbVOBWV2fUu5fzHwZrHIJ8KNBPtDoaX1uFO/OPLOnjDI1DvT157v6TmLL53mhJ763vkjOpGkzMBDxo01jx1zI+8tO7UDgCcxEgYJd9WHJB7tWEg+B+rklVE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xjun7XvdLoafkm/qATsHjnvpS3DLiaaE2BVgzS2Giqc=;
 b=hrXikbZAHkfaxw7Bv4WjbyGQFwPBAzNSa13jAb3i3Bsq+TMKZqgbDkMOFNtCr5BE7DmTApVQLV4/s8CSWgkhy7xXc7ImL2PFdhIAqtYNK9vWI3/j8ZLjscRV7NrjPpb11hptS2H96WEHe5mjErO1MO6jbvTS2ZDvTuM7fT0BfS1ia4mROX58INuwA5Uyc96P6Dz8gLOINm5G9rsidkR1zLNmAXophbKNgTd5Md4/oapCuzokiyMmCgvJDZDmKFf40rwxObVrOMhFNw1ORcOpVbGMPcFWxZ+E60WfA9pT8+ZlFb9FAqDafsmqT6RnPqMRV4erPWxDE3EoVHtH2HQkVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 02:30:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 02:30:10 +0000
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
Subject: [PATCH v4 1/6] mm/huge_memory: move unrelated code out of __split_unmapped_folio()
Date: Thu, 17 Jul 2025 22:29:55 -0400
Message-ID: <20250718023000.4044406-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718023000.4044406-1-ziy@nvidia.com>
References: <20250718023000.4044406-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:208:238::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 05af4313-0d72-455f-6e82-08ddc5a30485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H2uTUKNxl6C88x8dUlDKScDKiSDLYdNY/PrPIL9S/6wnLEervKPQAvyC6lTx?=
 =?us-ascii?Q?rG5v3YcmavZZynXXZ9KHSHHThLqmHwzQ9KppUNS9VGMf2b/DgVmNoQkDLCsb?=
 =?us-ascii?Q?+YFwOnTPAztOCzTjigaNgECOymLQw3AaBlr5L6ir4Scpc5h6lseDx9M2fsu7?=
 =?us-ascii?Q?wtpBo8GBJ9paOjAZMkUxz9B6ZvBIaynWVovIpfrDDDSQOiPuCsfQO6lOx8wU?=
 =?us-ascii?Q?mYmf4ttiHirSQp6C3pAJGDAxjw2AGU3m2gQLRCPBGbRrGWEEZfdJyGT97SOY?=
 =?us-ascii?Q?kmM2sKIw1Q+NnTxh4Vuk1EljZ93Dkw2B4E5R7c3SRz1Xi7A2mv38PDdvSzVD?=
 =?us-ascii?Q?l32LH2MvQ7AAtr0Iyw/ZcXnYrS3IzPni+b0t8/eWa8AJ7syDrhMvJgfXKhQd?=
 =?us-ascii?Q?n2JQWpg4x368T9aEA98FU3odEHBjlDAQf4xZd+NwkXysqSy4h9vJGTCoaozZ?=
 =?us-ascii?Q?pm0PZnXmCj0C/01hw4tMM0wW8SY2qusR6Wfcba3suu8viaS0iT0Sxc/HRXKQ?=
 =?us-ascii?Q?jMP3/wgI/+htSEfFx+/1j6pWXNO9kGjNEvS2XYRoJ0+3obnkpjbvBREPU97X?=
 =?us-ascii?Q?SFuAYBdudvTR00hBckgEbX2H5T5KvfL9uxV8c2zRSRm8Whao3GgLY7vx5JX0?=
 =?us-ascii?Q?9joOzMv9v12SOcjW+YWd5WM5uT0OIJq2/9OdRGBRjwbMaYw20YVWekf2+Mor?=
 =?us-ascii?Q?q9iJtOT+5yfmkSHcYb1DKwrlQSYWx3A5+CGKISi7ShLfbjoFGrK6emxpjmo8?=
 =?us-ascii?Q?05brT5/7LgHYvuA7Z6ydmxb+Z7S60WOtuepm4eY/ciKqV/GSbfP2x/UEeCdK?=
 =?us-ascii?Q?I6KD/57n1h26R/HaQBsy6U1Jp0yD6KeKWysRhauyCH38jIbSFixMkn/BAsgm?=
 =?us-ascii?Q?BvaV3WNVDmMUqKAEL+Rl6Q7se/8sHYEVUvWMc0U9q8UQPUXGquuWXf5TAANP?=
 =?us-ascii?Q?VCXP0AOBnMw7cr+goUjTOXLWpAAsazRaC4Oebnn28pCXU+sx0ESCxqUnJu0O?=
 =?us-ascii?Q?hUhBzuL9mz/fEHqdiIXUyNcV5lYI4br2tAw2Y1FN4cUZXs3Bxiu94Ek8WkJ8?=
 =?us-ascii?Q?bqh61fnzWWa69yfB9rfhBgtwC1sU7C5QN+Txkl19e+42uS8XvlFID1shuPmn?=
 =?us-ascii?Q?dKlvV0BSSGOWxLgVTw4Ea9HHzG1jzZ/cDeEeh+HE5DMP4mjLLN4vf/ElC/uT?=
 =?us-ascii?Q?XcyFK+H3FMO9Z9vOxndokf4oVLUnlTqWmSyX/ayOWdTeckfLrWw3734Ogvsp?=
 =?us-ascii?Q?GIhhEQCsiVjC2tneQuOsJSUnaZonw7POb4MgndVCUeQBkkCWTrorfGvlxEKv?=
 =?us-ascii?Q?5SCPUjL5ZG0/hyRVSxppmudcdWeXoJEsOK31XyJQw36IWSw00SPjwRGYJFrh?=
 =?us-ascii?Q?dFTr94jDD2g7Oxw+sATH400gg23Hc3wadEITYQtMi4nnSoimVJs5eduVwSlI?=
 =?us-ascii?Q?UpeUa+kIdrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6R2KDgep5Wja+Y7EAfQpTfqOSsYNz3Lack9XAsASn9mSKz4aK73kbJ/+exnf?=
 =?us-ascii?Q?ikYU0CBZJ7U9EkqYVRCdk2auZPX0OzrZfu+xDc3Zh+bWtaCzTnEzfWmoDkjt?=
 =?us-ascii?Q?7AnqAWwJLm5p2IZbmiD4zUPM2vGiw/P4E6niQ+UVzc8e8dhCYHjr9cIfMEgB?=
 =?us-ascii?Q?8Mat745pNP7V+EV14q6gpqGHe89V/5nzc3Vu4Kj/kdc381wShqJc5tytfqmJ?=
 =?us-ascii?Q?AwZqgE9yx+iJSCga9fHoXw4dGfYbcxGCUD8EK/THM84iclRBPsxR7lM6tUDi?=
 =?us-ascii?Q?0CtQpSgmdgsAz4BZ1fLud+vjZLePeZDRV1EQ2pmDkeCQxCra8Bpp/BolJXDv?=
 =?us-ascii?Q?MSldGms3uYwhjuu0PGBLAbIzRwowg2CNeclQN53makIRTED+a9qTHZmRJH58?=
 =?us-ascii?Q?06b1kd2k0KjQH6vWNBTfiJnwo4uMPd75Vqxtp3KfJRpQPs34irrJvZ+fMoGA?=
 =?us-ascii?Q?QInIKI+zc4+nP2C6ei/60cK2wYmUR3QTrS+gmBnamRsYdihHSDWMGbsLzW51?=
 =?us-ascii?Q?5z2gCqw2q7RbI+RJ+3Rm4MbtvYIO2zCskInhejWwUO8nKzh6bauUwapdHnru?=
 =?us-ascii?Q?gYjrKCSp7hBKHlwziaM3wvp9Lsa8O26JD77xCeUlVPWZN6z3tzkgND7UwynK?=
 =?us-ascii?Q?iX4peDvH1pCL67ZlPRMAZ6qhDWUfmqnUkhDg5qxAew7ISdSePo3ZkJn3Psbi?=
 =?us-ascii?Q?f3Ovjq/FIK8X198xQe+WzVioN2ZMsF1SSyFGhFhNSHIuQxhxIZIx75zTDj0b?=
 =?us-ascii?Q?8bqi4qSPnhFV5SlPGQ4jJ1GG65elRYmjpMDnAN++nPpX8JGhGBBhxiSk6toR?=
 =?us-ascii?Q?VTXGPTci9sy459TmsFmPIC87+RVlpOJfeFx+G8Qwy9fNf8FswbRafWHSbHZv?=
 =?us-ascii?Q?b6hiR+GKH5qbbsmosiJvtnnGETqJzE1Tk4ZWhax3Bk0mnGEcjSOKBp+718du?=
 =?us-ascii?Q?qqEwUkMm0TALpEDKTfBn2H3M7u5Vv9o3z0VSsDh8H7sg79LHODrMpjDIv4cV?=
 =?us-ascii?Q?yCtW6lFAVWeMVTmk4AHXe0vaACpQDKkpJEhhC090VJ9m0rFKBxHQpRhD9Tlx?=
 =?us-ascii?Q?ywZzYitPNfAcUslIXOxc06DMQt/BXlaEPVhjcgVe/jen4unFtDGh/1vbm6kl?=
 =?us-ascii?Q?7RvbmvZ2PbYF05cZTxcu7D1KpUoFXfAL1IZzmHYyhpdoHk/huKh2oHHGiPj9?=
 =?us-ascii?Q?9obz41ylU6rOGjr/dYEJFjntJ1MYOjMVBjehV+Vt6P0I9Sj1lWnkfpOFBytC?=
 =?us-ascii?Q?3vaIVpbdbqnsurnMPh44IATdM8GUY7S0puoF5NGPhG17vpUwn2K8quTQL9Zh?=
 =?us-ascii?Q?cALyhpcwLIINKsdeR4xgHxnGNc5bkkFs3KsOxHSqsR0juWzmtBs7rRyDAA+v?=
 =?us-ascii?Q?syV/n4RzNY+T9sKPCYo6K8bOTBDSVgXUAyFamnlvY+wbs0tPuOcwr/2idiu4?=
 =?us-ascii?Q?R93kmYCkQaMt/p7FohYKitNT3Kdb9i5IGjRhrTlWXUA03QJVxhIE/rbiCNqi?=
 =?us-ascii?Q?8LUXMqSxumU7wgvUlptRcHW35mUnfDrqm59Y3t6uFA3SJlN81K/gnm1FdjUq?=
 =?us-ascii?Q?PhWMh0/5q/Ped54+z/XUGRq+O/Vjao4ZSYXoZ28U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05af4313-0d72-455f-6e82-08ddc5a30485
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 02:30:10.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hs4TyigPJwHCX7YGW8J5D9z5L40LRysGRAnvBPvgsfFlpAyUg4WLG1f43q/O8uPh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

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


