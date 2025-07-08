Return-Path: <linux-kernel+bounces-722471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2349CAFDB0D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1287561A72
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6339262FC0;
	Tue,  8 Jul 2025 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hmUr2LyM"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B625DD1C;
	Tue,  8 Jul 2025 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013357; cv=fail; b=iJC1vJDIA7vzNPuLHkQafKVL24CFcTT2MziNmQf5E14P+TyawagJ5CAKHCiRrFDhwaUv1NODnAwgjVImV6Z9t4bi8K525TLOSK4/BGhvRk4IobPbsYvlW6MaHhhxuIh3pQl42GGk9BaUqvoeR+i6eC6S/vecNm3dKGgPL7Ij8nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013357; c=relaxed/simple;
	bh=ZLYKfSwm/yr23wg3fSdL3yuW+R1xNcPeWxL/o47OBkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6rFpFlOYhepNmL3S6ys/JeWNs7KjR85clBz5TRF3DB867M29gRkrgBhi9wlaL4SDV6whZSzikzF8jp4pEck3Zv/yZs2XXj3T6ligbOGEysks5SxLr7tRp/R7uWeYhiZ0YkppmcsU1QMUkFpi2/KnNkM/b9Ioe01wHK6WqQ6qWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hmUr2LyM; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZqmgbSIxoaLYPQvVk47yQSyNNehYp1XEK35ESyKV/IcNEiThLeuHH/WgXu67JFX7QADa6g1tfIlFTRrnH89fyWbwPAr66VI+kvTgF431AE3pPerBAxH/Fo0X9yK982G1CSWHQxP3ftFjlbWeH5LGjOrAoo3hM3AmlrkbhVkeNQ8cayV+t6Ucn26DsqmQv8uBM6PqP7J93tiJKwbVqOK+YgthlKL9XKv0/6S7qABGiTulzZowqaG8ecMZK4JjN+dPWJiASOsZXT9sPYJ+i8XQhETW6HXwFnQMpiQRmUHyR8efZ7aZOMJEAy+oZDKneK0If64usJnb/8DQHU2ack3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oK3uyuiWkTHP12MmTjtNw6FI/ohkhfkhH5cjjnGETg=;
 b=CnnZZOXteyKZ++9V/GOYL2qmsTvBZl0VdcJD4Ri1/d0QjGmugqQw0xeIM8Ev2UveuZut2t00AQpDaDP1dzaGukQOV7qO4WRlzkuwX5OkYt4MdFwfE8yluGESC4gujYQ9j8dVZwZswAYJOa1pv008EuN6lQcbdUdOx4yg4UJcyQWX/x7ICO0RjPeXlL7ElbyIGvlWAFRXbWuYB1geonC+88kSM++mi2SmTbCNAgQLRUIs+rhEjy218qRffZ9lRMmnbxASNDQ2ArLc/xReOGjVChPzjfLOB7N+rT6QbsySZgo9EkN/+N+QgMwHRtvn8ypG0k7WxpuxI0W2r8jZfowX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oK3uyuiWkTHP12MmTjtNw6FI/ohkhfkhH5cjjnGETg=;
 b=hmUr2LyMYrmmf5GlzWJKAKyyTKtvRuaQ6bcL61SyK7gKUVKqfxBCdJ1Z0iOS8aDpFABqxQNQAg5BW73A8tUqVnRsk3/hxpkIds5/o4UZHLxmQTYysdtwmKwk4WOxXlFeR8+boSmKQy8r0FOCTzjomF/ZRvKhyJFPjkIOklU5IwQ=
