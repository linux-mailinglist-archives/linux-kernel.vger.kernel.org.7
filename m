Return-Path: <linux-kernel+bounces-850729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE13BD3A48
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8C484F81C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CA730C36E;
	Mon, 13 Oct 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kXL1Zc1K"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78A2798FA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366153; cv=fail; b=VgeqwEy3Bj3xr582VpckeU7Yt2+ovBPzaGiaPzHX+mIOiSfBMHrY5QYo0rlc1CmOU2Bpj2ox0rZd4cNXhpAYg9LghydZCrrys3XYYRCD7LzhKQOfWnU64h49DZNyH0kJkPif2oqTMbwViRQTvO6I6uy6g8vatXWFU9CBPR1SPqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366153; c=relaxed/simple;
	bh=ru5Jzgp6+euHSpNlCRPuGaj61loc2WN/1y+OR6PAQvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evyf1YgpzYxuA/lmRzPC/5U25r3KW484zF1ifUS2+QIZXviomjqvLyBTW0HxQzsUSm0a8h7n+voo/17Bbk1fUR+aCSwh62oyw6hmY6n1+jHBcsvLtRdEf77nUzWOz9Lnptz+GNlQKxiRlYqbO4FwYxt0xlSDpjrXyW2Al5UPeJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kXL1Zc1K; arc=fail smtp.client-ip=40.93.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEV70GSpn6I8ri2xeigqp0QOd6HAqApnw7tlmsPjjMRlO5b3BNwVmp7qRn6ORkZP/yVvIZIu9pHfUnerVBKV3ctvlNyN/yEAyhNFKEngc6m52IN6f11JtAb66F5sXG1sEQ2VHG9++B6u0Xgqy4z61sgYcrZdL5reyEvYsjkRUKWv7Y3miEvoObc25m3kd+3ajabGqQBqKscAFUS8zKE24Bua4S1MJEmkLc5U4+Ez2yYRRmEM3Yjrb45uvslf88ZXEQS8bxZlJ2PcGdFn2tJyowE4Y+G76fLK1yLkBs3Y46BEMLDcgQ8tsYSM/3ipw28kzUjPbgEQ9Aj8tfp+TCb2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmTNeuWrHIxEgiREMxaAEKAs82iAZrjAf5GBd/LCHVU=;
 b=sXnlK9BkngWyAu3NSLiWiAw7V0qjFURy6pzBfWKNbIpkrq8CY5xA/8U2732EvFxItE9Ho0fZ5oKePG0zTDeiE1iJTB7KoDSruEo6z4zAzWgEpPAbbrDMpo7hU8U6Fv0pV0AaPj+Uh5gorQ1dxxW9TvIG86SaHJ2VAtvdSk4bZh5jbHWyIc1tur0lIbl1qGESNECfjxCfWeBf27i1/31SBBGW1MdtiMdfsFlZalFCrkaWNhyZWHAwNfjpx0jtRviEoMQP1Bx8Tsy0uvfoD42HMZiC1RGWdm6rEUQNX8DTtzHzz7MbTXeSR/oE2v5GuhjtpSDoaLPT7SErbQv8cOIUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmTNeuWrHIxEgiREMxaAEKAs82iAZrjAf5GBd/LCHVU=;
 b=kXL1Zc1KeuZWLUuj6FjxO7sUpOtUlvPINEG7jRZsude1qllqloXR9y3+ayon8nrKyfjfAg0rcox5yARf8czEOpTg30+qW6yXKHQzrBVgzCrZpmu3zPd9sMtbOD+BTTCctMxOPvvY5TY/ZrOtFChi1aFzj8V7sbN/QmqJLhZJYiQ=
Received: from BYAPR08CA0072.namprd08.prod.outlook.com (2603:10b6:a03:117::49)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:35:48 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::a2) by BYAPR08CA0072.outlook.office365.com
 (2603:10b6:a03:117::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:47 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:31 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 20/56] x86/bugs: Move bugs.c logic out of .init section
