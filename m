Return-Path: <linux-kernel+bounces-867847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA53C039F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CF43AD07D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820B422DF9E;
	Thu, 23 Oct 2025 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UxxvxbVg"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023120.outbound.protection.outlook.com [40.107.201.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F946DF76
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761256348; cv=fail; b=EpoQLmwoKtYRIWd1S6958e+D+RP9SoGa5eNmCq2eo/Iw85li63ToqR9OsU2j3ZQhJjsRqE+FLItt3+lZ40MNK8JKxtTcr8lmJJ4ItGd/17UwKCWRIYFrZk2UBV4ZO62Qs4fxROfcs4Z0BDTyI8BMqjY2rXoZqK+UBbTZmzO+qJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761256348; c=relaxed/simple;
	bh=najOq0wWlMZtrH0VAEbHMALcZFDOgrqA8rBlEFRgmYE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sxJln5+RZ3syiBWggB8bOiCMSQfpDV+7rUJNJy0sSotcjjM02yML7Pd4ZdAmHv/ucMnLigDOJm/3G1N95mbH8zqbfTNvRtxUSe31+gFpUkV1lA8b1TEsOB2tkxGoRoX4Nf5P45l23g0axiMoN80UzF3fuaZ6JGOW9ZZqXBREmks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UxxvxbVg; arc=fail smtp.client-ip=40.107.201.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHYkx2HMm7k0aae70MRjyToORaKRZjgkBicKosldppFel6itDoCJX6ukt8lApG1wWSFs+bGliRvAW9jyJWiPGN4d7pp0b21Bnrs4/g3VrFfbIrncgpe/30xBRBIHPbyRbQTCo2GQ1ZvC/o9I2aH6hnx+PhsOJHrZ+ovXa6z6snNDPUunJqS2yK5BxCtXZ9BsH02LZ/kJT6Jns0liPF/kUrAnr/Uts6yWThuUjY13z8WHw5nJKRfDnWbKMGIMbeZlsAp4i66x5b/40sq2VZXS44CefW0OLs0Htl3w7Vv0FcTyyWRG5+uiMFZrIiikmmoaSlya4it9ghLzL6j2KM4q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+KNAnthWr8Lf+4iHm50bCobd9c8qnc11AC+zf7x/40=;
 b=IbPyWoux9kyUbU2Pf34Bwy51hzGnTVKXVLqoqVGXR1O4XLZC+xeLD3XKnB0pTi6bJI9H32q++U8l3eu0LXJ63NchkCGBY8ozGaseu8Lg4HdgIA2PFO02a8LoeADeFK6EvrvR01vKgokMpMHk9/ZMu9OPNJ5grN2aLvGdblsNGXF57BSVg5bBIWh+MqASuk0lTa6wOK1+owEiNg3LSy3BzuCftNmTUX6M9+CvNJH7D3ncyLcWjuUHKK4DbaOAoH2rOOcPLLBFCUVX22U+59LeKzxAd7db4WTI+nA0OBX6wvUlCYoXkW9D/Y+nazdlbMX3h0+Y55FUnR7yEB4NIGjeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+KNAnthWr8Lf+4iHm50bCobd9c8qnc11AC+zf7x/40=;
 b=UxxvxbVgZYu1C4Nx+Wc/LkWr983xBzyJQu/GeTgxR663wKrK5U53d9DfVu2yawfLVDW+XKELF7Z/1AIt+cXpQIZmDSwZzmV+HK82s5hoIq91AGEXiGbSX0CmltwEgVqCdnf3EwiZ524r7ZVypOP28+5O2rq9zLKhPKyxMPhjkZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB7230.prod.exchangelabs.com (2603:10b6:806:1e5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 23 Oct 2025 21:52:24 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 21:52:24 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	cl@gentwo.org,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH] arm64: mm: show direct mapping use in /proc/meminfo
