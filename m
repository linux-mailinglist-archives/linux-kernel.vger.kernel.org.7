Return-Path: <linux-kernel+bounces-863890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29328BF96B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4849E507086
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807D32EF65A;
	Tue, 21 Oct 2025 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hBi5taVh"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3502BE036;
	Tue, 21 Oct 2025 23:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761091012; cv=fail; b=NAW4a4M6aSn7O4vwHdJpE9WKUyl2NTzXhn1p3btmHF70f7gInoY0kINRNrTmMRaSu8eqTmb01DyjVgRy/GdUxYIXtubSPw02T5aya+zQHrMSBFVdzxfZ2UoXpiikEDHSxQGplyXn3vTrSp7egT/rhr62HcTExzY5fvtWhRsDu0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761091012; c=relaxed/simple;
	bh=Y8egb/V0lVCiQQ7IrKi1S+ZTCBXqRlq6zDPvn97+qGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBP1o6Clhjs18zOV86JSNfmztK9Jrl87HNzaBzfDbrYm5rQIdVH8WNgYG7jmoHVX5Sg0FDncOuoUdy4oUCjoEoioS5QXrbPCo6o4XxZnw7giLJt5sDW4un+UgulCpRa/SuRr5BNnH1iQHnQr9B00XMlbclrhz6jeViExriGTBeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hBi5taVh; arc=fail smtp.client-ip=40.93.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSKLAOXzfF8/KZ5T72Hh5D5FnioGfIYJieH4hTlK3lpi/fY+ViHQu0cZiV5MLPwDI2jDF2F+XUIjaQg3yuB5rljTSjfpXcIK+axL6iLQ+yzefKsm0UBuV6j/VMapm1S7LokJLdoeWSL1M6mlo8nBaewyfN6I09hqqyF/PAi+Dj7IXXZVR9TAwI4lJn2gGlG9iBfrzp8/veKVP4esXQfKr94ngT80KhZSy2endv2Q+wVFKa+OQ8hcU/y+pUj1au1as8uFbZZtv8hcw0tHSOdjvkPArM4ZigPuDJ3ND7+1+RKM4pQX/DOYspjEFxIl7Y2GbhUF73eloRmJtwHrZ8G0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niCB6byXX0oBcEJJGw95fBr9dpdT3zZsiZBQ1MqfqqI=;
 b=p+8V5Mw5iO5bqi0K9PpBddyuY2a9nck1W/rdhrPq8V7PDsd2e5ArPFKtaT5aWpM2Q4LuQblHdP351M5zV20Oxzbfqm9VprTbutVYOqShJwmzobHJVlajToRyfPfFOqhwJsGf096eu6nJI9ATse/b6qHP3pGKRBbYYX3EYsEWKm8iXc2UbWQeRTHOPlHZ+DRecZGZ0L03stXoSgeb+savq56Y7OvWWpnDaNY1Gz3Kub7Amm8Pi3DS0eTJwMjwyJN00XoUQG1qPEjhUvVQ7oi4GTm9KQK5k1DnOoUWi2hpuX+qayiJRpH3P4FNtaR0jXaKu8LTYhR/6Hn/OfmzZnVWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niCB6byXX0oBcEJJGw95fBr9dpdT3zZsiZBQ1MqfqqI=;
 b=hBi5taVhxj77Tx+I8aXRklMiLsE0Al3wHI8N0JVai0SnzBz71nKyd2EiY8V2tghlZpgPgU03iT/9MJE4kYqkJceWJLGhJpd8kEXk0N8D9ftZB6075on/aacTT61b6Hf+mn1CKNQMeBj/dFe1NZAKOPr/sq6eYRdMrNDWAagulWk=
