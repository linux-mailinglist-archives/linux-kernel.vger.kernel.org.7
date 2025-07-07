Return-Path: <linux-kernel+bounces-720356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A197AFBAB3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA721AA2667
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865DE264604;
	Mon,  7 Jul 2025 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4FNez5Sn"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785022D790
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913216; cv=fail; b=IRX3CzEN3FHuOMSIp3H4wAqS/bz/lfksPgXsNqo167BbVW7dwYts47+FnGiYFYYyuXCFijh3PoNugmkgddLk4tM1PChXZc30LY776VtFcexw5E/eX6hZOGxDZMaMEmidun+XarFRVoEfGuEskz1PV88RmuIjXF7IwKhWV/S1Qqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913216; c=relaxed/simple;
	bh=vQ11HxzO9ULd3EAkw7QZ+T/3hQZlkQGTmOm30r0Lepk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eu0l4+2XiO4OkHbLiCkaxu5Zowf6roJAencanajWSDfIJFGtB8tOqRbcX8+59YHGaZmCaITd/jWvZ56M9oDC03N2cT9qM/HmvQO2Eqe8waZZ5dGs35DI0oUeYRdanfsZXPALTfOdK/TsAiuVEGDGkhBR4fJFXFhnW96EqOOH91Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4FNez5Sn; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhdsYdgU6Tq54oKTlZtUn3qgLlIQdNQB/tPdwIGSiYaCMO4zUml64entrLCvSITBQPms1eWc0Dp+E8M0iSR42P3fPktA3GDCBkoVjM7ABibGb/7HewphsRVKdWJj9Vz8S/pAfjvtpKRsFNu8+xo2CGJYPT8x/5crgrKgbn6zI6qaeygYVdUoj7R8EyRszBDIj8J4ZFDslZOIp9l2AtjXXj8VGsOql6NI7XWgfRaBotD+Vrz0Yq3QtKHDJVz1PWv/tyeOONpD8MDT9vZrfhqtztCpio+28xgl+qZu/dG0bRaogxkJzKlqX6aE1ph2ScqSTeFl6yayoeBKIdhzLKJSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHsoLCfWY4TitHEX+7gPncYL8XshduL2yoUQ1IUPUgY=;
 b=P5Z2TycW7xhqinBwojCG0x9sMSZQO7w6II6SGIYbJy55jkPsqwStFiXwdzrx8XSNEnj+aKF/1Pl47Pl0i8/YzCSE3JgY6joRC1dn0R/arwCuW9GiMBCHCvibVvEPvcygFv4+/ql2V34TUYY3N0YyGYZOS/xbQBMTgAj9UIrH5w2QKsKkLxbTIMi/IwSEFgGA+u8ZObNsXcj0SLwhhq7LXoIr1NztpLaovUcb+GxTeit6jZm2jYOUSxlH3ZT6PvL6dMsyJUg72EuT7JilGfpvZUiU+185wkAe/PUbdaIDJgYg0ngGfRbA4lO7F0XAck131u4yz6wSmOpwBU3n1bg7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHsoLCfWY4TitHEX+7gPncYL8XshduL2yoUQ1IUPUgY=;
 b=4FNez5SnSnn30e7koxrcKNyL8ltrK93kcWYzgMXbiKhF8Zja/G1yEywl8Q3fviSfyvdQezhgHDDjjI1Fk1yuiV83BV0pWyyuw2oR8shX7OdwM0bDParmf6fLN5+Zd71DsGxnZN6K4AZdlSzCJIMAavooCWJKxTavnFItox3PK6c=
Received: from BY5PR16CA0004.namprd16.prod.outlook.com (2603:10b6:a03:1a0::17)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 18:33:29 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::e4) by BY5PR16CA0004.outlook.office365.com
 (2603:10b6:a03:1a0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:28 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:27 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 00/21] Attack vector controls (part 2)
