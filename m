Return-Path: <linux-kernel+bounces-850709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED655BD39DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251A73E1F28
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C82749ED;
	Mon, 13 Oct 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tmBwm/3V"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA075261B9C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366122; cv=fail; b=nijBGgsFok2SIZp4ogD7/Dc5a9odIC2cww8YFIEXRi0MG/Vr5Z6pWFJmzk2aFHz0P3whdvOq01ubxnNC7mRps7b5cIZs0Rs6VScf0nYTezMPAnSm4gNRns3hP6+9F9XMY18CGS47XlGLIusp8woeNR+bqMCMXuUU0/c5u9ZE5/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366122; c=relaxed/simple;
	bh=TLfzB99JOZOJ29uO0YP7DkX02c4QoKQtktNAKR5MKHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0VuHhYNAQ1OTvqrAoNfoEZl8wLQQFgK724/0CzGbh1FVrlMt1PiEr5LdNQ7aI6kl7txiOGqFTM6Ui4A2mhgYcdrfsLE/CK1rhopSDiMhqgCYxpNapmuDpMryXs3TCJV6/8yeQEs440xxtD0xmtu+ZlouWmaazIkll2PKdlog6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tmBwm/3V; arc=fail smtp.client-ip=52.101.46.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApvlZwYEL+vV7lPy437Myg5XPE71ZicOvP391lbpfUmdaYNUI1WuLVoSvX2oIICI+HKG+6mSw63H/wXJ6zy5NbsOD0lKXP3WaSli1487SLQfl8TksNpMDv7zJB2P+9CTAvbl9+ExVayvEgjldi9NdT2+rrPCWxqEZW1I5R7GfVbbQA3CjMD31R2J7saRJWjMGeVJh0qtwORqMYgZzAcsdH1lCptLfh2AlDNcQ9B6HoTkILMrT5s29xtlRI3RtDV0S0H0pxS3J5/8surht4mmbpCWndLVlbdMGprU6y1KPUH5hMERvTIdyNIcP1b5SYberkFFrJrCYy85CPh5LPtZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC4AQHPsZl3n4cnt7w3EZcP+dCeYOC4Met4ryNVaPPA=;
 b=JvDXI35NkI5FUnNLHX6SgeF5Jl194+32moyT43B3MpqBQYkqmzOeY99K6/jhB5uaXmOpcD3RyRbMMGrxNDCX48xGtnslkLIh9Dn3kkLC5vA74bqqnKOnQ8hTt6qmg8JZ7UyzzBSbHDThXBY1YCDQzrjxDV1bhOG+/7CEeK/0HAlRMonSF5RN/UtWZRcBGhj3y2fsAt7yLLZ7WfGKLoMuQfcxvIZhYX+EAaqdVqyrwiaxt/RzJzsBOsK+3sHktEOcROkkIOjUf3MquVjv40h+OVg1mYEpaZvBFqDnzo3hrUXfZRCy9WnZy3J6SuzwDdYMWGTed1+lERHN12tg4JZ5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC4AQHPsZl3n4cnt7w3EZcP+dCeYOC4Met4ryNVaPPA=;
 b=tmBwm/3VbOmi6Zj32MPbERKZC7e9p+3ZgzxhRHkOo/G+7W8gTPHz4uMvAOJsJ0PoeVHYYk8fktFG9OWd5p1T+A7UU2wzfprYzxOA5TmsOYkGlxIYS9v1/WdAeFa8h4K53NEsw64L7eJI2DU1t6yWHqJtPdl1ckgl0Tx2AN3/xkQ=
Received: from SA1P222CA0114.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::21)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:35:18 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::af) by SA1P222CA0114.outlook.office365.com
 (2603:10b6:806:3c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:17 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:16 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 01/56] Documentation/admin-guide: Add documentation
