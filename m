Return-Path: <linux-kernel+bounces-863891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE1BF96AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4845E4FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF280262FEC;
	Tue, 21 Oct 2025 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xpiFL4Ka"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE4252904;
	Tue, 21 Oct 2025 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761091023; cv=fail; b=kbZswbLF7cJpaB/x8eRfrm8N/I5rJBTHOp78S/QN1KswqfvdBzuxg3E6JJWKWQB+8EPLzgC1Sup8vqqeYvKYXFXkKhHHYm9/M5fWX71cqslxMi40miuXQ4XYIoCNEBN0PpxzgxtLqRjqgcsTTF9ZPWyqr3R80iUb3niIwhMbjmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761091023; c=relaxed/simple;
	bh=ENbSuET7mJmpreF96qgKB0XU8chLGatGlplx1qKy3l4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKxv2gSHpU2i3x2FKh6EgTUJrYEWct4u0AEOAtNbgDsWplaKRJZwmByafRNDdRHCDfgVC7sUwnwLZhS26nEWjNdvw8NaR2Y8d6kcazQWBzbIFUESiKqudpsy5WQKKIzJVCsB6JpfaJP2vyFL0VfPQSHxC5dV57qW4IegW/XPqlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xpiFL4Ka; arc=fail smtp.client-ip=40.93.195.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRR+TOPp1i/EpV6MaSSTCaraWVIIxYbdT/Nt1jaYfT4lpNjcAJkunYDpkNaoMGD3sq8yayl4e+xC0n6ya1XbNOlJSMUDa/GyFBTVZ4kOLDRwnW7UTSPb43CR8EWELZx1FBX5RHNJ813WPtc5eo2JnuGaYBU10DmSC+CBJp+jkMkfTUHO96oAEX2z+NjQxnaR8I4MWE3O3CwLPmge04sIuS+Ng1y88dkHmJQVfhYbqQuNR6ujuivUfzpolM0oRfbjEgJ2PYDg6IUV1Zts8iGa9VBZYVVBU3WWa9r2dN4iF4YvAWWue/UxzDggjQ7gXcqVpFAGo/IuABDWPkIgU6kImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5m7kcwHbK9e+7lYS2Q2cn0OuiKllib0viICXK15pYg=;
 b=fgjbnsAXCh9ktqlUB7IMP9TZqxt4/tJ16+JlaTlSRYstA76hJ3kuo3SrWlgXUfecZKpPsZ/7leSfKxNFWYBG5CTeJu9nZntMZcuyzb/V5rYuHIWO4fV7QYBE40kTjegTZXbdIm5dNrYi9nC8XimV9aqHQYZOfXl7jh82Fvu7PGxkE0cKWkq94jE3U87mHj/p71ft1rX9hNzjdoN3cE6CXjkuWokT4MhpAs1XnBThFD2gvprwKfYClIwavkFav5wVQt9tVtIcPd/3oLlXFzRVfCFAPJDYgGvNdsbzc2K0leOhJLmx9q5fLoXmU/AewLEFfTjedFX4giVY6WAuEDCv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5m7kcwHbK9e+7lYS2Q2cn0OuiKllib0viICXK15pYg=;
 b=xpiFL4Kad8SUrXwGzicudd+HormMmUEeZ1j5jnL6TpUVFAx+8q7hmgNcII17RUJnR6vWCOJJD/4f4aGIdMt7kgTc36lK5QurjFtT9DhQTBgwQFzPB2DRMFpoWc4hhholthR586/KCvJpKTydohYRw0Mh2QD5srn5qT3I2mkaf0Q=
