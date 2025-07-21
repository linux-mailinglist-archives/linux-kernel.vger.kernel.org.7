Return-Path: <linux-kernel+bounces-739474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942A3B0C6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A290189028E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45772DEA79;
	Mon, 21 Jul 2025 14:45:14 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023090.outbound.protection.outlook.com [52.101.127.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB41DDA1E;
	Mon, 21 Jul 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109113; cv=fail; b=vFjCfgI+2reQEMZWODj6Y8ghC9pKiwAUGOTkwsHMe8jaF6WSRTBJRxbrAh+bPO1I0FAJ4KrZsT3ORUfWmynsVIf8ddOYrDx6JfZ+kyUrp9r9l9GxoF4yb+wOLRR605yC7FPPxiJw28K7b50I8xfUo5qZd4CXAYe6uq2xtbLH7Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109113; c=relaxed/simple;
	bh=Ao/c3vbTuWJXtbqJqc7R6t1adQdDFaZGNV4j0MuA7IU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IzfedYYkUbhzaZJRyLoWOkC+onDAGz62mIdEJuaViz4J5ECC4RHnotrdPMjbcdP3FUAqV3V+EMVqkEXU7g7F659QVkYwgAePvPKWi2iIPi8pS2Uu7IAuvW2iFMeA+vgxj754BaYszDm2RXxzjd2GLLgDdo0QgHPNed4mM1+OsrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4hn/B6Fw77ckPvpD9T2HvOWwcnEyMJxj2uF5pOM4S/K3KxWIWPpSU6Jthqc5Q5pZB4ywvgan73IYsvzSKx0gUWgttiVN1dhSUrOToVNSNL/Jyc+/l27NuPqMCr3Q1Fruw4DbNOdV+awhoWXCEiWlEzNIGiMWe/V/OIjd+jFvP6RKTYQL2O7Blt+g3EwhrsI258Sj6r8uxkezZ+kCMXyQEJIPy+Q9Y3PNm3MIfyyzYMIqJBynSHHDVDxZwGBGVC65bXyF3MYg1uSYSGDO2DFAgNKTD+1u6kk8rT3m1wWEMPCrNZ+EPVHNKI2RTJgiVaeQGj/74CigcVjGAQCkH+JtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOeGeG9dCRolwbRNBFsdgN/ES/tCnDAO5PA5JQjDX80=;
 b=O9udWlbtzX/aOV8GP4B9GeApJy9kDIf3y6E/CF7XfgwRvQ8DiZnU4FcODUrcgNSaJZqjpYYyqQ4ofVHupYZTpbMs5OkT21uPr9OfPr4TZF4a9eeOnDZv+EoKneqyzpDxM3EmBR78YakM5hgKTtZ3MJMnMT9dmAwwDNofVWOe59YmivtiMdVqDPBYmB8olLubVoRpCctX5Rdfq5XeCYVOWAys79yW7mdZ/tUKyHBDeIs/c4FK19NCn57aV1gZ/3FJ6DUm3D721nmsBSnk/1W3XE/0gjRr/DRXhpB34l/BjrG2kvaAACbwvUkM2eSBQgNOtuR+ZXN8GF91X8njqt4pew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) by KUXPR06MB8097.apcprd06.prod.outlook.com
 (2603:1096:d10:52::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 14:45:06 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:193:cafe::1c) by SI2PR01CA0048.outlook.office365.com
 (2603:1096:4:193::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 14:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 14:45:06 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 5C4F84115DE5;
	Mon, 21 Jul 2025 22:45:00 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: soc@lists.linux.dev,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	jassisinghbrar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	maz@kernel.org,
	sudeep.holla@arm.com,
	kajetan.puchalski@arm.com,
	eballetb@redhat.com,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH v11 0/9] arm64: Introduce CIX P1 (SKY1) SoC