Received: from BN9PR03CA0300.namprd03.prod.outlook.com (2603:10b6:408:f5::35)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 22:22:31 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::f) by BN9PR03CA0300.outlook.office365.com
 (2603:10b6:408:f5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Tue,
 8 Jul 2025 22:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:22:30 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:22:28 -0500
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
Subject: [PATCH v15 31/34] fs/resctrl: Introduce the interface to modify assignments in a group
Date: Tue, 8 Jul 2025 17:17:40 -0500
Message-ID: <0a646cf184a9113c54518b14a5c94984b36cee2a.1752013061.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752013061.git.babu.moger@amd.com>
References: <cover.1752013061.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 68da87ed-3c7d-49f8-2600-08ddbe6dedf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGpCaHR4U0xLaFdKZ3d2NmR5NUNpOUF6b0ZBYWlHY0VUR1RjNW9iUkZGWFRu?=
 =?utf-8?B?Q3FXYkJvYWNnMCt6NjBZOEVxL05vZGNIaDhGZWIrNXkxQ3poN0tJRzlmT04z?=
 =?utf-8?B?R1FpK3VuS3VaenVML2o2NWJWR1lhVTBTOHh0V2JVN2Ira1FXV0pHTEw0NWk1?=
 =?utf-8?B?bmJSNlY0WVBXWXNlSTYxcnp1RkdhN1Y0a2dEelc1M1AvNmJEc1lETnVHclZh?=
 =?utf-8?B?MDNycnpoVTQ4dm9rUzJmb1dkeU5jdHFoL00wUE41RlY5OUNFb3JkaTE0bDda?=
 =?utf-8?B?b1loUVZ6S1pWZTlIVFdpdnZBdnlNZFQzTERDNXdOTU8vQjFCU1ByLzJSYnFt?=
 =?utf-8?B?WUZ0UXQ4MGJ6VUdhQ0RtYVJGZWVJWmVtYy9USlVWUlZ6OGhFalFlN20xZWlF?=
 =?utf-8?B?NkZmWml4QVhOUTFxdFUvYmdkem5vVkloTGpBSzh1dHdwd2JtQ3dNSkJLa1Ro?=
 =?utf-8?B?UmpVbkE3dzVxZHZQNElUbHhmaTVMYWgrNmdDN3JYNXQ2azZmVUZOMTFUaFJU?=
 =?utf-8?B?U2JidW5mVzlmUndVeG8zYXhOMkJGTGNYZ3NEN09Mb3VxZnN5ZXhhcjc5QjV6?=
 =?utf-8?B?clk3TXBjSndoa2dYR3Boc2RSYzFOWkVvenFhdEd0MVZ0dkdFdU5yTmlzdFpi?=
 =?utf-8?B?aXhXMk1KUW93b3d4aml0WUcycVlWOFlNOXN2WFdxNlpWRmg5V1hNcCsyL1Vs?=
 =?utf-8?B?NDlFUEE2dEMwUUFRZ0ZyUXhzSzFldDVKV1lEeWRjRndKTmdwNnQ4S2tJV0p4?=
 =?utf-8?B?YTdDbWk5SGRCKzFFQmFzK3BCOFNJK0Foa3B6b2ZmakVBWGN5ekMzblVUNnJo?=
 =?utf-8?B?OVlabDI5ODJMYVV3cUxCZ0puem1HMVU1akNqdzhvS3hEVFAvU1NaalVRVk95?=
 =?utf-8?B?WXhWQnBHOElvWitPWUZXNmNLRkw3TW1TM3R5Z2NVWjNBUXJUYTNqZlRmb0dZ?=
 =?utf-8?B?RlFzeTYrK3BOMDFiZ3VVKy91QjRKUlN0RCswMFpKNEh0MXNyV2ErZlE4R2JV?=
 =?utf-8?B?OGI5clJnZFBzMUpIM0tva1dyUk9ldHUrRTdUc3kxVG9nRG5FY2VUSnV2WnB6?=
 =?utf-8?B?MldhZ3BNenZHcjJNNEk2eFFuai9EMElxYzF6T3pZMkNjdGQrdkZOT3N0QmI1?=
 =?utf-8?B?a0dYUitHQjB0QjdNWTc0eDNUVUYzWDF5R3RFbE94NkpwTnU3RjhVc0kydEl1?=
 =?utf-8?B?YlJ1UHNXcGxCYTE0c0FhT2N0WERqemduYURBVk1xbStub3FUM1laMW1odlYv?=
 =?utf-8?B?bjlpQ2s0U281NUtkTjRKMEJVVUc0YjV5U05BUjRxRVoya050ZjRVNHVsNXpu?=
 =?utf-8?B?YUtjZFg2Z1hSOFhKS2JXMTFLVkgyd2VwQlF3elVIT0o2SlQxMlJqNGtTMVhi?=
 =?utf-8?B?NkdIS21ML0JCVC9oZm9Uc2JTVy9TS3pSUTVNYWx5QTFSTUVoU0IxbUhaZjA2?=
 =?utf-8?B?ZE04Umh2UVpsVTFLNGltQVA0VWVSU0F2YnkyWTIzZ00xZjBhM3c3ZytDZElz?=
 =?utf-8?B?WVJ6YTdrbGFtL0xGSkRaa1B4Q01nOVU3ZGRBZFBwbHNYdXRSYnRCTk9vZ1lx?=
 =?utf-8?B?R0djb0ZNUldEZE5PQW9IeERLWTBGM0dTZDJPeGVrWjdZdk1adjlpbTkxc1RK?=
 =?utf-8?B?d2VGRWJaQ1VtNWlUeWdpUDFkUjhjUVRjV3BWbklDanlscVpuU1JHTXZZREF6?=
 =?utf-8?B?YXNPVXJ1NldXczZnb2p2MXJrMTVBNGt4L0dXV2ExcEtHRFJsemVTbXhieU51?=
 =?utf-8?B?R0ZRZnZhRTVBUExBa3NySmZnT0xyWnZlY21nZWNNdDFadDRTQSs3Zk1DekhC?=
 =?utf-8?B?ZERGaGkyU0VVZEJUOUdLazc2R3BjUUFma3dqa2xnQTBtYzVwVlNhRlR0WjAy?=
 =?utf-8?B?dlBWVnAzUmJIeGREOGcwMXNMNGlLdGxhUStRUzVvTTFlU09qYVdQdmZQR0do?=
 =?utf-8?B?UUpHMnkrM1doVVFkSTVmNW1sV1R0cWtzS3R1amxadzdwb1c5UEFBRmVUOEZK?=
 =?utf-8?B?VFlkbDcwS3lnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:22:30.9224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68da87ed-3c7d-49f8-2600-08ddbe6dedf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474

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

    _ : Unassign the counter.

    e : Assign the counter exclusively.

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
 fs/resctrl/internal.h                 |   2 +
 fs/resctrl/monitor.c                  |  18 ++++
 fs/resctrl/rdtgroup.c                 | 123 +++++++++++++++++++++-
 4 files changed, 287 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 4dd1d605d6ad..2b2acb55d8b1 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -527,7 +527,8 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
 	Event: A valid MBM event in the
 	       /sys/fs/resctrl/info/L3_MON/event_configs directory.
 
-	Domain ID: A valid domain ID.
+	Domain ID: A valid domain ID. When writing, '*' applies the changes
+		   to all the domains.
 
 	Assignment states:
 
@@ -544,6 +545,34 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
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
+	To assign the counter associated with the mbm_total_bytes event on all domains in
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
 
@@ -1579,6 +1608,121 @@ View the llc occupancy snapshot::
   # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
   11234000
 
+
+Examples on working with mbm_assign_mode
+========================================
+
+a. Check if MBM counter assignment mode is supported.
+::
+
+  #mount -t resctrl resctrl /sys/fs/resctrl/
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
+d. To list the default group's assign states:
+::
+
+  # cat /sys/fs/resctrl/mbm_L3_assignments
+  mbm_total_bytes:0=e;1=e
+  mbm_local_bytes:0=e;1=e
+
+e.  To unassign the counter associated with the mbm_total_bytes event on domain 0:
+::
+
+  # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
+  # cat /sys/fs/resctrl/mbm_L3_assignments
+  mbm_total_bytes:0=_;1=e
+  mbm_local_bytes:0=e;1=e
+
+f. To unassign the counter associated with the mbm_total_bytes event on all domains:
+::
+
+  # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
+  # cat /sys/fs/resctrl/mbm_L3_assignment
+  mbm_total_bytes:0=_;1=_
+  mbm_local_bytes:0=e;1=e
+
+g. To assign a counter associated with the mbm_total_bytes event on all domains in
+exclusive mode:
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
+i. Check the default event configurations.
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
+  /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
+
+  # cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
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
+m. Unmount the resctrl
+::
+
+  #umount /sys/fs/resctrl/
+
 Intel RDT Errata
 ================
 
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index b42890fd937a..9881674909f2 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -403,6 +403,8 @@ bool closid_allocated(unsigned int closid);
 
 int resctrl_find_cleanest_closid(void);
 
+struct mon_evt *mbm_get_mon_event_by_name(struct rdt_resource *r, char *name);
+
 int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 			       struct mon_evt *mevt);
 void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index e30a867c00bb..61419849b257 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1220,3 +1220,21 @@ void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
 			rdtgroup_update_cntr_event(r, crgrp, mevt->evtid);
 	}
 }
+
+/*
+ * mbm_get_mon_event_by_name() - Return the mon_evt entry for the matching
+ * event name.
+ */
+struct mon_evt *mbm_get_mon_event_by_name(struct rdt_resource *r, char *name)
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
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index dc108c5db298..b26baca389bb 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2071,6 +2071,126 @@ static int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file
 	return ret;
 }
 
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
+	}
+
+	return ret;
+}
+
+static int resctrl_process_assign(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+				  char *event, char *tok)
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
+
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
+		ret = resctrl_process_assign(r, rdtgrp, event, token);
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
@@ -2211,9 +2331,10 @@ static struct rftype res_common_files[] = {
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


