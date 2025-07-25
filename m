Return-Path: <linux-kernel+bounces-745691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044BDB11D20
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A8A3B01B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081ED2E4271;
	Fri, 25 Jul 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B+Enrg4x"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1F217F33
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441625; cv=fail; b=iCiP25zujKuKH196Ih7hG9Qvd1jp14qjNKIYJkRo7qmPpDWgE96IDeRJPh6FEB5tOcNwA5Zjpqhzkvf9igvFjmplXFFGNItK1ZyGSbVl5kS+7XDEUT92ZJou/10RIIIUHCKnm/rZy08KQ34NXtCrUTaLKF5+boNWGGrYvpHoS7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441625; c=relaxed/simple;
	bh=J55AVypgj1mfdphydKHNW+Urzc5DUsV6dPVg7uk70BA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpLuUBx8V2NViRLMIKyWp2CPtV2dTXoj1Ij8DccqPq282wChJkJ7J3nEFJ4iYH7JQm7XAmXI5Bm38tFZVEoCCQVpC0YeS24k6OnVXJFmy7jIWelIEWKFz8IA5yiopcnjbEa8LuZEtNf6Kz42K8sJG0lZa+fYwClP4PRmjAKqZgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B+Enrg4x; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Um0zVy3F4GgycYgp7JqwEvQh+s54s5uiKzinVtE6O36sI/wL/wXD9cVZX5MJWIaJ0o/k2RHEyHpkrEl5bMt165p40Y8FNPmYva/I+HBLN7K1YrlrG9/dPFNSAXjs6gHGUvpHuCQXV8h0oPumwgYS28B/97zVYx1K7wadHTGe6DEK7k7NFAtBUsvHx8t6FHNkChPrszfyKtFN3fh24L9hI5AvDVc1sgQJS97o/tUJ1un+CTurOENpWqBJ0BNs+oEjXuD9l8TqTClk7Nhn1Kzux3Qw3fBqiHjGWpx62GkWIHwvYEsSzyIRJuv9YneMUGTLjQxa2EERt6Gqgak9eBvMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbAier5sO4najAcyVQCHgp25OuqyvD+L61SrJ4gMdW8=;
 b=BL3OlQqFnICy/Q7gPxxEgdVBp5Z8r+Y/fZsKJsS/pTCbarODQtkdFgsFDTPgXAjuqNTbs686bFTiWQs4w1M6B3Hb4upERtXnqhyLeSaOWM2Jiz3S2cLi0ckTzOPuWjhaVHfh7s9uoOgV7S2x+ysPHMmO46hRwBFhceJklfCER1u2KKdte0x51y/onxEsPDkr9+vi+3DvzSu9/AKWBm0ixNtbEb6N2Jdx2PkIO962mXWtCp/JA8wMYFwOELlDKpszxtkUttE+4fYydT025BndYc864ON6gCD5jYYUARXtX9//V9pmnknW1X0lyQdK+UTCHbMAKepvwI/5BfPbCETrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbAier5sO4najAcyVQCHgp25OuqyvD+L61SrJ4gMdW8=;
 b=B+Enrg4xbcqa258slgQdJVaGOPeHM3pXpfTa1XPYwWpVTeNgTpGXA4jE+KLx3eRF3fZ80SKZM6Qecc93+eRYSN0FElSf0kkf/ga2WoJNObP7bxFDsaaZ7Rl4Il4+a5pYN7zIdauaPWZ0FlfMPhPhmHr0fr7+fIFxAknspg3jszw=
Received: from SJ0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:a03:333::28)
 by DS2PR12MB9751.namprd12.prod.outlook.com (2603:10b6:8:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 11:07:01 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::61) by SJ0PR03CA0113.outlook.office365.com
 (2603:10b6:a03:333::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Fri,
 25 Jul 2025 11:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 11:07:01 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 06:06:56 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: Naveen rao <naveen.rao@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, "Xin Li (Intel)" <xin@zytor.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Babu Moger <babu.moger@amd.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH v2 1/3] x86/cpu/topology: Use initial APICID from XTOPOEXT on AMD/HYGON
