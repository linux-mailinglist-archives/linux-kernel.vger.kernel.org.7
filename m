Return-Path: <linux-kernel+bounces-829439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7ACB971AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6112A8AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E611E2882B6;
	Tue, 23 Sep 2025 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bsp4l238"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C717285C80
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649760; cv=fail; b=RbQy1KRPTA6zFFQeNDd/f3PnOe9QDE8VDqdD+syS0N7h2l8YlqQBop/5hm6is/XMjtvBTWItSWH6ZPMl+kBVbHa8IVVgl5+/OlRxao1YPo/QxR8MZRL4+0st7QKXvKj9AF8mCkwyKVelSwKI93FW5Gl6o3ZWj66EbDDFCObZANc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649760; c=relaxed/simple;
	bh=Io5+4aTgQLEM3AHjdwZNvRcHW5Qb0uElANacJ01Yffg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zf+vuCLlBrLvEORHKo5UdMJpEX2SmDP8wqBEqfD0wtN4iuumf7uS78Ss4SlrWzb2cU7zKRCn2p5BVCiygI7OCTCjGBxyWSkwNCjYu+yoBgbmrPWNjrjq1OLe/KT3S/5jwFV81QjVspq4GfzPSvWj1yyigU5BldHxlrZnBb5F3Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bsp4l238; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiYmHo0esN+kPnRBIE9R23iaxhCTSoTViLHSevOoaOi+5iD6uEFGloKO3q4/Uyq4PoonzNeLQK8sjqYyGglUka0kPA4oq+djUoyrXbIUDhebg2RBJHy4USZBdWckVMHWVI3xzpzA4TnQzlkuacQjxwL6gXLgRMI8bUWHX2qW++yVvrrDBycJ1MfwZv5Z7qViRAH0NQq8pC01BYq6uU59hqeE9ZMPYWFZthPX4I7fUXv9caOjBw7B4kr8/uj5Oo8hTE264x3DXRYb++Jo+RgVEWYywayG4H4aKPqEgqEWAnoxAoE0P9i/9Ez6LEQomcaeTRv3CB1kYkJ/kzsv6N8ixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF2Qac4zUCI7Q24GJOdmKjFI0FxBhpcs3iOGl7cRHs0=;
 b=woo0ZWx+KKF40kwGEqxawzw1HN4uHIZg/QRpE8xP3+7IbNoWnUJVV5ZNT6N07qJVEr3X97rOcw9OeCrgpVp/Aagayq0OKLPyeDObMgLliUgOSg4OqvVcMCaj3Vs/DFLQlxijr/smKRQmz3kCX68O+Y1OAeqYUiJRi914h8D83zK81OviD6gnIhMSMpagm8JFgh9gKAZukvnIQibRm9ZHbJvDc0h6wwTfMQb2QHE3fvzXOoS9nbLnLDe99t2YN9R3o0Gs4FOfkJDx1lVHO9nJHXzWaRLbX5eZ9QkpOhmBdSwJ+HQB23nj04ZkHP18ta0WqGv6LSYCAnldyIJJhP0Uqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF2Qac4zUCI7Q24GJOdmKjFI0FxBhpcs3iOGl7cRHs0=;
 b=bsp4l238UDubzNFtznrq/V946YiBWakYFuQo44JiW/+UJgDVtRRlnA55KwDRP+5pOdgm6T9vDx+4v1iJsurNxAaz/pIK95yPS8EHTQ7hbjS5wI5uuP/StetosGjdpTXGCAIqXuDkpQhd93BlJUaqbq7ZrJ8JferKK5VtR6S5I4I=
