Return-Path: <linux-kernel+bounces-720360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CA8AFBAB8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BC81AA517B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE42673A5;
	Mon,  7 Jul 2025 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t8eZuVyV"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7944264F96
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913220; cv=fail; b=rrLklbft4LOPYJ8avjidZ3wR/eRmngwL3qg20gNoc/oRGYE8QNqbXD9b4Yi4Jnevwmhg2G2q2PMD2n19qmvK62/KQUVBzQUAvqvGZOFBZSLveF+BSHHrrCCkkfhFz7uLhvFklMWhztHR862BoVQBuU2F4cnvzu3Jnjj40yllU68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913220; c=relaxed/simple;
	bh=2BUL30k2kW1rvDW2EXGU1mfB2Cblay60gPb7to2jMs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L68xXkOTEG5Vy7wDltyHozMsoIX8DIHRUYr5kl+5tMohzdA+uurrQ9PuC07peXx1l7v5TwtJmw40+5qMgoKW05hsry5yD6m9i1e77k55Fd/EHE/P66PxByRXYxYUpoXs1jh3Ju3BQfFDaEsvVzncrRPqC8sM9Klbve3qzwg7vKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t8eZuVyV; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHa11uA4Pf4X5N1cksQbabIIR/IxhNphzhr8WieHpRKPPc+4VWcc9XKNfT+Kmjb3L9tatATlxZq+bv8bKHYgCZ6bx3DSxiFa8c7xM+e2o1Z/EJgxnrgACbz4ctncCk3tC4ElECkhzKjZZDmRyXKI/JdqA9Gsed26sWTi3t6CZg01r8KGmZtSwgbcnXZu+7bM8DIGeGd9ua/Kq3qhBTZCvhNYMgwukLkMKPW/UpWppyLLL2U4gczVejBUf35wsJk2dGWdwrLX+B1e414OuJxOXVOVCtyu1hflAyNOhQ9T6EylmaAgyINXyU69g/YFGJOKAK5h0tKUySXRcLF6YsteBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5g1c1V/sBNPvdh5G48hor+yPF8XH7RxtSUYOEsdifY=;
 b=JEh8jKXmu7hkqFfCc9BkTAVEpUk090d0ijMZ89Jp0bqA+lwjtbh8DUqZPf+F9bS6+EN8A+gvVk4RwN7sRR4A9faT9ctdg7N2rqETw/1TOYALnBCwVnmUi0nBLuV/6one8Cj+ixhqyAFJxtGUIm8VbrY0Catq7DSJgDmt/WevDMGdFBs+ZcnBIzCd1/Z+uaj8KBDmVSjUF6XA2xOjO/j5HhD6e31+BQButBOJnfk1KLji2PzlZTylBiTZe8VmBJQFdhV9fwehftjCXYbo7WnF3YvxgsuJGl+dC8NXp7Ymlv29skQCGNiXxIKGYJw7LwYo0RL/BZfP2jlor536jWXQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5g1c1V/sBNPvdh5G48hor+yPF8XH7RxtSUYOEsdifY=;
 b=t8eZuVyVE9XxtzkujOJLX1b/OKbLEzSRzmPhVuhfrJM9TNSYDzMRpux5Yk+HAOTHMFuZppAWi6V1q3omdy6SyjmJIwPoal2NwW5N810RKjTO87YQJdJ8JaJUO8SFD++q/6h7o8ZWhBVa8RTdq+nq63qwaQJ6+mtewHNNvvVs9CE=
Received: from BY5PR16CA0021.namprd16.prod.outlook.com (2603:10b6:a03:1a0::34)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Mon, 7 Jul
 2025 18:33:36 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::9e) by BY5PR16CA0021.outlook.office365.com
 (2603:10b6:a03:1a0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:35 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:31 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 06/21] x86/bugs: Add attack vector controls for TAA
