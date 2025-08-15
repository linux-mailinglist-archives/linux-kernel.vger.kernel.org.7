Return-Path: <linux-kernel+bounces-770013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD85B275E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B670188F456
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C5729AAF9;
	Fri, 15 Aug 2025 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iqGPXlou"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6850D2BEC50;
	Fri, 15 Aug 2025 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224947; cv=fail; b=rUOhTFNYxW/VHVTS397KROEfiPkItn7a4+6AU4++pagccfjDOCqZOFoo3p88sCzBGrOXtquMCygDoKzd1SFEI0uBler7rZwH3c7d/Yb9G9mfsRsCMSsEG/T0qH8mk4rz+KuFSi4bq9E5aknBo3pYXRW6cw8NyFIA3E6Xzl1UN80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224947; c=relaxed/simple;
	bh=DBBgiQn+D2xcS8GhTsCVE1dIFO/VUY+PwyMT25EkEcg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmMuKO/+OPilicZwaPZTQ/9qGcvVzgvucZb3g3K9eCsI2r7TedHYiZV6v2CjpOZ5N2PK5FdRpZ/zvDCXiQuC7uUau46hyzvmXRIMeik1qzik6aQTgx7bySJMxWqEebjTQl5+yHzReCEPY59E9lkzSMJ23i3aA7wtWZQ2vpVMny4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iqGPXlou; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJbmo0vk3gJN9TgXcgnn6kOYa+zJCemair0457L6ugKoAkc1NrF4barTYWOgsZtU+iQ0hh2wBM1k59H0kdGUwNct9YSIOwbF5zdieZQQMM/+7y35s0rJm6QyCg6Qf0xQ0VzliTFnfu0pYhe5pnVqYbI3meDMOqCkhEXV/tBB/BFjX1sPuX/0+uxh1ZGFEytuHCELyXJyn/Hr43qEQ4SsOcjFhAKo1isoeTpJmICEvguKOXZnhgw4WV4r63gAlqlaOuYftjUuEpi+xv3uEqhgBbbHAmZnztJCHUs8Hc4xhxpACOnTBjmr6CjhB0TrvBXXPAzHxq834o+tPFPsO4eFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ukgH0ZqTNh/VYls/cWwMBDE1EwgyQt8uKKTr+bABv4=;
 b=i5gqhkIuy4iSrJoh/ygaiIoZLhw2OLj1zZYxIVTACyyn52JcOBoCAbrjPEEcHkg2G3nWvXySDIPK4tBcX+Edmk69AsRPHUuKMeQLn2Jie2Bz7oCUgB5NqQUxaFWsWiHy3w+VjxaXD6+HIaWILTL7PbeBye9K8D2EqOYBbwxK0MDn9XLPikSoVPLWNe2PWOBvzKpf4K7KTFSRHYKuGIFWX2Ifx9BdNd2hV/YMizRxLVXOXAsgYiNBF5MpA/erfg8CDoGXbWR+g4ximKxH+uHObNiNUd9Spjyjj4+isOtwbFP8FmE13jXGZWAArgaMwl8WI8bmF5C3IDyQI2591Zc4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ukgH0ZqTNh/VYls/cWwMBDE1EwgyQt8uKKTr+bABv4=;
 b=iqGPXlouVvElZiCWttD0oMJy6u04H27IWz+naEmfYQ0Mv+hMCiL+hRJ6lRBlhSm/WQriLpPegXlsY2k6NV80KC9QqgVYIyKy+QyMzFlUuonC+V40og+G+xi3uTz8FyuDgtCmjSoywwh2Nw2kv0hvuyJJlykgVt5LWodAyIv5u/M=
