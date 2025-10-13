Return-Path: <linux-kernel+bounces-850754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E479EBD3AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71348401194
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9114730F547;
	Mon, 13 Oct 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LRILoqdf"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B230EF6B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366185; cv=fail; b=WpGATwoFX0sNY+qH4qg3KzYnvVbplC5tXNsxEtgWrZR4pgCDmdMapypeTFLgwn+QorYBdvZwetlkMyl3HqhZXhqivKczb4umJJEj/5cQfqLdtStQUaZHACu9AlC3kxzLlmAZOETgz5Klr1L/uwKj6NTIQBccuGhm8Ys1BugzYlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366185; c=relaxed/simple;
	bh=GQs6Ai0LHBFzWVDbKMDCkjh8uWrqssfJL1guRval7h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Msv5XxHzzAsH/o5OIKPuY22tLQrJoohhOjX8KOraio5IlEx3E/4MSsYFWWhJOscym+eSonKsi1T5aCvEcW7P+1FMhsEZJtq/TQ9miidhsyMkpx7ytja78EEE6Kz0vpHoO3ZEXCYqlX2rNgghL0DDX2rCAf4NWLvRdNhc2ihTr7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LRILoqdf; arc=fail smtp.client-ip=40.93.195.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eH6mqdAp1o5v18YC3mETqqXKklJ6iHawQ61jO/CHcnAtijFkPhGVkU3+lXAdSWGGroasOVmIpd9nQ9KlkpvmFHFv6XJyxAtxF2PoZOOqipSljn7dbx+IOSHiL7bGFqMxqJvlzVtqSc8YrIK33d0E8KKjnoCwgRObbGrcHMJ/xsEQhnqdp/i+3H7+2a9/6pwIAObwDIKwAskAV0x4WoEMRl4HFtjPjiSp36qwXNBB3Nj/NpBOVKI8NuOsZLSVM8AzLapvxoG5zRGGAskeleR9lADjyecRpntVyvNZoxrW7mJcMXiAZuQlAhFr1uuaHGyMSEErSXgCV5J9G/MiW5QH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bifw/FEkQL6wf/oTu+gbwZRXvA3PMjzYA1bQy+884Lo=;
 b=oF3E+Y9h/YzJTRF7OrHUP4tTIPxPYh2S4iUygCwllzRN/iX9ObDGizddIuYsVsb2Zp/rdCLbtIDSWO8DiPddOPap+eKyCzoVNDjmOKjun2KeVB3a6w/Zn2BeovTiKyq+JLcX6yOtK2+KJLXDkoK4fbp6DX0rIw5PqSbXpDaLKNxPfTd1bv+FZGgFQhdQ7fsN4PHbLSilh1nmWTtjvceLntmRvp2I53izIcFeD5qIw0AvUR8xH1Fcq5W8HatGHe/hcX53YIH2ToH0MdY1Wp7UmTgbELcyolFKmOuEpvzULC6wdwl7okiTT87KloxdjlEVowHDaoe6jAMs50ZnEPeagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bifw/FEkQL6wf/oTu+gbwZRXvA3PMjzYA1bQy+884Lo=;
 b=LRILoqdf8nGlp7psprPAZMNYlcLiY2Tf+tuSCUIhZUVcsJHK945HNKrC2tlg3Y4ctKxE3pAIz3TAb83GjwXIFLcYrczuiCHVh2/SPzzLtOL1XWiPiLchg3Oph0siff0ufEJ+iS7MJyr4HSeKYM8RdNKxNyy5GUoUv1C0ji1KlUc=
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:36:20 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::1) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:20 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:53 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 47/56] x86/module: Add ITS re-patch support for modules
Date: Mon, 13 Oct 2025 09:34:35 -0500
Message-ID: <20251013143444.3999-48-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ea90a2-c58c-4d9e-68bc-08de0a65e036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SN/SZFMCgVL9dxIRhE9oOqeVRpR28ade55jDZXyCYaEkVlqMhYdHnxRxnIcJ?=
 =?us-ascii?Q?Nz78H4drVNnk0knRZujvzGmJzj9cbxLue4g57OO9TweQkfkd0EpSGqE/c+sg?=
 =?us-ascii?Q?kPBJAtcrFhegkE78ClDFV5rPLJ6BfvQMpPTZRgM5KZ/ZvelPjLxHgnUMxebF?=
 =?us-ascii?Q?430cHcVatcOk7H9Tb4vtAbvKKEJDoB8IhTeOsPtsYB5Wgi5pXsloRgrHP+2m?=
 =?us-ascii?Q?NhNjlvkbbjAjfZbkXCtVKrOShKeqHRlhsACwFaXB/x7kKsR3rhVVDlLN/cIt?=
 =?us-ascii?Q?4c8HKVt7PU9mbZ5W4bVjQngIqns/ms3uf+lIjvQY8KbKMlvUCvFHLb5ydqBv?=
 =?us-ascii?Q?3ECqH2QxSlfnY1BLMjrcnTx3qPsmssVddYGGGIRtPvsHEs8aMdrSaONO0d7q?=
 =?us-ascii?Q?VAJMaDro0cK/qz0hfhIT0CFMTOii1tel1dBOBXZ7232n2mWGFPlfbTCAUIS5?=
 =?us-ascii?Q?A6av9u8LmzmfgXQTZVilA3mOK5S4pi3g24TGaFxVOdQfjxXxxmh4q/qCMhlQ?=
 =?us-ascii?Q?P2D/9yYZz1NcQlydASo3wB5sYTYS6sUqlxd9eAwhpnZTuKGTQgmevh2Vw2u9?=
 =?us-ascii?Q?lKTOoPHLAfM2irnacfbRpGwlzoK6rvcEsMGL5yCodsyl6Dj10anXajbBTlKN?=
 =?us-ascii?Q?JJ+bv+9qMMN8ofRaUouANOpuYOClYBIwG3sYKkfCOHrhTMjTNhqz0cqWm50g?=
 =?us-ascii?Q?rg4oNOqJfe/wCAFnfLONLe7G05OgadkrZ0g5j380dJV1FwqVZ6aY3QGFHwC5?=
 =?us-ascii?Q?s1rpDKY+PaSx+QrAc1AnldwwsabNLxq8lduoRLmheIq1k4oOW90ciHXUZHpI?=
 =?us-ascii?Q?9Vtk0ZxDxg2Q0IL7i6ZFTVwgegXa/1+E2SET5NxHQxQQS23icJn3LV2qLGM9?=
 =?us-ascii?Q?QLxXj6e9WL7y3189ztlhbt8VpLe+akDUwPFodYB1QsT9c5crz3WjduC23AeV?=
 =?us-ascii?Q?gFjpk85Setj2f7FPKhHWsnGFHs0i5f2MBfqyBEBpr3eb3UtCTdX7nAxhK21U?=
 =?us-ascii?Q?UIUfo+4HV1O+Ex0t6Tas/EpvZ+UhXE43MLa2cTgIYnDY/9izqWYBUCWlJ2cO?=
 =?us-ascii?Q?fqpvYWrKjZQxNKmEgrbIM9eQaw9T+EwWtsQwDRVuvkmjiBFeWnMrmb+P3JLP?=
 =?us-ascii?Q?NObEptRB/eZZlU3PlvfqwOR+khdJTd1BJSYwwqm6cw7hYUaBLPfCfan2moyt?=
 =?us-ascii?Q?84d3DbnC1itx6/xEGVLPo+R3cZR6COYkw5Slz519WoplwfFxRID5pVa87hbF?=
 =?us-ascii?Q?yd1XDtpzgGdPKHWs1BYcdSLNGI5X5LVRB3+Qk9V8c7uN2pHeE9YV968oLa3/?=
 =?us-ascii?Q?8hLPWS9AeaPNbZWM5VaK9BSrNZUUOZLPo2/pDHLj9GpKTdO64sdTpS3iC3Nh?=
 =?us-ascii?Q?KQjpZK57EVRGitzGEU1d61wNe3nlR3TvotKnBKz/XQxOmxh2t9KQwyM9G6wR?=
 =?us-ascii?Q?hMeEC4dyPFyvDKFDcTIIohU8loXYmLawerGd8wK5N5MG/2GJa+ClKUCK7FJJ?=
 =?us-ascii?Q?4v+k8M2nfQ3fdDo8tX1+eohSlVL+eZSsnhbiz+c8p311sj+DQEU59VKvWwo+?=
 =?us-ascii?Q?G64CrXQ5q7C5c5Rv+TQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:20.1408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ea90a2-c58c-4d9e-68bc-08de0a65e036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168