Date: Mon, 13 Oct 2025 09:33:49 -0500
Message-ID: <20251013143444.3999-2-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cc2e9d-dd8a-4999-0724-08de0a65badf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bm02ZPcWA+FB5HgDHBbHWQqKYpEUG5zSZTsqwt8tXxE9ed+dxwAcuepJG4Oc?=
 =?us-ascii?Q?jsRamSKQGwi86qvOqXQ2KkTigSbH3Kwe5nGZ2pCc8HjK4Lstr80nNer0T/kI?=
 =?us-ascii?Q?H0GahEgcoa+8Uoa+WwktOtSEGKA50o9ITQwev9cbcFibZ2+WMgXWnfdJpk+e?=
 =?us-ascii?Q?OpIs9IZPtFjn6jLlzRAPtPEjcybLqXAliJI05yOP24NGohj4yk6LqEFhqp6K?=
 =?us-ascii?Q?BWk3dmSmaLBKfEyt5qUp3aVBxnybgNzR7C38JTp02xqm1vDed1jYKDTYeKep?=
 =?us-ascii?Q?SowqPIgokg/u5hs47VkGk5gdc9sRJB/59FJqix1zpWsHJIdGE25KEn9uJoZK?=
 =?us-ascii?Q?1bxjEZkvXxdr4qS9k9lRPFMSzJY23sKw6QRG64bzlkXt7NcQCTe/4O76LFkW?=
 =?us-ascii?Q?14saSoZrQZJVGby4Eoq2+NZadsXS+RcTHLuvMmAVY+c4bpquXPg8CViW4qv3?=
 =?us-ascii?Q?GsJrn7SXbCYpNK9ICl7ncJU5ZzE2No1WmDNzjRMQ8DnH7BasoAzm2GsEOQvu?=
 =?us-ascii?Q?qOfCnzR45clJW3+xjVoh3VlIFfycYBLwmXgZGblVPEW2EFJVtWZVSM0MnRBF?=
 =?us-ascii?Q?P/C1z/N7jrOySQ0aVx/fF6GW5+VASnSeMHIOKVFeJm5FikaIaneEOsCf+g63?=
 =?us-ascii?Q?mtIy5DmA+v7BZ0076wVr/kgeuqwWJRdRsKUpubi33bpdCt/YDkj13/iuntHi?=
 =?us-ascii?Q?yUJIKZRF6ySKO5hrJL3+YI8lDJLuH9kffJ9+pLbYV4ijOc2LYq3nQ/46T7Ld?=
 =?us-ascii?Q?NYskYT0JtI32CnsFzuSCcRZtNnxmxVY3N7Sh8Nj3xEb7D/hzNd31/1wWgBUP?=
 =?us-ascii?Q?uABTbWiWCTOToppnjSnWf1SPGLoCncmWBkJm6Iw3lavToAP+MTFLCPKCyYx0?=
 =?us-ascii?Q?KT0pl+RWsYdoneALfIA1a9FRwCb5SSlOSi6VK93y9/7Hl+L2ICYudyv12Ceu?=
 =?us-ascii?Q?ehUHkeUzwdKCnqBgF5rrFVq++qhWZlgJ7R5icPzcWBCpG8uwf5jU8O+sjVY7?=
 =?us-ascii?Q?Kv022r69kE522GbNSAG6t9Hwg6SleFZXsQXDkkGTZHXAi0Kzs/CzyLOmSkzP?=
 =?us-ascii?Q?HNFsh4c20vWxP0es612liw6UJJeOL5glCVip7sqzPDYSZqQtqvCqNQAX1y/T?=
 =?us-ascii?Q?PN/G30vCsL5pOIhJbGMDrWoHXzdAQRqzjPE+7/dCkdRMabQBSt4+5MPQXAUg?=
 =?us-ascii?Q?GEspgRIdrenLYT4G8hskR0DXUbJ0iOpxHNP4jQSacAnCK09T8jcnA2i/LSNM?=
 =?us-ascii?Q?qtzKNERmYFz7sDlHid4unWPsgo2wMRduIiGdta2fRcgyZZhm1crbuhCgMjFC?=
 =?us-ascii?Q?eiqICNWkMtyfTL6VH+jxYFysn4Dmws2YrgipWa6totSesn+TYkuM3+8JgaDv?=
 =?us-ascii?Q?/4ZxdH9h/DWCrG5lgsIfhcKI6Mfk9I5mmXS6rKw/3rAksCCbMFYeecONbc73?=
 =?us-ascii?Q?U10OZ5wFSOn0h41J7JdPf81YRyhZFsr6ZGiVgYgi33DrDHdmlOuPIfEOkXcy?=
 =?us-ascii?Q?HTrRjhJAlqvrXFg5gq1FyNUDH/kJxUJnRVMRUmv1q2O0cuuNxtv64+mHsMhy?=
 =?us-ascii?Q?6MwnoomaZSkvjp0vsJw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:17.5707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cc2e9d-dd8a-4999-0724-08de0a65badf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005

