Return-Path: <linux-kernel+bounces-746163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75540B123CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F87179989
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B9E2475C3;
	Fri, 25 Jul 2025 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ndVKyipB"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B43F9C5;
	Fri, 25 Jul 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468225; cv=fail; b=chkmSUqAsNbGBnLqTMbGsOebZIA0kP0/gvgjjmuziuJmCEc+iKRVjsHbpnLlnpMtDe/IMvcfJBF296blG2vB15B+2Qr0ZrGjvWXGmIdG+I68NdltqQClBurC1GJ5BYnL0MveIrMuLJmbjyTFT26+g57IygIDv+uFScWT9UxAt0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468225; c=relaxed/simple;
	bh=PTME2pqGChslD6ytdAQM9MXTnUPhqih9ZBylOuV7amQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bUXR2DiNvUYOzRDKVz0PxSZui8y8LQdZy+4kPgf2yHN1Hr/AebsiiBuMmXURd/FRPFnYvxiZJFd986lmMkEMfKCcnZ9tqV5BfBb9iW0EYfnROW0tnaHpiQ3d3cTKMCBIc/8wy2nplzjMyFSVOuuRhMI3BM5laqtB67BaU1Dor3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ndVKyipB; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkdlIovGpex8N3bUyPCf2tP9/pQpjIUIxvow3WkyvdGK9ueIzXNvp3EfAxQ29vbNzUSooN6MOX0lj7NF3Gnv2aGwPgLJDLRwww3i/NhdCglhS8Zw56fKGsKthUJ4NHdQhwmoxWdyl1Zy1T7QyRw/NkLysC4es5tJxrbVCw3IredmDaJpnJpU6xCM9Q++79aZ/7vm+84MeJp3o+7GEo+cZ7U3KygAEZfY/+V8U345U8qO0+0EumQjqz8ne2Ne/QWlLu3XaxSyAtY+LIcj95vDb5mqtqTgEK0Qsn7hGMURuO5eqzOEnWcx4Ekit+eZF9/4sBhLDv1mkdvpYxoQ9zOxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CbmO/4Vb6ZLiama3kEItkcVvZwlUHnPVLdzhPIHFpM=;
 b=xvz7lPSasv+fh4v6+NEy0LkNTYdU7xCCiMHuYfVb0datFtyoRZbWJpPi3+ag+DMui7kNdUIMqdBKPNSYVYU8eK+nli5hFswBCQPOGQnmde+qTzt7bo5woQrvvL40up8n1sOh4V56OaypHrEKD3ZLqJhEhnX+fzjSkDQjhfTA/9hrUFmAvMCx4PPF5Bv3aH2RRp1zW3ndzV96Meoqb0WqcvNRQMvBrcm6OJvRX7vYz0Q4xGsA0r19xMbU51Zq3IErjnmm+a95ywShZHRhYMiKmq8y2OlTi8GnI3IoH/8CyH8JHHOehlfJveCh14yr4JJLegiBDV6qtK1MZELrVI6usg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CbmO/4Vb6ZLiama3kEItkcVvZwlUHnPVLdzhPIHFpM=;
 b=ndVKyipBYpJSmSACEj2b5dkFwZz+QdKp6kxLi9V739qUrr1BHGlwMVd1HaiWCs1/NiyC3F5DKMT9hnsCMIo4ESUGMGVKqdSapzFUBF+nuE2sp2KRdfHVDK5pygmsqJNiu0sAITFRZloXE1SBt4GXdd7XNVT1bN5A4OQGMUexTiI=
