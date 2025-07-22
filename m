Return-Path: <linux-kernel+bounces-740414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF745B0D3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC7E3A27CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEB1230D0E;
	Tue, 22 Jul 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2/7HZRJc"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150B21CFF6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170558; cv=fail; b=DaY544MwsoDIwX7LXeNj9vWRAAu4VPwLiaylLFbHgFpo6JCIDDLeNTR0BgpZ2g9isKAxkE7Mr5LUo94glfolTYpwuyAoZxfYhYa/TvQXJntbo0thtqM7Y4cB5BpYi1qaJ1jP4pCGboRn4nadppgIfJdupRlnqLBX3quJWqo1/sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170558; c=relaxed/simple;
	bh=nRyol5odRUzG8mQA0bk6/tiQF1bQuv8jzXMij7syncU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BYwHG7RnZWpCR9PwUtRg+B87R0ZBszIURh4anSLcGWTmqKDrHRy4MHiNQRW79RYwUxZiqBdf34D1HUc0zY/A9liSgQULqFGOCeXQ6eAobmmHGGq3o4Qnv/FZxTMQxkhyg2DddUFeHCwxgd2I1eAW3aVt7Kn1Z6pwg+/puWysSRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2/7HZRJc; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXmyBaWdigx0M6huepbR65jRCDskjCNI8wY3kmsPYJu4nPmXHzhCHuA2asybxuhV14br43boeBBw5nGzwDHl3cJZUd0S7Qm792gfRY9QYSAn7czX/gQJhQ8RwR7ou4OulABx/OAVFBkhzJm52BdxRV8mzrrozfyuFpG7fZR99xYjByfz9TKam86F057BQP0Z+gMEPvcjYcO8nbvuBzIsW3CkA7VVTvc1GSsHLLPAXgRKSdR6kQIjvGbyw1qSfKh2hPSsHCebXn6ktuJ2AxcY2z82JAeqrnAxQ3lUgIDEIlYTbpfDt0dIariRW84gP2afudBm/CrU0cRFJ+Ytp6FP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4yhNQoHHYCQjsbLPAptUzZdMB2xAGIvkpKPDsPiaKo=;
 b=pmD7D6QYZmZyklMmgAgS66WqSL4qpk7WGyFnedBzxuMpSCQ19AkTPFnSnk0Y2OeIf2Czf3n6VE4eYBZolOr9f2+zd43t6LIQ+jwArbQhxP3qewDqbdGD5k7eD+ssOlWb6fVPitNDYYl2PUqnHwSPv4z1LM5+aVDMmlDJC9sk0fKru5goRIsHVEyX/aX+WwCKqDPidssw+Fzmgc5z87pUodGUqS5Ei4J+QfYDhis8rj+84Do2Zd9A7N3CEtGJRSy7dmRabbWfxWfR79V4aYgWFyyXbnHFJwH6oW6HP8Khs/RIBJVCx3C/L5Ku98bDvP7+Td+AG4vIH7PTbAk78TPCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4yhNQoHHYCQjsbLPAptUzZdMB2xAGIvkpKPDsPiaKo=;
 b=2/7HZRJcYuhyAcoEPdbGgjC552pfXSRV95zjDEVGbGEtdBtMZVnXo3FAk78qYZ69v7p0IiGMfz8KMVyfy73fD73J7O6YNA+yLFryZf1A/hWNHt3DPJeUAAd5tVWonLtX/VHJ3WyH7nFMRRoRl8+5bOOQhjC+N5dpXi7Xj56hsW8=
