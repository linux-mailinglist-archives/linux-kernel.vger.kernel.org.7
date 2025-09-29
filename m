Return-Path: <linux-kernel+bounces-835802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFCBBA8170
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8E83A9FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500A224E4A8;
	Mon, 29 Sep 2025 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iTPlk/oL"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23524DCF7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759126706; cv=fail; b=M90y+L/h4dOwwmHzff704+ivRxG27GWtDTPLTNo7Ux0FhVSHerFAEfSg0ENoFrafc/gU1WmlKHQ0MdvdaEftomkXCzj1ZyOiydAATnhA3jVaAc1/KFj6yp3/hEzhR35rO4KPCxDdvcbDPHQBDLdmJRKRb1vXHED6bpk3Mkr/apk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759126706; c=relaxed/simple;
	bh=pwfSz8Bf81W9FOHZj3X9S/dhv/1MzCwA2lUVhLVD2dg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YfCnoXpmFz9lF75sDiqC6L4mujMS36Bj+PJMuu4hp1fYl+yPOXSbm8sKZDGhLSXwo/FXgDIZw2HVdQC7m8fBdvYkbq0q1uVZM3UFa5A+MdWDWWY8bYxNTzuKQL/Q26hMHrxne2WT1huhg5IWIkHykfZoXflQwAfEU9MLn3IwDf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iTPlk/oL; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+kQKhZK13fgz+zG3esWUChTi9FvHbNDuKzYwEZrHqDQEeB73BWbe7D5CGRdfIv1yOpEKUyeJodMqvt4y9eLZhlB2FPOOMyZ8ab/MkInfOCXH02gbKodfWrgbb3U2l0uRp06JPjn/Ly6YzsKEKPuOhaU5nX8eT6DZfO/5ILO3In1iNWuv24PXgs9FQi9k6227n8Ej3+t9F0yY76vTW7nURsetxiiEFvStELZTNX8WobyGmK+Boog+i2Jgq8B04+zGvLW/hFpIjG9TlsWBYH/3p8apQEhBGPndY+S4ShQOi0dCE7BD9KLKQ+xvyHwFf98/haxJK8FvDG+89kIjFLhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGVOUYvJYj5L6pUs44PmeEiNyRhGq68+oJCvH7b82Go=;
 b=eObGVT564aT/VG7QdC95JEETSwfOTzvRW3HReESuk/l+07Q2/zLoOQ0UQEq/pUslGUPdrMMWsshJKS0TV9WJsCrpjIU2/nsRTbSvdxE6GgkebyaCcBw4latE/L4xLFo7BwxYxCyD10bPBLyp5mY9vvyiXS2TpGs1q1QQk6kY1ylQipLSDDMMnCTj6MWUZu3SIECL2wl2v0MVCIwsJKh+Aac9LRx83flW+NB7Ju66yjTdReoONJ8Zjbdm9TN8V566nd08UCpnja/YAkUSEUxHEAgiiWVPrGvxWbxw8YpKm9m0TL4x7ZH34QGI6C6mChojSmDvq7wNIseqoGWj4Td74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGVOUYvJYj5L6pUs44PmeEiNyRhGq68+oJCvH7b82Go=;
 b=iTPlk/oLr/eGW4RktwzV/vwgiy1RzTGi8i43SmorCvLYXHxAm/NwStrWMhsUnZ1niIfJh5p9hlOB7KqLhqq5ARQK5gFSbFpdJaQiHyC9Q1s3YmkINFt+ZO/72GdllK4IDaOYSLquZkgXkht3sC5LqdN6o9Vt5LG7WVx9cNV5ymE=
