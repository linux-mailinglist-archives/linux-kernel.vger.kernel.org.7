Return-Path: <linux-kernel+bounces-720364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD91FAFBABB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC096189BB16
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09821268FDE;
	Mon,  7 Jul 2025 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4wIpuobY"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7CB266B64
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913223; cv=fail; b=jyZmasEc/KAdDybRy9xPUVZa0rv7BaX8jsxBrk4wGlU6YfyIS9i/Dmjfj3xGQv0MZAH2jFiEkotREbE51bp3Sh4KHWhDYSEHs76SDu3ZNrJ8FvO4e3o0KXbioG4TTKuO4xCMVuMl9O3a1UjFqrPQe6wWnWkE/RJeXAQdui2YSws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913223; c=relaxed/simple;
	bh=r/hMXQgueHWGgSInaJ1RuUDzyMnL3WYuru4ZGsrn5eE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hskmGnLr6RgbHjJeWd+5raNpmEvW7ZaKxQJK/1Iqy2KvvBZQwc4LZuGSMf6TNonf5M7SNlsqxdRWJf+1Rp34ErT+l6w1WrdvQ2rktJsM9MMRUCZ6saSRQhNTUcJiYQjJBLStSB9N5dgHNOLFc4fpF8cWNgTWl1DK99C0xEI1qME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4wIpuobY; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4+pHlkCz7ApqeOvNi/QqmVDA/QLEiYUZ9SbQEPPXAd5sIIhQWb0W4O7P28e9LTpdEcJItiFw06MPq5oW1eSQdfsPsN+MRpv7LeBhQr//wwv8zRgr6n+g0CYZQz5TussX62E3jxX5xOA6LWFb+2cD6KnLs68Ayv50ca3K95f7hlmqZ3kpTVcZhWr+qMtevIKqvQCGtbNDPig4rXUMaUirYL4e3SiAwcGhZnJperZx8KaP1uW1LLu4vKj5/c5tAREfi9ZiUDbKM83+2xXJOP/aLEQQEhCELWmMed3q1BoyFXa5NAucYh7/y0BWovebSGr2+prIN2u0W7qhXrc5vJM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn2mxXXwRu2DrksM1ojZ3Nzg3J+OUp0LtkfwNyavTeM=;
 b=r4QfvMHIZJX90wLvrhFgW/bWto1rGxIfa55jwb+e3kV3Kbu+vYm7rRBSBz0kuwUCy/nLReb3pqgv5U2jrfThVi0aQD0p+wr8cMqbd9ew7TIXR7Z+PJI7AgIX1Tmtnt3k0PZj42sA5J+d8ouIZBLmxz6Aifz/FI3P8UPEpshpa44wIR8GRw9DikMEy++PGGXB3BdBFZBNbmCObqWtFSZJpBc8c6tU2ZZUB13/4TowF0gJMaYosQEukp6E4/b9K37C/mc3xk8pdnNqTfTwBrbpALNDqGa08V3KiBy/BYlPb9rEOCrIToCznPbpzLFjR5IrLgsD/WqNIWvIoVHHhgctVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn2mxXXwRu2DrksM1ojZ3Nzg3J+OUp0LtkfwNyavTeM=;
 b=4wIpuobYo1pUVbk4WNLV51GeJek55cMKazadRZLlGmeN8R5GYK7mcwHDp5umVJI+SQnHlw+I5h2V+XlQN+hW0wk8sBt3wsaW7/orfQahy+z1wmRyPU+6nUocUuTLMZZXbloqOXg+NvXKnOctu6nEWmwDCgnl9cpgJxwAVvkg1TY=
