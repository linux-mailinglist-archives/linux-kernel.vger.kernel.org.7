Return-Path: <linux-kernel+bounces-799525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7EB42D24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CD7547DA3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84D62FAC07;
	Wed,  3 Sep 2025 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l7N1takA"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984F2EFDBA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940399; cv=fail; b=d6dRU785lPrxeNwgtqT83DKh3HQdT9kMMJTUnZnMKr6DBFXCo+NdRFJwVNC3EKbyAM4o1IY/01uEcN4ZCmEBcb28X3Bx9ZQp4dBw1S53gTfJbEHvUaiiTRWDpqmz0EnDbnY4TiNCeEUnoP41GGmyolQHcLDtLZNBWj+9ErlteSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940399; c=relaxed/simple;
	bh=xlD8SX4ad0eK/+78F6XXGtQvgXgeNVxJNJvllQzwmRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VMt/GTuEL5aOZYEWm9piyTn890wJ20ht/k2IrvaOIn9r8LqpMIxxTkJ30PkKoYY/ok14TR/fWEAQ84WtwZ7SE/9l5m9C9/ZygrITzZlNR9ML68oppG4CauWl9vNCbk+vGOmFja7TXiRyDusPPl7wD/OsjWg9V3Z/KZgveBXGAJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l7N1takA; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDsZnJPWg4oPEbqSXQZv2aDZhlmyvUVmOaVRwWWr8vhzTx0ri9J4phQ86i7kHFstEEcNK7rrtWsSzMJ1/UwA18Eat7Xo97B985D7pOHl9eZDYGYnOcbpnZqpSaj6XJSaVpGcgE24Gh7HrW2PtwKRv/uj/2fCam2y2MSXo43iWvHpDuGpHKFB0gYWJCnoj5r7qTp32cGsdowQPrcYQZle73GjU2NSauizyyLv/EmY9AVGJHZJo9uI2bql/nEIo4e6tDTYz36x3r98uqHL5K8JncLMqnyLHS6EQ5HRZtvJjcb761hArrJZYlzj09iqmsg2O/+8BstRZklu4rY9yV+PGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU6+Ady6aLl2rVK7oQBFdMGCrF29m+xSa6Z9u8FWszQ=;
 b=NGRYGuamfNfmxKviA7bBQgmgTC6yvmsMGTG/XnwtbL0cGAwSjxAJbco2bH1aFri2tPMzxiiAXQfv4ppoZr0eYEb8jHd7zKYuMW9ic7nVH6LRwM8Yvj4kD9RVH3pLdDpOcCIjfdSK9FnJyc7TKeEDAbak/ltsWeyhpv2PlcW9S843QcRb+eP67OEzTqjRBJ7WJrNWS/YRNMKZKFiWGmSr7N48s1ZbgpyHOBl7f3djtAG7mjeQ7V31g0CN2lfwbohhi7EOEfHL4/Q4CuXmIijdpKZB6Ox77LMJDWv33O5gsDQhNirfpoLidnxOfjRIEEaTcYehZrofokQmzG0EsvWGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU6+Ady6aLl2rVK7oQBFdMGCrF29m+xSa6Z9u8FWszQ=;
 b=l7N1takAL/oddlxtXo9NYczyiasYky4eCR/Qq6RX+B3fb2yuRHRw88FZF8izJfrsAm9JvpbwCLx19dNTUI5vZIbuDv+FeObQ6urZDDBU8bzoRNDZQcGvWFn+ErUvH6ZW6mgRbvy9qk8RZba3o5OApdE6LIPnnLUlo8wd6rr0Oa9mYPmxez4zzHX1Y7kGG3AC9oDf93xnuO+YVwjb/qUPO5PlxybY47PyTixWVq5Jp/4j6rErZ0eioPsqsh5ITI+c34+juhjx6MjcA67ATMD9Xx/ZADhPrTHd810S/XH5v7LOVHPe2Ub0jRIje5sYUXv3N7r46Xr9YyeAAH9ICbmUbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS1SPRMB0005.namprd12.prod.outlook.com (2603:10b6:8:1e3::12) by
 CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Wed, 3 Sep 2025 22:59:55 +0000
