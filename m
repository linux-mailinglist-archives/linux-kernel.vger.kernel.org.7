Return-Path: <linux-kernel+bounces-781213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C135B30F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63AD3B1BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E72E8E12;
	Fri, 22 Aug 2025 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OyE6Pn5k"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9DE2E763E;
	Fri, 22 Aug 2025 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844864; cv=none; b=pMAY5bEAwxvJTwfK05eN6nwvDt1HqqKKd+UA+YIv4BLW9mRRnxb5bCUWSXzCtlRyUXH4e3fzGjwijzbU+lfgdU7BdV0rS8u6pPhCiZd2QEnPVyHjwCe6Pf7aOE2THgJi9NqzQm5Gqc4slrEqDeYeV+cY0T8QMnfJRz+u+bqiaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844864; c=relaxed/simple;
	bh=FcumcV2Whbcu58LzChSEs7DamIEIn4LvHWaXu+hFJWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVKejzrcs08hJSolgD32OxViqOOm8mFimHuE9lWj3G3IS6Z8nF+QOFO2pkl2o0466NQTZnCngcTwvplvWV4EvcwYc8/ltRPbMT6iHSNHDiZziFl3BlXZR8jxYi0r7qgpa62iXoSGTLqsLglAqnhIpswUnsq2gMStzq+cSpkBSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OyE6Pn5k; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=R7
	lVxMHBGqRXSFM3wkc9nmiY62qEr5W27qh0df8q1wc=; b=OyE6Pn5kjDPrTYHFiq
	HQ+QIf94JAj9um1+9Eb97peJCCI9cny0v2c1bjEPFCucr+eDwrp5nN7RxL/+sole
	M2ta5l5sC7WS4SJ0+fI/kDYPuapkm3Mfbs4TZ+IB+zfp5dvRQIxvEJ3KrIGDS2Qm
	aQXUwD2ZW8rRUOHUoJARbV+GI=
Received: from ProDesk.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAn9_zCEKhoYtibAA--.23257S9;
	Fri, 22 Aug 2025 14:40:25 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de
Cc: hjc@rock-chips.com,
	mripard@kernel.org,
	naoki@radxa.com,
	stephen@radxa.com,
	cristian.ciocaltea@collabora.com,
	neil.armstrong@linaro.org,
	Laurent.pinchart@ideasonboard.com,
	yubing.zhang@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v7 07/10] arm64: dts: rockchip: Add DP0 for rk3588
Date: Fri, 22 Aug 2025 14:39:51 +0800
Message-ID: <20250822063959.692098-8-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822063959.692098-1-andyshrk@163.com>
References: <20250822063959.692098-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAn9_zCEKhoYtibAA--.23257S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw18CFyUCFyxJF1kJw4DXFb_yoW8WrWrp3
	ZrCrZ3XrW8uF12q39xK34ktrZ8Aan5CFZ5Kr17Gry0kr4Sqr9FkryfKr13C34DXr47ZwsF
	vFs3tryxKF4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwvtZUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEhSxXmioCP3PbgAAs9

From: Andy Yan <andy.yan@rock-chips.com>

The DP0 is compliant with the DisplayPort Specification
Version 1.4, and share the USBDP combo PHY0 with USB 3.1
HOST0 controller.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 70f03e68ba550..b8bcf450e9153 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1472,6 +1472,36 @@ dsi1_out: port@1 {
 		};
 	};
 
+	dp0: dp@fde50000 {
+		compatible = "rockchip,rk3588-dp";
+		reg = <0x0 0xfde50000 0x0 0x4000>;
+		interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DP0>, <&cru CLK_AUX16M_0>,
+			 <&cru CLK_DP0>, <&cru MCLK_I2S4_8CH_TX>,
+			 <&cru MCLK_SPDIF2_DP0>;
+		clock-names = "apb", "aux", "hdcp", "i2s", "spdif";
+		assigned-clocks = <&cru CLK_AUX16M_0>;
+		assigned-clock-rates = <16000000>;
+		resets = <&cru SRST_DP0>;
+		phys = <&usbdp_phy0 PHY_TYPE_DP>;
+		power-domains = <&power RK3588_PD_VO0>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dp0_in: port@0 {
+				reg = <0>;
+			};
+
+			dp0_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	hdmi0: hdmi@fde80000 {
 		compatible = "rockchip,rk3588-dw-hdmi-qp";
 		reg = <0x0 0xfde80000 0x0 0x20000>;
-- 
2.43.0


