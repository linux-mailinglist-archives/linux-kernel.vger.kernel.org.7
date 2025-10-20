Return-Path: <linux-kernel+bounces-860962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85455BF1780
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04EB94F5408
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E869131986F;
	Mon, 20 Oct 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="T5r84bSR"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023088.outbound.protection.outlook.com [40.107.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FD3128D9;
	Mon, 20 Oct 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965899; cv=fail; b=RpqSNij15A4bvjx9P5qJto/m67MC++mmPmYd/a6yxpuqj0gflgDjHKqD0TL/OEcKjFieLfC58naeGRtVMqh6ZZ+MylKZtr8skngCOhSjCQs4dzvCj3VP/PtjUbZ4L/VfOZtrKdprXjoDxiPKpU00cfn8wYFj1wCERbqZrvxq3kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965899; c=relaxed/simple;
	bh=SP6DuasWaL6jthj9RsBGG21BvHk0LgILaxpzK4uEXbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EeF8NRyI1lvKT55KHcvBM5f0QpkiSCGcm/JQu+ZyNULOy5dQbe2d6/8yiPyy11EQOfzbPHwq3wkEkOUunbVJBQHvqzT3PSmh+OJRG3kCTmzOpuMm0GBkEiLecrMb/28JBqld628b/bieJt2C+72L2lnuleFazJFGTrpnJUvqeL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=T5r84bSR; arc=fail smtp.client-ip=40.107.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waQOyxILTjMwCTCy/RC+u9YkNpFhEe3xj4xTPTR3gCPcDh/z0ukdHMW8IFd1bDxN74uzDmg0gsrwouKEPeIxWENv0U9/ZGfzgCl0j7BKhB+oXiMyBmURrAiRMz8U66ChcSoG0qKSv/dQ6kQ67y7MvtE7UtMa5iSYAqZAuVJ1+1FHEbP77LxB+OD/70Xz7UZENGjixqDKVdFg1/fbotHwwp568gJkVbtVWRXmu4mvAXdTvqipTX09L9VSVjzQgvVDMR44FLQcCQi5NOumIJnw9F9ysZ/vFXAJfRzbf7jKS4V+EmSj9kB+ip9lUrGOUxugblbtdzdwWrLMeqBAHlsnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1X3pU/vFnHWU1RY3pmRCVnK9ubBj3YmheXU7L2AKT4=;
 b=fxMb9FaLdyJTnO7f1t/a7S3Dyqtwg4ksaC9Xh6534cntmM7zw74TlI1bERIqQNbj4dBlXR4RIrRdDyFlFWfZjAh9DRR3mtjyHqkqM7QNjkkPzO2sj5Cby4STKHQiiZyxddr2BVhRLg6Y1Q+5Lu5hqnyW96qYdZWGaVD6PCc1gkcROz9qCvntrA1MSyjxntns9uBAgVcdcE6uuf6V+YISf/0NOfaMRs9Bk/MzkYyAxHdFj9JODfWgcFcmMmxaUjX8Tkb9Dnmku5SFusM5QKx1g0BAH0CusCkfmmXVaAF8K6ILc0TybrmPnU1mvZXux0a5KC4iGoSSnYBWsgISXMOpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1X3pU/vFnHWU1RY3pmRCVnK9ubBj3YmheXU7L2AKT4=;
 b=T5r84bSRMRm+w1nq6Ia9bB2Sjp73ECOYDJED63mWpBHfKzZfzeO2R+kMLKSG+29NXsRo9f5yxuzwdFkaLySJ1Nwmps+oBG2Ct/L8WElBBjU5DGd3+ELrOt0yqnuQuE1OYkdQXX8qczx+uBMzMjcw39ICwnBmosyJMt0qLUgTw6HJm3v/ArnXMDOiXZnvy/Xug9Q0U+UcvnGPLofBG+82sx39MVPCoGQZwIIa+smdYq4ZTTQgbUqUKG23bCChC2CfmM2jFhhGd4w0kWmsga1QbNmObGTo4j4Cgnf8b7nGqKurXpSc7vZUwfu2TH4kt/EqinTv2gtDfVxZrCvV3860Wg==
Received: from DU7P195CA0019.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::32)
 by DU4P195MB3233.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:61c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 13:11:34 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::68) by DU7P195CA0019.outlook.office365.com
 (2603:10a6:10:54d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 13:11:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 13:11:34 +0000
Received: from [127.0.1.1] (172.25.39.168) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 20 Oct
 2025 15:11:33 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 20 Oct 2025 15:11:25 +0200
Subject: [PATCH 4/4] arm64: dts: imx8mp-phyboard-pollux: add PEB-WLBT-05
 expansion board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251020-imx8mp-dts-additions-v1-4-ea9ac5652b8b@phytec.de>
References: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
In-Reply-To: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <upstream@lists.phytec.de>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|DU4P195MB3233:EE_
X-MS-Office365-Filtering-Correlation-Id: a535ab50-424c-4f8c-d267-08de0fda3191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czYzV0hXSi9kRk96ZkRHODNLa0dFZnVxRVJQd0ZIYll5RGtLOVA3ZzRwUGlx?=
 =?utf-8?B?czlnaVA1TDdmM2xqSUl6c290ZG14QWJmWnREK2wyZkFERGtrR24vVUhLb0FH?=
 =?utf-8?B?cG1nN2puL1ZNbTBEcHViRTI2NTVlN0dRYzQxSFl6alNDY0hMcFlLQlkySW9h?=
 =?utf-8?B?U0NhY2duTnUwN0tiaFlUYU05amlKZ1I3elkvRHFrMGVybjkxclcveFQyYXJH?=
 =?utf-8?B?akdQdkNkKzBIRFJoTm1DTll1Slcwdjd0MkxaYUgxaERWNFlUcnloN3psN2Fv?=
 =?utf-8?B?WEZKa2dMamNxaUszOEFDdjBVWDFzOUdrZEhwUzM2N2YyZmk4OGJxc1hzTHFT?=
 =?utf-8?B?d2Yzc2hhVllqejJJMHhHK0ZLRDN3am52aWJSUmpsSGhUTTB4eTlYOTh4ZGJE?=
 =?utf-8?B?QXJTUTliZldTR3oxUjkybWtWQmlJVi9qMUhSTENqREVDVDg2eWxSSjhVSTR2?=
 =?utf-8?B?Uit5SlBOa2FUNzh1OEdsVU5rd3pzL3JibnhqV0pjMTVINWt5Q1dUZmp1WWR6?=
 =?utf-8?B?eUdjVkp5ZVMxWERRcGFma2VNTXcveDR5NjJrR3JQSit6QXJOSkcvMTlmSXRI?=
 =?utf-8?B?TG5BSXJQS1BzRDRxMEtYMGJCbHZhbE1LaVdGZHFlOHVyU2NOT0E4NUxCenhh?=
 =?utf-8?B?NXdMMGJwWm9LQ29SR1k0VXlsR0lJV0drK0VsNjEvTjZGOFlkWnZPSy94SHYy?=
 =?utf-8?B?aGpWOUlJNCtDa0YxQ3EyYU9URzUwa0VodTk4cXA1VzJCSWtBMlY1TFg3eGd0?=
 =?utf-8?B?RnFpazBUeXpOZTlEOUNwa2s4cTFXOHNHZUJrNUhwZUpVOHJUTkxQQk9ueG43?=
 =?utf-8?B?TVBhUjNQNVlvR2w5Z1B1dUhlNjhIazV2MC8zeWI2TTMwQVhCT1JMYktLb0Nz?=
 =?utf-8?B?M0xKKzFRUkQvTTJibG5KRERpNFdBaEtrRE5ES1RkUHJHTkNHQUFxRGlNMjR5?=
 =?utf-8?B?YXdwbktzVkNEcHExOTZvQjZVV3VPRU54WUs4S3dnSmQ0eHNMdy9KNHhNU04y?=
 =?utf-8?B?c0VwV3NIUVFBazJiSEM5cG9PQ0ZFSG5Nd1pMeEJBKzhaVnJ6dFpJaWNLNHFu?=
 =?utf-8?B?eWdOTVN1ckdhUXBkMjNNZmVwL1B1UDk4QWRtTTNWVThOZEJZMHUvNzRRdkFX?=
 =?utf-8?B?WWU3dkl6RHNHcVErQmdGa0I1RjZhYUZ4bi8rdWFZcVRCRE9zWVh6M0hSbERQ?=
 =?utf-8?B?SnNXRzlLbm03R3pxOEU2cEZUTDJia00rSHhxYS9kUExrWVlocFp2K2hJd1Mr?=
 =?utf-8?B?ZFZzbDBPc2s2R05WZVhyTFVSOThIeGZqOFlUZUxYUmRBdXh0Z3JCbnZhT25V?=
 =?utf-8?B?TkRpUU5GM2lFQXNIZExUbXlaeHFnM2FsM3Y5eFhwZ0o3UG9HWktuK2pJTUZQ?=
 =?utf-8?B?MS9NbFJJRWlZR2RnYTgrakFHTldvQ045bUJqckJqMmVWODZBN0FtYVZyMWRl?=
 =?utf-8?B?Zi85QkVVVFNGOWNuM256ZHZGMTJMNnNTWlJyQ09FRWM0enpYeUt2bERkdW9k?=
 =?utf-8?B?b0dCTkpsZkRuck5vUmNNMXRtM1J4TkVFSmxXZ3RZQWh6WW13YTJSWUsrakxB?=
 =?utf-8?B?aldNTTUzQWNrZVFjc0h1NTZJOUJMQTR2MXUrV2hPdStSOW5LcWtZaXhUOW9t?=
 =?utf-8?B?ZlgzQlhRR3dvU045em42UWwwQnBxQ3FReWJNSkNVMHNZSy9pekZZeGZiZ0dG?=
 =?utf-8?B?enBjdWhnQTI2aXJEZzJ4SklDdndBNjBDYXdUVWh4Z3VyNDdLcFNXa3FGQk43?=
 =?utf-8?B?QzRJVUJkN25sZkxzTjlxVDJzWVB2M0Q5YmdJZDFiUGRiZW5hbUJza2ZFcVdS?=
 =?utf-8?B?bEVBWWxuM1UvbGtwcS9GU1Nzb2lxbE94NFN3MlJSL1lTSllZK2toMm9WSlpC?=
 =?utf-8?B?TTlhMjdkcXVHQit3WlJYSkFCb2J3RGJJNml5N3k0R2E3WWxVdk02TmhldFda?=
 =?utf-8?B?NTRpZ3gxSlJnb2tnQ0JTU1B4ZVRkVTBHOEwrVWZ6Rm9vTDN3bG9KNFNzQ2lr?=
 =?utf-8?B?V0cwKzlDZm1jdGFMaDhkM0pWQlh4cU5CVmZLT3MwUVE3Lzcya3BDczQzd0Vq?=
 =?utf-8?B?eGFmQU5RQW8xb2Z5M2NtOG56VHhtdDlzNVo3V0kwN1FLUTRuNnJhSFVTUloz?=
 =?utf-8?Q?mMrg=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:11:34.1419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a535ab50-424c-4f8c-d267-08de0fda3191
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P195MB3233

PEB-WLBT-05 is an expansion board that provides WIFI and Bluetooth
functionality. It features the Ezurio Sterling LWB module [1].
Add missing regulator to baseboard dts.

[1] https://www.ezurio.com/wireless-modules/wifi-modules-bluetooth/sterling-lwb-24-ghz-wifi-4-bt-51-module

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../imx8mp-phyboard-pollux-peb-wlbt-05.dtso        | 108 +++++++++++++++++++++
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |   9 ++
 3 files changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index d77e6ab8e46fe71ae41087a3b65ca64cc50e2e76..606a25f3323dab51ddff7bab686e69a8d48610a3 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -237,12 +237,15 @@ imx8mp-phyboard-pollux-peb-av-10-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk
 imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-ph128800t006.dtbo
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
+imx8mp-phyboard-pollux-wlbt-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-peb-wlbt-05.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-wlbt.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-wlbt-05.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-wlbt-05.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..0e98f4d942716e57f5bc1567924460b618eb0930
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-wlbt-05.dtso
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx8mp-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	wlbt_clock: clock-32768 {
+		compatible = "fixed-clock";
+		clock-accuracy = <20000>;
+		clock-frequency = <32768>;
+		clock-output-names = "WIFIBT_SLOW_CLK";
+		#clock-cells = <0>;
+	};
+
+	usdhc1_pwrseq: pwr-seq {
+		compatible = "mmc-pwrseq-simple";
+		post-power-on-delay-ms = <250>;
+		reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&iomuxc {
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_RESET_B__UART3_DCE_RTS	0x140	/* RTS */
+			MX8MP_IOMUXC_SD1_STROBE__UART3_DCE_CTS	0x140	/* CTS */
+			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX	0x140	/* RX */
+			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX	0x140	/* TX */
+		>;
+	};
+
+	pinctrl_bluetooth: bluetoothgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x106	/* BT_DEV_WAKE_EXP */
+			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x106	/* BT_REG_ON_EXP */
+			MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09	0x106	/* BT_HOST_WAKE_EXP */
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190	/* SDIO_CLK */
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0	/* SDIO_CMD */
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0	/* SDIO_D0 */
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0	/* SDIO_D1 */
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0	/* SDIO_D2 */
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0	/* SDIO_D3 */
+		>;
+	};
+
+	pinctrl_wifi: wifigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05	0x106	/* WL_REG_ON_EXP */
+		>;
+	};
+};
+
+&uart3 {
+	assigned-clocks = <&clk IMX8MP_CLK_UART3>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	pinctrl-0 = <&pinctrl_uart3>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		pinctrl-0 = <&pinctrl_bluetooth>;
+		pinctrl-names = "default";
+		clock-names = "lpo";
+		clocks = <&wlbt_clock>;
+		device-wakeup-gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>;
+		max-speed = <3000000>;
+		shutdown-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&reg_vcc_3v3_sw>;
+		vddio-supply = <&reg_vcc_1v8_exp_con>;
+	};
+};
+
+&usdhc1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	mmc-pwrseq = <&usdhc1_pwrseq>;
+	non-removable;
+	vmmc-supply = <&reg_vcc_3v3_sw>;
+	status = "okay";
+
+	wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		pinctrl-0 = <&pinctrl_wifi>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 7d34b820e3213a3832c5be47444d4e9c636a6202..9e25ce1d466b1174c60d2bb350339ca5d68cc025 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -119,6 +119,15 @@ reg_vcc_3v3_sw: regulator-vcc-3v3-sw {
 		regulator-max-microvolt = <3300000>;
 	};
 
+	reg_vcc_1v8_exp_con: regulator-vcc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "VCC_1V8_EXP_CON";
+	};
+
 	thermal-zones {
 		soc-thermal {
 			trips {

-- 
2.51.0


