Return-Path: <linux-kernel+bounces-850728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C396BD39E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496BE188E8F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D1308F35;
	Mon, 13 Oct 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uVmRw8um"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15EE30BF66
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366142; cv=fail; b=t5zF0YNxQUyXrrWm5fRof1NXu0rf0riEuG2/6CY48ZuDAyv9eselEQN8wN1hh42DgHFeRf0PmRGQO1PJnsC7Re6x0b+7BHF6zKZxRlumnaOS1aJvcfBl6cSN2Uj6uKexaTixrbzrfQpumsjpTNdmvGBKOa+z7kms/VDw0AYYiOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366142; c=relaxed/simple;
	bh=kXhRWoHhi+Ml4NJqzBAW9m6nS1ztKcG60aqoyTbfsYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QW4qfFbEgXJPCaPMPRlwcPpmiYvJ0tNe2wD1pNo+sWXqMQjHfqFbjEQANxbG3ud6W7dnX+j9ptg96oKAM9zMpHkymigIctdXXudIoKgI7oMjBKYioA7X5NJuCib3XNNWAl3fokzOoT/9yuWsdvQGd1qpZEXcdz13kWxfqWhIIDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uVmRw8um; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEpf3yH1oAtnmNCyrq3r47DkOi8tlZ0WxyYkCnEiX/phS152/fxDyYS/KA3PEwyJhIXJqxnfME627CzwCUZsTGN2M4ZSg7IPTW9UDZqmZfhwxgrQI0/xkgBxVL/8cyw6t8T/KF9uVpbr/czpa1EKJ7hWNbhy2YgmCdeLrjJVsl7Pl3ng42lH/a8SkYqtFN9ywosSDTRQwEssYxjZQ6DonoqCIFocc3G2pyy8YgUzXwREzHX+0EACqJHMtJCs6YmCgIVUHFYSFG1bLcI5np3o3OMKAH5ZZhL83d0mOtkb0PQyAKxtbCqB8Ref9PkAGrUvW9pVXeLF299NX3qJLziB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCtFn3g6CuvIaGnUWTpBnENWlzTX3SN9gogSQ0oUgEU=;
 b=fVqld16+kE18yJ7A2gViDcF7hNH6ZwSCH/ZuABzxZZQDwyb2YozcoEG1OkTU4SahzXg72f+Onvb4KxPk2dsPb7Han/TStBzKXcfuT5Ht1XuizeaVfyxgbgQOZp7O7YxNWkXwp2/AAAKicICa0qamADhmI1oFw0wn0wsdi9EkX+hJnx+sj7x3AKmEYCUfsjsWnNq8BJYPyoT3HZOlkB3uZLaHMerSBgA41GbyRsu/dXM/sDP8+88dBX/Xu7UZNZ80+9UjHcXgqf++7xQ6mTNzTnYr2o0d3ZQFOMQgmERw5aruGNQce9KiViSXEIWKKp7KbjFESt9gsai7ywRiZW20Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCtFn3g6CuvIaGnUWTpBnENWlzTX3SN9gogSQ0oUgEU=;
 b=uVmRw8um3w4GOP0iCpw3mUZ9nbVapLUuSg5LDlOlpFkjWI1fg+WYvpTTafX20Gjo9eOg83mCRzE6GBTPMG9CO8Crw6hfNVkcOeqN18U7jV536xrKOS5M5Wre8mGWOOgEteMZP4LsqJ6jrVrRo67qnZJoVsFg303WkZLecW0mY+Y=
Received: from PH8PR02CA0047.namprd02.prod.outlook.com (2603:10b6:510:2da::8)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:25 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::6a) by PH8PR02CA0047.outlook.office365.com
 (2603:10b6:510:2da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:25 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:23 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 10/56] x86/bugs: Reset MDS mitigations
