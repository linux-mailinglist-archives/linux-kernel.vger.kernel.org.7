Return-Path: <linux-kernel+bounces-736181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12573B099C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D142A48268
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454DE1D7995;
	Fri, 18 Jul 2025 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BufeaRM3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8631CAA6D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805819; cv=fail; b=sCDHLTDbEv3ii42gcwAnD0SzPYnL0dN1DkRVPx8SalM7U4+bqA/u6k9YVcgXd9BhvSJW4iNaP5whKeTE/4gJ7zwQDqHBi6IS9x/mMFDxpc1unNHr7iFKmPIRmv1r+DcjHU/5Or8XHCMYFKrs+gu0s6Q6uawUG1Yx0BSjPIoPqJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805819; c=relaxed/simple;
	bh=QLisbG7f/IEM903OnTG7gX3EDa1+hlyNWVbgn9YngHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sk11NOIp4SH6tuaMGUiBB+Kvl+eoOGFfFfayhKMz+7ssYTlaZp5aybyrvNVs0sLaKVlLqZPIPFOvmpCuVDUni8h7aLZLJZ07j8g/GhYKq0W/2/i5tqWRsKp5cZiYrz7iJls97guJkS69KalqDD1wb86ojsA2PfDvhLak8AMxEyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BufeaRM3; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6V9OtsxMy13MeWy6HanT7enn65xD37u4JiCD5wCPm5wN3+dxvK+97K7zlv7vXQyEC3DCwgG2AwcbpB5XTmv9WtO1kG4wprguAvni8np6MJwWKHVljKm1ccZ4nDBixmpJ+C8qAXdYdX9wPXmGJoIWZxAssKaHZ6xSAK8Djw3mmGQyTNY15PVYAjw1sEv+xw1v1cgWc0K5eRscHDEi2ZF1sggEPzgKTPeuS5dLEcSNLzrAwibJ7mwjGjt19mmsYJcyDyFsk2zL7gQqfR1qYmAKGqjU/4yRUWZe0W4nnnZ2g00FMeQEr0TYAauN5hzX9kC9pIzdMjJkyeh/8azERgpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzFgC5lkrzXX8HmuEsW6EyeoXTEH5WAMP9CM6DwhNlI=;
 b=skWqOg53LYfcLaYZB0aBaz8RQyhHBP8Y8eeuSIPxZZBDt53naHhTey9Hlo+R7Ilkqu9SSaoLMCL3khjz5wgBZE68eEFzlEOaksmZdjkNQWXTN6zAcHsL6VDaSwAKJfFJh3FPzY09KY8VqHjQdSdnXE+fHsmftBo57gxHZbTxWg1x9CBBV/cx/p7JB1g5UE/JPJMjBvjItlSPZUP4UUtU/CLyhYBPwtFFM9iB7vGPieKzV3tnT3Zk1l6au1UfMVbE6TvWydYyXPkLDrMPV/o58d/Li8f4nhxKppCbJeh6TWofbJMvm1RzSZAtaE/5F9dZR4dP7YY+rkLaqPqq6gOkcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzFgC5lkrzXX8HmuEsW6EyeoXTEH5WAMP9CM6DwhNlI=;
 b=BufeaRM362pKTZinsJ52VaagHRNmJC0DqP30HGqdQGDuvKL+Cm+w/Yr1skkmd/D5fxryAevpTxSovlL4iGPYRqPXKWP1KylQAS0Csb9NnP0vLFR+SIuU6+fwIcmZm3mxl1KLEuVG+e2Zgfw2FbKWRfFy3wPnNlX7+wETf40u/IzmlIgSXBfzomI/AVGj02UdBYIp3ssQstffXSLqRK/0ap/fCf7M4ZlOWZbBIRbClAdsHaUVTXj0MkbPSI7rh7w2wWloV6TTpRTdZ2CokTRGO92weg407V4XPyWrFavoeJK8tNh6nWQ2ML7NtBa/qL9Jh7SBvfUirqEZaqFzP/O4UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 02:30:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 02:30:13 +0000
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
Subject: [PATCH v4 3/6] mm/huge_memory: deduplicate code in __folio_split().
Date: Thu, 17 Jul 2025 22:29:57 -0400
Message-ID: <20250718023000.4044406-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718023000.4044406-1-ziy@nvidia.com>
References: <20250718023000.4044406-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:208:238::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eae94e3-e0d8-4a4d-4dec-08ddc5a30641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ms8T+julsVBtK3pR8i4q/NxG0404hbESl+MgMvSz69LRrcv6knJkaja3C8nh?=
 =?us-ascii?Q?qLQIEAyJNH+y+HyB79sftvukD5zV3MQQyXgVVV13Pr2IjsjudWIisP2FN9c8?=
 =?us-ascii?Q?GGGNQJYOb5GdHt1M21aVCi/or6sZfnnDRFM6tZ9zZ2H3ajxjgPTnB0AaF9T2?=
 =?us-ascii?Q?KjcYycIcb1r8VFhBG/oLW1u06No6+wGIUCcpY16pQzf506v5+SLZpllTkQAa?=
 =?us-ascii?Q?MatpsYnaPK/+dqIpRJ2WZirIUS4Lb5QCuPUvLCynQuJyu7FMVruq62X3oSg4?=
 =?us-ascii?Q?NO4BytgkyB8hcKHiZcJIPkOkUGUCgudX10ofm3d+QJ+UAxrVt9Qy+mtoKPeE?=
 =?us-ascii?Q?DJ1EKRpc/iQ9YSgz2WvU4ZugJM+IKdmLp/De4mHR/Uwfqjh1tx8JedDjprh/?=
 =?us-ascii?Q?e+z82GI9M4KSfwbf9oCYJWBHOGcg0hU0F7MCSOEPra1nKU66Rf+xSHEHNSKu?=
 =?us-ascii?Q?9ALCzXkQs30r/oeSTNAoid6bLop20cPb5/HqoOGYJGJlDhhAVu1pblgyLDQW?=
 =?us-ascii?Q?9KvWPKDEOmGwRb1nLXLZUb/4V3rsvHyt1pLYpek04dCC3U0mspeqe+ssA5oD?=
 =?us-ascii?Q?TeCOCgqlPUTn4YxsJxwLsEGF/FmoBHWqFBdwFD/Q7rIHbLnHuiduOocvx7rV?=
 =?us-ascii?Q?Ca8MFJbsXOUWFQMo7kidSqqLVympTmPnJqSxxMVt7auSYrESIiiUOGnTijTd?=
 =?us-ascii?Q?VuQ0Z9DTzn/8T/d108lFPRJkWtCvBmFNRKrveb9oCfbTQakB3sxxi1ijute1?=
 =?us-ascii?Q?Bxhv+VmE0JIilWg4ppicNcHgGPr8KqASm2NKMDE/Mr+QiJDV5UAx7DRnfwKq?=
 =?us-ascii?Q?EEXi3Wqu4AvCq77lyVffAJZv1mxXXVoasFbjhME74xADMv4bbIW8q/nk3piB?=
 =?us-ascii?Q?snrgrucMC5rJ811DcrK55PzOfj18v/GfoSW7/sRMXEWzUQGH3RbtD882VeQn?=
 =?us-ascii?Q?+m5iBLJZzckdWIxS3tPTsvzazvK90vPnRj46wxH8d/pkbPzi9jCA7WeYcp+P?=
 =?us-ascii?Q?e6UOkshQ8u2UB2unSkzqeRlxd4T6RHMt7X9VNo3j3qafXreXDrzBCZyhtXqA?=
 =?us-ascii?Q?FH/keqYEN7vOskCkcL+zpjYzWJ/q7Lad7Vexb2Wy0emgQf8cmPtHJpil6zVd?=
 =?us-ascii?Q?OnU4lD1JSE2k69DttYpj/TOI1+K/xZxhbLzbo8UYGuQnwE5pQ3x5dAWt+LaJ?=
 =?us-ascii?Q?dTUfTy2Lx7itU1RphgPZg+VPsWGj4+bW2PuY/cZn/OA8cg4rPJ34iBfqpzSt?=
 =?us-ascii?Q?85JYUCmV7+1XYjo5Ore0YA4YTDOWHLGC4Oz/PRQ4SdBLjfnn1Rle5Z0UL6+f?=
 =?us-ascii?Q?6AVRYAkeQT9fjiLn4hJqiAHKejTVyILk/6r+qPkhyDyUuoUfMUD1LcdAV/LB?=
 =?us-ascii?Q?a3Yd2UFBg7Lv/hWAvCcnkh/NKg6oqcWwS27noLy0GQHaLreZ0onK/lkC+4x+?=
 =?us-ascii?Q?EpAyec7ITlM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BkrfSLMQ0jxPxADDS+dFmHbPDvMC6gGhFmbwTREqTes7vNQ5azhJDZGLXCFl?=
 =?us-ascii?Q?fKLdP4FPDTkZQO18LN1uOSzTJSx1JZpsCNwySnuaF90C1KOZMdDbOTBLyFZ6?=
 =?us-ascii?Q?hmIc899v/Oviynh2+EzJe9Ki88ALR/NfEiSxkkd5wOmDrhczviuY+Wq6eafq?=
 =?us-ascii?Q?6JlRqyeVXqIWfl4apQBYjiA5R87txphAyCjBBS+HFoKOvTnWkQcjo0vlK0bo?=
 =?us-ascii?Q?im5Evee5mgsbhvnBsVYTMfN3cLhrLFXr4lGsc4BS8jFp3itR5RyD+ehFliNy?=
 =?us-ascii?Q?JNEbe0Cf5essRQbSJvUWylxQ9KWQ2cIwB3SpkHMhH/lKtqT4GmqpF2VEl3Sh?=
 =?us-ascii?Q?k1xBPTQSNoA3485LjKcCiQQiB1ZcEk7QUkKA3zMC0RLfuDntNRQ8pPdFPfoO?=
 =?us-ascii?Q?N6+h237wCxFFadZe+iS+U1af1i3iuIkufPUM3NI3x7JxOXOPHqVX2HoyO8Ka?=
 =?us-ascii?Q?Yd7ZqkZyWXlYsGHlWoVy744YvzhwTS7OLbc4GJmxF1KtApHf7FGt+N9hpvtr?=
 =?us-ascii?Q?ToClWuuZG7jJjGatM15gRGyvf+jl7REnua1rZO5NjqWDFXubPfZnXHrUBsQl?=
 =?us-ascii?Q?Odu7MwI5rAuYiIk0qPAEMvL+TgedQBr8KbkTg9NdG7EYqaN4RVYH7kWTURx3?=
 =?us-ascii?Q?X97hdMKjH9gnsEtrTdwW6jO729vCEwy0jfs2p9e+XQYihRY7/3YSKNSwHnzK?=
 =?us-ascii?Q?LBa4DPTfHHOyr4IBKyLFMx/754GbpqXqY7e60S+/wTYWZWXDLsTXjht8PhWl?=
 =?us-ascii?Q?eAi1IaR/lRzZRCkwH5NMSRIMQ/b+YqeDjlJb93p0TvKZDnc4Dt/9tZVHsJO+?=
 =?us-ascii?Q?DR+ARMvOw9hznQWy/s4dDkFU29/Bg+fldKoa+pTrUVQ8mEhELE4C07rv+UPG?=
 =?us-ascii?Q?OKTWDkOURLOyS1yWKe1o6KNdUBIdTA+SYx268n7Y0szEcicoR0Ymm6C/Sc2d?=
 =?us-ascii?Q?zNNoSQFOjsrso7LCUKAO7Xjrat9OgMgqeHJ9bqL9S+hL3zbe14uB6HcDjBVR?=
 =?us-ascii?Q?LfrGBJhAHG4qlDdDVKKkENuJeU0sPg1cBzVKZN+ipDYnlRjQVjvcUqWfRLBt?=
 =?us-ascii?Q?1I9i1M48e6UGpqNuCbsKPbAc5WwFLWI/9nPon9kkWhR4IX92C16fBiPeEngI?=
 =?us-ascii?Q?wCCGHUKyH4utEAVMQw2mZ1+1yTOdnTSawo8LyKbw2kbShSICgjqBFPQwwRco?=
 =?us-ascii?Q?t/Lny9sztu+V1VpyRPxqfJHh+NEu7cFjCJdvk6Pr7Z44lCDgKGXjbueOGBNx?=
 =?us-ascii?Q?wb2dp1qqaqF9yncE1ZSfbKGH1PcXfWuCv4RMhSIqLPrZIve23SYwI+TD9O31?=
 =?us-ascii?Q?JOY36dYaNnYFUbYycDVyYcvn69kCvgowVT8sxuy7eEw0gZ2uweqagyUFtp5L?=
 =?us-ascii?Q?X3Iwz3RNOSUVnNI5Ck+D4r9v5nzCfp/ib0mANq9vpgr16Ab8b1DPbvb/AabJ?=
 =?us-ascii?Q?A+IaC3nnePx9rHzSAooj7RQO47E1N4gg8LoKWlO9fc+q0IUEsqSWQ2+9Bb+W?=
 =?us-ascii?Q?h4AYTI9FnoavUGpN6UkPiRAm3IiIP/gSeB3MAtaW0xVin3ceUs+pRdVFVoTM?=
 =?us-ascii?Q?2mgYmkLwfxdQ1Bx+yuB0g06QV0bb76FhVrx1usH0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eae94e3-e0d8-4a4d-4dec-08ddc5a30641
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 02:30:13.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1bT+5eHBisbbjm4T/oWLLaD7B05A/VyY9zM85Xm4L1OvA1ehK8blhOOFdG7Ad2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

