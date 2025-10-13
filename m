Return-Path: <linux-kernel+bounces-850712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 127B6BD3A15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8075F4F43BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A62EE274;
	Mon, 13 Oct 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GIowmWj7"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F826E6F6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366125; cv=fail; b=AHj9TDW3vivkJk9MQKJxDgUvhqhYuLLmbE+ZBsu/ftB8jF0M5uJqs21hSBIzNne4arPks9P8K4Aff+7O260XR2+kOx8614oBwXZL6FbGZtT8l4a09s/L8ql3Y0alfOU4tn5e9G/rOqe0nZMpYg1syANrxvQsgR6zMP0XxNes30s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366125; c=relaxed/simple;
	bh=1nnNB79xOxDWbpVNngLHrcdy1zdGNy3DMBjB/J0T8Q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcKe2Msbx1sP98MxdxuhEit+MWNLvI9CVBw0DHDR+DWSHR5+fCiGm5pV+J+rfbIRXAWmTpIP3ZwBQIf6uVGKiHz5MrPVAXn30CXSc3SmhpsTvKcByprZ8xt3EXcqDL5yS4MW3SM6KWqDWmQK7k6outnOn2XFhaqnXSd6pBiTVZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GIowmWj7; arc=fail smtp.client-ip=40.93.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEkkkGXk/iZVDUiikCuYF9xubpQ8Bt+0v7+k3cEqFVPvSiVEB89+4c329RG99LsOoI6QbdylQ113MZnxi26magt8nQWTpUyLQQAZgeVGY3gPFPLJVjRYSyq/oCkq6zLDCojJ1UCysuvD46ysv174Io9SwJBYUIQkXiAEmXRA4bAmKLlB8ZXv/bNbds3TDk0ChnpAk35veOnKJyNoq061zx5RTIGDKclmFdW70pvEclliWzsVXOO9FmghiZyZEvhJ3BmUyWUBjy7SoQlepXFHStF3ZuEd8oamGrYV0ik2ai8J1E1vdEW5YM/8Ey8R6GNslCoQx+Ij2yezwfwzDfahaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxWbTq8BB022Iq+WPAzr6HIcvWRzdT1IoOEgCcruR1M=;
 b=soyqLQbzfrOkpr73lmbHfFj2ebwM3f0Y3lDR3o2EttZy216A1np+u7GFtxTIaqK5z/PKxMFI0XUDavXEnSEaOppDP41kf8xoCV6Nr0NJKKCZpIrWZ4/tdSKbWVXLv0xpxYl9tcYT7YEjU+2ojyjQFs7JJWtEL8HDYqDjEi2+e2TQU5sVs1WvRi9duFnwsTwHnMDIrwSmmWYJzl+tBC/48tVWRyJ5tjl0ZHUZWlXa9GTDo2X5eCF6JNAW/W7l6hKzjpUH7jLkLwT6y9wF61VvUEHimqh1WOTNLV6WRueZStFsq01p7VS3riOmC2pSi+oOTUXPLkLhnSnc4J7G5oGJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxWbTq8BB022Iq+WPAzr6HIcvWRzdT1IoOEgCcruR1M=;
 b=GIowmWj7z1Jak9tH+gPrD+qaELUjtb2xL4+CBYPIh1PhqOQfaRMXMWhM7NGHsyLLjhqrwRGIXGkoX+iTWDkU020Xs3HP+aNdaFUk0VMlopNXiKD1oWDCSpLI10JSgMSco1Jx49zPTt1X46AnCxxGml/gFYRMLcQuGyZPtzZ1HwE=
Received: from SA1P222CA0116.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::20)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:20 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::fc) by SA1P222CA0116.outlook.office365.com
 (2603:10b6:806:3c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:20 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:19 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 05/56] x86/bugs: Reset spectre_v2 mitigations
