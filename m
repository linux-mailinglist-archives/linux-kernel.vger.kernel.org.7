Return-Path: <linux-kernel+bounces-878612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECD7C21192
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E29254EED78
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AE3655E3;
	Thu, 30 Oct 2025 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wgfUQW8z"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8033655C9;
	Thu, 30 Oct 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840424; cv=fail; b=aCNMV0e158pec6sixpn1QsxDmiDsrKn84bQZzDP1/asTVfuSktXXk9+pGuQqCszy3hLa8Kgn1dhF9v+hxO3+llJgpANMggjJ9u/t/+ERqflbsLCZJlN1mDaRZWUxA8Dg5D+6yukBpoIa5Hs34yS0aLKw690cnS4RmdBB7K3Q+Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840424; c=relaxed/simple;
	bh=xQqnwT5H8Yy4tIcKMfc+sASlMsF/U/ecP8hfPdqHj7c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QMZl2CYL15PmcxnXpo+qFwaIRILJF8H0sWbFtJSfqOen0KQmRAFKGR4zWWsPt2Mc8Fx0aWjrgZD01LnWbVXCmci7DU2bj+Myb06p1HTapOsZYUclzQcpBfjG5F+DX6SAenUKL8HpdWJnHFWWdtC/eol65EfrXeSt2sv3T4SDBoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wgfUQW8z; arc=fail smtp.client-ip=52.101.61.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMgzmtdtnwrp76o3X7Y/dfCk8JLNunrI8X2StSL8JSdfK9JH7oydTYU/vIca+Cemk7v1zqqiAy6NcX2mGK3KPsO9wD3JztOFCkv7dXebT1XtxiXZvMsJ5m5e5C2qcPdBOfxUXKdJF0cefWeNpXJCtQbYSY4uQGJJWKzPXPfY4IvPYaZ2QulO6Vzdf7BgK3Nh52cDq0zPETJTSBlBPAAW8OwbIPK3n+37F+GQvcKLpfrW8hcSU6YOkHjDEExhroWljn42w0E5OJ4BFriVAgqwT0KZFMVxQOYEFlNFV6OmSUGMUHTKscmRhZuBImctxAH+866zft6qcOh2TntwHsd23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fImnJXnd+aq9kdkTaX6MxcmC//Lc50OFEOQjsoxvMFc=;
 b=hMs+xbRAHwS4pDAaPXdYttKmYbxkiI9F99ThYp13fnEtUSufnrHzCrjU81IPZ/FwqrNNtnqkYoUmFwpVFqoMwOfK79gucXy8sWO2aPYNQ/CAzQKKqvweuTl2SWnjRDIucvZ8cN7II3Vjn0cGJxEqYl0huxejVHsjhA5z9XOWQduaIXf0w9tr6SaamJma9iy/qEw6uJGh9olrbn84ZzhXkd9SBeotapGYeuB7p61bZngqBUt1rm9cf/85ZNZZhRlwTHBBQrkc2HAUTlThjWBbVqLmUmeoC7WeOesklJBfQVC9rXsfgTEmfKUa/pkbWY3GyiJLcCxFP+Cc7p3VLh3oyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fImnJXnd+aq9kdkTaX6MxcmC//Lc50OFEOQjsoxvMFc=;
 b=wgfUQW8zJFzv+MwgbOQip/q47W5yUsDiFCMcNCloXhYkH+vfRInD8l0pP+YeWVGf7ivX1gHAIFA5iwT5lhpD766hWNYAssX+jjb43Q0TkD4Vok+bE7dUzR1/XpFP8jAEgkSLVE1BzsdbLagl+yR+vTIfDOgWShWjWNO1HGHCt0Y=
