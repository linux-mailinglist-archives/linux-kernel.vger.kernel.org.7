Return-Path: <linux-kernel+bounces-720355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E2AFBAB2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951A93AAFF0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B29C262FF8;
	Mon,  7 Jul 2025 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eNRCuBkP"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829221FF46
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913215; cv=fail; b=qyvNUQenx/glFXHGaV/be4xinn+xVNu1dad1ORBMLax9jHsYLObbR23ghwoc0w4/NLXPIl6lBNwlxg7x7Fno7Kfn5rXWuK4QdDOFAst86r4mxl8BtqzgBGkrT2nQfJg/WuOOFXVUn7cpE7naklPz7XSRZJeZpcU7PJt0LN2GFno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913215; c=relaxed/simple;
	bh=9Cocd7sU5ulYg83yHdG+rouLPC33p/0UOykbPM/scXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sacoHWZtYCndW7uf5aa/8ghIqOBCoUsMe7vw8NAFVl/oFmLkcoy6PcsDwXJxwyT8uO4y/bi4lkcbazu8y5hAgjkvwdPxwEsoVm3pHtek3BiQZDcYXOcysH7dkdcWbs3IPalI/Bu+RA2Q8neuX8s3Y7Fo2kRac4yMNPfAh4CTlE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eNRCuBkP; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bz/GUj+rd3MqLfR+kRCU299OVTsfJmoMLtYb5zqcWR4ZKLNJZcKHhowHWy6WQt+lmWQVtwg/CC/xHE6C+TDzQgPodRPoCFyuhNlCfzM3wLbzOcXzGlNGZbkfRa7AnT9eJNjmFqzTKooy0W6VshktPO/ayvo7YAR5K8zImkXkY53+JiFitYd/yXZtSYl8vgpdkMKxSRHEVrN2aIvgf/UnVsWntBIqFmLzfIItx0/SmN+PhvGBONZFps0Rt6qHTMMDkFC76SHqZvsNmv9OmBg0Rym5ku+xuGb8CZo0GHYu3p0DvtcK79J52PZpFE7KSo2BonPh76a03PwaLI/HRx6K5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIiGl58gsbL8A+TiFEYmaYRwN8mN0uuxuZjTzGh1rTo=;
 b=VZL9gY0sb5eXmE3I8bkiVrx6+XLC3GP/Bfh+kDUdjs5H61cyhxfGoFqXMUnywgE9TNyfpVGG//Z6bz5J/V/pTzZuMeHMYZE1h/O/N5hzTnyBEJ5csZ41fcvdLSA/2bLMKvXrXE6y6vOKp972zgcETDT4E55ijAWYF+uoaoc9rOnhNwb/u1fOfP1L92HYgRpi6J9we5GuQZRLmvwXIlKabsJVpKTqMRouwW6BKtn9aYFfKakmzNLmjr4H4JiPYYpYS8TjZiMDgwoc+dX100BqQtCPwxz9VkJfFoaZvEv4nX7FUFsBNCcTw+pgAE/LngH2AOo3X63sjpFjnsd/B6IyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIiGl58gsbL8A+TiFEYmaYRwN8mN0uuxuZjTzGh1rTo=;
 b=eNRCuBkPTTtolbb0OIa/ROFis9U5VlQ3yvmfVyOzCQie5JI7ENTybzwKQoix5R7RUmZj2S683xvl1zKKQfM7zAVEUfLNMJfO9lVum3nb5X1y3tMJmEixxI2UsYWpXIA2uoEBBusaR4QRIBqjttNN+Pk4+mbgrVMWz2MoHpYcCdM=
Received: from BY5PR16CA0023.namprd16.prod.outlook.com (2603:10b6:a03:1a0::36)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 18:33:31 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::a7) by BY5PR16CA0023.outlook.office365.com
 (2603:10b6:a03:1a0::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:30 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:28 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 01/21] Documentation/x86: Document new attack vector controls