Date: Thu, 23 Oct 2025 14:52:10 -0700
Message-ID: <20251023215210.501168-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0049.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:4::28) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: f14ec18c-fc59-43d2-44d4-08de127e72f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URt6rP+qEDfMlcFBlnNK1QJbzHh6jFmFaOb3ZaEjgXjwohLGR/yRUmDF6y7o?=
 =?us-ascii?Q?SMeuqNpJ/ARsiiAYR7Mklerz7nyJFc5xAgZJc9F9HnA2g+u1thgtjYy6S8l7?=
 =?us-ascii?Q?3Vvi0aFATBlNEjWnXc8zMoDlBQrupvD1S+pCMZ/2f9FX4TFaZLLgVajKI9rJ?=
 =?us-ascii?Q?T1hXYRfJ7/xc7uYYb35XmZO6NNXytppDJ+ONDgLopKcKoGgqIL11gkeHO3UI?=
 =?us-ascii?Q?16a8ldkvjFtL80Xv665ZuCRZBzpQ0pMZbnE0jUe6n/Vk0/5kHpkEBBWdkEp3?=
 =?us-ascii?Q?EaHJOWzJmdQ/Do7pEEA9i1drv7MsuS6PCVWX5rNymhs1bOlgAIN9HBqb/l8u?=
 =?us-ascii?Q?ZJOw2/yW1Y++S2WZS5KdeCw93elOO/o1kInUhA1V/iTT6vDlSAXg1e6eMf9G?=
 =?us-ascii?Q?pkkcUX9M+YZdqlK+IEE2h8Y+/T3lZH0s6WzBdyyvDlJ3pgAbB6e/6JTKusJ6?=
 =?us-ascii?Q?o425WhlmZaMnYtanBqekTFKwq5UMWmZs4XDFgUCwTRRCliWfqLXMPYjXcPuB?=
 =?us-ascii?Q?qKXl/8ELYEuSmZau32zemtlwi48a4rvXNFCgoSja6H592+Q3OC/6bVCtttf4?=
 =?us-ascii?Q?9oLs4rrY8K+VqvlO8N1b2eWpsxszgKcMNl5VX2pe1YVJG78RSXhQhqYmvBnc?=
 =?us-ascii?Q?do5Ptg56uBayMcQ/MzfV3QSYcUeLHpkiQGnAXHztQKammP6fm6YzQL0DbaJa?=
 =?us-ascii?Q?kteMmnGtThW9Rz6RmJQBCM3tHsUFSSwsm3PmHWC1dgXhl1fPMLaI+F6XBvqB?=
 =?us-ascii?Q?W9kgmuaBlz3k/rvFJAHMZBXutl5mU2sWSFuDitM1UVpOzxLRjvbghq3jD9Hv?=
 =?us-ascii?Q?gCmTvXnVoPjQdWdlaLX2H7wcWE1CLFAm/G/XOW4t/ptzP/kgQqWC5xnXll0F?=
 =?us-ascii?Q?MNtRHb1Jyh7emegwCZh+N5CGrH8IRkoN0zAzaKeksEFKN23Qs9n6WGkEaLa8?=
 =?us-ascii?Q?qfWhLfQ6pq1QXKj3gXyBx68N9F9FTTB7wqu11+0bnpHtBwf14996P0bCvsDV?=
 =?us-ascii?Q?dkCGxzkOhO/XHG4USgT6aF9STvniqdIisW44gQIB0lyiQO/DdG9sWRdvVjXJ?=
 =?us-ascii?Q?vwFQt3DFGLQZVH8do2xI6R2tsuccaS3VT7iP0gQGPIi9O7qpNF/r/vZgPIDh?=
 =?us-ascii?Q?fZpNByKVME0oxwvRrwFOtNG9Q9c8ebw/lnOPodgIiJSoGRGv08WKmw3k361q?=
 =?us-ascii?Q?V/C2aQtDZ4QKBoFtlQCoJz+o/0pHV6kUvcw3Br6nSGwCIKD+zT0+V2uD5TGT?=
 =?us-ascii?Q?EBWhyuci2OoIJmkREUdaORJrNtA2tCBZOWKzW/CZmyqLs8I/ehI7wOGVR4s+?=
 =?us-ascii?Q?8WT16ICsdBNCdSCuIZZd4Cp7flb3cUS9QeRSdMsVvm/F3ujaUyciwoKj7Lg2?=
 =?us-ascii?Q?ZZaOS3MKTcz4zw5Jl/O86ED1sYpiLUlfsghSWOJikQR9JcXGLMHtUAuk5+iJ?=
 =?us-ascii?Q?G0yYY2TVZ45pIAzG+391HEUT5RJY+WyPCdFZxk0YqSsmgSC2F9Dgo6pjlrdE?=
 =?us-ascii?Q?ZMVSAoJdQrhRhrWPz+VbQlYQGwrtPjf9AaiW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dbkhWIdXAPD9FcYfWo6R3r7yR+Fexpp30CXWqY7n4qCL50GmE/Shcxxej3NG?=
 =?us-ascii?Q?4rsktSC3uRK8sb5mYC+VmZ18ceUG+3yXprLLYfif7SeBFqL74cmpPavSg/dd?=
 =?us-ascii?Q?Le3x6BXOfIKZa1xeFi4Y8vYlyeyW6APb195gNsasjK+ci5l1XfIjpAukWSLF?=
 =?us-ascii?Q?PKYQ5zzY6V96ULR/Jo+2AxSWwxxilS68mJQSsIuIFEF/nOsxZWK+8Bsl5NUB?=
 =?us-ascii?Q?DwE1Mcb2AegQ29roQ8QJELpcoAYLJCBd88jLhCXWtumjteol62SJEBeg0bcH?=
 =?us-ascii?Q?5+sRAKYrzKeQAmOhXjfo1qqvLVguu+0uv+FWoXpO8kSN1/BI2vs1bSoJ2hqB?=
 =?us-ascii?Q?LerSF+XeTDQreygILhgT3QFEnf52pghsHaQ8RaItItylYHfj5fI2oNZR31CU?=
 =?us-ascii?Q?UOrejMRoqLDlfIXcYN4eUbbKQu7cKb04HfXi2PY1qq2Xm2Kge11HC6mXk9SM?=
 =?us-ascii?Q?g+Vo+qs3ac1kI4d6Ll870u+2RkRWGT8u3FXYMTERqNqUThNChDT3oJDh44gX?=
 =?us-ascii?Q?P6K+NyN0FW20DoEjHwl/iq+ZM4AvknMDitsBItl4JwXrnC6505kv9EKdf2n5?=
 =?us-ascii?Q?RgI7xuWN5AAEBvHWEJlBBH/8yxhtJ+NPOb94gmNXU04roYPwwn98wM50usBm?=
 =?us-ascii?Q?Qn8qyYZ2uVocqzKr1B0FpeE7D/WR5f3D6svKWxR8p/7Vpwpr+dVOXYIEdf6B?=
 =?us-ascii?Q?MUP8kROmwVXJkZBB5UQ7cmqwaZ6Nx17ipsFRYbbKcnwPrciygoDzhLjV80tY?=
 =?us-ascii?Q?60jAgLOyAKIBzumLRR6mZFpOJoPA/Tsg9hxGMDNrDSWoR8EPEEIIPLOHT/lE?=
 =?us-ascii?Q?GPzqT3+bj4T8wYVkP66pzKA0mXCrwcLAg+y1Mgj2zzkQRE80i3QsWLV/kW1I?=
 =?us-ascii?Q?Qp27b8y2Oa48Z/7QEnZf+T84MVk65eXzJ4p5L++4l38Ys331cu3OjkLx0tYy?=
 =?us-ascii?Q?t8YdnUuTU6Tohh1VCXDNet05WO0fsLyfKxKzt6CUAqGwHUSBRJGltSNKTBss?=
 =?us-ascii?Q?hdRhjF+QwTzakBTCpNxZ8GqSK0LJjp6SpuvHLBhjQG6Tvcv38OIhifrX/bzw?=
 =?us-ascii?Q?CGwyp9szqrOOvtUv6w78z5FQmMphraOwMjGkB0T52ZZv2gKL2IHhufUTbj4G?=
 =?us-ascii?Q?49DFv3yZZq/veY6xMVXBBcKItj4wDuFBWNBjw9Qyegga2I2GJhJZMHO9S70H?=
 =?us-ascii?Q?ihqTlL3wBziiI6fqkQG/Jlc7tHR/qsFRiAC/lkf1QfG8226kiXBeTCjkdTge?=
 =?us-ascii?Q?6nbNOJHm12Tj2G1XzdvDlFdWda/NQJTXWKwN+7HwWeB+8WDyiSTmPFVmnkWR?=
 =?us-ascii?Q?WBnBHzPHpZR4uHgxXxGIdi/zjqW1fgrgn3zCaxgAQ2up+DP9poVvLYTnX/ZQ?=
 =?us-ascii?Q?a7ASELo2SvEHTAgjk6CnsfBfjOza27RCM7+ng1WsjIqVO0Ozj6U8F+OLVoLC?=
 =?us-ascii?Q?oF4ss7xdnoiQVraZNw+ElQOy5IS/7w1Z6WfJ4b4keSotVl8XyHJAK/t6RB6f?=
 =?us-ascii?Q?e8nP/61g8EZaVEzQSFyo2HC/rxtxUhyggo7KWQIVe0gMqwEEeu4mpKDBNftd?=
 =?us-ascii?Q?zxPfB8g8sRQ3FaDf3p//L6HJN3QTAkje9fRflB1+gg6PeFvECpkwTsesvMtQ?=
 =?us-ascii?Q?ES6SMb+hH+1H24p3nbj307c=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14ec18c-fc59-43d2-44d4-08de127e72f2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 21:52:23.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22GssGnHvSrQ+EJiFRYJ+8MCsP9/qYwtd0STs1VYI5MoQRCiJ3Ua22UYz4TxsM4h5fiihf0/nmAQyGjRwhM8FzMZu8a3rsQ8uYn2U03OKD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7230

Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
rodata=full"), the direct mapping may be split on some machines instead
keeping static since boot. It makes more sense to show the direct mapping
use in /proc/meminfo than before.
This patch will make /proc/meminfo show the direct mapping use like the
below (4K base page size):
DirectMap4K:	   94792 kB
DirectMap64K:	  134208 kB
DirectMap2M:	 1173504 kB
DirectMap32M:	 5636096 kB
DirectMap1G:	529530880 kB