Received: from BL6PEPF00013E09.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:6) by SA1PR12MB8918.namprd12.prod.outlook.com
 (2603:10b6:806:386::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 23:56:46 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2a01:111:f403:f902::3) by BL6PEPF00013E09.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 23:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 23:56:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 16:56:43 -0700
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
Subject: [PATCH v10 09/10] fs/resctrl: Introduce interface to modify io_alloc capacity bitmasks
Date: Tue, 21 Oct 2025 18:54:52 -0500
Message-ID: <3a6d3d9dace1a2dec3418eb00150418e9ef7ac98.1761090860.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a1d1ae-a035-449e-9e2c-08de10fd7de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UaI1TQ9GNGewM+vRhPLgOOrzHjUM+K4W98Hn061oxX7wsEXxO9sDpB92Vt0Z?=
 =?us-ascii?Q?FcvdxY5beIQy/FeibbZppmLVSK1ZLShrfSYGpckmHp7RnhqEJaqmnpV/Xos7?=
 =?us-ascii?Q?KpVVf3Ms59HqQkjbyZ5Sy8CgEzBwp8L5azfOvEhRwkw+2RqTJEcFF+kPMEu6?=
 =?us-ascii?Q?FzBXtNdpMjmbui6ODoqa3CDHplqUGpGKH0RCvI487q0bUAGX2QdTUqvg5tW3?=
 =?us-ascii?Q?23S6cvjgYSbAoIPmBu8jnwZgTvMBAS1y0+7DM7O5r/qxssdaykcBVM503YC6?=
 =?us-ascii?Q?LLJ1q3M9VsdwyhBpGhu9Fod7Bu9tiUEPe0iiu/Zk8IBihrs/n2j4G1VW5am6?=
 =?us-ascii?Q?z4vK7QhZqxZyfsyyYH8Bl5WFATQHBQwJ+mG88dbUQv2wykUhsKaqmvLM/JBt?=
 =?us-ascii?Q?epHh4n4LntFO9XYSU+MOQHbTIR6S+oop8NSbUOZVIc7k78BFGJ8N8tRCGKHK?=
 =?us-ascii?Q?iI/G2qea2TkY1BgBH7658fHtXqcqYTvn11a2dATdd7mgHJHyqZWyFC+q/cpb?=
 =?us-ascii?Q?ziTzcycaDsOJFVaaYyjwNeoqElhaBaMmU7VY5229bXXmnKDbO/l9C41Bq9Yx?=
 =?us-ascii?Q?/P7wVJrZcwnJJi6MjQeepCn9jca0RGQd0PzZUlA3mc4KEirAfDGrHnXxiyWz?=
 =?us-ascii?Q?MWt50x+2Yp3qpNRU0OTlGtsXKnvkLsfscrSSXCN1P/NZyOZPl9rNjCEPtxMO?=
 =?us-ascii?Q?R1HmX3A9MvPbchlywiZiO5ulyfoCZYonuUC/9fX3PK3QDVbXHeovm1tEvwGZ?=
 =?us-ascii?Q?DurekBz0uHBHJ0IKoZxZ+0zIvPcwV0enarBrPXXxhmnpzKF6c/QTSMBS48Eg?=
 =?us-ascii?Q?NDHFKnquISQErvlYaE1eUsvr653vM5bAfRCpys64KvGM0Z5GipCXKjVu5jv2?=
 =?us-ascii?Q?OqVOx63fRjV8rJNlhDGPCo7mxbew4rzC2Jo5L8Pso8pNt43fMFlV4cfCvAkM?=
 =?us-ascii?Q?3w3am82d+yx4fmrctHS16xwGzAMh7yDUsORDJuH8dSVMU2MGFWDS3NwwOyC7?=
 =?us-ascii?Q?NesFiK4uL25qJBR6a0Zefva3glXqRvcYrhdwGWXaoTLWSLz8+mVhcjPA+fMD?=
 =?us-ascii?Q?ERaWVIeIBwVcB1aKSHoYoRyupq3xu5oRFnpVBKLSxl5o43nox40xpQgKw44i?=
 =?us-ascii?Q?jJRto91heRmZsmgDOLQemgHtMkwBUVJ3JzAKp4WWG+6QZ5fmEI31/Jhenjue?=
 =?us-ascii?Q?x9s/EytuSHuebp2NRjqruLNdrve1j8CZWN9KIpgf3Xf1WNKnqnvZVLjlp70Q?=
 =?us-ascii?Q?aMajKz0WaTtU3/xCYfa/dUdJhQ8WoNgsfBf0MZMdqTjkV+ExbOsQfv2h+k6T?=
 =?us-ascii?Q?zUi+bMo9HwYvhMkXvjDI/15INbfwIhooX16TWEWYwZ1Nhft3SGnShQIovdRf?=
 =?us-ascii?Q?8u3Kytatlw+S3DeOHQIHr8bIZBN3i6TXJCOg5p9oCYRKcp64VRlEkvbCHrXy?=
 =?us-ascii?Q?SqDhiGxuAbVoccGQRvVuo61N1y7kj5tKOrc0bDiQs+gKqkznUrATu/kVFPOk?=
 =?us-ascii?Q?hmCzkPCkJAHoSqPzdGVAR8IXmBZGiCjmw9iXhaiirZczx2ZKvfOqmxCGGIgs?=
 =?us-ascii?Q?NeqsE5A6AG8T71orBiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:56:45.7388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a1d1ae-a035-449e-9e2c-08de10fd7de0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918

The io_alloc feature in resctrl enables system software to configure the
portion of the cache allocated for I/O traffic. When supported, the
io_alloc_cbm file in resctrl provides access to capacity bitmasks (CBMs)
allocated for I/O devices.

Enable users to modify io_alloc CBMs by writing to the io_alloc_cbm resctrl
file when the io_alloc feature is enabled.

Mirror the CBMs between CDP_CODE and CDP_DATA when CDP is enabled to present
consistent I/O allocation information to user space.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 fs/resctrl/internal.h                 |  3 +
 fs/resctrl/rdtgroup.c                 |  3 +-
 4 files changed, 110 insertions(+), 1 deletion(-)

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
index 813e298c48d8..a15479dd74a9 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -860,3 +860,96 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
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
index a28cc2541475..bab9d9716783 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -440,6 +440,9 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
 			      void *v);
 
+ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
+				   size_t nbytes, loff_t off);
+
 const char *rdtgroup_name_by_closid(int closid);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 8f40c4a078dd..236b6e49761a 100644
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