Received: from SJ0PR05CA0160.namprd05.prod.outlook.com (2603:10b6:a03:339::15)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 02:29:00 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::75) by SJ0PR05CA0160.outlook.office365.com
 (2603:10b6:a03:339::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.6 via Frontend Transport; Fri,
 15 Aug 2025 02:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:29:00 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:28:58 -0500
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
Subject: [PATCH v17 22/33] x86/resctrl: Implement resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()
Date: Thu, 14 Aug 2025 21:25:26 -0500
Message-ID: <327c88dfdac06a536c73ae0664d5bc2b9a86043a.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3ac0d6-577b-4248-3548-08dddba37eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M79IqnMH5Tf1ZjaktLR9RUU5Uth7+LxKhvBsSUrc9CxTHWlzGIcEZfoONwlI?=
 =?us-ascii?Q?MwJ/7s6BjjWTIKTJyxIgPWN60id131cRXb23VhhxMYRumRZ7G9brF6q30i6C?=
 =?us-ascii?Q?2BPKb9AVd6xUG8oMkGzysyyBZvfg1Qw6LF/Rq8HxG5LUkoW+Kr8RANFb+JlC?=
 =?us-ascii?Q?Pzi0AMZ37r1WWmR3MYayD/NA6CTagYW9c3ogN3jRBHZ9AOdomZjnmh4oiwQF?=
 =?us-ascii?Q?VfEpO5yl4vAJ8v2rgQMbmfvzL4NTca6/RVWlJehb63aEBVIH+1kFGJsOs5l5?=
 =?us-ascii?Q?ecjIfQW36Y22NhAp79SuJ/hdBjKsP83bKhbgQbBliQLvtFScxnEHAjuH4Ndb?=
 =?us-ascii?Q?UdLj0eVq4QYPhm/a5vRJAgjUm0Qn8zQFdNz1Ge4/fdR80aZZKUwOWcuExhG3?=
 =?us-ascii?Q?BWP96Unb/xvh+FFaWUSAFsKCnadznB3GtNvso61/w/Y3xTpnYekz2FEAtuyL?=
 =?us-ascii?Q?3wjFIDIGFhLdTY6fETaVywOSWXsBJzZYG7hzJiiZZbby0842P7ldTTRYvR99?=
 =?us-ascii?Q?ks/xWHBpaQqFBRAigyguA/YrTqmTPMgT2MimPlGyJSiY4VAJX+Eb7y104y0D?=
 =?us-ascii?Q?Ca5C4E1g21iVeXg8pw6BVrAM+bhD4omJ2T9htMJUA0/eUAxA5XzOtQduJULq?=
 =?us-ascii?Q?KbvD3ycK7RqYHa8VI0nkTLTiWeZ399rdY7WJcfJuYD9L/7+zpBaX5JuVYTmo?=
 =?us-ascii?Q?C+WDsj0IWjhao7QDCR5usX7Hb3zR7dG7kcYeHpRIGjCEyVL7zMOfwDj4G97E?=
 =?us-ascii?Q?betQX7GOb97KFWTXZILLvlZVWueRFrHgaX80rAl3otGtjC/I+l5OZyU2f7N6?=
 =?us-ascii?Q?oVeRYhV0rQQ8XvBC0hxsjlLGpTk8LaMRRGIR9BNxMSVQbd/E0u8MD/ri8t0J?=
 =?us-ascii?Q?51mUHZAekK2PGQrjKebSjent6nILecUnMFd3R2CoKP2WBic3Ry6WyyYn6n5B?=
 =?us-ascii?Q?L0U34GSmObaAFk7J2wdUlvAhzIY8fPMnACVUWQe7g+35fpy3J9U7eYLeWcav?=
 =?us-ascii?Q?Ka/TlACrmTlq222K4J8Dozlr4aIdpTwwdZMR2dFFghmX9YeGFbWzQvtjHb0U?=
 =?us-ascii?Q?bySKECZp+JlUdKDY3Dt4qTmB2VTMm4ED3CnZ4200bDc3vL0IMSpEK8Ba+z6W?=
 =?us-ascii?Q?UF1If0LSOcssD6BcIk801CRa0EQns+NEo5jvrlA2xLzXrFYzRoZsejms9VSK?=
 =?us-ascii?Q?bXTwlsIShxBYriRqI5FTYRl/c3cQbznTjdT5tP33sZsDMbyZL4qiLA4A1TLK?=
 =?us-ascii?Q?VvP0qyq4DSvlSEUlY4QqEQR//zRDy74NilUH07fA9LqljYrFVE/CgZSEzL+g?=
 =?us-ascii?Q?bB+sk8Sq2oayoJuS7fDLQNKVJEvkRCzqZ+goApQYVG5kGXZNmL8PHVEhwFrg?=
 =?us-ascii?Q?roOn+eip52bf0WKRuZ3P+4PJ+MFHZqNB475OhxFWBbYjDT63PaZ/OStP5meL?=
 =?us-ascii?Q?R+5XI0AL+HO+c1FI0je1MRGcNnKIeeQxQvuDjOC1sj4eyoWCiJ+WBVqzApLT?=
 =?us-ascii?Q?/UNgmI+fqUmOfRZyWcn795pnI65nPmzm4w/+L8U0rbxfl+kWwqmYeX8Yvg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:29:00.7415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3ac0d6-577b-4248-3548-08dddba37eba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652

System software reads resctrl event data for a particular resource by
writing the RMID and Event Identifier (EvtID) to the QM_EVTSEL register and
then reading the event data from the QM_CTR register.

In ABMC mode, the event data of a specific counter ID is read by setting
the following fields: QM_EVTSEL.ExtendedEvtID = 1, QM_EVTSEL.EvtID =
L3CacheABMC (=1) and setting QM_EVTSEL.RMID to the desired counter ID.
Reading the QM_CTR then returns the contents of the specified counter ID.
RMID_VAL_ERROR bit is set if the counter configuration is invalid, or
if an invalid counter ID is set in the QM_EVTSEL.RMID field.
RMID_VAL_UNAVAIL bit is set if the counter data is unavailable.

Introduce resctrl_arch_reset_cntr() and resctrl_arch_cntr_read() to reset
and read event data for a specific counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Updated changelog.
     Updated code comment little bit.

v16: Updated the changelog.
     Removed the call resctrl_arch_rmid_read_context_check();
     Added the text about RMID_VAL_UNAVAIL error.

v15: Updated patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
     with mbm_event mode.
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/

v14: Updated the context in changelog. Added text in imperative tone.
     Added WARN_ON_ONCE() when cntr_id < 0.
     Improved code documentation in include/linux/resctrl.h.
     Added the check in mbm_update() to skip overflow handler when counter is unassigned.

v13: Split the patch into 2. First one to handle the passing of rdtgroup structure to few
     functions( __mon_event_count and mbm_update(). Second one to handle ABMC counter reading.
     Added new function __cntr_id_read_phys() to handle ABMC event reading.
     Updated kernel doc for resctrl_arch_reset_rmid() and resctrl_arch_rmid_read().
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The monitor.c file has now been split between the FS and ARCH directories.

v12: New patch to support extended event mode when ABMC is enabled.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  6 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 69 ++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6bf6042f11b6..ae4003d44df4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -40,6 +40,12 @@ struct arch_mbm_state {
 /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
 #define ABMC_ENABLE_BIT			0
 
+/*
+ * Qos Event Identifiers.
+ */
+#define ABMC_EXTENDED_EVT_ID		BIT(31)
+#define ABMC_EVT_ID			BIT(0)
+
 /**
  * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
  *			       a resource for a control function
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 1f77fd58e707..0b3c199e9e01 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -259,6 +259,75 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 	return 0;
 }
 
+static int __cntr_id_read(u32 cntr_id, u64 *val)
+{
+	u64 msr_val;
+
+	/*
+	 * QM_EVTSEL Register definition:
+	 * =======================================================
+	 * Bits    Mnemonic        Description
+	 * =======================================================
+	 * 63:44   --              Reserved
+	 * 43:32   RMID            RMID or counter ID in ABMC mode
+	 *                         when reading an MBM event
+	 * 31      ExtendedEvtID   Extended Event Identifier
+	 * 30:8    --              Reserved
+	 * 7:0     EvtID           Event Identifier
+	 * =======================================================
+	 * The contents of a specific counter can be read by setting the
+	 * following fields in QM_EVTSEL.ExtendedEvtID(=1) and
+	 * QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting QM_EVTSEL.RMID
+	 * to the desired counter ID. Reading the QM_CTR then returns the
+	 * contents of the specified counter. The RMID_VAL_ERROR bit is set
+	 * if the counter configuration is invalid, or if an invalid counter
+	 * ID is set in the QM_EVTSEL.RMID field.  The RMID_VAL_UNAVAIL bit
+	 * is set if the counter data is unavailable.
+	 */
+	wrmsr(MSR_IA32_QM_EVTSEL, ABMC_EXTENDED_EVT_ID | ABMC_EVT_ID, cntr_id);
+	rdmsrl(MSR_IA32_QM_CTR, msr_val);
+
+	if (msr_val & RMID_VAL_ERROR)
+		return -EIO;
+	if (msr_val & RMID_VAL_UNAVAIL)
+		return -EINVAL;
+
+	*val = msr_val;
+	return 0;
+}
+
+void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     u32 unused, u32 rmid, int cntr_id,
+			     enum resctrl_event_id eventid)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	struct arch_mbm_state *am;
+
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (am) {
+		memset(am, 0, sizeof(*am));
+
+		/* Record any initial, non-zero count value. */
+		__cntr_id_read(cntr_id, &am->prev_msr);
+	}
+}
+
+int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+			   u32 unused, u32 rmid, int cntr_id,
+			   enum resctrl_event_id eventid, u64 *val)
+{
+	u64 msr_val;
+	int ret;
+
+	ret = __cntr_id_read(cntr_id, &msr_val);
+	if (ret)
+		return ret;
+
+	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
+
+	return 0;
+}
+
 /*
  * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
  * which indicates that RMIDs are configured in legacy mode.
-- 
2.34.1


