Return-Path: <linux-kernel+bounces-769986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674B8B275AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC785E4530
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE4B29A333;
	Fri, 15 Aug 2025 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2zOABgii"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9E629992B;
	Fri, 15 Aug 2025 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224783; cv=fail; b=KFlwTP6MEtPnRakUamXFWST1kNQyx5sLYBgtqnoKFzE3s5B46llUnXtXsBwuAplc7ZLz+i2cRNxT5cbO+42pYnO7qrn5FSuJXJQnRl9nsLWnF+BGaSQtbZHw3qkHjU3nrPx7ogO7ZKP7vr9KUe3BZqU1+4PRmwCPuzlhy/BHfpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224783; c=relaxed/simple;
	bh=8EKin7c10CfNoWHmsaTW0rO2Ee4qRxGbsrezRBkD6pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEYFrGe24zDdYnZypw6S4QLwY/GmGktdTOSn6ajJPJfNzG1okWCTgVFHfKvdKAJ79FBR7JJt7eKDisozn5GkslcaTULYs7Quf8MemYa87XYMBpZanW9tSSENCp8eZniufsbTL1D4e9mEgomjHP/oz7hWFv+u0fKrp7gM2/TcmPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2zOABgii; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WptQH9YL/UsiaBXdH6gw1xmTXfWEZY1i1yZ1d31eOGviISYUSqmAoE690U/3+XL57BwvziQp3HRmey84PMj4MRN38gTT9tYogBDgv3L9q8NnU097dSQngQpJk3wa1KWJCcQ3WzXWIhmez3mLKRuuCN0S3uK8OhAAHeTrcUYOJ1GIEbjb9FJ0xsTmWB9xK4BuxZE1jBk12W+HWLKaxFmlBm4NxKTzVgynbQxNdaCA6yoimfbVx/t2EgWRzpRF3KWWTLWy4huKpqkr2hwKzxpphfBggWATnNaSNB3BC7/L4OV1A+fCqSbziUccWS8MpfifJGypQe9Nk838iGY0UamN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgDuFsOrKVh3kcZHX1RPdQV2AdEd9wHEl5DLZoH+gIM=;
 b=yVTVYGMzdP3ZD46PH15ZVPYzgNiKLs6EO/jLIHi9tN9Lis+yvSv5sHzjOjALB7gcRnIfCMTWxhy7OiKWgjt/Q0j7y0vcEAl1hzpk9SreU+wdIuFTLBb//8R0sxQ6g5kliaZvknxh+TIG2lw4qM2Xbgo6AI5Wcr0RssfhHWpGA11mDqvRYPRrrLHnRFjlNB8DMkG14f/fgRlBoE2rNXcS4osg1FeiSk0Zk9fOVpi8RXjLq2fM4i/xHHkp27PkVVJvR8P+L0q0ft+KJQIp12JlGfaPfoVWkfQJjm4unPdvQnR749RPUaS6R5+zxEpxExoPkY54iGcsgfO3G/XfnxzXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgDuFsOrKVh3kcZHX1RPdQV2AdEd9wHEl5DLZoH+gIM=;
 b=2zOABgii9WSjuxLiaxVnu3UPZGwYJWLde0d2/nAPjNNJfovgTuJR231uAHb5JmrkwlJ70zTyxgZ8f1WjWrww0FO5qtHWnGF0LAbSSlnCqQCpkT0Vkku+Cv7kIpkhE24VBPIoVwKpnMb2j3kjkgPqAr0Y+TORy73oxVx3BrylB0U=
Received: from BYAPR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:40::18)
 by DS0PR12MB9727.namprd12.prod.outlook.com (2603:10b6:8:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 02:26:18 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::d9) by BYAPR04CA0005.outlook.office365.com
 (2603:10b6:a03:40::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:26:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:26:15 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <thomas.lendacky@amd.com>,
	<yosry.ahmed@linux.dev>, <xin@zytor.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<mario.limonciello@amd.com>, <xin3.li@intel.com>, <perry.yuan@amd.com>,
	<chang.seok.bae@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v17 03/33] x86/resctrl: Remove 'rdt_mon_features' global variable