Received: from SJ0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:2c0::29)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Mon, 29 Sep
 2025 06:18:21 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::6) by SJ0PR13CA0024.outlook.office365.com
 (2603:10b6:a03:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.12 via Frontend Transport; Mon,
 29 Sep 2025 06:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 06:18:21 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 28 Sep
 2025 23:18:17 -0700
From: Shivank Garg <shivankg@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <acme@redhat.com>, <namhyung@kernel.org>, <leo.yan@arm.com>,
	<yangyicong@hisilicon.com>, <bp@alien8.de>, <mingo@kernel.org>,
	<xin@zytor.com>, <yosry.ahmed@linux.dev>, <shivankg@amd.com>
Subject: [PATCH] tools headers: Sync x86 cpufeatures and arm64 cputype headers
Date: Mon, 29 Sep 2025 06:16:45 +0000
Message-ID: <20250929061644.19188-2-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: 738df136-4b21-433a-aff0-08ddff1ffd13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akhSLzJQTFJ2dEdReHhQOWp1TUxYa1Job1RPMzRUQkgxZkg1SE5TT3RjVHRy?=
 =?utf-8?B?Nnd3QTJKNzlBblNQeHdYUVlPSkJGOVoxZkRtVWI0OVBXUUVHVDRuRHVzb0FU?=
 =?utf-8?B?YzR0RlFLVW1mMTJFelZDYmpHN3hnS0h6c3U4aHhzempqOFhOZTI5Q0I1Wmdx?=
 =?utf-8?B?ZnYwTEYxL1JCUjhqTjYzemo0RVJQZEY0TGZCSWlXdWVqNWcrOUF2STBvMGY3?=
 =?utf-8?B?V3R1a1c4SkhEc0Q0MkxxamxoMDdvOXdjbFFOL1JxeTRtUm82aDEySktRTjd2?=
 =?utf-8?B?UTZQSWZJRkM1eXBQS2w2VU1JV090aHN4UWdGbkQ5VGkydHc2TGVOa0QvelVR?=
 =?utf-8?B?UStuNlcvTGhReDJEclRkZ0ZsRktkckxRaTR6SlBVVnJoaVVmbGIwNGV6VFlC?=
 =?utf-8?B?QURISHJkd054SE45ZnZyQnVrL2VoSVI5QVVSOWdnOVVQaEM2L0xSczlaU3ho?=
 =?utf-8?B?MncvY1RqUlRyZVlVVmswa2NVN0V4N2tHUFYzT21wNHNzUm9BTStLRkUvRUN0?=
 =?utf-8?B?UXM5cmxiR1dVV3REVStpSG5YQVZZUlpDcU5vWnJ5K1N0dlZnKzRSQm5wYzJN?=
 =?utf-8?B?ZnVvQThFV0NJL211SHRrcWQvanRGbmZWMVpmZHZtdFVXRWc4TFlGUFZnaHNR?=
 =?utf-8?B?T2IvWm1PcW8xVjZIdm5aMTVRektpcXZIR2RlWWw0YW1paGgyVjJNQjJSNjdU?=
 =?utf-8?B?Z3Rod0Q0SnZwN0RkUG0xakZSUWRKbUhmQnE4RE9Md1dtL0E1WFlkMGlXT2ty?=
 =?utf-8?B?S2U4RFpQRXZFWGxyR1RIc1cvQzRiUFdDVG9nNHJQejhjZTU1QUllNmIvYzhm?=
 =?utf-8?B?cTgrZzNvd0NNUFhoQVhHUWE3b3JTbzFlL25KUEtFeVJZMktzUWtyZWk5dEs3?=
 =?utf-8?B?cGlKdnllczlvY0t6THJvQnBpZTBRUkk1K0hmMWs5UDJXQ1Zham9kZUVDdHp0?=
 =?utf-8?B?cjNoVXJaWUR6cU1nYW1zT1ZwZ1Q3cERLbDNpblhLblVXdm84Um14eE8zb2tD?=
 =?utf-8?B?ZkJ2cEFrQ0dQQmo3bU9zZXVEOHRPdlVVWVp1REtjU2hTR05YZVAwaTc5YnFu?=
 =?utf-8?B?TXFDRTZ6anVkTGF1L0xmYjVxcHllQjRUMHJFbFZTZVlFdGdjeHI1TS96OEtZ?=
 =?utf-8?B?aHViWlFzbFRLazFGTU1XbGRnZERzQjJJbWJMTkJGeEtCK01FVXRYZVliM3ZR?=
 =?utf-8?B?bW9EWmlKcHNGVWZESVBZOVJVV0ZidGxlV3QyVVRDOXVadTYyTmlEWXQybHlk?=
 =?utf-8?B?bVhzbzhoOXVTL09QM1JJMHl3aDFadmpzbnJsQm1UbmpoemViWDhIZG91TlV4?=
 =?utf-8?B?a1hsd1VmNyt5aGZRMytrMWhkU0NTS015QXcyUDgzZEJtRWdNbmk3QmRQVm96?=
 =?utf-8?B?dXB2RkUzOEMyOE5PWXFoOXJYL21PWmhma25GaDQrSVRqOWhPMDN5QUUwR3hE?=
 =?utf-8?B?elZlS1FXSjFxNm55MlNia0tYZFlRelRxSmxIcXlFR1VBdWdGSDBVamhWYlpN?=
 =?utf-8?B?NllOcTdNb0Y3QmJtRmx1LytVWHZicDk4N0s3OGRSWk9yZitBaTk2dnltK1Qz?=
 =?utf-8?B?a2lHMTVJaDM3TnBsZ1hhMDUxeCs0MkQxSmZxMWJBajR4S0FvUCtFc1g1QXZF?=
 =?utf-8?B?b1ZoemxZZzZGczFDTzdOeFpSOXF5YWZWckk5S08waEdKVEZFRi93NUg3SkJ0?=
 =?utf-8?B?emR6TVNHVXFlTTRXVGYyWGpVZGEvaCttb3dpNHZoMWdxTlRiSVJsWWFjRlpS?=
 =?utf-8?B?cGdrdnRka3REcGs5WDU3K1Rxb3Z1eUUxMHFrM1FabE1VWjJoR01WdmUwaW9R?=
 =?utf-8?B?Um1VYXlSSnNDb3l0WnF4Nk85U1FlLzRGZVJNcENIZFJqL0cwV1pUR0xpVU1D?=
 =?utf-8?B?RW5QM1BXK3lPN1Fmdy9NWk8vaG5MTkdidXdsMCtlaWR0bkZoNmg2OG5PbEVK?=
 =?utf-8?B?U0lKVHR3NGJhVDBibktDWmJiMTB3MmpQZ0c1MkhXTUNzVy8xQnFkakRRcndW?=
 =?utf-8?B?YnE2WTJpc1dab0JRNTdHMXZQbzdxazcrSnQwT1VDbjZ2bWUyaUcyQ2xtdHRu?=
 =?utf-8?B?UzducmQ4eVliRzJhbnJrVzIveHc1UDBUUFlBR1IzOC8xWVoyWm5jTDNVeWt3?=
 =?utf-8?Q?Dzws=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 06:18:21.0130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 738df136-4b21-433a-aff0-08ddff1ffd13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34

To pick up the changes in this cset:

commit 2f8f173413f1 ("x86/vmscape: Add conditional IBPB mitigation")
commit a508cec6e521 ("x86/vmscape: Enumerate VMSCAPE bug")
commit c8c2647e69be ("arm64: Make  _midr_in_range_list() an exported function")
commit e3121298c7fc ("arm64: Modify _midr_range() functions to read MIDR/REVIDR internally")

This addresses these perf build warnings:
tools/perf$ ./check-headers.sh
Warning: Kernel ABI header differences:
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Please see tools/include/uapi/README for further details.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/arch/arm64/include/asm/cputype.h   | 36 ++++++++----------------
 tools/arch/x86/include/asm/cpufeatures.h |  2 ++
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 139d5e87dc95..661735616787 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -251,6 +251,16 @@
 
 #define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
 
+/*
+ * The CPU ID never changes at run time, so we might as well tell the
+ * compiler that it's constant.  Use this function to read the CPU ID
+ * rather than directly reading processor_id or read_cpuid() directly.
+ */
+static inline u32 __attribute_const__ read_cpuid_id(void)
+{
+	return read_cpuid(MIDR_EL1);
+}
+
 /*
  * Represent a range of MIDR values for a given CPU model and a
  * range of variant/revision values.
@@ -286,31 +296,6 @@ static inline bool midr_is_cpu_model_range(u32 midr, u32 model, u32 rv_min,
 	return _model == model && rv >= rv_min && rv <= rv_max;
 }
 
-static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
-{
-	return midr_is_cpu_model_range(midr, range->model,
-				       range->rv_min, range->rv_max);
-}
-
-static inline bool
-is_midr_in_range_list(u32 midr, struct midr_range const *ranges)
-{
-	while (ranges->model)
-		if (is_midr_in_range(midr, ranges++))
-			return true;
-	return false;
-}
-
-/*
- * The CPU ID never changes at run time, so we might as well tell the
- * compiler that it's constant.  Use this function to read the CPU ID
- * rather than directly reading processor_id or read_cpuid() directly.
- */
-static inline u32 __attribute_const__ read_cpuid_id(void)
-{
-	return read_cpuid(MIDR_EL1);
-}
-
 struct target_impl_cpu {
 	u64 midr;
 	u64 revidr;
@@ -318,6 +303,7 @@ struct target_impl_cpu {
 };
 
 bool cpu_errata_set_target_impl(u64 num, void *impl_cpus);
+bool is_midr_in_range_list(struct midr_range const *ranges);
 
 static inline u64 __attribute_const__ read_cpuid_mpidr(void)
 {
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 06fc0479a23f..751ca35386b0 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -495,6 +495,7 @@
 #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
 #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
+#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
 
 /*
  * BUG word(s)
@@ -551,4 +552,5 @@
 #define X86_BUG_ITS			X86_BUG( 1*32+ 7) /* "its" CPU is affected by Indirect Target Selection */
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG( 1*32+ 8) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
 #define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
+#define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affected by VMSCAPE attacks from guests */
 #endif /* _ASM_X86_CPUFEATURES_H */
-- 
2.43.0