Date: Fri, 25 Jul 2025 11:06:20 +0000
Message-ID: <20250725110622.59743-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725110622.59743-1-kprateek.nayak@amd.com>
References: <20250725110622.59743-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DS2PR12MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c0ed51-5635-480a-a98b-08ddcb6b617a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x14ekPSZZe14Qp9ODWN2nS11kiZ519ml1I8CqpTnX8QWKiRhPG5bloVJ4Vhk?=
 =?us-ascii?Q?Z2+/0ysKBnVa/Cdb8r9f/WH6iXI5WEFYCS3O36UIzavPoOJYDqMYmK2aYohf?=
 =?us-ascii?Q?v6C/e1MqmrRJzFw6a429Z9egA/+PFwupjCH6XUaLIP1ttrkjiyk87KhiEVJ8?=
 =?us-ascii?Q?7nk5Buzfc0zW2VotOMdRnOtXd70iNzRh2P+gavMx2br8FMNryUB44E7gg50+?=
 =?us-ascii?Q?0Lw3SEIYZoTqlFPCi9gAOKQ0zGkyzEDzJkNzUxz3xBzQFMh6CiFycOx3ysj5?=
 =?us-ascii?Q?Z8LJjTNZay6oYqwibgoX617RAyO0Sp61VFvUyRBNp89KGU4jp+OC3wb3MCsr?=
 =?us-ascii?Q?Rpuk7lGBX8DFgkfd0l3IC00jBAxIa0fdqv3nPOMrhvLgWJiTV52BuKdPrRfl?=
 =?us-ascii?Q?SU/HEbjZwDVn4SoMFE+duQWnq4d05YfWUdAlRwS+TnXUml7hoOQyC0qxPyNx?=
 =?us-ascii?Q?d6yW+PLfHW+PktkBxViuIYis9l9p0vFbWYT/+ESDeZKO5obFSQJL6RDhdddU?=
 =?us-ascii?Q?FsVWby26prxxIDfytkKthomkOLGU/6t/thFQUENeG7mHCN9cx5f848ba6tYJ?=
 =?us-ascii?Q?/ID1rea6ms76wX6XcHquLpozvxFUSidsn4Dd1hm9jMPgC/Sl0NXnp47gX8c0?=
 =?us-ascii?Q?I0dNkviUU0Lkj2hZ/uQ9TamCsrYHIFbgkEDWWsXQosS/UWp/kc6mA+quIhXR?=
 =?us-ascii?Q?l2LrNiwjefCzQcApy4jZ1/vHcwvLUg3K+RusoNhJyy2/IfHYr9/5OzEgtfDG?=
 =?us-ascii?Q?ZxXQhfV1TdzRcrh5+2rz1+dvTetkoLviYaHqzI+bcaqVa4U0QjWhEuACy1pl?=
 =?us-ascii?Q?r4zaRrjmWhYl5Hx7QvGKfsXwNFtvvqyJOXMBmHzx6ZZsf2sFLcPTnGFRf1VT?=
 =?us-ascii?Q?BoBRZk8gbHJigyjRNZusn2MOaVPLsnzlsOZRXI9VjfhsGflzc8XZdcffoccp?=
 =?us-ascii?Q?+WXZWQ4EGQ72mKmXJk7UeeT8Io1ItK06W4ODT1JWZDQvyEf+rha7NYvwwerk?=
 =?us-ascii?Q?6Br7lkrbv1mWcunF5SLsNMuRSin6TOw801ZJ0X8rVPZJv4obuNRh8NW8iJtZ?=
 =?us-ascii?Q?PBYqIqsHR5YLhRk6LkEhxF5fBRZUpQxUG+VPxT9myL4vSe7xHrnoqapcJLhb?=
 =?us-ascii?Q?34A6/I8PChp67RMlO4/QrDKL4hTLXx8k4av5LA4u3qqsyRlvSm53nZm2CaUJ?=
 =?us-ascii?Q?kxrUQJmL5PmZWynyJTcXI8TPL4tnsyy+f4C+pCenEYK4cj8BNkabnjE3GU5W?=
 =?us-ascii?Q?afkd+1jrc7HFnD0/9XwBgvA9ilRwvK0dJWj3ZLRCePpUycmPN5NF2I1Eofm7?=
 =?us-ascii?Q?R7K/ICPBdL+ky0FLUwy9ZIuym7jZc5ENpUX8DuDq92oUCQWTNiPr9LyXIclM?=
 =?us-ascii?Q?mxWcEXpm+WzCLUOZvQZuQntSkOJv9IpSkw0xEY7ftyyOtMcm8bOJPJZK03Uo?=
 =?us-ascii?Q?pJFknh5oyIPITxgdsoBXqrBt5eTktQ7jJqT2KxQxCIAZXKjjCfH7fxOTMbmD?=
 =?us-ascii?Q?dVj4GRCtu+ZgrPQXeLcmmLHTYCuNcj0EN8Rt8T7waMJnpyOHUGWGdj2gqQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:07:01.2974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c0ed51-5635-480a-a98b-08ddcb6b617a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9751

