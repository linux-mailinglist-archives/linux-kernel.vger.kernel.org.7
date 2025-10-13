Return-Path: <linux-kernel+bounces-850763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8197EBD3A56
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0B6E34D4C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A003030FF27;
	Mon, 13 Oct 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F1c7OtZx"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB430F945
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366192; cv=fail; b=I7WC5qP6tLmCjoR+s8ez70HvSHx4W0ZM+09ndAZzDNXvmpbuKrrD1TTKbVVXPC6LCCR23n2dySaq0rz3PGfULr5Eb1/7cug8XXGK8OCGXxA33HD1alplWhxgAZr4A5Rrm5qmphYCbsLdZmyMW1wKGDxfiduWdzyUs5Jc4mYxbZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366192; c=relaxed/simple;
	bh=u8cHskI8XJHNlzYGt4nZK+b/FPY96XclSvafYkXmyag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxmCbikgjdAlyDShb7HC5wKObEQ7KQKAXsHXualfVoXiL/nBrcAaC2NHbD8jtglFNLyVth4/g5idybJBtJa6sWl4TMt+AqGhC3KCeQciyQuoj9t2SuZP8JWG4Un6osE12Ai/6N4bHzX6XEnZ8IHK8ure9uwInaOg78kczkZXbe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F1c7OtZx; arc=fail smtp.client-ip=40.107.208.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkFJBj54xgFsRP+mjhY5nQMMPccaxDZGbIr9nfKHWT5bwVrO2o7nxuVLE4FWignfeIvuRnND8dO2AeUGzZvPPfJrQI+1zWJbwwm70i8nDyZv0OjbGUGKaqYmnjtWok3Lnfnsm/eue5jSSywoawWj+42mnwzsRD4YkKBK1UJ6ZUbYADehJie6WLsy5eKQlK2tdcD6OfHzUNxCoOw92A63kWBNLL1W6smBiYLa40Y0ouzEJJT20icyCLybdyxF0j/wu3Dc4Pittybw+BOJwmMqD4aWmY8L13M3j35sDgn9gyncsuq/gD4/zNYexg3AZilVwCZutQSxFhRi9m4TWlnyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nutwp61bpO55MAgOPyw0BDaMPJxKXGVP/Si+kQR/zbg=;
 b=FGcNtZwZfIY+7m4z/UnXf8uhI8GB1BkYlo95YXu8qUgWBRU1k9bAqGTkJd4zU1dmYf3QtEB+tRQ1pSIgoQPCQ1Ya94KyqDKUKmpJ6tw9Z3MChnPE7L/ai1JVtUXJAdAt71bSiJ4FoIvJroAJyIPdkAj1mfHIY00VIIigX6bJfLGr3mXJO+QAAwNdQuaJGUXdjJu0LlMD0I/K97KB0fvnFLGVJaK9LvH8tEhASaOuLzpekVbCnbOuVf4a7fjCI/TeH3IUR+zNCaYaJkr2s7JB6ROFPedvP9AWS7FteOtdJr01fu6A6bRFNEqnsZRh9fuz+tTNTmTmFurZtKOnnOt7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nutwp61bpO55MAgOPyw0BDaMPJxKXGVP/Si+kQR/zbg=;
 b=F1c7OtZxjJwP2VuAirKEDMCP+CJ5qQnRTYl96NTR/eRMNgK/zLtxuXC98sUSUlJIlB4p3UskoFMZfSuI+HP8eprBL4JpUb6Mfg2eByK8w0XLiet06ABGpaM1/jssVeufsySbguGxAUQrycZHlnMhfWh8pdckukHEM9du2ITag5Y=
Received: from MW4PR04CA0072.namprd04.prod.outlook.com (2603:10b6:303:6b::17)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:36:23 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::db) by MW4PR04CA0072.outlook.office365.com
 (2603:10b6:303:6b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 14:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:23 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:57 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 53/56] drivers/cpu: Re-patch mitigations through sysfs
