Return-Path: <linux-kernel+bounces-817094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD27BB57DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028303AD6CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2A31D396;
	Mon, 15 Sep 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CCNFEPXB"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921531B811
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944054; cv=fail; b=mVaCM7sfPJq/yekfFx+hI1w+MqiDBTz5kjojn1Py86NM9XuromLJcLrT7tx4v7YNDRyH0tXwo1zak2gW9cVJIEWE9DkxA2bCFqfdVcSJdotY0FGlKDZDvBSLqreGKHVG3F2nDuGnHquZk2nOiO6vwuhZTcfvra3rayJsfY5Pw+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944054; c=relaxed/simple;
	bh=jtpM+Wu9eCHkiLIXFitpmrIVk9IAP8MlkWGYpKgNj+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJxfnttcDKu2P1WcnCSrG+SxvjGqt4FSygcA7/BxFiFGpB/OXTMsdPPVU70BGZYFJT9rVj3k+jYu83/kdCI3V2dKXtQdqvGlVYwHxlTYHfo7v/nB6FWjo8B3hcZLtbDDxrbP3/PqzpRnf8i0KHdkBhQEZq/aViUKafXxKy72+E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CCNFEPXB; arc=fail smtp.client-ip=52.101.193.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTGBfTf7FMd6PTBcKhWozdRTlQhKJJy8BqxoDRxfRkvK/qwkEZS+Mm2WYopObROU0fp7TOjYd0P4Bn0Xd8q+I0ZLlgtFJbDkiJ2yf5KQdQHm+5bxXAl+qbdw5uQXkKJPwmmrUCLe5MIl8KYVuxmyz8meeiZO+bV8CI6+Q5EpTYaL45inpESL8Ug2TTS5We9iBSl7sLZP9VGHkM9GeOC4RDb9IwL4UL6WXXTVL00eHLKqK98g+uTyrBf/pQOp+wrReUn8NLqW9nOyAzDjSyHyWpuTl6mCZZzEB5ZuFAKdV0N9P1U50DCCrGuIfyTTxBJZZq11KXUAQvKrWbO3lRdcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqwZCGEnaszxys0nMtUvCADxd4KxU4JMP21R5EAzslU=;
 b=Aacf+axGY54jpUJdBrG3qflOY8q4D3JeE6OZNAZ29fshlZoNxSJQK/rgMCgurijViu+CSWi+G5WVB7zcgBjlsG3WahnD6zBIQMUEtNReZ1nNUjoneRjMSss6mccYu5ldpNMSJgf5qem7ekU6wgpeN05eDTMUNP2pATn02AyT91/yFBr1Hz8IMr5/O/Sb+KEs2RgwPwBrdesKGG4VUVqVxeeJBWr+xVWGb7sxXguMrmiKIEf/9lyO9rxQloyOnNQT25A+oc8KFMhS00c59BsDZ4jUMvR21lqUt3roBoq0pEzALmq9j7Vn+itXaDqPTZDW6NY4NY/SEK6YE4OYZAxzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqwZCGEnaszxys0nMtUvCADxd4KxU4JMP21R5EAzslU=;
 b=CCNFEPXBDkvbcIb2CvckYnICn74f3tz/65gIXSAXksBhKiDuXRaDKz6ZfRDu/o6RtiPxwxjcD3atZAlg97XxoEAGhTBSdAu4d3M4akDv0nrtSA6kXLnHkd8Aubj5WsHu0sVf35IjTjFzRyY1G1WwSMzl84fqIl+EC0avJwUvJvk=
Received: from SJ0PR03CA0116.namprd03.prod.outlook.com (2603:10b6:a03:333::31)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 13:47:27 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::59) by SJ0PR03CA0116.outlook.office365.com
 (2603:10b6:a03:333::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 13:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:47:27 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:47:25 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/7] x86/bugs: Fix reporting of LFENCE retpoline