Date: Mon, 7 Jul 2025 13:32:55 -0500
Message-ID: <20250707183316.1349127-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: b788b6a8-f20a-4678-e7de-08ddbd84c4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ifIzGy/h0cJBGfvIe7w+g/G5821IwiksRGH+l0iYNwofY8RqRbOg1GmgLhvv?=
 =?us-ascii?Q?pSkWavXmdXU6PYEOCz+NFFdVxbebdzf9tmfEC9hFiu0lWtjbOLKifthmu/HG?=
 =?us-ascii?Q?MEz8Jia68GnwsUEYWP7Ibz4uMu4suoi6Kgwe8ahRb7391hHTzStVwn38k9Jj?=
 =?us-ascii?Q?wZpwQOy96Hcc7lRexFsYh9JptrfJeaiTejLoNXRSC5aN5lOAlqemid655LvJ?=
 =?us-ascii?Q?0EF87uVHMWJGo969yXZ+K9XhrRV3FTNn83EblO5OvE3+0yHf0r+v23DNYHel?=
 =?us-ascii?Q?w/xGRzZYafyiVMtS7gEMMhp173RJaRawepc2NjF4uHU8GpIMp1N1mg3MhVvQ?=
 =?us-ascii?Q?uF9Y0lxVxpWuAH/F0Z3LhaFEOo20LpfBUn5cXU5m4yT0zj95+ulE2ej+cGEK?=
 =?us-ascii?Q?IvX5uMg2UyiduIsqbvF0SPHpNP+vSaFKMcBRMtOjfU4b/skPj2EGDQMSCvtT?=
 =?us-ascii?Q?7SgTfZFheICFFTIROt8tgbT+Df73M+O6/7SrwKQ9QIZM38Q9Ted7PkUFR55s?=
 =?us-ascii?Q?bppHTuxtwoLs5Oeb9qpANXNLALuTQtVeoq+sTS1WJtvU0bI+PPSTzuXFinkh?=
 =?us-ascii?Q?L4EsVnjjGr3sGwGvrMlKMf46j138Y0v4bLc29VBFcGDJoWupxGKijE6/CIkl?=
 =?us-ascii?Q?1ymXEWKQVmYHiiDvx9tD0uG/8p3jVIcDlTzRmbjESvYXRDS40+voAV2RkE1m?=
 =?us-ascii?Q?/BbCgdB5aaUJLEcONeGOACe8ZhTpiLr5ThbEqadkT1oRN7gCQV1eTAVN8u30?=
 =?us-ascii?Q?Ykxt2kvLI9kKL0FLdzV2aSLfbK28j3W5luTK5BQnwis9blnKt1RRXHkKGMAe?=
 =?us-ascii?Q?6WYdV3IYL1oA6m4q//y+eoICSBv7Lcm4JprEgcg+Y1wvSQY/zgORVFJXL2KB?=
 =?us-ascii?Q?gjnHXhNw1z/C2GE1i7LJO2cnKmVvRTHtfK3nuFJUfdAUq2p9F15dmSs1UTp3?=
 =?us-ascii?Q?xkXDFfYKEo9yDjTKvCLoE8VJxhJivXkL7oJpn6ANc5MkXVfcnWjLEih92tiI?=
 =?us-ascii?Q?RDuqzh1LU/7ABpPkz3w7yNeoJnq/4eREvAgZqHQO45ZGUEtwbYhPfvlvjKb+?=
 =?us-ascii?Q?963M+RjaPfta5H5UUyCTi0r/Nv+9QZaOpn5J1lIcBMmk6zon/DRBo3KPSNUc?=
 =?us-ascii?Q?9c9rQdaM4r7vlx9ZG9D0ZgneqDZKc5h4sU+NAKPnmST6Lp7RpINcs2RYID7l?=
 =?us-ascii?Q?CGtBNCF/wVXwX3l+wb6DZhjGbp63bSG9hpYEi4SrXnFO6+a3KbJU+ebVIKsK?=
 =?us-ascii?Q?CD6UidEgvF1gYLq3HauCmpgVB6qykIA189iu6p1x1NRRSbaTIYTHpTRDFMwA?=
 =?us-ascii?Q?kXvSpUYt1zOELFA7k7Q+uzzgtMprasJiJAZwyq+INHfFosXhv9gI6tJ6ZMsG?=
 =?us-ascii?Q?e/0hQrQ5SoIoRrTLqXVKjnB7/4DctVgH3bAkf3PrjZxB9XpnxjYHHLxguIX0?=
 =?us-ascii?Q?RZb0FRkMOdk/9vVtWcWIBHohk2cRISIRF9dGQAbF21DxvODeRjw7rATW3roX?=
 =?us-ascii?Q?TtCvWpI29HlQulcxPXQnLc1fvDOnObd5j9awcoNBBYtN2w/P/JVtOqEcnw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:28.8743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b788b6a8-f20a-4678-e7de-08ddbd84c4b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316

