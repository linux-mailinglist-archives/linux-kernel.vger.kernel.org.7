Return-Path: <linux-kernel+bounces-689285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E52ADBEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 04:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9BE1891CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 02:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72432036E8;
	Tue, 17 Jun 2025 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VIzKeI49"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58441FDE09
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 02:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126353; cv=fail; b=b//yvKNLU2s04shSndD6pUmO5m8q0q3ZizvKciw3ykmo0oOaDku3zov+BTtPxdSkXEwiSDTt2WfrthndE4yhQAJlU2PCrXyAqFtmdrK/IWB3Kkc7qV9FqepAxSk0mq2upJUXVVS6jw1iKDs0hUbuDirlZpGn1aTBI2dq+rDomhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126353; c=relaxed/simple;
	bh=EGWpb/EQeiWMZrEmUAFVy8Ia/PUL5CuUPfNWpAowAFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B+VJ6z0YUG1KAIxWBZIKzgJUmxnAb4LT4icyWmXZTb1YRexseupCv7YLc4eGk5SzqPFuWLLcy9+/1TfmWTXjJf9OIVEb0YpfdTNoQYhrfqI5w7InJy3P9IkUfZMh5FBAjcCIiXuqUFEsg2QHy0DdQt9G1UL7SbUd0FjQAfGeIe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VIzKeI49; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+F4SISn8Pmr//1oBdMelu3AUXkVrskb8cfH5NjxJ5dvRtIE/QTTCsi1HAAEj+tACjQ9G3mE2orKSKCX+QHIEvKWFzLMUoiSLL5nARol7pN/xnX+XF6ldUX/XyomlKtd33YgVa9LoHJ7xtGfh0BcgDvCqfLNs3K+/3VdxaMzc1aRHpG7QRqmnqZUd1s2rr5p0mxgHOdNy2NsGmE9NngK+4KUwTRpay2y1Ww3lykmajSqMdPMv1b2I7oT2kmNvem8pBt13cS2QpKEEfefuSKSt+tpJXwlfHAB9+Ylegcc/YVb8GdUSCZvoPuJbcp5P6KXi0BTO/QF7G8InmxK8k+vcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxI0/1wZBlRnZRVuH9jl4pcmlwXpkQJNlOlcwtgHQek=;
 b=kuKPWWLPKhrAmovIOBYNHge2MRN1LXjlP0hZ+6qOjDS8PkeVpNlizc0CkZdSP8zjzPReEXSK8mUsW8vKVvw2NH6XU/K7QIpz47FGIClgI4kvf/Wjn7DAbvAU2yOYj2WB4UdYpyzQaxfQ9qChxERKBxU2T8EWPA5rKGbcuAt2mmTkxjmE+EdVazallFpLdsqhA2gImO6Km7uBmw0R98fNs40Fr+bYxByiJGWDNg6YxVsxGjRi4613vWEWyrYF9uh0OZ7Q0QGXNkM1O4TiRsMDGHhFtzOvexY/XprMXKjHtJFtuIeZpVrRaEoS4gPbdB+gOEDOnWdS+DFebCyf2IXvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxI0/1wZBlRnZRVuH9jl4pcmlwXpkQJNlOlcwtgHQek=;
 b=VIzKeI49Ov5aVtG2RzvbRGK8fTl000vR4gxcYKii1MN/W+D+8Ns4Z8jht4xbh1nx7i/ET3yq/cO3TnerU7mt3B2wQw7xaf11XAl1sdr1vdSuOXRLn3fddk/I/I6p0WA0/zNu6mYbAC+wImKoRjsaQyC/Qyb0BqTku+NDxKPXafqaO9Nq15DfRY07yinH4HklB9g+2+NiXzXCVG22trDSR4ONQ/Q01Q9ueRpZ/1HaSgtICw24f8ulaEow8FykuVdgvA5wDQ52FihdbDlGoBlfCn98vpuVnUJkDOIIAebsoPYGeEa7zX9wxu8Hx28eAzOf3l70QgP4vcwybSRmvKJB1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 17 Jun 2025 02:12:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 02:12:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v10 4/6] mm/page_isolation: remove migratetype from move_freepages_block_isolate()
