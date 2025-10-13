Return-Path: <linux-kernel+bounces-850741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66ABD3A11
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D72D734D3CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F630DEB4;
	Mon, 13 Oct 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UteiMFgi"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24130CDBC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366163; cv=fail; b=i5tjgLqcS7SXYLx4eTVTqAOXw/0er23yqxgztpTsjm/5mHqiIBR574y7F6pX/hy/4YcH9tT5+X6dYoRjtaGGOGLBHuIB75wd656Lbi901dudOEOM5MzqqojMny6Q/vECscVmG1FycVWIMhN5Y09UM3PQPHoFrVya6dNNayf/IMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366163; c=relaxed/simple;
	bh=CZ4PAAgqCnCFfDnsAbUxT45U/FGB7kn9MkRV/9CssxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0ngyKYzXROD/KXF4R6XB31eP3QRFIb9zpjHgb3RsOL5gU9PctYtcivEGVKykK4778flYDxtGAye9PM6jS2Dof+mWof4mHaT8FpB/6w4nyCbzriXShd09vDn5MAn72XiJdIwEIZq92QgNUlHsuZMnBg9AjEzqP0zhB7HUhokTJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UteiMFgi; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0dRrnF3T/IPLAvYWQHi3P2SQP9C/QS5u25TkDFWwwUqF6IhgmBqyFqxSL+wWXlmXku//OOzL3dGoCsrCVhmdviEZjWYEED038+Fo15HDK+jmwPWbhgWXIPRlg/VmWusuaulmk7VvhX2lYgsYB3n1uvJhL/MXReWCj2mzjE2HL7+ebMIybBgkn9dI5K7pqN6fThoaaix75bzk3EWO3MvPc+7mu4wipbsnV6Sb/lw6H7QSUVrbg729ociI90nPzhY2y39FCyuKX/PWV4jWLXyuaw6ltaEQxY3tydMaz7rh0b+TOBK6MxLKoSOcna3QU/RSHwIVlOfNMvNIc6MxSl05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JLqLhgcMXqeyQvZ2OP/8DdSU/rKGrIrLGIGn8YaO5g=;
 b=pf38nFf0dWxS7o+P8QnqbcjB2PDnZBCTTzO+j246L4WyspAzFCyFNYiwp6ConwFLgIfHGm6Gltiua5gQyLgQsUbYq7QxftDuakbiFxat1ZEkRhtx+czcNfloUOSNw939lkT+eOlujTOt+WkpcPQFIXBddEdv5a2TO60u1K97QdBccurjy+PQzkmNNu8xDD824fx3brmNowl9e6ejzDznG/fdvWbWTpUwPtgHQzzhWnw6i0U4uC9NkebCuXuRx8TtQW6CtuM0NNclD1341qm0gYfY7nuvtJv8CtQphNIXcVfheoL4NBWIbBsYALEtQmDI8/YhOYQqIHgatYwKLUCldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JLqLhgcMXqeyQvZ2OP/8DdSU/rKGrIrLGIGn8YaO5g=;
 b=UteiMFgidBwZNzhLHrY5wbK4SLXDGwa+fkTK/VKfnIya+mxhdnAgeC5vg11CTlZyZBF/WlJxz7pI14uRGzTCt95+cq5FEQKAQcCnSeGmj3XD3C6eCJUz9o6rTxT7VCnojk1y6xGUhSU91mnNqxqS/EJjeN02h203Puc+nXtfi5E=
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Mon, 13 Oct
 2025 14:35:57 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::4f) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:57 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:41 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 33/56] x86/alternative: Avoid re-patching init code
