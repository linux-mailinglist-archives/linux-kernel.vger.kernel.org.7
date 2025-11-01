Return-Path: <linux-kernel+bounces-881253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4814C27D59
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C8F40333F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF862F6188;
	Sat,  1 Nov 2025 12:00:41 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CFF2D1931;
	Sat,  1 Nov 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998441; cv=none; b=siWbN8ZDGxFe4kOHkdI99PCwv+JNUEAiEFNOrwt566FyEoenK0EEw22MEQWMhltn3V72SR9k3J2Z2pFqjhBcbEtCDhLRWNYhIDxibJC0uVZgkYiNkZSoNNKXgexHd3jYlb9z4aJl4AOz00q7i0FqoecaOs4l/wfawY0LReELkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998441; c=relaxed/simple;
	bh=hH70sIhsKo69Nf713QQIrRLj0ZqKvZB+LuRtHKZ9OVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qb8ZCoGyT4+z3D7RQT/ambEYdotYbauXPAq1IJDQ2FmIh/wmf2md+rWcPYQ81HrKYz1Hxd7JKhRxKBqbxCXkb2k7QsfCusgWXoBTd6cqEX8RlP4E+ftxytASnyjMa98VJGCjQeViNdmeKDpd7sHAO1K6m/2TUCyyxd37C0OoV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [58.61.140.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2801cc49d;
	Sat, 1 Nov 2025 20:00:35 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	Hsun Lai <i@chainsx.cn>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: rockchip: fixes audio for 100ASK DshanPi A1
Date: Sat,  1 Nov 2025 20:00:09 +0800
Message-Id: <20251101120010.41729-5-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251101120010.41729-1-amadeus@jmu.edu.cn>
References: <20251101120010.41729-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a3f4a74cf03a2kunmc60b64232d3765
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDS0tMVk5IHhlDSkhPHUlCHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0tVSkhPWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1VLWQ
	Y+

Correct the i2c address of the ES8388 chip and the gpio of hp_det pin.
According to the schematic, the ES8388 chip is connected to the SoC's
sai2 controller instead of sai1, fix it.

Fixes: d809417c5a40 ("arm64: dts: rockchip: add DTs for 100ASK DShanPi A1")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
index 7c961cb27032..815f75e7cd70 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
@@ -46,7 +46,7 @@ es8388_sound: es8388-sound {
 		simple-audio-card,pin-switches = "Headphone", "Line Out";
 
 		simple-audio-card,cpu {
-			sound-dai = <&sai1>;
+			sound-dai = <&sai2>;
 		};
 
 		simple-audio-card,codec {
@@ -602,18 +602,18 @@ regulator-state-mem {
 &i2c4 {
 	status = "okay";
 
-	es8388: audio-codec@10 {
+	es8388: audio-codec@11 {
 		compatible = "everest,es8388", "everest,es8328";
-		reg = <0x10>;
-		clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
+		reg = <0x11>;
+		clocks = <&cru CLK_SAI2_MCLKOUT_TO_IO>;
+		assigned-clocks = <&cru CLK_SAI2_MCLKOUT_TO_IO>;
+		assigned-clock-rates = <12288000>;
 		AVDD-supply = <&vcc_3v3_s0>;
 		DVDD-supply = <&vcc_3v3_s0>;
 		HPVDD-supply = <&vcc_3v3_s0>;
 		PVDD-supply = <&vcc_3v3_s0>;
-		assigned-clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
-		assigned-clock-rates = <12288000>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&sai1m0_mclk>;
+		pinctrl-0 = <&sai2m0_mclk>;
 		#sound-dai-cells = <0>;
 	};
 };
@@ -663,7 +663,7 @@ gmac1_rst: gmac1-rst {
 
 	headphone {
 		hp_det: hp-det {
-			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
@@ -680,12 +680,7 @@ typec5v_pwren_h: typec5v-pwren-h {
 	};
 };
 
-&sai1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&sai1m0_lrck
-		     &sai1m0_sclk
-		     &sai1m0_sdi0
-		     &sai1m0_sdo0>;
+&sai2 {
 	status = "okay";
 };
 
-- 
2.25.1