Received: from DS1SPRMB0005.namprd12.prod.outlook.com
 ([fe80::7629:20ac:4306:5f4f]) by DS1SPRMB0005.namprd12.prod.outlook.com
 ([fe80::7629:20ac:4306:5f4f%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 22:59:55 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: david@redhat.com,
	osalvador@suse.de,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/2] mm/memremap: Remove unused get_dev_pagemap() parameter
Date: Thu,  4 Sep 2025 08:59:26 +1000
Message-ID: <20250903225926.34702-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903225926.34702-1-apopple@nvidia.com>
References: <20250903225926.34702-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MEWPR01CA0174.ausprd01.prod.outlook.com
 (2603:10c6:220:1f2::15) To DS1SPRMB0005.namprd12.prod.outlook.com
 (2603:10b6:8:1e3::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1SPRMB0005:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: d59999d0-cff2-4d4f-e5b5-08ddeb3d9915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F1CxV7IJG6T8GbYI8SClX3RGX74xV/U+Rj7GHu6P5iyCOLOUCN954NrkLUFr?=
 =?us-ascii?Q?7ubaxo2rShE2o/iRu8m+cqVgydmg/+zjUqygntLZyzKF0Mb5NLMz1HpFd5n3?=
 =?us-ascii?Q?gEjLyTLdSxDSQWUNqdCGIg8mwyyP+HuZaZgB3XpAZV6gs6mEUzMvWcLz9y2s?=
 =?us-ascii?Q?T8PHFFB+iXrvu8mqsY1Jz6/wSMjknxTmQ72cX8PvxU3eVGeVyvQ7WPo+g2iD?=
 =?us-ascii?Q?4DLORenWZoEnBc4nGHkxYGDi0hsqHtIPksFHsB9dfWrNF2uVEPzAAVxOePYw?=
 =?us-ascii?Q?2D6Kom13cgwIDfUZLrqpBh6PDeFN1+CVaHSSaoZIh4Uc/rEijtnBV2T5mD3D?=
 =?us-ascii?Q?OG10tazfrNC5JirTRorrIul7v1xQzp1FYlGHyBYemNakZmZqk/FTRQt/kq4v?=
 =?us-ascii?Q?kr5wfuEGCwyxBcg6tWHy3km8E063iJT92bc2LsLTDJTgncfSXneB/CBJvAmY?=
 =?us-ascii?Q?3xsFZ7litVRlXLkbED0qmDmxxwAccj4JVtpYjpDu32L9ZGUeZ6axcqicnX9G?=
 =?us-ascii?Q?l4sFVySZWoD9LBEn6WTCSlmIHOmZuN3JReJYZk9ylbJs0tzQu109GyEmgeMq?=
 =?us-ascii?Q?LJ/Em+1T8E86XuApviSDPOL1ctxqJSNGw0HHCQxBPSUcN2HGiUJ5WJ7OiEFi?=
 =?us-ascii?Q?x5HCO4XNgt6w67vjS9BgOqoxaRiNMIFrhcOQUBG5R/FqZPG49++ifkZUc1iQ?=
 =?us-ascii?Q?4fVmS2afqtqN5qKl3cunbBGkwabOHZZg/iluI8q93Q3eHHviIPfS9D5eKN0/?=
 =?us-ascii?Q?cn4+QFE1ceO5sCxMk4YSOTljMPf2pPG6qZedEf1F1zItW9aIBpjM8zN0830V?=
 =?us-ascii?Q?OJ5Oo3HWFhUi8qLFyWzSOC8RrZ7eOvctUvnKQ64rCNLflc8m0R/YVHimKa21?=
 =?us-ascii?Q?0/lwiXdRKswTdQTVSkeCOvsDDyiOXVmXeJNcS2j5CkZ6uEEiCo9UgEIdJ5ie?=
 =?us-ascii?Q?kVK3qMGhihQONr0d1MY6K8+DKp8QvYoeQ0kqOlkClOLGnjoxZhnPitiuDjXY?=
 =?us-ascii?Q?A3c0WkL8m/8o9k/f0TSbyN7ggfgnI44R2HinQvRcrj1y9TD4+RlBrgkV3SXY?=
 =?us-ascii?Q?srRIvUWHd76dJwv/9msafW3s3rX+apLhTXynYUVUCwzvt+L3D6gAs1f+FVgM?=
 =?us-ascii?Q?syt70zykiCZ2qoBKZD5pVrIrkl//AHSKda5M4I3ZkZ0/gPECJzVosoT7zRlr?=
 =?us-ascii?Q?nRKeWH36+jb9pzXDEteCaSTsdIrjAb9C0Mez689YpZCiarfaQvuM7rJ3Iny+?=
 =?us-ascii?Q?mMUR5lrvj1Y8E1ccavdjCUQitGHtXCcp5y019fRRjb3mgLgZfplpGzPFgAm+?=
 =?us-ascii?Q?vnFMPxO4fFRIjPaXDBaakRWp3dzUJUd9vYkpe8tQOWfkYdiWt1f34Hs+l3k9?=
 =?us-ascii?Q?b94r+JmeS9KhQBnJKOW80LE6sbKdJpzQwr5oxF+4h2t5eIRGQJqnP2VDFNv3?=
 =?us-ascii?Q?iSqEP0kChzU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1SPRMB0005.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ewSBhqrLjHR8iOLGVBSvowjlNEsjGOy5Vrqr/03ahibHYru1KeEQJu8rbeso?=
 =?us-ascii?Q?nBN0T88Qek2tU3uP2eo2MLXYI5ns8dTQwcPtNNkkGPmqp/cBExcx9HQ/p9K3?=
 =?us-ascii?Q?XhXFqz31QEZs83WSMUinh4sEEjWMA7xza+m39CVVvLk9Daq4LCxbqoQ/3VI1?=
 =?us-ascii?Q?bZawrUEusg8PZj9pK+d0C83aNZDt0e7RVZaRC0bLn5P0/dqkPZQTVgDUwQJU?=
 =?us-ascii?Q?7S5GosAgtJqoKBt3gvM+6NRYibJKCQF3zU8nDlKcv4IgyGuBmVf/6eSbAUdy?=
 =?us-ascii?Q?75TIGA5unzhFc5FllEaz1ifSonA29GdBS/J3LOykv3vymfK2sA5Rpoik2sD3?=
 =?us-ascii?Q?jmTedCyINLyCJY/jtZi0HJp94HmdS//CbGrl5hzrho5/tUfxXXcWIy6CtlgA?=
 =?us-ascii?Q?nb5CuyuGIr4u6IoKQKSAM2rpy0OZKIjQlhUN8K0a2uZeMhu0yfn65h1CgXTS?=
 =?us-ascii?Q?17glvwq4dCCseGkqT//+jqfDpF5+SyKLmOCVTMy2hPa5AqfaZmLAM9Q57AzY?=
 =?us-ascii?Q?PMG88iDhMMmDz/bNkeG+oqUditb/KQLuLGOnwcEIo9F7LIhixPdvkgcIo4qi?=
 =?us-ascii?Q?mFiEvYLRYGaDoiap7A3I3bF5TkXcYlDEJKTZpJu0Xfx1DpdHHxernDtTzA0M?=
 =?us-ascii?Q?8nc/cSbujcvnSCnQ7rFIqtuaHPaGb7zh6CcceFZptp4vawMzeiSwVNe3qRjr?=
 =?us-ascii?Q?eRb6we5FIE4oPTzd6HCitufU3L1tuhbqie7Tb4TQv+uM/iRNxjJJCKv8c1UG?=
 =?us-ascii?Q?Nx2cxlpm6JdI9LaZH5kDtFxDsFGq9iunPKlwrhn2S2Cdmq5MG/1+95eAVTfM?=
 =?us-ascii?Q?Opxy22D5DgyS5HddoKLSsaK4s5FFCsSTlSAx/pMIL8/p1UvLaL19OFQemz92?=
 =?us-ascii?Q?0gP8tZ7jNEoSRP5R2s9CFfzSUrMVNUKGKCUUf85uKsbrEOSHuO/iwQHokxxF?=
 =?us-ascii?Q?PUZmY8bTLLBvbuVJ96zBrXmTCWMhkaXawr7z+4eus2EXROrOygkds+494jGg?=
 =?us-ascii?Q?r9GzBxoBYXmNEU8YyVTGa5LyGxud9DDsKZHR1iXNbUMPea46sDMxog5QfCbj?=
 =?us-ascii?Q?koxEU+3OS1KChprAeomf7RAHqvw3/JUPKt6QO3DinDyvzupXVUEZtvDRR3yc?=
 =?us-ascii?Q?bFb8jeFPMGrlACAy5yD2Or/xDUC+KxLpfSemVSW9RqUvW3muQSvvYLGwufDj?=
 =?us-ascii?Q?NsEnzmvub63Ilhg7yPBWUZLvKZwJfPmOmRuSsrhqEm3mauSjV/2fqzjGFGqg?=
 =?us-ascii?Q?L1+2DZVqzHsm/sfqUFXGdjnUNhUe/ulcUut01akMFJwTYcfj+HIWOtZa1b0r?=
 =?us-ascii?Q?cVmgQxWfnlGQt52w1A3pMLnJJGbJEX7EHVHr0TugAFbB4u6bh/8x4FwepQ+w?=
 =?us-ascii?Q?ihzmwKBLeP01y5oFNO0rW7rsXLvKiHEVhAJLzTWDsEX7icHL6E5Y2v0ZPxkD?=
 =?us-ascii?Q?xFiWFgLu98m5Z0ntEgiQgYr78TnZfMTgOBAZkrHoDvHG0zDLcLtIC5IzqRGg?=
 =?us-ascii?Q?s4seXUpSneNoa1qDg/JsLPjyGZQp3Fzb/sJ49fMqFrY4XIyChAL1i8tP17Qa?=
 =?us-ascii?Q?DWgdASV/WcDeEGgsHSfTH1lTKb/TXR8QyR9Mt1BK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59999d0-cff2-4d4f-e5b5-08ddeb3d9915
X-MS-Exchange-CrossTenant-AuthSource: DS1SPRMB0005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 22:59:55.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIx7aWbs6kmeSiQER17Uy+yDagyhJuqf6LAPCn6/7H31OOLKLCOCblAMPtT46CtiHJkWhlP/7pqVPWHf1oj6XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345

GUP no longer uses get_dev_pagemap(). As it was the only user of the
get_dev_pagemap() pgmap caching feature it can be removed.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memremap.h |  6 ++----
 mm/memory-failure.c      |  2 +-
 mm/memory_hotplug.c      |  2 +-
 mm/memremap.c            | 22 ++++------------------
 4 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 4aa151914eab..5cfc2ae6c98b 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -204,8 +204,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid);
 void memunmap_pages(struct dev_pagemap *pgmap);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
 void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
-struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
-		struct dev_pagemap *pgmap);
+struct dev_pagemap *get_dev_pagemap(unsigned long pfn);
 bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
 
 unsigned long memremap_compat_align(void);
