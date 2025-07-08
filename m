Return-Path: <linux-kernel+bounces-722445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABADAFDAD6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC237AC0CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6909925E469;
	Tue,  8 Jul 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YrgB4Q98"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3F25DD1C;
	Tue,  8 Jul 2025 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013143; cv=fail; b=S6yrVwj6pGELIYg4AWw3JcAhOJlk/DBZqmpl/BN+FjjCQ3TyrYTM+4POJmZAf3ZIoqDv9mJDeT7dNnSh6qJOm/jQlI+kfkFvvR3p0hb9GkSH1b/eELuHzabbiB2+sS9E8WidJTGdNmc5epgM+SL8n0edc2mDc85C3XitELGowGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013143; c=relaxed/simple;
	bh=CNFjjOWSxtVJ+OGI5fye+geLqeDD5Kh91vwfiS0lyNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5/8JVDYtT7HqHHxQNEQACOgh+kihd4ohVcBStYt+ZkQrln1hodiTUzMz6zwBMMd6C9VeYgvWcTpsyL1F88sdFJg0yvGbDrNgYR2IXwVkHk8vuDg+gnnhqYI3Rkqkv6qVNsBODJDAgHk+5UTomt1ZXrgZnjVUqsKOqJ0Kn+uXGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YrgB4Q98; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tev7nbQmut2Z6tynp+LlMOkJd9u7fwH+0xqZbo4L7wzYbodZXjuksRE/czbHAgYeZaIiu3k5U3znVng8AvT1/HcEYHZrqFlhXRzn2qF6OGeYcr2Kd8rNJPUCVT5jo//VvAEYNLJC7txNM1fMUbS/38gRW7r1NGZ+6prHOTIjLhTyqp9L7tHY6IeYuA5Rby9guuZBHEBEMEecV3WlVhySdAS/W7TiY+Fhsvm0patKQLjA6KVDul1pBEE8e+NhgIr6u4vUXPZHXccOUtbgFgtoIq+t9OZQ4EWCuUdyoaKhkS3wg4szTAsHCePs3FaIjjYq8T7GCknq3tcmxhkgoQkjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSuhTyB6ciOGxV2cbicFXYzUEcn7Cq4/nPyDUIF8XNg=;
 b=KNYL1PnLWTMaRvVwK+FuWuvohfAe4Ddr3hmaTO1Q3bPS6dbpvvcaaMjfFxYqCm0o+jnZ3bb99sAXiTFJn6TMNorZHMIbr9oOMGwcFShBK5Hc3e3Ky8fj9DlIboiYs9It+6x0FLneyntqXz7FsaLBg4iismwa2BZWOKgYMojbIBJjvAaBvGCvGvql5o9+a7l1btQw1FfZ/QmRLrioIhNKsYZTHZzpksf1wUB8BjCZhGzeVknOladOuBqHOiPrXf2TCKT13IuT0xZtwEyVMoauPzfMUH8hu47v3pjBOYrwOagMEsVc4T57g+GbrZZXKDO2ipqmFUFJ5Nb6vmgfEeRzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSuhTyB6ciOGxV2cbicFXYzUEcn7Cq4/nPyDUIF8XNg=;
 b=YrgB4Q98BQMWzxC7h97FjHo36k+e8mg6/U8Rs+Qh9my1T0c6/KpIbLeRqIGisDhBeCIDzOc6y91XBcjCGX2soqkX/ZJ9erIUrTXRKhy0bCel7Mh0EmVt01gaW6OO1jUHsbxIxRq9XMDNBS2UN+UWShrMkFprnudSkfot1UfxeSM=
Received: from MW4PR04CA0204.namprd04.prod.outlook.com (2603:10b6:303:86::29)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 22:18:53 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::27) by MW4PR04CA0204.outlook.office365.com
 (2603:10b6:303:86::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 22:18:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:18:50 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <babu.moger@amd.com>, <tao1.su@linux.intel.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH v15 06/34] x86/resctrl: Add ABMC feature in the command line options
