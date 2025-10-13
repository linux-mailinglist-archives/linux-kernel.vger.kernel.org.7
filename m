Return-Path: <linux-kernel+bounces-850734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E6BD39F0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D19A18823ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911303093C9;
	Mon, 13 Oct 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qDlqhXTm"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00230C368
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366157; cv=fail; b=lw8/P+0afMVLREqBYp4SPIoTwL6EmiGovESvBzdHobkZqnuvaL7sGB4b6L2U17d1rYp9qloScGlyzD3v5ANxFoC9XJRdUPoDAWGEcumpwmCQ1EP9lIW/rKILWA1g2eg78ZweZ0RlbZfshbezpGf9QEKvSlazu3VBWueVvgRpnZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366157; c=relaxed/simple;
	bh=uhOE3pWB6UN29X1GDg+tjV+Jz8D2gU2nF0KWKF9WjqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOedCW3PWE2X9geo+Y9DsDQHfYb3Ca5jcsbzb6FL6RGMpvB1SVxHsMX4spkHWEXnqktEYpWXHjizCbqKBzhRlRkVTZKxAlUu/b/sAc8y9/vKMGL4C5v6N4oR6T3K0PfYDPyy9h+sYa8BP0KXoxAgcflbQk4kIMjDUR/hKT6Sfpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qDlqhXTm; arc=fail smtp.client-ip=40.107.200.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ui4uu+i627EUu4KPshqjZyNcDVhjo4YpJ2SFoHqlZoTgSur81C81ZrQ5JJQtDDubH1nvWzZdm1GuiczQRyPc09E/ytv7OldNHOL7ETzFFfQ5SDs/uX777jdvPKPAgaHzYIc3crFdH2aUUHTqItveXOOJgwaa74tNYxbd/tOtLoTI2Wh+c/xxeJTUU3UQTyFvZBuF/2o7ud5tsIuffxPyifqWUs8Y/mqHDWCS/eOPfR7nQRI0VeQ5SIF7cUn1afq+S0tENCxZ5CxIHheBlxW7cGDvUj1RCWFrHUUrFVEMpNyLet2eRkCKe5R96PTEuWIdPvBCcV/3jebU+W+8ugBLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyemTyaXyyo/Ho5jqv/PkYxl6urzAHRd/E5i7l2bmrU=;
 b=bB3smkWeLeXrA4sJEyb8X57xKMeIAG0IaAX7CanXyYsOyc1OseaIoAoXCGBMkDUTm4+UovsjoQ2eTnKS2a3BnOSB5zRjSiFGf/dQ9XOAo/4lbalXcXSZd3xZJ7fpOPztKkmpHpC1U82gl3Qi0Yzs+pOIe6pheiUN4icpqBXWMIUfcW2ID2YshoCMwuuHkZLlQHoX3TGDEAyHefvkCQ/uEHxxtgq+ccqk/sZJELeo/xYpRIT+8Y3fb0WHbjHB3W1nA3awQlHMGGhgw2sy+9AQ4O4Hu99gjZ0D+EYwzoPEFkiwEkJY8JwPBDWxdiXWfSq1yetQec2+NwVxW/Ko0fVtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyemTyaXyyo/Ho5jqv/PkYxl6urzAHRd/E5i7l2bmrU=;
 b=qDlqhXTmqvrESozBQ7tXvOIw1ncIa61CCqS6lRkKvcOQtUlG7Gt61JN9R6JSdCXTbVF8RGbgbnoip9Ghga+c9VmMaGjwqmikCGx0mHxsp3ieD/ea4aOJal9NURBueNS1lCxv/9UUsWgRpREpYae+5oVYZqji94NA2i3zCi49/N0=
Received: from BY3PR10CA0010.namprd10.prod.outlook.com (2603:10b6:a03:255::15)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:35:50 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::17) by BY3PR10CA0010.outlook.office365.com
 (2603:10b6:a03:255::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 13 Oct 2025 14:35:49 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:34 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 23/56] x86/vmlinux.lds: Move alternative sections
