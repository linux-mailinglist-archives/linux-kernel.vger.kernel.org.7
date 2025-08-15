Return-Path: <linux-kernel+bounces-770006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65334B275D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415FE1CE4EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E519929D277;
	Fri, 15 Aug 2025 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yJ18G27C"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266C29D266;
	Fri, 15 Aug 2025 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224899; cv=fail; b=eGNpDfw/xFbTRNZ+kMrbPyVhAwaanFKH6jnF0J9jaV8gHEJxRA6wt6eJcfTim70qHa1WBfR+8iakERX0IMtjBWwklxQU767DwqrFvK88wzFToLZwPyqE0uGveVLXPkEqrK5ZVQLBK6aZaJaAbQyviqSwDy8GMLE/08uS06wRmU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224899; c=relaxed/simple;
	bh=EK81hFrUA2azUKNHu2I6MxXh2JHce9P3eyxwqAGvqJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jE1INpyQN8OamIkw9EFzMu1CigBGlvvl7KxMuvhajJJM5hPjm5jE/U2Gdm6c7eSigFTeANp44TULs8AwmYlzLYQdIC+5EmbEN9fJ7RN7RyA4Tj4mz4KrSgbdMC3kT3f27sTdMw4r1EMsjgZR8iNbj9NDtgXaOJiwKeuVLJ3HXeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yJ18G27C; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIlQoSDiW8bmuGNRWiJqPA+zFyWFpnGKzrUokkXaJdl+uvkNJI0iLbtXByo9L4nJBeajSF5AAK0sb4MhtWaPQUrHpTMv0yeSRztPdOfBTcBo2dzn/OhkdNnSiShrj1M9t3jE8WYQUPpXTzYk44yrl+AwbsCuhxO/2bnOproe3CUFboncakmpbY051ILujUmff0C5G2WPA0tBTL6qilZKiNH4zLEXxsTa75cM92UkFCP73WRxmcc0KMfdUqqgKN+dF6Za2SP62cplPcqjmNChfuFQu8ot9cIorwM89voYX7j3mxB3VHF5wDyugvnExqy0Wxnr4wU5NDOFZEvBpj+gCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXB7C/0K1YhrGrDf0hFZ47eNy7+CS/QuWFRU2kUwoJQ=;
 b=uH/HSGhe2YjBXYcUfqb4F/mSoqMc3fXsWeY4DQ0kPIW9sU8VzPouxAOJHhJ1Rs1YtJeRltxRvZmumWDhFw4+x0o55FHglQR8XTrA7ZtIlTCHV/Koi2iNbaHCM+11ce7UsL+DV0wt608dtpKCesqYoJSeN3nggl/Z6BbNxcPqNsshNgyAg9IDKGxcvOCajGg+WUCPsaNA1QxRFvQPdwwpmprrScehf5jK/WLIfBadRytgARe3LbP/Ux77Rl0a8KLjIP/ONblqGjRyu3x4NOVYOIacbx7IqgyTTVX/gsQBAu40IQkmuvUhGyiTS2nEZbIqVn935Q2qVtsH1ecuwlDsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXB7C/0K1YhrGrDf0hFZ47eNy7+CS/QuWFRU2kUwoJQ=;
 b=yJ18G27CjTE253ZFYwioPtJ8zF3MhhyOLi3fgRaUzNqc4izlIjSkZs9knZBagFJwFf96KMc593t0UG17qa6AA7aO3GLPeM7i56yCH/DqUUWOcVRVvVudmg868+xLilgVFlLxVQnmZNZkwUgo4G04qNjX/gt8boH7ln7/E3N90gI=
