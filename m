Return-Path: <linux-kernel+bounces-881255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0669DC27D6E
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C575F4E50A5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4EE2F6567;
	Sat,  1 Nov 2025 12:05:36 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B32F6182;
	Sat,  1 Nov 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998736; cv=none; b=T6Hp7HyxhesKkbqdAesp/7FtewNdvnNCVVmxI/zsBX4FV2dZhE6zNp80pewp4zmlMylx35vIZ+vfOSv/9PNLd6ruc3s+/PvUVkXlc1oErBVMsuvs3gWiSnJtVevNlZ6l5agXfo7awZ0VfymjCJdNxAbDPxlaAIwbkQZ168u2FNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998736; c=relaxed/simple;
	bh=3oOcn6xt6Ma6qjR9nrnkUMbIKeJShmKJv+VGXlErhyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kB5nR2Ln7D7GrtO0kbrJa5OGyGD2nh1EjJMtURTLGwuGChtODEm0L/pg1OVd91kajs8dExo1kthU4DLz8wezUiyrlJTdIB25RVPi33HomaG3h0Ba8V3mT0GXDrme1tqojHzYubR+GQzQyT63OD9KcP4k22JrFIHg3+W2Y7+dY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [58.61.140.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2801cc497;
	Sat, 1 Nov 2025 20:00:20 +0800 (GMT+08:00)
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
Subject: [PATCH 3/6] arm64: dts: rockchip: fixes ethernet for 100ASK DshanPi A1
Date: Sat,  1 Nov 2025 20:00:07 +0800
Message-Id: <20251101120010.41729-3-amadeus@jmu.edu.cn>
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
X-HM-Tid: 0a9a3f4a3aaa03a2kunmfa682f8b2d3699
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGE5NVkpLTUJKGUxCTUMfQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0tVSkhPWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+

Currently, Ethernet is unusable due to an incorrect PHY address.
This commit fixes this, removes the incorrect 25M clock pinctrl,
and adds the missing PHY supply.

Fixes: d809417c5a40 ("arm64: dts: rockchip: add DTs for 100ASK DShanPi A1")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../dts/rockchip/rk3576-100ask-dshanpi-a1.dts     | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
index f8bc401e796f..425a78db9522 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
@@ -192,6 +192,7 @@ &gmac0 {
 	clock_in_out = "output";
 	phy-mode = "rgmii-id";
 	phy-handle = <&rgmii_phy0>;
+	phy-supply = <&vcc_3v3_s0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&eth0m0_miim
 		     &eth0m0_tx_bus2
@@ -205,13 +206,13 @@ &gmac1 {
 	clock_in_out = "output";
 	phy-mode = "rgmii-id";
 	phy-handle = <&rgmii_phy1>;
+	phy-supply = <&vcc_3v3_s0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&eth1m0_miim
 		     &eth1m0_tx_bus2
 		     &eth1m0_rx_bus2
 		     &eth1m0_rgmii_clk
-		     &eth1m0_rgmii_bus
-		     &ethm0_clk1_25m_out>;
+		     &eth1m0_rgmii_bus>;
 	status = "okay";
 };
 
@@ -618,10 +619,9 @@ es8388: audio-codec@10 {
 };
 
 &mdio0 {
-	rgmii_phy0: phy@1 {
+	rgmii_phy0: phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0x1>;
-		clocks = <&cru REFCLKO25M_GMAC0_OUT>;
+		reg = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&gmac0_rst>;
 		reset-assert-us = <20000>;
@@ -631,10 +631,9 @@ rgmii_phy0: phy@1 {
 };
 
 &mdio1 {
-	rgmii_phy1: phy@1 {
+	rgmii_phy1: phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0x1>;
-		clocks = <&cru REFCLKO25M_GMAC1_OUT>;
+		reg = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&gmac1_rst>;
 		reset-assert-us = <20000>;
-- 
2.25.1