xas unlock, remap_page(), local_irq_enable() are moved out of if branches
to deduplicate the code. While at it, add remap_flags to clean up
remap_page() call site. nr_dropped is renamed to nr_shmem_dropped, as it
becomes a variable at __folio_split() scope.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 73 +++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e01359008b13..d36f7bdaeb38 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3595,6 +3595,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	struct anon_vma *anon_vma = NULL;
 	int order = folio_order(folio);
 	struct folio *new_folio, *next;
+	int nr_shmem_dropped = 0;
+	int remap_flags = 0;
 	int extra_pins, ret;
 	pgoff_t end;
 	bool is_hzp;
@@ -3718,15 +3720,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
 		struct address_space *swap_cache = NULL;
-		int nr_dropped = 0;
 		struct lruvec *lruvec;
 
 		if (folio_order(folio) > 1 &&
@@ -3798,7 +3801,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			/* Some pages can be beyond EOF: drop them from cache */
 			if (new_folio->index >= end) {
 				if (shmem_mapping(mapping))
-					nr_dropped += folio_nr_pages(new_folio);
+					nr_shmem_dropped += folio_nr_pages(new_folio);
 				else if (folio_test_clear_dirty(new_folio))
 					folio_account_cleaned(
 						new_folio,
@@ -3828,47 +3831,41 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 		if (swap_cache)
 			xa_unlock(&swap_cache->i_pages);
-		if (mapping)
-			xas_unlock(&xas);
+	} else {
+		spin_unlock(&ds_queue->split_queue_lock);
+		ret = -EAGAIN;
+	}
+fail:
+	if (mapping)
+		xas_unlock(&xas);
+
+	local_irq_enable();
 
-		local_irq_enable();
+	if (nr_shmem_dropped)
+		shmem_uncharge(mapping->host, nr_shmem_dropped);
 
-		if (nr_dropped)
-			shmem_uncharge(mapping->host, nr_dropped);
+	if (!ret && is_anon)
+		remap_flags = RMP_USE_SHARED_ZEROPAGE;
+	remap_page(folio, 1 << order, remap_flags);
 
-		remap_page(folio, 1 << order,
-			   !ret && folio_test_anon(folio) ?
-				   RMP_USE_SHARED_ZEROPAGE :
-				   0);
+	/*
+	 * Unlock all after-split folios except the one containing
+	 * @lock_at page. If @folio is not split, it will be kept locked.
+	 */
+	for (new_folio = folio; new_folio != end_folio; new_folio = next) {
+		next = folio_next(new_folio);
+		if (new_folio == page_folio(lock_at))
+			continue;
 
+		folio_unlock(new_folio);
 		/*
-		 * Unlock all after-split folios except the one containing
-		 * @lock_at page. If @folio is not split, it will be kept locked.
+		 * Subpages may be freed if there wasn't any mapping
+		 * like if add_to_swap() is running on a lru page that
+		 * had its mapping zapped. And freeing these pages
+		 * requires taking the lru_lock so we do the put_page
+		 * of the tail pages after the split is complete.
 		 */
-		for (new_folio = folio; new_folio != end_folio;
-		     new_folio = next) {
-			next = folio_next(new_folio);
-			if (new_folio == page_folio(lock_at))
-				continue;
-
-			folio_unlock(new_folio);
-			/*
-			 * Subpages may be freed if there wasn't any mapping
-			 * like if add_to_swap() is running on a lru page that
-			 * had its mapping zapped. And freeing these pages
-			 * requires taking the lru_lock so we do the put_page
-			 * of the tail pages after the split is complete.
-			 */
-			free_folio_and_swap_cache(new_folio);
-		}
-	} else {
-		spin_unlock(&ds_queue->split_queue_lock);
-fail:
-		if (mapping)
-			xas_unlock(&xas);
-		local_irq_enable();
-		remap_page(folio, folio_nr_pages(folio), 0);
-		ret = -EAGAIN;
+		free_folio_and_swap_cache(new_folio);
 	}
 
 out_unlock:
-- 
2.47.2


