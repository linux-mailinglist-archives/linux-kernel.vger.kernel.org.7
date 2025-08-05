Return-Path: <linux-kernel+bounces-757076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D76BB1BD65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AA13B3653
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5DA24113C;
	Tue,  5 Aug 2025 23:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zkK4U5G4"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BC01E51EF;
	Tue,  5 Aug 2025 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436771; cv=fail; b=C79iIqXCD+Q0TUamcVGhudZwfxQSi4MA0zKLXpcCWYJcM+76ah4CLAnvXQEVIacDJZk9zM8bYeDq7VU7+ESReBQ3ntmR4P5syPvLLQInOGvxMLXT68Gm1Qp68c4q2F15gG0g3LGS4YtWrRmMo6Q1DMrIxfeHayx+n6r9P3lPhHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436771; c=relaxed/simple;
	bh=eGjmwWNAwClToKF4N76ry2J2i2XZfK7DdhpgGOY7wQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6ZWXfhY+2mqHt0LL5irBBGUDKSB5601jVzTpmwphfRDWTn3XesrYMwGq8gzp+Xg1RNZUYSurZiUbFB1jYZk7i/soX+vO1Lh84QzFqKFpWzQtK0EUxAhWrs0CdTigaqPza4kt/zuismyQDhfoWkJQgLY2RM19QyhFK4rOVaDRKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zkK4U5G4; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlWeSrfLnXqUr1HqcuSv+Y3A1sPYP7QS8oC5TydnkKprudTZRzubRjvHpod3MYkwIPmz5O/bwDuy+mpWomYRjZ3mw7oYv13FQyigxqcqi/SBcFnAZniMd1QZMaLzmjn+X/avQqGdB60K1ToH4ZXro5QDYj1ZMObvmym8Iv3D/orktyO7pjW7AiRocRutqeWeTdYpi+pDfauIzh9xXwhCBf+6ACRALu7BBWiBPe76sOiC4Rn6yPI2MWvKzBTtBEp7qXaq/B+4mbsvUf0s5w6KJg/As6LWkHioWjPinpPtRvZUZwy/BnRX7C2urs66f7BJovyQiw7Ka531prXGPSC91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ro3AFADUYLx4x7CLFTmSWhV9eIBf69VPSBGsCwlmbU=;
 b=mcaelbjmCUx7vPsCbPwrfwuKsbCks2Bojm4zVuc8MSh2BPsi2yRY3dWxC47XZpyzBpC4KduFpi1oLdwLsQ2LuD+1nRvgnydMHFF2QKBsoICb2h6e8soE95Stb2crT/nQb17r7bn82Z4dimlV6v+PaFUUjO7AjMY1xNH6O/RZGLGGTC9AIMYQ++fvZmu/Y3Zz+J7JqW0ZO3uNr1/svG2nsX4d4Rah56BqGC9HXoot1pScpf8qPYFlO/A9Z3voKlvDGWa37XrAuzc0cZWJlhMHkARsDFFqSaN7vgy2255Jbifl6AmfuIAGPqqDzSru542mtLIx7yA5rWxCDGLv5JqeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ro3AFADUYLx4x7CLFTmSWhV9eIBf69VPSBGsCwlmbU=;
 b=zkK4U5G41djVNiZOOPTEjTYU2AkK3Wj1uvSZ/MeKR3ZW74wb1byG8QppxHeQFiLQzTy6HpskXmbUBjkL0g5RVBihdUFDSM5t54BllfT8KzRq79dPCn74x1+WE6MjI+7xUTdut5SaZcP75N/hC6zn98OuGuXuT6sKTo1SEcGr4cA=
