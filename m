Return-Path: <linux-kernel+bounces-843769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A2BC033F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B07974E84B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C94C200BBC;
	Tue,  7 Oct 2025 05:36:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D011B0437
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759815382; cv=none; b=Bb24jBCRttFxzUm5QcL7qPWq/aCdrAlMFifB9yZPmaYrM5WdKE1T0JbJELj8SupCkyoaO5daZ/iPVArJRxNf80CuRzIbcFhUpPxKNquZ2e3e8ZP4r7tJ1qVzY2fRq727neCzJ7NGxTl4kc6311tb4+ja4tehPJ6GJEm5y9vP1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759815382; c=relaxed/simple;
	bh=zz6lPYQ1IJfuZS0Yj9SN8f1ym0BJqcUgvwAez0hXJaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aznQ6lW2TAXsZhOxQDdoh4F90xZGlcJVzd9w+kpPmmBqgOc/EEdbNcIGg5AYu//AAZomvx2/ENUA1r6Cl7emWO03y5fk04uxSK8pcsdiJBCfp/HAxsScn+2M4+vP8uiw55MmbqppL/qtTJHQw7Fpg8NbHUHQW4ko3YWp2TLMDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1v60Mv-0002SK-Fp; Tue, 07 Oct 2025 07:36:13 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1v60Mu-002Li7-11;
	Tue, 07 Oct 2025 07:36:12 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1v60Mu-0000000C6Jh-12wQ;
	Tue, 07 Oct 2025 07:36:12 +0200
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Tue, 07 Oct 2025 07:36:02 +0200
Subject: [PATCH] ARM: dts: stm32: lxa: drop unnecessary vusb_d/a-supply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-lxa-usb-dt-v1-1-cacde8088bb9@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAMGm5GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNz3ZyKRN3S4iTdlBLd5NQkA0MLS2NLs1QzJaCGgqLUtMwKsGHRsbW
 1AF85bcxcAAAA
X-Change-ID: 20251007-lxa-usb-dt-ceb0189396e6
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The LXA device trees are the only STM32MP1 device tree that specify
vusb_d/usb_a-supply and apparently not for good reason:

- vusb_d-supply (vdd_usb) is the same as the phy-supply for usbphyc_port1
- vusb_a-supply (reg18) is the same as vdda1v8-supply for usbphyc_port1

and usbphyc_port1 is linked to the usbotg_hs node via the phys property.

Specifying the regulators in the &usbotg_hs node is thus superfluous and
has been even found to be harmful in one instance:
Linux v6.10 was found to lock up every 50-125 or so reboots on the LXA
TAC when the DWC2 driver probe enables the regulators in bulk, unless
both properties were removed.

This issue was so far not reproducible on v6.17 (> 500 reboots), but as
these properties are unnecessary and different from other STM32MP1
boards, remove them anyway.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi | 3 ---
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi       | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi b/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi
index 9eeb9d6b5eb0ed35d4a83b743e8007f19422e2ed..7d3a6a3b5d09ea06689ebca11eda48785207aa31 100644
--- a/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi
@@ -374,9 +374,6 @@ &usbotg_hs {
 	phys = <&usbphyc_port1 0>;
 	phy-names = "usb2-phy";
 
-	vusb_d-supply = <&vdd_usb>;
-	vusb_a-supply = <&reg18>;
-
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
index be0c355d3105b89d4374d4f6972c7927970f06b1..9179075f2ead14a4deb45fcd2cefd60ab426a8d8 100644
--- a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
@@ -493,9 +493,6 @@ &usbotg_hs {
 	phys = <&usbphyc_port1 0>;
 	phy-names = "usb2-phy";
 
-	vusb_d-supply = <&vdd_usb>;
-	vusb_a-supply = <&reg18>;
-
 	g-rx-fifo-size = <512>;
 	g-np-tx-fifo-size = <32>;
 	g-tx-fifo-size = <128 128 64 16 16 16 16 16>;

---
base-commit: 33f3d92bd1bee0e37d68124dd6e7df793a6af745
change-id: 20251007-lxa-usb-dt-ceb0189396e6

Best regards,
-- 
Ahmad Fatoum <a.fatoum@pengutronix.de>


