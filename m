Return-Path: <linux-kernel+bounces-850747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D6BD3A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D681D189E925
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA5F309DD2;
	Mon, 13 Oct 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p9Oph02I"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D0309DCE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366180; cv=fail; b=bsoDWM0AlglMeFVQKhUY+Din1Y16GAaUOiCwdtl8Kk4q6Lu5zazZkJpSTVK/Zna0NuEcHkopuTN2iv9fMfMlZ+8aYNjgoxeAz+5Yqrbp9kiTRwxDZI2x5uxm9FQUQm9GS8OjTsbJP78WGxvEilEh2uVFB+pF6eGeGYp1wWRDjeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366180; c=relaxed/simple;
	bh=ivtbyWmVAoBE5vLinfYc396xp9cMgZl74TBBmFLZ2cQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIWyo2A9m2gqudrUtswGuSi7EJnfPCmsidhwrhCD1McR//hT6ryOP40BEw/bJ95Cs9g/thBKkx8I+1F3rEfum/9oVUhifhQsDK7WgUjUj5KsMTnjzg7N1nKTQBSdjo4bMFEf7y23/hhBxL+JSdgpBDqHUC4Su4/u4mApWEvQMUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p9Oph02I; arc=fail smtp.client-ip=52.101.53.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch6HxYZ6lSlQwJJ2Z8G2DDjx49nEC7CL3IasU6nUYVrz8SPZQGjHd9VZFuVwh+tmAlmeG/DMnxeFsyDdEUSiGoe9y4UcgdNoyhAnX6jf1KdPwP3hJ7HMgZqM1H8VSrAySHkdv2So039Nmmbpave3lRzOE32UqLHj+QO5AclC3amuPTF9rBuAdCjF9Ip3DX0/GL0Dj2LQMoq8UA1sqJpwqEKunfs2LNto19gsrhv2zWPGIkkkEyiFMJzdAH88FuHMIHF21dqGqNKfVjdazpniERPy+4nntnZ14k6cs+mXAA1173Oz0Vw6IwzcT5XB/Pwr8aB2VGOh9Mg7W1iKN0hfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs8YiRAB9tWEXiTWKuuFM6YsKHu8s9z3Hbon/oZySQY=;
 b=L6iG7f4G15/RvIj2EcfkgPAzEWRZ6qPm9gD2flsdSAiyTyGAbT6FR6cPvbLZkBIbdSiykXE6klg17longgTnIae1EBf+zooZzsmQ1AfQJ7m26PXdWCpNDukfA06yWMh+CGWHnU6Lq7AjJPjVKkIU5APFtawx1Qg7lzL/rUWW+357AtHYve+vyjlrteZ1MHJcK0HENXmFeNaQf/GKzLuZ3ivi2t3F0BjXlgNeNI0OVakWqIANWsam5SY/4Yr6YBOhYtLK+AWX8hnGgph0Zwwa1IW8vJeiDNylgLW0s5uNUKlYdhRq/R44MUurfD3WZeAVaMkCeDRwntBmYOsK2TjU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs8YiRAB9tWEXiTWKuuFM6YsKHu8s9z3Hbon/oZySQY=;
 b=p9Oph02IcZc+meo+dM5xxGJsGZRX52VeDm+g5XkwOPz3/wwVxvfQcPhXAAWTJAPutajmfcC9eJVOafsFUliJaYDsrPmNdH9+2QnYwu68aGNMuVcGqHw8gywIU3sR+8urdl2DvWI8v7jm1UEMMmUEhd3m3R6WZINZf8ZRW4XtYfQ=
Received: from BYAPR07CA0065.namprd07.prod.outlook.com (2603:10b6:a03:60::42)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:36:14 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::e6) by BYAPR07CA0065.outlook.office365.com
 (2603:10b6:a03:60::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:13 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:44 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 36/56] x86/alternative: Do not recompute len on re-patch