Date: Mon, 13 Oct 2025 09:34:11 -0500
Message-ID: <20251013143444.3999-24-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d05f9aa-c27b-433b-ea1e-08de0a65ce0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xV7Glf+xD+Ohr9ZuN9AudTxR/9braLannlKDdagsWEDzGfFgJ+XZ5pBKcpGT?=
 =?us-ascii?Q?GrdFX/S8I9oB6Y6g/PsxksZ+C2JMQF4MfR8pullrM/oJR7hQLRC/64G4Tdfu?=
 =?us-ascii?Q?QEkVaHoAiLuYlnNHBEIjxXijqKfgWgvliGw91pw3yRhjXVe8GOqVIcp5IiWj?=
 =?us-ascii?Q?Khm5cgbTPsji2SvtqEa6+1UbYtBYbyr9Nco3mTTCmUxd165wRbpAB8WKm/kH?=
 =?us-ascii?Q?nq/HxGQIOzQNYuexaEZyJ/iV77IRvLrlgGj/WDt0x9mVr5r+9+jvyD6AM1fL?=
 =?us-ascii?Q?HP5apNk3wuPkqf7NmAbZZTRbiGwexatLpLd+cDG7zyG0dovq4kY1DbugOTBC?=
 =?us-ascii?Q?fhnn2IFt9sU0Dy0jco5g1DYxkJfeiyZW62xBdlboKzDe5UHBEgYRMePeAmcN?=
 =?us-ascii?Q?lz+6beqvi74694ZR2MU0hEjmBUNr3mBQKWKgw4zp5cf8XW7FUtF8K/wjVgf0?=
 =?us-ascii?Q?4nXrL6Ur0hvxkzXMIk2cPzA3+soDPYx0pZrioWJHgtQyfa8tXwvydRMtqlgp?=
 =?us-ascii?Q?Bm6WJbIZP/p7P6zBMGbERN8DafZ/OrR2cBxGzA04Gt+xujtzyubFGXGf0K/m?=
 =?us-ascii?Q?5tNyUXOhfrMPlN2j21y4PP4gR0afL5A0IhUgmEHiRQA0JCcfgT3S2QVfaAcY?=
 =?us-ascii?Q?QQ7iwnoow8OcT5c/Tc9mcsfL+SrjBjGkrawuLhRrdzLaJ9+o62fpNlzF090z?=
 =?us-ascii?Q?BRC/C9QrRBIFtW3ygdn8wSrRGEQXaZPEmIRQkA2x9ftckpBmIlEh/m1C7lcs?=
 =?us-ascii?Q?gi3pTs+IdsdSlfS1Ahnp+mCl6bOTrm9apM1q+kCBIjQ0U06KMzp/fA3wsFYU?=
 =?us-ascii?Q?cNu5DCtSk/oj4rPIZep+dRstVD69EU4rXDjmlfkWt0RViF6KfS3Yc1Xe4l3g?=
 =?us-ascii?Q?qZgc9sp5yVTQcvaI7rm0hQJboMHwR52GtkFzPiFe7ytnwW4RQ9GovLlv02wo?=
 =?us-ascii?Q?J7IbOEVmPBbOMkeT55hwn3hGXXYzJIKRFiERteCR2o055nbkr0uPuibMRNw8?=
 =?us-ascii?Q?H2le3a2swXuHnu8WNIVp/vkveRLP5VmbsoOeYdK4qF0Hza1+vZ3wMqAI3s/p?=
 =?us-ascii?Q?PzJjd9zW8gEIXjnng3s2dU7l6jUKkFfbeX2cYeDkUDYsitld4eEDcPGX8gJK?=
 =?us-ascii?Q?kirC4Q+27sGnu5Cxyn0aBwh4bFUFuEvI3LuZLjRHvjCbQhEQpT3xIL6xAaA6?=
 =?us-ascii?Q?VJ6fcXpwrRKvF3wG5M39n6EykoHIDUToMwDSQU4vnKlKFBoIpqhZDSk5EQ7m?=
 =?us-ascii?Q?5z7IZzUm9Y/mWPPB9UeQMVPgh/PbC4Y13iGcaVgUp7wId4uqgBQrkWthga3Q?=
 =?us-ascii?Q?PYwGIM4qPiDy+LkMuJLbei2kXMqmWP27yMr5NgHegn6rPGURi03OZsTB1sXb?=
 =?us-ascii?Q?SFDhqA6PtTNmlQKaTvW916llCACqMoBuICojmrBUt+udckKaMA1e1Ip6+rEQ?=
 =?us-ascii?Q?ekOnSylcLJJgQdevU20BSSlfhbQHX5Rhf6aB7V46lXUgYWaEzOlcufun2qgl?=
 =?us-ascii?Q?DUdM9lrV1JizQEC2CJ3+xN6UXw5BSNoohtCmw142AyWEYbJcpTZ4ef41g+t/?=
 =?us-ascii?Q?709cwiG8orhJSW/zqgo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:49.6926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d05f9aa-c27b-433b-ea1e-08de0a65ce0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

