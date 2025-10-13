Return-Path: <linux-kernel+bounces-850726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F00BD39DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31A718857E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC7D30BBBE;
	Mon, 13 Oct 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WXu/bGe5"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D830BB84
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366139; cv=fail; b=qWdLPabXiCDbAnnPoWyN9nfMvTXtPULgQVDOo64l6tY0zA+23Au8oRVis0svzIjzW2dq6QFX5nncYeJAUPw6WU9JHRhW652RaOWl+/gNaw//S8PWR8ohx5nzoH7TDhiyad8GW4Cv7X63WAatR2DIx0ZAceSmERvR/GjILWVsQEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366139; c=relaxed/simple;
	bh=WtTT7bXpDetGIyQYViOqC5h53z5JAq1np5xCb05/sGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWfGL2ZrdVHY2Dao5GkiSava4vK7ZyfdBIUukFdqLYA54kl3kAE93oX1F/gRXOydExi/s943BXTsvntgE1LwWV9YXIORFey/9/m2vvLnH2xyUK4Wlx9iRxYqZCAfmwx+CjgM5giFiIwaOiBulLRPEzFmh73oLFW0yB+oYxzq4MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WXu/bGe5; arc=fail smtp.client-ip=52.101.52.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXcIcoN9AF1cD1GvuVvNDJ8bM4eFlByEGtYPqOqwoCK5q/A9gCX+eolEu/qklOObZQeai+VIxTUc5Kyrn0Thg/XsidsYkwxTW0VwvwDxlWLODxLdIod14/1RgcMsh8UHS8s764upB7/h8CEUq6e3RhSoZY4zJttBeXAtgQtPlct9IpCJGRRymCQcjwu3vEhGlYQDnnjE5TsGg+5laMYO0jm6xygT2C84PyyqPL6savY3DghjjkB1w1BeV6P1Klew5mttx9dRTrmZFJFXuSmpd/Ft/loije1AOlQADHev1prWgUoJbcdbnxQ7Q3q05FGJsT5MILUQcW4byO9uUDX5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF2Yd/SLma/khcJPVqowYBMVrlGVefNscPk76loh3lw=;
 b=KyzjcZj77Zyd+ikppIqmPDqr+/8Pcp8aclQSjoX+qfvVWGv1+D4HaECDPZskJxzi3I9O2WAdYMoD2vGFV17IaYA2CYtqvpsaIQekutTtr+fRJSdD7Ong4ISgmK/T6JFV8hXbvZj5vjQJAsEjDjgKl3GSnI7MTw+giP8iNZjBwU3YFWSkiD4sRmSSCqub19gFUX2fi9Hd4sWHkGTowjpdGWSNBjHyf2ehrRm+Jp8lkDVbr0hZw3wPtuR7MFXXkeduqn+Hwo8P2/zu2Qrh2XWYW/b/M/1YfPogtc/AWx7BbNOKbkmgGagUaC8PMM526F1f0KGvdWX1CttpI6IBNosEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF2Yd/SLma/khcJPVqowYBMVrlGVefNscPk76loh3lw=;
 b=WXu/bGe5AoxC9MeChS5hWWTDaRnyZOz0AVa3N+GrscNl6H8G2U9XC+v9eM6jWjWzFEsQT7aNlQ5PoU9wjIAih2n8nHh4f5VdLnK9FCXaPnAT4MQVWLF8yfa7tuEz8AyfS5dUEfYbuRhjFj/tb+mJuCgw+ZGda79ldaLzFAsZ+uI=
Received: from PH8PR02CA0044.namprd02.prod.outlook.com (2603:10b6:510:2da::9)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:28 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::75) by PH8PR02CA0044.outlook.office365.com
 (2603:10b6:510:2da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:27 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:26 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 14/56] x86/bugs: Reset GDS mitigations
