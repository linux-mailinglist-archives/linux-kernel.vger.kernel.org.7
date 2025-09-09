Return-Path: <linux-kernel+bounces-807296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6E8B4A2A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82574E6A67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F54430507E;
	Tue,  9 Sep 2025 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GnwkoSky"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013050.outbound.protection.outlook.com [52.101.127.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031D3054D0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400879; cv=fail; b=UXTmLYRKfUacjcbYmG9LZmTdPRxDdtQmQFSqg+O1T/pcOLQzqY2msbbzpTQEwwl4k9t8oYotUBcyVdUUravcNttiFJYtis1il6CyRs0/mbRnasgnwZpakeeyqyggrouSK3KWniVSpEOoR06BmXsgDwbLkzP+lLQw80HCJriRiNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400879; c=relaxed/simple;
	bh=vLFavNVBP052BQvDvIemyQdmuk+2riPT/egAqCkZIXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=slnmDz8XIo1JePKGdG3FGmEH9MzWRVGT6Cc5+E/bv+PP9cQ+c9A2NRwEqj4Ty39ryYis+hHF1i2duXgR6UP8y4j3MZlgKtCWyhMbMqJnGYre1N3QD3MWTeDxArlmlVM1lQs340fg8ld0l2LWVN8Yw7ziEuuoqpIeUQo7VNlRgLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GnwkoSky; arc=fail smtp.client-ip=52.101.127.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgwEl2E3c2J3ppJxVriJ1cOrN3ruHfVlQ9x1qnqFAcePQKTKLurfKQ0wdUb4hUl3PLqj6gv66bsNAYO8rKQxRC9DrKgzbT4fEVsLKze/8ZFKfH2JlUCKJQ0igz32mHFb2AqwSZhg87MYfBNbHl1BQNobSQXskOEhWckJpxX142K79cEOi5z4hbGfKCNpRt/lXa7qWXn2A1Sm8Op1+9CGYffTaJ0H99fhFP2u359IPpu2L6xsp+ib6iLaMyu8eDkSxAOsicG4Yk0FZEyamHFRw/yPjtMTe1Id4DhQq+6XP1UNUaXHJwYB5asI6rbci5vCHgrTM3eQXo+ARUnNQK8weQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpkF7fm3Q8u3s2txv2IjriAmLSo0yYRK9fhYOBwvOwc=;
 b=HyydhOBGp8h7WzHYsLS4C6o8iZJ+qNHpES5sWmCC5eKfkTUASb0hx95k3Usq0xi3I+SJMSd4+EVbCrdGN3+QVxAn7q0SA0vGZoh82kQbOxwV3Abiu0tWN1ajxDJ5WNZM51+C2ucyxCTF/4fwKTkWQX6iKWUq9gEgQ3gA3xJNFkd2tPzse1BoCMax/m5DIHHJ2fvR9L3TJ130tUqNzj/mzkMzmSwaHhIfhpAPNfJwRlRjVw/NFTFwDDg1ZAiZwPClmVZyXEwe8+rfzpSNRnDIHSfbyrts7/LVVTEomei4BKzDSCAb2Y52TlI7nBiAzmP74nKTpYR3RDgK5QWYo6NbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpkF7fm3Q8u3s2txv2IjriAmLSo0yYRK9fhYOBwvOwc=;
 b=GnwkoSkydQnmGDm7qBCRlwvJbaIIZmnZQJdXIUgvOH2zk2oKt8CNGwy37EQdnZmwq0ccrFmtuHegXfOzsUIkB2JK1aN86NsFPzEKolnNuKWcJLr67hEYDmfe4iam5Rn2gkwVUyaRkZAKYtP9MZ0oPnuAQ/xkBPs1ENl1AP17vrhZhvYI3RHnICoUuymzUgLRPWIsRHMTDcZ5bLugCVXOo2mZa9w1+u11rN4jXFPouF7ADrGHAy2+Ly515Qgj6ammBn+9MZyd/u2ROqdqHYwaPaXU7kDIgkD5KOKN60vja9FUAbypMZpZl2XggalkIU4e5DBiNR0+9qf7d9e9mkNgeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:54:35 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 06:54:35 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - SWAP),
	linux-kernel@vger.kernel.org (open list)
