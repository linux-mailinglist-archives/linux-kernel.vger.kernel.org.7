Return-Path: <linux-kernel+bounces-770010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDEDB275D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD0387BA71E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D8729A30A;
	Fri, 15 Aug 2025 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mnvYqxJP"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB02BE636;
	Fri, 15 Aug 2025 02:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224928; cv=fail; b=OuqgdymR4Gs6osK3DROb8cf8aDq6oamZR1ksfKTTWiRIltEKCkD/SX05c9ekqFqenkaCpckTW3RKOjA5E2gx6Hpf4fXGISEaXGolgygd1y0NkW7gpxn578xZW0SG2qEvdxygP7fPU1oQGfeSH4oysvKxS11JqgU6I7ASUIDDYQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224928; c=relaxed/simple;
	bh=Fn6KTxqsrwZGlKiSwtbuOuIQQhiQuMWDVOfXyOCdSQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3pm+605Ex6w01hjzQMHd3fUDM0U+q464H9DfwXw4D9QXrKFs4NuGeMwtrsUw58cyGBkuqrGFXL65qz6jICZQIWULjc5n7TbhJWi0F5i+omvuGqVxfEocFKfpiln8uRTTkrTpjAJwF/65XxC9730JMGAiYMI5AJMsA2cOiZVj5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mnvYqxJP; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYcsFzkj8kRGeNyIOb2PdtpKzGOTaaLKH8Qpv1kdUDS0yCm7b+9ifRgSnv/SA1+Ffr+HPNgPelu+HBPOZ3hxipRdG/5Qqvdw/XDPAYHcmEJMVHuDmcDFz6ssHNGyqWIUGuLbO2qxMIpI4LNiIahEpJ9r0asArA0Nvfc57JFJCo6VpjkfxBDQlry823Hcysnr4duMguNVLnV4M9cXuGDygG8LQkf77xvJ1LqGq81TzK+7ABbfdS3gZ/OdFK3HFTqBNQWNlEy55OocBcZYl2Au07PDJUTOpn57nUm0xrSFHpzOlu+kIAoEDWw94TuxAVFEE2IcyuJRMkDF0Ph+XzzHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgS+1PrZxqCnrClcxLjL4PELWk9E7Rrl0Q01+/eVFKc=;
 b=Ouq2DGxIuu6gY3Rai2dqLfNOv+9yRT1YnCAvUuRbkcm7iNMCzmTt20olRnk2YwdHt+KsJbYTeJKFflifFIps3OOea8vLdcbx0zJGvXQGzZetPa7+IXZT6LWTEKNWVY5d1TduMKzfgJpEeU2U4NisRXk2V7q/DkP5peyJB2vo8YhNzEpbYuo9+r4/XUmfWTq/KRw66QkwJ9bP6NWoh0pxdUwBRNfMFD/cW54Py6XJBTYpvPTCKvlfogHd49pjYubzno5LjSI2YDTnB/UPBisOXOqnuY3VTBJWM2TjRv2w5f0j6JkjTGZ3j4x0DHOdL+6HEdR14pTIVYYHUWbm2GnReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgS+1PrZxqCnrClcxLjL4PELWk9E7Rrl0Q01+/eVFKc=;
 b=mnvYqxJPJuMWZBO4aO4s/TiYv55T9pcd77YMXT4n+TOYF/DxyWVuakc7/m0ERq9Li37iSlrqGLsBDVMiG7ti4AwVZty4Mn5iWoFzqaPTXGelodwTc0FIk2t9sMLGhX6ZP7hVrEZa0019ZwgC6e9HAVppHT8gaKKHnHcK4rNQLQM=
