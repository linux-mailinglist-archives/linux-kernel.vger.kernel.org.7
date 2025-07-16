Return-Path: <linux-kernel+bounces-732898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF43B06D77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344EE56012C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D52D2E88AC;
	Wed, 16 Jul 2025 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tnmp4xzj"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4517D2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752645230; cv=fail; b=fih0czINK2odsSfcNowYINqZc6xdGsnLYUaWP6MKve2t0xZma+4X2gYXJsSo1X5CkB2SPTIAhkAgShC8fXSoT87HdU8zaspaODA2WKpSFKTtnZf+ZukFz5bnGZaktnQJVOpOA2FsiQmjJ0TRHe6rinvTzkb1gvUVfuN8Elg+53o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752645230; c=relaxed/simple;
	bh=4LkeckeajseEXbNcf43EiAbVCZOxgha3kxf3opNjqm0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pFP3kenH1zCiOb6SX3v6DX4uQLCaG5AQGohMdNa8TiKZ1ZwZhzwyZ6Da1Qh3aIY4Py0mgt4z5Uz6RWaWjUZ1Q/KS+chAjYYQiBzP4mrBULDZCRevSmuMw/smx6zjpAgfrMPJDoBNwDNU0yqFnKl7cdO7VKxI8zh6Lsu/5vcLiRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tnmp4xzj; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9j8NvsImHjlwIwQBUvlyrL5pH6Ji79NnQcE8omJrl+NRReMNwxPyNWvmivnkleJKoe8DSrD7sz75sONGMvHXEWneX0TfPnNKKlE16KvxkqG77UwCHxydi4/8Jb3IUddyGtw458ifN4FZlFJo6VDbM5tnAzs9yNjwa/IIP/vC+PnW79AvZYchIWMjNH4o3SF8EvQ7aVZnWXF8L3OLd9/nJPcPmzqyxfWtPEMnpzEJZndQzeq7Sh1rXxRI2LbLNqzN1BRJPomYGG+HWKz/viM4dPEitlFbARLqiW+/8SF2+sJa4s4U4ksibHNT86irVdkeNKftKTosQkQ1PYQHPCwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC6yBa2pq1n/w0WuBDDXz3YDyPoxKa8rYOLyj6idmRE=;
 b=NmfmryaRiH9WWnaPjI5hHMm9QL/bXYHeYQzry5fSbfsJ4fxO+ejU0RV3d2juIjf1LywmoXaG0yez7tHjkn4n+nuoMDA3xk3o0+/34w5s1fGn+M/tjQ/ncolBhZvVdSpTb48ShRax2mAh8oZVvv5Y3hk/BHNF7bq+t/AeaxEDLdR/3QKxoTknLZDIRyEHBy7GGC3dFoIg17pOqofveETTjcqZKAqz0/rxAXMUG2mDwqvebKQa3TPlGugHE7GWN5ZMQOQ/70XTohcXP7sWgsraXfckRvrgei5eNixXDaciRde09YL4kXQXjsvsfxGfJehOLdPG65uOh3cyydsPtgTJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC6yBa2pq1n/w0WuBDDXz3YDyPoxKa8rYOLyj6idmRE=;
 b=Tnmp4xzjKbfVmfrTxTcXJjTCquqFnRJ1qmvG+hD342A89YDwGvvTEpQ1msVF1jnq+zXg2vkXNj+W6LGox7FUryp97cRiLvRW+gE27tI9uaJNbnehZFJ9XWNuZoB/6oyua4R1RFVZPQ+IKLRMQtZO5O/e6yhVFiuch8raGDw4Gi8=
