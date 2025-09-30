Return-Path: <linux-kernel+bounces-837438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA56BAC539
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A067A83BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6592FBE06;
	Tue, 30 Sep 2025 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JooDNA4E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4B2F39DC;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225052; cv=none; b=W4hYBv3ZoRul4DSxZoZMKIA+04Ktsf6v7ChWYo94Fy7/mZRwf72Ukw14ueB0HojrG+iO84H/GFIcvB4H0CMMsrvQrFfI1HzURIrumUEsEIBySrBAq65YJBi/i+ZaRC5pKouDQRiIh/vpd540+iXUAiMcikisrXUyNlYv3k/Y/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225052; c=relaxed/simple;
	bh=IcxSHLYl5CZjSo//DJmvH58mP+K43m312XKis/pZlLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U0T5HMdFIlgwUYiWB9xxBwnpH7o+JYkHxbwLevCTWQvG8m4Yd0OX3jURAzny3Za9QRRGVqmdtlFs43UU/ZDpMoYrRKHIoR/RLO6rYnwk5gHsolxZPKqaIR/1Oot+YqF0EFjFiY0XAq+QNaSOrn+27Ifxfl0Z+cFg2yrBDD6iZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JooDNA4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1369C4CEF0;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759225051;
	bh=IcxSHLYl5CZjSo//DJmvH58mP+K43m312XKis/pZlLY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JooDNA4EJDKqRyRYYW/VZUuBjy/yvR/FfKQ/9jUaj8GkQDMbdrY/h8hFc/zffWRYY
	 5QUBx11BAkcZSflWwoDL0e2uLMZ1AnmejwPNgEHEV20HvBg1uYHBiPssGwjQSJBNzv
	 5eemiK/sDWr+oRc6I7AuPODsIA+Ha1ICh4AUC7lzGUDqaPHktGwR9L6y2Vs3f7FmBz
	 7KozslKw+mWqF6jiNaloHRR6pNmi6lmIrzii7rBGGLb01VsgiofTv0OraFrGGIXKGG
	 /j8/aCZPKPpMJYZVo8bPFJ+zBzDL6luHqOiYhT8wRu5y7n9UOjjyPkVLr0URkWGrmh
	 P08DWXXhCsg8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF0CAC5B9;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 30 Sep 2025 17:37:23 +0800
Subject: [PATCH 10/19] arm64: dts: amlogic: A4: Add PLL controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-a4_a5_add_clock_driver-v1-10-a9acf7951589@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759225047; l=1225;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=oAaJfXCorPN/I+5LCtKFDD1NM9mVnKs2qOf9ZPCvDw8=;
 b=d6myvlj/U/L13Tj+S+Ji4Dk0XtVUxazgUUq9FsVE1ThmjBA/nzBhUa5xmY5macDs7lO7hGqSI
 M9QAVPVu/svDybUns5YQEHYuQU2bWzRntvXYsqFUQFx2sqtfKKQZrZT
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the PLL controller node for A4 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index 75a87f093d8d..aca81e658654 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -7,6 +7,9 @@
 #include "amlogic-a4-reset.h"
 #include <dt-bindings/power/amlogic,a4-pwrc.h>
 #include <dt-bindings/pinctrl/amlogic,pinctrl.h>
+#include <dt-bindings/clock/amlogic,a4-pll-clkc.h>
+#include <dt-bindings/clock/amlogic,a4-scmi-clkc.h>
+
 / {
 	cpus {
 		#address-cells = <2>;
@@ -198,6 +201,16 @@ gpio_intc: interrupt-controller@4080 {
 			<10 11 12 13 14 15 16 17 18 19 20 21>;
 	};
 
+	clkc_pll: clock-controller@8000 {
+		compatible = "amlogic,a4-pll-clkc";
+		reg = <0x0 0x8000 0x0 0x1a4>;
+		#clock-cells = <1>;
+		clocks = <&xtal>,
+			 <&scmi_clk CLKID_FIXED_PLL>;
+		clock-names = "xtal",
+			      "fix";
+	};
+
 	ao_pinctrl: pinctrl@8e700 {
 		compatible = "amlogic,pinctrl-a4";
 		#address-cells = <2>;

-- 
2.42.0



