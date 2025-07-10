Return-Path: <linux-kernel+bounces-726219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B722BB009B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389851BC7EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357432F0C6D;
	Thu, 10 Jul 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="whZMpKOh"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EC72741D3;
	Thu, 10 Jul 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167815; cv=fail; b=DgYyw2dSgEi+6eMq4WRESq1Uy0VRfTKeZD2r8LYV2/TcrHwkSlEK50P7/JazPyu0MJe7N+e+zLexaQczGqGW+YRZfFrup1+/yq5aRjDhFP/35/vp/5icJhVm3qxDvzuM3diV2NaaztGGbP1LuTuPR/jmk9YUcVlQo2i+KiCMey8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167815; c=relaxed/simple;
	bh=YddKltoFt7FVA79q5akDasErb+YWdf+quOvJ6Oc7gto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clpNNSYn5c9owhUgLn1MAWgo1x93HgK8tTI2tmcO4y4TSiKKmy+S2IMqE+ufGtOUn9cPjKfA6uk89ogt/LghAlQZhemImp2QoNHWtO6tLXSfXeMD+tmvz2x8dj1DaVkkz0iipz+FxV+WxoR4d1n9TSQU/ZcLZKO4wa1IFakLH6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=whZMpKOh; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4isRVKiLImCVyO2hEjEk7ihTK2vfyz1aTiw3YykMgQuBAcV5uYd3zVbl9gP6QKBBWAY+gjq6Tpxrbf7XtlPTNt2jWF6LzhIeWKnFHOiAGWhg0Ps4Wkjn7iYF/XkNH1XYsFxDKdaXiTGqTAek24fBk4zZFdrmsECl/f7c0ibIzV5G3uPxqdrKq6tIl2t9NE5nHZlGpGLPMu+pNESq0K3C0KiAnLEBdPdWrGKaarYdqEdZfUPMroWq+nuqflBCecSxaYvw9UEoEukXqRLgF7fHRrfElGIbuzX2RAnPhrvvxh5SJ3oeJd99ckZ4BH5OEnMNebdE7H3LICvQQix5TDLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9ZhiYYKahYO8iixfeniz6AMzC0pG21egg3sut6+rP4=;
 b=KKzrjWVBQ+xaJ9TvkHv0DynYC+8QXcu8gy28+W/7itpxDDbJtBv03XPcpZxqt3xNZ9ediZW7S1kn7BYPlmMAR2S8CCnbw94PeeGZc79Au3vNyP2VKivalrGp6A8jJ23LPeLFzau+yWJMGpy/LMENsZtKuPcqS4CalxGUntH2PFbCQ2xv3t0SDvsTXoPho2jCBXg+iktKMyDET8aplCq9CoFd3sOjWu3RajmSlM8RNB+7mErFmkH7Luyo0hC3MH0naQmdY+xYewr3kgSmg+FmXl5suyBOFYPDBoMYAy4AKvwidW5Yl/ogzxwacUnAnkFTFhAYYoa2zeVfmt0Ls/K+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9ZhiYYKahYO8iixfeniz6AMzC0pG21egg3sut6+rP4=;
 b=whZMpKOhWTzGsyuc4p6wRQFjpmXsALUIUr6KxotEhjE8bvmD8yahHVLb1JpxEmHhWkv6haHXzBv1/g7vEoQTavz37PF3jS5QeiDLkDmdPMN0W4ZFPZCUpgAxoNqzKE1M3fst6i27VDvIWGkS8iHKyZ+nYbnyOU+qWtHxkx3GOKg=
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 17:16:51 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::46) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 17:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:16:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:16:47 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<babu.moger@amd.com>, <yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>,
	<xin@zytor.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <me@mixaill.net>, <mario.limonciello@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <ak@linux.intel.com>,
	<chang.seok.bae@intel.com>, <andrew.cooper3@citrix.com>,
	<perry.yuan@amd.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 02/10] x86/resctrl: Add SDCIAE feature in the command line options
