Return-Path: <linux-kernel+bounces-726222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F37B009B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D776C1BC7E37
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EBD2F0E2B;
	Thu, 10 Jul 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l4nS3WIS"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C11CD1E1;
	Thu, 10 Jul 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167842; cv=fail; b=OjG7V9OEKsicZv4VNgK1Yo/ldp8dC4eaOOxUy+sEa3Zv8quswOyA8bCFBdEcod15EES3WClgtv2ZiMzC7m1qKaXxfi0rovToA62aKTwVgbAdKQ4OE/z5SM/ujlykVmBEQuOTHK/m/w06l7SaczzV34g5nrdchk99gUwHS1bVD/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167842; c=relaxed/simple;
	bh=OwEUAu/0xb925wTjYb3WEu/8cTJMDhOv1KvRqeP550A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApJM8KIPKG9axONa2t4qaIjg+ozbhe/NFueCvndfdRi6E0WYyDWKC9daqCwkb3hMCZ0qU0EDTIvMsWseVEBF7fUB3FLxGd8LDBcVoNmJgQmW/MbzeEvHZduWYSw2V6M3WE+bN8ct6X1CWx4MPUkwmQvMJCE9LRLek7pMwKGfhdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l4nS3WIS; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9PfiLWvfpk4QGX6GNmRAyUQXkpfVyN7CQAhvVwGl0TllObnte0F7vgl27uUZJyf22VsfZOTH4FGlYSHtmCI15I0SBZvk3mH4EOPrdUiDHs6qruF6BWzz8ZzLeBR/pR5fGop0TXVQ9RjZcADTHUk3dhFEaZRrOsVy2zJqKySlAJgubRT2jO17HE23RAJxYYDVhR2Bq5xp45+/G65Z/woh5HYW5yMIFdHFtZ8ZgQD0a/v1X2nXiPiLySqLnAfIbIja9bztscxE7AROa9HLu5KvJJZwzKPlubnf4vEJuII5vsKgBE+nhEldW10NSlL9LBaSDd/UemWZ4VMt6wYsUZHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rC6SOebXpZBo7aUiDxqTC2Mk7tOUhNkqdKyRSybbio=;
 b=uLSzI2yssNSO4Fam3TYGCx4mYYryCrN/iCa21sQeJ7oN21r8yMCW6zeY5fVIPS6umoksRzYWOWOujFgDmSc0M0TSlpKt3AMQQYja+sLC4ZiA35WRURUvJx0X3nFeiSw3YRlAItmwcqmkWj4Rk3vDj3Vi7o/zU1ArcFSBWGMw95Txa2viWkNUIkp/rJEnsO+bqsH7RaJ+cZR2x45GY0yfCf4rX3KnpFhKn+2m5ctwBOJWP2iyustWzlJcfA9XgiRcH1oAfycLbs75mlqza6gubSTunV6NfdB8rhqiIgYYLmE9USPrSi432yODFOkgR5mBLgB0OIlqeP+zbCQXCSyk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rC6SOebXpZBo7aUiDxqTC2Mk7tOUhNkqdKyRSybbio=;
 b=l4nS3WISL2fbuNUijgiEaCotvT2zUBoCC9+6F0KlyTy1rwqFzcTVnRtiK5jLOQkom9+3mVPkr9YTve3XVSZpQkX4mFpD0A2hDSoIIF/VRMf+U1AHK4erWQzLlWHVpOBGXA44GYeHkFhMfIR6WpoDSMEOHnYwp4DOCzsdQSudc/Q=
Received: from SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::34)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 17:17:17 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::dc) by SJ0P220CA0003.outlook.office365.com
 (2603:10b6:a03:41b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Thu,
 10 Jul 2025 17:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:17:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:17:13 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<babu.moger@amd.com>, <yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>,
	<xin@zytor.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <me@mixaill.net>, <mario.limonciello@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <ak@linux.intel.com>,
	<chang.seok.bae@intel.com>, <andrew.cooper3@citrix.com>,
	<perry.yuan@amd.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 05/10] fs/resctrl: Update bit_usage to reflect io_alloc
