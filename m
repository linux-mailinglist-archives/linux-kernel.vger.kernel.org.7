Return-Path: <linux-kernel+bounces-770025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D72B27604
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847DC188D527
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87462D12F7;
	Fri, 15 Aug 2025 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xeUa8+rT"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C932BD5B2;
	Fri, 15 Aug 2025 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225026; cv=fail; b=JQ7rzLazrUCwlojX/WZbr+Jzc2lNZkQ3Jh08iowSOiWa1GtKTrTMEmIysoVMXnEnN5hHKTHEcXAYGfLq7hNbAobtsTPalx//xs5cz/p32ZCvxvmeXRL8NOw1rqBikIy0KW0cAyVWe+Jegz0vjViLMTT/ChJCeSgkIUdul4DRs1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225026; c=relaxed/simple;
	bh=RvKhErnXCtEE1IiyUXrarnw1XfG94exZV1i74pVUTEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkD6JoTKXrhK6C28ev8JobmW/GSjCStepgb7FOT505C8pUVAue4xDJPniFmedgoZ4/o0Z/nVIgInV0cZOD3xNn34Lu19Ghxa2939UgF+SGj3yA6v81pgAjCiwpbZ/4r43kAj+ij9XL7TQiZ5JgYZeM5Sr2L3UHvGWlI5Fqevjl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xeUa8+rT; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1S1/sfLbgChsz9geEThFcZnBoNGw98XMS54H5CXJIfPaF4bxvxyHs3/h3KhFooLEqroKfwgvsc5JrRkTmtDptJrI4eYWGCpJgGnQtQN4BvJq77GV24t2es4+jJ/R5Rjjy58kKA1DGQNEFjqB/WXDP36BYz+sAXxeLRJGOL1CfwUIhObxF4lpmo361w3P5xWlAr22X7qQkTRNqWJDvA3MGXyTs4wC0OH0PivPZc6kR/fEyScGwNGlBgBnW++y+e3o96xPu1Ciqv8NQkDD0fTHE8rLYDlDcB00cxqUymKaGs9+N/pgBUxyDhzQDuBa0yRcciXRIpzl0gek3UvyBubAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wRDdLM/qKOR91Em5bRV2RBbuCFOmyBuFAaOmVUIsEI=;
 b=uJghc14pJrLluq94kBCKPgQETJN15saGkaqumE7Tyn0M7bFQ04Ut1J2oRqYpjXKqXWPBM7PX8Yn0vXg6Bc+QHRfpCHIKivO9/jjhYeyAWvftx4T25bUzjjcDNPR7jwfsjNadibGdPM/31MB3tQWFcoXD2ErnoAdbVmKM1IC7Rx6ZGvd3APOe/L38OlOlqJRpmzbKIJioKfdePvrPhsP1BJZtiQ4P9uN7NAVF+RCj+h879NM9dC4Ye3s0I+UznrkWfjenNyxrz8cv2Wfu1QxguJkKdkjvzuabxTUrPU3vGjh/Nrq082IC/09TdaYGWRbsuosF9nTEyTmvcI18FlXtXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wRDdLM/qKOR91Em5bRV2RBbuCFOmyBuFAaOmVUIsEI=;
 b=xeUa8+rTn2vEh5HilBNNMy3l2oPCpfw+xXYnQlg6c7KXNkjtukYrceqEJXgdEeXS0hPKe2ML5XzWTHROCAysQiMVBtF8kDsuFbY/Ge+fuu0X9E66CZRXTFIJXokMm+hlAiwGCG1mfWoxEl1AnF6yyIuVmarlrbzKdKim3jKBwic=