Received: from BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 18:30:15 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::d) by BY3PR05CA0015.outlook.office365.com
 (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.7 via Frontend Transport; Fri,
 25 Jul 2025 18:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:30:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:30:06 -0500
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
Subject: [PATCH v16 00/34] x86,fs/resctrl: Support AMD Assignable Bandwidth Monitoring Counters (ABMC)
Date: Fri, 25 Jul 2025 13:29:19 -0500
Message-ID: <cover.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: c07ce888-f69a-4321-99c1-08ddcba94c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDJsRDFZU0UwdDZSODJLc2FKY1ZMTkNSbVVVL1dyY1NKTWppYnFEUlAzejlL?=
 =?utf-8?B?U1FvVThTcXdJVmd1YXVBVjRMcS96Tmxmcnlub0lWQ01hL1crL1NRc3dnRTk5?=
 =?utf-8?B?MkxTL1N4c2dzWWJnZXJjY2VZNkNNbWlicU1TemxCU01RRmVxZDlLQlF3VGYx?=
 =?utf-8?B?QW1hVndOc3lhbm4yZzc0UHR3aU04UjErUVlETHFKcmV4VkFMVlJUbmdnOWFL?=
 =?utf-8?B?bkdZaGIxYU9mOTU2UlRlVFl6WkVFQUxXYVF6TjFOclo1THNocTJ5VGEvN0FO?=
 =?utf-8?B?dnlKZ1FhK2Z0RXFUVUl6aDBUcFNiRUs3eWFHZ2pHQURiOVkvaW1DK0U3cmFh?=
 =?utf-8?B?L0NydmdLOEszWnFpT1pqRWc1cDZ2MHJKaEdrWHJaSHJPeGRRYlV6eVVRYU1L?=
 =?utf-8?B?L0t4WWdPQ0xERGR6WlVXdmhwVGxGdDArTEdMenJLY2V0K2lFMzNsU1FNQkRx?=
 =?utf-8?B?QmFUT2hPMUdLWDF5ZnhKQlV0UGdvaGsvR2U0MnFzbFZ3MmR3aTVYL3JGWVYy?=
 =?utf-8?B?K0wyQnd2WGxsbE5NNGN4ODlHWTFXL2paNVNOSHdnckQ0YXRJMnZnd1lVdFdP?=
 =?utf-8?B?ODRnZHptb25KRzJNTVF4alhtNkplV3QyZjM0QThIZWJzKzR5ajVGeDVHSjNJ?=
 =?utf-8?B?NUI0cGZIU3BocHEzSkhYNng2WjUzSGM0RFJvS1pIdFpyTysrdXJCLzF4YWg1?=
 =?utf-8?B?aHl5eEtyQ3dUczhHN0YxSW55L0VFb1R4SGg0OCsyS3ptWnRIa0lRMmp4R3Fh?=
 =?utf-8?B?VDhRSi9pdnhlT3pIUjM1eENiY2FIQ2VaSFRCRFA5c0V4VGMyMDhDcUwvL1ZB?=
 =?utf-8?B?ZGhuYWNaNWtubjJYR0FVaWNOQmFhWXZQV0svSDZ3Si9uL3JMMndUbG9qVVAx?=
 =?utf-8?B?M3lkZWk3K09kNktOQXkyN1QvcmY2S2pOU3BRdWhsLzBqRCtVdng4K3hDNU5P?=
 =?utf-8?B?MDk0bHE0bXRkY1RSUkxZam9EU2p4WjY0SlQ3NW1xNjR5NVNmaFNBZDhvM0ZO?=
 =?utf-8?B?VU14NXIvYVIvS1UvNXJKREFRZGk4WVFiOGl5N1diM2U0T2pyMGxxcWNwdzNs?=
 =?utf-8?B?RmpzWCs0T0RNeVcxQjRZRk5va0lGa2lWMzhVWkJtQ0RkY3lyLzhabHMzRHpp?=
 =?utf-8?B?YWc0L3d2UWJNdnV5YS9hWGtMME03clJwOHRkOFU2YlpiTUFDYlhiMkg2SzZ2?=
 =?utf-8?B?RERNMVFLbkd3QXJPaU9ZbUVEN2RyUHlOTWVaYzNGcU5sVFZmTVNGVG1LQmdn?=
 =?utf-8?B?bHJlMFBsYWMzd054ZGNtb3NwYmpLY3dCM1ZHQ0JrdXY0TkpVWTF3a2R0Wi9u?=
 =?utf-8?B?L2JVQVZHWTdsV1pGOWNSZGNQTTYrMzNvNm5oUVBtbHJmS0E0K2xMQisxc1Zq?=
 =?utf-8?B?NTUzblZDVW9XM1I1L1FuY2dtZTJJUFFxeDkvYWtIQThiMTg1WkNxN1Yyb0dj?=
 =?utf-8?B?cXNkN3VoMllockRINkh1SnVIVVFnUXprdUhLNTRnWWlyZytSbGhPcG9UWEo1?=
 =?utf-8?B?OEp4UjZERVBSQy9TSW5lRmk5N3RQYWdCRnpZWHZUc2wzSFJkMjJicTUyQzNI?=
 =?utf-8?B?b0JuS3BQT1QxYnVoTy9lMlAxelR1NEY4ZGl2WmZiVzcxL1pZWEFJbE9pbVBS?=
 =?utf-8?B?OXFiaHBiUFR2bFo0MUJsVkFpRG5LaEJKN2VTRTdNRTR4VFpIeU1HSmQxcnFZ?=
 =?utf-8?B?UFBYQ3ZRM0wwZkJXNXNzNlFTUW1xeHAvZG9KV3RSZDIzWjcvRU4xUWdMclRB?=
 =?utf-8?B?NWVwWmE4MDdIVjA3VkRTSUVaaXFyN2JNU3BqRkdTU0ZuSFIrUjNpcXpRQzZ4?=
 =?utf-8?B?c2ptd2JNbEpxd2dPWHFSNDU4cWdBR2M2eGlrZjIxY2p1ZElMa1JxaTlIU2lW?=
 =?utf-8?B?N2YvZ1BlRmhKM3ZBNTBTSjZvdllRRU1BTUFmVnlxZUtQNUlKeFpSOUl4blVp?=
 =?utf-8?B?RVVQT1pnREpRajJYbjBvVnBjMXdxTkhNQ05wUUcrU2s0UHRmVnRWOFBGVmNX?=
 =?utf-8?B?Y1d3U1UwWGNBOEFsRGxEd2haMVRacXI5Wmd2TU1KZmF1QXNlRUJobUt0Vy9D?=
 =?utf-8?B?eU9FWUJJcjMvYVlFQ2IwQjVrZ0pYZHAvQ1B6UT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:30:14.9490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c07ce888-f69a-4321-99c1-08ddcba94c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634


This series adds the support for Assignable Bandwidth Monitoring Counters
(ABMC). It is also called QoS RMID Pinning feature.

Series is written such that it is easier to support other assignable
features supported from different vendors.

The feature details are documented in the  APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC). The documentation is available at
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

The patches are based on top of commit (6.16.0-rc7)
commit 34481698fd9c ("Merge branch into tip/master: 'x86/sev'")

# Introduction

Users can create as many monitor groups as RMIDs supported by the hardware.
However, the bandwidth monitoring feature on AMD systems only guarantees
that RMIDs currently assigned to a processor will be tracked by hardware.
The counters of any other RMIDs which are no longer being tracked will be
reset to zero. The MBM event counters return "Unavailable" for the RMIDs
that are not tracked by hardware. So, there can be only limited number of
groups that can give guaranteed monitoring numbers. With ever changing
configurations there is no way to definitely know which of these groups
are being tracked during a particular time. Users do not have the option
to monitor a group or set of groups for a certain period of time without
worrying about counters being reset in between.
    
The ABMC feature allows users to assign a hardware counter ID to an RMID,
event pair and monitor bandwidth usage as long as it is assigned. The
hardware continues to track the assigned counter until it is explicitly
unassigned by the user. Additionally, the user can specify the type of
memory transactions (e.g., reads, writes) to be tracked by the counter
for the assigned RMID.

Without ABMC enabled, monitoring will work in current 'default' mode without
assignment option.

# History

Earlier implementation of ABMC had dependancy on BMEC (Bandwidth Monitoring
Event Configuration). Peter had concerns with that implementation because
it may be not be compatible with ARM's MPAM.

Here are the threads discussing the concerns and new interface to address the concerns.
https://lore.kernel.org/lkml/CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com/
https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/

Here are the finalized requirements based on the discussion:

*   BMEC and ABMC are incompatible with each other. They need to be mutually exclusive.

*   Eliminate global assignment listing. The interface
    /sys/fs/resctrl/info/L3_MON/mbm_assign_control is no longer required.

*   Create the configuration directories at /sys/fs/resctrl/info/L3_MON/counter_configs/.
    The configuration file names should be free-form, allowing users to create them as needed.