Although just the machines which support BBML2_NOABORT can split the
direct mapping, show it on all machines regardless of BBML2_NOABORT so
that the users have consistent view in order to avoid confusion.

Although ptdump also can tell the direct map use, but it needs to dump
the whole kernel page table. It is costly and overkilling. It is also
in debugfs which may not be enabled by all distros. So showing direct
map use in /proc/meminfo seems more convenient and has less overhead.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/mm/mmu.c | 86 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

v2: * Counted in size instead of the number of entries per Ryan
    * Removed shift array per Ryan
    * Use lower case "k" per Ryan
    * Fixed a couple of build warnings reported by kernel test robot
    * Fixed a couple of poential miscounts 

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b8d37eb037fc..7207b55d0046 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -29,6 +29,7 @@
 #include <linux/mm_inline.h>
 #include <linux/pagewalk.h>
 #include <linux/stop_machine.h>
+#include <linux/proc_fs.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -51,6 +52,17 @@
 
 DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
 
+enum direct_map_type {
+	PTE,
+	CONT_PTE,
+	PMD,
+	CONT_PMD,
+	PUD,
+	NR_DIRECT_MAP_TYPE,
+};
+
+static unsigned long direct_map_size[NR_DIRECT_MAP_TYPE];
+
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
@@ -171,6 +183,45 @@ static void init_clear_pgtable(void *table)
 	dsb(ishst);
 }
 
