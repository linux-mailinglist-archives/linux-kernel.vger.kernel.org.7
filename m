Return-Path: <linux-kernel+bounces-817384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C1EB5818B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8830A7ABE64
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6DB23C513;
	Mon, 15 Sep 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FF9yKCOn"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B921D5CC7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952271; cv=fail; b=s/YR0ZUOkf5QE2jxb+eyWt7j+nmCVouT0vjHPKFkZ45VxWev8sH8UI2Ryh8JFD8qSXWj3hISTA9MGb+iy01IKQ1Xxu02e/vPXw8gcgmC5cgruuaPT6z8/8NOYeqzBDfxOAzihUfbU2vNEK98A9/S9r7UNuuX/+m0rwqm2HZRtNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952271; c=relaxed/simple;
	bh=03dNdB/ErkL6AsSQANsjXW83EK3KoLFb436NYrJljew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s4ZeQWsDAZ4RQA98+fJF20YImDOg76du7qLvrWfcOUH/FvqBoc6Ub1RIEuQB1rbmQ5V59Nf2vQsHW9DHzqqfeHUqPpQ7r9MHT1djw9NKwQyUtpTkLtGAS3qP0cJ8AGJ+4uEiPcoR/0u8Jq5gmEKdBARQIfoL4BVwXQGiZ5LGHL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FF9yKCOn; arc=fail smtp.client-ip=52.101.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2z7+THAtqkDqBlcDFcn5JSWTN8nWs/m9In2LMfFDXzanD5bJIbC1yrOgYRj0i9bP6NBtE9boSyGAQaDMK1/TkeTxj5Xmuo+7XsLYwSzkF+D21eI817eBIdb/7+2XQxFDSp9x6lN9BShza8XJyn3N7ga3jzkM+YyTkJ4B1MNUs5z2kIUidVp93V0CeTwjAmxJg/7+ldn370eDEjaJE+k0WNASbkN7gFIj+5HR+zv/U0nvbeO07Phfykl1+KQEh8QBVUZk4/r9cfTPwdkpLnlILK3mK2J+ykq2Fpl3VcH2tx56Yld4wKA1VHnG+fCnjnAHAm3we5/9NsEqtK4iiJZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AigdjPRutaAbcqoFkSaTsRbO2VbKB1FjGsAvwuH+liI=;
 b=lvxS96q4qt3m37S8nT4XjcbA06ik4gqWR700DSwokihuHS1cjfFzRS3r4oCDTnoppuxQiXrpYOHqF6u9LJh+bpdCSuJlOx85o7UeXOVMPEcz35gA2T7OzUrz9wAZLGKflvkCZRMt6TS+WnmeRoyc+krIanPXtI/a70zuI/L8zl1+KsxKiZ6y+tiZuNTG3vmwhGHI0i2RxzyXB8LBwD0fCJlTevTSU4Sslhktf8QAcGBQzavjVPrxa/2FuDNPQ2K0N/YXfeFVENoVtf/GGQayjpSI12MfJeINKox/2xe/T3DMtql5mEcopxH3dVH7A4O88NPAb8xuUPeeB6E/RNCcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AigdjPRutaAbcqoFkSaTsRbO2VbKB1FjGsAvwuH+liI=;
 b=FF9yKCOneuP3gvcSVgW/4ne8v7F4t5lE/YJ/6E92zEjs7kFiT1e7di7sTSZkDW48nSCxqt1rF8FMRuvpx71Zl6D2tJR03kwcUEF+Qu4QVJLhJpBJT2xSNA61w0hjNPHuvI2WBjfAiN15hnhmEw9z6OMGxIrFYI51Lk2zZriikPU=
