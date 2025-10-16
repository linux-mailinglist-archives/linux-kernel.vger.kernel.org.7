Return-Path: <linux-kernel+bounces-855725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C5BE21D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C191C547681
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5630147F;
	Thu, 16 Oct 2025 08:17:05 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2120.outbound.protection.partner.outlook.cn [139.219.146.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A53019C5;
	Thu, 16 Oct 2025 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602624; cv=fail; b=qyYBYFSDxjcUixrYw5O+5t4x3U9k4svqGDgZ53/8mIOg72bZiFawL/RJ5/xfK1arQBKvYxUzLmssj8lYNuzuQ93q4sLnS1ilAkTttbvcaYkhb8hRFVqaGofChRBuX1+RW+y4U5a0EN4ntSjeB8zO+RIZ/owrnAaDBmfh5sqrYR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602624; c=relaxed/simple;
	bh=fgrBUgI5/oNsNQxhCQrW4e1jge/pKZD12+JgXt3Zxkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FtH8tSoSxiwk532q8V1ItTCfc30+nhiVNRH5auvxx26eYdIDUjbvFb1vbsyDeXDVy+sa9QL4ht4dcO7ZU3Z4N8dvzccUZZOXgkO+TIuGFRQfygzl8BSvMkPoafMlx2sTN9GKxkNiuraKYTQP9MgaMCDvFPGJADRg57EeCxOBQvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMWKaRTlpRWfCBrh1IwyCXIXPiJJMcroz+4+AZdwiGaeJHQCxe50sHrRz3+K5tb6imOMABEMjN8DoFKwWpBxIfumy7/3UqMP3EEhX4igtiVoagstdNheCz//r1KRyu3IyycyNoRxOVOCivxC8tZXVllEBEAYUsi0cQA0CDzOXYY4CHRWGmwdWVK/45KBTtfuv2bpzfdiwuK7UbmArftozh+d769eidqZwQc7zu+CnfmaNjNPwORSMqziEoQrjHEfjJ3bCb12fg0qSoKDOxVpn/oisF4DPyDqQ8VdWu6bPhmRLkoyb78pypXigl6jYcAv2adCSwKjCVf70jyoEv1lVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTddjTbxeUmmpXZqZUcsSVvc2r0iAITpCCe5xcKyd94=;
 b=Ks3pVD6sSEgKIeh0+TCQmCkluVH1bsuSgDL2ehk5JgkHHkvM2dNVLEG7t9Xiu8oKghSG+nNf1gNSgYpoN+uIi9YUTdfkEfIwTFHamQ+SVAKtMqQvCkp4CH5WbKdbK6ohTYOsOqs6u993FJ+/P4J3HvcZXudkJkAX9PmJXQzampi52+x1ZB5fUFRmxMkRnOWHiAdynfFg5JSdJFA+Nap5O6V3VZzG6exfN8KCuiyLDLDJ1TcsHu+d38VryHaYxbFxF8OatD8FiTCE6G3nhmwI8rIHcfmo2biuQbJBCABtSWdW09/bSg+J0D4oH7GcNpU0F7H7A+50s3EKzEeCAhxChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.23; Thu, 16 Oct
 2025 08:01:08 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9182.020; Thu, 16 Oct 2025
 08:01:08 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/7] riscv: dts: starfive: Add common board dtsi for VisionFive 2 Lite variants
