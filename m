Return-Path: <linux-kernel+bounces-814714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BB1B557A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383FE5C1E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084B2D24B6;
	Fri, 12 Sep 2025 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wfnv7Q/M"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3D54758
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708982; cv=fail; b=JRUIvMlLQLgghJlNDozuqAhOKtAmlYmsaIpjPyT7QfjvQ8373Q7r7fI3EyOzjOAlygRHiHWPquK94ZzhER351L0w9Xb+bs1qWhFquRt1CM2Tsg7KJZPR4AQ36xAzEGtAhzNDn6QF5roEneHC7l/hcfwBKY9Yfi/U/X9PorX65O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708982; c=relaxed/simple;
	bh=ErShfRtXbv0CHqc2y4QSnMMSxr/A9KqimcDbnT/xpNA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MxT50ceKJtMurQA/6dPd2eKrtRw9GmtWyViopIzl1V5+sfZX1IBEIvlgpbDSbVvwIRnUzrel9Ii19Q5i1Yl6DayrI6x+5kwm5J0X3Ms1Ptvd3HhLmKT/QLx04QB32iMjCyUW0OKJ37/Hp5qhyM/tR3fi0KLZrOZ6u+QjoN+qWDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wfnv7Q/M; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBCOafrwcl2QZnNk9PT8ueqr6Yy2G24TXmtxjsxYzwXOPiMzj0aKUMq+bzV/UKnM41RJpmnssjEmgYrDz3RDZ8MtdWsZf/bWnRAGqTeUAEKaUVptpFm21NzQahowLtXrmda/QTqtQQFrl4VGPi/VOMYc0lEO1VBZwrPQ5vYp3FzeSBtbCeM0GeV+xdNZFmoX9cuOAfzoK+hvpBdQtpGfmHIW64lyS5sFGghBx8EylHYpIkMr7BFriMsTN57Zvr5llW2hz5g5uRzZbjNmpDTXL+n9h0pFuXA+biy0z/XM0r4bRJtTlwA57KJti/jcPKBIhQbn8qLFlWH7gP6qHlbc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waAPcKTjUguZrDCBC8+qO3rQVklcRl9KUPDZfQM32e0=;
 b=DjuE5mAUpEeh4w1QmmqZOREn86SF/t0Rc3El91zzhCr6udnj+M5VhxH8KOTuTj7V1kQZrE+cEdspBJ4uJfLxBKQu2R/azSHZmz0gQIlakG37L/1FrkKZEO4fXOzPsjJLjVgZEj8qPtb5PttTixPZkDEiBuguqEQAfJEkpH733wgB+wntSqYtmPMZnF07F4aclS+wYwPDdaodM471pSAO+mNNVsgq4Eu5m0qJP2j2TWlx0UpRTgH8UiGibYCfZjvCb/981dGq3UgSsekLfjZ7iaBIgtuq0CVkc8lqquGyC8tzuOuykK53x3lE5pkoUbcasqYf96Gu4BfbTFNIiFBBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waAPcKTjUguZrDCBC8+qO3rQVklcRl9KUPDZfQM32e0=;
 b=Wfnv7Q/M4A5ApPY0famWlanQJyD9pNVdM8toPENElcN1t3GQ/VAxvFVCoZ6A92V7T2Y7ALWfD1jY0tR4s6ADvO0RvKLcs3Hy+5adPxLwa2XDZfQp83aC33jgjg+RYVufi4bTS/G8SkMX/YzhXNoj+THQxvGle74vI3CFihRfTlA=
