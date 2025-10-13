Return-Path: <linux-kernel+bounces-850721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D84FBD3A20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBD844F6EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7243230B509;
	Mon, 13 Oct 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Mxr75SF"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B61308F32
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366133; cv=fail; b=b6SF/kaXhfT0itpOdqOclwUBsfHTWwSyoMIgnnxx7NJuFYzpaP67cnusafl3FSSvKT2GuYNMaGASx8y5UwlNnL5TeeqLFm8ZZQ3ORXB20i+qBw8leW3SXCXP/W5CrjJYx7WzVP0hJNGOJs98lzdwNLFB28T6EmNwMSlmM03RHNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366133; c=relaxed/simple;
	bh=dqcEp7KgbuKxPOL1sBiXjgF21UUbpkwhYBFPAyoJ9Ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZjbCV43Ohx72UW5Zu8u7jG1XTvxocsHZfHWhkc3lA3V9kdFv1xgHa2enx5t2tkpWc7Rsoky0fsNqLJaeBt09vVd7iLeU0kxJELX55Jo5eUi/qLLQ48h3HHP3OTPHercvYES/S8oSUtyuopyg5DUJ7zYDB7ykrPGa2rhQxxkwoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Mxr75SF; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQdCKvSm31bvr/a5qOcsbKOw+z3W8ATtmDSOgesa0HixZvP9Znbg14p5ou+rvKvFkWua5pM7WSXLd2D29p443/NzWcyOkS1WizX0VMT8qvRx/hUkvsg84hjudLTh269xUrFI2CWbNNwJSqWFo6z1Ohabw/sUGGrqTWSaNJ9Aj7zvOWkGl2L9yQ7tsawNIAWHpEWCYWerNlyw/WgyzxmFMWs35K+J8TgwexFY7Gy6vVCMZD2whiukSleBCd6Co6Uk1zq7s8jcvyvwpKwALcNS3yMoJD40jfFXZXM+0AOgHj7Qj9FQ1FbYKW7jiaFCOZvNXv8h/iFm+lcUhPwnHPSgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiEgwNKOB5cCl/oujtxDTGARdedDYW5o63kpIyOtbCk=;
 b=JYes1qObonYbJ/0zcanxcN9oa+4/zplLNRJ9q5/RoDHZOFXk1mCNYx5ubAlRmNaBAUkwkxjNqfNoU/9DbWTw3w9BSpkYIzDWV+GM6+oUcHQQ6W++3WggTAyKVR1gjYl9EeiB67AJfKoWXA/B3DNDWqvYwpCJoSqb5XX7x7DhB/guo1ZFaDnkt0vn7srZLvxt61KxK+ARNaQnFsaueOri8yeONaE0NbI59WmU/ur9uAo4i5aJ4Ud9C753GUg8ZL3Ah1TKcxw6m9Tbf9K+ll2IiTdVyvspM8MGzQ3RCy0M76rrkpYxwH6eW1mGtWKPK/lS8XU8bul6LPOc2HWvt2YHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiEgwNKOB5cCl/oujtxDTGARdedDYW5o63kpIyOtbCk=;
 b=2Mxr75SFLC00eGqPveGcaUpv8wUWCkgOY6SsLCmh9ItJjvM+vd79IVEjpSXftBRgLs/dvWFafnKWVSOQ2H052TR7pKJU2gkbNiSS2/Q5sej0tdUUocwhpAdrF4HjYhhu+SZ5viRmh+eI7vLu2gZYIVpF/mnTSBeDYGPZGqTVYsQ=
Received: from BYAPR08CA0065.namprd08.prod.outlook.com (2603:10b6:a03:117::42)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:27 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::6d) by BYAPR08CA0065.outlook.office365.com
 (2603:10b6:a03:117::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:26 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:24 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 11/56] x86/bugs: Reset MMIO mitigations
