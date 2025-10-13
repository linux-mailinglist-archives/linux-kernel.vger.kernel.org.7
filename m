Return-Path: <linux-kernel+bounces-850722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA453BD39C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427641886EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E85830BB80;
	Mon, 13 Oct 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BP5v0b1C"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78230AD1C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366136; cv=fail; b=g9ZzOgbM1SBC9h9tNuX2qGnd/4dzzTRad8gzCg23SMaPC1Io0HfSLZ1DuDfGnWU4ZbLe1oLJnr6Rd5cenCfbYtQ6EcLJJZPg49kCCFfy+Vn/+vO4tDqaHpLx5tHvub/lL06H9weqWKokA2t2DMtuC8an53JmiGA8MpYkM4x13QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366136; c=relaxed/simple;
	bh=r9BRm1BMSzt84KrS+tQaphurYdhKvRHX/Gv/NLo8kzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPiiS3YdPsSb2tVPjI5Z2KIftYI2Un6aoRZ/ur7trkmOb3II0oHGDtUPTwydMkaEWd0bkHa5dPfl/KsmLMHb03EXUas1IN/InpP0U4jtPsgNlopUFxm34wGiaYtIkV4qUFpsnkpCSE9+0MxY7jtNSaaHSNz30byM5/wCbJE7JDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BP5v0b1C; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hy5+9nfnLhdVAJJ4jLK7kcuPq+0+NTrUyEfjliLX69cNV+Yq6v7EG08sCCyzHatuxZdaZTMh/EQWGZ26HaYjdWLYYvNAuW8Wl4O2IhH4xb/bPVkXNmQa6nuoVOAsf8RaJALQ5g1etPR4aU6/xu5JvN+qRghPbw2iEYyMkn7VYVgKZnNM5ZxMDYXsADwUqCyGAUH9/ejNV3pjQU0DlPY9CWl+w2mvCV+4Xc3y/c1cfgQGqBbL5D7IuPjbWUWKB4jBt0jM09FH+DAwNk+ydYax50WrYpSld357Gx/bVqqHYRr0sXjOz7Mhkw/D+C6lkS2NaR5D/eBZ2FLJLiGXycUX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCIUoNgS7nxFiBFQGefRAauM23ME93hGuqdFJz8ilKs=;
 b=jjA9UqAXwr2dGCDs9UaYUpBDy3JJTm19gv6cC2DGpym9hq0XA/3MQse6tepcSnbQn6pnX59FrxTP+gEV0v/DCpxkJtiwCNYmubLLh7MAs8zxBX8jNpwAHX+5vh2XjUcSpdUDVRkivmEJ/pjRviEln4j4qhLgQ/Ws5M8jN5CvcQ/PyI/WEgKNCE7RVtIueX5Byb2HzoCSkDOKGajaU9oZk3ej5sdeeA5N9XVJT90E9LrbSWivBNtvHP+dlRXhLk8VRH6gFLMsIfegwMa25Qd7JBNXwjH13Mz+aQ9WxQ4lPQCt6XklL/1/LU6Hj3mggjTUgAoe0QwlaqMRAEnFER0sHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCIUoNgS7nxFiBFQGefRAauM23ME93hGuqdFJz8ilKs=;
 b=BP5v0b1Ct41fTTIhCXRfpw61FgHTuWn4Ez6J3qI+NNXXyfdV/987n0CDnjZMUsOgwWpugNnFGPbqJWZelmuYNSIIfONBSjjROF5MkbTU4hzkjdppikRpeKtg3hiE1OblBrPEjqrANpKZS3hGWztNJBMOt95g920BdpCQ7txT+Ns=
