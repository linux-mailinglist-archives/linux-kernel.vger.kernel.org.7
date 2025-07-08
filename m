Return-Path: <linux-kernel+bounces-722466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B202AFDB01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80402542FCE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB6264A65;
	Tue,  8 Jul 2025 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aiFlicOC"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421626462B;
	Tue,  8 Jul 2025 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013325; cv=fail; b=Xb9jshnjrReLbSzyRu/x1I0CLSez9O0fHb5YsQmqvtZFhmfYN9CoJU5OO53TcvVlEJnoFE5z1FRhIXHdPzw1NFDvZMtKW0ms7QQawjG3GN9RUgBxGlw0aIhq6TCZj97uL7F2OInac7ZBMiPuvR4YFP15MEly7X463f4PoIWOyWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013325; c=relaxed/simple;
	bh=WQJCyF5+tBCP+Kukh9Q9x8qCSrumR/twAXPtOGHw5GU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNfCwRi75iBKB/NTdS2yv8GPjIDzPq3LeTV8laTRa3YcG52N93i0HBC7NYvIQoWO22W17F6x3QO41aZnFDo6kHXSiDZhBvnbrvuqgm5s9kNIxR1ts5bZjH6mUOo1MW8HnkeY3EwCbNFieOt4KcFJi7midbxc8Kojaip0gRT6Ri8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aiFlicOC; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9F38KDNXlsTR6pobNtknUtdyoPkbODIUijD211gTeIcDikQKIsudWfiINTQAopHxUsC4bGnc4oUKmGmdBqW8q7VMeJBLji6FJqnnd2PI7BQr+y5qLKIN1CzFgZ5GiZJ2n78TBu9J8O0vsCy1HSzu6VSitPEbcEEBYA3AgENxCqwfwwQMVfvGFdxATd25IPXhDLEDVSQtWZ4GbfKjCcl6sjNeNKSClOuvUFU1wyCKnAe+NizIfnwiEN50HPxDWjUSNnN3DjUgiDuVMS16T8SxO54HaEuxm1StVCSc4V3esn8j88JNLd5I5QcdvWvdQxefl3J6alS2N92T0RnFM81eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vhzTJkzHxQuOP3FmulN4qw08GO5Zx1WG5pMyvKnGH0=;
 b=hmibu6YAZ1RimkoHKLZ3oP5hvw26KJpN6hTkgqiM5Nw845cIQRJtCSYFlq24e8DXCEjWhDScphbydw/3Mj24xNmw6ncTXfSeVoaQa4xJUUEdYpVMooeYE0OO/xEW8j4Qqo5NqdeARzYOa9+FaM8KvqG9kEhkqau35PGzj2jT2o/jy9drq8ff/QgdOvvnWRkvpL38ZOYE+krgzmy1vZ30qyXzcM6qE2zFIy39cM5FI40fbW5IBXeOYkMI3dFdQPhQmTevIvYfoujs/wHUg67jrPH2ujH9BgR8lhB6naP3XNLoQ2qM2IoCHqxW6vzFt4pezoUBszmAkhq1LTh3IgrAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vhzTJkzHxQuOP3FmulN4qw08GO5Zx1WG5pMyvKnGH0=;
 b=aiFlicOCgwmei3lekof97MFwYRzlj3zLVWJkf0Z9LV93TOGuvlXeR00N5k97IF3WoMaVPWGTTjRG3MqdUOYjix4SrHo+ixGOo99qSsbUEURlqUHIHwZ6zLe/S/A/8Awm2yVnQl5Z2ApnBo3xej2TyoqoF5WAUvJT5P9dFgITMUo=
