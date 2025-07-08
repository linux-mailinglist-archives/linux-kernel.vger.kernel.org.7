Return-Path: <linux-kernel+bounces-722464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026BBAFDAFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947BA1766C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443EF266EE6;
	Tue,  8 Jul 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EjNR/QgB"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1B265CDF;
	Tue,  8 Jul 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013299; cv=fail; b=uI1lZvPvTjhYXHY/AtQRJuUsfCWuAwfW26VSc7fB1RL/hBO6PLyyarOdIMeglttQEkSIw8Zk2WTPr7hSbTPlSz2Uoi1AaT4WAG8GGrzkRT7r/W9IO80osUtxSP/uCziqkH/N1Cr5lszWgX6fULx3g9pB06VYvKYkVjXQniaQIA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013299; c=relaxed/simple;
	bh=nogQFCX8w+13DT7R63pnIMSyYmK9YMivhmYdMOnpMqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqhsNut8jf8276+UNe6Jc2Mg0Hf5zDUSnDEiiCeFFz8nS/NBeL8gzEwIMrUF0C/uG0NfG9JQDlxz7LWNd7qiTKbcE1BsdCJZQTnYkiZVNhq/B47YxF6Ky3JJne0jfZwv7t/+Dbzuog7QtUZNQgA9qZfHJCN2tU8/BTIyp86eyNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EjNR/QgB; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3HFrDWe1TD3USVMAYDC1m6qrUDwGLW2MDDfGzQB9KmwjWVSCNqank2FytM2kHXp747LIs+KZwvFMkTHylluMD6XtIS9ShOqkbvdtr1Rsd9CbDXUA6Tw2/PZxvDpaO4t54LaJmzbTmlwuT5ahb/uJBnlf91WKMLPzSn+NWZla6rGAkI7teLHrVznypKquIjNPkdvWxfw73orPahof40+nrHz0I9p90qx2t7ZzQSB+5f2YeflSHV1a88HAR86YkA41Mefbg1a0tM3ah8C0eNBnOsO47AOjY9MYfUnj/OS3tzns4J3gtL7ScfVB7tZYpN6NX3YRSbPyRz7i5viJsA7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEALoZgKzJwN7rnxXAA0DIHKPUEgZizi5APCwaAfU2Q=;
 b=RWCW6R9lzLIabn139qWk1iHNtONL2nSHE0sFzUVxNuhkEca7CLbv4w/Q3Jld+kNV9RgL2Z4HTpVSJ6NsvDWzhTcLT+vBY4+B3GttQM83jeMG7GsIHkvjFhOxJtatU5WVqVcyByO/uwjoncvt0xDxu4JlcuE8AxRxfvVZK0NDK9BUMXttYPvJlKSZxaPbY0/R/g2UbKlaiH8aRfBBW7JiSzWyT7KKivGxh6rBuEwO1zi17JVKJxNqFAlMKCH5FC933fQW3DyrkR5VtL6uXE0k9i+h9EadZjfgcBZrWGDE4KoQKGt6+EXVZp4JJoHd0BDrpqc3/mZ9MLWD1wQF8lABRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEALoZgKzJwN7rnxXAA0DIHKPUEgZizi5APCwaAfU2Q=;
 b=EjNR/QgBPPjZ8NOMWgVZmL2px6jleTMQ8HJFTrimS1QLGp+bt+ZmGlt7l6E7eeOlrruAYTj7Fz9vVhgrjf7CCfX7AwyT6YaBIAQ8gT0rpKnvl0xj4Uzt8MmnGbirBaLRje3lObMYu93wKIPE8a6GFWiaBdxlkSm5EDlZ40mEXq0=
