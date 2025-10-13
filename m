Return-Path: <linux-kernel+bounces-850753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16014BD3A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69B494F748C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68AE30F54D;
	Mon, 13 Oct 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YNgeoPhm"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039EF30EF65
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366184; cv=fail; b=XuPsbui0plUHwod791GP3N3V9Bh46tiH4pknH2qJyN2d9Wfltd7eGOepa+PpKsa+iyu6YTM1JSxhQBKD3rnLvdQx0hzVBA+24nCdcfkihXWYqjOW2gkT0YMXOh78q1qTj0Lxb0hLPWBbOqIa96EblwqMjdulfRVKrE0F54G1LdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366184; c=relaxed/simple;
	bh=BsYXgzoT9kMLwt0syG8lPLIpPqmm+dmshKByzE7bAu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tey9iinJXhv74rFvBjlrETVmNsDQqB5qvHZfSupTlNp3BJwE+6PoH6kzg+MOPi4NlK5JNx7vF0PtNjOoTCEqSTQ5wLj1Eg16hvDQPe+oXOxfaUX7RlW+i4CvgNVQRHEMP6d5PiYFlUsWGpFIv9Zt3w4GXpzZfWCTTu1QsO4WZ4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YNgeoPhm; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOq2rmu9noEGcmE8RD2DCBsH32iLRZkZB5O8lAi3pINUpGKaYvpnL3kwF0BJFsMMlaF8QoeuJwI9YuTF7KJR3yL7EL0Y8Yo3Mak07qYr1czBp0S1J/ZD6gt5V2h7ipBTiveL3RAPc7AmTvBycn7CPJqDZv6L1UeMSM/FsKqJOUw584ZSbJV0kUmAstKPxd5epDEMS458/RkLhzpQpV0nl00zMvwniAJvukTkujT4WA62T5zo0JDsNPRr1+Wmngsmr1UDghJZ9hyIGKqY3Oa4cdP9hjS9/HC/NVZpaUdKUInEku9du5XkUopks930MLGcTMZwewl0iETseOEZsKEqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvvW6BuAyyXQMi3vRCpchFRtYzlxEL1qOFXQj7byGU8=;
 b=Wqjj9zY4TavletzjD9fXd3UNkO06CdXd0rn2iawMDKWvkhIzXEW4r0zcd1ScMvKjIRGPo6lDxAg9Bzwjk8kT3VNFvugxn8RyIVjAdM6IADDQvwImk7pwhWeKAVjsc8fWfioitD2p1/lEkBwfKeSG5iZI8ikQeh3wUJ8cEtMFPOzYcC0qBOyyBR84fNcLpovFTG5ovYPa221++RlDm1cgcHgMidyyifCaFuk2fCMu97hvf3+ChErk+bwNNV5zvPmGVXySJOPiKxthwBVf/EkEQFUf+wYOJTP4lClM14wl7TvYiZxbTpI2S+vkv//vVfFEjMNCjvGrstDhZEQFbs2qPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvvW6BuAyyXQMi3vRCpchFRtYzlxEL1qOFXQj7byGU8=;
 b=YNgeoPhmkMzMKs+Uo3acjQBrQDW1gfawXgPuNRx27LQhU11PVh1e5EQKm/mAEZGshqj0HAGgGz/y1kyAPS1bzcX083fmeSX7aaud57xkgULwxw+yL9KLJQ5E7TTaZ3w8O53GiIhn4nAD/HtjxyADiGdNkUeGqZnjlndI9ORM3MU=
Received: from BYAPR07CA0042.namprd07.prod.outlook.com (2603:10b6:a03:60::19)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 14:36:18 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::6d) by BYAPR07CA0042.outlook.office365.com
 (2603:10b6:a03:60::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:18 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:50 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 44/56] x86/module: Update alternatives