Date: Mon, 13 Oct 2025 09:33:58 -0500
Message-ID: <20251013143444.3999-11-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: a61601f5-4cf3-49f5-0c63-08de0a65bf76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iqfv9r2fg1cYTqsaROMqkRneMAIRN8uDhpUClayiHEHSYAB59pAYutN5V8DY?=
 =?us-ascii?Q?W+rXILGzApU8udMsAFdX6gGXVz1LR1UIUtzVbhfLa/DgYbiuXNW0krkGeY/f?=
 =?us-ascii?Q?t5bT+6zv3cP36VNiDBnUXHZBptys1h2VcSNXpfyjuPCzgRXEC67IYA71O6qf?=
 =?us-ascii?Q?gYWPzSlKY7Ym51zTwwSm6uK3y9nbX6mNaCQ8kZ2j3XSM4tUUna/b4RsavIRl?=
 =?us-ascii?Q?fwg1dgDQaURllKFebMLBmRiTLADA6GaJIxWdl3LBHluzU+O6weY3cOoFT4VA?=
 =?us-ascii?Q?yWShcxuhpJWGRAc014l+fxMwoA9sy9vC9C15MRPg9N5+bxykQuQuqOWHF48P?=
 =?us-ascii?Q?orAJkylXuQQsZqkiPQSEt8X70fr9AQVbdx93Z23cFkFWbpbgqXmI0Ua/cjvE?=
 =?us-ascii?Q?6Seo3FEd2EDKhdQY/PbPl5A068bskjecop8fSNQ3oEZG5U/kxxl1iiJTr3Oo?=
 =?us-ascii?Q?64opzKkv071YGBvdd35XFUf2DFcESoX/aDXPHpnqAgU/pTdrmZTlCONI3sHs?=
 =?us-ascii?Q?kQ7CbV6fLzlhcbQxjYQBgmJgXr5+/gDixC9053uXzWBfpFDgowQKO3rpM+64?=
 =?us-ascii?Q?QF//hHv4jXaRkH6kjthWUHmPY/nw5dAgzcdC2T1vdiuzB3zbWi2AH5PivjXX?=
 =?us-ascii?Q?vOxEXJMMw2W0YZ16OTU/RFcGrXkMv21jl6cfwA0oVRYIzB7ekCpFLhbE91eq?=
 =?us-ascii?Q?WQGEryKn5MjQ3faJzmd0MnHoTZ8nX7+t4SyKIoWTUumZljmxVLn/5JT5yZDy?=
 =?us-ascii?Q?udFEJ9vvZoae6PbBc1irhH61yqR7nkbfHXKPIgyTTvysescx7toGydHXQmgT?=
 =?us-ascii?Q?Wz6Rr2c61RGtMW1rQ3GN2gNY6XFj4kyp/5ocKFNT0EBvsFlUdgcAooQTToCk?=
 =?us-ascii?Q?bVHK0prrRrDO7y3MTOJNAr8Y/gJqf99tOEIN1PvNEVlE+mN/809E8d/uEDHn?=
 =?us-ascii?Q?lyiAUmNGCinomrcQQGisBiw0Cz+TI/orefe31f9SZOLYvpMuEokiGJcEvkt0?=
 =?us-ascii?Q?IGvXfcBPVR3qUPsBHRuIUFMq83Bz97TKMNpQc/NQaF9rpdc+wwWaI5QrXVdf?=
 =?us-ascii?Q?yD+P6Dm7l5R+OO7y6fN9MbX6FrlJaYa3MygsMbRPfZTAe/+JGaErK+DzflPw?=
 =?us-ascii?Q?mmQXIWdlPAf2sqirkZRvxnGEpOGGg3IUXaHywiq1skkfcdQIUFzYvgxdHfNY?=
 =?us-ascii?Q?m65JpbWO1HeZVLyIUmQUgANYJyHPY6O9Z4RSPqfvHDp36URLjKQ+T/3oL5iF?=
 =?us-ascii?Q?jdGeKYd6HHabyLvXj26rxhD3F5FzAEIB3wMgBCsDkltAj+rH1sFfQe87Biwq?=
 =?us-ascii?Q?tLEpeFzak3/KOML5AINQur7XmvdtmtvrOyVgQh8asZrooMYd4gebcgmYcrvR?=
 =?us-ascii?Q?eu4m4ZT4ERP93KIjk898nBvqZBgf5HYcpRA1F6I6orKVkEscIo37yUi30cfC?=
 =?us-ascii?Q?8cD04nPkYXfBrz+FuSCFAAufmvb2Avm4pJDsV2zFslpyuodTqjzdjjYv8J7M?=
 =?us-ascii?Q?p6wBEKefE5Z5CyCTXzYqviWcZl86V8Qq8WqF7ffjeduXTmb+vrLEZcsFDTbX?=
 =?us-ascii?Q?6eyhQLsLjvE8mW+0BhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:25.2691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61601f5-4cf3-49f5-0c63-08de0a65bf76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588

Add function to reset MDS mitigations back to their boot-time defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b61bbeaf82b1..5668a8b8821b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -554,6 +554,16 @@ static void __init mds_apply_mitigation(void)
 	}
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void mds_reset_mitigation(void)
+{
+	setup_clear_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	static_branch_disable(&cpu_buf_idle_clear);
+	mds_mitigation = IS_ENABLED(CONFIG_MITIGATION_MDS) ?
+		MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
+}
+#endif
+
 static int __init mds_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
@@ -3891,5 +3901,6 @@ void arch_cpu_reset_mitigations(void)
 	spectre_v2_user_reset_mitigation();
 	ssb_reset_mitigation();
 	l1tf_reset_mitigation();
+	mds_reset_mitigation();
 }
 #endif
-- 
2.34.1


