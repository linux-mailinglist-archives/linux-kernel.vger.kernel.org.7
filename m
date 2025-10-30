Return-Path: <linux-kernel+bounces-878779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A6CC216E9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EBF03466D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94173678CC;
	Thu, 30 Oct 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dU8d4TKq"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE43678BB;
	Thu, 30 Oct 2025 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844639; cv=fail; b=bFxWFXhtq5HZHLE3hbQRSbXPXrSpa6j5lGspGjC1+Vmg8TzRFoaEPEddkhJD2XiHZKvPJ6fby/LUcmlc+uE/KXTGGmXN39GJz0Khq+XUMNfJqS6oR6duBwwdKuTqacwADAukDWsJINniG4mgNOrXL07yA8XpdvXyVIty6W6q2yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844639; c=relaxed/simple;
	bh=QfW4srPARS95qbwsihxfe5u+hEF59Zey+EoeDkpXhMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KF0hZYkJjuVfiK7XXkCENZMPZC52geD3iCV0xPI3MWt1LDexGk4q6CTOwVUNdDFpFEMrShsoLcb6zu5gCOVtBEJE8Dw5/EFdwUWFxgJj2UdyW9+H88oGk1w9GLXzz9uZjBKK1euNee/b9toP1A9u/uaX5sqLNRv5XKaitDFuPW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dU8d4TKq; arc=fail smtp.client-ip=40.93.194.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbpnAny1Jq5RUAILSJtyEoWLKDlxhCsGC9USTKsBUMcitNKcGskoAQjDxEDoT8kYjrMszlNmxLJEpV9LCIiM+0Apdqn/v2pcMivXsObO30sviow1LB4yL1Wu/fj7uW7rQAIJLddRO5jSk0rQh3ytVXb1vAtOqAx6k718JvcXut1tKZ4ajs77PttUQwGv43dBTPvtDPrcaA82HGBxNZ4c+DOlHN7LWSwGJ17UZosBhhz+EkIIATeedlaCZU88a+No/rutZWtMdd6cNHAkGRs+mnySzcKVDvQ3r3093tBshxO0zJtfGO5avbg2WooHyWMDy2bnI0fTLmnwXmDgT0f5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHg4J1LD31rL2EHV+TnTZREKVggeeksUHUR7uzfv9vQ=;
 b=et6I2Ap0zIRIV8YmsqsUHQ7vb29cHZewuklNtggyR3ajYUa/a8bLa2lxYEOY/Wa2WIlTnKTItAPBVNNCSd4tb3LJm7zOu2CxCUJRh3VO682njLpbHJtOrj+WOqiGpL3tjREvSlsnlf5wKcHEXc+yTeqC2J1Din4kIQ9aLovotQLrFIPDQFV7w5SCfw36XUjvYYsHR/wzl+yUyXn7zJOUdtlbzK1Pkb0gmW9E6rquVbjmPYYwNve5TrzYQI/ZDQPa18UNxLgBglsxJasy8mlPJODnlODo0q+Njwqu3CTAWcdZokNesr34uy6kSrxYI+K/dC6fAWU4xCpY8XmsZRIbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHg4J1LD31rL2EHV+TnTZREKVggeeksUHUR7uzfv9vQ=;
 b=dU8d4TKqlERE//2RtlBGmjyRZmR10eee2EP6STiv6K07XKm4kn2wMpxQbxzTc9xyuXwvIMzuUto27CglBRuSwqN67sHMtDqeemznMkHvrlrgVZD8l1QHaUAEKm4Ync29Iaae10IUcDWoCfQ43Zvgj3ukbghqnM7noFrjeDY6RNA=
