Return-Path: <linux-kernel+bounces-745692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C32FB11D22
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B66A3AD286
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBC02E49B8;
	Fri, 25 Jul 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KAHIyO2A"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303F2E542F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441644; cv=fail; b=Z44eQDI3/m9jpT0sdsHUr6Zf1WgoPvMVia/zoglHSgRBKZhZvfMrY1TwXGdfL8ClGgTgmYGHGDZ3A1HvBFJT3blGez2jZZ2+56rr8moly5xW4m5hutG5E0WfmDWu2pwIqWFduAVAi4sRX8JiFJjBLclsxyPJkXfD+CXdRF1nILw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441644; c=relaxed/simple;
	bh=ORuYilq97P5jYjPT9y+pjKEViAb3GkV4lxN4S/qjhMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sopb/viX2j4Nrmg87/bCI5Tn+ErGdFjDVd3vHgjUUqooRSGM14smcZ6eH9DzqL85WKhnlknXK5hgRjIRY96uU4UU0f2WlpVbEdo/A7/bVbZ6OheZs5u/n6s6QGZHxF0fzxD9wAxmCp00wZ0fMiXgyiiL7L/SL6k2l/iEtMNBxmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KAHIyO2A; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frB3WBH/VWOU4x/t2feUzuRyJWx8BlebRrrSfQEiulQPbwEwUG2uSCD6Sa4coetfzzqH7O9r4OvUSRvsjZsErDE4Ys23XDraf9fqAu2HLIim6Dae4xyUnabdXyoZdU/wKwsrkeSa824w/1RkY+jkYvvTwcT95sTxTdw+D0/npYsnvWkii4O+YhFU5VEUpDPSNfwBejbm9YSIKVT8oCYqvYctC/3ESw8LLkGFkY1pbE6GMWcHEtBUFg284RTXJKu9EShxr+vZFud5V4jf9/9nLofOCncxaO8/sBh00T9PYgQLJFcxAxXurIUXbSkY4uQ58KWQ9Ib7nyqIb1SUZQPqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTJWnmfWHDlEqK3D21J0i3FL8ecV77/JKvQRl8HJwyI=;
 b=b0zosEY+paBA/t68QajWJFRG7EHgZmtlddnhoZ5hckkEah9lCFGJeyuBIAfrH4p5tbvS3nG2GTcBXaaCKhKQLF9+fj81xz8X/y1MYd25zb4bR41CMb/wxxmd0FuolxL6aztVO4uxOAsc1aD6tjs0LWWiMMQ8/N2/IAeZi4rPTx12ZThrAsPQaMMAvnRAJL4cAvvYw6awhSQVKAmXM+IBWLAwj0ti6u4ySuF8EP01QjEDRQjhhYPfEUDiYnnKz1Ds5khuRRrIUgKCh0Bo3+5pcVFT0YBKlXwTDc2TNiluec9FgSqG0Bla3STEiQlEwSIozPXDnPw6334bJrxBrGEXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTJWnmfWHDlEqK3D21J0i3FL8ecV77/JKvQRl8HJwyI=;
 b=KAHIyO2AQbdNOi7JqAHKxm2Zey/Z6FllISSsfk8WLDowlBJMHfkXjte8SvFXYs25ui/iiInXYsl9abQgSjg9ZK6pn9QLtfbGnKCK6yYKnPdEBgUZBEorzV3KNUuuAHG9sLeNIwdFhl6yxALczuC8aQZtuAFa0up5gucdQnse2GM=
Received: from CY8PR11CA0010.namprd11.prod.outlook.com (2603:10b6:930:48::22)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 11:07:20 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::79) by CY8PR11CA0010.outlook.office365.com
 (2603:10b6:930:48::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 11:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 11:07:19 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 06:07:15 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: Naveen rao <naveen.rao@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, "Xin Li (Intel)" <xin@zytor.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Babu Moger <babu.moger@amd.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH v2 2/3] x86/cpu/topology: Always try cpu_parse_topology_ext() on AMD/Hygon