Date: Mon, 13 Oct 2025 09:34:02 -0500
Message-ID: <20251013143444.3999-15-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fe5333-decc-4f2d-3f97-08de0a65c116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UWZZSN2zW4VdrYu8ZUErpfjZsS9U7UiM98OY5bx2dOKZU5oo3bFEvU/Iue30?=
 =?us-ascii?Q?4Ak/NmxNOUdpEBlIGEozADGl8u9lNFlujKdzUlcWhbCIaHj08/iLBUNTvxX3?=
 =?us-ascii?Q?q5idvdjFqxxdR47iUSG6ZzuHzujAjkukJTg1EDffllXoy+Ntp/3N06KITPR7?=
 =?us-ascii?Q?DSl5ec9o4X8IU+jNl01yCGS8s1qMPZwZxPbQIORKI/f7iRmjOLnVk2H5BwHw?=
 =?us-ascii?Q?3BxwIwvHS1EXKxrC1IbcY7OR8yJLUamABaMSaoAQc5U6piFHo/RFiXnX1/9m?=
 =?us-ascii?Q?xsff0Jvnys3/vK0nbdcQq6wbMZVm399dWmOQAr7znDq2aR7g90IPhOZjuMw9?=
 =?us-ascii?Q?vDn+/wPyghe/0zQ3g6fxBBvKQdjlzG03ZgKr4FESbHxLZYBtYuX8rSNAnz2V?=
 =?us-ascii?Q?z06dQukNIe5rwv+Q5C420JQ3u3LX08Jo7Ah86f6A/Mhj0IfSUx2Wrf/Abe71?=
 =?us-ascii?Q?jENlC3NKlacw5814DbKZMSx9GuES342k9vi0S/YddTBiUFH7AP9wT/pZFShm?=
 =?us-ascii?Q?YWnlp6RT6SKkEf0ub53ZbMJoqS5xXfGZzDa9Ow0HFdJ043eVzqJwz2ThLxGs?=
 =?us-ascii?Q?KxOVgDsjcKsh/O5Z/FbEjslH9wQ8VjC+/FZyb1xce08XxEZaKONsiIJNVa6X?=
 =?us-ascii?Q?DSZxtbsAKOYPT0WiR+7+X2YzYofsJqy8uRJwMIl9DGYa+DQJGhjzC97aIaNf?=
 =?us-ascii?Q?3OyuGx9EtZ06jsVSgctLsh/ydQ+cXCN1NbGzA8mfgtxKE2u0lofUhc06XVHD?=
 =?us-ascii?Q?I9zwjV1/d3ZHv3BMssVt1iHZWdnXPBXP711ppHaio4AK8mT518KsSjm9PSfu?=
 =?us-ascii?Q?6YGSWXWblGWGXt4EBCrGDEHohP62Og7ZVMIALe47U6hFbvYmGdB8acixJI9y?=
 =?us-ascii?Q?6Hn9PRgCBCB1S2/aZcD20FEcRHOrQYfE3ZMMcweaBRYoixoSELV1Eb62jzCd?=
 =?us-ascii?Q?crDTnhuL8O4xHefggLUuK/bk5s6MCdD4syvVs0NjGWXebAgjdcx7pzX9/36J?=
 =?us-ascii?Q?6bEmQntNifBulLUOEcZuKB2UGYOuy0/d8DBy00XAinns0v5HNhjkiJsNIBEs?=
 =?us-ascii?Q?q7n6NZi5ceKSAUatHvRssY+FNUH8ms5SiUSRYDh2FhaQ8HffXDpvCmIFwmNz?=
 =?us-ascii?Q?CiM1bc2GV47WFVy++7hboEK+/TVu0blsaKLM12MJAryz++2AmPcUfdfheQ8L?=
 =?us-ascii?Q?cx1ofKN5XiO5ARP/8ctyAXFHnZoa6sHv8ancwgwE+JEBdvjqD+EkH7JKSO50?=
 =?us-ascii?Q?vM5OsGc+8u9vUe28oiJiXa5mIs+oBhQMq1eUNB3/TlmErVu7S7t3JZDo7gPU?=
 =?us-ascii?Q?1al/yrKLndPWNJ1OjY+HOFYEd+BaLFlCK/cH8DO6so2rbpy0/oCrgqBOU1OY?=
 =?us-ascii?Q?B2b2URpBNvCzljVC/gz9Ovq/ZujDIapRwkFTtimiL3jRHcLknloRSPIgWMt0?=
 =?us-ascii?Q?jy3rWJf5FvKXSkLkBp+bdyNmn+IRi7Lr6plDRJ/xYukIVROE7XAuj0yfwCf3?=
 =?us-ascii?Q?0RHkYcI3TZmFGGcY1tw5T9KiTgKqHdKv8o348MV68oEEyC2SluaNEOi6g4zN?=
 =?us-ascii?Q?sPdpVvZLJylhYCuDJ2k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:27.9966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fe5333-decc-4f2d-3f97-08de0a65c116
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292

Add function to reset GDS mitigations back to their boot-time defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 112553058ccc..e765ac0b9240 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1182,6 +1182,18 @@ static void __init gds_apply_mitigation(void)
 	pr_info("%s\n", gds_strings[gds_mitigation]);
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void gds_reset_mitigation(void)
+{
+	/* To cause the MSR bit to be cleared. */
+	gds_mitigation = GDS_MITIGATION_OFF;
+	if (x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)
+		update_gds_msr();
+	gds_mitigation =  IS_ENABLED(CONFIG_MITIGATION_GDS) ?
+		GDS_MITIGATION_AUTO : GDS_MITIGATION_OFF;
+}
+#endif
+
 static int __init gds_parse_cmdline(char *str)
 {
 	if (!str)
@@ -3941,5 +3953,6 @@ void arch_cpu_reset_mitigations(void)
 	mmio_reset_mitigation();
 	srbds_reset_mitigation();
 	srso_reset_mitigation();
+	gds_reset_mitigation();
 }
 #endif
-- 
2.34.1


