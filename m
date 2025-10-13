Return-Path: <linux-kernel+bounces-850710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52165BD3990
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE141881D92
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D742270568;
	Mon, 13 Oct 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u+abPHS/"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919A2749C0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366124; cv=fail; b=VhJLJS5myM0VVUW3ScCL4YouiskX10hfmQgUFez6/rTVSK46q2pMRtBy7YNVDba3kifYt0Iwy3I3vxunTzBkiUR+wl1AWRT3LqikWKrzdGZWvc9rqOX7OcjfCvcKb4w9lXgaI69jrR18q8HbQdlm4YIvUIGvY906Y8CB9cRz75c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366124; c=relaxed/simple;
	bh=HNyYgx3cUteajAbSwvnclOOTLShqCPcufF+EbojvO2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMlPqVx8CjDoz60sK92pjr/m3V54qo87iY61b+wuK/4oNTYziBV5WG/NGKsSS50iVu1SWs/KgtRupbO3jvfjuTiqk5Y/4FLwzZDFfeTTyeelX+nZHjp5EFqGV3gLDtM6PeNtxHtQqh6QxjoCoO8CvhvIB4Qjjc/5glJqSpb51kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u+abPHS/; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PT2LKdl5KBGKUDUQLg3ej9NxjA+Q79BQ8xQ0SkCP7z77yOGJBDLHlixsKY+41fzk7GJTPuVE8E6nILAQ2nNSB8/rFRsrv9zO26gTGSf1P2W23xSYDmCV7ZYdvEdAAEC4VqvB0nmVuyJgGAla0pgT0/GA0mqu4NEszfsiHdsnsD4xMFkmzcsK8/+yIqtcxTaSnXfRBz3gnk245keKyWgy4423i1Mxlhm+lUTpolMroMBtBhQzEEbEgLnnzEz66HTLQzXKBiO27NWgXZr9RMcPg12FnZloltq3V1aUAjPREPWC3zyN/MS6EW0qdcK88qWIedQyUHcacF7AWV3laExSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMBw/bAR7wRRL/mt9K/bCy/gqSguRjKCJabxanQ3sSE=;
 b=uoGtnaJLBo7JsR6fS+FroJ4EfYpIkxf/oK443NDRH0TIOvbkJ+RShmlLmeX4CIfziPYnnGKNs8t8ZKlzOI6gGqrHltf8AhVrQ2BRhA2b6pcae+BL7KqR+peeYaiixm+lQPPuoRN+3yl+L+pEVwmAR7pbX2dmXRNUtqQjIWvHGE9oRogQMBs+HhRNgken2NujHM3gepRvwz458QsraKDC+ygw/4epV4kRHMRvJu0NTVZt00zEKsku+rgwDNue67EM51U+ecMyWt1D0wySlo56q9ghaPEUxJaxfwJlQnmeO8MUzJd6+D5MpGGZw+OAfzx1VWGMDDKudfZ1PhSEUfETfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMBw/bAR7wRRL/mt9K/bCy/gqSguRjKCJabxanQ3sSE=;
 b=u+abPHS/vExdwCau2JViFd1OpV9kQx4KeYszrjy20y0ejsu8ZX1jM4QhGaue+7GGFkQmwnNhnrpqeBhm5vv6/azdfLopXcnIP+JrokB5mSkSoBhiBOkBbwiAI/IcoAxnGzrNB2EttuwD47letdzuqqLYsE2i5BJDVica0QMMGjw=
Received: from SA1P222CA0103.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::7)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:19 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::6) by SA1P222CA0103.outlook.office365.com
 (2603:10b6:806:3c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:19 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:18 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 03/56] cpu: Reset global mitigations
