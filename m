Return-Path: <linux-kernel+bounces-722456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C40AFDAED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACDD17EB04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43AC2673B7;
	Tue,  8 Jul 2025 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ITTiCSY2"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B1262FFE;
	Tue,  8 Jul 2025 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013242; cv=fail; b=CKZz3CydJlXGacz4LS5REfqsmDQhkCwhmsV8wwhrkUh+jctg6SUlz6xfKwkVVaByqSEreowwy/UesLeULU392DcpNC3yhikhavWW/6uC5e7YerXNYN/e+0PoX8LL4KS9NflMVwmYw+jdfd6gxR9j81ic1wCWFuTn8XuDHNP+g5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013242; c=relaxed/simple;
	bh=zGP/ccPwj6PIU1GEuay5rmDEtzadG2ia1oDYXXL1muw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlBMeliJmqpa1JT95qgUK/NO4P+CnIT4ML5wJxg90kWB6cT3w7rLzY18Fzp7QWoiS2IGFD+h9j+5FKrfJPkJTVmlk0g8753o89XtlpRDNid4A3u6NiozGJ5YBWWaUTZeI/bdn/CnSdnVz327E0Esz0zFs1Li/vJ/78Ub9r6O09s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ITTiCSY2; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMsViTWp1hnyMAL1wzAZC6l21kF375sWUAS3kBp9ynOiQ4cC9LaDMWEB1JpzaVoRhjo6NugVgP3uZ+d1x/mxuO3HHI1RAyFJHsDIJ3CQ8LrhWgC0yi2y61Bde56cOEz9Bof7MegHPHKyiHLIxgzyLB+ZoUe0+pSp1brJlLwegI5Frp04r2reMbsSzxCoupJmnXzspdGnJfSWiUcqpE0bsqWjVUrr7q6YbGYKs0U0LBIfgaLA76sq2ohu7JBRKjfWXe6gmKL1CJ/MhhwhAFxCEF8OqGWrsc0T0n7Wx/QUUC1E5v0NSd4LVqh7Q0yQ0MXQuMmLGLh6hzQqVw9iEoM+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLs69HUhBI1qtUPszjfOJm0ndBDQPQSDMVas4oXMt6A=;
 b=jBzb+auuDfdkyGhn0AcNLduSsaHIHTxwFSh7chml4NDCmlA6V6bru4EbT2RVjwOkdsKUjKjJR1zIgvjmxVfsXtkOS8rGGnzNf9sTxjWjCDupfWEfYfL+nNiB5yUkR0FbFVB/Hul5HESiz9nJi36xFCftn9tJcvhRQJXqsYXYfz9ge/skTQHw1/wEwb/rhAkGXupY2WbibTF4Jetnt5+XebDbyOQriHp6cUyrykcgXpV0EteKa2xEsbkHzuNmHBWbCaSoqtVG+6zURbgFiivC5vvbQEWHFEM5vUKOidtocZud0pHZAYXjeQ2k0+0s8bK+UnyKbZqBkeFgzxjCVhtfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLs69HUhBI1qtUPszjfOJm0ndBDQPQSDMVas4oXMt6A=;
 b=ITTiCSY2yBSy64ELBYZCZ28+0BZxRuGxv2iOjosVrk3u0J+GJ7dz2BoPhQP9fdto2pMUMFLXMjk7+hZmaaJkBkDWJavPL3xicxs2TKdnYuleljUoqjbIcJ7HRhhw0nQYjN9SWfxI57jqKj5ILWY/L8qGn3GGtpSWyytn1eBEHPg=
