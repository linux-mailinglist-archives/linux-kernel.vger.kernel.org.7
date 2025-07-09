Return-Path: <linux-kernel+bounces-724073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C4AFEE42
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F63C17743F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BABC2E973D;
	Wed,  9 Jul 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KQdsgNm9"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2AB8F40
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076668; cv=fail; b=LR257haSqjNqOmflvzdLRnEBdgZH/Mn2tFSf53Cq0SmJxSRjl01/+++24n3+91oLelho30k4UpS/i7VXlfT7KoE7T0Eelj3+iH9zdQ92Gs5ZI1Jb1BjH25lSezEbMGgBm+9n2qqoQOxBzqAYtly138MjuJDLfPTUM8Hn1BzAVWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076668; c=relaxed/simple;
	bh=hJz/27xDtWIrvZPohyCS8WNkaw/HnQBA8JTruv7J1wE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCuKbHF8v8tyk0kFYJ16iOGpG3xSqghydjmb8Asr92zyfq6BF3VFL2cm2URZX6/qriBBXw+lIULmTvHQOZUAm8fuPy/+nv9uJvN9buC3hKP8orJPelEvNPfbDTyDoDUy7frCr1EBHIWm1KAjjWQetw1vOQ2ENwGrFvHnP17w9LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KQdsgNm9; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srCkU83QgDiE0d8naTrnDdPkwgwv2reVkwxxOZUdYOctuqvYZrE4bZEhi7fALhVti0wX3MyxDDhn6SobffodXGSJ7B5ou6X7HlEqYjJSWtmTAk1ruuFg28kPHj4MJjlD97kVzg32pLV9DpkyKqFrStEkFWpaXmSfyrutGVr7Rd0Q6m5a6P1i0yI8l2yKzPb0jtNHGvqX7OdN7LlArppXjXEIzDBXiIqRtk+Gss2sJJ1Db1vl5UeEWTUvGWH9bLPVb7qWYpRzmWML1zaS3iG2BWDFJ0WLQvaK6Ybdj1esebxRig3K5tTIwlXedx8ykwgoAtOF5yOzvn5SEGb7XeG+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cVo3HQVyj3cTSxJxbIGr+YszWugqzDD8vqk5g2l6iY=;
 b=iX+XEeYVvzpsa/LO7HMdaKz3PgKUEawEdusIMGf+cLCnR4FRI5m+11hLxpypwRrArIvRG76xQhwaQcDA9K0PyRG55elJMFZ5DplDj1EBCxaCpyaV/VNjl8CoqdK4Vq+1B8CONUOFYJDovfT59tfmpNofLpBM0xmbw+FW0jUDXeQS4DX4hiQp1lFEW5WSqI/fQmg8AB/+ijJpZkTgb5EMnqfZoK3yPoXkskjfwYNeNsw6dZ5Tg3BPYcT99qn9GLJ/BevVa9/B8C0WgL9ad/DJ7Q0rsyjsLRQ+kOaoH2wn16eaTnjjI/5BKTT7+5G71hhxd/0uy/sdtJ9V3iopJfVVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cVo3HQVyj3cTSxJxbIGr+YszWugqzDD8vqk5g2l6iY=;
 b=KQdsgNm96rvDEOoJdvyIsuXHhmO1TWxPTuNZzZSUUKhhWKglgAtoFmU4IuyEqsMRXT0niJQpLnLZucwbJlJJO+V15urnZ0ns5AZ1uV6zgQWiyeE/5mEH/pZfK07qAYHrk3GYy12NSvUVPfBDx2GK+GZyaaEbHpv7aLqmNFWwdfA=
Received: from MW4PR04CA0310.namprd04.prod.outlook.com (2603:10b6:303:82::15)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 15:57:42 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::df) by MW4PR04CA0310.outlook.office365.com
 (2603:10b6:303:82::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 15:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Wed, 9 Jul 2025 15:57:41 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 10:57:39 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 01/22] Documentation/x86: Document new attack vector controls