Date: Thu, 10 Jul 2025 12:16:16 -0500
Message-ID: <f3b1e748c13086a7183ffd159e667d07a4ff6cab.1752167718.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752167718.git.babu.moger@amd.com>
References: <cover.1752167718.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f8cb55-59be-4f10-7c78-08ddbfd58f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GKN3ihFcoOYdgixWVF63nHCAq3xAUq4r6SXeYZQajqEl3Ti/BhynKkb+lZtZ?=
 =?us-ascii?Q?d2cqlXn1VvyxUYzZ2Jm8tegngcCVVkQZIQW1BhOC505TeXbmdZjmVsiyfv0X?=
 =?us-ascii?Q?86P400d9wjpK/S1VlGV2lVsyx0+IZxz/4+aRwXVce777BFK3usc4YieEimZu?=
 =?us-ascii?Q?juPqhm3enGvSDVaJzfzKhcVvBkzJkZDzLWuL7NAffjb7OpwVclZfvgtmWbDe?=
 =?us-ascii?Q?lakKaWtW1gNShsfERk+PZ36OP6aiPWEqnaL/8R/w2RBZ+JpeVtjjLcIZ68ON?=
 =?us-ascii?Q?oQ3OBi/Q++RJXVa783R0e6CtySMyiJdSljLyM8kv3B/Bk2tpfEIhs2TxOpvo?=
 =?us-ascii?Q?4LWDUyVpv94jEHaS7mBjcF6r4a/4tbXINltYyf1jPCYa6xE4p+cLhbJCFt0i?=
 =?us-ascii?Q?5X7F5PECVPR95W5WWRDyvuxBvks4tGRhrXToEOwE3+NSirp+uhWgBd/QwzEh?=
 =?us-ascii?Q?/7gxX+3tG9kpZaAMlKo76XgcURWq/N+k+dtFjenGoeFlBJYYPDU5h2sB2zjB?=
 =?us-ascii?Q?XS0RCxNP++/rrEqXa/GkcBJGaLyHo5ohwe+mJwUQ73+v3kJoKAaOE057RcZG?=
 =?us-ascii?Q?X8cd73pJ5HDj+c9KXOIDLs0tMuQzqOz1+3OXqpFEoeNNKLvcMAp6hI3aR44Z?=
 =?us-ascii?Q?vLEoBDcM9WDRF+6V5f0zS8nnV9b5fwzuWoTOPoVoJxk1SSVWHuXxV63/W9tr?=
 =?us-ascii?Q?96Y/+pwaY1gPI1qHWzoywI1PqDwTeLFs69VW/WrZupbw0kdPgSooiAFllg3z?=
 =?us-ascii?Q?307b2XPlGbwNL57Y/nbw/WR9gWQDzoft8+FuoN8BrXBddKxVHoh/LwUokmEJ?=
 =?us-ascii?Q?5vQ0AjH154NbPnzLGaqX5SIO2UTZmxm9yC3TWFhyGIHt5hwdchDV0EyG28Xw?=
 =?us-ascii?Q?XqYULyqP0tVH8EbPSxZXW75pNI95peGmf9+NEEW9O4y4r4Is1S4qdrvLB4v6?=
 =?us-ascii?Q?e9eFAgN6YQ4TXloZ3jR6aLDI/2apQ8WTBxoTMZUCIPVZAHVMc/mS4F9s8m4p?=
 =?us-ascii?Q?7CTdpzw3HtpZU6jmzt8Ym8CxiAPywFph6Et6Ah4dz+dSQEt0ehu9SDjrKj/B?=
 =?us-ascii?Q?LoKZXT+1W7rlfcT4MURJJFWeFyQPVGMghcfPsNxbaZXZbkgkCBpz4d6fVOo7?=
 =?us-ascii?Q?a4s1MIuaFJitgCW7H49WQpr8SfF4WVH2wunp3tTkeiYpXX3JwzGj2lMOllMa?=
 =?us-ascii?Q?z5ke8b1tkKFhPNin151Aj4IUW6U65+0CgaIS20nfwRnmcGY1xW5lqpc3k5nE?=
 =?us-ascii?Q?tNirgx1pu/KQCexnmM2rVSax1ooy7O2i4SLfWcbU/b86ez2Hjs5JKqcbYIRT?=
 =?us-ascii?Q?128ft+i6aydvVo2dm3SV/F87BaAYjgHflm6C101LC0W4x06BqLUwBpcU+QCL?=
 =?us-ascii?Q?loPTK1Ooa7SxTot7pOj+J2emW6YVmuZBnbOPyYK8x6bOtp3nP6qO6iaWYrMc?=
 =?us-ascii?Q?g/6be/PGclq4ELK1p1oiISgB2i+nieOnJbWsEZevNKEXlMkxuXS4denbUoEA?=
 =?us-ascii?Q?BZEYhEb2jrsqPF0+uTxG9kYB1HZ1lQVvEP1W?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:16:50.5373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f8cb55-59be-4f10-7c78-08ddbfd58f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449

Add the command line options to enable or disable the new resctrl feature
L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: No changes.

v6: No changes.

v5: No changes.

v4: No changes.

v3: No changes.

v2: No changes.
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 07e22ba5bfe3..aa1c5948bec2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6066,7 +6066,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, sdciae.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 187d527ef73b..f6d84882cc4e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -707,6 +707,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_SDCIAE,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -732,6 +733,7 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_SDCIAE,    "sdciae",	X86_FEATURE_SDCIAE),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


