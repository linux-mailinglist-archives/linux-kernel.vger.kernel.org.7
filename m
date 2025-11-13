Return-Path: <linux-kernel+bounces-898402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEEDC55335
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F232B4E9DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407E02264C7;
	Thu, 13 Nov 2025 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U/hql3/H"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987102248A5;
	Thu, 13 Nov 2025 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995553; cv=fail; b=HmdA62E9PBBSLPPDjiH2q2C32aA5uLqfqOWEefHRLhVDkOxo/6Ig37rpeoYuMsw5ween6Iac1leY1zxbnmxq9iwqeIWa7+5qQMqMoPneBnmTJMJPsdA76m9H27sCzHsRAfLK1UqKx4CjDCDDMXiEQeBJaSj4mc3Zyiftk72KXBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995553; c=relaxed/simple;
	bh=ebccWHimWkhDhHgjgJUuzYkkWTZVmGQuL4FntaV1H2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBMDnhKT8UCPzi2dTjIqrM2O1Zq5RWmDtYUoM4jL+oIlMN2fh3HJfGfyA+6Jam94jF63+eQEtilGhQGEMrMzdNxcwId/zmXB1UQhcsWb0qLw5ZfkCFHMbjM5Y9xlvo8OziHwMqFYrZln7EZRaUY6+xdnB+FNnBQT0zVcfGwdKb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U/hql3/H; arc=fail smtp.client-ip=52.101.85.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6jXU4Pw9Fu1iI4USzw7uu/YM0tcKRWwnx6YhdPDyR060CghMHxvJkG2N1xDLCmX7R92LjV53O7LqyNm1ahnmyhtqHBlS49WFEHZsBR9qsZBRLhLjb+hNHjLNdX+7tKDq8cyrGtjCbggjOfbFxMng0NCFeI+D2ojVGUl7l2dUHqP92G8bRp8nM3iNcg6j3sLFMpQala0slFh2TXuCN0VY62hqaCdEccaNUisH40IHnstG+w6qaMb4JmFvUcJIwwLbEs4MdVq1VmD9LhJUJi418TSO+4DeHa9n7PU/8iBe04LIlLuP/AvHoLGI6cX0RNp6gANgFvss4jViRxqHlEGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Zdkc01Mqbv/9R0g+jrQpf9p6AeL3H6YJkCSVCuVu90=;
 b=oCFFLrXDe45fw47CJ7JhUFDCV6ZZPh6aZuPg+FQATXy754odSqa5XO1Ds+dVXga9yBTnCjF43haQ4O2QlwoC99r+hWUJW07Ir/BAzKZAIk83acWsEL/Mww+j+uRGbxm8Kj1lZPhKdVfsQ0lgYUXfgjMfp9CGbXIfsu10xkyzchGxmNi/qXRopc4cik0YVenlNL2wkLBCQ01VakEBtRycdzXJyDyqcEKcGpZ6Yolf5nbx1DGwdtBLQu99+73gKNaZm7bKpQid2syK+OIRVys+iM3jFaSDc0xxc3nA3r7zcakat5EXrTJ5Hj7aJTIhS35+OyBW+4iitvXTpqPBuhsssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Zdkc01Mqbv/9R0g+jrQpf9p6AeL3H6YJkCSVCuVu90=;
 b=U/hql3/H5fKw+C8qMabbckUdQj1bCwwKbFBLW2tdULePXidhxOQojegZVIgQAr39jTw3FW1HZ+825ePvW4zukTRXLHV2pFBi1g6pKfyovyV1rv3MutOsfeZpJnZLNVdCoeGXQEv/LCCkkF54fLV5xzTwrmSrC6WdxZ5DsewBAUE=