Date: Mon, 7 Jul 2025 13:33:01 -0500
Message-ID: <20250707183316.1349127-7-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707183316.1349127-1-david.kaplan@amd.com>
References: <20250707183316.1349127-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 639d5a61-1b84-41cd-88b9-08ddbd84c88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2e/nIdKQJvXXdRWI5S2XBBYoZ+a1MLod/lJ/Lx8H8Z5Kl3XWd7o3pHnrng8H?=
 =?us-ascii?Q?uvXNeCAH7CbaxZNHWYdA8UlGx/CCxUThUwTQzp4GMxk3je4UgAYD8yz1XHPN?=
 =?us-ascii?Q?kmgKrAPxcsd+vgGZM4Ef/v/ECjsDEHl83IieCp3sm7NL5C98HRNzPJfPuCev?=
 =?us-ascii?Q?OooVGvDJcWipt2eW3Sbmg0YLuNTQUEj7yS0UEbjjK0h9boVO33q58RYymuOj?=
 =?us-ascii?Q?XqsjeO1lynd901NUBIj73SKbzHBAjEaLOVve7gLkEcKJHKys8FyqjxR2ymSR?=
 =?us-ascii?Q?YIwKLl0fg9JOxBwsUX7V7jGYhFPbFu47JEmvkgB27l1PPSfntOqHmtS5YCjk?=
 =?us-ascii?Q?ctWm8FoqYyAOD0GIK7jXslr/S/MOnF7B5WP77tZ9yv95nSGITFvVZ+uWWedh?=
 =?us-ascii?Q?UcANdsQeNxuAEPvKdElPYHoV4lGF7G2QTuCtRGlIzr4VmXO3nd4+EK6rnwbI?=
 =?us-ascii?Q?Kp9xd3pDbGZdvCYXJLqUsFEiYiXVVPT3FCO0hqzJ+UaM1zMXPcz07MxchJI4?=
 =?us-ascii?Q?8qpmfa+J47HF/ezF6LD1ISQTuflkRTvbFuqCXOiW0m7u3+/SkO3IxGV5ocjt?=
 =?us-ascii?Q?wJ4U9NL7Z8elw0z0t2xEtsFh+QM7PCYn0r8rG7sIvUc3z3SVr+YaYzoSkO5i?=
 =?us-ascii?Q?YZkQspJiG+2OSRb+gKpdrpK8zhz7Vpo4ATnrq3CwI20QOFyahrpUinoEcEmj?=
 =?us-ascii?Q?STx2ZzS5aaEWQzX7w1wEnhPMelc1KNlllWBkBadtkwMMt3z7MZWMap5ARrXU?=
 =?us-ascii?Q?Igk/iyCMopieBNSQkoeY+xy0pFcnupEOMTC3wrfD4ExgpEjaIUO2Lgf79O7Z?=
 =?us-ascii?Q?Q2DkIu2BQuhDEsh+0qQARff2+MVYibfrD1RH/DS83Fj4oRBIwA440PPkCwBe?=
 =?us-ascii?Q?f/RwcP7ANAhSGwvLnc/srXrElcTsJcVX7toIsAux4nBKckD8y1AeZ285IjFM?=
 =?us-ascii?Q?ejHo9GK7E/y2UY2IuYUi6ikA44q3EaTkQx27N//mz5wLWOnzHRxzcfxBk9d5?=
 =?us-ascii?Q?rY7g8EwHZP98CFxR8QOcbtQA3ENl3gY6zhS0dAEIPKYRLiz9E7W2jOdQyYfy?=
 =?us-ascii?Q?y6ezEYYvX2b4PIMM6U9QyYmVY/fuNH0wwEielu2xHxuLx7COZek10F1tRUju?=
 =?us-ascii?Q?qBwTOPm7p3vBNi7SvVPCxHYmWjd4o1vLQawHe2m7M9n/2wBkg9U2oFTM/iK9?=
 =?us-ascii?Q?1VNcm9j6bwcQW8/ZP2/+8jkPaZPMXe9az8Pi/y0pKIbNdLkBghf0TUrOChlm?=
 =?us-ascii?Q?qJay95fhV7GRmONzQUa4ik1RQZqenanQOsJPgSlRYhEi/xxcgKrxmLTetpWX?=
 =?us-ascii?Q?vWGRLQusmfBU0Bzo3800KndK2stXlyKqBDfFibT9zgZGBdJ6vX1RYNYPXDzj?=
 =?us-ascii?Q?lveVsc69v7dOt//LyAvK9Byq6wejgm1oqJA2F38EuYCZApZSmf52+0ohbltL?=
 =?us-ascii?Q?16XYw/DoRXIJhLgqhBQlb28ia0DQWwELoQF8tjnbCrW/UbxOaw2O6cIKTOXs?=
 =?us-ascii?Q?JVtJJZBG+BTiUfx8od6ZCnbqVQUPbi0y3a0u?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:35.3239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639d5a61-1b84-41cd-88b9-08ddbd84c88e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044

Use attack vector controls to determine if TAA mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 65d482aa450f..527ea049d4cd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -534,12 +534,13 @@ static void __init taa_select_mitigation(void)
 		return;
 	}
 
-	if (cpu_mitigations_off())
-		taa_mitigation = TAA_MITIGATION_OFF;
-
 	/* Microcode will be checked in taa_update_mitigation(). */
-	if (taa_mitigation == TAA_MITIGATION_AUTO)
-		taa_mitigation = TAA_MITIGATION_VERW;
+	if (taa_mitigation == TAA_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_TAA))
+			taa_mitigation = TAA_MITIGATION_VERW;
+		else
+			taa_mitigation = TAA_MITIGATION_OFF;
+	}
 
 	if (taa_mitigation != TAA_MITIGATION_OFF)
 		verw_clear_cpu_buf_mitigation_selected = true;
@@ -547,7 +548,7 @@ static void __init taa_select_mitigation(void)
 
 static void __init taa_update_mitigation(void)
 {
-	if (!taa_vulnerable() || cpu_mitigations_off())
+	if (!taa_vulnerable())
 		return;
 
 	if (verw_clear_cpu_buf_mitigation_selected)
@@ -588,7 +589,7 @@ static void __init taa_apply_mitigation(void)
 		 */
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
-		if (taa_nosmt || cpu_mitigations_auto_nosmt())
+		if (taa_nosmt || smt_mitigations == SMT_MITIGATIONS_ON)
 			cpu_smt_disable(false);
 	}
 }
-- 
2.34.1


