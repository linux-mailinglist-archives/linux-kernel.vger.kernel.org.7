Return-Path: <linux-kernel+bounces-795547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C2B3F443
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67E51A811A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D892E1722;
	Tue,  2 Sep 2025 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a4jChifV"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043E2DF15F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 05:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756790079; cv=fail; b=jHfbEbeWylGZgF5zRJgelDgOAV4Z9EJXbxuhUDFCTlJE2ZdbjoeVoiFRrYbpWd8T8/RYH2dsvH6WQ59rysVrdeRLgJ6QGNJJ7LVoRpshmcDYtqUm8EVRYE7rExpWkEwYtY001KGlf/RcWgEYQlj2H1cK/3aO84M57Oa5EAToxlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756790079; c=relaxed/simple;
	bh=1y5Z9XymXNAepOxLsjOhrDTvOCMB1qz8rj2zYaoq8Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XHeXa52BAgKWn+t4JoKYuL+RLZ9cv/rKRyH5s5O0q5bfq9fZhzZ4coplj34fodEnqCVtnxSAB/CeWWpT9uwCXZ+uj6e119mKHI+RRO0hxM2rUipVRyyH5xYFafwZrzKeomxYRUUnQTeEqlZw5PPER0URnrM3xQRaDPAsAbyuRbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a4jChifV; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQhM/YRU26H5HAF515n8MHR0m+7AMSU3x95JXszAqlQJiUmY6shktYl2R1KtFAWXM9f8IQQGLct/3Z/7GO7dazPSzAG39zuqy7T0/qZGDolXWBfQ73CVGu57GhkufTkBvX0taZ90dlE9bAWEHx+MvvUihzxLgtUgJvrxsuTJlbpE+2+rS0fLpDMgVB5eNCb+Wb4RLTPWIHAG9/P4rFtexZeRyExg0QNZYi73TXz0nL00lDovAd9AuwhJJwNkzFSvY0YhfsBjXjLZvdydEy8DWuv0COujKAJTlXqD5wKhHj8TLqOlwtGgYWHdzF4UYozHeSz+1OdeRLnrlLjfjURWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYXip+wVckS2ZjQuUYONI7UXiOV+HjnnG1bZGwwWrRE=;
 b=HS9m7PVqbUiEnbgKzVEXoV5i+XyKqDN4kWTOd3+m3jgAwKjff4+FuebJm/PLXADhrc6OjF3MJ4NWKvoIdcIFDOGZBRWX6pupajp30iytDezdY12m4+L/R6BSAwU2d5ytqKusSAYovX3trN1j+p166Dpu+24wTCbK+uSASlv41V0F/jGT+GVtmTpz/6D28S3Aw5XlWtx0enWxbEr0Dy1vZZTv1zq3RlHoXp2/NA0w+HFnCM//zybx8HZLP5kh28LuqHore45Reh9rp9wG+OM/YrTdGmYqUuMOB/l2LLgzIg3Ks+fNM3IdI8C08yo6iwU7JE3qiYpbsrLHojHbttYvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYXip+wVckS2ZjQuUYONI7UXiOV+HjnnG1bZGwwWrRE=;
 b=a4jChifVbsJ7SuhquI+qOKbol14lu5lON5CcEVxMq9w710goMgT2ch9PJcJzE1i7+lOUJAaouQnHD4YnnzzH5LfgvbDgcv7V0Yuwd11bzrouB/2z//dvZALmxHQf6HPlGxoKSvsyE8yAS9D7WKbM5iDmURWguf8csntbCNna+NmHIS+gaCWWQCtibCSTkilUOJMI0mk/bAkGx81NetTksCdDKLZS0PwWttC4YVYCgUyJCzm2zQSusXWM6Ap59mX0F2lN48HH6n23KMacgBR1BTxskpC7SbM5HgUr8Rf1Ci7HfWsILXfuJwa8PmCsEPEyx0uqhZnb3/Vzb4V569pSRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 05:14:32 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%7]) with mapi id 15.20.9009.017; Tue, 2 Sep 2025
 05:14:32 +0000
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
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 1/2] mm/gup: Remove dead pgmap refcounting code
Date: Tue,  2 Sep 2025 15:14:20 +1000
Message-ID: <20250902051421.162498-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0025.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::12) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: e24dc0d7-18ab-4d7b-64dd-08dde9df994e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n5dyQDFNz/HHS12xZwFCsL0aqiq/gE/W0Xg1baqhJHS8qMRbDaU7/plc+gep?=
 =?us-ascii?Q?k344xKArBmRPh/hZ6VBLph+OR0HqUGQOO5YCHnnypkmjsU8ywDenIhGAJCpK?=
 =?us-ascii?Q?HSZqXwk5e1T410htGzU28O6iQfjNWZq2xCjMG+U1EjWgEW8P2/PWFzBBZsQF?=
 =?us-ascii?Q?RuK+9VDK0WTFVtrMlIdUMwgYEPrM9qW77x//fQNOCZnP1jmDj0PKkdc8QgHm?=
 =?us-ascii?Q?zvVUzxyCw9bfia5YUfKYGRKfvedlRNfTBU03iaBggsnx1g/Leh9hFak+iomv?=
 =?us-ascii?Q?329iApG772KIonYWXNPDPez9Jwp3y0NVXvQsWC2LfiiYpE+ylN6djURMipr1?=
 =?us-ascii?Q?SLs2Xf8fy2uZCtJU8b9lP5TkQBYCaj9Kr0WNlUR785vdSIU4ZtMRO4AiYiaK?=
 =?us-ascii?Q?I7YlfFQO35/11Ih3caO5WNN9flV1z7I+zbRoMwej6iTY9kxzr1iFf71KxO+r?=
 =?us-ascii?Q?VyNehHcTI9uUjcMGnt1433w9kZqu1W4l5Etk+qOO5pQOdfQuOApF2N3kBbLC?=
 =?us-ascii?Q?19FCsdf2I6Aqy6g3yHgO1CbOayP/s0j3LcYfBnFW+hw9mGMhFszi1N+MmYnD?=
 =?us-ascii?Q?OJ+kJjVeRDG0LoMrML5y/UfpN2PjP/B3I1wgbmwa9NSvT3BEKkUJz2qvmA3s?=
 =?us-ascii?Q?UO/AHItxmwQ4cLfyqyjMKejfhYRoGPIJB59Oi3QSDI0cWg7tx8ufe/+p9jOG?=
 =?us-ascii?Q?Y8HjK00s98JJROfjYaxvmeeNrJQK3uHRNo/B66lPvcMxmg4uy96cL0/4FK52?=
 =?us-ascii?Q?qBWGQ9OI8d1YxU6Qw20DsBAmGCZe18MIyu+4UCuQmhYB+zYAZCiY1b+r0GqU?=
 =?us-ascii?Q?Ft4m17kkggo+CQbQUzFJ5uJvcJvbNlsoRfxi0+tnWq0Ahye3jRAFcluJUNZY?=
 =?us-ascii?Q?T25qr0aRRCMkmtB3koUWRiloJW4zDZsiG2iNJo5K/eRe4E3bEB54Ugvm3plc?=
 =?us-ascii?Q?ELeyftck35bybKcCuJOVOYLRGR/cVnuWUcHqQk+0Z7LxbmTNDQsBZHTgvqiI?=
 =?us-ascii?Q?YbrB3pzsTdcpPargU9/LPvyLvemxmB+IPWRv1tK0WQ3/xA57dkU8MvRvtVlc?=
 =?us-ascii?Q?Kct0bWbGNZ5p3zSQN4k69tte1HcyrDJCPZZZSnGmiPiQ2rqnz10QFbNF5d6B?=
 =?us-ascii?Q?2ATJh6NH3IcO1GcrJVWj3/DXgHBCSV+JA/NEHL1J+oOxssNiw0aOGCIX8t9o?=
 =?us-ascii?Q?2EnM5ygwUb/rbmdJBn2aLoV0tXtyFzE+bAM4QiLhyQhbGelOP+wZKbohJffh?=
 =?us-ascii?Q?4nl8COqjQFyADLkQ3u4opxVW18Ci3xm+WiAkumG3wBhEe8zfKehjHybsnomE?=
 =?us-ascii?Q?jWkW5NgdupLqGtGT8rZab1Eg/a64yaDe9yFx4uFtmSbGQ15oLo1k/kxaaPxK?=
 =?us-ascii?Q?ZKufJ/isvyWlas6AwN1Cz6UNQK6v3TXm2oTovET2z0t8Lcb7BoaVSEo77edN?=
 =?us-ascii?Q?A+X7jd0ujLE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K2HBw7eLflNzVlJ2BrFohA4Dg03DBUG9VzAOIBbw75WiTxwYs6lvcXjum+EV?=
 =?us-ascii?Q?mcJaB7mZi2yKP8t9pn28q4ohiz649HDwHILHceJu6Jef29LP8p6Obxo2Z18F?=
 =?us-ascii?Q?SwFBvHqEsk2YN8Bju0sgWUFLJGpNCOUO6erZ5XurJNe6hK5x1WeoVgy6bAhD?=
 =?us-ascii?Q?Bq/N2scNgeRKQyRLUA4mR8xKyZS6MoC+j2wqUaK9FI6EJ+SPj8fmcalyGo3t?=
 =?us-ascii?Q?nf+teFStPaYV3XL0VyOscXFhNK0psC6aDTwyrHEuoW/bJu1Pm+kfcUf329EP?=
 =?us-ascii?Q?fnEx/VEU9/Nd/0vhQYlIK2q8zSeRZkGT1Ja2kQQjm99/JMzHMMbp6SHDbasS?=
 =?us-ascii?Q?Te/RD7rOQary/PGVK6jlwHEw7Ncw3r9s3RhypibXpQHTjtjtcnhLR9o0rxZy?=
 =?us-ascii?Q?rVKKTN6pqIswMg7Ua1TscLzVC+XOpFOIZTiG11yJaawQXgUkjP1i4RrfiaP5?=
 =?us-ascii?Q?c3gAi4BGC7Y6uHOVheoTaounDhY0nmNXz/iNFcRwFM7n7DrDTH+RDWC8KY1D?=
 =?us-ascii?Q?Iy6uwlKsOJJk4q83uVNx8nh2oFTP9CWLEG9z4PCkg///FgqU4y8IRkg1m+AX?=
 =?us-ascii?Q?I1+U27axU7Sg2rjMTE40cYInu6Nn/I97K8MKY6I2VrQtJE3f5HDlYrM15phn?=
 =?us-ascii?Q?D+UgVMkkNb2pTH6ulC7MiiVpH6fsvKmCw3GToUx3e5/1Mb3x/8kpIoYopruD?=
 =?us-ascii?Q?dCzQ7wAy/vzzEl7fXfNeDSnNKLSC5zbeAolysfdQWvP/WxpJC80qcdyZZxu2?=
 =?us-ascii?Q?GRKPeVSMSgz6BKQ2Bv3pWCnNWfaYgEQA2zXCuYnD5u4YFzPG4qrmMTfdGUZH?=
 =?us-ascii?Q?B8HOBwz0va6dXOl9ulY0/Py+rgI73F9GchPETps77M6WcpHBfDOhj050jKmz?=
 =?us-ascii?Q?MWfnMcuC+7R8qvXC0ndRZ3VRHI6UA5PcAWz67bpgONQzXPNGuCfZad3McQAB?=
 =?us-ascii?Q?/eka5jmQoQ9R+5hwN31DKf9Z+5ujcj/AVmfdkNiPjx8XKJgYiW4+Ea8KRv7+?=
 =?us-ascii?Q?g70ZhC27Uy6cn9TC73uBbe+k+/pF3RoA/6O2y9mWmtb9c/qRJUMSFF1K72+A?=
 =?us-ascii?Q?5u2ynnppZFEJr4vn8QSVNQDsXtF7pOspBbGaDsjhKYARuyUfUulFiqWbIXkl?=
 =?us-ascii?Q?gfDXcUx2YACHbJHP0fMtx3WmKae81LYkCHut+Q/45pxLhNrm+g6hQbwRd04V?=
 =?us-ascii?Q?J0PSc2N4eeiuQGEqO3qlstD7Xnxz1iiQvkoKPI3PJSK92cq/rigeir1utzWx?=
 =?us-ascii?Q?h7G/Iy7Nq15loOnkcQEgRTJ/XGAETIgHEmI/JbRPWG0bIpKXn9dKbRtMrMNu?=
 =?us-ascii?Q?0ZSiHn0++gwIch4y6Sd8Eceu0PwLDpXkhOS7Z9qMwAhZyDZrEMH3HKN1ylqR?=
 =?us-ascii?Q?ACRjoT8IBvps0FcXBt+6a+uMoAEtOAe8t0UGOu8wsC9xtbhmyY7jjUGyVoY6?=
 =?us-ascii?Q?RRYf0dG0rW5mgXki/GTopERb3xrSX5r6bpMlVTTSuqosZUiD04Ff1tIyZqzo?=
 =?us-ascii?Q?pA20jeLeyKPtYOFGIuRFGnKh8vZ5QKFrm5B/qucPoYfckeIR6aH1IYwqal9h?=
 =?us-ascii?Q?fD1XYi0eXUh9REE/paYH2Rb8re1Icc4qWwRdYOE+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24dc0d7-18ab-4d7b-64dd-08dde9df994e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 05:14:31.8931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/TPlOas+juMls054yHgLf0oJxMyp2cEGJu5tJ3TXnnXCkW6cRDgzsG0gJyikTz06w/Ila7Ufq4UOZ8BpjeCXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409

