Return-Path: <linux-kernel+bounces-850758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5CBD3B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F313E53F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E682A30F81F;
	Mon, 13 Oct 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X2lQk69M"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1030F531
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366188; cv=fail; b=XGfjgJJHYTlHl73HBpvArUxbw3yIg14038Ww17fKm7JwUHp/rbpcK3DkwmGDSMzCfWavV9TtzVLkJlVBjRCaRGBOmmr4XNgZbO1oJV4hSj4cxfnI9pEVLH/Bioc248sjldpNAwbqWV7novsLxwmO8zixtup8Kts6vXSlxCUUfm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366188; c=relaxed/simple;
	bh=LYjlcEx6gfR7xNSOmIH+fst5jmPLaombXwmmQrSytnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0XyQ1FmNfu98R70eRITJc7tXHkLVIpOOYwiu076TaOYrAoRt73sy8B3S0dBiIlymcwkhTyN+SG+CkHJs0BwB6Qm4OTwgsZXJVSyZZPI8YXuoKNYFBA/XbEc+k4y/+cTSqiThW+ctVGWbU6XNDscWWCPWsPZE4ImKPAJKQX4ReQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X2lQk69M; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0Q917du+AT/CxqxlFiivkJRzemqogKpbigjtvjrtvcCaJAF9Ptox6qp+2DHjXHqyG8IATRA3A219/IqB+SOGXaY7pWQxIE8nfY7xhZ/eCgRWKS9D/GKTW51bWecbQrQugMS9k4eEkmP5HSZESGDOddIjDJHicpZ0CY49Qmi6YzuiEP/Tym3dmK6EbM1li+IuaZ3urUCku2Yj8ieTfqaCod3PT2NdbcdVk2CJTp95jih1WO2wI8ZAI9gEtznBPQsePrs4bhntMBk8k7V+iKIebQrZwoN00Fi+3Uv8KgRnPnSpfV/wOzHfwJt986+cz74nxn84Lp5TTR8v20dqjPohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WsfOUDfRx9OtswORNYwTOSqDYblb+B9kcCdPHH8seA=;
 b=jbByQfX/pozoP6ZADPsMPs9fDdz8myu5amE6ekuYo2QzeAAF2YqeoRwCA//IYuf1h+uMQopcws5cVsuMl9mEeLDKfcjMaXnnoqsvgvmXMpCwdlTDztiuCvQwXxnE+MjY0Xk/Mfkreh4P4rcdSsUxXTtLiBRdX5dhTxmiHhiMRo7IQNRRg0OeUhNmKkjHP6YhhAjCaTp6nEQshioX2XDueQFlZPy6fWMuyvJOoL33DHVL+3EviYnRZ9rS56TtUX5PCjCpx8pf3UjhSwNI9V7yEoxub4w6ubvxq+QDJRfxAgNUm+LQEL7vVZXvdCrat5yvfyU7jXdx4krWA3DXDoZKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WsfOUDfRx9OtswORNYwTOSqDYblb+B9kcCdPHH8seA=;
 b=X2lQk69MJ/AYAR7w+P11K8Sk8Bq1V9pRzfjXSfXgJoT6lPg1rh2YXiHFRfzukCM46OGK7/30mmP1CB3z3fVL8LT7j9kI2O7mG/dqV/kqsawdAWw97oEmRQwAdoMUJYgZZPQKpnwA+rpJh5FjepKpz6aZF/nzieU4nXV7AKc4IQk=
Received: from MW4PR04CA0088.namprd04.prod.outlook.com (2603:10b6:303:6b::33)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 14:36:23 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::66) by MW4PR04CA0088.outlook.office365.com
 (2603:10b6:303:6b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 14:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:22 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:56 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 51/56] cpu: Parse string of mitigation options
