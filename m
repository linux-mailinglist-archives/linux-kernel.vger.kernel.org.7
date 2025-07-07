Return-Path: <linux-kernel+bounces-720367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36981AFBABE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847E44A1AA6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEDE268C40;
	Mon,  7 Jul 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hyNTqjQi"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7765B267B90
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913225; cv=fail; b=NmEp3FHQeKdRe5OfPEyE4Hx6O8q7qzXlPfrpiKPQaDbmVizI5N6CWUKCN6UsuL+dTC+cx9awxryfx2Kqz5T6RvIe3tu0s6i8mbrsc9XzMXrytDLezWq7RDk7X4e9zNZWYtGQSIQjWyLGdF+UGgcR/un+vpo4bySNojmy8FX2NKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913225; c=relaxed/simple;
	bh=Huzo6U9tVQjDiP/NdFIWg2ud5HYlkb7j+e71Vbq1J70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqzO4ZGr1OTI3ATorDfScpOyZAmH1wVQP5FvT93y18IYj2atgreOeMO2+PQbpVqk8tvwgtgfZXem90lBD1hg9ET/4HhOgYxyWqVlqy2pylc7RZLmFVHMWglkYvU8z+A64IogjyFo2HSiteDRTRsGLE6rH81Yfg3b0GjPaOSakgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hyNTqjQi; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pX1Whm2gIo0/gFsv7eVcPjumjmkSM5pmbdM+Ti2e/WaKbbBJAyPmHpOknMvCAdXdWO+anu61/Bqi2vMo1QV2f4iwqq1IGAoCnla1vU140B3P3WZ//Dx1ogB2onViBlodBEDj1a6JM+wiOYrZjH8GnmQUQ6q8OK9FaPEyC5yFVMUamQYwQ2iVViCuLLWe0gvA82w6G+K2ZssUXMD9ONSiOqp4/HdALpDhuirKXM/4pje6iIPuhXaVm0DjpDv8QaV/7v+gGVkRx+mjqtaWajdlCWHFiXn713kZFMez98ht7dYNamSv5+g/WC2IEHz+T/blRDivYgvpeFNUxtn4SWRTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk0UD0lTyxpZ1V45umETLGgWROOL3W3ZaV6bFEWQVAw=;
 b=PnBhB3y7CGVQAOv7gEAVNgcm7g789YPAERPIbFweW31TrWv7qCGUep7fl2wpVrt9Z5Y0rp06XeN6Yo530Od7vNsVYxqD27kRKr32a2HMtKau9a/d6xjJgeb4VQ6sLiTbfd3Zm8UvsuK6Y1SuCtNO/toCE4yb68kPqGAgD6OHViHAFwBJy0MkWA6WeYN/0QLjhR2qFc+H5PGPZWU9ir0PUiHA+hIxeIDKrLLRADqFRHyXjX+KNN66xbDvH/WrSZzZ6cTNJl8ckiG7DRO+dxUTJiuLbAJoeOa+8zMpaNoFcav4QFst3FlX6V598j6BGG0GboxddzKw/rXpBDz0qK61dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk0UD0lTyxpZ1V45umETLGgWROOL3W3ZaV6bFEWQVAw=;
 b=hyNTqjQiH/ZfyjIsMNvORczPh7YG2m0bYb7QMqK53A3hdu8j0fvzS59EfpLsysjA1l4L1j84yEGuEkAgLR4AgANLGilyW0zLD0ioTXYBbKgSXjWppWexpWwD/oLjTDvuJ+kPXwtnyiCeSKbkkaEj3/BqBbaWsAsPBOdDUfCqlxw=
Received: from MW4PR04CA0256.namprd04.prod.outlook.com (2603:10b6:303:88::21)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 18:33:41 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::8a) by MW4PR04CA0256.outlook.office365.com
 (2603:10b6:303:88::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 18:33:40 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:36 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 12/21] x86/bugs: Add attack vector controls for retbleed