+#ifdef CONFIG_PROC_FS
+void arch_report_meminfo(struct seq_file *m)
+{
+	char *size[NR_DIRECT_MAP_TYPE];
+
+#if defined(CONFIG_ARM64_4K_PAGES)
+	size[PTE] = "4k";
+	size[CONT_PTE] = "64k";
+	size[PMD] = "2M";
+	size[CONT_PMD] = "32M";
+	size[PUD] = "1G";
+#elif defined(CONFIG_ARM64_16K_PAGES)
+	size[PTE] = "16k";
+	size[CONT_PTE] = "2M";
+	size[PMD] = "32M";
+	size[CONT_PMD] = "1G";
+#elif defined(CONFIG_ARM64_64K_PAGES)
+	size[PTE] = "64k";
+	size[CONT_PTE] = "2M";
+	size[PMD] = "512M";
+	size[CONT_PMD] = "16G";
+#endif
+
+	seq_printf(m, "DirectMap%s:	%8lu kB\n",
+			size[PTE], direct_map_size[PTE] >> 10);
+	seq_printf(m, "DirectMap%s:	%8lu kB\n",
+			size[CONT_PTE],
+			direct_map_size[CONT_PTE] >> 10);
+	seq_printf(m, "DirectMap%s:	%8lu kB\n",
+			size[PMD], direct_map_size[PMD] >> 10);
+	seq_printf(m, "DirectMap%s:	%8lu kB\n",
+			size[CONT_PMD],
+			direct_map_size[CONT_PMD] >> 10);
+	if (pud_sect_supported())
+		seq_printf(m, "DirectMap%s:	%8lu kB\n",
+			size[PUD], direct_map_size[PUD] >> 10);
+}
+#endif
+
 static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot)
 {
@@ -234,6 +285,11 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		init_pte(ptep, addr, next, phys, __prot);
 
+		if (pgprot_val(__prot) & PTE_CONT)
+			direct_map_size[CONT_PTE] += next - addr;
+		else
+			direct_map_size[PTE] += next - addr;
+
 		ptep += pte_index(next) - pte_index(addr);
 		phys += next - addr;
 	} while (addr = next, addr != end);