Date: Mon, 21 Jul 2025 22:44:51 +0800
Message-Id: <20250721144500.302202-1-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|KUXPR06MB8097:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7c4b4595-9082-48e6-49a0-08ddc8652f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3KSR5aOIfqGEf2wqmaqAD41Sl6CfRsnS5iMTMtDd/AXLvUHk70SOeWUZAHPe?=
 =?us-ascii?Q?X27Ck0+MYlyuPGocI2keCy6Ys2xf293sgIyZ4W7oI26iaXoG0kKFnhY0EtvD?=
 =?us-ascii?Q?YrNvXvsrjhWKVe5cZKIOKkxLsNoV/Yz4Noz357HXebSpKX21EBseiD2f3Qf0?=
 =?us-ascii?Q?RKr72VMXKOQ1Qrv79H6+V8VI0IqH2dx0v9qj6cVBZFzOW9vOh91JMM2Ram2u?=
 =?us-ascii?Q?SlPdmF7IKWN4VNzQQDwONSQiI906b1jrFHOC0OjP3dPsAQVz6gwKcnTWcOjW?=
 =?us-ascii?Q?YWuJxRXz1an3K7nAOzLi8Npi9ngemacGXH/uyZXTTNIFYRfqJHzD3n7/A8bB?=
 =?us-ascii?Q?S1k8YAcXkDsk5Lat49vuz5xvkBN44/yhLc9OCy19YK2OLjLYThDL5U6cRxK9?=
 =?us-ascii?Q?hOJ2gsuQeRZAQhZobM3gglqYBxH7/ZlB0WixpE1DAUDe02Cn5gGvaaq4y/qY?=
 =?us-ascii?Q?grzP3hFzM00bDd1+qr1IRzsJCCvGkAdEK+OO52DDz0tradoXTdT1cbfnlOHx?=
 =?us-ascii?Q?0AqnzKk6R/tG+0qKSRYk4oZLBjiU8B52fred0R2jg54x2LWKKCt9nirnq4QM?=
 =?us-ascii?Q?OXIFARO9HNeK5vZHmNhv8lMCHwVbyWMzdRnmdlBf37xvFtw/Do7yV6yJv9O7?=
 =?us-ascii?Q?xRQ/0pJ1awK2k6mn9bVR2glROca9R/J9MOz/F/qQdnbPHSD1YU+w98pZeJJg?=
 =?us-ascii?Q?a8O8p+/PItoqlaoaKKtiEuipJzw05jwLrHcTUJNuY8ZR8Z3+xOhz064NwO2e?=
 =?us-ascii?Q?QyM5DbaCNRPLia7pKjd4IjXp3HdvWiwNRhZPs9EFCoEsYkhAUZrKw77lwuVl?=
 =?us-ascii?Q?tp9zSnsMG5yhVWl8WDNLe6LGTVQDsQuB+QOM2Q7Vb4O/5794L+OwIkz5BBnC?=
 =?us-ascii?Q?67zR5drgwraEW5iHmMkTPfm9YpRwuLZ1O4/lif2FEJ112ePoSsdB16eVwJjh?=
 =?us-ascii?Q?XPZ950qfWUHbgkJTGqNAlTrXkRnGxnuK+zo1IdjFJ2yYNtdFWnkEALjMp8RY?=
 =?us-ascii?Q?51AQ2HcPOyOQ25FVGKQGd0lndu1qU2php3WDu9HyLvnmvL/a+MPofxAAcNGh?=
 =?us-ascii?Q?Js1TYSOML7264OuKlpOJ2DYSiu0/qaEMkPiezgmB7J0weHuXy9NMlbxSYHk9?=
 =?us-ascii?Q?JQ3fjUaUvRfcGvHD0PdWK5KqBgxILXgxbj4LiRs4Mqudz/fhCq6OpEUKA/Tr?=
 =?us-ascii?Q?5Mq6HmN9z6HZJIu7OfF5mNbJ7A/2jNn13hr1XupGxriFnmjcmDJbGjP898vx?=
 =?us-ascii?Q?zEWRhGCnDz2/DGrDqcj0EpQG34IzHbHYBrcGrYJNJr4Knrc+U0GhufDgZLFz?=
 =?us-ascii?Q?MW2UfayZZVoAPbycvXJ/ZyaDFIgmH0MV6C563cF4evoruTWv+kx2GDguE3tH?=
 =?us-ascii?Q?vri2j55U0Pty59elY95e69ezjGo8V6RZhj6dwgLh7TVLndZVXfhkGH8xiLsp?=
 =?us-ascii?Q?2CLj4Ftr5v/50myMIGnVYIi8xYhtESVLpjt8iWXH3P7PI7zb8WMR5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 14:45:06.1982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4b4595-9082-48e6-49a0-08ddc8652f15
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8097

Cixtech P1 (internal name sky1) is high performance generic Armv9 SoC.
Orion O6 is the Arm V9 Motherboard built by Radxa. You could find brief
introduction for SoC and related boards at:
https://radxa.com/products/orion/o6#overview

Currently, to run upstream kernel at Orion O6 board, you need to
use BIOS released by Radxa, and add "clk_ignore_unused=1" at bootargs.
https://docs.radxa.com/en/orion/o6/bios/install-bios

In this series, we add initial SoC and board support for Kernel building.
Since mailbox is used for SCMI clock communication, mailbox driver is added
in this series for the minimum SoC support.

Patch 1-2: add dt-binding doc for CIX and its sky1 SoC
Patch 3: add Arm64 build support
Patch 4-5: add CIX mailbox driver which needs to support SCMI clock protocol.
Patch 6: add Arm64 defconfig support
Patch 7-8: add initial dts support for SoC and Orion O6 board
Patch 9: add MAINTAINERS entry

Currently, all patches have got Reviewed-by or Acked-by Tags.

