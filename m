Return-Path: <linux-kernel+bounces-830456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F31BB99B54
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9914C4AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C813009FF;
	Wed, 24 Sep 2025 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="KX7TreQf"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020140.outbound.protection.outlook.com [52.101.84.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3372FFDDE;
	Wed, 24 Sep 2025 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715164; cv=fail; b=reuy2MYDuH1PfvrM5RN7RNOfZCzjL2Sw1vgXkEDkhmq7qpx7rgU4uLHt8Ep4MiykRqpO9TlAwsdXdmB5DQy1EnfwLl5apVMJ1cNmQpAZ/lyxAGX81IYPIijp9u4bjduBIn09q4sQb1zNziLwA/dMrOO0x+4m2IWuBjCD2Lq6Mgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715164; c=relaxed/simple;
	bh=kxxzGEfL3Yt7dSS5B1eLUv67MsgU27p7Gji7iqYJnLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PwbZABwnJGqkABImBSA5lEOCC/bYEz5kHYXIeL6AhxTglhDdf5oHjcSqLVZohvGfmxBY9E0wh2N5eRNSwPN9io4kAqsRPFUmZwbJzRAuYiemGWkUEA1boQLqY2jtvZp4SjCpZrOaKzQ8Gv09Cl8IAufk58DJOOOdyA956psny28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=KX7TreQf; arc=fail smtp.client-ip=52.101.84.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wX3QOGrNJBVJ5hr+mxN+tn7i7l+4B+jylRc+kvsIYiqBEo6kqQ1RQ4rxyYsYRmSF3jo23+pa0pawDTX8jiEuKYxYksQgW8dWZHe/LegDWBaad1psO+qp08FC4SxXTGbvHKeQChHo7DvUY56B2fB3VxyBFkSuF0Mo91CreGCrF1ZLHX1zkbmoHb/tYY7bJ0YV/t6Mg5BJEtcWVGUl+VkJNRRLvL5Iab2/m5us4/vMTSKFVnwXpgbz20z8InwRyd07Ly/8bpMvDDgxjGjj8f9tzz+qqK7UTJFCgkHjuYl5iEMlSx+xriTzuw9MRMlF5J2Xwdh55cq75Gmahr1mVTcE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaZvZVFSkE54aNqULeuL4FQ4rGa4khS0rDFIP7Pdu0g=;
 b=q32j5KvT1IlllzgDRMLyT090Ei5WAnPfuBSdGKuwFWshj8tm1tym87CyIgio1WXjgn/X9B2UsnhKYMDyVOJz64/rLqcWht6653M/8g+9HZtDnP/BUnGH20KQc0MGZ5z/J07ECoT7RaFCpX/N3jJ68jxWm+qgJ8m5nLYmD59vCWX+nYTBJ3baUV6p2V1Y7D+u++9sZODl7FEtlssYo/73HoO42V6iPPO+yhJM8qVW0QukFg2Udsn8jm6ppPjOmuPadyqWqL4kQPE4+NAWYuqcjEhdEOawo7LOW+f4KDU+XvWx0MKGnUrGjXGnXNz4j0I2ur/Tknn7lNRTE2IEVTBCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaZvZVFSkE54aNqULeuL4FQ4rGa4khS0rDFIP7Pdu0g=;
 b=KX7TreQfnRa9cq3QU+dM2OVbRCt4NxxZEkuPVQGfTaNgCc3y6ytJ2ytK4oz6zAFkrm4L0yAwlGD2VtwwIdvfsRIKiPAQjFvsxmXTDEp9dBJuTt7X3w3NHnV5q5N80wysx9UrVyuHPHQjAelVb+sZ5VX72eyGFz8p9DrEiMCalVSo7VSWJjl8qsmxxKATapo8pJfydSFTotApusff/9W3n/5AzqX3SJ2cBXpp+Jreu5/WgTdSOgczoggCIdwa/teO7VgQlynkbBwxS91qKmouWEpbw1PLFrkh0h12v16QdhfDHHcQavoLf2OJGALxxpU55OeATwQ6XoWe4mF7fkz0+g==
Received: from DB7PR03CA0087.eurprd03.prod.outlook.com (2603:10a6:10:72::28)
 by AM9P195MB1079.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 11:59:11 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::61) by DB7PR03CA0087.outlook.office365.com
 (2603:10a6:10:72::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 11:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 11:59:11 +0000
Received: from [127.0.1.1] (172.25.39.168) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 13:59:10 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 24 Sep 2025 13:59:06 +0200
Subject: [PATCH v2 3/3] arm64: dts: imx8mp pollux: add displays for
 expansion board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250924-imx8mp-pollux-display-overlays-v2-3-600f06b518b9@phytec.de>
References: <20250924-imx8mp-pollux-display-overlays-v2-0-600f06b518b9@phytec.de>
In-Reply-To: <20250924-imx8mp-pollux-display-overlays-v2-0-600f06b518b9@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|AM9P195MB1079:EE_
X-MS-Office365-Filtering-Correlation-Id: d68159af-44c7-4629-a2d2-08ddfb61c68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGEzNzMvUWpHOGg4WkhTMi9tZTlRWUhCTnJsRzdORDdiNEM2cUtVckNVTDAx?=
 =?utf-8?B?bGMzdGVoRGlzY09hV0NNc0hSbktyMmdWbU5INS9Mc1pjN1JtUmJ4V3BacTl4?=
 =?utf-8?B?MFpyc3l3azU0RGVWOUdnN2ZhSHBYNVlPbXdrT1RDaUJtMTNmL3VJNVdkMGpz?=
 =?utf-8?B?OUNlK1NTK25sOXZkSjlxOC9YY2ZXL1p4eFRWL3ZqZ1lrU0dNVmpNYWYycFN3?=
 =?utf-8?B?TW53b2NEeGlmME4yamhYQ2pXc1dta2JXdHNTS3NHY0FSV3dlMEtReThXZGRG?=
 =?utf-8?B?dDBqSHN2Q29SY040Q2VNbHBnRitrd2ViSElOWm9lU21TbHJvNUJVQ0lnYkpJ?=
 =?utf-8?B?bXltZ1hqd0xhZlYvQ0gzdG14d09CcVROUVEzUjA3MHQ3UUdCMlFKT2luR2Zz?=
 =?utf-8?B?bW1PYWNVcU9CMkxEWFEvOWV0djlBR2Qyc1IzWElBQW1va1NLTWw1MUFWUWhR?=
 =?utf-8?B?dVJCSHFHdGtVYU9haXFPTW1OczBuUXB6Q3ZPUnZTVjg0TWhlY0c4QVkwVlFp?=
 =?utf-8?B?cDN6K0pXeFIvVDR1RlMzUlRLYmtTUHhBdVRYQlgyWTJPcmFLNUNXb3FTaFdU?=
 =?utf-8?B?RXhTRXJQSW5mcitwZE5WMm42V1JyOXpCTWZmbXdxc0wxaEx0bjF4eVdUQ0l2?=
 =?utf-8?B?T0xlU1FYeHBPVmRyaEJFTjNreHNzamZORnRYeVZnSjdTUkpJMWE3dUVaUlF2?=
 =?utf-8?B?Y0c4L1pZWFo4OGY5OUY2SHhocTEzUysyMTVtVmM2MENTaXdxeDJZc25IVktI?=
 =?utf-8?B?dUp5cUl0THEvWEZVU3oxV1Q5a3Jzek5nQW9DYzAzWERrVUtoZ3Z2NFB0NWRZ?=
 =?utf-8?B?YXB1VWZaMEp1QmJwVkVzL2JEYVNkWjNxUmo1SnR4NkVZdEhNUlpGbEZRVnhE?=
 =?utf-8?B?VnRNbW1rWGs2YW9hS092ZE52S2djS0ZBd2k4UWc3RTNRZUVPUjhvaWlIZG1G?=
 =?utf-8?B?ODdIM2lCM1YyVUwrWlpma3VwS3E0MkJENWVQbkg1V2cxZERMUmJadWVjZXl6?=
 =?utf-8?B?dWNsUmhpejNRdlFNQzJSWVN5OGwvSDlUTTk1eE9tTkRMNGpjZ0c4N2NqUGNo?=
 =?utf-8?B?N3Iralg0ZU5HRldaT05SKy9wRGl5K2hvcTNYS01GV1ZZK3RacnpISTF0dkFs?=
 =?utf-8?B?L0tJNVFBbFNhbzEvcnI5K2NhTE5PM0NkUmtVanhqVVlCMjQwNE9EQ1lCeTFo?=
 =?utf-8?B?VXo0NEQ1SWhla1ZLMHhzR2ZaeGxXbkRGMFE5OGhuMnNjQnkrQ29laUtOeEhO?=
 =?utf-8?B?ZU5HQmVSWWhvaDhnaG1EUXdkdXJSRXhFKzhZcS90M0hKYWliZGUwakxTYWox?=
 =?utf-8?B?RXo5QWlRLzh5dnRENFlnYkJQeFBGS01lZHpQWkp0WDlFR2ltNGNOZmpORUh6?=
 =?utf-8?B?ZHRMZjhQS3J3L0JJUVpXdXJKMzQzN2FkeWJwaWdmVFkwbFJ6RXlibjhLL0Jm?=
 =?utf-8?B?WjN4dmhBZDR4UXB3ZGpPSlUrcXhJb1VsNndKQkRLdHFYL0FoWjhPaHhKMWV1?=
 =?utf-8?B?NFdpbXlwSnNJQ0d4WDVQY0RlaXU0RWJmajUxMnZLaXk3WGh4cG1MZkpzNGpo?=
 =?utf-8?B?UmU1UE1rZzVwTWF6Uk1yWmViVWsxUUUwZDBaOTlRNnQvVk5nb3A5YldjT0ZM?=
 =?utf-8?B?ZFd3R3k4cFBGVUpReVdnUzB3OVdaRTNVK29sNngxV0pIbzNQV1NKdXV5Y2tL?=
 =?utf-8?B?ZE5BTTRoYzhsYVNCOFpVelJBL0ZwTjNUNzVvNXd3ditZMTU4MTVkNS9RU1pq?=
 =?utf-8?B?ZG51cmdSSFoveEVybUh3QTBBUjNKWVNTTGY3eTZJMTcxTWJFMzIwcGduM1Mz?=
 =?utf-8?B?eTBCK1IySGFTNmRLKzJQdTczTmN6RjdKRW44L09YVlllSy9DNVBjdXdOMUYw?=
 =?utf-8?B?Q2ZubWFrQ3lIenFiRk5qWUFWNFhubDQzQ05KUFg5bmFEakdUb3hub2c5bjJ2?=
 =?utf-8?B?VEZRRVNwMWxnY2FmYXpSblhHdGpBREZnU1NMQi9YOW1HdFZsK3drN0VNVkt6?=
 =?utf-8?B?Tkd3ZmVhT1VUUHM2bnhOdnpzbVpWSUttdGNyRzhKTjVHVHBlUHM0QkFkWFhF?=
 =?utf-8?Q?Tcz38y?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 11:59:11.7323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d68159af-44c7-4629-a2d2-08ddfb61c68d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1079

The same displays that can be connected directly to the
imx8mp-phyboard-pollux can also be connected to the expansion board
PEB-AV-10. For displays connected to the expansion board, a second LVDS
channel of the i.MX 8M Plus SoC is used and only a single display
connected to the SoC LVDS display bridge at a given time is supported.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |  6 +++
 ...mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso | 45 ++++++++++++++++++++++
 ...8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso | 45 ++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9c121041128972d2239e2cc74df98b0bf7de1ac2..e4b097446440f41785dd1a0e5d354796e800ee76 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -222,11 +222,17 @@ imx8mp-phyboard-pollux-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-etml1010g3dra.dtbo
 imx8mp-phyboard-pollux-peb-av-10-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-peb-av-10.dtbo
+imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtbo
+imx8mp-phyboard-pollux-peb-av-10-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtbo
 imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-ph128800t006.dtbo
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..d71945430c801a0136a95d691af0cec64622a066
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include "imx8mp-phyboard-pollux-peb-av-10.dtsi"
+
+&backlight_lvds0 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm4 0 50000 0>;
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
+&panel_lvds0 {
+	compatible = "edt,etml1010g3dra";
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..8ec4bbbbabb5cc7f5ae05d641fb5d14931250daf
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include "imx8mp-phyboard-pollux-peb-av-10.dtsi"
+
+&backlight_lvds0 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm4 0 66667 0>;
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
+	 * The LVDS panel uses 66.5 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 66.5 * 7 = 465.5 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 66.5 MHz.
+	 */
+	assigned-clock-rates = <0>, <465500000>;
+	status = "okay";
+};
+
+&panel_lvds0 {
+	compatible = "powertip,ph128800t006-zhc01";
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};

-- 
2.51.0