Date: Wed, 9 Jul 2025 10:57:31 -0500
Message-ID: <20250709155731.3279419-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707183316.1349127-2-david.kaplan@amd.com>
References: <20250707183316.1349127-2-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec76d51-ddce-41fb-0f05-08ddbf015632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ksd7sWvPbn3LxdLUrD5TlGKjrNf5jXGHDCMjyCBg1g6O9Pw2S6qbKDMQIAcJ?=
 =?us-ascii?Q?IrcHdtO50RWSqjOAd7LZTUa/zWVx4FXJWWpTnJe/IJd/H4EOCI4J3ShlSpgZ?=
 =?us-ascii?Q?PGqXNif4I3dF3CKPW0y3o0NLiq1hSX1rhK6tQ8ywF37ZAVFJUzrLXe1+oEyL?=
 =?us-ascii?Q?WHQ1oSxQlrVYEQNsFeFQ3/TVB/g6agyp4ng14DasgX926S4pjdKLAi9F0xcH?=
 =?us-ascii?Q?JcoLt1ESDjCRBCHcTT1jMvtBi70W/6igu/uhrMe+O6gDp7i/Iez2aLCel1W7?=
 =?us-ascii?Q?LLpcTzxHDVku9DuWdmBHWTtC4YApPxfjC8MrMdloUvysHpsIVxkrthIaW+N3?=
 =?us-ascii?Q?gPszOtCSAz+YCCgiEu6bNRWsLqwHot5VfOjfNR3ZDzCUSferIX77NewiEpUm?=
 =?us-ascii?Q?OEON6+PWOOrZaDDroHB+DAu6f4H3kmdSjYmBKm0BRdC2VpI90rwfhG1cnTVH?=
 =?us-ascii?Q?bt+ILHjlUMU8BHn0hwptw0B1MaM4eI/C3+xn00CFFqk0zbmPwsLjun047Bkz?=
 =?us-ascii?Q?G/ectSWBC0FICx64a9mFfo/YNfQF6hg6kCX3UoAHWnvWudW45p+SAYh9H9IR?=
 =?us-ascii?Q?sp/vw4+V/+YxGJwzFeQ6Ljg5mC1dcvZbJMRvycMBB0295TV43XbNaAlC5/j0?=
 =?us-ascii?Q?5HnIf2JOJI7eUlCk12BmKSiXXx76y3bM5yYD5SHlnygKxWgMa8rsGu6G1D56?=
 =?us-ascii?Q?e+dzVjThZhSEy815sliWjlv8epybkfAz4JeLYX7BWLxynOIl3NJugcaAJf+P?=
 =?us-ascii?Q?ajqorbhoZAXEgddlQEiqaKQHHWo+U3yQWTVhBLNAAWSk8U/QiuapGzQyLqiw?=
 =?us-ascii?Q?yPIjwkMSlknpEqczKcaDMl3bR/15j6Cbi8KDeGoRNmwV4Skae6D36SsUIxHv?=
 =?us-ascii?Q?o+KxECOMlwxqesBnidjsqxLRLZ9ZHVlHx9ULJ9By198TWw7Mz6jivpCl9R3I?=
 =?us-ascii?Q?s5RAINRnhFFrYladMTB7zl+LwHvg76Wt20nOIlBFxAp73PHnP9uXzBwul/oD?=
 =?us-ascii?Q?GBsl22qvPqWFobYi9niCOkq7Ay6Lw31b8oI0Dx5XQcW3a3TuGPXhpxcGx4g9?=
 =?us-ascii?Q?MVJZKnioO6Kz5ez0BKfafG3gtajPA78jbE3KhMGT0zpH9iTUcUGTlBrdguXb?=
 =?us-ascii?Q?QlqLDxmjQ1TS8gJNSDQnhJ0pTFgwDQoElvnQnqwOtX8CqlV8i6Vi4t/vahiW?=
 =?us-ascii?Q?HccXvJB4GI5QRroxyCbCPp4QJH8jqdw+oj7BsaB4rUtwidEkz6L8le671dMt?=
 =?us-ascii?Q?ddxuafFiED5UgCH8wql0Ttx6QxvYzUBXT54BA2RBKyBQaTiaBIjuxd81S2KA?=
 =?us-ascii?Q?bEfR2Gah/4dg8b3wCLsoBMIYHsB7yfhLQ9Ia2FPHeGso904UhYQhlNf+akWm?=
 =?us-ascii?Q?Ho4cbOYvFqi1O5deSWNSTyuUtbXatkwEuyK5V5u+yxNYC5TN/jCYnWHGLk2+?=
 =?us-ascii?Q?ELqr0j82nPzt3ByClZSEF37aeYLj1ZrpELiazxDzEaQZn4nCdVMssT9T6vIU?=
 =?us-ascii?Q?Jgh/U4I1KBAnaA3GiTG0obbna+INymOQ5fEV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:57:41.7114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec76d51-ddce-41fb-0f05-08ddbf015632
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049

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
 .../hw-vuln/attack_vector_controls.rst        | 238 ++++++++++++++++++
 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 .../admin-guide/kernel-parameters.txt         |   4 +
 3 files changed, 243 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
new file mode 100644
index 000000000000..ee56e849616f
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -0,0 +1,238 @@
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
+TSA                   X              X            X              X
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
index 07e22ba5bfe3..baa1d6ad1dc8 100644
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


