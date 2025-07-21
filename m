Return-Path: <linux-kernel+bounces-739034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE66B0C0E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797FB1891476
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6620E71C;
	Mon, 21 Jul 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="KbUJsVCi"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4D28DB7F;
	Mon, 21 Jul 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092520; cv=none; b=E2B+H5K/5Z5BJYRDBqFiu5lw6WKicIHzQ2OerrAJ7ZFUfxMaSmwJsi6dF3NyadWflJgYlU7QZvO80hYu9Lx7in3fZV1U0uKAhVL+jxipV1EOLDxlFm1SSyf8CUNszsoI9bBI1bBM28bb6TF0HPhTWlKJAR+K319KwW54lOd3kAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092520; c=relaxed/simple;
	bh=Goh0tFpzekGWfGSf1ECWnMAiIARmvY3RWxrJfMdAWQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YthaFTYvNV4Rm3REfGLVUXFk/VjJO5vQKI4vvl5OThhXLGw7pCJAzPfpVxHjqW68lpBfU1de8wGfrM4SckRUvZ/WIct4ubGgQ/5BosRUZUwjI63aM0cOGnZbks5f/LmbUwDQP3oPW5VluDxueozJdmM/7pykdomjjO1iDO9miNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=KbUJsVCi; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9E84C75FF;
	Mon, 21 Jul 2025 12:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1753092517; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=if3G31kDyONKU4cYh6cAYYRUvhtz4mtYtm+FhFilxts=;
	b=KbUJsVCi58oBt+Pft9XY38ImHzMB6aisEcggDcryygYT07VffSxu0lnLGxKldGzeiuYAdh
	vzaue5hIKJgTUA7ST+ac2Ya+jLfBwcKl/xrgEXvfifh69HT0wiDn7Ui29ZA3xwhi+uC1xA
	c31rEyaFD5yTttEVJufCT2fdWRNuYxxDlsx8rd0dT3Z2Agt0isIsUDQZiD3WsbbXNbUiqG
	F9+ujUhJqrEPDTzYnNdGZ7lYyKskyzyFgkmlW/xzUfeEGZqOD31qs7FihzKQeuAbP4eQpv
	pZ51K1/Yczz+vczEfqRKSapJ/XK91W32DUG8ef2xMYHlLAzVKDrgaN+xXTUUiQ==
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
Cc: Oualid Derouiche <oualid.derouiche@kontron.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 04/12] arm64: dts: imx8mm-kontron: Add Sitronix touch controller in DL devicetree
Date: Mon, 21 Jul 2025 12:05:38 +0200
Message-ID: <20250721100701.115548-5-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721100701.115548-1-frieder@fris.de>
References: <20250721100701.115548-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Oualid Derouiche <oualid.derouiche@kontron.de>

Some new panels have the Sitronix touch instead of Goodix. Support them
by adding a node for the new controller. The bootloader needs to detect
the correct controller and enable/disable the nodes accordingly. To make
this easier add labels for both nodes.

Signed-off-by: Oualid Derouiche <oualid.derouiche@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* fix node name (thanks Fabio!)
* add labels
---
 .../arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
index 1db27731b581c..57d0739fcce32 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
@@ -107,7 +107,7 @@ &i2c2 {
 	#size-cells = <0>;
 	status = "okay";
 
-	touchscreen@5d {
+	gt911: touchscreen@5d {
 		compatible = "goodix,gt928";
 		reg = <0x5d>;
 		pinctrl-names = "default";
@@ -117,6 +117,17 @@ touchscreen@5d {
 		reset-gpios = <&gpio3 23 0>;
 		irq-gpios = <&gpio3 22 0>;
 	};
+
+	st1633: touchscreen@55 {
+		compatible = "sitronix,st1633";
+		reg = <0x55>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupts = <22 8>;
+		interrupt-parent = <&gpio3>;
+		gpios = <&gpio3 22 0>;
+		status = "disabled";
+	};
 };
 
 &lvds {
-- 
2.50.1