Received: from SJ0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:a03:331::32)
 by SJ5PPF7BC0D55AF.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 16:06:58 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::3a) by SJ0PR03CA0087.outlook.office365.com
 (2603:10b6:a03:331::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 16:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 16:06:53 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 11:06:41 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 11:06:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 11:06:41 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UG6aYY2428176;
	Thu, 30 Oct 2025 11:06:37 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
	<hiago.franco@toradex.com>, <francesco.dolcini@toradex.com>,
	<b-padhi@ti.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: dts: ti: k3-{j7/am6}*-ti-ipc-firmware: Limit FIFOs to Linux use
Date: Thu, 30 Oct 2025 21:36:35 +0530
Message-ID: <20251030160635.1388401-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SJ5PPF7BC0D55AF:EE_
X-MS-Office365-Filtering-Correlation-Id: 657cdb2b-1dd4-4195-9bf7-08de17ce57d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|34020700016|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UZJ6dqKQ+eV8wkTsWyilpfYTVagNInvzw1QnTdHhiJdftEYmt1ac3DRWQI74?=
 =?us-ascii?Q?MpRPwJRwv82WKhZWkhTrApuAPXVV6UcXM6kXl9oXUivCitgP+KrfsXTCxXUi?=
 =?us-ascii?Q?Z59cIV5R85YpcSfIOoj5MWoqS1/Q/BStvKwlrNvQ2sw3upuo8sTA4SYR/4Io?=
 =?us-ascii?Q?+/LKGJtyMaaAjAE4yyZzEhmGkh9bfN+8iIy3031waKNQFCjjxo1tTcUaGuZ/?=
 =?us-ascii?Q?Cgy9rIX3aB+gHIOnvgiB+k1QH1ZqdIttRKLKY/e7miwuZe+k5MldbkEHmt8e?=
 =?us-ascii?Q?IebFW8EoNILmF2YbkJ4CGzx0AEH7gnQdawE0DsUWgtY2stts51KzZKFzuaOZ?=
 =?us-ascii?Q?5j6/Jf7ni51JXH4UH2sKDvzJmp4gRIwIU/XgXmf7w9WFl3rMoqHOdAWEtOAN?=
 =?us-ascii?Q?AixgcpojPbdrmpAufxOE81D5Brvuz7RjDVsBApQDXe6n5PCZmoPxIe+LDZsy?=
 =?us-ascii?Q?3IBqvagF0OOTdJN2BTAkLpa3By2h2Uhhl/+YYptp3pMIoIqCw7FNY424djec?=
 =?us-ascii?Q?4VTu+9ULgZpgqnIgQiMryZci5caGbd+eEh243W7qVBNmnN5k/jEi/JqDwHM9?=
 =?us-ascii?Q?e+c72iA+1AbBBeGPvvd+bUBvwN+sRjsKAWiNvTEONNK/YWefLVIMYjCzDvYh?=
 =?us-ascii?Q?+Hl4a/IUbJxW09d9X/m2fImOErT3I0MN/k8i8RLbUJg/MeRmdVaI2j7P1Nm3?=
 =?us-ascii?Q?GJvDviCObzjT2eJ5BAo4GI4wbGPFGygN31m3i89PNMDPQNuoK6CVqAarizoR?=
 =?us-ascii?Q?w1NFWcjhSAWI356PHM5w1NjntRCFbSCvslS5VVd7QQBtMYbd+oWZCD038Hn+?=
 =?us-ascii?Q?Dw0T0jwco91ynzn1WzhKKIbF9fkBEF8OxrC2gH2/3Xx6xBZLffkFpX7LlsbL?=
 =?us-ascii?Q?FwswR4MMk3bWUJ7v3GKtfb2bSlwlE9YulJv0Se7uCa0BrZ88rr4/ZTm4mVyE?=
 =?us-ascii?Q?Dt/FzdxwsPb48FOg5LQ+mj5VQcRC/yP6BO48SXaUpuHFv4IdGvJkMJFJc3Hb?=
 =?us-ascii?Q?NudZUGB2asSqCnzqL5SpxMdf0VM6Bra+fFhN3H1OA7bGhyWMTPb3AMb73XLC?=
 =?us-ascii?Q?/v29AT+Ma2avGFTfQR5eqWDOUOrh3mCD86u7+aFVOyrK3RcMkkG3XH8P8eY2?=
 =?us-ascii?Q?bRGvSqc1M3IX/jmAqJAgGMB+YP6idA9HwLvifd+7HKkWY84LwKZCTNxiCcxQ?=
 =?us-ascii?Q?dLMXdhzlxKvTASaC5YmgG9SJ4/G6Kgz1lL4dUEvbw5j7vnU2zX/g2r5cdqg7?=
 =?us-ascii?Q?JDBVEKsxnZlSJToeFRBaGFJ6SMs2BnlAI6gKEqwxPxpi5i9K4CAUHZXN014i?=
 =?us-ascii?Q?8ylUB6KsYQU3KiVwNgen6PiXIH+8MYqtAwISy/wi/wEByOKIF1iOXMy2HY8j?=
 =?us-ascii?Q?3/NA8FiNUnBYEUmrCeBmwv8cd2wczn2ymeWZT68flLRGq/kkGL+vVA+G9Iub?=
 =?us-ascii?Q?p3CKS0p6+XQrxWC5AtSbMQ0jlG5Mq52KC3kUGiZZEkBrZNHoOgp/qqu7hxom?=
 =?us-ascii?Q?Ne5ZQW3HFo4/6wEwDDxeERJM0mn5+FdsTK4kSelCILeqpMvCIX2mDgd+NIJI?=
 =?us-ascii?Q?UQjfihBfN6Kd2nPfD34=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(34020700016)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:06:53.6624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 657cdb2b-1dd4-4195-9bf7-08de17ce57d2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7BC0D55AF

Each mailbox cluster has 16 hardware FIFOs shared among 4 users (CPUs).
Each FIFO supports one-way communication between two users and is
configured by the firmware.

For TI IPC firmware, the FIFOs starting from 0 are assigned for
communication between the Cortex A-core (running Linux) and remote
processors (running RTOS). The remaining FIFOs are used for
RTOS-to-RTOS communication.

In some cases, pending messages may remain in the RTOS-to-RTOS FIFOs if
a remote processor is powered off or in a bad state. To avoid issues
such as suspend failures, restrict the 'ti,mbox-num-fifos' property in
the device tree to only include the FIFOs used for Linux-to-RTOS
communication. This ensures the Linux mailbox driver checks only its
own FIFOs and does not interfere with those used by other remote
processors.

Fixes: a49f991e740f ("arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware")
Closes: https://lore.kernel.org/all/sid7gtg5vay5qgicsl6smnzwg5mnneoa35cempt5ddwjvedaio@hzsgcx6oo74l/
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Please help in testing the patch on Toradex platforms.

Testing Done:
1. Tested Boot across all TI K3 EVM/SK boards.
2. Tested IPC on all TI K3 J7* EVM/SK boards (& AM62x SK).
3. Tested that the patch generates no new warnings/errors.

 arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi         | 1 +
 arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi        | 3 +++
 arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi        | 2 ++
 arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi         | 3 +++
 arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi         | 2 ++
 arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi        | 2 ++
 arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi        | 5 +++++
 arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi       | 4 ++++
 arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi        | 4 ++++
 .../dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi     | 6 ++++++
 arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi       | 1 +
 11 files changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
index ea69fab9b52b..913bd5ff49f7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
@@ -21,6 +21,7 @@ mcu_m4fss_memory_region: memory@9cc00000 {
 
 &mailbox0_cluster0 {
 	status = "okay";
+	ti,mbox-num-fifos = <4>;
 
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
index 950f4f37d477..b377edb52bc9 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
@@ -33,6 +33,7 @@ mcu_r5fss0_core0_memory_region: memory@9b900000 {
 
 &mailbox0_cluster0 {
 	status = "okay";
+	ti,mbox-num-fifos = <2>;
 
 	mbox_r5_0: mbox-r5-0 {
 		ti,mbox-rx = <0 0 0>;
@@ -42,6 +43,7 @@ mbox_r5_0: mbox-r5-0 {
 
 &mailbox0_cluster1 {
 	status = "okay";
+	ti,mbox-num-fifos = <2>;
 
 	mbox_c7x_0: mbox-c7x-0 {
 		ti,mbox-rx = <0 0 0>;
@@ -51,6 +53,7 @@ mbox_c7x_0: mbox-c7x-0 {
 
 &mailbox0_cluster2 {
 	status = "okay";
+	ti,mbox-num-fifos = <2>;
 
 	mbox_mcu_r5_0: mbox-mcu-r5-0 {
 		ti,mbox-rx = <0 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
index d29a5dbe13ef..82512e7a44ea 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
@@ -21,6 +21,7 @@ mcu_r5fss0_core0_memory_region: memory@9b900000 {
 
 &mailbox0_cluster0 {
 	status = "okay";
+	ti,mbox-num-fifos = <2>;
 
 	mbox_r5_0: mbox-r5-0 {
 		ti,mbox-rx = <0 0 0>;
@@ -30,6 +31,7 @@ mbox_r5_0: mbox-r5-0 {
 
 &mailbox0_cluster1 {
 	status = "okay";
+	ti,mbox-num-fifos = <2>;
 
 	mbox_mcu_r5_0: mbox-mcu-r5-0 {
 		ti,mbox-rx = <0 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
index 6b10646ae64a..793e965c5a4b 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
@@ -63,6 +63,7 @@ rtos_ipc_memory_region: memory@a5000000 {
 
 &mailbox0_cluster2 {
 	status = "okay";
+	ti,mbox-num-fifos = <4>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
 		ti,mbox-rx = <0 0 2>;
@@ -77,6 +78,7 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
 
 &mailbox0_cluster4 {
 	status = "okay";
+	ti,mbox-num-fifos = <4>;
 
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
 		ti,mbox-rx = <0 0 2>;
@@ -91,6 +93,7 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
 
 &mailbox0_cluster6 {
 	status = "okay";
+	ti,mbox-num-fifos = <2>;
 
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 2>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
index 61ab0357fc0d..579533df6bd4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
@@ -28,6 +28,7 @@ rtos_ipc_memory_region: memory@a2000000 {
 &mailbox0_cluster0 {
 	status = "okay";
 	interrupts = <436>;
+	ti,mbox-num-fifos = <2>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 		ti,mbox-tx = <1 0 0>;
@@ -38,6 +39,7 @@ mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 &mailbox0_cluster1 {
 	status = "okay";
 	interrupts = <432>;
+	ti,mbox-num-fifos = <2>;
 
 	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 		ti,mbox-tx = <1 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
index 9477f1efbbc6..4245a5319085 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
@@ -52,6 +52,7 @@ rtos_ipc_memory_region: memory@a4000000 {
 &mailbox0_cluster0 {
 	status = "okay";
 	interrupts = <436>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -67,6 +68,7 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 &mailbox0_cluster1 {
 	status = "okay";
 	interrupts = <432>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
index 40c6cc99c405..4003f125dbe7 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
@@ -114,6 +114,7 @@ rtos_ipc_memory_region: memory@aa000000 {
 &mailbox0_cluster0 {
 	status = "okay";
 	interrupts = <436>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -129,6 +130,7 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 &mailbox0_cluster1 {
 	status = "okay";
 	interrupts = <432>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -144,6 +146,7 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
 &mailbox0_cluster2 {
 	status = "okay";
 	interrupts = <428>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -159,6 +162,7 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
 &mailbox0_cluster3 {
 	status = "okay";
 	interrupts = <424>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_c66_0: mbox-c66-0 {
 		ti,mbox-rx = <0 0 0>;
@@ -174,6 +178,7 @@ mbox_c66_1: mbox-c66-1 {
 &mailbox0_cluster4 {
 	status = "okay";
 	interrupts = <420>;
+	ti,mbox-num-fifos = <2>;
 
 	mbox_c71_0: mbox-c71-0 {
 		ti,mbox-rx = <0 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
index ebab0cc580bb..2ef5c95f6e93 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
@@ -100,6 +100,7 @@ rtos_ipc_memory_region: memory@a8000000 {
 &mailbox0_cluster0 {
 	status = "okay";
 	interrupts = <436>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -115,6 +116,7 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 &mailbox0_cluster1 {
 	status = "okay";
 	interrupts = <432>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -130,6 +132,7 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
 &mailbox0_cluster2 {
 	status = "okay";
 	interrupts = <428>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -145,6 +148,7 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
 &mailbox0_cluster4 {
 	status = "okay";
 	interrupts = <420>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_c71_0: mbox-c71-0 {
 		ti,mbox-rx = <0 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
index cb7cd385a165..c25dec00cc2a 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
@@ -63,6 +63,7 @@ rtos_ipc_memory_region: memory@a5000000 {
 
 &mailbox0_cluster0 {
 	status = "okay";
+	ti,mbox-num-fifos = <2>;
 
 	mbox_wkup_r5_0: mbox-wkup-r5-0 {
 		ti,mbox-rx = <0 0 0>;
@@ -72,6 +73,7 @@ mbox_wkup_r5_0: mbox-wkup-r5-0 {
 
 &mailbox0_cluster1 {
 	status = "okay";
+	ti,mbox-num-fifos = <2>;
 
 	mbox_mcu_r5_0: mbox-mcu-r5-0 {
 		ti,mbox-rx = <0 0 0>;
@@ -81,6 +83,7 @@ mbox_mcu_r5_0: mbox-mcu-r5-0 {
 
 &mailbox0_cluster2 {
 	status = "okay";
+	ti,mbox-num-fifos = <2>;
 
 	mbox_c7x_0: mbox-c7x-0 {
 		ti,mbox-rx = <0 0 0>;
@@ -90,6 +93,7 @@ mbox_c7x_0: mbox-c7x-0 {
 
 &mailbox0_cluster3 {
 	status = "okay";
+	ti,mbox-num-fifos = <4>;
 
 	mbox_main_r5_0: mbox-main-r5-0 {
 		ti,mbox-rx = <0 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
index 455397227d4a..809ecf26ddd1 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
@@ -130,6 +130,7 @@ c71_2_memory_region: memory@aa100000 {
 &mailbox0_cluster0 {
 	status = "okay";
 	interrupts = <436>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -145,6 +146,7 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 &mailbox0_cluster1 {
 	status = "okay";
 	interrupts = <432>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -160,6 +162,7 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
 &mailbox0_cluster2 {
 	status = "okay";
 	interrupts = <428>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -175,6 +178,7 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
 &mailbox0_cluster3 {
 	status = "okay";
 	interrupts = <424>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_main_r5fss2_core0: mbox-main-r5fss2-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -190,6 +194,7 @@ mbox_main_r5fss2_core1: mbox-main-r5fss2-core1 {
 &mailbox0_cluster4 {
 	status = "okay";
 	interrupts = <420>;
+	ti,mbox-num-fifos = <4>;
 
 	mbox_c71_0: mbox-c71-0 {
 		ti,mbox-rx = <0 0 0>;
@@ -205,6 +210,7 @@ mbox_c71_1: mbox-c71-1 {
 &mailbox0_cluster5 {
 	status = "okay";
 	interrupts = <416>;
+	ti,mbox-num-fifos = <2>;
 
 	mbox_c71_2: mbox-c71-2 {
 		ti,mbox-rx = <0 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi
index 81b508b9b05e..67af04b25fd0 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi
@@ -20,6 +20,7 @@ c71_3_memory_region: memory@ab100000 {
 };
 
 &mailbox0_cluster5 {
+	ti,mbox-num-fifos = <4>;
 
 	mbox_c71_3: mbox-c71-3 {
 		ti,mbox-rx = <2 0 0>;
-- 
2.34.1


