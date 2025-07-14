Return-Path: <linux-kernel+bounces-730211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166E7B04167
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E538C189D9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756025BEFE;
	Mon, 14 Jul 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="wQJVQh/0"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B710259CBF;
	Mon, 14 Jul 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502826; cv=none; b=kpEZnZ6UMT4sxFxsHQezgSNBZTS2TEawz9Jr4Dx3OC2ieKUT/yARLd5ScBENFXkamwmlnd5F2dSUiaQMI8bUisAm+TkzNel1Gcy9zUicIoIoDS2BiruULoEntOqGl19iRKqMphUSX871a9CLPLK8GsoWCnCASHzOoqg7EmB1IIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502826; c=relaxed/simple;
	bh=wgdU4WP9FnJ8Y6csHTkjGCEqVcCVt6v/KyxIsvJySS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy9DfU4qxjC97cuQtzgfCt9kPMMkIExdiuWiJ0ejd8K+HM5ZBAcBASC/Tsgve64ldPuaMa2nkF4SsK+F9JUGIH46FblTcnjdFhe1vcoEHXUJdA+QdrhKwfFyd7jYXTJv7ucTcFt88NRSYl/decGWo+k3e2bQTEcPFyDG+m/ldg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=wQJVQh/0; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82052C753E;
	Mon, 14 Jul 2025 16:20:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1752502822; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=madsTv28Rf7JKcd1M7q0kHETPGpzvbAfjoCb2ndJQxU=;
	b=wQJVQh/0cvikZ/fWJTWn/HxmCUCvueT7jIuP3N79DjnRQA6Wo1SL0LFid+a73d9wMmxSq/
	u+RnjlxIq3EFYFdZFIndHsLbhX6lj5f5QNyZmnZtXQqVGT2nrubeVnhDnwlAA/Pg/54Va+
	YqzZweuLoiYlUMVQsL15Jb3T85vdtGM3cKDwDRQbnKh2kIhPQ0fq5YqsnT8+EZ/RMpP0Q2
	5IEEhPKBbwAYmMJNRifAVKtAQSnqlSGxYa+EKKqaTnwuQ+yjCXRRHoEEeVoeBpaJyGNgCX
	Lc9DEdOZIRZH5wMMMzPUI/gkZkbhOBhs4Gt3DJPQIT+rA2ahkngynygJgpVy1g==
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
Subject: [PATCH 06/12] arm64: dts: imx8mm-kontron: Name USB regulators according to OSM scheme
Date: Mon, 14 Jul 2025 16:17:32 +0200
Message-ID: <20250714141852.116455-7-frieder@fris.de>
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


