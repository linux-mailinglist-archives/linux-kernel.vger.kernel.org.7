Return-Path: <linux-kernel+bounces-722451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34587AFDAE3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1724E35AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31FD25FA00;
	Tue,  8 Jul 2025 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ia7RWgQn"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C825A620;
	Tue,  8 Jul 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013183; cv=fail; b=Qq6YgFL/6xew7CFFe95YpqZDdtRf3thUXBiAxB3+SeCsX6aavtsrTWN8V2TI5jeiOAjQ30caUAQWs1NL1+g8XyZEyRjs/hJRhlRmnVCJP7OKyROYr/TNsSbbkoJptwx/QaK6QdWRmlLZo5JXzCmyksBqedonMiLM3DmsrKdy2b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013183; c=relaxed/simple;
	bh=PyIvuFYVq6LEiJMUQliFZjo2bbsqBwZbYkezmI0/qGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFWoCkq39SNH2Uz3UiN+2WK0n4BAWjV3yQ9nl1Q9DPIkH/IL5egi+DsiVR2QITnmoopdShAF7eZny6171x4Ahmxs+q0cSlgGSXvXEHAZ/NBBP22Lre+O5l3ZNj5xs5L/k0QP7swJ/CeAC15Co5RwOVI+uajWbRF6YxA56pLeKkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ia7RWgQn; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxrsJhlr1COE3XHjG943Q9OieFUry95GdDhpmt0vEGOtaD9y+YxcM2lzPqdJqo5p7b9zuqmcYh93vC/cs3RtaVw13faHHOrKjc4swvU7jqsFD1VhW9Vgi5vO2Nr7wxVV9ACd7pHkyBzipipMM/cXieqrl5RU6JdytX8504FL2q2rCJeEt56NgJ5shA/7ihKomYypScs0XVS6WRK6atVjR7pcP6DyyVomWtIne8ac3ioMqBzxluENJC3knMw9IWWCA23EYwzyzwYIZpMVed+tDpj2mLZat7fKA+h+oxuWPtr7+r5GXeA4onaktKud+nxa2gOPfj4jIcXU5dFj6DRN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmQZKoNrMWJjTMyg104ln24pp4/RBx9EK60/U9JiZ+c=;
 b=EEDoBTk6Yhuq0PsF0zDJEwyFm0nEAN1nZvgjBjZ/qtFO3sFXs5Rgr3fy6kPOei8eXmv7UjLpiQ9IbGHS4ouHoRZTYv/ePTscrZONeaOkm8gfbJSenJtV1NbwGAtMNbhPuqLGzoOmDrTM1FeR4+iH+c9emAqHimFdy0qBE29Uz9PhlZAviWbcND23gnNWEurOArL+OBbrqksVVFbqzSzaJ6/IuWRCCy7CZxb/2pgNVPzgDI94gXRRPAQMVaB5Z4Yj1hnnzGGcwQ2F1EAy5jlqm4FBMt05GAmNG3K5SMLW3Cb3pq+UUWKtE6Fj6A7Zynhp5agimDCQ5F0YU7ExBD2s3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmQZKoNrMWJjTMyg104ln24pp4/RBx9EK60/U9JiZ+c=;
 b=Ia7RWgQnrqBBlh09f94tDs9NXs08nG9Uro1RHeKNO7vRj4Hbw2uyuRsw6mDhycyi6oesprohoQwOY5TUFJBJoyUi0vqe8VaC3FOyeCtF7XFNYWmfVV2NeeT0dKnJHOMsIqLTE+p4eHTXyFk+rqOS/Qt1u603548/iZ9ahEx/UeE=
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 22:19:36 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::2e) by MW4PR04CA0210.outlook.office365.com
 (2603:10b6:303:86::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 22:19:36 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:19:33 -0500
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
Subject: [PATCH v15 11/34] fs/resctrl: Add resctrl file to display number of assignable counters
Date: Tue, 8 Jul 2025 17:17:20 -0500
Message-ID: <c2d804df633ae7e7a2dfabbfd6b4e2d774dfe394.1752013061.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752013061.git.babu.moger@amd.com>
References: <cover.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff54ae7-3a52-4f15-3e2c-08ddbe6d8611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0T1fPeITvcP+wEEBUJfV7ueUsCsfWXxVkCAj4/FsubldMmd7r7Ctzv7/9dXZ?=
 =?us-ascii?Q?YMbkfl8FoZOITb8bb5ojKAhUQWUsA5yVQGz9yZ19YeaB6h5O6DgWtqJx2/V3?=
 =?us-ascii?Q?xUGN9IoPmraswE8o4x20Ber1NIAjJfDZdx4YtNIgkuknJPwXjW7jCOpGhPne?=
 =?us-ascii?Q?kmVu6EYNAgn9IDAuFnWhJN2PuGHVBGrHf2iW/HclwUTc4HfgUYPuwJ/EYVUL?=
 =?us-ascii?Q?ky7pB541G9POQEb4ADRHv8CosfY0Vyq0OcRZK1EXaqBVp0Xz5pesEPA7pMh6?=
 =?us-ascii?Q?lXnX7UFpiy3vm86txjicZ6PzbP7HtknWDhgTozuJLq8Bve6qXX26sekMGWp4?=
 =?us-ascii?Q?qu0AIk7dUs9hVjS7PKqk5+kOPKfjRiG4TpYLWaAud2teUDpC+6qfomUIqKJL?=
 =?us-ascii?Q?o52+tkxxYy1XeJQ7O+FLSF0//s07OYFDmyjZl0kM2hL5I/T4/XMl63oxwg+S?=
 =?us-ascii?Q?ILHUXJ3TlPZjR62FiCMFdVAjyBiJU6MFTxenwpIRRfdYP23FV0MhRnvrIoFY?=
 =?us-ascii?Q?90hdA3RxpVEZUelqoe7T9DAk2WDS5ljXEPMQ/Yxn3GMwD1+CVYwcFrlhqapm?=
 =?us-ascii?Q?BG85Wxn6J2GMXR7vRTebZt4Nl7SqsZhhYuZEpp9LK+G1kFNmNrcN363fFLpj?=
 =?us-ascii?Q?dAyUFvXT7eXlydqB6dvF3FNqq1TbcSwjoPI9Fbwx367mEpYMqhf5U3/9BcD6?=
 =?us-ascii?Q?xUKurwr4CqXqADonrZ+uMj5R9QXBrc/qbkBFz9Ncr6PvHftUmfn9Z1ORRFIB?=
 =?us-ascii?Q?qQDhEfIglyhKYki6Bv0zgKgC1g5vKN6ko/ZEb+K1jnFw7mlS56gfrceRPk2z?=
 =?us-ascii?Q?zAo0pVBrmqBqkOntTtqD++cOjn/wS8UoX+67IkAmqhbOzjQcYLKTUmGNie0X?=
 =?us-ascii?Q?ERa9LdVhsSvHqSia0gwAf3xmoh6jeZF/mQadTaDtcYL+Bun+cVEkz4IdkY+v?=
 =?us-ascii?Q?RPNl78Y8yAIDqU0AxMXtPP/hltufUwQnp8ObMoFcwi1i9sRJ3vDWEqKt/fCa?=
 =?us-ascii?Q?xoVxlvCN6Fpm5NECYOlJPVhYvUJWmbgeNwpAZ3mcf5bKEuwK1abelRWR2TR/?=
 =?us-ascii?Q?butsWl7H11DmUS0njbFoOMb3AnQsTlYiAqfk+2PaD5nrOoW1ribfA04MsPge?=
 =?us-ascii?Q?RUHPxC3gHy9fL1mqj/9EyAo+5XrxmA69mrNeSt5c5DDlqN94PndQD+8LePeV?=
 =?us-ascii?Q?6xYz7PzWpyqZ5htz1g16kL39s46hY/NAnM+H4acSveu+89s74vtKp5STYAop?=
 =?us-ascii?Q?QiW4ul85GNchIyEJKE7ZcJq2lqWwvj1hclkJ8EwhhjrQ9t89/Q+yScduX9vS?=
 =?us-ascii?Q?X99yhrsPv9Zx4DbquqiKFZoa2iC/qEzrGwbUdPy61P6+nsQIKV0TIcBlkliq?=
 =?us-ascii?Q?D71gXIaLwvdXiItUZi//vZlEC3TU8kcEJd+nFybLYlqHbiyg/L6fQM4rTO5P?=
 =?us-ascii?Q?Z0HOgA0YnVyrMqKUFIPT0XoWlTN5i5SjJMPXAAfgtNrPq0noX/3ExwFnmaak?=
 =?us-ascii?Q?YnoR8p9GVZrGuKuSzvuykmbmqvyEVtEh9Xxb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:19:36.5123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff54ae7-3a52-4f15-3e2c-08ddbe6d8611
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor bandwidth usage as long as it is
assigned.  The hardware continues to track the assigned counter until it is
explicitly unassigned by the user.

Create 'num_mbm_cntrs' resctrl file that displays the number of counters
supported in each domain. 'num_mbm_cntrs' is only visible to user space
when the system supports "mbm_event" mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Changed "assign a hardware counter ID" to "assign a hardware counter"
     in couple of places.

v14: Minor update to changelog and user doc (resctrl.rst).
     Changed subject line to fs/resctrl.

v13: Updated the changelog.
     Added fflags RFTYPE_RES_CACHE to the file num_mbm_cntrs.
     Replaced seq_puts from seq_putc where applicable.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The files monitor.c/rdtgroup.c have been split between FS and ARCH directories.

v12: Changed the code to display the max supported monitoring counters in
     each domain. Also updated the documentation.
     Resolved the conflict with the latest code.

v11: Renamed rdtgroup_num_mbm_cntrs_show() to resctrl_num_mbm_cntrs_show().
     Few monor text updates.

v10: No changes.

v9: Updated user document based on the comments.
    Will add a new file available_mbm_cntrs later in the series.

v8: Commit message update and documentation update.

v7: Minor commit log text changes.

v6: No changes.

v5: Changed the display name from num_cntrs to num_mbm_cntrs.
    Updated the commit message.
    Moved the patch after mbm_mode is introduced.

v4: Changed the counter name to num_cntrs. And few text changes.

v3: Changed the field name to mbm_assign_cntrs.

v2: Changed the field name to mbm_assignable_counters from abmc_counter.
---
 Documentation/filesystems/resctrl.rst | 11 ++++++++++
 fs/resctrl/monitor.c                  |  2 ++
 fs/resctrl/rdtgroup.c                 | 30 +++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index b692829fec5f..4eb27530be6f 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -288,6 +288,17 @@ with the following files:
 	result in misleading values or display "Unavailable" if no counter is assigned
 	to the event.
 
+"num_mbm_cntrs":
+	The maximum number of counters (total of available and assigned counters) in
+	each domain when the system supports mbm_event mode.
+
+	For example, on a system with maximum of 32 memory bandwidth monitoring
+	counters in each of its L3 domains:
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
+	  0=32;1=32
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 7e816341da6a..54e9a1d0c28a 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -927,6 +927,8 @@ int resctrl_mon_resource_init(void)
 	if (r->mon.mbm_cntr_assignable) {
 		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
 		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+		resctrl_file_fflags_init("num_mbm_cntrs",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index c7ca9113a12a..acbda73a9b9d 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1829,6 +1829,30 @@ static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
+				      struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
+	struct rdt_mon_domain *dom;
+	bool sep = false;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+		if (sep)
+			seq_putc(s, ';');
+
+		seq_printf(s, "%d=%d", dom->hdr.id, r->mon.num_mbm_cntrs);
+		sep = true;
+	}
+	seq_putc(s, '\n');
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1866,6 +1890,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_default_ctrl_show,
 		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
+	{
+		.name		= "num_mbm_cntrs",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_num_mbm_cntrs_show,
+	},
 	{
 		.name		= "min_cbm_bits",
 		.mode		= 0444,
-- 
2.34.1