Cc: Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v0 2/2] mm: swap: Forced swap entries release under memory pressure
Date: Tue,  9 Sep 2025 14:53:41 +0800
Message-Id: <20250909065349.574894-3-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909065349.574894-1-liulei.rjpt@vivo.com>
References: <20250909065349.574894-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0176.apcprd04.prod.outlook.com
 (2603:1096:4:14::14) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: fba61312-1c50-4a39-2d11-08ddef6dbc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|42112799006|1800799024|366016|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tlQSuqANXtAhacJbv2lt+E1hs5IvNCBPdMoAvy122qJXBhegc2nckVao8PX4?=
 =?us-ascii?Q?KDPjcw6LsDDVpf1rfpfMH5RgdgwVbr1eAAtM6MBgWF3Z1ObpyBfbTZJO3Xhb?=
 =?us-ascii?Q?ptcod8zCIm+xiqUfgQunwBCasX+vGT3OeKWqVikbzf52JSVhYFEwngElagDW?=
 =?us-ascii?Q?K7mJZg4ID1lgBWkHwhk7mMZ6LsaV4wnFYUNVGzAzJqWwusgcgbOoBTeHybow?=
 =?us-ascii?Q?XBhAZU6JmoyDsBIoyA61VXZfBadNbo5xnB6ZRilcSW7+ZU6BkyvNXisJZYrJ?=
 =?us-ascii?Q?z4Ae4cbp2RfQSewpJSTtM0EKgsfznba13T07WG0+6wKzd3HvojX8GvzP4nL7?=
 =?us-ascii?Q?bMVy3eMaL4knqAkNjknObSIFs964GcsUTgsVCoyzeQiinf6tuIGxXUVJ30s9?=
 =?us-ascii?Q?fWUvHKqzQ/+z+vIAPlrrnoHxIQzXkIgK7nj2VcIQLmdmw8vUG8bBjAuJRxdL?=
 =?us-ascii?Q?op7dK/oTpjvCIsYKpc5SYN4DA0gbu/KQexb1IvEbfKV0FWS52F3lh+twxC9t?=
 =?us-ascii?Q?Wc3qfl5ny501Lh9JmHoTsgqPNJCSW5z4rxzsIxH0uPlUh2p0tArOkaMJmQ1W?=
 =?us-ascii?Q?6B6Akt4/68+OpzjbM+dsOTkQg1SH9p8wjwfiGIJaqtsyjBz/Jw2MviL1NxN0?=
 =?us-ascii?Q?Iq9a+wIpgGFkIciak+V2hBlmBHqikOSSdkiKHliOslYa4h47QE5NAQ7Hfoim?=
 =?us-ascii?Q?v8MnFATvxtfX119J18R4/nbjgXlZ/bP4fdFl5fUJVD1n1x266ulDYuHq0oZL?=
 =?us-ascii?Q?SeLoip/D1kY1tRctSMVg2LtUr5wuwwcN0s6X1NjZZL0bb5/iSR6H5DQ/Th5y?=
 =?us-ascii?Q?IXxq92MaKQ/V7pu8KO+qGLl2f71CzlVAXZptK8pNDVH7z05YsOjzBWLn26H9?=
 =?us-ascii?Q?mRm8+Zfrm7tiGi9qpChMNwYFNnPeD+e30qBYS8FCAjZMDLt/G2praKEGddcg?=
 =?us-ascii?Q?FNZpeweaL8fc14YhskH7xHmH4IbBoCP0TYfzhh4w9S2InEq1Hvd9YB1NXnpR?=
 =?us-ascii?Q?qB9Sm/vgzcH58axACAC+HVa4iaFPIQX7CVMkXp+KV9saf6kaJKSe8iY9FyZs?=
 =?us-ascii?Q?SkaZBE/w8NAF0Erx4y0xcliMl+2nDzjjLU3OJNwEGCAU4UG3VRyqZU6LQEu9?=
 =?us-ascii?Q?cnYSyt8gOaaaa9jG4LrFeg3GW5omSCtyugDLnvHNph/R0tGZWNwxcZhCjDq7?=
 =?us-ascii?Q?F2kc4x0Jo0eN7jaGUrA3dZiQonsY0TGg6Y0IDiKle2umR6u1eG6oFurhM5iw?=
 =?us-ascii?Q?4U6VY6fJc0L0p+oAL3JEGc6OgL21N/ojdY1hJ8/Zfjr/+854ts12VE1VVNVs?=
 =?us-ascii?Q?Z62oCop16Rz6i8nI7Orj0sGxG+yl9zafUMpR44duTrN8LQHrrrD1FO8kMzy+?=
 =?us-ascii?Q?Jxv2NdkMLg56PK/i8Pn2vwhUCqKUgpGx48V2+MRwbqW67aXBLG9vQvF82YB1?=
 =?us-ascii?Q?BMJyUtIhlPLd0q27F3BZRLDzJ1N8yq8iZWC8Ja3mVhFd5w2OmFaC8vBvvUKs?=
 =?us-ascii?Q?fqEfZJOHF0AjAB4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(42112799006)(1800799024)(366016)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3hF1eRmBkmgu0j8jypz01VABez+OlVLukPkiXa3zrua3crFvqpRFgcfHJICp?=
 =?us-ascii?Q?gWp64fyxAtJn9MGvrCheUlypRCL07UmuOK/1ouBCFlWhHPGG+0zcCLhvmhdR?=
 =?us-ascii?Q?XJvjAvyL6TdxMpjNmR4QuD3ZpO3J4QnWf/0QtCxTTacEdvNtdiV4aI2gUd2n?=
 =?us-ascii?Q?pfC7Vg/aLENVGkegS9qI0bQNKEmDBPmnDfa+2SFP8RRoa+eH5gV1SKErGA8G?=
 =?us-ascii?Q?y8Gzw+3liyOnykZoA5MuQDeRBxO2h1VXltlT9iumzUcrwBICgQaj/mnetipb?=
 =?us-ascii?Q?MYlJuzZ0PYUnqdHkeA/vAgGfw9QQY6atLvIPQxjMr8PXXFquGjrERDsc3ilo?=
 =?us-ascii?Q?Zh2gDMa7eIqWm28PjEJW1CG64C6IJu0/efi+d3uZtPffhrrA8q++Nqh5UUMV?=
 =?us-ascii?Q?DxP7CnqBg1Ma3LCPMPjfB7DRN65AdyPPjNkAB31k5t8VzXXAb3Y75Dy/eCiC?=
 =?us-ascii?Q?VUJT90xlM7Mk37iD+EiuVJ9ubGaA+ntb64e62VZgr270CTGxfDBSP9TmMB8Z?=
 =?us-ascii?Q?RsH65QstIfoWZZhSXyGp2BcbyOZT9Cp6Tmx8iIBPWMyY+6ktoAFT2PbKQUC4?=
 =?us-ascii?Q?tADKK3PQb4s0zz44+g4DZ7cHxF0siePlHxBqZ7HrYCm+0QZqe1kIxSmOYuHC?=
 =?us-ascii?Q?wcqIIVprDTDymIp3BbRNtidE+OlGjUZc7g7vW8Nsm2YrNle/oWoZNkEhTTHA?=
 =?us-ascii?Q?Uh04YC7bXI4a9pRf6UDgnoM8iffI50J/1jvbXLqbT6ORDzMI+9zozPW456KP?=
 =?us-ascii?Q?0s/yVq3F4S25lO3No9wQU5YvBssMz1fIMavUavlgnwve38oWdwz0Ys+FKA31?=
 =?us-ascii?Q?KsX7u/OKDKzGpu21p34cVmB/SWspo+G2ey3jRZ3ZNKVSJMoRe0NojWO2b5fO?=
 =?us-ascii?Q?/sdUg1weIF9+5SFvzR0rOpAWD4NPz7fGMmZkScFg9ijFZ3EVXpgkBB//z0e/?=
 =?us-ascii?Q?fwP2ed1lpGQcHbAuhyG+d2w8OYaoOcLDxg5s+LFeQZ5XlijQPSo0QF6zRlhZ?=
 =?us-ascii?Q?JODJimn9jKqVqlhOuOhJSEFKy47j34njyAkMXNiSG9ryy/lW5XrYGkh0e8dN?=
 =?us-ascii?Q?AATSHsBxs81PJyW55u+DCge8DBlmN7UvQq4w/yxG6Oh/bhDtTYZ3JqVd5Vfm?=
 =?us-ascii?Q?38cxlM0uUKZbYNmDMI0DTn6Ae4utRhR1PqGKMjS5OfqOdRzXbancUhhAxmvv?=
 =?us-ascii?Q?RbG3Bwl8inkOR2ASr7DtFryXXpR3FZvaHqkAfyQWkblBEywOeZj8GLwYh+ut?=
 =?us-ascii?Q?m9Q4AHaGDuo7sLiff6kEb4MAEyUs5hDy/SWF8aGxWzhgu3II8CrwZ9WeRP+y?=
 =?us-ascii?Q?NZCfF28RdTy1Tm4RaVqmWyZQuhqeYEg/HCz54l86jbvacE6ZE5T5E+wQr5Qf?=
 =?us-ascii?Q?obWA4nvH0/ZRnrGzKHL+ReNBbsjdNAqTW3/Rb2hMOB9hddjSgkYWu3TV1te+?=
 =?us-ascii?Q?VDylHwU1vxV/Gj5tbdjkiC9qaqtAtx7cO1isZg4Zrc1quaR7eTf/gfIYlxcl?=
 =?us-ascii?Q?uJMhozcgdnMiomTBy/yynmF62FuSfbMBqSVefTveccN2jBT4Akul4Lxkt1PZ?=
 =?us-ascii?Q?ffCAJl+6X2sJOyOyzq5oOzQl7ONGsf6tF8mAbRKo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba61312-1c50-4a39-2d11-08ddef6dbc76
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:54:35.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBEERji77uWE/bnmJoZnKKJLsYWCZt8M74EX5BqcE6lqpmmeSkCm4gJTpQo4MYVA7j1nyvv/FopEiCAZkAAb6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897