*   Perform assignment listing at the group level by introducing mbm_L3_assignments
    in each monitoring group level. The listing should provide the following details:

    Event Configuration: Specifies the event configuration applied. This will be crucial
    when "mkdir" on event configuration is added in the future, leading to the creation
    of mon_data/mon_l3_*/<event configuration>.

    Domains: Identifies the domains where the configuration is applied, supporting multi-domain setups.

    Assignment Type: Indicates whether the assignment is Exclusive (e or d), Shared (s), or Unassigned (_).

    Exclusive assignment: Assign the counter ID the RMID, event pair exclusively.
    
    Shared assignment: A shared assignment applies to both soft-ABMC and ABMC. A user can designate a
                       "counter" (could be hardware counter or "active" RMID) as shared and that means
                       the counter within that domain is shared between different monitor groups and actual
                       assignment is scheduled by resctrl.  

    Unassigned: No longer assigned.

*   Provide option to enable or disable auto assignment when new group is created.

*   Keep the flexibility to support future assign options like Soft-ABMC etc.
    https://lore.kernel.org/lkml/7f10fa69-d1fe-4748-b10c-fa0c9b60bd66@intel.com/
    

This series addresses the requirements listed above and keeping the options open for future
enhancements.

# Implementation details

Create a generic interface to support user space assignment of scarce
counters used for monitoring. First usage of interface is by ABMC with option
to expand usage to "soft-ABMC" and MPAM counters in future.

Feature adds following interface files:

/sys/fs/resctrl/info/L3_MON/mbm_assign_mode: Reports the list of assignable
monitoring features supported. The enclosed brackets indicate which
feature is enabled.

/sys/fs/resctrl/info/L3_MON/num_mbm_cntrs: The maximum number of monitoring counters
(total of available and assigned counters) in each domain when the system supports
mbm_event mode.

/sys/fs/resctrl/info/L3_MON/available_mbm_cntrs: The number of monitoring counters
available for assignment in each domain when mbm_event mode is enabled on the system.

/sys/fs/resctrl/info/L3_MON/event_configs: Contains sub-directory for each MBM event
					   that can be assigned to a counter.

/sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter: The type of
			memory transactions tracked by the event mbm_total_bytes.

/sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter: The type of
			memory transactions tracked by the event mbm_local_bytes.

/sys/fs/resctrl/mbm_L3_assignments: Per monitor group interface to list or modify
				    counters assigned to the group.

# Examples

a. Check if MBM assign support is available
	#mount -t resctrl resctrl /sys/fs/resctrl/

	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
	[mbm_event]
	default

	mbm_event feature is detected and it is enabled.

b. Check how many assignable counters are supported. 

	# cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs 
	0=32;1=32

c. Check how many assignable counters are available for assignment in each domain.

	# cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs 
	0=30;1=30

d. Check the default event configuration.

	# cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter 
	local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_writes,
        local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all

	# cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter 
	local_reads,local_non_temporal_writes,local_reads_slow_memory

e. Series adds a new interface file "mbm_L3_assignments" in each monitoring group
   to list and modify that group's monitoring states.

	The list is displayed in the following format:

	<Event>:<Domain id>=<Assignment state>;<Domain id>=<Assignment state>

        Event: A valid MBM event listed in the
        /sys/fs/resctrl/info/L3_MON/event_configs directory.

        Domain ID: A valid domain ID.

        Assignment types:

        _ : No counter assigned.

        e : Counter assigned exclusively.

	To list the default group states:
	# cat /sys/fs/resctrl/mbm_L3_assignments
	mbm_total_bytes:0=e;1=e
	mbm_local_bytes:0=e;1=e

	To unassign the counter associated with the mbm_total_bytes event on domain 0:
	# echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
	# cat /sys/fs/resctrl/mbm_L3_assignments
	mbm_total_bytes:0=_;1=e
	mbm_local_bytes:0=e;1=e

	To unassign the counter associated with the mbm_total_bytes event on all domains:
    	# echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
	# cat /sys/fs/resctrl/mbm_L3_assignment
	mbm_total_bytes:0=_;1=_
	mbm_local_bytes:0=e;1=e

	To assign a counter associated with the mbm_total_bytes event on all domains in exclusive mode:
    	# echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
	# cat /sys/fs/resctrl/mbm_L3_assignments
	mbm_total_bytes:0=e;1=e
	mbm_local_bytes:0=e;1=e

g. Read the events mbm_total_bytes and mbm_local_bytes of the default group.
   There is no change in reading the events with the assignment.  If the event is unassigned
   when reading, then the read will come back as "Unassigned".
	
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	779247936
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
	765207488
	
h. Check the event configurations.

	# cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
	local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_writes,
	local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all

	# cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
	local_reads,local_non_temporal_writes,local_reads_slow_memory

i. Change the event configuration for mbm_local_bytes.

	# echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
	/sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter

	# cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
	local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
	
	This will update all (across all domains of all monitor groups) counter assignments 
        associated with the mbm_local_bytes event.

j. Now read the local event again. The first read may come back with "Unavailable"
   status. The subsequent read of mbm_local_bytes will display the current value.
	
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
	Unavailable
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
	314101

k. Users have the option to go back to 'default' mbm_assign_mode if required.
   This can be done using the following command. Note that switching the
   mbm_assign_mode will reset all the MBM counters (and thus all MBM events) of all
   the resctrl groups.

	# echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
	mbm_event
	[default]
	
l. Unmount the resctrl filesystem.
	 
	# umount /sys/fs/resctrl/
