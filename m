Return-Path: <linux-kernel+bounces-733274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FB2B07290
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08197A2695
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3AE2F2730;
	Wed, 16 Jul 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hs9Uwhbk"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10E92F1FF3;
	Wed, 16 Jul 2025 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660347; cv=none; b=A1/B+ofOpK8/gfb6iI+vJC7929uSzIH0w6B9umlYxCw0Wwa+ufvLY6pWrw4sK9Axf44F+c3p93fOCOLCHFMTqiFDQ5Q0+CenAYDW3akuVWj9lzrTaEXVYbaSLhwAIHhPKt2+a0FAjaAUXM0qmJcNRBy2JtpFpj716X0TS/uoXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660347; c=relaxed/simple;
	bh=prhs1fwZMMGiQNm65qqtpDtyHAygwhDTa8hqJRJbJc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jR2H1DnPhjEg4mt82LKtVK6mnZYdgF5fJwg5VaLxT1uFf8/zjo7kjdyOgBwTzUeXlyqzCrcKQa7PYVhP1uJ2Kv9SkrHHZOG409Y/dtyh2KNesXTJWO4Kgjs71MS0GD22liSqo9ednNMReFMSCvsbXw5fFYI5b3jXeSGzk2zW83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hs9Uwhbk; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=F5
	Mn/v7RZ7UFx8WGpT30YpU6PJiEWQ1DE0lZ8cE+J4c=; b=hs9UwhbknfRDF1YPgz
	xYhlgvomvCK7k5DanIwc++TwoQi38jkcATqUl6HL6ovWrZfIZ+P6iEMNo7Eb1dXU
	ndEZLqLf8NFIrq/cpSC56oY+yCQBLbzoiCd0JyObxo2eo40577UAk92TxNgubflr
	CbfDPLrPsjEoSsBorx6fxBH3I=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH0s46eXdoG0BuFQ--.1985S10;
	Wed, 16 Jul 2025 18:05:08 +0800 (CST)
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
Subject: [PATCH v5 08/10] arm64: dts: rockchip: Add DP1 for rk3588
Date: Wed, 16 Jul 2025 18:04:35 +0800
Message-ID: <20250716100440.816351-9-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716100440.816351-1-andyshrk@163.com>
References: <20250716100440.816351-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH0s46eXdoG0BuFQ--.1985S10
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWDCry7tFWfJw17JFWDJwb_yoW8Xw4fpw
	nrurZ3GrW8uF1aqwnxt34kXrZ8A3Z5CFZrKr1xK3W8Kr1Sqr92k34akrZ3C34UXr17XwsF
	kFs3tryUKF4qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8a9-UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkBOMXmh3dCSOzAAAsc

From: Andy Yan <andy.yan@rock-chips.com>

The DP1 is compliant with the DisplayPort Specification
Version 1.4, and share the USBDP combo PHY1 with USB 3.1
HOST1 controller.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 .../arm64/boot/dts/rockchip/rk3588-extra.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 90414486e466f..691fe941d53a1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -210,6 +210,36 @@ i2s10_8ch: i2s@fde00000 {
 		status = "disabled";
 	};
 
+	dp1: dp@fde60000 {
+		compatible = "rockchip,rk3588-dp";
+		reg = <0x0 0xfde60000 0x0 0x4000>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DP1>, <&cru CLK_AUX16M_1>,
+			 <&cru CLK_DP1>, <&cru MCLK_I2S8_8CH_TX>,
+			 <&cru MCLK_SPDIF5_DP1>;
+		clock-names = "apb", "aux", "hdcp", "i2s", "spdif";
+		assigned-clocks = <&cru CLK_AUX16M_1>;
+		assigned-clock-rates = <16000000>;
+		resets = <&cru SRST_DP1>;
+		phys = <&usbdp_phy1 PHY_TYPE_DP>;
+		power-domains = <&power RK3588_PD_VO0>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dp1_in: port@0 {
+				reg = <0>;
+			};
+
+			dp1_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	hdmi1: hdmi@fdea0000 {
 		compatible = "rockchip,rk3588-dw-hdmi-qp";
 		reg = <0x0 0xfdea0000 0x0 0x20000>;
-- 
2.43.0


