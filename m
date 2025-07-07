Return-Path: <linux-kernel+bounces-720368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A939AAFBABF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C5426367
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECA626B74A;
	Mon,  7 Jul 2025 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sRdvb8qg"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344226A1C9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913227; cv=fail; b=EPhlOe2tK1M4tYx6PDBFRprZQEY/VzLqNy6g8AciNI/AragRvh0ZmOmQzlolluMTGq4riCZ/ydU1jzwk/6qqiGCP/eUBjPdiAZrGDh/SXtveZnqi342yi3OFqkEx5gENAGyrSp242nCexJgxmoPsOHvtD9OH5w1k6PTSD/wXoXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913227; c=relaxed/simple;
	bh=rpdJh3HmfZRrUZTn203ZrgeXhgEdhOvCqEDd3736KCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oczp2ysdg3IQhXmNEuXns2iDR6NrLGzCdrqTP8yK8NDB/2naxBS7f+zM0jlXs/nPl708Uot7sMrCKvdFwKLd7IcZbU5Lbhy9CF8dGBOQrf1+aEyknTgrMPX73GuOYJrTDdOQJM8WSeV7ZVdvhFqTSW7oCpkknUvGbHl50WSS8sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sRdvb8qg; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ2zsJ+y1ei4wQ8sJvBL3Iudg9kwb2Y/g2BKAi/W7zv55oa4PQHa7+M/yWrVXSA3SGWtOWv7nkBzrJzn7QQ7XuE7AaLLjx++nEADqqrEXCLo2i6BMGBF++DCJq32IT45axNgSWv8tRuQcvQe5cDhIvvTieLSyIsUtrOYEu43MmwwDMJpu2edCD2HtFsQq6ZP4SNA9m7kR7bQgcodjV/e2+/4kt1fJDDNoRfWK2LmH3cp9CeOgtDKuSWqDwsrkkijv2cEkEHfJhuk2Z/Sil6R0jMN361LfyPvjr2f8i6FbGyLE/o1lucDLfqRDc3EdTwR71Y/sxa1zMYaz0Cttf8W+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7ZN3zsoL97r94sAJlZDPegcOk6O434Gf6ffT4yJaZc=;
 b=xA/equZKhF3kSZBK5XzuzK4hC6+MuRg0J5QpcnBSAo914rvS17PYSo9C0wCqRSIXA9+bdfEx23vaSgCMnF9SBuYWLSdEXxhUFaHGI5zweOUmYTchk/G2CjxwxiD6BYdSx45pM3d5lSa8hboUOzEKImeg0nCX/qaveUyZTszi6UnEhRE3+t4V/PKLzfqTVQLGDGbLvvRM+HDrxGRw3ya3tuxnLp2akPmcUhHAwsjGko8oUbt4vn+vCAIAhOWoOB3xSYG2xiPt1s/TYkd/4kRlEN6nR4zWlFrz8gHFpOM/CZbjx26tTgIKh6uH5K6j99UyAt0GrJfbHhTNsEgZQtMCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7ZN3zsoL97r94sAJlZDPegcOk6O434Gf6ffT4yJaZc=;
 b=sRdvb8qgvOH24TaMZi2cXOzn82NSdZgq8Fv+HRjWLDmB8XVcZMgwS0hNmPCqwI+PfI+2F4xJQZIut/6ebOSz+MH9DPNVDOsz904K9EGOO9GXVNv0DCeJOgAu1mLWOnW1eE163l1AgPBDhCBV7NMruOFRzS1Nnh5kUx6YzJNQm88=
Received: from BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41)
 by CY1PR12MB9650.namprd12.prod.outlook.com (2603:10b6:930:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 18:33:42 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::e4) by BY5PR16CA0028.outlook.office365.com
 (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:40 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:36 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 13/21] x86/bugs: Add attack vector controls for spectre_v2_user
