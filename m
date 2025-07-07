Return-Path: <linux-kernel+bounces-720359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95101AFBAB6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF82417EB43
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D526562D;
	Mon,  7 Jul 2025 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MBAOdELE"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03120264634
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913219; cv=fail; b=ZXHQYvu/dbLzqxzkbIuPCbQMYSLNE+FIwH/kthbgtQG5ruCpohK04MtZM5nWjIbcuA2xHxfRwvoeWOXhVn+n7IArQMKNtjFJq/4di0rHVZQ+XRAupwDOPZMCk39yP/Tlm4UkLn88sXPtYQq2wwfet1RUoUm5TEMyFH5BSNDs4gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913219; c=relaxed/simple;
	bh=V8+pxiVOnMnt+/6H/lGw8wQw11fzD7j6TlwutIKkEmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQrKF02CtrYlDIx8Tq0UEhlNU78ht0B0LaF41dvzb4yvystZBYrGiIZUuQvXRwABLRu330qF2YDZg8slJyxv9d3VzzqKhq86gesyNE/ZrO8Y+Hhoz3bpruksHB8JhSD3F2y4rtIirzUc0jkbCtu5XeQUX5JEUqePB/n8WsToEzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MBAOdELE; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geC/PX6wCMDpqfnaMM/mpWSPea96tJhsyGHvNLxEdr6WKhev6UJeGd/xVXFothJ1fIFwQd6B66FUY49/dD4Sk9iAVFtE+lIFVycULW038JxQYSgyufXdp7fgOvCoYz8lfJSt97omsaEANche2/sZpLAH8THRJ/vrkK7KPZ5cIYzEkyutTbqLAZLQQURDLOXZ+SH0Ll6TMxkSW7GzzOG0TrpmdTIeWp8nT6yzrzp/CfJJRF3RgdbDXVdPsAyDQF0zHVTrQESq+XUAZe1ZaZVAcl0XYprYcCGcdWWrG1zMej0lFYwVo5BvrJyZlj8Iohp3vTHzdzZKTKurbVBsyQMrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TwrM1ZufZ/SxBaK2uFFOk8IxCD7kvP/kXtjenaPB4I=;
 b=RQXxBoyi8eHrW8YJikDucUZ9iQNTm8/UnDHwLv+EmAyNHbJNRYkdGJ21jG6weP6RG96gUkBZS/4zxdDTXuJ8u2gmKuLK9KVktRWpaHwY4y9RxU7kDh5AC0QotYMjLGimUR6U1nsyKNyEBoW0DjhpPYN/4r52sLxltoQa2K714xdgCuZRpAsSzkjz3E0sOUAEr+R2QnmeYid5RvxIFSQbSuGGQRMjAPJY1xuVP08xQH+XTggD1nWbeGNCdVGwZF7XtASljta6hTOMMETsxVLNx4lOS3ZrpK7dw++DYBjhH88hVKd8U/AiQYuGCH9DmrMRtns5TZjcLJGfyNZrfQD5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TwrM1ZufZ/SxBaK2uFFOk8IxCD7kvP/kXtjenaPB4I=;
 b=MBAOdELEe2rz+AYGqKY6w/nLs2rnQTZceBjZUsgrHi0tR7mw0v/mTjuYv+TBS8JjeZF9J4hvEvuXD2zzEsTR4lbmZ8BNOGL+I6V7ZHHMQW01R553ELN+Mcgxfjl+C1t6m13eobZZMPbV+b1UAdMSwOB14lo5oRmQy5mlXXnF86U=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by CH1PPF6B6BCC42C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::612) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 7 Jul
 2025 18:33:35 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::26) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 18:33:34 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:31 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 05/21] x86/bugs: Add attack vector controls for MDS