Received: from SJ0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:a03:3a1::18)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 07:49:13 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::8d) by SJ0PR03CA0373.outlook.office365.com
 (2603:10b6:a03:3a1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 07:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:49:13 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:49:09 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <x86@kernel.org>
CC: <seanjc@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH v3] x86/sev: Improve handling of writes to intercepted TSC MSRs
Date: Tue, 22 Jul 2025 13:18:53 +0530
Message-ID: <20250722074853.22253-1-nikunj@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f65747-d9e2-44f8-2b19-08ddc8f44056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?whUAGGtfrtgUGCMYJJ+iaJ61Y4vU4Ja3VlI743uS0+Yyzed8Sbj2HPf8BDab?=
 =?us-ascii?Q?nlNP1uHri+CRAmd6SRZsGKNj3LD+sp63in93Fe7Eo2koKLmLZJcLvtgOWuDI?=
 =?us-ascii?Q?lZaqy4kLpg36kDLU+WE//QHHCstkl/reuKklkJyW0BMQh9AxBB0NnQcdusg+?=
 =?us-ascii?Q?X+1Ntujv4GCllNpUAy2YyNjkga/ar4TT6oBZOsXl3WzFS09vcOF0WEoozc6u?=
 =?us-ascii?Q?z7IYwhynb79lbZyDku274AFuBlmkPtRusAXJexzRut3+VAHbf6FdHa7UO8zK?=
 =?us-ascii?Q?qu+v9iWQrxDOoBfPVwCNo/qVqsxWClqiQ8SNcbIDpM+UEtJ9f4c5JXUYJA+6?=
 =?us-ascii?Q?5ZERtsDY2w/ucCiwK7WZZ6RmbXwjPq3TEWtyW0Z/3y4JR2nRt4kZVzLhhofP?=
 =?us-ascii?Q?lWXAohA44Yy2FxxzDqisZDfvdUX2JVTyqBgJoEQnzM+m501lh4QZVLuRH+zh?=
 =?us-ascii?Q?0JiTKK72Ui8A//8SzAXSKEH/cYTtMmUoVAse1upeNI8h3QFU9UEuSZjIQbF2?=
 =?us-ascii?Q?JFRRwJOPZ8eQ36O5R2IcpNK2JUUI4CjFYDBijfSP0miDKviqnYUllcw1zk+M?=
 =?us-ascii?Q?95rBQDdO7Z8IsLgjHrkiQGrkXfp5qok6f59ZCBQEqQ81yCVxPGFQD54igzpr?=
 =?us-ascii?Q?why4iWf8qH0Ln4wwpKSDPEJCfrHwNj+3o3lX9rvgl9Mk6Xp2TWslUILaKH0f?=
 =?us-ascii?Q?9antvFmdByuU19DABEYq56aSS6uiweHEfotNoXlhz8UpedA8QUon9alrWLGY?=
 =?us-ascii?Q?ThqVTE3tA0XZlW0mH0G8jBwWT2pW6wtS+rOyC85J9mjTOhezsDHvybA5Jvfg?=
 =?us-ascii?Q?iQpzRghWdXgp14almOt5OfPijk0GScjXpGd74czbk7asB+M+NR9CVDFZlczs?=
 =?us-ascii?Q?GElePrAFV8UMGefrdNctO+IWgdq0bsOmgchWegYUSsdZH65ODH/V6ttNjsnn?=
 =?us-ascii?Q?J6JIFs24p9i/bYiQwLLnHdChMyiDkHcUwY/ec4lWk8opJrLl879/ci1JNNHD?=
 =?us-ascii?Q?rxBy69ALgBUOmwPIKoxfoA2JR/mRL6NJ2TXYgd/sVmJbYqR/qAI8ccMZkxiM?=
 =?us-ascii?Q?uNO4tRg9gxIalmSCp+JE6rhyj5gGGZdRj0z3h0q73CNVyFzuH/9aKtPyMSy8?=
 =?us-ascii?Q?BzcN7mJ+g65uBKHpy40r/X4Sd6AFStoloPbU68W9P8gnWvrmMSL07tCGUp+i?=
 =?us-ascii?Q?X2oXAm9qd7wSvZSmzIDBqQ/uoIivv4zwmcDfE08XSQnsV00CrmpCP8sGnq1Z?=
 =?us-ascii?Q?BjlnwwQCx3myR2+Dt5R2Gucl0IlVv4RicExIJJBTk7Ys1b+vuUU4pTJtgw+c?=
 =?us-ascii?Q?/yZLWGQcgViV8SBBPcEZVSyGeNXiaceNuohgSmBbsRRzUcnj0BIgaKMQ+258?=
 =?us-ascii?Q?KybqsGlyBmFhelOWUjafrQbH9i6ub7nMZrauHMV31nt3U0aQzgH3YXnwrd1b?=
 =?us-ascii?Q?gMWW3ohrYfZGFzEHKhokrleuubKKcDMjDWr4LSLju+Yq7rxz0qHxj83xtuBo?=
 =?us-ascii?Q?Mq7PfP3BnDpqiylFWpHkBffE8oqct3mT8ED2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:49:13.2792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f65747-d9e2-44f8-2b19-08ddc8f44056
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Currently, when a Secure TSC enabled SNP guest attempts to write to the
intercepted GUEST_TSC_FREQ MSR (a read-only MSR), the guest kernel response
incorrectly implies a VMM configuration error, when in fact it is the usual
VMM configuration to intercept writes to read-only MSRs, unless explicitly
documented.