Date: Mon, 7 Jul 2025 13:33:08 -0500
Message-ID: <20250707183316.1349127-14-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CY1PR12MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a81512-27e7-4ecc-8d4e-08ddbd84cbe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6L4gZq8bWytBESqKSmk2LZpc5wCHqu+uFwpOkXtacPIaLU/yNLgEWaS5TSZn?=
 =?us-ascii?Q?bRF8guWSgQSB5hv2vPe+MgRbXkB/Qvc3hBw6dSrwYkIBlFjzcmX4zKioD68J?=
 =?us-ascii?Q?YcQZ5mpD9UY7FtNk+Fwkj+8LwBLhUwrR2ORuc1pPWM9ZV+vP5jC3eMwTjBKF?=
 =?us-ascii?Q?z+68oM1GRD4ux59FHSw37DlPB5NQtlyHzhHzHavrBV0FF0ctUrcrEj6be3iF?=
 =?us-ascii?Q?Y/bfBJRcfNtKgDUjWGcpBXFxW2UfaWVIZwzqspsQ/4e3u4uAu4CfERVBIDCq?=
 =?us-ascii?Q?AUUJvGrgg4TmhtlBknhJn03j63XRJc8DT9SCaREQ3HIxy9m196Gqqi6MLtpN?=
 =?us-ascii?Q?aRWGQLWqphOcrnpIaFHQ62YwQj81m3+0jpM1abPUzKUX0Gwyl8wyWo+c6iti?=
 =?us-ascii?Q?uj301iFdhKhJ/8F3kwgvQzqDGxI8LpEWZlQdFl5ZdPjc9B0r3I7gTdhxq54H?=
 =?us-ascii?Q?5BsMHQAwJdQT26e1TrMDj8camfhM4RFnnvV1DrYMlz3SpTSRLz5iTPDDjZGd?=
 =?us-ascii?Q?4NW7+uGO/7rFQJDs+sTYwuOfEJH1e9UK82/qxFOUq/fRm/27WTfXagzj0JFj?=
 =?us-ascii?Q?yE/f2Fz6b5KBkSoxLV/sFeyw3hKJEUsRz5Ywaudi9CDjDW9Fr7mJiLAwwURu?=
 =?us-ascii?Q?i4FLI4OzjS6InZix4/eZwClG/yQKWbfRyZGM0mcWbyp2DDNvbLPz6eRjs6mq?=
 =?us-ascii?Q?H963DLbOX4+tlgCI7qMwS4fkR1BXGfJqKLwkJ28O6cDcVVKLlFf8Vf5X9OT5?=
 =?us-ascii?Q?iL84+b6MZAc8vfh9KsQNILg0EpBZ9Qh3Y3tuqoCmDpnf45E504qmwz2SGTkG?=
 =?us-ascii?Q?MYp4/LBdfmnSICPfdGWe2tZDQX9Lg+dpRiTYoRh5ASryahn64eTgaFikE3C+?=
 =?us-ascii?Q?IyFd5vNltJqds53x+CaZApAbtm+6pzflEFd7NvF7d0c1vL6xl0/nW2/tiT7b?=
 =?us-ascii?Q?0kly0xaG5Im1OfaIetgu/2dQeipmIjQdgtQsxMwUGbzoVU0fXPydglFUDrEn?=
 =?us-ascii?Q?RuuqQ7riyPmB1AVOL2KEZX1EBG7AYkAJ0iP7SX3NHc3d2FykRwqO4Ij1xiCD?=
 =?us-ascii?Q?mIPnZuknWdcVYQVmtIguItyaM4zc38QseKHUQzywK5Ei6MuC1y/NmpTSs6Sf?=
 =?us-ascii?Q?byft75FUGQY6ZwpEJrv2N7Ml5Gy+dXDN8M3yBYjGPAvJg0sibCZAn5+Ku+H4?=
 =?us-ascii?Q?slaUB+63c3xiCqfhvsqGX4aAQ/DQnSa382EH4EIQIeSpOx3yqv3YyNiHojue?=
 =?us-ascii?Q?JO7v3COLlkco7lkZQS+mQSRmlwm2X290k5mXjMSR32jY8K+9aG1KF1l311M0?=
 =?us-ascii?Q?ACee4Cw7+ZjUCSryPpyP6UL5yMnQTcRhOw1UQGnsPAP1FQDNwe21W/PEdmj6?=
 =?us-ascii?Q?2+zEVsO84Y/vOQrj3F6UG+t4zxlNQqXTrgl9aAjHP7mKcyEq9EzSU/Fj3lrK?=
 =?us-ascii?Q?uRFERIjfDx3Rgu/NUXQqRSQNxW2wuhO+euBZXaKf2hu+vStJsB31jUIwJPqg?=
 =?us-ascii?Q?sSNtJSR4pE5AMcybC94JVUytsWCbcjOMvRPw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:40.8953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a81512-27e7-4ecc-8d4e-08ddbd84cbe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9650

Use attack vector controls to determine if spectre_v2_user mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1e2dab9be7db..f331cd70b0b4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1725,7 +1725,7 @@ static enum spectre_v2_user_cmd __init spectre_v2_parse_user_cmdline(void)
 	char arg[20];
 	int ret, i;
 
-	if (cpu_mitigations_off() || !IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
+	if (!IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
 		return SPECTRE_V2_USER_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
@@ -1763,6 +1763,13 @@ static void __init spectre_v2_user_select_mitigation(void)
 		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT;
 		break;
 	case SPECTRE_V2_USER_CMD_AUTO:
+		if (!should_mitigate_vuln(X86_BUG_SPECTRE_V2_USER))
+			break;
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_PRCTL;
+		if (smt_mitigations == SMT_MITIGATIONS_OFF)
+			break;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
+		break;
 	case SPECTRE_V2_USER_CMD_PRCTL:
 		spectre_v2_user_ibpb  = SPECTRE_V2_USER_PRCTL;
 		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
-- 
2.34.1