Received: from BYAPR11CA0053.namprd11.prod.outlook.com (2603:10b6:a03:80::30)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 16:04:26 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::c) by BYAPR11CA0053.outlook.office365.com
 (2603:10b6:a03:80::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 16:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 16:04:26 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 09:04:25 -0700
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Sean Christopherson <seanjc@google.com>,
	<stable@kernel.org>
Subject: [PATCH v2] x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT
Date: Mon, 15 Sep 2025 11:04:12 -0500
Message-ID: <2d15f9a0368a660c0468299f430e22c1329a67e8.1757952252.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f480aa-b0ec-4c3e-8047-08ddf4718b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DaHlxqEKH7cZ5LPSENf0p3GDHNV+0/upyXz/EOguPxKg8TFH1O53mcOuUsHY?=
 =?us-ascii?Q?+yCmNs0LQTqqT7S6L/xOHUtVTDAp5gncWHsSomdPzO9GNVa9WNh+N+CJfo2M?=
 =?us-ascii?Q?u/dlg0uTAWBNo7w2PBHy8kQNmRvhzZMqWvRuRYzqKAG3hImFiTMhMgNZwbOF?=
 =?us-ascii?Q?GOOUF2tOBfb4zlAim7wqHAvbAluLM4LTpge5JnIJ3DI+VH/vQA10gxvqYW0/?=
 =?us-ascii?Q?AiRh4mZS8+7ZNEEGDq5W95P6/oMiSVVRsTy31V2gdyoCxmuyqHLeXGf33lWU?=
 =?us-ascii?Q?t38wDpjH1rKgozf2fR+sZioCHMhgU2ZtCLfx55ZzactK9lQsv0AxzwMQOnGP?=
 =?us-ascii?Q?KawW82BAnjpQ2qhqEm7UjIEHUpDbftVG1YFzPjOUGMzIphGlppoDcAf/u+zQ?=
 =?us-ascii?Q?rEWz9uTS8ZjVT89nwgVHmQPqQ0grK9V5TlDIhNQS4IHOdk9jXZEkXsapD/Zp?=
 =?us-ascii?Q?ma+YRGOzp6Mv0/WoBK5fCj7aCbDaZ1BuoYnQu5fCvlpBeyAn+gDlL1O8z0nq?=
 =?us-ascii?Q?G0O0lfxf3f9KEz28H2VJ5oyuNEcItxvlpieCYTiSDjqf3Lhr3nHXF6wOOw59?=
 =?us-ascii?Q?ZWDYjkn0qX+9SYuZMi2OYnRpcjYGm9GPE0KDdv0V+6mpZfXjTEdSJUAmcD8M?=
 =?us-ascii?Q?o0Mh8aEFifLRcDIN0MxlGq9dOKJL8RXIG4RwEXz5fkmIvEPLBTHBX5X4jWIV?=
 =?us-ascii?Q?eh20WT3Qw4xf4Pjak5CSO/7PTwQkOt9sacdZHgyKrOde40CO2CRxN1ZMO9cN?=
 =?us-ascii?Q?UssfoMriDQPSVMDnsBZ4/CgzLklJPrHfxK9VDWOmMfQg+pyJv/x89PTzXcGh?=
 =?us-ascii?Q?RgqPjZ7WIzQbn+8K3vjU3fNrCrHIjHsAMqOxdDYpjA8B/KN1PSFsaATBobtn?=
 =?us-ascii?Q?y1cTNvy/Vm2uQddR0tz3gC7tk+jpMRuL0inAqxZMrQjINggltL/5EIOpsoHe?=
 =?us-ascii?Q?YyoUAVoxteCCPS1Cbd2zsVMvqChwQOUsCph0MdJVHxKafHxZ0D7UG5mMYqVk?=
 =?us-ascii?Q?/lxxXRIWMGblvv+ReAF+kt5JAZ+D+Uiw1m4XvMUOFYEGTi7CIACJUtIHyq9i?=
 =?us-ascii?Q?AZSQIlHJpTx/3pOHFTgtFXSJsErzlzChY1Khesxz1NAkV8ulq/fKfExZOMac?=
 =?us-ascii?Q?U8q16QDSRk9lGyAv33lEHS/xv6X4YkXhaHuT4PL5HnYAJuj4EjFWyW/C/+qt?=
 =?us-ascii?Q?V2iewXSbctIZeHDhNvGcQzNB17lLRptIi8dZkya4gtfOE6HXwLfACKlQXnOz?=
 =?us-ascii?Q?DEPJbC+t9zw4OFHgw+6z0iw2h55SZa4zktkKLyafFCTB0cwq+gsxe/abcIBQ?=
 =?us-ascii?Q?KDN9FfTjoEXBoY+cHi/LkutHn3XDCIXyKv6BaXrOfhpz1q/ipeopvYQ8xkks?=
 =?us-ascii?Q?rF1LsfsoxFjAJWW6msBFPGbhO4kaWZ8wz7VYBEqyEb/T1D4eixG0SF6waSqc?=
 =?us-ascii?Q?2ebIWSEK14LJ2VwtgBA30lHBu3ZujPrDwLNym9RTUNnEBu7Mdz5FWuqqXF84?=
 =?us-ascii?Q?8hs8o1UjuYU8R0+MExkB1MVpgcVG8dzLlPBI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 16:04:26.1984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f480aa-b0ec-4c3e-8047-08ddf4718b59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110

The sev_evict_cache() is guest-related code and should be guarded by
CONFIG_AMD_MEM_ENCRYPT, not CONFIG_KVM_AMD_SEV.

CONFIG_AMD_MEM_ENCRYPT=y is required for a guest to run properly as an
SEV-SNP guest, but a guest kernel built with CONFIG_KVM_AMD_SEV=n would
get the stub function of sev_evict_cache() instead of the version that
performs the actual eviction. Move the function declarations under the
appropriate #ifdef.

Fixes: 7b306dfa326f ("x86/sev: Evict cache lines during SNP memory validation")
Cc: <stable@kernel.org> # 6.16.x
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 02236962fdb1..465b19fd1a2d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -562,6 +562,24 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 
 extern struct ghcb *boot_ghcb;
 
+static inline void sev_evict_cache(void *va, int npages)
+{
+	volatile u8 val __always_unused;
+	u8 *bytes = va;
+	int page_idx;
+
+	/*
+	 * For SEV guests, a read from the first/last cache-lines of a 4K page
+	 * using the guest key is sufficient to cause a flush of all cache-lines
+	 * associated with that 4K page without incurring all the overhead of a
+	 * full CLFLUSH sequence.
+	 */
+	for (page_idx = 0; page_idx < npages; page_idx++) {
+		val = bytes[page_idx * PAGE_SIZE];
+		val = bytes[page_idx * PAGE_SIZE + PAGE_SIZE - 1];
+	}
+}
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define snp_vmpl 0
@@ -605,6 +623,7 @@ static inline int snp_send_guest_request(struct snp_msg_desc *mdesc,
 static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
 static inline void __init snp_secure_tsc_init(void) { }
+static inline void sev_evict_cache(void *va, int npages) {}
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
@@ -619,24 +638,6 @@ int rmp_make_shared(u64 pfn, enum pg_level level);
 void snp_leak_pages(u64 pfn, unsigned int npages);
 void kdump_sev_callback(void);
 void snp_fixup_e820_tables(void);
-
-static inline void sev_evict_cache(void *va, int npages)
-{
-	volatile u8 val __always_unused;
-	u8 *bytes = va;
-	int page_idx;
-
-	/*
-	 * For SEV guests, a read from the first/last cache-lines of a 4K page
-	 * using the guest key is sufficient to cause a flush of all cache-lines
-	 * associated with that 4K page without incurring all the overhead of a
-	 * full CLFLUSH sequence.
-	 */
-	for (page_idx = 0; page_idx < npages; page_idx++) {
-		val = bytes[page_idx * PAGE_SIZE];
-		val = bytes[page_idx * PAGE_SIZE + PAGE_SIZE - 1];
-	}
-}
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_rmptable_init(void) { return -ENOSYS; }
@@ -652,7 +653,6 @@ static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV
 static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 static inline void kdump_sev_callback(void) { }
 static inline void snp_fixup_e820_tables(void) {}
-static inline void sev_evict_cache(void *va, int npages) {}
 #endif
 
 #endif

base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
-- 
2.46.2