Date: Mon, 13 Oct 2025 09:34:08 -0500
Message-ID: <20251013143444.3999-21-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 168889b2-1390-4777-fb48-08de0a65ccd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llix9mqcFcdKPTUiU8kME0NVcD+TTPaqpGyYGWvt9S0iM5IyoL3t2GmlG4cP?=
 =?us-ascii?Q?ut3WKKntJEIXnnRq6/KGJvbtwf4Y1TFuZBDoeF5X/sxrCPVIcT10aDeWpd0i?=
 =?us-ascii?Q?WSVSfCf52z3EeRevgR8cFYiW34kbHg2Ic5Nj3oNt8GZnV+VTf8TsgJ0VDeRe?=
 =?us-ascii?Q?FYVScZHivZoIHpAE8ex9D3H720YntwxdPZiHCb4K8sfLqzStKUjN3hwB64O3?=
 =?us-ascii?Q?Yh+128QgfSLI4EeooKXRQzUYvciG/Sm1iHUmscNPPnYJ8yG5PYTQdVV4YckJ?=
 =?us-ascii?Q?I0rtpxgbv207tt2vW+yKG5yjkViIhBWQ3+r3g+eA5I6LFAJqU+xWdgD2GxIU?=
 =?us-ascii?Q?soRoDsP+z9j99Zl9+hTtPo5zaFXPRv+0zZTODo5OyDFPJcTBR+oYYVKU9ZtN?=
 =?us-ascii?Q?GxC6HnH2Y+SLZpzm5HVbmfHLXYAhNrW9n1BDBiIGKBdTYpf8WSf5B0lkzBXl?=
 =?us-ascii?Q?7bUocXh77rITM0UPgfHrff84m7cPoBp5cHptoPij03meLMYSs5HQeVXSvA71?=
 =?us-ascii?Q?Qq4SKTYzEIHJh5wnCoIMw58v+7fw95EnuDoyxh5fpLozI3syhomqlbFAs0GH?=
 =?us-ascii?Q?IBo33/JYDJ6kUI6DLxDWyHR050NsmA5aFBY2HEb9oLahR2QleIyecAVQWQvM?=
 =?us-ascii?Q?f5T75nXtu4wiNP4TomJjnskcwFNMqEwwLLjo2uVdH+POOEeNmg+vEoQeYan/?=
 =?us-ascii?Q?f9zbW2MLIE8helZHvje3ORAODVXgXckZ4+rJR5/UvGCK/WdHY2gl4syG8OvI?=
 =?us-ascii?Q?SlDJBjcF/JWNpzucb2cLeyQj/htYOx4iZqUc7F3jmfCSFvGJBHGBObzyhn3M?=
 =?us-ascii?Q?lURASVyxBB3Osj41KDcpVSzzY4sDGkuJXgFXtvg9INYlWTFo7I8+oVyjEH2b?=
 =?us-ascii?Q?lN+lG9fruW0n+jSmBrfaiY28k5njoxLbP9t+ei0T8qB/su5Tk45pfWtJ/vbo?=
 =?us-ascii?Q?ErrMzPcbrbZZGvePUJY6+IUlUHm0h711+E+t/UGUyPnQmF5XvnwPyldOdGue?=
 =?us-ascii?Q?M90lD0unvDRcV2gXVRoXOYHTWr6JRCrcNA8STQ0jnNWzc3doauptkcfH6+L7?=
 =?us-ascii?Q?tFj3GcC/gIkHGNqoIh8BAro4HbaAAVRspKWh/DCHsKCCCn3iYSt5BCBJ7rW8?=
 =?us-ascii?Q?b/MO3yihqXwZQI117ZX9IgQysItjy9lLKtA6KzYap55rFozC5wlGqZ620EDe?=
 =?us-ascii?Q?VEX5OZcJr7t8m90lIAMkgl9xQPWZHgX6XGXKQv7nvo7wZ8uoaShI859xEoAZ?=
 =?us-ascii?Q?MBBrmxzwsaneeyKU2iHZrcTerLjgZrrRFCF0p2gTPqHW+gy8jzSSj13pHB9r?=
 =?us-ascii?Q?O4K0OiBaVYRygPyV+kjBOoR/JSVPAxM5DlYjNTdH6xQmzvvOO+CVL/3aRo2U?=
 =?us-ascii?Q?UJ0klTPnQb1J9mnbpAlochFYLU83srluc+VTFf17TCApOFmvhNRrx891JhkO?=
 =?us-ascii?Q?SzdzPQ4wzj8h7f/WRIDu1oJBrVXnFwOh+dZMam4xysT7AOHvqHxD2thdjxrk?=
 =?us-ascii?Q?NnO6f3CgYK4/9YepyvEgeg2UGtlyK1l3z8H/3MFdXNT0G/g7AyfA4vgUjXom?=
 =?us-ascii?Q?qR2bvV/W6zY19OQHkZE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:47.6186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 168889b2-1390-4777-fb48-08de0a65ccd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

If dynamic mitigations are supported, all the mitigation selection
functions and mitigation choices may change at runtime.  Therefore, none of
the functions may exist in .init and the data must not be read-only.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 312 ++++++++++++++++++-------------------
 1 file changed, 156 insertions(+), 156 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6cd7198f7dca..06061bcb08b8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -55,52 +55,52 @@
  * mitigation option.
  */
 