This is an updated version of the second half of the attack vector
series which adds new attack vector command line options designed to make
it easier to control which CPU mitigations are enabled.

The first half of this series focused on bugs.c restructuring and was
merged on May 2.  Link:
https://lore.kernel.org/all/20250418161721.1855190-1-david.kaplan@amd.com/

Attack vector options are designed to make it easier to select appropriate
mitigations based on the usage of the system.  While many users may not be
intimately familiar with the details of these CPU vulnerabilities, they are
likely better able to understand the intended usage of their system.  As a
result, unneeded mitigations may be disabled, allowing users to recoup more
performance.  New documentation is included with recommendations on what to
consider when choosing which attack vectors to enable/disable.

In this series, attack vector options are chosen using the mitigations=
command line.  Attack vectors may be individually disabled such as
'mitigations=auto;no_user_kernel,no_user_user'.  The 'mitigations=off'
option is equivalent to disabling all attack vectors.  'mitigations=off'
therefore disables all mitigations, unless bug-specific command line
options are used to re-enable some.

Note that this patch series does not change any of the existing
mitigation defaults.

Changes in v6:
   - Added ITS attack vector support
   - Removed new BHI user->kernel only mitigation (can be added later if
     desired)

Changes in v5:
   - Updated table layout in documentation file
   - Minor clean up

David Kaplan (21):
  Documentation/x86: Document new attack vector controls
  cpu: Define attack vectors
  x86/Kconfig: Add arch attack vector support
  x86/bugs: Define attack vectors relevant for each bug
  x86/bugs: Add attack vector controls for MDS
  x86/bugs: Add attack vector controls for TAA
  x86/bugs: Add attack vector controls for MMIO
  x86/bugs: Add attack vector controls for RFDS
  x86/bugs: Add attack vector controls for SRBDS
  x86/bugs: Add attack vector controls for GDS
  x86/bugs: Add attack vector controls for spectre_v1
  x86/bugs: Add attack vector controls for retbleed
  x86/bugs: Add attack vector controls for spectre_v2_user
  x86/bugs: Add attack vector controls for BHI
  x86/bugs: Add attack vector controls for spectre_v2
  x86/bugs: Add attack vector controls for L1TF
  x86/bugs: Add attack vector controls for SRSO
  x86/bugs: Add attack vector controls for ITS
  x86/pti: Add attack vector controls for PTI
  x86/bugs: Print enabled attack vectors
  cpu: Show attack vectors in sysfs

 .../hw-vuln/attack_vector_controls.rst        | 237 +++++++++++++++
 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 .../admin-guide/kernel-parameters.txt         |   4 +
 arch/Kconfig                                  |   3 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/kernel/cpu/bugs.c                    | 269 ++++++++++++++----
 arch/x86/mm/pti.c                             |   4 +-
 drivers/base/cpu.c                            |  67 +++++
 include/linux/cpu.h                           |  21 ++
 kernel/cpu.c                                  | 130 ++++++++-
 10 files changed, 668 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst


base-commit: f339770f60d9c3312133cfe6a349476848d9b128
-- 
2.34.1


