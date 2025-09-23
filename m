Return-Path: <linux-kernel+bounces-829435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38585B97176
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7462A8A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4EF281503;
	Tue, 23 Sep 2025 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YHC1oHhp"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8427FB21
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649745; cv=fail; b=ODop8UVJBP+SgfgZzhyCyY6N8LhtZU31uIjaltXkkAhDt451y51+fKjks8142EivPLeuTPmSYzl9vUhn9mOEveeqJjmTs6HFCFnlJhR2RtAXVOb4SuVHEpw5qdnHskFXoucO7+FywaF/y4dPx5BJQq1TFrPgTR0JHe2wAkFbGGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649745; c=relaxed/simple;
	bh=VHe2DsATWLXZ8BrioSn9lCajYXXjmSGD/JdEmf9df+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpXtZRw6w4mxknjWfMkWX7rRY6yLDC79Nr+WGmLXZTBzC1ZXUmMrWxF/2SrYmh2Lgx5QJSDErONvOnB70/Mlli2CUb51bi0XTgjGfnagSTRqhJuPLxJlOOPFpSLTaVOcXyzM0XmStPP2d28imDQufSzGiiOozc1XVPpCnzyEBg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YHC1oHhp; arc=fail smtp.client-ip=52.101.57.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPMZMmedeerN61QKWBvGNOI+2+igyItFxuezchOcAe8Gmr4LlUiAVTfKlMq9UPm21OavIjY1RngreEAxZxDdOz/LJnY8YIan+086GoL8JDyGkLLOK7usRTmfbj0I3a+N1Z3GESisRe6/cg8CuYMkA8mOW4Z6umQ91JDkabEMMgN5zeJgDR+nJOa+x8FaIqHfVfOAKWvhxl37DD0D5YS4pQOaTTfq4CtLSBLPCR4CWBt13BpvPp4uQFAwz6TPtviDcEP4OmH6oOUL/azei2/mWByni8SuAr+n9JJqc/m0r6HilTo605qD0ecjKO0i9KNmDSxfkA89G7Lzc0QtqpxG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F937NWw09Hcn4DgbpPIs1W5CVMOH4s8rDaCGjvXFz1A=;
 b=NH1pAB8xTvvcrZwxrB7LSYeBil1QnZerNIFCJql+iKROORY0Fr5Xa+xYyX7xxBmFzem6VQvWECsr8CiOFL4rqyYU9f4wFlf+UAsaRi2ICSCyQr1dxsCdY5oVLHr2abB9OQ3pvD/+pabDNNKRZ04YelKZ3Mzdgqdk0eS+wKVbMMJBuJPEbXmn8NdVuOYCqPHiCrwP2zsMGuejlWZST3TFomoTTVCFJ2/3LZ8Zmfe1MLz7rA8NlIlaUMA/5h6gFEbyaNW54ds/9STXmR8CNr3yc45H+5ThWA1f2bdsRbso6VRfu/tNmtcj/wAqvf/yVs8nlEQixW6mHmrUrhSw2oMiVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F937NWw09Hcn4DgbpPIs1W5CVMOH4s8rDaCGjvXFz1A=;
 b=YHC1oHhp/svdLX9TnTbYTE8T4d6a1LPVsRhPh945zz0gjiVwQiPcLibv9J32iMif1gG/VV3Me95z4Lo+foNdah9JKer0MTXP9Q/GlTjjeKxx4meOGNIVeKO3QSPoxo7atIlkkkL5HAz/8fJ/Nk/KpXIlS9Wl8d6JK/0nsL8vYzc=
Received: from BL1PR13CA0189.namprd13.prod.outlook.com (2603:10b6:208:2be::14)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 17:48:57 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::91) by BL1PR13CA0189.outlook.office365.com
 (2603:10b6:208:2be::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 17:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 17:48:56 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 10:48:47 -0700
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>
CC: <ziy@nvidia.com>, <willy@infradead.org>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<vkoul@kernel.org>, <lucas.demarchi@intel.com>, <rdunlap@infradead.org>,
	<jgg@ziepe.ca>, <kuba@kernel.org>, <justonli@chromium.org>,
	<ivecera@redhat.com>, <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <rientjes@google.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <bharata@amd.com>,
	<shivankg@amd.com>, <alirad.malek@zptcorp.com>, <yiannis@zptcorp.com>,
	<weixugc@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC V3 3/9] mm: Introduce folios_mc_copy() for batch copying folios
