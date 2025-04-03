Return-Path: <linux-kernel+bounces-586041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D40AA79A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 05:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCBA3B3237
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 03:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB3C1A23B8;
	Thu,  3 Apr 2025 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A/N1wYSk"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF9817799F;
	Thu,  3 Apr 2025 03:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743651519; cv=none; b=eQ4u33WsWYytKKIH6IFOJDuClWBC9q6YIPa0+2YTzinjjspEO2VVdqHwUuoDKQgDvVWg2/aQ9vMPMAxeE7nPPt4H/GzRrZx2Ua3M1yBpstk9Hvw7eODYkaXzitVT9PyDdnL/QXEuABoSxzRRVxR3jipjaHwe6rWfKGTrE/TJygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743651519; c=relaxed/simple;
	bh=M47KI5ik229PFXh4vZtuE7Ef3xXaa306wzP7RGmJfnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDeJ3MGoZYznl582EW6cLf1QOOgbwPoJCyf0p7LFb9azvyZpyAOjjbx3w8/sWqPGICU4ras8wo69YtWPWYoLUuivA3bY/NptCt7KaeHeNF3lz0Yv4ui0Mp2ZBr8o8MxITnrlSeJjUTzc8hEaoDvxaY2Hfq8Wc+EGywYopH41Abg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A/N1wYSk; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=VBmaI
	1F3khfg5+m2nr03cMmSVAdLbuEwhA3VNeIpdUo=; b=A/N1wYSkhEBxPy3/zSEFm
	1YvUyu2XuVUqZV4lNTWWgz2NoKTqi4nj4Rp9WjayfT84hzKgvO7B3ntS0OizdORA
	TPYbR4Ioy0VU99zUwf8+E0kJOjKMfu//Vq3cxM8nKNjTz660mUm+kWeKb4JnLzvZ
	sgwLsfMQpyqucZOs1xcpbY=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHWgmNAu5n7FfDDg--.28713S10;
	Thu, 03 Apr 2025 11:38:05 +0800 (CST)
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
Subject: [PATCH v3 8/9] arm64: dts: rockchip: Enable DisplayPort for rk3588s Cool Pi 4B
Date: Thu,  3 Apr 2025 11:37:36 +0800
Message-ID: <20250403033748.245007-9-andyshrk@163.com>
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
X-CM-TRANSID:_____wBHWgmNAu5n7FfDDg--.28713S10
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur48WF43Jw4ktFWxJw4fZrb_yoW8AFy3p3
	ZxArsYgrZ7urWUt3sYyF1xJrsxCrs5ua97Jr13Z34SyFW7Was3Kwn3GwnYkry5ZF4fX3yr
	trn5XasF9F1DXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY9aPUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0g4kXmfuAW8woQAAsQ

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
index e892dd7c91aae..4f471da1d866a 100644
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