Date: Thu, 10 Jul 2025 12:16:19 -0500
Message-ID: <87e1a53201f3e539fc917a5d901f09bce432f720.1752167718.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752167718.git.babu.moger@amd.com>
References: <cover.1752167718.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: c18dade4-af13-4e33-3c5a-08ddbfd59ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k3cDdQ52X5OOAH4lKFkcsRabYDZYMcy5QhBd0cNEdb9g/BBRuzZBTwnB1VE4?=
 =?us-ascii?Q?7qY+aZlNaUtvXWvzRhrMB87YQBgiHG7BRUxl1ovx2Y9cNdQ/siPUILMh1ujm?=
 =?us-ascii?Q?iOs7omtEQW4h3mT96N/OECRA1ledHKoufL+b7NbYm5PObJVOv4k1i1ca4/Nk?=
 =?us-ascii?Q?CV9K1EbcD3Ld/5DqgiQcHbvgYIHbmQvo+trBZ69KvzA9mmSiStcmFM1OHVVI?=
 =?us-ascii?Q?goPDH8KalPFa3RkIlOBDAetIHJIIQJnxz7uYT2RNdCzmXczBORdf9dDNHimz?=
 =?us-ascii?Q?I4ndqf0uaBKX/ah8JBFGIMHx1LnA3vCyHQuqNP+K/RnfX5j2Waxbal67Cz25?=
 =?us-ascii?Q?N0M8+BR6NxJpMCkckZ31lDi4Rhw1x1pj1mGuqfLHrgFQ2rNufb2ZCXB1cMOo?=
 =?us-ascii?Q?Hf7H1zAb6VsjU+tpFXQ9rAAZFD9SPsFw7E6CerrAtl9So0pej59aCNNYco+e?=
 =?us-ascii?Q?liVYPZEzZPG1k7bKnYHGJitdod9eBs7yvXXr4/gNYe905k/Vw2wqpZKcGIuW?=
 =?us-ascii?Q?A0EiGBakyQwBCUP6mLIQlQiacu29XmZDHV16e7lronCtMGt22DJfylzbI9DA?=
 =?us-ascii?Q?k1LIHr4owg0qirZmNv3WXN5eM9oL7gZpKWIvqz+l5cSu4GwarkeKCvv50VG5?=
 =?us-ascii?Q?RMbmHb/za0uEc9BP+DRjtSKhCsAvLf9CAh+pSHeM1o5nzsSfL1NppULsRjXm?=
 =?us-ascii?Q?ZB+yIecaczCDLwMhCAzsvtRweJccfLBCQFObHpX2Tg0/wj8PWz+UXBfwbkns?=
 =?us-ascii?Q?ilQG1BABun7Te3QtGGpYePskNgkzuw/7t+vyK7OmsfVy1lTyx/VVIasNpiF4?=
 =?us-ascii?Q?W9eNNX5fP2zKamBl+IFm6j2BVDkhonBcJ6YhIQEM7Ryc2JOAeEgQU6bTwkol?=
 =?us-ascii?Q?nEz8cjuNwbQK9tYvZr8b8q9aoZ0yB+0w49xhCcFUYnzlKyDaL8k04DGuSGFA?=
 =?us-ascii?Q?1gAC8OQQ5RDLl+0S+FDlg12dMv2iI4dIcOAPRl1y9bU0+qZwOV6sSP0ZJDLP?=
 =?us-ascii?Q?7z4/27xicFz4tetmvnpuEuliw3BA5gs7lndMGyL+/AJeS41PLew5ynTUCZir?=
 =?us-ascii?Q?7Yb/3utWvZXZHU0lLMTvAXlTOHUpTK/BosB7S6s//yMMeR2JvVuSJWQXg/E3?=
 =?us-ascii?Q?6+PDx2XnFr2hj9iImMa0Zgbhc7CfKFE10ge7pcByH8Rg7qcvdNymzFHBmI8C?=
 =?us-ascii?Q?UL2c0ucrb0H+9CWkZ8+LNqCnv5BB/UO7j1AL04qrhwHTE6GJf1N9YQV7Zctu?=
 =?us-ascii?Q?GASS4xwYdHv4HgQp51/AHa+cM34CTNcyW0gRstevHqrSMakkohUGlzVsHXlp?=
 =?us-ascii?Q?kVavQN+BO7jdkSz/JSEiD6hzdp/ftlnt63NVS02NMNGX22S8c61NMTDP3x+r?=
 =?us-ascii?Q?niohajVxIQIwOlRZaCLsLQgGMM+OCxBs7NvwyZxHO76ehTqvNIGyJkIYKc2J?=
 =?us-ascii?Q?rbqplMJI5in2UFsjX0G21ZziNoqYl5TPjD9CjWxsxZ5EEESbrEMhhisWHnWm?=
 =?us-ascii?Q?mw4OV7fLrBoqY4MHU2OEvO041y9Qkg0Dh2FB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:17:16.5693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c18dade4-af13-4e33-3c5a-08ddbfd59ea4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070

