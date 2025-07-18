Return-Path: <linux-kernel+bounces-737281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBD6B0AA3E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF16170DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ED12E7F36;
	Fri, 18 Jul 2025 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JP25p0Xc"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338F2E8E02
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863884; cv=fail; b=WpNNe/3lWmgSxKUi33MHrTVnri+quJu/zANdVoYbpv0+fo6h/uZc6kqkkd1sloqJWvNXGXWqXFRhdCK/P+YhJdIfy153SFsHZnnhx1Zpr16xkXCailtmACAcqhSyPhHgeHF4dx7x0nKNi0Z9jspEja4sv2QTv80M7NRjqBJyB1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863884; c=relaxed/simple;
	bh=iPualLxNhLiS1fxxzOfpM1GnXojzTc/ROt/68dfH3fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gr17siDQfWk9NQzlPs6G2yl4JRJWz8oJevx75XwvTE6N7upQj2JHNI7SGgVh7V+Imnw822UAMl5KDSaIFv6UDZ6Q1/OjnUyPRJySfEqUAK45ldmzLoTQrS5aDscUtd0ywITFYty6l+q1DLV6ZXQZU+idpixFGGRK6gFEVWa3a5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JP25p0Xc; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RW06I9fOH259Z/M8j+XgNK8z3EN5QFED5urEheA3NMkEwKRvFzBilnfBZbwW8kbY9V0IXgY0bph3bDEUFhM+sp3zMQT5doq8S9LIfn4h/J1Rlce2UWZgNShjxq693bT3B3RU9sS+BGju2K+Xw1qBHrXtg2uWGXUKFuMyjOHMMoFfUy1rU4/gqwIw1ZbsviE6HeJF5hG2HvkMiK/NTjw9eWpwDm1TaI3cEXAipEhFnUqxpFM31PKRMZhVISn55cHDpm49xyYKjDn8K6by1c1KoSAJUwwAZQ08FQ5uzJ7DOBohHYc9jxkpGjL9kuJY4X5jez37KYXNhAGBBVOFYjZ+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvBRIIPiylHOXYtdkVDILflGtLijXwd7kLOSaLQi/fo=;
 b=WldZPJVPizbGUi0A1Qe+aYztyxpO4sX3vE2mvdAoJGquVH8eo9cL2LT/ADLB6AYoDTAiZhvIEhJnMFnAb5L1cdPhX7MBZogpv+oyFFMkASy4ao/vkA6GZhyhso7C98jz8gkXer2oiRMO58zPATRnEoEK6VWGEWuyPGuv+QgeTME9Ow/DzXbYcazt40+D8ge4z7TzAFMYkaUCKr19CJyqPHVUQ/HdBQG2SKGTvFp+wUBgDgjipq50mCEF9bUCa4WixqGb80nb8sUf3ebbqqAqsm8fe3CMGkUb7hAu2PLAeqAPpaHcIbxxpKv7Y8yYB0vXYdFP+j0xEizltwYBL8hfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvBRIIPiylHOXYtdkVDILflGtLijXwd7kLOSaLQi/fo=;
 b=JP25p0Xc+barOuUijJFyyORRllOf90DcsHuladyPptzu3IE0BFs+oHzXv65X3SuG+YntpsJX/bJjHsq+oK//XcfH2YCv+WVxJOvSCIstKs6PTqGH9apDpYjla3PG/MBMUn6fIWx399paYrCHMRkM3JRIKLjcGuUyNy0vG5le1yMtTOk+je137yNJhggtuISkmB06Y4HmUmdJz2uBHrd7C6ezn/dteRoWeLLCjcYbOv89HyyzMN+PEq3WEjFBmddiuww5eoZ8XMZQe8D/DP5bRqC4oPAzCIzCNN+jGWtdtGcP8KZE5uDaGkNHVR2ScqImYWf7aMvSNbW4xHjFy3hiYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.39; Fri, 18 Jul 2025 18:37:56 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 18:37:56 +0000
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
Subject: [PATCH v5 5/6] mm/huge_memory: get frozen folio refcount with folio_expected_ref_count()
Date: Fri, 18 Jul 2025 14:37:19 -0400
Message-ID: <20250718183720.4054515-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718183720.4054515-1-ziy@nvidia.com>
References: <20250718183720.4054515-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 109c8a01-600f-4226-d766-08ddc62a3684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?28wwmuisq1MNmbTGogbY1NNxrGG7Z6WGmwd747LGovAaTrGcyA63n3nofaiI?=
 =?us-ascii?Q?0G65Deg+sE1/0w+X2sdWS0l+Jfmpf02knoc3y7GyJUJB42MiaQtDhBaGDUIk?=
 =?us-ascii?Q?wEXdl3/9UXZBWa+GYHl9hEAe9e9edIWv9ITgY+ckt/ceCN6v0bR+uMoJWsKr?=
 =?us-ascii?Q?vKfCAMNY9mSOsAH2oiSF74H2CKqWAHYeY1Q1XDm5blfIfhu8gZAQSOTPfwRL?=
 =?us-ascii?Q?DjBgAiDBe7W5bHgDx1ZSI6wdygFa0x092R2LbSFw0Qiamzjhi+TJ9RaMZuat?=
 =?us-ascii?Q?lvG9HLrQ55CtF4NbceEIZY3btwU2GQdXV2YCYVz7+7lkCvb2BvnlLHxQ1SPq?=
 =?us-ascii?Q?4LoYmJ3v59iYNsasKh55Pf82LUjRWv4ajLOg1yathwBOVLqPeGkNyRsHYWyE?=
 =?us-ascii?Q?3aSRTe7Id8vz6BU56RvrDP2uMK4lfOCP/TkNGBto8gkfO94itRDqQeFlkOWR?=
 =?us-ascii?Q?IzXvhM+Ju8xLPrUGUf03tfZwai4khHfAn44Y2FVizIt7zMqBBx9vy+IW5qSW?=
 =?us-ascii?Q?G+xIIMd2avGWGpvRBWiyWaJM6Wmocc1M0qLNRNa3qQo9t1WKDtCC191ni7R4?=
 =?us-ascii?Q?vcnMvyjL1ijw4FIxZaFI1opmKpLHKHGjsgkwXeDHxe9kq+it4Ijp1tO9F2rx?=
 =?us-ascii?Q?dryACq/3p1alQTEN5UF8OaTpUG1Vap/ojb4wP2FJHWhyTkJPjORoLrGvsjo6?=
 =?us-ascii?Q?cuuZ2rFDjuQm+XKBZ6fn/5LQ0dB9bO6ROm/em1Wgk7M4jHjU7CbDWPmYVzqD?=
 =?us-ascii?Q?y5btBLmS4fo3Dvyzhr4XcyHZH2VZa5SXalZEW38SovvYnJ0WH+U2ZFX+4klU?=
 =?us-ascii?Q?Qwj5lmV6sIWSFIIB2SDEqE2IOMynwCjhXlw3XTeQIb/Q3n+3NJSCv/BBlPE6?=
 =?us-ascii?Q?lFf8W4/oG8n/BXMVuX6zvbp6lLC46f9QXJG9ibs5mDSXFGcLG18JzI4qz5Xh?=
 =?us-ascii?Q?r93wcAt+MWSqVz2+cXK8z4+RXccGypNqyTWtjtYHBWsNVmBYXGuTn9Jza9pV?=
 =?us-ascii?Q?wix7dbQ9J7pHBdMpt2R/tBV2HWH71Bres5ElaxnYrcJVkdyT6xJ0xGXPY01B?=
 =?us-ascii?Q?n/3qE53ifyWlxFJsdQt8HmEdp1015zW6iwTeXImhbVDllNTErh+0Co+zCM+N?=
 =?us-ascii?Q?avQX/yvlWEk/KU60zzDsmZUF5vbS8FqjjvP7al6C6btrh5IwtCWRCo4P72Ma?=
 =?us-ascii?Q?+t1Vd+luROuWTkrj15RgzL7bJbZlxrRJqaPB5Zb1hctqVq8HmqVMU2iqAAMU?=
 =?us-ascii?Q?9VeEID8xz1eie75uP7M8toGKmLwNL9qhnUgW8QK24YYoljB97KT5T8uwX+4F?=
 =?us-ascii?Q?e5WguxQcQ0ylJICqrVKXcGGeNOHY/ANoVE2inWlakO2UQIsLBFIoUHdEchuz?=
 =?us-ascii?Q?SOWVImAlqqBQYZvazkNKp9wVoAIHQpb9EsRm8VKcxcuHKUERXimiYQoL/smN?=
 =?us-ascii?Q?UfzBxW3l3Is=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ILFtWkENXU6H2wjFIfI9olYB+5X8X9SpxWem9Mjro0AC9qlib01mhn47CoQy?=
 =?us-ascii?Q?2Wp09hjlNVLSfgNIT1CgdFuRTOFf9CweG/8Re43pZRvjk+A6v1ZthRd0Acme?=
 =?us-ascii?Q?EUWVD5QgzActfMwwODqFk6UgVCAgQRynjIogFPAlc2Cg8ASxCEtMoL/bS0kA?=
 =?us-ascii?Q?vEpUoGTRMJerPJdKBz2M8pMFcJ8dmuyacQgQBKrk1cKHjsp5+k5u/0WxnfVv?=
 =?us-ascii?Q?8JCkLdF8s9gRTPBKsQ+bF6IL9BP5aWMZS1PxKBeLlZLBVZtbjryKyF4X4GbD?=
 =?us-ascii?Q?WxLFuOqgX4VHnG7F5QUrZMM5EQhxlu2drUBFD4eepA+DDyACF6uP5LzaHg6B?=
 =?us-ascii?Q?kSetUsnxHIapR7mZd8plPq1sk2zgGhJUwpED0prIBD/T4UHhbHSXVGiYfLhl?=
 =?us-ascii?Q?tbFZvTUNnbMTiawVaGme2yPYIi5PVxzvb7MeZsYgBjg3a721w5oO869ZzvTU?=
 =?us-ascii?Q?utGsKWvCziyDqI2A9J7XnJs//lt1UQUYtK2NIhiV/cSlx1/QTFONAlCRbJqs?=
 =?us-ascii?Q?7Ot+3P5R+ct61PHXW6wRCifiBM9kyUvZBdBdB4fVZCKdDdzyEjRlXSg43iXe?=
 =?us-ascii?Q?t3gdj2I5e0EP8Bm0EvMGrJVwv7CbA+cHa+I8vawyc1tOQgz/kthPojWbCnUj?=
 =?us-ascii?Q?yW56h2EQv4ZboFSgOqi0Hlxtt2ocKeFTcYsQdBVKIY3ZafJ1DyASEQ7Z6DbY?=
 =?us-ascii?Q?BKyi5iDuueHbp2v/yGxgRJMZcDPzd98DazQZhuPluO/WdpyTHYzIAMufbo1E?=
 =?us-ascii?Q?C02qXK3Pft02jqEikLw/U+paPqKaXQh2axsbY90CXqN3n3lqlpJ2ioRQulAi?=
 =?us-ascii?Q?itLGADrkxscqn2Ji+dRF8Zt1+UIdr6mj4ssRyVW9CZFoi6Vy1TpmEJTl3CPs?=
 =?us-ascii?Q?OrNvZxqXt90X745xXulj3lKLtIaUTcSCPAGvZ4ddVeO/Wy7eg8qKN/XGYqwL?=
 =?us-ascii?Q?PejFrmEOmZQ/Pjs3dYM3YDUUuRxEGuJNQV4IKmn6m2uvOHoTy8Y4xQWPeyKY?=
 =?us-ascii?Q?qsa2X8oV6qsBDSABp+3U+d2AbAQ927uDObY1Ow8yoO25rI2CTNZhx2MisuDK?=
 =?us-ascii?Q?ii4/R+90n9fIZ8UY8eynmOoI562gB1REhS5lsS/gOvqxmddBMibQiWIh7NPG?=
 =?us-ascii?Q?och+fgxVT3l6Uh3ooQ3gEkbVbBgxJylAS+nFFTtUMuQtq7CRc3bxyCR3+8z8?=
 =?us-ascii?Q?0QC3t4IkGq0q1lo8BCF2R5t2lYL/uPnE0gEBvdK7DEyhPm4vwVndM34vIpQ/?=
 =?us-ascii?Q?qfYVfqJoTZoVQwHrBmz6YTtYbqX2jOYk3LayYxuolDTnwfL3tK6ZB0Oq31O4?=
 =?us-ascii?Q?sOv/aTrU0MwBy6i21OS1NeYhKB0DPRwKq4v1lI6SXVL5UA8ucolvQedfGZXn?=
 =?us-ascii?Q?3yQOp3zUEin+OHlX34fUwWKRntwc0GqkrO843KyocPCUpzzExwXQBDP45Vp2?=
 =?us-ascii?Q?az4AOMTXZ/LXaiziVakNbK8E5i6HdZMrAYpE96ai5LDpPGtrL2dxvQUJIi4I?=
 =?us-ascii?Q?kcld+gvPOnofqyOIa29tqV7mSrwRFnmeGBqip0X3PKwabBmBRxH6Y1TwxFaM?=
 =?us-ascii?Q?H7JSSt3y+f/PxKJA4Hh+CCbNmrEmowouycJBJLYt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109c8a01-600f-4226-d766-08ddc62a3684
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:37:56.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhDFxVsJ+qC1MaNPhWu/Gk9/BUYkKlI266Rhbd9IfVju0WES82cjteABBw8kwZhV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