Date: Mon, 13 Oct 2025 09:33:59 -0500
Message-ID: <20251013143444.3999-12-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 958a02b0-8a8c-46ec-060f-08de0a65c007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7r2Goe+RTF0ZvmWGKQl2aMmnLtDSJWMYl6UJO2Hqm+vvyvDuXDNQ+Fw2vePq?=
 =?us-ascii?Q?PzqYOm8WcM3bJ6NWAyvP+kGpAMvCi8PexbuZ5dDHvHI2AYllES6ApCCeOlbx?=
 =?us-ascii?Q?jRSU9oKsiEzEmFu2r2cXBgeiCm+z/7ANIdUBC8zw/d6ZRJkHEEOTyZgyC95P?=
 =?us-ascii?Q?+NR+tDAvKwrGTH7G/PH6pBjEWZyyiBvG6PO8xd2NVvVAlYoW2wOZd0MGfUDT?=
 =?us-ascii?Q?3mldK9LwP/HSA5TTUrjLi820RXzdc5pC1LVDhNN+LRAUk1qFxoVCUMo3v7qn?=
 =?us-ascii?Q?4E/Unwkg9sgRTqAldure5Ang3jCM2aSkbu2nuFb9F1MR5j5S1iGobUv6px2x?=
 =?us-ascii?Q?BEA2wYn7c3BQElpjqtR9z7l+o8KpUPCgG3sfNIjjoXFDVZfJQ5fVGazDEd26?=
 =?us-ascii?Q?3ILEeLCZgFmYhI3d1PzB9ovpwUScpYkPGGUHZ9Q52KtcSfdNn+OWUcKgsK99?=
 =?us-ascii?Q?ZgKko3F/DpBM2e12dpUOcQT/RIF/Ex4gGK3vMvIxIjqrm/D2BV7Mr0k+kolC?=
 =?us-ascii?Q?Xrj6xz7n1OwTbdhKyKUYVGdJ0sU9D1OY8cgynoApdljfM3KJPuwWpPUcZrZz?=
 =?us-ascii?Q?NhlqofwAnA54R61nHcBwr/D7F/IIt27FGgVTgQN9ydI9P50lv9kh4Ff3TNdl?=
 =?us-ascii?Q?blnkGcS+NXtSQ7tKyuhMW/A6tb5o44y7JXbQT80OhZKt880SVsiSZJDu9szG?=
 =?us-ascii?Q?zAq4qqrQAoSUZ8BlNgYBbj9uvH0Np7QJXPqI7nFwUrnkaoOzriDtYTGsi8jS?=
 =?us-ascii?Q?BaQ5rZiaE2FjoZuO+cV3ssUI85+uy9JTMQSTVWqb/GLTKRY43dax8Vg5OGde?=
 =?us-ascii?Q?3anwCs2WIrmlL+CUD2uS//DI76lFoqgsLIptkwvLjTnZ3PsmZ2mgaEBXEi2D?=
 =?us-ascii?Q?O5p7VPKmgLaDmvSUtGW000p5vtEAFVs1N61aNspPJtHwydUzlzfZCOLGT42Y?=
 =?us-ascii?Q?jANbIph5WX5WYWtM0/FurpWBT4PUdFezBLsSfWTHxZRIeLc4wEaWmthRR5Wb?=
 =?us-ascii?Q?PlVtB0n+d+1affgK4QafgArXdYO2WKElBFNc7DRgDssmZkUqWakaage2jgfw?=
 =?us-ascii?Q?0Y8k6ARAbAEPu7gSmAXQ/4ydrOw53SUs6NFHykwVIZMjXEc0B0lTjWQ2+qMw?=
 =?us-ascii?Q?nNK6obBdaeqa+kRYcqISghs8JPzciI5m0uiPx+6aX+QQu1JNMjDOLNt4tyTm?=
 =?us-ascii?Q?HLrvlNlrf4thW44O8dETOH4dpovkauaGfnX+tvwEF9/IVoWUIDu9L/WGx/8l?=
 =?us-ascii?Q?vOyajYu4RbEAUvu3/G1RJfSUuBeGjLcW+weY790T3Ry69K2ml6GWdik0GZh+?=
 =?us-ascii?Q?VJ6PUVb1YCOXOXDMk9Al+3LXHOMX2Bkm2LnLsR1qOEY1pElcJvkDU5hsCf//?=
 =?us-ascii?Q?zxd8kpku/yrjrpjSWsUL0xzdvEaeXguqmNIoAJBuApg9ch7Fus1tkngv6vyS?=
 =?us-ascii?Q?YzbzIvHpZRm1tSvygWroEWpF7HyJhgGzgMlKazFpnSBYT7GaYKOJXSJrfyl8?=
 =?us-ascii?Q?cB7kRH0QC60Ma6My9uAx6ASbvRaUEOrOonId72brANZlmM7wtkV8lGM6ZPVc?=
 =?us-ascii?Q?vtVhsIPp826o6voRcNY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:26.1444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 958a02b0-8a8c-46ec-060f-08de0a65c007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618

Add function to reset MMIO mitigations back to their boot-time defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5668a8b8821b..9139c8187913 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -787,6 +787,16 @@ static void __init mmio_apply_mitigation(void)
 		cpu_smt_disable(false);
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void mmio_reset_mitigation(void)
+{
+	static_branch_disable(&cpu_buf_vm_clear);
+	static_branch_disable(&cpu_buf_idle_clear);
+	mmio_mitigation = IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ?
+		MMIO_MITIGATION_AUTO : MMIO_MITIGATION_OFF;
+}
+#endif
+
 static int __init mmio_stale_data_parse_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
@@ -3902,5 +3912,6 @@ void arch_cpu_reset_mitigations(void)
 	ssb_reset_mitigation();
 	l1tf_reset_mitigation();
 	mds_reset_mitigation();
+	mmio_reset_mitigation();
 }
 #endif
-- 
2.34.1


