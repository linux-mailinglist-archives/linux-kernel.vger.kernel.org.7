Return-Path: <linux-kernel+bounces-737276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F60B0AA39
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F345A25D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4BA2E7F08;
	Fri, 18 Jul 2025 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kmrSEZuc"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E471F7575
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863874; cv=fail; b=iktgoP0pEHwApy/4HcuPs8zrBrs+iLvayIgxPVMYGqE7JQNKRbUtwN5inJOm3gi/cen8m2jcLztHGdJ4qz7zD1MwEZ/mGWKA+lZqPDqsoFX6M+AnaxBzgw7ONZKxjqd5B0vH+yReZmg1eOAvdWW8KV8pfWGtz9Klahy+9iMIyps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863874; c=relaxed/simple;
	bh=+r0iT0n4Bi4+VlrbXsSyIKoHF/gWYByvQbdCfJfbzXI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m53vc78whJ/eYYObSH7WlHnmglxmkTvpkjAe6YWFakjzcPxmt0NJbxmTouW7ilMzI9eZxtpMojgIPG8DK0x8+pnFO28vxgg1DTBpsqHAzjNw4rqZ10M9vTVlfNQa4dUgLqHMJl69O6yBG+Yd+xgl+F2/YVsJiw+TZ2kQr+YTTvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kmrSEZuc; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1O/Gv9+uD0kjFPVF27IS+UV2HetwIIkTVgHH04ZACFgDRUmFOZgQUpVA04TajvSalfqmE4T0cm4YFQlLNvlJVmYm1YIMsqD5IT62eh51VBKRk57GaTxeXJ5wu4RvKHaxbFKhGqp4TA1nWi+NwGLzAsSIspwDmSG5C0VWsGpe85KwwkQmmoPwmJVQO8/4hdFSq4ljGxVrnf5J7BqNIgdZ5AKd1tcyn72bWfPAMflLE5Oq2DOkeoG6DeZPtBMcKd4zVGFv0TbrTt+quTYxPCGMJy4TSdXSBNnyjmV06MeANjQ2NwvML+viHDmnV4cUJkALjBiwsRnyR7qjnxyTy+dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trPRejOvQKiatvwTz3OLB2nMVxPRciKqdIYfXvT1MRA=;
 b=Da6u9gC9ODbH1xrmlUn6qkG0Di3M7g87UWWyO1zEYeBnN8O5RqL3DRMkbhoanpOqfI85KFwJX88pznzrXfnicM/mn71SzEP4thFTKT7snE/sa5scvPLp9psd1z+TFDqpadsKOwFBPDJ5nSYnmzQdCbcl32WBJTeNznpcrhlfs9n9iA9fKEIqhXa0kfGNrGG2Xeh4y5P/yP91IrMrngvMTfYYjawlvtwHe4Jw/EV6QuLVACN+KVrkFcng+l7Sa5xQ+MU8jMcwXhE8toU9zEA6O9VHYh39LW0mj/WUKCr4zh6HQDjPjXMUA//G2sHXQK+ltDYW8LdvuC0gbJAXh0w8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trPRejOvQKiatvwTz3OLB2nMVxPRciKqdIYfXvT1MRA=;
 b=kmrSEZucy0BEbTpjdalywfkXcvu7iwmH07Gg4FOWsQGr77vZgEiFzSZm1j2pz7kKZDtPcku7aOIB2P467Cw+hQt/AymQcPMibGCm0XeaUeJoGQIla+u5MsNEL2Y2ceMvpjTxtbI+YHUKd+OCddn90+f48UqnArFaA8ACZcBJIipuhugf6fJ5r0p4fT78Phy2Ao0ZKDF7BAbkw3Ao8jjR4/KWE1DIwPW3W0z/b6rvURlj0K+0qfzbqZLYL8ntT2g1pqcykXrGFAD5CmvFzW+w4zmvoZqHvBa6YpvuudSAx3GqSJzyX1d/NPTNpq3DxOr5M05wftgRxmNffiEZgND8uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.39; Fri, 18 Jul 2025 18:37:48 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 18:37:48 +0000
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
Subject: [PATCH v5 0/6] __folio_split() clean up
Date: Fri, 18 Jul 2025 14:37:14 -0400
Message-ID: <20250718183720.4054515-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:208:234::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 795fef42-079c-42f4-f8a4-08ddc62a31ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XnW7w3xqGed4mF98PcT9i2TfPZCPPt/mF55PNUbKJ+XJjTKcs8yuE0IRm5Tf?=
 =?us-ascii?Q?wz0kVT5GbaTQqKif5aDk5PVyC+QbBF1nSXiCW5gdZVRI0DIZLo0NciLVOFJU?=
 =?us-ascii?Q?hrOx9CE/U4csEDsbFbhDsEmB27F6INrKAhGiq6KjeWZoX6epS4+wcXHUWxrk?=
 =?us-ascii?Q?l1Jh2O/o0n5kRch+NM6ezQObWnfA3l51eCaZM3K9hNW5ogGdLtoje1SPzRtS?=
 =?us-ascii?Q?iXn1ZRjNjlTkMbDc8c/IGfXlsdBpF9nCYF3m0tPU/Yraev/zBLOuEj6dGupB?=
 =?us-ascii?Q?NqdH4J8OO6utlHBZ6lFytLctJjQEAN4VddThS0JaevxyFovBZHl2XZUbPjTj?=
 =?us-ascii?Q?LuwTlS/uhOzr9V55hUqlUOUHxVQDqr0qjwYc4Wadb0bvZvtn0SEW0eoq4wLl?=
 =?us-ascii?Q?WaxVeO1O6YSK2ZrWxRWjwNPPlnpBKjmYcYjd9NkMC2Lwl5hO8SLxtSjFxYst?=
 =?us-ascii?Q?NUrzN+etEl9KRfUGQn4VaZgaNLdh7+hzw+8QIY1sTp3ot4IW9bvWGsUa/XaD?=
 =?us-ascii?Q?CVRqaKhsEtsriL11xyyxlJSm5H4m2z4MD+KJuXlQ+n0qVXaf6jffMkg2VgHi?=
 =?us-ascii?Q?E4W83k796t0oIw9MZZXcl/2c1bnIb2PToAM81sL87uiZoML0kFVqvl6ngaSc?=
 =?us-ascii?Q?y8vlLvkZy+Q3F8Sgsi/pIg004D8jK5qbi0Ewku+ju1n9M5C2pv/cf2O0P2TM?=
 =?us-ascii?Q?JqJ5G6G5MfykeFCgbQiKr2AoqfwwB+h/JKyt9lIk2vRnmGzxODm/baOeAAYH?=
 =?us-ascii?Q?1/p+25fyZ+1HkLjbkCUckCQpWBaqLIdTNB/z+Aqia2zJArH/PrFWuZ+rtE+p?=
 =?us-ascii?Q?yxyB5b0AljSiEjfmb+ypVQhiKRrgz0T3Rr+AEgcIaBEdMtibgy6ZZQZCLtUx?=
 =?us-ascii?Q?JVwGRRN3F0Ydb1sgJRplGlybOyfErRm6Pk2CYwwIrrwLvmhixD59aBU89g7d?=
 =?us-ascii?Q?9+kNodk8qhumQ3DmabuY84w5SVDUkrJet0FMaY07ztqI8IzLRpDqWCyD7uQ8?=
 =?us-ascii?Q?nvJH1KCQtlKt36danz8N3YV3/ubyEgaD3LD1CIjEJ7DvFVhbG5rX3ay68efz?=
 =?us-ascii?Q?UHDldcDXFzjFjdbSiGwhePXf7GzTyt4I7Y9aQiDwC8xm7Rl2VnhN9wuqu4Wo?=
 =?us-ascii?Q?+afcV/l9/FgC6Hte4iINo2ksUzn/eUyA6K7Olc4eyJvnRL+M0ZZgIUXW+xAO?=
 =?us-ascii?Q?qoDYE7NG7X1Ps6qM7GdxOCL/LFvtUzczN1QGwwacBw/Nh/yEDi97NHOkbPgC?=
 =?us-ascii?Q?tPIBD+YY1fchwE8Cz0uqDCRxIwYTmtLl0TAjlUDjeQje/cZPv/X5/PMMtIYD?=
 =?us-ascii?Q?CFpWapTLRM9UiPny1WmnV8oikbozHpicEqjKqF+6Qs9mzD2l1BT2SYzy1je5?=
 =?us-ascii?Q?WX77FHl/29DjHownv16ktRv/Dsh0qHE6IQoHcuJ/V5+WBQeJGuRsBS9dujjk?=
 =?us-ascii?Q?RvLUo3D4fAw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2L+yFhSFulWfG39P5SEoJYWHPWG45jebRt1Sxnap326EcsAqkZ61djPAsqtb?=
 =?us-ascii?Q?H4VYnVePZMMpP/FozANkto+5/7pw5jO5KeQXk3EoKc0rVoAQaPE8qb8jKV2F?=
 =?us-ascii?Q?LpNoNN4T+WykyENXAjCbS/P5X9CFV4aYMUSb4OtbKPjX+dPqzo29xOrLd1Qz?=
 =?us-ascii?Q?i5U4da5Z/Xykcg2rpSXXs0eGLiROMedS9F+molzT2TpK0ZbbUpIDlJbKMzF+?=
 =?us-ascii?Q?IrbOc09sLL0eyp9UB0SlTxIA678LoJakniHKcvVurWtqRCApC2gSaiDYWZpk?=
 =?us-ascii?Q?LFoAGqf1Ob+Y1cI9ePwMj0McoDYUeSCcyu7sgiWbbejCXarFAAVT3oKnIlbn?=
 =?us-ascii?Q?OiAlZLUSoHO88Ffe6t+huui/GgC+ubaW0g+WxAob64tP8hN8MppY3utyw0FV?=
 =?us-ascii?Q?MFrPzgjit9bDwRZTkBynHDYqkZiSYzt42fReaIsDDKbkAib+grarGj5RXyXy?=
 =?us-ascii?Q?340EbnjvgijzRPv1XSsYrXjFwqJ5CX+CjHcXv5EI62Wa6pUp0BdgNFSN7YBH?=
 =?us-ascii?Q?I3et1SwOXB4IMub6hon0r7viCFo3LpRdaq8W2lCasDouplN+3U4Pl8z9ace7?=
 =?us-ascii?Q?mUvLO4L+7pZsXnAYBXdTPoW1S0arX0oBkDI9sTGQ/rEo/jJP/1Cf1N0lVMxB?=
 =?us-ascii?Q?Qnyn2adQUS9unOXrNXMnOdBsbJzFCEVgKT19wfqY0Qe6ZMXua9em6/vbkPPr?=
 =?us-ascii?Q?G88BLU/me0Ht/t2TcDRC48Ytm0ZLA8gXWOFQZvtlkZuhDqhredRY9iml78n9?=
 =?us-ascii?Q?i2I/BSImS4rCsW34McieIgx9hrdf2Pt+In1Q3yQsjznpgAE9Fmi4r13alOUl?=
 =?us-ascii?Q?edDe942agBMstDlYL0DEg7OKe6gicdeb0MKX7SttO2jRvvOQ2w2yUdD9gv5n?=
 =?us-ascii?Q?tHKO6+zwIurWIduAqL9mhY+IorTF3GWMzkukP0jo/Tp0rts2fZKeoTrlayGE?=
 =?us-ascii?Q?PEwzQtfPAzy6D/eZnWphVwMmUgSDZEYZNE2WVYKg8OZpl6nGIpJt4L3qdKGa?=
 =?us-ascii?Q?uLZ+SLYPPXXKzvvj4QUzj00AcoB0zN4ekECg5KNl8FWkwn+IFZscASympGmE?=
 =?us-ascii?Q?+QKWApBxNADCiuvf6fmMZY7Tt0goMPi8yt8HX/zokdAdlZ01MWRg+lP9W1hr?=
 =?us-ascii?Q?5DnO1RhhsYN9gccqTCuP4JiV9NIF5S2RQTstOGu5y0qUNPcjAtVcms1+v9Y7?=
 =?us-ascii?Q?3BLWOYm1fUAD7vBQXb0yYKPzyGEUVtqzVlQ7HisTZONq0ukR0omE9FPBlCJS?=
 =?us-ascii?Q?5fVmMojH8YlsEYjxvX+MeH7nvBXEisfIH5Rqj5NALhTCGIyVfQ9fjk2Ltrya?=
 =?us-ascii?Q?5PF60HfmAU/NNmYszv7hFXOyb1AJkBSLVelHQvBOSeGqha/K6WF7wijrQTZr?=
 =?us-ascii?Q?kfGxSnb62WiPLYthR/UlT8O83Hgucw/khihgEO66sTRaoEAZbqsW7LUZKg2T?=
 =?us-ascii?Q?lWgU8AFU8/I5hoUoV98ME7Emgeh5nny/UuWL4g3whXNHS7x1wBTuIAEoC4/i?=
 =?us-ascii?Q?Lrxlj57Fg93+stScNGBpwt8qP9pdokIBPlJNb3m5iHD5fDzEGOZL32lbWEkK?=
 =?us-ascii?Q?C/1uvcYIzS0smyrVIUVrBuNFXUGuEOQdfGnKxM4Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795fef42-079c-42f4-f8a4-08ddc62a31ea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:37:48.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EiGpPnWQeZATxdjVWC+z+CAec8ry+9BmiipYjkFbslnMCI5lKpwwHDveW8V08X9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

