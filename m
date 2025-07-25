Return-Path: <linux-kernel+bounces-746194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F174B12414
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F80D1CC6739
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549532522B4;
	Fri, 25 Jul 2025 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k/Fmew4p"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE12500DF;
	Fri, 25 Jul 2025 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468535; cv=fail; b=HiNyQmmGfd7/wUE/dZd33HpvsXntoevV2TlpiFRP5V161wKYdgA52/X0CstOAeeITtSwML9AP8vxSBB8O5WqjflRvrn2oBq4/7qKFcWc+Rxw8Taw5GRtOPVJ7L403jY1gNU7aRGyxU0AfwSRFzMkFGfUcjgbP4dg37OGP9sO1Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468535; c=relaxed/simple;
	bh=Wmu1Huv59vXPfDKENfEfYF1/DikvR00c0Wv4RoHgfrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QapXtwofFTksMgJN98F48IaYOxl7icEc4hh5+d3BPTw2AfJ+4sqfQSFUJR//z4vo63PAFw71XNI9+WHq40vGxkMHSWdDO5WaLPp5f9exXvmZpbA4LN9JTaTblGdh8qOQZdLyvKGAEWY+3tE3v5BfiUHJ3VB3DlDyGT67GuFk5wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k/Fmew4p; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4n+rU4FjKuzwvnngrUU04fkHbsUUmhMl209WNtoMkt96pj2vOsaM7Tzzek1B7d3X5F19RSkR4bC2apI3z6M2KRhJsOm1p30Y/F24ixHaL+1PC3obevyhlhtZyH+K+lDCHLTp3LXwDjdC4gXcnx8xhaqbp/ge1YcQNYah8tnM8qPgCQydl+Gx7ck6UmMqf3FLTrxKi+ZZ0/+Q9CkdYBgxXQlhHGHISmGyHDPxroJWbphwiqafv2xHvj93WYf93jT9A/xae8dY2cmibwSfckBS7e7d53nde67HMG+2xhqIX5ejuu+29g5peZ/cVHzVWZsWYz5Y8Rq3WVRmDSca09CcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLfvK51lnum1BbeQsvfoxwwOII9Qa/zeoyiD8/delmM=;
 b=sdnU7lTGpJDXgWCA8A+Js1z9HhkiB8BQ6/GGHj2HnrY5OwHYE16lxvqtL8nMV3h6MfRl6dD1rSf8sWIsuDuKrz5bYkG3XifoGL3qb0mgxGjtAfXi3lzRAKhhRhGQajtaOL0aBNkWsTIWJwH1Y4sUZ7IaQk4I5zEYpZsG9t+Guwm4fWxAKLf5u7jSSsP4IANJEpPnqLoPD3p2wPbOxwqgjbXkvL4p0MoSrQU5opIEcQIsL7RG8r43RPbNP+tUWOvdSUlNOMVwD5h6VeZUY/2QLDKVK4qSyMnr678EUiQ9rjJtLFgkofKu9QCoDCBeLntkKUHJSQIMM3tOaMNETfCs4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLfvK51lnum1BbeQsvfoxwwOII9Qa/zeoyiD8/delmM=;
 b=k/Fmew4pP1P7nE2rZ7+IqtXpNnCXyJjUmKh5N5hUXnlZd/e2NtVt84At1bfj7N436tD7zAm8M7cSZ0usbOR6SBIZdO44NdWWa//ffLgv+eIkoJu13YgpbpGiqRgbFL1Bn+qEa3zIicmTpOO0afTOJ2cVRPXvgwZeXoyBFnPm8UI=
Received: from SJ0PR05CA0142.namprd05.prod.outlook.com (2603:10b6:a03:33d::27)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 18:35:26 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::37) by SJ0PR05CA0142.outlook.office365.com
 (2603:10b6:a03:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.7 via Frontend Transport; Fri,
 25 Jul 2025 18:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:35:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:35:21 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <babu.moger@amd.com>, <tao1.su@linux.intel.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH v16 30/34] fs/resctrl: Introduce the interface to modify assignments in a group