Date: Tue, 23 Sep 2025 17:47:38 +0000
Message-ID: <20250923174752.35701-4-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923174752.35701-1-shivankg@amd.com>
References: <20250923174752.35701-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: c91e2cb6-d07d-45f4-97f1-08ddfac9784b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BbPDQlXucdIkXrAu8tG+tfxjVJjnxbhr2+iLh1s/eb3aSC7F/EotoIQmRu+r?=
 =?us-ascii?Q?rM6vtVLy+AuLIsKZONDjn+bv1gtI4gHm32c/XnN7l+Ec8xwjiwtLxm61LyzH?=
 =?us-ascii?Q?zQuDYxHyPsI16Mpgt0WtpHc+pSRgBVm+3vKs7XE3TcbmSBeayU5XQ7h3SGBG?=
 =?us-ascii?Q?pEUo4G0TNKAjmj25+z/BAAA6MXCU+DrHSyMOwaAZL6b4PEZYnAZ+O5TZGiq7?=
 =?us-ascii?Q?/si5Lo8B+aC1ZWAK8LPEAPRwZGbQBSAlJDB4VXOkKIuPNyvZjkUpxy04Cp/u?=
 =?us-ascii?Q?JWHJuBZIg1eTlHbYZycuuvOkc7WvSwy7xiL+RYHu7vmJMDfI6XkiM+Lw0Dac?=
 =?us-ascii?Q?zxDQGa1NTGWNpGWRdeWwCa60vr/+LA7iMES29udMLJJO8X/NmfmlYjXJOcf+?=
 =?us-ascii?Q?Kal3UycpvCCeIwwL21/Jikphm32paPFAwHpRFWMc5A80S+Ij29GTBByMdSUT?=
 =?us-ascii?Q?lbC/AC/ozyTvYEOW21mEqVvFY04uKiOUQU4/mDxvczYcifNo/imP2Aa5CQHN?=
 =?us-ascii?Q?re04nH0x7cNydVd4SEJun6HGPNFXykLPn4DlXVfExWRrdKUibkEgcW1Nwier?=
 =?us-ascii?Q?ZDXbuRSvgl1a0oeHOYOt6NUvxtklfPbEJ4C3jMkMQUnZ3kyJ6ZifsIx7dfks?=
 =?us-ascii?Q?Akg1rr8jvjndZ677CMWc65WZ23yo3Hwo5RbjKbtpBdmkuvKw+p51j6JtZfkb?=
 =?us-ascii?Q?KGXJnEyOc4caevp3RVYRBNLgjuYhVN8JCo/pSmrXQ78jSADuv3grbe84ETRv?=
 =?us-ascii?Q?l3L8lZQYzUXesYgx6tKBZa9cRFeQQDyhhd18xWpFji+X8jA3TJgvTkXMq5zK?=
 =?us-ascii?Q?/k1T99XHZ8mFHVdTQi61x0+nngblJ0qFcqvbBdQhyOLkaE7Uv5C3vVBCOYMB?=
 =?us-ascii?Q?P2patumxBgWUEpL4McXj9T0UGcv5pnDqIgEOGPC0Ssmmk/pr8CiYCXwokY4P?=
 =?us-ascii?Q?pQvHzb6061dzyU2IJXsqG06ottDq3rQ0zIhQ7uhl/4I3cBxP+Y0b7tsIQkQV?=
 =?us-ascii?Q?3+SwZQmLiieZxeqTlsVzhjrRpZ2nj4h3oE22IjPmHo/3SaTl1DuEC8wFAbBF?=
 =?us-ascii?Q?kTnPuyaSQktYa4vnipIwqoC2Z69RNuPFkRmBsJdN4DMvOQ5sXTO+5BrJVC67?=
 =?us-ascii?Q?BIrPhSOqiyJ4e9akNMcc7CA1BAGWpWSo4qdfI2ekShxV/hoIOz3nPJzxkq65?=
 =?us-ascii?Q?XK42Mk0WlabyXzveI0+Hie99mbu4/145QO4pkGviq+yqpJLBB8vQZfC0UO5N?=
 =?us-ascii?Q?7tSXNVRV6jh9A7KRUN7KEZxoKpJoDgkyK9n5Ol6zQAzDF/bq8FQD44yTkmc2?=
 =?us-ascii?Q?HxMBXJtxbirtBgLq1kzUPgPe17smw4JGJTIRzsO6OHWtie1Zfbj6Z/3xwBcM?=
 =?us-ascii?Q?9nylGpMEK53agXzVQMLFbswFnvWVhbe67+sZsTn6MbgGMSGqTEsOU7jgwi8z?=
 =?us-ascii?Q?nlYYM+zt904+aUyJI4En2t03C+uqMEHJhHPMUciY5DHH5F2N1nlpneU75rCa?=
 =?us-ascii?Q?6UU0cRtU2bCPcnYg1gnSIUuRgMdfO93l6E0C?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:48:56.9635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91e2cb6-d07d-45f4-97f1-08ddfac9784b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967

Introduce the folios_mc_copy() to copy the folio content from the list
of src folios to the list of dst folios.

This is preparatory patch for batch page migration offloading.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/mm.h |  2 ++
 mm/util.c          | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..383702a819ac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1187,6 +1187,8 @@ void __folio_put(struct folio *folio);
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
 int folio_mc_copy(struct folio *dst, struct folio *src);
+int folios_mc_copy(struct list_head *dst_list, struct list_head *src_list,
+		 unsigned int __maybe_unused folios_cnt);
 
 unsigned long nr_free_buffer_pages(void);
 
diff --git a/mm/util.c b/mm/util.c
index f814e6a59ab1..2d7758f33fc6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -748,6 +748,35 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 }
 EXPORT_SYMBOL(folio_mc_copy);
 
+/**
+ * folios_mc_copy - Copy the contents of list of folios.
+ * @dst_list: Folios to copy to.
+ * @src_list: Folios to copy from.
+ * @folios_cnt: Number of folios in each list (unused).
+ *
+ * The folio contents are copied from @src_list to @dst_list.
+ * Assume the caller has validated that lists are not empty and both lists
+ * have equal number of folios. This may sleep.
+ */
+int folios_mc_copy(struct list_head *dst_list, struct list_head *src_list,
+		 unsigned int __maybe_unused folios_cnt)
+{
+	struct folio *src, *dst;
+	int ret;
+
+	dst = list_first_entry(dst_list, struct folio, lru);
+	list_for_each_entry(src, src_list, lru) {
+		cond_resched();
+		ret = folio_mc_copy(dst, src);
+		if (ret)
+			return ret;
+		dst = list_next_entry(dst, lru);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(folios_mc_copy);
+
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 static int sysctl_overcommit_ratio __read_mostly = 50;
 static unsigned long sysctl_overcommit_kbytes __read_mostly;
-- 
2.43.0


