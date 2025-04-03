Return-Path: <linux-kernel+bounces-586043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A9DA79A92
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 05:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D328617260E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 03:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09F61AA791;
	Thu,  3 Apr 2025 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jL4ucTu+"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12911A0714;
	Thu,  3 Apr 2025 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743651523; cv=none; b=Jwiazst2PFk5d6RCmpTZdGyMgdhdKnMXY5km305OJRqTm702PKaJZOxQGQFQYaDA5f8bpXJCB3AzRtkooBhLBmoNy5igu0xqwuLR2UayoQkYtLkMQwAiohdNBH7HFHc8IdmmRS9tBxGU/tamKb2E2DQMCXhWB9cmtBe+5fB5iQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743651523; c=relaxed/simple;
	bh=JQxaqS9tfViCe6ypFvCXamgSrDbKXlfU1xBQk/6fFpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0WPTycL2q476/n5FV1wQJm2akOsfr0ymAG6hymhglw+YS7+lTFQouxJl8hUhvqrrL8NwbpEryi3/SsiWgEtCATYykY/PGT6DtdwvivwAqzK/vfOe5DFSXcoIUtDIarYIntAtB7SFxGKZ5QtCBJRy4lqegoCS/7q58vPTAi/gP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jL4ucTu+; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=gfYR1
	7AWFdDAoFD+7Wjznah5/IIra+Cx9QmpA+CM7HM=; b=jL4ucTu+C56BVXM8EGSiS
	TYcgUZy7U/Zevk3TOftxNGTnDYwjOVi65kD688Op6kNbr7F6fhdUhjiuscczzVa1
	1Z+BvR0hdOBFPbjfjBdsuZcy1v042aNlvBVSVGqqMWBvhksSRbJk9iycyhYjMsL2
	aD5oHFwL6/195yXI8JW7JY=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHWgmNAu5n7FfDDg--.28713S8;
	Thu, 03 Apr 2025 11:38:02 +0800 (CST)
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
Subject: [PATCH v3 6/9] arm64: dts: rockchip: Add DP0 for rk3588
Date: Thu,  3 Apr 2025 11:37:34 +0800
Message-ID: <20250403033748.245007-7-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250403033748.245007-1-andyshrk@163.com>
References: <20250403033748.245007-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHWgmNAu5n7FfDDg--.28713S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyxJryUtr13Gr1rAF45GFg_yoW8Xw47p3
	ZrCrZ3XrW8uF42q3sxKr1ktrZ5Aan5CFZ3KrnrGryUKF1Sqr9FkrySgrnxA34DXr47ZwsF
	vFs3try8tFsFvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY9aPUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkAEkXmft-iHCxwABs6

From: Andy Yan <andy.yan@rock-chips.com>

The DP0 is compliant with the DisplayPort Specification
Version 1.4, and share the USBDP combo PHY0 with USB 3.1
HOST0 controller.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index a25048283410c..e07f0d7460e7a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1433,6 +1433,36 @@ i2s9_8ch: i2s@fddfc000 {
 		status = "disabled";
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


