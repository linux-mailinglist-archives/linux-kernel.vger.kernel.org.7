Return-Path: <linux-kernel+bounces-850745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7680DBD3B19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3C33E45DD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE7E30E839;
	Mon, 13 Oct 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wsi5vG2S"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6163309DC5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366179; cv=fail; b=QSuYc2oQuKhLuCVx1ho54tYtmopLtGSm2/8MKooE1Rpjz+/Z8QiDDdALCkB+uqqplS7DsHIHqKAk90o4y0IqyinC5kKNha7rjYo/Tq22st1qt4bIf0K2Xv60S1U1aByM802RKoUl2dAX+ft57A25aWGhO1ezNglmtxGHTgnYML0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366179; c=relaxed/simple;
	bh=O8zw6uMn0XV15DZRXNG1nrZKJpl/fqpThNwOKjrXtz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfngIG4ZaHCKOOT67Or8x4J9Fkrp/REGzuHBuAann9CqoVDsyv9AtMoCMHGdIHjmzK5H4osrWOi6C8xnKfm7/UXydYrdMSfHaJlf4lZZVKzlTGlLeU014Thgp2as7XcQSv8ffx893I+F8VoXqpxixIxbeUXSu/lu7opK5lJ1HrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wsi5vG2S; arc=fail smtp.client-ip=52.101.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY3G+1brsGnFgSNhphvrP5+OqZf7GPR9iFPmROisbn8ekMA+dkjRfucSdtG8JDzefljcsT+zTP+luydT3xDcOU/uqSqWmPjLl2WSYejB1YwJR8shn2BMb/59Y6AfmcwMQpH2mnCduBIIbOplkQLRa9QfO4p9tRmImQhJdRnxEKRZCXfCK7FpmGsLiv9N2ANFNSJdTMiLghEhL9SQdwrsrCI0s3BFnqb6KF0YZdThRd9VsRU4L1qRMW7IyLtRjWI+ibckjVqRoWr8QnazQRdEMH/9xmzrQEWYL04K7flv/NhIk7lDQpWgjWMPR8LU0sW1nB61r9HaxwhEiDJTdtv3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bh7CYcaZaDRKWBEGn1WhNTaTlTAnqYPZEHVCLexKGXc=;
 b=JBUdQLuW7Ao2S3ZGcygSezHMTcro3Z3Sg6clU1a5FxG/5uLmSwQePaVG2L7/LrnPcMQF2754RF5Ie4aKtaGIx5SDzq5+8C9Gadvn4ugynXbktV8hTiRm7MG1FuJdS6T3utN7lJJoWsmBqa6gzbT2fii21IAzYe/LaYXcs4kGS+hWwcVYIicRatggMc7S148fQ6Mdmf/J1u4FaSrl57QS970igD2CNIKS/OvV3JGFyyXJa/gvKzjra35JXewvzIKnz1XL4rJrB3ZtLi8nYMj3UGBHgciAxglQzMKbIEmbaU2IJAqeI5BXrDGXrfONtb3jknT+U6p3iB5W/I4x8HKQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh7CYcaZaDRKWBEGn1WhNTaTlTAnqYPZEHVCLexKGXc=;
 b=Wsi5vG2SezodwhNzk4hlVBIT+iAUB5yf+W31HxwfT0dDzijy0IMdXiHxpya45NUrsdZup6f9TuVRqNEAWJcm6BEXbmY9r8sdI19Aqbpt0A3o8oFcqVNEXxmsdh799CpiE4Cpkbv/FgOmWuAEfPnkWI+bXt+motexj7aIsRbZ5ow=
Received: from MW4PR04CA0074.namprd04.prod.outlook.com (2603:10b6:303:6b::19)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:36:14 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::66) by MW4PR04CA0074.outlook.office365.com
 (2603:10b6:303:6b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:13 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:46 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 38/56] x86/callthunks: Reset callthunks
