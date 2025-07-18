Return-Path: <linux-kernel+bounces-736184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8B4B099CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF274E8541
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC1E1E8329;
	Fri, 18 Jul 2025 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mKDaED5O"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A51E520A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805826; cv=fail; b=hCHA5oRpuh3fsqw6HOe8F12PjloPux63CMgr3RwC9UXfqJ9a+jutUFcUwGGSJ2RoQeffYuQkxcU9nFa2uhZ4XXDnjHm91/iSqdfXLcRrVY6i7O0SvrMtx5g61NUPog5BYq0WtqBJQSeQxH4I4W9QDcPTkV0oxN3UBXxN2dABeaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805826; c=relaxed/simple;
	bh=LsQxspP907f8yNgC1Kp9lmU0/35KW/XQw4G1IMucWtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EvAOx8GBRKodccTfpX24ZLINaESHPJweTP+T6zYY6pNawQbnJRsH/dnlUhYlNdGsKU8CBs49EtP90cLmbxTrV6FFBsurphzfytoYYqTdye6AzwZDgAGicrS49feVcToNIrQ0jWlwUdydFnSl0GwhqLo0OumxG40SQFLwoR/vNpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mKDaED5O; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvseIP0ysuM8VHxCklfGVKdWrktI6k++uy1aAez/PHpVeImgImu7h5CkglHO98qX0g6A6nFINtGarawwaVf9LqI1yiwWPBckte2B7qLilqUP45HV+ph/AOB+/FRkQcE6ddUsf/XsZtW0wiVWeWZv7X6GTV9dgHVgsc5ocrfx/TRIfOq+LcGTwxhFsPoxiqFyMjrmsJtc/HlbXqgktMRsi4Or7AOETltRbFx+qfkjCO9cFPS/bVeYukhkSaenLBKi9KxAyJrV03gGIYB0unvKVGuPfjwd9Cc+J4+qgN1NfHcyjtqLPrf+zDgRbLr/GL60X031+jpvCOsTTdDisjYeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnk5p6QXythh1Tl1yugCWGAHylMIbaGnTn/bEYc3BZY=;
 b=wjdnqCGvEAGoPB6iPoo0PqZgwgtkLmrU9cxGyivIDIIb95A52DfM5crdCTHSblU2uo1Z6B6iqi6pgfyMhE3OwzuAoeqVZNPkPUCztSWdRu14XjlHIpYRGD+Eha07ObD2q1MLPnLoTqH+nxS5Fsm+mL794BHrwOjt/X+vntAs4wMoE2lXpDBcfaaeoJyKCS22NyieskhtkirtHccqAhl6bQHI41leGWsQdbqyypcWg+11tWPh2vDotObB905IWSmXbf8qU2gbMOns/+4tn6zC9Yh1diZAxClLZBwuidvjVYHs6PKjXmwjqadKusvxMoASStmmnizetdUpE7vPgpcEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnk5p6QXythh1Tl1yugCWGAHylMIbaGnTn/bEYc3BZY=;
 b=mKDaED5OsLPvo/RWpxkbiOMI6mukp1Jl4FriiZHbDn6MdJNhVbREZe0twW53pyCPQLnE9esEXIU6A1DqZIkBV6Xw4lRvivvQ49OMfP9HOFQmiBUq4OUjvCSvTWw3szfrAoMozWLR6yU0iO5gQrnrc1RDj5cCijVmAdkpo30IriQKIwP99LiV/iGxE3BvsoHLnIzqjL4CTPLoI/JQACbJpMT/0Fu2g41GcfQXV81RZDE9O13T7jy6uGqrhNfirqp3p2HgJ42EXOvHPiWqddAkayBhCwFxdh/2exd2BmvnTC07/V9db3CCIL+DYVpvYVorvB3OGxv55YlintZ9JJxkxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 02:30:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 02:30:18 +0000
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
Subject: [PATCH v4 6/6] mm/huge_memory: refactor after-split (page) cache code.
Date: Thu, 17 Jul 2025 22:30:00 -0400
Message-ID: <20250718023000.4044406-7-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718023000.4044406-1-ziy@nvidia.com>
References: <20250718023000.4044406-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c54f50-f7b7-440d-78e1-08ddc5a30926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhXYnQ1v8bf8AlF6ncVq6kXxmyn5ulF+64aqvAxo12aocM88Z964bmmcza7C?=
 =?us-ascii?Q?AM58Mb3ZyhZHPdEnt73C7IQzB7YtMvVJtEJx4VJ61+Qximk2MwKQXpmSCFA3?=
 =?us-ascii?Q?k5wLJvs0QKKzilAu63u4kHS6+7uC/7iS71Qq0zLtPfpG8bMFn7luxaJ/XF2A?=
 =?us-ascii?Q?6UecPn0v9ZxdeRm0yivgGK8SzCPBsIasyvb0aKUHEhS7DZhdqFhlaPcw+JAa?=
 =?us-ascii?Q?ntQsc1gRLkZDHSE+fNXCXdGuOlEtJ3zIArwiPG1X0r1soANYWMIsmBqSOuIL?=
 =?us-ascii?Q?O7ijd7YWALDN9JuLzpyIUyL3koX8sQVt1S9Jl77r69neuhCaBZDsD1DjUKZ2?=
 =?us-ascii?Q?YuhsTalL+CqCeghUDclas9y7+yq+ZVUzWiwdDoM/1B1CcGHVQgcM3Iw9Rgbk?=
 =?us-ascii?Q?BecSN4gGuxshfecTjhwpuslsJDqcuzUsyWewAhFodrrQQPa44VR8PJ8Rwd9O?=
 =?us-ascii?Q?bVJnvdY+K1bPDAdOtWHEjxIm5L4K1JhfSzBD4NtejUlmzCvYxs4Crfl6lJnB?=
 =?us-ascii?Q?c+NDnuG8rvMrUWRQuCWeGvP+9r8xKll/dg/TDPaIGpqzzwA9C0Q4NlqCjIjt?=
 =?us-ascii?Q?4jbYEHJ6mmNOzQt+HH+Zku4a6o3IC57xLAh1fV/ZFOToVbTKD0Lfav5N0yrd?=
 =?us-ascii?Q?pG2rNAPwthHqcxfJ11ygawcMsaVejgaCcT54ugM5BcDBGC5JtV655GWVB5JA?=
 =?us-ascii?Q?HlrFSZL+UPmPbRDxIM8ND9GO4jOmX8ryzq6Dt7/pRS44hLLNY08QBBM0oHKA?=
 =?us-ascii?Q?P0Ojkx3bNmUI+nDKG1kdgBoF21VHUG+xVYoZjLQ3Nv11p875p7FHZA45wWjE?=
 =?us-ascii?Q?v/gHv5Gl0vnQOb0WlJ+v54t38LCr4DPQrJo8LH+4EOrUWtustFiRL8GetG7V?=
 =?us-ascii?Q?Cq5wYroYAj+9R3BwU7Z0BifRbHMoPrhUO/vozjc2BiBmt7oGovGcOEDaJSjq?=
 =?us-ascii?Q?33Htzfe1ROo1xk+enYXLRvJiV/ZWveRoO7wcjxThPSS1HVp+ddDaeBPnGZRJ?=
 =?us-ascii?Q?Nu2/Lz2lezl85slkr+DEdAzhV/0pj25zt/5vRajmbTInquunPlZZd1QnsBuT?=
 =?us-ascii?Q?08ObcVbK9r+dJAWBv13HdTQfs3yYPDL9zumk7dZFEZu4MpRmIv+naEzTUGKa?=
 =?us-ascii?Q?XfkUBML/r/xEwrSiH+VJhlebjwW/sGIpp8IuGd7qiaTDBlVKWEIn4hBmCSCi?=
 =?us-ascii?Q?tkOfb+Aoor1fUHm/3ZVJ4y34clJ3fDprOTpqZgbIvLpjSK4djsLdTfBaWA3W?=
 =?us-ascii?Q?qDmtYj/Xg7LjSzoL5nPe5pUVodn9bB/JlAX5JvdjQMmaPSI9Pg50ZcVqobq4?=
 =?us-ascii?Q?48GYdslX4Ch9jXoFrZIh2fQQgVXU9gz3iwSa16NseXotcsAe4c7az09VxGHG?=
 =?us-ascii?Q?bjzMbXnV5Gw8L2NOtCM/I8g63BNHj8D9sTuuTVAEPsHcvn2fG9jbotGbKMd0?=
 =?us-ascii?Q?34m6GIFBKh8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BlKYpfjysTJZHO1O7vt76b7wqaHpQB3fK2t0X7CJFlvn66cm0blvKP5kamKa?=
 =?us-ascii?Q?lc/L3Qp76YfmDTulKIXvyjvQ/Q9i4nWEQhbJtkl56fGef3Uplc8eqUfprZbR?=
 =?us-ascii?Q?0s7YC/y2huVnWkoSDn+zqC4pIoPRJk3m2omKs46R/6Rm/TNwA75WT8S9HyGs?=
 =?us-ascii?Q?M20dhXLo4gYia5w7kE9ZnLrmmlhP3nu4iFQW6nl0ECLY41xgm7xmxPoBxpnV?=
 =?us-ascii?Q?GFTuVhXBxez1sJt4HoNWH24rrpmQP+K+Ge1NfT8kTT81RDF4MJ2BvNrn1RY/?=
 =?us-ascii?Q?fqu5Dfni+C2J+c0lKnZ64D4OZkl14qKR5qWuM8C16WGt0e5BCkmzZXxu2vnB?=
 =?us-ascii?Q?v8G82yI0HJhPLzLMRx+pExxyLv4Tq7djBWBC0BnFuyCLQbsr/5FxI8nIo9qh?=
 =?us-ascii?Q?3WWf9HSaj4FYFAaOBnCg3OzZbt8WVT6HztHoUTzgrYxMW19hD/8O+Lbg1btY?=
 =?us-ascii?Q?Op4B3ScP5XLf1iXeSZxxUWNsGfe9EdKq8zaXQXoFWrzZMWHHogvjs9386E1O?=
 =?us-ascii?Q?Yp2l0c4wv03tjyIG2fxlAXJknwnffFAngVnFxy8viaLpXszbo9Kaen5RrdqN?=
 =?us-ascii?Q?GpA3oqOb6cm5PhRP9P0F5r+weMKrNolGI6BjuB+xEsEphn6ITEYmqqfwrCUd?=
 =?us-ascii?Q?/yMte62F2It/+RtPEVVG1F0ypvXxgeLxFP/BCJAUUDpyjvUwmqsWcjG60OnE?=
 =?us-ascii?Q?XuGFau2widUzGdwjWoNfahQeBEkbXVZgjK3ukPMp9LVIyV90YQE0lJ5/N0pA?=
 =?us-ascii?Q?jSdE2f2fi19u00L25mgBWz299pOweNwLz770JIzUveMlnWMmNWguftH8nkn4?=
 =?us-ascii?Q?295Z/GWhPVDWvknS7NfUm5+l+j1j7TGfmEZBAiUi54WVbaKMdCwgP4wu63/N?=
 =?us-ascii?Q?sEUp4Xvd2QKg30gUDWXmq25Cw/jXh3KKARbhNEYT/ErtOKOsYTyeWVAdaLYx?=
 =?us-ascii?Q?CWNnCqSjccl97esPkmCmwuhGJ0ybO9vp+DleAfPO+f5LqpY6j069IKpMKA/H?=
 =?us-ascii?Q?2CpIFGpPh4iRWqRj13jr/u6A+fCImHGlGZBMszK5O3R1SWCftX59gRHSZf8Q?=
 =?us-ascii?Q?/ybuIiLtHGvkrps/CrzuwB8RVOKbVdqUxOsyqcozB5P8rgFvpFSV9ju0/+N/?=
 =?us-ascii?Q?YQNUIhEk83nS07bEnUwxttNSQdnnzfGrXeVODXqrA+mcd+fXHLeRqckjat0g?=
 =?us-ascii?Q?G8oMlTcUpp5Dst4IPGyUxw+f9rcPCYRk5VDZsyx6F7B7ADJ5nJtT/nlHfska?=
 =?us-ascii?Q?vXifRru/Oc390e9bBH157bqMObYZIKguxgpkAiK8tAGSlqdDCY0ZKHNp+ZRt?=
 =?us-ascii?Q?T2DHuc5HXRpINYj73PpKmlXj6Cp2Qtud0WwZk0aSMR5iwhX8VuzDu/JJntx6?=
 =?us-ascii?Q?vIs+ZQPtXRNDGWltbdJ0ra1YIHja9N13fNmnuF53gNOI2M1gE5ptQMki/yov?=
 =?us-ascii?Q?ibD7Y5SwzmtgMqVOOxj6Ay3jrx55MbFeCVvUN7F2QlN5QAXX3NGC0PJfryX5?=
 =?us-ascii?Q?xJsdc7sPD9EPK/N3i2xRjSD8OA1bvRO27P52YAw/YmlAC+i3KvIghtuFmIu1?=
 =?us-ascii?Q?pPbTOSAg6MkMKhM6hVD4jvJOhwV/BrVMvAByW2o4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c54f50-f7b7-440d-78e1-08ddc5a30926
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 02:30:18.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHwGFBXIqF0WG0sqd89jkGmhKneHqYEDQDM7B7KfZoCM+kS2ks0D5KwDHgV3h6BK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

