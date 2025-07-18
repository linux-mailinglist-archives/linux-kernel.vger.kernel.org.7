Return-Path: <linux-kernel+bounces-737277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C220BB0AA3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1EAA44EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDA02E8880;
	Fri, 18 Jul 2025 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YGd7efLQ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA422E7178
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863876; cv=fail; b=pcrWcK8pT5bwuHpCPK/KSre4T7bAbfYcOXiUI8AZYiNec8D86t3HQyikf8n2jX6XUUSIU2Al/Zxn8DEL8f6v7zlWt0Ol2sAU3+pxdjMamb+InWayeFFFaO0jyaBImmk9fYTZtQTEYaM9LulyReG7dZQj0S7YR98gQc6xtMCcX1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863876; c=relaxed/simple;
	bh=r+BFGTV4FfkHPXI283gW4swMxOG4mTXrn2Td2lg8LIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNJBL8IeoH+JxgfsoC2VL0ae4sZFvopM/1QTT6JD9UFOH6+s80a8t/0UHZPcPP3vG8RoCCDSGKzLNcIkTKq1/T2ulFLTppyIK2vsq4QmBuHMAkiE5uy6ZFMiZqpthPryNK9kOMy8V2ToDT2+pDnBZ6m1XbdF7gFDpDq7NDUNGPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YGd7efLQ; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4AXXItcMt3VK+REGcwxdGY582hBFEi7GtZYxgAqZSOusSZGLeBJWtCC5RwCJF11u0M8JcBFZyxRPRvAbGDSPV6wuOQ94viUdyDU61WwDUIpB/sLxKdGxPpi4Y0N+tdbtmK2tRqG/tPoIP9xBGvC+X1w1xYQ2owkni0SmvsF2aNk2bPKw2M8Kh1mCZOHyPyEvuQAdC6oQshM49lMBOfvvhv6bzeEFplfbL6aZPkptHfPAGy1a2+JrZxeCsAzk1KywQirrUqqQ9tSuX8nkvxMvSft057iAcKMFOkAZ0Z4+7Z1e8qTB+/pliJkQhB5rdoU7R+QQQ9nf5rqrfPy/2KL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOsB92v0D1dqhgoA8iNwuO32oHHq3oxXDI3YyeRap/E=;
 b=OV5qDi7ftui3LrVSpzVhLaQyDkTQjpDLmF157E75+Cyc9n0/nFaJTybk/xnt6iYMOPgsbU+3EfDK9UH4ESZOAEe/g5lJ9ZpuwCPglFwFtzQYCdkwockjXthTv1Sdj/ewB46KxbXwOtPBaqxFJVkgX24ZPHB78fIs63MwESPcQQ+9eIhnRubxQH/YqFKvNNnTkb4/v9JI6HQtNWyVtvNjOr2r63pm1PriRGZOJa4w1a0yyGOUO5m/YciPvVfkbuXEJwyogVV84uEI6Mq9INbb/88rX56mZxG8yNEaFo6lqJgvjRj/JzXuzXoV8OIEqHMK5hfZsEsKgPI7+BSZAGqfjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOsB92v0D1dqhgoA8iNwuO32oHHq3oxXDI3YyeRap/E=;
 b=YGd7efLQT30usPFl+ilxmLlIvNJx62EAtk31MJwQT/pG/+ukv2NiDWDifQ1/JS7P61khY5wNhodwSXysVu3DQLZPwzTh4zfrYq4pm800P55B7O03NY7BJwdzV+5dgzfryy63bryXaPVGa0h50/tiNnDPbpoTh+Mr9jO3QKEhHwFym27oN57E1DkJ43IJNPt+LQY6Jg+0NrkyHAn20M/CkXkxOzc6ZN5rD1IQgyYupahPL1zGayRyOB5rZE6MPEi9SFmC5fvHVhg9cqi8CuAg7iZnRtCxcGaeGSc1L5tl66IIIe3eiVmKRlIG/1bLtaNxqBhnroVRaHuePt/WC5HAaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.39; Fri, 18 Jul 2025 18:37:52 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 18:37:52 +0000
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
Subject: [PATCH v5 2/6] mm/huge_memory: remove after_split label in __split_unmapped_folio().
Date: Fri, 18 Jul 2025 14:37:16 -0400
Message-ID: <20250718183720.4054515-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718183720.4054515-1-ziy@nvidia.com>
References: <20250718183720.4054515-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:208:234::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: f880c08a-c10e-4e4a-36ec-08ddc62a3403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yk5mIG2qePbe9BvX/w5s1T2UZjG7AZwM6De5yY2QG7Rkjg0ViicXU8CNnDmU?=
 =?us-ascii?Q?vR7Rpd37HRqhukCOoDDrG1zeFYG2H2YXGEVBllPgGo3inPgu8nOqh3686IXX?=
 =?us-ascii?Q?tciahJAQvJ30nQjCS7b60PuSOin3wvRdqBMDs+8JqNoVR1WJ3Z9khQroY4A0?=
 =?us-ascii?Q?qvHRFIN/XM8voRGgp/BMbj3iaLk7hoWt4OIS+KmxYMi42+YELEwQi4/qnmCM?=
 =?us-ascii?Q?GzULuGTSOTMtDQRQg+v3wHL6hTGe7hkNN4bupV0vjL10KCHaqtUN2gs90dc2?=
 =?us-ascii?Q?8+x7MGFj/9gyb4S+eqpgflXm+yIVcgf1ldVtfZbZ6GzDPIHWEqDK/SDIsz5k?=
 =?us-ascii?Q?C5y5LHI+DQ7kduUfFIdfIIExh+BEGMeqCSGQVNqUR5kbLFdmIm9AGoKzuXtR?=
 =?us-ascii?Q?Gmkep7eqse/Dnj2b6rdqvqWuZ2g0UlzEOppSEZT/1FkGl0PshCXcTate34+o?=
 =?us-ascii?Q?5BJKIXN/ducr9cru+y/Xpv2+YPxcVAe6vcFcnoJNKjSQGuH9QRZrRrmd1A01?=
 =?us-ascii?Q?ZoHSqe1xcGQd4X9JoCgqis0ld9ZO170hYbmlB3uLo1z5llZGpTjM8JxqyoZh?=
 =?us-ascii?Q?6sc147TK07+be395LifNBLjCdI3wBTBITNkPSGMgmho024s6wujaIltlrWoA?=
 =?us-ascii?Q?t9Dmp2DvN0BZdEyU9MAQjW4aVkuZuvlwaHylink2sNG2TM0uXQmopEpDe1lV?=
 =?us-ascii?Q?VRimTNy7z3o4BR9dPz9AktAMSJbPLrgfuxZzsWF+TSKs6VOYsHipx117zaMz?=
 =?us-ascii?Q?CjIENVBTMcE9dJftcoCtfrWSweIl7mEjkJvxhUOiH03JbHdwGlczrEBGVBHZ?=
 =?us-ascii?Q?6Ei95cp5Eu6Q0nTt6pQesnWUv4OZ5r93+Vzm2bqRPZ3szzpS+K94Oyy0bB5X?=
 =?us-ascii?Q?svVzaHYpqQ6V5esb2+CArNHkAAfXwB2EvfSyQiwtYKqOBwf3C8zrsqLYnZtw?=
 =?us-ascii?Q?VsqAPB4f2a44mFUmBqdX5NvkBIQPLzNxXUELGmk/RTWVUjw17KALUe4dZ6iM?=
 =?us-ascii?Q?MS7UOsqcWST3xAODlD3LsTJBXmjhxeW1Ij2pKgcd5+Ex5mSqzj9+sjJNbw3h?=
 =?us-ascii?Q?tXopmzJRhdUItE1MmYgmrF8svOvXGk8/+7ZAwurAY4/e5R8ErAr5Sp0n2oY/?=
 =?us-ascii?Q?++URVe95CKxFr7iuO2uo5u4oHhKLdXHJsTmf62hlkfwaVz0BS2u+NEKvWX62?=
 =?us-ascii?Q?7pONNj4PFYic1gqByEwSVtHJV4AMBB7HtvJ1Yef0BZdkrN8tuZ934cdWLkrI?=
 =?us-ascii?Q?l2KjFPc6UqkP4DR8t/poQ0J7MpbUQcr0Dc//58LVn7/iTSVVjJ7HmvNaxBM7?=
 =?us-ascii?Q?N2fAnQ8N2pML0X4mcLsb4idiV3XoKsgv//pbpA8y084Sm09pnd0I5GuePEt7?=
 =?us-ascii?Q?JKo5kh9Uuz9wj6sdl0up7iA49EB6XzC26e3J8ZadbH7Ynn1rvNoqapCpjYzO?=
 =?us-ascii?Q?V4yAp1gxgGo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fIiuGzo378f/YuIkCViBDwSBPqZsAByaIlOIVzZ9ObV+514lYorCTKnlV0ek?=
 =?us-ascii?Q?Q2sxKuTEWaLv5wagCXYj1z7DlB+2VKcBz6upfX4HVrlukJ60Sy9fjY62lGIo?=
 =?us-ascii?Q?JkLxsGcyG8aYVQAvcCE0F3PJ6OsNM1g/0+1hOW2wnwSZ40RGqdNtb00ocCPD?=
 =?us-ascii?Q?aMWWuh78T+YBwsGObhmGpef7lCKKfQE5KG58hGDvddUANsWh2hUYB8tpDV59?=
 =?us-ascii?Q?G1OA0r9Hcr8VssnPB247qr+n1axvhBc/l4KFYXDafl1v6zNblR7/Kcz4qZeu?=
 =?us-ascii?Q?X+TyXFpNcOtui7y7lG4hFobj2lhXn/GNPmqMx7QRZ1F4yuXuhkDWuiYVdYvp?=
 =?us-ascii?Q?UmqObt4bMoCFHMTtwz3ZfRV9r3O3JLOVeReBpjKUckPWbPO/MlWyluPWtsQ6?=
 =?us-ascii?Q?WGxK2GfHRUVPr9KxXHNbYdqfLn5Nns2PdDQ7pg5S/SXTs+TSaaVhTva9xvzW?=
 =?us-ascii?Q?G4gi8QWT5Di6DMTFVLjkn3h56hIDtk09Yw9hoaSstmJ7RfmO6FojpWDU7YNF?=
 =?us-ascii?Q?a88lf+TaJufgTB7+fXWPjUJf7/uZDxFQFa9R7wE+zhk44fSUPtNtnhFrKnMO?=
 =?us-ascii?Q?vxqXowSs5UxiX4th+YUb3MkVML2gmdvorDw+KGpZVwV8VTQR5+5DgJNUj4Un?=
 =?us-ascii?Q?d0cNyfmG52fqk2tI+VsPkRxZPmxk9EOO5u6TSO431NHi21FiwDb8ze3sMu0E?=
 =?us-ascii?Q?3XbZs1cbonNeTitXauIInfeDrg6erh/VDzG1bcWzTNNXYJFJD1IR0uIo8BSw?=
 =?us-ascii?Q?jkOEgY6uXRFpYLbi7oCZ0ut/KFhGmrLblze/sylbqW6KD4UMqwbHOfM/Ye/D?=
 =?us-ascii?Q?nISaPwU1c4rzIPcXdFTi1VnDANWin7qufrMnqX0pRqBu7QmdARCE0vlvtY1x?=
 =?us-ascii?Q?+0wTJ4++HauIGuroDR1BxBorY6SeOxyOTDHlwbcJdMmylMi/cvDxQWv0mVgp?=
 =?us-ascii?Q?ELBuLCyEJpaQFJPkRAQzPdMGj7Rtn4/WeaVqcbgqs9P5YqcgdUkltE1ZQ7Ph?=
 =?us-ascii?Q?t9opKhToEd7AXRajlfoCZKEMd6YoAtvZZPLrfHaaFuJSFY+7JaE7vXJ8dRzc?=
 =?us-ascii?Q?A426IqnhDaLoTdE0rge9T6ouUDbjLN5GLCyDfad/Dkjzy9WhwNc0yOOWsMUd?=
 =?us-ascii?Q?K6qpN0TwREE4U6MQYZKDXniM8+0XGiMMRm6cZzpTPUJoDZJb7yILYsDzVvEf?=
 =?us-ascii?Q?kc8fLiuFUfIoZRntfjmj1z4YA/BpTdOcmFaMZCBjUxozgBQDBebyrcVQ/Byj?=
 =?us-ascii?Q?Ll5prQlYT3TSG1daxoE6vWw5F0HNn0t2350w1elyCoMkWwfCmBlf/tWYo1tg?=
 =?us-ascii?Q?2Li2W9Ha7vNIacAOXL5kg5SMsfC8VmCjdfGKxVlTzKML6CWgVxcUVZ3oqMXY?=
 =?us-ascii?Q?Rdw7Ent765Xz89DLzNtNWxGNY2ET0KBb02enVILEk32V/lR8eZyNE4QQjSVu?=
 =?us-ascii?Q?U/VHeRFoOc4N4KGK74SXdxcnlL8nPwxQOGsX8bCkpROkKT2aGdNRPAKsFCdD?=
 =?us-ascii?Q?TYuGIjBjof4v5dlilnyZmoippvD7ubOO2W9LRCun+aTgTAfEkXhc/A6Kxjss?=
 =?us-ascii?Q?+KsE+7cuhqLdHS6y47lX3FKDZL7GYemSrmvlEc3O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f880c08a-c10e-4e4a-36ec-08ddc62a3403
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:37:52.1082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yF5Ovdd7wHIdtiiLG6jPUAmm6y+WoaxQLM0CzEMe2kiIJIrAUivFS/pioqyUvJCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

Checking stop_split instead to avoid the goto statement.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63eebca07628..e01359008b13 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3463,18 +3463,18 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 				if (xas_error(xas)) {
 					ret = xas_error(xas);
 					stop_split = true;
-					goto after_split;
 				}
 			}
 		}
 
-		folio_split_memcg_refs(folio, old_order, split_order);
-		split_page_owner(&folio->page, old_order, split_order);
-		pgalloc_tag_split(folio, old_order, split_order);
+		if (!stop_split) {
+			folio_split_memcg_refs(folio, old_order, split_order);
+			split_page_owner(&folio->page, old_order, split_order);
+			pgalloc_tag_split(folio, old_order, split_order);
 
-		__split_folio_to_order(folio, old_order, split_order);
+			__split_folio_to_order(folio, old_order, split_order);
+		}
 
-after_split:
 		/*
 		 * Iterate through after-split folios and update folio stats.
 		 * But in buddy allocator like split, the folio
-- 
2.47.2


