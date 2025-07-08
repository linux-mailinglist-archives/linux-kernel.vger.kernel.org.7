Return-Path: <linux-kernel+bounces-722440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0E3AFDACE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECA61AA528E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A010725CC58;
	Tue,  8 Jul 2025 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RLjw7kjp"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42DA259CA4;
	Tue,  8 Jul 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013100; cv=fail; b=U0sriYlrWGL4QM51WJx8tnW4UiLd2ys5ku8t9WcrCqquhuPPP7GRY25npF3TwEGyFXL9SxWm3VWYRk0xEQ0pw8zQ5cNrQ3KO5Ox3NYjVs8J4gNrLMgKZ5d9yw0DlKe1RJBomXV95hKQKGnJClqPW1QQJwvgV7g3OcYx6xW2t2zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013100; c=relaxed/simple;
	bh=e9/dV+ZaYbEtrPa4h19oo/+VOtHNDroyIYbw9T+k4WQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aan/F19nUcFX2q8xR2RRjN5Dz+jyRzCFQ0ZtxwR982yAdXwyk9atCmY/eoP+QT7IKYjaUR0kb43DZ9vY7oot6a0COBOnAOws21BAn0609Qn9X7nZU0U1ToYTBrcMQI35XxVgz85WwEhhJzELSG+f61hU5eLOmF7vNyZpJJ3xcfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RLjw7kjp; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ywt4FAb5lK+fEX9oB0KveFDwaXAm6nG9nVYhJ/uwCdVbfMRYJE56qmlwsZinrX4zG5+4EZiyRtDEEB4rmVkX3Fb3pFupqSRQv9V5Tf/rQNnjcVj6FKk95u5p9jr8IflMqoO+pAl8QEfjaxDsByU2CeJOYt7Tnx7wz+lPB83IzJMGGCBlfJuLGbmZs0pRi7ZQzkliUL0EdiLWDFAFPXc9Q8obUzJUCGAa2dAswx6ecfp90tQWJOyyWlW8UbSBZyyO3QbdMj5UbZqpZBwzw/2vhWxIG2HlqDLZHd7QqbRTS9mi98Hwp3gL/ecqEUAWKROWpoHoWfSCaCXBHCG5SchmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhhIHheU+j4HRuZuWpSamC/TVO31QeTGb3pZdQpYtzE=;
 b=cVhH0r8Nmn+mZhWIfuiCo9eL70Wgu28s2RHZJWmFfqdH37IzLWPjJ0LXWQFcl7Vn/eXlrDfnB/gCSPZWTzWpLrlYV+9f5JkKWldVIP+9uGibqXeLRo7HOZQDhzgHCXiD6Eal788JlJDcoGDK67Qk6su2tXrh6Ao0CZEX8J7rW7D/5jkf2s6Aurhb+eAvwZe3YbN0HX3OcUcxtrY9U7QZ/eqqUzb8RlFRQfCIG3xD7HQIqhQ6j2di1bO9F9mxvO1ihvM7hwPLsCzfWP1MgQ69evwEsvX+lbfbTOKHkhDfssnGEixbq0eFX/whT6PKlMn3UeU+eSiES3GGwzVLLFbTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhhIHheU+j4HRuZuWpSamC/TVO31QeTGb3pZdQpYtzE=;
 b=RLjw7kjp+tBRrOwuaEy+JWF4kEljz20vRKbzNgjnCH62QCCRxQ1BFpqvueKN1oP6Lmvi5XNcQxUIyYn42CLLwPPEjkjkSw7uIWF75OqgBHpTVs2SUcd71oh/RFAdIUhXp6JVXJYKn2iMm7rpsHMCLCdnJBIQsbJ5hXXeeNuAgMU=
