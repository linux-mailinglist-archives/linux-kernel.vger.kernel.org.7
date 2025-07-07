Return-Path: <linux-kernel+bounces-720267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53FDAFB951
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692C41AA7B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A0287243;
	Mon,  7 Jul 2025 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="IR1Yo93b"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C3286D50;
	Mon,  7 Jul 2025 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907409; cv=none; b=Wnybwkopmizb6T19+c8d5PjLwa00nHKtNwjyGxstnFZDvugODE9xzX3OFiC1zmrMznDOBZXnpHhTp0KFtbp47cYhYRBTzk+w2RKcdCmHrPqCeHTDc/N6/KJshk4GnWt7NIerRYgMtaimSUurMoaLKsYpitOLe4f2R7OKQR0dtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907409; c=relaxed/simple;
	bh=aN3THnLd5tCPlI69MReI3gSNZwFID7+A5kTI7toLCLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfH/DbjCaVJOwtoGCEteCNt3VLw8FC3yxZioAxfUmVxX84KpYW7Mez/zs1yLMLIX+FToK91Sm5Wp8jSXZeT7w8E+f2iIRvOKxKmPMAki9rhjGzlNifMg333XOPueRxrfRpH2EU3UvhQofbXIuXTcFYX8cQQVq7B/ZZEVz1CDLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=IR1Yo93b; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=QVv9VN6mF2jxRpVKoSC9NQ/7rqOozAMNWU4uby4GCM4=; b=IR1Yo93bPSVYTBpRB2sx+wIFNR
	cKsnu3dqCuXZdo7vsfK/S4xBckIlpnz6iKMzQZUpOj8Yh7EpZJabNQzbcetjIkLKJTKvjbOFrnbCY
	GZf64RuNZwUsQUWDMZuRX2Kvh3A/yrf/GbSm7B9MLIld5KNkyjw6Gk1g1tjP8ivysdH6mPk2SPr3j
	zJCi3NHDSrHV23YPISx13kFZK7TZUejR6eBIYn+XYtaJOk+aPt3uEHdzpfiVd+5Svc05Y36sK/Mfg
	M/u+tfOMCl+vDAY3kHRVPAqIGp+Y2WV9RtIxxnuEsRSKYkG3vYiqLz2LpQhGo9zHC/CwrGFmLO/co
	MM+Yx4Uw==;
Received: from i53875bf5.versanet.de ([83.135.91.245] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uYp1x-0004yl-H7; Mon, 07 Jul 2025 18:49:25 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	andyshrk@163.com,
	nicolas.frattaroli@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 12/13] arm64: dts: rockchip: add vcc3v3-lcd-s0 regulator to roc-rk3576-pc
Date: Mon,  7 Jul 2025 18:49:05 +0200
Message-ID: <20250707164906.1445288-13-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707164906.1445288-1-heiko@sntech.de>
References: <20250707164906.1445288-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixed regulator is described by the schematics as being part of the
baseboard and its output supply is then routed to the 30pin DSI connector
on the board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts
index d4e437ea6cd8..d0ab1d1e0e11 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts
@@ -107,6 +107,18 @@ vcc1v8_ufs_vccq2_s0: regulator-vcc1v8-ufs-vccq2-s0 {
 		vin-supply = <&vcc_1v8_s3>;
 	};
 
+	vcc3v3_lcd_s0: regulator-vcc3v3-lcd-s0 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pwren_h>;
+		regulator-name = "vcc3v3-lcd-s0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
 	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -715,6 +727,10 @@ rtc_int_l: rtc-int-l {
 	};
 
 	power {
+		lcd_pwren_h: lcd-pwren-h {
+			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		vcc5vd_en: vcc5vd-en {
 			rockchip,pins = <2 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-- 
2.47.2