Instead of open coding the refcount calculation, use
folio_expected_ref_count() to calculate frozen folio refcount.
Because:

1. __folio_split() does not split a folio with PG_private, so no elevated
   refcount from PG_private;
2. a frozen folio in __folio_split() is fully unmapped, so folio_mapcount()
   in folio_expected_ref_count() is always 0;
3. (mapping || swap_cache) ? folio_nr_pages(folio) is taken care of by
   folio_expected_ref_count() too.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d98283164eda..19e69704fcff 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3731,6 +3731,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
 		struct address_space *swap_cache = NULL;
 		struct lruvec *lruvec;
+		int expected_refs;
 
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
@@ -3794,11 +3795,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		     new_folio = next) {
 			next = folio_next(new_folio);
 
-			folio_ref_unfreeze(
-				new_folio,
-				1 + ((mapping || swap_cache) ?
-					     folio_nr_pages(new_folio) :
-					     0));
+			expected_refs = folio_expected_ref_count(new_folio) + 1;
+			folio_ref_unfreeze(new_folio, expected_refs);
 
 			lru_add_split_folio(folio, new_folio, lruvec, list);
 
@@ -3828,8 +3826,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 * Otherwise, a parallel folio_try_get() can grab @folio
 		 * and its caller can see stale page cache entries.
 		 */
-		folio_ref_unfreeze(folio, 1 +
-			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
+		expected_refs = folio_expected_ref_count(folio) + 1;
+		folio_ref_unfreeze(folio, expected_refs);
 
 		unlock_page_lruvec(lruvec);
 
-- 
2.47.2