Hi Andrew,

This series replaces both [PATCH v3 0/2] __folio_split() clean up
and [PATCH] mm/huge_memory: refactor after-split (page) cache code.

Hi all,

This patchset refactors __folio_split() and __split_unmapped_folio() to:
1. make __split_unmapped_folio() reusable for splitting unmapped
   folios. It avoids the need for a new boolean unmapped parameter to guard
   mapping-related code when __split_unmapped_folio() is reused to split
   unmapped folios.
2. improve code readability and prevent smatch/coverity checkers from
   complaining about NULL mapping referencing.

An additional benefit for __split_unmapped_folio() refactoring is that
__split_unmapped_folio() could be called on after-split folios by
__folio_split(). It can enable new split methods. For example, at deferred
split time, unmapped subpages can scatter arbitrarily within a large folio,
neither uniform nor non-uniform split can maximize after-split folio orders
for mapped subpages. The hope is that by calling __split_unmapped_folio()
multiple times, a better split result can be achieved.

The patchset is based on mm-new with aforementioned two patchsets
reverted. It passes mm selftests.

Changelog
===
From V4[6]:
1. Use VM_WARN_ONCE_ON_FOLIO() without return -EINVAL.

From V3[4]:
1. Split up Patch 1 into incremental changes:
    a. Patch 1 moves code out of __split_unmapped_folio();
    b. Patch 2 removes after_split label in __split_unmapped_folio();
    c. Patch 3 refactors __folio_split() to deduplicate code;
    d. Patch 4 converts VM_BUGs to VM_WARMs;