Received: from BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::10)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 17:49:11 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::9c) by BL1P222CA0005.outlook.office365.com
 (2603:10b6:208:2c7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 17:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 17:49:10 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 10:48:56 -0700
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
Subject: [RFC V3 4/9] mm/migrate: add migrate_folios_batch_move to  batch the folio move operations
Date: Tue, 23 Sep 2025 17:47:39 +0000
Message-ID: <20250923174752.35701-5-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bea6ddb-5773-4ef4-2555-08ddfac98070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KaKai3uP6nuNb1PEoRBCSLpbtqY1nMD+24k4jQECK23bJTjNtJ4N6UPUILtx?=
 =?us-ascii?Q?f7RXBghW1JLUzsfgZg77xRbh2m06owSQ3QiKxvZbG6yaJUQmcWNAHOKdcqIa?=
 =?us-ascii?Q?Y1olaYAxtr0ff0dSm1NvjCLMxmuAgMT+z56v3iQlHddAC3SSORXRYpjII52F?=
 =?us-ascii?Q?p52sw46qUyManZv6rIo30eSC49XHDj8FfZdQ5UHR2poDgi1U9pgYQGn0IjD9?=
 =?us-ascii?Q?Wwy/DvwR5UM2wbXSFBOwGB16RBukCZOj7z3SxYdQK/AQww0PDGt9xkeDJH+j?=
 =?us-ascii?Q?9Bp+wg5EXjlMfxFrvQaNUyKHieNJXXVw8APNbORNmghbjAAy5Y4GS2m3SW3t?=
 =?us-ascii?Q?PBFI968xBNUcKAVPTvs/aiViYwP2KNra64p9SjPHbM/ZsUUYA19VGXzMkX1H?=
 =?us-ascii?Q?rQuePgojalCq/hzV/PZHLAtChEzdgHQN3kiVPdN56LSg3z2A8pDCz8yd/yL7?=
 =?us-ascii?Q?rVO02CaahB6siLqnwt/FwR/xPE/nDKUcfjDuxwU7AQF8akx2spQoFPODC/mS?=
 =?us-ascii?Q?UGu8ewUWrSz1IFVvZaXqOD+HmhMQv1o1OS8aFEsclPPJDdLoLW9trUSwczZz?=
 =?us-ascii?Q?EkV3fYu+XZX2Ex9pm5Ce3lRsXVjCqJXNZT6C5U7efJq3tHA56Z0U3o/H6Ut7?=
 =?us-ascii?Q?dQJ6a1FKjW+PcqPfzTjVnX6z0eMWnZ8Nj3nUW4PwpTcZPBIwmXDINH93e0es?=
 =?us-ascii?Q?D2T2GYVcwusNhoK3F2uTe3m9wEdS7s+KjSM1ipjT0F/erDB0oZAZA7L1oqqa?=
 =?us-ascii?Q?+11AWQ2J4tWLxEHdHI+ubu98UqxVysWVhgAUEx8R+MRFD13wOA140o+gBha5?=
 =?us-ascii?Q?RmHl/BbBuvCbUKoSSJwydFrxSKJMDKI9MHe2PNdiQ6yNrqyxWanhMwdi+C/g?=
 =?us-ascii?Q?48FHvIGRtfhs+0av7vaIK9J8y9fscTKfdIB9K1lYxoRK2j26URXYpEC5zDNU?=
 =?us-ascii?Q?83fYn7c8gH06Cyf7FiXpaCBRz05NASqKSuWJoVgRSW8sZkMQqrtuGfUTKH9s?=
 =?us-ascii?Q?l8SD8oT2ps3X03hNMcJoNCRKjFaNVxr1blukE2vXjNClBcpI3S8uPgI1qPew?=
 =?us-ascii?Q?wGjV0RT/jrSoabdCCOV8nIdZ1ikR3h7S/EBCb2tgqciLrF7+bfNAga9JtZcH?=
 =?us-ascii?Q?FcsjdgnKOz7Cb5VLcKC/9wENYqUQFz9CPqAIyK8d0Lz5Ke4snhVsj3A8QEVP?=
 =?us-ascii?Q?5Kdv5sXgqZbUfLzwfUXvOeu06zpfnnlpfxeK4CjD+577qkXfsj4pd6Q1MJd/?=
 =?us-ascii?Q?VXPr5iuHowZ4on4pfutN5sA1XHIWyr5nlcwKr6u2+iAekKiek3LCjA3YzSu0?=
 =?us-ascii?Q?pK2z7TO2DcnnElifHBeNVtEQRGSDk0kuVIM4ZzQP7naSzJSTo4vSdpZhZzBf?=
 =?us-ascii?Q?ZMhFnehlj1iDJ5K3Rq4H110Jmb6WfymX1GndBnHO4YwclhIIlWXvN7QergS+?=
 =?us-ascii?Q?ycXrTGIMaI4EG+WpM2/6EnQJMOYbxOyLgRhpGVsGLn352iKwKesguRGyQKsa?=
 =?us-ascii?Q?5xclNhf8tpwJYrQzRpzVz2FEFJex0ULGQvRu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:49:10.6252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bea6ddb-5773-4ef4-2555-08ddfac98070
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746

This is a preparatory patch that enables batch copying for folios
undergoing migration. By enabling batch copying the folio content, we can
efficiently utilize the capabilities of DMA hardware or multi-threaded
folio copy. It uses MIGRATE_NO_COPY to skip folio copy during metadata
copy process and performed the copies in a batch later.

Currently, the folio move operation is performed individually for each
folio in sequential manner:
for_each_folio() {
        Copy folio metadata like flags and mappings
        Copy the folio content from src to dst
        Update page tables with dst folio
}

With this patch, we transition to a batch processing approach as shown
below:
for_each_folio() {
        Copy folio metadata like flags and mappings
}
Batch copy all src folios to dst
for_each_folio() {
        Update page tables with dst folios
}

dst->private is used to store page states and possible anon_vma value,
thus needs to be cleared during metadata copy process. To avoid additional
memory allocation to store the data during batch copy process, src->private
is used to store the data after metadata copy process, since src is no
longer used.

Co-developed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/migrate.c | 197 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 193 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 3fe78ecb146a..ce94e73a930d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -843,12 +843,15 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 			   enum migrate_mode mode)
 {
 	int rc, expected_count = folio_expected_ref_count(src) + 1;
+	unsigned long dst_private = (unsigned long)dst->private;
 
 	/* Check whether src does not have extra refs before we do more work */
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-	if (mode != MIGRATE_NO_COPY) {
+	if (mode == MIGRATE_NO_COPY) {
+		dst->private = NULL;
+	} else {
 		rc = folio_mc_copy(dst, src);
 		if (unlikely(rc))
 			return rc;
@@ -862,6 +865,10 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 		folio_attach_private(dst, folio_detach_private(src));
 
 	folio_migrate_flags(dst, src);
+
+	if (mode == MIGRATE_NO_COPY)
+		src->private = (void *)dst_private;
+
 	return MIGRATEPAGE_SUCCESS;
 }
 
@@ -1149,7 +1156,7 @@ static void __migrate_folio_record(struct folio *dst,
 	dst->private = (void *)anon_vma + old_page_state;
 }
 
-static void __migrate_folio_extract(struct folio *dst,
+static void __migrate_folio_read(struct folio *dst,
 				   int *old_page_state,
 				   struct anon_vma **anon_vmap)
 {
@@ -1157,6 +1164,12 @@ static void __migrate_folio_extract(struct folio *dst,
 
 	*anon_vmap = (struct anon_vma *)(private & ~PAGE_OLD_STATES);
 	*old_page_state = private & PAGE_OLD_STATES;
+}
+static void __migrate_folio_extract(struct folio *dst,
+				   int *old_page_state,
+				   struct anon_vma **anon_vmap)
+{
+	__migrate_folio_read(dst, old_page_state, anon_vmap);
 	dst->private = NULL;
 }
 
@@ -1776,6 +1789,176 @@ static void migrate_folios_move(struct list_head *src_folios,
 	}
 }
 
+static void migrate_folios_batch_move(struct list_head *src_folios,
+		struct list_head *dst_folios,
+		free_folio_t put_new_folio, unsigned long private,
+		enum migrate_mode mode, int reason,
+		struct list_head *ret_folios,
+		struct migrate_pages_stats *stats,
+		int *retry, int *thp_retry, int *nr_failed,
+		int *nr_retry_pages)
+{
+	struct folio *folio, *folio2, *dst, *dst2;
+	int rc, nr_pages = 0, nr_batched_folios = 0;
+	int old_page_state = 0;
+	struct anon_vma *anon_vma = NULL;
+	int is_thp = 0;
+	LIST_HEAD(err_src);
+	LIST_HEAD(err_dst);
+
+	/*
+	 * Iterate over the list of locked src/dst folios to copy the metadata
+	 */
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
+		nr_pages = folio_nr_pages(folio);
+
+		/*
+		 * dst->private is not cleared here. It is cleared and moved to
+		 * src->private in __migrate_folio().
+		 */
+		__migrate_folio_read(dst, &old_page_state, &anon_vma);
+
+		/*
+		 * Use MIGRATE_NO_COPY mode in migrate_folio family functions
+		 * to copy the flags, mapping and some other ancillary information.
+		 * This does everything except the page copy. The actual page copy
+		 * is handled later in a batch manner.
+		 */
+		if (unlikely(page_movable_ops(&folio->page)))
+			rc = -EAGAIN;
+		else
+			rc = _move_to_new_folio_prep(dst, folio, MIGRATE_NO_COPY);
+		/*
+		 * The rules are:
+		 *	Success: folio will be copied in batch
+		 *	-EAGAIN: move src/dst folios to tmp lists for
+		 *	         non-batch retry
+		 *	Other errno: put src folio on ret_folios list, restore
+		 *	             the dst folio
+		 */
+		if (rc == -EAGAIN) {
+			*retry += 1;
+			*thp_retry += is_thp;
+			*nr_retry_pages += nr_pages;
+
+			list_move_tail(&folio->lru, &err_src);
+			list_move_tail(&dst->lru, &err_dst);
+			__migrate_folio_record(dst, old_page_state, anon_vma);
+		} else if (rc != MIGRATEPAGE_SUCCESS) {
+			*nr_failed += 1;
+			stats->nr_thp_failed += is_thp;
+			stats->nr_failed_pages += nr_pages;
+
+			list_del(&dst->lru);
+			migrate_folio_undo_src(folio,
+					old_page_state & PAGE_WAS_MAPPED,
+					anon_vma, true, ret_folios);
+			migrate_folio_undo_dst(dst, true, put_new_folio, private);
+		} else { /* MIGRATEPAGE_SUCCESS */
+			nr_batched_folios++;
+		}
+
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+
+	/* Exit if folio list for batch migration is empty */
+	if (!nr_batched_folios)
+		goto out;
+
+	/* Batch copy the folios */
+	rc = folios_mc_copy(dst_folios, src_folios, nr_batched_folios);
+
+	/* TODO:  Is there a better way of handling the poison
+	 * recover for batch copy, instead of falling back to serial copy?
+	 */
+	/* fallback to serial page copy if needed */
+	if (rc) {
+		dst = list_first_entry(dst_folios, struct folio, lru);
+		dst2 = list_next_entry(dst, lru);
+		list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+			is_thp = folio_test_large(folio) &&
+				 folio_test_pmd_mappable(folio);
+			nr_pages = folio_nr_pages(folio);
+			rc = folio_mc_copy(dst, folio);
+
+			if (rc) {
+				/*
+				 * dst->private is moved to src->private in
+				 * __migrate_folio(), so page state and anon_vma
+				 * values can be extracted from (src) folio.
+				 */
+				__migrate_folio_extract(folio, &old_page_state,
+						&anon_vma);
+				migrate_folio_undo_src(folio,
+						old_page_state & PAGE_WAS_MAPPED,
+						anon_vma, true, ret_folios);
+				list_del(&dst->lru);
+				migrate_folio_undo_dst(dst, true, put_new_folio,
+						private);
+			}
+
+			switch (rc) {
+			case MIGRATEPAGE_SUCCESS:
+				stats->nr_succeeded += nr_pages;
+				stats->nr_thp_succeeded += is_thp;
+				break;
+			default:
+				*nr_failed += 1;
+				stats->nr_thp_failed += is_thp;
+				stats->nr_failed_pages += nr_pages;
+				break;
+			}
+
+			dst = dst2;
+			dst2 = list_next_entry(dst, lru);
+		}
+	}
+
+	/*
+	 * Iterate the folio lists to remove migration pte and restore them
+	 * as working pte. Unlock the folios, add/remove them to LRU lists (if
+	 * applicable) and release the src folios.
+	 */
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
+		nr_pages = folio_nr_pages(folio);
+		/*
+		 * dst->private is moved to src->private in __migrate_folio(),
+		 * so page state and anon_vma values can be extracted from
+		 * (src) folio.
+		 */
+		__migrate_folio_extract(folio, &old_page_state, &anon_vma);
+		list_del(&dst->lru);
+
+		_move_to_new_folio_finalize(dst, folio, MIGRATEPAGE_SUCCESS);
+
+		/*
+		 * Below few steps are only applicable for lru pages which is
+		 * ensured as we have removed the non-lru pages from our list.
+		 */
+		_migrate_folio_move_finalize1(folio, dst, old_page_state);
+
+		_migrate_folio_move_finalize2(folio, dst, reason, anon_vma);
+
+		/* Page migration successful, increase stat counter */
+		stats->nr_succeeded += nr_pages;
+		stats->nr_thp_succeeded += is_thp;
+
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+out:
+	/* Add tmp folios back to the list to re-attempt migration. */
+	list_splice(&err_src, src_folios);
+	list_splice(&err_dst, dst_folios);
+}
+
 static void migrate_folios_undo(struct list_head *src_folios,
 		struct list_head *dst_folios,
 		free_folio_t put_new_folio, unsigned long private,
@@ -1986,13 +2169,19 @@ static int migrate_pages_batch(struct list_head *from,
 	/* Flush TLBs for all unmapped folios */
 	try_to_unmap_flush();
 
-	retry = 1;
+	retry = 0;
+	/* Batch move the unmapped folios */
+	migrate_folios_batch_move(&unmap_folios, &dst_folios,
+				put_new_folio, private, mode, reason,
+				ret_folios, stats, &retry, &thp_retry,
+				&nr_failed, &nr_retry_pages);
+
 	for (pass = 0; pass < nr_pass && retry; pass++) {
 		retry = 0;
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
-		/* Move the unmapped folios */
+		/* Move the remaining unmapped folios */
 		migrate_folios_move(&unmap_folios, &dst_folios,
 				put_new_folio, private, mode, reason,
 				ret_folios, stats, &retry, &thp_retry,
-- 
2.43.0