Date: Mon, 16 Jun 2025 22:11:12 -0400
Message-ID: <20250617021115.2331563-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617021115.2331563-1-ziy@nvidia.com>
References: <20250617021115.2331563-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0020.namprd19.prod.outlook.com
 (2603:10b6:208:178::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 4882e724-71ee-4184-6a21-08ddad4466f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?alaZdHrStAziLiMpZY/IJZW2M71Ypm3QdJ3YJ2DQyBY8IP4eyHmcZW/mDIHD?=
 =?us-ascii?Q?qSue337qXC7lu68VWVVaM1TbYYhSNAJbhDebkt8V3oi3S2lRpadu2HAN/QY8?=
 =?us-ascii?Q?38c78nL67kv4ZPsIiouJdmT35nPDyDJ9APM5j4dP0Stz9ayP4Esf1fd+KfE5?=
 =?us-ascii?Q?uT0WVfvwgZ3l0sFZWUrdtjSSMD4ZwilSWT8njY1r/21e+V5fgCHvX52xylZi?=
 =?us-ascii?Q?/MlI2SXhVJ3pUJSjkVI41NaF5Vkp1BZ7ATF6VbeaGmEnjIMtZuCXIkKzsW9z?=
 =?us-ascii?Q?mD+ec7fQaSCGWTq82XC/Q8qwnU5MXB2L6mlB66znKwdia+RNTyoTHstqnDre?=
 =?us-ascii?Q?bc+4lEF9eJphVi01VmDb7mMGvp+NViOf68SI9fx8hntzAD9F+7RXnkurAwwz?=
 =?us-ascii?Q?YKa7mk2QtJUi2/+R+o2jjjOonZ1GZdfrbLU/46+rCP2paMZjL4mxp3swyi2N?=
 =?us-ascii?Q?LpK3b2OoEQyVb7CGaFU6gZTnQmnfpEsiwCWQtUpZrIeI6eddeydXp/MMj0oH?=
 =?us-ascii?Q?hj3MOArxtVsI0+iuUMsYsu0AWgBnaTiARzqfQeatyzoeEhBUbLt4bm0+aVBN?=
 =?us-ascii?Q?KMWUyYyH57wjUk7tSoRiED6LUJ+uH3/ua71rItrhqUwQpV6EokggXJTNwipZ?=
 =?us-ascii?Q?BEXfiYqb+NlOnBXyqC0P2Gw4pC+C3MGTTCz4cPdioPxQwn/8ApwRE9rwG9JY?=
 =?us-ascii?Q?mP9nXbTSJxOz3/1h9SaYTliPXHl/a65K/hPiEH8i3cqS4yFHN2gtACLtOWeq?=
 =?us-ascii?Q?2ga8lmqNrUdFCieBQI880t4MJq+O5TymuyjFZMavyMqjnGYKhyKunpZlta9m?=
 =?us-ascii?Q?mT1+fSAQXFgUXf9ktjo2cMwVmZsQJRkODv1cp4TrLMEtZN4RPdZABqWuLXd7?=
 =?us-ascii?Q?Ks3fCy5RWJjFTisEi0r8z/amzaGYqOe8PBIfudrb7Gt1KEAaDkLYgjgMGGps?=
 =?us-ascii?Q?TH5QIt7/7uXLVScn0ana8wJsLJBVFaIYaS2vDGRAKT/j1JQiFQ0Vql1BahZO?=
 =?us-ascii?Q?0YK7TsX2kqKYf1nZSt+AY1PUeki8i94+JBWQchLjjAGtUbdnmXGtX7PTA2A1?=
 =?us-ascii?Q?0LkDRSIG9UtgZu5Oe6sY7eg2/lXUnW/rily2Ufou3orPY3lRcK5/T2/6KfRH?=
 =?us-ascii?Q?L1Jq3XCrzUcfoTE/wfqrI3Ww/Wsjy50Vd5i02lIloit2P0SPPdMD6TRX+7bq?=
 =?us-ascii?Q?yHM1AstQEO5u5Q6CjXcOFf9LhB51p0omJQNFYur3BdVu49OwPm6nBb3hMAVU?=
 =?us-ascii?Q?lFmQZhGRJHwiKCjY/HkvswvwBdmdL0aHhF7erVdM+myIO1wrwCGHL2pOqLco?=
 =?us-ascii?Q?24kSt9tV6mDpEvY0nni+/uOAu/qFrUd+VQaPcFvT2eDywq6KdI0LWWB8DCiR?=
 =?us-ascii?Q?joKJWtx74MZMZv+Z96TQJn7/JhNnMBpUsajY0XkvZ+tbPJuvzFVfoQRPZMaM?=
 =?us-ascii?Q?yVrA/mEGczE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CRdlLT+xaMVspLgtgWSI5kSojNy0wJNCY9+b2Wu2gZDkZojpIxcb2H458MCC?=
 =?us-ascii?Q?SEECZRXZzSD9wY6ZHCihSVTEZPdkDMO/ORVWLzIcxalzV2wA8RH0Xq65aHkz?=
 =?us-ascii?Q?Nj1GJTD1i0DekRnl+kbOmWKh22yo4GwpZ1I9hKmCIPI3mS7dj0ijkWqme3Ab?=
 =?us-ascii?Q?x2cjLt2tJc/LO3oOTMyRLv89AkuBKCBpp9xHr+e2xooAc3AqtCzDX+yA4Rp/?=
 =?us-ascii?Q?CJBEIsLOMn6ogAOS7cUYzSD9I6AysRdoaaIUMd6VJjHZ0jTEQdo7/iOrQDmt?=
 =?us-ascii?Q?szi0Xi5lru1zu/PDebbrKvTqnizzTMiQwCSKKuew1NwSlgTU4Ig9anrNWzn6?=
 =?us-ascii?Q?R5ODbCHB8niK6ReNar7JsV/NbJbGiAWPeFdOO+DG8enlhtKseME+6xuoi7yI?=
 =?us-ascii?Q?OOVFDxxzRPNko8A9nU0g9LMIXQGci3c0sQV1GsA9sV5/tazshHQ+OnPCBK92?=
 =?us-ascii?Q?GQL3/dqdd/hyJV184FIED6Kqr0foNiECtwX1eG9SgdBHk+7jVoBvUuG7HbB3?=
 =?us-ascii?Q?RT9jhaRyhQ43XxWfC1SQuQcFy6gJ3XSS3cA047XVrH2YmEc+cVoPOtjuPNdn?=
 =?us-ascii?Q?KkyfSA/fJ2wLC7EZ0fkol4lrMeO+TtwLRbSMiTHhqgj7aWcE2pkgIMkb5WdN?=
 =?us-ascii?Q?uYyAaDSfILNyVv50I9nVbu5pYdB3Pb4/1+b1MUJ4cdlbGnb4siqwEykR0GiX?=
 =?us-ascii?Q?4QvAuO7lOFbYCDHpCqFSN8oF+WT2r8s186nQo4eUDke7ILO0lhPbbecXdOp8?=
 =?us-ascii?Q?a7uSHIIrc3yMFf74U6Np+odOXYXB16/aeMWE5/Luyw68RLbCtIRD7Ow+9MOP?=
 =?us-ascii?Q?h6ZYILPwgDPKbos4VhfmMcTb7T2H8ZiZ7BV5Ay4je4D4BI9DuklSzsUEJzz+?=
 =?us-ascii?Q?CqBu8CRcAC7WUCY0xsJtBl/A4KIH0NnDQ0eL75wsXDcsBviDrXj18hATYcnk?=
 =?us-ascii?Q?dS4HeE8MpWRYW0qtAgcxa1n5O/FGkAJhzPOuMHBQPtYimthmSD3RbAv4fPAm?=
 =?us-ascii?Q?QWPJexwb2f+Ycz61JfLU91Toiz7RbL4M7U+j4SMbkPSfeqyguRZF+Mk9fGxu?=
 =?us-ascii?Q?yhuUjCyiRZYOUYWxHNKWc++7smpb9DVY2Yf6/GfGkRDWuIGPifqOGwzlpAlf?=
 =?us-ascii?Q?Lsj/ZBAUUimXggUMF7mw1QI2BTclVuz4MXIzLTSEd7SWl+7TcJztEZcFSL74?=
 =?us-ascii?Q?8dEX8BJvgkfzCvmbWMve0wwTMzEATOrUA5sEjjiac7UK5nITfPF0bGEhTPgo?=
 =?us-ascii?Q?ZrHXR7g8gNG+c9HqpD1XxJOPYX/25JqpBCrYM23H5NRYDxxcAPASUIM7mmQX?=
 =?us-ascii?Q?j7n5pWtY2rlnFhkj89HpuEaogwijTJemhqlIljSinTh3szCy1nvWbDiB6L08?=
 =?us-ascii?Q?dnEinbpgEsa6B2m1+jms0Ojtm02mEu1O1GRybeFXZoP99zpyVl1teDzHHVn3?=
 =?us-ascii?Q?xqe/EF3gxeA4FxSNcUe5f2rolorLvV6k82S5lso40Lu8LGZhOPjzxIw6Xxfc?=
 =?us-ascii?Q?FKyOA31UJNgunDCeNqGrlh/IG+KIFiXecjxs0+MGSOB3hQHjhS8I/yKg/3xE?=
 =?us-ascii?Q?nkiT+xFr0ydAVf576kzNhmQg6rcdpzugZ1soZjfK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4882e724-71ee-4184-6a21-08ddad4466f5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:12:25.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Du6Am5sCG19y5yHoWwoYrk14BeHs4kq2yIKbRXTkghVCEEWUOhAXJ8kHdkUvzmhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921

Since migratetype is no longer overwritten during pageblock isolation,
moving a pageblock out of MIGRATE_ISOLATE no longer needs a new
migratetype.

Add pageblock_isolate_and_move_free_pages() and
pageblock_unisolate_and_move_free_pages() to be explicit about the page
isolation operations. Both share the common code in
__move_freepages_block_isolate(), which is renamed from
move_freepages_block_isolate().

Add toggle_pageblock_isolate() to flip pageblock isolation bit in
__move_freepages_block_isolate().

Make set_pageblock_migratetype() only accept non MIGRATE_ISOLATE types,
so that one should use set_pageblock_isolate() to isolate pageblocks.
As a result, move pageblock migratetype code out of
__move_freepages_block().

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-isolation.h |  5 +--
 mm/page_alloc.c                | 80 ++++++++++++++++++++++++++--------
 mm/page_isolation.c            | 21 +++++----
 3 files changed, 75 insertions(+), 31 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 14c6a5f691c2..7241a6719618 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -44,10 +44,9 @@ static inline void set_pageblock_isolate(struct page *page)
 void __meminit init_pageblock_migratetype(struct page *page,
 					  enum migratetype migratetype,
 					  bool isolate);
-void set_pageblock_migratetype(struct page *page, enum migratetype migratetype);
 
-bool move_freepages_block_isolate(struct zone *zone, struct page *page,
-				  int migratetype);
+bool pageblock_isolate_and_move_free_pages(struct zone *zone, struct page *page);
+bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struct page *page);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype, int flags);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3fae0694aaaa..06cc990e2a62 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -525,8 +525,8 @@ void clear_pfnblock_bit(const struct page *page, unsigned long pfn,
  * @page: The page within the block of interest
  * @migratetype: migratetype to set
  */
-__always_inline void set_pageblock_migratetype(struct page *page,
-					       enum migratetype migratetype)
+static void set_pageblock_migratetype(struct page *page,
+				      enum migratetype migratetype)
 {
 	if (unlikely(page_group_by_mobility_disabled &&
 		     migratetype < MIGRATE_PCPTYPES))
@@ -534,9 +534,13 @@ __always_inline void set_pageblock_migratetype(struct page *page,
 
 #ifdef CONFIG_MEMORY_ISOLATION
 	if (migratetype == MIGRATE_ISOLATE) {
-		set_pfnblock_bit(page, page_to_pfn(page), PB_migrate_isolate);
+		VM_WARN_ONCE(1,
+			"Use set_pageblock_isolate() for pageblock isolation");
 		return;
 	}
+	VM_WARN_ONCE(get_pfnblock_bit(page, page_to_pfn(page),
+				      PB_migrate_isolate),
+		     "Use clear_pageblock_isolate() to unisolate pageblock");
 	/* MIGRATETYPE_AND_ISO_MASK clears PB_migrate_isolate if it is set */
 #endif
 	__set_pfnblock_flags_mask(page, page_to_pfn(page),
@@ -1921,8 +1925,8 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
 #endif
 
 /*
- * Change the type of a block and move all its free pages to that
- * type's freelist.
+ * Move all free pages of a block to new type's freelist. Caller needs to
+ * change the block type.
  */
 static int __move_freepages_block(struct zone *zone, unsigned long start_pfn,
 				  int old_mt, int new_mt)
@@ -1954,8 +1958,6 @@ static int __move_freepages_block(struct zone *zone, unsigned long start_pfn,
 		pages_moved += 1 << order;
 	}
 
-	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
-
 	return pages_moved;
 }
 
@@ -2013,11 +2015,16 @@ static int move_freepages_block(struct zone *zone, struct page *page,
 				int old_mt, int new_mt)
 {
 	unsigned long start_pfn;
+	int res;
 
 	if (!prep_move_freepages_block(zone, page, &start_pfn, NULL, NULL))
 		return -1;
 
-	return __move_freepages_block(zone, start_pfn, old_mt, new_mt);
+	res = __move_freepages_block(zone, start_pfn, old_mt, new_mt);
+	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
+
+	return res;
+
 }
 
 #ifdef CONFIG_MEMORY_ISOLATION
@@ -2045,11 +2052,19 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
 	return start_pfn;
 }
 
+static inline void toggle_pageblock_isolate(struct page *page, bool isolate)
+{
+	if (isolate)
+		set_pfnblock_bit(page, page_to_pfn(page), PB_migrate_isolate);
+	else
+		clear_pfnblock_bit(page, page_to_pfn(page), PB_migrate_isolate);
+}
+
 /**
- * move_freepages_block_isolate - move free pages in block for page isolation
+ * __move_freepages_block_isolate - move free pages in block for page isolation
  * @zone: the zone
  * @page: the pageblock page
- * @migratetype: migratetype to set on the pageblock
+ * @isolate: to isolate the given pageblock or unisolate it
  *
  * This is similar to move_freepages_block(), but handles the special
  * case encountered in page isolation, where the block of interest
@@ -2064,10 +2079,18 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
  *
  * Returns %true if pages could be moved, %false otherwise.
  */
-bool move_freepages_block_isolate(struct zone *zone, struct page *page,
-				  int migratetype)
+static bool __move_freepages_block_isolate(struct zone *zone,
+		struct page *page, bool isolate)
 {
 	unsigned long start_pfn, pfn;
+	int from_mt;
+	int to_mt;
+
+	if (isolate == get_pageblock_isolate(page)) {
+		VM_WARN_ONCE(1, "%s a pageblock that is already in that state",
+			     isolate ? "Isolate" : "Unisolate");
+		return false;
+	}
 
 	if (!prep_move_freepages_block(zone, page, &start_pfn, NULL, NULL))
 		return false;
@@ -2084,7 +2107,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
-		set_pageblock_migratetype(page, migratetype);
+		toggle_pageblock_isolate(page, isolate);
 		split_large_buddy(zone, buddy, pfn, order, FPI_NONE);
 		return true;
 	}
@@ -2095,16 +2118,38 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(page, zone, order,
 					get_pfnblock_migratetype(page, pfn));
-		set_pageblock_migratetype(page, migratetype);
+		toggle_pageblock_isolate(page, isolate);
 		split_large_buddy(zone, page, pfn, order, FPI_NONE);
 		return true;
 	}
 move:
-	__move_freepages_block(zone, start_pfn,
-			       get_pfnblock_migratetype(page, start_pfn),
-			       migratetype);
+	/* Use MIGRATETYPE_MASK to get non-isolate migratetype */
+	if (isolate) {
+		from_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
+						    MIGRATETYPE_MASK);
+		to_mt = MIGRATE_ISOLATE;
+	} else {
+		from_mt = MIGRATE_ISOLATE;
+		to_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
+						  MIGRATETYPE_MASK);
+	}
+
+	__move_freepages_block(zone, start_pfn, from_mt, to_mt);
+	toggle_pageblock_isolate(pfn_to_page(start_pfn), isolate);
+
 	return true;
 }