-static void __init spectre_v1_select_mitigation(void);
-static void __init spectre_v1_apply_mitigation(void);
-static void __init spectre_v2_select_mitigation(void);
-static void __init spectre_v2_update_mitigation(void);
-static void __init spectre_v2_apply_mitigation(void);
-static void __init retbleed_select_mitigation(void);
-static void __init retbleed_update_mitigation(void);
-static void __init retbleed_apply_mitigation(void);
-static void __init spectre_v2_user_select_mitigation(void);
-static void __init spectre_v2_user_update_mitigation(void);
-static void __init spectre_v2_user_apply_mitigation(void);
-static void __init ssb_select_mitigation(void);
-static void __init ssb_apply_mitigation(void);
-static void __init l1tf_select_mitigation(void);
-static void __init l1tf_apply_mitigation(void);
-static void __init mds_select_mitigation(void);
-static void __init mds_update_mitigation(void);
-static void __init mds_apply_mitigation(void);
-static void __init taa_select_mitigation(void);
-static void __init taa_update_mitigation(void);
-static void __init taa_apply_mitigation(void);
-static void __init mmio_select_mitigation(void);
-static void __init mmio_update_mitigation(void);
-static void __init mmio_apply_mitigation(void);
-static void __init rfds_select_mitigation(void);
-static void __init rfds_update_mitigation(void);
-static void __init rfds_apply_mitigation(void);
-static void __init srbds_select_mitigation(void);
-static void __init srbds_apply_mitigation(void);
-static void __init l1d_flush_select_mitigation(void);
-static void __init srso_select_mitigation(void);
-static void __init srso_update_mitigation(void);
-static void __init srso_apply_mitigation(void);
-static void __init gds_select_mitigation(void);
-static void __init gds_apply_mitigation(void);
-static void __init bhi_select_mitigation(void);
-static void __init bhi_update_mitigation(void);
-static void __init bhi_apply_mitigation(void);
-static void __init its_select_mitigation(void);
-static void __init its_update_mitigation(void);
-static void __init its_apply_mitigation(void);
-static void __init tsa_select_mitigation(void);
-static void __init tsa_apply_mitigation(void);
-static void __init vmscape_select_mitigation(void);
-static void __init vmscape_update_mitigation(void);
-static void __init vmscape_apply_mitigation(void);
+static void spectre_v1_select_mitigation(void);
+static void spectre_v1_apply_mitigation(void);
+static void spectre_v2_select_mitigation(void);
+static void spectre_v2_update_mitigation(void);
+static void spectre_v2_apply_mitigation(void);
+static void retbleed_select_mitigation(void);
+static void retbleed_update_mitigation(void);
+static void retbleed_apply_mitigation(void);
+static void spectre_v2_user_select_mitigation(void);
+static void spectre_v2_user_update_mitigation(void);
+static void spectre_v2_user_apply_mitigation(void);
+static void ssb_select_mitigation(void);
+static void ssb_apply_mitigation(void);
+static void l1tf_select_mitigation(void);
+static void l1tf_apply_mitigation(void);
+static void mds_select_mitigation(void);
+static void mds_update_mitigation(void);
+static void mds_apply_mitigation(void);
+static void taa_select_mitigation(void);
+static void taa_update_mitigation(void);
+static void taa_apply_mitigation(void);
+static void mmio_select_mitigation(void);
+static void mmio_update_mitigation(void);
+static void mmio_apply_mitigation(void);
+static void rfds_select_mitigation(void);
+static void rfds_update_mitigation(void);
+static void rfds_apply_mitigation(void);
+static void srbds_select_mitigation(void);
+static void srbds_apply_mitigation(void);
+static void l1d_flush_select_mitigation(void);
+static void srso_select_mitigation(void);
+static void srso_update_mitigation(void);
+static void srso_apply_mitigation(void);
+static void gds_select_mitigation(void);
+static void gds_apply_mitigation(void);
+static void bhi_select_mitigation(void);
+static void bhi_update_mitigation(void);
+static void bhi_apply_mitigation(void);
+static void its_select_mitigation(void);
+static void its_update_mitigation(void);
+static void its_apply_mitigation(void);
+static void tsa_select_mitigation(void);
+static void tsa_apply_mitigation(void);
+static void vmscape_select_mitigation(void);
+static void vmscape_update_mitigation(void);
+static void vmscape_apply_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -118,15 +118,15 @@ EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
 DEFINE_PER_CPU(bool, x86_ibpb_exit_to_user);
 EXPORT_PER_CPU_SYMBOL_GPL(x86_ibpb_exit_to_user);
 
-u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
+u64 x86_pred_cmd = PRED_CMD_IBPB;
 
-static u64 __ro_after_init x86_arch_cap_msr;
+static u64 x86_arch_cap_msr;
 
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
-void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
+void (*x86_return_thunk)(void) = __x86_return_thunk;
 
-static void __init set_return_thunk(void *thunk)
+static void set_return_thunk(void *thunk)
 {
 	x86_return_thunk = thunk;
 
@@ -169,8 +169,8 @@ EXPORT_SYMBOL_GPL(spec_ctrl_current);
  * AMD specific MSR info for Speculative Store Bypass control.
  * x86_amd_ls_cfg_ssbd_mask is initialized in identify_boot_cpu().
  */
-u64 __ro_after_init x86_amd_ls_cfg_base;
-u64 __ro_after_init x86_amd_ls_cfg_ssbd_mask;
+u64 x86_amd_ls_cfg_base;
+u64 x86_amd_ls_cfg_ssbd_mask;
 
 /* Control conditional STIBP in switch_to() */
 DEFINE_STATIC_KEY_FALSE(switch_to_cond_stibp);
@@ -205,7 +205,7 @@ EXPORT_SYMBOL_GPL(cpu_buf_vm_clear);
 #undef pr_fmt
 #define pr_fmt(fmt)	"mitigations: " fmt
 
-static void __init cpu_print_attack_vectors(void)
+static void cpu_print_attack_vectors(void)
 {
 	pr_info("Enabled attack vectors: ");
 
@@ -235,7 +235,7 @@ static void __init cpu_print_attack_vectors(void)
 	}
 }
 