Date: Mon, 7 Jul 2025 13:32:56 -0500
Message-ID: <20250707183316.1349127-2-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bce1ea0-bf98-40e6-b07e-08ddbd84c5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kHQck9Gd+YF5dMn75dEb1c5TlxCpTS1MZMtqWxIyaavQiI9rmhapoG9kNG2C?=
 =?us-ascii?Q?ywkrs7x4FQJny2K+iuB1kVA7WrNsGm5oeQy6zeE5QGU9htu6JfApxyyspchj?=
 =?us-ascii?Q?Tu8WmJDQv6eldoTmCWoEs+1h6QIuVU8I+rChG2IubzYeuLTK06Hy+ZIdPcEf?=
 =?us-ascii?Q?m9eyIAuU4kz/fQ8azB0oCpet7brQ5tEXGdM7n1+yamXm3HjCZ/x1hl8kgOBl?=
 =?us-ascii?Q?vrICkaLCBLLUXvmfa2FS26IudNECjAaKph0akmGr+zsvwiM+lvbln3HcSfmy?=
 =?us-ascii?Q?zHkX83ZGNMJ5mQB8/22brXrFAhVb3Jyj1lJMcNbC1BfzcQBaPP/aeQj7JlWJ?=
 =?us-ascii?Q?/pD8WSCUYxulMyRVyw8TfOHKEajtfF4BZmfi6odKYktuOBAnd+Qnrj/Vg/fQ?=
 =?us-ascii?Q?BKxmXlW/Yscm4k793oHM0rjmWvtXezJxDISVgBhVJhjdqECjwcsaRUjzzrSJ?=
 =?us-ascii?Q?EQzGzjVvwY/6IVzb98YVGL0tO0srAz7ZXJ539FF+yvY81DdPW95Da6jRcnas?=
 =?us-ascii?Q?bY5EuhwGUiGeZOzpg7v41rWjZQeuGEF1RsT9TFifpXj0fN7dmf91TsthYpop?=
 =?us-ascii?Q?iBHsiHavKKS3I8IumjwGwx7DWLTjb0x2j1STREg+ucgd0c0IufTYk5Afx1Qt?=
 =?us-ascii?Q?jrux1yWcWf2n0n3mxVBf8/ZodpgcpXKUjpV0l+CT32ogZ6J/3crPBFYqo54s?=
 =?us-ascii?Q?g4VEJtlGGOoR4ClwOcanHUyPtG3z9Hzj0ZpduKu8Fy6QE16dKutahwsrzstr?=
 =?us-ascii?Q?l4XRZ/RpMur5Yff/SbgQinf5PwjHAnn+2VCPYNxSDD9PkakcRJC4ags+aA+M?=
 =?us-ascii?Q?/8El7t/JAKbFU2VO+cqVWYEHARNAYCzedsuJfmkvbFhmDoJaLWn8qV0IacfF?=
 =?us-ascii?Q?UPc48gQ7o+FcwuZb91FWVYxtVnnQAUhjyYJ72PSl98JWay1PKnPETaRZgG9w?=
 =?us-ascii?Q?GSUukBFGehs/C9vpf2CO93kcqFGaQg9D7NcYCYCNROJFONc9pJMpmLquTKzl?=
 =?us-ascii?Q?qAdN6wLSMZMEgnKoz10RwtDqrqBDsi+u8XN0fNzieMHR78+Jf1oZJuy0eNXL?=
 =?us-ascii?Q?Z1HpewsgT+Y342RNjgvq6xxrPRIrUrtKJK277801/gdl97SGRwocYzDWEHoA?=
 =?us-ascii?Q?WwHn4fKQdwmEls8beU0JGQwEbSVNvdxeDqjAseaJTs1CyVR1TX4mmNZ5zB2r?=
 =?us-ascii?Q?s8BBRjJHUObqOjBa8xOOv71Sk3sYUDtJHLi49vzpycARPg3HpvX+C0u5ZFf5?=
 =?us-ascii?Q?DXOJBxbTwqkZzgtxW23KRglLu5g/2YM13djl0F4K9xoew9TuJNwk6AvXEkGx?=
 =?us-ascii?Q?y09kuWKpy1yV5p03EnLDZfAHJ8DUMpqD7/8lDhCAD66mHc3BoYk0xQE4aJrA?=
 =?us-ascii?Q?jhQsniumpTTy1BefjIlP7uyrNnjWX9s9b9YOBVUdfSKIVb9L+w41l/fzuda5?=
 =?us-ascii?Q?IobBZt0lf9QE7iFwfLecmk1BJglc133QUVDo0AFEDn6KUqi6h5tH4rdDrSsH?=
 =?us-ascii?Q?v/ZFWg9PDuM5j2JCabW64l423pjX2u9eOJhi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:30.6789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bce1ea0-bf98-40e6-b07e-08ddbd84c5c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681

Document the 5 new attack vector command line options, how they
interact with existing vulnerability controls, and recommendations on when
they can be disabled.

Note that while mitigating against untrusted userspace requires both
user-to-kernel and user-to-user protection, these are kept separate.  The
kernel can control what code executes inside of it and that may affect the
risk associated with vulnerabilities especially if new kernel mitigations
are implemented.  The same isn't typically true of userspace.

In other words, the risk associated with user-to-user or guest-to-guest
attacks is unlikely to change over time.  While the risk associated with
user-to-kernel or guest-to-host attacks may change.  Therefore, these
controls are separated.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 .../hw-vuln/attack_vector_controls.rst        | 237 ++++++++++++++++++
 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 .../admin-guide/kernel-parameters.txt         |   4 +
 3 files changed, 242 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
