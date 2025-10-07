Return-Path: <linux-kernel+bounces-844002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A4BC0CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2BD54F3AE6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD22D46C0;
	Tue,  7 Oct 2025 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="n7TiSlUD"
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9592580F9;
	Tue,  7 Oct 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759827651; cv=none; b=DqX3+XlBB+QAN+MAddNy5YC6D/N2ujZH37vMJTvQPR5iwO11pmJCHJiugTzHyOCoJFJUlBHMvEuddX+BZmqGc6kmDIFlLNlahmgDQpr/HjDyw9WaCTlRCyi9lEQiXOYFMYMIJ27NuB16yrDi1yO2/BBNuaoc3amMfGrMD3WXYTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759827651; c=relaxed/simple;
	bh=eNLh2sl1E7GE2+5DyV9dKbAUakN5RdwhTwQxV573oiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HW7V7o3IH6NyhBKHHupoOzHXTZW4VLmM/T2edEBxxgwliolbTtUj2sw6zpCENl2Yo0hddWtknPnbc53y8mIQFR8eoUZs3yyWVmdKLJlQqWiQ4Sr0f53FuVOt/QLMcCChshNa2DCuMHVTNjhCdxXZrsV5NZTK5xK74kGYr2Jdods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=n7TiSlUD; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=I4koABzEQoGKLzAtw8KpjOXYdJpMHOXjILBXMLZGWaA=; b=n7TiSlUD+1OiiL2GO9Zg04Yicn
	+AW9x+mJuW8/d/6gEzO8FiNlc6QKmEzzY8FgVATJcGTSgvckJbwMiedxDg9rJrVDft2g/gGhNYuWO
	YtC7ozZyWSYT0Cu4UcllSw09QpTBGbsIGM54U3cL1eQarFNjgd7Wfm33zx0o7vDqmiCcsHmrXkjxW
	myUgBIha7g329UqhgAJI/DubMAjCZbv4wjBZC2ApPpkdzqQLh83sG1LD2ube6hUD5XVh9hTAqLYUc
	jsTfRh3VMd9yf3Wxr2zP7Ru+A5BDtNYuZy1MuDLwYSbQ/oJMauruCS80dQLf5nzl/zSQLnS9aWF0J
	z7NgHwDA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:34170 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1v63FJ-0000000BgWm-0nsq;
	Tue, 07 Oct 2025 10:40:31 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 1/2] arm64: dts: freescale: imx93-phyboard-nash: Add jtag overlay
Date: Tue,  7 Oct 2025 10:40:27 +0200
Message-Id: <20251007084028.1125185-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add overlay to enable JTAG pins on the board's JTAG (X41) connector.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  2 ++
 .../freescale/imx93-phyboard-nash-jtag.dtso   | 26 +++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 525ef180481d..c72a6fdc5412 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -356,10 +356,12 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 
+imx93-phyboard-nash-jtag-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-jtag.dtbo
 imx93-phyboard-nash-peb-wlbt-07-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-peb-wlbt-07.dtbo
 imx93-phyboard-segin-peb-eval-01-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-eval-01.dtbo
 imx93-phyboard-segin-peb-wlbt-05-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-wlbt-05.dtbo
 imx93-phycore-rpmsg-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-segin.dtb imx93-phycore-rpmsg.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-jtag.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-peb-wlbt-07.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-eval-01.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-wlbt-05.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
new file mode 100644
index 000000000000..4744eabf95f3
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
+ */
+
+#include "imx93-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_jtag>;
+};
+
+&iomuxc {
+	pinctrl_jtag: jtaggrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO24__JTAG_MUX_TDO	0x31e
+			MX93_PAD_GPIO_IO25__JTAG_MUX_TCK	0x31e
+			MX93_PAD_GPIO_IO26__JTAG_MUX_TDI	0x31e
+			MX93_PAD_GPIO_IO27__JTAG_MUX_TMS	0x31e
+		>;
+	};
+};
-- 
2.34.1


