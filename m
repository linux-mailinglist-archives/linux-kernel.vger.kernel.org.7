Return-Path: <linux-kernel+bounces-850746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBB2BD3A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE9554F6CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0AB30E828;
	Mon, 13 Oct 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fPOdmqJG"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5333309DCB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366179; cv=fail; b=s33Flpt3mwpOlBZeESQhigotISqdCLLO60VbU1TIP92eTxMAS6dx0zUcUuS9xJPNaGaQENOSAm9QFFKbwSSm9yxPsO1uGBxu9imKIUeECxcTSj5+GbkIP01HV6vnBWnV4W6Tk1teTBIKVgCGQ65yoOy16k9O+Epp08Jk/mB+XBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366179; c=relaxed/simple;
	bh=7Wb+YmMJ6PMV+U+5czs7HxDcIv1LoRswp5mS6K5Q2Cc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inLz0ktjYPy/twmFHLCvEK85RDWX+/RfFDOQD/9QI4MF3xB8J6q8e25JE8ZD+apSw1A0Rwx0cBe6MELjMntjtV96edNuVKLZAx3BDijjkfLirJws6Q+z3Lt4I19vWVuL+h0FuRZ6zEpqVGgQ2rk0QpaHJZE5hTl7VGiD2O5+iN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fPOdmqJG; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Isu9gjPnuED5xctasEJvlxUEw0pTFdjyQykvOtx/aOPH9L5lvgo4zcI3ep+6D+QOTNmKVjrBhn9oRdUmnWmrpN14r+JV0Q/keJIkW2P4QcN48CAUUOrXmr7E2sLWho7O4fR0SIGiAElIvsT9cCJdJ5NYoRExQTuFZ02scTNdGUAcW6c4k4UQjLzoQOi13TV5peFU1NG+RkkaS92oliJ6Qchc8JucFYqcxC25lWLw4fXpL6ri6Axv9KjJ1ulngHt0HMbjovcVWvhP2tkYkhRwTrk08zmabhRyZie/fphqoKhru5ON9AJ1b8GDAFwOR2b/Ho67PU8UJ7cHNlZZhmR1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmWXIwnSOED75MSOaGvJCM6pBIdBpfl+Llu9IB8nsAE=;
 b=ZZbuDIvK+6co7xl+ReD0IIjKJtNbTLUTpOATg3VXczPmshwuqpsPA0UWCAI8FlJ8I2Hax9ZQsGfINOaVD1mJZyhz/i1wrBWbX/3WpDexK43z0DLkA0T7iJe2+AXv1yLTGuLgnR154LVdx9NYZ2R4BCsjUnbNeMBydqM5dTLytZDvgYEaDgl3SNwjrh3GgGhvVxq0vFLRz6HppgWSbkzERye+uZzFrBCBad3yvaAaPRHtVqw2SfHPfKf8K8IWYgU/IuIjHEpOgZijhM+tXhWIrG/Kg1LbrozJbQrtcK4z7utLRCGR3driaSQ8oRI8oKfXQWEMEigdAZmKDXKNamHx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmWXIwnSOED75MSOaGvJCM6pBIdBpfl+Llu9IB8nsAE=;
 b=fPOdmqJG+1tGRPn4PzMxlHhextWF+tduqX4AEo6TVHXcSVG5Gi4jyGILdkCO6tAInnxhfUGjCfl+8QnNV/ONIZg/R8EkztJA0AmCF1TN4NQFsPMSn7Q4FVQh70n4/NspJRaf9XXEjsTCL8f/c2sEqTs4AK2kfLUJeDV6q6LKVdg=
Received: from MW4PR04CA0081.namprd04.prod.outlook.com (2603:10b6:303:6b::26)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:36:13 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::7c) by MW4PR04CA0081.outlook.office365.com
 (2603:10b6:303:6b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:36:13 +0000
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
 2025 07:35:45 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 37/56] x86/alternative: Reset alternatives