Date: Fri, 25 Jul 2025 13:29:49 -0500
Message-ID: <5c589b07428d3bce95616b0f69fc58883eb86360.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
References: <cover.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f596bf-3a36-49d6-6b4b-08ddcbaa0503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S20vaEVnNXJVRkkzS0YxZ0h3blNsTXNhKytNT2ZzT3pYcWg2SXI1Z1hMUThZ?=
 =?utf-8?B?SVZZZFY0RGh0ODcvV2RvSmg5MWZYOU84bmQzaGw3a3hPS2hobUEwTVUwenpQ?=
 =?utf-8?B?bHhYUmowM25LWkk1dkhJSTdlYXNiQ3JuY1RnSGlQdHpKQnFhRjFWZGZrN3FD?=
 =?utf-8?B?RXlBdDFXNEJveVNQMmNadForSFU0OWxiUkszQXRnUmZ6eTl4b1JrUFp6M1BT?=
 =?utf-8?B?OE5lSjdXUEV5WGNwVWJCUko5SWVIRStSTGxKNWdxeVBKYm81VXBMNkl2Q2hY?=
 =?utf-8?B?RFpydk9tQzR3blZ3Rk9aVythV0N1Y3FaSVEyelZPa000R1BaRHVnOXl5V2VV?=
 =?utf-8?B?ZnZWWEZBdHFYejJLOGRCY1JYTnN0dWJ5aGtLcFJ6czhPeE92SUkvWmRYMk1u?=
 =?utf-8?B?MEY4Q3lsM0JPdENTWGJRZ2JVTmV1MmNYaU1mNHRsUlJDV0dmMjZmQlZqdFJC?=
 =?utf-8?B?UVM0ZzdnTFlUUlVYd0hrK1QvY3UxZll1dTJNY3g4V0t1cEoza3JMRHFiK2g5?=
 =?utf-8?B?MGc0UUFKMzhtNUpnNzdFaXFBZVNnS1N0YkhYdVBuM1I5WHRxaDJvL0hxTDUw?=
 =?utf-8?B?VmRXQnpuYWRkMTZXRUx5cGo1dzVGUWdxU01yajlxdlFvNWIyb01VTXdoMC96?=
 =?utf-8?B?OHk1ajdlaXhwSGpMYVdDR3c3NFdVK3RyV0syeHZhcld0Nmd1ajRmRllaZi8y?=
 =?utf-8?B?MERRaDhaVGtVbldnNDFERXk2anBtYiswL05xUnk4bHZzNVAyRnJ5SVdsb3Z0?=
 =?utf-8?B?bThqWEhPOVhYbTRsN014OWlUajVabGhlNytUUUV2TUg0ZnkwYjdaTEh0QktS?=
 =?utf-8?B?MWczZmpEU0JpZDY0VldGaTU4dmhvN0F3L3R6OXNtSEtwb1B4ZFJlN2tzdjUz?=
 =?utf-8?B?SXMxNlNsZ2dPcGNkSmxobDQ2MHAxOEFUaS9uM09scklPa0YwSHFLa1RlZk4w?=
 =?utf-8?B?OUEwNGhScTNWMGhpdkJWV29sVWZGRXBxelZjS1BZTHVLVkthbjBQVlVkUENl?=
 =?utf-8?B?MUY0bVhTTGJVWFplVUIwQU9FNHhPVnB1T1liYWdOY1hMM3JYbUhpRzNrNXd5?=
 =?utf-8?B?U0Yxb2NNTVIyc1BPUHcyOHRiOElPTGxJc21xdWVyY1ZjYWhEa1hkVUJMMm1n?=
 =?utf-8?B?R01aa3lRZGFjcmY4OGFSYkdHZE5BUGNwdkJJY1hUUWxJazViK0VKU0czUzdD?=
 =?utf-8?B?Z0hpTklDUWtPS1FXUXN2UHM2Q3pvQitOeTllTVdoL2huNk9wcmFpVVUyV2FG?=
 =?utf-8?B?a1BoZkM0QjRaMlg1Z2FVWmpoNDlEK1kvY1B3RGd2K05tVXZ1NUNVMEFLb1Ju?=
 =?utf-8?B?NmV5RUxwOUs0SkNlUDU0ZTdxSzE3MWlNZGZ5M2hHZ2VsRTIzOWFWQXdTcWVy?=
 =?utf-8?B?c29VN3FpaDQyQ3J2N3VLdnNqOEk0NExwU1J4b3laeURkRTdzTDZUWDNzMGRP?=
 =?utf-8?B?VVVEbUE0TDZqMDJySmVQVWRzSXVIMzMzWGp6ZXBpMFNuanBHTitPYmZ3dkh3?=
 =?utf-8?B?MVZid1R3SzUvaGFrb29neitHWDdXcUViczZpMnVFZ28yWjFjRHB0UTR1VnM3?=
 =?utf-8?B?eVlyNzZLTDRhT0F0MWNWd01QdVJXRW1NRFQ3UW5tdm9JcGpucmZqMW1DL25U?=
 =?utf-8?B?NHpWVktlNHFGalUwNGJvMGxNZEJOOFZZZTB6UmJyb2RXb0RwOFVGVnhTcmZW?=
 =?utf-8?B?ZEF2V1NneDM3ZzNXN3hRcCtMVEp2OEg1ZWhMajVCVTFhelJEb0huL1FPRDBV?=
 =?utf-8?B?L0hqbjExZGtUWWNkOFFvelpsbm54MHUvZEdoMElndWRpS3BuNzA2NFFQOGpL?=
 =?utf-8?B?Y1JxQlBVSGhGdW45ZkkrK3JXVFJFMWJITU5GOGpjam5SZmNNbmhRVmpic29Z?=
 =?utf-8?B?WVpITzA5VWE0VkxHRysreXQ1ZXpxbDA5TXpybmJ3NC9wSXVIWnAraXVQWC9y?=
 =?utf-8?B?ME1reTdibTl4dVAwcG5DOHF4dHNOVFRXZVVPSHc5VWUxUE1MZG5zUFZpdzZu?=
 =?utf-8?B?dlUzd1lyWWN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:35:24.4588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f596bf-3a36-49d6-6b4b-08ddcbaa0503
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

