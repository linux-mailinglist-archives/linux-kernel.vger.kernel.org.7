Return-Path: <linux-kernel+bounces-736178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90BB099C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BD8A4831F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E1F1C5F37;
	Fri, 18 Jul 2025 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dE0/Vun0"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D640186E2D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805814; cv=fail; b=D07z0djyMjy3q7PH4zbxvOOflFYZzmFAMM40Ph7uj6L+GEtyhxmFQ5bb5wCaE9JgFmdgQ8QrSl4ZhV5ovaqAxPTrjZfn8fLZB2NzI8zeX7Roti0Q1gSUbTL/risA8BcocP4FWiEQZ/6mpgxw0w1DsFTwWPoP11fRfzq0fOuaHqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805814; c=relaxed/simple;
	bh=JSPilpJgXpO13OylC4mQLsJXYphcFDocdJYKyEWl3xM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hkat+GYcGW5f1XnU4hXhcwcsM3yNC00nGZHVkLdID/WhDImf8B1sEDSs9cVHUzSv3PY852NErfjJkIel3wFNwbr4BES+7NgoOQVl3gmlFeumzeAsuAvG2japb9FoR3z73TqbAZgZnpNelaDrB5TEl+mhAjGCWXy/fNzOw3J4plA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dE0/Vun0; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7rtOQOYmCn9qZ80ha3SBhec6xad6LaD2IHWA7IJJ0rB17VqdEq55UVtzJFYRW7ka4nqrqgyyYN0kmDKOW/IPB2ZvBhS/r++hoIdbSLmHd8krg193ZZOaNG046c3/4PZYzHyWqZN/8c+XQ6lML5vagAI5wX7X1JlAlP1NP9oHKNmLxyODQiwq4FUMmmmex8iMT06QnGWnQVstMu1Z7JJSD3x05k6/Hos7AW8xqg/YGbppIpI3m/XCa9A/6GdvAYi9Sq/3kPXPAl8GmLYAx5kFq7yghUICqkJb0SZGnYsdX2HZe0WD4V3ygwzGGVzxsqT6ULjwrkUOFHDc1fNxjFffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhgHSxBn8cojdD1OtCVCiJblvncZw3QMcGWAzxo1H9Y=;
 b=CXDzHjEEgvSmLBlkNhJ6n1v6vs56MmoZDKBsdLqfHrQASvU6bEe2AdQm5QtIx+V99LDp6z22zFq+9GTHKkMgBP1aZZjUpsCAx6VTJ0lRjD8AdTeojCah6C3FavJ/3B8qkYMl7sBYD+13VfeIwZr0uW7qS+wxjpq2zbv7cbmkxiVTatSKRpblde38fBuj7+U5nEevzR4acqQLtKENt9Xwk6sdS4usiexqlHO1ghl65w0K0LO08EnTij77LNtnquP613IIG7IGKexLwAMjzjKBq1+m3PokAZTrUGgaOChtxd1ePggxa3ZPSAzD5GYT3P0fmKt0HB5FcrLdygHMSLLRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhgHSxBn8cojdD1OtCVCiJblvncZw3QMcGWAzxo1H9Y=;
 b=dE0/Vun0/efma0/YuTe1V8hItEYhclO4Hum3bup5ukprclfDj9Yyw61X5igH/2P3r59bB5BAy7Ia/+8FbzfSrm/duyAgBT9wbIrMQdG4NodIScu/4AGZjlpBDK59RPvAVCF96CQZV1UE7AgvRENihXEAwcTIt3BPRbf0NcRg91VeDwPu9hQuzOyeAmkBX/Nw3OswsXrHUiTbO/sLAS1fDVpigmRQbMRiRDR7qqoa0Rf6Z9dg3lhrxeBLbufHZbj4VNlczfcKwNDub1pQ3OR32P+NSFTHisge0HXaWnBFx+UcW/18BaxeRrcP1EOv33UzaTCyABq9I+sRYqOd6mHTTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 02:30:09 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 02:30:09 +0000
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
Subject: [PATCH v4 0/6] __folio_split() clean up
Date: Thu, 17 Jul 2025 22:29:54 -0400
Message-ID: <20250718023000.4044406-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:208:238::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3d66cd-ae47-401f-10e0-08ddc5a303bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qh+uCRLYE7X+9Vw8NnUJdtcIywJsViOXk+yewPJlHCP3TrgL4JedO5KUGx2H?=
 =?us-ascii?Q?RXQST2RqXWy5DtmeC67iYX9CPhyndsan4cT3wdlrAIr5oReMj7z1cg/Vxe9Z?=
 =?us-ascii?Q?6cTeq5Ge0XuusLWwRDqnuZox4gmE33AOBPUu6NFz28GBvj0WjqTZ12AzwEoU?=
 =?us-ascii?Q?hvv/Qg++TJWYb5PZoxq0dy3rmN8SUkVSxWkPann8YYamqpalrHMs8vZEMtos?=
 =?us-ascii?Q?rHf+IGdP8qsan5Q/5AtFVnIN4bp3vWSeUxfZYhEB1Bxv4hIJvuOBEwGsXqqM?=
 =?us-ascii?Q?EQzVp3QQwBJPFlMeB75cK6d3IRHu+nJ6RlJR3s6dOr6K+cjD95vD0eZu2h9L?=
 =?us-ascii?Q?n3fca+tELnY2etcxEwRxyDMkMvn1tLhxitRBTk04/MHVnr2oIHK54B3IMiYh?=
 =?us-ascii?Q?hsMldKVEDDOEJSH0osb0U8moDBbcBG6XB7a0lapdqSDS7KZuS/hzuxKMTcI3?=
 =?us-ascii?Q?bbX3B6hIEeu7fz1yfABuNEuE0CI+vW5tfJbvxVM7ijE9Y2r6EXvdWqGDbJ3+?=
 =?us-ascii?Q?XqgWEcJnwWeo9gGIbbqxdZ16Zr9fLDGqKEfhifSu6JSsHEqHm8A+n6/90QrK?=
 =?us-ascii?Q?4AF/2s+Oe7arRClFJL5bIG33/6dF78LD0+wmezRmlVhkuISGiVcsigOOhR9Y?=
 =?us-ascii?Q?u59f97h/AjOqPNlXxasDUXdyqdVU1UpVuNJO8q3SC/wkjqaUcCOL+IX2EL6G?=
 =?us-ascii?Q?V4Av/8ZR4OcHXgc3iOcJ2ONTdCkEw8ReZnkb1YKAgdsjNAFRrAl4oUeyY06k?=
 =?us-ascii?Q?cN9pSCN2wCseClUBte86hf5d+TO7t5i7Eww/jTARtNItSFE/OSZHt4DtKE+w?=
 =?us-ascii?Q?+c3KW0cTiWLGCPVp9sq6uzrUXpsGEkteleDaQbA0OaJJCQ2wXmRriy9/go9p?=
 =?us-ascii?Q?TiaSwxQ+g86NpnCyDx64stuQ1rc4ex1KmfMLxEqdgQSh1hFZZWlP++ItIdbe?=
 =?us-ascii?Q?NHTmqK54U58qe1QJeLhlsFw6FkU0ifkZX47KSAVttwjPK/mbi81tLEFkhfJE?=
 =?us-ascii?Q?zsz6wDcAgeG12RwrApanwPFDaGHBmkFjUujoG+nt6hlidEQJcHcwzG2G+Hxz?=
 =?us-ascii?Q?8OBWTcS1b1v9ScaAQrjyKIgVRmVa+Ir7Xo4CNxnfexWYnHPzPFIfXqnurkWn?=
 =?us-ascii?Q?QIly3Ra1X4ykcwLH2T26UEOGFiKeA9wRRIBGHz/YXftznk6Up3JlnDVpJvRg?=
 =?us-ascii?Q?oxVeI1F3YTpgtDQIkT0WL021TRIqdIS2+EGL38pTn0OCjn3Y54GRXs3/Bu03?=
 =?us-ascii?Q?nwiOcptJjL5AAtjAgn9dH+sNfY9GNSnrGwhZxd34AUvMU0nRkaYOyp5ShxZL?=
 =?us-ascii?Q?nFd0MHUFfDggB5gyRzEXA5VVWSke0C2oipTEj8nmZKuF2wt55gMcUu8lvflH?=
 =?us-ascii?Q?ZWdYMww7XTsF9HDErK+n8eqFBDUeOH61qTazn1wrHpG9CMBahWH1CKSH4kem?=
 =?us-ascii?Q?NAbE5t1XkHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ym8vt27NP3ZIdOIr2eSBKo5ResILBnkc4LzdObv/aENvv1GDa/jIrKezrgTw?=
 =?us-ascii?Q?bh6xxc73UoytWKW6UG7aifDED0KWTCRwSR7CywLzxM8kzCqBWu14bYR8pPJ1?=
 =?us-ascii?Q?TTNQzo80oSp/zESqK9bFLajXP+l1V+uzuTG13umwl8HaOVOvv3awdqfMCO43?=
 =?us-ascii?Q?JlXEdPQlzISakT15CDOlbKaWP8i1XguHa/KaixkvPeyIXXsTMbMHa8K8g88K?=
 =?us-ascii?Q?dXOx1a8HYbrgz2ZMzgiTK0AxXvBEkyV8IEAfJVecm4/blWItRuzKOZoGGyk5?=
 =?us-ascii?Q?cPhRKS2tsXvLRY8vMATb7PRB1IZdR200DbghdZ4txmAOgv1jtY1MxS3z2F65?=
 =?us-ascii?Q?ArIMO2LThEF6zT6vfcV14UJ0+ECmLHRCAPtJtFqnie4Yoht7jR2BlxzJNS7A?=
 =?us-ascii?Q?YM+1y5FR90A21YSAF8QEQxUz994s3WYTX+ZKTeKWd1/RwJ/aO2jDuvLhNTcS?=
 =?us-ascii?Q?49VYmcruzbFCzoaIRahJUPz1JoKA612gs5e9ERMvT5hvuy6ANtJPq0IwULjx?=
 =?us-ascii?Q?Sv+Adnen0jbvB4dEdMJjNpf+KAWvCLbDxsHyKvNjWBElfLrCmfT3ZnCzigJS?=
 =?us-ascii?Q?BGRLBLkWobZlo0sCwLyLwZOhbE+l7N89ywoAb5qybXEGr9VgChVixmcbgd/E?=
 =?us-ascii?Q?t8ikzlWVWWPhYCogj2u5wI7hXW2UL20gtx+HDZ1IVt5M8Mwbu2Ji+WtEgKZN?=
 =?us-ascii?Q?YFZcgroJX3obutB0gdG4RmwXtveMS2xE6oxnCI5vzbVlTkq3cOe+KvOgvQ4V?=
 =?us-ascii?Q?CzZB3709439vij+lWG2CDD6InAmDMQkAz+gNCpv3+MhWNesujU0PFEEvNAE+?=
 =?us-ascii?Q?OQ5W+HjFttds9XhRVAhjEKba6Ada7UVWJLLMa/OcctWt3gy2X3iVwDUfzMbG?=
 =?us-ascii?Q?+/JFmiAXuoOsDjw+VlNDLomqqVKtkhmOYtKKP90q6HfEiJOiVaH3uHqRCsts?=
 =?us-ascii?Q?ALermdge0MhF1/69/KO5ICCS1v4noOanfeHgnw2DQdIYKEc4+KVegFaYijLg?=
 =?us-ascii?Q?SU3yZgrVFiK0M2Miyfpk3VFgagq+YgC1EuqwM3qbWbqwbb3K68s/AWWPiKAj?=
 =?us-ascii?Q?FnKxHjSZUZft9KqZ6u7W9QGpAByLhyw9Qb1Qi4dKz6fqY1uAZc/RNkXyv/xI?=
 =?us-ascii?Q?McCOKhl2R37qpToR5QtgSMJ7NnUy14q2/69GVtpDa31SX4PTbRdSjYmzqTza?=
 =?us-ascii?Q?YybAIafXtLO0JvWyvizLtQX1R/ROfsVc0GmGv9FaNccqIWCxgjXs72Y8WkDn?=
 =?us-ascii?Q?RPIA+7cHU2SP+84wazNlP8Li7TVN9eyZbU+oM9rFzhcJ+73Cle9ylQmIsfI0?=
 =?us-ascii?Q?hO6rzhSjYK0X+Ig0/3cDDpCgvL9+D60XkYr/ps0LY8kWKoIqzxrN48LLH9VP?=
 =?us-ascii?Q?prZzRXPbGnhMq8Jx/CjYkRM9CaKQ6abRl67zzHa2BJtKQq3YbjXnsi94BzFC?=
 =?us-ascii?Q?8hLhiQoWR5OFAW3x95QPdX0DUwklHP/zhXU9q81+KWvq2kZ0678UjGppYw7a?=
 =?us-ascii?Q?dHeTzQXgjQXu1Rlh5OhUPms2qvo0e5abQIb2VwRaF1sbVQ0EXt4hgeIMo9lz?=
 =?us-ascii?Q?6t/vFQD3UtAY3tisjnuGn0JQI6DYKBU0BCttgW2s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3d66cd-ae47-401f-10e0-08ddc5a303bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 02:30:09.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhRbgX3tdFgNE7w7KYZxIg+QnpRAVmAbAPEGHqKZKgRB86sUIl+dLLJLfpqPt/SO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

Hi Andrew,

This series replaces both [PATCH v3 0/2] __folio_split() clean up
and [PATCH] mm/huge_memory: refactor after-split (page) cache code.

Hi Lorenzo,

I addressed all of your comments except renaming folio to origin_folio,
since I find that might either cause confusion or require a lot of code
churn. folio variable points to the original folio throughout
__folio_split() and using origin_folio in the middle of __folio_split()
is confusing as one might wonder if origin_folio is different from or
the same as folio. The alternative is to rename all folio to origin_folio
in __folio_split(). That seems to be unnecessary code churn.

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

Zi Yan (6):
  mm/huge_memory: move unrelated code out of __split_unmapped_folio()
  mm/huge_memory: remove after_split label in __split_unmapped_folio().
  mm/huge_memory: deduplicate code in __folio_split().
  mm/huge_memory: convert VM_BUG* to VM_WARN* in __folio_split.
  mm/huge_memory: get frozen folio refcount with
    folio_expected_ref_count()
  mm/huge_memory: refactor after-split (page) cache code.

 mm/huge_memory.c | 317 ++++++++++++++++++++++++-----------------------
 1 file changed, 165 insertions(+), 152 deletions(-)

-- 
2.47.2


