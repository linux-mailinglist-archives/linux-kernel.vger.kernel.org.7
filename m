Return-Path: <linux-kernel+bounces-850752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ECBBD3ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBDF3E09B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DA430F542;
	Mon, 13 Oct 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pq7nfpT8"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47DF30E846
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366183; cv=fail; b=W9scXz8nylTqZGuoxsA3mbBpXGu5VR35DYSUALjKt2F4/8aZgXkJJK+v2h/rQtIhXO807jz3t6ooWIwA91to3XXPhVPsXqBEa6nqfdA1N9TFYaZ1ycuxpr3EoZzd/erMU4hL5ihzirHh8IVQldckHIcNRmO1hcECDGPzWtVJv48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366183; c=relaxed/simple;
	bh=Y81F7XvMlt6c0wi80cDCL67h7sIGkCJMKkd0KdJ8NR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsGKc0J09uytMgJqKg81+uR25UBfFQdGJiXE7gPztQFYk5ZQtUXHFfruIhETc+QSNtFFSaFvoxoGPVuO+utzLf+cQr03+ZwicKiUqHZEqQp1P9tWvFTI8PYHYsi5lGJmNM2o+bR+W47Ry4XLO6OdUmO8jqzAErJsgEVkaEhfEX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pq7nfpT8; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8NAfC7gDCKXq+Lhbj36qkQGCo67swKfiTR6bOwXXv+xVQ/HS7wZtyibHBMu1E/TnxEYUoA7EFtDmE9fNHMOntTH7cGMFRrxY9hsVTK2y4kdtzCA+P3oj0HoQQW6GLyaQqaY3IulQb7FHd22Euh6EIuBc+pIW6U5KyumI3okKkaSPoHEOlWHK/fUMLEcNe7Vh+L1f6ioNqyxMeZvbiNOiKoJCH7vVY5rr9GM7RN/ijXY4xqfHJs+KpsZLIcQVHpZ+SA/li7ukSM5WUSn5tKeBl8gntuTUwhrN7CoGoqQeVk61pMsfguVt/TntrH5V9hMVYpPL3TkzJLPhWENkuYoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD8uhnE4N1c/45RTWq74khoO1tVq7ck0N6McrHH1mrc=;
 b=dh1abao+IgL8g9vIFrQpbBjD+c45rkDk7713XyBbMBIpq/cB2+HC7pbPT4c5KpLClWoVMmKG9w6HTKG9+Ho114b70ROkMxwpv+xyNzR2MEBrpy3J6nDot1M+tcHI6UJjdYzazNvE+wxg6RjqlQ0OqF0VApvxgaE6svkusytQKv69r9XzITHJoYKDwbYnvFEnFTs5mafeZOvs3fXv4qLobvzXeFqqNmvRC+YSAPdKRpMzq+oF5bkwH/PBpqcFujaY0OqyVg8H4uLtTs4eOGMAQHs90JEhcZ8Gk+SHSm8RXOpIg5e8gBVR+L/m3DrJmg6Xl32Dqp426WXtMfVri0vlMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD8uhnE4N1c/45RTWq74khoO1tVq7ck0N6McrHH1mrc=;
 b=pq7nfpT80itfAoberAW3B4j55xMbSp7FrF0nlOCH2npZH6OE/mMB8NWH99ESGpLsWKHBfup46Zyk0h5inpXHKY+MqILiIoqGwRQnAubLt+VlUwUrb6ImjzanzSNpN3hkY0HfwnMugE0fAFeCvytgftFwosyfDkY7iEiJDMS64+4=
