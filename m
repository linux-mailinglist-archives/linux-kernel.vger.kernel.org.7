Return-Path: <linux-kernel+bounces-850720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBD5BD3A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B61A3BDCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667E3090D0;
	Mon, 13 Oct 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ei/Wwz9A"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340F03081D7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366131; cv=fail; b=rJrAtK5xjYMh3Zh+A4919sgu3UspRvwDUS44sDb41UgcQRBN4NLV7RnOavL+SPXqSVAhY3QT9Z+MVWyKpjh2MA5mgNUgxRN5JKZGEVTf+FfQEpvoRklO/FZQejHlzxhU6g13SRnRJZnC0H3y6u8WZpYC9fqcb1c983TftXqrmkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366131; c=relaxed/simple;
	bh=gnYCgii+whL3aqL5OGcVub4rbWIAWkIZ9euOHRBUkQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aB7VpN1bc+f2A9rv43Z6dO1ViXiWkQp6qL5sg7T1SX/qeLcH9+obZ9E2FYAZMIK6nj6euzRCkppqN3bbai5Zt3Zp+bMYfW/4n4j5+UukosZrkbs3MAyQEFjp+FBTHhiMQtLg0CyTzEi13vxoQk9WFHGNuQ/2UFmGenXjvc6JvjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ei/Wwz9A; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzFdKDO424ELRVFqdfHpfdwrZAGOoqAcGtWt6mvdc9KTKQ1VTrUMuhtxqm7E80q1OP0kaOTIkPISaqLrGIrXLyinUCokoQKWzPWL3d3zorxm2MxhVvUDfaQiR2v85akp4UJX17oVV86R3rJd3pVNmSAHolS6Z4aTxYZGq6jlRij/d1vNddrsBTIi5Lx3U9537cwuHWxcg6TZqA2qKcEmVnsnzvHqMOTTlEJTEYYHqn1NCubanntT+8qAMI/x1bYrHdJxJ1mdHTsj1eqUoeJO/iTiILVPQP7hH1UqX4fFL1Kp68rKZtU8UDAnH87F9s+E3uKNqCve4kr3dApIn56rcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eifWsU6LUbv+jSM+HUEkLHKU+HA3dk98cm4FSQkmrcs=;
 b=J0rHO66jJvf5MnJlS2h0uIo9R6fXrf0DJdbMvzv2aLpJsriumLWicYTvzt+NuId1yvyTmbP9VXgCEZWJd3vNU9hzfglmzh51mAIw2RoPZICilV942sRY1oHJqAaMHaCyOiiKnDNyr9oax5bj/yW1D19X3bWEZWyCyHGHysgnkUMBnR4IUjbBDPDsmeUcqWNVcP/gbUH2iS7kT7SlCL2fawEh0BGu56O0QUEUDyqZtWl0BHuQ/UFgBjSVXFf/qRbe0HF0hBwAH4SlH3zFIS72fuuXjGUSCsV3/N0RvFH1LWkpup0NfOf3rygcW2TpyiEGr2qXGcybD4mnnT8zQvXvow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eifWsU6LUbv+jSM+HUEkLHKU+HA3dk98cm4FSQkmrcs=;
 b=ei/Wwz9AZh/eF0djlKU4/tjW9czOlXiR+FFDsb5qgxr/XF1oLtSl4aECUX8D78EncXb94zm2FFDxkQERgEGRr+rNq4x+uSWgy3XeBKdiHaP7MYFL4fqVM7KYAiHk2DT2GcYx3iQ+hdys+w5tKm0HO2aPVtJO2/AMUG4nCYzUuok=
Received: from PH8PR02CA0029.namprd02.prod.outlook.com (2603:10b6:510:2da::27)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:27 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::54) by PH8PR02CA0029.outlook.office365.com
 (2603:10b6:510:2da::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:26 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:26 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 13/56] x86/bugs: Reset SRSO mitigations