Received: from CH0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:610:76::31)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 00:59:06 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::f1) by CH0PR04CA0026.outlook.office365.com
 (2603:10b6:610:76::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 00:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 00:59:05 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:59:02 -0800
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
	<peternewman@google.com>, <feng.tang@linux.alibaba.com>
Subject: [PATCH v12 09/10] fs/resctrl: Introduce interface to modify io_alloc capacity bitmasks
Date: Wed, 12 Nov 2025 18:57:35 -0600
Message-ID: <67609641b03ccfba18a8ee0bf9dbd1f3dcbecda3.1762995456.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1762995456.git.babu.moger@amd.com>
References: <cover.1762995456.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7cfc33-58d5-46ef-34b8-08de224fd852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f580QCMpiqx+1eRv9nn5nS3U10rb0I2GQjd5jXzpXiTYuEyxB+PO+Q9oupRs?=
 =?us-ascii?Q?mewFOAJCQYHScfJYlEcp/rJlo81u2DtG1AidhKJ8/mFOo71kX347hfrxorf3?=
 =?us-ascii?Q?MrJf35+h9/kvRlMWKiNdLkJyFUSEPlNvwreG8yXpHKEj3n2Pv1D9kyAEkEU0?=
 =?us-ascii?Q?scA/ZpHFHfIjckM01Jw3fLRV/SSxA5PHGytbHcJo+Rl6gLGYevlo4uSpOibn?=
 =?us-ascii?Q?77Umm7vm5/Mq6vYEWp3QmZvnr8yfw19VhCiJaUOwI/PwVy+JKjgNcQLOzBWm?=
 =?us-ascii?Q?53oYSbov+KFLZQlbm+XWYlD5TTyaKY6VYaJasiqZKEPTgn6ByN6jCA5OnXAN?=
 =?us-ascii?Q?tQCgzx42hQS0QGgRCQw5chH7oioDaK41/S2h05QoNr/4tUvgOvvY33ta39EI?=
 =?us-ascii?Q?IsE4jaEc1MzOkNYh8/xhEcy+3VOdq9M7QD9jFOLoGy3h492P9o6pwY/Ofe8y?=
 =?us-ascii?Q?vDzOKidamd3/ZiTXLLZI3qp+S1zu982LMZyxZZvow6ozj0cUUOwb/x1rqvXy?=
 =?us-ascii?Q?PY0BbGEbc7yYgr0SWSxLrCTQzwpaO6V5IP560mpWmS15lOYtQLJ4jh5MbZws?=
 =?us-ascii?Q?m/wh6KkbNm3I2JPgD1tPvXx/Ze6nwIf61BEiIDTiYUXGHdCkVhoGar4Ym75I?=
 =?us-ascii?Q?+L+DiUkJItsqC76upXgkuOo4fgxfFqEDsrD7FRM9CWtKUt3So6qnIxYGoTEm?=
 =?us-ascii?Q?S/oh0u1i5n/NbwORHIcYOErF+4QmZESksrd0p9ZotCX8cChzsf7mmR1MdZLo?=
 =?us-ascii?Q?Ta4sUciY80h1yiKU1SvTe16yZVIwJ9nN9nf5Rsu6OMxC78nJz8H6nzBjMd1J?=
 =?us-ascii?Q?15UC/Z/rbxdezqjfo/zJJ5/a3B9kJ68VlqsbXJQftdlurFN1M6Lgju5Guwfe?=
 =?us-ascii?Q?p/ka3k7YnVxioKKtXnxG7Wts5t85gAlvtLU3mPHDKGuVb5Z5OT9nhcXfOgIY?=
 =?us-ascii?Q?DlS9dYhi1XBv2JAhUJOVKxq2L5Rk80RerWlknJKIV/pNZtIt/+84GetiU3sr?=
 =?us-ascii?Q?f2nLQ2PlkJ0BHwc9PQvEhohKzGIS3X/cL3nUCkgntqkAHhmoPFdMKi5t/Fs7?=
 =?us-ascii?Q?O7rNDROdCOGzD75xEAB85KAEE4qMS2uvhpBl9EtMlXI3UJVi9zYg0PUhyhD0?=
 =?us-ascii?Q?qY3IV49XgsUfJh+Y69yAO8Vbum5l8uiDHPlEHY1R/mA92NlgIFP6u3DvpYZt?=
 =?us-ascii?Q?IN/ydl9EqIi/sOVYoAE+XEXvDDe6ocVcD9EjjgJZxiM+mbzPgvbevve+uaBM?=
 =?us-ascii?Q?rjnvwn7Dblq0aKMV3QqIIxQUdlWRDl1bq4vy6KdXjNRk2B9hlwvYJYr772O1?=
 =?us-ascii?Q?speQXUlf612r/RUu10mQ147f2fZJvn35T4n8YuOUUFjTdCJrevuTzefNoNSS?=
 =?us-ascii?Q?7uDsRVtH/QH8PnZRek1Wh0O1TE86/tFSHBwCPoHWxnYVgX4WqFkRcXH4EdrO?=
 =?us-ascii?Q?N9AaZ5gnZV/LmR1WF2KVf5eLidAFU1bOngxBSUOJuecaoWoce22d29SWy6VV?=
 =?us-ascii?Q?QKQwbQIUefZXi/4GGVUrzz9qt6YvzgJWXO6XYVv0NqCUNC+Sghri6eJuhuGf?=
 =?us-ascii?Q?XIL0ZARNx9W0+38lvvM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 00:59:05.9679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7cfc33-58d5-46ef-34b8-08de224fd852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369

The io_alloc feature in resctrl enables system software to configure the
portion of the cache allocated for I/O traffic. When supported, the
io_alloc_cbm file in resctrl provides access to capacity bitmasks (CBMs)
allocated for I/O devices.

Enable users to modify io_alloc CBMs by writing to the io_alloc_cbm resctrl
file when the io_alloc feature is enabled.

Mirror the CBMs between CDP_CODE and CDP_DATA when CDP is enabled to present
consistent I/O allocation information to user space.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v12: No changes.

v11: Fixed the minor conflict in internal.h due to previous patch.
     Added Reviwed-by tag.

v10: Updated the changelog.
     Updated the return code to EINVAL when feature is not enabled.
     Minor code comment update.

v9: Rewrote the changelog.
    Removed duplicated rdt_last_cmd_clear().
    Corrected rdt_staged_configs_clear() placement.
    Added one more example to update the schemata with multiple domains.
    Copied staged_config from peer when CDP is enabled.

v8: Updated changelog.
    Moved resctrl_io_alloc_parse_line() and resctrl_io_alloc_cbm_write() to
    fs/resctrl/ctrlmondata.c.
    Added resctrl_arch_get_cdp_enabled() check inside resctrl_io_alloc_parse_line().
    Made parse_cbm() static again as everything moved to ctrlmondata.c.

v7: Updated changelog.
    Updated CBMs for both CDP_DATA and CDP_CODE when CDP is enabled.

v6: Updated the user doc restctr.doc for minor texts.
    Changed the subject to fs/resctrl.

v5: Changes due to FS/ARCH code restructure. The files monitor.c/rdtgroup.c
    have been split between FS and ARCH directories.
    Changed the code to access the CBMs via either L3CODE or L3DATA resources.

v4: Removed resctrl_io_alloc_parse_cbm and called parse_cbm() directly.

v3: Minor changes due to changes in resctrl_arch_get_io_alloc_enabled()
    and resctrl_io_alloc_closid_get().
    Taken care of handling the CBM update when CDP is enabled.
    Updated the commit log to make it generic.

v2: Added more generic text in documentation.
---
 Documentation/filesystems/resctrl.rst | 12 ++++
 fs/resctrl/ctrlmondata.c              | 93 +++++++++++++++++++++++++++
 fs/resctrl/internal.h                 |  2 +
 fs/resctrl/rdtgroup.c                 |  3 +-
 4 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index e7994538e0ce..bbc4b6cbb71d 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -196,6 +196,18 @@ related to allocation:
 			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
 			0=ffff;1=ffff
 
+		CBMs can be configured by writing to the interface.
+
+		Example::
+
+			# echo 1=ff > /sys/fs/resctrl/info/L3/io_alloc_cbm
+			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
+			0=ffff;1=00ff
+
+			# echo "0=ff;1=f" > /sys/fs/resctrl/info/L3/io_alloc_cbm
+			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
+			0=00ff;1=000f
+
 		When CDP is enabled "io_alloc_cbm" associated with the CDP_DATA and CDP_CODE
 		resources may reflect the same values. For example, values read from and
 		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index c43bedea70d7..332918fc961a 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -864,3 +864,96 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
 	cpus_read_unlock();
 	return ret;
 }
