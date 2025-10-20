Return-Path: <linux-kernel+bounces-860354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C31B1BEFF26
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308B73ABFEA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D232F2911;
	Mon, 20 Oct 2025 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="D6AQ5W6m"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3152EBDD0;
	Mon, 20 Oct 2025 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948759; cv=none; b=a2Blp2ZK7rKEyuK8vWMAgrmQJ5SOZ/VZiqLscIjchz1s9OK8L0eBcY/VEznSGoZzfoWBIffviDD8ij6TVa/86xnDRDHeDra7JVNK7VHa+SE0Hu9ushpl60sVWCOz/G4Co3nij4LVEV6zkpjJEfv0FTmv+lQG/Fiqny/OQnXVPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948759; c=relaxed/simple;
	bh=htaTp8CZvpGdr7O0sX+0iC2RqkMOEhUVnrcOTdRkumw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnIqgdgsBZi/HmipWi3eiROQzepyk6/rMdgIoStCBu/LpojHSAORLyy80UdXvYs5q3dU5QT8f6dgybwS/Z8/c8uQFwcpokxVyTm2vyKz6/mVeukthHjTikkGM/he0KkPjdw3BM3qyqD3B8GrtODI4c8nNwIWDf/KeWOzoj60p14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=D6AQ5W6m; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=445YquTwMCYGWvvFlDmuQ2qGeWs3mzkw8t3wT+6a8rU=; b=D6AQ5W6mMOjbKai0wM0Wotu6Lg
	F4hjAhi/YJJq+F2uS2ll0V7VxTzRNDAH5iwqOCjosnRaCbLODs/ztsuDckgcV/odID1vWDRV/JaG6
	yv77eCDGYDkb4B3myJb+l+hN7ZpxrecbGpV0fXqs+kEghqfxkRa11mMKUxtPWiAnGgXet50Mtsi5N
	KDK/HU/gFPeI5YsiL8RnbJgXfiTfC9ACGc39PXScF0FP4DkU6UGhq6ajo9/odEchXv2kotQFDKKYL
	p2UbsZdRkyQa9sgibQjM8S0uAzVca4j0DaTyn80KwJo782Xf55Gp/G4leCJ4p7qlfNQHAGP3fbS63
	NGyXWk5A==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAlD1-00078O-3Y; Mon, 20 Oct 2025 10:25:39 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	cn.liweihao@gmail.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 8/9] arm64: dts: rockchip: Enable HDMI output on RK3368-Lion-Haikou
Date: Mon, 20 Oct 2025 10:25:07 +0200
Message-ID: <20251020082508.3636511-9-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251020082508.3636511-1-heiko@sntech.de>
References: <20251020082508.3636511-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Enable the VOP and HDMI controller on the Lion-Haikou board.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../boot/dts/rockchip/rk3368-lion-haikou.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
index abd1af97456a..a8eb4e9c2778 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
@@ -58,6 +58,16 @@ vcc5v0_otg: regulator-vcc5v0-otg {
 	};
 };
 
+&display_subsystem {
+	status = "okay";
+};
+
+&hdmi {
+	avdd-0v9-supply = <&vdd10_video>;
+	avdd-1v8-supply = <&vcc18_video>;
+	status = "okay";
+};
+
 &i2c_lvds_blc {
 	eeprom: eeprom@50 {
 		compatible = "atmel,24c01";
@@ -101,6 +111,14 @@ &uart1 {
 	status = "disabled";
 };
 
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
 &pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&haikou_pin_hog>;
-- 
2.47.2