+
+bool pageblock_isolate_and_move_free_pages(struct zone *zone, struct page *page)
+{
+	return __move_freepages_block_isolate(zone, page, true);
+}
+
+bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struct page *page)
+{
+	return __move_freepages_block_isolate(zone, page, false);
+}
+
 #endif /* CONFIG_MEMORY_ISOLATION */
 
 static void change_pageblock_range(struct page *pageblock_page,
@@ -2296,6 +2341,7 @@ try_to_claim_block(struct zone *zone, struct page *page,
 	if (free_pages + alike_pages >= (1 << (pageblock_order-1)) ||
 			page_group_by_mobility_disabled) {
 		__move_freepages_block(zone, start_pfn, block_type, start_type);
+		set_pageblock_migratetype(pfn_to_page(start_pfn), start_type);
 		return __rmqueue_smallest(zone, order, start_type);
 	}
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b2fc5266e3d2..08f627a5032f 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -188,7 +188,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	unmovable = has_unmovable_pages(check_unmovable_start, check_unmovable_end,
 			migratetype, isol_flags);
 	if (!unmovable) {
-		if (!move_freepages_block_isolate(zone, page, MIGRATE_ISOLATE)) {
+		if (!pageblock_isolate_and_move_free_pages(zone, page)) {
 			spin_unlock_irqrestore(&zone->lock, flags);
 			return -EBUSY;
 		}
@@ -209,7 +209,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	return -EBUSY;
 }
 
-static void unset_migratetype_isolate(struct page *page, int migratetype)
+static void unset_migratetype_isolate(struct page *page)
 {
 	struct zone *zone;
 	unsigned long flags;
@@ -262,10 +262,10 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 		 * Isolating this block already succeeded, so this
 		 * should not fail on zone boundaries.
 		 */
-		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
+		WARN_ON_ONCE(!pageblock_unisolate_and_move_free_pages(zone, page));
 	} else {
-		set_pageblock_migratetype(page, migratetype);
-		__putback_isolated_page(page, order, migratetype);
+		clear_pageblock_isolate(page);
+		__putback_isolated_page(page, order, get_pageblock_migratetype(page));
 	}
 	zone->nr_isolate_pageblock--;
 out:
@@ -383,7 +383,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 		if (PageBuddy(page)) {
 			int order = buddy_order(page);
 
-			/* move_freepages_block_isolate() handled this */
+			/* pageblock_isolate_and_move_free_pages() handled this */
 			VM_WARN_ON_ONCE(pfn + (1 << order) > boundary_pfn);
 
 			pfn += 1UL << order;
@@ -433,7 +433,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 failed:
 	/* restore the original migratetype */
 	if (!skip_isolation)
-		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), migratetype);
+		unset_migratetype_isolate(pfn_to_page(isolate_pageblock));
 	return -EBUSY;
 }
 
@@ -504,7 +504,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	ret = isolate_single_pageblock(isolate_end, flags, true,
 			skip_isolation, migratetype);
 	if (ret) {
-		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
+		unset_migratetype_isolate(pfn_to_page(isolate_start));
 		return ret;
 	}
 
@@ -517,8 +517,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 					start_pfn, end_pfn)) {
 			undo_isolate_page_range(isolate_start, pfn, migratetype);
 			unset_migratetype_isolate(
-				pfn_to_page(isolate_end - pageblock_nr_pages),
-				migratetype);
+				pfn_to_page(isolate_end - pageblock_nr_pages));
 			return -EBUSY;
 		}
 	}
@@ -548,7 +547,7 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		page = __first_valid_page(pfn, pageblock_nr_pages);
 		if (!page || !is_migrate_isolate_page(page))
 			continue;
-		unset_migratetype_isolate(page, migratetype);
+		unset_migratetype_isolate(page);
 	}
 }
 /*
-- 
2.47.2