Date: Thu, 14 Aug 2025 21:25:07 -0500
Message-ID: <3d59f8db13d6480fb967393e4c706e58398945d2.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|DS0PR12MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: f1998fd2-b13c-4532-f70a-08dddba31dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ITb43dkSiqZ8slDEron+qcwpWQEbGrJlQKv9FQdENd+29gV/kOgzzMzdUT70?=
 =?us-ascii?Q?w0eJgAlPfMLfmMWSp+KNWH5Q8e9Y3RxptNWWxwPLG3cjkKuYBH6YttkL9o1x?=
 =?us-ascii?Q?fzF73my8uTnj/ZnPqmSgkdiwQKlOxgiU+8ouP0/mGia9yLmpYWmjbnTgTQis?=
 =?us-ascii?Q?vUSGBfsIIeoMb0TG/phoziGp7LserEwR1OnuJYB1xMTyRdDNy2/VufIirWOc?=
 =?us-ascii?Q?ic8RP5V0en6Q5iJJLGV81PFZ/who3wfRmRXjo/R72QuZIFi/qUz7O39BbZ1f?=
 =?us-ascii?Q?K7bPjwzD18BdwnMbZN+s0ffP2kD715+/G18MmWXHEnCQIWO2fbLDdWpZiZhN?=
 =?us-ascii?Q?tW+nkmw3K7OZeRjxsJKgxouSVQNkK5YJl20vwTK/JirHAHZM1FsfDMp3UdXT?=
 =?us-ascii?Q?D2Gp6CcEoXTQVO/qnarG4vhYAcLYCdy0n4g/1fGY+G0Z4nG3JJ7lQsKJzdcI?=
 =?us-ascii?Q?5NCMmDnR4Tn1Qk7kavieSMxWn7pBf3ZbBo/Qdw/5B9aWg9IEYxvfikmpGYPH?=
 =?us-ascii?Q?bYdzG/egAZO7Au89Uzy/LxU5EMb81O440MoxBlnUwiQIAN2bBXXIAbPoh6Ze?=
 =?us-ascii?Q?Cmfq31DJF2zux9LVDdZEcKOMy7IIEXxAb+QD6uRCPl1d+NcuuKdzoLYkNLiJ?=
 =?us-ascii?Q?fPMMfNGeEsyfEIwaJYR+3ejR9LjpdJZlyCI7viGDhCp3ulOvq70oI+mpsVd5?=
 =?us-ascii?Q?MNsiMzYGzx0mM2/yETTS76LN3uQsl8iDW5oieJ2QNwFHwTiWRfkXEX/hfu8e?=
 =?us-ascii?Q?Ct0HLWsNs7+t4pp9H7mWeMqgpNnXAdOfnzTQZ65STmK5hJcp+cfLJwVzRTC0?=
 =?us-ascii?Q?QFY4fq1ju2kqmhhMrqtmy6YJ/IubPcP7EbZ447H9+ciipq+/Eq+THB4IyMO7?=
 =?us-ascii?Q?FA55WG4xmWRPUxZ8/ls8VCiYcejZH7TBRReperBiRgMZZFGCc/s/zLFRnJXX?=
 =?us-ascii?Q?6yzrC++d6KcMe49Y3T1d3gpUUEMQNjhaKoEtWsPxvWeNVPUYEk8O4QcNkWII?=
 =?us-ascii?Q?v8RjcfpCeR/kIL0Xfcow8uWQtAh8WhzC53W7/xAlVJhopTx2/egYKmuD2BsZ?=
 =?us-ascii?Q?uJEftwWxg4+m21a2XZsR9Z/eq1a4bpbrcdHelddUVjdVstIJ11z9/y1lz/oE?=
 =?us-ascii?Q?5h4nvrl+Sc1+xt3L2LuND37PG6u+CC6+COrjgaUQUdiqMNMfd50t1o5hGeqA?=
 =?us-ascii?Q?iKp3izLo3SCjC9iuSlPXzo+4n2tMCh+qTd7tLBjgFMO55RqgjoIhUELt0u7c?=
 =?us-ascii?Q?DAHSCxR5a0y44gLsQll+7WTpkbGK5LVGYe72pPswNToL6/8kKAfkeS1eJ/ul?=
 =?us-ascii?Q?OR9nQ4EpFYFkYaPlNlKjap6qHKrYjGbrgabEabLU/rolRRrzL05pwJJAO02a?=
 =?us-ascii?Q?8vBqJrod4vS1giTPWBEE4n1OQImYBt+He+orV8DKgb1Wlqt0naVAsUOegqRJ?=
 =?us-ascii?Q?O+20kFMvUZO9gG13PO0VZt3askoYHAFu1tIbPFvRTm8q+1ODeJSZKbvWGgC8?=
 =?us-ascii?Q?stBP8M1ZDQL0X5COliQ7Rw3UzCpJTknDO8BlBCeB9B+Jf9IQTGI/WqGc/A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:26:18.2005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1998fd2-b13c-4532-f70a-08dddba31dcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9727

From: Tony Luck <tony.luck@intel.com>

rdt_mon_features is used as a bitmask of enabled monitor events. A monitor
event's status is now maintained in mon_evt::enabled with all monitor
events' mon_evt structures found in the filesystem's mon_event_all[] array.

Remove the remaining uses of rdt_mon_features.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v17: Added Signed-off-by tag;

Picked up first four patches from:
https://lore.kernel.org/lkml/20250711235341.113933-1-tony.luck@intel.com/
These patches have already been reviewed.
---
 arch/x86/include/asm/resctrl.h        | 1 -
 arch/x86/kernel/cpu/resctrl/core.c    | 9 +++++----
 arch/x86/kernel/cpu/resctrl/monitor.c | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index b1dd5d6b87db..575f8408a9e7 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -44,7 +44,6 @@ DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
-extern unsigned int rdt_mon_features;
 
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 1a319ce9328c..5d14f9a14eda 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -863,21 +863,22 @@ static __init bool get_rdt_alloc_resources(void)
 static __init bool get_rdt_mon_resources(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	bool ret = false;
 
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
 		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
+		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_MBM_TOTAL_EVENT_ID);
+		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
 		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_MBM_LOCAL_EVENT_ID);
+		ret = true;
 	}
 
-	if (!rdt_mon_features)
+	if (!ret)
 		return false;
 
 	return !rdt_get_mon_l3_config(r);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 61d38517e2bf..07f8ab097cbe 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -31,11 +31,6 @@
  */
 bool rdt_mon_capable;
 
-/*
- * Global to indicate which monitoring events are enabled.
- */
-unsigned int rdt_mon_features;
-
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
 static int snc_nodes_per_l3_cache = 1;
-- 
2.34.1


