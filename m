Return-Path: <linux-kernel+bounces-739036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4EB0C0E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EB14E10B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1328EA62;
	Mon, 21 Jul 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="sgiGTqQv"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C428DF2E;
	Mon, 21 Jul 2025 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092522; cv=none; b=s8C+E0nJXy5+T5BYSNpjIl46VB6hY4bBxBqyEB62orcCgar8asJLQQxlp8rYbP+BI8Dx4t7iBn2BEjmFpc5owX73jshapbgU+s4CHlg/2JTVltimS4xpeyHq4e+93M37EFkfALZFnnWP0EsNz394T4+77KKwjRBmeRYiLAAN3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092522; c=relaxed/simple;
	bh=F10Xwe5+E904VHUYV6ZPKyrzp9KZXN1uU222qowfndM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R769sAU3VBjK6ikHXlAUODQ0nXXLyfPF4sKbS7gVxSmeoZYxjxGUijpEtzoCwgeLBrytd3cNgeEqb+4YXLCFUHqiH/ubBYWCve/rsJXMH0Bsh9jI1Uq2u+Jb6kFACBb/X8eN62srJldKL2IUBvXzY2F20g5voGeU1fuDf+5Akyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=sgiGTqQv; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76C2CC7600;
	Mon, 21 Jul 2025 12:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1753092518; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1/bZceTz7f5S3mR9djxZojIdPvF+101cbNdjGmMV7JI=;
	b=sgiGTqQvdT3IYmHAxmotG2TSMT6g3b9XspgECEs+Ylqp1qb8RBkGLiI3/wSJqSd1c1JKx7
	BUiKDnZaMCArpjYCu4bpx45gWc0zKAwfbkUsoUVF+9v7GP5yDPJIZQNdDvpUhkltX69xPF
	95IS7QCaL5LWaOHDtJ5k6Yte1wyTL46XuJt1jERjntldw6qLqpRHKHQFL5UaTo0+yswc2Q
	ltBzjW04AsO6A65yUeecn1A9Z+lynoxeX7rflDQLWEHHkxZGcVbAL0UJVEQD6QwR/NbONN
	dNUX3o2TQHhVUUBsq7fFKZ7tApMkKT97yG/fXHYhcompVODhqW4PvD2979w8iA==
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
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 05/12] arm64: dts: imx8mm-kontron: Sort reg nodes alphabetically
Date: Mon, 21 Jul 2025 12:05:39 +0200
Message-ID: <20250721100701.115548-6-frieder@fris.de>
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Sort the regulator nodes alphabetically.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index d455429652305..264553248d5cc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -30,29 +30,6 @@ chosen {
 		stdout-path = &uart3;
 	};
 
-	reg_vdd_carrier: regulator-vdd-carrier {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_vdd_carrier>;
-		gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-name = "VDD_CARRIER";
-
-		regulator-state-standby {
-			regulator-on-in-suspend;
-		};
-
-		regulator-state-mem {
-			regulator-off-in-suspend;
-		};
-
-		regulator-state-disk {
-			regulator-off-in-suspend;
-		};
-	};
-
 	reg_usb1_vbus: regulator-usb1-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -96,6 +73,29 @@ reg_usdhc3_vcc: regulator-usdhc3-vcc {
 		regulator-max-microvolt = <3300000>;
 		regulator-name = "VCC_SDIO_B";
 	};
+
+	reg_vdd_carrier: regulator-vdd-carrier {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_vdd_carrier>;
+		gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "VDD_CARRIER";
+
+		regulator-state-standby {
+			regulator-on-in-suspend;
+		};
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+
+		regulator-state-disk {
+			regulator-off-in-suspend;
+		};
+	};
 };
 
 &A53_0 {
-- 
2.50.1