-void __init cpu_select_mitigations(void)
+void cpu_select_mitigations(void)
 {
 	/*
 	 * Read the SPEC_CTRL MSR to account for reserved bits which may
@@ -399,7 +399,7 @@ static void x86_amd_ssb_enable(void)
  *
  * See Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
  */
-static bool __init should_mitigate_vuln(unsigned int bug)
+static bool should_mitigate_vuln(unsigned int bug)
 {
 	switch (bug) {
 	/*
@@ -464,9 +464,9 @@ static void __ref bugs_smt_disable(bool enable)
 }
 
 /* Default mitigation for MDS-affected CPUs */
-static enum mds_mitigations mds_mitigation __ro_after_init =
+static enum mds_mitigations mds_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
-static bool mds_nosmt __ro_after_init = false;
+static bool mds_nosmt = false;
 
 static const char * const mds_strings[] = {
 	[MDS_MITIGATION_OFF]	= "Vulnerable",
@@ -483,7 +483,7 @@ enum taa_mitigations {
 };
 
 /* Default mitigation for TAA-affected CPUs */
-static enum taa_mitigations taa_mitigation __ro_after_init =
+static enum taa_mitigations taa_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_AUTO : TAA_MITIGATION_OFF;
 
 enum mmio_mitigations {
@@ -494,7 +494,7 @@ enum mmio_mitigations {
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
-static enum mmio_mitigations mmio_mitigation __ro_after_init =
+static enum mmio_mitigations mmio_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ?	MMIO_MITIGATION_AUTO : MMIO_MITIGATION_OFF;
 
 enum rfds_mitigations {
@@ -505,16 +505,16 @@ enum rfds_mitigations {
 };
 
 /* Default mitigation for Register File Data Sampling */
-static enum rfds_mitigations rfds_mitigation __ro_after_init =
+static enum rfds_mitigations rfds_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_AUTO : RFDS_MITIGATION_OFF;
 
 /*
  * Set if any of MDS/TAA/MMIO/RFDS are going to enable VERW clearing
  * through X86_FEATURE_CLEAR_CPU_BUF on kernel and guest entry.
  */
-static bool verw_clear_cpu_buf_mitigation_selected __ro_after_init;
+static bool verw_clear_cpu_buf_mitigation_selected;
 
-static void __init mds_select_mitigation(void)
+static void mds_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS)) {
 		mds_mitigation = MDS_MITIGATION_OFF;
@@ -534,7 +534,7 @@ static void __init mds_select_mitigation(void)
 	verw_clear_cpu_buf_mitigation_selected = true;
 }
 
-static void __init mds_update_mitigation(void)
+static void mds_update_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		return;
@@ -551,7 +551,7 @@ static void __init mds_update_mitigation(void)
 	pr_info("%s\n", mds_strings[mds_mitigation]);
 }
 
-static void __init mds_apply_mitigation(void)
+static void mds_apply_mitigation(void)
 {
 	if (mds_mitigation == MDS_MITIGATION_FULL ||
 	    mds_mitigation == MDS_MITIGATION_VMWERV) {
@@ -572,7 +572,7 @@ static void mds_reset_mitigation(void)
 }
 #endif
 
-static int __init mds_cmdline(char *str)
+static int mds_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		return 0;
@@ -596,7 +596,7 @@ early_param("mds", mds_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"TAA: " fmt
 
-static bool taa_nosmt __ro_after_init;
+static bool taa_nosmt;
 
 static const char * const taa_strings[] = {
 	[TAA_MITIGATION_OFF]		= "Vulnerable",
@@ -605,12 +605,12 @@ static const char * const taa_strings[] = {
 	[TAA_MITIGATION_TSX_DISABLED]	= "Mitigation: TSX disabled",
 };
 
-static bool __init taa_vulnerable(void)
+static bool taa_vulnerable(void)
 {
 	return boot_cpu_has_bug(X86_BUG_TAA) && boot_cpu_has(X86_FEATURE_RTM);
 }
 
-static void __init taa_select_mitigation(void)
+static void taa_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_TAA)) {
 		taa_mitigation = TAA_MITIGATION_OFF;
@@ -635,7 +635,7 @@ static void __init taa_select_mitigation(void)
 		verw_clear_cpu_buf_mitigation_selected = true;
 }
 
-static void __init taa_update_mitigation(void)
+static void taa_update_mitigation(void)
 {
 	if (!taa_vulnerable())
 		return;
@@ -665,7 +665,7 @@ static void __init taa_update_mitigation(void)
 	pr_info("%s\n", taa_strings[taa_mitigation]);
 }
 
-static void __init taa_apply_mitigation(void)
+static void taa_apply_mitigation(void)
 {
 	if (taa_mitigation == TAA_MITIGATION_VERW ||
 	    taa_mitigation == TAA_MITIGATION_UCODE_NEEDED) {
@@ -683,7 +683,7 @@ static void __init taa_apply_mitigation(void)
 	}
 }
 
-static int __init tsx_async_abort_parse_cmdline(char *str)
+static int tsx_async_abort_parse_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_TAA))
 		return 0;
@@ -707,7 +707,7 @@ early_param("tsx_async_abort", tsx_async_abort_parse_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"MMIO Stale Data: " fmt
 
-static bool mmio_nosmt __ro_after_init = false;
+static bool mmio_nosmt = false;
 
 static const char * const mmio_strings[] = {
 	[MMIO_MITIGATION_OFF]		= "Vulnerable",
@@ -715,7 +715,7 @@ static const char * const mmio_strings[] = {
 	[MMIO_MITIGATION_VERW]		= "Mitigation: Clear CPU buffers",
 };
 
-static void __init mmio_select_mitigation(void)
+static void mmio_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
@@ -741,7 +741,7 @@ static void __init mmio_select_mitigation(void)
 		verw_clear_cpu_buf_mitigation_selected = true;
 }
 
-static void __init mmio_update_mitigation(void)
+static void mmio_update_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		return;
@@ -767,7 +767,7 @@ static void __init mmio_update_mitigation(void)
 	pr_info("%s\n", mmio_strings[mmio_mitigation]);
 }
 
-static void __init mmio_apply_mitigation(void)
+static void mmio_apply_mitigation(void)
 {
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
@@ -805,7 +805,7 @@ static void mmio_reset_mitigation(void)
 }
 #endif
 
-static int __init mmio_stale_data_parse_cmdline(char *str)
+static int mmio_stale_data_parse_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		return 0;
@@ -835,12 +835,12 @@ static const char * const rfds_strings[] = {
 	[RFDS_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
 };
 
-static inline bool __init verw_clears_cpu_reg_file(void)
+static inline bool verw_clears_cpu_reg_file(void)
 {
 	return (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR);
 }
 
-static void __init rfds_select_mitigation(void)
+static void rfds_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_RFDS)) {
 		rfds_mitigation = RFDS_MITIGATION_OFF;
@@ -861,7 +861,7 @@ static void __init rfds_select_mitigation(void)
 		verw_clear_cpu_buf_mitigation_selected = true;
 }
 
-static void __init rfds_update_mitigation(void)
+static void rfds_update_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_RFDS))
 		return;