---
v16:
    Picked up first four patches from (Tony):
    https://lore.kernel.org/lkml/20250711235341.113933-1-tony.luck@intel.com/
    These patches have already been reviewed.

    Updated Reviewed-by: tag for few patches.

    Fixed the conflicts with latest cpufeatures.h and scattered.c files.

    Added a new check in get_rdt_mon_resources().
    Added check in resctrl_is_mon_event_enabled() before enabling.

    Resetting the architectural state in resctrl_arch_config_cntr() in both
    assign and unassign cases now.

    Function renames:
    resctrl_config_cntr() -> rdtgroup_assign_cntr()
    rdtgroup_alloc_config_cntr() -> rdtgroup_alloc_assign_cntr()

    Passed struct mevt to rdtgroup_alloc_assign_cntr so it can print event name on failure.

    Function rename:
      rdtgroup_free_config_cntr() -> rdtgroup_free_unassign_cntr().

    Updated rdtgroup_free_unassign_cntr() to pass struct mon_evt to match
    rdtgroup_alloc_assign_cntr() prototype.

    Removed lots of copied and unnecessary text from resctrl.h.
    Also removed references to LLC occupancy.
    Removed arch_mon_ctx from resctrl_arch_cntr_read().

    Renamed get_corrected_val() -> get_corrected_val().
     
    Removed the call resctrl_arch_rmid_read_context_check();
    Added the text about RMID_VAL_UNAVAIL error.

    Squashed two patches into one.
     https://lore.kernel.org/lkml/df215f02db88cad714755cd5275f20cf0ee4ae26.1752013061.git.babu.moger@amd.com/
     https://lore.kernel.org/lkml/296c435e9bf63fc5031114cced00fbb4837ad327.1752013061.git.babu.moger@amd.com/

    Changed is_cntr field in struct rmid_read to is_mbm_cntr.
    Fixed the memory leak with arch_mon_ctx.
    Updated the resctrl.rst user doc.

    Report Unassigned only if none of the events in CTRL_MON and MON are assigned.
      
    Moved event_filter_show() to fs/resctrl/monitor.c

    Added rdtgroup_mutex in event_filter_show().
    Removed extern for mbm_transactions. Not required.
          
    Moved resctrl_process_configs() and event_filter_write() to fs/resctrl/monitor.c.

    Renamed resctrl_process_configs() -> resctrl_parse_mem_transactions().

    Fixed the return in resctrl_mbm_assign_on_mkdir_write().

    Moved r->mon.mbm_assign_on_mkdir initialization to resctrl_mon_resource_init().

    Updated resctrl.rst few corrections and consistancy.

    Fixed few references of counter_configs to -> event_configs.
    Renamed resctrl_process_assign() to resctrl_parse_mbm_assignment().
    Moved resctrl_parse_mbm_assignment() and rdtgroup_modify_assign_state() to monitor.c.

    Added new comment in resctrl_bmec_files_show() about kernfs_find_and_get failure.
    Added the parameter to resctrl_bmec_files_show() to pass the kernfs_node.
    Updated resctrl_bmec_files_show() to pass NULL for kn_fs_node.

    Added a patch to add me as a reviewer on Reinette's suggestion.

v15:
  1-4  Picked up Tony's tree. This will be base for both the series.
  rdt-aet-v5.5 branch of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
  After Reinette's comment on previous version.
  https://lore.kernel.org/lkml/e9eb906f-d463-4c1e-9e15-5ed795fe5366@intel.com/
  https://lore.kernel.org/lkml/b761e6ec-a874-4d06-8437-a3a717a91abb@intel.com/

  Improved changelog in most of the patches. Thanks to Reinette.
  Improved the code comment in few places.

  Fixed the enumeration code by adding check in resctrl_cpu_detect() during the init.
  Moved the fs related enumeration to resctrl_mon_resource_init().

  Removed evt_cfg from struct mbm_cntr_cfg based on the discussion.
  https://lore.kernel.org/lkml/887bad33-7f4a-4b6d-95a7-fdfe0451f42b@intel.com/

  Removed resctrl_set_mon_evt_cfg().
  Moved the event initialization to resctrl_mon_resource_init().

  Changed few goto labels for consistency.

  Added extra check !r->mon.mbm_cntr_assignable in mbm_cntr_get() to return error.

  Added two new arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr() implement
  mbm_event mode. This is kind of major change in this series.
  https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/

  Added is_cntr in rmid_read to implement resctrl_arch_cntr_read() and resctrl_arch_reset_cntr().

  Removed the error setting in rdtgroup_mondata_show(). It is already done in mon_event_read()
  based on the discussion.
  https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/

  Changed the function name resctrl_mkdir_counter_configs() to resctrl_mkdir_event_configs().
  Called resctrl_mkdir_event_configs from rdtgroup_mkdir_info_resdir().
  It avoids the call kernfs_find_and_get() to get the node for info directory.
  Used for_each_mon_event() where applicable.

  Fixed the partial initialization of val in resctrl_process_configs().
  Passed mon_evt where applicable. The struct rdt_resource can be obtained from mon_evt::rid.

  Fixed the static checker warning in resctrl_mbm_assign_on_mkdir_write() reported in
  https://lore.kernel.org/lkml/dd4a1021-b996-438e-941c-69dfcea5f22a@intel.com/

  Moved resctrl_bmec_files_show() inside rdtgroup_mkdir_info_resdir().

