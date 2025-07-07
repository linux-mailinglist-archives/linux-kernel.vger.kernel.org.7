Return-Path: <linux-kernel+bounces-720358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2374AFBAB5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6073BE749
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E54265609;
	Mon,  7 Jul 2025 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c4LzZ4Jb"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02A264614
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913219; cv=fail; b=K1wPITg37mRbWccdQjk15Eed212oqCKcWaf6l4ES5c4GOKjhRp2w5olZJCkiiH6wTGifkaWA7zJhHLWvZTL6CoLsQST1omGxU5utsJRkgUUpYCqzfh5EUyfgKWWtSO5Jivt1H3lEpKRncAVKRa5JuDuxgw35DH2aWfJIt31YTJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913219; c=relaxed/simple;
	bh=+Pb224qAc4QTNpyxqGhYGhm6Tl1fnIr34RGgJguD0LU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVRDdbmUqvYJAcX+8p9XDlC8SLm6T5bxGdDBMs2eYVmOT4Dh3SAqXGXg0KgHrOMAXcdzMOa2vijrFYf34Gg7X7J65P3vUtqsQgu0+xG7+ydYU24BJJtkkND9cBPkQxX7wJfm2FaRnrWZJOcajLSzzMNeHpe3j8iFuJyx/6Ojm+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c4LzZ4Jb; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbeELRkuSoaXKb64ugkMZyL4lQFlREzL/pqv2qPfRjzapqdi2OzhltXn1NvAzjFk5ZKq8grnHpnNCRSqwWKN4VsyqdqRm1ZGl1+3iotrSR0VRJEoNOPRE3yAwM8FcjYvL18I4QP8uokITRixOLaPtFthqNjAHWSEC52zeLI8qGJKR/P4zTCsdEYlLGeO1liD2aYx/x0qAB3K8TYevpQ4ZrW7mRDlpO12fdRrxShAsmP16spWKdDnlvTUhk5pyvGjWNJ+VYOdwBDLQY0dB+v9kZS2dbXmo1xclbAAsXsxnVezeXGOwbA2sl+xFy+ml8RA/trZeKrczMA3xccrl3mFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1JH5Usy8qtseJxDu6eziz6JIeWmTTUQI6Q1F43ro3Q=;
 b=la2cubFjYmkf08JIhnQYe7SBNy/3AKbNzax+mpAz8SyVQg9bOU7DmP5oC7hYr2pa8EF1HwhJgDpO5y1Z7RoloITKUTGySCQMq0HnF4A7sg9N93U9/6/sxITGhw4ZyEuXVEep6gFeXvT1Og4Eifd5mqQAQ578atnCzXCNYUVfH6hhwGOIKzKBoIQscPVJtcW5FzarrUi6PLkJFUoTwq0zrtX1mYfdKUbDc1ojYZ1gDBluDFp5z6yUDGMxgyBqlNjT0+4tDTBjN+rMDdxE44zatYK+umtavKl+PbdbDFeUs3c4V8T/5H+AVPyjXlbrFAMT6/aOwyqySUZfpEk27OKaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1JH5Usy8qtseJxDu6eziz6JIeWmTTUQI6Q1F43ro3Q=;
 b=c4LzZ4JbqWEybUjPzzDIpuWJ6243orWXaZ78+dtIWGFXWrY8rxG9ogBDJfCKe0pkKYA7zudDSXFTsELu5tT/40mLVZDCNesjgkgpZHg46Jm779Ge5I1o/+9/BGeTkdXS8n3IexYijt4/+d+XKx/YWpqbBK6e+wLaIA2Ji6RX2uY=
Received: from BY5PR16CA0007.namprd16.prod.outlook.com (2603:10b6:a03:1a0::20)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 18:33:34 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::2e) by BY5PR16CA0007.outlook.office365.com
 (2603:10b6:a03:1a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:33 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:30 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 04/21] x86/bugs: Define attack vectors relevant for each bug