@@ -877,13 +877,13 @@ static void __init rfds_update_mitigation(void)
 	pr_info("%s\n", rfds_strings[rfds_mitigation]);
 }
 
-static void __init rfds_apply_mitigation(void)
+static void rfds_apply_mitigation(void)
 {
 	if (rfds_mitigation == RFDS_MITIGATION_VERW)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 }
 
-static __init int rfds_parse_cmdline(char *str)
+static int rfds_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -912,7 +912,7 @@ enum srbds_mitigations {
 	SRBDS_MITIGATION_HYPERVISOR,
 };
 
-static enum srbds_mitigations srbds_mitigation __ro_after_init =
+static enum srbds_mitigations srbds_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_AUTO : SRBDS_MITIGATION_OFF;
 
 static const char * const srbds_strings[] = {
@@ -962,7 +962,7 @@ void update_srbds_msr(void)
 	wrmsrq(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 }
 
-static void __init srbds_select_mitigation(void)
+static void srbds_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SRBDS)) {
 		srbds_mitigation = SRBDS_MITIGATION_OFF;
@@ -996,7 +996,7 @@ static void __init srbds_select_mitigation(void)
 	pr_info("%s\n", srbds_strings[srbds_mitigation]);
 }
 
-static void __init srbds_apply_mitigation(void)
+static void srbds_apply_mitigation(void)
 {
 	update_srbds_msr();
 }
@@ -1012,7 +1012,7 @@ static void srbds_reset_mitigation(void)
 }
 #endif
 
-static int __init srbds_parse_cmdline(char *str)
+static int srbds_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -1033,9 +1033,9 @@ enum l1d_flush_mitigations {
 	L1D_FLUSH_ON,
 };
 
-static enum l1d_flush_mitigations l1d_flush_mitigation __initdata = L1D_FLUSH_OFF;
+static enum l1d_flush_mitigations l1d_flush_mitigation = L1D_FLUSH_OFF;
 
-static void __init l1d_flush_select_mitigation(void)
+static void l1d_flush_select_mitigation(void)
 {
 	if (!l1d_flush_mitigation || !boot_cpu_has(X86_FEATURE_FLUSH_L1D))
 		return;
@@ -1044,7 +1044,7 @@ static void __init l1d_flush_select_mitigation(void)
 	pr_info("Conditional flush on switch_mm() enabled\n");
 }
 
-static int __init l1d_flush_parse_cmdline(char *str)
+static int l1d_flush_parse_cmdline(char *str)
 {
 	if (!strcmp(str, "on"))
 		l1d_flush_mitigation = L1D_FLUSH_ON;
@@ -1066,7 +1066,7 @@ enum gds_mitigations {
 	GDS_MITIGATION_HYPERVISOR,
 };
 
-static enum gds_mitigations gds_mitigation __ro_after_init =
+static enum gds_mitigations gds_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_GDS) ? GDS_MITIGATION_AUTO : GDS_MITIGATION_OFF;
 
 static const char * const gds_strings[] = {
@@ -1123,7 +1123,7 @@ void update_gds_msr(void)
 	WARN_ON_ONCE(mcu_ctrl != mcu_ctrl_after);
 }
 
-static void __init gds_select_mitigation(void)
+static void gds_select_mitigation(void)
 {
 	u64 mcu_ctrl;
 
@@ -1170,7 +1170,7 @@ static void __init gds_select_mitigation(void)
 	}
 }
 
-static void __init gds_apply_mitigation(void)
+static void gds_apply_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_GDS))
 		return;
@@ -1202,7 +1202,7 @@ static void gds_reset_mitigation(void)
 }
 #endif
 
-static int __init gds_parse_cmdline(char *str)
+static int gds_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -1227,7 +1227,7 @@ enum spectre_v1_mitigation {
 	SPECTRE_V1_MITIGATION_AUTO,
 };
 
-static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
+static enum spectre_v1_mitigation spectre_v1_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V1) ?
 		SPECTRE_V1_MITIGATION_AUTO : SPECTRE_V1_MITIGATION_NONE;
 
@@ -1257,7 +1257,7 @@ static bool smap_works_speculatively(void)
 	return true;
 }
 
-static void __init spectre_v1_select_mitigation(void)
+static void spectre_v1_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
@@ -1266,7 +1266,7 @@ static void __init spectre_v1_select_mitigation(void)
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
 }
 
-static void __init spectre_v1_apply_mitigation(void)
+static void spectre_v1_apply_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return;
@@ -1319,14 +1319,14 @@ static void spectre_v1_reset_mitigation(void)
 }
 #endif
 
-static int __init nospectre_v1_cmdline(char *str)
+static int nospectre_v1_cmdline(char *str)
 {
 	spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
 	return 0;
 }
 early_param("nospectre_v1", nospectre_v1_cmdline);
 
-enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init = SPECTRE_V2_NONE;
+enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 
 /* Depends on spectre_v2 mitigation selected already */
 static inline bool cdt_possible(enum spectre_v2_mitigation mode)
@@ -1353,7 +1353,7 @@ enum its_mitigation {
 	ITS_MITIGATION_RETPOLINE_STUFF,
 };
 