Received: from BY3PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:39b::11)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 22:18:13 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::4d) by BY3PR05CA0036.outlook.office365.com
 (2603:10b6:a03:39b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:18:13 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:18:06 -0500
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
Subject: [PATCH v15 01/34] x86,fs/resctrl: Consolidate monitor event descriptions
Date: Tue, 8 Jul 2025 17:17:10 -0500
Message-ID: <7d999eb2e9435282339b1e6b39cfc5347664eadf.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: c018d71c-5ac2-42f7-fa93-08ddbe6d5468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YPdkqfTuZSCeZl+TpfL6keCzjNGmgyTfpPuT/S9BnhZiXbdoaFi+LTqcyOZC?=
 =?us-ascii?Q?13l7FJlfYygp6hBsDIc76Ls2XUL3s1I10CgEJ/2dqq8dAzFZ2gtF+KE7oF0z?=
 =?us-ascii?Q?yV12GAYsbN6+D2CdlVmeF3an9T1lZnp5P4K4RcWBi9nv9py57GSWxvxQdg1K?=
 =?us-ascii?Q?K5kfBfo3FCEbugCyAU1CLqU+tLIzA/0TVhBsTGrtDDLrbz2YLnvrAa+c6Z7y?=
 =?us-ascii?Q?aPiMqnfct0ZLxVruRft6gM5ZfxA6CCf9/S560X2gr7fvw/uxlAIAjS35Eawh?=
 =?us-ascii?Q?zXMjdtiQcfAFkPbhbEW4bHwx/xcPbtBtiUP6ANOu6NPLVi97HXtFUW2Bnd9c?=
 =?us-ascii?Q?mDoojufnbpQlOyqxdPwsvWjUYsB41trcG+5BdvTX02rO/BEGGtzP3D9xZ9u5?=
 =?us-ascii?Q?s8ViNl90eY0JXrRK+u/Zdgxr036DMumv1QnciN6nvXZBZjgvOz+b3ymJXOm+?=
 =?us-ascii?Q?5ZUNvOkLH07/OtIg2ePSyh9sU4Q6nzjFAbn0zM9kXw8Qc6PA1O0bYmhgrmP0?=
 =?us-ascii?Q?3fjTc5YlH0ftp5LJc3dS1mDh9cf34+NTjY+aGwnt4+8DpX+qKciuS/gmx9Rb?=
 =?us-ascii?Q?a4CdaikXZmNS0ogpo0YNaJot1+tpwEsSygT2UXyBANXIA7SqLb8F600DAg1G?=
 =?us-ascii?Q?inbj0V2QEsJ9ud3eupp6cBoIVA3FSqBBEj2EXfni/sGOh91bCZ7pFervmTYg?=
 =?us-ascii?Q?tYvYniej4MX5ks+Stt/96IBfCo3onpqa44gSAFO+2+Tph7fju9GpzpC9X0yd?=
 =?us-ascii?Q?X5Bnr1bq48NiOaURZGekKOTyu9au0zOyULvMsxdRO1qYpEKiRnEtH+ZlPcs2?=
 =?us-ascii?Q?/E+VShbToQ8bpkDLG0IKcCqm6PGJy+k79zylLPc9T70wEapYRL4olYzbrTB0?=
 =?us-ascii?Q?mJo1WPrz8V8Eaci78aEccIxD1tjPbZn0Gmf8V8+DNo7Ll1VGxBdEmbNhGVxw?=
 =?us-ascii?Q?4lM4aJvt0pFS4ekSXfTQI9/whL8EoiUF+T3ygA767Agg6+ctu2KbLNBV7wGC?=
 =?us-ascii?Q?fgBq4ZRFF+yuirUUcW8QGOvZ4erKx4hzQQKA8Y6qqvbVvrYx539MhzXAEK6H?=
 =?us-ascii?Q?jxBfy/6HUYCEQa4TfuEhiROJY0JGaYsCpQ+8I1ctqnuaUQiwZjt792oidN9F?=
 =?us-ascii?Q?i7Hs9D8GeW8oC15i1tCwD0JvTe2MEUMhmW4zd7U/gzw46b7FDy8x1VAhPTxf?=
 =?us-ascii?Q?/sd+3KZV18LjB4AIxt3yxFO4iFdY1ETUIQlaY1fe4WlZ1GhjRJbT1siqsOAZ?=
 =?us-ascii?Q?7OS3UizFsJRNe0rudaJllvGExZYvV5e7Wh1c2DdjO/gGlKBV6t4sah3dTeMk?=
 =?us-ascii?Q?PQOSQ+6hjbaJitsNbRQaBe4g9jES58PCr85D/Pm/unK24yp7Ck7umjuTkisu?=
 =?us-ascii?Q?ahoV7XNuU6gDauBiBE2dRw9rQq0TvawQuPbNBrNB13Z+PIReUO2/0LaPkHQO?=
 =?us-ascii?Q?fWP4r8ITJfgwjPk/3DT2+0Gwvo1vJlB6mTPqrxsvvovEsqwI5SrtiR0hca5v?=
 =?us-ascii?Q?qwQ8quQFxwsfUSbgYCRVT54FUYrK51m8Snp6uCpO6WHHcyeznjRioREsCw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:18:13.2005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c018d71c-5ac2-42f7-fa93-08ddbe6d5468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204

From: Tony Luck <tony.luck@intel.com>

There are currently only three monitor events, all associated with
the RDT_RESOURCE_L3 resource. Growing support for additional events
will be easier with some restructuring to have a single point in
file system code where all attributes of all events are defined.

Place all event descriptions into an array mon_event_all[]. Doing
this has the beneficial side effect of removing the need for
rdt_resource::evt_list.

Add resctrl_event_id::QOS_FIRST_EVENT for a lower bound on range
checks for event ids and as the starting index to scan mon_event_all[].

Drop the code that builds evt_list and change the two places where
the list is scanned to scan mon_event_all[] instead using a new
helper macro for_each_mon_event().

Architecture code now informs file system code which events are
available with resctrl_enable_mon_event().

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
v15: Picked up Tony's tree.
     rdt-aet-v5.5 branch of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
     After Reinette's comment on previous version.
     https://lore.kernel.org/lkml/e9eb906f-d463-4c1e-9e15-5ed795fe5366@intel.com/
     https://lore.kernel.org/lkml/b761e6ec-a874-4d06-8437-a3a717a91abb@intel.com/

v14: This is Tony's work. This is part of Tony's telemetry series.
     https://lore.kernel.org/lkml/20250521225049.132551-1-tony.luck@intel.com/

     Tony made special update for me to include in this series.
     https://lore.kernel.org/lkml/20250609162139.91651-1-tony.luck@intel.com/.
---
 arch/x86/kernel/cpu/resctrl/core.c | 12 ++++--
 fs/resctrl/internal.h              | 13 ++++--
 fs/resctrl/monitor.c               | 63 +++++++++++++++---------------
 fs/resctrl/rdtgroup.c              | 11 +++---
 include/linux/resctrl.h            |  4 +-
 include/linux/resctrl_types.h      | 12 ++++--
 6 files changed, 66 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 187d527ef73b..7fcae25874fe 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -864,12 +864,18 @@ static __init bool get_rdt_mon_resources(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
-	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))
+	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
+		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID);
 		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
