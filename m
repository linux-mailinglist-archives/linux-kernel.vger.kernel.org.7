Return-Path: <linux-kernel+bounces-768944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C131B26837
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF92A2038B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F402FF141;
	Thu, 14 Aug 2025 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="axxxzRP0"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92F1E9B2A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179473; cv=fail; b=O4QDt7dwzZsO8OUCXFYV+zmnrQsg98/uFJm5TOkcTb6AKt8ZFUtE/tzkDd6mVrJuygzZfn80lfKCc2GndlxAHKyG5DoWzz13LBQYtofqKBlpvfWjeNmHr+DEMWiXN0V8/y7xTSLVzQT4ajkEmPUjIUEL8sbJGIKAzVhkJeTl7io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179473; c=relaxed/simple;
	bh=tz/Mrn/Feh0Fa5jxTnssaiqWy1CWRwxr/OaLxo34wDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHGsusKN6iX9rTS56VoI7rbG9wS7QKwgM9yBeYzPymZqj0ps0Zl/VYOJuDyLAElP74VTWb0lpnk0LkEue3CnS6mZf2eU+LFvzvjLcnv0IXEL3hRJ28nj7QtBX1Zd45q23CJQV0zFvNcEeR2KEXhxLSLKIn4OzXr60I97b0AnefQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=axxxzRP0; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RftCnU5AJF0bKELIElRKCW2bilmxpXhiZ7t1PDhzg/MGJz1EWkAba07Ug+IybL1/8NBwe4Sin2RyZAH9HWJmc4gc09EHCTCofHavM1Q01qXkhCx3tZrygjzchoX0htdW67r8zi1Oku3zxJFKNninV8LSOKaFiv0UNWBjh5KnLpSaGkm3qGXIUSeT2BzkazmCrFz7wTDdz1VDh2HhDZIj05WgwyXHNuh4eDp0Rn7F5zz00TLyt/sow42avRbRkP13X8kJnG2/uJYnAtk3YpWr5vRCsLxAuy33uiIBc3wq+oAUc+0jVkXJb/q/KdRkz3aUKpTP5VFy3NdsxcvRM2m2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXCLP7LS/KfXDafwpQvsPCw+JGNumX2OyTonQaCXLh8=;
 b=wifp1+YiECAg8i2WkdSdi1Rp2OLFHOIJiX93m5SnFVU4/oMuaxFJWWcMtHNbOE0qT+/SMJdGp63j86JXlFPzJKhYmBR3wqSOvmLRBLSw+loY5taxbw7SK+FnC/uuMqRo9I5WCMhuhF3orSpEPdQqG9QpkX+H0erxJKstyAmfUj3O9kYg3rp0CRvcdcNu9lHChUQfBQr/pWSU2nEyIGtuYbioNlgmiB8eDvPsuXGaakTGJSFKxD4FpbAuMe4u6RqkWktR4kYP/pjrhBsE7g9ek3repXLJuDhQW6eTXOLnhU+rTJu6tKEsaB36kaqB3pCAddbBX8gTQCWRHugncM+qZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXCLP7LS/KfXDafwpQvsPCw+JGNumX2OyTonQaCXLh8=;
 b=axxxzRP0ceu6wY0QTVLRg3FiE6rxTW7eDfGzEx/ajWbFmTd4b4twKifXbFg0jV81rludK5FlAXJtY4ZMEpdUuYVcDYFH585sVqgMaY/Xo82uv5OXOfYBdfbOqcbRSs+Te0saP+E9I6a09w7oNY8CmMzuziRt9aJDuPZy8G2NctQ=
Received: from DS7P220CA0070.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::33) by
 CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 13:51:09 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::dd) by DS7P220CA0070.outlook.office365.com
 (2603:10b6:8:224::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 13:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 13:51:09 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 08:50:59 -0500
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
	Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v1 5/7] x86: ibs: Enable IBS profiling for memory accesses