Date: Mon, 13 Oct 2025 09:34:24 -0500
Message-ID: <20251013143444.3999-37-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d0134f-6f9e-4f49-015a-08de0a65dc0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ztQVeVVcKBXTQdWWQuasHrjNCZUY5hGAwEJx4MQER6NSFVLcJIKQqc4/G/Vg?=
 =?us-ascii?Q?8avffxvybcJVifIRe6lSBJAG80ejQeSWmHrBBtQXp904lMctwWPNca5ODVU1?=
 =?us-ascii?Q?O1DNL3X9SOjGGAqmtk0SF9nyHHdST/cZnZmLCz7I0Aj1WbAZYZgAXiixOs6B?=
 =?us-ascii?Q?Bv7MplQnhgufhIbtdVIhJqQKnWSOAoqfxoMVe/VpPiTDCvXG5VQ9OS3wSq48?=
 =?us-ascii?Q?DLY4XrrV4QkveRdnjZ/GZH8U2UeGaZRDESkZjUxD+vBiQQZDiBolSUIih/6H?=
 =?us-ascii?Q?taEN0v0i4z4OGCjME4DVP9tFjAdfTGMm3dUgI1VlbYLqTi7aVMXg6lwj4mEi?=
 =?us-ascii?Q?ScVo5emXNHJGT+hLalhu4eSwU31of6iriBsGbR2CPw2Gfe4jGKiCmKe42qsb?=
 =?us-ascii?Q?2mLH8uyDyQKD4jQ9DEV2iRb9djS0GCOuIl7fGAFN2j83JHWh+NRnpRWcke3O?=
 =?us-ascii?Q?Rzld90053RGOv8pJ58VpHFvuCKqOJ18TGbzaMrQ5Ai7KAphClrbLPBvADFZl?=
 =?us-ascii?Q?sOnZC3jXsIj9UMG5ENBBfcbA81Nzv9EuOS9a1zBbEMNdy4/fYd3Nx4JUrga3?=
 =?us-ascii?Q?kXvpH4f7Mv0Gu5dSHntuOQAoGb9MukcQ6WBRjSnOfI+U+UY64SRc9rLb2WqG?=
 =?us-ascii?Q?wppEjgnYf8F7wCGt/DRkGx/jsYkgecNtKI9odkJLSP560xrxVcCT1KtD95BJ?=
 =?us-ascii?Q?JU90ixgJ5WcZg60ftkQQxgJ6hLb98t+U18dqUdP0zv+lTfFsux3AAMcmgnuo?=
 =?us-ascii?Q?w2zZUH60HkwoHpRbRCQ3QE6P/a6WQpUtHXpRP2JXrnqGg25SDvtVfbiT2lRk?=
 =?us-ascii?Q?IWPA9YL4diihe66BN0v5MkRPmXM3jVdykX4wMvA9wjxRbCMlJt/kqs7byLaT?=
 =?us-ascii?Q?pMFBZ9+lvqPMKmRlKpoqB3hbfirwygPNwXPoV/GZre+rR4+M+P2FQFVIUJUE?=
 =?us-ascii?Q?48qGt6eoh0OgtoEqSMOexanUAPgfVrP/neppK917U5Ow4+xJ+DUZwKaZybQI?=
 =?us-ascii?Q?HtPYReSEQUuaUtui430mclFfwSgYM3hWhVFDCjtIDLuytYdqFYkJSJHaeUxo?=
 =?us-ascii?Q?nDIQxFBEF9sQnUX58vbRwfwt4j7OcCD2J20oZSV1T+zySlvSo5sd49EuXBUT?=
 =?us-ascii?Q?0auJHoZr/haRoPW1X4JdUWva/RmueEAxRMySFanTD0/aj6munQC1P+PDH6pK?=
 =?us-ascii?Q?HaQw9WVMzyGme6Zuwd4datWo1nfUrGazpW7XAv64/X+0YuFs33o9F81RR05W?=
 =?us-ascii?Q?ouGBZ7m5xE9Gt+54Lv6ArQG1zXM+4R1S2U2aYDJyULE85hzicH2Y93eYJ5OF?=
 =?us-ascii?Q?OHMaADAisWvHOZ+DlWrLXkL49OY/tN8p54VJwl9BoRqOrkqKfONso/2fERu/?=
 =?us-ascii?Q?zyu3npqQIB97+Ab6XKIvbg6XXl5lMQj8Ep7vDxKCZyt5rwK5L02bp73nA2n4?=
 =?us-ascii?Q?F1ERyQzxejocDJvdYgkLAYzP7FI9asJx/sH1pSB1kf5jeCjb/urzSvAYK+ZX?=
 =?us-ascii?Q?2brVZoJBZ4NBL86FRr83DYpLA6P3YTrd2PpgpTuBS6poNUfJLat4QNC+QshF?=
 =?us-ascii?Q?KUhd0bK52l/OGR5SWBY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:13.1734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d0134f-6f9e-4f49-015a-08de0a65dc0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523

Multiple alternatives may be defined at the same va, and the logic will
compute the maximum size of any alternative and update all of them with
the new max size.  This only needs to be done once, and must be skipped
on re-patch because the memory containing the alternative information is
read-only at that point.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/alternative.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a02dc6bfb696..17b93763d1be 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -298,7 +298,7 @@ u8 *its_static_thunk(int reg)
 static inline void its_fini_core(void) {}
 #endif /* CONFIG_MITIGATION_ITS */
 
-static bool __maybe_unused repatch_in_progress;
+static bool repatch_in_progress;
 
 #ifdef CONFIG_DYNAMIC_MITIGATIONS
 static struct alt_site *alt_sites;
@@ -697,8 +697,12 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 * add more padding. To ensure consistent patching find the max
 		 * padding for all alt_instr entries for this site (nested
 		 * alternatives result in consecutive entries).
+		 *
+		 * Ignore this on repatching because this has already been done
+		 * and because the alt_instr may be in read-only memory.
 		 */
-		for (b = a+1; b < end && instr_va(b) == instr_va(a); b++) {
+		for (b = a+1; b < end && instr_va(b) == instr_va(a) &&
+				!repatch_in_progress; b++) {
 			u8 len = max(a->instrlen, b->instrlen);
 			a->instrlen = b->instrlen = len;
 		}
-- 
2.34.1


