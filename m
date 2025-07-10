Return-Path: <linux-kernel+bounces-726192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C82B0092F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5C51C277BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90322F0E29;
	Thu, 10 Jul 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="hA57riP9"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15ED2F0038
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166260; cv=none; b=NrfixQ/Gu5vQYBl7+X8dATOoNGpMqFcIgHQZLSNDeDHyZQYz+z3XWb160+Utw6LsvrAIXhe22bnki5gwHGNXFLvhy3xNihZvbHzKHZEl/jM6TPuHDlT+6W4Omf3U654WCsjCzlKyUzlmtWDnhcX7mgWG+pd6SWjjyot3tTJawFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166260; c=relaxed/simple;
	bh=1/lgcU6J91Nah6llXW2IKKlaxLEotdEdEftqQWx/RQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUEerV/PUlLbYQmDRGgsJjHPmleOY6aOYB6EJc0/1ZN1sSMDsxhi6NYnCW3wZSSxVd1z4kR+V9RBrZSTQrWGWCS4gA1X5A3hJ8015HzpgzH/IEeOLOnCPjTLKD91RVVJ/8vTQfDO660rdn/yH4mrz9OoGV20IQrVQzwGS4xH5tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hA57riP9; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=hA57riP9ilplNUC9lxhigzrnbuJoTuzqGA+Pf1dsLsG4sJFE6rPayh1SBGcND7paED7Zu6l/P/7/F4nXflqnFxBKA5bflQYCio8GaejZOvqaPU0sNnZ+ccgOtww5U3544sUn5aQTMmYyqvZaXMQzBAv4PdvuZg7v8Y+QUIirNYn7xbjQmjsdyMxB99QWBysmhg30BcIjWqX51DByNgLZ0M90VO1FsvOaXhXj0Y7Ze/xhcyHNa5rAP6gCQUiR5azKMCj19weRzYckd0qQkf6NCVhyzV5N/aNjHzyAYz1SePN2SyGDldYw91hbH8K5wvrLvFJQ2EV+XGU0DTrnPswo+Q==; s=purelymail3; d=purelymail.com; v=1; bh=1/lgcU6J91Nah6llXW2IKKlaxLEotdEdEftqQWx/RQk=; h=Feedback-ID:Received:From:Date:Subject:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1992400030;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 10 Jul 2025 16:50:39 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Thu, 10 Jul 2025 18:50:06 +0200
Subject: [PATCH v2 2/5] arm64: dts: exynos990: Add USB nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-resends-july-exynos990-dt-v2-2-55033f73d1b0@mentallysanemainliners.org>
References: <20250710-resends-july-exynos990-dt-v2-0-55033f73d1b0@mentallysanemainliners.org>
In-Reply-To: <20250710-resends-july-exynos990-dt-v2-0-55033f73d1b0@mentallysanemainliners.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752166235; l=1950;
 i=igor.belwon@mentallysanemainliners.org; s=20241206;
 h=from:subject:message-id; bh=1/lgcU6J91Nah6llXW2IKKlaxLEotdEdEftqQWx/RQk=;
 b=gNdTB+SazTGvUEOySHF1DzzjAQr3SsdgnqbRRzof8PUYQnaio5ON375X3MrWNhmc7Zsj4eNwa
 VGjsC/VeyutDl3Ja5I/egjjgQ6wh4tSkmW0HGlxxTXTycIsGd42jq36
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=qKAuSTWKTaGQM0vwBxV0p6hPKMN4vh0CwZ+bozrG5lY=

Add USB controller and USB PHY controller nodes for use in
the Exynos990 SoC.

This SoC supports USB full-speed, high-speed and super-speed modes.

Due to the inability to test PIPE3, USB super-speed is not enabled, and
the USB PHY is only configured for UTMI+ operation for now.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 arch/arm64/boot/dts/exynos/exynos990.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos990.dtsi b/arch/arm64/boot/dts/exynos/exynos990.dtsi
index 4446a1a54ba2de56879353c9c4a898b1d697fc13..bd5e086ac46d3010ace413e2eeb2cd30d7f7672c 100644
--- a/arch/arm64/boot/dts/exynos/exynos990.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos990.dtsi
@@ -278,6 +278,37 @@ cmu_hsi0: clock-controller@10a00000 {
 				      "dpgtc";
 		};
 
+		usbdrd_phy: phy@10c00000 {
+			compatible = "samsung,exynos990-usbdrd-phy";
+			reg = <0x10c00000 0x100>;
+			clocks = <&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_ACLK_PHYCTRL>,
+				 <&oscclk>;
+			clock-names = "phy", "ref";
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		usbdrd: usb@10e00000 {
+			compatible = "samsung,exynos990-dwusb3",
+				     "samsung,exynos850-dwusb3";
+			ranges = <0x0 0x10e00000 0x10000>;
+			clocks = <&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_BUS_CLK_EARLY>,
+				 <&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_USB31DRD_REF_CLK_40>;
+			clock-names = "bus_early", "ref";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			usbdrd_dwc3: usb@0 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x10000>;
+				interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usbdrd_phy 0>;
+				phy-names = "usb2-phy";
+			};
+		};
+
 		pinctrl_hsi1: pinctrl@13040000 {
 			compatible = "samsung,exynos990-pinctrl";
 			reg = <0x13040000 0x1000>;

-- 
2.47.2