Received: from MW4PR03CA0225.namprd03.prod.outlook.com (2603:10b6:303:b9::20)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 02:30:16 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::f9) by MW4PR03CA0225.outlook.office365.com
 (2603:10b6:303:b9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:30:15 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:29:58 -0500
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
Subject: [PATCH v17 29/33] fs/resctrl: Introduce the interface to modify assignments in a group
Date: Thu, 14 Aug 2025 21:25:33 -0500
Message-ID: <281e3250d5fd715adcf734676c0e68f17a00fb59.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 3369ce0a-9578-4f8d-9551-08dddba3ab87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tjc0Um5MTmNCYTZ5VXJrZmhhU1Q3aVRHbHlmc0diMHZTeG9VMXM4UzBrQVVm?=
 =?utf-8?B?RTV3OUdiWXF3SU5DeEQ3b3RLbkt6L1RKRzF5ZzdPTjdaa1FzbFo4L2VVbkRG?=
 =?utf-8?B?VXBQSHF0bkdHYXJUd0YvcUNXWnNXRjIzaEY4SDJmdTdpc1IrdXAwb2lPTEpl?=
 =?utf-8?B?REgxTWl3cDA1MFdMTHZpUUJSQ256MXFPMlc1Vnc3TGZWdEJHNjZTZEZqOGQr?=
 =?utf-8?B?aWg3TnpMa0xDSFFnYWNsdWQrZHk3WWgxUlR6bHJtQkJDTzI4OWJZMU1GS25F?=
 =?utf-8?B?OCsrcmZqRXNnZXFhWlBOTmZlQU1EY0g1dy93bithTG5pU09xVm84bVkycjlz?=
 =?utf-8?B?ZDlUeHZocDRoMXVQTU1sZXBPdHZHcHpjVXZkRWJHRXdoNStwSk9nVVFqS0lU?=
 =?utf-8?B?ZGE4a1pNK1Fpb0dmWlo4b0pSYk95Q0x6WjhuNTg5U3RJWm10Z1RJSzlGTkZj?=
 =?utf-8?B?c3libkdQZFdmZHZMYjJmRVFqalZ0aFlhTTA2UjlOeFMxenQyOGNFamIyRjlt?=
 =?utf-8?B?MFhCTUhwNGgzaldWYVJrOG5UOGx4WmUwanBzeUtaYVZWVDE3cEFYV05nR1N3?=
 =?utf-8?B?TVZLUWgvdC9meGZueTgvcmdndWNmTlYzblJTcjBOREhOMEZEYkh1YmVaQUx5?=
 =?utf-8?B?QXdTNHZoU2VMNHBVTGd3UElpOFBnd21yZXdzTkNjOXVXRGdoQlRTQ1czakhx?=
 =?utf-8?B?TVVYYVZoNTlxaTRTZGNibDJEN0xXZjZVK1JIMDVIZlF3N3hHUkYrN1RqYWZ6?=
 =?utf-8?B?Wi92c1FQRXpwc2FBUmpSSUFJcldlWjZpQ0JWa0E5L0RJRWZrR2lidjFrZzRp?=
 =?utf-8?B?YitQWkEwNXQ1NU5RYVZubm1WUmVHS3JDeHpHYVVnbExTMEF5UWM3dGg1bjVQ?=
 =?utf-8?B?dGxmWTRkMDU3dDF1dlN2dGtTdURSMnFCdWZITXpSTlB3S1Z4Q1R0MllGaExo?=
 =?utf-8?B?ak9WRkJvdjJ0SnBYYmVsUWVoUDZBNnR2WHRUNE9MclZ2aXo1MVR3dlBQckdq?=
 =?utf-8?B?b3lXK0REQTZ5S1k3Z0g5ZzdQL25WNmdEWEtMb0lxaTNDbU9DWmMxMEJoSGpO?=
 =?utf-8?B?Y29Bc2VuQjhGR2NOWlNZeGp5SWhhNFFJMGNScmpiaG83ZEM3N1ZzZnVGMThW?=
 =?utf-8?B?TE1CcVFLc3NIZTROVTE0eEhZRGkzNHdRZlRNeGtEK3U3d2k5dWo4a3R0b2l2?=
 =?utf-8?B?aDlNVDBCcnZXYTJQU1Y5czJXNys1OGtPTlZWNW1RVzJFdTdrVktvUVN6TEtP?=
 =?utf-8?B?b0xhZ0E0WjNTd29vSXJPdVA2bm9ob3laNnVSZDd1WFNOSU5Mc0RRaU81VGdh?=
 =?utf-8?B?RWdxWmFLaHlQQkl2a3NVQWJ5TU8xVUd1MG5udjdac1RIbEIxZGtOQUUzYkJM?=
 =?utf-8?B?MVRsTTlkTlN2cFNSbW5QbzQzZlRyTnR5alhERkc3TWJqS3R3eFRlc1BkZE52?=
 =?utf-8?B?VU1pVEM5ZWlpMHkxam5MZUlkL05TdFRtL2Y2d0NBN1ovVy9uMVNWVFlyTnE5?=
 =?utf-8?B?TUo0eSt5cGI0aWlaamRNNUMwL21JVThmbUVDdUYzVmxpQW8vUENCbklUZzBw?=
 =?utf-8?B?VDNGMUZ0aC9qZnVFUEw0Rldkc0V3NUJERTR3MXg3RmF4QU1rQjMwa2xPVjVS?=
 =?utf-8?B?Wk82ZExaMkVjby9OcUZITHRuazZJZ3ZTZkZtSmFPUzJWY3hKUnBzTnJRaThH?=
 =?utf-8?B?RytvUllkaDBwWk5zczhsRHo1ODFta3BEeE5LQU1lOWVSMlFIRnZ3NkhRR092?=
 =?utf-8?B?ZmpCNnBicllkWFdhVHhzNmczY1lIWkp3U09abFNFT3BxZk9QZzdOcDJnQVBu?=
 =?utf-8?B?TFovTThERWRFdUQzTUZFbGNKUFFuQXJZWC94MUxpSDVSUzliaFdRcVJKWGlp?=
 =?utf-8?B?enNYbXYrbXNUWlNSKzRWQnQ1bWxOZEJ3UnBZcWFtWGc3R1Uxd2o2cGI0NHV4?=
 =?utf-8?B?eUgveU81QkhqbEo4SEF3VUJOQlZJbmc1T2pmd01nbmNBc0ZQa1hwbVVxaWdT?=
 =?utf-8?B?cW9RWU4yOEdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:30:15.9074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3369ce0a-9578-4f8d-9551-08dddba3ab87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

Enable the mbm_l3_assignments resctrl file to be used to modify counter
assignments of CTRL_MON and MON groups when the "mbm_event" counter
assignment mode is enabled.

Process the assignment modifications in the following format:
<Event>:<Domain id>=<Assignment state>;<Domain id>=<Assignment state>

Event: A valid MBM event in the
       /sys/fs/resctrl/info/L3_MON/event_configs directory.

Domain ID: A valid domain ID. When writing, '*' applies the changes
	   to all domains.

Assignment states:

    _ : Unassign a counter.

    e : Assign a counter exclusively.

Examples:

$ cd /sys/fs/resctrl
$ cat /sys/fs/resctrl/mbm_L3_assignments
  mbm_total_bytes:0=e;1=e
  mbm_local_bytes:0=e;1=e

To unassign the counter associated with the mbm_total_bytes event on
domain 0:

$ echo "mbm_total_bytes:0=_" > mbm_L3_assignments
$ cat /sys/fs/resctrl/mbm_L3_assignments
  mbm_total_bytes:0=_;1=e
  mbm_local_bytes:0=e;1=e

To unassign the counter associated with the mbm_total_bytes event on
all the domains:

$ echo "mbm_total_bytes:*=_" > mbm_L3_assignments
$ cat /sys/fs/resctrl/mbm_L3_assignments
  mbm_total_bytes:0=_;1=_
  mbm_local_bytes:0=e;1=e

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Moved mbm_L3_assignments_write() and all dependencies to fs/resctrl/monitor.c.
     Fixed extra space.
     Re-organized the user doc.

v16: Updated the changelog for minor corrections.
     Updated resctrl.rst few corrections and consistancy.
     Fixed few references of counter_configs to > event_configs.
     Renamed resctrl_process_assign() to resctrl_parse_mbm_assignment().
     Moved resctrl_parse_mbm_assignment() and rdtgroup_modify_assign_state() to monitor.c.

v15: Updated the changelog little bit.
     Fixed the spacing in event_filter display.
     Removed the enum ASSIGN_NONE etc. Not required anymore.
     Moved mbm_get_mon_event_by_name() to fs/resctrl/monitor.c
     Used the new macro for_each_mon_event().
     Renamed resctrl_get_assign_state() -> rdtgroup_modify_assign_state().
     Quite a few changes in resctrl_process_assign().
     Removed the found and domain variables.
     Called rdtgroup_modify_assign_state() directly where applicable.
     Removed couple of goto statements.

v14: Fixed the problem reported by Peter.
     Updated the changelog.
     Updated the user doc resctrl.rst.
     Added example section on how to use resctrl with mbm_assign_mode.

v13: Few changes in mbm_L3_assignments_write() after moving the event config to evt_list.
     Resolved conflicts caused by the recent FS/ARCH code restructure.

v12: New patch:
     Assignment interface moved inside the group based the discussion
     https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/#t
---
 Documentation/filesystems/resctrl.rst | 152 +++++++++++++++++++++++++-
 fs/resctrl/internal.h                 |   3 +
 fs/resctrl/monitor.c                  | 139 +++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                 |   3 +-
 4 files changed, 295 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index af0c38206bab..3e549822a439 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -530,7 +530,8 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
 	Event: A valid MBM event in the
 	       /sys/fs/resctrl/info/L3_MON/event_configs directory.
 
-	Domain ID: A valid domain ID.
+	Domain ID: A valid domain ID. When writing, '*' applies the changes
+		   to all the domains.
 
 	Assignment states:
 
@@ -539,6 +540,7 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
 	e : Counter assigned exclusively.
 
 	Example:
+
 	To display the counter assignment states for the default group.
 	::
 
@@ -547,6 +549,35 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
 	   mbm_total_bytes:0=e;1=e
 	   mbm_local_bytes:0=e;1=e
 
+	Assignments can be modified by writing to the interface.
+
+	Examples:
+
+	To unassign the counter associated with the mbm_total_bytes event on domain 0:
+	::
+
+	 # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
+	 # cat /sys/fs/resctrl/mbm_L3_assignments
+	   mbm_total_bytes:0=_;1=e
+	   mbm_local_bytes:0=e;1=e
+
+	To unassign the counter associated with the mbm_total_bytes event on all the domains:
+	::
+
+	 # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
+	 # cat /sys/fs/resctrl/mbm_L3_assignments
+	   mbm_total_bytes:0=_;1=_
+	   mbm_local_bytes:0=e;1=e
+
+	To assign a counter associated with the mbm_total_bytes event on all domains in
+	exclusive mode:
+	::
+
+	 # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
+	 # cat /sys/fs/resctrl/mbm_L3_assignments
+	   mbm_total_bytes:0=e;1=e
+	   mbm_local_bytes:0=e;1=e
+
 Resource allocation rules
 -------------------------
 
@@ -1582,6 +1613,125 @@ View the llc occupancy snapshot::
   # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
   11234000
 
+
+Examples on working with mbm_assign_mode
+========================================
+
+a. Check if MBM counter assignment mode is supported.
+::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl/
+
+  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+  [mbm_event]
+  default
+
+The "mbm_event" mode is detected and enabled.
+
+b. Check how many assignable counters are supported.
+::
+
+  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
+  0=32;1=32
+
+c. Check how many assignable counters are available for assignment in each domain.
+::
+
+  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
+  0=30;1=30
+
+d. To list the default group's assign states.
+::
+
+  # cat /sys/fs/resctrl/mbm_L3_assignments
+  mbm_total_bytes:0=e;1=e
+  mbm_local_bytes:0=e;1=e
+
+e.  To unassign the counter associated with the mbm_total_bytes event on domain 0.
+::
+
+  # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
+  # cat /sys/fs/resctrl/mbm_L3_assignments
+  mbm_total_bytes:0=_;1=e
+  mbm_local_bytes:0=e;1=e
+
+f. To unassign the counter associated with the mbm_total_bytes event on all domains.
+::
+
+  # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
+  # cat /sys/fs/resctrl/mbm_L3_assignment
+  mbm_total_bytes:0=_;1=_
+  mbm_local_bytes:0=e;1=e
+
+g. To assign a counter associated with the mbm_total_bytes event on all domains in
+exclusive mode.
+::
+
+  # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
+  # cat /sys/fs/resctrl/mbm_L3_assignments
+  mbm_total_bytes:0=e;1=e
+  mbm_local_bytes:0=e;1=e
+
+h. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
+no change in reading the events with the assignment.
+::
+
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
+  779247936
+  # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_total_bytes
+  562324232
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
+  212122123
+  # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
+  121212144
+
+i. Check the event configurations.
+::
+
+  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
+  local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_writes,
+  local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all
+
+  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
+  local_reads,local_non_temporal_writes,local_reads_slow_memory
+
+j. Change the event configuration for mbm_local_bytes.
+::
+
+  # echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
+  /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
+
+  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
+  local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
+
+k. Now read the local events again. The first read may come back with "Unavailable"
+status. The subsequent read of mbm_local_bytes will display the current value.
+::
+
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
+  Unavailable
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
+  2252323
+  # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
+  Unavailable
+  # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
+  1566565
+
+l. Users have the option to go back to 'default' mbm_assign_mode if required. This can be
+done using the following command. Note that switching the mbm_assign_mode may reset all
+the MBM counters (and thus all MBM events) of all the resctrl groups.
+::
+
+  # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+  mbm_event
+  [default]
+
+m. Unmount the resctrl filesystem.
+::
+
+  # umount /sys/fs/resctrl/
+
 Intel RDT Errata
 ================
 
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 88079ca0d57a..264f04c7dfba 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -418,6 +418,9 @@ ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of, char *buf
 
 int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
 
+ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
+				 loff_t off);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 76967a49b4e8..41dd2a117376 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1509,6 +1509,145 @@ int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s, voi
 	return ret;
 }
 
