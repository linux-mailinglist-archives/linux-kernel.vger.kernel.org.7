Return-Path: <linux-kernel+bounces-810435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5AB51AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B52B3B61D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B19332BF40;
	Wed, 10 Sep 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S4Q1S9sH"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B95335BBE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515693; cv=fail; b=spqx9VLyYN2VfN7tC2kzVULhJkz/es1PDy541q13SZCkyHiE3/4NmcWvxclAd0hmhlRGcUjOROLS7i11jB3bp1b4TQAckVu/g9t4ZHk57LI8Swu9IIS2Qj7wTZfbg7nQX43KuRYTX4+KzmFdVh2/f1n8q5BC2h5W7vuIHjjB9PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515693; c=relaxed/simple;
	bh=0Mzfn8jVkDBGv+EPTCCwEKfprsAoJUHo7rLXtqELwlQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fASsXNQKYQtP2+0VhO7SwWW50Jz8BskVhHD0VkdAiFYOPfMQFhiHmTjjEnDeRppaPAPg1z/nB9M3s1ubbLoiz/LWJQebqwrMCUNfKaWm6p9HPtAq+4xjO/eRNrXt6+7GdD2z4qTf7xMLzXIg4fL/ptNQvggufmswgnMg77qCoOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S4Q1S9sH; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmiYE7kxdYnrDjzFLo6PRFZ8BXrv0P+PHXnuihtBk/zPmgOBshzGHISwDTcaGSaWwCHBLYwhy3/wylTdAhED2zoUYH26j710M2uckYDbe1UyMUctGrUq7gnO0P3Z5rduGxfBmgmt6hEeVxSJX0zqb9huhMBzj55rkTsw+LxWcoRsEtH4ghYD1qHTKMzI7Bq+N75bsbRPBWMcpe1loKySAZt+Ss4GhNWdPXOwu5fRxMMp4esfXRlVF/lX7uhoavZBmM5PBEZvKjmDiR2MMshZd+vIMA0Ki3sa5CHYehKZ9zrqNdRv6Rjm6vOGBlC4gZjDLwLWiVITm7zJM5rCoKd6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59SFms/JUIGx4TGCwTHjqBFEnu6Eg/N9XnnXI3pfq4E=;
 b=sdXPzmAFgytxb1uKN0n9mgPtBSLztYuuxCqhWtQ7ZfiPnoY8bREQEIOEfKAwsvFzKAiolr9PaYIL+R6GT6d/lRrV5Ys/4GDinYEXmBUWwbgB5SI/ZvhzNCE2L/Am9MyhGUFAvoxGz5oJODXl1nHXcJq+whamKW1tkLVx222nwNNnsqn8/xem0xtHhvFziDf8U1UYGJ0klpx0kPdK/G182bGln/5ArO6bo/MTsU3TznoDjeQkr+CqP359DZMCcIr9JHodjEdhbBPgipZet9peN9Nxs8jlk8Q6sryj12rQougbxCEuyDgZIffRGX3l+AQDQ//NtlzLhmoh1SRh917A2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59SFms/JUIGx4TGCwTHjqBFEnu6Eg/N9XnnXI3pfq4E=;
 b=S4Q1S9sHzzrA9Zn/soAK1gYtdtqMo7b+5dH3tFqVep+cPOevKPWZCWwT0LIpvHvOsjBbqhRX/RZ357IXqezoG/hh//wutP3+qZOpD27N8hLpbGga7bLphYQvpHjXOZFLQHJxO8j5dQ/CFcINZnhhl15ya8sBTvpEhxOUf8C61O8=
Received: from SJ0PR05CA0194.namprd05.prod.outlook.com (2603:10b6:a03:330::19)
 by IA0PPFC855560D7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:48:09 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::72) by SJ0PR05CA0194.outlook.office365.com
 (2603:10b6:a03:330::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 14:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 14:48:08 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 07:47:51 -0700
From: Bharata B Rao <bharata@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <Jonathan.Cameron@huawei.com>, <dave.hansen@intel.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <mgorman@techsingularity.net>,
	<mingo@redhat.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <sj@kernel.org>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <nifan.cxl@gmail.com>,
	<xuezhengchu@huawei.com>, <yiannis@zptcorp.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <byungchul@sk.com>, <kinseyho@google.com>,
	<joshua.hahnjy@gmail.com>, <yuanchu@google.com>, <balbirs@nvidia.com>,
	<alok.rathore@samsung.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v2 1/8] mm: migrate: Allow misplaced migration without VMA too