Date: Mon, 13 Oct 2025 09:34:21 -0500
Message-ID: <20251013143444.3999-34-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3144ed-c785-4a2c-2003-08de0a65d2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nfmhyvMnQqwJlGSuJydzxDDNfEKVJlzHmckMA+1yoih6wGvfVjfpJPnPL0G6?=
 =?us-ascii?Q?lrPzGILZuHJk0jy7060mUN2+wguITuwrxVrrmetH2zirQvFXIHFGx0p+7uwr?=
 =?us-ascii?Q?KsiEVM7vmFYEyRQLd9tuRLXmIWPHBF54dSYpaWHf4KYp2qmCTcYrcCx2aUTP?=
 =?us-ascii?Q?z+hApHo8Z5UXOcJd57iMi7kEaSp5y37nuGJvpXgVELKC3N8q1eq1TSlNXfSd?=
 =?us-ascii?Q?JUKdnWKZz86wcB5UR26yaxm93EV/1HAKJZJifLkktUQnOJG/v2hcJ8G6/rJa?=
 =?us-ascii?Q?Dh0Yb4dQJA0y5KnTG4V2kqSbOEBUh8ejA8Kii1yfnip3GKOgpjPsS76+S97l?=
 =?us-ascii?Q?yrcYi10YD37tRWoeUFC+/F1FUIZNGW5rWNaqSkjRNBhc49A5Mw45mBPHnw/a?=
 =?us-ascii?Q?GxOcksZO+1F3K1E0Y7287Q2YoBr6fuhF/GXTxF/xmxof8SkW0LrP0UoF3n+C?=
 =?us-ascii?Q?+YFae4pF00ZnvNMG3+I9uRftThf7tlcyJkgaSbK+zIud3QKJewmS71JhGTPj?=
 =?us-ascii?Q?5CKu/KZOVT+I90JdSI9HFNw6sDCIg5maeRirzfbsLQP+BXlzORQ7bDEndF5V?=
 =?us-ascii?Q?805i1Tgqw2alLXVM+89NSAhJSEO155Y+C49Zu02V4VtG2Dy5lbE1jHbffbO3?=
 =?us-ascii?Q?sQI9Hp4caGV9Vl3RszqvgZcB0SmkvhMW4EKnHqbqJzetb6pmyZUbtcKHgWE1?=
 =?us-ascii?Q?aClW/AqW9hg3Fk3i10MqL12WEw4UAPWvWvcxpKyCHtdAQSEIQEauvLB/Ohv5?=
 =?us-ascii?Q?EaXzOV+Jp1XxoehG8KPTU5EspWwhAGOFLRnJH7l1PLfNwgL97PajODjQ5bhD?=
 =?us-ascii?Q?OSDsmkdoUDnprjpegULvSkYNMZCTHEx9ooJadTgGXNgsfZlNc1j5pPK3iOls?=
 =?us-ascii?Q?dPaIJrJWoth1hQ2zrPrH23w6SPKV/AW0BRJsJZKspD9TG8E2951I2jj2zCfN?=
 =?us-ascii?Q?Z5XHEeNyKtgmefFavEvgo/+n8Z27VshZ06OfrSj86+VEQbJYy8yxUo/QTD2l?=
 =?us-ascii?Q?wAFeFtvgOPbRNFHy1l2O9Ti5PMRGb8mLYdiAnwfTQZVbE9ArlTpQSgLG8txR?=
 =?us-ascii?Q?UJpLzejzqeCnBdD1onjGgX+3LjQzK8qINdTRiFZygwCZzGtNunGLQNlhQDEU?=
 =?us-ascii?Q?X7Bq0SRA7BGjC99Ax+H7fLzpRTwQ3bOJvEj+3RD3uYIRjaZMuKvEr1M7fzUC?=
 =?us-ascii?Q?LwtTMwqWLYF59F0k7OYxdk49LqbBGV4cmpES59YgJpkGOOOUtUh516sh4qFL?=
 =?us-ascii?Q?mTTdeBbQCOs869C52C6rl0vOulUTxVMWowqHFABbaceBdmE4Akot0Vu4Yuba?=
 =?us-ascii?Q?uSQq8IYj8cvDz/B1wS6GxmAurD/RpwT5jn4GcGHgQ22UJnTOwMJ0xi+SCqrg?=
 =?us-ascii?Q?dV1kRM9xLkN2fRk5Bk3JNZUJulPDU/kqbsiGZYX5PpOZBlj9oh7AhvVdhRPi?=
 =?us-ascii?Q?7vW05Xg8eCjrE3XGXIybgaxACrpsKzsfIadn8e48bV8Bqeqwp2hwOW3xIyDm?=
 =?us-ascii?Q?jCPCGuN/KSwXHj11PUtAGa7i/M/i+tLJ3GMnvAKI9emUEOKQjZrXESdN5XeP?=
 =?us-ascii?Q?3G2LbdalAfcjRlkwnCM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:57.3865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3144ed-c785-4a2c-2003-08de0a65d2a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662

During boot, all sites should be patched but during re-patch, ignore any
sites that are in the init section of the kernel or a module.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/alternative.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9fbec219e98e..a821ea37fc29 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -298,6 +298,27 @@ u8 *its_static_thunk(int reg)
 static inline void its_fini_core(void) {}
 #endif /* CONFIG_MITIGATION_ITS */
 
+static bool __maybe_unused repatch_in_progress;
+
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+/* Do not patch __init text addresses when repatching */
+static bool should_patch(void *addr, struct module *mod)
+{
+	if (!repatch_in_progress)
+		return true;
+
+	if (is_kernel_text((u64) addr))
+		return true;
+
+	return mod && within_module_core((u64) addr, mod);
+}
+#else
+static bool should_patch(void *addr, struct module *mod)
+{
+	return true;
+}
+#endif
+
 /*
  * Nomenclature for variable names to simplify and clarify this code and ease
  * any potential staring at it:
@@ -658,6 +679,10 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		}
 
 		instr = instr_va(a);
+
+		if (!should_patch(instr, mod))
+			continue;
+
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insn_buff));
 		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
@@ -986,6 +1011,10 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end, struct mod
 		u8 *dest;
 
 		ret = insn_decode_kernel(&insn, addr);
+
+		if (!should_patch(addr, mod))
+			continue;
+
 		if (WARN_ON_ONCE(ret < 0))
 			continue;
 
@@ -1092,6 +1121,10 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end, struct module
 		u8 op;
 
 		ret = insn_decode_kernel(&insn, addr);
+
+		if (!should_patch(addr, mod))
+			continue;
+
 		if (WARN_ON_ONCE(ret < 0))
 			continue;
 
-- 
2.34.1


