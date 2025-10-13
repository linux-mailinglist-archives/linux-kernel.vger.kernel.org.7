Return-Path: <linux-kernel+bounces-850724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8113BBD3A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307FD3E0265
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823BF30BB9A;
	Mon, 13 Oct 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fsa6Bm7H"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E530B51D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366137; cv=fail; b=Hirv7mlhXAtlbrvqfaLULpXMcu+oZlnw/5KX1l+SLnjicngbUOsZcxWgyz9JH4+MslLp1yrvbsidxGW0zb85zHLXVEFweHHdn+9iSeS9uT/xQL+67YnWGwdPTax2VuC3fdpqf0y2lmw4WKbUFXLRqPvNb0lZGEsBCg/SKi/EhBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366137; c=relaxed/simple;
	bh=m+W1nblgONXW5TDO4x17r/JdbcADz6yNzoqBRkE4D2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+19vQFS5QfdVv6gHAuvkN4HW3Q0b3f1fn7Go3NEp7XJ4x0V+cjTdhmFL9W+a9UTkkYbr8s5d5USa6eb5szG2HAOblFv1VE88DyDwNtkh/nRL2b9kddxySU0IDk6O2iDBRu+1Tx0jMba4SgGQ/NSZmf3DNYRpJYewEZi7DbN+hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fsa6Bm7H; arc=fail smtp.client-ip=40.107.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rz8v/WviUaEG8P0dXddvI1auLWlSBemuGDO9ZoS9i9pG15iNv/7nGDQg6V9eiJIoFAR1ITWX9gyHJ/gIL6L4SZg7iJuUU51GNBvWMEYcLWAgTNEBkiYm8ecfK4+8SFmhtEf42iEhScPW29jQoYoBawSlWkPYuseCY87mgWAB2ZccNpJIHusncjnKUcx7JPeQZWk1kGwqlHRfRCbhY3102S40KpBYx5emWjPm8vwcJ5Mk9qnCSy+ZVAFRR88DouiaI2ZXCX+IbV14Aw+ibtqjBufzY7ACFD7BcrCy/TWD3pLBmz0G29wuSvnjBN0l3XKisA0riBwQeljh1OYgiRGfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJTdX/90J/Nm9TLZ+KGe1rqSSuV3El7lv7BRYTuuosg=;
 b=Bz0gcMHXiIe+Zs5ROlG6avj+s9xotJg8Qgq4xqm5djoxcZWWFtb1lOWPqjyHDz9L8CK5MBEBG+5KacXGcVL5Pi3QLFyzsl3dODHpChIfXmQymiMVua8P8w+GN1r9u/WnWAC1lb4Qz4hdTi07P9E+Lch7D5WSEdWdNoWitePZs1xKMK+x2S+vXH6VYT01q+5zOXmejcQtaCgvfe4joYLgNGC3kOxEdcCn2B+a5u1r9yFGQkpybXa3fm+5OSmDvc7YivDK1D2TGMbHSRjJiSx894ZDpoCJWwloly9/qGF/QBd7n6U/+enk9dmtTPeTy4phQAGROus8aytkdDHPzqgnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJTdX/90J/Nm9TLZ+KGe1rqSSuV3El7lv7BRYTuuosg=;
 b=Fsa6Bm7HfCrA3WfZhs0gny6Xtq7V6Ojd8DJoIDR/wnLFEIwZJSMP29PkBeWzC8zaRHkhSFTltiZzrsESrpemVzfeEUn/UV/zUijHJ8kOemtUxPB17XfVWcZRmYck8upL+6wtRHhMIEbJYO2uluH+FnHiCFztGhEqu8XwsGxh+OQ=
Received: from BYAPR08CA0042.namprd08.prod.outlook.com (2603:10b6:a03:117::19)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:32 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::44) by BYAPR08CA0042.outlook.office365.com
 (2603:10b6:a03:117::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:32 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:30 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 19/56] x86/bugs: Define bugs_smt_disable()