@@ -262,6 +318,17 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
 			pmd_set_huge(pmdp, phys, prot);
 
+			/*
+			 * It is possible to have mappings allow cont mapping
+			 * but disallow block mapping. For example,
+			 * map_entry_trampoline().
+			 * So we have to increase CONT_PMD and PMD size here
+			 * to avoid double counting.
+			 */
+			if (pgprot_val(prot) & PTE_CONT)
+				direct_map_size[CONT_PMD] += next - addr;
+			else
+				direct_map_size[PMD] += next - addr;
 			/*
 			 * After the PMD entry has been populated once, we
 			 * only allow updates to the permission attributes.
@@ -368,6 +435,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
 			pud_set_huge(pudp, phys, prot);
 
+			direct_map_size[PUD] += next - addr;
 			/*
 			 * After the PUD entry has been populated once, we
 			 * only allow updates to the permission attributes.
@@ -532,9 +600,13 @@ static void split_contpte(pte_t *ptep)
 {
 	int i;
 
+	direct_map_size[CONT_PTE] -= CONT_PTE_SIZE;
+
 	ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
 	for (i = 0; i < CONT_PTES; i++, ptep++)
 		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
+
+	direct_map_size[PTE] += CONT_PTE_SIZE;
 }
 
 static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
@@ -559,8 +631,13 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
 	if (to_cont)
 		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
+	direct_map_size[PMD] -= PMD_SIZE;
 	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
 		__set_pte(ptep, pfn_pte(pfn, prot));
+	if (to_cont)
+		direct_map_size[CONT_PTE] += PMD_SIZE;
+	else
+		direct_map_size[PTE] += PMD_SIZE;
 
 	/*
 	 * Ensure the pte entries are visible to the table walker by the time
@@ -576,9 +653,13 @@ static void split_contpmd(pmd_t *pmdp)
 {
 	int i;
 
+	direct_map_size[CONT_PMD] -= CONT_PMD_SIZE;
+
 	pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
 	for (i = 0; i < CONT_PMDS; i++, pmdp++)
 		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
+
+	direct_map_size[PMD] += CONT_PMD_SIZE;
 }
 
 static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
@@ -604,8 +685,13 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
 	if (to_cont)
 		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
+	direct_map_size[PUD] -= PUD_SIZE;
 	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
 		set_pmd(pmdp, pfn_pmd(pfn, prot));
+	if (to_cont)
+		direct_map_size[CONT_PMD] += PUD_SIZE;
+	else
+		direct_map_size[PMD] += PUD_SIZE;
 
 	/*
 	 * Ensure the pmd entries are visible to the table walker by the time
-- 
2.47.0


