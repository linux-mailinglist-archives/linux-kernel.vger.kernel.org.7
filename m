Return-Path: <linux-kernel+bounces-732829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F45B06C84
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1AA07AF6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C3227510F;
	Wed, 16 Jul 2025 04:05:47 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5472147E3;
	Wed, 16 Jul 2025 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752638747; cv=none; b=LG9iHdEKSJcZlYXyMrs8q/FYLgfGUHWFzOeUrL8lTbInCBlr/OUEXfjYNSSx404hIU0tvKLLRUQGBUcr3fs5h+T8ESPwdzcYU7YMde9WdRAwzPBoN8rhzVGYS2nWbZevmhod/j32RWPvmFGFk9hdeKR0FF0xLmf81gASHWkYIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752638747; c=relaxed/simple;
	bh=DthxudIzpcohRCT/rEWYCYVzQEWZ5titrOEgy8ZInMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1TXf3Mlub+XgJyXN351hOL1/CYXZVy6JrAR/c+6L4g/gR0Iz8Nsp4gqKb/prQnY8Uh1uU7jSu/QVJimLf9MM++owOjAgG37T1GP/zzORJSsFwb3SR38aDASjvKdLuuup35nlTOZ/8vwkWdqOt9LXLabnBnf/pETnk1s/hoyc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 18151B4D173D;
	Wed, 16 Jul 2025 06:05:39 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: E Shattow <e@freeshell.de>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: starfive: jh7110-common: add status power led node
Date: Tue, 15 Jul 2025 21:04:54 -0700
Message-ID: <20250716040500.178287-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add status power led node for StarFive VisionFive2 and variant boards.

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 4baeb981d4df..2eaf01775ef5 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -8,6 +8,7 @@
 #include "jh7110.dtsi"
 #include "jh7110-pinfunc.h"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
 
 / {
@@ -38,6 +39,14 @@ gpio-restart {
 		priority = <224>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led_status_power: led-0 {
+			gpios = <&aongpio 3 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	pwmdac_codec: audio-codec {
 		compatible = "linux,spdif-dit";
 		#sound-dai-cells = <0>;

base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
-- 
2.50.0


