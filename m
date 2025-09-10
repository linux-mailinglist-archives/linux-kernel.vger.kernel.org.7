Return-Path: <linux-kernel+bounces-810349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B67B5191B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA3C468122
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4913176FD;
	Wed, 10 Sep 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="eAGTu+IV"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2133.outbound.protection.outlook.com [40.107.104.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED821882F;
	Wed, 10 Sep 2025 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513874; cv=fail; b=n81I/4G0DE35B07JooEmOrOJ2deqSnuAdQVgDekwPPsyvP6dyccGeMoQlXCbsrJ8c0K7q6rCFufsvsXyDqOtDR99nBmRp3A9GvSLzSvrzwiP5b3tzjwTtSMpe5VEn5VHQjSDmKjsMk5+dGLcvx4uEUBYS8D1lTrAPMNV9fDUdu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513874; c=relaxed/simple;
	bh=vpbNxvrna0VmqhC53QRdcCS1/fA5ZUfUpBrhQ/Wx8mg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kMho7bRSh7YPjkj7DkVhElgmgIx8usIUwD+pBHH7+3oFox6GzbwjkJhRLEWuNYnmlbj3rKQmS6XEoNrNZfaAMm7HgcZvmuOapy9T0ihnd0iXSdmA1LNvZ/Pw2nmaQDydS4ETXiw+GeUjrQNL4AE0OFOW8VPMut72DhHe+iNT8u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=eAGTu+IV; arc=fail smtp.client-ip=40.107.104.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4opJ+80BGni2v3u5yhi1QibVGFyLI8aLd3H6t80qvRP3L3mZjfymlqFW5koffp5UKDm47ARKvjwDnXv97hgkBVkOimQeJJOv+3yXbzfAAw9NchmE1coLO3A3RaZJym74dr7FECaafVs93GPEq4BLQf5GEA/7AJc11E/YRAJSzcuAbuOkaONAbH0PtnQeNAXZ4cjv2BAdYtYuelNjBilmMnV90Q7Ly9PRTjD1YwfdhQtH92k3zzbXnIFgviKiuXLi43X1Wjn9VNMM5hWz1iCQi3gEs0m0dX6j6Xkx71RwO7CQjz2G2rPU+QtKje4BdCgyjuaNeuLnMXBueKSy6Nxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KU9gK3mTWp1pZHcLJ3BVwowKDWt5/NhskPgbnvuqkM=;
 b=WrhOcNxbvYgKHkNVcI2XPJSA5/893xdF5qpqzrK6YojpRNdYs5qhlRl1+X+NT90sZH3BkSiVADCNCaj9+ABOkypuTSrqoZUj/BrewLquj3sLncv1nIk9i7xDIn3xbtOeycdQf83Zor2GU6cfiHeoBnLxPRdoJXS6hrDyf+JdOIM5O6mGx4qVjLHzXUaDfX416i3M296Z5v8EeB1VEC2jt/K3Vm/rR5JCS3bTMFLi9yh9RQa+VtvovIdn/xJhzvBxLE9t8rtBpavuk0+gDUbVzPAgrYVh3TDob+TfFBQutttuGxzC5R8ehPc6p/dgy9CSQJfOHrZnQSkaEKDqTATBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KU9gK3mTWp1pZHcLJ3BVwowKDWt5/NhskPgbnvuqkM=;
 b=eAGTu+IVm8AXWWTPMpSK9DxAjsrFu4C9Fpx1dnOVitMb1mNWLfg25ZBAQBAvdtZ1dQ1Y9ut2Ef+B/MwVJPk4eafSwifSdu5ISA8anB3uRZm+kR0m+t5R9G9QgldvMZFsBDKiQ34pJzaW79LIEDHk53ik0gkwBTGkWtwRpyGXJ0bjbKKTzN/UcbasFzJwoQhfpSYqgYWdw4xYoXbnL//LeJTue7OqwttIOUdEb5qcddUWd2mb91Sn6zjZbWzMaNhPfMD9ah8Or/3Er3jpuYpB8T+oty3cCIKqelLxnPdePDwefNw8Xsx/FSOGb47wyD/pk7JfzaOOfW81acnaBz/j4A==
Received: from CWLP265CA0453.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b7::22)
 by DB9P195MB1306.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:29c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:17:42 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:400:1b7:cafe::9d) by CWLP265CA0453.outlook.office365.com
 (2603:10a6:400:1b7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 14:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 14:17:40 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Wed, 10 Sep
 2025 16:17:40 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Wed, 10 Sep
 2025 16:17:40 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2] arm64: dts: ti: k3-am642-phyboard-electra: Add PEB-C-010 Overlay