Date: Thu, 16 Oct 2025 16:00:52 +0800
Message-ID: <20251016080054.12484-6-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251016080054.12484-1-hal.feng@starfivetech.com>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1308:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f3df37-371c-4479-c37c-08de0c8a2a29
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|41320700013|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	Jd2j+8gK8ateCw/2KziNHxMQPGScGAuCkms337zdRHQbt0G9B86MLZNJk6AXAFLyD0xEjuG9b1p5JGR6Ue/K8kwL9loxik3aWcUGyJhoqydYkrNjBQ9SNXoHS5NRyY7d1AM9dJm9cOzINX4XgFTMePB214lmEz0Guuop+pJ3wZau7UpCP7byhOxB99d5zSqkoqqQY3EuuZTv2nbGY3ysusAqtT2lgfKwAzDStRL6IGZxeJ7MPS8Z6SefnyPZZqtBhG0aKn/rXooY5fO+3a74s0Swn3BfA6kmAOsTtxHXaR3W4Sws31XAUs245nFAnTYDx7pbwvllBXcJ+/AW6fyihToLzn46HjQIt6oE9wqwQMw0+sJjQ38knGOkhi4wjO4dNpX41Rp+FPNSNaY7TmGbfJRwTR5FGuabPzEGpv0IPWAokp+EIWnqJYD7vr3M3tpHsK2WcZ5tcn+eTpXf/zlLJWV1v4vaFgZBlkpJvDkKu6Yp2+MXaRRRWCHIzoCV8152qNQHHWaVdZbnuZBq17WOIkagMnNDustJ/oG3dyIbDF/1RR/xu9W428HKvuv6tEqmdmEBbNIVdJo0rPc56fy0nv2BxanzzZaYGQ3chBb+hoA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(41320700013)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJQ+4MqLqDLUfTvYkvc1ByxHxgZv1uiZQMr+o4paSLCoHNdsRRzWvSdLGlhI?=
 =?us-ascii?Q?GSKAJe10Wm0jZcmlh/bDw0c9lAbU9SgFHqTOgQgFtIjd6AoLQR3jF38lKCvf?=
 =?us-ascii?Q?ApalVXOuy0zcI2XbE6l8JjSeLWx6K4O5LMfVM0lbJ3GB8soXdwxFbhfshoPY?=
 =?us-ascii?Q?Ekt0bhl8gTnY7KQ2Ye2kFeND3Fo7I02jmqMf/gffGTnSG8LI1BqbU4lD4uUX?=
 =?us-ascii?Q?bOZjwkthAkW4bqDHrBqAbODAf+KX3e3svRiKBcA3woDxfVKJdPkq2NKQninf?=
 =?us-ascii?Q?xr3clbRv6wSxT4lXS40XzKtUbYJwwNZeAODuQln0Br8+dUzG8PHziZ4n00yJ?=
 =?us-ascii?Q?MLVLwysynzh/T+xbcteDKsCvpFzIEhUqHA60xC+PRR6BVw+iYJwhJJYyyAEX?=
 =?us-ascii?Q?T/Svlq5ex/tJP2KglWsy+fpEwtzuVcMiYcLlLE2tszHgkLAJhw6+EjtF0Mx+?=
 =?us-ascii?Q?vEBtHAez3XTZcRidC9UC8P1LBBRNovzBTw1XBrVnxE8dMGEFOpo0fY4KORHi?=
 =?us-ascii?Q?kNiPt5CFevohZlYOoWrjH1wuVfNNCBRiUXz2Wisu3mEGsUzVUpQN9LBpVQ6C?=
 =?us-ascii?Q?C4v+WKCyVYoPhK4pL/X3p6ho2GcG1B0vAF4tnRk4oX5SVz2NJV0EghALXI08?=
 =?us-ascii?Q?BMaLQgxwlXbg7fI3L9qBlQJvE/RoKiBOWriWVkPp0TL5NjZoLSEkYmVievSy?=
 =?us-ascii?Q?thj0mZHAu9KeamEMFQWhGNkvnMJWP23t+yv/vHmJvs0TzMbjtYLCZo2WliCK?=
 =?us-ascii?Q?o8FPdkltk4ZkA+3i/CLUGSAfk1NLaAiVCeiliPvI7/U2Mj7SvJdrOXFia3Rs?=
 =?us-ascii?Q?jE9xXHfAuv7QzmB3dcPxKNM3fjbWbVGHAyX88GvT2YOxPY+WPTN55c3JO1Rv?=
 =?us-ascii?Q?K+jmVpymXxPcYHvTCDFj9ghaAQcROaA3ctrrL5JyLxHD7SshuyD5f6jO4Fja?=
 =?us-ascii?Q?BkSL8EHoWAfqb+ZW6+Zgp3wTPs+z40SttFtGq0t5twSbwvVKGXDqwMPxHN6p?=
 =?us-ascii?Q?ZHq/t2IFznSh+PZdPi2t2oE13DjMa4Md3H0k9tz3P+MMJa2B19ouJa9rddR5?=
 =?us-ascii?Q?gdbGOuKmrP21un0S2Zt6ttNmPo9p5v7ajp5lTmBSLWLieV/tsyLsqxQINfZP?=
 =?us-ascii?Q?Dlw2cyYhSPFwCr62RKGwj1//fzeQSEhutX3xP3mYXWgSzWXWBcCURu+P+9Rt?=
 =?us-ascii?Q?E8oJPnceBh54dhZx7M58t7MlrGbN9mHZ/AkyFFm/TxlxlXZ1LDpFkIAC1N/Y?=
 =?us-ascii?Q?LK2JUOf08VVK1yPAHgfcBxQTpc7O5i+5tDsp9XanBbQU6Mzg48BdIMh2T6xe?=
 =?us-ascii?Q?aShyPzNwSmL7GLRkoWcma7dy8wcjVeQNhnv7DbBiRuXvMr7jm/thJg9DfPdG?=
 =?us-ascii?Q?coREPjGKydTkIzAHy9rTSDxC06V8IRzblxAoobvT0yD/kvd0S2IcEslKbeb3?=
 =?us-ascii?Q?rMPZOvuFkAgVy9Kdqu89SxZeeOa3awGUx3WI7SEFDiH8qC1PABNJTOv9zb/P?=
 =?us-ascii?Q?0NvDcBxkgziEeSPDSG6pGskQ24V2TroAHgbIdP2DcUSdLkAPiajnDVnEkRqO?=
 =?us-ascii?Q?cvBf9/Y4mUEDcz8YD9lamAKd0GOqSVus6DjNRRY25H4s0S6WIxGw20e8x5kp?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f3df37-371c-4479-c37c-08de0c8a2a29
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:01:08.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BVlaQGN8WovW1rDQ+y9cR2H6mVMRFISVgirpXF8NjIMHPZenGMcc/fI2X0H7bW2re/0z8+lMx0t2S3C+j+79b4rFQCXuvXzC8BiyRt7bt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1308