-static enum its_mitigation its_mitigation __ro_after_init =
+static enum its_mitigation its_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_ITS) ? ITS_MITIGATION_AUTO : ITS_MITIGATION_OFF;
 
 enum retbleed_mitigation {
@@ -1375,10 +1375,10 @@ static const char * const retbleed_strings[] = {
 	[RETBLEED_MITIGATION_STUFF]	= "Mitigation: Stuffing",
 };
 
-static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
+static enum retbleed_mitigation retbleed_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_MITIGATION_AUTO : RETBLEED_MITIGATION_NONE;
 
-static int __ro_after_init retbleed_nosmt = false;
+static int retbleed_nosmt = false;
 
 enum srso_mitigation {
 	SRSO_MITIGATION_NONE,
@@ -1393,9 +1393,9 @@ enum srso_mitigation {
 	SRSO_MITIGATION_BP_SPEC_REDUCE,
 };
 
-static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_AUTO;
+static enum srso_mitigation srso_mitigation = SRSO_MITIGATION_AUTO;
 
-static int __init retbleed_parse_cmdline(char *str)
+static int retbleed_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -1435,7 +1435,7 @@ early_param("retbleed", retbleed_parse_cmdline);
 #define RETBLEED_UNTRAIN_MSG "WARNING: BTB untrained return thunk mitigation is only effective on AMD/Hygon!\n"
 #define RETBLEED_INTEL_MSG "WARNING: Spectre v2 mitigation leaves CPU vulnerable to RETBleed attacks, data leaks possible!\n"
 
-static void __init retbleed_select_mitigation(void)
+static void retbleed_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_RETBLEED)) {
 		retbleed_mitigation = RETBLEED_MITIGATION_NONE;
@@ -1500,7 +1500,7 @@ static void __init retbleed_select_mitigation(void)
 	}
 }
 
-static void __init retbleed_update_mitigation(void)
+static void retbleed_update_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_RETBLEED))
 		return;
@@ -1544,7 +1544,7 @@ static void __init retbleed_update_mitigation(void)
 	pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
-static void __init retbleed_apply_mitigation(void)
+static void retbleed_apply_mitigation(void)
 {
 	bool mitigate_smt = false;
 
@@ -1627,7 +1627,7 @@ static const char * const its_strings[] = {
 	[ITS_MITIGATION_RETPOLINE_STUFF]	= "Mitigation: Retpolines, Stuffing RSB",
 };
 
-static int __init its_parse_cmdline(char *str)
+static int its_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -1656,7 +1656,7 @@ static int __init its_parse_cmdline(char *str)
 }
 early_param("indirect_target_selection", its_parse_cmdline);
 
-static void __init its_select_mitigation(void)
+static void its_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_ITS)) {
 		its_mitigation = ITS_MITIGATION_OFF;
@@ -1697,7 +1697,7 @@ static void __init its_select_mitigation(void)
 		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
 }
 
-static void __init its_update_mitigation(void)
+static void its_update_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_ITS))
 		return;
@@ -1730,7 +1730,7 @@ static void __init its_update_mitigation(void)
 	pr_info("%s\n", its_strings[its_mitigation]);
 }
 
-static void __init its_apply_mitigation(void)
+static void its_apply_mitigation(void)
 {
 	switch (its_mitigation) {
 	case ITS_MITIGATION_OFF:
@@ -1783,10 +1783,10 @@ static const char * const tsa_strings[] = {
 	[TSA_MITIGATION_FULL]		= "Mitigation: Clear CPU buffers",
 };
 
-static enum tsa_mitigations tsa_mitigation __ro_after_init =
+static enum tsa_mitigations tsa_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_TSA) ? TSA_MITIGATION_AUTO : TSA_MITIGATION_NONE;
 
-static int __init tsa_parse_cmdline(char *str)
+static int tsa_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -1806,7 +1806,7 @@ static int __init tsa_parse_cmdline(char *str)
 }
 early_param("tsa", tsa_parse_cmdline);
 
-static void __init tsa_select_mitigation(void)
+static void tsa_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_TSA)) {
 		tsa_mitigation = TSA_MITIGATION_NONE;
@@ -1848,7 +1848,7 @@ static void __init tsa_select_mitigation(void)
 	pr_info("%s\n", tsa_strings[tsa_mitigation]);
 }
 