v14:
   Patch #1 is already been reviewed. Not need to review.

   Patches # 2-5:
   This is Tony's work. This is part of Tony's telemetry series.
   https://lore.kernel.org/lkml/20250521225049.132551-1-tony.luck@intel.com/

   Tony made special update for me to include in this series.
   https://lore.kernel.org/lkml/20250609162139.91651-1-tony.luck@intel.com/.
   We both are going to carry thesse mutliple events support patches.

   Patches #6-31 are changes related to mbm_assign_mode. 

   Took time to check all the text comments. Taken care most of comments.
   Anything missing is not intentional. ):

   Removed the dependancy on X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL
   as discussed in https://lore.kernel.org/lkml/5f8b21c6-5166-46a6-be14-0c7c9bfb7cde@intel.com/
   Reworked on ABMC enumeration during the init.

   Updated the code comment in resctrl.h on all the prototypes.

   Added lockdep_assert_cpus_held() in _resctrl_abmc_enable().
   Removed inline for resctrl_arch_mbm_cntr_assign_enabled().
   Added prototype descriptions for resctrl_arch_mbm_cntr_assign_enabled()
   and resctrl_arch_mbm_cntr_assign_set() in include/linux/resctrl.h.
   
   Changed the name of the monitor mode to mbm_event_assign based on the discussion.
   https://lore.kernel.org/lkml/7628cec8-5914-4895-8289-027e7821777e@amd.com/
   Updated resctrl.rst for mbm_event mode.
   Changed subject line to fs/resctrl in few patches.

   Removed BMEC reference internal.h. 

   Removed mbm_mode in mon_evt data structure as it is not required anymore.
   Added resctrl_get_mon_evt_cfg() and resctrl_set_mon_evt_cfg().

   Removed evt_cfg parameter in resctrl_arch_config_cntr(). Get evt_cfg only
   when assign is required.

   Updated the code documentation for mbm_cntr_alloc() and  mbm_cntr_get().
   Passed struct mon_evt to resctrl_assign_cntr_event() that way to avoid
   back and forth calls to get event details.

   Passing the struct mon_evt to resctrl_free_config_cntr() and removed
   the need for mbm_get_mon_event() call.
   Corrected the code documentation for mbm_cntr_free().

   Added WARN_ON_ONCE() when cntr_id < 0.
   Improved code documentation in include/linux/resctrl.h.
   Added the check in mbm_update() to skip overflow handler when counter is unassigned.

   Changed the term memory events to memory transactions to be consistant.

   Changed the name of directory to event_configs from counter_config.
   Updated user doc about the memory transactions supported by assignment.

   Renamed few functions resctrl_group_assign() -> rdtgroup_assign_cntr()
   resctrl_update_assign() -> resctrl_assign_cntr_allrdtgrp()

   Added rdtgroup_mutex in resctrl_mbm_assign_on_mkdir_show().

   Fixed the problem reported by Peter.
   https://lore.kernel.org/lkml/CALPaoCjvUSKLKOXzF85j8mHT=eZYM-7R0=gJ3PRgOk4yuF5ZhQ@mail.gmail.com/
   Updated the changelog.
   
   Added check in rdt_mon_features_show to hide bmec related feature.

   Added the call resctrl_bmec_files_show() to enable/disable files
   related to BMEC monitor mode is changed.

   Added resctrl_set_mon_evt_cfg() to reset event configuration values
   when mode is changes.

   Changed the name of the mbm_assign_mode's supported to mbm_event or default.
   https://lore.kernel.org/lkml/9b08ab86-22d2-40c1-be20-fcc73ee98b3d@amd.com/

   Added example section in user doc (resctrl.rst) on how to use mbm_assign_modes.

v13:
   Removed BMEC related 2 patches which were in the previous series.
   It was related to optimization which can be doen later.

   Patches are created on top of FS/ARCH restructure. So, major changes
   are due to FS/ARCH restructure. The files are split between
   arch/x86/kernel/cpu/resctrl/ and fs/resctrl/. So, functions
   are moved between these files accordingly.

   Added fflag RFTYPE_RES_CACHE for mbm_assign_mode, num_mbm_cntrs, available_mbm_cntrs.

   Removed the references to "mbm_assign_control".
  
   Moved resctrl_arch_config_cntr() prototype to include/linux/resctrl.h.
   Changed resctrl_arch_config_cntr() to retun void from int to simplify few call
   sequences.

   Added the event configuration details inside the evt_list in monitor domains.
   The avoids the need for new structure mbm_assign_config. 

   Passed evtid to functions resctrl_alloc_config_cntr() and resctrl_assign_cntr_event().
   Event configuration value can be easily obtained from mon_evt list.

   Added new patch to pass the entire struct rdtgroup to __mon_event_count(),
   mbm_update(), and related functions. We can easily get RMID,CLOSID etc from rdtgroup.

   Added new function __cntr_id_read_phys() to handle ABMC event reading.

   Added a new patch to hide BMEC related files when mbm_cntr_assign mode is enabled..
  
   Added the call resctrl_init_evt_configuration() to setup the event configuration during init.

   And few other commit message updates and user doc updates.

   Removed Reviewed-by from few patches as patches have changed due to FS/ARCH restructure.

   Let me know if I missed something.

v12:
   This version is kind of RFC series with a new interface.
   
   Removed Reviewed-by tag on few patches when the patch has changed.

   Moved BMEC related patches (1 and 2) to beginning of the series.
   Removed the dependancy on BMEC to ABMC feature.

   Removed the un-necessary initialization of mon_config_info structure.
   Changed wrmsrl instead of wrmsr to address the below comment.
   https://lore.kernel.org/lkml/0fc8dbd4-07d8-40bd-8eec-402b48762807@zytor.com/

   Fixed the conflicts due to recent changes in rdt_resource data structure.
   Added new mbm_cfg_mask field to resctrl_mon.
   
   Added the code to reset arch state inside _resctrl_abmc_enable().

   Added the check CONFIG_RESCTRL_ASSIGN_FIXED to take care of arm platforms.
   This will be defined only in arm and not in x86.

   Changed the code to display the max supported monitoring counters in each domain.
   
   Fixed the struct mbm_cntr_cfg code documentation.
   Moved the struct mbm_cntr_cfg definition to resctrl/internal.h as suggested by James.

   Replaced seq_puts(s, ";") with seq_putc(s, ';');
   Added missing rdt_last_cmd_clear() in resctrl_available_mbm_cntrs_show().

   Added the check to reset the architecture-specific state only when assign is requested.

   Added evt_cfg as the parameter to resctrl_arch_config_cntr() as the user will
   be passing the event configuration from /info/L3_MON/event_configs/.

   Changed the check in resctrl_alloc_config_cntr() to reduce the indentation.
   Fixed the handling error on first failure while assigning.
   Added new parameter event configuration (evt_cfg) to get the event configuration from user space.

   Added tte support for reading ABMC counters. This is bit involved change and affects lots of code.

   New patch to support event configurations via new counter_configs method.

   Removed mbm_cntr_reset() as it is not required while removing the group.

   Added new patch to handle auto assign on group creation ("mbm_assign_on_mkdir")

   Added couple of patches add interface for "mbm_L3_assignments" on each mon group.

   Introduced mbm_cntr_free_all() and resctrl_reset_rmid_all() to clear counters and
   non-architectural states when monitor mode is changed.
   https://lore.kernel.org/lkml/b60b4f72-6245-46db-a126-428fb13b6310@intel.com/

   Moved the resctrl_arch_mbm_cntr_assign_set_one to domain_add_cpu_mon().

   Patches 17, 18, 19, 20, 21, 23, 24 are completely new to address the new interface requirement.

