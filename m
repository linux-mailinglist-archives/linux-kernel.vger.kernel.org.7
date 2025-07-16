Return-Path: <linux-kernel+bounces-733277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1644B07295
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3BD77A84DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488A62F3620;
	Wed, 16 Jul 2025 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j/SZUQe6"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170D92F2718;
	Wed, 16 Jul 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660348; cv=none; b=PRWlmBunCanOLCpaYCVl+m76vPgRkTsbg5KgEz6HYWWsdyhn3BmEOmn12P/07zGKPQILQ7E0lR129TMASsDYnH5Jew+p1UFXXXHfd1v6SBiQ9OpKDUjbHJ1wDbngChQl7G9e3SfFSgyL+oXcFvixdcW/heHhkLWQQ7emX8ZR/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660348; c=relaxed/simple;
	bh=414gHypClQ8qjkG9acqV6Xosykh7KjUFEInmNBBWKsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yvmx7YhBRE1ljssAbJjYq35XOahzKNSKGBVoyK5M4u/xpwwKf9lj39gO7uAfYsVGpOSBh70Hm62rL5odhs1EmJ6wBFFPCGFtmd7FKVLwBxNlSBp9iNHyvLJCd9IHNaWEAIy2mLjAEUsw0KIeMe1JZB6q/fyhaObgjSEcrmSx6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j/SZUQe6; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bi
	YaTCyrwwaaHZG3Abnb2xB6q/1qQ8ILOxOpGX0nKs4=; b=j/SZUQe60Y6uWkHgq7
	/DptRJx8Z+zfyTNi+muN+gj5Me7gw8vmtY93F1IoNRjyRTkPqk3USfCV8fbly7um
	PQvaPZkmP8XD8H0dzD3mq/BAj9H9Ob8FniYFbGoLOyOmo80i4VJIT5Lm3erkvTrM
	OEIEpuPdJ7dtANavmkEsvynoc=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH0s46eXdoG0BuFQ--.1985S11;
	Wed, 16 Jul 2025 18:05:10 +0800 (CST)
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
Subject: [PATCH v5 09/10] arm64: dts: rockchip: Enable DisplayPort for rk3588s Cool Pi 4B
Date: Wed, 16 Jul 2025 18:04:36 +0800
Message-ID: <20250716100440.816351-10-andyshrk@163.com>
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
X-CM-TRANSID:_____wAH0s46eXdoG0BuFQ--.1985S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur48WF43Jw4ktFWxGF48WFg_yoW8AFy3p3
	ZxArsYgrZ7urWUt3sYyF1xJrsxCrs5ua97Jr13u343KFW7WF93Kwn3GrnYkryjvFs3X3yr
	tr1kZasF9F1DXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8a9-UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEgqMXmh3cPPq-wAAsD

From: Andy Yan <andy.yan@rock-chips.com>

Enable the Mini DisplayPort on this board.
Note that ROCKCHIP_VOP2_EP_DP0 is defined as 10 in dt-binding header,
but it will trigger a dtc warning like "graph node unit address error,
expected "a"" if we use it directly after endpoint, so we use "a"
instead here.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

(no changes since v2)

Changes in v2:
- Sort in alphabetical order

 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index 8b717c4017a46..5393c6cc493c3 100644
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
@@ -889,3 +919,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
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