+
+static int resctrl_io_alloc_parse_line(char *line,  struct rdt_resource *r,
+				       struct resctrl_schema *s, u32 closid)
+{
+	enum resctrl_conf_type peer_type;
+	struct rdt_parse_data data;
+	struct rdt_ctrl_domain *d;
+	char *dom = NULL, *id;
+	unsigned long dom_id;
+
+next:
+	if (!line || line[0] == '\0')
+		return 0;
+
+	dom = strsep(&line, ";");
+	id = strsep(&dom, "=");
+	if (!dom || kstrtoul(id, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
+		return -EINVAL;
+	}
+
+	dom = strim(dom);
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		if (d->hdr.id == dom_id) {
+			data.buf = dom;
+			data.mode = RDT_MODE_SHAREABLE;
+			data.closid = closid;
+			if (parse_cbm(&data, s, d))
+				return -EINVAL;
+			/*
+			 * Keep io_alloc CLOSID's CBM of CDP_CODE and CDP_DATA
+			 * in sync.
+			 */
+			if (resctrl_arch_get_cdp_enabled(r->rid)) {
+				peer_type = resctrl_peer_type(s->conf_type);
+				memcpy(&d->staged_config[peer_type],
+				       &d->staged_config[s->conf_type],
+				       sizeof(d->staged_config[0]));
+			}
+			goto next;
+		}
+	}
+
+	return -EINVAL;
+}
+
+ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
+				   size_t nbytes, loff_t off)
+{
+	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r = s->res;
+	u32 io_alloc_closid;
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
+	rdt_last_cmd_clear();
+
+	if (!r->cache.io_alloc_capable) {
+		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	if (!resctrl_arch_get_io_alloc_enabled(r)) {
+		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	io_alloc_closid = resctrl_io_alloc_closid(r);
+
+	rdt_staged_configs_clear();
+	ret = resctrl_io_alloc_parse_line(buf, r, s, io_alloc_closid);
+	if (ret)
+		goto out_clear_configs;
+
+	ret = resctrl_arch_update_domains(r, io_alloc_closid);
+
+out_clear_configs:
+	rdt_staged_configs_clear();
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 779a575e0828..e1eda74881a9 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -440,6 +440,8 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 const char *rdtgroup_name_by_closid(u32 closid);
 int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
 			      void *v);
+ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
+				   size_t nbytes, loff_t off);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 44d419e4e63c..3527bb8fa2ff 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1973,9 +1973,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "io_alloc_cbm",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= resctrl_io_alloc_cbm_show,
+		.write		= resctrl_io_alloc_cbm_write,
 	},
 	{
 		.name		= "max_threshold_occupancy",
-- 
2.34.1


