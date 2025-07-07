Return-Path: <linux-kernel+bounces-720357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 701A2AFBAB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFBE1AA250A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989F6264A84;
	Mon,  7 Jul 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TCjBCd3k"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5214262FE4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913217; cv=fail; b=UAJkIsKKmJgQkJOBBRNknVZc4Eh33rZaNtEQ8H6BQEotcTvJeGGnciBbJcEDbMkIRzSEePy6n7ignMdyf0sMZzRKR88fBf7QoAkDW9RqBC+LlF9jfcp6/ZYsd/EnpCVNlsW0BdizqCoayu7JPGdKXqcZnVxvev9gHD8ahNxVi9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913217; c=relaxed/simple;
	bh=VbbPgicQP6feLUHj8ejcgZ8wOOSCIvYAKBUFxfGD2PM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pansHSvep10+2iXF0GCHEDp3A9kIN/jA/OmRXeLdiBzW7c3M31YU5RBaFzZRgdOkLiXa32SlpgU1OJyz+p4k+jlY48UWJLr+ISIJOUPxOjAG9dnSLs7RAH7/QXDSDrHPkbUolsX+NyDx9Ag5DrsikvGgnfPMWpjKLMY8mopiDRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TCjBCd3k; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IadtWJOvxojGyWKzM3KLtvjP609EPMuHYNvqPV7Se9GuMCqRZQURhkBM3wLu/+BUm6lyHVRNAArz0yNE+a9A+HBFtBZ0WHvLbsGeVFmoiIEYbaD2RTrl32y89JgcEBO1amApMEiDx/4+WW6kiBEvsfHGvulTU8SDSuQVfqSLDh1CM/UFCpt2URpgRaSJMs2EIySHWrOMn8WVLVnNMZoTmC3MW6382fTjNSkFSnYWn4DlBgacUKM/rft+D9iVfjeFaxlL/0SRDk3rkNssvifeAN35y4Knklx9qFVZs7HMXaluDy8jf2vpI8kpSUybHc925pAMdPPnaXl6icE3bF6P5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biP3yBSLiRcHxT2I9ygIlfFb+nJAl0FhRU0N9HKmJWw=;
 b=pIod3bKhiMd/9jzUhL8/qlrfE2VDTc++rV+6ZSfGtJ61kw6fPiqGDN9K08tGBwMTPrK24Z+FMewZ9neoQ/gV/g0U5NXdBgTZ/r15rdQ7OJVJQ7KXqz3xMVcwYBqYk1qgxhm6UD6ERDOW3ypmROklP4kayWYU+hc/WPlBTzRm/Caq8rcqpo0Sd8rNMGfUOw7VqbnZjPN1d1sM1y15KW22TUaPsyUe1zxmrMDFLws0kptAhn8eg6LuKixL2PFeWdNyuk13/xGNB/zNmKwKUSPg+Mhcrotyp/SPujkBx/rCAh0OwIbiAYeCPDB/rA5mFfGznRFoTddSBlx3MBJVjdOanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biP3yBSLiRcHxT2I9ygIlfFb+nJAl0FhRU0N9HKmJWw=;
 b=TCjBCd3kRr2hqSIouumDwRWKQdWNLseawwrfQMmOoeePqupqDgIulKMlghjkFu7YJ7BGzFk5qi7f4EF0nhr87F6xRixPFI2fbWTwjXXtgM7PZO5q6XQVwRJaro28dPEuxmuHik2vq5TWXaJ8NgxK4D3ZcB6B4tgtkiah1gtLT4Y=
Received: from BY5PR16CA0024.namprd16.prod.outlook.com (2603:10b6:a03:1a0::37)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 18:33:32 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::af) by BY5PR16CA0024.outlook.office365.com
 (2603:10b6:a03:1a0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:31 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:29 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 02/21] cpu: Define attack vectors