Enable the mbm_l3_assignments resctrl file to be used to modify counter
assignments of CTRL_MON and MON groups when the "mbm_event" counter
assignment mode is enabled.

The assignment modifications are done in the following format:
<Event>:<Domain id>=<Assignment state>

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
 Documentation/filesystems/resctrl.rst | 146 +++++++++++++++++++++++++-
 fs/resctrl/internal.h                 |   3 +
 fs/resctrl/monitor.c                  |  94 +++++++++++++++++
 fs/resctrl/rdtgroup.c                 |  48 ++++++++-
 4 files changed, 289 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 0b8ce942f112..0c8701103214 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -525,7 +525,8 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
 	Event: A valid MBM event in the
 	       /sys/fs/resctrl/info/L3_MON/event_configs directory.
 
-	Domain ID: A valid domain ID.
+	Domain ID: A valid domain ID. When writing, '*' applies the changes
+		   to all the domains.
 
 	Assignment states:
 
@@ -542,6 +543,34 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
 	   mbm_total_bytes:0=e;1=e
 	   mbm_local_bytes:0=e;1=e
 
+	Assignments can be modified by writing to the interface.
+
+	Example:
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
 
@@ -1577,6 +1606,121 @@ View the llc occupancy snapshot::
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
+no change in reading the events with the assignment.  If the event is unassigned when
+reading, then the read will come back as "Unassigned".
+::
+
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
+  779247936
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
+  765207488
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
+This will update all (across all domains of all monitor groups) counter assignments
+associated with the mbm_local_bytes event.
+
+k. Now read the local event again. The first read may come back with "Unavailable"
+status. The subsequent read of mbm_local_bytes will display the current value.
+::
+
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
+  Unavailable
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
+  314101
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
index e2e3fc0c5fab..1350fc273258 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -418,6 +418,9 @@ int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v
 ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
 			   loff_t off);
 
+int resctrl_parse_mbm_assignment(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+				 char *event, char *tok);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index ebc049105949..1e4f8e3bedc6 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1311,3 +1311,97 @@ void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
 			rdtgroup_update_cntr_event(r, crgrp, mevt->evtid);
 	}
 }
+
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
+int resctrl_parse_mbm_assignment(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+				 char *event, char *tok)
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
+		return  -ENOENT;
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
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 47716e623a9c..2d2b91cd1f67 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1979,6 +1979,51 @@ static int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file
 	return ret;
 }
 
+static ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf,
+					size_t nbytes, loff_t off)
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
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -2119,9 +2164,10 @@ static struct rftype res_common_files[] = {
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


