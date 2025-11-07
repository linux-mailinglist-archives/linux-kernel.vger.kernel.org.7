Return-Path: <linux-kernel+bounces-890593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B378C406CB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3F91888ECE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F88632ABF6;
	Fri,  7 Nov 2025 14:50:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAFD329C54
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527002; cv=none; b=kJ3nsCXUiVxWSJig5GG+x18UiJt7KQN+yHtmecNArXb7TgrnMy3UmduCjM9EiwzoXO43W8DNcuO0uyYOYU82MIMkzHJbfSDFoDxGIchiMPebF3KZWP9njuYM1j7ErFiTjM2CxiHYKeDf5XvMAkFjLcTYncIJmxx3vTWGU1cl8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527002; c=relaxed/simple;
	bh=9xmlgYIcPDg2cJwx5uGKS37YQZiZmJHaREenlXSoNzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WECKKrPW0ImR+5TJmfotuXrdUEetHANHZmeFxP99JkzxswVInERq/Igz6o/9MEQgpGabukDb6R31TAut/XeFxyuG4NOU56z0GQEDj8ZSMaZPQ7zf2DV+EczMRWeK05IZM21X0wnMotoiiOePRX9O1v+20uEC7vS5HGMesDC8PRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1vHNmh-0001Tb-JW; Fri, 07 Nov 2025 15:49:51 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Fri, 07 Nov 2025 15:49:52 +0100
Subject: [PATCH 2/2] arm64: dts: imx8mp-skov: add Rev.C HDMI support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-v6-18-skov-revc-hdmi-v1-2-595549e5b496@pengutronix.de>
References: <20251107-v6-18-skov-revc-hdmi-v1-0-595549e5b496@pengutronix.de>
In-Reply-To: <20251107-v6-18-skov-revc-hdmi-v1-0-595549e5b496@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From software perspective, Rev.C HDMI and Rev.B HDMI don't differ since
the panel is connected via HDMI and the touchscreen is connected via
USB. However, the bootloader firmware expects to find a dts with the
correct revc-hdmi compatible.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/Makefile                  | 1 +
 arch/arm64/boot/dts/freescale/imx8mp-skov-revc-hdmi.dts | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 525ef180481d331e9c4decd092b7b831c497b67e..9da685641aa9e102a8566f0e58c0b57bb822c7d0 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -233,6 +233,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-mi1010ait-1cp1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revc-bd500.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revc-hdmi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revc-tian-g07017.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-toradex-smarc-dev.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-skov-revc-hdmi.dts b/arch/arm64/boot/dts/freescale/imx8mp-skov-revc-hdmi.dts
new file mode 100644
index 0000000000000000000000000000000000000000..c263e8fd048464df637604a8776aef345877e4f6
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-skov-revc-hdmi.dts
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#include "imx8mp-skov-revb-hdmi.dts"
+
+/ {
+	model = "SKOV IMX8MP CPU revC - HDMI";
+	compatible = "skov,imx8mp-skov-revc-hdmi", "fsl,imx8mp";
+};

-- 
2.47.3


