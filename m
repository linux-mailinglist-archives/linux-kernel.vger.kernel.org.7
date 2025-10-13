Return-Path: <linux-kernel+bounces-850733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB1BD3A59
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB2054F47C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAE73093B5;
	Mon, 13 Oct 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RTcl7sOq"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB83093A6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366156; cv=fail; b=ZAPmv4hRY+sX578HbuMHK4ug0OgNjBzyRXufMhx3Rl57sxDBaCIBaBNtrFR102WYZ8OpisdaUT5MCuOPSPuLfHFfDcmJHs6z7nYdQQK4eXoTzLIedYI7udOo/XAQRwoL6h57T/lncrh07X569ujtSWXSJOib959zD1LtpOc+1oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366156; c=relaxed/simple;
	bh=roGvSICHKb09UTLR8Gp6FPQ2ycX1KaXDM3mSkIpAnUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6+wdK9PwDJF+MRM30xDI/TLDvSFjJrnYlidapPJ6WsutiI7/UjjT9DF6/h7rNsyGDfnTEToyvxuzR0Wm8sSY6EDJ/l4hBDZpnlWnAk4pi81R1K8iiMWZNC8glMfOoH1ZsFubTzQWVk8z2n6DefSa+XD5iT7BpzGwTGPHVv5G20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RTcl7sOq; arc=fail smtp.client-ip=52.101.62.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhXzL2TUbxuOSxRpaNgebYfGu4C+1d1plXPZymm7tY/fyKdzrf24+Pb1WieJeT2a+G4y7YtGe8AqclwFAroPjJSpuQKPytM3FUQuXY3RFtACI1/IzRKKd5CqFrGgxuCD1nQhAnQr8+UkJkN6s/5e9/qEGVHp+v5MR0D5Q/BryZrE2NdaIdrLjmXydRQo5ZEZdpZrrZp2qxo5kFkt/+bpsMYd4liwWEj7E9Yj0Z4sGbKSfqO2aFQ7Ha1U/imSXny0V8JshQz8cue9518RsGGZLHWTAfFr42DLBJ0ZPvEQbWyxCpXlXI7cgIcsrq1NWaNQ8BB8L/0KzwkK+Q2yi08gug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3bEY+uzZFDqWDZmwyJ0RMagUu6W25UCPXJ6SlvOH9Q=;
 b=cwdGSKi2XJkcjRlMJMDQdww6A/ZAY1Vlavd+mWlPKr3JkDbqm01xNA6bztj0PiNDqFzhq/t4dU9hD/ART+pbL5jfUfIeD92C/KXsV0pasHHEjeBPajMhFADVZ6k9191Q8TkyECDIJOt0GjzhjQ+olcNxSFiOB2KqqfeKMnwKBM1CIVJ9clSLH5j2JO/aALNZ1HhQAYcY9on/8G7Umpnah25s0AkhzUT7BHHV6ZF2IfCsrdpXMgwrh8TQzZXjDAvePUx+WESC+q6VQ0FP54r18nnu1B9dN1Yesk0xjahkfwUR5BuLVW+KL1PLFbqPhRZjHXbdc+OoLLOD/jSYD1PvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3bEY+uzZFDqWDZmwyJ0RMagUu6W25UCPXJ6SlvOH9Q=;
 b=RTcl7sOq1mVSnE3lFHo0Wlg12dqKqCRUD/xY3gt8D8ll4siNtnzYQOVh7ii2TRuxZAThyZJh+HrQKb5P0euBEKYMnbtVcUejBdFmtVKD58BL+ejPQU52Xbujbtfw4Ab5B1TAR5K8GJCU2Tj00scgLzFPXALGH2o/uVcZpi2vvwA=
Received: from BY3PR10CA0011.namprd10.prod.outlook.com (2603:10b6:a03:255::16)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:49 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::f8) by BY3PR10CA0011.outlook.office365.com
 (2603:10b6:a03:255::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 13 Oct 2025 14:35:48 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:33 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 22/56] cpu: Move mitigation logic out of .init