Date: Mon, 13 Oct 2025 09:34:41 -0500
Message-ID: <20251013143444.3999-54-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: a1be0125-0edc-4878-d255-08de0a65e218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YxzAMVd7oipP3LkpDxkDdZi9C0hlV40s5H8Otr0zUnoskmsVB2P/ZamLAPDR?=
 =?us-ascii?Q?RqNseWZIFQiZqQkxVrxhqxkKkahmLXeW0nGGTL+5DudqM+P1kNbf8UrmPLXl?=
 =?us-ascii?Q?n4kjIE4FRzGSrNepqaPATPNMR+JDr/HrxNubLTKF61niwLPx/6p2DgnE6f/l?=
 =?us-ascii?Q?BF3xSRhkqMlVZ86OuvnrciOurrvQItmm/RzRWhdRgS2KJ/TM7HaSnTedzGE0?=
 =?us-ascii?Q?YI2UdSBFnNC1/ARGrowgGdxU6Urz0lWKKCenDCV8iGWySCnSOTLXwAINROHc?=
 =?us-ascii?Q?36dU3y/HPa4VM04sQQX7bzagC/NfMoVD0B2c+5mBdLG69qg3d5jZQAIV5ndX?=
 =?us-ascii?Q?icLOj/OThDnEM8baWesA83F4fbZGqM/nzd8XxD4jrC8CuLmBcxdyyo1m/GBZ?=
 =?us-ascii?Q?2id+LcHObymUXd90zi2mkkFaPluXpxvYAcv0o7VhERMLx9jQnj3Gw0pyDp7i?=
 =?us-ascii?Q?yBYbrZi0BdRrSZTRR6hKpI2z/ge2B25IAbCKfBlUVWZpRyJaRwjim2o4m+Xo?=
 =?us-ascii?Q?/AkvlNBRop66AXisyyh2jhBMZIq8gWHsouQuZQpcooUdgZpT5kswCxgJkHhA?=
 =?us-ascii?Q?4EynLSLzTPOHAZ0k9vLaYz1NcmWmXAtXsDCCDQeYyQGhYgeedrTh5xpnISOq?=
 =?us-ascii?Q?4uFVB+sRC9Tijhzo1vZL/fbrqC7wDXY2KPggYbejgP7pZ3r3jNHr84waKqid?=
 =?us-ascii?Q?vwNckVgGpMR9WF1jgmpuzxUS16Ibm2o29KAPKPuBWgaAGOOZ+knjNpsYrTn/?=
 =?us-ascii?Q?kOYqm8QfgTsnIZE+IdEHiB09XQJyZg/rKqHUGfgZ5ewWQN6Z/MFjxvULt4QP?=
 =?us-ascii?Q?V4JaAIZw4ZNa/iKuphhmSsXTpu80vYbjWCc9VbXF9IkZrN8d0t9GgWz9EEiZ?=
 =?us-ascii?Q?R8nd23dQ4gC4rC+OWWuMklJlgXLMsqVcVQh56/ee9wFQrlBrapjgPtZjqXxk?=
 =?us-ascii?Q?0tTWC1e6zpnVjARh8bKoOy8cRjRfbVsd/YuugBbgR+txBqhMcITUvtc7F1o5?=
 =?us-ascii?Q?OejtoVdxV4ICl72LHcAtP5GPlOT76DK5ZydRY90RDu5IXBjV8MVHLkuvSF4W?=
 =?us-ascii?Q?b8SfSIwxRkqt+A7wuuFKKEjtf0rhyWvQ8gnHBh++UoF9Nc+9fYz5DD3nABrg?=
 =?us-ascii?Q?VG5Nfr1tVTjsHyEepLRfmc+a9bNdib7to7NZGVFF9SOSdjlDUV74RL2LYf3z?=
 =?us-ascii?Q?JzrUK/UTNc64heBZC9punYP/IvfMOzWOrjDzj7SnKX0KUWjCz6qHgKGIIBNq?=
 =?us-ascii?Q?WZS97LLRmTB9nLd9IhmehiWRgPEjxkq9S6fMQvgP2CxdlO0CBzqkJ8KpN2Hs?=
 =?us-ascii?Q?JxSFwnzi57avlAOwfMlbzmTJ0WIMeYHC1iRiyPAzsHXtlhysvLRjalp80XWA?=
 =?us-ascii?Q?lMnc6qcQybjMqPZaT4ztMKRUwOnnJ55EeeKo8SEj42F4iLB5kDlDYbw59f20?=
 =?us-ascii?Q?BUTXVZ+cIQrkKVpRBhof6fkmPgrnkZfHFyd3om2idTOt7udb5sluYQokvRuR?=
 =?us-ascii?Q?Jfu13FCMPMdebdC98QLJdWBiIO7CAiaG5ufuJzV6mMPQYBFzbXwuRdx80h9n?=
 =?us-ascii?Q?PH0fWw6maIiVQ87Iha4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:23.3038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1be0125-0edc-4878-d255-08de0a65e218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

Create a new file at /sys/devices/system/cpu/mitigations that prints the
current set of mitigation options and can be written to in order to
re-select mitigations.

Only options related to mitigations are handled, with the file initially
returning the relevant options from the command line.  When the file is
written, any existing selections are discarded and the new options are
evaluated.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |   8 ++
 drivers/base/cpu.c                            | 113 ++++++++++++++++++
 include/linux/cpu.h                           |   3 +
 3 files changed, 124 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 8aed6d94c4cd..5a0d4372e739 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -777,3 +777,11 @@ Date:		Nov 2022
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:
 		(RO) the list of CPUs that can be brought online.
