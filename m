Return-Path: <linux-kernel+bounces-722460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EED2AFDAF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6711C27D48
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AAE25A659;
	Tue,  8 Jul 2025 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TiXqW0Aj"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE4826059D;
	Tue,  8 Jul 2025 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013260; cv=fail; b=Je8DcTN9hNMFzMU3fW6epGhwZxknFm+EHE9MPlEyhlNwvduBzYsDkoFAn/Qfk4KIbFeaOu+vNnAtCtSXKCRArOVTUAlTzu5U9dmBZ9HFOBcJHTjrVLRj5AyU9gRWTrymlR2TgjoCEUujjwXZBl3E/Oqh0iyY/GXzCfGDzt/+Siw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013260; c=relaxed/simple;
	bh=FV6+tCQekyLC/Jzdd3rhs6XQraFew5ZYcpgK9d7j5sI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8vasDEO0genkj6V/0D1/slDXC/nJrdBJ/B2dkZImDJtWWkl9SSGjMo1JgJagZ888mSBkNwEoDo5841qV/gr20XndV+mzpihUs3tKBUjlq8XaYqQOB85RKYfGdgGnv0sLnvpHX7SLSb8mBJNrbfpNHyluXjeUuOlp93teeS7tLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TiXqW0Aj; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0aSUqrzNPNCL6fiWrCcQnpLBeiZufSgauIE69tAQvs7WfT/UkEKRXe+MkkWF4bJGIPs+EpkR/gc7GD3GxYm2InaQ+Zvbl3ZXUMnQT/l0XYDUb47U5TTTUv6C3IH4ZuByKqbbBaDv0ClpCOCSmEv1iD9CxEK0t58PR46LvWpqvGcPq4pZz9gGRMCpXT9nfQ4vDCwyccMHQ8jJzXUIA2g5y1obIDqggAh9jbien61SvZTYuUDVYf67XT2ov+S72etHnEtwYk1hJqqMFYna8ti17ul+GLjp9BUhyk0735EmXtavRV8UnUkYuw9uqG93ZarIbL65bVKLz0JPbg9oNrtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Zjes6R+tAVajVdAGEos7J4dsgTQajTWzRWiTGpnKvY=;
 b=k3ZkoNZUzUnA/CVzU8CopSmnYdn1MwDmCafQBetVnv2oDTxz4V+Cr0rpwMyvvftVUcLOrVHa/0cvfy5rS7iSdrP0iMU06GEkSeU+OLb8iHOzIr3uBVGtlc0DpmMs+8pSE9nvFlR0v6te9XLXF3fEy9vS1Q9Hko5a9cvx42MlXTsI2a84ZhZ2DmYMbuDph9ic/R6PWDg38NtqRBcplKIv6aMGUma4dF5S/J4jDG48rhG+n0PvWrNAGVt1Vwt7Lq1nBMFgeGqUr1d3BSeKaCPbAuyebY4ri7pZgaQm6oPiRRDYnGrduV+mmrXDLieSsIyfaEj1Ihd2skQCblCPDPaXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Zjes6R+tAVajVdAGEos7J4dsgTQajTWzRWiTGpnKvY=;
 b=TiXqW0Aj1DnfbzWv09nqBOfE/PIWpZbEzx80DeAA2kWRImA7zjNUeTVR+Weh8AuQYH1F8d2DElndFFFBFwApQMcBrsj4UcI4lhWEM3fmq51QD/HX2Ryndq4Ir/HTWJArUabPL2814KtiZrx7GtTAsnpPuYUxnoOj8+ORQwklWGk=