@@ -227,8 +226,7 @@ static inline void devm_memunmap_pages(struct device *dev,
 {
 }
 
-static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
-		struct dev_pagemap *pgmap)
+static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn)
 {
 	return NULL;
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc30ca4804bf..21298f861a5a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2266,7 +2266,7 @@ int memory_failure(unsigned long pfn, int flags)
 			goto unlock_mutex;
 
 		if (pfn_valid(pfn)) {
-			pgmap = get_dev_pagemap(pfn, NULL);
+			pgmap = get_dev_pagemap(pfn);
 			put_ref_page(pfn, flags);
 			if (pgmap) {
 				res = memory_failure_dev_pagemap(pfn, flags,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1f15af712bc3..14e98c89f5b4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -375,7 +375,7 @@ struct page *pfn_to_online_page(unsigned long pfn)
 	 * the section may be 'offline' but 'valid'. Only
 	 * get_dev_pagemap() can determine sub-section online status.
 	 */
-	pgmap = get_dev_pagemap(pfn, NULL);
+	pgmap = get_dev_pagemap(pfn);
 	put_dev_pagemap(pgmap);
 
 	/* The presence of a pgmap indicates ZONE_DEVICE offline pfn */
diff --git a/mm/memremap.c b/mm/memremap.c
index b0ce0d8254bd..3b4717cf3a6b 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -153,14 +153,14 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 				"altmap not supported for multiple ranges\n"))
 		return -EINVAL;
 
-	conflict_pgmap = get_dev_pagemap(PHYS_PFN(range->start), NULL);
+	conflict_pgmap = get_dev_pagemap(PHYS_PFN(range->start));
 	if (conflict_pgmap) {
 		WARN(1, "Conflicting mapping in same section\n");
 		put_dev_pagemap(conflict_pgmap);
 		return -ENOMEM;
 	}
 
-	conflict_pgmap = get_dev_pagemap(PHYS_PFN(range->end), NULL);
+	conflict_pgmap = get_dev_pagemap(PHYS_PFN(range->end));
 	if (conflict_pgmap) {
 		WARN(1, "Conflicting mapping in same section\n");
 		put_dev_pagemap(conflict_pgmap);
@@ -394,26 +394,12 @@ EXPORT_SYMBOL_GPL(devm_memunmap_pages);
 /**
  * get_dev_pagemap() - take a new live reference on the dev_pagemap for @pfn
  * @pfn: page frame number to lookup page_map
- * @pgmap: optional known pgmap that already has a reference
- *
- * If @pgmap is non-NULL and covers @pfn it will be returned as-is.  If @pgmap
- * is non-NULL but does not cover @pfn the reference to it will be released.
  */
-struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
-		struct dev_pagemap *pgmap)
+struct dev_pagemap *get_dev_pagemap(unsigned long pfn)
 {
+	struct dev_pagemap *pgmap;
 	resource_size_t phys = PFN_PHYS(pfn);
 
-	/*
-	 * In the cached case we're already holding a live reference.
-	 */
-	if (pgmap) {
-		if (phys >= pgmap->range.start && phys <= pgmap->range.end)
-			return pgmap;
-		put_dev_pagemap(pgmap);
-	}
-
-	/* fall back to slow path lookup */
 	rcu_read_lock();
 	pgmap = xa_load(&pgmap_array, PHYS_PFN(phys));
 	if (pgmap && !percpu_ref_tryget_live_rcu(&pgmap->ref))
-- 
2.50.1