Received: from SJ0PR05CA0176.namprd05.prod.outlook.com (2603:10b6:a03:339::31)
 by CY3PR12MB9701.namprd12.prod.outlook.com (2603:10b6:930:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 02:28:13 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::3e) by SJ0PR05CA0176.outlook.office365.com
 (2603:10b6:a03:339::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 02:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:28:13 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:28:06 -0500
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
Subject: [PATCH v17 16/33] x86,fs/resctrl: Implement resctrl_arch_config_cntr() to assign a counter with ABMC
Date: Thu, 14 Aug 2025 21:25:20 -0500
Message-ID: <4aa25560f266388feb1bfe0df238ba21f27c0720.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|CY3PR12MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f05e136-941a-4161-6b7c-08dddba362a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RmJGBMipoQ3uF5E6Bc931sbVFttFFfFWym5hQ0yn0h4PW8mAKTjifvXhq6dD?=
 =?us-ascii?Q?zTJaDlK51AZ2Y4FV446D9dhmx1dx+xBcBG3XJgtpXJVetUb+Fz5QOQ3mVZrE?=
 =?us-ascii?Q?NekH+vDBsGltn7pl8wmziIRBPYUJ4ir2iLchRLRxu0VZzCkzzKAvJbYKHDN9?=
 =?us-ascii?Q?bcWbOKECs0xWwAFEE4qn9OdK3kekvGioUIEbWcmxUxTVFIFxHwbMHIwyzkdR?=
 =?us-ascii?Q?wp8NUY6Yyq39om5Flx8ZDu1loga6ZjNZfpg1YuNip4BpBUqr6HkZS9dgG3O6?=
 =?us-ascii?Q?RE7u5zeTtCmWcsz5mZ+dtZcebpKMo2TZWKPyK/SLOyVIGXuu0s1/7Vdd1Quy?=
 =?us-ascii?Q?G82FIphp9fy17OIEhzVGFD9iotr6XCcCqTqdV+5qq7lF5kzflgyb8f3aGBCv?=
 =?us-ascii?Q?DJDyTJBd6NN8EY2UPU0VXVjp9XSbLc6vEmDt8luw9N3TF0JesmaLTIM7KHlW?=
 =?us-ascii?Q?Mqrlikcuzbd+4qFCWS9Bz12yf19horRXJ/h7X6Cnl81f9H1mxhWRuX0/socx?=
 =?us-ascii?Q?gnGdEDbD85RGVAPtJT6LvgOvUQ/D5x9C2ISj8rSlUXJk5VH21tDc6V5/XJVj?=
 =?us-ascii?Q?h3HsGQWIQvPbaM0jBQug08Rb3NFXFF979PQgbL82ZJdmPpjN3LDw+phrN3uK?=
 =?us-ascii?Q?97KK6hoWmhVJXUtnYmq5QRUyzhv28FWwBivbhoe5U3yBlAsoKVlAZjlemaEz?=
 =?us-ascii?Q?j5YgbCor0sxpS/bjG7qKVQggS9BEqh4/JSCdF1Xdb6B50sODLqahZh2BwabQ?=
 =?us-ascii?Q?PifvOoQjW/5ZDpseaRRj3wCXzyyZLwCu84RgM503UjnHjeO5m8Qt/IUPtNCa?=
 =?us-ascii?Q?aERoPpRz9rJORmjjVzm8qBVnxRlh7lLcSq1HyjgdJ4cL1/6gtIY9DrFYIqfN?=
 =?us-ascii?Q?yGoEHrukFgeZIZizJ5GurYbE3y/GZzWzgb5vMvw1mtVyE5GK1DPvUTRguOcE?=
 =?us-ascii?Q?ZjTeXuBu3XI6wsYRLl03HzTB90neAGQvi8B/aY8A99iluyyHyCyYJNq+gwYE?=
 =?us-ascii?Q?14kg/HaVUAMxfgHcPZbOdfsOTgRzj8lmG4HdugUFxzt98MqVW3vQl8Gix/9W?=
 =?us-ascii?Q?Azsw0q9su4TmfblhZ67k+qtCp+A3ec5ODKJxTctNc2mDq9CAjRC+5KrzaMA5?=
 =?us-ascii?Q?THuGassqhVK1gRJCLdMeXu12ozB42ECGdRH3R5cPj/bk0+nNWev/AFMdX7do?=
 =?us-ascii?Q?TnmEmQKxge1S5MIyLKECtGO2/me0IE5BaBhXIWeB918pBCtFHc4Mp0MJX8be?=
 =?us-ascii?Q?+ZCVkq4ArZvgGqfhbJnkAQqZ/3CLtMq+0Wyz8pqOdEMelfLLqni0DLj86HmA?=
 =?us-ascii?Q?r0gZEIOXe8cB0TPK7YEFai3rbVd1v0Mgxt3PdafJt7/xXz7fHR7YX4Rn2tUo?=
 =?us-ascii?Q?OnmT1L8REzJifZLSl4+TAVk4yfz80cVGdEukmAdIuIBy+kiUDsQuaqp4hlhN?=
 =?us-ascii?Q?7vJYGcQp66fFoy6fia0Dbu66+Sj3FL48j+HNlvkyLkMSHUgKZWXrL9rtKpeL?=
 =?us-ascii?Q?DtwSWEyfHwKwYZFWY3/8tglOIQZVtKYxTi3rVynWCKUKX7gDVPnGKBwKGQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:28:13.6294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f05e136-941a-4161-6b7c-08dddba362a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9701

The ABMC feature allows users to assign a hardware counter to an RMID,
event pair and monitor bandwidth usage as long as it is assigned. The
hardware continues to track the assigned counter until it is explicitly
unassigned by the user.

Implement an x86 architecture-specific handler to configure a counter. This
architecture specific handler is called by resctrl fs when a counter is
assigned or unassigned as well as when an already assigned counter's
configuration should be updated. Configure counters by writing to the
L3_QOS_ABMC_CFG MSR, specifying the counter ID, bandwidth source (RMID),
and event configuration.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v17: Added Reviewed-by tag.

v16: Updated the changelog.
     Reset the architectural state in resctrl_arch_config_cntr() in both
     assign and unassign cases.

v15: Minor changelog update.
     Added few code comments in include/linux/resctrl.h.

v14: Removed evt_cfg parameter in resctrl_arch_config_cntr(). Get evt_cfg
     only when assign is required.
     Minor update to changelog.

v13: Moved resctrl_arch_config_cntr() prototype to include/linux/resctrl.h.
     Changed resctrl_arch_config_cntr() to retun void from int.
     Updated the kernal doc for the prototype.
     Updated the code comment.

12: Added the check to reset the architecture-specific state only when
     assign is requested.
     Added evt_cfg as the parameter as the user will be passing the event
     configuration from /info/L3_MON/event_configs/.

v11: Moved resctrl_arch_assign_cntr() and resctrl_abmc_config_one_amd() to
     monitor.c.
     Added the code to reset the arch state in resctrl_arch_assign_cntr().
     Also removed resctrl_arch_reset_rmid() inside IPI as the counters are
     reset from the callers.
     Re-wrote commit message.

v10: Added call resctrl_arch_reset_rmid() to reset the RMID in the domain
     inside IPI call.
     SMP and non-SMP call support is not required in resctrl_arch_config_cntr
     with new domain specific assign approach/data structure.
     Commit message update.

v9: Removed the code to reset the architectural state. It will done
    in another patch.

v8: Rename resctrl_arch_assign_cntr to resctrl_arch_config_cntr.

v7: Separated arch and fs functions. This patch only has arch implementation.
    Added struct rdt_resource to the interface resctrl_arch_assign_cntr.
    Rename rdtgroup_abmc_cfg() to resctrl_abmc_config_one_amd().

v6: Removed mbm_cntr_alloc() from this patch to keep fs and arch code
    separate.
    Added code to update the counter assignment at domain level.

v5: Few name changes to match cntr_id.
    Changed the function names to
      rdtgroup_assign_cntr
      resctr_arch_assign_cntr
      More comments on commit log.
      Added function summary.

v4: Commit message update.
      User bitmap APIs where applicable.
      Changed the interfaces considering MPAM(arm).
      Added domain specific assignment.

v3: Removed the static from the prototype of rdtgroup_assign_abmc.
      The function is not called directly from user anymore. These
      changes are related to global assignment interface.

v2: Minor text changes in commit message.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 36 +++++++++++++++++++++++++++
 include/linux/resctrl.h               | 19 ++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index cce35a0ad455..ed295a6c5e66 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -444,3 +444,39 @@ bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r)
 {
 	return resctrl_to_arch_res(r)->mbm_cntr_assign_enabled;
 }
