Return-Path: <linux-kernel+bounces-720375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE850AFBAC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C194A560E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A726E6E1;
	Mon,  7 Jul 2025 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EH7JhKUH"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35D26B778
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913232; cv=fail; b=rEzgPXvn8tSh6tj0Icz55ilR1IVQdb2lh0xNBOHlKLlsH0bziMq0mFAlOI3QlWzT6IoGa7sFHSFMFxSVMG5sJ/YcutIsz5puBiIOguTHyRbl9cLqndGQoAZXDey8npVhQt5K9IxEwWHlgJFu5cUREdOYptscyax3k4cshfwVoW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913232; c=relaxed/simple;
	bh=fZJrvn+g7fUak1mVl/21qm81+84cgi9KenqyZ6zwL0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLNzRNWLJBrkxXAqjuvUnX0r/WcY1u7GRCs+Iz45cbNNsAze3Ck1YNkvmoEIgFZoe31aXFzRiCZvTacTL0pZKfkicqw47b2SEPWq1lYmnrAUoncQK95BTR+TqP8lWIUZyVfBTWIgYBtuMyceXPUwu7u6WW1ydf2rtXiNunVlxXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EH7JhKUH; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfZX+lAJIVugi0XSyFEIE6Fa/uNMtXku6qIJ2wmSSQh+fNpIIRrJG5DO6z6ZF2NT18nOHMu4Al+TgyH5wYzk35ZEuHC5nwMyD2qKDILt7og91qf/4sPF2d8luuJ2KKoaFgrkYYhiVRd1WHgI+fxaZsQqx/jd60UgHwm6U1jxCyBdVgizXhCn+ZuFaP1evEFtsEt1m6+PpxxrwnfBzRQ+DNylg8VphFkRQQNmJsZRMdH/3XWq7UAuhDwtGlG9osjc9c0t/iv4Sjzk6MONCMCSTlDyQ6jxShUCFwlI1heYfEwZbgDmDBKgbsU2DQSSo16Bx5yK2XYZj5hYRM82/rGQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6MguyxUMnUQJX3gsEj6dtK8QOsvw6mG9cfdX66P04A=;
 b=AB3FwnwnXK/xOhXlOmaqFK6mMpd0dPSG9D0aU4hy7JPGNJrIFdg8/+Ln7ILYZuE9tnYGUMwj2OssEqWKMoLVQlj6Fh+CFxEhwOGddHJGhpJKR5jcGfOQ7Z+dYsx1+UDVyZgDpqwZYp55hYcyyWVFqGNIHFAHru8xRHiareLanEfrOkeKd/VUqzLOOVK19ZV5m7anny1kF77pF5b8zVTryd/rtt5TWUPWJcJMPhNw95zDy5aBSQkWVmApX3p9zq1tT/ESP20I8uBbmvS7xJ+Qmee1n72595MrHjyMg7uD1uc+M+LYq8jpAuTQEtd+CuYoZkbRQC31i9vzfLsbLhdihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6MguyxUMnUQJX3gsEj6dtK8QOsvw6mG9cfdX66P04A=;
 b=EH7JhKUHWYno8plDhZRhLFjLz3vWrtiFQ63MoIHRZ5BoIsFegeTM0jWHNoJ4LEavHNAPDax8zAfKzdElkzSvLZriXXe2qqqD3bXBr+N3BfLBO4/9Sfgra3zzkruxZ7p+eqrWvSDU9uTQyEqRAscIrC8Pu0qiDIN4lT+SgTZOj/s=
Received: from MW4PR04CA0243.namprd04.prod.outlook.com (2603:10b6:303:88::8)
 by BL4PR12MB9480.namprd12.prod.outlook.com (2603:10b6:208:58d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 18:33:44 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::c5) by MW4PR04CA0243.outlook.office365.com
 (2603:10b6:303:88::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 18:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 18:33:43 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:38 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 16/21] x86/bugs: Add attack vector controls for L1TF
