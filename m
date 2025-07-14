Return-Path: <linux-kernel+bounces-730209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C83B0415E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3BE16588B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD2258CC0;
	Mon, 14 Jul 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="Yaye8xXM"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77925393C;
	Mon, 14 Jul 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502824; cv=none; b=b3Jyug8KExQh6h7E414C+MH3LaBuJMIKphONDr00snrY3n1gE1ucOeQGsvCiFlECZNLFoEzr48e8wMcqdA+Voe/t/Elc+uV+p+kgAn2MLLJZe3wiLFwcdLQ0e93AMgawlAtIDKpuIiKs5tzU9OeOrcG0Ohp5dfoAm3ljRPYLlwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502824; c=relaxed/simple;
	bh=iaIHr95EYCPG/4EC9W9/SZEHZNA0jG4H21UubzlF/Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmqWl7C/Idus6cYded8txKM5Q5UIYjNCvfzAXbmKRd47I4j+AJH3K8YfY2QmOgoVTPrIoB7djM2WOO3513H+fCzsT45XwBuQYmhAJeib6iPMNRreNnQ6XT1cESNbqp//2z3D0G2dApy3pWRNqLKIkhW2xSnHjYyVyjkeOaWB/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=Yaye8xXM; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D32BC753F;
	Mon, 14 Jul 2025 16:20:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1752502816; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=I1cjRw+NOmrxpgqFiLQFeXIHtpswYIGfiHFGY6ljemw=;
	b=Yaye8xXMLAM+wbU1ONJzXaYlZHoIMWO/biWbvIge79i3eQXrVGlAdnjupaETFIykCNrwkF
	GVprrUGV0Qzc2CRQLR1cbyWGaL+l8GL3ugbCFJupMljvmRApXq/Id1raM8h2gbjWROMf+j
	4qBxRBWDjekNlx8BJzm2qSPlpj19bhDq7bLw6bE9WjnwkGgi9qugCbklT4OeE5UZ342m3R
	xZCKou4L1RBiGdT46qKcAhs+qjqf16vXd6y5E2I4MmF3GgI04zQAtlcjGjYbPzlROEl8ed
	vnaKhXsd7rh80s5kI4wlIXzEGhLHDPuouW0Xqk/nRgfYSwSoXHea4dikEZ1AHQ==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 03/12] arm64: dts: imx8mm-kontron: Use GPIO for RS485 transceiver control
Date: Mon, 14 Jul 2025 16:17:29 +0200
Message-ID: <20250714141852.116455-4-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714141852.116455-1-frieder@fris.de>
References: <20250714141852.116455-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Eberhard Stoll <eberhard.stoll@kontron.de>

For this IP the correct control of the CTS signal for transceiver direction
switching is difficult and - maybe also buggy - in the driver. Especially
the bootup requires special handling for most hardware implementations.

Therefore we simply use a GPIO now, which is fully under software control
and which is not problematic on bootup.

Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index d16490d876874..d96c07757e1d2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -268,8 +268,16 @@ &uart1 {
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
+	/*
+	 * During bootup the CTS needs to stay LOW, which is only possible if this
+	 * pin is controlled by a GPIO. The UART IP always sets CTS to HIGH if not
+	 * running. So using 'uart-has-rtscts' is not a good choice here! There are
+	 * workarounds for this, but they introduce unneccessary complexity and are
+	 * therefore avoided here. For more information about this see:
+	 * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=79d0224f6bf296d04cd843cfc49921b19c97bb09
+	 */
+	rts-gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
 	linux,rs485-enabled-at-boot-time;
-	uart-has-rtscts;
 	status = "okay";
 };
 
@@ -439,7 +447,7 @@ pinctrl_uart2: uart2grp {
 			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x0
 			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x0
 			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x0
-			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x0
+			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29		0x19
 		>;
 	};
 
-- 
2.50.1