Date: Fri, 25 Jul 2025 11:06:21 +0000
Message-ID: <20250725110622.59743-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725110622.59743-1-kprateek.nayak@amd.com>
References: <20250725110622.59743-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: 4762aaca-d8a2-438d-4841-08ddcb6b6c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3vEeTQr6r9vBPHA/QQ5HnkGMLWpqBIOYXNY5H/8j/vZGXC+O0BTONkoF9WyK?=
 =?us-ascii?Q?8B+DK8ETZRmxtNw/UO6w75jqd6HzgH15sTnzU/8HTUmajzExUEl3NWA9dTWk?=
 =?us-ascii?Q?Oxx2CUMdZs23WH7STjzKiIigSAv28MvtYgQCb9MUJ+poZB0MYr1JDFinuhF4?=
 =?us-ascii?Q?rC2p+zsQ15rHP5WIjTivXPNY/NqCWHe+3jVU1Wp1riL5GUYwvMylQg9x0lsT?=
 =?us-ascii?Q?vUE4lwNdw78/wZyiiU7NYrgNz9J/QPMTscTHBi2mOuo0tlmxwIFTYBACa78s?=
 =?us-ascii?Q?Kq/rgqDVT2esCXG6n6Sng+p4xLQjameFBjouaH2PwmTJah6JgOF53FqXooRA?=
 =?us-ascii?Q?Jx2+CJLHVWGpTE4aqJi9IV7cpCzsR5tO+9TSH/aFmq5quFfxbWRheeGSdQ6M?=
 =?us-ascii?Q?wjlVDgpDBvidhkytoqE+NeRNFMw7/HbRw6AW2+G9c/DsNVdAoh3DqGxJ5UKo?=
 =?us-ascii?Q?3j2XFypNW50eIyxUQL0wKGEVG535D2dOe6Yl8EOGOuLSE/evn1RGiLhaV6k/?=
 =?us-ascii?Q?+Z7WoM/pIcd/8/IycXiQBtyDSN0cFqxiCFD/jdddF8K8Q0P4b3lSL6b0ELZc?=
 =?us-ascii?Q?TLRCGNQZtEySvDPud4MUPHOoBSwgpyuZHspNPDHtAFVxn2pvlHp2+N779mgP?=
 =?us-ascii?Q?1nI+Edq7OSBoYdCVc4vTSiPFfjB2k4ayVaEEgbcBGiD7tOWUwL02IQGg3n0A?=
 =?us-ascii?Q?rv+WHnTpaM40LsKxJsS5ZS6f/vwuX0VGAo7HEcn8azudYZNcdX4I058e8DLa?=
 =?us-ascii?Q?0KMyEva3sBFNSV6mg7zokZMDN2+MVrAIjpwiz4r6QOMT1luIBzZCJn6cM2Y2?=
 =?us-ascii?Q?pKl6QuvptuJ6vTyVhtSWB8F7tW+EEImXlGR2MPGsOHQX5a2BJnOCz20iv7mm?=
 =?us-ascii?Q?pj31f7TIU82p4LYaE+nPuCUwlwgyB5t0K5qAgnmgawpj4PaqAqdAigNS2OGo?=
 =?us-ascii?Q?pk9LGpk9rZdMaNy/rdQNl9bDa+s1sWsyVEVFl9BE7YqBZWjRPorHj4wMYrjl?=
 =?us-ascii?Q?tL3l4Mb1DUxqXFbaVsD80b7vUGwKldnTQt8VhiHy8ULeDYKl8nNN7Iv73a1c?=
 =?us-ascii?Q?OGGfvFI5L5aZKo60fdfuX3l8WHBKQuQIS6deaBuUHFWBvR8yMUC+Yt/MANaw?=
 =?us-ascii?Q?eAafmoq24O84XCruQ0z9ygsDksyqcQbCyo1z3BiC24yZefpADtzuK+RxNTel?=
 =?us-ascii?Q?2u534JVR4qETR2eF1wd7dFlZeo7UXBSiovKj+kqEYK6FwBamLMectJOQ2TTS?=
 =?us-ascii?Q?MKIaC0nWmV+uy7CU8JK4RDatz596mMBPK7Gbif9+qN2ArEMB5mtGt077gnV5?=
 =?us-ascii?Q?9tQuidleHV17KINMjQ0KxlhQ7QzdbmH2bdPYEjjysTCWKxw8YrRnDP2YJxgW?=
 =?us-ascii?Q?k5gO3chzczvcCOmxuZrVqKFJ2Btdz7djaIf1Vs6JQBvVTbg7SRDNc7IMjJZ+?=
 =?us-ascii?Q?1IKK4KGZYQzpCCr+I67pTwPFMdP62UjhsheZSemBAL+Zw9IUK1sC+/aTpaua?=
 =?us-ascii?Q?YJQgWvOfRoewPxD6cWpl3kDoV09GumfoDM5/ZHQg4dOM+jphTG69HqNAuQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:07:19.8681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4762aaca-d8a2-438d-4841-08ddcb6b6c8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490

