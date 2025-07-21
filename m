Return-Path: <linux-kernel+bounces-739600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD8B0C864
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE07ADAA2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE032DEA67;
	Mon, 21 Jul 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q3nSKov9"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DC4189BB0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113807; cv=fail; b=OeA2HJWlIplAlXwwCk6I//Ikx0h+V+piLk+4X7I1WSgtUBmA0MyWb69GJmtF5weqtE64B5Qq0sSApmSJmXfMaY7XNUyHpEiahrzqAGxsXJ/wJBCbmxrovj05nJIjK0N1cSJT+7fuIX3UHzL/QkbVGyOBz0elH46/gVfU+dP1kos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113807; c=relaxed/simple;
	bh=Nx2JTZoEcEj9p/mRX5YEy6KDmXiF3MQbF8tL9lncqRI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BdC9C1qqudzii+CXoRsmCuLJpGKD1ieH6mYYv+6IxMWW7gRepPpY8P0m0uZATrJOlya3UUEoiJ+8DxLJd7rHBYP631kynr2f+FefoiZs4/9jy/SQSgAfVagpsyt/r1WtDoSvj6ZOwNAE+HFflq7TMmd4lXpFHD4JOe2K3funLyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q3nSKov9; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjK/Qbw1nd1TNqlsG7BP7DI/i587R2/+OqsV02ClMQbSqWk8In5ORvQ2xUAqa6x5JdR3/3JlfzuaC1Gfss54aL1qrN5Qe+a14ccKVeKcVjEer5g1C/2QGgJov+1yNDPGPOE1S+APOcAaA3i3rFkiiqaJB1Jsegi5netjRorgeQmCci2ym8xa8fnWgZgU7fFe6uln8h2RM9qJ09yz1Fz4mJJ33F+fik2uYYsPVWGTX+dALJWWGf9RDhbp83WEJX/bnU/mhL3N3/KUwJcL9mRh7q61wdxL3QocNBy5c0EZEiUtDtAPxRpN6c96aMjGDSUrrswsrcrqpDYY+4m7t4+uEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9biJUIyHKzb/aV1u684+ZS1OkYdT0Qa8m/EL0Q4+T8=;
 b=DtA5Cc7Koqw6y823bGVcswmKlKeOpNmp11Nz6r91rpbsqEkBzfl0R8VLa4YtnJwEpaW5l1qUbKGxS2eUqHg7Y6R72YLo5PKyOZrg+MDfIGEXheJGtmHT62J3M1N+anHZ28ur7o6v6zQYNnBHt7FoqXIaH5zLn8UdeVEG+2NYNO7DJ20c5j8kUQU+aCcAYscixmOm/rNRuXtfFGmcGyLRP4wLvWRp1/Mg3eP5lUc+bfgAjM2Pb9qzDPRtSRkE7k7b2A776S263HH7Jwr8taYSAAryEaz/1Eg7+8yTHUK5IuLYEsjACLL6Dom4TyZp+um3TpLo9ec5mSpni0N2txt3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9biJUIyHKzb/aV1u684+ZS1OkYdT0Qa8m/EL0Q4+T8=;
 b=q3nSKov9XU/Q36PT4A5QqDacDF5B9Os8hAKzbbwv90Tmr7AXD6//FlTsWOamXMe9mki1C7ySb+CFUyce+Q7r592W2ZfFrRw69E8NmhZwVonMgAnmZU441M9I45Tn6bVFjNeuW1nfO0jQdM07wzgS6s4AsdqrN9T2746iVJZIFSI=
