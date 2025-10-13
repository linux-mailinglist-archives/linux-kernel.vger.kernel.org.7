Return-Path: <linux-kernel+bounces-850716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA65BD39FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0866B3E3862
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A3D308F00;
	Mon, 13 Oct 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p5xhqXAS"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5CC305E31
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366129; cv=fail; b=IXsk68WtFMSx/vwN95Eeb8e3H7s5tFZplZvrJuMK9JSglFTDNhY6bEWfyfPmzmBknPKEKw0nbUhNVwMpto1HN7J+8cYfBSV8zLTs/HG4TK1jtKXuGWpvE5cEexeNbdRZU8V9WcyGbtL5uJf8maw4OHoq+sJRcvFHrZSQSM4NrzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366129; c=relaxed/simple;
	bh=q0YDsa4Xw5cHfosdQRyKHoQyEO+U5RJYcbg3LWYPlpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHDJUCur3Q808yIO6hG83X5J/02wek1sX1+FyssoA2oHRzxP+ky4FIHBlxNtFkEWSnn5/ns+fgaupAzRBEh+AxKIUiCB8povtUzJsLo7Ni7U8TR/8v2n4326uir1x+RzPr7R2Q/RYwgC3OShWvzFTzQ84k5hIl62Q/fCwIIBxPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p5xhqXAS; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OV04pSKx3ElW1c5ZmNY2JGXJPFjC5+ZNZbcHUH2FrdKSlhe8ytMYXxAuR0DltiaP2E3h8sTl42LgMV0DXK9tut6eDfcyxRCPuu7BoTA4MM2zYMPjYKEab0XkGZHDCxfzIJmIrhkoUdW1doki8+AHPqLnAUgSnt5eyfb1FmSc++2+Gzk+m0ct0jnjBd38t6/6age5bS8GZALn9GzZHFHsUGDd9CHiV54gCftU2guN2BMaHYXMyx3q1xgbihWz9nUz8kghQxS0tGXzYXx5WjCLZLwOwc0GYzP1YhBUWa22bkCLhrB9CnOiSeU+iNYwLJALuou67+yYFv99OvN07XLgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZmxJEtKCMHKu2jOKH3R7HOFAWQzB0MgpQentSh/nVM=;
 b=cKK28ZffzbtKCjSIK5ve47O8gzjGjHS45pk82/4ptCG4Lwt6HqLt5gaDmEf2MC+RF2eqeiq3dRxn9EP9fWUQcqbeOVXtfOY59WtZAiYGF+alST+sfI0Xh2szkQi2GZ/R54ne227HaVl8mVqWOoPZOQq4KRh2F9LE41cjUMuIWpKqkeBFBWJGVhBsfztR5QnBPf3h/ZP1/LVsm5cA9Ql4bgtMeW0F13jBDh2hecncJxf7mloEVM32BwuHUebC9Vf/cF+gNmwpFua6ovgjYw2CBhGbkAC/snWQ/qxFXelFqqbr1zeAVt5CwfBbjdvZPjc8aKAIREgdZe/Ow8P1xSiqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZmxJEtKCMHKu2jOKH3R7HOFAWQzB0MgpQentSh/nVM=;
 b=p5xhqXASxUjGdiGXUPL+UFiaJCnZ5CwO1+4s0NxBg0PadbtGDfS6/eJUL69xblG/4g+DTRPLrxbHCjwVe5PA8xQ84OzkI2VYKGYX67s68sTnMCfi12s49qm1q0URwZyF9g3SElcknfAoLuNXaKsQYKE2F25VtAhy2eZjH9xkCsM=
Received: from SA1P222CA0114.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::21)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:25 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::af) by SA1P222CA0114.outlook.office365.com
 (2603:10b6:806:3c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:25 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:22 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 09/56] x86/bugs: Reset L1TF mitigations