Date: Mon, 7 Jul 2025 13:33:11 -0500
Message-ID: <20250707183316.1349127-17-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|BL4PR12MB9480:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b0c590-3276-43d3-61d2-08ddbd84cd8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yh5dni87MkBjBqAvNZpOrLTwiUiwCv+oQgCCa8C9hG9YaPMEkiGnGKYpl3JS?=
 =?us-ascii?Q?M6fNVbCdCX7wUdSgtFVGVu1ScTv4dBZiyf+PbNFU83Dwd3ECghOfTN8qs0ch?=
 =?us-ascii?Q?PTonUV87tngUJ9t5SF7cz3sz+bnZ0whxvVaHSe9Fiw8OmGE0rHxPBT6/cg9O?=
 =?us-ascii?Q?INZBwkbmtkuc3Rwq8eWQ7917m/voZXhJQaF1ygQB3NW+bbJxC8s/cYPOj8mh?=
 =?us-ascii?Q?VPr9S14sanbG+fgyetc36fPUNR1FvRLlqEX/Fzwx10MgJnG+8fi13VtGBJkH?=
 =?us-ascii?Q?A5o+5L8+l1Y6XBjhSmt6Sh3K9xl/9D7yOAMkVK2rS4tWtnmQd9ujIr0BQabi?=
 =?us-ascii?Q?0nmemHD2VFAFIdEdXhiS/f9SxQU/+WIhoTJ/VMFqdHLcxk5Gc2e8q+lxpZDv?=
 =?us-ascii?Q?GM1T11y23Z5iyvF+K0OYYLes21k2Qo/HsrnI30M7N9w3VhPAo5fgeGrAmMSx?=
 =?us-ascii?Q?T0YexwVqevXP2gy06URo2XX/MYakqfJNYtcNjmYrvZEN1VcVjpNAzBfiyibe?=
 =?us-ascii?Q?9PRSt9Sl89ptOhIA1Tf9ZXGj9zQgbE3ZcA7TvVHOajNzKutuUnmsLRNfAoI1?=
 =?us-ascii?Q?sEUD0JD2HcM0jsWHzFcWzEAlKJ6A/lBVuRTEAXOz2ZCYJKGBvrKOi0xfpBp2?=
 =?us-ascii?Q?wKMF86ziTVVXCmm1ykpmafLLqNHJUnw9LtU75KfiP9T6uNPHk4Jddw0Pqjb5?=
 =?us-ascii?Q?3jmIWna4FDCL6o+YrltubEfXa2BczxKJxAVhOKPoPdM7N4U7jVOEqVWfTsfx?=
 =?us-ascii?Q?Gh77EkvPwo/ronBykz4i/D5o2fFt9KyvjPd3LulpWo2KEFGshdPwJwc4b3Pv?=
 =?us-ascii?Q?2tyNeqUz+o0lRZ/Wjyn7vjkL2svQGSKGFajAvCZZmiwPZ4qU1kZ6ObO0G+ga?=
 =?us-ascii?Q?Ei3/XyPULFSgGOzzMHmOmNINypaORMU3aN7McKzbwl27PXcUYaLfntElpu6/?=
 =?us-ascii?Q?o+E+BxMJqtjS/UdozTN1Mr8nu3HH8q0vsC1h7lIKUontpzppvifCAamIrw+1?=
 =?us-ascii?Q?CYcnEgZvT9aGqGYY/Pi3ztwrYrG+zgDPJ86WRViTKWan+HTQhAW3EIWdfAx0?=
 =?us-ascii?Q?NVGVnTCxKtxxMPQ50lODrWr31DMKOnfbu1WMkl5/E78R9AEiTTO5/kFlzJPd?=
 =?us-ascii?Q?SeWNnCRyThidq0gI0Z8vk+evUFwfRGAjwyMhBdjEHgl3WNmg7AzefD+59PL6?=
 =?us-ascii?Q?GElX8awn6SvklchtT5ETLtPAGSWoUat78rb9cBUSTX/5Kzj6Tx2W11dygEOh?=
 =?us-ascii?Q?pFxDqtME5Ixy2KIMz6rB7/br8I+PO2lJahK5RsK5FhC0T3K0K47GJolEHCRC?=
 =?us-ascii?Q?TCFc3r8qqf9Yg3Expky4uVZT5GcGzvCKrBsTB9ZB4XfjznYJJlppuZ8ejBLG?=
 =?us-ascii?Q?eFpyQ2Aa+Ho+9q4P7n/pQw3mejdp0rYAUToDlljdun/3Ntr7hcVfxH0I2Do8?=
 =?us-ascii?Q?tytsfjQNycsQ/grignkoFvy+yhaHSnD9hD4JE+YHlpJsdVIVfsAYkgwvX3UH?=
 =?us-ascii?Q?UiEzSytHP0KsjRVlAoFxhI2bQOKHN6HB39tu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:43.6929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b0c590-3276-43d3-61d2-08ddbd84cd8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9480

Use attack vector controls to determine if L1TF mitigation is required.

Disable SMT if cross-thread protection is desired.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2168e75bc1ac..ecfd7d728ac5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2884,17 +2884,23 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 
 static void __init l1tf_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_L1TF) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_L1TF)) {
 		l1tf_mitigation = L1TF_MITIGATION_OFF;
 		return;
 	}
 
-	if (l1tf_mitigation == L1TF_MITIGATION_AUTO) {
-		if (cpu_mitigations_auto_nosmt())
-			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
-		else
-			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+	if (l1tf_mitigation != L1TF_MITIGATION_AUTO)
+		return;
+
+	if (!should_mitigate_vuln(X86_BUG_L1TF)) {
+		l1tf_mitigation = L1TF_MITIGATION_OFF;
+		return;
 	}
+
+	if (smt_mitigations == SMT_MITIGATIONS_ON)
+		l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+	else
+		l1tf_mitigation = L1TF_MITIGATION_FLUSH;
 }
 
 static void __init l1tf_apply_mitigation(void)
-- 
2.34.1


