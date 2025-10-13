Return-Path: <linux-kernel+bounces-850744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1103BD3A89
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7F63E80A9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295930DD3A;
	Mon, 13 Oct 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Df/M2Krf"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530430DEC5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366167; cv=fail; b=fWaioqQ04mNZPsf6FPs5tusl8uVoljiuYX+07HumGhJ0s0wDXswWMWqj7yMclvDUw0XJesDIqpahp3TP3VlAtQz2k3Shp/PIB8ySifMfrdbHyxceY8bvBZ9eY3DK754uXI+dO3lEcpdrVW4lptVaOg7pQw22IpUmb4aGv6MLuy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366167; c=relaxed/simple;
	bh=jUSloZLljdx9a9AljgG6stR6EyE1Wd9P3uvhd3gtOXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNhXzjsopY0LWGZg5qSWka+4joIq3Lgs3M0KAvEoS2v2Ri62klDc2BuLF6z9BfavZamcYn61TtJxr1e7UdsDm0MfUWKJSLC0vVpvuD1P4phcs0jvzTDHBjqN2zvVhPu6KPGuQUOjttKWkR3H59bNus/o8k86Dax3QMRPAEkKicI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Df/M2Krf; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9jwODXrA0EugB3rwDX8er1K37vqHg7MXnrwb3iuku3OT8pbaeX6yBHQaWDYJTydia6JnVaLhb2j6Aho6hQWV2bPH5tbmeFEJWIDfthZaU/wtIpvHW+KTK9g8zPCMdRR5KjYqyj9CMdCRsaB1bQyJD7fAb8LBq+jk3didOZ6Qju19t0ScCSqLebputRGZ1EaqZmEp5wOfZgO7mhWSTc9D+Qd72J84rkg5w0fyOUZ6PawHAO+egwP3YfAd19a5URI82mK7pVMPQduCa0cN9pP9JuvUUUo7pRM5vA16/q4kZzMsEB+/IWysDROzFynmIgwtRVkxEllwOeTlgpmcpEgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOpK0j0IQAwxerGIoz+Xhr564JYPOMyvCEw9lfo8e6I=;
 b=dpYSoMAONwDmYA7ZlCIxNCRgypV9tGxUuAS2JD62Q1OuPQZNdIFiZ4MXywgeI8qTkhyf+yhbVdsJgRmEuAn3fMft0T29E+trj8Ai/hy3j/wbCrleyFqwpFAU9dcPpl7QDWmcojSWhkaNci8Mk7T1i6874tdPye2n6ha4ttY5bdRe/3CFPzocxKHp5XuLQFZUo4f8h1z9xVsrJZCE17LmFI4b7yM+d0Aa+YxFaOIirZZ7asSNFmPavx6PWX8Sas6oaevRbkheUYXKiTrJSjZ0ckSQv6Fs7bQ3JWOqapABzhAaRes26j3ioaDHsoSSAOLBH43tmjw7ZIBDhOJoVJrt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOpK0j0IQAwxerGIoz+Xhr564JYPOMyvCEw9lfo8e6I=;
 b=Df/M2KrfRZPYKY0KrnoXJN2ioQknjvsmCXXcowhuJlubXgHgNSJl5mICwLTH6TJziRhDRFUJXrVLHtt5QAk1cKrd/tpkxt/HtHcs/Oer1j1v7Zp/wBaPqg08RMn3ROUKhiaq5BXAtSpXJxUqpQvT43cj+ogi13xrqQt9fjIUagg=
Received: from MW4PR04CA0110.namprd04.prod.outlook.com (2603:10b6:303:83::25)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 14:35:58 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::31) by MW4PR04CA0110.outlook.office365.com
 (2603:10b6:303:83::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 14:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:58 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:43 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 35/56] x86/alternative: Save old bytes for retpolines