Date: Mon, 7 Jul 2025 13:33:00 -0500
Message-ID: <20250707183316.1349127-6-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CH1PPF6B6BCC42C:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7e378c-c34f-4622-758f-08ddbd84c854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LzSFBJmIRJWz1NAsX1QADP/bwxZV+ycKRU081HFeUjhCkcv4JF3mF2CVZlcx?=
 =?us-ascii?Q?67CFLnYZx39gPfu4wXvHO1lOXdaWGlI0h6W6w7R8j+9tUOO8lMBcT5CxGazY?=
 =?us-ascii?Q?qI1jl2KWKhkq6LA4lSKpOAwrx4IS9KwmPGezUhyta44s3yyl3PHKJqwkmN/J?=
 =?us-ascii?Q?vR74MgcJ63b2NPK4sLwIZeoxwofQ/D5N3q7q+qwQAd7XXRGI++41F5Nj3UDQ?=
 =?us-ascii?Q?6QX5MlJqOsBXIVaZIo4qZuo8cjSu4phoUYc166yw5yjdGh830/zTb037ycaO?=
 =?us-ascii?Q?XTAlFU7m8NtbUYQ1AqpvvQLwRtjXnSxLyRDYyUe4a/0DK2KvkRjdFNyM0wZL?=
 =?us-ascii?Q?weYZgLSnHvUo+sm0pYdkHAZe7SSl6Xx7w8ExjkcFcZaSqztrrJ+rs1W0yLYw?=
 =?us-ascii?Q?tfWh/enr5zC4iJGIn3bMoXwPHEkVIkxq3itjOARCdHkRljIhEMsKa323lQqH?=
 =?us-ascii?Q?oBEJXH08qXOLnAInf9eIZ6BDUa4yWvJA7sOUQV84bfKuIStOOMid8W8QYjhY?=
 =?us-ascii?Q?2TFldJ6udKqmd4FOiWncztp1SNi0H+bYpl/V9Sbtpk/n6CZUzL6tq2oL9ofB?=
 =?us-ascii?Q?wt815x3y8gPL2TH6ZdiG2QdbmYv5BJJoOBz9nhPH7xCyhCzCR/HSB885FQ6f?=
 =?us-ascii?Q?MX3yL5wBdARrp7BSQnG9SGIhyg1ViosgmzIaBbZdF9QKDLjTVHx+utZJkuMO?=
 =?us-ascii?Q?sWnZyV8S28B+7g9VttDTeU6RqTwW2PfKv1miaeRQdW/hV/HAFwuW++yhONK/?=
 =?us-ascii?Q?u+xbeO28LC2HysaKFvNvtMsxPYHCr+UGf/afWll6kCUoqGz4KTQ+ZUNnbinG?=
 =?us-ascii?Q?3B1goEsSJ16741O48ufliYurOofjwVWypHc0NvMUTNI9s6wtIpJu+4pv9cHc?=
 =?us-ascii?Q?SD4A/ZoDHNa2j1U84hBpPsGfap2WE8uxceQXW6mH2cRJTRKW/BwkDIi5E/FC?=
 =?us-ascii?Q?cVfs2RNQ5araSCwut0Nn1vSUXH09a2iSVWEVTccDZSH5h3A9blZv5/ZLTB0B?=
 =?us-ascii?Q?+6ewTHVtKVWM/wcj73AFFmwpCejSlzQOKy0cnO0pdeylyIlIIstqCf63nG62?=
 =?us-ascii?Q?2pNIcxcUGeZ5mzbhp9N2s8LPSYisbZSi6ic1YiXQbw3ew3p6WnDyn/LgeidC?=
 =?us-ascii?Q?iarNBUhIHoqrbYKq5vC1hmVl0ErstfWTZAQJFep5P2/5DUeyGLGC6CGmyQeB?=
 =?us-ascii?Q?wC+o7fnwG3x5nSWqTNUvCUZyKa2z4LJC5gzd8P4gMG9yQZw7dWr7G6D2C03S?=
 =?us-ascii?Q?zZzvj2El9PJeEXJGnKOhC49ea6AaDhKhCdyzPlzNtB2lmUQT/N6tf7SElSqm?=
 =?us-ascii?Q?gZdTTc8bZh3dytfJQqmByzmKNqH5PlINdGgkNkb/VIqSgjWppgqtuMh2xIgV?=
 =?us-ascii?Q?ZbkhnHE+BgE1BuF/0EXMq5RcdQ7dCEtXdTL3fq8jhSX+AHRLDhkqj9X2vbFx?=
 =?us-ascii?Q?f7wsHPaxTChnvQXoXg42tB6IGhD4px/tkGKxK+I/uGgTqsipx1y4UYXv/MqL?=
 =?us-ascii?Q?pt+Gi154gglKetQFP9vcmcKbrZwnJBCc4fL7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:34.9429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7e378c-c34f-4622-758f-08ddbd84c854
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6B6BCC42C

Use attack vector controls to determine if MDS mitigation is required.
The global mitigations=off command now simply disables all attack vectors
so explicit checking of mitigations=off is no longer needed.

If cross-thread attack mitigations are required, disable SMT.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1fa0704a8694..65d482aa450f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -437,13 +437,17 @@ static bool verw_clear_cpu_buf_mitigation_selected __ro_after_init;
 
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MDS)) {
 		mds_mitigation = MDS_MITIGATION_OFF;
 		return;
 	}
 
-	if (mds_mitigation == MDS_MITIGATION_AUTO)
-		mds_mitigation = MDS_MITIGATION_FULL;
+	if (mds_mitigation == MDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_MDS))
+			mds_mitigation = MDS_MITIGATION_FULL;
+		else
+			mds_mitigation = MDS_MITIGATION_OFF;
+	}
 
 	if (mds_mitigation == MDS_MITIGATION_OFF)
 		return;
@@ -453,7 +457,7 @@ static void __init mds_select_mitigation(void)
 
 static void __init mds_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		return;
 
 	/* If TAA, MMIO, or RFDS are being mitigated, MDS gets mitigated too. */
@@ -474,7 +478,7 @@ static void __init mds_apply_mitigation(void)
 	    mds_mitigation == MDS_MITIGATION_VMWERV) {
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
-		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
+		    (mds_nosmt || smt_mitigations == SMT_MITIGATIONS_ON))
 			cpu_smt_disable(false);
 	}
 }
-- 
2.34.1


