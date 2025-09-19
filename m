Return-Path: <linux-kernel+bounces-824250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8CEB8880C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7ABB5A060A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102462ED845;
	Fri, 19 Sep 2025 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E38w/Yds"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE21CEACB;
	Fri, 19 Sep 2025 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272572; cv=none; b=oNWg6HmhO8wPsmZLnP/9gA0i3j/jqnY+06j0LDvJmFpSOzfGR/1ZywnxZBES86pO1Pw5YmAy6iC0M8/9rLwxAqi4H0qZAKjRu8emxif0naumrcU2SeenOAhSF7PIdbnk53EeUmuGq7UxIw/unlRlJHAOjyTP8zxceZQC60cSNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272572; c=relaxed/simple;
	bh=QnqUEnpeLq9ge4Og296heLwMfc1HMVf6E6vKR5SfUvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mHxfQwDFncsJBpn8cUDlpx0w5WGN6iehP3pRbUEYz4Wp+X3LnSLnwoEbBaE3DdZDCTFB6wdQgoLSBlDC0OhMpdm9p81g1qps5gjMG4q0h2BilWQIBhG7xL5GN34QzMbJSQYRzAGgT8rpWxaNYbuIeQyckXG2cMS2zMDLT4d0AVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E38w/Yds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0440C4CEF1;
	Fri, 19 Sep 2025 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272571;
	bh=QnqUEnpeLq9ge4Og296heLwMfc1HMVf6E6vKR5SfUvc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=E38w/YdsnZ9PM9bSqTcUODxorau6UBsEe1kSQ0y3sMhTJJHyzLsnmmoTyF3kMYTVN
	 Idu8bL2erULMLCYZ1U9kE5A+hJs6CNgRXcVQYQJd8WoB4RVBLNu0BzerWwMH5iglYY
	 oVU5NzYSoPu3smgV0E1pPjxeqtwtjxBdB6uMocCzK8pp56zRuC5ItW4GBETPQeK1Ar
	 tVGYT0N0ZCURrP+kwm9lKJEBhbNb03/+a4S0Z8HTR4aSDp3xOkW4fJhtC1+OO8p22i
	 0to9oxWU6/XKsFNcqPdGIoN++OlWgvNZA5v594aK5BDFfPhW345o6k92Ni01NbbTWJ
	 m9L9bfoVwpv6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC93BCAC592;
	Fri, 19 Sep 2025 09:02:51 +0000 (UTC)
From: Joel Selvaraj via B4 Relay <devnull+foss.joelselvaraj.com@kernel.org>
Date: Fri, 19 Sep 2025 04:02:29 -0500
Subject: [PATCH] arm64: dts: qcom: sdm845-shift-axolotl: fix touchscreen
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-shift-axolotl-fix-touchscreen-dts-v1-1-60e26ad4e038@joelselvaraj.com>
X-B4-Tracking: v=1; b=H4sIACUczWgC/x2NQQqAIBAAvxJ7bqGsiPpKdBBdcyE0XIsg+nvSc
 WCYeUAoMQnM1QOJLhaOoUBbV2C8Dhsh28KgGjU0UzuheHYZ9R33mHd0fGOOp/FiElFAmwW102r
 sjeo6S1A6R6Ki/Y9lfd8P3kSGknMAAAA=
X-Change-ID: 20250919-shift-axolotl-fix-touchscreen-dts-afa274c233de
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758272571; l=1992;
 i=foss@joelselvaraj.com; s=20250919; h=from:subject:message-id;
 bh=6LBH+r1kb4SLbj+q2QfBWT2d9IJvx4qETyl2gI3HG/E=;
 b=A//B6TSPiw9hGoryvpzwQBGolYnGD8pHdgBCJFbRqADxMePhaVm8ZvlzGqjNC64tW080SNCPE
 x1J7WRb5LM7ASwcLijqa2/VDMrzeeBrDN6RViRYR/cErbb3YzNvwWyX
X-Developer-Key: i=foss@joelselvaraj.com; a=ed25519;
 pk=BBMos4ph15apUFh2AkG9rLZIrBWl5LD4egPOhEv63X0=
X-Endpoint-Received: by B4 Relay for foss@joelselvaraj.com/20250919 with
 auth_id=529
X-Original-From: Joel Selvaraj <foss@joelselvaraj.com>
Reply-To: foss@joelselvaraj.com

From: Joel Selvaraj <foss@joelselvaraj.com>

The touchscreen properties previously upstreamed was based on downstream
touchscreen driver. We ended up adapting upstream edt_ft5x06 driver to
support the FocalTech FT5452 touchscreen controller used in this device.
Update the touchscreen properties to match with the upstream edt_ft5x06
driver. Also, as mentioned, the touchscreen controller used in this
device is ft5452 and not fts8719. Fix it.

Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 89260fce6513937224f76a94e1833a5a8d59faa4..d4062844234e33b0d501bcb7d0b6d5386c822937 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -434,20 +434,19 @@ &i2c5 {
 	status = "okay";
 
 	touchscreen@38 {
-		compatible = "focaltech,fts8719";
+		compatible = "focaltech,ft5452";
 		reg = <0x38>;
-		wakeup-source;
-		interrupt-parent = <&tlmm>;
-		interrupts = <125 IRQ_TYPE_EDGE_FALLING>;
-		vdd-supply = <&vreg_l28a_3p0>;
-		vcc-i2c-supply = <&vreg_l14a_1p88>;
 
-		pinctrl-names = "default", "suspend";
+		interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
+
+		vcc-supply = <&vreg_l28a_3p0>;
+		iovcc-supply = <&vreg_l14a_1p88>;
+
 		pinctrl-0 = <&ts_int_active &ts_reset_active>;
 		pinctrl-1 = <&ts_int_suspend &ts_reset_suspend>;
+		pinctrl-names = "default", "suspend";
 
-		reset-gpio = <&tlmm 99 GPIO_ACTIVE_HIGH>;
-		irq-gpio = <&tlmm 125 GPIO_TRANSITORY>;
 		touchscreen-size-x = <1080>;
 		touchscreen-size-y = <2160>;
 	};

---
base-commit: 8f7f8b1b3f4c613dd886f53f768f82816b41eaa3
change-id: 20250919-shift-axolotl-fix-touchscreen-dts-afa274c233de

Best regards,
-- 
Joel Selvaraj <foss@joelselvaraj.com>