Date: Mon, 13 Oct 2025 09:33:57 -0500
Message-ID: <20251013143444.3999-10-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c01a36e-ecdc-4839-d7b3-08de0a65bf5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gUe8bO0b0yZJWs9FlavRpSTgG+GaAk4Ud0xSeywnYteerJBUg7n8UqMQQGox?=
 =?us-ascii?Q?F0Sxwa+HN8wLTGYHMd0/6lrJXZL3og9gV6PdrdxwYH2Dx/gHXWvLaYMbGsAs?=
 =?us-ascii?Q?A7ONmq0QiuQUL3zJm3MYP6oDsEUf8gQQdQJshpJw+nBu4MGVRK/zSEu+iX2f?=
 =?us-ascii?Q?xCiKzTMNFMNiY7Oi7ILKJjlmJWOAaghyOfmEPb0fNRPQDY073hbP8JCfnOc1?=
 =?us-ascii?Q?LIhx0TwwDfiDMJjUfLsIh431lX1WnuR9jSzUjquYiEkYl/nUNl1u4fRfefdJ?=
 =?us-ascii?Q?2jmaVdrIqovqqc06tIT8AYNE8iS1w2c57yxk6Coi8O6V5i+Kn4m2Z5QqVk8s?=
 =?us-ascii?Q?DXca8IUET7SVqP9KsV0PDjyOOcUKGIdZVKCSwJeYeDCE/i5luRoEw+/T2+tC?=
 =?us-ascii?Q?e8Bqf/tJ3eNbzTCOzOsrg3WUhXB/Ks2C1PrI4TM/tAxm6v9EnjfDoKtFy1lu?=
 =?us-ascii?Q?ik3d29e1oQScNTxANJO5jHkIoXbwjm7q8wKReBNQo1b1YLGIrxxLSqyv4x8+?=
 =?us-ascii?Q?gHWd1NPsmmaPw3dcBEfc+Xi4RspkDRhwI/H4tQxUrIEamkUN3ylGZlzxfnwd?=
 =?us-ascii?Q?sRmGXyZAO8HCU493hm9g6xK76KUEJqrxoNpueA+oya5ay1/jP5Iue8cCR3dc?=
 =?us-ascii?Q?6DkKQojNl422gpFGzM6H/ZCqFV17T7uHKbu7VAzzM7qKenxR6dQTgAVQmeOA?=
 =?us-ascii?Q?IH0h27ncxc3BO8M2SDbpcQzYq3MtU5BKxzlSYyUV3pO03jAoxX9fRrLII3Pm?=
 =?us-ascii?Q?fSaWl12dekWuMvzk8kSL4tXP+sZxNRG7/oskDXi0bdr0aQb11PY7OtaIAg/S?=
 =?us-ascii?Q?FFyXNevFniPJHfZ6f5KT2womx0XOoz1ALc8zlLa34fbjlqaeLMlWW35gUtCh?=
 =?us-ascii?Q?KSZPO3fD9oH8wcQhkFKBZ74g3THahQAuNF7KuzQXwM+Z+iBXMcwwO+whsRDh?=
 =?us-ascii?Q?ChC9AqZq4zMQgH1bx62LsYgyvCRX64v2oAspETP1epx1Vtj3nMu+JZYEw4BU?=
 =?us-ascii?Q?57fNwT+M4DTJmUMNOk+Ylvr14UCXW7PtpCAOKls1spolOtjybwAnIYHrs3hK?=
 =?us-ascii?Q?xhjnEwq4xCmmjpoTaQzegPIC0aN8poeEX2ppe3O4Sny8crfhdo8LYWNTyNXd?=
 =?us-ascii?Q?q/lurwLUgZjLt/CRRyrF6bbodRq7NGzHxKc4wxANEaWSZQdNlBo1TksPgQnz?=
 =?us-ascii?Q?FFQYItC0xNb18mUbZaLg3mJcEiFZkCr74whAmQKz1czf2S8g3N/KHn1gHpGK?=
 =?us-ascii?Q?MkejkW+Cr6bZWokSMWsnuEs/zTFMvmFfT7oyI3Gco+88+kW66SyBSX0szXk2?=
 =?us-ascii?Q?xOTUSCuaEgpmzfShflAcqL8l4li/WgvEly4hntqWkBQ1lfYR6EnRsq1vnmSO?=
 =?us-ascii?Q?SDbSZZDrhnN7phrwCwIx1MFdf6y70bFo+PIbcYMOv6eYRxLscxPoCEB7uVSc?=
 =?us-ascii?Q?TCDVCI84njK1oiS9uxmwaEuPFkWJKZv9RQ5hBPVhDEX9u8xlFG8iz2JetO0P?=
 =?us-ascii?Q?JypKGJRgepLx4LOgtj5NKvev5dXVtT3VB6iMrQdrmF2zCbA3ZDQjUonJM/PO?=
 =?us-ascii?Q?SvYYyzQiZCpTZB/XOIg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:25.1080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c01a36e-ecdc-4839-d7b3-08de0a65bf5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727

Add function to reset L1TF mitigations back to their boot-time defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cc7b1b67d22d..b61bbeaf82b1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3059,6 +3059,15 @@ static void __init l1tf_apply_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_L1TF_PTEINV);
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void l1tf_reset_mitigation(void)
+{
+	setup_clear_cpu_cap(X86_FEATURE_L1TF_PTEINV);
+	l1tf_mitigation = IS_ENABLED(CONFIG_MITIGATION_L1TF) ?
+		L1TF_MITIGATION_AUTO : L1TF_MITIGATION_OFF;
+}
+#endif
+
 static int __init l1tf_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
@@ -3881,5 +3890,6 @@ void arch_cpu_reset_mitigations(void)
 	retbleed_reset_mitigation();
 	spectre_v2_user_reset_mitigation();
 	ssb_reset_mitigation();
+	l1tf_reset_mitigation();
 }
 #endif
-- 
2.34.1