Received: from SJ0PR13CA0054.namprd13.prod.outlook.com (2603:10b6:a03:2c2::29)
 by SJ5PPF01781787B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::986) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 8 Jul
 2025 22:20:54 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::35) by SJ0PR13CA0054.outlook.office365.com
 (2603:10b6:a03:2c2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.19 via Frontend Transport; Tue,
 8 Jul 2025 22:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:20:54 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:20:51 -0500
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
Subject: [PATCH v15 20/34] fs/resctrl: Introduce counter read, reset calls in mbm_event mode
Date: Tue, 8 Jul 2025 17:17:29 -0500
Message-ID: <abb2f418a54f46dc3e2a78716f5ab643e112ca67.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SJ5PPF01781787B:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cf562b-2542-4281-05dd-08ddbe6db493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tGUpjuWQx/Rx+IeFhmATP73X8NZQrnzo+CXwp6QMjd7njtDd6Uidmuq1j4fV?=
 =?us-ascii?Q?MD4gaA7b9aB63GKesg63Znvp9htKUmJm+c8UPTvhIC/G4mJRkfD0dPP61Stu?=
 =?us-ascii?Q?bhqpBvbuDm1p8GfPY1lN3fVetFHG1kSMjIzpbCSNh7w5ja2Gz9p1jdZXR7p0?=
 =?us-ascii?Q?A0JhZj0pWJDSvwlR0iPDJabQ3c/tFBxV6/CylxHdrkOIUdp/9p0Nbhy818ck?=
 =?us-ascii?Q?eSm8h8Eq8rTbroorICt74Q9HjJKPTQOtap16t8GXswAGkXs/uQ57g9FXS8oL?=
 =?us-ascii?Q?TRFpprVxPmzQUckpi9H/uvjOSPEHP/S2q+/KZliFtWhZUWI73ASVKRIKxvsF?=
 =?us-ascii?Q?X5cj7JFKG1XhoMKPsgr9S9m5UwQrh+kvGV2xKFY9E1eAC2IKUY5ESFI6w9LA?=
 =?us-ascii?Q?D+LD9DpRxkAhmFFRrzdzg6m3cPI05K1eMAHTT2BqsIlG1+VGXb0eJF9XDeAB?=
 =?us-ascii?Q?w3RrGNVYK8+y8Iavj675gt+wZ5H1BD7ItldojipUxhWSSM4bvT9zU7H4SAPx?=
 =?us-ascii?Q?wSwIrKtTGz0M8z/RSzleWNU/JcL8HWzTtmPZ4Rh2IAGRLsVi/1412o78TP4N?=
 =?us-ascii?Q?q3p0sYm11dJGdwQwtJjEYpWrXpVDPNLc4KgxmTvNo/ApWsLjBL3/6ioX/Euj?=
 =?us-ascii?Q?LWOmfw45zekT5ps2akUnJez0mYcgLbzbAma5Dg1slyMasx855zTPNaU+tnuz?=
 =?us-ascii?Q?gfhKGQ5e1HL0R6AG4ltS4BTLdkJmQqoRWX58DSULc71UOcpFr6qxZNuFbML/?=
 =?us-ascii?Q?tRQ0l46Dt7L973NpUlr0jWCnk8X8jHxpmGOtv0EHY8GSw94WrWMHVRVFbUxC?=
 =?us-ascii?Q?eEQgtqVcwaMtU8nLhnYPeQNtXmWI1rXQ8utwZ2f0QzFt7yD0yQCNxTR1LnN9?=
 =?us-ascii?Q?BF1epLsf0GPsyFL4zJ6nlnC4ZXR5qtCpR73PmXteacCokbI+YX29cHzxV37P?=
 =?us-ascii?Q?4Mycks1hW4bw/vJE+uaH6MUEYEv7l9tF1sAnpowSuqmuUke24lD2ZXdD/6bT?=
 =?us-ascii?Q?PlXEB9POFcGlJFSmy3nbuZNS8gDsicc6E9106gzKdfqWERr6Ao4wzxa0eCB+?=
 =?us-ascii?Q?hbvK0ulliSzLkRaq0dNYyXqBwFeARhr/9ziO01ajh98VlTonDxjZmEB/wus9?=
 =?us-ascii?Q?Ylz2lGCxuxVxu/GKC0jWHp6dTlLHcBTQgqa2IO/p0pyudcPfe6bnbcWwLhFA?=
 =?us-ascii?Q?N9YCrQVL8QM+Ndo3vFLYB3G4Y3Y3nehA8UgyudXzZ7PUcEMr7Hp1DZO3aBBC?=
 =?us-ascii?Q?F/Itclq0HCaJBfKKlATJFWikHfWIEWv7Oxp7aP2VP4mPK053m29SgZLnXdKs?=
 =?us-ascii?Q?DMyOupDP16NlCGxI/PBtsFP+9Ilg+pOLuQArtv36QoXqFpGOIEfgDUIAsNM+?=
 =?us-ascii?Q?jvY/A9hT6F4Ci+HlLUyVlwIDO4SuzvSvVnHins9H71Y3ipQBCDqMDxwapynY?=
 =?us-ascii?Q?gRd2jsnIF8QI6e7SidEhqGeRIrJS4DRezWauI4Gv6S9JgIYyS2vQtDICY52I?=
 =?us-ascii?Q?/v2dpQhnqnDthdGiXHV1OL4oOtI4Dm8DUxIc3ikmhLI7Z77mH0Z88w0sjw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:20:54.5372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cf562b-2542-4281-05dd-08ddbe6db493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF01781787B

When supported, "mbm_event" counter assignment mode allows users to assign
a hardware counter to an RMID, event pair and monitor the bandwidth usage
as long as it is assigned. The hardware continues to track the assigned
counter until it is explicitly unassigned by the user.

Introduce the architecture calls resctrl_arch_cntr_read() and
resctrl_arch_reset_cntr() to read and reset event counters when "mbm_event"
mode is supported.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: New patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
     with mbm_event mode.
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
---
 include/linux/resctrl.h | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 50e38445183a..96679ad49d66 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -613,6 +613,56 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
 			      u32 cntr_id, bool assign);
 