Prior to aed877c2b425 ("device/dax: properly refcount device dax pages
when mapping") ZONE_DEVICE pages were not fully reference counted when
mapped into user page tables. Instead GUP would take a reference on the
associated pgmap to ensure the results of pfn_to_page() remained valid.

This is no longer required and most of the code was removed by
fd2825b0760a ("mm/gup: remove pXX_devmap usage from get_user_pages()").
Finish cleaning this up by removing the dead calls to put_dev_pagemap()
and the temporary context struct.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/gup.c | 67 ++++++++++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 41 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index adffe663594dc..be5791a43c735 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -28,11 +28,6 @@
 #include "internal.h"
 #include "swap.h"
 
-struct follow_page_context {
-	struct dev_pagemap *pgmap;
-	unsigned int page_mask;
-};
-
 static inline void sanity_check_pinned_pages(struct page **pages,
 					     unsigned long npages)
 {
@@ -661,7 +656,7 @@ static inline bool can_follow_write_pud(pud_t pud, struct page *page,
 
 static struct page *follow_huge_pud(struct vm_area_struct *vma,
 				    unsigned long addr, pud_t *pudp,
-				    int flags, struct follow_page_context *ctx)
+				    int flags, unsigned long *page_mask)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *page;
@@ -688,7 +683,7 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 	if (ret)
 		page = ERR_PTR(ret);
 	else
-		ctx->page_mask = HPAGE_PUD_NR - 1;
+		*page_mask = HPAGE_PUD_NR - 1;
 
 	return page;
 }
@@ -714,7 +709,7 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 				    unsigned long addr, pmd_t *pmd,
 				    unsigned int flags,
-				    struct follow_page_context *ctx)
+				    unsigned long *page_mask)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t pmdval = *pmd;
@@ -751,7 +746,7 @@ static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 
 	page += (addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT;
-	ctx->page_mask = HPAGE_PMD_NR - 1;
+	*page_mask = HPAGE_PMD_NR - 1;
 
 	return page;
 }