Changes for v11:
- Add Krzysztof Kozlowski's Reviewed-by Tags for patch 8 and patch 9.
- Add Jassi Brar's Acked-by for patch 5.

Changes for v10:
- Patch 4:
	- update the description of the Sky1 SoC use case.
- Patch 5:
	- Move macro definitions above where they are used.
	- Prefix the macro definition name with CIX.
	- Update variable names and remove unused members.
	- Fix the misuse of the use_shmem flag.
	- Add some comments for use_shmem.
- Patch 8:
	- Address comments from Krzysztof about "shmem" node and delete two blank lines.

Changes for v9:
- Rebase to v6.16-rc1
- Patch 5: address comments from Jassi Brar
- Patch 9: Add CIX mailbox information at MAINTAINER file

Changes for v8:
- Patch 6: add Krzysztof Kozlowski's Reviewed-by tag
- Patch 7: add Krzysztof Kozlowski's Acked-by tag

Changes for v7:
- Patch 8:
	- Refine *_scmi_mem nodes for their properties ordering
	- Delete Krzysztof Kozlowski and Fugang Duan's tag due to substantial changes
	- Add two Tested-by tags from Enric Balletbo i Serra and Kajetan Puchalski
- Patch 4: Add Krzysztof Kozlowski's Reviewed-by tag
- Squash two patches as one for arm64 defconfig
- Rename clock binding file from sky1-clk.h to cix,sky1.h
- Some of my Sob are missing, add them

Changes for v6:
- Rebase to v6.15-rc2
- Add mailbox driver
- Add device tree description for uart, mailbox and scmi firmware (for clock).

Changes for v5:
- Patch 5: Delete pmu-spe node which need to refine, and add it in future
- Patch 6: Refine MAINTAINERS for all CIX SoC and adding code tree location

Changes for v4:
- Move add MAINTAINERS entry patch to the last, and add two dts files entry in it. 
- Add three Krzysztof Kozlowski's Reviewed-by Tags
- For sky1.dtsi, makes below changes:
	- Add ppi-partition entry for gic-v3 node, and let pmu-a520 and pmu-a720's interrupt entry
	get its handle
	- Remove gic-v3's #redistributor-regions and redistributor-stride properties
	- Change gic-v3's #interrupt-cells as 4, and change all interrupt specifiers accordingly
	- Remove "arm,no-tick-in-suspend" for timer due to global counter is at always-on power domain
	- Remove timer's clock frequency due to firmware has already set it

Changes for v3:
- Patch 1: Add Krzysztof Kozlowski's Acked-by Tag
- Patch 2: Add Krzysztof Kozlowski's Reviewed-by Tag
- Patch 6: Fix two dts coding sytle issues

Changes for v2:
- Pass dts build check with below commands:
make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=vendor-prefixes.yaml
make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=arm/cix.yaml
make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb
- Re-order the patch set, and move vendor-perfixes to the 1st patch.
- Patch 4: Ordered Kconfig config entry by alpha-numerically
- Patch 5: Corrects the Ack tag's name
- Patch 6: see below.
1) Corrects the SoF tag's name
2) Fix several coding sytle issues
3) move linux,cma node to dts file
4) delete memory node, memory size is passed by firmware
5) delete uart2 node which will be added in future patches
6) Improve for pmu and cpu node to stands for more specific cpu model
7) Improve the timer node and add hypervisor virtual timer irq

Fugang Duan (1):
  arm64: Kconfig: add ARCH_CIX for cix silicons

Gary Yang (1):
  dt-bindings: clock: cix: Add CIX sky1 scmi clock id

Guomin Chen (2):
  dt-bindings: mailbox: add cix,sky1-mbox
  mailbox: add CIX mailbox driver

Peter Chen (5):
  dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
  dt-bindings: arm: add CIX P1 (SKY1) SoC
  arm64: defconfig: Enable CIX SoC
  arm64: dts: cix: Add sky1 base dts initial support
  MAINTAINERS: Add CIX SoC maintainer entry

 .../devicetree/bindings/arm/cix.yaml          |  26 +
 .../bindings/mailbox/cix,sky1-mbox.yaml       |  77 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  13 +
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/cix/Makefile              |   2 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  39 ++
 arch/arm64/boot/dts/cix/sky1.dtsi             | 330 +++++++++
 arch/arm64/configs/defconfig                  |   2 +
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/cix-mailbox.c                 | 645 ++++++++++++++++++
 include/dt-bindings/clock/cix,sky1.h          | 279 ++++++++
 14 files changed, 1434 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cix.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/cix,sky1-mbox.yaml
 create mode 100644 arch/arm64/boot/dts/cix/Makefile
 create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
 create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi
 create mode 100644 drivers/mailbox/cix-mailbox.c
 create mode 100644 include/dt-bindings/clock/cix,sky1.h

-- 
2.25.1