v11:
   The commit 2937f9c361f7a ("x86/resctrl: Introduce resctrl_file_fflags_init() to initialize fflags")
   is already merged. Removed from the series.
   
   Resolved minor conflicts due to code displacement in latest code.
 
   Moved the monitoring related calls to monitor.c file when possible.
   Moved some of the changes from include/linux/resctrl.h to arch/x86/kernel/cpu/resctrl/internal.h
   as requested by Reinette. This changes will be moved back when arch and non code is separated.
   
   Renamed rdtgroup_mbm_assign_mode_show() to resctrl_mbm_assign_mode_show().
   Renamed rdtgroup_num_mbm_cntrs_show() to resctrl_num_mbm_cntrs_show().

   Moved the mon_config_info structure definition to internal.h.
   Moved resctrl_arch_mon_event_config_get() and resctrl_arch_mon_event_config_set()
   to monitor.c file.

   Moved resctrl_arch_assign_cntr() and resctrl_abmc_config_one_amd() to monitor.c.
   Added the code to reset the arch state in resctrl_arch_assign_cntr().
   Also removed resctrl_arch_reset_rmid() inside IPI as the counters are reset from the callers.

   Renamed rdtgroup_assign_cntr_event() to resctrl_assign_cntr_event().
   Refactored the resctrl_assign_cntr_event().
   Added functionality to exit on the first error during assignment.
   Simplified mbm_cntr_free().
   Removed the function mbm_cntr_assigned(). Will be using mbm_cntr_get() to
   figure out if the counter is assigned or not.
   
   Renamed rdtgroup_unassign_cntr_event() to resctrl_unassign_cntr_event().
   Refactored the resctrl_unassign_cntr_event().

   Moved mbm_cntr_reset() to monitor.c.
   Added code reset non-architectural state in mbm_cntr_reset().
   Added missing rdtgroup_unassign_cntrs() calls on failure path.

   Domain can be NULL with SNC support so moved the unassign check in rdtgroup_mondata_show().

   Renamed rdtgroup_mbm_assign_mode_write() to resctrl_mbm_assign_mode_write().
   Added more details in resctrl.rst about mbm_cntr_assign mode.
   Re-arranged the text in resctrl.rst file in section mbm_cntr_assign.

   Moved resctrl_arch_mbm_cntr_assign_set_one() to monitor.c

   Added non-arch RMID reset in mbm_config_write_domain().
   Removed resctrl_arch_reset_rmid() call in resctrl_abmc_config_one_amd(). Not required
   as reset of arch and non-arch rmid counters done from the callers. It simplies the IPI code.

   Fixed printing the separator after each domain while listing the group assignments.
   Renamed rdtgroup_mbm_assign_control_show to resctrl_mbm_assign_control_show().

   Fixed the static check warning with initializing dom_id in resctrl_process_flags()

   Added change log in each patch for specific changes.

v10:
   Major change is related to domain specific assignment.
   Added struct mbm_cntr_cfg inside mon domains. This will handle
   the domain specific assignments as discussed in below.
   https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
   I did not see the need to add cntr_id in mbm_state structure. Not used in the code.
   Following patches take care of these changes.
   Patch 12, 13, 15, 16, 17, 18.
   
   Added __init attribute to cache_alloc_hsw_probe(). Followed function
   prototype rules (preferred order is storage class before return type).
   
   Moved the mon_config_info structure definition to resctrl.h
   
   Added call resctrl_arch_reset_rmid() to reset the RMID in the domain inside IPI call
   resctrl_abmc_config_one_amd.
   
   SMP and non-SMP call support is not required in resctrl_arch_config_cntr with new
   domain specific assign approach/data structure.
   
   Assigned the counter before exposing the event files.
   Moved the call rdtgroup_assign_cntrs() inside mkdir_rdt_prepare_rmid_alloc().
   This is called both CNTR_MON and MON group creation.
   
   Call mbm_cntr_reset() when unmounted to clear all the assignments.
   
   Fixed the issue with finding the domain in multiple iterations in rdtgroup_process_flags().
   
   Printed full error message with domain information when assign fails.
   
   Taken care of other text comments in all the patches. Patch specific changes are in each patch.
   
   If I missed something please point me and it is not intentional.

v9:
   Patch 14 is a new addition. 
   Major change in patch 24.
   Moved the fix patch to address __init attribute to begining of the series.
   Fixed all the call sequences. Added additional Fixed tags.

   Added Reviewed-by where applicable.

   Took care of couple of minor merge conflicts with latest code.
   Re-ordered the MSR in couple of instances.
   Added available_mbm_cntrs (patch 14) to print the number of counter in a domain.

   Used MBM_EVENT_ARRAY_INDEX macro to get the event index.
   Introduced rdtgroup_cntr_id_init() to initialize the cntr_id

   Introduced new function resctrl_config_cntr to assign the counter, update
   the bitmap and reset the architectural state.
   Taken care of error handling(freeing the counter) when assignment fails.
  
   Changed rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to return void.
   Updated couple of rdtgroup_unassign_cntrs() calls properly.

   Fixed problem changing the mode to mbm_cntr_assign mode when it is
   not supported. Added extra checks to detect if systems supports it.
   
   https://lore.kernel.org/lkml/03b278b5-6c15-4d09-9ab7-3317e84a409e@intel.com/
   As discussed in the above comment, introduced resctrl_mon_event_config_set to
   handle IPI. But sending another IPI inside IPI causes problem. Kernel
   reports SMP warning. So, introduced resctrl_arch_update_cntr() to send the
   command directly.

   Fixed handling special case '//0=' and '//".
   Removed extra strstr() call in rdtgroup_mbm_assign_control_write().
   Added generic failure text when assignment operation fails.
   Corrected user documentation format texts.

