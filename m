Return-Path: <linux-kernel+bounces-737279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6782AB0AA3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A271C80F51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610872E7F08;
	Fri, 18 Jul 2025 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UqgiKzVZ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18EC2E88A9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863880; cv=fail; b=g2XnwVtT7KWo8uVtfJuVf8R5AiVjkpVIojXHCYfKP8FVoOGSPMlInfndcVm8xbXs7pnXTuUrUKmlDvQgxAbZ+xZ9qcxKTOvA+1wRT0hQrpNJHY8lWLZ/CuvQaPlWU1TnLjqMedpdMJMv/MeOaLGCSd3cDAYGNk7NT/w5BkkHTLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863880; c=relaxed/simple;
	bh=RSjz5ibPdeALF7k3vxsR2jhTkaTQAf1IHnmzyYRfW6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmvUf3WO2CqgjhDFCnd2RcPoxR4UGfVdHagN8HMoBEZXKuRgCfIZulchReyHl532cgr47RtSHmMlCpAoiEscv7uPqbCwmP5NrAYhU0oHrL6F23BlV+UwkRtCBIt+kZIcsrmXjCm7C2HuVqDF2uc0XIfKCni2bzwfpuXbU4ZL+XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UqgiKzVZ; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVxSX9+QVm4Onn+wUARR27dA/BCkpfQ8FmoKDuEjZxXrlMfu/FuNj2xNVEnekCek7eRi+BfyruQHVNJQFllpYIyQ21nM/Ap4WzPblP7SkfTm1bqsMTCYVRdRt79yLM3NghRltrHXtBZgYWr63PNeRapnApsZpiPLqwrqxX+GpI1JH4EPe4/CRbYMUW+jg55nYl3PnCLBesWTMGhbVjyhQFBHS84hngAU+huhG7YZYsGpe3S2HadeAbl2l5cmrCUKgdeJCk71t+rR/REfMx0y3lVlAu/rIA8iUwDPz2vo8JgFptzRt3uqfpEGCwtMn+5L7exEj+fi4Y/fmcKBGzARfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l79qGOhvqKbUJA41BF4RwtaZz7sWuH+Izb86my/dEw8=;
 b=l21swLRius3G9BTYvTuYh2WhzBpgxt/367Wq9jLNuSVjXjLRvKolQ7mNhQl8GPSSoTf1SOC3oqTqadaPW53qZOd9WbLKBp9BbYsoyd/aD+OFqh4KdQV4X+CWx6P3fLT7d5/FJwy7Vk1ZzIqdbFlnEFuMFpQjjd7tcJZtW9ZWqkNWIbU2Udhh4Q+/iFYjhaMdU1oCPHeM6a2/70ilHAwqWAWPHQMjzrEW//hA48oGU4/8jZSbI6IR5TF491NiQgXngDud/UsM6CLeuufOZTweLolGQmbj/floG019cBBuRawCMSKsXwjAU2R22/3jDJyHcYhQvRIt7aa4H1uhe09emw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l79qGOhvqKbUJA41BF4RwtaZz7sWuH+Izb86my/dEw8=;
 b=UqgiKzVZjSfpK39usc1HPVHF5rdTQupPEdPrulVYl0c6BToG2M8Ak8P7URNw+O3xXw8YEPmoV/6tOlMENxkMQ13kwZWQ+z8P4MDupuO5UJz9b/bDzX9wQup1N4FF+r9OEtO82Y8ZZfvWTjy62HIEPD9yiE444no2e6HA93Kn4hSARqojhc7enzE5yFEhxFG+to3yQZlbZ3RPS9qhabifjXZaPehOyc+cuk/t2u2hBD47NUmWSw+EgLLhIHYDbFvFHE21ASTk6OTrxSUH+eOgeM+glMBMVca1xE5Jg1tnMKjSLQ27hiUMvC6R4+KVT7QjeKHHrHx3CRUYElpiSGPaug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.39; Fri, 18 Jul 2025 18:37:53 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 18:37:53 +0000
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
Subject: [PATCH v5 3/6] mm/huge_memory: deduplicate code in __folio_split().
Date: Fri, 18 Jul 2025 14:37:17 -0400
Message-ID: <20250718183720.4054515-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718183720.4054515-1-ziy@nvidia.com>
References: <20250718183720.4054515-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:208:234::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: cea87a10-081c-4701-b1e3-08ddc62a34d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DS2+wfka33urjFMKE8gIu13MhWFBofEra0qQSswd38jZjZ8t3vzQXuO0YaNu?=
 =?us-ascii?Q?PHQ9Q1j54Zc6Pgz3qKThjFgeLNILwvOq8UWWs2m5yBfarfp0t0T5RAgZb0VS?=
 =?us-ascii?Q?lxtlZusDEk2s01vU1iq6GtvogH89vdTJJvY27brEyxV1togEeHBlS9lD+Gv6?=
 =?us-ascii?Q?3PoKHQ/bzAVs8ZTag7veIMtH6t0oUIqQ3blLMw2wLbPDZLUfGU/dsNXKQKKA?=
 =?us-ascii?Q?kKXxtbRj/nxN5O9SDfKKmMbOrgL46dkv00cLFaudMoIbjnau1hmkkxftNwVP?=
 =?us-ascii?Q?GfLA2PUuXuY+Kx5RDRmHhzDlZ5Afd7ODz2LyJEkLaZkYcW34dBsWQXTH4Q2p?=
 =?us-ascii?Q?gMRMb887qLHB6kZNeRAojav0M9WnewQDK1ywwZi5mqzzo452w80s7uYyGZNq?=
 =?us-ascii?Q?hgptjk5mNrSFATBNnZCWp0jgPh2Dcu5JTedPuI7avLc3sXQD3UhtjkkT17om?=
 =?us-ascii?Q?LU74oFCbLT4WhNbp57XM3bqBqDX9/vnKg23b9mkEXahd1ippLZSR9ywFFcvc?=
 =?us-ascii?Q?mKsW7pA470//VsDADuiZfQMnLH8CD2Z/K+Kv9/KSjaNctWC5AEE4wQ41e6Mp?=
 =?us-ascii?Q?s/XcYIrsZS9OgFm9JVruKCPnlQvuSlygL3+JjIkiGeQ47MTSHESvy8ZtBwId?=
 =?us-ascii?Q?RVV21RZA7ptZyEA8yHvVkA1bLELXZ+CTkdU7r5W0TsLdGToD9/aWwJ9nJT/c?=
 =?us-ascii?Q?DSSaih6x9qXtk+866MDBBooGY+oDNkTTyySMmJI4v54v1a9tD36djBjA/DHm?=
 =?us-ascii?Q?HyHJaY6wRJXWlEMBL1x/b/NbxYBxQ9U8EqeZdemczrMBnZfiv9ySrHa9xONE?=
 =?us-ascii?Q?EdiJd7tQM5cY+xQJevzFHh8jbF5cq/X6JwbHcpHk0qHuQTr4yw+Fpbu2A+dw?=
 =?us-ascii?Q?+x2DfYvcHRdz8VV7OwdNk3XrIsZQQW7/kqy9FGAmTOfTl+Pi8UdWZ7dAWIJB?=
 =?us-ascii?Q?HFC10kmPze6SFvac/CQ4VuGr5qgvoWshluGRgzZeKWIsY7njJXI9qHJBd6eJ?=
 =?us-ascii?Q?RuigDvLCk+WvICqDBQnnqwUvCqOrmc4d4x7wRtxMN6peGGY2Du/ouMRaaDBS?=
 =?us-ascii?Q?Wf3NorArJaCvY7VjaeeRpqli3rEjdgBv/eCVBmLlk887i7dkzsjii8C3UNLM?=
 =?us-ascii?Q?IqfjYhBiKcw+Wz5joDUs86bCWBfTDCiOMRN0Us/UGL1ZCP6CksajT31XIcWr?=
 =?us-ascii?Q?bI9/RNuqUUDRCo2ZMDaOngzZnvszWqQ6S8Sdm6nPrnRWnFyjIknCsIRJe3MK?=
 =?us-ascii?Q?ElZ+W9kfEzO3UHjQYyA7ZWUQXMsRE0Sp1W1ZRQXM0/VSORYbu0/HOCWdlANP?=
 =?us-ascii?Q?Ebw4JE+g4owOdZ9YVXaUYKFS50vBmb4MnnR7U+xssYvS060jMN53Nz0FvSMv?=
 =?us-ascii?Q?6eqpJlPVWPgmqwfxwaAlJmPiea2Ycj8bMt+OknDMmQyg2+aTvnf+oRT3V0oS?=
 =?us-ascii?Q?BnJj4N4/PnU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NNQv0Kwe3csay/ATnYABClRjMoINCJoAz843VFs3st4OcekLtDMIDd9hRbxZ?=
 =?us-ascii?Q?YdPm/NWfkfZv8KtZqwO4aTP0GXBfHC2P7GSD7cN9XDz2fUbb4U1iaTnYnxNS?=
 =?us-ascii?Q?zsxvzs+c6bFNLY0ejmb3li8UEeAlAuA7B5bLuOl1YH4U+oSrjYnBbMl/P3FN?=
 =?us-ascii?Q?cIsSTBK6/SH21uci7T8KZfRsItsjccwIyDrL4FgArPTGsh+ITW/4mYi6+0OB?=
 =?us-ascii?Q?gyXLplvcre1XFa8IrKKTKedUhghIFaEolzKOTpx38/CG4+HgtUdqRuakUg/0?=
 =?us-ascii?Q?xd50X+mq7hYsshXe+BBZIkK8CFVz7H1uWhy43BMHm8yu3RxGCZRinxQzJSuS?=
 =?us-ascii?Q?54r1mFnhaU/JoTO2UPFevFTb+DLZP9Ksk7VXabTgUn3ZQPhTz9GFpiGc7XAs?=
 =?us-ascii?Q?o0YPkF50FVYM5N8Ll84pgLxJ7V3lOTRIzaexFDyU1VpZoSCFUr6kMvSvMqby?=
 =?us-ascii?Q?xzuG9mMVXqxc3J+TYjsOm7LczW5fga3HJUr4GPt0wi9ocmaJc8wJKPwGikJ6?=
 =?us-ascii?Q?1mRbqpIT5gK9rpZUnrM/Vck5DxpxCR8EkBdbMKHgq+mcnO9f9SNvdhh2edX7?=
 =?us-ascii?Q?aOrvAye1yaOtJmMIFTAyQZeky++OAjikEqHEG7ywAqIVrgfjEdf5QrVFzh8+?=
 =?us-ascii?Q?ziXl9VALXFCqBdu44wk5rkM2ogA9wi/ueWnvIPoWQCoqBCQkAlPy1Bwc+xj0?=
 =?us-ascii?Q?cMZaq3EcGT7Mzjp+LMoLFeuShg8UoB2qDz4HVlbnvM9iHqFDwMPURjJSehoH?=
 =?us-ascii?Q?UsQdeB2pcgE865ANeEk3x6Yi1fwsSSyhfAWleqZyCW1VGr8n7CF+DVCjMzGo?=
 =?us-ascii?Q?tcoEL8GxFnyUfxKBNTAxTOTiSlUBW/qjqTxgT5Ni5I9iQnAYagm7b/+V6MFS?=
 =?us-ascii?Q?PdpnIycFifec+ZcnLrjPT1+nNiakxR089AbXEWFyvAmXNBudVMfMBnYk9MXz?=
 =?us-ascii?Q?zzP8Hy2e8NbJShiFWDTAPClL9oZVGAdUwJhx5YoTJjACD0EGKpNTEPkkvwGq?=
 =?us-ascii?Q?olBnj62O1zTRbBPc9t0jzuZyc6RZSRVXvGNIxt7vYpAFlt3QFyi7LEZZ7XJU?=
 =?us-ascii?Q?mjNtbX789w5MstW5bY/hIBR8dKyprOuzfdRc0iR3tRVVRMqju3bWkPUiHG95?=
 =?us-ascii?Q?ikbZ+IOkDXKKQp1xbR1QA+wHlRi9TQ0p1H7XGaNfOFrZIfpYU6zddWbsz/UH?=
 =?us-ascii?Q?xAF4ITsqRzZ3bG1S1sR782suafKwfGQ5bv/5RSL+sS7Umn8wRlUerucEIymg?=
 =?us-ascii?Q?w1IMlkLpjq/dshAf0PiBv2Fx/88eigyVB20olgOLi0f+JcBae1YZYdGvXP0j?=
 =?us-ascii?Q?Ld8Jvb+eaqAIw1cKYCIACHpi0qbLTBho/wR8OtjeJQERFazM1CDb4piCn7kb?=
 =?us-ascii?Q?COB61SCxZ0bi7nQFQiqWr60rEaqgpAhLI1LFH78LhodrkoGTrVaRN932dRcR?=
 =?us-ascii?Q?6SM13aJWcIWobU+lUHtmKjy9LWD0X4529aeoGs0l7q7cntaU078PXOg4WNdY?=
 =?us-ascii?Q?N8rK2foikboJvmEjLFWd97+1ySgJG9WeI3dM1sjhBW79jrW+xO+iH8O6bxcJ?=
 =?us-ascii?Q?F0SVLkEaq/oDUUg900V+Ovlj7pDrpAdKPtTOZufY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea87a10-081c-4701-b1e3-08ddc62a34d7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:37:53.5025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URk+AAZvxekPVvcEqIml/23Ti/C/kQ2xwKtIErd1oeUzcxaMc08bjZkzhAZ16bx9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

xas unlock, remap_page(), local_irq_enable() are moved out of if branches
to deduplicate the code. While at it, add remap_flags to clean up
remap_page() call site. nr_dropped is renamed to nr_shmem_dropped, as it
becomes a variable at __folio_split() scope.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
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


