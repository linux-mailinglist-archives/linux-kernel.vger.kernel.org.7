Return-Path: <linux-kernel+bounces-860919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3290BF153A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5AC18A57C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D51C31283D;
	Mon, 20 Oct 2025 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="dQv0Zn12"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021128.outbound.protection.outlook.com [40.107.130.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA42F9D8C;
	Mon, 20 Oct 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964576; cv=fail; b=sUxvOHfcnMEZkHrrkbbdXLBHaigHMX+Sp3CYxKAvQljObvqTmZy17JdYBNAiKGzzYoyf9YxP3HoZU2HAdEzqnidlR44UIWfXEZiJf/LkgQJ8+tKSRl73upK/MEIOykN17XlKtOrrt5Mx3O7YXg7A//ASN4kMPil9SfG7F2nLk8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964576; c=relaxed/simple;
	bh=jO99VgQbpFFvsASmWsFpUBk0DLurFgEuvcxaCx3p/EY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KBBSQLZcof5HoUgaSbGhiWmMZWoGLxCN7zLVNB8CFsTlXskNcq2qzqWvIQq2P5VpkSlzOH42NCV8WnCz+m2fpLJpKJbNSHaotbgMGHbG3Lki8EXANci1BU9gJNsiEQ8q0jiIKpAU+eTPDwvVYG0Yt4ZbOLI9vGBxtvbhQX2lZnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=dQv0Zn12; arc=fail smtp.client-ip=40.107.130.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGTQ9nQi/wJZpNaxQx3Ag12Tknvu7TA4sTPFvmKcIJ9fuYUl/B0d2HP6K/7A5m+1KIBA6CVnx6ni1QK7Q6b2PgKkNvtYbDpqhEcHGCMRZw+a7C6SS4uhXgI3hHjurhAoML44045bVU29oIaCs4UmCqxtXIJhJUN0STrGtvhdSlBFsGNptl28vsQkGJ+i1dwPVDha6MvopFnFfOSYRbbRShwYKq/xM7FKdnWlpx8lEg403pOIVmzQA5/h6vdVSeOf7rt9tyYq4yLzt5plG4YciYyfEkCSurLKjGXTBWyxIX3oedQ4XQNb07tKcqHma+vWMtjlnznkYPVoV8TKI7s08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pv9hKFge/rXa7jcyCH3ufDnGx7DNscyzpbmlHjx/VU0=;
 b=fVbJG9jsyiO3UK+gzHHOH0zYc5icpBfSS8qZhQQdG1jQijw+fquTE6hbLtdP2HjgBwRNl8GdXj81Fw50/AHGYLeabaIw7SCe388pQOrPO3vZqMxcwIoRCiCECxtv5rFOa5Vl1XL2eBwZWEH/HhnBAgGZugtERTT2Ng60TMpJ/18olW7iqQTsUUsUlKUF63k/l1j7fATTQZCx8jezZqfBdjO9zxUXA6IewiAZu784jB8ycX5lqaNl3O0WgfQS4H3Q1FIxH/rouLUSYtioWXTripLJM8R0ap/wKr4OFKNArSTYLftru6REeigfeEjO6g8qMPGVFEwEq857AD0eErQJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv9hKFge/rXa7jcyCH3ufDnGx7DNscyzpbmlHjx/VU0=;
 b=dQv0Zn12mhrf/9oVBv/4zFEhxPGzPPnuvuLFCppV4dPdWXGfNAu/62LxROuKfyrWQ0LmfAqZPI8EGBkczrO/lj8Y9zRtOjsmzCVh+g38zemnGnDpWVgDPa4c2SxcpOpG4qUom8dC9zfOY9D16847c/41ZvPELa2/NHS8j/b9opqoLvxjhYBXA1J3nGomde9G0n3neYJOXSYS6uy9f5eFc10hTAuQJRlO0Iom/U2s14EjdimucQs8FdQBknGn5gcJLsjt1sr181vtFhODF42SpEP4TFzBnn1uwZQvYJqTPRvy+7lEen4TLGU+M1yxx+TtcluZcfAf+9TbesrsRRnvIg==
Received: from AM6P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::42)
 by DU4P195MB2688.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:573::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:49:30 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:209:81:cafe::c7) by AM6P195CA0029.outlook.office365.com
 (2603:10a6:209:81::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 12:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 12:49:29 +0000
Received: from [127.0.1.1] (172.25.39.168) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 20 Oct
 2025 14:49:29 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 20 Oct 2025 14:49:25 +0200
Subject: [PATCH v6 2/4] arm64: dts: imx8mp pollux: add display overlays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251020-imx8mp-pollux-display-overlays-v6-2-c65ceac56c53@phytec.de>
References: <20251020-imx8mp-pollux-display-overlays-v6-0-c65ceac56c53@phytec.de>
In-Reply-To: <20251020-imx8mp-pollux-display-overlays-v6-0-c65ceac56c53@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Teresa Remmet <t.remmet@phytec.de>, Peng Fan
	<peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|DU4P195MB2688:EE_
X-MS-Office365-Filtering-Correlation-Id: c5dc1415-ab89-460d-a3e8-08de0fd71c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlN6N2Y4TnVRUCt5WER1V0VBNngzb240ZGVkTDdOYWcyRVlHYU9YYlo3L3Yr?=
 =?utf-8?B?TlpQL3Z5YURLRlBHR3ZWTVpmRldvYWlxMXBxbS81aVVWcW93Wmh1bGZOREJl?=
 =?utf-8?B?cGVVOHdxdGp4bGZqWGVEZm90TzQzQnJlWkFja29tb2lLcC8wWm1MNjFSZjMw?=
 =?utf-8?B?Q3E2RzQ3Uzdsek9oUjN1RUNMZUVZMElDcWZwVWlWUHduSWpwOVd1UnRIMmRr?=
 =?utf-8?B?K1NZWHdhZXd4QmgzRDliZnhpZGF2NVNPUGw3MGhjTzNXRm9FOHNyVzhPNHkv?=
 =?utf-8?B?eUtHVUNxbmZQeEIwQnNyS2czRG1Nd3IzeDgvOG5JYVkzaWJITzhJOVlFaHJ5?=
 =?utf-8?B?NGJ3RHU0ZjN0OUkrZnY4K042V1hzcmQ5RXV4SHVGeTcxazRyQnB4RmhTNWhk?=
 =?utf-8?B?Tk1YVVJLditoOUh4T0Q5bmdjNkk4MjRCK0RObG54Z2xubGcwZUFTNXlJK29Z?=
 =?utf-8?B?dWVMQ3NXbkE4blRxTWNpaWM3L0pqaVZjNXVEelRUdkRLZm1zUWp6OVNRWG1u?=
 =?utf-8?B?VlRiSDdjZTF5Y2FlV2JDVEF1eEFqMlZPZEovUGQwcXRLNHU2V2tvemlPaHhM?=
 =?utf-8?B?NFF1WWdOY3Jhbk5UREY4cTZhbm1qWU9DSDJpZmtGWXlyZzBUall0eFJUblVC?=
 =?utf-8?B?VVNYa1JQR3dXMG5SOG44bkFvTVZEejBObDJwdzRCend1MTMzZktnRG9yR3Jt?=
 =?utf-8?B?OXJZd0hMbkduNFJFekJrSzRiWFBRcUF2TCt5M25TOU5Nek80Wmd1dVlVQUNm?=
 =?utf-8?B?MVZXaFEwSWoxMlJFVjNUQ2ZKUjl3eTIrY3VySXNFTVJkc3k0akVZc2x3ZjJ0?=
 =?utf-8?B?MUpHalBOQ1hwNjRDTWRXVjREelVvR0RlVzdBYVFQMFR5UXhtUU96ZnlvbUdl?=
 =?utf-8?B?U0hRaEVsYUsySnBENm40OHkwVWx1WkNranplajljRTRFaTBEc1NUcmZFQzVj?=
 =?utf-8?B?SEN4UlF4cVo0dDdqL0VnWXczUDN0OFFBaXM2eFNuTktpRXJzS2pIZktZb0Jv?=
 =?utf-8?B?OXE3TWdJcEJRUEdyaUZ6YjA5VitoREt1RFZoMlpHYUNqVnJrQTh0ZDM4SnZF?=
 =?utf-8?B?U0ZWS2FtUHVBejUxVVhmM1FqZUR5eFJwYVdIbms4czYyMGY2a1VKdSt4Qmpq?=
 =?utf-8?B?VVc0MTZ0b3VHaDRDQitaUkFIVHlaQlU0ZlMwYjFhcEhuSldybHplYlNwSVpP?=
 =?utf-8?B?d1ZaRHVycnRaWTFpRkxsamVPYUQ3ZjM5bG8zMWF4NE5oU3VFUGZZbW5pTjdN?=
 =?utf-8?B?R3IySjhvQjRrbjJocHpkQ2RkNnBjL2pUdGtjdHdEa2U1Mi90djkvZ2NVRklJ?=
 =?utf-8?B?QUxoRHZ4SDI4T3FPa1p1T0pDNUp6YU1ZUlYrTW1ReEc0ajFMSnFxc1FxTkl4?=
 =?utf-8?B?U1B3OVZXUWtWTU1KR3ZYT3JLR3dFT2tQdWZzaVQ4Nkk5MnNuUlNJc3hXWnFK?=
 =?utf-8?B?dXBLcWkvRSt6OXJVMzNTWnVCMEJ0OFhQTzZPU1hPd2xpMXRndDh0OEgrU21o?=
 =?utf-8?B?dk5FaVZmZGFTR3V4M0FkY042U0t3dzYyQU9JVWRSMnVILzMwUWpHQWxLWGZx?=
 =?utf-8?B?bUdOMU9HVzFOTjlnaDgvNEZ6Z1FDTG8wZEZVUHZrZ0FDN05lRTdnWjM1VmVz?=
 =?utf-8?B?akhMVFdiZU9Dc0hNa2ZOT0N2RU0zNWx1M2llb0U2dEZ5bGtpWGlxcjR5QlV4?=
 =?utf-8?B?YXZHTVVHWFQxRE9tTmRKcE9pdnYyTE5BUlBMbXJWWDNndGhZMC9qTjZHVFY3?=
 =?utf-8?B?MFhlR0hjVEdjR0l0cWkwNU9TMExoOGFTamxkdXB6R2JNeWN3Rm52VERGZElQ?=
 =?utf-8?B?YUJrV0ZBd3FmemEwYVdNVkdWWjdSOXFDLzdPenZCQ2hmRWk4bDBXbUptYUJy?=
 =?utf-8?B?Y1NhUVdHUkxiRzlaVHlsUGgwbXVPN2EvZC9yMml5aUU5V3lxa2Qzd2ErS2k1?=
 =?utf-8?B?Z2tZOThDQnlBYTdxMERSZUMxc0pTdk9DdzNLZTZsdVQ0V1V0UDE1Y2d3dWxU?=
 =?utf-8?B?V0JoLzNocEVPb1N2eDRTbkd2QURLRktFbVpFenQrL1N3Yk1GaVRJeGU1SWY5?=
 =?utf-8?B?S1BIV21TVkx3SHU1U1RXRWd2Yk9ycFgvUU0zSG9WSVN1SkdXL0ZObG4xN1BG?=
 =?utf-8?Q?7TwU=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:49:29.9117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dc1415-ab89-460d-a3e8-08de0fd71c40
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P195MB2688

imx8mp-phyboard-pollux had a display baked into its board dts file.
However this approach does not truly discribe the hardware and is not
suitable when using different displays.
Move display specific description into an overlay and add the successor
display for the phyboard-pollux as an additional overlay.

Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |  6 +++
 .../imx8mp-phyboard-pollux-etml1010g3dra.dtso      | 44 +++++++++++++++++++
 .../imx8mp-phyboard-pollux-ph128800t006.dtso       | 45 ++++++++++++++++++++
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 49 +++++-----------------
 4 files changed, 105 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 23535ed47631ca8f9db65bec5c07b6a7a7e36525..805ab9e5942bc9e2b9776e92412f56e969b6b39a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -218,7 +218,13 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-enc-carrier-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-smarc-universal-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
+imx8mp-phyboard-pollux-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-etml1010g3dra.dtbo
+imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-ph128800t006.dtbo
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..7a7f27d6bb1be6364cbab5d2fe45a365c7680fa8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+
+/dts-v1/;
+/plugin/;
+
+&backlight_lvds1 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm3 0 50000 0>;
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/*
+	 * The LVDS panel uses 72.4 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 72.4 * 7 = 506.8 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 72.4 MHz.
+	 */
+	assigned-clock-rates = <0>, <506800000>;
+	status = "okay";
+};
+
+&panel_lvds1 {
+	compatible = "edt,etml1010g3dra";
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..a39f83bf820490cf946849413cc968f9b0a86c96
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+
+/dts-v1/;
+/plugin/;
+
+&backlight_lvds1 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm3 0 66667 0>;
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/*
+	 * The LVDS panel uses 72.4 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 66.5 * 7 = 465.5 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 66.5 MHz.
+	 */
+	assigned-clock-rates = <0>, <465500000>;
+	status = "okay";
+};
+
+
+&panel_lvds1 {
+	compatible = "powertip,ph128800t006-zhc01";
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index e97d1d7c629b7fc4b52931868e35cb2d98434513..9687b4ded8f4c98fe68bcbeedcb5ea03434e27a3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -7,7 +7,6 @@
 
 #include <dt-bindings/phy/phy-imx8-pcie.h>
 #include <dt-bindings/leds/leds-pca9532.h>
-#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/thermal/thermal.h>
 #include "imx8mp-phycore-som.dtsi"
 
@@ -20,16 +19,12 @@ chosen {
 		stdout-path = &uart1;
 	};
 
-	backlight_lvds: backlight {
+	backlight_lvds1: backlight1 {
 		compatible = "pwm-backlight";
-		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_lvds1>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <11>;
-		enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
-		num-interpolated-steps = <2>;
+		pinctrl-names = "default";
 		power-supply = <&reg_lvds1_reg_en>;
-		pwms = <&pwm3 0 50000 0>;
+		status = "disabled";
 	};
 
 	fan0: fan {
@@ -42,10 +37,11 @@ fan0: fan {
 		#cooling-cells = <2>;
 	};
 
-	panel1_lvds: panel-lvds {
-		compatible = "edt,etml1010g3dra";
-		backlight = <&backlight_lvds>;
+	panel_lvds1: panel-lvds1 {
+		/* compatible panel in overlay */
+		backlight = <&backlight_lvds1>;
 		power-supply = <&reg_vcc_3v3_sw>;
+		status = "disabled";
 
 		port {
 			panel1_in: endpoint {
@@ -231,32 +227,8 @@ led-3 {
 	};
 };
 
-&lcdif2 {
-	status = "okay";
-};
-
-&lvds_bridge {
-	status = "okay";
-
-	ports {
-		port@2 {
-			ldb_lvds_ch1: endpoint {
-				remote-endpoint = <&panel1_in>;
-			};
-		};
-	};
-};
-
-&media_blk_ctrl {
-	/*
-	 * The LVDS panel on this device uses 72.4 MHz pixel clock,
-	 * set IMX8MP_VIDEO_PLL1 to 72.4 * 7 = 506.8 MHz so the LDB
-	 * serializer and LCDIFv3 scanout engine can reach accurate
-	 * pixel clock of exactly 72.4 MHz.
-	 */
-	assigned-clock-rates = <500000000>, <200000000>,
-			       <0>, <0>, <500000000>,
-			       <506800000>;
+&ldb_lvds_ch1 {
+	remote-endpoint = <&panel1_in>;
 };
 
 &snvs_pwrkey {
@@ -281,9 +253,8 @@ &pcie {
 };
 
 &pwm3 {
-	status = "okay";
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
+	pinctrl-names = "default";
 };
 
 &rv3028 {

-- 
2.51.0