Date: Mon, 13 Oct 2025 09:33:51 -0500
Message-ID: <20251013143444.3999-4-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|LV9PR12MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a119bc2-b39e-41ed-a3e4-08de0a65bc17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dfafey3gE9i9ILnCuypv6At/hImFhliS+G7n4GQqt03XxTez85C5wXT6mOLg?=
 =?us-ascii?Q?sBy8cOwUCJGHMTpA3piGS/nxsW2OGyzZbd1zVJIHRkbnoWIFxJjDHryPcYp6?=
 =?us-ascii?Q?JZyiJprEXPlQZd/sapl/C42O5MCCsNf5TmdbG2TZCOfgF7/FJTq0M6EPldg3?=
 =?us-ascii?Q?P78417TrT0SNInRRiZBiUP8HvQCHSVigk3FMSQrC32wa+xjH1mGZNogO6y2V?=
 =?us-ascii?Q?QSmh+n3cmWgIRrov04VVjs9lMFMwPlqxheXqv3SeYdhkQAlYFJnz0MnYAncT?=
 =?us-ascii?Q?q65vnqzOqu1OiKl16yY6VKLwAJ8m4qP5XQMSgRv78LntJepo280rnCd0SlmM?=
 =?us-ascii?Q?BUDCAD5x0NA3cLeQA9Y3Jezx9YUuR6kn9Z1Okenk7mieImYcD95jRMQVlarC?=
 =?us-ascii?Q?sC+UWMv492kpRlOmDLPs6dJUhnfiSI9z/O2DVTMwwpJ34GUVHsOtXlvtgNIz?=
 =?us-ascii?Q?pqH5zNXRmb1166JFImWen0LIOep9yBYej1gnqGI3Pwiq952LUbpYmPCxXK7E?=
 =?us-ascii?Q?B7AS8X61NwtI1nGB83oAPASM7XnViQqxEhB/t0v+lH32j+CQXcyQC6PCZ8Lp?=
 =?us-ascii?Q?KS98U3MIRt7AvSSrGt3rQx93SzM8KwGVVCGOirZh7D5wHwBdVVMK9VVSC/XI?=
 =?us-ascii?Q?libwePZqlnYqyQU/BswJvzzGko9G5IOn2EIAafi2yVt8Hy1/dYa4NBc4om26?=
 =?us-ascii?Q?D3xrgL2biDmQacQbnvf3QMt1oBwvmzO9Pj/8RleeBC+GfM7L7vMAykL5+tmu?=
 =?us-ascii?Q?aLm1Smc1d0PR7WNmUn+wq97rZdtykQXR2+UO3PwZjFRLNW5a9mPbcO+rScU5?=
 =?us-ascii?Q?AkfniherPxOFQ7k3IEEMQiS/1fjSA+HxVyEbOJau7wT52CBc8DGe3fnOa3wY?=
 =?us-ascii?Q?+xYLx1ItaJ2Yr3qoaiF8a35rmbTLrzT9cwvTkprVB9PhfS1WI1NC1ovtrlZN?=
 =?us-ascii?Q?JpuMK4QEG9plJDCK9gg4iU3xqjcVdR4mfb6AWii0mg0aSz3stpx+mCgfDDQt?=
 =?us-ascii?Q?QBRjUW9xMqkqB65AOn5svos2FOV3xxH0wnPL/JqngfWQe6tFdBSF9NsEwQ7y?=
 =?us-ascii?Q?e4iKW3kOeOdkyj8cRz/Dg/rlIp+adsbUSgEFjNCmwRAl8opGlg7O/3WHqkTo?=
 =?us-ascii?Q?qag4XVuz+q/qUk/28Q9bDg6n9be6nepxA9MoP5TnJVJH5mMxo6xsrdg5FZKb?=
 =?us-ascii?Q?2b6LTDpOQEyfIFGl1n4cTtm9bkUMCIMRHAjzlul36ZnSRF1fsMFKL2ExdLbO?=
 =?us-ascii?Q?v63Ygq89TgV7ORamubVQDJy7EcKgugXEfgVwu/lurMfZx/SWJjM5Q26+qkf1?=
 =?us-ascii?Q?53iVmrY5bfWbMvIiEJ/F8qsUaTl5d114bUGKU4pZTV2Pat30nmR8WrWJnDZg?=
 =?us-ascii?Q?RnL+E3tUh5cAoslx6KmkC8kC8JgJVwj/YRzzyhhYuCZcQ/icgCP1nJgoWjp4?=
 =?us-ascii?Q?qFTPmEXsXb1llRRTVENIFRi87rBky7CmljbtNRMglRUTdDGdk3g38sNfmeQm?=
 =?us-ascii?Q?judagDzgtugZ1W3zwfgVZtSk69ISMX0bZCYtcNN0gnce35paGOIBMxZshvZk?=
 =?us-ascii?Q?hk0h7V3CSeqga8yEBz8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:19.6233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a119bc2-b39e-41ed-a3e4-08de0a65bc17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830

Reset global mitigations, including attack vectors and then call the
arch-specific function to reset further mitigations.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 include/linux/cpu.h |  3 +++
 kernel/cpu.c        | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 487b3bf2e1ea..3da629a76a49 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -208,6 +208,9 @@ enum smt_mitigations {
 	SMT_MITIGATIONS_ON,
 };
 
+void cpu_reset_mitigations(void);
+void arch_cpu_reset_mitigations(void);
+
 #ifdef CONFIG_CPU_MITIGATIONS
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c539b28..910249f6217a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3171,6 +3171,7 @@ void __init boot_cpu_hotplug_init(void)
 }
 
 #ifdef CONFIG_CPU_MITIGATIONS
+
 /*
  * All except the cross-thread attack vector are mitigated by default.
  * Cross-thread mitigation often requires disabling SMT which is expensive
@@ -3326,3 +3327,20 @@ static int __init mitigations_parse_cmdline(char *arg)
 }
 #endif
 early_param("mitigations", mitigations_parse_cmdline);
+
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+void __weak arch_cpu_reset_mitigations(void)
+{
+}
+
+void cpu_reset_mitigations(void)
+{
+	smt_mitigations = SMT_MITIGATIONS_AUTO;
+	cpu_mitigations = CPU_MITIGATIONS_AUTO;
+	attack_vectors[CPU_MITIGATE_USER_KERNEL] = true;
+	attack_vectors[CPU_MITIGATE_USER_USER] = true;
+	attack_vectors[CPU_MITIGATE_GUEST_HOST] = IS_ENABLED(CONFIG_KVM);
+	attack_vectors[CPU_MITIGATE_GUEST_GUEST] = IS_ENABLED(CONFIG_KVM);
+	arch_cpu_reset_mitigations();
+}
+#endif
-- 
2.34.1


