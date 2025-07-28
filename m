Return-Path: <linux-kernel+bounces-747679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D6AB136C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2247A189B9BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE55255F2D;
	Mon, 28 Jul 2025 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S/8GCnmo"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4579922FE15;
	Mon, 28 Jul 2025 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691413; cv=none; b=oufBjp58ZkQ+kv8EfeMGPu1ad8MF72EZnO7u4Z1/MF09t221749BZIY1udxVK1q6uRjQJkNaimb7u2eezUGCF0syncKiUn4EUEtn+mrIsVcHcB2E8qbakvKLyIb6IyXFXcaH5Y08ILlU4EVH+GTknbNNojeFPAMpJYjlgKiVWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691413; c=relaxed/simple;
	bh=zkIQ13/H9CnTVLK6A7Z4pxO6LqziG5oPt4Wp5fwiZIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFk53xawzxPnjRmW8F8akUMe5dCOn2TwDfsz8tcQWA8m5c6lC5BHiD7GNf/+qwl4eqhEV99S1ftTAo8CFMCvIhwfCURts+mvWyiFULkCaOVnp6UogZZ8jo/smmo5HjGFwutdb2vwv5L0cxa8hklt/dlCz54GQqCG5+beqGrwRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S/8GCnmo; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=h8
	8O4dZwxfFg63Pi6AQ85/YvjoNhwX4BJiQNP+yOVJw=; b=S/8GCnmoj8Kfm9VupZ
	dKSCGhnACu89x2h3z4niFY8fu3Pnkv+op9tmYteLfuW1pvm5F8mpsK5w8vNzBcDA
	OCqG6cQeHqgrrolnkjPMTddhuV+XIhmLfNPM7Arp+M2+dThFz+AeOzpU9b+yjrOD
	1tvZNBYa5qpdTwnLEtWnutZfs=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBn0Oy_NIdoxboRIA--.27423S12;
	Mon, 28 Jul 2025 16:29:08 +0800 (CST)
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
Subject: [PATCH v6 10/10] arm64: dts: rockchip: Enable DP2HDMI for ROCK 5 ITX
Date: Mon, 28 Jul 2025 16:28:35 +0800
Message-ID: <20250728082846.3811429-11-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728082846.3811429-1-andyshrk@163.com>
References: <20250728082846.3811429-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn0Oy_NIdoxboRIA--.27423S12
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrykKw18Xw43uF4kCrWkXrb_yoW8KrWrpF
	nF9rs5GryxuryYqw1FvF1kZFs8Krs5ua93Jr1aqry0yFW7Xas5K3WrWr9YqFyjvF1xXw4a
	yr4kXa4j93WDXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcvtZUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0g2YXmiHMZxh5gAAsc

From: Andy Yan <andy.yan@rock-chips.com>

The HDMI0(Port next to Headphone Jack) is drived by DP1 on rk3588
via RA620(a dp2hdmi converter).

Add related dt nodes to enable it.

Note: ROCKCHIP_VOP2_EP_DP1 is defined as 11 in dt-binding header,
but it will trigger a dtc warning like "graph node unit address
error, expected "b"" if we use it directly after endpoint, so we
use "b" instead here.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

---

(no changes since v3)

Changes in v3:
- Add RA620 into bridge chain.

 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
index 7de17117df7ae..903ad42f97177 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
@@ -57,6 +57,29 @@ analog-sound {
 			  "Headphone", "Headphones";
 	};
 
+	bridge {
+		compatible = "radxa,ra620";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@0 {
+				reg = <0>;
+				hdmi_bridge_in: endpoint {
+					remote-endpoint = <&dp1_out_con>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				hdmi_bridge_out: endpoint {
+					remote-endpoint = <&hdmi_con_in>;
+				};
+			};
+		};
+	};
+
 	gpio-leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -73,6 +96,17 @@ hdd-led2 {
 		};
 	};
 
+	hdmi0-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_bridge_out>;
+			};
+		};
+	};
+
 	hdmi1-con {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -268,6 +302,24 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
+&dp1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp1m0_pins>;
+};
+
+&dp1_in {
+	dp1_in_vp2: endpoint {
+		remote-endpoint = <&vp2_out_dp1>;
+	};
+};
+
+&dp1_out {
+	dp1_out_con: endpoint {
+		remote-endpoint = <&hdmi_bridge_in>;
+	};
+};
+
 &gpu {
 	mali-supply = <&vdd_gpu_s0>;
 	status = "okay";
@@ -1261,3 +1313,10 @@ vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
 		remote-endpoint = <&hdmi1_in_vp1>;
 	};
 };
+
+&vp2 {
+	vp2_out_dp1: endpoint@b {
+		reg = <ROCKCHIP_VOP2_EP_DP1>;
+		remote-endpoint = <&dp1_in_vp2>;
+	};
+};
-- 
2.43.0


