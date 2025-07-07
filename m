Return-Path: <linux-kernel+bounces-720362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2CAFBAB9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E4A42619C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CC426658A;
	Mon,  7 Jul 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kqXLARo5"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297BE266573
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913222; cv=fail; b=b/JSlUbLpdh76xNGqXeVm0FMsjA/flAiFR4djDAxTEtT8VxTDavXM2N6EmWMkK4+BbJQChdJsbhxzhLBi/Xu70CGjGp6GZdwotlE7yirh416Eo8NxtSHqwdAuj/R0208XV8m+8tT0KTQKj/oFbbGWPWZHIDjnNrC8Tzs72TgohY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913222; c=relaxed/simple;
	bh=LF3NJTyxlpccbAboNad14iM+v3CorfLA8wJs1Ws/H00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwCWb7hJiFNHmWLKBLjZULfU7635srYPOBnRTkXCIiJHXLuxIVD9/EeLytg1fr2EyDttx3bsHcTqHbnv3vepd+pbGf2FAKJTzI/GKEgRMgM5DitsPhtLEXwcLnHZtVHoYy3xFk3Qr6xufpvvaQB1LhkBa0JddI+bDyNjrMMpCm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kqXLARo5; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pE5RP8jmA5jhfV5KWFMgsLHmyUJaYZGOSnHiC0CqOGn8vcac1mzIMspMO/ATZmX2rYi6gLxa+4ytM4e3YaHsiKl/4/2Tx5jj04rGk+3qZk213iGwc5T/j/jK+3OLLXbtVka6rfETG77Z/PUwsnTGrelkVYzsZHG60Hh4jvJJj7DmBi9uwAg9MVzQ5d1il0wr0JegmMAlYCg4SYAVW/IKgjK7ggv//52eZoIWX94wO3yZaBgtXwOBBJ3B5SwA2KnMYVJhrbhwrQMOpQGlUzfzZ/tzIFpwB3/TaU09QZSv7NZlFSsqLWfGmG7pEEseKHtXi/YB2GbPt+3HHb/dgNedyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X13mkfPY+iZhaU/ERHYY/KbYtIwPSMZzt0UmmAHpCF4=;
 b=lob3yrEXNU+g2Fo+PlzuVn7T/NIpme9jHKSmVvK6FAuDSLPRZuTskEDiylz+MNHkzRumyPfDT1WpCGZiFN6Q5KSwq9y+nP4vmeEAQBK4u77O7+Yo6s7AkkPvGdJ+lc3wEV5xvRKEFghlKhAFSo3jlHEwoe2c8pPozxN3dzHHzHTn+vyUViPhFSHQ6mKUV8Y8u63YF7EQePR6RT+heBr+BI254ecHkJq/ees2eoGi7MkWt//I9MGquytO6DaHEBoZVNxVw5lFPd8rwIKMusIgmEEM2BBv/gwJxNkZDvKmotkpaLbZH3xiCXM1XFe2u6qd3o0G80ijTXkAdeR7KuO4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X13mkfPY+iZhaU/ERHYY/KbYtIwPSMZzt0UmmAHpCF4=;
 b=kqXLARo5+XsZGA391uhxNhP/F633M/82j4v1CU6C3KcYRM9YeK3Sh5bmZK6nVP7Kyj3ezqgs4gEHD788LV2u9my1XJTMXGyFKEAlgQ3tqJNQz795aY7IjrazuWQuU5rUm9jZfBMKIkluV68JaKvNFqVM2PNmr8lT44CmufeHD1c=
Received: from BY5PR16CA0006.namprd16.prod.outlook.com (2603:10b6:a03:1a0::19)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 7 Jul
 2025 18:33:38 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::c3) by BY5PR16CA0006.outlook.office365.com
 (2603:10b6:a03:1a0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:38 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:33 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 08/21] x86/bugs: Add attack vector controls for RFDS