-static void __init tsa_apply_mitigation(void)
+static void tsa_apply_mitigation(void)
 {
 	switch (tsa_mitigation) {
 	case TSA_MITIGATION_USER_KERNEL:
@@ -1880,9 +1880,9 @@ static void tsa_reset_mitigation(void)
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
-static enum spectre_v2_user_mitigation spectre_v2_user_stibp __ro_after_init =
+static enum spectre_v2_user_mitigation spectre_v2_user_stibp =
 	SPECTRE_V2_USER_NONE;
-static enum spectre_v2_user_mitigation spectre_v2_user_ibpb __ro_after_init =
+static enum spectre_v2_user_mitigation spectre_v2_user_ibpb =
 	SPECTRE_V2_USER_NONE;
 
 #ifdef CONFIG_MITIGATION_RETPOLINE
@@ -1954,7 +1954,7 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_IBRS,
 };
 
-static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init =
+static enum spectre_v2_mitigation_cmd spectre_v2_cmd =
 	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ? SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
 
 enum spectre_v2_user_mitigation_cmd {
@@ -1967,7 +1967,7 @@ enum spectre_v2_user_mitigation_cmd {
 	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
 };
 
-static enum spectre_v2_user_mitigation_cmd spectre_v2_user_cmd __ro_after_init =
+static enum spectre_v2_user_mitigation_cmd spectre_v2_user_cmd =
 	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ? SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
 
 static const char * const spectre_v2_user_strings[] = {
@@ -1978,7 +1978,7 @@ static const char * const spectre_v2_user_strings[] = {
 	[SPECTRE_V2_USER_SECCOMP]		= "User space: Mitigation: STIBP via seccomp and prctl",
 };
 
-static int __init spectre_v2_user_parse_cmdline(char *str)
+static int spectre_v2_user_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -2009,7 +2009,7 @@ static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
 	return spectre_v2_in_eibrs_mode(mode) || mode == SPECTRE_V2_IBRS;
 }
 
-static void __init spectre_v2_user_select_mitigation(void)
+static void spectre_v2_user_select_mitigation(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
@@ -2070,7 +2070,7 @@ static void __init spectre_v2_user_select_mitigation(void)
 		spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
 }
 
-static void __init spectre_v2_user_update_mitigation(void)
+static void spectre_v2_user_update_mitigation(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
@@ -2115,7 +2115,7 @@ static void __init spectre_v2_user_update_mitigation(void)
 	pr_info("%s\n", spectre_v2_user_strings[spectre_v2_user_stibp]);
 }
 
-static void __init spectre_v2_user_apply_mitigation(void)
+static void spectre_v2_user_apply_mitigation(void)
 {
 	/* Initialize Indirect Branch Prediction Barrier */
 	if (spectre_v2_user_ibpb != SPECTRE_V2_USER_NONE) {
@@ -2161,9 +2161,9 @@ static const char * const spectre_v2_strings[] = {
 	[SPECTRE_V2_IBRS]			= "Mitigation: IBRS",
 };
 
-static bool nospectre_v2 __ro_after_init;
+static bool nospectre_v2;
 
-static int __init nospectre_v2_parse_cmdline(char *str)
+static int nospectre_v2_parse_cmdline(char *str)
 {
 	nospectre_v2 = true;
 	spectre_v2_cmd = SPECTRE_V2_CMD_NONE;
@@ -2171,7 +2171,7 @@ static int __init nospectre_v2_parse_cmdline(char *str)
 }
 early_param("nospectre_v2", nospectre_v2_parse_cmdline);
 
-static int __init spectre_v2_parse_cmdline(char *str)
+static int spectre_v2_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -2210,7 +2210,7 @@ static int __init spectre_v2_parse_cmdline(char *str)
 }
 early_param("spectre_v2", spectre_v2_parse_cmdline);
 
-static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
+static enum spectre_v2_mitigation spectre_v2_select_retpoline(void)
 {
 	if (!IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
 		pr_err("Kernel not compiled with retpoline; no mitigation available!");
@@ -2220,10 +2220,10 @@ static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
 	return SPECTRE_V2_RETPOLINE;
 }
 
-static bool __ro_after_init rrsba_disabled;
+static bool rrsba_disabled;
 
 /* Disable in-kernel use of non-RSB RET predictors */
-static void __init spec_ctrl_disable_kernel_rrsba(void)
+static void spec_ctrl_disable_kernel_rrsba(void)
 {
 	if (rrsba_disabled)
 		return;
@@ -2241,7 +2241,7 @@ static void __init spec_ctrl_disable_kernel_rrsba(void)
 	rrsba_disabled = true;
 }
 
-static void __init spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation mode)
+static void spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation mode)
 {
 	/*
 	 * WARNING! There are many subtleties to consider when changing *any*
@@ -2295,7 +2295,7 @@ static void __init spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation m
  * Set BHI_DIS_S to prevent indirect branches in kernel to be influenced by
  * branch history in userspace. Not needed if BHI_NO is set.
  */
-static bool __init spec_ctrl_bhi_dis(void)
+static bool spec_ctrl_bhi_dis(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_BHI_CTRL))
 		return false;
@@ -2314,10 +2314,10 @@ enum bhi_mitigations {
 	BHI_MITIGATION_VMEXIT_ONLY,
 };
 
-static enum bhi_mitigations bhi_mitigation __ro_after_init =
+static enum bhi_mitigations bhi_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AUTO : BHI_MITIGATION_OFF;
 
-static int __init spectre_bhi_parse_cmdline(char *str)
+static int spectre_bhi_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -2335,7 +2335,7 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 }
 early_param("spectre_bhi", spectre_bhi_parse_cmdline);
 
-static void __init bhi_select_mitigation(void)
+static void bhi_select_mitigation(void)
 {
 	if (!boot_cpu_has(X86_BUG_BHI))
 		bhi_mitigation = BHI_MITIGATION_OFF;
@@ -2353,13 +2353,13 @@ static void __init bhi_select_mitigation(void)
 	}
 }
 
-static void __init bhi_update_mitigation(void)
+static void bhi_update_mitigation(void)
 {
 	if (spectre_v2_cmd == SPECTRE_V2_CMD_NONE)
 		bhi_mitigation = BHI_MITIGATION_OFF;
 }
 
-static void __init bhi_apply_mitigation(void)
+static void bhi_apply_mitigation(void)
 {
 	if (bhi_mitigation == BHI_MITIGATION_OFF)
 		return;
@@ -2401,7 +2401,7 @@ static void bhi_reset_mitigation(void)
 }
 #endif
 
-static void __init spectre_v2_select_mitigation(void)
+static void spectre_v2_select_mitigation(void)
 {
 	if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE ||
 	     spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
@@ -2501,7 +2501,7 @@ static void __init spectre_v2_select_mitigation(void)
 	}
 }
 