Date: Mon, 13 Oct 2025 09:34:01 -0500
Message-ID: <20251013143444.3999-14-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: c2573e44-4365-4f96-1a55-08de0a65c07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ls3LTOCnnwYIJcwKVgUjm6JE7BMIRfAnHfhHBlR9Y9WXruA6HDMiI/oNwIHm?=
 =?us-ascii?Q?+spRfC/7hVKGbqqsiWjndbzvLBXS6FDx6u4tWmONedk9WEz0a37O5aavdPf5?=
 =?us-ascii?Q?K5BbchGS51eFyKPfOv7bLQpNuoCfqIJxnmOjDdh8P91Uic76Gfbml3tJxujN?=
 =?us-ascii?Q?aNX7RZnIpn8uoIgfSbp4KWK39XYCvwixNLpYQ7VZoF9WPdeZ2iOJDe/u+vrD?=
 =?us-ascii?Q?+ZU/8DSYJ6KsHeqUUSLpZisheVCK4i2I6Ika78C0PuoB4YpPvqnsANdRYM+J?=
 =?us-ascii?Q?EjiCMaquW7qTh0vj4Hw0Ht69qugDpWsd4linDVlLYg/a0g1PhfWucxxPjDMW?=
 =?us-ascii?Q?HtoB+1hxKTKYlQ1AXnK3rKqhdzmHB3QS+ziaFhPRL9DDCSGQ7R8FZfrAwVmb?=
 =?us-ascii?Q?n5xqrNWRisTKbkF6pqDXvBaq/a8UroWZ2Se7ewKFf58BCyUqIx+NrnvIlTe+?=
 =?us-ascii?Q?lMtFeUfXuxHyrFJQ/3JKZUSxpzwSQbEDbsfTImIM/CNN8k19hw5yvMPPytPx?=
 =?us-ascii?Q?WxRSFocfRkR4TJHp2aS888bmitgVxIV/jsKXTR0Pru8lf9H1Q7Yv14hUHcfB?=
 =?us-ascii?Q?QIzn5W/gLTPn/XPbiZG6Zu341phoV6xUbajGXE1IsQXU5NZWRthoeTLNb0dL?=
 =?us-ascii?Q?Q7pooYMwH0ohozqhns5xE+5oRS8Mjznvd37UBTGFfy74vhNPsTCOIlctOoIX?=
 =?us-ascii?Q?U7D4MMtOhvWt7X4xgEHA2/FvFDlVxcA0ZbuyBl7GnnwIPmpeoEHv4wmxWjIa?=
 =?us-ascii?Q?Rn4m/zT5A7qxjF5ajwphmmzjT3FpUZ3n9MOecWpSsJJe58Bo4PowPvx+wc3S?=
 =?us-ascii?Q?5plEdeJPzulhVUG/KHO7uh1PRCOQyR9r6gz4LYlQBGUpS8RaeNhfTWXzaWYo?=
 =?us-ascii?Q?pdoSB6DsBYpzUlb9fmzQL56Mdsj09bdMDQ3I2wOahC95bG8PttUi18/2y87i?=
 =?us-ascii?Q?WUuhRJ9iEhZP4BARwAV1JPBJ7nynfYC8QwDCQHMgNEu3Z/Z/smIct7fbBY3q?=
 =?us-ascii?Q?WL3FhNBJT4yzTdmPzYUcXx7yM/W5fyASdxbrtK3Vo8o+fnkv2cs48Rb2NZDp?=
 =?us-ascii?Q?1XEBMY72J3IpCPaFxLdO4R29lK5Tze+OeMNYmYMbhCHJIV2sZptwc0zM7dL+?=
 =?us-ascii?Q?pR4By41K9DEZ9h94Z2iLQIx6avBC6moxDomzaB6NIHSc93ABAgERGDANQmP7?=
 =?us-ascii?Q?tWpZep5JqbUu27VaegpnPPWrfBeb/+wQpOJG4muqsItEnKhgcMGnBf3ZRuUb?=
 =?us-ascii?Q?2yzF0gDGHjnExvGy0/qm69Mx2ktwQUDnVGLHYpWQoEc2zxho/jd6YM0C1Lao?=
 =?us-ascii?Q?bU2DVftpGVwryssA+4ImRGifMnpOUAPWvO7zHpOK8kyt4rfvYX2/SQiAAoLv?=
 =?us-ascii?Q?FA2BBGUCYkyhVKUaU+iYQF1SgLNSW5Xxm+z5vkVb5h+W/1280wND9WmvzEGq?=
 =?us-ascii?Q?oXqsv0UqWCHezyzjZx5JOIbQDEeQl8x4iy08rwl/GTIrN4kNrnWDZ8yUKUFX?=
 =?us-ascii?Q?R0QgGHBfaWrH8eQohq6nS9e9OHNuU+C2WOMrJxo/uQU0yFuzJZr4tZ9pIDwb?=
 =?us-ascii?Q?xRPlVhsAeFMkJqDWNZw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:26.9878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2573e44-4365-4f96-1a55-08de0a65c07c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257

Add function to reset SRSO mitigations back to their boot-time defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9a9d5309aa56..112553058ccc 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3312,6 +3312,21 @@ static void __init srso_apply_mitigation(void)
 	}
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void srso_reset_mitigation(void)
+{
+	setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
+	setup_clear_cpu_cap(X86_FEATURE_UNRET);
+	setup_clear_cpu_cap(X86_FEATURE_SRSO_ALIAS);
+	setup_clear_cpu_cap(X86_FEATURE_SRSO);
+	setup_clear_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+	setup_clear_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+	x86_pred_cmd = PRED_CMD_IBPB;
+	x86_return_thunk = __x86_return_thunk;
+	srso_mitigation = SRSO_MITIGATION_AUTO;
+}
+#endif
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"VMSCAPE: " fmt
 
@@ -3925,5 +3940,6 @@ void arch_cpu_reset_mitigations(void)
 	mds_reset_mitigation();
 	mmio_reset_mitigation();
 	srbds_reset_mitigation();
+	srso_reset_mitigation();
 }
 #endif
-- 
2.34.1