Date: Mon, 13 Oct 2025 09:34:26 -0500
Message-ID: <20251013143444.3999-39-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8d8596-5282-4575-0671-08de0a65dc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NyC6fTQzQJcHQfQrZzoZ7QO/mCOAEVvCA1tJ6ySlNkXqRDo9Sv5dwcYxjmpt?=
 =?us-ascii?Q?A9wEgX36i1PrkMk3mEsub50Ss76EmQOaFOVFI6FVhTCmy3F6sZEqetWQUslD?=
 =?us-ascii?Q?ykH/oxNK+6bOs1gDv8ST4CrkINHL1pYmoXuRzLHoQvQHKpnSBlEVAI2TjbN0?=
 =?us-ascii?Q?mlLxgHdecRD3uCMbha9jUnhX99CzFtGZeh2azqDD5sv9uVv6WDEe4z9vrhhA?=
 =?us-ascii?Q?oAogIcgRC0+u4S/H8dPboLzqgIUr45mWruIgHGbUKiC1GF1ydm3eYJU1mNsp?=
 =?us-ascii?Q?vUlSZ6e7OzZGWmK/6RkcFyX6LOGUp/+cxnyhTTerhtL5pYQz1SN6eTAy7/AX?=
 =?us-ascii?Q?aa5uirTtwBVvkoNekVud81uJgQnrQWgsSNAezp4v6Iarc6ueFIjKqyvyr0yr?=
 =?us-ascii?Q?wyolRiIt8nKFDtzf30Km8pMVYKPlBxOMhWXiAluuflDpoi3zTIIl29mN4MLF?=
 =?us-ascii?Q?L4PAN4ZfAoIIz00iad7JWi4TCWP5OBB6Ep3COkg1mIY1uE261dQQer2N2xBH?=
 =?us-ascii?Q?krwH24x4QLGdI1TWQm3qg6Z4AzzAjW6UYtC7xtVPrFlqbLmb8Sg4d1Hb7IOQ?=
 =?us-ascii?Q?dBcfuiaZbiFrSotJelq2VKgLDHm0zlL6Giwa+p4e8wLpO6Ys6l+ekLGNr6B+?=
 =?us-ascii?Q?8/sb9UGh88Z7RYO0OS+dSxOhumxQhx/cHv+HqWn6pIwrIwZvBvIC9b6JhuN6?=
 =?us-ascii?Q?bNu5961p9NDCMsYBbmKOmatkevFOnASokwRJElXInDGKugl4UtU5lcwFLdqG?=
 =?us-ascii?Q?ooK0fywFH80gXFuvSCiHvKq/eISZwhqUn76d3bTofyvkCvALH7Me5LP7TjNd?=
 =?us-ascii?Q?u+gbK5gK37BZ2CWZH+JTohe3gaxg7iIYsnW5BOieYbI2uDJGcceQX2ikG/F1?=
 =?us-ascii?Q?Wel+9CdSm5eA3gYFjP/4o1wxcXRijUCqfCv35sJsNBDd1nlCD4zb0H+Py1OW?=
 =?us-ascii?Q?ngoiHmBAdGKxt/KKZDGOw1z2PPIGdiSHwi4q7zksLet/c95pbkEQswCrEk2n?=
 =?us-ascii?Q?Ur7SbxarASXNke5U37+8nrMXCov6hy6YHTLSfp7H2U2Zrg1swbxoBSzBvsVD?=
 =?us-ascii?Q?GxCyzgWABcwDJwFWBejxX0ZcccfH/lGZoXgfUOH5cpeD7Cec5txkxHJfcvQg?=
 =?us-ascii?Q?qyzflr7GLy5OWBaxuvBW52Vtm1JKdF2MF6HWvcpcBb46vTtBJn3ryIgVvtpY?=
 =?us-ascii?Q?S4j8P6dayBJIZI6GJaLBSVKy/+stBIBmDXlkr/FK30FAT5u/K5FERMAfqGju?=
 =?us-ascii?Q?gH3F7whjWRCscH9nfagdgHIeo3G2tJkpXtv0znzEavVMjjTzl21hDUXdjB0U?=
 =?us-ascii?Q?+0tYCS2qVgUR56hPD8zFi2NWLfx01RuoIhM17QJnWyrzqVh9NROktA7sL7cl?=
 =?us-ascii?Q?7D7DJoP7X7F4E+0yf/y5FQoTJrPayboOzFMkCk+LCDOo53CFbFyOXwt/Txvm?=
 =?us-ascii?Q?XR/2KmPgIhWXUggrQ6lZWaBZIDqnn4c9fIQJeJh7dYY2+9cIGCna45OvqDJo?=
 =?us-ascii?Q?3rH0XYFSdbz9N87Iz06qN9oyC04VVAukLBlq6WHz+R6Jx9KsS5og7dp1tU5B?=
 =?us-ascii?Q?IUO+MG0bHfPAoJ9UiHY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:13.8939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8d8596-5282-4575-0671-08de0a65dc7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