Date: Mon, 7 Jul 2025 13:32:57 -0500
Message-ID: <20250707183316.1349127-3-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 104f3826-c531-4181-9aed-08ddbd84c662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wb+Eix5FcMSA2efwxO7JCfRonvvOCdq0IzF2+X+VT4NUsUyjN2DZsKwqGEfF?=
 =?us-ascii?Q?wmdPJlwkKt58ERjpzVUzIaJOJCIZWVTukov0eCoSWpDQjKZPX7UycQ5ZVkoC?=
 =?us-ascii?Q?TojiBo+D+RAOCm5/k+QU4joGFkfC0C3Hny1HgrwL13IEW/qDQUEoTzagIKh1?=
 =?us-ascii?Q?SaKgB9HQtfoCBQyr+QozO8DTvMC6Xlpn/zmCMeEbz/pKI+tVt9bhoCL+l5UW?=
 =?us-ascii?Q?LhueKIS8R4dWiCrDFSBNs048tIEqCgW+UDTb9w6l2s3U8dx9VtadoPkMNuTt?=
 =?us-ascii?Q?FryBC752n9+51Z6YZSHr5y4Ho0tic5TO/wfzlFYtxfJnoK9JNpkyheZUZXO6?=
 =?us-ascii?Q?DxvPNX+BHAaQmgBlOMpPoxQXTy2EUQkipQxTHd2FjM+DeageOYeEWQDRJf+B?=
 =?us-ascii?Q?HcvQpqMDhROg3eu8OiVPadfvEUe9oRv4TLTjaDTPgscsYeF6o8RIOHPIQYZ/?=
 =?us-ascii?Q?XDebJ7YPRS2TguxZ/fi1hLgA2Gps92KfnoG66OWXc7ba/44QbgSwLesPb2lY?=
 =?us-ascii?Q?PngZbi8ASGroKJSrdZ4pxK3q1/gWyJ3fNcbi8Xs8ByUqZZzfh4+vAwLxTAVq?=
 =?us-ascii?Q?t47RJVXzCeN9HnUrS0rAkGxUk5iOEq0LnEHBH4sfOvBc7nqIryjh4YiyllZd?=
 =?us-ascii?Q?axFfApihbxzgQvCOfQbADxYZgakiB4WhIGj+Bg8GQJ3CoeuYcqEwxRsCbPmL?=
 =?us-ascii?Q?iaHkSs9OeQ5uDbO9tXzMVAw94fsqxWJjjTc/B64F+YUcrUwtzRmm8oIcr+QL?=
 =?us-ascii?Q?WdpnLGgZ4xHshT19hXG0OVVofsJssKP3AStoUkGSbhOn7ZZV11CWKcNVuQxx?=
 =?us-ascii?Q?HbiC1kPaMGDjHhQjWNKYI5ClY3qy9ObIhCbHzTQP8PF8WiMS2BjjJ+Jw5Cbp?=
 =?us-ascii?Q?xlIfnslxbjnVUqmKmKYks8ggCZ81dIRHyJuGh4OC5yEX3YhURW0zAlnz9K7p?=
 =?us-ascii?Q?lpRKQ2mOjnIYCh4D50i1U591dQFqtARrPPcCVIIIYFkmtDOcytIM2rLTaqlI?=
 =?us-ascii?Q?QbCgntG/KCz9D0qff6DORT9D6ooNQgCITyQL3l7z/oUSMQy+71zS609WWSGg?=
 =?us-ascii?Q?Kxz5+L2O/THO9k0exr4iSFbXoYLBjI0iDP44a8svc5MgEs6yqW/5gG6RdSmr?=
 =?us-ascii?Q?WUhfMsVZr8q6D95Z5Vbx6SQBaLlSGV/L/DIG5GFfVsjeoPTFCrF5MAJHgtxC?=
 =?us-ascii?Q?kw7z+Ecdsyh7aP46vygSHKZoBYVGvNA9mikX8SjCJaHkympK4Wa7tSJMjubk?=
 =?us-ascii?Q?YcBsCrR/x6NbX7AXpEyvEmo1vgk1xnu/6xs2PyrtR6eyaccA+VDsF87sUj6r?=
 =?us-ascii?Q?RxF0S1i0qGkUogzNT/e4YqSZpOl8ePHZ+ipB9IlAV2ZgUbhR3XG9wSKUirCh?=
 =?us-ascii?Q?+X9gtlGvGq4nbZpKI9fyXuHKaqwcE0AsPxvQOoH1DAbFc1AeSJ1+/YO6G4hN?=
 =?us-ascii?Q?04qf0cZiAo0/1XFVJPOEBpKHKJw8PJ8XfUw/9qODj9juKb4+fBEa3VnyzhIb?=
 =?us-ascii?Q?luZklZszUMYc4xxv15vh3KysBwrcXrRZycdw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:31.6811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 104f3826-c531-4181-9aed-08ddbd84c662
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571