Received: from MW4PR04CA0085.namprd04.prod.outlook.com (2603:10b6:303:6b::30)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 14:36:18 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::1d) by MW4PR04CA0085.outlook.office365.com
 (2603:10b6:303:6b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 14:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
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
Subject: [RFC PATCH 43/56] module: Update alternatives
Date: Mon, 13 Oct 2025 09:34:31 -0500
Message-ID: <20251013143444.3999-44-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 3559a0dc-be2a-4c9c-994c-08de0a65df10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nAKBaRFKmR0UPTy2Uyerz2yZgau/3sAM3v93N6UKHGtq40tOqMCQYv15Cw0S?=
 =?us-ascii?Q?Gbxfr+TVq9vUoHHXdKyn2eQzrD++eitcNuU4uRP2cPafl1p444rFiuVvYQyy?=
 =?us-ascii?Q?sqdsQH+ZM3nFzYdfhqxF++Rqw4gQ4zF+ihqTVrZM4a9mrr+3R0Ni+AROASYR?=
 =?us-ascii?Q?UeBOY5819waSLDHs6yAMicFCdrb5433vhvWG63Ct83m4b8rFEwgxQ1dJzOXl?=
 =?us-ascii?Q?7GPW741mP6Pl5oz6now8f1Sq6PEdLshPlYnuv7zlhvOwAa6oeLxLdIQjjYRT?=
 =?us-ascii?Q?/HUc0RsmJDvuw3dm1luHEEwME47P+UMPSEksNJCGx5v8l8P8Vg1Z7WRd0ciC?=
 =?us-ascii?Q?PrVS32KDLmuTzLZOtLYzhaye/Q5kfWpVEiQ+xKJkNW5S87aqHXpoRWOeMGVj?=
 =?us-ascii?Q?23d/bd8PxQCBnxIz1rBbQPFgU9OZ7xzngS9ijJTk3qGjtNpThfexA7J1lzpb?=
 =?us-ascii?Q?xZyTH/MkwmvHE0i9h1vxsFmvP7Ob6bvpRjHUh6EZ+mGtMT2/ZbnaEIpAcEPv?=
 =?us-ascii?Q?/bOgQ9fSF6Buy5hieLAMMRdSOABv5OPQeEr/1gaPBwgrD6+gBEtXCMCrTRyD?=
 =?us-ascii?Q?gxQI36MCbJjoFzsiJKgT2em8lpeHwM65OkgmFF0LgXwswDYBHXkO/uUtdDHm?=
 =?us-ascii?Q?MFrpM3JPYGIEsI9YzvPL8uSDIHKKsLVCGL/iKUDv2d5zyfEZ0qjp0rtQGZf+?=
 =?us-ascii?Q?kzbbLzbkxkzjdChyHrfTmWvtYq8kW/JyrMctq34vIlRcyNUce7N6T8xHBZ8D?=
 =?us-ascii?Q?vmuuo9YVJjbQ265QLHWyORvZNab6JmZRPYD+Q5nm9ULr89PI/pzxx6yl3nrK?=
 =?us-ascii?Q?oeR8Usko0Sr06yu8vcZ6SpbaqxNQ3oUK50aAqhC3YRwCyxBcHKWRZFwowiRh?=
 =?us-ascii?Q?nxj33TwSdAMNRe2kH4ezU0T3KY3p9vaSf1e7Vt2Siw6pyNiKqg5iJeFGXtBA?=
 =?us-ascii?Q?frHHZY56p+jXlIdFDiyYCnDBuFN6bgh5+6UdqOKn+lxGWIvBSk70EOgBXBDj?=
 =?us-ascii?Q?9lon0qH6JKkIhEZQy9iPSxMq+cHeYb2LUhIhCGeHSooKf24NjB7abMZbWrVk?=
 =?us-ascii?Q?dKd4zGuV6TuPBTziKYVbEEtgbXBN6awmQ1UwdHfVReNZGJ75VqgjGpCvFnV6?=
 =?us-ascii?Q?QCp1CROMfuDo8vg6csKWLG4koKzpY9RefxJTTUs4htlAnpejhFEJnep1tV6i?=
 =?us-ascii?Q?5qhl2ILhtPK4B2xccGGUmzstiFSexvtyn6X8QOmexf+s7/r50092FqLqbvSO?=
 =?us-ascii?Q?J60PjOWTKqGHod2/jCzq2g2uabCtJwEY6J58oDNO80zZolK8BMN8l3EvPXfy?=
 =?us-ascii?Q?Ss+E+8X3unQq9jWbbWnEiK8EBczojMhYZOUKxPds+g9T9pq5+xbt+8qMf6zK?=
 =?us-ascii?Q?6oEP5mrkMKQp06Ky0B5B1B9n57jD/r3yWtYZ2UedsNz1i1+53sFEerp16Wdd?=
 =?us-ascii?Q?skUxNPyaKfLLSfbFNzMCaQhC5Ca4tmLNBolt3yR6ekiGIbc/GMtG6ywUhXFm?=
 =?us-ascii?Q?+hERlymoDw1Ld1Ou5JEPyFBlp3fNgjS7Lrt+6gre2VsGEoyyc9G78oc1+JQA?=
 =?us-ascii?Q?c1Nm3q8peZzSf2vI2DY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:18.2171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3559a0dc-be2a-4c9c-994c-08de0a65df10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

Update alternatives in modules by making the module text writeable and
then calling the arch-specific update alternatives function.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 include/linux/module.h |  6 ++++++
 kernel/module/main.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 2d8c34cb961f..f29974cae6bc 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -1023,6 +1023,12 @@ DEFINE_FREE(module_put, struct module *, if (_T) module_put(_T))
 #ifdef CONFIG_DYNAMIC_MITIGATIONS
 void modules_prepare_repatch(void);
 void modules_post_repatch(void);
+void modules_update_alternatives(void);
+void arch_module_update_alternatives(struct module *mod);
+void arch_module_pre_update_alternatives(struct module *mod);
+void arch_module_post_update_alternatives(struct module *mod);
+void modules_pre_update_alternatives(void);
+void modules_post_update_alternatives(void);
 #endif
 
 #endif /* _LINUX_MODULE_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 0525b1c6d5b9..fa46ce4285dd 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3943,4 +3943,46 @@ void modules_post_repatch(void)
 		change_mod_mem_perm(mod, MOD_TEXT, false);
 	}
 }
+
+void __weak arch_module_update_alternatives(struct module *mod)
+{
+}
+
+void modules_update_alternatives(void)
+{
+	struct module *mod;
+
+	list_for_each_entry(mod, &modules, list) {
+		arch_module_update_alternatives(mod);
+		update_all_static_calls(mod->static_call_sites,
+					mod->static_call_sites +
+					mod->num_static_call_sites, mod);
+	}
+}
+
+void __weak arch_module_pre_update_alternatives(struct module *mod)
+{
+}
+
+void __weak arch_module_post_update_alternatives(struct module *mod)
+{
+}
+
+void modules_pre_update_alternatives(void)
+{
+	struct module *mod;
+
+	list_for_each_entry(mod, &modules, list) {
+		arch_module_pre_update_alternatives(mod);
+	}
+}
+
+void modules_post_update_alternatives(void)
+{
+	struct module *mod;
+
+	list_for_each_entry(mod, &modules, list) {
+		arch_module_post_update_alternatives(mod);
+	}
+}
 #endif
-- 
2.34.1