When there is memory pressure causing OOM, fully reclaim objects from the
global list that have not reached the threshold.

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 include/linux/swapfile.h | 1 +
 mm/page_alloc.c          | 4 ++++
 mm/swapfile.c            | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index dc43464cd838..04c660aae7a0 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -5,6 +5,7 @@
 extern unsigned long generic_max_swapfile_size(void);
 unsigned long arch_max_swapfile_size(void);
 int add_to_swap_gather_cache(struct mm_struct *mm, swp_entry_t entry, int nr);
+void flush_cache_if_needed(bool check_ache_entries);
 
 /* Maximum swapfile size supported for the arch (not inclusive). */
 extern unsigned long swapfile_maximum_size;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1d037f97c5f..7c5990c24df7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <linux/swapfile.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -3967,6 +3968,9 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 
 	*did_some_progress = 0;
 
+	/* flash async swap cache pool */
+	flush_cache_if_needed(false);
+
 	/*
 	 * Acquire the oom lock.  If that fails, somebody else is
 	 * making progress for us.
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7c69e726b075..26640ec34fc6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -229,7 +229,7 @@ static void async_release_func(struct work_struct *work)
 	kfree(work);
 }
 
-static void flush_cache_if_needed(bool check_cache_count)
+void flush_cache_if_needed(bool check_cache_count)
 {
 	struct work_struct *release_work;
 
-- 
2.34.1