Date: Wed, 10 Sep 2025 20:16:46 +0530
Message-ID: <20250910144653.212066-2-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910144653.212066-1-bharata@amd.com>
References: <20250910144653.212066-1-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|IA0PPFC855560D7:EE_
X-MS-Office365-Filtering-Correlation-Id: 466821a8-3dcd-4df7-5d1e-08ddf0790f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avUst6lbps44cO2VOJRGLc27X8A3Hmzeh6V1f3XFhnGO18slLvbuBKZB6HXB?=
 =?us-ascii?Q?z+AyDv8hynzEgirqGXZV0nao4UBW/cLN/OkTglTfHWf2LgC5OgZp993C8F2f?=
 =?us-ascii?Q?MDL60hD7F4jaUjsEybG7KyVBeY6OrYZPEhghy3+Rwh+wC+0e/rcVdssLt+Ry?=
 =?us-ascii?Q?guEirsg09PJHDHRJSOFmCZTiIuiKbKm01it6h30f6lU6UfjMN8KBbXQTwosX?=
 =?us-ascii?Q?qXh7X+k1+raLRP9raxm9G0A3evjg3DUjVsLJ2dHpKNT+8EDkS/H6EB++LL0J?=
 =?us-ascii?Q?SOYkRsNh8cnv2JqaSf7inUmAY1s0J+IpxwiZQNOG2+e/FZvK6RkakpPLMiXq?=
 =?us-ascii?Q?BoY/oNvE3IDfLVpkBjIX+WAOrW6jkBjA576T5Wt3TsheGlcwNz6fIYtHoPvl?=
 =?us-ascii?Q?KPjJQaympL6YQiCapfHC12/M+oDe/yumwEoRJ8rI+n8AXyP2OVJVbfXvuSTh?=
 =?us-ascii?Q?SxztUtInoEXJ3UmO//D/g12z31JK3pWFCIEfvRkIWT872jakwxBcUsRWOA5S?=
 =?us-ascii?Q?S6/gnuA8qB9FUE7CAExNZg29JDNGmuvB9XzMm5eq8YVyIo8h0C07DEx/zzhF?=
 =?us-ascii?Q?JYaytQlcBSYQzVeb6/10Ew4X+gozuOZzWuY2mUxoZa0QFxBSmXC6m8/xhMd4?=
 =?us-ascii?Q?/HA6n86er79yykF//Gf9tcInW4f1mOOnRf9m5KznxHSwA9Sf/Gb/YnXHAMt/?=
 =?us-ascii?Q?f+5iTI8ORGz/FhP3ocp1LdAlJ0qqnL4abttvcUFa8+yjqYxiJVvZV+3yBzGB?=
 =?us-ascii?Q?SVefK0mgPH9kmZ+aIbhXQTJeWMOiZEzmvAexSqhKaxqEYXBd7mQv6NZCu0/u?=
 =?us-ascii?Q?XENmyBsIjibWlDzxQVAwtJScl1tVQ/HqqT9+3XSDi0j/LZOBTOCKAPyQpiON?=
 =?us-ascii?Q?/1ldNr2XVBXZhEO554qXNM8b+1WkN8EG3NMVQe2W1eEArasq8rVmlYn130Ev?=
 =?us-ascii?Q?ScVcix/Cm0axLCbYlSVNv7QrFZdEsPgwJNHrgG9lHLMdk6mAk3u9ESTN1Gly?=
 =?us-ascii?Q?BWjrVkaMJmzw3dFE8JmbFxthWB4UBT0RqmjGurlhJUAdOnwMiJWvTfrCt/be?=
 =?us-ascii?Q?1GPOJjoVjDZgBKXG6PcfdqDU7X+Kv32IA1KluhIUvQXcWC4VZSrXfvV1Yr2j?=
 =?us-ascii?Q?rhbuoM/rd53MNssY4/kVeWRAraMdwFMF/iNxQ10gOLwKWcN6bQkwaALDBEkq?=
 =?us-ascii?Q?st0V4mfCTbh8uhcuqQA/1dS3k0ybbHBLNfUwAfP+zgmt8aIEmNDvvAWihZ55?=
 =?us-ascii?Q?95ERjcB1EtSZi1ziUP5GIq4htCRrNP39ufwoYYmDItF6vQflE2Yg89dkMboK?=
 =?us-ascii?Q?IGLHPthacNDzzIUYHTv4vvl2PpgwKQdsQCMKLoD3cbaYG8A1n2xX4VYSzJSP?=
 =?us-ascii?Q?b5VTnyohz4XkkS7FVcyYsFbcIPzAA7IfBCmcjWW/w3GqJpqFhXDAvILjueat?=
 =?us-ascii?Q?qtY/nZbfX5uUdxJtGj1vIagSAL7Qkor2/BJC2N9ke6Kb5XS6FZptUCMKmg0J?=
 =?us-ascii?Q?6AGoNh19K8PIVVNK7UCsP2EltzqGUEEWF6jb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:48:08.9570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466821a8-3dcd-4df7-5d1e-08ddf0790f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7

We want isolation of misplaced folios to work in contexts
where VMA isn't available. In order to prepare for that
allow migrate_misplaced_folio_prepare() to be called with
a NULL VMA.

When migrate_misplaced_folio_prepare() is called with non-NULL
VMA, it will check if the folio is mapped shared and that requires
holding PTL lock. This path isn't taken when the function is
invoked with NULL VMA (migration outside of process context).
Hence for such cases, it is not necessary this function be
called with PTL lock held.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 mm/migrate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 425401b2d4e1..7e356c0b1b5a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2619,7 +2619,8 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 
 /*
  * Prepare for calling migrate_misplaced_folio() by isolating the folio if
- * permitted. Must be called with the PTL still held.
+ * permitted. Must be called with the PTL still held if called with a non-NULL
+ * vma.
  */
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node)
@@ -2636,7 +2637,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * See folio_maybe_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
+		if (vma && (vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
 			return -EACCES;
 
 		/*
-- 
2.34.1


