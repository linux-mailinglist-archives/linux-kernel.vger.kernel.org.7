Return-Path: <linux-kernel+bounces-724500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1733AFF3B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D875A572C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B1D23AE87;
	Wed,  9 Jul 2025 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="F1nQVyAE"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F121A92F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752095324; cv=none; b=GPI2wkxFdAsTFJ/WP3R683KsVTukeCquzImchsA9V4p4rBWBE1kA6UYbL1hvv73m1W1tPPp0Na6VcYpzIiblWgwpOUYtOwuFqMSw79YmnG9cJ5NJ4i2rVRDi2QuijMTSGLhZsHQFouSXHmx8EQCJd+0WkwjbyKNizo935wdby3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752095324; c=relaxed/simple;
	bh=/sPHUll0HVA/zIYX4UgOh3ke6kfWHMxnpwreuceuMeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mc5tM1Ifp1z8OzxKafQcFj4f4B5jluuuDUAu+PgxiR6AYyXwrbZZfKe8NEt65ejhvwTFQYNeNhYbC0DC9riAtHHGYdwOzzBJvmSXHGIOIkeBQHcYLSryqfp3ZsTfj5jivgsMrAxWWhMcZ9xSVVcXR8Bzdg/TyxMT0FN+VsZGR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=F1nQVyAE; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1752095321;
 bh=yLPdjZGdoWUbTfAy2GwqZq8+x71kvvXbnWtl1wzXyRk=;
 b=F1nQVyAE0MXjmaRM9CJomt9wiM5mgfw+uVBEc9jJuhZ1/vGctTd1Kd25tgDk6qYds8PF0IM8o
 U5jaTPMi9pQ9LYsFoUM+4jfsW/a5tq5pN+j28pK7cN5Q0YuetKVQH8Tp5jOnUhA96bFl1UYcu9E
 /Agoiv2VoYyg8Uhqp2dq3zRdqoAblBvCNYY8u5NXesBAiam74lYpuXSfibtCE7E5IE99Ev3V66D
 QW29496d7KUC6DKTPrjuyNV9gDgNVaoUtrwU99JEFD8oN31EPWXPbBUr15HNKU4qQO+k3nAzGxj
 0/SrfwEKJAVJQNWa1yTrqHzlR2+J4mmpqWVAanrUKvGA==
X-Forward-Email-ID: 686eda55c4bb2e061789d0d3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Fix UART DMA support for RK3528
Date: Wed,  9 Jul 2025 21:08:28 +0000
Message-ID: <20250709210831.3170458-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to use UART2 DMA for Bluetooth on ArmSoM Sige1 result in tx
timeout when using dma-names = "tx", "rx" as required by the dt-binding:

  Bluetooth: hci0: command 0x0c03 tx timeout
  Bluetooth: hci0: BCM: Reset failed (-110)

Change the dmas order to fix UART DMA support on RK3528.

With this fixed Bluetooth can be loaded using DMA on ArmSoM Sige1:

  Bluetooth: hci0: BCM: chip id 159
  Bluetooth: hci0: BCM: features 0x0f
  Bluetooth: hci0: BCM4362A2
  Bluetooth: hci0: BCM4362A2 (000.017.017) build 0000
  Bluetooth: hci0: BCM4362A2 'brcm/BCM4362A2.hcd' Patch
  Bluetooth: hci0: BCM: features 0x0f
  Bluetooth: hci0: BCM43752A2 UART 37.4MHz Ampak AP6398 sLNA iLNA CL1 [Version: 1091.1173]
  Bluetooth: hci0: BCM4362A2 (000.017.017) build 1173

Fixes: ab6fcb58aedf ("arm64: dts: rockchip: Add UART DMA support for RK3528")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This can be verified with an upcoming v2 of "arm64: dts: rockchip: Add
ArmSoM Sige1" [1].

[1] https://lore.kernel.org/r/20250708224921.2254116-5-jonas@kwiboo.se
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index b215126efcc2..001a555c83b7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -595,7 +595,7 @@ uart0: serial@ff9f0000 {
 			clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmac 8>, <&dmac 9>;
+			dmas = <&dmac 9>, <&dmac 8>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -607,7 +607,7 @@ uart1: serial@ff9f8000 {
 			clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmac 10>, <&dmac 11>;
+			dmas = <&dmac 11>, <&dmac 10>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -619,7 +619,7 @@ uart2: serial@ffa00000 {
 			clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmac 12>, <&dmac 13>;
+			dmas = <&dmac 13>, <&dmac 12>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -631,7 +631,7 @@ uart3: serial@ffa08000 {
 			clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmac 14>, <&dmac 15>;
+			dmas = <&dmac 15>, <&dmac 14>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -643,7 +643,7 @@ uart4: serial@ffa10000 {
 			clocks = <&cru SCLK_UART4>, <&cru PCLK_UART4>;
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmac 16>, <&dmac 17>;
+			dmas = <&dmac 17>, <&dmac 16>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -655,7 +655,7 @@ uart5: serial@ffa18000 {
 			clocks = <&cru SCLK_UART5>, <&cru PCLK_UART5>;
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmac 18>, <&dmac 19>;
+			dmas = <&dmac 19>, <&dmac 18>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -667,7 +667,7 @@ uart6: serial@ffa20000 {
 			clocks = <&cru SCLK_UART6>, <&cru PCLK_UART6>;
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmac 20>, <&dmac 21>;
+			dmas = <&dmac 21>, <&dmac 20>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -679,7 +679,7 @@ uart7: serial@ffa28000 {
 			clocks = <&cru SCLK_UART7>, <&cru PCLK_UART7>;
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmac 22>, <&dmac 23>;
+			dmas = <&dmac 23>, <&dmac 22>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
-- 
2.49.0