@@ -759,7 +754,7 @@ static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 #else  /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 static struct page *follow_huge_pud(struct vm_area_struct *vma,
 				    unsigned long addr, pud_t *pudp,
-				    int flags, struct follow_page_context *ctx)
+				    int flags, unsigned long *page_mask)
 {
 	return NULL;
 }
@@ -767,7 +762,7 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 				    unsigned long addr, pmd_t *pmd,
 				    unsigned int flags,
-				    struct follow_page_context *ctx)
+				    unsigned long *page_mask)
 {
 	return NULL;
 }
@@ -813,8 +808,7 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
-		unsigned long address, pmd_t *pmd, unsigned int flags,
-		struct dev_pagemap **pgmap)
+		unsigned long address, pmd_t *pmd, unsigned int flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct folio *folio;
@@ -912,7 +906,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 				    unsigned long address, pud_t *pudp,
 				    unsigned int flags,
-				    struct follow_page_context *ctx)
+				    unsigned long *page_mask)
 {
 	pmd_t *pmd, pmdval;
 	spinlock_t *ptl;
@@ -926,7 +920,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	if (!pmd_present(pmdval))
 		return no_page_table(vma, flags, address);
 	if (likely(!pmd_leaf(pmdval)))
-		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+		return follow_page_pte(vma, address, pmd, flags);
 
 	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(vma, flags))
 		return no_page_table(vma, flags, address);
