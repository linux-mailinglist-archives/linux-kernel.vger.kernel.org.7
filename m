Return-Path: <linux-kernel+bounces-850723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3F0BD3A26
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FED3C8043
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FDA30BB8A;
	Mon, 13 Oct 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="stZ+7qGU"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385530B510
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366136; cv=fail; b=oQnhGaNonYujtDLKAeBq7yUs68kESEO2FQmqUWdDGY5LA1QgeJYsH6k4vLL3WPrBu/qadQcapZy/vY8mCUNmfug5xev4puu9WUudo4PQZQE9usGv4K7EAuaAagb5XYjDseBxhLONUq+/Eme3W+rO/hGpWvpmOIv0mZhX8gSVvwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366136; c=relaxed/simple;
	bh=sEtvcU0DRCOSwuleoGkjushw2H01oufeGvUZRSgilw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJ8+9rstECTYhPWnKfBmY++EXAMAEuc7jV7hmQBrXCmyGzT9rdYNSCn7nB04YNSYsy9z07jLau12XPMFGSFstRRXcosdItVcx608kXH69yvZok6H6KoIP8oTrw770Lv0xm2t2QOK/D4f681H5J70DyCK9gbc/Al4wLJqcF/fjE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=stZ+7qGU; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAEm4/bllog+vM4INsM/Aebg+PKb8HRsGQp5aez7exXxeK4dU98ZEsWtsdM99sOmSoiXrux1bEg/UApZSNUIPZfbGJ//Cg8apVRJcH4pcMbqbMWaedZVGJF6QWmrIgwtlmB5aclZzueJCA2iBPgUKBOsxiRKdfjh4cC+waGFcAVl23WH5eEvWOz/MS/4QqOF4czOAd7MDZEgGeyx1HtnjA3cghL7pueu2yUqWn73OcrcHr1fsMutFmZn3knRk2CtnlwjBsx1+WWYZObXL2YWCBf1RL0HujRCAvkcJldaOLxeUsNnSF5ADfjLXLC7kQVOxQqyATLLCj60KYLtr9HcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/Cfn6toZoXSamzuDTopfmh8rqEUbQ+HmNa4nHNLHmo=;
 b=iaIEOH+m6IFN2+1ii+XiJrLjYiBZwhT2/KCXOsH97UzP9jShEX967z94Chxvl4rWS8krJwxlH13IOYiXBi4QxBnRBrLOcAu34byzZO+yko9rX1IE+MeG+ROTBBH+uhU+dg9BF31lu9aJKE+b0c6nJVc4qlOV4EzGpSacnYo7YXfPDRQOst2Zcs4czHYKlA6KqIesQGCBvY4VAtF8CBdVOL6ATrEKg3sNUCxyfqD2XgW/7+l0qjMjTPsb3b04k/XiljV+okkv0Id5IgmMlrTnJUmiOgKLGrY1G9cDJBa/urLXpnWXoFCZHEnCGd2tgAGV8toTIviqtOE7WE/nKlEYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/Cfn6toZoXSamzuDTopfmh8rqEUbQ+HmNa4nHNLHmo=;
 b=stZ+7qGUBOAG7hELBe8WazuS1oqEDb77BJQWadvzWT4ANO4m/WyLPs0mcHbeiQ+uGSZL7Vx+x8Wy+cPePwcnVG6iVSUDIK32J9CTv8+2Sxx2bqySPmi+K8JafJvsSQ8ytZuqsdwBMnhSsDq25wcFQ1RAPB3wamvRe/ArTmDHjT0=