Date: Wed, 10 Sep 2025 16:17:16 +0200
Message-ID: <20250910141716.2133707-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|DB9P195MB1306:EE_
X-MS-Office365-Filtering-Correlation-Id: 974a3d2d-2b56-4426-04de-08ddf074cd73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4uyUtmn70HY46d/pEmDZ5bl/9kimeDxnInxSQc/0e6IJLNNnGeOWUewD3pDO?=
 =?us-ascii?Q?uTyDK8q1mU04Rb5AsxrvAK/cGgfAAakbSj4NwOwP5rT3dOkyZx6+VqjH3wDF?=
 =?us-ascii?Q?JCwiBBYJryXK7Z6g53CU3t/2QxvOLI/Wp9dwFFI6elfQaAb7IsVxDXeFNd0T?=
 =?us-ascii?Q?rfqv6a2eFPBI3qcdCi0QdxsaRSvetBqOYffw0zeCii290yMYq+vaIWshpGRR?=
 =?us-ascii?Q?fyKPdJMok0AP7viBxwXsky0Avpx3BSh9C8FlZGdY7G8Z26Qd2iahpvxybZ0n?=
 =?us-ascii?Q?yPsFMdNszOFMBvamnK0PeUMGDIgtrIjaU+czjB3UqoeCijTIMxCgqL5fm0OM?=
 =?us-ascii?Q?j38E8HS4W0phUkS2ifNtDYhW1G77tR4QKEXskfG59Rj/ddZnWlR+JYTwtbxg?=
 =?us-ascii?Q?JG2ZWu9Ec8lZNN7wTDQUVBrCvX4ZFTegXNoeOjMd0KtHz+87iqJlpB7TJ5d7?=
 =?us-ascii?Q?+Cdz4RyozHc+eUW6facBzjkJH4rKxM6L7dwE3mcNR0wARUgY4LTmPOu1t0qK?=
 =?us-ascii?Q?pW3lDcoBzyY7e2uzir//+rcBwmMTZyucEV0d0nXCBJgS3fFqYd/BvoSr43MU?=
 =?us-ascii?Q?1neOGxEBoW6mZusEv7RRlBspHEaV0atRphpyuCdAqhqQsBWzrfuvZWPWSI5j?=
 =?us-ascii?Q?0NbxPufAPpybkWDKGoARTS2dgmjKK3wR81JdsqVWz9s0juIHY1G/z+QqzoO3?=
 =?us-ascii?Q?qC/am7BAKNLlUy0s8iTRoFbOviyo5BV9hL54ErC3BYkKcBLlMktrHonG/zv7?=
 =?us-ascii?Q?BiiPznp8ibdj7fR6/fRB9u4v30czr2sW30d8RdEHMLhUCOLIwNJABhpgwTF3?=
 =?us-ascii?Q?1vQAa+AAmFaJfmX2WFM3soHROhDqK4OJnG/cOLx2GBTm8x+ol6XjkYBTZnAS?=
 =?us-ascii?Q?ettiF0eJgTj/AErqaNW5i5w0FW31FtPAIDjEajsVfE/YbVAxmE0HI7JFqir1?=
 =?us-ascii?Q?AfQVSOBXnghk3Xaj1tOPd0jYjZHFE8A0/A3mgPcs+JavRLzclhBWa3fbc6PY?=
 =?us-ascii?Q?p0d+4BAm04k+4E5kCLyCa89QF67KVw6rBgfkdlKTu1dfg/VGwlQplSn7eRIO?=
 =?us-ascii?Q?n0clQb8FdURJ/M6i6I1g1DC5rfoW/5Jp+kOEtfbNZ8CIC9wgzKceDI5k6xNx?=
 =?us-ascii?Q?ZVWVnLzjBW96pzS1UXvNUeJmWWt6I5kVyRL/r+rWwckQ2ySSALyYxCeP3by8?=
 =?us-ascii?Q?BtUdwzLMawB/abO2KjZm0GHYjEvQtEVXlg+A7lOQVaxu3p6XXKF7p7P1UPrN?=
 =?us-ascii?Q?nHFyThG7MHFR73unTbULHjzRgATDhEbl7SnwT4xopVPCmCswVfy1uyxUZWvK?=
 =?us-ascii?Q?GFJstbbVI0/oZMkAQcECC87YOOY1uQw4cyfOWriHC70TxT9Vb0p7UrbOSfEb?=
 =?us-ascii?Q?b1h3FXgb22p4ioVLZNdLplZETcGCxAw11H44ct2Qo1QFcbRfRiHErFZP1LUR?=
 =?us-ascii?Q?rP7nG542nPfo7srecJqpSXdpOhDZ+Nddiuuqthz2cJshkAOu6YnBtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:17:40.9811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 974a3d2d-2b56-4426-04de-08ddf074cd73
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1306