Add a common board dtsi for use by VisionFive 2 Lite and
VisionFive 2 Lite eMMC.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110s-starfive-visionfive-2-lite.dtsi   | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dtsi

diff --git a/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dtsi b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dtsi
new file mode 100644
index 000000000000..bd8868fef872
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dtsi
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 StarFive Technology Co., Ltd.
+ * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+&cpu_opp {
+	opp-312500000 {
+		opp-hz = /bits/ 64 <312500000>;
+		opp-microvolt = <800000>;
+	};
+	opp-417000000 {
+		opp-hz = /bits/ 64 <417000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-625000000 {
+		opp-hz = /bits/ 64 <625000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-1250000000 {
+		opp-hz = /bits/ 64 <1250000000>;
+		opp-microvolt = <1000000>;
+	};
+};
+
+&gmac0 {
+	starfive,tx-use-rgmii-clk;
+	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
+	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&mmc1 {
+	max-frequency = <50000000>;
+	keep-power-in-suspend;
+	non-removable;
+};
+
+&pcie1 {
+	enable-gpios = <&sysgpio 27 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&phy0 {
+	motorcomm,tx-clk-adj-enabled;
+	motorcomm,tx-clk-100-inverted;
+	motorcomm,tx-clk-1000-inverted;
+	motorcomm,rx-clk-drv-microamp = <3970>;
+	motorcomm,rx-data-drv-microamp = <2910>;
+	rx-internal-delay-ps = <1500>;
+	tx-internal-delay-ps = <1500>;
+};
+
+&pwm {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&syscrg {
+	assigned-clock-rates = <0>, <0>, <0>, <0>, <500000000>, <1250000000>;
+};
+
+&sysgpio {
+	uart1_pins: uart1-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(22, GPOUT_SYS_UART1_TX,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(23, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_UART1_RX)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+
+		cts-pins {
+			pinmux = <GPIOMUX(24, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_UART1_CTS)>;
+			input-enable;
+		};
+
+		rts-pins {
+			pinmux = <GPIOMUX(25, GPOUT_SYS_UART1_RTS,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			input-enable;
+		};
+	};
+
+	usb0_pins: usb0-0 {
+		power-pins {
+			pinmux = <GPIOMUX(26, GPOUT_HIGH,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			input-disable;
+		};
+
+		switch-pins {
+			pinmux = <GPIOMUX(62, GPOUT_LOW,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			input-disable;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+	status = "okay";
+};
+
+&usb_cdns3 {
+	phys = <&usbphy0>, <&pciephy0>;
+	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
+};
-- 
2.43.2