Received: from MN0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:52c::32)
 by MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Tue, 21 Oct
 2025 23:56:56 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::94) by MN0PR05CA0024.outlook.office365.com
 (2603:10b6:208:52c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 23:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 23:56:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 16:56:52 -0700
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<pmladek@suse.com>, <kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>,
	<seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>
Subject: [PATCH v10 10/10] fs/resctrl: Update bit_usage to reflect io_alloc
Date: Tue, 21 Oct 2025 18:54:53 -0500
Message-ID: <022b992dd61b4456220c0ca1fac75d73374922e9.1761090860.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761090859.git.babu.moger@amd.com>
References: <cover.1761090859.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cf5b2d-249b-4c46-cd90-08de10fd8410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FZ7qwqnSCzH73Gsy4T6uHW0lu8ugsdotRQQpKYntm4BJuvh0KGT3JVBf+IRR?=
 =?us-ascii?Q?Fzl+dhxyk3gT7GhVkkpJqpAlbN5+kFGR23Ey2wzNJCc4xRHZ+JU1DjwlSVHx?=
 =?us-ascii?Q?n0bUjNhMBpS3H97f30UVy+YsRsWbClhGk0FYDPIXDUr5mMbYCvzHYIbhTRvx?=
 =?us-ascii?Q?YVdO4bCLOTePgrXOojCi+g3ghaURBmdneSOQNGt0iMh7ZCV2d6I1vs/OqJKg?=
 =?us-ascii?Q?ZrZtAOuFazgP9GIfSfW/f/+FhUqBz/aZYm86bUFig6mV5HNWNvd5atPatE8c?=
 =?us-ascii?Q?FGla52hzB4F6W6cf3HZCAdRyLYEURtDblPZSTOZE2Jym3JC7BMWPyepAzaed?=
 =?us-ascii?Q?XodbWjmtjAZX7FH7T2x2fmlTQ42opEmpdSlv3R8tvNP4ku/E+zBzRWyLemjh?=
 =?us-ascii?Q?tNz5AChwXsfh6ULhUbOPxUjKYZHqDz0+do3asuAleXl0Xb+3W5zLuGsio56F?=
 =?us-ascii?Q?oSDP/OrIana0mcZ4DWxlm5h1apmgWfYtQJn0eS0shaLtf3GtKfLMNX1GmfdC?=
 =?us-ascii?Q?nEkM4tVA9AJ6kIDBiTMopVc+jFVRxDKtMxJGe7nrwCLtOdnMQH3MRd2Hm6s6?=
 =?us-ascii?Q?g1eZsehc+zSpqRyh6tSjYFWbf4CuY1nufZIZTiRV6lNQO6+Z10gPZp7XBPeT?=
 =?us-ascii?Q?kxBShY4uMwRALLLUIKgkgCRCnwHCIrb2UvLo1YNPGXqeL6brYTsQCvPDkz5U?=
 =?us-ascii?Q?Gwv4wHceWmX5rE3+/MPoLsW6MeAckFB8CRyW6XTw7HeN3WXhBT2uJYqIANEC?=
 =?us-ascii?Q?6uNqKMN6BwlMBTdkI/9ycMDHIDdN8vzbq/uePgVT4RDobsFW7wJQPPsGHXD9?=
 =?us-ascii?Q?htQdk1g2cJXCTwiqOzGfM/pwJ2wsYPC07WpWjxhKep2AH+GYKjpBBhGjAYge?=
 =?us-ascii?Q?+bWThYjbhwxtypTbL2fnwZfHyA29e292WPlxcP0tSwE3Ri3ZhECyo0LjVRKS?=
 =?us-ascii?Q?KNqnN09pIYeAUDaRUvOLIVGHgW2dTj6LaJ1s2Cqym+AUXZyzcf9vXobXEkqL?=
 =?us-ascii?Q?wyGdMR+87F9i5qZ8vVvGDRRM6hGZvI2hX6dzO6GBkJtA9YGCO4UlVNBNtWZ1?=
 =?us-ascii?Q?7rbfG/lH0haQY/YZEyknRDfYjZWLXAOu/J1ADAhoUKZn5ynkI0XLQrOEAQPP?=
 =?us-ascii?Q?rqWo6qLBWBMtvAIFKGECdnIAb2O1ZZv6j/3p9GK2oE1D3j11UWGYYJvfptRJ?=
 =?us-ascii?Q?DETjHZcYI+606lhWrV79aSByewRx4CP14RBEQIvVl4lbH9TDWQ/7nL+yKsma?=
 =?us-ascii?Q?OD4cAAi+uchk0fzWzlGQNVkm60sZQXPvI/vRjcBTpgXMMdbpaPxBpFh6qmW8?=
 =?us-ascii?Q?wS8rmwCBoGYcdIMxxxpRyfe8WgOwm1lMYFiz//gYdMyQxj3yKbfkW933jAal?=
 =?us-ascii?Q?yV7yZJeQnrzlgvcY1GP6ff8u0h3TzBxNsdeqUDUPTlkgH9/dZvvJZQOsMdK+?=
 =?us-ascii?Q?KDBV0FveTgeg9UUndgyyVPKYF17LpekT6RC/wmNHwn9ChaR2CmGrdS1aAZTP?=
 =?us-ascii?Q?EO1KYIeOKj1WjtNTL0rijMa59Fb8PRxHm8OpcyIAjroIf4U5pZGd+14Nk0IR?=
 =?us-ascii?Q?LOC7QJyEgxBKErJQwCc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:56:56.1221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cf5b2d-249b-4c46-cd90-08de10fd8410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333

The "shareable_bits" and "bit_usage" resctrl files associated with cache
resources give insight into how instances of a cache is used.

Update the annotated capacity bitmasks displayed by "bit_usage" to include the
cache portions allocated for I/O via the "io_alloc" feature. "shareable_bits"
is a global bitmask of shareable cache with I/O and can thus not present the
per-domain I/O allocations possible with the "io_alloc" feature. Revise the
"shareable_bits" documentation to direct users to "bit_usage" for accurate
cache usage information.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Changelog update.
     Updated schematas to schemata.

v9: Changelog update.
    Added code comments about CDP.
    Updated the "bit_usage" section of resctrl.rst for io_alloc.

v8: Moved the patch to last after all the concepts are initialized.
    Updated user doc resctrl.rst.
    Simplified the CDT check  in rdt_bit_usage_show() as CDP_DATA and CDP_CODE
    are in sync with io_alloc enabled.

v7: New patch split from earlier patch #5.
    Added resctrl_io_alloc_closid() to return max COSID.
---
 Documentation/filesystems/resctrl.rst | 35 ++++++++++++++++-----------
 fs/resctrl/ctrlmondata.c              |  2 +-
 fs/resctrl/internal.h                 |  2 ++
 fs/resctrl/rdtgroup.c                 | 21 ++++++++++++++--
 4 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index dab4b430d3a3..ccc425b65b27 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -91,12 +91,19 @@ related to allocation:
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
+		configured independently via "io_alloc_cbm".
+
 "bit_usage":
 		Annotated capacity bitmasks showing how all
 		instances of the resource are used. The legend is:
@@ -110,16 +117,16 @@ related to allocation:
 			"H":
 			      Corresponding region is used by hardware only
 			      but available for software use. If a resource
-			      has bits set in "shareable_bits" but not all
-			      of these bits appear in the resource groups'
-			      schematas then the bits appearing in
-			      "shareable_bits" but no resource group will
-			      be marked as "H".
+			      has bits set in "shareable_bits" or "io_alloc_cbm"
+			      but not all of these bits appear in the resource
+			      groups' schemata then the bits appearing in
+			      "shareable_bits" or "io_alloc_cbm" but no
+			      resource group will be marked as "H".
 			"X":
 			      Corresponding region is available for sharing and
-			      used by hardware and software. These are the
-			      bits that appear in "shareable_bits" as
-			      well as a resource group's allocation.
+			      used by hardware and software. These are the bits
+			      that appear in "shareable_bits" or "io_alloc_cbm"
+			      as well as a resource group's allocation.
 			"S":
 			      Corresponding region is used by software
 			      and available for sharing.
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index a15479dd74a9..1a1374fce603 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -750,7 +750,7 @@ static int resctrl_io_alloc_init_cbm(struct resctrl_schema *s, u32 closid)
  * resource. Note that if Code Data Prioritization (CDP) is enabled, the number
  * of available CLOSIDs is reduced by half.
  */
-static u32 resctrl_io_alloc_closid(struct rdt_resource *r)
+u32 resctrl_io_alloc_closid(struct rdt_resource *r)
 {
 	if (resctrl_arch_get_cdp_enabled(r->rid))
 		return resctrl_arch_get_num_closid(r) / 2  - 1;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index bab9d9716783..e5136f406f69 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -443,6 +443,8 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
 ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
 				   size_t nbytes, loff_t off);
 
+u32 resctrl_io_alloc_closid(struct rdt_resource *r);
+
 const char *rdtgroup_name_by_closid(int closid);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 236b6e49761a..b7f94d110025 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1062,15 +1062,17 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 
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
@@ -1098,6 +1100,21 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 				break;
 			}
 		}
+
+		/*
+		 * When the "io_alloc" feature is enabled, a portion of the cache
+		 * is configured for shared use between hardware and software.
+		 * Also, when CDP is enabled the CBMs of CDP_CODE and CDP_DATA
+		 * resources are kept in sync. So, the CBMs for "io_alloc" can
+		 * be accessed through either resource.
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