Received: from BN9PR03CA0967.namprd03.prod.outlook.com (2603:10b6:408:109::12)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:17:13 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::77) by BN9PR03CA0967.outlook.office365.com
 (2603:10b6:408:109::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Thu,
 30 Oct 2025 17:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:17:12 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 10:17:05 -0700
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
Subject: [PATCH v11 09/10] fs/resctrl: Introduce interface to modify io_alloc capacity bitmasks
Date: Thu, 30 Oct 2025 12:15:38 -0500
Message-ID: <8ae9db3198ae0914789ecaad4a5f78acf8faf2e8.1761844489.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761844489.git.babu.moger@amd.com>
References: <cover.1761844489.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 01477d54-91a6-48d2-b92a-08de17d82a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rBlVuKm1hhp68zYc/M1d1d6+MlCErqi2URsxIJF1WKuC7qvDIWaETCyVT6+8?=
 =?us-ascii?Q?Hy41OGYcyv9s4TUt8Cn9tCwqNAHOB5y+WYUwZu5PGuV8MUQ+s8tQVq6hGVAA?=
 =?us-ascii?Q?VTjEZWfH/zjOS57zRMXlDgCZjx8Ef1J502XArlOuKG9GrnptrUEUTAUxBEMQ?=
 =?us-ascii?Q?cjRBgMevceKidrEt4xBu8GEu4oeDcS7EYB+p7T7zWt/C9hfqgQVLWViwCQow?=
 =?us-ascii?Q?xCKKB0alOci009Ci+Q/J1OgVe9J08oLwtOPWDJDtezROx9gllUdAHzpmUAE6?=
 =?us-ascii?Q?oXw3RigXTssiOonPkftqeXfY5LdkVQb0NRX/u3GgKrVR8jDJiZjxC2cpWiIS?=
 =?us-ascii?Q?dNwnErmqFAs7CKcdgrSEBoPZPy0ta77MTIJXMyLpO/WOj9LCnovpvTL8VjN8?=
 =?us-ascii?Q?2t8mX0nRalexXyBgZoIzZ8Agc5aScQR+6swnhtw9mq6qTz0pn+rQGUnSC8SE?=
 =?us-ascii?Q?IM6DdZPhpe55uUvkL4HNx1A748Dcg82U7+G3FU/MpfpHp8M3jGOVV5ah2qpI?=
 =?us-ascii?Q?YcMH2iWrKDO9XuGXc98df8+KJVOK0Cb3WnMCzFnfRBvIg2pRDnpCKdHGOXEL?=
 =?us-ascii?Q?nsSQ+d3mx+9qOekMlo9O7SxeoQTw/PZGHd5OLnwU4cBz0SjXJ3K0ntSoSOHe?=
 =?us-ascii?Q?WUJB9ZLax6pnzaisBI2OBxfejWMpRZDjDReUF9Ltf7rFvznBN8gVFH0sr5Bj?=
 =?us-ascii?Q?SzozbLjqL2uEo3+OazYOS8xrLvldf+sIpJUFLOnjcQIjKsMbWECix1441/rY?=
 =?us-ascii?Q?0DEkYKifCNL2qM1LDQH8fkCfohOtgM8Jtc9vuDSL1YhVZwnM0aJs9075rBqD?=
 =?us-ascii?Q?8njdHDEW5rTKIiBqoM5waFXOWBieIF4y1pYbvKaNSnqBrrMEvtOuDekcjkzD?=
 =?us-ascii?Q?mMOIzuI3nNii1R8kumBI73oSOEaMp1SIoUgYwyE6AIawS2MWq/ZQxT9/QZ3i?=
 =?us-ascii?Q?HZMpWITXnTBb+gPrGSwNrKnHZ/nuXjH2vh6Edx4L+jFYUuLFG2YtnxHFS1ZF?=
 =?us-ascii?Q?LGfJV3uZxVM5MAK9ggbJjGRXp1COYkE7tpZkRt1kR7OQAUoUcSpY+KsYBa+y?=
 =?us-ascii?Q?mRt165jqpwiMb1qK4XSpJQINMyRENJsEkeASSgsu9uDVGvWrg7Rff26CDmzL?=
 =?us-ascii?Q?I8/kt8WMz9xCZKUJnPSBLsMFtX8Lz35JZ/qAW5SVQwFLIJQ126JeOkTVEFY2?=
 =?us-ascii?Q?UPC4jdB80l0pbfw8qmRQwLwqejFTCm3HNSdqMLC/go6QyT6Tw7H1+ny3/QJn?=
 =?us-ascii?Q?FLSIgQgr7yv7l/jrcK6b9a2tEt+3TavXYcRET3+vEnhP6X29X/Mf1jfx33fv?=
 =?us-ascii?Q?ZFp16JJM287yJ2ym+M44cvLPlIuowXpOEzAHrOJWsNYimMpJLLQnYxxV7+9k?=
 =?us-ascii?Q?v81nKyc59OLnpYCuTI3n5fyC/+TomKc3hl+STFd0sfGf6k9mtfzNa4T0cKQC?=
 =?us-ascii?Q?NOCXdNIGk4lQLNZ6S872cBlYkI9F7ytzwtnJGhgyb/znq0V5ArbiZVt2ldKn?=
 =?us-ascii?Q?xii1ljZ9HICnlEVqoj3G2k/LVb24ei2qy5kKrSWWb+pQvhx5st/YSybLhIHU?=
 =?us-ascii?Q?uTyrTaGtII8/JMZKEaE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:17:12.1008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01477d54-91a6-48d2-b92a-08de17d82a31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310

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
index 1826120ab5d5..dab4b430d3a3 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -189,6 +189,18 @@ related to allocation:
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