Received: from SN7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::18)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 23:32:45 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::49) by SN7P222CA0004.outlook.office365.com
 (2603:10b6:806:124::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Tue,
 5 Aug 2025 23:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 23:32:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 18:32:27 -0500
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
	<linux-kernel@vger.kernel.org>, <manali.shukla@amd.com>,
	<gautham.shenoy@amd.com>
Subject: [PATCH v8 10/10] fs/resctrl: Update bit_usage to reflect io_alloc
Date: Tue, 5 Aug 2025 18:30:30 -0500
Message-ID: <6d34357ee32bb519c607a0e2f0195194c1096d7c.1754436586.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754436586.git.babu.moger@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: c76d6c86-93bc-4838-b152-08ddd47861a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NsrNo1AI+mSujac5MCeLc+Ao+s3hhRBMY0o+z4rzErr2kCA2+1U1fIqzwU7W?=
 =?us-ascii?Q?IiSar4kFPW923BB0NGOowhdvjy/IVnS9n8Gzi/ckRiw+a3eOlSSoS2J570zF?=
 =?us-ascii?Q?lFBfGacDTP1KZvRxIklu0qq7wo8pGOmbA45Rn+CUWxej5+yxlSXAfNlVh3Dq?=
 =?us-ascii?Q?ZTjtWCEGqBjHagAhhS/DZJdEmYcYj/NT5Eat/IJl6H0oiMKhYkeawXDDS3P9?=
 =?us-ascii?Q?hDwK1dYajslk4XVOe6YEzR8RX60e+ATbXvxdwngb7306jL8f01ByLlxyBBWy?=
 =?us-ascii?Q?m96qO5GP2vuGCCRMCdESvCr6PdVL76ZzFdtIQRryT+Y7VX+zfry9udqctEhh?=
 =?us-ascii?Q?0xf/X/KybAq+uMrT99kqU/h/G200nZ6ZD26fh2Tz28YjAl4rpLHkEaCCDYtq?=
 =?us-ascii?Q?fei3vYypOOj7LoFF/JqZBONKrZ/c1lNgmgy1STyBcQDwCO0GKlsjHuPbwRve?=
 =?us-ascii?Q?jyuJlGaSXi/q90AQ0fn66aRz8sRPP2P/crM5uEoAGvl1fmSgZQf25wxnOGWZ?=
 =?us-ascii?Q?/auIDo3uvGQr8dBWrYDfI93daXcnoevNP0i6sIHrm770Dd7rxlN7k6/xHDc6?=
 =?us-ascii?Q?5/9JtCn+/hnyd4daB8UHUiKO/AV06Kff6kNW6TMu/7K5aRap4E3bjNd6RkHa?=
 =?us-ascii?Q?MALV4NG5/I7kGWEt/2VN6u2YB7NSSwfAojFjzP85n26i0nVTnEGoIuXGljkW?=
 =?us-ascii?Q?LI81kLUqFoFOAsQSx/C/oSuX37vNXwaHV+Yt9HzReQrDtTohge+fKdrNgolV?=
 =?us-ascii?Q?kv5Gdz2bp3Xv6awXqhaxT4m/WTN0X6lngS1AuESv/68MSdu6OmsRwC2IJ7qY?=
 =?us-ascii?Q?vDcxcydspDRHKIGD7+cVzhbPHxvlxhsIMTN09zfUx9R1F/BVU+B12IyhpsGT?=
 =?us-ascii?Q?AXKY8sZsmBSdbZ1f6btEf4n9UysF9KR+djD8e4kpOKcZSAljToLOy9yhXRGU?=
 =?us-ascii?Q?/z8+9FeKV05CNflNL5pbFTNT3O6Oc3S82osSZ2BBznz+476DTjJzeXNlTRdW?=
 =?us-ascii?Q?t55puhq1ooTsLqPyxnqbJRDwk2x/TtNEfL3dNgzG0bLngsszLbGIMR0XiiXG?=
 =?us-ascii?Q?ykhDFlUdaEAiqBzx9rWj0jgtoqZLtwLgPkGOLrjY7q0Pvr8mgZ+655hRHPGm?=
 =?us-ascii?Q?jlE4q01TZCl9WGJRxD7T8mfdlACdQpl251eT9qEoXo+Ddd/keDeIDlbRFJYw?=
 =?us-ascii?Q?Rq2Kwlhivyool2EJ5Wpskja6R4J6jpow3hOpOAx+qTAERZPhZAhtxUeGqg4j?=
 =?us-ascii?Q?SAr1zwLjjkGInijUmOSM9AMKjtQ7ja1Tlwh5qmiZRDWtUnkO64P/uzGk81oI?=
 =?us-ascii?Q?t89nw8vYu7ShfUUXxr0yBvBTnPzJsvB5ljkyWbAKjQH5ZnhcA7e8mMtdmMOb?=
 =?us-ascii?Q?MNeAhooEMRyLY7VTS67KBDYxKgG7eyAD5yOBcS+pEibeVJnVzUCqxb0UGGzp?=
 =?us-ascii?Q?MjxtjV6GGevi5mvaUAqg4ywoHXxlJNhP6A/frohAhurjsVZaV6mGD6N+yYyX?=
 =?us-ascii?Q?Y0ZldILA17Cn+WL4LEL2Z1amSKuYdDw/YxSz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:32:45.4839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76d6c86-93bc-4838-b152-08ddd47861a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411

When the io_alloc feature is enabled, a portion of the cache can be
configured for shared use between hardware and software.

Update the bit_usage representation to reflect the io_alloc configuration.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Moved the patch to last after all the concepts are initialized.
    Updated user doc resctrl.rst.
    Simplified the CDT check  in rdt_bit_usage_show() as CDP_DATA and CDP_CODE
    are in sync with io_alloc enabled.

v7: New patch split from earlier patch #5.
    Added resctrl_io_alloc_closid() to return max COSID.
---
 Documentation/filesystems/resctrl.rst | 19 +++++++++++++------
 fs/resctrl/ctrlmondata.c              |  2 +-
 fs/resctrl/internal.h                 |  2 ++
 fs/resctrl/rdtgroup.c                 | 18 ++++++++++++++++--
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index d955e8525af0..1e46231b929c 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -90,12 +90,19 @@ related to allocation:
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
+		When "io_alloc" is enabled, a portion of each cache instance can
+		be configured for shared use between hardware and software.
+		"bit_usage" should be used to see which portions of each cache
+		instance is configured for hardware use via "io_alloc" feature
+		because every cache instance can have its "io_alloc" bitmask
+		configured independently via io_alloc_cbm.
+
 "bit_usage":
 		Annotated capacity bitmasks showing how all
 		instances of the resource are used. The legend is:
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 1f69117f96f8..cfa766319189 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -754,7 +754,7 @@ static int resctrl_io_alloc_init_cbm(struct resctrl_schema *s, u32 closid)
  * resource. Note that if Code Data Prioritization (CDP) is enabled, the number
  * of available CLOSIDs is reduced by half.
  */
-static u32 resctrl_io_alloc_closid(struct rdt_resource *r)
+u32 resctrl_io_alloc_closid(struct rdt_resource *r)
 {
 	if (resctrl_arch_get_cdp_enabled(r->rid))
 		return resctrl_arch_get_num_closid(r) / 2  - 1;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 5467c3ad1b6d..98b87725508b 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -395,6 +395,8 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
 ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
 				   size_t nbytes, loff_t off);
 
+u32 resctrl_io_alloc_closid(struct rdt_resource *r);
+
 const char *rdtgroup_name_by_closid(int closid);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index a3ab2851c6da..b85c2622c94b 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1068,15 +1068,17 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 
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
@@ -1104,6 +1106,18 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 				break;
 			}
 		}
+
+		/*
+		 * When the "io_alloc" feature is enabled, a portion of the
+		 * cache is configured for shared use between hardware and software.
+		 */
+		if (resctrl_arch_get_io_alloc_enabled(r)) {
+			ctrl_val = resctrl_arch_get_config(r, dom,
+							   resctrl_io_alloc_closid(r),
+							   s->conf_type);
+			hw_shareable |= ctrl_val;
+		}
+
 		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
 			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
 			hwb = test_bit(i, &hw_shareable);
-- 
2.34.1