Date: Mon, 7 Jul 2025 13:33:07 -0500
Message-ID: <20250707183316.1349127-13-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: b38d3ed9-836b-4ea4-3dca-08ddbd84cb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?65h7XrRX+EI/BNStCBhtRrrD9vAMX1A1nq8KrzenoYH0RyKkq6n7kKwyQY9F?=
 =?us-ascii?Q?v9BbWffMDfl0cbd5WptZsY9hCciGjGnmjnIkI5y2L2mKgOoONM35YkuCxVvb?=
 =?us-ascii?Q?peha3PzXTrAQR7Wq/gJYw/Y2V58pYI/86Xv0hbuKVKYJptmwih974/wvpNB9?=
 =?us-ascii?Q?1U7g/2umQdF/ZgzQ+WhgQSkU9gcmflFh3hWXM8/vhcXa8GCzqSdzOJSaJxoO?=
 =?us-ascii?Q?eRUPylSy+0mzdSOEGUU9hzWDj17HSCGK4AESFaFSYxWavom0cS4GXO/Ozei0?=
 =?us-ascii?Q?FKcm8om+khcuPwCRvz6ORSM8V9q5z35MFniIZumGM9rmh/IpYwTXrAX7KtKd?=
 =?us-ascii?Q?GF6usAQhaWGhGxVIW6wmFejkHVDUiJnxgsHZhgaeSVFWk9MHe2btcCwG9dLR?=
 =?us-ascii?Q?G0LW0pqTc3dahVyaS6C4kucE67TH3C7LEZagahC/4VF0R2VDeqttmpjDNVER?=
 =?us-ascii?Q?GC1QacgXjD8xQkdq8wp8CkE2dXZEldR4+WKeHondaRf3voqtGumTFUf1tXlr?=
 =?us-ascii?Q?XReOus4jekyLPk9OY+TNaDnS+TGWaQDveTGeipfm8eKlMVDZZuXlrWNsPNEY?=
 =?us-ascii?Q?lXQCWNch2iaIIPsqVXv21cp/m6npYoQMCQhS8to4/aieaw+r0jc5cPMqKJt6?=
 =?us-ascii?Q?kPWu+EjBBGvSZQLfKqnbDpPBGR6lQOWuLrMAxaWPl3tsuq+cI0VGwCvSqGh5?=
 =?us-ascii?Q?dR3i8NCAP9qynnTkXbxFbnTcwRYEH0zJ0qPVYcxJgA4CO9irRm6DzdAkVPDP?=
 =?us-ascii?Q?4d2iJShy4hKf0pgqGpmw+0tuCLvjcqTiZncbAdvXdzdVJ0VOzgfu1KsmZyAX?=
 =?us-ascii?Q?a0l8kSPtciamKwmu5wxKbx81SESu2fJw0kUOU9HOhoIhBriSx5DbeO2pVKM6?=
 =?us-ascii?Q?SvOPJDsOk/NXxtzkA2eBb8K+Bo5UuZ9mFf1VJBnafV93pyBjZbtqbEZkTQbl?=
 =?us-ascii?Q?uTbt4lF90fVDL5QiNPX1AOFvJjhlRQcCQD87TTrHMgYz57a+w1xiGa6WH903?=
 =?us-ascii?Q?5oivae8prOlNeCUop87Gp7J/hIrs6f2hvdY/gC9Dt0UfLz9Kc252q5Pw3S2/?=
 =?us-ascii?Q?1zp+4WvylBSnzGSM6U16Eg/eqWDxufsgrHZNeGq52NimhnnMgjcr46RT049H?=
 =?us-ascii?Q?p1cCnKq16izXZCkxsmhVzVzMDR3QB93Zcsdj7+JJPDypqfM7n74/l2ABTAj2?=
 =?us-ascii?Q?g9lnXWK8p8cKtcQJtOPfmJtaEcSwH6c8bB2qwivvpCAnAKGpellP1Ub62jI0?=
 =?us-ascii?Q?5Cek3HCEabGbXNxsObYpwZQMWahktvFIzjqR9mhs/kf9pzrXMdvXGgf2U3y/?=
 =?us-ascii?Q?+g9hcp5G4fXQeGuBEJ1DkCieEOK7fofDj0awlYRf1wAfytef+CDq3QXHi/g0?=
 =?us-ascii?Q?RSIf61dz2YVFsFBfg2vxlGpMABPWYs5UvKH+3bbMm7mGt/QR1k31H4FP93eP?=
 =?us-ascii?Q?9MKAAzhhOLpEsZfuRLYjnJU7mu4JHhH1ElwS/5cWN47N1v+/XzJjsTNebv5C?=
 =?us-ascii?Q?zLsT+oiKUOGz/S+jyckjH3GWnuRZ604vpv3t?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:40.4428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b38d3ed9-836b-4ea4-3dca-08ddbd84cb9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479

Use attack vector controls to determine if retbleed mitigation is
required.

Disable SMT if cross-thread protection is desired and STIBP is not
available.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f4b3d879ba38..1e2dab9be7db 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1309,7 +1309,7 @@ early_param("retbleed", retbleed_parse_cmdline);
 
 static void __init retbleed_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED)) {
 		retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 		return;
 	}
@@ -1346,6 +1346,11 @@ static void __init retbleed_select_mitigation(void)
 	if (retbleed_mitigation != RETBLEED_MITIGATION_AUTO)
 		return;
 
+	if (!should_mitigate_vuln(X86_BUG_RETBLEED)) {
+		retbleed_mitigation = RETBLEED_MITIGATION_NONE;
+		return;
+	}
+
 	/* Intel mitigation selected in retbleed_update_mitigation() */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
@@ -1369,7 +1374,7 @@ static void __init retbleed_select_mitigation(void)
 
 static void __init retbleed_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED))
 		return;
 
 	 /* ITS can also enable stuffing */
@@ -1464,7 +1469,7 @@ static void __init retbleed_apply_mitigation(void)
 	}
 
 	if (mitigate_smt && !boot_cpu_has(X86_FEATURE_STIBP) &&
-	    (retbleed_nosmt || cpu_mitigations_auto_nosmt()))
+	    (retbleed_nosmt || smt_mitigations == SMT_MITIGATIONS_ON))
 		cpu_smt_disable(false);
 }
 
-- 
2.34.1


