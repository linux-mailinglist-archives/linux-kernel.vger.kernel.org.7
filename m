Return-Path: <linux-kernel+bounces-739037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ECAB0C0E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1753A18C04C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915E528DF04;
	Mon, 21 Jul 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="l5FFp07w"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2528E571;
	Mon, 21 Jul 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092524; cv=none; b=UtY3V9LIPGLX3OQPEqbX6AH3yC9N0f03Wy/OLaH1vekhepKlPQ+jEF4JkTOHaYa8KNELCgs2nq+xLK2j6Ul1yDo2nVw8Qef9CteDalk86UB+KBgUoj6XA0gyCILOlHMq8e/osSJCylDEKK4biUODw49aFeXAbtmPhkeCU53Dt8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092524; c=relaxed/simple;
	bh=wgdU4WP9FnJ8Y6csHTkjGCEqVcCVt6v/KyxIsvJySS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYc5GFMGXvXcabajSrk33xqalj2G++ECxoXqkWfEHGypOpFSktcz8mjZzKVCT5Ls7jPAef2Kd20A42OP9sozl0vvg1mPFMHoRSOPEVSKIHkm+90BVJRJ6+Ucso8y25/Tg2kbmC3Lxkaa+IVpiHpk/+MQEyZNTAcSWS3N4bJNpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=l5FFp07w; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBD9AC75FD;
	Mon, 21 Jul 2025 12:08:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1753092520; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=madsTv28Rf7JKcd1M7q0kHETPGpzvbAfjoCb2ndJQxU=;
	b=l5FFp07w+Y98LdwpBkjMnreNfxY6jRlcWcnW68dtQYYZLx0B+8UA0dRirv+IsEzMX+dBo2
	6xtXUxA2ITUE2TmTwQD/lfPCGSVrGOMbmHPluGqdMgi6ZxaYdvSMP0xJojPyDVt0eZheBj
	aaOz+vHeMgtO6ghEdTzsFpc2pv5lzLGYajbS6CT3OeR/e80m+luD7pjKIcNX8ZGv5iEDZz
	BT5Okix0/xeM4G/Sbv7FEG5xaxGzJOuYKEbJ4nqvn2+lvFx68BtBPCTe1nsX/QbkJmpgxh
	mi5MYrdYbp1Z4ynL4D3/eqLC/i4vPejunhww9MCEq9ssE03wd7a87hNf2FwTHw==
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
Subject: [PATCH v2 06/12] arm64: dts: imx8mm-kontron: Name USB regulators according to OSM scheme
Date: Mon, 21 Jul 2025 12:05:40 +0200
Message-ID: <20250721100701.115548-7-frieder@fris.de>
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

Use the names from the OSM specification.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 264553248d5cc..96987910609f1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -38,7 +38,7 @@ reg_usb1_vbus: regulator-usb1-vbus {
 		gpio = <&gpio3 25 GPIO_ACTIVE_HIGH>;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-name = "VBUS_USB1";
+		regulator-name = "VBUS_USB_A";
 	};
 
 	reg_usb2_vbus: regulator-usb2-vbus {
@@ -49,7 +49,7 @@ reg_usb2_vbus: regulator-usb2-vbus {
 		gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-name = "VBUS_USB2";
+		regulator-name = "VBUS_USB_B";
 	};
 
 	reg_usdhc2_vcc: regulator-usdhc2-vcc {
-- 
2.50.1