Date: Mon, 7 Jul 2025 13:32:59 -0500
Message-ID: <20250707183316.1349127-5-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: a69d3de9-39c4-4232-337e-08ddbd84c7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eq+suB+uSSmspch/90Dlu7G3KIngJd4HCLHnsp6MHyTjciEHvPuLZz/NotEQ?=
 =?us-ascii?Q?sdX5wqmtolvCu2meeamL+3tLeyMSiFOLqhpIOqJ1Hnjy9xITh6xoXTdBsekD?=
 =?us-ascii?Q?i+FlxgD9Y7/Pqaqm8qwVEi/sSC1No0pzZpTifWswTK9NbQ+xoTf0YqUUhQ7V?=
 =?us-ascii?Q?R21QkEmrJ2bYV2fJEhPVME+NXYIgp9GNYoXFNj2vX+6sA2wJmSTqnlEp5cyp?=
 =?us-ascii?Q?qEmvfgWASXXrOtSWYLhzsuL0IK2OqQgfHHyyzolAo6pmfZrYZ3W1pdqWXx57?=
 =?us-ascii?Q?Mzi10IAnUZKVz7vGJV/CoS6DMWwgbj2U431vbG69Ei+xMbmlpDI5FM2DSor2?=
 =?us-ascii?Q?qQ9lEd7K17oevNmPuk+c56+Os+cwqCD9/6kNKmbc39I6EfQ6iBI+TPQDmbvX?=
 =?us-ascii?Q?Ypb8poqLPKq2qrSAEa6tlVUAmnhALWs9CikrzDokkOc7XE8Ea7H32THOB+yp?=
 =?us-ascii?Q?5LEgj8elQuk1T6i1X1duDh8QsxaIAPHbu02fX6vJqs9ilP1eiMVnmlUt0TZU?=
 =?us-ascii?Q?leaMTvg7/baJwijAo5uqceNi4vOWEp4x/sidl8jOC9NYdg2Yam+9ejXPSkQ2?=
 =?us-ascii?Q?Kh9n5iXma3wplZCDv4lS4aFSeaM028bo4b2rzXqxEfhW9vkocCT8Ie/8g/Ee?=
 =?us-ascii?Q?JTAJY7dT92DiJD9Qs891wAwXhHWZjtftYAvK1UmvLyxNPl00CXFkPjuooTfo?=
 =?us-ascii?Q?mq34+/6PSaIDmz0z7Y8LTh1mkn5h+/sXIStuw6Vxm+Cs+KFFpdHkx5ybng7v?=
 =?us-ascii?Q?A/qNBj/5wh1UFfDsWj564HyjkpBw9YPUL5tELaFXJY8gL+iXt4YHIbHKip7V?=
 =?us-ascii?Q?dnl4um1or8+e/9PSaDHi8nY7CfnKKfBKMIG7L9vQrVNfKeQvo4ivvvhxwUx/?=
 =?us-ascii?Q?1LSuY+t8eYL+QnPUE5Q3F7sPCIDXeBgOTZYXpTpIprkWRdFwEYGrfnWWf56f?=
 =?us-ascii?Q?4vXMx4GjoztD0mrn5nsb3FnVnxCJe9hpprswacEhsiYDI4qiJS9QoiyNDTxj?=
 =?us-ascii?Q?Ppxo12pfyuGggpi9MWgBED6z/8U57KlbXp4lDR5KCmp8s8AcAauuULh1tNjS?=
 =?us-ascii?Q?Pgf5M3WLydxoXl4fC0n2t0OD0NglSI2k7FA5PV1i+5ztT6fAOfsQIsMwyt86?=
 =?us-ascii?Q?gsar+chVNrRgacV8ru8N8la12ypZ51rEFRfBsFkWdjfC0cPI6pxM8MlD0Pwa?=
 =?us-ascii?Q?veQNm9F9Qifkp1DXjF3I0Kj80kytLDK8B7dgndT52iq9KNKNzv+m/BsXPCed?=
 =?us-ascii?Q?b0QG9jt2+Qxznb55rtrrlmy9nTmExT5c4T+QHYvRTq1+alAz/4lm7MD5zIEK?=
 =?us-ascii?Q?yn8MSQp2EqAWILouMgOxsRyL8psKaQ5ghIrvj8BhbhqUa6X+ei6dvSw962gY?=
 =?us-ascii?Q?M8drexi7BqlVu9D4xV6PWlfT6RlKsSLqmp4nz+fVdRzlJG+m32nE0ViRsMOF?=
 =?us-ascii?Q?5gnGMPlQW5hxDc3x0QdxHB8r2fx8nhb5jd+wTBbHs9IL6i+4RkkksHPVm+iB?=
 =?us-ascii?Q?Q1RBqqVxSxSEbf66YoRPd1Es+NHdopR5wZ6k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:33.9002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a69d3de9-39c4-4232-337e-08ddbd84c7b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739

Add a function which defines which vulnerabilities should be mitigated
based on the selected attack vector controls.  The selections here are
based on the individual characteristics of each vulnerability.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e2a8a21efb10..1fa0704a8694 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -328,6 +328,62 @@ static void x86_amd_ssb_disable(void)
 #undef pr_fmt
 #define pr_fmt(fmt)	"MDS: " fmt
 
+/*
+ * Returns true if vulnerability should be mitigated based on the
+ * selected attack vector controls.
+ *
+ * See Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+ */
+static bool __init should_mitigate_vuln(unsigned int bug)
+{
+	switch (bug) {
+	/*
+	 * The only runtime-selected spectre_v1 mitigations in the kernel are
+	 * related to SWAPGS protection on kernel entry.  Therefore, protection
+	 * is only required for the user->kernel attack vector.
+	 */
+	case X86_BUG_SPECTRE_V1:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL);
+
+	case X86_BUG_SPECTRE_V2:
+	case X86_BUG_RETBLEED:
+	case X86_BUG_SRSO:
+	case X86_BUG_L1TF:
+	case X86_BUG_ITS:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST);
+
+	case X86_BUG_SPECTRE_V2_USER:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST);
+
+	/*
+	 * All the vulnerabilities below allow potentially leaking data
+	 * across address spaces.  Therefore, mitigation is required for
+	 * any of these 4 attack vectors.
+	 */
+	case X86_BUG_MDS:
+	case X86_BUG_TAA:
+	case X86_BUG_MMIO_STALE_DATA:
+	case X86_BUG_RFDS:
+	case X86_BUG_SRBDS:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST);
+
+	case X86_BUG_GDS:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST) ||
+		       (smt_mitigations != SMT_MITIGATIONS_OFF);
+	default:
+		WARN(1, "Unknown bug %x\n", bug);
+		return false;
+	}
+}
+
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
-- 
2.34.1