Date: Thu, 14 Aug 2025 19:18:24 +0530
Message-ID: <20250814134826.154003-6-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814134826.154003-1-bharata@amd.com>
References: <20250814134826.154003-1-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a12639f-65e5-4aa8-03b6-08dddb399f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QMt5ImjQG6NIgul4tzJALc98C76PL+a7Xz+ICq74vKRxTPL55FP482eeY0Xb?=
 =?us-ascii?Q?JpLVX+oChGxHGcPkg3uILqWi1eicJ6P4N28X1bgyzdSohvAmmcQXGrBWw839?=
 =?us-ascii?Q?atjFWJAZsQuac7Dslg7+h+jv+Gv665y5TVsX86wKeEdRBzT+heqC+3J3sEnL?=
 =?us-ascii?Q?ZKVMrAUz6cJZ32nMX918t8PH/j7fvKlv4tB/vk+5oI6LHt10HCBzvt35FjJw?=
 =?us-ascii?Q?NnBQlg2EHj29zCEXtviR8M1H83Cq2glzBOzOmjYXgvLERS6OLPGVIFhYxQFT?=
 =?us-ascii?Q?IsNdCyyYLY/+Kkt/OOceTD29d53uMlyqA7+TcfD7/B9jlwSDQ4hq81YJlq+5?=
 =?us-ascii?Q?iTbqD9X5asPtms9tUk2dyx0gGheM0XlNHfyS+UiemE4uq+JjE+cjrKHYf9co?=
 =?us-ascii?Q?mwetWaL74209eGajM9lOelxzUl/3F1l6PVPAsDVpMgDqaBR03jlaTPce4Wu9?=
 =?us-ascii?Q?5Y237oy7Eny+83WuRDJJveQC/BH9z8vaojr7eP72RWkDK2GSZbOOmsJ/zdXL?=
 =?us-ascii?Q?pQ0mCUoK3pquDUzjovuHHL4J3gz/okpRhWiJQEByvUzeaa/On6/RE5pL4HkQ?=
 =?us-ascii?Q?SD23Ng+HFkxIdR0A2yWN2ymCAyRAJJ3QANlWwXVoVL9lNeYF6pTlDFZaMjlq?=
 =?us-ascii?Q?NEYkCtJyWXGcQFA2K37Rn9gmMgwZD8e9vAgFr3/UEa2pBCwibPFgG62Fabwf?=
 =?us-ascii?Q?q1e+Z7jGX2O/aeZwQ2ABJJofALRCMH9DT6yyjoXEAXdAIzlF3Tgk4N0KTYOd?=
 =?us-ascii?Q?fLOHbanzym8xNAxuykH3ZSdnkgno16UkrqFeJ9UpCspDHBgjcKAnq4+BpPU1?=
 =?us-ascii?Q?3t6tCNFR0pSvoLxKiT4g1FEyoC9wKqunG1sYVf9uXfMouhFHNKdSZR0dvK0Z?=
 =?us-ascii?Q?RVtrXPiScj4dwlHoDYyav/Rwk5OZ+N5qVJFmM8UTTZxz12Xg7i1oPU0bnMie?=
 =?us-ascii?Q?XoZN97T5HYPzLoYauKzqkVA/GAl3cOUxyhntk1TeyO2ijPOI+tlDR0v7/ikm?=
 =?us-ascii?Q?h2a9XZ+3M0JKYIWzqEPLvBeoaOjAgyxPKWQXMDCKZHuUzy+H7UU4vsqgrIh0?=
 =?us-ascii?Q?bxrjWqsq8CIJaLHx+04GUn/DXtMg1BFO+Ki97EnBUnvcElSjMxqiI17/fPzb?=
 =?us-ascii?Q?PKNJLKl8RBcHviIzPFLuzSefQTLrdVGc8NbdaWnQSVSMMuwGEavZdarE2EfP?=
 =?us-ascii?Q?UCKv5v1JqYkN1wa0B5uUHSRd1HlwgePRX8p4M5gAtfucWrvvSqJqmAgLghf4?=
 =?us-ascii?Q?ddEbCC4aj1O/hKEeaoKf4EtmL/lH3KNRTnqANvrKCa4T9PvuqS6Zcmukn0Il?=
 =?us-ascii?Q?pCg7Et1UQgdMVFUYuUKJuSsjPA6E0+qhJ+eVU6EP1bUKDpG4S7pSVSKwE2tW?=
 =?us-ascii?Q?cvCiGGErh6+bwgCY+Whbv0KXAXYLvUjX2nmaLw8t0OrFNWgZGeEb7E4fpwlL?=
 =?us-ascii?Q?63cdovPNlypcLcrVes8xT0t8FQEgRWJfnyXUNnbaRIvAQpHJNJQB5AgNQZ+d?=
 =?us-ascii?Q?pNy5O3JDPdm0GcXcRiKSohTcLwoBKk9Fe3sH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:51:09.1784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a12639f-65e5-4aa8-03b6-08dddb399f88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725

