Return-Path: <linux-kernel+bounces-862330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58616BF503F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EA33AD298
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB9328134C;
	Tue, 21 Oct 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="iUrZTOZz"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F978F4FA;
	Tue, 21 Oct 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032610; cv=none; b=AD6rJaqdwbxtp6wap8yEn8AVxpxOe9/x+M4D8CNyCcUgQ+k58pIgafBU6yNrzzCRLGIgcDM7JNtFCa7wSve/89wqbnIiph0H3JrcxDGebz+yMtdga1Sjiv0VL1Gii4p8gP+Bwi+kAWtekQEKhN8quoNdX8r6zF/n4XmZvNTr5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032610; c=relaxed/simple;
	bh=htaTp8CZvpGdr7O0sX+0iC2RqkMOEhUVnrcOTdRkumw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkeNqgt89MIJK/6IIkgqelWm0ojYQ1qhLJP8ahgmQaA7/suNDMMEMMw928PIg9Zmo+Ygdc+jgBFLRE/d0ykwqusWx14SwIoNZu3HQhLi7UNbQA4hbkcyfwgswHyneJcd90bvmbCfklYFXo2tAWP4MFpD+XiR7ckV36+cd3nW5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=iUrZTOZz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=445YquTwMCYGWvvFlDmuQ2qGeWs3mzkw8t3wT+6a8rU=; b=iUrZTOZzaLL3fyZVeCHJaxvjeC
	BerfNIWSOthofcI0H1WxeVGUXBNntT85YiRWop7D9KbYjW3zCCM31xEbQVa4P1AEB+VjLgV6TI1Bl
	SX9HqLLAr2mkVBbAGsaEqRpVz182SdMmrkcdp5bq17JU4g6EdLu3xvOho7tjBmtbP2Uvh48xnJKcZ
	TMU4ITOKae999SatR0zfGZFmdJJVDQ1hAgCT4HZuem7v5c+z8OLurowI7x7FrIiGSEwWIQpFCYcPa
	Iv4Pc1StT+dtczdgEPmKCN9U3TCl3gyW+Zj+k+yFweP4WLdB/y1e4V9v74vrOHwGQxLnqXH9JfwOa
	Z7tREdIA==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB71P-0000uy-Pz; Tue, 21 Oct 2025 09:43:07 +0200
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
Subject: [PATCH v2 8/9] arm64: dts: rockchip: Enable HDMI output on RK3368-Lion-Haikou
Date: Tue, 21 Oct 2025 09:42:53 +0200
Message-ID: <20251021074254.87065-9-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021074254.87065-1-heiko@sntech.de>
References: <20251021074254.87065-1-heiko@sntech.de>
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


