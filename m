Return-Path: <linux-kernel+bounces-770478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A299B27B54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0811B63276
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AEB2D63F3;
	Fri, 15 Aug 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGXrrp0q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E624502C;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247062; cv=none; b=lKc2UOOAIy8mw9BCPCIJekmV7eSTPcG/Qp+kk7ZikAT5QqNx9AS3XsKIS7fSLJQUUgmMFAPMqiIArJ6kr3ONTO6e9IQKGmiQg0HK93Wtnq5wRhC3WNqsXyYtSyh7ROkqlFiNr2Us5EkVUDnRBN6W4bVS79K+Tx11Yss1YCh5SbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247062; c=relaxed/simple;
	bh=5yLR73S69Dza2YSwslzv9M45RT0dAh/D/n8Q4U3GUj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqppHdaqI1donjGxYGT2RNHU9PiP4aOwnlwKmfGkQ/mNt+dgCxiD5/EyOE9ZxrSSeFNGP7cn+M+ZOPH9VqyMZQemMgNTvxyapHDWYC/03pPr9aAzjbdv2r/LzxM+vEuFLqGy6ajvshCcdgGaXXs8oYGm21Ajl3oD86qkiDK7RZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGXrrp0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E7DFC19422;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247061;
	bh=5yLR73S69Dza2YSwslzv9M45RT0dAh/D/n8Q4U3GUj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jGXrrp0qxYVImzDOQxKoRu1G+G/wn+x6tJfhfm46tNT4S/i3tOyLlE4risb1tZMXV
	 Adeiw2ZwJV71e7hyUHJM4KnXgxYS47Ep8eWkMGdkkaeX4pDs1PVXl1+5dV7BDT2lEn
	 792VQrF796kBZcvVmMSrtqh/yrTLbU1ys61SeOV59TjTxJUDGqMwxT3bCsXWbdvtHf
	 eTJKIg1CbWZYn61uNmts4NINgU+KoPdks7kdMgTsrdhWS4eDqm7NDfFtFGcMNJME5Y
	 ev3SNdg4wnB61cw790tQhIFnZGVh7CTmI+ftnI0l3kvEJr4YNoDbxfwDWJf+ytlBBu
	 veWW4YsR2ffnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869CECA0EE6;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 15 Aug 2025 16:37:34 +0800
Subject: [PATCH 08/13] arm64: dts: amlogic: Unify the compatible property
 for clk-measure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-add-more-socs-to-support-clk_measure-v1-8-59f04ba67457@amlogic.com>
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
In-Reply-To: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755247057; l=3522;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=EHJwnnddK5r6qztNb2TJl7JYxmXy90quB+2alicslFc=;
 b=zv242H2x9f/LEwB89LfCTL3Z61M1JxVpanUqgW4kxMvHUmoNhs0D9AxOm8Z5gvO/ddNsWqG0v
 va6BgMWpjgGDcMk0PIbiWWiDNCXJscS56n/rDO9UWGfJHIWQNOfPSMD
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The clk-measure IPs across Amlogic SoCs have minimal differences, so
they can be managed with a unified compatible property.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi       | 2 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 2 +-
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi         | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi        | 1 -
 6 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index ab9ebabce171..570cac451d63 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -761,7 +761,7 @@ internal_ephy: ethernet_phy@8 {
 			};
 
 			clk_msr: clock-measure@48000 {
-				compatible = "amlogic,c3-clk-measure";
+				compatible = "amlogic,clk-measure";
 				reg = <0x0 0x48000 0x0 0x1c>;
 				clkmsr-reg-v2;
 				clkmsr-indices = <0>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index d4a4a037e0f6..e939ec6186c6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1858,7 +1858,7 @@ spicc1: spi@15000 {
 			};
 
 			clk_msr: clock-measure@18000 {
-				compatible = "amlogic,meson-axg-clk-measure";
+				compatible = "amlogic,clk-measure";
 				reg = <0x0 0x18000 0x0 0x10>;
 				clkmsr-indices = <0>,
 						 <1>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index dcc927a9da80..54220f105a4d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2385,7 +2385,7 @@ i2c0: i2c@1f000 {
 			};
 
 			clk_msr: clock-measure@18000 {
-				compatible = "amlogic,meson-g12a-clk-measure";
+				compatible = "amlogic,clk-measure";
 				reg = <0x0 0x18000 0x0 0x10>;
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 4510e3403174..4330a6284873 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -365,7 +365,7 @@ uart_C: serial@8700 {
 			};
 
 			clock-measure@8758 {
-				compatible = "amlogic,meson-gx-clk-measure";
+				compatible = "amlogic,clk-measure";
 				reg = <0x0 0x8758 0x0 0x10>;
 				clkmsr-indices = <0>,
 						 <1>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index 21a9fb27ee3f..8df234ad78e8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -630,7 +630,7 @@ internal_ephy: ethernet-phy@8 {
 			};
 
 			clk_msr: clock-measure@48000 {
-				compatible = "amlogic,s4-clk-measure";
+				compatible = "amlogic,clk-measure";
 				reg = <0x0 0x48000 0x0 0x1c>;
 				clkmsr-reg-v2;
 				clkmsr-indices = <0>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 8ecf876c73ee..2279237db793 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -478,7 +478,6 @@ &cecb_AO {
 };
 
 &clk_msr {
-	compatible = "amlogic,meson-sm1-clk-measure";
 	clkmsr-indices = <0>,
 			 <1>,
 			 <2>,

-- 
2.42.0