2. Added "mm/huge_memory: refactor after-split (page) cache code"
   patch[5] to this series.
3. Added remap_flags to make remap_page() call easier to read.
4. Updated Patch 1 commit log to include variable rename information.
5. Converted additional VM_BUGs in __folio_split().
6. Renamed next_folio to end_folio to avoid confusion.
7. Added a comment about start for loop with folio_next(folio) instead
   of just folio plus skipping folio in the loop body.
8. Dropped swapcache folio split check code from __split_unmapped_folio(),
   since the check is already done at the beginning of __folio_split().

From V2[3]:
1. Code format fixes
2. Restructured code to remove after_split goto label.

From V1[2]:
1. Fixed indentations.
2. Used folio_expected_ref_count() to calculate ref_count instead of
   open coding.

[1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B54845@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20250711030259.3574392-1-ziy@nvidia.com/
[3] https://lore.kernel.org/linux-mm/20250711182355.3592618-1-ziy@nvidia.com/
[4] https://lore.kernel.org/linux-mm/20250714171823.3626213-1-ziy@nvidia.com/
[5] https://lore.kernel.org/linux-mm/20250716171112.3666150-1-ziy@nvidia.com/
[6] https://lore.kernel.org/linux-mm/20250718023000.4044406-1-ziy@nvidia.com/

Zi Yan (6):
  mm/huge_memory: move unrelated code out of __split_unmapped_folio()
  mm/huge_memory: remove after_split label in __split_unmapped_folio().
  mm/huge_memory: deduplicate code in __folio_split().
  mm/huge_memory: convert VM_BUG* to VM_WARN* in __folio_split.
  mm/huge_memory: get frozen folio refcount with
    folio_expected_ref_count()
  mm/huge_memory: refactor after-split (page) cache code.

 mm/huge_memory.c | 311 ++++++++++++++++++++++++-----------------------
 1 file changed, 159 insertions(+), 152 deletions(-)

-- 
2.47.2