Received: from SJ0PR13CA0219.namprd13.prod.outlook.com (2603:10b6:a03:2c1::14)
 by SA5PPFB1A5CE29A.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 02:28:43 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::34) by SJ0PR13CA0219.outlook.office365.com
 (2603:10b6:a03:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.6 via Frontend Transport; Fri,
 15 Aug 2025 02:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:28:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:28:41 -0500
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
Subject: [PATCH v17 20/33] fs/resctrl: Introduce counter ID read, reset calls in mbm_event mode
Date: Thu, 14 Aug 2025 21:25:24 -0500
Message-ID: <c007d6e024e9c8c302b7996ad73bfad3312e13e4.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SA5PPFB1A5CE29A:EE_
X-MS-Office365-Filtering-Correlation-Id: 67647e34-3d1b-404f-e09a-08dddba3748d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8A8jQqw1z2pBXTG5kut5BinYm3Aj8yu92KqUBLaWQS6Aa+0oWea2hIcsPsTm?=
 =?us-ascii?Q?D7gXIZ1/rg9WoxUb/y0gMS2RGju4VI/xkVkZA8z5bzG62oOycoIY4EinWtLW?=
 =?us-ascii?Q?Ym5XwfxajY1MoYNsyB6MBq5/BN9F5ar+5V7LbAXeLA7GnlKprHj6PdFtLfYh?=
 =?us-ascii?Q?ZAtbIiIWwukalP2m49bjJNxToY8Mz47kXqAxpIuH/kO0/pfc4MWfUsUlm+PV?=
 =?us-ascii?Q?ZpQcO9dCXCRwWE8FnJuJqclS1qnMuoYdj9G2Qw2jsMZ1RWygN3H+Tn8s/Ccs?=
 =?us-ascii?Q?iuiuiBj0WwCbi3inN6AbNc3Zbw/eN9oONH5B/UFEz9mMQGjrt3y12P+nqG4x?=
 =?us-ascii?Q?fF2z7c6rQcRSffrGJNRoiZkz7SavFuEAwi6NSikPXgcMTGKzoUPGgsLTEWJ9?=
 =?us-ascii?Q?fqq3PRm84d+FrndJJ2cHfYhzPBymyaSfOsmRYsezHoxdbCBJiW3hSH3VV1P9?=
 =?us-ascii?Q?+fHB+3IgKvwGCjKM5EHEU0OU6bnhI2H4TJ9+MT8V7u+PRmQIC7GmeTLAN/eO?=
 =?us-ascii?Q?bBFOtvOPwxE1HiRlJhZ/CDIu+xRnCdAkT05RAijON64Yk2r5jaFjhBUDNOv+?=
 =?us-ascii?Q?oVIbRRdreyTI14mpmecI+Y2KZGUQO4HsTzqzkzJjWuqNpkyz5DCaJ1nQK7rh?=
 =?us-ascii?Q?Wlro6hiGaqnbdCIcD5amSQsH//nvPYfg4fHWqyuRB9gX/KkBsx8X8gW+0ah0?=
 =?us-ascii?Q?/exyGEjEfWKCARjwEEEn+v6uIXIKYxMjdNSF523m7xvYUuWWSmxcfYNRcG4S?=
 =?us-ascii?Q?MFc/w1w5XnxqcMRRGl27y213nhyCuMACBHUS6AKQc8AL3uOCFZTSWwGsTTsP?=
 =?us-ascii?Q?6HqfyGG6t2vSkfBLe3n3ETcRCnTkH55tkpJYzMEYF3j4KmHBQ4Xd5FUX0lh6?=
 =?us-ascii?Q?roA1nSgq9zVWQ3F6aq3ifNcqhlxBHJ8sDIJXjVPBoPpda1trt9KR4o4xLgrx?=
 =?us-ascii?Q?5pdDF5bhLTsO1mfNGDQSSocyVvK0cPpdkd8UoiCK647WferbxnnXOF7I5tRZ?=
 =?us-ascii?Q?1SUGQW+KsdcuBkXk5PprnPHORxck5s9STzVXzWvRRIN3gyd0MpTAayvRpJb4?=
 =?us-ascii?Q?waksV3a+AZYkAg9SqTOUVo5CjrSCFYxX0LwZZVmZrmt/dplogt1DNwPKJGvQ?=
 =?us-ascii?Q?2mgxLM+lf9nMVfFcU+WTxPP/H+O2C9KgcQ/QkZYfpetyNgsS6Z8zc4ufFwYj?=
 =?us-ascii?Q?yi7WcrYJYYyroc6cGGGtmu1QWeebrLYfSHOlIJs3wwF6E8EnR3PPOJ/wwIuf?=
 =?us-ascii?Q?c58+JYQrXOJKsMzs+WpGfhtsEd5ULKT03TB3jSgNdfPEAo4D1C/WTurPN8vp?=
 =?us-ascii?Q?gUAdD0q0qDgXuPbkgvtYXOt6DiC7CIJYnQgDXLpim+Jfx60CauYC3tFRfKuv?=
 =?us-ascii?Q?WB8SJF4dKsXA6cRDyX0pr49TKYd5OVLTP8ptTv/5yzND1ILhlZwuD70aFn2V?=
 =?us-ascii?Q?SQv4EwO/C8kfKalWTLln1c2cfhWmiFoTIRgCe37pzAV1sG2jYSPCAEgU09ih?=
 =?us-ascii?Q?RH8LNrtCm/uFdKKMX+/OwnwmcAJ0wAP41yj3WRriDkFBhJc9r6PCyvYnrg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:28:43.6747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67647e34-3d1b-404f-e09a-08dddba3748d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB1A5CE29A

When supported, "mbm_event" counter assignment mode allows users to assign
a hardware counter to an RMID, event pair and monitor the bandwidth usage
as long as it is assigned. The hardware continues to track the assigned
counter until it is explicitly unassigned by the user.

Introduce the architecture calls resctrl_arch_cntr_read() and
resctrl_arch_reset_cntr() to read and reset event counters when "mbm_event"
mode is supported. Function names match existing resctrl_arch_rmid_read()
and resctrl_arch_reset_rmid().

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Updated the changelog.
     Updated kernel API doc.

v16: Updated the changelog.
     Removed lots of copied and unnecessary text from resctrl.h.
     Also removed references to LLC occupancy.
     Removed arch_mon_ctx from resctrl_arch_cntr_read().

v15: New patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
     with mbm_event mode.
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
---
 include/linux/resctrl.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 50e38445183a..04152654827d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -613,6 +613,44 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
 			      u32 cntr_id, bool assign);
 