Received: from PH8PR02CA0051.namprd02.prod.outlook.com (2603:10b6:510:2da::21)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:35:31 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::d6) by PH8PR02CA0051.outlook.office365.com
 (2603:10b6:510:2da::21) with Microsoft SMTP Server (version=TLS1_3,
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
Subject: [RFC PATCH 17/56] x86/bugs: Reset TSA mitigations
Date: Mon, 13 Oct 2025 09:34:05 -0500
Message-ID: <20251013143444.3999-18-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: f38cba48-8fd7-4729-95d6-08de0a65c2ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7BaIywARw9WZSPsKqrpB4PKGH0No8dgZGy7hUgS+Cm5vTdWA6HdLPDJ7saFF?=
 =?us-ascii?Q?tkhpfhyY+DMugSSFmu7WUqPFiVT9BT6G0nltnOWZP3vQypzLiSJxiVensIx7?=
 =?us-ascii?Q?PMrFq/Sza948sWTCPfsixQedavdO7fyxJdME0kEsPTV+jq9+gPl4Y/e5fy6O?=
 =?us-ascii?Q?InZrUcOS1kpWlVKg7EOIHqNZbjyXxSOCuz9mDg/pmTYZ2JOo/1Fb/c/6Ovzv?=
 =?us-ascii?Q?uMFlgdhuKNyVn+fKPOnrAPyEw8SqnKnqdc9UufPz7gkK8EgW05ljkoDGrteZ?=
 =?us-ascii?Q?khedh6qkaQqVxOdO6gPHC0cOIqgzzJwa8n+sSvMokA7q3eBPW4WO3Pdsb1f+?=
 =?us-ascii?Q?+Nzrr8n/UBRygi+3SJwZgQHGpveYLAgJMqespbDB20pzKCDjxIR4ByrnSk76?=
 =?us-ascii?Q?fjKWz3BEYeLSNcuT32MTh94sfehe4UHbf6oVumGKt6d3ClWhXqHx7yk/TjaJ?=
 =?us-ascii?Q?AvfIc5CYvw/KoXCEEOIhnwt5jcIjNoyNOyFeJ+ipUIejqyieL47DJgT7aQyN?=
 =?us-ascii?Q?MvNgCA4rkkNf2Kn51HoTa0svNKi1pbhR4z8xK3GaBRFa4RuWvY3jLfdVLZHs?=
 =?us-ascii?Q?8nb/IkCvrZdMnUPMDfhwe3UAvQG511u2q9UEPM1ieIzmiFL6LRi1YxOST+NC?=
 =?us-ascii?Q?7sgV03NDsdnKoBh+m5NvEnFYxl25faqEKdGtABE7y4sYkQozjrvS6JjvwTNQ?=
 =?us-ascii?Q?lExQORIHAx5GWbkxpGHOr0+jQ00p5CND1drjQsbGIzQLrm7fncj4DQJHgxoD?=
 =?us-ascii?Q?+NbxQZ0CFtyuUmu4bDVmkqGR6RhWXhkz/dHCF5Ko3cfu2FxrG92Srk15Cock?=
 =?us-ascii?Q?9x6svehpqH/Bn7TLRw0znNsbZjQ/sK0LsQIrMonFt3OuJH+CjQrkwSBAG2+W?=
 =?us-ascii?Q?/UyBnh0ZSDPyoqYCzdhC/Gn75CyYlPPctvK+LIpwOGH6QttM3ybR/zRGSCWv?=
 =?us-ascii?Q?Na2xxGdiYuP5CZKnb4xWd1zgeiP4ekPGe4xrxfOdZgpcALQeIjHJBFzJtc+S?=
 =?us-ascii?Q?4IrDW+7S+p+b6JoBY46/7LomeKKI4PHMRzjb4H47vEWOWWencOnGKA9XcvyF?=
 =?us-ascii?Q?XVItGJHw103KYcFdnSJKfCf4SBXUfY11kuU5ei7686A/Y0t2SLfGe6NgeBMx?=
 =?us-ascii?Q?nRmr9Sedds8ynaxJyi6MKj6nu9Jd9+p3KJvLYr3xeRaqwIbod+zBvgLmmlC0?=
 =?us-ascii?Q?fNx0JR66gLUi4+XxNOyh2CixYMvYYB8879Vo/vl9TZHAi/4K/dxgwKnmPj2z?=
 =?us-ascii?Q?GBPBRSOcAtzUZmp67b3Wwc0azsl0fw1W7+/XiR8tM/l41P20hg9xHq87XfAp?=
 =?us-ascii?Q?16XHqHZCA3D2gRkdnle4WH67kKlftrRNo8z92Uo+LYdywFNcxdeC/FzArw71?=
 =?us-ascii?Q?MaNG51VPf0+w3LAYgL8ywKUHb2jIQC3iajz5bJY+a+vJY6CtcxIvQK/ul/Az?=
 =?us-ascii?Q?ODbDmhZjQBNBp5qXo7qZ8kWvDAeWfXn5seaXay/soTZBLU3Eexl/uqOgEwLa?=
 =?us-ascii?Q?3K06fYyuUrTuMKZWaCWRlaqk3Lrn8gRgptjvWXXGXVTsugnQP8qrNN4LzxSo?=
 =?us-ascii?Q?VNZV9aUBaPX2RJ1VlhM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:30.6718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f38cba48-8fd7-4729-95d6-08de0a65c2ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285

Add function to reset TSA mitigations back to their boot-time defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bf5de097e1a9..6a3e079a85fc 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1858,6 +1858,17 @@ static void __init tsa_apply_mitigation(void)
 	}
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void tsa_reset_mitigation(void)
+{
+	setup_clear_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	setup_clear_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF_VM);
+	static_branch_disable(&cpu_buf_idle_clear);
+	tsa_mitigation =
+		IS_ENABLED(CONFIG_MITIGATION_TSA) ? TSA_MITIGATION_AUTO : TSA_MITIGATION_NONE;
+}
+#endif
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
@@ -3978,5 +3989,6 @@ void arch_cpu_reset_mitigations(void)
 	gds_reset_mitigation();
 	bhi_reset_mitigation();
 	its_reset_mitigation();
+	tsa_reset_mitigation();
 }
 #endif
-- 
2.34.1