new file mode 100644
index 000000000000..b5e465e618f0
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -0,0 +1,237 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Attack Vector Controls
+======================
+
+Attack vector controls provide a simple method to configure only the mitigations
+for CPU vulnerabilities which are relevant given the intended use of a system.
+Administrators are encouraged to consider which attack vectors are relevant and
+disable all others in order to recoup system performance.
+
+When new relevant CPU vulnerabilities are found, they will be added to these
+attack vector controls so administrators will likely not need to reconfigure
+their command line parameters as mitigations will continue to be correctly
+applied based on the chosen attack vector controls.
+
+Attack Vectors
+--------------
+
+There are 5 sets of attack-vector mitigations currently supported by the kernel:
+
+#. :ref:`user_kernel`
+#. :ref:`user_user`
+#. :ref:`guest_host`
+#. :ref:`guest_guest`
+#. :ref:`smt`
+
+To control the enabled attack vectors, see :ref:`cmdline`.
+
+.. _user_kernel:
+
+User-to-Kernel
+^^^^^^^^^^^^^^
+
+The user-to-kernel attack vector involves a malicious userspace program
+attempting to leak kernel data into userspace by exploiting a CPU vulnerability.
+The kernel data involved might be limited to certain kernel memory, or include
+all memory in the system, depending on the vulnerability exploited.
+
+If no untrusted userspace applications are being run, such as with single-user
+systems, consider disabling user-to-kernel mitigations.
+
+Note that the CPU vulnerabilities mitigated by Linux have generally not been
+shown to be exploitable from browser-based sandboxes.  User-to-kernel
+mitigations are therefore mostly relevant if unknown userspace applications may
+be run by untrusted users.
+
+*user-to-kernel mitigations are enabled by default*
+
+.. _user_user:
+
+User-to-User
+^^^^^^^^^^^^
+
+The user-to-user attack vector involves a malicious userspace program attempting
+to influence the behavior of another unsuspecting userspace program in order to
+exfiltrate data.  The vulnerability of a userspace program is based on the
+program itself and the interfaces it provides.
+
+If no untrusted userspace applications are being run, consider disabling
+user-to-user mitigations.
+
+Note that because the Linux kernel contains a mapping of all physical memory,
+preventing a malicious userspace program from leaking data from another
+userspace program requires mitigating user-to-kernel attacks as well for
+complete protection.
+
+*user-to-user mitigations are enabled by default*
+
+.. _guest_host:
+
+Guest-to-Host
+^^^^^^^^^^^^^
+
+The guest-to-host attack vector involves a malicious VM attempting to leak
+hypervisor data into the VM.  The data involved may be limited, or may
+potentially include all memory in the system, depending on the vulnerability
+exploited.
+
+If no untrusted VMs are being run, consider disabling guest-to-host mitigations.
+
+*guest-to-host mitigations are enabled by default if KVM support is present*
+
+.. _guest_guest:
+
+Guest-to-Guest
+^^^^^^^^^^^^^^
+
+The guest-to-guest attack vector involves a malicious VM attempting to influence
+the behavior of another unsuspecting VM in order to exfiltrate data.  The
+vulnerability of a VM is based on the code inside the VM itself and the
+interfaces it provides.
+
+If no untrusted VMs, or only a single VM is being run, consider disabling
+guest-to-guest mitigations.
+
+Similar to the user-to-user attack vector, preventing a malicious VM from
+leaking data from another VM requires mitigating guest-to-host attacks as well
+due to the Linux kernel phys map.
+
+*guest-to-guest mitigations are enabled by default if KVM support is present*
+
+.. _smt:
+
+Cross-Thread
+^^^^^^^^^^^^
+
+The cross-thread attack vector involves a malicious userspace program or
+malicious VM either observing or attempting to influence the behavior of code
+running on the SMT sibling thread in order to exfiltrate data.
+
+Many cross-thread attacks can only be mitigated if SMT is disabled, which will
+result in reduced CPU core count and reduced performance.
+
+If cross-thread mitigations are fully enabled ('auto,nosmt'), all mitigations
+for cross-thread attacks will be enabled.  SMT may be disabled depending on
+which vulnerabilities are present in the CPU.
+
+If cross-thread mitigations are partially enabled ('auto'), mitigations for
+cross-thread attacks will be enabled but SMT will not be disabled.
+
+If cross-thread mitigations are disabled, no mitigations for cross-thread
+attacks will be enabled.
+
+Cross-thread mitigation may not be required if core-scheduling or similar
+techniques are used to prevent untrusted workloads from running on SMT siblings.
+
+*cross-thread mitigations default to partially enabled*
+
+.. _cmdline:
+
+Command Line Controls
+---------------------
+
+Attack vectors are controlled through the mitigations= command line option.  The
+value provided begins with a global option and then may optionally include one
+or more options to disable various attack vectors.
+
+Format:
+	| ``mitigations=[global]``
+	| ``mitigations=[global];[attack vectors]``
+
+Global options:
+
+============ =============================================================
+Option       Description
+============ =============================================================
+'off'        All attack vectors disabled.
+'auto'       All attack vectors enabled, partial cross-thread mitigations.
+'auto,nosmt' All attack vectors enabled, full cross-thread mitigations.
+============ =============================================================
+
+Attack vector options:
+
+================= =======================================
+Option            Description
+================= =======================================
+'no_user_kernel'  Disables user-to-kernel mitigations.
+'no_user_user'    Disables user-to-user mitigations.
+'no_guest_host'   Disables guest-to-host mitigations.
+'no_guest_guest'  Disables guest-to-guest mitigations
+'no_cross_thread' Disables all cross-thread mitigations.
+================= =======================================
+
+Multiple attack vector options may be specified in a comma-separated list.  If
+the global option is not specified, it defaults to 'auto'.  The global option
+'off' is equivalent to disabling all attack vectors.
+
+Examples:
+	| ``mitigations=auto;no_user_kernel``
+
+	Enable all attack vectors except user-to-kernel.  Partial cross-thread
+	mitigations.
+
+	| ``mitigations=auto,nosmt;no_guest_host,no_guest_guest``
+
+	Enable all attack vectors and cross-thread mitigations except for
+	guest-to-host and guest-to-guest mitigations.
+
+	| ``mitigations=;no_cross_thread``
+
+	Enable all attack vectors but not cross-thread mitigations.
+
+Interactions with command-line options
+--------------------------------------
+
+Vulnerability-specific controls (e.g. "retbleed=off") take precedence over all
+attack vector controls.  Mitigations for individual vulnerabilities may be
+turned on or off via their command-line options regardless of the attack vector
+controls.
+
+Summary of attack-vector mitigations
+------------------------------------
+
+When a vulnerability is mitigated due to an attack-vector control, the default
+mitigation option for that particular vulnerability is used.  To use a different
+mitigation, please use the vulnerability-specific command line option.
+
+The table below summarizes which vulnerabilities are mitigated when different
+attack vectors are enabled and assuming the CPU is vulnerable.
+
+=============== ============== ============ ============= ============== ============ ========
+Vulnerability   User-to-Kernel User-to-User Guest-to-Host Guest-to-Guest Cross-Thread Notes
+=============== ============== ============ ============= ============== ============ ========
+BHI                   X                           X
+ITS                   X                           X
+GDS                   X              X            X              X            *       (Note 1)
+L1TF                  X                           X                           *       (Note 2)
+MDS                   X              X            X              X            *       (Note 2)
+MMIO                  X              X            X              X            *       (Note 2)
+Meltdown              X
+Retbleed              X                           X                           *       (Note 3)
+RFDS                  X              X            X              X
+Spectre_v1            X
+Spectre_v2            X                           X
+Spectre_v2_user                      X                           X            *       (Note 1)
+SRBDS                 X              X            X              X
+SRSO                  X                           X
+SSB                                                                                   (Note 4)
+TAA                   X              X            X              X            *       (Note 2)
+=============== ============== ============ ============= ============== ============ ========
+
+Notes:
+   1 --  Can be mitigated without disabling SMT.
+
+   2 --  Disables SMT if cross-thread mitigations are fully enabled  and the CPU
+   is vulnerable
+
+   3 --  Disables SMT if cross-thread mitigations are fully enabled, the CPU is
+   vulnerable, and STIBP is not supported
+
+   4 --  Speculative store bypass is always enabled by default (no kernel
+   mitigation applied) unless overridden with spec_store_bypass_disable option
+
+When an attack-vector is disabled, all mitigations for the vulnerabilities
+listed in the above table are disabled, unless mitigation is required for a
+different enabled attack-vector or a mitigation is explicitly selected via a
+vulnerability-specific command line option.
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index 09890a8f3ee9..89ca636081b7 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -9,6 +9,7 @@ are configurable at compile, boot or run time.
 .. toctree::
    :maxdepth: 1
 
+   attack_vector_controls
    spectre
    l1tf
    mds
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..c540e9eb721a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3790,6 +3790,10 @@
 					       mmio_stale_data=full,nosmt [X86]
 					       retbleed=auto,nosmt [X86]
 
+			[X86] After one of the above options, additionally
+			supports attack-vector based controls as documented in
+			Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+
 	mminit_loglevel=
 			[KNL,EARLY] When CONFIG_DEBUG_MEMORY_INIT is set, this
 			parameter allows control of the logging verbosity for
-- 
2.34.1