Date: Mon, 13 Oct 2025 09:34:25 -0500
Message-ID: <20251013143444.3999-38-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b43349-3062-4fa6-5a95-08de0a65dc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZPfd2mQ5ESZj04O+Tgs5uSpSXZ5/u244InztbtcU7SVQAOaR+Xw+U/n20+Rm?=
 =?us-ascii?Q?E78asyDvBMFlOb8GuQDgr/bEwAnF0J8Jvenspjfwri91upUYCZm9/QJOWnIR?=
 =?us-ascii?Q?WqAcNrU9EXppxAHqpuH4R8/xbUHItKphdNGNuBv33rvSyldSPYF79iziuZLe?=
 =?us-ascii?Q?hD3qZX89dDMWCaCM+wOzMusPw56S3n8yqRans1l+u2p6H3Y5sjp3m+FWK2k6?=
 =?us-ascii?Q?lbfeD/Rvu0xFZEXBjmbP/zXCwWNrZ2n96iFXLyym9PQowSscpFIDQpHrvUFe?=
 =?us-ascii?Q?YLFHw+xTwvY8kxbeQsSp11/bCzQeXmBB2uPqT1qlKCZ16sBqv9u97mtnAGgj?=
 =?us-ascii?Q?2g0vTOpLaEH4RTmr9Pds9kyLa5xiaHHwfYjDJYM3gD7sIz7m52GiF8N4ex7P?=
 =?us-ascii?Q?ArkhWXBD3RDK/fE5h79qqt5jgH6lTf05SM7GBYjqrWOKD6QwsfdXFo6jNwdF?=
 =?us-ascii?Q?OimWiNquGLbV/NpQqG4N6szX79aeCxnrMabYLg3M7fcnWZCihH7TcheUGdnA?=
 =?us-ascii?Q?gFqZFMI3KKJSaVdQ/jnbGsq7DZ910oORv50ArAhK7QkKkttRptQwUtHBsAFZ?=
 =?us-ascii?Q?Uyg5mBn1q5ofmXKGcmJmEIVVxHu/g8sjR7fw8sNpTWkQ/+oSspIeWNZ4SVbG?=
 =?us-ascii?Q?C54xf2iOYsZ9C6C0vSZm+3h2gyu0944zwwI1yo3meH/OR8vvuAMFBWDQyCjm?=
 =?us-ascii?Q?0FUIw/q+9UtbANASnV3lZu8Gn0axp4tYchv06yFB9Cb6xUrvcCaHaqp17/z4?=
 =?us-ascii?Q?99vGmPnqaOJux229AwQc7Yz1yTjIDDJdzYNwjGd5jCELrhCpnOcRBf2+n4Mf?=
 =?us-ascii?Q?TVkY/6IaXDGBwIIhsk0ytNTdV4Z0BUX4LCIUa/3tUh6KdYtTFEVAtJQ2tkRk?=
 =?us-ascii?Q?3P0HQkTBuPdjU3QsBv049NzXpmYu75BYfOibIBFJmiFi6Y8EYug6CNBAjMY3?=
 =?us-ascii?Q?VaOVo3OLoTyXPqV2Bn7Yg56YuAFJ916gD8rARnWB/i8QpiiQnGi2BOWbGOxm?=
 =?us-ascii?Q?741vyQValLkbOI2pjxziXCqjN7zrDZnnN4aismWFBi6rdpa0Jv5li1M1/lrZ?=
 =?us-ascii?Q?L37WOxBDPG/PsvWlS9uiPY6E92vwbTr8o37iVHAvLYEWhT988Hi4/9pTeLLQ?=
 =?us-ascii?Q?75qz5keZ7U32DAdW8Ee6RojZat/VhDzCA7nX6Q3dA4dkmdkx1tfNFAG37l0g?=
 =?us-ascii?Q?YT0pCf+RZMa9DCVGlgV4ZApl6DNBR0TiwpC1W4oKIf1temlhJMIXfHh01m5U?=
 =?us-ascii?Q?EOicnZ/mxGPByi9tLhjEqyUp5sbbAvkw4sDIzJVJpt4o95S5Bf6YzLq6qlgL?=
 =?us-ascii?Q?e8o72glAmfIifh4cMc+dtH+UsGnQl2hB89N3EArhfWYRsk1GPX/EPl286lP3?=
 =?us-ascii?Q?dre+ai6m3yWdNK0cUbqzkhUx/B1p+V/CA4nWA7HY2fhhrorsjEsLFko8bLt6?=
 =?us-ascii?Q?i1q7SiDD194X5b/QICvIFffWuym6h4dwYjvA8rHEpkXeFkvcznckVWAgHqWx?=
 =?us-ascii?Q?xHCsmjqtcvcV6lMIf2/+T/pqJyYa+3SpARpUOenJ55RiTPVc1+kpeWoRaM4u?=
 =?us-ascii?Q?QGRlwhF5CG/7o6ZRrBg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:13.1807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b43349-3062-4fa6-5a95-08de0a65dc10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649