Smatch/coverity checkers report NULL mapping referencing issues[1][2][3]
every time the code is modified, because they do not understand that
mapping cannot be NULL when a folio is in page cache in the code.
Refactor the code to make it explicit.

Remove "end = -1" for anonymous folios, since after code refactoring, end
is no longer used by anonymous folio handling code.

No functional change is intended.

[1]https://lore.kernel.org/linux-mm/2afe3d59-aca5-40f7-82a3-a6d976fb0f4f@stanley.mountain/
[2]https://lore.kernel.org/oe-kbuild/64b54034-f311-4e7d-b935-c16775dbb642@suswa.mountain/
[3]https://lore.kernel.org/linux-mm/20250716145804.4836-1-antonio@mandelbit.com/

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4db67970ae69..19342660739b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3646,7 +3646,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			ret = -EBUSY;
 			goto out;
 		}
-		end = -1;
 		mapping = NULL;
 		anon_vma_lock_write(anon_vma);
 	} else {
@@ -3799,6 +3798,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 */
 		for (new_folio = folio_next(folio); new_folio != end_folio;
 		     new_folio = next) {
+			unsigned long nr_pages = folio_nr_pages(new_folio);
+
 			next = folio_next(new_folio);
 
 			expected_refs = folio_expected_ref_count(new_folio) + 1;
@@ -3806,25 +3807,36 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 			lru_add_split_folio(folio, new_folio, lruvec, list);
 
-			/* Some pages can be beyond EOF: drop them from cache */
-			if (new_folio->index >= end) {
-				if (shmem_mapping(mapping))
-					nr_shmem_dropped += folio_nr_pages(new_folio);
-				else if (folio_test_clear_dirty(new_folio))
-					folio_account_cleaned(
-						new_folio,
-						inode_to_wb(mapping->host));
-				__filemap_remove_folio(new_folio, NULL);
-				folio_put_refs(new_folio,
-					       folio_nr_pages(new_folio));
-			} else if (mapping) {
-				__xa_store(&mapping->i_pages, new_folio->index,
-					   new_folio, 0);
-			} else if (swap_cache) {
+			/*
+			 * Anonymous folio with swap cache.
+			 * NOTE: shmem in swap cache is not supported yet.
+			 */
+			if (swap_cache) {
 				__xa_store(&swap_cache->i_pages,
 					   swap_cache_index(new_folio->swap),
 					   new_folio, 0);
+				continue;
+			}
+
+			/* Anonymous folio without swap cache */
+			if (!mapping)
+				continue;
+
+			/* Add the new folio to the page cache. */
+			if (new_folio->index < end) {
+				__xa_store(&mapping->i_pages, new_folio->index,
+					   new_folio, 0);
+				continue;
 			}
+
+			/* Drop folio beyond EOF: ->index >= end */
+			if (shmem_mapping(mapping))
+				nr_shmem_dropped += nr_pages;
+			else if (folio_test_clear_dirty(new_folio))
+				folio_account_cleaned(
+					new_folio, inode_to_wb(mapping->host));
+			__filemap_remove_folio(new_folio, NULL);
+			folio_put_refs(new_folio, nr_pages);
 		}
 		/*
 		 * Unfreeze @folio only after all page cache entries, which
-- 
2.47.2


