Return-Path: <linux-kernel+bounces-850736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE39BD39F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0B7188BAC2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE83274B27;
	Mon, 13 Oct 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w3NFEseo"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B63093BF
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366158; cv=fail; b=V7L19LlEHxWRKvUv02gDGvzMrV8Vgj8rTbuP+yuTVUJrRMGCY3bPZaXf4V+tIUVEs3M2U929SUbKJPmkdp9DcYUfthZriRv7lk5WttikkZezcVd/GPB/eFhZos/T6jHE8vPT7ToJdWI7TIhqbhxem1DlVEN0Bn1BqBSAMIh46GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366158; c=relaxed/simple;
	bh=Bbl8kCX6J85MCj8dKpwqiYhLV0vu+MTlLMpDxN8iRm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eprCszQ1XagYtXY25WR8ltLLqFacpQeu8Xt+UEkKfkcn563wW3ow1DPXYwprbvdhem7NdybdO0oRAnEN+lO4nyYp5Lux4862G1C+L7R1OtS7HAOfHigdMBbXWqKtVFxlknHR+k685q1lgQfPXgQEge6oNXX8yRfv5xSJK3veK3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w3NFEseo; arc=fail smtp.client-ip=52.101.46.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ha518TI272SL1r1CwvpiSDKcuq7eFlg1a2I3/6EOga+4jtLTbxv7XIuNcJKauk6BnQBDDWtJ2kzL05GRJQGGxXA3tQKkzTkVXQ8wujHXag0yWRaY/T01e/C111heB70/mP2awT+ai+9I5SojMBbp+XA/xSFyM406b4rYERZmOCzbT1+MXuHXerN5xm9K32RYkUcOcjsLdzvZpnJM5s6H5XpGPKxVBA7aB1f9kVPaYzn1Yp602rFSOj4m4EnzB2GlhfLOfZHC7/Oz0wfMuJS6dPBMR08EyLmXBMcqYvbcIYfM+lAp0ynMA6IDGNVpoduMTuJIq2H2mM1q5O0nxuQgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+wiqbSNZBc4ZwWhkNOx+S3w6yR5lYK9Lofu7gPSvag=;
 b=U/tJk3rps9O2yQFsqegQwdVzw0e/63QD8O0GnC0NHea87nkyJYVBBHqgYURRarAVdBZA0ZkxTAuJmgijATidefupYOXgMTTIhs0C5LT5DyOpBj73TZHInkS93NkvQgMfeNA8zivg6DrE3SA28VDz7Ywoc29flUgIhVmJ/CToPjtTp2L1D+PZ1WiAaZkI7ozR8WgnTAPUyaYFWtCOpT67ZCliAFn+QKIDukmAUXdw3f8WvPtFXoTuAQgJLOvjyBgq72WcldTOVTFXi2lJPVhj4i/ehoyz4gaapeptI/QL2OmMfm50emRXmyntu5vxGX0sfkk/8jjcrx05BppMx1xQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+wiqbSNZBc4ZwWhkNOx+S3w6yR5lYK9Lofu7gPSvag=;
 b=w3NFEseoSRRnr/Sbhwa4f6yqdQ0AyFAZE/dvxoFvyx+Be80NOQkOO7LqraMyLPgLj7yrAqOTGlbqPGYYYhK8TAyxhV85bheI4nzI1jia1xoGZlLGvJ3POa5rVzXJIWwyP2U3J3+HRDZkhk7ZNxYq+NjBbB8c2n4CX22jaoxXi68=
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:53 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::4f) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:53 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:38 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 28/56] stop_machine: Add stop_machine_nmi()
Date: Mon, 13 Oct 2025 09:34:16 -0500
Message-ID: <20251013143444.3999-29-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 4336cf78-6300-43dc-df91-08de0a65d014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pWcxXQqUO7g4aFBZfqFOzq+JYasimh3hOds0uiV4CCfcQiOqlHJmIDfcdyVc?=
 =?us-ascii?Q?gbPpJRfeSGVJkhkKOegS5iHKiENDvqvWJtT8Lbw+OtjqM34Rs1XNuDEsvjjN?=
 =?us-ascii?Q?8cIR3d+0LNoZ6H2lrOdxaNgINvyBkBt1lVOC7HP3/GG5Ntl0nR8wcoao+xnU?=
 =?us-ascii?Q?3EvW77UqTQpkDYBWTlkmKYQmhwkkUrxBgEph8ySxOksHRilEfinC+Ym0vFb8?=
 =?us-ascii?Q?lKJ8/LtYDXCZ8Lwzi/txlqAExkh4hSpQcHIHArQyqTz5StG5ATBP0HtAD+hq?=
 =?us-ascii?Q?hTCtQ211xGBXv31J/rQ+uKtHBeI9WazusSOv1QTs5ap1VXaoxEPS2yawYQ+G?=
 =?us-ascii?Q?+b2m3hjVafAv1ya6WGuYPRlWLymtHHC7tLejRgELLVmeYeHwecGJM9T0LRlm?=
 =?us-ascii?Q?aO0/RRfQY69IJMLr5cseOp1Dh0jJMz3ZRkTbs64Dkb+vOoqRiTHiUxYeRHqG?=
 =?us-ascii?Q?oZo2rk2Xz7gZGnqjFZBr8Gkw88eKHUe5x6jiitvhu3TieJswmatnFaE4UbPQ?=
 =?us-ascii?Q?gb7oIiPfKNWT79/4WoBQe4hmG2L5EDGCZr0WRhoTmoMtewHC1RmD+rqkDiBt?=
 =?us-ascii?Q?GQjLJJv+0zlv5MSW9voaXAY68xXCkYDUmYdaqnsRGQmXZWHAxAyXPY+5Ja49?=
 =?us-ascii?Q?zPP/sqNwk9lLnpciTvRm48LYn4yqFfC3aoRjEPuYcIBUzsNo9B5SDCqiMF9P?=
 =?us-ascii?Q?7B7uTdhYKhi9RvAdgSo8rZ5zKKqRIpidKUadACHRSvDz01L9SohYFb2COL5e?=
 =?us-ascii?Q?+MzHLRk9OcPa8tbsYolD2mfauVGsj/iKojV05FO9pSopllhBb0P525ATPNsh?=
 =?us-ascii?Q?uNZaxFUCDPAi7Pqwo+iPvY11+dgGFpjEalA05ovD7uELMWkxWaInoL6NqhcJ?=
 =?us-ascii?Q?a3xdZrNTMiCq9FnDhMfFLMFMlSLRRnciNnPmoUl/pMtWAc95/Xv0XwDMvHB6?=
 =?us-ascii?Q?9P4swMhFeGg8Er+oPXS1feaI5LNLoV8eZ/YgRcdS9up/yjIWeRbpdhsAWOzr?=
 =?us-ascii?Q?ZfNknGPN2YKuCfZsocIHGzhPQE6X7y9XM5GVHPUwmr52gGsJE55JEFIWDdbN?=
 =?us-ascii?Q?5LOAqz1xGYvob/H6A6qJkV97T+7IrvnZAWcwOTG1NYrWyM8YzR0bJLEVDDz3?=
 =?us-ascii?Q?4f3j8Vqd3p0nAEdlC5awzcQ3mwIXXqwPYliS6Z/WRk4e6vkeHUgCHsL5Xefl?=
 =?us-ascii?Q?dL0CsUEW+H7pM2eI2ofEkJEPe42cvsQPtiLMFoLPGIgRjMqmiG1/g1Fym896?=
 =?us-ascii?Q?lW3Zkx1xOvGKZLALyA5gIN7X9sL1BmClo8xV6zissq0u2oZooMUdvY1PFZcg?=
 =?us-ascii?Q?oUY6BQ4Fck5ZiuhCxm+9Zz5ACUpqtFo02DjsTA5R6wTGP8SMDivUC/yQVt7J?=
 =?us-ascii?Q?tShMx/kkcRUee73egv/D/xprcGRNepokQkhfpesTF2sYKfRZQpyoZ8VzQoAd?=
 =?us-ascii?Q?0kcodN7Cc9bbpj/JdT1263S0sFKthVQDtjM34cbIc/XHCUPzOzUxC/WOIEUy?=
 =?us-ascii?Q?XGk1hwtn5EL1h8ZuZKCtjZKfyp92owa6KvYqA+roERUkT0w4hSbpXu9MbcbV?=
 =?us-ascii?Q?QNuLDz9WpOoZzlONryU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:53.0779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4336cf78-6300-43dc-df91-08de0a65d014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274