Enable IBS memory access data collection for user memory
accesses by programming the required MSRs. The profiling
is turned ON only for user mode execution and turned OFF
for kernel mode execution. Profiling is explicitly disabled
for NMI handler too.

TODOs:

- IBS sampling rate is kept fixed for now.
- Arch/vendor separation/isolation of the code needs relook.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/include/asm/entry-common.h |  3 +++
 arch/x86/include/asm/hardirq.h      |  2 ++
 arch/x86/include/asm/ibs.h          |  2 ++
 arch/x86/mm/ibs.c                   | 32 +++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index d535a97c7284..7144b57d209b 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -9,10 +9,12 @@
 #include <asm/io_bitmap.h>
 #include <asm/fpu/api.h>
 #include <asm/fred.h>
+#include <asm/ibs.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
 static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 {
+	hw_access_profiling_stop();
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
 		/*
 		 * Make sure that the entry code gave us a sensible EFLAGS
@@ -99,6 +101,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 static __always_inline void arch_exit_to_user_mode(void)
 {
 	amd_clear_divider();
+	hw_access_profiling_start();
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index f00c09ffe6a9..0752cb6ebd7a 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -91,4 +91,6 @@ static __always_inline bool kvm_get_cpu_l1tf_flush_l1d(void)
 static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
 #endif /* IS_ENABLED(CONFIG_KVM_INTEL) */
 
+#define arch_nmi_enter()	hw_access_profiling_stop()
+#define arch_nmi_exit()		hw_access_profiling_start()
 #endif /* _ASM_X86_HARDIRQ_H */
diff --git a/arch/x86/include/asm/ibs.h b/arch/x86/include/asm/ibs.h
index b5a4f2ca6330..6b480958534e 100644
--- a/arch/x86/include/asm/ibs.h
+++ b/arch/x86/include/asm/ibs.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_IBS_H
 #define _ASM_X86_IBS_H
 
+void hw_access_profiling_start(void);
+void hw_access_profiling_stop(void);
 extern bool arch_hw_access_profiling;
 
 #endif /* _ASM_X86_IBS_H */
diff --git a/arch/x86/mm/ibs.c b/arch/x86/mm/ibs.c
index 6669710dd35b..3128e8fa5f39 100644
--- a/arch/x86/mm/ibs.c
+++ b/arch/x86/mm/ibs.c
@@ -16,6 +16,7 @@ static u64 ibs_config __read_mostly;
 static u32 ibs_caps;
 
 #define IBS_NR_SAMPLES	150
+#define IBS_SAMPLE_PERIOD      10000
 
 /*
  * Basic access info captured for each memory access.
@@ -98,6 +99,36 @@ static void ibs_irq_handler(struct irq_work *i)
 	schedule_work_on(smp_processor_id(), &ibs_work);
 }
 
+void hw_access_profiling_stop(void)
+{
+	u64 ops_ctl;
+
+	if (!arch_hw_access_profiling)
+		return;
+
+	rdmsrl(MSR_AMD64_IBSOPCTL, ops_ctl);
+	wrmsrl(MSR_AMD64_IBSOPCTL, ops_ctl & ~IBS_OP_ENABLE);
+}
+
+void hw_access_profiling_start(void)
+{
+	u64 config = 0;
+	unsigned int period = IBS_SAMPLE_PERIOD;
+
+	if (!arch_hw_access_profiling)
+		return;
+
+	/* Disable IBS for kernel thread */
+	if (!current->mm)
+		goto out;
+
+	config = (period >> 4)  & IBS_OP_MAX_CNT;
+	config |= (period & IBS_OP_MAX_CNT_EXT_MASK);
+	config |= ibs_config;
+out:
+	wrmsrl(MSR_AMD64_IBSOPCTL, config);
+}
+
 /*
  * IBS NMI handler: Process the memory access info reported by IBS.
  *
@@ -304,6 +335,7 @@ static int __init ibs_access_profiling_init(void)
 			  x86_amd_ibs_access_profile_startup,
 			  x86_amd_ibs_access_profile_teardown);
 
+	arch_hw_access_profiling = true;
 	pr_info("IBS setup for memory access profiling\n");
 	return 0;
 }
-- 
2.34.1