+/*
+ * mbm_get_mon_event_by_name() - Return the mon_evt entry for the matching
+ * event name.
+ */
+static struct mon_evt *mbm_get_mon_event_by_name(struct rdt_resource *r, char *name)
+{
+	struct mon_evt *mevt;
+
+	for_each_mon_event(mevt) {
+		if (mevt->rid == r->rid && mevt->enabled &&
+		    resctrl_is_mbm_event(mevt->evtid) &&
+		    !strcmp(mevt->name, name))
+			return mevt;
+	}
+
+	return NULL;
+}
+
+static int rdtgroup_modify_assign_state(char *assign, struct rdt_mon_domain *d,
+					struct rdtgroup *rdtgrp, struct mon_evt *mevt)
+{
+	int ret = 0;
+
+	if (!assign || strlen(assign) != 1)
+		return -EINVAL;
+
+	switch (*assign) {
+	case 'e':
+		ret = rdtgroup_assign_cntr_event(d, rdtgrp, mevt);
+		break;
+	case '_':
+		rdtgroup_unassign_cntr_event(d, rdtgrp, mevt);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int resctrl_parse_mbm_assignment(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+					char *event, char *tok)
+{
+	struct rdt_mon_domain *d;
+	unsigned long dom_id = 0;
+	char *dom_str, *id_str;
+	struct mon_evt *mevt;
+	int ret;
+
+	mevt = mbm_get_mon_event_by_name(r, event);
+	if (!mevt) {
+		rdt_last_cmd_printf("Invalid event %s\n", event);
+		return -ENOENT;
+	}
+
+next:
+	if (!tok || tok[0] == '\0')
+		return 0;
+
+	/* Start processing the strings for each domain */
+	dom_str = strim(strsep(&tok, ";"));
+
+	id_str = strsep(&dom_str, "=");
+
+	/* Check for domain id '*' which means all domains */
+	if (id_str && *id_str == '*') {
+		ret = rdtgroup_modify_assign_state(dom_str, NULL, rdtgrp, mevt);
+		if (ret)
+			rdt_last_cmd_printf("Assign operation '%s:*=%s' failed\n",
+					    event, dom_str);
+		return ret;
+	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing domain id\n");
+		return -EINVAL;
+	}
+
+	/* Verify if the dom_id is valid */
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		if (d->hdr.id == dom_id) {
+			ret = rdtgroup_modify_assign_state(dom_str, d, rdtgrp, mevt);
+			if (ret) {
+				rdt_last_cmd_printf("Assign operation '%s:%ld=%s' failed\n",
+						    event, dom_id, dom_str);
+				return ret;
+			}
+			goto next;
+		}
+	}
+
+	rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
+	return -EINVAL;
+}
+
+ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	struct rdtgroup *rdtgrp;
+	char *token, *event;
+	int ret = 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+	rdt_last_cmd_clear();
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event mode is not enabled\n");
+		rdtgroup_kn_unlock(of->kn);
+		return -EINVAL;
+	}
+
+	while ((token = strsep(&buf, "\n")) != NULL) {
+		/*
+		 * The write command follows the following format:
+		 * “<Event>:<Domain ID>=<Assignment state>”
+		 * Extract the event name first.
+		 */
+		event = strsep(&token, ":");
+
+		ret = resctrl_parse_mbm_assignment(r, rdtgrp, event, token);
+		if (ret)
+			break;
+	}
+
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 9d3a58c76fe2..dd5e6f720b98 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1939,9 +1939,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_L3_assignments",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= mbm_L3_assignments_show,
+		.write		= mbm_L3_assignments_write,
 	},
 	{
 		.name		= "mbm_assign_mode",
-- 
2.34.1


