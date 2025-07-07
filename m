Return-Path: <linux-kernel+bounces-720373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6005FAFBAC3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A5B4A528C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EF026CE37;
	Mon,  7 Jul 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A+pl/pNT"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E410026B2AD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913231; cv=fail; b=RAFN5fa2KiQ4XlVWA6MbsT/bKtE5NLFIHJnKEoJB5t2MESTEK6nwS0K+yZL91mLVx849k4Q7LTwcNldg9NCgQsVTykzx3kFn0FGK5ZKFO546rTTJYPxLkQ5QFjmYU6uWsK1F39nbaTgSxlLaNgG1YuSNHmtpzGYbGmo2icr8OnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913231; c=relaxed/simple;
	bh=7XkJ6PtM4zRIFCuC+g8GXDT2+h1fkCYxGDPTCtg1U6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KomTy/gzcHCklFk45AglW8wvn2jsqi6L5LLHnG5y37fi69IMnJL6xT6DypNyJlOB/HHxSd7ZA4lIHVrjgBe3cvRlfY7Q7G5ushE90FrdattRiF49SYWZrAWjABLyxeMGvQmet9HI+9rKUGkomCvm0mbb6pZgSrIkoSZK0ZXT4iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A+pl/pNT; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuJU8xS8RA/MwNWBz0ls2ulLO8fpNxpuV9gmZZSZi9wOY0PBD6zoUBX5Ke+t6rbnkP/Ev/Dbri4Fj5BUq7W4knT4dG1418HAYg4BXpSxfAxVpfDTIW3dLIYiSG5g05UxUbf8iM6dvBaGhG/aeaxVbgkEvN4IRLWR5ixJev8HAOdxoERQYJEgtPhpnEUnWHtTcGsqH6zvtJkTkSSYU05ZVt5EFeR/w1BbxDa7ZiUIUExn8xAIeqvbR2BjhbLCepoO9b4exlpl3jYlceG+YYbHo6xy3LDzHrXlB++DqF5gz84/GrYJc1hhrlMcyBhYdi1u6rKRctWwJVLlXHmczgOQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSqyZzXIuaHiLdYjXHaNZa3izwqYa3/ncZGys9AZu74=;
 b=vY1wkkffJFwVeOEDZE+gjlMnbNg87IUozJ/dasftY3pjI1mJkn2ERzf/X4Cjc+/FnkuQqRrsOv6yajNuyzCQiA+tc9sd4ewWj7zfg7DpJSdztqDf7LtR3fFb2H1T9slDsI8TM6BFKEs3/hqJWaYLL94ZE+2MtT5pIuGbMQ5F0w5l8sBT2R7h0+GbxtWguERk3dz51SRLsPJikAWv5/UL2yzoERxw7Tmj2jNB9yOFUm3w5zuvwG1pYu8zWrRYcs2EIZ8zH+Dl47pR0vq+BEUjMnsPNj67V8jsmJK18lZWWOOsdGbiynco/pl1e/JxqOea0/UOzdShJMXXqx/bFBkpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSqyZzXIuaHiLdYjXHaNZa3izwqYa3/ncZGys9AZu74=;
 b=A+pl/pNTyHCAYLsAdKo0+KGcjvhwxaj6FqlG3n6g548reJ1c3/CXLXU5BwJl1585SP12weLehW344Oa0c1OAf40z8w+Bmq3OAbJwuQOLYgm8cnreEr7g22GEerac36MFaf3WAs+rEr8MmPnrsfy9SJ04877vICZ5OeU4RmY4IbM=
Received: from MW4PR04CA0255.namprd04.prod.outlook.com (2603:10b6:303:88::20)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 18:33:45 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::31) by MW4PR04CA0255.outlook.office365.com
 (2603:10b6:303:88::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 18:33:44 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:40 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 19/21] x86/pti: Add attack vector controls for PTI