When re-patching modules, call the appropriate functions related to ITS
mitigation support.

The ITS mitigation is unique because it requires memory operations that are
not possible under NMI context.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/module.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b6beb2b3469c..12a934755097 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -390,4 +390,36 @@ void arch_module_update_alternatives(struct module *mod)
 		apply_alternatives(aseg, aseg + alt->sh_size, mod);
 	}
 }
+
+void arch_module_pre_update_alternatives(struct module *mod)
+{
+	const Elf_Ehdr *hdr;
+	const Elf_Shdr *sechdrs;
+	const Elf_Shdr *s;
+	char *secstrings;
+
+	if (!mod->klp_info) {
+		pr_warn("No module livepatch info, unable to update alternatives\n");
+		return;
+	}
+
+	hdr = &mod->klp_info->hdr;
+	sechdrs = mod->klp_info->sechdrs;
+	secstrings = mod->klp_info->secstrings;
+
+	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
+		if (!strcmp(".retpoline_sites", secstrings + s->sh_name)) {
+			void *rseg = (void *)s->sh_addr;
+
+			its_init_mod(mod);
+			its_prealloc(rseg, rseg + s->sh_size, mod);
+			its_fini_mod(mod);
+		}
+	}
+}
+
+void arch_module_post_update_alternatives(struct module *mod)
+{
+	its_free_all(mod);
+}
 #endif
-- 
2.34.1