Define functions to restore call sites back to their original bytes.
This is done by checking if each annotated call is pointing to the
expected thunk and if so, adjusting the call target to point back at the
original destination.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/alternative.h |  7 +++
 arch/x86/include/asm/module.h      |  1 +
 arch/x86/kernel/callthunks.c       | 73 ++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 936e555c13ce..00e60195d768 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -133,6 +133,10 @@ extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
 					  struct module *mod);
 extern void *callthunks_translate_call_dest(void *dest);
 extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip);
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+extern void reset_builtin_callthunks(void);
+extern void reset_module_callthunks(struct callthunk_sites *cs, struct module *mod);
+#endif
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
@@ -147,6 +151,9 @@ static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
 {
 	return 0;
 }
+static __always_inline void reset_builtin_callthunks(void) {}
+static __always_inline void reset_module_callthunks(struct callthunk_sites *cs,
+						    struct module *mod) {}
 #endif
 
 #ifdef CONFIG_MITIGATION_ITS
diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index d0c39b921408..58d7f1017a14 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -23,6 +23,7 @@ struct mod_arch_specific {
 	struct alt_site *alt_sites;
 	struct retpoline_site *retpoline_sites;
 	int num_retpoline_sites;
+	bool callthunks_initialized;
 #endif
 };
 
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 758e655f36a8..3e6f00e19814 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -336,6 +336,10 @@ void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
 	mutex_lock(&text_mutex);
 	callthunks_setup(cs, &ct);
 	mutex_unlock(&text_mutex);
+
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+	mod->arch.callthunks_initialized = true;
+#endif
 }
 #endif /* CONFIG_MODULES */
 
@@ -381,3 +385,72 @@ static int __init callthunks_debugfs_init(void)
 }
 __initcall(callthunks_debugfs_init);
 #endif
+
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void reset_call_sites(s32 *start, s32 *end, const struct core_text *ct)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *dest;
+		u8 bytes[8];
+		u8 insn_buff[MAX_PATCH_LEN];
+		void *addr = (void *)s + *s;
+
+		if (!within_coretext(ct, addr))
+			continue;
+
+		dest = call_get_dest(addr);
+		if (!dest || WARN_ON_ONCE(IS_ERR(dest)))
+			continue;
+
+		memcpy(insn_buff, skl_call_thunk_template, SKL_TMPL_SIZE);
+		text_poke_apply_relocation(insn_buff, dest, SKL_TMPL_SIZE,
+					skl_call_thunk_template, SKL_TMPL_SIZE);
+		/* Check for the thunk */
+		if (bcmp(dest, insn_buff, SKL_TMPL_SIZE))
+			continue;
+
+		/* Set new destination to be after the thunk */
+		dest += SKL_TMPL_SIZE;
+		__text_gen_insn(bytes, CALL_INSN_OPCODE, addr, dest, CALL_INSN_SIZE);
+		text_poke_early(addr, bytes, CALL_INSN_SIZE);
+	}
+}
+
+static void callthunks_reset(struct callthunk_sites *cs, const struct core_text *ct)
+{
+	prdbg("Resetting call sites %s\n", ct->name);
+	reset_call_sites(cs->call_start, cs->call_end, ct);
+	prdbg("Resetting call sites done %s\n", ct->name);
+}
+
+void reset_builtin_callthunks(void)
+{
+	struct callthunk_sites cs = {
+		.call_start	= __call_sites,
+		.call_end	= __call_sites_end,
+	};
+
+	if (!thunks_initialized)
+		return;
+
+	callthunks_reset(&cs, &builtin_coretext);
+	thunks_initialized = false;
+}
+
+void reset_module_callthunks(struct callthunk_sites *cs, struct module *mod)
+{
+	struct core_text ct = {
+		.base = (unsigned long)mod->mem[MOD_TEXT].base,
+		.end  = (unsigned long)mod->mem[MOD_TEXT].base + mod->mem[MOD_TEXT].size,
+		.name = mod->name,
+	};
+
+	if (!mod->arch.callthunks_initialized)
+		return;
+
+	callthunks_reset(cs, &ct);
+	mod->arch.callthunks_initialized = false;
+}
+#endif
-- 
2.34.1


