Return-Path: <linux-kernel+bounces-746178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 947C7B123E7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9021CE604C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BC6254864;
	Fri, 25 Jul 2025 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lCBhfEVj"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9A253925;
	Fri, 25 Jul 2025 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468372; cv=fail; b=L8rvmh8lGVHCfNdTuWfjFCqEK9Ivya+BGa14VepsYthWkhmDY4QKDk99h+tgk4zVCXq8bzXQXks9jWFWYmfO33aZqjA+aEVcDb6f15+ho81rLMdh7PITia+GXYvt0UaX+voj+Ek9nXfr7eeGKFqMzn8NYB3x+xKR3BiUsthkbyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468372; c=relaxed/simple;
	bh=gvEI57rMSAhNoHWDpjh9P/sYeVDnTHRT9TL10SmkQuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G41TPG96j4XFxMNmsnCjo1YNf94t/b3PCBs8CzhiAr3c7+Wef9s+rjCFQTe+t4nCByn4zOxPC2xU9x38q4ykjr4TJgqvHsZRyfx5YQrjx6jaDdt2QHxgP/G2MrysFh92NfFAJldLThmHCeVtpetTgHAxFi7bNwWyX3ku9OS37ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lCBhfEVj; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/S17FJ/XBdxZF4zggXplY42pJ0BZF4RGE6v5fvW8B0CO/B5+1RiFXXWhx81IfkoAYtW24FDIM82RBW+33tHoRiaGsI0dm98A0R1ck/gN1BooF2svmud0nKWTfTqhVtdImfjBFfCqtD/duG85PPIwuTpdkj/B0da5OxKlMQHT+JB3eEL4H7VRUt4Zqa+WG2U84KHZOEhlOUyKD4wF6zuebLM1d8eRQ1er6fHq4hPbaI+DOVgGp1AKgGtX5tKcvblV1DW+msz58jbFy28dbd3dLQk+JVZT7SsWAYAN5HtUMpvCvgEJxcdYBCpVqnyaUqvLsfyr2Zi/TvSA3cL80IqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEmcsdzWI/IaUa2TyNq/nrWfN8iDKh5FssD4n3+c4sY=;
 b=RW0aalTucpi1IQO/3QQ0Xa+9ClMHbPNKQ7iI76AsJieMgoMxoX5IFbdIVH3rAirmtYBF1SDxmh5k24t7ILt65sYFHTyBlRck1LH3t9ujZu/O0QnXrYfm82JUl9q9b/Cp4Vxf27vE1n8U5VIINDyq/18lQqTnGe470RQ8uX4eof2VbEbBGPHLj8JuPUp/gScfJQEpjpi2nUB0vYrSFLKuDvjLKW2C4pXHlPtp9hu1ueQw6uRmfXmP5YP2y/N823gId7cJfH6JdKNNwLn10oBN4UwSb72TEOCSDe17TvRfBq9ePILI4Vg7bTTJcKHFP733BH5NFBJBdzoBYuWuREEwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEmcsdzWI/IaUa2TyNq/nrWfN8iDKh5FssD4n3+c4sY=;
 b=lCBhfEVj07r0XCar76LWhXNqxbQviLJRDYD0n+nwkIqPtV9j4IDq6vlt+q186hiGG+Ecs3mLouzaYK1uRiyG9fi9no46t9Wt50U9y7RwaFxMqdo/1AwPAxB0gSuAh3c62wFnfBR03rCiWwn/LTTz3A0LBc875bSiWQFFLsqdjK0=