Received: from BY5PR16CA0017.namprd16.prod.outlook.com (2603:10b6:a03:1a0::30)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Mon, 7 Jul
 2025 18:33:39 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::d7) by BY5PR16CA0017.outlook.office365.com
 (2603:10b6:a03:1a0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:39 +0000
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
Subject: [PATCH v6 09/21] x86/bugs: Add attack vector controls for SRBDS
Date: Mon, 7 Jul 2025 13:33:04 -0500
Message-ID: <20250707183316.1349127-10-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c10bd7-69db-40d6-6017-08ddbd84caae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wrO0mVqAPReUkQHm5BcnHr7Viu+UVa+GMcmsEOZmEcX4XNX518TkHdLaq/My?=
 =?us-ascii?Q?h2oc2l/DoxffpcmwsN4ScUjqIz48yjKay25YZO4SK3BM6SqsSwfWm+ggrHCx?=
 =?us-ascii?Q?PE9YxmNbhGbN8TOT/2u74evkdn4eb9nZBcAmSZecCDR0Pa200RLGvDf1b3BP?=
 =?us-ascii?Q?SR+5LHB4Sofx3Gy9V/5XklStbbD47RtDpF4Q/8/iFPd+rLG6P27lMg/gLYjX?=
 =?us-ascii?Q?qh756JDCvlVsLmdb2Z6xLntF1yEjE5V1yV9qzt871vhPQA+6jCcJH5dMRJp5?=
 =?us-ascii?Q?CdmyJpt2tKIfQ1O1H42h5Su36PaHkb0JwcSln1UTfLJ4jwF35HJUDWg2MnJI?=
 =?us-ascii?Q?ZJWgKdBN7kZ1OPHxdszHTgGUgYjer3xuoWMomYeDpQXB/WGpZtiYr+EK4w8P?=
 =?us-ascii?Q?aBVPaxmD/P8vlmAYh+siI8cIaRJReLRh9/EIKFdatL5TRqQ5SEMfEuafx4L6?=
 =?us-ascii?Q?SQxQu5u3UpFpP/klzAauf351GFcJpbpE2ss+s1HZTC+KyJsQrEdA+p62vYUI?=
 =?us-ascii?Q?UtbE9lU6b3aeIzt7sJ1JAvE+8xQHSL3wOZ4DZ0JkfDpEv90afRy/PoMHDwFi?=
 =?us-ascii?Q?AEoBqk8jMC8edIY756H9H0dWcyWnvnNPT8Dsb3f4zDU/S1VWTz5DcNVuNyp5?=
 =?us-ascii?Q?YywNhb0gDgLhIytYZf74KkdgFR5WSSRxbfAwrRGYzUngsKnWqw2aJaTdUPE7?=
 =?us-ascii?Q?4YtDHnlfdXxnQrW7dDu4um/LJDFQmcYgTlhNw7jh5uGLIDg4Y/5KOt2lLp2i?=
 =?us-ascii?Q?COhUa+Z4Hte8KVCy/ErT1O4/vdYggm1xs+z74uFSEJoecMjAJdN/sSh7FWJY?=
 =?us-ascii?Q?CCkU14FYjldrrxhAD0OABvdERddpGWRuJvBZB8BWFuKnX4y1N0Zk/OPChcGv?=
 =?us-ascii?Q?NHD1WCgpi3k+uWYV1NCe2lJY+TQaoNInZmS8IUOh30xIzgU3mHY+PO6zsPUo?=
 =?us-ascii?Q?k+pe5SEmzVcOoAEVamdoRtQA7I9BFR2uKQnR6YnRV12NSYSkxntyoPJlDiws?=
 =?us-ascii?Q?wSBRZR0MyVqVMcglfhiZCWbzJz5Mx4db9w/6CM4UaLrUL0oNvAboJc8MgomC?=
 =?us-ascii?Q?pK0MYcC5rBVv7adfBhT9gGtzXzNAV1TRsXFu9Qh1Q8sy2mPe9fLnNyGc+fBE?=
 =?us-ascii?Q?/iYrywbO2OSmt5cA0wtODdAXbd7n1a3l1PMxDuFtnn3+ahOuOVhY2C4mS37z?=
 =?us-ascii?Q?k8dB03vRureTOj8/EsDnmTbJAjZO1LXKlh0Fq1ySN5nK/4qOFjLarnuQ5gAD?=
 =?us-ascii?Q?gBkm8YmUB+vghc33DCfrpsNKp96RcMGlm2+GfVTJ7B51WLnH0WEXRHvN2TI+?=
 =?us-ascii?Q?PrdSIcuLMA14gIPfc7EUZ06eacfzjERkHtXhsilZq89NpDeqHXTflN8tio8G?=
 =?us-ascii?Q?t4YcIeP+SXalvPNzXp5zB87wSOzoBiEIcwWSuptxKAnC1R0qOx5tMwZcmqA5?=
 =?us-ascii?Q?9F4xHrQFYsInORneJuPmR43wVar8AI1FLwOH2bazpiB0kTKzQRI9yLIZkth6?=
 =?us-ascii?Q?7NR9lsOdg0yRjas4G7CM8WkS9cE5Yujgd8PZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:38.8822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c10bd7-69db-40d6-6017-08ddbd84caae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238

Use attack vector controls to determine if SRBDS mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cf7d010931b9..e01fb83daa07 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -866,13 +866,19 @@ void update_srbds_msr(void)
 
 static void __init srbds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SRBDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_SRBDS)) {
 		srbds_mitigation = SRBDS_MITIGATION_OFF;
 		return;
 	}
 
-	if (srbds_mitigation == SRBDS_MITIGATION_AUTO)
-		srbds_mitigation = SRBDS_MITIGATION_FULL;
+	if (srbds_mitigation == SRBDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_SRBDS))
+			srbds_mitigation = SRBDS_MITIGATION_FULL;
+		else {
+			srbds_mitigation = SRBDS_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	/*
 	 * Check to see if this is one of the MDS_NO systems supporting TSX that
-- 
2.34.1