Date: Mon, 13 Oct 2025 09:34:10 -0500
Message-ID: <20251013143444.3999-23-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 2761bc01-50bc-42a0-9fb5-08de0a65cd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z5N78huy3z05wkmXoBBp4K4T+jQcGYoY/f3aLsFe28wtBGaJJCNqq2dDYBz2?=
 =?us-ascii?Q?HmXpWNrpuYtslhE6aXmBGytM9j0Ze8O1eN5lmUYVreV74tdUvyRrHErr4PYm?=
 =?us-ascii?Q?zX1n1+MerBXYFQByIoDZ3dxekblZ02A7rL6f/uEiu2hxAV1DoVYsJ6rEEoSh?=
 =?us-ascii?Q?+Lo73817DHuJm11Vs+4goJCFfcNLpH63/GDQn5Qp8P2nFiQDEH+Dd/aIdLkn?=
 =?us-ascii?Q?d2+xsoklo+SUMFaFLmbqwGKkzP93MQkc4A9RCcLbHJIWTTa02H76hTDNxBZ4?=
 =?us-ascii?Q?0qBAyVdeikNweOsO9i0jXSjcuFlgHtKgcOqOGa2skKS3t48dISS4PhYqazn1?=
 =?us-ascii?Q?J50xhbPeOv3s7LzzDodVw9GT6/5vSZjrASAXutftkYjsDhlrztVTi7sFQG0G?=
 =?us-ascii?Q?d0rpDxTil70fBeUwlz5DUkI5zdWOjKu/r+xnWiB+k2xNUWmlNlum2Rnjz/m/?=
 =?us-ascii?Q?836t23ka/A+ST9gbGypsk8k7mrZA5/ABTkjV8EY9Oz4l7/5hxgaxE61YYSqM?=
 =?us-ascii?Q?cz2NwXQTBul+LneVASZWqihmx2tZVzjCL5UjzgXt0b0SADlKc7lWB2fHsATt?=
 =?us-ascii?Q?hXfC29vGV0ByIwiTTiK5xOBmngEUUH/ajiK21Bkwu9U5Nzv2WmzFpo9mCF2I?=
 =?us-ascii?Q?G3efx2nFKbWhitCHKQgCI5iBcIPnYnHh6g+Ngh1bTm95C1l6hsN2k5dOHNun?=
 =?us-ascii?Q?Ro3e2U1R400v2HKO5hsmrBmbSTiDzJaXunb126NLteftcWMi2vvTR2OX36Q7?=
 =?us-ascii?Q?GM1Xjmc+ynTw7dQnXE9nEGLx7WkKWlo8tTlTpmNRSGvByXof05+SkB+exJQy?=
 =?us-ascii?Q?O64Y54n8Raeeii+00P0IxI/nBaOsGzHqnW88ZZCkD2z7hwSuKHz67xzHJJct?=
 =?us-ascii?Q?DCNsQu3d/3DJ07WJ64onSNe0bfdGAGCFk/RjOyUauL1w8Mlcj9gczyyvXNM5?=
 =?us-ascii?Q?yO+X21aFT/J+XL/VyhKjYasvxtNvzkiKpdML65JuiOYhBQYubj0gjeOoImrp?=
 =?us-ascii?Q?6TZN9mFuOI3EXhxop702YklkfiQgj9SeQkqqQ2+BZxL9E/+GLRDTL+neHDLS?=
 =?us-ascii?Q?WluEd2isYApRrqtZVVrflkwFiztKVO6QdU3s0k1WRKAx+MyTH+wBmPEsERw6?=
 =?us-ascii?Q?/CHrdzw/t03zvB7UxM62SHRRD8Vyuu/3UD8PpJtO8Z/KrCIdrAePt645AkjP?=
 =?us-ascii?Q?gY8P0poPU7rqq/txQvIQuFy1+6WlWvg8c8LR7AVf8lhkb0dm3iSSCzRDUBs5?=
 =?us-ascii?Q?aFHiUmy28L80HB5wvaKw6piTWGfE24PeMhkeRinL1rLfDbHvSid9SCIGvquY?=
 =?us-ascii?Q?IsIHKv/YifdMpnqWw/nUQXc4MPYjG7QNesK26qzpIDxGqh2Z3dr1ClVjOcuE?=
 =?us-ascii?Q?GIsv8mfmHrjD8cyIBnUrTXxTgzrESYZS/sBWDiGwfKuHoRN+us+n/Wqq3wmS?=
 =?us-ascii?Q?HL5TYIjiYBSbDyEtjhgqzg4M9fdCrCxtlFHz8t1fuFWw2xkb4al37t5EDUun?=
 =?us-ascii?Q?S+wB/E7DbkdcjVw1cDt7BXAoaWxXt32HcCioBs6yk05AnkHHbLd8vnV/hU2B?=
 =?us-ascii?Q?CKRCCxocj7lpog8E1DI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:48.9234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2761bc01-50bc-42a0-9fb5-08de0a65cd9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335

The functions and data related to the global mitigations= option may
need to be called at runtime to support dynamic re-patching.  Move them
out of the .init section.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 kernel/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 910249f6217a..33289405af30 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3180,7 +3180,7 @@ void __init boot_cpu_hotplug_init(void)
  * Guest-to-Host and Guest-to-Guest vectors are only needed if KVM support is
  * present.
  */
-static bool attack_vectors[NR_CPU_ATTACK_VECTORS] __ro_after_init = {
+static bool attack_vectors[NR_CPU_ATTACK_VECTORS] = {
 	[CPU_MITIGATE_USER_KERNEL] = true,
 	[CPU_MITIGATE_USER_USER] = true,
 	[CPU_MITIGATE_GUEST_HOST] = IS_ENABLED(CONFIG_KVM),
@@ -3221,8 +3221,8 @@ enum {
 	NR_VECTOR_PARAMS,
 };
 
-enum smt_mitigations smt_mitigations __ro_after_init = SMT_MITIGATIONS_AUTO;
-static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
+enum smt_mitigations smt_mitigations = SMT_MITIGATIONS_AUTO;
+static enum cpu_mitigations cpu_mitigations = CPU_MITIGATIONS_AUTO;
 
 static const match_table_t global_mitigations = {
 	{ CPU_MITIGATIONS_AUTO_NOSMT,	"auto,nosmt"},
@@ -3239,7 +3239,7 @@ static const match_table_t vector_mitigations = {
 	{ NR_VECTOR_PARAMS,	NULL},
 };
 
-static int __init mitigations_parse_global_opt(char *arg)
+static int mitigations_parse_global_opt(char *arg)
 {
 	int i;
 
@@ -3255,7 +3255,7 @@ static int __init mitigations_parse_global_opt(char *arg)
 	return 0;
 }
 
-static int __init mitigations_parse_cmdline(char *arg)
+static int mitigations_parse_cmdline(char *arg)
 {
 	char *s, *p;
 	int len;
@@ -3320,7 +3320,7 @@ bool cpu_mitigations_auto_nosmt(void)
 }
 EXPORT_SYMBOL_GPL(cpu_mitigations_auto_nosmt);
 #else
-static int __init mitigations_parse_cmdline(char *arg)
+static int mitigations_parse_cmdline(char *arg)
 {
 	pr_crit("Kernel compiled without mitigations, ignoring 'mitigations'; system may still be vulnerable\n");
 	return 0;
-- 
2.34.1