+/**
+ * resctrl_arch_cntr_read() - Read the eventid counter corresponding to rmid
+ *			      for this resource and domain.
+ * @r:			resource that the counter should be read from.
+ * @d:			domain that the counter should be read from.
+ * @closid:		closid that matches the rmid. Depending on the architecture, the
+ *			counter may match traffic of both @closid and @rmid, or @rmid
+ *			only.
+ * @rmid:		rmid of the counter to read.
+ * @cntr_id:		The counter ID whose event data should be reset. Valid when
+ *			"mbm_event" mode is enabled and @eventid is MBM event.
+ * @eventid:		eventid to read, e.g. L3 occupancy.
+ * @val:		result of the counter read in bytes.
+ * @arch_mon_ctx:	An architecture specific value from
+ *			resctrl_arch_mon_ctx_alloc(), for MPAM this identifies
+ *			the hardware monitor allocated for this read request.
+ *
+ * Some architectures need to sleep when first programming some of the counters.
+ * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
+ *  for a short period of time). Call from a non-migrateable process context on
+ * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
+ * schedule_work_on(). This function can be called with interrupts masked,
+ * e.g. using smp_call_function_any(), but may consistently return an error.
+ *
+ * Return:
+ * 0 on success, or -EIO, -EINVAL etc on error.
+ */
+int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+			   u32 closid, u32 rmid, int cntr_id,
+			   enum resctrl_event_id eventid, u64 *val,
+			   void *arch_mon_ctx);
+
+/**
+ * resctrl_arch_reset_cntr() - Reset any private state associated with counter id
+ *			       and eventid.
+ * @r:		The domain's resource.
+ * @d:		The rmid's domain.
+ * @closid:	closid that matches the rmid. Depending on the architecture, the
+ *		counter may match traffic of both @closid and @rmid, or @rmid only.
+ * @rmid:	The rmid whose counter values should be reset.
+ * @cntr_id:	The counter ID whose event data should be reset. Valid when
+ *		"mbm_event" mode is enabled and @eventid is MBM event.
+ * @eventid:	The eventid whose counter values should be reset.
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


