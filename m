Return-Path: <linux-kernel+bounces-850755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F6BD3A38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0372D189F052
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E184730F7F3;
	Mon, 13 Oct 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lO/qxYt0"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA730EF94
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366186; cv=fail; b=nKKGohdc0Soog6q/gD6O7b0XjqUd530zuAipTsmWGFLEGgjZz+zSB57mAozC2J2g/Z2ri1fqQmG/n6HgrhZLN1Y7egu1F7mgl5QClo3w66xXvg8THDIBTbA9At59j5UHBjsP14ZAHi5vRfTFVpKed/nYmubMgQBkEwqysC6DGMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366186; c=relaxed/simple;
	bh=cQnV2+9V/I/enQGNFG7/7Glh6w4ndBOpfqgM6kCTiHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtdBgzrlGmrNYY0RpY53DPhK99sZjzeGebMefHj1+AA7ssKqrRD8DLs7BcHbnfO0uMSX43pmSyhkV5LCLj4ZzbSEK6XsnEerJEy5ESzm1SUEw+JkAEo2rIQ5I0Qc0ISUW88CeMn9jli9ca5dj7aNdagx16uK44PfqZNvt7xK5ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lO/qxYt0; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6GI+uutf3T7L3AvbPIRmbVgi8fG00hGi+eaP6qn49eSLGVfICEi/YtquUo/3P6jNhQx6cHAC+FtPE4uDMgKqKzAxPRtED7VzU7MttdN5+qZmFmU4mFBh89FosUJCNtxMV66dsSTzmBbOJ4b6+M2wUNolPLlurdlgGYQ0A5I+N2YJoUdBJe8AUMnH6UY5VQ48YCVnmpdFR58l2q3Jb4fe6Bj/OkIKcgcvhmhanHplT/faXos61TShGSMGYquTSkDudBoR4r9/2cq/YDWatDtGckHbhJLO2tkyEBeqxa/hGKZ6g1mrmZuaW6Nl2svIw8LVSDqaobTfjO9rHmpEKJ8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdYkxkx2pnLcPUqwHM2xC9tCJEv/Xqaou9QFuOo8/Bc=;
 b=sznDzWXFP8qNwrAAfxAOnph2a7Ze0tcgSbTrT/mSniu3LAPHjlN3/xqKj2uuVTUPibmXamIJgweykQ1Ulm/VG5IGdMOnQmvzXXeTGhNJ4/UDBoNpzN1nNopodGPtJ5e7vccfrWN1RvYT+ZCgdgZQ0Ng6lIC3aLciAOMC983xLAWFWjtaxM+AgqdzhrRX8qgB2qdGtteKk1WAmoUWMM2Js1o+SFuYYhPFINdpvHCrBwzjbEvz+3kJKu/XUFKDMNWubXRmf2MM3ml15dlOYjpfTLO119FmOe/xTb2T7Fk2vNHlLKjFW12KsUKkoh5qH2GxrEYriIHFhJajfp4vUI/89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdYkxkx2pnLcPUqwHM2xC9tCJEv/Xqaou9QFuOo8/Bc=;
 b=lO/qxYt0WEURUitXlRLDYlNAbS2OfXsAhZes/dKQkkb3VvI8NTD3a7PgPK4qq+Wbyn/cR6snM2klGaC0XLxcOkyRBm7gPL6eOaPP+kaj/jtUQbSHopUAlfn4zPf1G0igbUpFIy2E0QViA8lRVI0x8h6+hJ0ganvz6o43wM8CnJE=
Received: from BYAPR07CA0044.namprd07.prod.outlook.com (2603:10b6:a03:60::21)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 14:36:20 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::ae) by BYAPR07CA0044.outlook.office365.com
 (2603:10b6:a03:60::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:19 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:51 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 45/56] x86/alternative: Use boot_cpu_has in ITS code