Date: Mon, 13 Oct 2025 09:34:07 -0500
Message-ID: <20251013143444.3999-20-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fb85e9-d23c-4d25-81ec-08de0a65c395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+2GJTzSlBK3TLlpayNTd20QdGGFH3sCY93nzn/Zam54QWgedDSW0ljDArNb/?=
 =?us-ascii?Q?fK7yrkMXQ5UzVOLz5IDauoCLjFpADPoOBaFyGz5myMAEm0HPVWMixA7LKIqz?=
 =?us-ascii?Q?rSNBO7HYT0udV4xvtSOEw8IfaSm/rN2BK1xbW1obQycMj6WNgHhTltxRBJKq?=
 =?us-ascii?Q?Z+UXQERGHSyTmuxA02F6/OPlUdbHh4xPaejCwtsrhLG3GuGy91/g5/UUWYrP?=
 =?us-ascii?Q?SoWTzsTzl3SAKWOCiCptjAU1PfqRxkjRUdv/BIravyWnjK8AZU53iyXT5Sg0?=
 =?us-ascii?Q?YUO7CKXw4/YbUd8LbMevVnIJ01uigTPUkADWuS6I+FwoGCUNL3sF2KueP865?=
 =?us-ascii?Q?F20G9OpcPFGcRum8ThymgnUoxVgCa1zF3o/UIVi7/l7cUQ4USLphRVkvT5Jv?=
 =?us-ascii?Q?4kIFk22TCk97seA1PKvJiynyW0oUOMSDs94JGBO2NerGmxnNnIDlfPfZ66Oy?=
 =?us-ascii?Q?Eo+GdoooAMO7eW19ByEzchen7hIZ1ZaBk/bSV+7vbqtmpnDB28EMTdBCO704?=
 =?us-ascii?Q?eXexIgOajQoy32H+wTqNGEjfHFLjeaoB0V7cSP/UUe7UudoYCkHM7aK8PJq5?=
 =?us-ascii?Q?85Z7H409FG5+CfUvzMkaTDgDI1kxnSQMUoPANVbR8QrfNt6JoMUDMk3P1tfQ?=
 =?us-ascii?Q?TVzS58A8pqAFq12EMJyv9ykjzoTc7HdhDql52l+rv+gMD8Scch+ZeZAbDbVk?=
 =?us-ascii?Q?RzJGQXBmiPTdpyWDLbMdjPPNzygCHym7SUyBts8EB/2UKNarM8MBxmrI3Vaa?=
 =?us-ascii?Q?GmDBq1gbfp+vGaf174SkuYJV2MiL1OSMqWrIWwfH04Gtjv8QRHg5DHulstl5?=
 =?us-ascii?Q?LhZZlFcb16oaezNs0InzwxiabU+UqhlPGy5ZhJZGzknL8/jwvfbmc9L1CAW0?=
 =?us-ascii?Q?arIzszNxjm6rz2MX8zPIxWaEaITuLLYQ4VQDY3bULOVP5DfypQxlbnfac5kH?=
 =?us-ascii?Q?Qi7kf3eDx7Qd0rdp7CDRL8R31KEqeilRSFIWbTtLFkV6DLcpvZzyG2iJY1uL?=
 =?us-ascii?Q?0gBu1H+LjZCXy8isjS5pHdvdVuaizRlGjU0jl9FEySlrC7GnvarzNIfS9XFj?=
 =?us-ascii?Q?AbUsSKrXvxdSy7H4/ofeDiN3qs1CztRXghawWtwqhzRDSHDIJuy1ceZUdqta?=
 =?us-ascii?Q?2H8z1YI7d/ySS4bgpvUNK5DUncgA6rVIWd8HKJ1ozODkXGK6BDR6aic+U1AK?=
 =?us-ascii?Q?mHx87se0Yj7KP90RIgptpY3PXynsDS/o4dKjtjKq3BXHFJeFHzVMc7Y+tfYO?=
 =?us-ascii?Q?yCSHVxCYwpgDhZZTmMxRwI+otEmoTEFO66Z/mzwXx9ErfrO34+O9VcjloYYh?=
 =?us-ascii?Q?+Yu07FTZd89Czl2vuuxZe43LpfKJFKmOsxsJmwrlcnbqmDe/WadMF8uPVLuY?=
 =?us-ascii?Q?oSDb9Vz0ufer+7KIClKnOK15pJWZdukTprNNYG1gTAa5dP1E6XD3W1t5ck97?=
 =?us-ascii?Q?WshtdSvVSTW6Z75aEXpCWMduDxc+3lzqQzTJftOt8wEs2F7F5BXenZfrNyQa?=
 =?us-ascii?Q?4XafLaUcY0X2InLoP3zEqyi4q3wwpuZPHUq0EP4KlbzXsIaMlJaQJe+BUhFV?=
 =?us-ascii?Q?sb8O4kwNi7e90RVtuf4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:32.1111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fb85e9-d23c-4d25-81ec-08de0a65c395
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

bugs_smt_disable() is a wrapper around cpu_smt_disable() which can only be
called during boot.  Print a warning if any mitigations try to disable SMT
at runtime.

bugs_smt_disable() is marked __ref because cpu_smt_disable() is an __init
function, but it will never be called after init code is free'd.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fcb1337026f1..6cd7198f7dca 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -455,6 +455,14 @@ static bool __init should_mitigate_vuln(unsigned int bug)
 	}
 }
 
+static void __ref bugs_smt_disable(bool enable)
+{
+	if (system_state == SYSTEM_BOOTING)
+		cpu_smt_disable(enable);
+	else
+		pr_warn("Unable to disable SMT after system boot!\n");
+}
+
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
@@ -550,7 +558,7 @@ static void __init mds_apply_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
 		    (mds_nosmt || smt_mitigations == SMT_MITIGATIONS_ON))
-			cpu_smt_disable(false);
+			bugs_smt_disable(false);
 	}
 }
 
@@ -671,7 +679,7 @@ static void __init taa_apply_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
 		if (taa_nosmt || smt_mitigations == SMT_MITIGATIONS_ON)
-			cpu_smt_disable(false);
+			bugs_smt_disable(false);
 	}
 }
 
@@ -784,7 +792,7 @@ static void __init mmio_apply_mitigation(void)
 		static_branch_enable(&cpu_buf_idle_clear);
 
 	if (mmio_nosmt || smt_mitigations == SMT_MITIGATIONS_ON)
-		cpu_smt_disable(false);
+		bugs_smt_disable(false);
 }
 
 #ifdef CONFIG_DYNAMIC_MITIGATIONS
@@ -1592,7 +1600,7 @@ static void __init retbleed_apply_mitigation(void)
 
 	if (mitigate_smt && !boot_cpu_has(X86_FEATURE_STIBP) &&
 	    (retbleed_nosmt || smt_mitigations == SMT_MITIGATIONS_ON))
-		cpu_smt_disable(false);
+		bugs_smt_disable(false);
 }
 
 #ifdef CONFIG_DYNAMIC_MITIGATIONS
@@ -3109,10 +3117,10 @@ static void __init l1tf_apply_mitigation(void)
 		break;
 	case L1TF_MITIGATION_FLUSH_NOSMT:
 	case L1TF_MITIGATION_FULL:
-		cpu_smt_disable(false);
+		bugs_smt_disable(false);
 		break;
 	case L1TF_MITIGATION_FULL_FORCE:
-		cpu_smt_disable(true);
+		bugs_smt_disable(true);
 		break;
 	}
 
-- 
2.34.1