Received: from BL1PR13CA0118.namprd13.prod.outlook.com (2603:10b6:208:2b9::33)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 22:21:59 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::27) by BL1PR13CA0118.outlook.office365.com
 (2603:10b6:208:2b9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:21:58 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:21:53 -0500
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
Subject: [PATCH v15 27/34] fs/resctrl: Provide interface to update the event configurations
Date: Tue, 8 Jul 2025 17:17:36 -0500
Message-ID: <8213746e89e4813e397043325520353ada56651d.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4f19bd-911b-4511-937a-08ddbe6dda68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1VrgaZ3ltYmvnMbqeiuH+CRgkl4lZmIcMQw7lHYpR3fBSTrzUJO9ub2ckFcx?=
 =?us-ascii?Q?Ev0GPiuct2n55J4f4iE0fV4E8y7nIS2ZHjETENrKM1oRAIEgIQp1FDbwANWG?=
 =?us-ascii?Q?UmHZ1CRr7VCj/OMefAffjDzTrldgI82kNmeukEGyBYTS33qdRxPUIW0ufy/J?=
 =?us-ascii?Q?yq7s0vngM729/7CakaKRYERGK2dqnvYL4DDCKwyYVaDz8UcINTVpvIcE4JJG?=
 =?us-ascii?Q?EFmSNpvsyPm6FfblPIhiApABOMWjpDqpxZmoQj5Nykxi4kvoOARsjZSCMqJd?=
 =?us-ascii?Q?nJjRaihsQFl9BeeuFo9QwiVIm6qaERtZsn4sc/PLPVI+gi+npOFXcocaLm52?=
 =?us-ascii?Q?4jX+X/7LHW4EAc9NiM7ptr5SMe+2kk0PXB+tr/zHYmBbNZNm512DZzLf605S?=
 =?us-ascii?Q?scjc2mBlbHXTAhhmw7UpjtAvjnu8MP3o6yIVyid4/dAAXvteQB3BxgpQ0Cq2?=
 =?us-ascii?Q?SkOQnER0dxjDJiwqcV4OgVb4EXV4t1OueNX7AcdvseFa/LQUN/8JxJ9QY+xH?=
 =?us-ascii?Q?iGq808RC3sstq3Bad2+DAUfrTgGdBxkzmdVXVog3u3rs+Oi07TsQtjPay7kx?=
 =?us-ascii?Q?fnxnEAgkugtOrs8Xqac7vGoYbZMAuaE+c129YfQTbSffCaqfz6gduf80Ooij?=
 =?us-ascii?Q?0x3alMyIlbSp/vZcexpzTt4F/4/2CmzjSBM2S4MCnvupcaxQCcVJhrhMlHQ0?=
 =?us-ascii?Q?xiYZ8zByGTs8iS+lGlGsyc0wjHPl/QKo97inj6+v+0WthS5r9jYY/wjYzQAH?=
 =?us-ascii?Q?gdbZpjayag4H/WWk4VuVybW3kW8WKoBs9v5CCYynwODhQ71R+kqloLJEDmeL?=
 =?us-ascii?Q?PqBAVANkmQ9gvv2SxT/swBou1/avE4es5yI6X81Xp+FPmKOtnVRDU3QKRYRn?=
 =?us-ascii?Q?zjPt4tssZ0dguZb89nAQW9yTcR7qLVA82ksKI0tSsKyZnXEA9S3X09QVQ1uC?=
 =?us-ascii?Q?hJZjW90OjHfuFwrI3WqZFDCjlNLZoIIOw+XYyG+SobOTBrMcLrk76QiqF11W?=
 =?us-ascii?Q?ov56pc7XI5zt/q7zP1ryzHy2dsmMTvU3OdoebWmu+YkSQGsVkZ8dmADKa5gB?=
 =?us-ascii?Q?Fup0tYTau/t1pkLHekpPMwpFPxFEsBvuvfDzy/aiEBh8k/9fKShXIKJwXfb/?=
 =?us-ascii?Q?6wHQF5/H4nzCp23cSSga7IdsRvDaDdQ/unuhI6N2tfNMP2BkztJYJ5eWTanO?=
 =?us-ascii?Q?JxL70q1XMUDjViFNfACxm7jElyO1RSYrKBh7j13Plvrc6AankCgJe4NjRbzh?=
 =?us-ascii?Q?rrylorxxzNlHWeUjaPi1jcfRAoZ92Tpxd7FdO9QxzpF8ul6RgjlbPY29rm45?=
 =?us-ascii?Q?EQ3euz0R9tzsRQzscdlO0hf8kthtDsqJ8h0R/S1eCW9OesQtxz3yAd3uht0x?=
 =?us-ascii?Q?2OaLh5vw0e8kxK9UZifDLGa3hPKvTF50X8KeEbuldNFN5T3gqagHEXSXQNQI?=
 =?us-ascii?Q?sJF23h39Zu1FiMNct36cUdFDNy73kvpvNS4ypQPdswd/PJmoNO0eE9Axsy64?=
 =?us-ascii?Q?tPADPrzK3cjDxqGimXd6gWQwWEI2OagZ+k1R?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:21:58.1044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4f19bd-911b-4511-937a-08ddbe6dda68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412

When "mbm_event" counter assignment mode is supported, users can modify
the event configuration by writing to the 'event_filter' resctrl file.
The event configurations for mbm_event mode are located in
/sys/fs/resctrl/info/L3_MON/event_configs/.

Update the assignments of all CTRL_MON and MON resource groups when the
event configuration is modified.

Example:
$ mount -t resctrl resctrl /sys/fs/resctrl

$ cd /sys/fs/resctrl/

$ cat info/L3_MON/event_configs/mbm_local_bytes/event_filter
  local_reads,local_non_temporal_writes,local_reads_slow_memory

$ echo "local_reads,local_non_temporal_writes" >
  info/L3_MON/event_configs/mbm_total_bytes/event_filter

$ cat info/L3_MON/event_configs/mbm_total_bytes/event_filter
  local_reads,local_non_temporal_writes

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Updated changelog.
     Updated spacing in resctrl.rst.
     Corrected the name counter_configs -> event_configs.
     Changed the name rdtgroup_assign_cntr() > rdtgroup_update_cntr_event().
     Removed the code to check d->cntr_cfg[cntr_id].evt_cfg.
     Fixed the partial initialization of val in resctrl_process_configs().
     Passed mon_evt where applicable. The struct rdt_resource can be obtained from mon_evt::rid.

v14: Passed struct mon_evt where applicable instead of just the event type.
     Fixed few text corrections about memory trasaction type.
     Renamed few functions resctrl_group_assign() -> rdtgroup_assign_cntr()
     resctrl_update_assign() -> resctrl_assign_cntr_allrdtgrp()
     Removed few extra bases.

v13: Updated changelog for imperative mode.
     Added function description in the prototype.
     Updated the user doc resctrl.rst to address few feedback.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The rdtgroup.c/monitor.c file has now been split between the FS and ARCH directories.

v12: New patch to modify event configurations.
---
 Documentation/filesystems/resctrl.rst | 12 +++++
 fs/resctrl/internal.h                 |  1 +
 fs/resctrl/monitor.c                  | 44 ++++++++++++++++
 fs/resctrl/rdtgroup.c                 | 74 ++++++++++++++++++++++++++-
 4 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 57fd12f0aeca..06c8c08d0341 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -342,6 +342,18 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
 	  local_reads,local_non_temporal_writes,local_reads_slow_memory
 
+	Modify the event configuration by writing to the "event_filter" file within
+	the "event_configs" directory. The read/write "event_filter" file contains the
+	configuration of the event that reflects which memory transactions are counted by it.
+
+	For example::
+
+	  # echo "local_reads, local_non_temporal_writes" >
+	    /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
+
+	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
+	   local_reads,local_non_temporal_writes
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index b107874407b2..b42890fd937a 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -409,6 +409,7 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
 				  struct mon_evt *mevt);
 int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
 		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