Received: from BYAPR01CA0017.prod.exchangelabs.com (2603:10b6:a02:80::30) by
 DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 20:29:34 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::f7) by BYAPR01CA0017.outlook.office365.com
 (2603:10b6:a02:80::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 20:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 20:29:32 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 13:29:31 -0700
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Sean Christopherson <seanjc@google.com>,
	<stable@kernel.org>
Subject: [PATCH] x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT
Date: Fri, 12 Sep 2025 15:29:19 -0500
Message-ID: <70e38f2c4a549063de54052c9f64929705313526.1757708959.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5d5276-ec60-4054-e59f-08ddf23b1548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u0jMCZufOkmdeK26fCKNw8DtARHLHLOhLyjp9Zx1SXuM8LxjyF46k6ZGpJ/8?=
 =?us-ascii?Q?17n+Coj7v4GtCDzAjz0KoRQsfGw+gE1Fz1x1xz+Js91Voj2IgaJW7pxz+svy?=
 =?us-ascii?Q?ssmnsfvOKv0Z1wqjVvFcu+adusGA5Tm9ngg+L/AUGrr8sIoqPV7xNPcQ8lA6?=
 =?us-ascii?Q?z7zlN/l5+f3BtBLOP3c38E4aT6tDKuXv/9UT6+LC3KyBK6T4CYgDqybnxgeR?=
 =?us-ascii?Q?DbnaqxQFjchHoRsJAPlWxZ2X/o60+/UJg+QYHzeLzhczJnZZoe1SozFLWR3b?=
 =?us-ascii?Q?l8O0yrt79TqK1WbAyItHHPBG2a0VIY2vteHPB1c4VxE0oot65g+9jTODZxoD?=
 =?us-ascii?Q?8Siy95jY49HiJbCBnMGfGKNj/37MhlkqFoS3xqqtTOUbG17vpkfUCp+dJgy2?=
 =?us-ascii?Q?vG4IBJaEH7mRgyH1iSZL/lZ8E9YvLiKFmFwiWLvgSBVjYjVElYsDqhNyFWYR?=
 =?us-ascii?Q?AG3upvHxopzDm/Sksda2jG1+dOLeeV03lKdSryPJ3g6j8y1BaotNlM2bHsa5?=
 =?us-ascii?Q?Ju/UR5eg0wyIm2fkXmDfOY3seNINMUaiy5b80J65o+uyOk22EgSosAcfRdbY?=
 =?us-ascii?Q?XxO8A4VfeO3bhTOV943I3FC67GHNYNIETWBqPwCguYbdIaPbXllkUOMIJLpg?=
 =?us-ascii?Q?YqhORPQliAV+SjT6grEJgFAojjGKNHMq1SxD8L8R86OFSc3AXdwjzyE4FpvO?=
 =?us-ascii?Q?O+Dol9hlnfIadz8VPnn2JReG9qshNyzt0an0QkypE3brNNRqudoEUtkAe/lj?=
 =?us-ascii?Q?1+wG4bm6xLoqQs5gCBuvhcreanuucUKK2Ev15WmOXa9Rc1XwD689Fm8XaqZs?=
 =?us-ascii?Q?3efpv2gf0bPVMAt0Qz85PYfbOKX4bSR8v5LOlfArq5m+0RyfhGW2lHhiRKZt?=
 =?us-ascii?Q?dJ6scxyWxavfn8J/lvNxaYIvpsLwQiw8FOpqwEFqt0NmVEoIe47oA+xXBzUN?=
 =?us-ascii?Q?mJtomBQMt5EBv0pJG2XF5YBO5iaVCzjYhTIa5u0vqStoe4FchBcR+6w7kWC2?=
 =?us-ascii?Q?3tJPxZJDoxVT6srVXq9plB9kLiLOXJdx5YP/0SGcEcQCyyGs5Nw3+zxdKFr4?=
 =?us-ascii?Q?TXwxuF6kSaapRLzEcUlRZTZL5318w5f0W5YaWPw/6z7Hlm/UTJo5LfG4xt5Z?=
 =?us-ascii?Q?h4fZyEIP/8+APx6J+P7y5BNgG7J7eZL1paOhqrNwk0IXUj9tSE9+IZ1KPbdI?=
 =?us-ascii?Q?uwQToPvKfgeyjfwfohgXLHTqI2Lw+r8fWpQ7ULMHmzkpjKHlRcGFa6F6d2oW?=
 =?us-ascii?Q?wFv5iDyhkA+Vjd1v2uh0aC0VVbUCx0e7jvosSqN+Uv6186quBAynAU3SXCGt?=
 =?us-ascii?Q?WZJczL0Mmu+/t1VtG9XrUatpotX3fjXY4Zync0+1gJLJZ/ffZwj8GhnLgqmI?=
 =?us-ascii?Q?25izRFsF/lY8UmM5n9KueIwOEqnaeyOeV1nfDKEnpZN/D4G8H2W42NBZlU/D?=
 =?us-ascii?Q?5931QB2UPsaTdh0clJGWbxO0Ix3QxULWtAy+Xmr+uKYmvUNEajrWErGkfVZC?=
 =?us-ascii?Q?0limuBD6p2J1iHbLnThNijdCrmXDWV4E9XUO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 20:29:32.9235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5d5276-ec60-4054-e59f-08ddf23b1548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271

The sev_evict_cache() is guest-related code and should be guarded by
CONFIG_AMD_MEM_ENCRYPT, not CONFIG_KVM_AMD_SEV. Move the function
declarations under the appropriate #ifdef.

Fixes: 7b306dfa326f ("x86/sev: Evict cache lines during SNP memory validation")
Cc: <stable@kernel.org>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 00475b814ac4..e5a7e0ebdc73 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -579,6 +579,24 @@ struct psc_desc {
 	u64 caa_pa;
 };
 
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
@@ -624,6 +642,7 @@ static inline enum es_result savic_register_gpa(u64 gpa) { return ES_UNSUPPORTED
 static inline enum es_result savic_unregister_gpa(u64 *gpa) { return ES_UNSUPPORTED; }
 static inline void savic_ghcb_msr_write(u32 reg, u64 value) { }
 static inline u64 savic_ghcb_msr_read(u32 reg) { return 0; }
+static inline void sev_evict_cache(void *va, int npages) {}
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
@@ -638,24 +657,6 @@ int rmp_make_shared(u64 pfn, enum pg_level level);
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
@@ -671,7 +672,6 @@ static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV
 static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 static inline void kdump_sev_callback(void) { }
 static inline void snp_fixup_e820_tables(void) {}
-static inline void sev_evict_cache(void *va, int npages) {}
 #endif
 
 #endif

base-commit: fc1ded58808520a1ced0c4e2e5fb0dbd33b33612
-- 
2.46.2