v8:
  Patches are getting into final stages. 
  Couple of changes Patch 8, Patch 19 and Patch 23.
  Most of the other changes are related to rename and text message updates.

  Details are in each patch. Here is the summary.

  Added __init attribute to dom_data_init() in patch 8/25.
  Moved the mbm_cntrs_init() and mbm_cntrs_exit() functionality inside
  dom_data_init() and dom_data_exit() respectively.

  Renamed resctrl_mbm_evt_config_init() to arch_mbm_evt_config_init()
  Renamed resctrl_arch_event_config_get() to resctrl_arch_mon_event_config_get().
          resctrl_arch_event_config_set() to resctrl_arch_mon_event_config_set().

  Rename resctrl_arch_assign_cntr to resctrl_arch_config_cntr.
  Renamed rdtgroup_assign_cntr() to rdtgroup_assign_cntr_event().
  Added the code to return the error if rdtgroup_assign_cntr_event fails.
  Moved definition of MBM_EVENT_ARRAY_INDEX to resctrl/internal.h.
  Renamed rdtgroup_mbm_cntr_is_assigned to mbm_cntr_assigned_to_domain
  Added return error handling in resctrl_arch_config_cntr().
  Renamed rdtgroup_assign_grp to rdtgroup_assign_cntrs.
  Renamed rdtgroup_unassign_grp to rdtgroup_unassign_cntrs.
  Fixed the problem with unassigning the child MON groups of CTRL_MON group.
  Reset the internal counters after mbm_cntr_assign mode is changed.
  Renamed rdtgroup_mbm_cntr_reset() to mbm_cntr_reset()
  Renamed resctrl_arch_mbm_cntr_assign_configure to
            resctrl_arch_mbm_cntr_assign_set_one.

  Used the same IPI as event update to modify the assignment.
  Could not do the way we discussed in the thread.
  https://lore.kernel.org/lkml/f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com/
  Needed to figure out event type to update the configuration.

  Moved unassign first and assign during the assign modification.
  Assign none "_" takes priority. Cannot be mixed with other flags.
  Updated the documentation and .rst file format. htmldoc looks ok.

v7:
   Major changes are related to FS and arch codes separation.
   Changed few interface names based on feedback.
   Here are the summary and each patch contains changes specific the patch.

   Removed WARN_ON for num_mbm_cntrs. Decided to dynamically allocate the bitmap.
   WARN_ON is not required anymore.
 
   Renamed the function resctrl_arch_get_abmc_enabled() to resctrl_arch_mbm_cntr_assign_enabled().

   Merged resctrl_arch_mbm_cntr_assign_disable, resctrl_arch_mbm_cntr_assign_disable
   and renamed to resctrl_arch_mbm_cntr_assign_set(). Passed the struct rdt_resource
   to these functions.

   Removed resctrl_arch_reset_rmid_all() from arch code. This will be done from FS the caller.

   Updated the descriptions/commit log in resctrl.rst to generic text. Removed ABMC references.
   Renamed mbm_mode to mbm_assign_mode.
   Renamed mbm_control to  mbm_assign_control.
   Introduced mutex lock in rdtgroup_mbm_mode_show().
 
   The 'legacy' mode is called 'default' mode. 

   Removed the static allocation and now allocating bitmap mbm_cntr_free_map dynamically.

   Merged rdtgroup_assign_cntr(), rdtgroup_alloc_cntr() into one.
   Merged rdtgroup_unassign_cntr(), rdtgroup_free_cntr() into one.
   
  Added struct rdt_resource to the interface functions resctrl_arch_assign_cntr ()
  and resctrl_arch_unassign_cntr().
  Rename rdtgroup_abmc_cfg() to resctrl_abmc_config_one_amd().
   
  Added a new patch to fix counter assignment on event config changes.

  Removed the references of ABMC from user interfaces.

  Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
  Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.

  Thomas Gleixner asked us to update  https://gitlab.com/x86-cpuid.org/x86-cpuid-db. 
  It needs internal approval. We are working on it.

v6:
  We still need to finalize few interface details on mbm_assign_mode and mbm_assign_control
  in case of ABMC and Soft-ABMC. We can continue the discussion with this series.

  Added support for domain-id '*' to update all the domains at once.
  Fixed assign interface to allocate the counter if counter is
  not assigned.   
  Fixed unassign interface to free the counter if the counter is not
  assigned in any of the domains.

  Renamed abmc_capable to mbm_cntr_assignable.

  Renamed abmc_enabled to mbm_cntr_assign_enabled.
  Used msr_set_bit and msr_clear_bit for msr updates.
  Renamed resctrl_arch_abmc_enable() to resctrl_arch_mbm_cntr_assign_enable().
  Renamed resctrl_arch_abmc_disable() to resctrl_arch_mbm_cntr_assign_disable().

  Changed the display name from num_cntrs to num_mbm_cntrs.

  Removed the variable mbm_cntrs_free_map_len. This is not required.
  Removed the call mbm_cntrs_init() in arch code. This needs to be done at higher level.
  Used DECLARE_BITMAP to initialize mbm_cntrs_free_map.
  Removed unused config value definitions.

  Introduced mbm_cntr_map to track counters at domain level. With this
  we dont need to send MSR read to read the counter configuration.

  Separated all the counter id management to upper level in FS code.

  Added checks to detect "Unassigned" before reading the RMID.

  More details in each patch.

v5:
  Rebase changes (because of SNC support)

  Interface changes.
   /sys/fs/resctrl/mbm_assign to /sys/fs/resctrl/mbm_assign_mode.
   /sys/fs/resctrl/mbm_assign_control to /sys/fs/resctrl/mbm_assign_control.

  Added few arch specific routines.
  resctrl_arch_get_abmc_enabled.
  resctrl_arch_abmc_enable.
  resctrl_arch_abmc_disable.

  Few renames
   num_cntrs_free_map -> mbm_cntrs_free_map
   num_cntrs_init -> mbm_cntrs_init
   arch_domain_mbm_evt_config -> resctrl_arch_mbm_evt_config

  Introduced resctrl_arch_event_config_get and
    resctrl_arch_event_config_set() to update event configuration.

  Removed mon_state field mongroup. Added MON_CNTR_UNSET to initialize counters.

  Renamed ctr_id to cntr_id for the hardware counter.
 
  Report "Unassigned" in case the user attempts to read the events without assigning the counter.
  
  ABMC is enabled during the boot up. Can be enabled or disabled later.

  Fixed opcode and flags combination.
    '=_" is valid.
    "-_" amd "+_" is not valid.

 Added all the comments as far as I know. If I missed something, it is not intentional.

v4: 
  Main change is domain specific event assignment.
  Kept the ABMC feature as a default.
  Dynamcic switching between ABMC and mbm_legacy is still allowed.
  We are still not clear about mount option.
  Moved the monitoring related data in resctrl_mon structure from rdt_resource.
  Fixed the display of legacy and ABMC mode.
  Used bimap APIs when possible.
  Removed event configuration read from MSRs. We can use the
  internal saved data.(patch 12)
  Added more comments about L3_QOS_ABMC_CFG MSR.
  Added IPIs to read the assignment status for each domain (patch 18 and 19)
  More details in each patch.