From: Garrett Giordano <ggiordano@phytec.com>

The PEB-C-010 expansion board adds two extra 1Gbps ethernet ports to
the phyBOARD-Electra-AM64x.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v1: https://lore.kernel.org/lkml/20250113184926.2209094-1-ggiordano@phytec.com/T/
v2:
  - Pick up from where Garrett left off
  - Update aliases to not use node references
  - Update pinctrl nodes name to match dtschema, *-default-pins
---
 arch/arm64/boot/dts/ti/Makefile               |   3 +
 .../k3-am642-phyboard-electra-peb-c-010.dtso  | 158 ++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-peb-c-010.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index aad9177930e6..98e10b2b0475 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -69,6 +69,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-gpio-fan.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-pcie-usb2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-x27-gpio1-spi1-uart3.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-peb-c-010.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
@@ -206,6 +207,8 @@ k3-am642-phyboard-electra-pcie-usb2-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-pcie-usb2.dtbo
 k3-am642-phyboard-electra-x27-gpio1-spi1-uart3-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-x27-gpio1-spi1-uart3.dtbo
+k3-am642-phyboard-electra-peb-c-010-dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-peb-c-010.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-peb-c-010.dtso b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-peb-c-010.dtso
new file mode 100644
index 000000000000..7fc73cfacadb
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-peb-c-010.dtso
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC America LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/net/ti-dp83869.h>
+#include "k3-pinctrl.h"
+
+&{/} {
+	aliases {
+		ethernet3 = "/icssg1-ethernet/ethernet-ports/port@0";
+		ethernet4 = "/icssg1-ethernet/ethernet-ports/port@1";
+	};
+
+	icssg1-ethernet {
+		compatible = "ti,am642-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&icssg1_rgmii1_pins_default>, <&icssg1_rgmii2_pins_default>;
+
+		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
+				<&main_pktdma 0xc201 15>, /* egress slice 0 */
+				<&main_pktdma 0xc202 15>, /* egress slice 0 */
+				<&main_pktdma 0xc203 15>, /* egress slice 0 */
+				<&main_pktdma 0xc204 15>, /* egress slice 1 */
+				<&main_pktdma 0xc205 15>, /* egress slice 1 */
+				<&main_pktdma 0xc206 15>, /* egress slice 1 */
+				<&main_pktdma 0xc207 15>, /* egress slice 1 */
+				<&main_pktdma 0x4200 15>, /* ingress slice 0 */
+				<&main_pktdma 0x4201 15>, /* ingress slice 1 */
+				<&main_pktdma 0x4202 0>, /* mgmnt rsp slice 0 */
+				<&main_pktdma 0x4203 0>; /* mgmnt rsp slice 1 */
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+					"tx1-0", "tx1-1", "tx1-2", "tx1-3",
+					"rx0", "rx1",
+					"rxmgm0", "rxmgm1";
+
+		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
+
+		interrupt-parent = <&icssg1_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+		sram = <&oc_sram>;
+
+		ti,iep = <&icssg1_iep0>, <&icssg1_iep1>;
+		ti,mii-g-rt = <&icssg1_mii_g_rt>;
+		ti,mii-rt = <&icssg1_mii_rt>;
+		ti,pa-stats = <&icssg1_pa_stats>;
+		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
+		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
+				      <2>,
+				      <2>,
+				      <2>,	/* MII mode */
+				      <2>,
+				      <2>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			icssg1_emac0: port@0 {
+				reg = <0>;
+				phy-handle = <&icssg1_phy1>;
+				phy-mode = "rgmii-id";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				ti,syscon-rgmii-delay = <&main_conf 0x4110>;
+			};
+
+			icssg1_emac1: port@1 {
+				reg = <1>;
+				phy-handle = <&icssg1_phy2>;
+				phy-mode = "rgmii-id";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				ti,syscon-rgmii-delay = <&main_conf 0x4114>;
+			};
+		};
+	};
+};
+
+&main_pmx0 {
+	icssg1_mdio_pins_default: icssg1-mdio-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x015c, PIN_OUTPUT, 0) /* (Y6) PRG1_MDIO0_MDC */
+			AM64X_IOPAD(0x0158, PIN_INPUT, 0)  /* (AA6) PRG1_MDIO0_MDIO */
+		>;
+	};
+
+	icssg1_rgmii1_pins_default: icssg1-rgmii1-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00b8, PIN_INPUT, 2) /* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
+			AM64X_IOPAD(0x00bc, PIN_INPUT, 2) /* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
+			AM64X_IOPAD(0x00c0, PIN_INPUT, 2) /* (W8) PRG1_PRU0_GPO2.PRG1_RGMII1_RD2 */
+			AM64X_IOPAD(0x00c4, PIN_INPUT, 2) /* (V8) PRG1_PRU0_GPO3.PRG1_RGMII1_RD3 */
+			AM64X_IOPAD(0x00d0, PIN_INPUT, 2) /* (AA7) PRG1_PRU0_GPO6.PRG1_RGMII1_RXC */
+			AM64X_IOPAD(0x00c8, PIN_INPUT, 2) /* (Y8) PRG1_PRU0_GPO4.PRG1_RGMII1_RX_CTL */
+			AM64X_IOPAD(0x00e4, PIN_OUTPUT, 2) /* (AA8) PRG1_PRU0_GPO11.PRG1_RGMII1_TD0 */
+			AM64X_IOPAD(0x00e8, PIN_OUTPUT, 2) /* (U9) PRG1_PRU0_GPO12.PRG1_RGMII1_TD1 */
+			AM64X_IOPAD(0x00ec, PIN_OUTPUT, 2) /* (W9) PRG1_PRU0_GPO13.PRG1_RGMII1_TD2 */
+			AM64X_IOPAD(0x00f0, PIN_OUTPUT, 2) /* (AA9) PRG1_PRU0_GPO14.PRG1_RGMII1_TD3 */
+			AM64X_IOPAD(0x00f4, PIN_OUTPUT, 2) /* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
+			AM64X_IOPAD(0x00f8, PIN_INPUT, 2) /* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
+		>;
+	};
+
+	icssg1_rgmii2_pins_default: icssg1-rgmii2-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0108, PIN_INPUT, 2) /* (W11) PRG1_PRU1_GPO0.PRG1_RGMII2_RD0 */
+			AM64X_IOPAD(0x010c, PIN_INPUT, 2) /* (V11) PRG1_PRU1_GPO1.PRG1_RGMII2_RD1 */
+			AM64X_IOPAD(0x0110, PIN_INPUT, 2) /* (AA12) PRG1_PRU1_GPO2.PRG1_RGMII2_RD2 */
+			AM64X_IOPAD(0x0114, PIN_INPUT, 2) /* (Y12) PRG1_PRU1_GPO3.PRG1_RGMII2_RD3 */
+			AM64X_IOPAD(0x0118, PIN_INPUT, 2) /* (W12) PRG1_PRU1_GPO4.PRG1_RGMII2_RX_CTL */
+			AM64X_IOPAD(0x0120, PIN_INPUT, 2) /* (U11) PRG1_PRU1_GPO6.PRG1_RGMII2_RXC */
+			AM64X_IOPAD(0x0134, PIN_OUTPUT, 2) /* (AA10) PRG1_PRU1_GPO11.PRG1_RGMII2_TD0 */
+			AM64X_IOPAD(0x0138, PIN_OUTPUT, 2) /* (V10) PRG1_PRU1_GPO12.PRG1_RGMII2_TD1 */
+			AM64X_IOPAD(0x013c, PIN_OUTPUT, 2) /* (U10) PRG1_PRU1_GPO13.PRG1_RGMII2_TD2 */
+			AM64X_IOPAD(0x0140, PIN_OUTPUT, 2) /* (AA11) PRG1_PRU1_GPO14.PRG1_RGMII2_TD3 */
+			AM64X_IOPAD(0x0144, PIN_OUTPUT, 2) /* (Y11) PRG1_PRU1_GPO15.PRG1_RGMII2_TX_CTL */
+			AM64X_IOPAD(0x0148, PIN_INPUT, 2) /* (Y10) PRG1_PRU1_GPO16.PRG1_RGMII2_TXC */
+		>;
+	};
+};
+
+&icssg1_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&icssg1_mdio_pins_default>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	icssg1_phy1: ethernet-phy@1 {
+		reg = <0x1>;
+		rx-fifo-depth = <DP83869_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		tx-fifo-depth = <DP83869_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		rx-internal-delay-ps = <2000>;
+		tx-internal-delay-ps = <2000>;
+		ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
+		ti,min-output-impedance;
+	};
+
+	icssg1_phy2: ethernet-phy@2 {
+		reg = <0x2>;
+		rx-fifo-depth = <DP83869_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		tx-fifo-depth = <DP83869_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		rx-internal-delay-ps = <2000>;
+		tx-internal-delay-ps = <2000>;
+		ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
+		ti,min-output-impedance;
+	};
+};
-- 
2.48.1