When the io_alloc feature is enabled, a portion of the cache can be
configured for shared use between hardware and software.

Update the bit_usage representation to reflect the io_alloc configuration.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: New patch split from earlier patch #5.
    Added resctrl_io_alloc_closid() to return max COSID.
---
 Documentation/filesystems/resctrl.rst | 20 ++++++++++-----
 fs/resctrl/rdtgroup.c                 | 37 +++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c7949dd44f2f..c3c412733632 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -89,12 +89,20 @@ related to allocation:
 		must be set when writing a mask.
 
 "shareable_bits":
-		Bitmask of shareable resource with other executing
-		entities (e.g. I/O). User can use this when
-		setting up exclusive cache partitions. Note that
-		some platforms support devices that have their
-		own settings for cache use which can over-ride
-		these bits.
+		Bitmask of shareable resource with other executing entities
+		(e.g. I/O). Applies to all instances of this resource. User
+		can use this when setting up exclusive cache partitions.
+		Note that some platforms support devices that have their
+		own settings for cache use which can over-ride these bits.
+
+		When "io_alloc" feature is enabled, a portion of the cache
+		can be configured for shared use between hardware and software.
+
+		"bit_usage" should be used to see which portions of each cache
+		instance is configured for hardware use via "io_alloc" feature
+		because every cache instance can have its "io_alloc" bitmask
+		configured independently.
+
 "bit_usage":
 		Annotated capacity bitmasks showing how all
 		instances of the resource are used. The legend is:
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 77d08229d855..a2eea85aecc8 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1030,6 +1030,20 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/*
+ * resctrl_io_alloc_closid() - io_alloc feature routes I/O traffic using
+ * the highest available CLOSID. Retrieve the maximum CLOSID supported by the
+ * resource. Note that if Code Data Prioritization (CDP) is enabled, the number
+ * of available CLOSIDs is reduced by half.
+ */
+static u32 resctrl_io_alloc_closid(struct rdt_resource *r)
+{
+	if (resctrl_arch_get_cdp_enabled(r->rid))
+		return resctrl_arch_get_num_closid(r) / 2  - 1;
+	else
+		return resctrl_arch_get_num_closid(r) - 1;
+}
+
 /*
  * rdt_bit_usage_show - Display current usage of resources
  *
@@ -1063,15 +1077,17 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
-	hw_shareable = r->cache.shareable_bits;
 	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
 		if (sep)
 			seq_putc(seq, ';');
+		hw_shareable = r->cache.shareable_bits;
 		sw_shareable = 0;
 		exclusive = 0;
 		seq_printf(seq, "%d=", dom->hdr.id);
 		for (i = 0; i < closids_supported(); i++) {
-			if (!closid_allocated(i))
+			if (!closid_allocated(i) ||
+			    (resctrl_arch_get_io_alloc_enabled(r) &&
+			     i == resctrl_io_alloc_closid(r)))
 				continue;
 			ctrl_val = resctrl_arch_get_config(r, dom, i,
 							   s->conf_type);
@@ -1099,6 +1115,23 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 				break;
 			}
 		}
+
+		/*
+		 * When the "io_alloc" feature is enabled, a portion of the
+		 * cache is configured for shared use between hardware and software.
+		 */
+		if (resctrl_arch_get_io_alloc_enabled(r)) {
+			if (resctrl_arch_get_cdp_enabled(r->rid))
+				ctrl_val = resctrl_arch_get_config(r, dom,
+								   resctrl_io_alloc_closid(r),
+								   CDP_CODE);
+			else
+				ctrl_val = resctrl_arch_get_config(r, dom,
+								   resctrl_io_alloc_closid(r),
+								   CDP_NONE);
+			hw_shareable |= ctrl_val;
+		}
+
 		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
 			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
 			hwb = test_bit(i, &hw_shareable);
-- 
2.34.1