Date: Mon, 13 Oct 2025 09:34:23 -0500
Message-ID: <20251013143444.3999-36-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: a69d1c32-f999-41f1-5523-08de0a65d346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eadxEHpR5xVyJXNxnOqXgDthGi05vYPUtzDNBuXj8QY+dztqsjSUWfZ+YpbG?=
 =?us-ascii?Q?vYRG3XaFJ2qcwjn0DP+sRox30+E79dloBSQlkm7gSlQLH75CZsMhSJ34uFAj?=
 =?us-ascii?Q?9GLeQ274aJAXi391aGz8TewxAOSdQkpMk3mk8zM3xOTHQMEUvn7qwh/9d+tR?=
 =?us-ascii?Q?UEwOWDAP0v1GqMhXICnfeBI6hE6yFjX76s/gAGa6sJ8ZIbwRGhxwMv6klQS5?=
 =?us-ascii?Q?jslg2x/TjMZHXxhezRf5zxBjGg5nhNtYfSSs6QntMqMkH6MhcjwVlLuzA4a8?=
 =?us-ascii?Q?HUZmVmy3SXD5dBSMkfIjEtEbAJN/MiR/vz8iJR4WMUQsAlf4vkMdSCP9RG7T?=
 =?us-ascii?Q?k9DG5UyINE5BTJ2y6Dak7t9s2wuBZ/0xxLfDpFiqHyVke2/tHzsxw7JCjX+Z?=
 =?us-ascii?Q?TLgetdDzOYXdjLqh5ns4Y79GNXCxypbMXEt7iCQMW1hIdf1XB63A+ov4F5AS?=
 =?us-ascii?Q?8ZaJp6PEH4tdmAu+yudfy0p2uLX2pdM+Nvs9Ezd1xl/ARMIYtOZKfkNhpHg/?=
 =?us-ascii?Q?0delhzR6MNTp2auLoqDxzE8hokzJRSOrJ8FWwMpiSMM5ffPhdZ47lWXU6+II?=
 =?us-ascii?Q?gyFICaRm68QktpQfCg9cticMzHYtuGM+5rmW1nQXRholo7XHOwbOqdBn7vxo?=
 =?us-ascii?Q?17bpU3wgJ8xxX2W0ia+G5l5WsxkPmslO4oKMYUziemtpuwEQCBGQSt3YSGnb?=
 =?us-ascii?Q?+sViR87UJNUdF8UlZcF9n/3XVcOy3iIML5V0Dxj6/54zpj4wNYdqwLK2i/wm?=
 =?us-ascii?Q?gUcxUWXMjBIRyHJGmqS/C7QoSyb75eF0KKHpt7SlVzohXA7yzVF/B3WFLfOT?=
 =?us-ascii?Q?BVgP7lGDWfQ88RS07rn0ztzVr1fzvqQAcBsPuC1TWdRTjGW3MfsHsFFgmE+/?=
 =?us-ascii?Q?vYlQyA2a1fdb5jd0bLCHmMg9s8wq0gsjxz+yLrdUqancIJC10lBQoiFBvvee?=
 =?us-ascii?Q?e8fNg1MzDLgkFqvpR3RJNk4LdxrEBQWOtzMqjqq8nDExaWeB5g82kA78inBW?=
 =?us-ascii?Q?LidARy/bTsG0Ca5VxVLye+aDx1ByMjm5/0Usfimq7PCMqYb+6N6u68phzw82?=
 =?us-ascii?Q?GKvjQZXxXgN+Y8tfwJiI0az18PPdO76OvKmv6ofNpTL6yOxC1W7C10/qLHp+?=
 =?us-ascii?Q?MZaAoi8ajr+EpKEX9u65uFijgU5vRwO5U7K+V5y19IGVsTA9/4PAI1mcVVPf?=
 =?us-ascii?Q?ByWQWc4CkJK/0BwSt3x5dPA7nxF/2pyRRvjJ9j3Z13Ah6mve1In3uIQdgbOn?=
 =?us-ascii?Q?vhShz2ncJBIzM1gaQilvkQOQF+UpJ18E8t7AwZe1ScuhqOhoRFhzz2G+kJPH?=
 =?us-ascii?Q?Pu6UXqZxBLyJpCiBlPfVltCjCMp4Ax3eMsCZaOXOFR5m/JNhL9g+fIAU+GEw?=
 =?us-ascii?Q?euJ8HumMTLLNQpC/+8lNAi11g9jGc86NiBDesQXTy85Iz7gPv5XxSxTHGrty?=
 =?us-ascii?Q?WPSxDKAXKOGsq2ZOKb+3yj8y5nkRC7XzJ7vpLoBRhGuI66sMfDYyqkO/pMHE?=
 =?us-ascii?Q?TjYrPWclL3kmqoTNQTPsR9fJ7smy+cWgNw+PXujnkUItjnd1p3XhgS4QF6Pw?=
 =?us-ascii?Q?yt0cSWRLFoOq/5BjzyY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:58.4351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a69d1c32-f999-41f1-5523-08de0a65d346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271