Received: from SJ0PR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:334::11)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 21 Jul
 2025 16:03:21 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::8b) by SJ0PR05CA0096.outlook.office365.com
 (2603:10b6:a03:334::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Mon,
 21 Jul 2025 16:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 16:03:20 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 11:03:19 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/bugs: Select best SRSO mitigation
Date: Mon, 21 Jul 2025 11:03:10 -0500
Message-ID: <20250721160310.1804203-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: b28cb1d5-21b7-4318-3c3f-08ddc8701d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h/9HR2eDhQke+gCuKMRuigMfUyKf79TPxhDqmGb7sZcwNtm+G+h6u64nlX1W?=
 =?us-ascii?Q?lFcqChRy/fFcR1oOFlwZqhGtM9Lw1kypLo7fPJalEuxC6pjjhTvDfBTrkg8w?=
 =?us-ascii?Q?x3JP6iK3uyzT6jFGqz2X4Zuh4vnV0+ZNLQDjCygZ/U7fIng7tXax/xHxLWMe?=
 =?us-ascii?Q?LobDFlWv0I5t0b2X/rrYiVNfj4OmrEK/O/OOaOy035+EzLjFgfrbZrhw0v2K?=
 =?us-ascii?Q?/Tm9T4KuZRz3kU7r93NOgi4bTi+PMJsf0V856nda3BEWkQKoxeU98wfjtfQh?=
 =?us-ascii?Q?iXZpkf/+8Ig6/P54IbCz0J35EDso8QiHd2d1KqjvX6vTRqDNsKpADZPm5hQs?=
 =?us-ascii?Q?UJWg7i2xOq80bRxhfq3Cyinyju1IcmgpsWfFKWfNovruILPJDx4NonredB15?=
 =?us-ascii?Q?1x98SJc3yC7AmfDDSx1QGS9TUcWVXihLCXDFXeJA6nlGnKBABryw1CIZLSYw?=
 =?us-ascii?Q?Ql3CNMkwpjrykq01RfHyb0IsABOH5oqixCAzzvuoMbfvpYrFEB02ffqzbbXm?=
 =?us-ascii?Q?1y5xobwfa4UWXZFMflwFt/70GTzFZ2qOIMQnbmqlx+U4eX1mB9RN0kV8Mfg3?=
 =?us-ascii?Q?8cKUdtr0h9mkAmds6WcWu3T+wHdFdi9odENJnH2XK0OmX3XUoyrfqZCYMuRp?=
 =?us-ascii?Q?/6HM/PyA48papsp4WXSzBdqWsq3h6LWHqUTEo9Tg3nhfrlxdQyLXPOt8ArDT?=
 =?us-ascii?Q?6EAcjDP/XUu1vihkCdEYpcRCYqjlMcqcvqoZtYAgVquE7lcI3l+rr+eaWqcb?=
 =?us-ascii?Q?TwGCKxY2c65MQpsWoRFAwe2uagBg/mKU94eSej/vQkAnWBVQb0UsHWN+YW1i?=
 =?us-ascii?Q?orYOL4KTjzzH/ogz3xWvqMPYQ7SNb2OUB7spR+PSf9QBO3fMZ4xCCrs1B/2o?=
 =?us-ascii?Q?XT66u/EfAxIab6HAZvmxAGaaO0VGhLxwEdeHyJD6VF/qB8lIHcg0DrYuwKUt?=
 =?us-ascii?Q?cSKlyFosYyoXoaT/mtYbrRtYrqMqjGZhhgZPBzOcL7AgdPm32699pgZ6Ji7u?=
 =?us-ascii?Q?xAv+UVt18qKEbJg+4O9N4wC04gWrmeJYZ+4DYXWXbBTEdKDLfW7UFQvcgrUg?=
 =?us-ascii?Q?o1jIXP/pXXMMLqfIh06rWEykKQZozJzRLwlsDUeUbHR02Sg9erMJjLD+tooJ?=
 =?us-ascii?Q?NCKoJJscEUJ4My2nxXIhTQV3x7SV0jxFCzAq2Zo6RwIV2n6qTQdBb0hHPT7z?=
 =?us-ascii?Q?NmTJRcm9tH51vM6YTtJ220tJV3F7b5+8x/NjVYy518Ze1CbjdbmvSxTzDQHH?=
 =?us-ascii?Q?eOwFFT4F3oGoj/oHK5frGHH3MwwzORVgpY0mm+b7xcx6cVYksBtISuuUGCa9?=
 =?us-ascii?Q?g5Itxn8J5JURHtRT+CDFZ3ExZv4UG+msLLG63YLxua62esbTXPLwKPNc7kGN?=
 =?us-ascii?Q?pJzRd3o7PcEkJz+3PfM1QyLhPe8yCBYGIHofNMxIPYcKQghJT6EMSI9GM9k+?=
 =?us-ascii?Q?zZnYRL2H5DB8lbTT+6F4lfXPp/xuGH0WZXgZ6PS4eXEIu0r7GuNXJ7DOCfYe?=
 =?us-ascii?Q?F4wzGRhkX5dfhOT2SlL87V0ztUJvnvgZrBve?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 16:03:20.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28cb1d5-21b7-4318-3c3f-08ddc8701d73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659

The SRSO bug can theoretically be used to conduct user->user or
guest->guest attacks and requires a mitigation (namely IBPB instead of SBPB
on context switch) for these.  So mark SRSO as being applicable to the
user->user and guest->guest attack vectors.

Additionally, SRSO supports multiple mitigations which mitigate different
potential attack vectors.  Some CPUs are also immune to SRSO from
certain attack vectors (like user->kernel).

Use the specific attack vectors requiring mitigation to select the best
SRSO mitigation to avoid unnecessary performance hits.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 .../admin-guide/hw-vuln/attack_vector_controls.rst  |  2 +-
 arch/x86/kernel/cpu/bugs.c                          | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
index b4de16f5ec44..6dd0800146f6 100644
--- a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -214,7 +214,7 @@ Spectre_v1            X
 Spectre_v2            X                           X
 Spectre_v2_user                      X                           X            *       (Note 1)
 SRBDS                 X              X            X              X
-SRSO                  X                           X
+SRSO                  X              X            X              X
 SSB                                                                                   (Note 4)
 TAA                   X              X            X              X            *       (Note 2)
 TSA                   X              X            X              X
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b74bf937cd9f..2186a771b9fc 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -386,7 +386,6 @@ static bool __init should_mitigate_vuln(unsigned int bug)
 
 	case X86_BUG_SPECTRE_V2:
 	case X86_BUG_RETBLEED:
-	case X86_BUG_SRSO:
 	case X86_BUG_L1TF:
 	case X86_BUG_ITS:
 		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) ||
@@ -3184,8 +3183,18 @@ static void __init srso_select_mitigation(void)
 	}
 
 	if (srso_mitigation == SRSO_MITIGATION_AUTO) {
-		if (should_mitigate_vuln(X86_BUG_SRSO)) {
+		/*
+		 * Use safe-RET if user->kernel or guest->host protection is
+		 * required.  Otherwise the 'microcode' mitigation is sufficient
+		 * to protect the user->user and guest->guest vectors.
+		 */
+		if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST) ||
+		    (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) &&
+		     !boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO))) {
 			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+		} else if (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER) ||
+			   cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST)) {
+			srso_mitigation = SRSO_MITIGATION_MICROCODE;
 		} else {
 			srso_mitigation = SRSO_MITIGATION_NONE;
 			return;

base-commit: 34481698fd9c3c21425ab744e9e15dc2ce3b1b85
-- 
2.34.1