Define 4 new attack vectors that are used for controlling CPU speculation
mitigations.  These may be individually disabled as part of the
mitigations= command line.  Attack vector controls are combined with global
options like 'auto' or 'auto,nosmt' like 'mitigations=auto;no_user_kernel'.

Cross-thread mitigations can either remain enabled fully, including
potentially disabling SMT ('auto,nosmt'), remain enabled except for
disabling SMT ('auto'), or entirely disabled through the new
'no_cross_thread' attack vector option.

The default settings for these attack vectors are consistent with existing
kernel defaults, other than the automatic disabling of VM-based attack
vectors if KVM support is not present.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 include/linux/cpu.h |  21 +++++++
 kernel/cpu.c        | 130 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 140 insertions(+), 11 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 96a3a0d6a60e..29adac00c6e5 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -197,9 +197,25 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
+enum cpu_attack_vectors {
+	CPU_MITIGATE_USER_KERNEL,
+	CPU_MITIGATE_USER_USER,
+	CPU_MITIGATE_GUEST_HOST,
+	CPU_MITIGATE_GUEST_GUEST,
+	NR_CPU_ATTACK_VECTORS,
+};
+
+enum smt_mitigations {
+	SMT_MITIGATIONS_OFF,
+	SMT_MITIGATIONS_AUTO,
+	SMT_MITIGATIONS_ON,
+};
+
 #ifdef CONFIG_CPU_MITIGATIONS
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
+extern bool cpu_attack_vector_mitigated(enum cpu_attack_vectors v);
+extern enum smt_mitigations smt_mitigations;
 #else
 static inline bool cpu_mitigations_off(void)
 {
@@ -209,6 +225,11 @@ static inline bool cpu_mitigations_auto_nosmt(void)
 {
 	return false;
 }
+static inline bool cpu_attack_vector_mitigated(enum cpu_attack_vectors v)
+{
+	return false;
+}
+#define smt_mitigations SMT_MITIGATIONS_OFF
 #endif
 
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index a59e009e0be4..be25543567c0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -37,6 +37,7 @@
 #include <linux/cpuset.h>
 #include <linux/random.h>
 #include <linux/cc_platform.h>
+#include <linux/parser.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -3174,8 +3175,38 @@ void __init boot_cpu_hotplug_init(void)
 
 #ifdef CONFIG_CPU_MITIGATIONS
 /*
- * These are used for a global "mitigations=" cmdline option for toggling
- * optional CPU mitigations.
+ * All except the cross-thread attack vector are mitigated by default.
+ * Cross-thread mitigation often requires disabling SMT which is expensive
+ * so cross-thread mitigations are only partially enabled by default.
+ *
+ * Guest-to-Host and Guest-to-Guest vectors are only needed if KVM support is
+ * present.
+ */
+static bool attack_vectors[NR_CPU_ATTACK_VECTORS] __ro_after_init = {
+	[CPU_MITIGATE_USER_KERNEL] = true,
+	[CPU_MITIGATE_USER_USER] = true,
+	[CPU_MITIGATE_GUEST_HOST] = IS_ENABLED(CONFIG_KVM),
+	[CPU_MITIGATE_GUEST_GUEST] = IS_ENABLED(CONFIG_KVM),
+};
+
+bool cpu_attack_vector_mitigated(enum cpu_attack_vectors v)
+{
+	if (v < NR_CPU_ATTACK_VECTORS)
+		return attack_vectors[v];
+
+	WARN_ONCE(1, "Invalid attack vector %d\n", v);
+	return false;
+}
+
+/*
+ * There are 3 global options, 'off', 'auto', 'auto,nosmt'.
+ * These may optionally be combined with attack-vector disables after a ';'.
+ *
+ * Examples:
+ *   mitigations=auto;no_user_kernel,no_user_user,no_cross_thread
+ *   mitigations=auto,nosmt;no_guest_host,no_guest_guest
+ *
+ * mitigations=off is equivalent to disabling all attack vectors.
  */
 enum cpu_mitigations {
 	CPU_MITIGATIONS_OFF,
@@ -3183,19 +3214,96 @@ enum cpu_mitigations {
 	CPU_MITIGATIONS_AUTO_NOSMT,
 };
 
+enum {
+	NO_USER_KERNEL,
+	NO_USER_USER,
+	NO_GUEST_HOST,
+	NO_GUEST_GUEST,
+	NO_CROSS_THREAD,
+	NR_VECTOR_PARAMS,
+};
+
+enum smt_mitigations smt_mitigations __ro_after_init = SMT_MITIGATIONS_AUTO;
 static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
 
+static const match_table_t global_mitigations = {
+	{ CPU_MITIGATIONS_AUTO_NOSMT,	"auto,nosmt"},
+	{ CPU_MITIGATIONS_AUTO,		"auto"},
+	{ CPU_MITIGATIONS_OFF,		"off"},
+};
+
+static const match_table_t vector_mitigations = {
+	{ NO_USER_KERNEL,	"no_user_kernel"},
+	{ NO_USER_USER,		"no_user_user"},
+	{ NO_GUEST_HOST,	"no_guest_host"},
+	{ NO_GUEST_GUEST,	"no_guest_guest"},
+	{ NO_CROSS_THREAD,	"no_cross_thread"},
+	{ NR_VECTOR_PARAMS,	NULL},
+};
+
+static int __init mitigations_parse_global_opt(char *arg)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(global_mitigations); i++) {
+		const char *pattern = global_mitigations[i].pattern;
+
+		if (!strncmp(arg, pattern, strlen(pattern))) {
+			cpu_mitigations = global_mitigations[i].token;
+			return strlen(pattern);
+		}
+	}
+
+	return 0;
+}
+
 static int __init mitigations_parse_cmdline(char *arg)
 {
-	if (!strcmp(arg, "off"))
-		cpu_mitigations = CPU_MITIGATIONS_OFF;
-	else if (!strcmp(arg, "auto"))
-		cpu_mitigations = CPU_MITIGATIONS_AUTO;
-	else if (!strcmp(arg, "auto,nosmt"))
-		cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
-	else
-		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",
-			arg);
+	char *s, *p;
+	int len;
+
+	len = mitigations_parse_global_opt(arg);
+
+	if (cpu_mitigations_off()) {
+		memset(attack_vectors, 0, sizeof(attack_vectors));
+		smt_mitigations = SMT_MITIGATIONS_OFF;
+	} else if (cpu_mitigations_auto_nosmt()) {
+		smt_mitigations = SMT_MITIGATIONS_ON;
+	}
+
+	p = arg + len;
+
+	if (!*p)
+		return 0;
+
+	/* Attack vector controls may come after a ';' */
+	if (*p++ != ';' || !IS_ENABLED(CONFIG_ARCH_HAS_CPU_ATTACK_VECTORS)) {
+		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",	arg);
+		return 0;
+	}
+
+	while ((s = strsep(&p, ",")) != NULL) {
+		switch (match_token(s, vector_mitigations, NULL)) {
+		case NO_USER_KERNEL:
+			attack_vectors[CPU_MITIGATE_USER_KERNEL] = false;
+			break;
+		case NO_USER_USER:
+			attack_vectors[CPU_MITIGATE_USER_USER] = false;
+			break;
+		case NO_GUEST_HOST:
+			attack_vectors[CPU_MITIGATE_GUEST_HOST] = false;
+			break;
+		case NO_GUEST_GUEST:
+			attack_vectors[CPU_MITIGATE_GUEST_GUEST] = false;
+			break;
+		case NO_CROSS_THREAD:
+			smt_mitigations = SMT_MITIGATIONS_OFF;
+			break;
+		default:
+			pr_crit("Unsupported mitigations options %s\n",	s);
+			return 0;
+		}
+	}
 
 	return 0;
 }
-- 
2.34.1