Modify the intercepted TSC MSR #VC handling:
* Write to GUEST_TSC_FREQ will generate a #GP instead of terminating the
  guest
* Write to MSR_IA32_TSC will generate a #GP instead of silently ignoring it

However, continue to terminate the guest when reading from intercepted
GUEST_TSC_FREQ MSR with Secure TSC enabled, as intercepted reads indicate
an improper VMM configuration for Secure TSC enabled SNP guests.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---

v3:
* Drop pt_regs pointer as it is already part of the es_em_ctxt struct (Tom)
* Added Sean's suggested-by instead of authored-by (Sean)
* Removed WARN_ON_ONCE as kernel already warns via ex_handler_msr()
  for bare wrmsrq() calls (Sean)

 arch/x86/coco/sev/vc-handle.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index faf1fce89ed4..6333eb6b23c2 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -371,29 +371,30 @@ static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
  * executing with Secure TSC enabled, so special handling is required for
  * accesses of MSR_IA32_TSC and MSR_AMD64_GUEST_TSC_FREQ.
  */
-static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write)
+static enum es_result __vc_handle_secure_tsc_msrs(struct es_em_ctxt *ctxt, bool write)
 {
+	struct pt_regs *regs = ctxt->regs;
 	u64 tsc;
 
 	/*
-	 * GUEST_TSC_FREQ should not be intercepted when Secure TSC is enabled.
-	 * Terminate the SNP guest when the interception is enabled.
+	 * Writing to MSR_IA32_TSC can cause subsequent reads of the TSC to
+	 * return undefined values, and GUEST_TSC_FREQ is read-only. Generate
+	 * a #GP on all writes.
 	 */
-	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
-		return ES_VMM_ERROR;
+	if (write) {
+		ctxt->fi.vector = X86_TRAP_GP;
+		ctxt->fi.error_code = 0;
+		return ES_EXCEPTION;
+	}
 
 	/*
-	 * Writes: Writing to MSR_IA32_TSC can cause subsequent reads of the TSC
-	 *         to return undefined values, so ignore all writes.
-	 *
-	 * Reads: Reads of MSR_IA32_TSC should return the current TSC value, use
-	 *        the value returned by rdtsc_ordered().
+	 * GUEST_TSC_FREQ read should not be intercepted when Secure TSC is
+	 * enabled. Terminate the SNP guest when the interception is enabled.
 	 */
-	if (write) {
-		WARN_ONCE(1, "TSC MSR writes are verboten!\n");
-		return ES_OK;
-	}
+	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
+		return ES_VMM_ERROR;
 
+	/* Reads of MSR_IA32_TSC should return the current TSC value. */
 	tsc = rdtsc_ordered();
 	regs->ax = lower_32_bits(tsc);
 	regs->dx = upper_32_bits(tsc);
@@ -416,7 +417,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	case MSR_IA32_TSC:
 	case MSR_AMD64_GUEST_TSC_FREQ:
 		if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
-			return __vc_handle_secure_tsc_msrs(regs, write);
+			return __vc_handle_secure_tsc_msrs(ctxt, write);
 		break;
 	default:
 		break;

base-commit: 34481698fd9c3c21425ab744e9e15dc2ce3b1b85
-- 
2.43.0


