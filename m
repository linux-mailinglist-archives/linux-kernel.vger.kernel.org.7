Return-Path: <linux-kernel+bounces-726854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21D0B01209
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049724A6FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FD41A5B92;
	Fri, 11 Jul 2025 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t/hCC2Ni"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538AE1A2C04
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207151; cv=fail; b=jwWNSf97WKeWrgIrKlkx7ii0nC7pHZMu32s1xaY4iLKpQgaed9vqicOGUmUUlgi3dDqU6UTEYtmzBOwHgQta5Oi+QCx36M7KtMUxDelCMzzeim73neXMCJyG49RORstuVxl031bp2wNNKEJLPUi8IwcldjLIcAty3l6mtp0UyDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207151; c=relaxed/simple;
	bh=eeLN1JRKfwPZ3CHv3gQ2DlItKB8Oxe4DMZff+kHnEf0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GNf2igyomj581xQMlnbnSvRFhlvjmD25ZM0MDSrsoByIGFkKRMiCc3KfKnoHty8gc0JG7xxecSE1wapJkd/9PQKe52AuMHOBGCXmL3zKPZfOeITT8cyZIKtPpjH8vR8g/2rzKFw2KKuNXsWTX5qXMyw5kneFC0kU+FMxERFTZjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t/hCC2Ni; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsOR1/GbaGqC/sLat5VM/2vNC2dY441r6MymtrINinlsL3AMtyeQ2rOLAP4SN9p+DVxfp6UtOw7t7QZIuGwfqDuWfsFxEieIt+xkyw4y4C/7EPBYEl2r/EyjDXhC310DPsB4xoAyiKIsy7mgwrPGhkpDodFOyNPT84/mu+SI2lZ4GzjoGZOWm5i275hCAN5JrO+z1cHw1I23ViNsPtpufSJCX7wRGTIa/QUCYgExjP5HPXzIp/30SgvtHP/7oR0tH7n3Kk8fgENXNA0VH1cmun/7WQpuFRv4n6BO8k58Y1rJq50nUKNoQsXZ4qNbfTv3iB2zjxm/uE8TtCFV/7hNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUyeixXjoQYgYu86Sxrjuz5M6xwI1ZJhHVflGbDDPS4=;
 b=B7rLrtax1eusff4rNon7oEsTXp1VSz/FfmFB2ANfJMz04sHngi1/WprPggS5SDbJDFMNYC0CTz6DfibAHkuu+U0fMwRvC8t/I8zYenUqD3II9eh3l+OYJjkkG1IROdC1AHoAgoRnNHjkRq2k65qhaic0qaSLWgr1KsqEmTwKIVaMu0PeVzJqSLvTtWYpnIJqV3mLAUDjkby4ZcDN4+giuC5wowvjbWXp5FNIBytWO7ntFnlSK7JkkVrTjU1xRn45DgUNTv/MqP177HKVTiCDtfH2PFTyv9vaOeh/NYEMdXceS9J1KaEWV1gEfV8sT85to9DbPfQtW/LHnOJ/P1WTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUyeixXjoQYgYu86Sxrjuz5M6xwI1ZJhHVflGbDDPS4=;
 b=t/hCC2NiTKtGO5pXEMpe/c43DiSngCe4ptXNxLIqveEztO5/aLXJZDjNmZSxtr78D6t9RyUXYg4QX6Hg+T6sqbwKno6gxDbEZTIW1LkJt6ccKX8+WQRK+Qxdrziv4jXDrYsuLviqmeqzpzl105u30BTQxWbsnDOPWRZ8XVHbGUE=