Received: from BYAPR11CA0079.namprd11.prod.outlook.com (2603:10b6:a03:f4::20)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 18:32:48 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::b) by BYAPR11CA0079.outlook.office365.com
 (2603:10b6:a03:f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 18:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:32:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:32:44 -0500
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
Subject: [PATCH v16 15/34] fs/resctrl: Introduce event configuration field in struct mon_evt
Date: Fri, 25 Jul 2025 13:29:34 -0500
Message-ID: <b4720ce8145d77b0f08d5023d462db789dfee356.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
References: <cover.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1aaa90-2ac5-418b-fb78-08ddcba9a758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMpPeaqzdiPI9Z1lqDalOO+eDB0Biwf3MIdzMYioywuYfDd0gM59h2LWhtk3?=
 =?us-ascii?Q?op7mANdczl4voNuaPh2eS7uWiR9qSoG5wG/NYIO6svFMB6+QZQdXZCV3e4JE?=
 =?us-ascii?Q?fKmbhsCfH8lkA5kaJmYTSp27/qANfBCO880kFltgOnyAsrp8x0IUPGDVL72D?=
 =?us-ascii?Q?iqarXKbIlFYZKqWOhl4iyhut2inkPXeLYmyHhHOOjvSKihdTU432pXShp0RS?=
 =?us-ascii?Q?HoFtTEPHrOK9CVE8asRuej7ci/u8/hjZwut7QwRbXUVdyTN5lRqEZ3vXSzg0?=
 =?us-ascii?Q?Z1WF0zMKoMmlWinWZpZVzVJyBYLkNQxQfNQAQ3ZTlboDu1kh+QZXscPyRhNo?=
 =?us-ascii?Q?qcCJI/bUN+rGRO+47sgyb2+ceK/nHJLluiwIpqYLnxWQYz9Vc1dMseekk/xf?=
 =?us-ascii?Q?8O3kzTXdDCBv4q2Gw4AwacZqJ1NZVIyD5nEyxXlbvYes3TVtH1o7YVUGc7pa?=
 =?us-ascii?Q?1ctGeGUHWR0P7rzk2N/JkE0UEPscbUfq6ZiUGLz4ZmlZnMCEMGHlPMbj6Om4?=
 =?us-ascii?Q?EDYWVICCOCfmQR0mEYDt3iv7IW/mT86XgErM6z+7TYvx8MTnA6VrG5+Wdicl?=
 =?us-ascii?Q?KY9zdoj3OApaffSko9ncT71j8CHjXy5+tPjlcBCB/wduatYFdNPB+X8o8Wef?=
 =?us-ascii?Q?uKt0T9RE+U50xkH1V6VdzQEbQ4ZMVXZztzOa4F/1h/0NN5xIPZujBLqLOG7y?=
 =?us-ascii?Q?fYKZi/FYq2WJzRi+ykmP4aMkuVBzfAS1NWD8PIIkhzMja/lh78HTXhrb318S?=
 =?us-ascii?Q?lg0VHZrEgSZy2HHrq9e6UpacD7yfEfBvcDM0ZRTH6/Q9t/gsY8UYDxmS/G7+?=
 =?us-ascii?Q?qeJ95833Q7Vuc3itP5Of705zOf49VZ9ovDN89wkYevOTOBXFiAhOkLeYkJ94?=
 =?us-ascii?Q?m5hCy9LeROvy89JfnNZKZ5TkLlhKbnUJB5yk6qebpIJwaMm7dQDtYM7MO7bb?=
 =?us-ascii?Q?O3bo6GBocpLpoXAc2WLMeqTakiNEbyY7nDxo/elbYalennySTKdXa+Ri82zn?=
 =?us-ascii?Q?fxla3d9fwLdGBY5RrMazaScIxh3lUsib4vOa78lnvPaqxP1RltMdB7CsSKbX?=
 =?us-ascii?Q?qIf9Yu4dQBOGZ/SsZX0giZP7Zib+IaIVmNwcwPh4wCrKP/BJtea3OWSlJ/UV?=
 =?us-ascii?Q?67mAFZfXMxkSY4TtXf5LB4e6YVvOHpO1cTIGWRPG9/codj33IooDsOPkYI/u?=
 =?us-ascii?Q?B/mk93HiCO95DfNeKJSqMohnRSnRxuzix+adZI6bz5GZKOqSxmUixNkS5Ple?=
 =?us-ascii?Q?/yCLWjnz75K+Zy2PPknBwGME37PBMEuJZ8fxHSLYnHwqXdirTBcAR6WnG9bB?=
 =?us-ascii?Q?S8ynmlNdU/+z6tkSKYw521EJf45XesOCKn8TM1mj9+AbyNDP6z81bzxS4J34?=
 =?us-ascii?Q?HaUP8BNfScBFeGRPMvpvbyHzM/DpwqTLly2RWN1oKmuULdQOArlQg6+T/wHN?=
 =?us-ascii?Q?WxwAGwfItty58WqLHLJGV8OWNQ7DEUqhHtkoZMSTJwL92VEwgHbrM7dVucDC?=
 =?us-ascii?Q?w6IwaZ1Qm69ELbUlN7tE/b6Ub7DMuUBU+isOOKJdCEqjRmh/QSsZg3pN4Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:32:47.3057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1aaa90-2ac5-418b-fb78-08ddcba9a758
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607

When supported, mbm_event counter assignment mode allows the user to
configure events to track specific types of memory transactions.

Introduce the evt_cfg field in struct mon_evt to define the type of memory
transactions tracked by a monitoring event. Also add a helper function to
get the evt_cfg value.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v16: Added Reviewed-by tag.

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
 fs/resctrl/internal.h   | 5 +++++
 fs/resctrl/monitor.c    | 9 +++++++++
 include/linux/resctrl.h | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 4f315b7e9ec0..db3a0f12ad77 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -56,6 +56,10 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
  * @evtid:		event id
  * @rid:		resource id for this event
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
index a0b0ea45c7b4..a089867262fa 100644
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
@@ -929,6 +934,10 @@ int resctrl_mon_resource_init(void)
 			resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
 		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = MAX_EVT_CONFIG_BITS;
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