-static void __init spectre_v2_update_mitigation(void)
+static void spectre_v2_update_mitigation(void)
 {
 	if (spectre_v2_cmd == SPECTRE_V2_CMD_AUTO &&
 	    !spectre_v2_in_eibrs_mode(spectre_v2_enabled)) {
@@ -2519,7 +2519,7 @@ static void __init spectre_v2_update_mitigation(void)
 		pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
 }
 
-static void __init spectre_v2_apply_mitigation(void)
+static void spectre_v2_apply_mitigation(void)
 {
 	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
 		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
@@ -2675,7 +2675,7 @@ static void update_mds_branch_idle(void)
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
-static enum ssb_mitigation ssb_mode __ro_after_init =
+static enum ssb_mitigation ssb_mode =
 	IS_ENABLED(CONFIG_MITIGATION_SSB) ? SPEC_STORE_BYPASS_AUTO : SPEC_STORE_BYPASS_NONE;
 
 static const char * const ssb_strings[] = {
@@ -2685,9 +2685,9 @@ static const char * const ssb_strings[] = {
 	[SPEC_STORE_BYPASS_SECCOMP]	= "Mitigation: Speculative Store Bypass disabled via prctl and seccomp",
 };
 
-static bool nossb __ro_after_init;
+static bool nossb;
 
-static int __init nossb_parse_cmdline(char *str)
+static int nossb_parse_cmdline(char *str)
 {
 	nossb = true;
 	ssb_mode = SPEC_STORE_BYPASS_NONE;
@@ -2695,7 +2695,7 @@ static int __init nossb_parse_cmdline(char *str)
 }
 early_param("nospec_store_bypass_disable", nossb_parse_cmdline);
 
-static int __init ssb_parse_cmdline(char *str)
+static int ssb_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -2722,7 +2722,7 @@ static int __init ssb_parse_cmdline(char *str)
 }
 early_param("spec_store_bypass_disable", ssb_parse_cmdline);
 
-static void __init ssb_select_mitigation(void)
+static void ssb_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS)) {
 		ssb_mode = SPEC_STORE_BYPASS_NONE;
@@ -2742,7 +2742,7 @@ static void __init ssb_select_mitigation(void)
 	pr_info("%s\n", ssb_strings[ssb_mode]);
 }
 
-static void __init ssb_apply_mitigation(void)
+static void ssb_apply_mitigation(void)
 {
 	/*
 	 * We have three CPU feature flags that are in play here:
@@ -3032,7 +3032,7 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
-enum l1tf_mitigations l1tf_mitigation __ro_after_init =
+enum l1tf_mitigations l1tf_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_AUTO : L1TF_MITIGATION_OFF;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
@@ -3079,7 +3079,7 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 	}
 }
 
-static void __init l1tf_select_mitigation(void)
+static void l1tf_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_L1TF)) {
 		l1tf_mitigation = L1TF_MITIGATION_OFF;
@@ -3100,7 +3100,7 @@ static void __init l1tf_select_mitigation(void)
 		l1tf_mitigation = L1TF_MITIGATION_FLUSH;
 }
 
-static void __init l1tf_apply_mitigation(void)
+static void l1tf_apply_mitigation(void)
 {
 	u64 half_pa;
 
@@ -3152,7 +3152,7 @@ static void l1tf_reset_mitigation(void)
 }
 #endif
 
-static int __init l1tf_cmdline(char *str)
+static int l1tf_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return 0;
@@ -3192,7 +3192,7 @@ static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_BP_SPEC_REDUCE]	= "Mitigation: Reduced Speculation"
 };
 
-static int __init srso_parse_cmdline(char *str)
+static int srso_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -3216,7 +3216,7 @@ early_param("spec_rstack_overflow", srso_parse_cmdline);
 
 #define SRSO_NOTICE "WARNING: See https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitigation options."
 
-static void __init srso_select_mitigation(void)
+static void srso_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
 		srso_mitigation = SRSO_MITIGATION_NONE;
@@ -3295,7 +3295,7 @@ static void __init srso_select_mitigation(void)
 	}
 }
 
-static void __init srso_update_mitigation(void)
+static void srso_update_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SRSO))
 		return;
@@ -3308,7 +3308,7 @@ static void __init srso_update_mitigation(void)
 	pr_info("%s\n", srso_strings[srso_mitigation]);
 }
 
-static void __init srso_apply_mitigation(void)
+static void srso_apply_mitigation(void)
 {
 	/*
 	 * Clear the feature flag if this mitigation is not selected as that
@@ -3397,10 +3397,10 @@ static const char * const vmscape_strings[] = {
 	[VMSCAPE_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT",
 };
 
-static enum vmscape_mitigations vmscape_mitigation __ro_after_init =
+static enum vmscape_mitigations vmscape_mitigation =
 	IS_ENABLED(CONFIG_MITIGATION_VMSCAPE) ? VMSCAPE_MITIGATION_AUTO : VMSCAPE_MITIGATION_NONE;
 
-static int __init vmscape_parse_cmdline(char *str)
+static int vmscape_parse_cmdline(char *str)
 {
 	if (!str)
 		return -EINVAL;
@@ -3420,7 +3420,7 @@ static int __init vmscape_parse_cmdline(char *str)
 }
 early_param("vmscape", vmscape_parse_cmdline);
 
-static void __init vmscape_select_mitigation(void)
+static void vmscape_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_VMSCAPE) ||
 	    !boot_cpu_has(X86_FEATURE_IBPB)) {
@@ -3436,7 +3436,7 @@ static void __init vmscape_select_mitigation(void)
 	}
 }
 
-static void __init vmscape_update_mitigation(void)
+static void vmscape_update_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_VMSCAPE))
 		return;
@@ -3448,7 +3448,7 @@ static void __init vmscape_update_mitigation(void)
 	pr_info("%s\n", vmscape_strings[vmscape_mitigation]);
 }
 
-static void __init vmscape_apply_mitigation(void)
+static void vmscape_apply_mitigation(void)
 {
 	if (vmscape_mitigation == VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER)
 		setup_force_cpu_cap(X86_FEATURE_IBPB_EXIT_TO_USER);
-- 
2.34.1


