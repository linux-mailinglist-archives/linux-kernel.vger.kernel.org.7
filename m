Return-Path: <linux-kernel+bounces-781210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBF6B30F35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4600D17D666
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841A32E6137;
	Fri, 22 Aug 2025 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OleJAlpX"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C002E54CC;
	Fri, 22 Aug 2025 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844859; cv=none; b=s7DCJhCB0rtEzvrvFrkIckjeNI4p/0Q6EDfmBpuQQpZp1QH7/KRTAQJdgOFPtFZjs9erU/Xsar4+BqziaI3jga3hvTKERWYYF90ztUrh1zplDSCdTmzdUmURBP1n3nA9hic2PZ9dViu3NdfvmYHGB4XkBY3B4bdwAh3nuKHHlDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844859; c=relaxed/simple;
	bh=I+nprd4XKv9b7xxgKYJmPkEjWpC9unrbulKXwD4ZO+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVvPHYvSKrYNrUmWm85EBDQOAwJ4WpCM+3Nfn+335m0VRmSiCwt/SAhWqFbSeHBHx4S4MpJCxzZcCv6I8ot2xavdFuRHKOpcD35L+jSNtmqIcTH8K1s1MCwOc1L6Xj378ZXc/RLdr922aXtJVpwbhwQcvmSEGTsCfYosjFvrbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OleJAlpX; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=HA
	NX8SGyUYTMmygkXUKgrV9E1KMjquu/Hj3lDx24v3U=; b=OleJAlpXnekUIDBtyH
	Be7UdN73GWIk4WY8BPu/RFFWmg8rmJ4d5tDpua7GM0a8pjeiyvOLXIKap+HsMzr0
	Kxm/i6ApnkeBP0TjJikkuvZnFpgvZFXGCfRGBrnKWRo2inLdlrz/eI9HelknoINw
	y9OJdAs+q+nL8M62ttc5T7cEQ=
Received: from ProDesk.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAn9_zCEKhoYtibAA--.23257S11;
	Fri, 22 Aug 2025 14:40:27 +0800 (CST)
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
Subject: [PATCH v7 09/10] arm64: dts: rockchip: Enable DisplayPort for rk3588s Cool Pi 4B
Date: Fri, 22 Aug 2025 14:39:53 +0800
Message-ID: <20250822063959.692098-10-andyshrk@163.com>
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
X-CM-TRANSID:PigvCgAn9_zCEKhoYtibAA--.23257S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur48WF43Gr1rWFyfKrWUtwb_yoW8CryDp3
	ZxArsYgFZ7urWUJ3sYyF4xJrZ8Crs5ua97Jr13Z34akF47Was3twn3GrnYkryjvFs3Xayr
	Kr4kZasF9F1DXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwHUDUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gCxXmioDHlx2wAAsi

From: Andy Yan <andy.yan@rock-chips.com>

Enable the Mini DisplayPort on this board.
Note that ROCKCHIP_VOP2_EP_DP0 is defined as 10 in dt-binding header,
but it will trigger a dtc warning like "graph node unit address error,
expected "a"" if we use it directly after endpoint, so we use "a"
instead here.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

---

(no changes since v2)

Changes in v2:
- Sort in alphabetical order

 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index b2947b36fadaf..d7557e61390b9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -39,6 +39,18 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	dp-con {
+		compatible = "dp-connector";
+		label = "DP OUT";
+		type = "mini";
+
+		port {
+			dp_con_in: endpoint {
+				remote-endpoint = <&dp0_out_con>;
+			};
+		};
+	};
+
 	hdmi-con {
 		compatible = "hdmi-connector";
 		type = "d";
@@ -215,6 +227,24 @@ &cpu_b2 {
 	cpu-supply = <&vdd_cpu_big1_s0>;
 };
 
+&dp0 {
+	status = "okay";
+	pinctrl-0 = <&dp0m0_pins>;
+	pinctrl-names = "default";
+};
+
+&dp0_in {
+	dp0_in_vp2: endpoint {
+		remote-endpoint = <&vp2_out_dp0>;
+	};
+};
+
+&dp0_out {
+	dp0_out_con: endpoint {
+		remote-endpoint = <&dp_con_in>;
+	};
+};
+
 &gpu {
 	mali-supply = <&vdd_gpu_s0>;
 	status = "okay";
@@ -890,3 +920,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi0_in_vp0>;
 	};
 };
+
+&vp2 {
+	vp2_out_dp0: endpoint@a {
+		reg = <ROCKCHIP_VOP2_EP_DP0>;
+		remote-endpoint = <&dp0_in_vp2>;
+	};
+};
-- 
2.43.0