Received: from BY3PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:39b::10)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 04:12:26 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::bf) by BY3PR05CA0035.outlook.office365.com
 (2603:10b6:a03:39b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.7 via Frontend Transport; Fri,
 11 Jul 2025 04:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 04:12:25 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 23:12:22 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <x86@kernel.org>
CC: <seanjc@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH] x86/sev: Improve handling of writes to intercepted GUEST_TSC_FREQ
Date: Fri, 11 Jul 2025 09:42:00 +0530
Message-ID: <20250711041200.87892-1-nikunj@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2a1987-14fb-4a16-8bfa-08ddc03124da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4QjMCbnf5NqOyQuYtgtNjPWO8oxamUP+6FVrqXXjA40LU+oe94T3iACMBOX+?=
 =?us-ascii?Q?EtlrM6DOffrICF01M+KLYuX2bUid25ZnAYF1XXUiwIjtA+3wrPhkzBNJfzqP?=
 =?us-ascii?Q?YuNeAEwDhO1zlk3V2Nnfu6fem3dVS3ZDqLa+hm6X8coM9GSNjbqhLCczYs80?=
 =?us-ascii?Q?txbadMaDjyvjHslkJGP++1YHB4Qrq5sxiHx6mY2tbNMClL+zYQWG0k1l61WG?=
 =?us-ascii?Q?sbe8ire6nvudPX27LIi+Gcu9bD9RhjfOHKSkTaGu0HMh+YXtx8nWhtn6GtgR?=
 =?us-ascii?Q?Zi2VS2ExvC2GwfuU6fAsh9xNtXoCFbSvnqQMllCrk74vnoMB1L3wV3WudKQY?=
 =?us-ascii?Q?jNDveAySiBe7sSNe2MwB6bZpENcpHSku3fuZChTmzlbfkpxd1JfJ9ES3o6r4?=
 =?us-ascii?Q?Uct9SIoErSianmXRfdvJBgNzA5rJqlEzlgDSbmkLO//OfLomLgJjTCcmb81G?=
 =?us-ascii?Q?JiPciN4zxM7aHVTXdOxJh4tjFmpxMC9kq7HW6vQ9M/VvVkmHVSlttOa+QTnY?=
 =?us-ascii?Q?f4U4GaEI3jiq35t4UtA148zAkiBqXWyOt8OwF4+EddRpYQMPKGHrYjljVMpF?=
 =?us-ascii?Q?b8tiU18+X0c+Q2Fk6kO13hN3SbU4jziteXwqSvhgVdAZzmEzCWtoORrKcVsv?=
 =?us-ascii?Q?Votu3of33VjrTQsNFdI4XbWzqHeR083PbnJxAAVQr/PdQVy0sU/iQn+vR3SG?=
 =?us-ascii?Q?RcnsASzsseht9Au2Z1OX3/SxMf08QBUc6jh3AguvSL9+/rcuGe+8QBR8lsAY?=
 =?us-ascii?Q?j7VMEmGbIgytu0Mmu2+7ybazBrJbJgKQEtHoGhClVF2FooOt4JErepFHgXkz?=
 =?us-ascii?Q?INDwUu69tVgXmOI76c1HqnIDdWSeBhsuBgU3bzNYEgg29Q1NKVoq9G+/NRs2?=
 =?us-ascii?Q?hHDvFV/YIRavYQadl+3PNnjSWRUw+w/xuY1WSFTIvKuarAulSUQIf3pItLXD?=
 =?us-ascii?Q?tY+g2tx0pWMLUIj6M/V5tKvHQF11Em+BN6xmhGr2kt6obyGaGnKoEHSHMK+x?=
 =?us-ascii?Q?74I/YA88UMWv4VoApYhE0//xOBZ5f1n2ioiKEW8VS6viubcP1dbBmIjVZtAT?=
 =?us-ascii?Q?RB5a1QP5OJmF1LqgMpGvG1qGDz9l/JnKYLMQSc8skOkWc7LhzUdkFTG/oLp8?=
 =?us-ascii?Q?EXcNkjQKJpO/wLY1Wnh7o1j67/ODQnIfc4eyqXQiOrHIV0thd5Q7PW3cytw+?=
 =?us-ascii?Q?NVHxk8ogPebIDWMzhQifVvKrQDE8WKeQePd3rDGW8FuS8XSJvExDiRigw5eN?=
 =?us-ascii?Q?pUHEjudk1B9Jie5L9xXMcCu4Q7cWMm9v5boizBxpmbeIiHnyWeA3Qmo0YxpS?=
 =?us-ascii?Q?KasoK8wrhZVdNXiNY9Wq9OZ97TA77664G1CZJ46gTApomkljs4rRXYPhwxjs?=
 =?us-ascii?Q?PpDQi9aJHZZFGGOy/qDqNtgCew0UIUC+zN8jDj6DqnEOKz3a4GZF7BwPMUgU?=
 =?us-ascii?Q?//04AmFsPOIs8u+nQHUB0akJbP0Nt8MXuzAyl+1vbGVun91ctp3xApZolbMK?=
 =?us-ascii?Q?IP4GzKqmHV5NaJrJH3RqM3ja1zVLpPe7gFc4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 04:12:25.9363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2a1987-14fb-4a16-8bfa-08ddc03124da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460

From: Sean Christopherson <seanjc@google.com>

For Secure TSC enabled guests, don't panic when a guest writes to
intercepted GUEST_TSC_FREQ MSR. Instead, ignore writes to GUEST_TSC_FREQ,
similar to MSR_IA32_TSC, and log a warning instead.

Only terminate the guest when reading from intercepted GUEST_TSC_FREQ MSR
with Secure TSC enabled, as this indicates an unexpected hypervisor
configuration.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/coco/sev/vc-handle.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index faf1fce89ed4..581e34083321 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -376,24 +376,21 @@ static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool wri
 	u64 tsc;
 
 	/*
-	 * GUEST_TSC_FREQ should not be intercepted when Secure TSC is enabled.
-	 * Terminate the SNP guest when the interception is enabled.
+	 * Writing to MSR_IA32_TSC can cause subsequent reads of the TSC to
+	 * return undefined values, and GUEST_TSC_FREQ is read-only.  Ignore
+	 * all writes, but WARN to log the kernel bug.
 	 */
-	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
-		return ES_VMM_ERROR;
+	if (WARN_ON_ONCE(write))
+		return ES_OK;
 
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
-- 
2.43.0