Similar to alternatives, save the original bytes when patching retpolines
the first time.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/alternative.h |  5 ++++
 arch/x86/include/asm/module.h      |  2 ++
 arch/x86/kernel/alternative.c      | 37 +++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 3ee781d61927..24a4afbf163b 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -102,6 +102,11 @@ struct alt_site {
 	u8 len;
 };
 
+struct retpoline_site {
+	u8 bytes[6];
+	u8 len;
+} __packed;
+
 extern void alternative_instructions(void);
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
 		struct module *mod);
diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index 2bb602f99154..d0c39b921408 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -21,6 +21,8 @@ struct mod_arch_specific {
 	struct its_array its_pages;
 #ifdef CONFIG_DYNAMIC_MITIGATIONS
 	struct alt_site *alt_sites;
+	struct retpoline_site *retpoline_sites;
+	int num_retpoline_sites;
 #endif
 };
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8037076e9301..a02dc6bfb696 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -302,6 +302,8 @@ static bool __maybe_unused repatch_in_progress;
 
 #ifdef CONFIG_DYNAMIC_MITIGATIONS
 static struct alt_site *alt_sites;
+static struct retpoline_site *retpoline_sites;
+static int num_retpoline_sites;
 
 /* Do not patch __init text addresses when repatching */
 static bool should_patch(void *addr, struct module *mod)
@@ -1036,8 +1038,36 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 void __init_or_module noinline apply_retpolines(s32 *start, s32 *end, struct module *mod)
 {
 	s32 *s;
+	u32 idx = 0;
+	struct retpoline_site *save_site = NULL;
 
-	for (s = start; s < end; s++) {
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+	u32 size = ((u64)end - (u64)start)/4;
+
+	/* ITS code needs the save_site pointer even on re-patch. */
+	if (!mod) {
+		if (!retpoline_sites) {
+			retpoline_sites = kcalloc(size,	sizeof(struct retpoline_site), GFP_KERNEL);
+			if (WARN_ON(!retpoline_sites))
+				return;
+		}
+
+		save_site = retpoline_sites;
+		num_retpoline_sites = size;
+	} else {
+		if (!mod->arch.retpoline_sites) {
+			mod->arch.retpoline_sites = kcalloc(size, sizeof(struct retpoline_site),
+							    GFP_KERNEL);
+			if (WARN_ON(!mod->arch.retpoline_sites))
+				return;
+		}
+
+		save_site = mod->arch.retpoline_sites;
+		mod->arch.num_retpoline_sites = size;
+	}
+#endif
+
+	for (s = start; s < end; s++, idx++) {
 		void *addr = (void *)s + *s;
 		struct insn insn;
 		int len, ret;
@@ -1085,6 +1115,11 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end, struct mod
 			addr, addr, insn.length,
 			addr + insn.length + insn.immediate.value);
 
+		if (IS_ENABLED(CONFIG_DYNAMIC_MITIGATIONS) && save_site) {
+			save_site[idx].len = insn.length;
+			memcpy(save_site[idx].bytes, addr, insn.length);
+		}
+
 		len = patch_retpoline(addr, &insn, bytes);
 		if (len == insn.length) {
 			optimize_nops(addr, bytes, len);
-- 
2.34.1