Date: Mon, 7 Jul 2025 13:33:14 -0500
Message-ID: <20250707183316.1349127-20-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f65600c-1550-4f66-de47-08ddbd84ce4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fzqr2srCdNanb89/lN/VD4bCdBe1CM/b0X3bmPY0176UGr/kWzf4p3SuO5on?=
 =?us-ascii?Q?A4w+OJusOlTT2T6xbzd5Fa/faLHa4o1Tbh2Y8u7zzSkaMpBoqwSfEOf48Rit?=
 =?us-ascii?Q?9G4GqZxyPB+vLeAIIpywkUdnWWfZ/vJWjGFStObfHKBhdHB6fBJshe9ApxMd?=
 =?us-ascii?Q?tokmO/K1oY7nY1nX69SW7afBWiFSOm/W9My4HgYnfvNkFPcqSPJVNJU+PJXg?=
 =?us-ascii?Q?6FDD7qlOu8ALzG6OQXgqxhlqKCLhk37eEF5FF9mBOsLAFHiV+6EU66oBEmVq?=
 =?us-ascii?Q?H29ffUyZUwsF6pKYveEDISJHib4YVPyVIlgFhE3xwyeFxQC0iyL6UM/6cro4?=
 =?us-ascii?Q?ZB19m3bWrbcW4I8kOaMqYmpsVkmH9vq4KexrUDaN+JTWAnyll2DnfB4Q5iGM?=
 =?us-ascii?Q?fx4Rn3S5rHFh8B8bLXRcB4fatMfuYgPxkAh8+ANUiKZu+Wesb3FgFJfIJsYk?=
 =?us-ascii?Q?eMJEBCaYK9rHES1LYk/ikjSakXAlJnGbexXiOcn6ttmnSIyfNVj/38hZtT3+?=
 =?us-ascii?Q?h2l1Ct47+3f7TclIeLfCwnJBbAIvAn2g1OPr4+Z0dct5qiMfdWCIDBGbgHtP?=
 =?us-ascii?Q?YodJ1RSHDWGQYZu7wQ4azKiHQK2e8cDbOP8oxE+Ky0lSR3N+uWzkOKknpiJ7?=
 =?us-ascii?Q?CaozY5opKYCNVNeOBwJ/u803d/HKTnLCQEysXyKeXvOJtvBF4pRJ2Au5W0h1?=
 =?us-ascii?Q?nmLer1pfqXM+J0HtlJjyXkzZiiRocDyZi5BnppEe5Xh3XMbUQcfb7Ve1eO7T?=
 =?us-ascii?Q?/eyMlVo08ogKKi2+51Ncz3EUxCCnBjbdHP3TwX2xeBU1n2T17sUrEVZTCk2h?=
 =?us-ascii?Q?sL7pgmxg8mBsh6A+JbSV7PXxkSmEQkQ/uV073sf0Dks75TLgVjpDA8D/3YSM?=
 =?us-ascii?Q?irRwLcJU7DfHGHdq458SOkZP9++d6+8sfC1+Aiq8zPCbv4m3JNlSUfySZUL9?=
 =?us-ascii?Q?fw2lSNzWSm1bBZ5vSmzupIOHkt4rhccpNOF3ueZwMQMZIngIwLn5zvZ+xRYV?=
 =?us-ascii?Q?SXpS2oSrAs8zgefoYZxlTyx8Yt4MWsRXOJ5dRWvIE2nXryaEJuQCztCur1yh?=
 =?us-ascii?Q?jz2ua5aehhX0earPqx+zvBfuGxtqCFPvPCwqH77Co5FxNG7OEbz99RmRXEPu?=
 =?us-ascii?Q?GHX4oexFocAQ49m+sr+N4jTPVV9iz3SfokxeUaDP4JK4dvl90MefDiX+b2/h?=
 =?us-ascii?Q?jW03QTR8cSHssDz4+y1j++ZeFvbcGvdLxKZ4efCiG80YA9W3E10lxfiOolQF?=
 =?us-ascii?Q?B850LThKDMaq7CxdceFb+szxPU5s/kh+kZsbIjfSipaPvlV3C0WzOx3SCa5a?=
 =?us-ascii?Q?bHXt9/hjZzfKuO+Kd1VO86GX1mqh16Krbgkfmuhz7Yh3xG+MZcnlZJNjx4f6?=
 =?us-ascii?Q?YYEL5v92Dc9W3qiDVAoSRbP0xaP/qwLRcNHyg8vXMQeNHIItYBFQEYGGMWjU?=
 =?us-ascii?Q?4puIqzqaqT9UR4fS3SwGlMZZ3SEF6GNWnwiV/8zFsQzwYsK6KpFcwakyv92W?=
 =?us-ascii?Q?/THCaouvCF1WmyWWrrwMGOfsj2fPBl5xYmSw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:44.9743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f65600c-1550-4f66-de47-08ddbd84ce4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020

Disable PTI mitigation if user->kernel attack vector mitigations are
disabled.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/mm/pti.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index c0c40b67524e..b10d4d131dce 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -38,6 +38,7 @@
 #include <asm/desc.h>
 #include <asm/sections.h>
 #include <asm/set_memory.h>
+#include <asm/bugs.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)     "Kernel/User page tables isolation: " fmt
@@ -84,7 +85,8 @@ void __init pti_check_boottime_disable(void)
 		return;
 	}
 
-	if (cpu_mitigations_off())
+	if (pti_mode == PTI_AUTO &&
+	    !cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL))
 		pti_mode = PTI_FORCE_OFF;
 	if (pti_mode == PTI_FORCE_OFF) {
 		pti_print_if_insecure("disabled on command line.");
-- 
2.34.1