Date: Mon, 15 Sep 2025 08:47:05 -0500
Message-ID: <20250915134706.3201818-7-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915134706.3201818-1-david.kaplan@amd.com>
References: <20250915134706.3201818-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c8d493-ec0f-457f-d0a1-08ddf45e68ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?041r3ciCl4clN74wwlOUALbnQenp51f9wXX14kAvVnMdiP3OLUQodvMCHI6B?=
 =?us-ascii?Q?Tx6YQ58fmyqiZ7wUvcVCx7hVYycQBSPktpUnVg6OtDNv6jgsloypvm2h1Niz?=
 =?us-ascii?Q?wZIl5EKdC11L17enSuTMSE+h+IGUgDN7fDSxpxbOCrkO/NRq3PUd0mPvJ91+?=
 =?us-ascii?Q?2zovRCTScgeVNAySfN8SAQ2P8ZB8shdk6aMtbe3X6RwDdw5uKk6UzQVQkpyT?=
 =?us-ascii?Q?rLhLSilmELlQFqWh84Z4gv1Wc1AM1hG4/gIb2SAJyxU6eQlXXQLwLyf3dxBo?=
 =?us-ascii?Q?PM5pAWnEHSS+Pi5IYFRIc9qoeVHULBWjcJjRqNkoSdyStkukKjdE+axiFhQ5?=
 =?us-ascii?Q?FXYdzXIQdhRXpHMtKkODww2hjdcbFZDKEnG9tpiJ65yrnZY9BV+cDy7VlEkj?=
 =?us-ascii?Q?KNENOFagG5ZU4rSh1Dwn/LfuyAoWK19GEc5cMjemy3yvJUUwb9oMdxVjavbo?=
 =?us-ascii?Q?CGv8kKw1a7RoYOi/sK3Shoi0cScVYzIEtDpRq72U+C0/6m0BNVEkSwlDYDNc?=
 =?us-ascii?Q?J17tSUnRswI9KRKIObA7gSRxXr5BPA4vwbk6jpq6wsVS/F0QKnp7YvqF2Q9D?=
 =?us-ascii?Q?5WkFgvzLgpybbT7VTrnEwVhPhWc0XdjMFcMcpNfPvkgWiRiRj2rOBP3H4/5C?=
 =?us-ascii?Q?HYkZDKLuUdfZOlzLf+f7+vI5OJ3rGuZrKuiWFhaHF01ZNf0YbulDVcGruPGc?=
 =?us-ascii?Q?yKV0rCydr8zezEUUsgmu/mBIXbXZmQ+Mn1GRhCgsAp8rCJWOXzgcwjjQ+9R3?=
 =?us-ascii?Q?94O9wZ1TuaDfZHD3rt5XPuaoHIS1i9Y3cuYtfb1sWwGdO1Ksy7jMkx7ucLBN?=
 =?us-ascii?Q?PsT3xMlTHm/bu1ny0tAb8SjiMybVFCI7fZF286DpQzeznp7xIYU5edvzmo/V?=
 =?us-ascii?Q?QzAowBnlnYHSPm4cRwoBML8QCSEaZaSqwgX/GwAko+QxFOC4De5XCihvlEKL?=
 =?us-ascii?Q?XreMHN5dV6kQAuOo4PkwVg7IDgNgIHQq0NGZT4OC2fv5rAByHOjbqWW90DK3?=
 =?us-ascii?Q?zX5E7NLDeuXzgl8+Z9SiOKG3pxfAID1O3ZHWRnthc0HEJk9B+GYlbiBEN/b3?=
 =?us-ascii?Q?dUur3rrjsAeLyDNTEROzhZkP6/EDRmB3z8AnCamQq/FtAm9B7JiMTHk06RiM?=
 =?us-ascii?Q?fTZnFiEfpojjfl0TyQlNPoEg1phjw/ly7ZJ5lfGDllvcHXmczQcXJxXkhKwF?=
 =?us-ascii?Q?HIMTX31xXBFmwGueeMYPLk2E21ZhuY8E9k8CdYL3eRvcbdkroxFX0EZYhKBl?=
 =?us-ascii?Q?Mvj+topA3VU7dDusKwEp05brq45cW2YGDUmFEAcZnP51UbFljsjd/RU6TH7m?=
 =?us-ascii?Q?YIRAxPuz3Id8F4+CrMX1KKenIFJjYdyxMXIsGqjM+24BPY2iqF545JMV6L/7?=
 =?us-ascii?Q?GydwnSjFlgfbasWOB1K4gPatJ2DA2H937gqA5O6GuHSrCp3jJEH+ExYx1qIl?=
 =?us-ascii?Q?gM9T1G6bUDIV6v0dJxv5cjHqOe8TTQEtGOIDwu99PRIAROThEM6f52OCyWrw?=
 =?us-ascii?Q?D73Lk36XlHYgbofoN/aeeoZ/8XPwLjblgr0N?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:47:27.7634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c8d493-ec0f-457f-d0a1-08ddf45e68ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729

The LFENCE retpoline mitigation is not secure but the kernel prints
inconsistent messages about this fact.  The dmesg log says 'Mitigation:
LFENCE', implying the system is mitigated.  But sysfs reports 'Vulnerable:
LFENCE' implying the system (correctly) is not mitigated.

Fix this by printing a consistent 'Vulnerable: LFENCE' string everywhere
when this mitigation is selected.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 317c26e08827..1f3a20f6fac0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2032,7 +2032,7 @@ static void __init spectre_v2_user_apply_mitigation(void)
 static const char * const spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE]			= "Mitigation: Retpolines",
-	[SPECTRE_V2_LFENCE]			= "Mitigation: LFENCE",
+	[SPECTRE_V2_LFENCE]			= "Vulnerable: LFENCE",
 	[SPECTRE_V2_EIBRS]			= "Mitigation: Enhanced / Automatic IBRS",
 	[SPECTRE_V2_EIBRS_LFENCE]		= "Mitigation: Enhanced / Automatic IBRS + LFENCE",
 	[SPECTRE_V2_EIBRS_RETPOLINE]		= "Mitigation: Enhanced / Automatic IBRS + Retpolines",
@@ -3564,9 +3564,6 @@ static const char *spectre_bhi_state(void)
 
 static ssize_t spectre_v2_show_state(char *buf)
 {
-	if (spectre_v2_enabled == SPECTRE_V2_LFENCE)
-		return sysfs_emit(buf, "Vulnerable: LFENCE\n");
-
 	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
 		return sysfs_emit(buf, "Vulnerable: eIBRS with unprivileged eBPF\n");
 
-- 
2.34.1