Date: Mon, 13 Oct 2025 09:33:53 -0500
Message-ID: <20251013143444.3999-6-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: f393a5c7-f586-41bd-8fa6-08de0a65bcb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ntmIK5VNrCZPXG4F1WniqG97zI3LECdUwqPGpQVLq4Pt0ZRyeB4fzl0ul3/5?=
 =?us-ascii?Q?kVG1GK2LQqLOguhtl71YRiENnp0DnwWHCwaDv1K5x0T4s8nB4LU636AAfii+?=
 =?us-ascii?Q?kkC+J7+smklzI1evoY/UUll+nr8/wRxcbU1XRRQ5T3nDt7JrJgDSfDc82DZ4?=
 =?us-ascii?Q?aHuzgRY0zm8En0a39XaJmA9qPEHNtuRxrB6Sz380Wnsrk6ciyXeodvJHZQIG?=
 =?us-ascii?Q?Gta7bALCo+KSzDB0v2vVjAtrU44/N9TH9nhoN0/XpolrXlQiUydKQarBNdU+?=
 =?us-ascii?Q?mhNKp6PfZSxPO9a/i26SGJrXYI2AWEZnl0zs1Lv80ExyaUJif9Wn/aDWvgo9?=
 =?us-ascii?Q?yvYnn924lg80xZh4IX8UgAsq1QZ0Be3wYdRZRbxi20Za5+wbxhq8ii0M+pMK?=
 =?us-ascii?Q?mz7kEIHMnubV88or8UFsqZwM5xkx+zgTnbomwqAmnFxwxO3ObiphyDuH6Ssp?=
 =?us-ascii?Q?9H+fBW4hYQBi3Nfasd2zKn6zB308PTfAB7zAHlfcacXoviqB47K7R+Cyad/y?=
 =?us-ascii?Q?vOhQzfRiYClZpzr9EC2H/n0tQlnv+InIIiv7ahfNVzxQQnnZVXKELMde/xLe?=
 =?us-ascii?Q?8lsYrDakGrj6H1QGDLZPI+m2K9ptz/663gR5vSQiK8+pd4nQlKLOTjO6iI1R?=
 =?us-ascii?Q?G/pkeCkIDv6sg0XayhJwrUAhibMBdHjI0HmguxFAMuxGBAzlRsit7Zg7LjXB?=
 =?us-ascii?Q?yA3iy1FbMi45z2jmSXg8gYySn0HxOXLxstK7/zafWC8qhYcgMnkXhHMgn5BP?=
 =?us-ascii?Q?IGGzAsJJB9TZOKffrRTLkIrsJLkEx0c80fQ2k3ZOqqt4ay1LH8tBPgsgTIi2?=
 =?us-ascii?Q?n8W2m5yQh0DUnYsdQspMPhM5MFKjnerMvPZby1LGOi1GAGyQwTeWNPDP1Wda?=
 =?us-ascii?Q?kTLUY5yzdiCpD2aNsg/khL8O+jeQ0YJpbzdHO+RDGh8QzwooyLxCEKrg9F4m?=
 =?us-ascii?Q?cHHlnglligiI1WMidWUg3QW4kk9/A/mTOdAbihNlGxvhRhQmnHamzB/ZfPSE?=
 =?us-ascii?Q?yyD2wr86075oTwTZWQicCJOaaSoCB5PYxy88cnxBhpLHZ9itsbQyMR4neNJS?=
 =?us-ascii?Q?JoKldsCVxFmg00w8XJ07n7kfDZcp0riP3TCw7qHaoIwggrBvVnfkT6LqcTTc?=
 =?us-ascii?Q?HOFVUxR2kJZkuShFteXIuhkMjcuP7KHyT14uJ9quEIK3ide3toG0PYOh1vo/?=
 =?us-ascii?Q?KDVwVdBCHgTaROkWEpq68FcDX/IuXs5DNv8hcvuhEnqckdpsN/r9cJiQFyNx?=
 =?us-ascii?Q?W0ZuBRSNHPEsnZepICG7b+ezYFYui3WOWg6qso7uZw/YJkr+g3527OBfSfPS?=
 =?us-ascii?Q?6X+VMSVH5ef6z3BdpSsRIui+SY9YwJWnMy0lgNE1q3N1H2xMCoy9o4TUe6Mc?=
 =?us-ascii?Q?FTxVvSiq1M5ZG4+6xREs+d1f5Eiod2c5AhEjqkE8B36JrhIvnqTed4kaq5XN?=
 =?us-ascii?Q?lnJvmuaQ+Tr939wWpZyKEO4y7OHIvHyKSxXtaJixe76LMuT2yqUn8ug7hKaP?=
 =?us-ascii?Q?95aEmda5PaIQbeft9SnI17SOIdYJhfAnRr0TDwIHhNExXNaRkQ5fWpMgVF3z?=
 =?us-ascii?Q?E2f06tL23eAEdsFWrlM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:20.6707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f393a5c7-f586-41bd-8fa6-08de0a65bcb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

Add function to reset spectre_v2 mitigations back to their boot-time
defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9d5c6a3e50e1..0430635bb17d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2477,6 +2477,24 @@ static void __init spectre_v2_apply_mitigation(void)
 	}
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void spectre_v2_reset_mitigation(void)
+{
+	x86_spec_ctrl_base &= ~SPEC_CTRL_IBRS;
+	x86_spec_ctrl_base &= ~SPEC_CTRL_RRSBA_DIS_S;
+	rrsba_disabled = false;
+	setup_clear_cpu_cap(X86_FEATURE_KERNEL_IBRS);
+	setup_clear_cpu_cap(X86_FEATURE_RETPOLINE_LFENCE);
+	setup_clear_cpu_cap(X86_FEATURE_RETPOLINE);
+	setup_clear_cpu_cap(X86_FEATURE_RSB_CTXSW);
+	setup_clear_cpu_cap(X86_FEATURE_USE_IBPB_FW);
+	spectre_v2_enabled = SPECTRE_V2_NONE;
+	nospectre_v2 = false;
+	spectre_v2_cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
+		SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
+}
+#endif
+
 static void update_stibp_msr(void * __unused)
 {
 	u64 val = spec_ctrl_current() | (x86_spec_ctrl_base & SPEC_CTRL_STIBP);
@@ -3810,5 +3828,6 @@ void __warn_thunk(void)
 void arch_cpu_reset_mitigations(void)
 {
 	spectre_v1_reset_mitigation();
+	spectre_v2_reset_mitigation();
 }
 #endif
-- 
2.34.1