@@ -939,16 +933,16 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	}
 	if (unlikely(!pmd_leaf(pmdval))) {
 		spin_unlock(ptl);
-		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+		return follow_page_pte(vma, address, pmd, flags);
 	}
 	if (pmd_trans_huge(pmdval) && (flags & FOLL_SPLIT_PMD)) {
 		spin_unlock(ptl);
 		split_huge_pmd(vma, pmd, address);
 		/* If pmd was left empty, stuff a page table in there quickly */
 		return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
-			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+			follow_page_pte(vma, address, pmd, flags);
 	}
-	page = follow_huge_pmd(vma, address, pmd, flags, ctx);
+	page = follow_huge_pmd(vma, address, pmd, flags, page_mask);
 	spin_unlock(ptl);
 	return page;
 }
@@ -956,7 +950,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 static struct page *follow_pud_mask(struct vm_area_struct *vma,
 				    unsigned long address, p4d_t *p4dp,
 				    unsigned int flags,
-				    struct follow_page_context *ctx)
+				    unsigned long *page_mask)
 {
 	pud_t *pudp, pud;
 	spinlock_t *ptl;
@@ -969,7 +963,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	if (pud_leaf(pud)) {
 		ptl = pud_lock(mm, pudp);
-		page = follow_huge_pud(vma, address, pudp, flags, ctx);
+		page = follow_huge_pud(vma, address, pudp, flags, page_mask);
 		spin_unlock(ptl);
 		if (page)
 			return page;
@@ -978,13 +972,13 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	if (unlikely(pud_bad(pud)))
 		return no_page_table(vma, flags, address);
 
-	return follow_pmd_mask(vma, address, pudp, flags, ctx);
+	return follow_pmd_mask(vma, address, pudp, flags, page_mask);
 }
 
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 				    unsigned long address, pgd_t *pgdp,
 				    unsigned int flags,
-				    struct follow_page_context *ctx)
+				    unsigned long *page_mask)
 {
 	p4d_t *p4dp, p4d;
 
@@ -995,7 +989,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	if (!p4d_present(p4d) || p4d_bad(p4d))
 		return no_page_table(vma, flags, address);
 
-	return follow_pud_mask(vma, address, p4dp, flags, ctx);
+	return follow_pud_mask(vma, address, p4dp, flags, page_mask);
 }
 
 /**
@@ -1003,20 +997,16 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
  * @vma: vm_area_struct mapping @address
  * @address: virtual address to look up
  * @flags: flags modifying lookup behaviour
- * @ctx: contains dev_pagemap for %ZONE_DEVICE memory pinning and a
- *       pointer to output page_mask
+ * @page_mask: a pointer to output page_mask
  *
  * @flags can have FOLL_ flags set, defined in <linux/mm.h>
  *
- * When getting pages from ZONE_DEVICE memory, the @ctx->pgmap caches
- * the device's dev_pagemap metadata to avoid repeating expensive lookups.
- *
  * When getting an anonymous page and the caller has to trigger unsharing
  * of a shared anonymous page first, -EMLINK is returned. The caller should
  * trigger a fault with FAULT_FLAG_UNSHARE set. Note that unsharing is only
  * relevant with FOLL_PIN and !FOLL_WRITE.
  *
- * On output, the @ctx->page_mask is set according to the size of the page.
+ * On output, @page_mask is set according to the size of the page.
  *
  * Return: the mapped (struct page *), %NULL if no mapping exists, or
  * an error pointer if there is a mapping to something not represented
@@ -1024,7 +1014,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
  */
 static struct page *follow_page_mask(struct vm_area_struct *vma,
 			      unsigned long address, unsigned int flags,
-			      struct follow_page_context *ctx)
+			      unsigned long *page_mask)
 {
 	pgd_t *pgd;
 	struct mm_struct *mm = vma->vm_mm;
@@ -1032,13 +1022,13 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 
 	vma_pgtable_walk_begin(vma);
 
-	ctx->page_mask = 0;
+	*page_mask = 0;
 	pgd = pgd_offset(mm, address);
 
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		page = no_page_table(vma, flags, address);
 	else
-		page = follow_p4d_mask(vma, address, pgd, flags, ctx);
+		page = follow_p4d_mask(vma, address, pgd, flags, page_mask);
 
 	vma_pgtable_walk_end(vma);
 
@@ -1376,7 +1366,7 @@ static long __get_user_pages(struct mm_struct *mm,
 {
 	long ret = 0, i = 0;
 	struct vm_area_struct *vma = NULL;
-	struct follow_page_context ctx = { NULL };
+	unsigned long page_mask = 0;
 
 	if (!nr_pages)
 		return 0;
@@ -1418,7 +1408,7 @@ static long __get_user_pages(struct mm_struct *mm,
 						pages ? &page : NULL);
 				if (ret)
 					goto out;
-				ctx.page_mask = 0;
+				page_mask = 0;
 				goto next_page;
 			}
 
@@ -1441,7 +1431,7 @@ static long __get_user_pages(struct mm_struct *mm,
 		}
 		cond_resched();
 
-		page = follow_page_mask(vma, start, gup_flags, &ctx);
+		page = follow_page_mask(vma, start, gup_flags, &page_mask);
 		if (!page || PTR_ERR(page) == -EMLINK) {
 			ret = faultin_page(vma, start, gup_flags,
 					   PTR_ERR(page) == -EMLINK, locked);
@@ -1474,7 +1464,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			goto out;
 		}
 next_page:
-		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
+		page_increm = 1 + (~(start >> PAGE_SHIFT) & page_mask);
 		if (page_increm > nr_pages)
 			page_increm = nr_pages;
 
@@ -1524,8 +1514,6 @@ static long __get_user_pages(struct mm_struct *mm,
 		nr_pages -= page_increm;
 	} while (nr_pages);
 out:
-	if (ctx.pgmap)
-		put_dev_pagemap(ctx.pgmap);
 	return i ? i : ret;
 }
 
@@ -2853,7 +2841,6 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, unsigned int flags, struct page **pages,
 		int *nr)
 {
-	struct dev_pagemap *pgmap = NULL;
 	int ret = 0;
 	pte_t *ptep, *ptem;
 
@@ -2926,8 +2913,6 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 	ret = 1;
 
 pte_unmap:
-	if (pgmap)
-		put_dev_pagemap(pgmap);
 	pte_unmap(ptem);
 	return ret;
 }
-- 
2.47.2


