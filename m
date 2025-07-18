Return-Path: <linux-kernel+bounces-737280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6C5B0AA3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002841C80E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E702E8E0C;
	Fri, 18 Jul 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MxP1oNth"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832042E8DF2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863883; cv=fail; b=krFWcpfdw6KLZupsYPa1q0vOZ/OoWTwobBrZX7lvdD+3Vus7aTphcr5tKF0Eu+o90JtQt5dNOFSA/Z+XoEseF3L1buJqlEi6ovgO5jOzbpteoGW/4vjyYZGADWMzq0gZfOcWysgN/NWpAFDJOBZO3AAKhtwvSzjpF25AR6oLQ2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863883; c=relaxed/simple;
	bh=n4ldQO6IC3XLk2s6ig0BblQTTZRXGMMAaRHzk9SPGOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BEUl+IA5uAg6p09uQ28H7szhRS3raEHw73dApGabvM44kQTC/17+PzOyZP0TqJXshVzCxdxKpEr2LA0h2DDWrV3xJQUCuESiofKFrncLu0IYqXFHXlY1jiWibUInhJRIoz3/+Y2XufjURZWTt4pESf4fPUjtsrrExjNOA2bruTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MxP1oNth; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfBuNk6IYkcHhurFLlQb4efbdHdyVcLsYcncvfQXabT7/bqqy30goVuR4ZtpRjIFJ/YMBIc4zeEUcLUre/CNrzjO4BFk6dqupfIPHrXzJQ6aqz4l4uvnbLRPr8lScAKtxwlcs0wL7WvAFXO4Ad9kkV/C9u+ysII9NHziqpzX82roqQx3TJAxrkbtxXkg+Ib53TPCJFU3r7S+lSp1ZeWyGFQuYzIC4ABHW5+yGmfW1VGe3g8db+gacpc8YG+GIS7jNaZaOaqdp8AzTJj34U86PioGwOwEQNYNUMw1/GdB5wN/1Fh8eOjv/dLRvS2xoC5PV7AETe6v7mohsm1LXk4j8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txUXqNC2N8SSNuJurX1gkuXaP7+FtImoaZJkxMD7Li0=;
 b=Yp+pX+jBco6Z+42+dtw/QCzAzNbL6MKnecCorYAJ4QNNjlrReoBa7OpU8Tq2XCuziu250wd2WE2mQy2MVYQcUw1porqYJlEJquDlrlt0Rk90U5eSive9I3oM/EbBivDyn/8WLRRnq3xRcUOdNTG5aRzLoW2XgBZgvuoquW32/fHPQwODZ0MXni+XFI2Q+qpz6fY6Dt1ZPhvhAQnxEGG6Wnce3ksmPHo9U8uybB8sNMUTm1jFoj2hcz1ve3wlqVv+x/OrQ3/d6iNGX58gG+m0LH2pH6pt1AaTlcDsdUnTzmaGhkjEmEeB4tjuCIwbR5wLAJKS1qNSCqN9NthzONJR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txUXqNC2N8SSNuJurX1gkuXaP7+FtImoaZJkxMD7Li0=;
 b=MxP1oNthQAt6ZLAyWm62PWwAmDo0qBkRGCgdgffdw7t8Ts1H58ZkOEkg/0HuTDkVk2MPF88HKdZle+l4xcHebXo03Lpuf96j/irRHGJJbDQTEfNI7FtpYGFZyW2pBoQpzM9HpRPbQ/QtHY9/GmliWN3qBQD/Wo9uqWCwXyPYAmO0EOmAgWsuxTBC1yhzwNQMomjknei0ZQLecMpZPzro6rX7a6BbWMIPrV8MrBnlEaWyWIk6X25EbLA9gbX+j1RO6gFVp+LIjmknPe5OqHFAWwWis5i5gJ4D0vzL8qPgG1mkwBBNgja1j6J9WjuuF/u9q+56bFEP+AEi9W63vTgvGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.39; Fri, 18 Jul 2025 18:37:55 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 18:37:55 +0000
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
Subject: [PATCH v5 4/6] mm/huge_memory: convert VM_BUG* to VM_WARN* in __folio_split.
Date: Fri, 18 Jul 2025 14:37:18 -0400
Message-ID: <20250718183720.4054515-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718183720.4054515-1-ziy@nvidia.com>
References: <20250718183720.4054515-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:208:234::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d56db4-72cd-4099-29ba-08ddc62a35ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kcz1kfwzwP/gpaar+hMr1Vk0O+KrwmmXl9TM7Ol5KWTY0dcrzidHTq+YpHI+?=
 =?us-ascii?Q?v+0rKndQfglbfKKkuPAS/32vVIix4yDOjUpKQDCdd3+eJvFkHLFhUQZODysn?=
 =?us-ascii?Q?fznHhluyULmY8JrBqK0uy1r0UndLq3+p0lPcgftjGbimnnxtme4tBQQsH2yX?=
 =?us-ascii?Q?XH5aUnBBBDXKH4y3Hi5w7wHZrT49u9GIT9FRHH7nRegIaytDam83ZGwDVoZM?=
 =?us-ascii?Q?EuN4wTi5K2SObZPnmfcEGSmMehsZs/MBYwJcAN65P6Omv1ffDq/vzNFmEPvR?=
 =?us-ascii?Q?zX1XKH7hVZC3BoKcAOo8hNLiHKdUu6zYkaG+SxH5sfzC4cdsuu6/7cY9SlCv?=
 =?us-ascii?Q?rPdsn9upC9n+qGtjKfzpISxsyV15Z37MkC3zemJ1C5iucgLcPXtnIcrh0li9?=
 =?us-ascii?Q?G8lBqfwhtc1w1YHhCHFbVlux9mNIJ8HN7HHiCBMmIzj5zHB5mUuEWxSYPIVt?=
 =?us-ascii?Q?MExBa/7QYnefVEfl/lgNSYCVO5cw9eABcd1bTA3IR4EQxKJ3gcBKgVgo4GPt?=
 =?us-ascii?Q?eSqImhP++EUsbI1o2TseT5mUemUEnSUgfWEsRJwxuBZrsN6ouUbnJ65FpaRt?=
 =?us-ascii?Q?YNwYQftJJAfD3OxdDfbDdWzYB0/HKhjctm7NhGEzqgofgyLNPRautKuyyrit?=
 =?us-ascii?Q?EvO+5Yj1gLGRAt6ZOhJgIPOjVmsSCFbswwwBHXZWnRQ1NsUFVa4q4Yhkqcw2?=
 =?us-ascii?Q?SagGP+Cs63U7JNNEgVFD0WU5MKiDaBVaBIbxHQMN7IBwcqw+ALQvkjAwL1J/?=
 =?us-ascii?Q?qx0TeEfXmXSd2pkY0H/dNXWa8+Dm4F+DYH8X8etEqWg4wPhyZeqn9h4x0JXc?=
 =?us-ascii?Q?1OfQrxdNlqr+/UprhffiYHE6iSrzFc+CgBBHGxjqX2oqKnOrWIQvQ5VpfIQ2?=
 =?us-ascii?Q?01VYg5cb5KE3VrTyP0Ky5HNw27s9JRNzjg343L9oF2xCM+uXjFjpqPe7yOvl?=
 =?us-ascii?Q?A8hMh8LM6tPGMmTRpbUKaI4PZMz2bY0DNFhTWqiKCqWal1WwaV/EoDKpKFep?=
 =?us-ascii?Q?QqY/TJhaTeqvJ+YnLAApwtvxSNk+fQ4KpDwBUZeQ37DY6kL7F6+5WL2YI+uK?=
 =?us-ascii?Q?WuGjyMP/oNQ0W1T/AZda2flqJCKMoD8VhP5/1h140gHw8FSoC0hG92g5T5+R?=
 =?us-ascii?Q?MjlUFQezIBhn5pyCQdRUfYWKBiUNK43YK222bevwYcgRd1GV2nRiKl9yZ3Ov?=
 =?us-ascii?Q?ie9NMGdIxIwZN1tk5uWoCiP6Jg075ECh46ZdtbNAdxwy1nmjTX/YwofNTXcn?=
 =?us-ascii?Q?ZVA3R+jkVRYT4F6VBezv5jKlyN9N2BBY0vn+Zx3tJOQ7xZcrhxpe7skkD9rN?=
 =?us-ascii?Q?VAynb7NALZBR4f/z4kqe8sVkAtMCalIJYfLRY4F84cZ6GQcZBahq9UqLJnd6?=
 =?us-ascii?Q?fjFMM/RssRNN3azJM5cr3F0Sa9JXrRMI8zc8YPoGDlyxzNfD/gyFl0BszqQv?=
 =?us-ascii?Q?VWjrWkzoBhE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Ew9pkcMcEBU58cLK41qjqo0lalNXU6okq6KXoQFC5tqXSGhXhgWCCt8R33s?=
 =?us-ascii?Q?MANN6+LnAQD+goyuCn0g9pQaELiPA0RGAaUaddXlFxJmBxSPUFHiOYpeucok?=
 =?us-ascii?Q?SVF383wmzFFVJOvZTIFBmJL/yUa+nsCV1xX37VMhs6pPOXHDYpj7SF2n1c2N?=
 =?us-ascii?Q?/c58o72nUGYdISFm5F7ghSWm78EzyEUfd2K5kFIq4QScTKk1HzUDIY/JeOrM?=
 =?us-ascii?Q?IzFfqsOj9AllfRDJ2ufnPh7HCNfModw7iUiIccw2OUz2Ce5L1qRP2nIoNkR2?=
 =?us-ascii?Q?sOX1+MdYaq4mKcpub0Fy17tdYJoEoMoTz1XDrGM+JScCf8gxpuwwkoj2oK9f?=
 =?us-ascii?Q?mi4THuNIu79Zmc9jkEI6dZwic1Ub7NnVtImoBh44+jnJiVEfN/LkpPvmK5Kp?=
 =?us-ascii?Q?X/YvCm8ZXrT1g1x+a1+KwVKs08pU+WOD1XkpeEe5GuTNDy9D4xfLGGokQXiI?=
 =?us-ascii?Q?MRmb7bIXBl3WNo8eRBxqDGoPvRwu13mphs/mKzB0eXlRKMvgQet/qdnXcp7g?=
 =?us-ascii?Q?Qt+gfcmjAKZBECLM0wh8IwkNp7N/0hrbzJ8AjthhRt5fKFrximA1Dcv6rcak?=
 =?us-ascii?Q?gt3PLP4K3ESciF+8hHFLJr2PEnMpYujWEn3OAjgROnePhOGCt5xb5UvGeU6z?=
 =?us-ascii?Q?OB0PotrFdeLkAAjKIh4ZdwqYA/WS1E57Rudu8JeHaUy4uwvqGqj7PnOsPzwJ?=
 =?us-ascii?Q?dqhqOZ6jU77mNKnFkFw2WEa0DCTi0E7BrI+mhQB8mcL1mv82LvW+A28S0K7S?=
 =?us-ascii?Q?QCiDjIuwPgr7q3IDsTn1Ln967NlKVk2DOR75mkZb9M7jVAV3pn5nW65xmNTo?=
 =?us-ascii?Q?1uccb4C0FNGd8p33C5tTUsEZtGsI9GyMekE4SQIysOCQRSOwPzcLzDtUXNF3?=
 =?us-ascii?Q?UjsVUzteEe56Z+Z1QdQc8Cen9Z2PEAwsTxgA+4dn7kaLLlUHM/7cy1xfu4tS?=
 =?us-ascii?Q?Gr5IMn7+ailREtN1aFMoFAZGGPDHKE6SQvF0l3uwX15sfEXoOPG42jh7rlbb?=
 =?us-ascii?Q?4q3DL3CtngxNNqnKqjyGC5BvfRu0LMjeF6SzGrf0qBsLACgInEQk5zrD9DUI?=
 =?us-ascii?Q?rEeYxxegA5aMa47IrrIhoRYagmvLkrLlL6pBMOfcfRZGaAwDHzP67qUA0Ojo?=
 =?us-ascii?Q?jyYXfNIvZwxVWOBIaz+YdWpMpugL9ARvQvGzJzTuAyvXNZfOqg6DiPI5mhkE?=
 =?us-ascii?Q?xsOw4e1qKPEsNC8g7x8rns/4qMLPfd5AkV4bFcgcS3yx4+mszlxBvQWfeCsF?=
 =?us-ascii?Q?xezlfnvOR8dsaIDh8TdXsDI4+GYdNRfT9jkY2iKeD4SB95KXN3DYviN7lODW?=
 =?us-ascii?Q?uzFKLCgcSLtixGukR0PwUiMyG6iDVR5GKjEGb3ox5Ip106MizuH3j6yda/Fd?=
 =?us-ascii?Q?KekT4+cafOgxg8Kg3sXHOV3C8m2RHOdeDrA/Wv8re/gI1Lv9LfA7PmV94Nkv?=
 =?us-ascii?Q?e/HFY/ukpU7piAsj0dEFtcF6r1Y8iyYSnamlMVR2hUY1q0XzyP4LTOqP66Yv?=
 =?us-ascii?Q?kCkcQ2xvVosG4xNPi4UlxHOoPKVf0vE9Q/AzCkwORFVzcA5zH9Q7wVk6db4L?=
 =?us-ascii?Q?naQPmOi1ImEl5nab+iRXZLhypCLBw97KaWGnAByM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d56db4-72cd-4099-29ba-08ddc62a35ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:37:54.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJr8AwuDxDGhjHvnuwqBBU73hrpZdaGNV8nHaOIjKAb3yUPpI08QvpW8DWLkTQev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

These VM_BUG* can be handled gracefully without crashing kernel.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d36f7bdaeb38..d98283164eda 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3601,8 +3601,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	pgoff_t end;
 	bool is_hzp;
 
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
 
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
 		return -EINVAL;
@@ -3766,7 +3766,11 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		}
 
 		if (folio_test_swapcache(folio)) {
-			VM_BUG_ON(mapping);
+			if (mapping) {
+				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
+				ret = -EINVAL;
+				goto fail;
+			}
 
 			swap_cache = swap_address_space(folio->swap);
 			xa_lock(&swap_cache->i_pages);
-- 
2.47.2