Prior to the topology parsing rewrite and the switchover to the new
parsing logic for AMD processors in commit c749ce393b8f ("x86/cpu: Use
common topology code for AMD"), the "initial_apicid" on these platforms
was:

- First initialized to the LocalApicId from CPUID leaf 0x1 EBX[31:24].

- Then overwritten by the ExtendedLocalApicId in CPUID leaf 0xb
  EDX[31:0] on processors that supported topoext.

With the new parsing flow introduced in commit f7fb3b2dd92c ("x86/cpu:
Provide an AMD/HYGON specific topology parser"), parse_8000_001e() now
unconditionally overwrites the "initial_apicid" already parsed during
cpu_parse_topology_ext().

Although this has not been a problem on baremetal platforms, on
virtualized AMD guests that feature more than 255 cores, QEMU 0's out
the CPUID leaf 0x8000001e on CPUs with "CoreID" > 255 to prevent
collision of these IDs in EBX[7:0] which can only represent a maximum of
255 cores [1].

This results in the following FW_BUG being logged when booting a guest
with more than 255 cores:

    [Firmware Bug]: CPU 512: APIC ID mismatch. CPUID: 0x0000 APIC: 0x0200

Rely on the APICID parsed during cpu_parse_topology_ext() from CPUID
leaf 0x80000026 or 0xb and only use the APICID from leaf 0x8000001e if
cpu_parse_topology_ext() failed (has_topoext is false).

On platforms that support the 0xb leaf (Zen2 or later, AMD guests on
QEMU) or the extended leaf 0x80000026 (Zen4 or later), the
"initial_apicid" is now set to the value parsed from EDX[31:0].

On older AMD/Hygon platforms that does not support the 0xb leaf but
supports the TOPOEXT extension (Fam 0x15, 0x16, 0x17[Zen1], and Hygon),
the current behavior is retained where "initial_apicid" is set using
the 0x8000001e leaf.

Link: https://github.com/qemu/qemu/commit/35ac5dfbcaa4b [1]
Debugged-by: Naveen N Rao (AMD) <naveen@kernel.org>
Debugged-by: Sairaj Kodilkar <sarunkod@amd.com>
Fixes: c749ce393b8f ("x86/cpu: Use common topology code for AMD")
Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog v1..v2:

o Collected tags from Naveen. (Thank you for testing!)

o Moved this patch up ahead since it restores the original behavior
  before the topology rewrite.
---
 arch/x86/kernel/cpu/topology_amd.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 843b1655ab45..a0e3e177fc35 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -81,20 +81,28 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_topoext)
 
 	cpuid_leaf(0x8000001e, &leaf);
 
-	tscan->c->topo.initial_apicid = leaf.ext_apic_id;
-
-	/*
-	 * If leaf 0xb is available, then the domain shifts are set
-	 * already and nothing to do here. Only valid for family >= 0x17.
-	 */
-	if (!has_topoext && tscan->c->x86 >= 0x17) {
+	if (!has_topoext) {
 		/*
-		 * Leaf 0x80000008 set the CORE domain shift already.
-		 * Update the SMT domain, but do not propagate it.
+		 * Prefer initial_apicid parsed from XTOPOLOGY leaf
+		 * 0x8000026 or 0xb if available. Otherwise prefer the
+		 * one from leaf 0x8000001e over 0x1.
 		 */
-		unsigned int nthreads = leaf.core_nthreads + 1;
+		tscan->c->topo.initial_apicid = leaf.ext_apic_id;
 
-		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
+		/*
+		 * If XTOPOLOGY leaf is available, then the domain shifts are set
+		 * already and nothing to do here. Only valid for family >= 0x17.
+		 */
+		if (tscan->c->x86 >= 0x17) {
+			/*
+			 * Leaf 0x80000008 set the CORE domain shift already.
+			 * Update the SMT domain, but do not propagate it.
+			 */
+			unsigned int nthreads = leaf.core_nthreads + 1;
+
+			topology_update_dom(tscan, TOPO_SMT_DOMAIN,
+					    get_count_order(nthreads), nthreads);
+		}
 	}
 
 	store_node(tscan, leaf.nnodes_per_socket + 1, leaf.node_id);
-- 
2.34.1