Date: Mon, 13 Oct 2025 09:34:39 -0500
Message-ID: <20251013143444.3999-52-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: ce563c38-8525-4150-f8e4-08de0a65e198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTmblws5IzwsfpQSkQCiNapEBz1oRH0qJ5l0XGfooLzoZ/7eVMpSQPAXXYwP?=
 =?us-ascii?Q?mdVnb/9yC+VBtO+OeoN7uQ/2eLPi+KUrsr1Ckm5jvON6A7ConV5aL0YV15Ly?=
 =?us-ascii?Q?yYj5z0nDhLf2AyHhOofWdLFAtk+gXaR7C/f4VA8QgrlO0zDxhqK8W9q1mKVO?=
 =?us-ascii?Q?B8CASjkSTvfkncdpae917I8BZPkBz8Wcz3tvJKOum+8dVXjMB8n9cEhBhohr?=
 =?us-ascii?Q?BoRdlUUsWm8N18UbYiEjqqNTMay/nMJv8Fpp3Hb4RcB0e3MU72OcG/za7Ikg?=
 =?us-ascii?Q?2qnUCQVI3kc+7pv3pwKK2kgCdJQfL7fJ65y7kzcInISSYXnlKoZ78JfbY0W6?=
 =?us-ascii?Q?7yb1Kl0x9JVEFtKLztoxwn3V6Zy/e6YFeZsIYewKFZ9H3eg0myhk//PkJfD/?=
 =?us-ascii?Q?jeLUGWSLrlZ8F9j8pK4pwgbnVI3UWiwFuYqXCGHMcMKZoB/pqA8Jer+DxtfG?=
 =?us-ascii?Q?xUl+aqt8KNx/6n92iXN+pXBMN7h38FkgNYGQREe/Ve3RlavHsTB4PC1ingFQ?=
 =?us-ascii?Q?BAovfzjcaySCzlddx8Zt1BofKgbZXMiljuAxrylKYdqRltkUxmZTBmsK4cFv?=
 =?us-ascii?Q?aLgiAskkI5xB8hD/RzRMNFAb8O7LuADJg4O8YjjanyF0BMSEDQTRJRwJgkiQ?=
 =?us-ascii?Q?6AyC6d9dyMC7Tleucvzs6Pv4VufeT8TfxNE/XGAKRO6z5Vm7zD2lRl0UmDcE?=
 =?us-ascii?Q?S9EwFCKGNpqrJ49mo+yV22+C1jOoiCySG37dQi2cf1Ev17g3qBtRskhp97lW?=
 =?us-ascii?Q?IhLlqEHn5RXlCuuMoa8kPDI36G/i/0KhRfx9qMpYt9s4CTSZeVo16jQCL0Yf?=
 =?us-ascii?Q?6I8g8HiTN4fxzd6ctr8Q/2A01ki/eeiJLu1qwGBmJGPpnFMwFk1oRCdYJERD?=
 =?us-ascii?Q?RR+XX71uYGqNQVE1Itld0GE/e+tSUz3ZyIaLOruNrpjwDa+aZ7L1pSPyWUhk?=
 =?us-ascii?Q?nGTLotcZS6P6q3SCE+rDBNdwnMSg53aPhlmwxAFH9P6PFPur/zjM6am1uihP?=
 =?us-ascii?Q?y7yozwu+H65WSvfPtxoLXksvEdtG/eY2ctoc/7w+UduQ0k0LlQAyKatkNPXe?=
 =?us-ascii?Q?X2f9WfmWgpH+q0CO3aEwMQ8s6bjNS4sZHjRAdBa8KDobe2y2l6tQWfZhfS0H?=
 =?us-ascii?Q?u/vMufq+1OxzZ+Q5tuE9uJk+ZxXdUrCxEv44Kbnp2Ubc7WtKzDGJ2Yx09n3C?=
 =?us-ascii?Q?3f7olSa6sskJQzraVUM7h8NQzraxZU9HYGZatLBz4x0Sj9guq8/A+toa1kla?=
 =?us-ascii?Q?6UYpeW8AfjJd9Rn2Fddaf2LPvdjHmIATinPf+U/UKINWbY2QfmsEmILkYxZ8?=
 =?us-ascii?Q?fF86u7pqgDHWTVGIFVs9HIFSuSfo9ArDUb6Zsp/1YcIFj2gpYkN18ST19ZrS?=
 =?us-ascii?Q?ZX6rHUmnfIQYqBBw8CD1ACQPCZEGPmKfam9XG9Zgv1OuxmgXK5ZtZTuxOpBK?=
 =?us-ascii?Q?3xsviPxVyJelTAGZ/PzB0BXzqL//TquVMIcSJkUNxQEUOepvjp2nqhUfInWD?=
 =?us-ascii?Q?lgIBFG8+Y2o8jG6G7yfsmj3PubcCQ2e/T/96bWKCIyGlqgMSRNrPy6/8PGCs?=
 =?us-ascii?Q?HlTp4F44FBv0oBR6RN8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:22.4660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce563c38-8525-4150-f8e4-08de0a65e198
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938

Support runtime parsing of a cmdline-like string of mitigation options.
The global 'mitigations' parameter is processed in generic code and all
other parsing is done via the arch-specific function.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 include/linux/cpu.h |  4 ++++
 kernel/cpu.c        | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 3da629a76a49..6f69344465f1 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -210,6 +210,10 @@ enum smt_mitigations {
 
 void cpu_reset_mitigations(void);
 void arch_cpu_reset_mitigations(void);
+bool cpu_is_mitigation_opt(char *param);
+bool arch_is_mitigation_opt(char *param);
+int cpu_parse_mitigation_options(const char *str);
+int arch_parse_mitigation_opt(char *param, char *val);
 
 #ifdef CONFIG_CPU_MITIGATIONS
 extern bool cpu_mitigations_off(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 33289405af30..942a200398c9 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3343,4 +3343,36 @@ void cpu_reset_mitigations(void)
 	attack_vectors[CPU_MITIGATE_GUEST_GUEST] = IS_ENABLED(CONFIG_KVM);
 	arch_cpu_reset_mitigations();
 }
+
+int __weak arch_parse_mitigation_opt(char *param, char *val) { return 0; }
+bool __weak arch_is_mitigation_opt(char *param) { return false; }
+
+bool cpu_is_mitigation_opt(char *param)
+{
+	if (parameq(param, "mitigations"))
+		return true;
+	else
+		return arch_is_mitigation_opt(param);
+}
+
+static int __cpu_parse_mitigation_options(char *param, char *val,
+		const char *unused, void *arg)
+{
+	if (parameq(param, "mitigations"))
+		return mitigations_parse_cmdline(val);
+	else
+		return arch_parse_mitigation_opt(param, val);
+}
+
+int cpu_parse_mitigation_options(const char *str)
+{
+	char *tmpstr;
+
+	/* Copy the provided string because parse_args will mangle it. */
+	tmpstr = kstrdup(str, GFP_KERNEL);
+	parse_args("dynamic mitigations", tmpstr, NULL, 0, 0, 0, NULL,
+			__cpu_parse_mitigation_options);
+	kfree(tmpstr);
+	return 0;
+}
 #endif
-- 
2.34.1