Date: Mon, 13 Oct 2025 09:34:33 -0500
Message-ID: <20251013143444.3999-46-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac9c84f-d8cd-40fb-477c-08de0a65dfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RKv0w5ClhOi7mk8qHq7foP0zxIuDy2CBGpsZqZoF47TNcS+dtL37bahAV0hp?=
 =?us-ascii?Q?2YprZX9C3TQWpaynoizMTvPYAWKEdntwxEg9/6x+3MGVZTb0Jk73yqTPVKjw?=
 =?us-ascii?Q?2TdiUPOzPDJv2xZiQKDIGnIGFyk2jD26Y4Fsjbkinafe8iPYtH9GGhQjIBJZ?=
 =?us-ascii?Q?KvoJ5GWEvGqcLlPrT6Xp/mMjkVJKnfm0R3Il0LODOrUMK/qGPpYlYZtZyhrT?=
 =?us-ascii?Q?sbXyVUXyNYdoIVmamFAOAJcYg/72/jyG9CHm/Du0FeyONuxIjWpNBrens9Pq?=
 =?us-ascii?Q?li8QQQZHkXLX0SanHQNCVEXFM1a77xLvkb4QrzDwxMWvQvDGEgCyH58NE35T?=
 =?us-ascii?Q?zLRRdTcSJKZwxSWwJ7yuFqhYDNtYOi4zNLL3suF2TjY8W7fPWEoqmfQiYSOh?=
 =?us-ascii?Q?PqquEER2Dy+mHf9bJLJySO/XPQ2jAq9yJimjeq9EyLi9k2/LaomhgknFX9ks?=
 =?us-ascii?Q?FxYpo0mVoDBuuo5ay778KBCXRQ0VWG1ChwR62LBLR4tyaspzzOcvH1g2Cwsk?=
 =?us-ascii?Q?Z2y6s3AyGfb25oFd3TV2DXiLNBAySdc/LsZv12Ja8eZUJzY39P1J/p8au6M+?=
 =?us-ascii?Q?mhfh6KUuUWd24LYV20DfHP+thQffQiATvhWeSClJoxPFG4Sagd4XGh8D17oy?=
 =?us-ascii?Q?je2YBMMaId9IrL4vfOLEW1v6A2+pA0bi5pRwS7NEqarNC78OdB8VlvFPL80J?=
 =?us-ascii?Q?pLQcNlsEu4xgVMIyuNiEcF38zlQOIETe9dqUEO8j2E46qyr89nbUAUilSJGu?=
 =?us-ascii?Q?5lMxUvPsamKm2PVmH0pPYKBf5oFNyrqLiBP3fFBVW2CJk5jY+3TVpunX6f4R?=
 =?us-ascii?Q?CInylLTIIRSu2m55lSSjkf2lhWsFjj0gSSs9/pA2sP6UhZ3h3nrOEvNZEkvZ?=
 =?us-ascii?Q?JIkrAsMWZDbZ4JbdTPvEHWdXCRLCIrfhxDlAHVMJmt8KpStGFR1ZOQnwuGzm?=
 =?us-ascii?Q?htXxselOUYy/uPnM0XYNnHAqJMshHFWZFlZnfdN5UkNu2teCA+/9x/jN4Hr9?=
 =?us-ascii?Q?rQfA/8h/uN/B7dBHMe0vo9L1vsK40qbsu16jo3SLgwtm8q9efvCo8HIHIK2g?=
 =?us-ascii?Q?5HUJOrEfaJiXZu7lKMBvqnN/xJTqdB/euJ3vVXAXEoDrWKHxKmcHP2m6+Bwx?=
 =?us-ascii?Q?afQOMhkLIfxnjnJ1rKoYUDub61uiB0N6gus8TKJfNU+He6QZT+/nKNWbUmxw?=
 =?us-ascii?Q?FjapFw1dqS6kAUdqUL8jawpAEAubkle/mLA87kGBC29EvIidESeTeOyS25OO?=
 =?us-ascii?Q?zcSTWeOCGK1yfHi/YMymrQtSD3GCiSDk/0jlkLNf0jNqx8H2hW37MukD79ym?=
 =?us-ascii?Q?tsvYeS8yhvApUJMv9t8UVLFB+QeUcwRWzDwP5o2BSZLFp3XwRr9wbR2Akp1s?=
 =?us-ascii?Q?ml7sDJS7PvvX42Ln/gDUMU5okOC6fxmC3lU32s6IxOEeaAlHXJVvoLuMpoTg?=
 =?us-ascii?Q?/nNn+HVrRzt63DbMTfO47aNz3soCFMLvRhjItaJr069O1eqjLeBrip21ZBVj?=
 =?us-ascii?Q?ra3hrJJplE35sY4yIp0RsDcV1YGl29j97ijXZfX0ca0WB82g8fzRIZZKLqBC?=
 =?us-ascii?Q?sk2wKT5SLiKQ8pWKmpU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:19.4868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac9c84f-d8cd-40fb-477c-08de0a65dfd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

Replace cpu_feature_enabled with boot_cpu_has because under dynamic
re-patching, this code may be called after features have changed but before
alternatives are patched.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/alternative.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2d48d750d4d9..5a543ffca10d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -187,7 +187,7 @@ static void its_fini_core(void)
 #ifdef CONFIG_MODULES
 void its_init_mod(struct module *mod)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+	if (!boot_cpu_has(X86_FEATURE_INDIRECT_THUNK_ITS))
 		return;
 
 	mutex_lock(&text_mutex);
@@ -197,7 +197,7 @@ void its_init_mod(struct module *mod)
 
 void its_fini_mod(struct module *mod)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+	if (!boot_cpu_has(X86_FEATURE_INDIRECT_THUNK_ITS))
 		return;
 
 	WARN_ON_ONCE(its_mod != mod);
@@ -901,7 +901,7 @@ static int emit_its_trampoline(void *addr, struct insn *insn, int reg, u8 *bytes
 /* Check if an indirect branch is at ITS-unsafe address */
 static bool cpu_wants_indirect_its_thunk_at(unsigned long addr, int reg)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+	if (!boot_cpu_has(X86_FEATURE_INDIRECT_THUNK_ITS))
 		return false;
 
 	/* Indirect branch opcode is 2 or 3 bytes depending on reg */
@@ -967,9 +967,9 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	/* If anyone ever does: CALL/JMP *%rsp, we're in deep trouble. */
 	BUG_ON(reg == 4);
 
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
-	    !cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
-		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
+	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
+	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
+		if (boot_cpu_has(X86_FEATURE_CALL_DEPTH))
 			return emit_call_track_retpoline(addr, insn, reg, bytes);
 
 		return -1;
@@ -1004,7 +1004,7 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	/*
 	 * For RETPOLINE_LFENCE: prepend the indirect CALL/JMP with an LFENCE.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
 		bytes[i++] = 0x0f;
 		bytes[i++] = 0xae;
 		bytes[i++] = 0xe8; /* LFENCE */
-- 
2.34.1