+/**
+ * resctrl_arch_cntr_read() - Read the event data corresponding to the counter ID
+ *			      assigned to the RMID, event pair for this resource
+ *			      and domain.
+ * @r:		Resource that the counter should be read from.
+ * @d:		Domain that the counter should be read from.
+ * @closid:	CLOSID that matches the RMID.
+ * @rmid:	The RMID to which @cntr_id is assigned.
+ * @cntr_id:	The counter to read.
+ * @eventid:	The MBM event to which @cntr_id is assigned.
+ * @val:	Result of the counter read in bytes.
+ *
+ * Called on a CPU that belongs to domain @d when "mbm_event" mode is enabled.
+ * Called from a non-migrateable process context via smp_call_on_cpu() unless all
+ * CPUs are nohz_full, in which case it is called via IPI (smp_call_function_any()).
+ *
+ * Return:
+ * 0 on success, or -EIO, -EINVAL etc on error.
+ */
+int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+			   u32 closid, u32 rmid, int cntr_id,
+			   enum resctrl_event_id eventid, u64 *val);
+
+/**
+ * resctrl_arch_reset_cntr() - Reset any private state associated with counter ID.
+ * @r:		The domain's resource.
+ * @d:		The counter ID's domain.
+ * @closid:	CLOSID that matches the RMID.
+ * @rmid:	The RMID to which @cntr_id is assigned.
+ * @cntr_id:	The counter to reset.
+ * @eventid:	The MBM event to which @cntr_id is assigned.
+ *
+ * This can be called from any CPU.
+ */
+void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     u32 closid, u32 rmid, int cntr_id,
+			     enum resctrl_event_id eventid);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.34.1