Received: from MW4PR03CA0113.namprd03.prod.outlook.com (2603:10b6:303:b7::28)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 22:20:37 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::63) by MW4PR03CA0113.outlook.office365.com
 (2603:10b6:303:b7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 22:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:20:36 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:20:08 -0500
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
Subject: [PATCH v15 15/34] fs/resctrl: Introduce event configuration field in struct mon_evt
Date: Tue, 8 Jul 2025 17:17:24 -0500
Message-ID: <f87053b76713a05fa4b5459dbd3af6af83d47c49.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 80aff5f8-067e-4e5c-968b-08ddbe6da9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YaCdpJUDZx4Gx1zbPiRhICrA89noZuvtO390Y1WXp5LPI96HfsWZu2/wygZC?=
 =?us-ascii?Q?w47FPfhkOlLEMMN7r+0IaIKirY6TnwDyYve7lodqJq3r9RTPclLTNg5WdXJr?=
 =?us-ascii?Q?tYMtkN2CI/78saTnk2pghcGcpW1ILkEX+OT6b7jFeFiyiOb0N5kzUfcGzS3m?=
 =?us-ascii?Q?eU2v48QT7BKxwKSWyxwLBfyVtCqZ/mGVjgQJtfIZ0+2ruAxyRRPBgK8U4AOu?=
 =?us-ascii?Q?+dA665QEwIWLt3GLiVfb4/GcoUKTN/UMstT+CVC/GhUiy7Ii6z+gMcS0W8Gy?=
 =?us-ascii?Q?rIL6uaC/DRyTvCeipr9tkMJ74IUU9Ll/fj2yO3ox62P+mNrZv6FI9cBitveq?=
 =?us-ascii?Q?Hf1vB8/cPFdqQ+FLluv6mJNVTyBGUiRzOLsISCTQe4/CA9zshWcnP5BJXMdL?=
 =?us-ascii?Q?Ns9aFukFhZez96w6plRPwYeIXU5ASfg9M1NAFelgvjxu6DaZZMhuDda5h6ig?=
 =?us-ascii?Q?nR7zsJJwjdVXqL4b8m71VlABWIVsnrd90msoKFk0mdUwWv4kLYlFQ3YLLQZS?=
 =?us-ascii?Q?8/aPLjEfn8+TGeg3I1O0IM1B3ISbebftfs22R56UpSYk5u+FqfqCTkgKUn0Q?=
 =?us-ascii?Q?hcPmNIz5AfOdCHRGsRMB/h9iZjYSV2NoX4TF96ztUjqYfYN17Hl+i6TT3CLr?=
 =?us-ascii?Q?xLNOkBSDO2zfNx6wjfL+yH5/FtRLd2Xpu8Eq413jFSM1W7gKVNiJu3cxtfi2?=
 =?us-ascii?Q?jeD5DeTFLre/F1rYHdlVPZ2hGnPhJqFfIFUnz+rNDg2km+8tnY3JEML1EqTo?=
 =?us-ascii?Q?P5QdTjR+9mBETM+RcvudvZlS/Abn+X05t5q9e3ySrrAI/VCYF+ifAyZJUnAz?=
 =?us-ascii?Q?ENu1CvNidxUIFYgGRblO43nVhbq7L7Xu4ipSv4PvcdJik8OlorqBzj93vxpa?=
 =?us-ascii?Q?zbRoZOEqwBxJMRlxYxRTr05c4phRXK70zStflRyjSlIvyQXaMmP8I8mmy6N4?=
 =?us-ascii?Q?g6bI+6jrqVp7oTd8B9sWwbisl7BPyzjUemwk1uAiMQgh5IkkY79juUeYCxJ8?=
 =?us-ascii?Q?W+ddQb36WMzcmdaAs7KnmfeRq6idoNHlmKZ4JS9IrQ8IGE4+4Da54MyRKp+4?=
 =?us-ascii?Q?6bB1MatWc6jlJ2wZA6GRKrAe+cziA2DsAds1XQHARQcpYjp6eazoBjPcEbmb?=
 =?us-ascii?Q?vTHaTi20tTb0Ct6ApP2/29gWE9JgVrVM7Cr7SgbM0v39qKLoyacuqhhXe/F5?=
 =?us-ascii?Q?qi//utNp+lIfE8EtBxTquoBeAlloaWMGUmF5EHdTMFpE7Hq7aitM8J936Cg+?=
 =?us-ascii?Q?2Qn+xBUhRIwMT6D3bcrXA0yXBfSynqdKScj5RYpUjGrc5dRtffI8YoIC8shN?=
 =?us-ascii?Q?rw+r1wMNma2njFTyDJVBIffNa0r7xjrAhXVfkysn75bvSsfh/s/HB9JK5Skj?=
 =?us-ascii?Q?Rypjrz5EqsYXl/APcAk6fZeWaBSqAoJha1QRELEfuF1h8qhjYNayVmR92DG0?=
 =?us-ascii?Q?Q7kNTRn4FJJkRObkBrn4QL7FjRgLnVNqlev+7dPxYtSJz68+sbQVJ7K8Ke8/?=
 =?us-ascii?Q?ZsMcDxEQcvVoxlFdOT+iQpwg8mZWd27CH3IacEGVynzWED4tSk0zEhVJgg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:20:36.2487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80aff5f8-067e-4e5c-968b-08ddbe6da9a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355

When supported, mbm_event counter assignment mode allows the user to
configure events to track specific types of memory transactions.

Introduce the evt_cfg field in struct mon_evt to define the type of memory
transactions tracked by a monitoring event. Also add a helper function to
get the evt_cfg value.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Updated the changelog.
     Removed resctrl_set_mon_evt_cfg().
     Moved the event initialization to resctrl_mon_resource_init().

v14: This is updated patch from previous patch.
     https://lore.kernel.org/lkml/95b7f4e9d72773e8fda327fc80b429646efc3a8a.1747349530.git.babu.moger@amd.com/
     Removed mbm_mode as it is not required anymore.
     Added resctrl_get_mon_evt_cfg() and resctrl_set_mon_evt_cfg().

v13: New patch to handle different event configuration types with
     mbm_cntr_assign mode.
---
 fs/resctrl/internal.h   |  5 +++++
 fs/resctrl/monitor.c    | 10 ++++++++++
 include/linux/resctrl.h |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 445a41060724..ea5c9fa932aa 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -56,6 +56,10 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
  * @evtid:		event id
  * @rid:		index of the resource for this event
  * @name:		name of the event
+ * @evt_cfg:		Event configuration value that represents the
+ *			memory transactions (e.g., READS_TO_LOCAL_MEM,
+ *			READS_TO_REMOTE_MEM) being tracked by @evtid.
+ *			Only valid if @evtid is an MBM event.
  * @configurable:	true if the event is configurable
  * @enabled:		true if the event is enabled
  */
@@ -63,6 +67,7 @@ struct mon_evt {
 	enum resctrl_event_id	evtid;
 	enum resctrl_res_level	rid;
 	char			*name;
+	u32			evt_cfg;
 	bool			configurable;
 	bool			enabled;
 };
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 9fd1fb76f82f..11327bd8cf72 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -884,6 +884,11 @@ bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid)
 	       mon_event_all[eventid].enabled;
 }
 
+u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id evtid)
+{
+	return mon_event_all[evtid].evt_cfg;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -926,7 +931,12 @@ int resctrl_mon_resource_init(void)
 
 	if (r->mon.mbm_cntr_assignable) {
 		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
+		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = MAX_EVT_CONFIG_BITS;
+
 		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM |
+								   READS_TO_LOCAL_S_MEM |
+								   NON_TEMP_WRITE_TO_LOCAL_MEM;
 		resctrl_file_fflags_init("num_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("available_mbm_cntrs",
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index e013caba6641..87daa4ca312d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -409,6 +409,8 @@ static inline bool resctrl_is_mbm_event(enum resctrl_event_id eventid)
 		eventid <= QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
+u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id eventid);
+
 /* Iterate over all memory bandwidth events */
 #define for_each_mbm_event_id(eventid)				\
 	for (eventid = QOS_L3_MBM_TOTAL_EVENT_ID;		\
-- 
2.34.1


