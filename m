Return-Path: <linux-kernel+bounces-737282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B6B0AA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C61FAA80D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F202E9740;
	Fri, 18 Jul 2025 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oKLKsdzI"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB132E88A9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863887; cv=fail; b=Vy+0w/pPh+fgAhI9Q4ATR+sPi/7uGJIeRGOz+cciueAbhEm+khD2tsVAMZ1bULn/HhnE10PVJYR04bsjFeI49aUWh+rKyISlMJF+15NFLJTf378aAB97og/XtA084bA6at3Ch1ulVYkVVhKhSuz04+26XFUoybsOql0Q+/3RkPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863887; c=relaxed/simple;
	bh=pk/mnSJQEYJZHBsav+n/KOHbr1Oi0mE7l85CBouVU6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FLMbt9wYiBqnMTE7/G2rAJHUOoq/az+QGO62OQ6ckXDb/m1IXQvWS11n1kmNFJ4Tr7eCefPiZEFQb5KqhE7pLdLPYQYX2G98yOKwGKxSBTJYFzOcQaIlZBT4CBOD5JeKa/Bz8YhT8rHiMpU0WP8gBmYiYWzysFHUQAgax2enRwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oKLKsdzI; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPlcgiFWgMpAPi8H1NuVhlwADtOr3r3EkztWbaIEzIoW6gsTxcajff7INYirsyzRm12F9R0+WDzRA9/m/H4qHk79oZs4PH9MDc22tMzPes1zwtMQYVv+Oz6N3uoSED1ZP7isSZYKrhRcF0tAPYCcMNO8t9pyToPZ3Q8WHhu1HuPNpzFuAbwHrlHakiFwJ67Uk6XFv5SzavGTtgXiEODSl9jAYUGQPFzMReoByh0yd3NJpmILn8Ya+H+FjHW83TvesRevREvcGca+0Wt0tQmXABkijzQTovC4RYqOjtIuFnNFBCkN2tOItregrOAA3pUib7YS/Oc7O/od4ZCSUxatuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuNfEGnE/pkxmtI3d2K1g+qHeSUNpMH17TcrWnnOs1E=;
 b=mCzk42Ku8wHIpak5Yfm5PhXyq7DuG154myrbF3TwFyhACuiCbDBy6jtdNUQbXfoPG8rkHpYcn8fk2dBUZSImfymCIOIY0uPRr+6MDxj8yB11yrP7k7Pc855595CKI5GCafBYmaZLeXnCdiakAZ2mjw0Pjliw48kmGEXDFHCurUtkMhJe3OKuRIwoaKnRMojVdNllD0VyhoXpYBNhiuoT3OBexmTijxYAGOX6OaK4hYdMZJiUT4xMF7bVVYy0UJaHbkh/3EIJwJWh4uG98r1W5jkRU0uXTCgZ+wyjBdhYtLnrlWu6k9ajBsg2dSE/DiAdr7XA6H59AgAy361Q+7uaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuNfEGnE/pkxmtI3d2K1g+qHeSUNpMH17TcrWnnOs1E=;
 b=oKLKsdzIQ+GPeIWxcGuEBIR+Ny/YwbQ1/lKv+q2LyOjUvrWC2wyfzfEK7qpiv1BSxXSHwC29ys8B1Con7PdbX6JfcWqj6h5fDsdHsWrLvt2sD/awz5gAylfFxY0BE1xL6jniH8OzuhbCT6Ne7kf5uPS9HWXQB7IodssA6lmLbLoZ/C4SQVBpBjzKO3+3zPiAdoX+po1nUx3+EJrSy81Oj9VvOawrdjm2w4VZR43IfTkSZa4Yn/2M62brDxSj8JFy4vqK/vK4lEyBoFuTY8BjuH4f1zv/d8lyLWayhcyRLVwOAAgerU7ho4e/2uxKDgxEDGfjhu6+JPUMNbxnCClXrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.39; Fri, 18 Jul 2025 18:38:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 18:38:03 +0000
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
Subject: [PATCH v5 6/6] mm/huge_memory: refactor after-split (page) cache code.
Date: Fri, 18 Jul 2025 14:37:20 -0400
Message-ID: <20250718183720.4054515-7-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718183720.4054515-1-ziy@nvidia.com>
References: <20250718183720.4054515-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:91::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1258dd-0141-47d9-03f6-08ddc62a3a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWwDQI65wRgemN9FKfnTaGWhAS+vuvtBFNmGOYgz2NjRZIj46mus48/wgEMv?=
 =?us-ascii?Q?JQVcCYLOA/zsBsNGIjs4SQaHX68dLylp2R3JqnItCC1lbYoufBOjetEUKTpS?=
 =?us-ascii?Q?1QnklZypDSKYHC07cGxKMcu8iNVhxJN1s3UDRcbYRA8rq9lqNRfinFcAT8DZ?=
 =?us-ascii?Q?6koccdzy8CjHhZr+DKQlIkgYYk6QR9l7pMKtX7nUo0zpUUCL84WJ0W2dHreu?=
 =?us-ascii?Q?m+vwnm80EpmUexGdNJxW/SVBgEp8mUzErJJLQOzDXi9HZmw9Zlqr9ebPzSlr?=
 =?us-ascii?Q?7l7qpLkU438zfXuhpgEuF9MusOYVLzXxVx893LpQS52gF57jAkdnCVLTxXLU?=
 =?us-ascii?Q?X9GXtPunvuQXSOEppzcLCVX2WQZkFoFMHP6h3a+VZH4cPE9UsKiLsQfjrwEq?=
 =?us-ascii?Q?oY+y6j9PxctvxtHWDMvyDYmk6eDO1RZ/3oG83j88gDfXFiJLwt29hrz10nKB?=
 =?us-ascii?Q?LqfZ3KRYVl0IqpP1fHvK4BuG9Zj1l0qYycyZTgVV72MHMq/HUuGiWASidcvE?=
 =?us-ascii?Q?SwQ6UfI2XfEoqA0Wy9XH3dq5FXNZvLeDNacWgU7/I2aQHSTbkDKkB9jOvF8E?=
 =?us-ascii?Q?y/JoeMC81lrcbiaIPu7/IZi9QkmVoRdwcXQrGTVyhnMay+YQVM0Kr1x/m0dl?=
 =?us-ascii?Q?vf8pPHKgVfnPtXcSeAXe0dnn7ockiYgTb0Ll5/U10Y/TS9cDuotNGbKPd3wy?=
 =?us-ascii?Q?DPNzPxOU6i6qiQdvKhjcRoZqUwk40ztFzrd1+p/zokB2jxzwvQCVlrqxPk/4?=
 =?us-ascii?Q?QBoJJ1hSVew/drQxx2fvQZV+ygbwAuVLxOoVZBFGeRz0OAyI3hP0u5nvSYW5?=
 =?us-ascii?Q?JgY693rnaLO1wihSHN4q3V7nNPUBUp8ZKM02Qc01OdCckf8yW7XzBk+FkPD5?=
 =?us-ascii?Q?6+v3jox2zbYuHs+T2yjSlm0RTYicoCihSdVkt8vllYdnJUfkY7N8iaXh0RxA?=
 =?us-ascii?Q?WvTXmD7umFO/xen/7PWek7DVkCbMRlVx/GMRg0EHnOYwKPR+wbeyFJiVgYVr?=
 =?us-ascii?Q?XZ1V4XG1CYJz8wTdBOWMl5cUIcNuWs9RKdzG/yd8ST4ybZq7cxwKuUhP9pNp?=
 =?us-ascii?Q?I44L5cyUWosJl6Z5mJX4xkgSEMxqA8L5eN9SI4SCzyoCboRtEdJkMq3ikGa6?=
 =?us-ascii?Q?pWkBLkmb4bUlTWqhl6xOs07M21XPZetOuITRvVGFN6Tjf60QSQ9gSbQKl1GZ?=
 =?us-ascii?Q?xnWqa4MBU5D2ag/UoHJ6dUCsw8Pfmw8wAdAQCM7maSH1vsH7DF0Z2BclMHWg?=
 =?us-ascii?Q?jAJHXSdC+4tcEDbiy6gc1Oiv2qylPhWc6tGtuDJIukrFu0Lp7QV4ftc3giGL?=
 =?us-ascii?Q?Lt68igYfqmpPCiz+wpqCYRaiyesg6iORV1LJzzzkBT59K6fIv13nCt1W51eD?=
 =?us-ascii?Q?5ukBOcCU7duZrCG4vqtZMowPoa2jfIgVXu/XOlh4n+6Y2kxoBIr4wC9xpfFH?=
 =?us-ascii?Q?Y6S0I8mpGUI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p69zV0cMd3WZ/ds8SEslS71q6NdZN7Cl9n/fo2tgsKlHRBdS8/wJk66b/F4+?=
 =?us-ascii?Q?w4fRO93wzgG/xG3jeT777qNZy1mbNwIH6mxVQfTTbBb+G/Kpng6883WRPGbW?=
 =?us-ascii?Q?N0Hoe6+upiVcEIRjGcBvvlfsaN71y9I4OmlERxHup769l8MbcRcmqLYYfNtb?=
 =?us-ascii?Q?hs85J4LBmog4GcorOxg92L2XxTnRtg8WnYnbcayiSHwZNs52wgYlYggw5AL0?=
 =?us-ascii?Q?dQUPxXeF3UkOW3KnAs6/xr8GJmziYHDcMs+ksGb9T/x43bzrlSbrPR1Z5Mc3?=
 =?us-ascii?Q?EbhIkLdliSpPaq96U0/CQfYTmyL5wlzvRmhOzxtHUnjSLRCFaaoQIZhq7TzA?=
 =?us-ascii?Q?Noshuz06NRpCt6udLppZwN11mnV8ddqcFWBxY2vDXmjuw9m2Wgh4qOgwS7ka?=
 =?us-ascii?Q?Is0X0AOtG7Gzi9jfu5rUPK4fxhBeZm9tFUcTCOe0s1nQvCKYAl6FMJUxfuhH?=
 =?us-ascii?Q?OUlazEytJVY+Mmi15zXkDg5EQPRoHpqqBr6141rtT/6EAOi/9Vnd7zUiKrZq?=
 =?us-ascii?Q?Nu6tHdBHav2ZurZzOnmhCq4AZSeJfkMTwZXIZVczaAFK8X7es7k7TvG7z/US?=
 =?us-ascii?Q?nTrzXPin7iZX2Y4PYfUeryequu2izyfZChUMSkZznFCeYk9LZ5JzkiqHmFx8?=
 =?us-ascii?Q?nfU0BeLoYEr2LJAaNx1rfyIcDcqhLeomWiHQJoNwVp9MBwK+F6kTHv82rdlx?=
 =?us-ascii?Q?wC8fD28zvDFirsO2pHaJdZcafy976WXDIE3yNvucVfyqevMJWtwcJ71FW8jU?=
 =?us-ascii?Q?CyObno6jkVhbF7oFe4u5O6x4L1DXfX+r6VRCBDVEthf2rIIi0micSEVlO0mu?=
 =?us-ascii?Q?s1lUxbKcFDTA0PW3vJc7GCi3xVOjaeA8ii9AGhk7YnnDIDaRB5rUKGCUW9oh?=
 =?us-ascii?Q?/cbCJTTGOOB2JBSWM+n3CqqReY4+JT/lnchxb9re4J3iI7xbRuaWfHUkA+tb?=
 =?us-ascii?Q?30ZZhBCHgHtTxVous8DkMkCIAi59TX/tt7Cy6vys6dmrRe0FinCwYWbdQfuX?=
 =?us-ascii?Q?F8ZPalmb7/lRdTUZVdqoRDzsgnJySbe5Is0Xj7slAiFg/0/QRb39bwMMW1XF?=
 =?us-ascii?Q?n9irnvSV9MtRFFfIqvymmwmD3ka+nciLAmNvYK0BFzg7sg0P2rB6NApD2F/a?=
 =?us-ascii?Q?16FVrkKOtx69Js9UHuljsy7gLFbGnKJXkFLmcdJxhzL9cwUW1RFU7iO+wg0K?=
 =?us-ascii?Q?hP4VBoPLjXlxSUGL1ugaMGHzKUXzsjX08rS3dB2/QTYhRS+5GsBVces7d9zY?=
 =?us-ascii?Q?rJtmvEeJdP5p0ENPqV4X9bw1IN8RkYhhupPalE2qXgHyVd8bU3DAa6dkf32e?=
 =?us-ascii?Q?u/ignRGQ37UWOn6sBI2BKWKbAIUNdv+IJWNZip1HHQmqZ2Ue4K1kP572avr6?=
 =?us-ascii?Q?VGjPrLQfrkkj4HsTx0b96oFv+EgeU/2ydOHH8jKANUsXXLsKHYUM2DIYoHxl?=
 =?us-ascii?Q?4jU7cQ8Jbb7zAut8SUPfp52h9nnUHwns1DFFn24YNC6KAoRBDswJJgVvKBid?=
 =?us-ascii?Q?6lJwoN6nJZPv4oSv5tdwFup9aJgfN1ZDi1316OkgXitaHqF7e9HTeIU/pY47?=
 =?us-ascii?Q?HGHCwozT/LCPYx8U5jPD5n/0XyMtqGOVwuEmYlCgVMwIXCu0v1KPHHwedyMW?=
 =?us-ascii?Q?0jQlvERtmXl1JCT5XIYW1L0zAjleefTVDHZLfuNd3gfJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1258dd-0141-47d9-03f6-08ddc62a3a66
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:38:02.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qa0Mcipsl12RKr33yeete5RX9QFpLmAeLJdVBoukTNWxq374Rkgl/XLd0s4K/zCM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

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
index 19e69704fcff..9c38a95e9f09 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3640,7 +3640,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			ret = -EBUSY;
 			goto out;
 		}
-		end = -1;
 		mapping = NULL;
 		anon_vma_lock_write(anon_vma);
 	} else {
@@ -3793,6 +3792,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 */
 		for (new_folio = folio_next(folio); new_folio != end_folio;
 		     new_folio = next) {
+			unsigned long nr_pages = folio_nr_pages(new_folio);
+
 			next = folio_next(new_folio);
 
 			expected_refs = folio_expected_ref_count(new_folio) + 1;
@@ -3800,25 +3801,36 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
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