-	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL))
+	}
+	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
+		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
 		rdt_mon_features |= (1 << QOS_L3_MBM_TOTAL_EVENT_ID);
-	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
+	}
+	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
+		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
 		rdt_mon_features |= (1 << QOS_L3_MBM_LOCAL_EVENT_ID);
+	}
 
 	if (!rdt_mon_features)
 		return false;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 0a1eedba2b03..445a41060724 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -52,19 +52,26 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
 }
 
 /**
- * struct mon_evt - Entry in the event list of a resource
+ * struct mon_evt - Properties of a monitor event
  * @evtid:		event id
+ * @rid:		index of the resource for this event
  * @name:		name of the event
  * @configurable:	true if the event is configurable
- * @list:		entry in &rdt_resource->evt_list
+ * @enabled:		true if the event is enabled
  */
 struct mon_evt {
 	enum resctrl_event_id	evtid;
+	enum resctrl_res_level	rid;
 	char			*name;
 	bool			configurable;
-	struct list_head	list;
+	bool			enabled;
 };
 
+extern struct mon_evt mon_event_all[QOS_NUM_EVENTS];
+
+#define for_each_mon_event(mevt) for (mevt = &mon_event_all[QOS_FIRST_EVENT];	\
+				      mevt < &mon_event_all[QOS_NUM_EVENTS]; mevt++)
+
 /**
  * struct mon_data - Monitoring details for each event file.
  * @list:            Member of the global @mon_data_kn_priv_list list.
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index f5637855c3ac..2313e48de55f 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -844,38 +844,39 @@ static void dom_data_exit(struct rdt_resource *r)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-static struct mon_evt llc_occupancy_event = {
-	.name		= "llc_occupancy",
-	.evtid		= QOS_L3_OCCUP_EVENT_ID,
-};
-
-static struct mon_evt mbm_total_event = {
-	.name		= "mbm_total_bytes",
-	.evtid		= QOS_L3_MBM_TOTAL_EVENT_ID,
-};
-
-static struct mon_evt mbm_local_event = {
-	.name		= "mbm_local_bytes",
-	.evtid		= QOS_L3_MBM_LOCAL_EVENT_ID,
-};
-
 /*
- * Initialize the event list for the resource.
- *
- * Note that MBM events are also part of RDT_RESOURCE_L3 resource
- * because as per the SDM the total and local memory bandwidth
- * are enumerated as part of L3 monitoring.
+ * All available events. Architecture code marks the ones that
+ * are supported by a system using resctrl_enable_mon_event()
+ * to set .enabled.
  */