Received: from SJ0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:33a::7)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 16 Jul
 2025 05:53:44 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:33a:cafe::cb) by SJ0PR03CA0002.outlook.office365.com
 (2603:10b6:a03:33a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 05:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.1 via Frontend Transport; Wed, 16 Jul 2025 05:53:44 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 00:53:40 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <x86@kernel.org>
CC: <seanjc@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH v2] x86/sev: Improve handling of writes to intercepted TSC MSRs
Date: Wed, 16 Jul 2025 11:23:15 +0530
Message-ID: <20250716055315.2229037-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 410ec791-ec78-4077-d109-08ddc42d1fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n14/Z4vrRweYSMpu8dQMo8/Vv/4NlOLB5lu/w2Qc04m49blCig0itrdEf3pR?=
 =?us-ascii?Q?oqjJ1U+JlZPDTzQtgAZAPQ9jvX6obw6pQPBrxubYeINhGyc4I8BvJQRh5bc0?=
 =?us-ascii?Q?spMlZm1kD54FjmJWuzQKw6GFUaPjt9mJqXbl6/oV/t1RroIPXiV97QWKAihX?=
 =?us-ascii?Q?NeDgx4enhpBB8DbFNacSTBq5Z28cHrHq5nnbQZIKO693mU2tDAiMQnPh/rHl?=
 =?us-ascii?Q?KnK6GI5U+nyVUa02bFIffZFinfcW7WRQ4kxMFgvRustqbeXRBtDWeay2rCYW?=
 =?us-ascii?Q?ad/YXUH1W/bswJg7wCpkBtQSkAW6flHvOioSKQweT7GdgGjSG1pD9StHXMxT?=
 =?us-ascii?Q?UIoSaNdwL7atZ1DWstONrkUqh0kinEbjoQcT5t0cbd83n7OI3+9BhL5o3qyk?=
 =?us-ascii?Q?B7QiKYzjYvj8xYWq7O6x1xC9Ca/hrkWo4HxfGkxDWfqUB/yFMz6cqy0g0fTF?=
 =?us-ascii?Q?zgc4oENOsYawbzo82sdSXi9EBS1Xe9DTJpp27wvmWR/GNIvslfBynijuohAw?=
 =?us-ascii?Q?ua56VLqBJ/ULbYvTQZusUZxp73b/M19yL1ZBXZBq7LEcGsm4RLti2yjLd2EI?=
 =?us-ascii?Q?awOB+WOPM8Uf1dSAmh/jRhTky/TmIVkppITEcbWAsdI3DMHXjYF7CNirwghq?=
 =?us-ascii?Q?4FtNkvPDxcpu+odW8lQ3wXYSGJjfzYmUHE4BwbuKCxNKO+v968WdeUVEKq66?=
 =?us-ascii?Q?fI3SY8L2nGPcJNuTcnMe+CmPM7jy3WV+ez+DkPH6KfbmQmJ125nvmzjzha4j?=
 =?us-ascii?Q?PkNWQ5wvUohTXbrIAcJRJr6yQWWoqUos2KFw+QRa2vVKqS5FovRm/N7PoCeA?=
 =?us-ascii?Q?jzUJiy6v4DbgtONL8f+Nvo1hii1W1OOQDYCdNKJVoCm4rnpcXGTM5uVHdJJJ?=
 =?us-ascii?Q?KNZcZG30vScYBzgzoj9vCU4FwSE0clS8s6uV2Pg5hBIqm+IXWHuoICGZvK36?=
 =?us-ascii?Q?ulVRwwfcgVunUPo+49Nz0D8dr5hjz77XcvckLSAXwWKRbxRubQ9ak9YJfwFA?=
 =?us-ascii?Q?2nOFIs6ku62GT96ImUwJq+pp/A7fUtvEQVRcBvi3Qj+32LZSvo5F5ao7ZK6/?=
 =?us-ascii?Q?URBmmdN6hi7rcyo5kn2kERC8KOGQzu2Lv2/gZho3KJeEbHlkPIfaWHpaUKSx?=
 =?us-ascii?Q?Md9Uoe9FOawW4aQ7TQ22fO85kxXQ7ek46VScLufuolyj2b2tZ2VoLSaOhcbA?=
 =?us-ascii?Q?XsuvNIBO0HCCKTM/VxRYfy8ObDLB/okDoWCzcDS7Ii1NBlPh8zdEKnsjp/en?=
 =?us-ascii?Q?QdvjCrRydFfhkGpbKNCMkTqOHSZTItMNUF0DI3m4DV+5sZ4EjJvoordqap68?=
 =?us-ascii?Q?adtMJgyZ24yVTL6HyT8psKkP0g9RIGxGx9imhuhCJEykp8/b5Lb1sNagVZz4?=
 =?us-ascii?Q?bD5+gyTH8TootDrgzBlfX4IJNqCu8QlQggkwDueShUpt+qsh606sujCZBhaP?=
 =?us-ascii?Q?7BZ06xXhvT44ZBkLjiLfkm1iuO/Zf7cDPlLFGOqhSW+vxk099Q15gGELJz30?=
 =?us-ascii?Q?CayQUYMSWwYs+eSTMneS81I5V/GKCoT8CohW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 05:53:44.2797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 410ec791-ec78-4077-d109-08ddc42d1fe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999

From: Sean Christopherson <seanjc@google.com>

Currently, when a Secure TSC enabled SNP guest attempts to write to the
intercepted GUEST_TSC_FREQ MSR (a read-only MSR), the guest kernel response
incorrectly implies a VMM configuration error, when in fact it is the usual
VMM configuration to intercept writes to read-only MSRs, unless explicitly
documented.

Modify the intercepted TSC MSR #VC handling:
* Write to GUEST_TSC_FREQ will generate a #GP instead of terminating the
  guest
* Write to MSR_IA32_TSC will generate a #GP instead of silently ignoring it

Add a WARN_ONCE to log the incident, as well-behaved SNP guest kernels
should never attempt to write to these MSRs.

However, continue to terminate the guest when reading from intercepted
GUEST_TSC_FREQ MSR with Secure TSC enabled, as intercepted reads indicate
an improper VMM configuration for Secure TSC enabled SNP guests.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/coco/sev/vc-handle.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index faf1fce89ed4..18be9f8bd015 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -371,29 +371,30 @@ static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
  * executing with Secure TSC enabled, so special handling is required for
  * accesses of MSR_IA32_TSC and MSR_AMD64_GUEST_TSC_FREQ.
  */
-static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write)
+static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write,
+						  struct es_em_ctxt  *ctxt)
 {
 	u64 tsc;
 
 	/*
-	 * GUEST_TSC_FREQ should not be intercepted when Secure TSC is enabled.
-	 * Terminate the SNP guest when the interception is enabled.
+	 * Writing to MSR_IA32_TSC can cause subsequent reads of the TSC to
+	 * return undefined values, and GUEST_TSC_FREQ is read-only. Generate
+	 * a #GP on all writes, but WARN to log a kernel bug.
 	 */
-	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
-		return ES_VMM_ERROR;
+	if (WARN_ON_ONCE(write)) {
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
+			return __vc_handle_secure_tsc_msrs(regs, write, ctxt);
 		break;
 	default:
 		break;

base-commit: 9f4a425223f3bd8ccaebc7f4f42b1d8c5f12fb45
-- 
2.43.0