These functions reset the kernel code back to the original form it was at
boot time.  Retpoline and alternative bytes were stored when those were
first patched on boot.  For returns, all returns are simply a jmp to
__x86_return_thunk so patch that in instead.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/alternative.h |  7 +++
 arch/x86/kernel/alternative.c      | 76 ++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 24a4afbf163b..936e555c13ce 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -97,6 +97,13 @@ extern int alternatives_patched;
 
 struct module;
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+extern void reset_retpolines(s32 *start, s32 *end, struct module *mod);
+extern void reset_returns(s32 *start, s32 *end, struct module *mod);
+extern void reset_alternatives(struct alt_instr *start, struct alt_instr *end,
+		struct module *mod);
+#endif
+
 struct alt_site {
 	u8 *pbytes;
 	u8 len;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 17b93763d1be..b67116ae883c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -3292,3 +3292,79 @@ void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, cons
 	smp_text_poke_batch_add(addr, opcode, len, emulate);
 	smp_text_poke_batch_finish();
 }
+
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+void reset_retpolines(s32 *start, s32 *end, struct module *mod)
+{
+	s32 *s;
+	u32 idx = 0;
+	struct retpoline_site *sites;
+
+	if (!mod)
+		sites = retpoline_sites;
+	else
+		sites = mod->arch.retpoline_sites;
+
+	if (WARN_ON(!sites))
+		return;
+
+	for (s = start; s < end; s++, idx++) {
+		void *addr = (void *)s + *s;
+
+		if (!should_patch(addr, mod))
+			continue;
+		/*
+		 * This indirect might have been removed due to a static call
+		 * transform.  If so, ignore it.
+		 */
+		if (*(u8 *)addr == INT3_INSN_OPCODE)
+			continue;
+
+		if (sites[idx].len)
+			text_poke_early(addr, sites[idx].bytes, sites[idx].len);
+	}
+}
+
+void reset_returns(s32 *start, s32 *end, struct module *mod)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+		u8 bytes[JMP32_INSN_SIZE];
+
+		if (!should_patch(addr, mod))
+			continue;
+
+		/* Generate jmp __x86_return_thunk */
+		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr,
+				&__x86_return_thunk, JMP32_INSN_SIZE);
+		text_poke_early(addr, bytes, JMP32_INSN_SIZE);
+	}
+}
+
+void reset_alternatives(struct alt_instr *start, struct alt_instr *end, struct module *mod)
+{
+	struct alt_instr *s;
+	u32 idx = 0;
+	struct alt_site *sites;
+
+	if (!mod)
+		sites = alt_sites;
+	else
+		sites = mod->arch.alt_sites;
+
+	if (WARN_ON(!sites))
+		return;
+
+	for (s = start; s < end; s++, idx++) {
+		u8 *addr = instr_va(s);
+
+		if (!should_patch(addr, mod))
+			continue;
+
+		if (sites[idx].len)
+			text_poke_early(addr, sites[idx].pbytes, sites[idx].len);
+	}
+}
+#endif
-- 
2.34.1