Date: Mon, 7 Jul 2025 13:33:03 -0500
Message-ID: <20250707183316.1349127-9-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d20437-fdab-4ee1-fc02-08ddbd84ca4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f1ugFqJ0JrtsL3M0KVrs+k9RXV8VuCWv5tJ2nMDc1scNBKfmp6yLB0cVD1ND?=
 =?us-ascii?Q?aHI53eCvU+76Q7Tc0j7HvHavp6eW01KCZ6Fljm4u/Aap1GPFl26VvILBRduM?=
 =?us-ascii?Q?RonQo0utT2Lr05uetUrhiQBp2ZBnOqncDF6IzqrM/4GmYllMouZfUGUn8imo?=
 =?us-ascii?Q?jipNHNn39wParROWS+RyscNQzLqH+daSFkFZyi9g1eIKy8YiQXABFWMKrf5N?=
 =?us-ascii?Q?EMAkE6ISL80fDM2ekmEBK46YbKJEhKe3NTVIWKYq0QNoUsoJfGwNHaZMX9wf?=
 =?us-ascii?Q?gq1wO0SOagOeVCeb4LYvJMbPpDkUxHfFzkr8iILflObHxU1f/dZe+N6eKS+Q?=
 =?us-ascii?Q?iMVxZ6v0KIyl4XG8YXfllLXtocJEYBMy5oJUCXJHs+lkQPwwWU7EpU01T5Mv?=
 =?us-ascii?Q?8PJa6YEk8B2peDvdu4jw2oV5HFJJkIsJQuIpaDbB9Wjard1NcQpwaI0chvka?=
 =?us-ascii?Q?XG1xyvEDHqbriFF3g6F1Raed2Y71lJcf+Cg3b3W3W9XKMcpood/L31qe2sja?=
 =?us-ascii?Q?Eq156ZeboWbvPsuozPBlyPfExOFcL19P5iJh9nTR0PvaRNiUSYb6n3oaEpCR?=
 =?us-ascii?Q?XJi/GUtlArP7NtqWh2+XtpCtfDz/YjO5czA6tRrK8p/qyTi4BnNOx92riudn?=
 =?us-ascii?Q?faKUf1HfaD5kL513CKxCJu1sXJ2+J1p62mM1rMAVXqvFsrplMPozZqEPiomz?=
 =?us-ascii?Q?86e02Qq6ntxEA3GSCsdXtYJloYGg3/XhywX/vMA1V2tEjVLMzivXG8mdGcGw?=
 =?us-ascii?Q?0Cn8HfNaWV6NvD945ZJxjVSlM1ZjfTnUelomuI2WIH0cUyGKP3uUEbMQd45v?=
 =?us-ascii?Q?uMXWENrriVOWk5eVvHFL5TJM8+JGq+eBI+Kr60BQDCKo+zTp7NgB2Bfjdx+A?=
 =?us-ascii?Q?yoVHOGYvrVkAgTSyb2x2pBqLCsWq7NVgkKFucUQId3V4f+u0eD3V2jYrLxF1?=
 =?us-ascii?Q?Q2JDBiCbxwbL57VSPQMK8FCOFSkZHBFTjQEyRI4TR8Z/fiyRGZ0XlnNqHbSV?=
 =?us-ascii?Q?c55MbkRG4n94sXUtKIkGE3wKtPMH7ZCS0RNrFaEuK7DQSi/oGU7B865twZyy?=
 =?us-ascii?Q?Z1t71MIX6/ZAAMVuZaQW/dpOQnT0hMtrP1mhvjRfAeYeRKYJAxwXtpzDgf7b?=
 =?us-ascii?Q?mgaaMYZZ0+sbEVL1GhSt+JSR8v2kuWcHSN04QMm5Ahdj7de7Rneh1HQl7uj/?=
 =?us-ascii?Q?Zz/jgD7WrZ6lgaAutLTZmyff3aSS+ffVELdPaEJZUQxZbHi61GtPkLIjMi4V?=
 =?us-ascii?Q?8ZwUsUD0Opi2uJIxPpK5DzojGfAz1wq7ChBJfTtRgbjZ/JsmIpwHX30sAJiq?=
 =?us-ascii?Q?wem12pMzOBhv4WAzf40IGSDGWlhEDrbJM2MegouSdB0pqiEUTK3HxHX45kF0?=
 =?us-ascii?Q?oqR30ONuoUjdfJ+wm0txJT+wCerqs2X1RU6AQJGtzyaJhdq4TwleNFcQsuGF?=
 =?us-ascii?Q?LbtzGkOkBUAew0mtAxDuxN74qkQ4AJ/dpppx3WbA760eP+5eckccTRN5EvEU?=
 =?us-ascii?Q?5cgCM2ycjys0KcCqRQBwT5J31SBo2jfExV0U?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:38.2378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d20437-fdab-4ee1-fc02-08ddbd84ca4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880

Use attack vector controls to determine if RFDS mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9f81a236735f..cf7d010931b9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -744,13 +744,17 @@ static inline bool __init verw_clears_cpu_reg_file(void)
 
 static void __init rfds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_RFDS)) {
 		rfds_mitigation = RFDS_MITIGATION_OFF;
 		return;
 	}
 
-	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
-		rfds_mitigation = RFDS_MITIGATION_VERW;
+	if (rfds_mitigation == RFDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_RFDS))
+			rfds_mitigation = RFDS_MITIGATION_VERW;
+		else
+			rfds_mitigation = RFDS_MITIGATION_OFF;
+	}
 
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
@@ -761,7 +765,7 @@ static void __init rfds_select_mitigation(void)
 
 static void __init rfds_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
 		return;
 
 	if (verw_clear_cpu_buf_mitigation_selected)
-- 
2.34.1