Support for parsing the topology on AMD/Hygon processors using CPUID
leaf 0xb was added in commit 3986a0a805e6 ("x86/CPU/AMD: Derive CPU
topology from CPUID function 0xB when available"). In an effort to keep
all the topology parsing bits in one place, this commit also introduced
a pseudo dependency on the TOPOEXT feature to parse the CPUID leaf 0xb.

TOPOEXT feature (CPUID 0x80000001 ECX[22]) advertises the support for
Cache Properties leaf 0x8000001d and the CPUID leaf 0x8000001e EAX for
"Extended APIC ID" however support for 0xb was introduced alongside the
x2APIC support not only on AMD [1], but also historically on x86 [2].

Similar to 0xb, the support for extended CPU topology leaf 0x80000026
too does not depend on the TOPOEXT feature. The support for these leaves
is expected to be confirmed by ensuring "leaf <= {extended_}cpuid_level"
and then parsing the level 0 of the respective leaf to confirm
ECX[15:8] (LevelType) is non-zero.

This has not been a problem on baremetal platforms since support for
TOPOEXT (Fam 0x15 and later) predates the support for CPUID leaf 0xb
(Fam 0x17[Zen2] and later), however, for AMD guests on QEMU, "x2apic"
feature can be enabled independent of the "topoext" feature where QEMU
expects topology and the initial APICID to be parsed using the CPUID
leaf 0xb (especially when number of cores > 255) which is populated
independent of the "topoext" feature flag.

Unconditionally call cpu_parse_topology_ext() on AMD and Hygon
processors to first parse the topology using the XTOPOEXT leaves before
using the TOPOEXT leaf.

Link: https://lore.kernel.org/lkml/1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com/ [1]
Link: https://lore.kernel.org/lkml/20080818181435.523309000@linux-os.sc.intel.com/ [2]
Suggested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog v1..v2:

o Moves this patch behind since this deviates from the original
  behavior.
---
 arch/x86/kernel/cpu/topology_amd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index a0e3e177fc35..b392d91c6df4 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -178,18 +178,14 @@ static void topoext_fixup(struct topo_scan *tscan)
 
 static void parse_topology_amd(struct topo_scan *tscan)
 {
-	bool has_topoext = false;
-
 	/*
-	 * If the extended topology leaf 0x8000_001e is available
-	 * try to get SMT, CORE, TILE, and DIE shifts from extended
+	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
 	 * CPUID leaf 0x8000_0026 on supported processors first. If
 	 * extended CPUID leaf 0x8000_0026 is not supported, try to
 	 * get SMT and CORE shift from leaf 0xb first, then try to
 	 * get the CORE shift from leaf 0x8000_0008.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
-		has_topoext = cpu_parse_topology_ext(tscan);
+	bool has_topoext = cpu_parse_topology_ext(tscan);
 
 	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
 		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
-- 
2.34.1