+
+What:		/sys/devices/system/cpu/mitigations
+Date:		Oct 2025
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		Read/write interface to control CPU mitigations.
+
+		See also: Documentation/admin-guide/hw-vuln/dynamic_mitigations.rst
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index fa0a2eef93ac..3f9410dee67c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -21,6 +21,7 @@
 #include <linux/pm_qos.h>
 #include <linux/delay.h>
 #include <linux/sched/isolation.h>
+#include <linux/filter.h>
 
 #include "base.h"
 
@@ -605,6 +606,113 @@ CPU_SHOW_VULN_FALLBACK(indirect_target_selection);
 CPU_SHOW_VULN_FALLBACK(tsa);
 CPU_SHOW_VULN_FALLBACK(vmscape);
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static char *saved_opts;
+
+static int __cpu_filter_mitigation_opts(char *param, char *val,
+		const char *unused, void *arg)
+{
+	char *opt;
+	/* Extra byte allocated for the ' ' at the end. */
+	int len = strlen(param) + 2;
+
+	if (!cpu_is_mitigation_opt(param))
+		return 0;
+
+	/* Extra byte allocated for the '='. */
+	if (val)
+		len += strlen(val) + 1;
+
+	opt = kmalloc(len, GFP_KERNEL);
+	if (WARN_ON(!opt))
+		return 0;
+
+	if (val)
+		sprintf(opt, "%s=%s ", param, val);
+	else
+		sprintf(opt, "%s ", param);
+
+	strcat(saved_opts, opt);
+	kfree(opt);
+
+	return 0;
+}
+
+/* Only save options related to mitigations. */
+static void cpu_filter_mitigation_opts(const char *str)
+{
+	char *tmpstr;
+	char *newline = "\n";
+
+	kfree(saved_opts);
+
+	/*
+	 * 2 extra bytes, one for the final NULL and one for the space we add
+	 * between each option.
+	 */
+	saved_opts = kmalloc(strlen(str)+2, GFP_KERNEL);
+	tmpstr = kstrdup(str, GFP_KERNEL);
+
+	if (WARN_ON(!saved_opts) || WARN_ON(!tmpstr))
+		return;
+
+	saved_opts[0] = '\0';
+
+	parse_args("mitigation filter", tmpstr, NULL, 0, 0, 0, NULL,
+			__cpu_filter_mitigation_opts);
+
+	strcat(saved_opts, newline);
+	kfree(tmpstr);
+}
+
+ssize_t cpu_show_mitigation_options(struct device *dev, struct device_attribute *attr, char *buf);
+ssize_t cpu_show_mitigation_options(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, saved_opts);
+}
+
+ssize_t cpu_write_mitigation_options(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count);
+
+void __weak cpu_prepare_repatch_alternatives(void)
+{
+}
+
+void __weak cpu_update_alternatives(void)
+{
+}
+
+void __weak cpu_select_mitigations(void)
+{
+}
+
+ssize_t cpu_write_mitigation_options(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	/* Save and filter the provided options. */
+	cpu_filter_mitigation_opts(buf);
+
+	/* Reset and re-select all mitigations */
+	cpu_prepare_repatch_alternatives();
+	cpu_reset_mitigations();
+
+	if (cpu_parse_mitigation_options(buf))
+		pr_warn("Error parsing new options %s\n", buf);
+
+	cpu_select_mitigations();
+	cpu_update_alternatives();
+
+	if (ebpf_jit_enabled())
+		pr_warn("WARNING! EBPF JIT is enabled.  See Documentation/admin-guide/hw-vuln/dynamic_mitigations.rst\n");
+
+	return count;
+
+}
+static DEVICE_ATTR(mitigations, 0644, cpu_show_mitigation_options, cpu_write_mitigation_options);
+#endif
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -660,6 +768,11 @@ static void __init cpu_register_vulnerabilities(void)
 	if (dev) {
 		if (sysfs_create_group(&dev->kobj, &cpu_root_vulnerabilities_group))
 			pr_err("Unable to register CPU vulnerabilities\n");
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+		if (sysfs_create_file(&dev->kobj, &dev_attr_mitigations.attr))
+			pr_err("Unable to register CPU vulnerability controls\n");
+		cpu_filter_mitigation_opts(saved_command_line);
+#endif
 		put_device(dev);
 	}
 }
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6f69344465f1..99e4b08ff36d 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -210,6 +210,9 @@ enum smt_mitigations {
 
 void cpu_reset_mitigations(void);
 void arch_cpu_reset_mitigations(void);
+void cpu_select_mitigations(void);
+void cpu_prepare_repatch_alternatives(void);
+void cpu_update_alternatives(void);
 bool cpu_is_mitigation_opt(char *param);
 bool arch_is_mitigation_opt(char *param);
 int cpu_parse_mitigation_options(const char *str);
-- 
2.34.1