Move the sections containing information relevant to alternative
replacements to the beginning of the .init section.  This information will
need to be kept around to support dynamic mitigations, and putting it at
the start of the section makes it easier to conditionally free it.

No functional change.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/vmlinux.lds.S | 98 +++++++++++++++++------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d7af4a64c211..e0db3f4c97df 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -211,6 +211,55 @@ SECTIONS
 		__init_begin = .; /* paired with __init_end */
 	}
 
+#ifdef CONFIG_MITIGATION_RETPOLINE
+	/*
+	 * List of instructions that call/jmp/jcc to retpoline thunks
+	 * __x86_indirect_thunk_*(). These instructions can be patched along
+	 * with alternatives, after which the section can be freed.
+	 */
+	. = ALIGN(8);
+	.retpoline_sites : AT(ADDR(.retpoline_sites) - LOAD_OFFSET) {
+		__retpoline_sites = .;
+		*(.retpoline_sites)
+		__retpoline_sites_end = .;
+	}
+
+	. = ALIGN(8);
+	.return_sites : AT(ADDR(.return_sites) - LOAD_OFFSET) {
+		__return_sites = .;
+		*(.return_sites)
+		__return_sites_end = .;
+	}
+
+	. = ALIGN(8);
+	.call_sites : AT(ADDR(.call_sites) - LOAD_OFFSET) {
+		__call_sites = .;
+		*(.call_sites)
+		__call_sites_end = .;
+	}
+#endif
+	/*
+	 * struct alt_inst entries. From the header (alternative.h):
+	 * "Alternative instructions for different CPU types or capabilities"
+	 * Think locking instructions on spinlocks.
+	 */
+	. = ALIGN(8);
+	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
+		__alt_instructions = .;
+		*(.altinstructions)
+		__alt_instructions_end = .;
+	}
+
+	/*
+	 * And here are the replacement instructions. The linker sticks
+	 * them as binary blobs. The .altinstructions has enough data to
+	 * get the address and the length of them to patch the kernel safely.
+	 */
+	.altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
+		*(.altinstr_replacement)
+	}
+
+
 	INIT_TEXT_SECTION(PAGE_SIZE)
 
 	/*
@@ -243,34 +292,6 @@ SECTIONS
 	}
 #endif
 
-#ifdef CONFIG_MITIGATION_RETPOLINE
-	/*
-	 * List of instructions that call/jmp/jcc to retpoline thunks
-	 * __x86_indirect_thunk_*(). These instructions can be patched along
-	 * with alternatives, after which the section can be freed.
-	 */
-	. = ALIGN(8);
-	.retpoline_sites : AT(ADDR(.retpoline_sites) - LOAD_OFFSET) {
-		__retpoline_sites = .;
-		*(.retpoline_sites)
-		__retpoline_sites_end = .;
-	}
-
-	. = ALIGN(8);
-	.return_sites : AT(ADDR(.return_sites) - LOAD_OFFSET) {
-		__return_sites = .;
-		*(.return_sites)
-		__return_sites_end = .;
-	}
-
-	. = ALIGN(8);
-	.call_sites : AT(ADDR(.call_sites) - LOAD_OFFSET) {
-		__call_sites = .;
-		*(.call_sites)
-		__call_sites_end = .;
-	}
-#endif
-
 #ifdef CONFIG_X86_KERNEL_IBT
 	. = ALIGN(8);
 	.ibt_endbr_seal : AT(ADDR(.ibt_endbr_seal) - LOAD_OFFSET) {
@@ -289,27 +310,6 @@ SECTIONS
 	}
 #endif
 
-	/*
-	 * struct alt_inst entries. From the header (alternative.h):
-	 * "Alternative instructions for different CPU types or capabilities"
-	 * Think locking instructions on spinlocks.
-	 */
-	. = ALIGN(8);
-	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
-		__alt_instructions = .;
-		*(.altinstructions)
-		__alt_instructions_end = .;
-	}
-
-	/*
-	 * And here are the replacement instructions. The linker sticks
-	 * them as binary blobs. The .altinstructions has enough data to
-	 * get the address and the length of them to patch the kernel safely.
-	 */
-	.altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
-		*(.altinstr_replacement)
-	}
-
 	. = ALIGN(8);
 	.apicdrivers : AT(ADDR(.apicdrivers) - LOAD_OFFSET) {
 		__apicdrivers = .;
-- 
2.34.1


