Return-Path: <linux-kernel+bounces-830458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD04B99B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EFF189F92C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB8130102A;
	Wed, 24 Sep 2025 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="ihfii41X"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023072.outbound.protection.outlook.com [40.107.162.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4F2FF67C;
	Wed, 24 Sep 2025 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715164; cv=fail; b=X4r38fRXi54+2MwJ97IIHv7VT9w+u1yyFJf531zZzLKzLxgm+Fzf1bxEtoM7qKGNF5BJzI5XJOJy9xRDbVzuMtcD0TvACJ6nOLqbWZb5f4etqOi3RWOJeAOi7arZ/sq7uisSfbzX04fPqxD+5ZxQAzsjO+ITuHeZZx0jdDWRWFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715164; c=relaxed/simple;
	bh=ieFLc/ybEA9KA3pJMydP5w0j/YTJ18plnfEHS3BCluE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WekoknfUaT0Ml8hEVEymC3903jgobBpODvokaAU0UAGl2+kZPLwIaySmhSQrUuIw2uIauIAP9KRppsOFUl/vMo4MRbhdWYt0bnFew7W/Zg76GSv+Ir14V6x/MVROmLnUZ21zvYqICUcDPryBmjtwQCWYFZwMHFJSzjnrtnt4pYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=ihfii41X; arc=fail smtp.client-ip=40.107.162.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrVJ4+rGhuSO0wkENQVPYkSKFmcXrW1POB0NsZ2CSyP3eogVU4UXZ4X4icxqPoX/umFcvacLjFxA07UKOi+SADCTr6txsTynWRpIJsmY/CziVY1/3aTYNLvJEO28qGqP/w6N6TKU/nKRDMvBq+OJyRv14hMjiE9XhMEgdcmapZvBIaaYfhH6Ygf7gOih6yIdKQrsSaHRSYgxLX2n4rg6dAaizXKPz52tQvmGbCoUkhQr40/VPAPFAdifYPgmEsm6v+BkfTQULeL/S6K62ZiRgzF8ECpBtGBxsAHNBdaXWYAbkIhhDzgIw0OCqJ8eVhDlv6yyES0vCb+R4AmVtT2+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HIBbNx+7IoAo0EgoqfpJZzI0d77yAdU5KcGNxih41g=;
 b=BFl+Su9Y9FER7A1pn260N+2mAJGcJzgwRh07d+k0ItLiRbPyEA8NqcFcU9EPmQpM+F8w0k44QfcBHKvfFsfw12NJIW+eaax+6vLz4DtKz+AuxzmmyRtWTfmdaEYiW9Cc0ZwEqTLPpnWu0OPmlrDMtDh+dEYFNJrmmK7GdZSgHqiYtpIqqH8IvyJL/rMXzmHw7eLC4f5EM/g3nUgip5PkefQQi/j9Dn5R/9lOCtN1QPmaXKc3UcnjfcaNtko/TqQs7Lw74NlJttQipfUX0U32NHZuya68w2udJecYUKOjA8us4h6PbDTLkQVR4PWE+pY00VJoXYw+VWIs6m6OlAtbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HIBbNx+7IoAo0EgoqfpJZzI0d77yAdU5KcGNxih41g=;
 b=ihfii41X2+CQAuHnxnMHjRXV8xt3HCOduLzt2A4A1y5FhSgR2Q+6DhaknOMGlgun1LfTn7ptwV+/MJQTNliOOc7EV+KfmDRZ3ioATrqn+M+jGQxYkmP/4aX6LTz1OzewuVHd8iDEJ+mdiEHmyc5xLGhySpTTvlbZCaMISSiTtVNFzS1IXOnKVSUAQek+MO7VoTF8J4ptpEmwDSfnRy1ffErazYmkFRqfWNvs8OJbf8z9HnCRVny2tNR33FWjePxWpYnqxdWixn6JHwLzHUcITdiAfnNcm9SD/he4duHes6VZTfX2uNWyX8M2yg+UX+aTSSBY7uf3BwygEBQoviWGyw==
Received: from DB7PR03CA0077.eurprd03.prod.outlook.com (2603:10a6:10:72::18)
 by FRWP195MB2886.EURP195.PROD.OUTLOOK.COM (2603:10a6:d10:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 11:59:11 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::ba) by DB7PR03CA0077.outlook.office365.com
 (2603:10a6:10:72::18) with Microsoft SMTP Server (version=TLS1_3,
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
 2025 13:59:09 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 24 Sep 2025 13:59:04 +0200
Subject: [PATCH v2 1/3] arm64: dts: imx8mp pollux: add display overlays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250924-imx8mp-pollux-display-overlays-v2-1-600f06b518b9@phytec.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|FRWP195MB2886:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fe6120-2914-451f-f13c-08ddfb61c62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW8rTW1INnFTT1pzcGlWdUpFaHozMEdCM0R1Kzl0bk5mbzI1NndudStiMEF0?=
 =?utf-8?B?cDRydHY5T2QvN1VzU2hyYWkwOWltcXR1N1JGNisxVEtFMkRkTEZ0V0ZEcjF4?=
 =?utf-8?B?TnN2N1ozdjdmUG5WVXlteTFwMWxERVF6bkhJcTRiMHA4SGZ4eWFWVVkrT09v?=
 =?utf-8?B?dXU5aFhBRjAwVVQydzNuUFozZWVGREppMjJXWC9WdW9kR0hOOFhJWGo2N0JJ?=
 =?utf-8?B?YmNUTWNaYWNnOElnMXdob1BCVXpFYnNvNGxkR05kWER5YjFDSXR2cnNaeTBy?=
 =?utf-8?B?ZVVYWHpick9xbWZydHlZbWZBczlmNHNRZ0FxZ3YrREJONDVYVEtTalQ5VUM5?=
 =?utf-8?B?V1NYekRqTjlXVkxHdlppZEFnc3BaN0Y0Z2FLK2p1NFgra1N4UzhVYkNuWTlU?=
 =?utf-8?B?SWkvbHRaalFxQmRORVNTRC9SZTRzZ001ODhEWmRVbDRlRzBzNnE5M1YrQngr?=
 =?utf-8?B?eUQ4cE1ZMzlPL0FRc1B4VEFCaU1sbTNUeHhFWHFIbWcxbUQ0WGtISWM5T0ZZ?=
 =?utf-8?B?TncrQVpVSjhlWHhqemxSV0l6US9aaXR5VjBvZWRNd3l6RjNWT0xHTU9lQ1Rn?=
 =?utf-8?B?eUpjUjNZMFRQWXZhOWtOSmZWRzd5cmg2UkM4Vzl6cWliYnFPck14TnJNTXRw?=
 =?utf-8?B?dWpmOGp1MUdXVHRXL2JpM25WaGpQSzhwNDNpZXJVMzRPUGpTT3RXdzVwVGN5?=
 =?utf-8?B?R0d1R2NFeDROWjNmYThCaUptUktaQmVKdk5NODdmellxdkFqWVQyOXkrY1dh?=
 =?utf-8?B?NE1rUnZpZm9XQjB4NVhMcUJYeVJKSXVCeUdNVzNwTXpyMnE5eisvNTRPT2da?=
 =?utf-8?B?czV5enFZUHlyUkp0ZmxNWWVhVXB4OXpCY040TE9wVWZQc2pIQmxvek5pRFhy?=
 =?utf-8?B?MHlUMWpRcWIrNGRQdmoxdDAwUEcrdzNvWVlpREI2eVQ1ajBpMHByT1h1Unlo?=
 =?utf-8?B?RlM1anoyVHFCOGZLRWtHMXVVUEdGWnRZM2hPL2xmcVo3ZDJZd0hCZHVadUlE?=
 =?utf-8?B?Y1d0Q1drbHBaaGYwU1FGYU9kL3hDK09MUXV6c0dublZvWGJ0eEJsTVNrUVdV?=
 =?utf-8?B?YkREMzB3by8zYTB3cFk0dklneVBpemMxNGRwYVY0cnBGU25nR3gzakVxa2dG?=
 =?utf-8?B?MnZSMDloSm9pMEN5ejZNMkhNSENVUEtUcDBlOUk1bmszbnU0MXJJWEVJTUVs?=
 =?utf-8?B?UlRPQ3dZUU1BUjdnMVhwTlVraFZKTVFJVlBxcXRLM3NtcEdXcXhVTVdYK0gx?=
 =?utf-8?B?cGNLSkJRZ3pEVzROWGszS3lCTmVEMmVIYU1MdlliYU9GR0IxQithdFRRbm0y?=
 =?utf-8?B?TzB3T1lEaXFocnErb2ttZ0psRFY5amFZU2YydExvVWlaKzltUnpxNHhhd3Vy?=
 =?utf-8?B?MjRVNUltbGhtUXdIdWkzU3Ruc1R1dUV2L1pCOWF6OUxuVUVhV1lQbWlGY2Ev?=
 =?utf-8?B?YSsvZXpkRHg1NUxiaW1CNlFjSVRBcUtURDliZ2d1MTA3aWhvakdPU09jZ2Jp?=
 =?utf-8?B?Tm1XekhzY1VaQVRKZCtMSkc3M1RrMHJmM2FsYVdQU0k1YXZ6VlM4WSs1WnNI?=
 =?utf-8?B?bk9CQmN4T3J2UVlmNTdISWlQamNYREpVczk3bG1kcnAxQ210dTZRZmVQdkxR?=
 =?utf-8?B?UHhKc3dkRVB5Y2RvZnhZWEZxeEorNlBwblJSdVVGQmYxSDdDL3NnNDNsRUMz?=
 =?utf-8?B?U2NhR0lLSjJvQkRCZCtGTDU2a0R2SElSYWZ3V2VkcGJpcmlMYnRkNGNIVldN?=
 =?utf-8?B?eklXa1lNM2poL1gyOUNFWk9rSTV2Q2k4MlJjUWtEdTBsZGkvcUlmZndkeDRK?=
 =?utf-8?B?RGM0U0hoUnowSHRVZEdzWDNsU21EWFF4cm5XTFQyNXB1dDNjYjZrM1c1bmpo?=
 =?utf-8?B?Vk00d3pEYmFheHFTQ1VKRlJHS2E3WCtITlhHS0RITm1MWHQ3YjY3MGsrcllk?=
 =?utf-8?B?Z1ZNbGZOSkFyY0JHWFE5WElpNGZIRXJuWkV2TmRlVGJKTHUzc0llYU4zejYy?=
 =?utf-8?B?bkMvdXRHdTZWWGVWQWRVbzkzS05BSFdRMTV6T0pwR2g4dUQ0a3AwTkJDUWJ3?=
 =?utf-8?Q?Wzt4Wv?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 11:59:11.0861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fe6120-2914-451f-f13c-08ddfb61c62a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWP195MB2886

imx8mp-phyboard-pollux had a display baked into its board dts file.
However this approach does not truly discribe the hardware and is not
suitable when using different displays.
Move display specific description into an overlay and add the successor
display for the phyboard-pollux as an additional overlay.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |  6 +++
 .../imx8mp-phyboard-pollux-etml1010g3dra.dtso      | 44 ++++++++++++++++++
 .../imx8mp-phyboard-pollux-ph128800t006.dtso       | 45 ++++++++++++++++++
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 53 +++++-----------------
 4 files changed, 107 insertions(+), 41 deletions(-)

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
index 0000000000000000000000000000000000000000..9c14f7818fec807577f4774c0e48e9daf5014734
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
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
index 0000000000000000000000000000000000000000..0df34c50cce7df58322161f0a2f72eaddf2307a7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
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
index 436152308642270c320e3ae3b21b9e46b923c043..76a9ae34ba469cbc65648f588c63c4016119821e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright (C) 2020 PHYTEC Messtechnik GmbH
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
  * Author: Teresa Remmet <t.remmet@phytec.de>
  */
 
@@ -8,7 +8,6 @@
 
 #include <dt-bindings/phy/phy-imx8-pcie.h>
 #include <dt-bindings/leds/leds-pca9532.h>
-#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/thermal/thermal.h>
 #include "imx8mp-phycore-som.dtsi"
 
@@ -21,16 +20,12 @@ chosen {
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
@@ -43,10 +38,11 @@ fan0: fan {
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
@@ -232,32 +228,8 @@ led-3 {
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
@@ -282,9 +254,8 @@ &pcie {
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