Add new documentation for the dynamic mitigation feature.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 .../hw-vuln/dynamic_mitigations.rst           | 75 +++++++++++++++++++
 Documentation/admin-guide/hw-vuln/index.rst   |  1 +
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/dynamic_mitigations.rst

diff --git a/Documentation/admin-guide/hw-vuln/dynamic_mitigations.rst b/Documentation/admin-guide/hw-vuln/dynamic_mitigations.rst
new file mode 100644
index 000000000000..9904e6ec9be5
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/dynamic_mitigations.rst
@@ -0,0 +1,75 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Dynamic Mitigations
+-------------------
+
+Dynamic mitigation support enables the re-configuration of CPU vulnerability
+mitigations through sysfs.  The file /sys/devices/system/cpu/mitigations
+contains the current set of mitigation-related options.  The file can be written
+to in order to make the kernel re-select and re-apply mitigations without a
+reboot or kexec.
+
+The data written to the file should be command line options related to
+mitigation controls (e.g., "mitigations=auto spectre_v2=retpoline mds=off").
+When the file is written, all previous selections related to mitigation controls
+are discarded and the new options are evaluated.  Any non-mitigation related
+options are ignored.
+
+Dynamic mitigations are available if the CONFIG_DYNAMIC_MITIGATIONS option is
+selected.
+
+Purpose
+-------
+
+Dynamic mitigations serve two primary purposes:
+
+Move Policy To Userspace
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+Mitigation choices are related to the security policy and posture of the system.
+Most mitigations are only necessary on shared, multi-user systems if untrusted
+code may be run on the system, such as through untrusted userspace or untrusted
+virtual machines.  The kernel may not know how the system will be used on boot,
+and therefore must adopt a strong security posture for safety.
+
+With dynamic mitigations, userspace can re-select mitigations once the needs of
+the system can be determined and more policy information is available.
+
+Mitigation Testing
+^^^^^^^^^^^^^^^^^^
+
+Dynamic mitigation support makes it easy to toggle individual mitigations or
+choose between different mitigation options without the expense of a reboot or
+kexec.  This may be useful when evaluating the performance of various
+mitigation options.  It can also be useful for performing bug fixes without a
+reboot, in case a particular mitigation is undesired or buggy.
+
+Caveats
+-------
+
+There are a few limitations to dynamic mitigation support:
+
+Runtime Limitations
+^^^^^^^^^^^^^^^^^^^
+
+There are a few mitigations that cannot be toggled at runtime due to the way
+they are structured.  Specifically, kernel PTI (page table isolation) cannot be
+toggled because of the complexity of this mitigation.  Additionally, SMT cannot
+be disabled at runtime.  Therefore, if a bug mitigation requires disabling SMT,
+a warning message will be printed.
+
+BPF JIT
+^^^^^^^
+
+There is currently no way to recompile already JIT'd BPF programs.  This can
+present a security problem if moving from a less secure security posture to a
+more secure one.  It is recommended to either unload BPF programs prior to
+re-configuring mitigations, ensure that security settings only become less
+restrictive over time, or disable use of the BPF JIT.
+
+Performance
+-----------
+
+Re-configuring mitigations is done under the biggest of hammers.  All tasks are
+frozen, all cores are stopped, interrupts are masked, etc.  This may affect
+system responsiveness if lots of patching must be done.
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index 55d747511f83..44418bad5895 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -27,3 +27,4 @@ are configurable at compile, boot or run time.
    old_microcode
    indirect-target-selection
    vmscape
+   dynamic_mitigations
-- 
2.34.1