+
+static void resctrl_abmc_config_one_amd(void *info)
+{
+	union l3_qos_abmc_cfg *abmc_cfg = info;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg->full);
+}
+
+/*
+ * Send an IPI to the domain to assign the counter to RMID, event pair.
+ */
+void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			      u32 cntr_id, bool assign)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+	struct arch_mbm_state *am;
+
+	abmc_cfg.split.cfg_en = 1;
+	abmc_cfg.split.cntr_en = assign ? 1 : 0;
+	abmc_cfg.split.cntr_id = cntr_id;
+	abmc_cfg.split.bw_src = rmid;
+	if (assign)
+		abmc_cfg.split.bw_type = resctrl_get_mon_evt_cfg(evtid);
+
+	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd, &abmc_cfg, 1);
+
+	/*
+	 * The hardware counter is reset (because cfg_en == 1) so there is no
+	 * need to record initial non-zero counts.
+	 */
+	am = get_arch_mbm_state(hw_dom, rmid, evtid);
+	if (am)
+		memset(am, 0, sizeof(*am));
+}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 87daa4ca312d..50e38445183a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -594,6 +594,25 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
  */
 void resctrl_arch_reset_all_ctrls(struct rdt_resource *r);
 
+/**
+ * resctrl_arch_config_cntr() - Configure the counter with its new RMID
+ *				and event details.
+ * @r:			Resource structure.
+ * @d:			The domain in which counter with ID @cntr_id should be configured.
+ * @evtid:		Monitoring event type (e.g., QOS_L3_MBM_TOTAL_EVENT_ID
+ *			or QOS_L3_MBM_LOCAL_EVENT_ID).
+ * @rmid:		RMID.
+ * @closid:		CLOSID.
+ * @cntr_id:		Counter ID to configure.
+ * @assign:		True to assign the counter or update an existing assignment,
+ *			false to unassign the counter.
+ *
+ * This can be called from any CPU.
+ */
+void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			      u32 cntr_id, bool assign);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.34.1