Received: from BY3PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:39b::31)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Tue, 8 Jul
 2025 22:21:31 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::1d) by BY3PR05CA0056.outlook.office365.com
 (2603:10b6:a03:39b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:21:31 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:21:26 -0500
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
Subject: [PATCH v15 24/34] fs/resctrl: Report 'Unassigned' for MBM events in mbm_event mode
Date: Tue, 8 Jul 2025 17:17:33 -0500
Message-ID: <296c435e9bf63fc5031114cced00fbb4837ad327.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: c55f60bd-608b-4dc9-e9a8-08ddbe6dca5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dnz4XSMMbPJ4pKNzbvJlLh0J8//GZh0lDC6RHers0AvQdqWmU5wL8wM04S5/?=
 =?us-ascii?Q?2qD8zCt0KgU7u9tMGy76Dfhr3vECLSDDqau9PfRyKGt+8RHfJDCq3tHMl0Vn?=
 =?us-ascii?Q?uAdRiRUiM+3J/cjXXUMs0Ig8lG6Sdk4CwQzMfrIyKmwS6+3DDNZ+OIlkla3x?=
 =?us-ascii?Q?RrQ6GjogucQtUPKam3AJCprRKOhxk+/3T0JlDCwCjRjvNx/6w6EKhRc5fPfY?=
 =?us-ascii?Q?VWruHAalphXBQ7M0QRbbljb8TdutQ/4/kqbg9MICSi5kfOOA9LXsu4EXaO5n?=
 =?us-ascii?Q?Qv2XVQCb/7T+ApagyvThH90n/DOZVthNDnso1+8daNFgM0qFf+7pMrHzmMu1?=
 =?us-ascii?Q?IRYVcdW4H5Me5I/aMxT2xM+iavtLU/CAbO7rjHwfPGPK0X1p64Rdo2x7Mpcr?=
 =?us-ascii?Q?poSQ4FGgGIW5qcTTRHiDhxxeAyP7WGfLRml4D965XHlPf1BGWThrhNk4WDf2?=
 =?us-ascii?Q?sFc+fy9tqtZNI/UT5MLwymorc6S2IO9GrBvvwEpeRvRXldUXIDTmXMpamIPg?=
 =?us-ascii?Q?xhXi5rUV9SuiZxeE/IhWe7Bo7/phU0obK1mbDjOqRhTZiVk3m0ZHxn7rIhEd?=
 =?us-ascii?Q?pxzev48ZRsoaKNl7aiHpF5Map6SECq+TSDrIrp+AYmlHFu4bIcQWhkPK3Kp+?=
 =?us-ascii?Q?ta8z1PHcg3QauVVClKZhBXd0/zMnY4uYIoNrYrrn8iB54HpDZVlW6fQEAM3c?=
 =?us-ascii?Q?b1FS9mJAUag2GmqXCP8xaqZSV9e4xwC+jhOGHrlj/brT1DCg+mY4uN0OjxEW?=
 =?us-ascii?Q?URdn9CTEBfZdo8yrkE6/sqsgurfVgR4mGAt228NeueySfxqdASw48p2raTXt?=
 =?us-ascii?Q?22N0T5cxOac7zoVUnrIQE2MLz4uKAP3WRK+O/ivaWTbMObbzRU4WUpFsyiuP?=
 =?us-ascii?Q?rVdRVxiHq+eRmFbuGBl6GWcTgzoIZs1vklYXaVcbeL8N5/FgiO1AcBP9EX/M?=
 =?us-ascii?Q?uNM6SgkHAclpdBHAOYvqyBPq9tBjbveo/dRnitz3emiGUOTOn2DBRSWfMVq/?=
 =?us-ascii?Q?UdsHLl+1eoenxniI0mYgKhd5KeNj8mmTl7zl5zQ4popwNHx6c01m4A17w8Z0?=
 =?us-ascii?Q?2B8DL5ff3tBnRRMuWP1FskJYB2nfSljtbxdrx9Kri8gA85kfHO5gDE0ZTpWZ?=
 =?us-ascii?Q?odguMpiFIGXlDWaKaDvewzZnNl7AXKKioax+QyiFyB/M5CO44j8PWJUikECo?=
 =?us-ascii?Q?UG4IneGl6I4B6jhvhQXlpd4cfHvsZ73qJlSx6YxlpxTGvgw0M4W7QiydCHK8?=
 =?us-ascii?Q?EIG8YwYOutH0hp6AO9GkQycrZv5pXROqn61eVmlDEU+RHqyOxxbeqHmsqdOM?=
 =?us-ascii?Q?UIbVhD9FeiaDGJY61/n64U8A8ihClCqv4Afuivdp4fVyD1/DR05U7f5w7+4C?=
 =?us-ascii?Q?HXYahOp5f4KV2ILF/IUnRnjf5fkynqTAa1bC9T7PK0KGgVFhfq7jeHTVhXFB?=
 =?us-ascii?Q?ATV5Xk7yboF+kTtzAjO5XawBv9u4ZcovbAII4WHiArrY5jP0tMcw9+4vIfLC?=
 =?us-ascii?Q?qbxP9p6/6J7xhbZha9RePxZq/jqEp1W4dcV6D346syHoKmqy1vBIGmmJ6g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:21:31.1089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c55f60bd-608b-4dc9-e9a8-08ddbe6dca5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523

When the "mbm_event" counter assignment mode is enabled, a hardware counter
must be assigned to read the event.

Report 'Unassigned' in case the user attempts to read the event without
assigning a hardware counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Updated the changelog.
     Removed the error setting in rdtgroup_mondata_show(). It is already done
     in mon_event_read() based on the discussion.
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/

v14: Updated the changelog.
     Added the code comment for "-ENOENT" when counter is read without assignement.
     Removed the references to resctrl_is_mbm_event().

v13: Minor commitlog and user doc update.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The monitor.c/rdtgroup.c files have been split between the FS and ARCH directories.

v12: Updated the documentation for more clarity.

v11: Domain can be NULL with SNC support so moved the unassign check in
     rdtgroup_mondata_show().

v10: Moved the code to check the assign state inside mon_event_read().
     Fixed few text comments.

v9: Used is_mbm_event() to check the event type.
    Minor user documentation update.

v8: Used MBM_EVENT_ARRAY_INDEX to get the index for the MBM event.
    Documentation update to make the text generic.

v7: Moved the documentation under "mon_data".
    Updated the text little bit.

v6: Added more explaination in the resctrl.rst
    Added checks to detect "Unassigned" before reading RMID.

v5: New patch.
---
 Documentation/filesystems/resctrl.rst | 8 ++++++++
 fs/resctrl/ctrlmondata.c              | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 446736dbd97f..4f5eb5bbd4b5 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -434,6 +434,14 @@ When monitoring is enabled all MON groups will also contain:
 	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
 	where "YY" is the node number.
 
+	The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
+	counters and allows users to assign counters to mon_hw_id, event pairs
+	enabling bandwidth monitoring for as long as the counter remains assigned.
+	The hardware will continue tracking the assigned counter until the user
+	manually unassigns it, ensuring that event data is not reset during this
+	period. An MBM event returns 'Unassigned' when the event does not have
+	a hardware counter assigned.
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index ce766b2cdfc1..45351673e4ee 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -661,10 +661,16 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 checkresult:
 
+	/*
+	 * -ENOENT is a special case, set only when "mbm_event" counter assignment
+	 * mode is enabled and no counter has been assigned.
+	 */
 	if (rr.err == -EIO)
 		seq_puts(m, "Error\n");
 	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
+	else if (rr.err == -ENOENT)
+		seq_puts(m, "Unassigned\n");
 	else
 		seq_printf(m, "%llu\n", rr.val);
 
-- 
2.34.1