v3:
   This series adds the support for global assignment mode discussed in
   the thread. https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
   Removed the individual assignment mode and included the global assignment interface.
   Added following interface files.
   a. /sys/fs/resctrl/info/L3_MON/mbm_assign
      Used for displaying the current assignment mode and switch between
      ABMC and legacy mode.
   b. /sys/fs/resctrl/info/L3_MON/mbm_assign_control
      Used for lising the groups assignment mode and modify the assignment states.
   c. Most of the changes are related to the new interface.
   d. Addressed the comments from Reinette, James and Peter.
   e. Hope I have addressed most of the major feedbacks discussed. If I missed
      something then it is not intentional. Please feel free to comment.
   f. Sending this as an RFC as per Reinette's comment. So, this is still open
      for discussion.

v2:
   a. Major change is the way ABMC is enabled. Earlier, user needed to remount
      with -o abmc to enable ABMC feature. Removed that option now.
      Now users can enable ABMC by "$echo 1 to /sys/fs/resctrl/info/L3_MON/mbm_assign_enable".
     
   b. Added new word 21 to x86/cpufeatures.h.

   c. Display unsupported if user attempts to read the events when ABMC is enabled
      and event is not assigned.

   d. Display monitor_state as "Unsupported" when ABMC is disabled.
  
   e. Text updates and rebase to latest tip tree (as of Jan 18).
 
   f. This series is still work in progress. I am yet to hear from ARM developers. 

--------------------------------------------------------------------------------------

Previous revisions:
v15: https://lore.kernel.org/lkml/cover.1752013061.git.babu.moger@amd.com/
v14: https://lore.kernel.org/lkml/cover.1749848714.git.babu.moger@amd.com/
v13: https://lore.kernel.org/lkml/cover.1747349530.git.babu.moger@amd.com/
v12: https://lore.kernel.org/lkml/cover.1743725907.git.babu.moger@amd.com/
v11: https://lore.kernel.org/lkml/cover.1737577229.git.babu.moger@amd.com/
v10: https://lore.kernel.org/lkml/cover.1734034524.git.babu.moger@amd.com/
v9: https://lore.kernel.org/lkml/cover.1730244116.git.babu.moger@amd.com/
v8: https://lore.kernel.org/lkml/cover.1728495588.git.babu.moger@amd.com/
v7: https://lore.kernel.org/lkml/cover.1725488488.git.babu.moger@amd.com/
v6: https://lore.kernel.org/lkml/cover.1722981659.git.babu.moger@amd.com/
v5: https://lore.kernel.org/lkml/cover.1720043311.git.babu.moger@amd.com/
v4: https://lore.kernel.org/lkml/cover.1716552602.git.babu.moger@amd.com/
v3: https://lore.kernel.org/lkml/cover.1711674410.git.babu.moger@amd.com/  
v2: https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
v1: https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
----------------------------------------------------------------------------


Babu Moger (30):
  x86/cpufeatures: Add support for Assignable Bandwidth Monitoring
    Counters (ABMC)
  x86/resctrl: Add ABMC feature in the command line options
  x86,fs/resctrl: Consolidate monitoring related data from rdt_resource
  x86,fs/resctrl: Detect Assignable Bandwidth Monitoring feature details
  x86/resctrl: Add support to enable/disable AMD ABMC feature
  fs/resctrl: Introduce the interface to display monitoring modes
  fs/resctrl: Add resctrl file to display number of assignable counters
  fs/resctrl: Introduce mbm_cntr_cfg to track assignable counters per
    domain
  fs/resctrl: Introduce interface to display number of free MBM counters
  x86/resctrl: Add data structures and definitions for ABMC assignment
  fs/resctrl: Introduce event configuration field in struct mon_evt
  x86,fs/resctrl: Implement resctrl_arch_config_cntr() to assign a
    counter with ABMC
  fs/resctrl: Add the functionality to assign MBM events
  fs/resctrl: Add the functionality to unassign MBM events
  fs/resctrl: Pass struct rdtgroup instead of individual members
  fs/resctrl: Introduce counter ID read, reset calls in mbm_event mode
  x86/resctrl: Refactor resctrl_arch_rmid_read()
  x86/resctrl: Implement resctrl_arch_reset_cntr() and
    resctrl_arch_cntr_read()
  fs/resctrl: Support counter read/reset with mbm_event assignment mode
  fs/resctrl: Add definitions for MBM event configuration
  fs/resctrl: Add event configuration directory under info/L3_MON/
  fs/resctrl: Provide interface to update the event configurations
  fs/resctrl: Introduce mbm_assign_on_mkdir to enable assignments on
    mkdir
  fs/resctrl: Auto assign counters on mkdir and clean up on group
    removal
  fs/resctrl: Introduce mbm_L3_assignments to list assignments in a
    group
  fs/resctrl: Introduce the interface to modify assignments in a group
  fs/resctrl: Disable BMEC event configuration when mbm_event mode is
    enabled
  fs/resctrl: Introduce the interface to switch between monitor modes
  x86/resctrl: Configure mbm_event mode if supported
  MAINTAINERS: resctrl: add myself as reviewer

Tony Luck (4):
  x86,fs/resctrl: Consolidate monitor event descriptions
  x86,fs/resctrl: Replace architecture event enabled checks
  x86/resctrl: Remove 'rdt_mon_features' global variable
  x86,fs/resctrl: Prepare for more monitor events

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/filesystems/resctrl.rst         | 312 +++++++++
 MAINTAINERS                                   |   1 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/resctrl.h                |  16 -
 arch/x86/kernel/cpu/resctrl/core.c            |  79 ++-
 arch/x86/kernel/cpu/resctrl/internal.h        |  56 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         | 247 +++++--
 arch/x86/kernel/cpu/scattered.c               |   1 +
 fs/resctrl/ctrlmondata.c                      |  26 +-
 fs/resctrl/internal.h                         |  54 +-
 fs/resctrl/monitor.c                          | 637 ++++++++++++++++--
 fs/resctrl/rdtgroup.c                         | 588 ++++++++++++++--
 include/linux/resctrl.h                       | 148 +++-
 include/linux/resctrl_types.h                 |  18 +-
 16 files changed, 1962 insertions(+), 226 deletions(-)

-- 
2.34.1