stop_machine_nmi() is a flavor of stop_machine() that runs the specified
function in NMI context.  This is useful for flows that cannot tolerate any
risk of interruption even due to an NMI.  Arch-specific code must handle
sending the actual NMI and running the stop_machine_nmi_handler().

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 include/linux/stop_machine.h | 32 +++++++++++++++
 kernel/stop_machine.c        | 79 ++++++++++++++++++++++++++++++++++--
 2 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 72820503514c..452c45640012 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -141,6 +141,29 @@ int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
  */
 int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
 
+/**
+ * stop_machine_nmi: freeze the machine and run this function in NMI context
+ * @fn: the function to run
+ * @data: the data ptr for the @fn()
+ * @cpus: the cpus to run the @fn() on (NULL = any online cpu)
+ *
+ * Like stop_machine() but runs the function in NMI context to avoid any risk of
+ * interruption due to NMIs.
+ *
+ * Protects against CPU hotplug.
+ */
+int stop_machine_nmi(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
+
+/**
+ * stop_machine_cpuslocked_nmi: freeze and run this function in NMI context
+ * @fn: the function to run
+ * @data: the data ptr for the @fn()
+ * @cpus: the cpus to run the @fn() on (NULL = any online cpu)
+ *
+ * Same as above. Must be called from within a cpus_read_lock() protected
+ * region. Avoids nested calls to cpus_read_lock().
+ */
+int stop_machine_cpuslocked_nmi(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
 /**
  * stop_core_cpuslocked: - stop all threads on just one core
  * @cpu: any cpu in the targeted core
@@ -160,6 +183,15 @@ int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data);
 
 int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
 				   const struct cpumask *cpus);
+
+bool noinstr stop_machine_nmi_handler(void);
+void arch_send_self_nmi(void);
+DECLARE_STATIC_KEY_FALSE(stop_machine_nmi_handler_enable);
+static __always_inline bool stop_machine_nmi_handler_enabled(void)
+{
+	return static_branch_unlikely(&stop_machine_nmi_handler_enable);
+}
+
 #else	/* CONFIG_SMP || CONFIG_HOTPLUG_CPU */
 
 static __always_inline int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data,
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 3fe6b0c99f3d..d135f32528e8 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -174,6 +174,8 @@ struct multi_stop_data {
 
 	enum multi_stop_state	state;
 	atomic_t		thread_ack;
+
+	bool			use_nmi;
 };
 
 static void set_state(struct multi_stop_data *msdata,
@@ -197,6 +199,42 @@ notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
 	cpu_relax();
 }
 
+struct stop_machine_nmi_ctrl {
+	bool nmi_enabled;
+	struct multi_stop_data *msdata;
+	int err;
+};
+
+DEFINE_STATIC_KEY_FALSE(stop_machine_nmi_handler_enable);
+static DEFINE_PER_CPU(struct stop_machine_nmi_ctrl, stop_machine_nmi_ctrl);
+
+static void enable_nmi_handler(struct multi_stop_data *msdata)
+{
+	this_cpu_write(stop_machine_nmi_ctrl.msdata, msdata);
+	this_cpu_write(stop_machine_nmi_ctrl.nmi_enabled, true);
+}
+
+void __weak arch_send_self_nmi(void)
+{
+	/* Arch code must implement this to support stop_machine_nmi() */
+}
+
+bool noinstr stop_machine_nmi_handler(void)
+{
+	struct multi_stop_data *msdata;
+	int err;
+
+	if (!raw_cpu_read(stop_machine_nmi_ctrl.nmi_enabled))
+		return false;
+
+	raw_cpu_write(stop_machine_nmi_ctrl.nmi_enabled, false);
+
+	msdata = raw_cpu_read(stop_machine_nmi_ctrl.msdata);
+	err = msdata->fn(msdata->data);
+	raw_cpu_write(stop_machine_nmi_ctrl.err, err);
+	return true;
+}
+
 /* This is the cpu_stop function which stops the CPU. */
 static int multi_cpu_stop(void *data)
 {
@@ -234,8 +272,15 @@ static int multi_cpu_stop(void *data)
 				hard_irq_disable();
 				break;
 			case MULTI_STOP_RUN:
-				if (is_active)
-					err = msdata->fn(msdata->data);
+				if (is_active) {
+					if (msdata->use_nmi) {
+						enable_nmi_handler(msdata);
+						arch_send_self_nmi();
+						err = raw_cpu_read(stop_machine_nmi_ctrl.err);
+					} else {
+						err = msdata->fn(msdata->data);
+					}
+				}
 				break;
 			default:
 				break;
@@ -584,14 +629,15 @@ static int __init cpu_stop_init(void)
 }
 early_initcall(cpu_stop_init);
 
-int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data,
-			    const struct cpumask *cpus)
+static int __stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data,
+			    const struct cpumask *cpus, bool use_nmi)
 {
 	struct multi_stop_data msdata = {
 		.fn = fn,
 		.data = data,
 		.num_threads = num_online_cpus(),
 		.active_cpus = cpus,
+		.use_nmi = use_nmi,
 	};
 
 	lockdep_assert_cpus_held();
@@ -620,6 +666,18 @@ int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data,
 	return stop_cpus(cpu_online_mask, multi_cpu_stop, &msdata);
 }
 
+int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data,
+			    const struct cpumask *cpus)
+{
+	return __stop_machine_cpuslocked(fn, data, cpus, false);
+}
+
+int stop_machine_cpuslocked_nmi(cpu_stop_fn_t fn, void *data,
+				const struct cpumask *cpus)
+{
+	return __stop_machine_cpuslocked(fn, data, cpus, true);
+}
+
 int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
 {
 	int ret;
@@ -632,6 +690,19 @@ int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
 }
 EXPORT_SYMBOL_GPL(stop_machine);
 
+int stop_machine_nmi(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
+{
+	int ret;
+
+	cpus_read_lock();
+	static_branch_enable_cpuslocked(&stop_machine_nmi_handler_enable);
+	ret = stop_machine_cpuslocked_nmi(fn, data, cpus);
+	static_branch_disable_cpuslocked(&stop_machine_nmi_handler_enable);
+	cpus_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stop_machine_nmi);
+
 #ifdef CONFIG_SCHED_SMT
 int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
 {
-- 
2.34.1