+void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 787dce934903..0722e72f6cb1 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1173,3 +1173,47 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
 		rdtgroup_free_config_cntr(r, d, rdtgrp, mevt->evtid);
 	}
 }
+
+/*
+ * rdtgroup_update_cntr_event - Update the counter assignments for the event
+ *				in a group.
+ * @r:		Resource to which update needs to be done.
+ * @rdtgrp:	Resctrl group.
+ * @mevt:	MBM monitor event.
+ */
+static void rdtgroup_update_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+				       enum resctrl_event_id evtid)
+{
+	struct rdt_mon_domain *d;
+	int cntr_id;
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
+		if (cntr_id >= 0)
+			resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+						 rdtgrp->closid, cntr_id, true);
+	}
+}
+
+/*
+ * resctrl_update_cntr_allrdtgrp - Update the counter assignments for the event
+ *				   for all the groups.
+ * @r:		Resource to which update needs to be done.
+ * @mevt	MBM Monitor event.
+ */
+void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
+	struct rdtgroup *prgrp, *crgrp;
+
+	/*
+	 * Find all the groups where the event is assigned and update
+	 * the assignment
+	 */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		rdtgroup_update_cntr_event(r, prgrp, mevt->evtid);
+
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+			rdtgroup_update_cntr_event(r, crgrp, mevt->evtid);
+	}
+}
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index bb28ef7e4600..4889e7556cc7 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1916,6 +1916,77 @@ static int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq,
 	return 0;
 }
 
+static int resctrl_process_configs(char *tok, u32 *val)
+{
+	u32 temp_val = 0;
+	char *evt_str;
+	bool found;
+	int i;
+
+next_config:
+	if (!tok || tok[0] == '\0') {
+		*val = temp_val;
+		return 0;
+	}
+
+	/* Start processing the strings for each memory transaction type */
+	evt_str = strim(strsep(&tok, ","));
+	found = false;
+	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
+		if (!strcmp(mbm_transactions[i].name, evt_str)) {
+			temp_val |= mbm_transactions[i].val;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		rdt_last_cmd_printf("Invalid memory transaction type %s\n", evt_str);
+		return -EINVAL;
+	}
+
+	goto next_config;
+}
+
+static ssize_t event_filter_write(struct kernfs_open_file *of, char *buf,
+				  size_t nbytes, loff_t off)
+{
+	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r;
+	u32 evt_cfg = 0;
+	int ret = 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	r = resctrl_arch_get_resource(mevt->rid);
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = resctrl_process_configs(buf, &evt_cfg);
+	if (!ret && mevt->evt_cfg != evt_cfg) {
+		mevt->evt_cfg = evt_cfg;
+		resctrl_update_cntr_allrdtgrp(mevt);
+	}
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -2042,9 +2113,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "event_filter",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= event_filter_show,
+		.write		= event_filter_write,
 	},
 	{
 		.name		= "mbm_assign_mode",
-- 
2.34.1