Date: Mon, 13 Oct 2025 09:34:32 -0500
Message-ID: <20251013143444.3999-45-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: e2af1c50-fda7-487c-4823-08de0a65df45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ioRl8FGlXQjDAtzqZIoJi09wah4vpZogduT17XW6WCBRfPU+u4GhaBtDeGb1?=
 =?us-ascii?Q?FTtp3FA3dwiiP2nBZd/x9eg8vecmDjYIMNveyosQxnZc6zy5fMhAh7W0jdO3?=
 =?us-ascii?Q?CQnT15J22OSo4dxfpdTanXA56ZnMNGRWIbfZ9C5Qhk8kNpm8LjAHCEqRwqQl?=
 =?us-ascii?Q?qEAY1BoJoIOK85Wp96kRT4LngH0dodr6Xp44tosRlRBg6F1eNksncPzUvJw6?=
 =?us-ascii?Q?DxZSeRv81zCZiFWifRDMkGN+CDxPNrXiRp7WdVdvNSgv3QRRtZ1DCC8Pk14Y?=
 =?us-ascii?Q?OrhIJiZUC5clZYbhoqDGgWV5TSi+x7WRfchYqxDkO9pmzWBRd8wYBb91kEiZ?=
 =?us-ascii?Q?+0kJwzmnN5vNr9Nf5y3iQe9yE/BwTRf55YSWzm+R5xrM6cIuWJH4eWk8TNCG?=
 =?us-ascii?Q?9ndNdOgmj0+7llW91WnQXs5TPpl5EnuE3rRU9Wl92GLCeZ9PYUkuGJYzc7Ic?=
 =?us-ascii?Q?BexYVrzUn0zdUJ1ShyA5OCCM/mMo2N5XnOLfjNdbZ/TPh+C5/PdwtRiMbnKO?=
 =?us-ascii?Q?y/QzX++eiqZqRsLJumbYah/FDfg/+WVjhuhty2tzoYQrEUNGKyci+f0N5PTB?=
 =?us-ascii?Q?V7VtQ7qu9DE+wP/ivVLOmTC1AJyPkv+nYz2t4TuM2OH3+190P2YSVuADSN8T?=
 =?us-ascii?Q?/bw1pFK+Mewuu84c0cHDPLcHTsIedMeZSu4S2KDNMylwvL6uvGh1Rxo0Kfgi?=
 =?us-ascii?Q?xTJ+HrSg/YLmRxtwIiy90QfgBzx5np/7bJYHrYuROSLHNjjXiGebD05FnR+i?=
 =?us-ascii?Q?txLrIk9zxFBmjQXC5r5aUqhjDLscYOoUe2YkEE5q6YwHMs4jrEObqP2qq+mI?=
 =?us-ascii?Q?wBgle/8S4/e7D1+Rt7Nz3XtAspsYegYkybAY1N6/ILdrHJ5a6ceiZMyFJkKG?=
 =?us-ascii?Q?WoZvyWS5yAukhnqNs8oVlzViJY0PvQcMsAsSvirrYeL0znIfE67JHaTYV/1o?=
 =?us-ascii?Q?khY20dg8w/v9T+y0mZtyerEq8cBsD8DEIsVn9N3SMX4x0Y4fL9StW5zy3Guh?=
 =?us-ascii?Q?hBEN+iJgaPkcNocP9KzlRKXHHI0nIkupxTzspTZEpEArO6CGKeurvYQ0jg2D?=
 =?us-ascii?Q?jS5YSXegaqkPyzYhJLBUV/ZgHSWmhFF3ObUkGXj6Wtq7GlqWFEGuxqt/UN54?=
 =?us-ascii?Q?Oj0YhEZECby5mlMv6HoChPprNY6zkJUKxQT6Q8G6LhFv9s3YK6sVXlxtQEBQ?=
 =?us-ascii?Q?IB4RpxP/V3K7PvblnS2AdMMsLIqcClBzBcTd2o85bJl24qH/G1W7J+bECQFB?=
 =?us-ascii?Q?Xl/DpEU39roWaLoti2CnIPy54w0gW3Igo5mTR/m9T3VuOxBTunrvY/NVgUJI?=
 =?us-ascii?Q?d2xjRkeWaY/30x66Xmed6JSKrecSC/FKIDbqV1JDFFi8nsBLBv3p1sa6tgGw?=
 =?us-ascii?Q?GHvX/9OvxE/bZ6Mr7mGJ7Zli1L5LRIoDHZX+vOkDJhCL3e6DR2rcRNhNn8iG?=
 =?us-ascii?Q?8VHPl177RRZyiUtnXQTFIBmjlwUy8A6iL9CV45qxkfgB0GHpyTFyhIP0GYRv?=
 =?us-ascii?Q?SRyBLjYTa5eDKNAKgDjX1nMjEnHVC83PZVLeijJ3Z7hPDpEAHrFUregCh5c9?=
 =?us-ascii?Q?iWBJEm6dTyTz/G6m0JA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:18.5605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2af1c50-fda7-487c-4823-08de0a65df45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433

Support resetting and re-configuring retpolines, returns, callthunks,
and alternatives for modules.  The ELF information is kept from when the
module was first loaded.  Static calls are non-arch specific and handled
in the generic module code.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/module.h |  4 +++
 arch/x86/kernel/module.c      | 58 +++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index 58d7f1017a14..f72359b5120d 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -27,4 +27,8 @@ struct mod_arch_specific {
 #endif
 };
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+void arch_module_update_alternatives(struct module *mod);
+#endif
+
 #endif /* _ASM_X86_MODULE_H */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 0765d2360a33..b6beb2b3469c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -333,3 +333,61 @@ void module_arch_cleanup(struct module *mod)
 	alternatives_smp_module_del(mod);
 	its_free_mod(mod);
 }
+
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+void arch_module_update_alternatives(struct module *mod)
+{
+	const Elf_Ehdr *hdr;
+	const Elf_Shdr *sechdrs;
+	const Elf_Shdr *s, *alt = NULL, *retpolines = NULL, *returns = NULL, *calls = NULL;
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
+		if (!strcmp(".altinstructions", secstrings + s->sh_name))
+			alt = s;
+		if (!strcmp(".retpoline_sites", secstrings + s->sh_name))
+			retpolines = s;
+		if (!strcmp(".return_sites", secstrings + s->sh_name))
+			returns = s;
+		if (!strcmp(".call_sites", secstrings + s->sh_name))
+			calls = s;
+	}
+
+	if (retpolines) {
+		void *rseg = (void *)retpolines->sh_addr;
+
+		reset_retpolines(rseg, rseg + retpolines->sh_size, mod);
+		apply_retpolines(rseg, rseg + retpolines->sh_size, mod);
+	}
+	if (returns) {
+		void *rseg = (void *)returns->sh_addr;
+
+		reset_returns(rseg, rseg + returns->sh_size, mod);
+		apply_returns(rseg, rseg + returns->sh_size, mod);
+	}
+	if (calls) {
+		struct callthunk_sites cs = {};
+
+		cs.call_start = (void *)calls->sh_addr;
+		cs.call_end = (void *)calls->sh_addr + calls->sh_size;
+
+		reset_module_callthunks(&cs, mod);
+		callthunks_patch_module_calls(&cs, mod);
+	}
+	if (alt) {
+		void *aseg = (void *)alt->sh_addr;
+
+		reset_alternatives(aseg, aseg + alt->sh_size, mod);
+		apply_alternatives(aseg, aseg + alt->sh_size, mod);
+	}
+}
+#endif
-- 
2.34.1