-static void l3_mon_evt_init(struct rdt_resource *r)
+struct mon_evt mon_event_all[QOS_NUM_EVENTS] = {
+	[QOS_L3_OCCUP_EVENT_ID] = {
+		.name	= "llc_occupancy",
+		.evtid	= QOS_L3_OCCUP_EVENT_ID,
+		.rid	= RDT_RESOURCE_L3,
+	},
+	[QOS_L3_MBM_TOTAL_EVENT_ID] = {
+		.name	= "mbm_total_bytes",
+		.evtid	= QOS_L3_MBM_TOTAL_EVENT_ID,
+		.rid	= RDT_RESOURCE_L3,
+	},
+	[QOS_L3_MBM_LOCAL_EVENT_ID] = {
+		.name	= "mbm_local_bytes",
+		.evtid	= QOS_L3_MBM_LOCAL_EVENT_ID,
+		.rid	= RDT_RESOURCE_L3,
+	},
+};
+
+void resctrl_enable_mon_event(enum resctrl_event_id eventid)
 {
-	INIT_LIST_HEAD(&r->evt_list);
+	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >= QOS_NUM_EVENTS))
+		return;
+	if (mon_event_all[eventid].enabled) {
+		pr_warn("Duplicate enable for event %d\n", eventid);
+		return;
+	}
 
-	if (resctrl_arch_is_llc_occupancy_enabled())
-		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
-	if (resctrl_arch_is_mbm_total_enabled())
-		list_add_tail(&mbm_total_event.list, &r->evt_list);
-	if (resctrl_arch_is_mbm_local_enabled())
-		list_add_tail(&mbm_local_event.list, &r->evt_list);
+	mon_event_all[eventid].enabled = true;
 }
 
 /**
@@ -902,15 +903,13 @@ int resctrl_mon_resource_init(void)
 	if (ret)
 		return ret;
 
-	l3_mon_evt_init(r);
-
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
-		mbm_total_event.configurable = true;
+		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].configurable = true;
 		resctrl_file_fflags_init("mbm_total_bytes_config",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_LOCAL_EVENT_ID)) {
-		mbm_local_event.configurable = true;
+		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].configurable = true;
 		resctrl_file_fflags_init("mbm_local_bytes_config",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 77d08229d855..b95501d4b5de 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1152,7 +1152,9 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
 	struct mon_evt *mevt;
 
-	list_for_each_entry(mevt, &r->evt_list, list) {
+	for_each_mon_event(mevt) {
+		if (mevt->rid != r->rid || !mevt->enabled)
+			continue;
 		seq_printf(seq, "%s\n", mevt->name);
 		if (mevt->configurable)
 			seq_printf(seq, "%s_config\n", mevt->name);
@@ -3057,10 +3059,9 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 	struct mon_evt *mevt;
 	int ret, domid;
 
-	if (WARN_ON(list_empty(&r->evt_list)))
-		return -EPERM;
-
-	list_for_each_entry(mevt, &r->evt_list, list) {
+	for_each_mon_event(mevt) {
+		if (mevt->rid != r->rid || !mevt->enabled)
+			continue;
 		domid = do_sum ? d->ci_id : d->hdr.id;
 		priv = mon_get_kn_priv(r->rid, domid, mevt, do_sum);
 		if (WARN_ON_ONCE(!priv))
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 6fb4894b8cfd..2944042bd84c 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -269,7 +269,6 @@ enum resctrl_schema_fmt {
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
  * @schema_fmt:		Which format string and parser is used for this schema.
- * @evt_list:		List of monitoring events
  * @mbm_cfg_mask:	Bandwidth sources that can be tracked when bandwidth
  *			monitoring events can be configured.
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -287,7 +286,6 @@ struct rdt_resource {
 	struct list_head	mon_domains;
 	char			*name;
 	enum resctrl_schema_fmt	schema_fmt;
-	struct list_head	evt_list;
 	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
 };
@@ -372,6 +370,8 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
+void resctrl_enable_mon_event(enum resctrl_event_id eventid);
+
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
 
 /**
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index a25fb9c4070d..2dadbc54e4b3 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -34,11 +34,15 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
-/*
- * Event IDs, the values match those used to program IA32_QM_EVTSEL before
- * reading IA32_QM_CTR on RDT systems.
- */
+/* Event IDs */
 enum resctrl_event_id {
+	/* Must match value of first event below */
+	QOS_FIRST_EVENT			= 0x01,
+
+	/*
+	 * These values match those used to program IA32_QM_EVTSEL before
+	 * reading IA32_QM_CTR on RDT systems.
+	 */
 	QOS_L3_OCCUP_EVENT_ID		= 0x01,
 	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
 	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
-- 
2.34.1