Date: Tue, 8 Jul 2025 17:17:15 -0500
Message-ID: <00cd603997e3ee6a389f83aef066fe7313b1abaf.1752013061.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752013061.git.babu.moger@amd.com>
References: <cover.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 48779d2d-8702-4d4a-b80f-08ddbe6d6c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RsAKgtiCH6pSVNH7xL3BH1nbvc/JmPpxvp39bz4W7EZGFSXd7M5b1BBkhVPj?=
 =?us-ascii?Q?JyaQtDBfcIn9FLLT/TwmXQIsXDJ7xILbgDSN74D3xr1OIMpnJB4vnEVun1To?=
 =?us-ascii?Q?lwUNadrUiMPI0777snsR3bL6nNcS9l+kffs0k9tf6PKTV/bHwzfIAyYxtmjM?=
 =?us-ascii?Q?Sx9A2CS4PiqITlEcGD7w+7+gHXl+n1Gwr97eimisRIHFH3VmgYrml9suXO1R?=
 =?us-ascii?Q?NJ7uloxbzsAMyfxGOksrvJeEoNfGsPomOmXsUm/Z2tplYuC01AOzz2gd0Fpx?=
 =?us-ascii?Q?aas0qDo/BocndmGBRHgVod03b7DtYLUC0ftEybXHRc43aCkiSB1m1iqtQh3N?=
 =?us-ascii?Q?a3DiGhLmJBpfV3Eev+OkIq5vRogYZMjMmhZK+wauCwm1MBrDZCh9e5JCllRB?=
 =?us-ascii?Q?AdqFOjzPQbTmgkvFgWn6/dbrc3+3I3VnM0wZnynjjFnPAz9Z97c5ShT1Ynuh?=
 =?us-ascii?Q?s9MVj3CFpvjUl0QAzsbC0hfAexiWVxR9ysZew4VGi80uGrGevz4Ige77tT98?=
 =?us-ascii?Q?hDtdxfdYs8eVQ0ahzJwJPsrpdmc6RerBNZHtJZLdjnBuyX6HFSRcYQvT9R6/?=
 =?us-ascii?Q?oHbAW7hKZahDUHVmTzAMwqFAF8NVSTzSKe1tnNexO7YF7Ei8rIgSTluJpPBG?=
 =?us-ascii?Q?c7XA/OP4wpEqMqZQM9ZfNO6/FtKlxEJKTlV8XGebW5MqYfZyvheca891ghpp?=
 =?us-ascii?Q?Jq/XJm+/r1wderRTxDMEWDPBxl9W12umgcjZmYlqmzczSAhBaAgwK1OfWj3/?=
 =?us-ascii?Q?9Obw521rn6sdx9VIxLkv45Mj2xZCYf51/4G0OPtD8GlM7ckgQ/nNtIiwYsuQ?=
 =?us-ascii?Q?YDoT45yUAoCt5hoGfWsDTj82ywLZxoPPvVfxNGOGXaKKjEBkwYlAM2c9AGKs?=
 =?us-ascii?Q?2PfX/Xo+Cv/xqpkfY38ph9Au2fTHoeLY8Oxq6GJjw6KFnrtTRWMMwW5X6EZ+?=
 =?us-ascii?Q?fXYP3QLtJPGYmWu7rQ5LmduhJTM8S0oIcSE2b7p3nWqf4EGlOIsyGH4faJR4?=
 =?us-ascii?Q?gfwF4uowAf4huw9+feDudXPpZE80qi3DqlDmmk+zq4/rVpoJGRZaQH68iv7/?=
 =?us-ascii?Q?6EAVcGOFJubk41roTf3bODn/E1bR7B4YNmKv5aZHTFXNNfL+mMsB5zVul4lE?=
 =?us-ascii?Q?uw65Sf3j38TiDG1txnw0t8DzB7TPkHF/329byFyssKZOzCArRv6TvBr32j2n?=
 =?us-ascii?Q?hqqUR3zvX21L+9N2SnfGE1xkdNPhn/vLRkzc2O1Ty8Ry5a8WsMSu0oDq31U4?=
 =?us-ascii?Q?3FQlM51zmwb9ZSeK8AjgTJfXbCSsgXNVxSfLKcg9xwUGvlX3O0cExzJOF2/S?=
 =?us-ascii?Q?d1N+v5J+YIGKEKdeEEr2g0aQjW2GbHY2EndCsS5YK5Y2AemkaLz1yD/j8mwI?=
 =?us-ascii?Q?Hf0SHPIAnkOe7fB1gwKm+dWqvtuU/gjaTFRk2JJXaaRVTIU+Yy4JxKlBzVrf?=
 =?us-ascii?Q?viQX2lFT2Os9RXAN0OvQPyUw6nxD8DXbyqDBxWrioLKZNkiP5HAFPp/+Ke5p?=
 =?us-ascii?Q?3//BaHmLciOMH8tvBI0u74J7TdEYpNnmJkAB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:18:52.7899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48779d2d-8702-4d4a-b80f-08ddbe6d6c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725

Add a kernel command-line parameter to enable or disable the exposure of
the ABMC (Assignable Bandwidth Monitoring Counters) hardware feature to
resctrl.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: No changes.

v14: Slight changelog modification.

v13: Removed the Reviewed-by as the file resctrl.rst is moved to
     Documentation/filesystems/resctrl.rst. In that sense patch has changed.

v12: No changes.

v11: No changes.

v10: No changes.

v9: No code changes. Added Reviewed-by.

v8: Commit message update.

v7: No changes

v6: No changes

v5: No changes

v4: No changes

v3: No changes

v2: No changes
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/filesystems/resctrl.rst           | 1 +
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..f2f2511b0ec3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6066,7 +6066,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, abmc.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c7949dd44f2f..c97fd77a107d 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -26,6 +26,7 @@ MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
 MBA (Memory Bandwidth Allocation)		"mba"
 SMBA (Slow Memory Bandwidth Allocation)         ""
 BMEC (Bandwidth Monitoring Event Configuration) ""
+ABMC (Assignable Bandwidth Monitoring Counters) ""
 ===============================================	================================
 
 Historically, new features were made visible by default in /proc/cpuinfo. This
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index fbf019c1ff11..b07b12a05886 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -711,6 +711,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ABMC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -736,6 +737,7 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