Received: from BYAPR08CA0063.namprd08.prod.outlook.com (2603:10b6:a03:117::40)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 14:35:31 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::82) by BYAPR08CA0063.outlook.office365.com
 (2603:10b6:a03:117::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
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
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:30 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:29 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 18/56] x86/bugs: Reset VMSCAPE mitigations
Date: Mon, 13 Oct 2025 09:34:06 -0500
Message-ID: <20251013143444.3999-19-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe33d88-e1d5-464b-534e-08de0a65c2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CtJGmmnMEe+Pg5ZFzkVCvaZoxVw6StTOQKlErV/5nr/FMo21rh/R3ZpniZO7?=
 =?us-ascii?Q?6DPuExinf9zgNjAnfaJRyg9g+C/aLpmSosyWiSL/G2XBAuIS8+lCNSmMZQ9S?=
 =?us-ascii?Q?JQZ5pWDA7ZmWdMNhXvtLyLFOSbeF69WgaMpleZxPmnfvVXvCENbqU52lyBPz?=
 =?us-ascii?Q?4lkZ6umF/+pEKvAeSZE5TFpo3KvbnVRous21QjRPTjf9WMsi2O/BqBfr2cwn?=
 =?us-ascii?Q?fpNkT4iRMosGO9hh+aBt1vCOAkFFdkTiqifxs7lMlTphw//s8eZvISJ5oNlr?=
 =?us-ascii?Q?4eLNp4dU4DMRJCd5IQ8b3pp3xXD+O9YjmAUt7JRJkawlHPDr7aQsoKB1bYMl?=
 =?us-ascii?Q?zZPojTJ+JcTlLtGFzyRXvY1R33uvJ+f7CLiaDKKOoyk3ytfs1vroMHIdVPW1?=
 =?us-ascii?Q?RxSVhXl1wdSsTcR4Dj/ehIvqUIbCBhne0DUJgX8z5ZRxFamq8v178T/tVwm7?=
 =?us-ascii?Q?tJw8qiZNveqcQ7R3rd0+1CNizzlWX3EE46wR/tpG1LxfTpmJlXrSwOfRQMDu?=
 =?us-ascii?Q?5pVR9woESkG+d5LZl2AOQ/S9sR7j23sS6FYN5+7AbHZQ7lakX9IWBRZwi5+D?=
 =?us-ascii?Q?IvyIgEhCEDkIpIwHOfQAcs2ktCkY6gTucuGUCFqsYUNuuFwUsyC811AWAzxt?=
 =?us-ascii?Q?I+uv9eAEPMr8OjKtCP+rwjqnd5aHs4aJDoH4e+JaEPG87z8Mgn8+EEDCGu83?=
 =?us-ascii?Q?/mU2q/0lgULxo7B7cox/Iq3vRqgYOo19HAv/KavxfJ+dJKgZewL9t9LTVBC1?=
 =?us-ascii?Q?JYEdoG7aP5tZhJ2xwhWti6t0sMU5ln6R2tRHCRJTHW+NuLMFFNQbM6YLNiom?=
 =?us-ascii?Q?BrlK6RYdVOrztX2HJ+MYF4Y9JrnXwmGo3teWnGzMo0q2lQxkSYfab/lt23FG?=
 =?us-ascii?Q?p82uBJtoE6PiCFJHYqnAcDBZDHeSAmJE6/Ku9GlBfMzbqzeS8epMZY1X5NGC?=
 =?us-ascii?Q?MIRjSBHLN65WWm1Dj1R6ISYvK8fwv+oypD3yr+w6RDwpxdheHBPSLL8B7Gaw?=
 =?us-ascii?Q?0QK2QfWIiWXRc5xatDZ7dLbE+g96zqfCYF76pQS/QBaOV3/ablDU34cCiBsg?=
 =?us-ascii?Q?SZJw9jcEyB7dfc6BJmtoZDqiA7UFGE2fdPkar5wvmzwAQnrw9GuKE3ODnDj5?=
 =?us-ascii?Q?7t1Cox7NPBiHgQsiS4NyKo8hKuXKYslmvC03tCbNv1JudELcKTQwQgRpTUUk?=
 =?us-ascii?Q?GCzZO+wLpBclxPigaDZ2NdoVycFDqjKk5cQ6QINZsMF/GuvbKUd9nx9h5ggN?=
 =?us-ascii?Q?1sUwIHKsmQOGnOIiomRYDooIlMoe2pbhnIbkecQwfjvlDIT1LHM4SkdlZnoS?=
 =?us-ascii?Q?B0rVj613Qht9mRrAsSHcHocifKpAyijdjhKubKqgAnsEaSlz5SU9ZXmaPhOQ?=
 =?us-ascii?Q?F/uskBydn5t5YCC6UMdoejIO9f720uO01PsSHIRjKJIiLH5yxPtmJd8jVpy5?=
 =?us-ascii?Q?504P1ZCVR2wYEOD9TUxmWBJh2JWZIKsoG9yNgrk/R0RKihVnjAQ3PufBGWfI?=
 =?us-ascii?Q?hTeGhW0zR+HFUfa7OjAoWoA0C8lXqqHVbc9iyTd5OYy2IC/0SNbO3b/Q69/S?=
 =?us-ascii?Q?9DQeT32zmkeSalsFVFU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:30.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe33d88-e1d5-464b-534e-08de0a65c2cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659

Add function to reset VMSCAPE mitigations back to their boot-time defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6a3e079a85fc..fcb1337026f1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3446,6 +3446,15 @@ static void __init vmscape_apply_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_IBPB_EXIT_TO_USER);
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void vmscape_reset_mitigation(void)
+{
+	setup_clear_cpu_cap(X86_FEATURE_IBPB_EXIT_TO_USER);
+	vmscape_mitigation = IS_ENABLED(CONFIG_MITIGATION_VMSCAPE) ?
+		VMSCAPE_MITIGATION_AUTO : VMSCAPE_MITIGATION_NONE;
+}
+#endif
+
 #undef pr_fmt
 #define pr_fmt(fmt) fmt
 
@@ -3990,5 +3999,6 @@ void arch_cpu_reset_mitigations(void)
 	bhi_reset_mitigation();
 	its_reset_mitigation();
 	tsa_reset_mitigation();
+	vmscape_reset_mitigation();
 }
 #endif
-- 
2.34.1


