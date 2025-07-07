Return-Path: <linux-kernel+bounces-720262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08627AFB939
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FB63B62EE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915D235072;
	Mon,  7 Jul 2025 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qbVfqFY5"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DEA253B5C;
	Mon,  7 Jul 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907331; cv=none; b=B0480qRjAd9H76/4XyOdXBVbqJx3go6F8Tr1ypWJZ7Or9SqZcMjAYjq9D4OAl8e3qnIteBjRVMWvEdzItF1QF64igmj92fKFQfYjca630EiG0H4nymPx7GISaUF6tIBQ0A8OvXMfljYIzil+FoMUv5pmkpCZh57UMmJaGz5xDZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907331; c=relaxed/simple;
	bh=InKXB9RqBFpsMcJfuOlJArpEIizXsZyBYMdsyxdlEp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spqLtlUncv15yaLd5I1eWJOIIDIuT7a4dQPPffGWXkx6IEXkszpWVt76P2pwa0os5WQ+iz+HXtYWbjD9R3iAIag1zRNr5VBp+G6y4DevA7Ji/j806QP0Wso/mhr0HL9NSw9s3NUFW6FY7yWBaoobYPmwEp1vO0VOf5DapB0G/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qbVfqFY5; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=p8ly7oF3wY3svi7kAE9pak8dnHj/ipa3jtx+B3eJ+EE=; b=qbVfqFY5KmjT4Bmb0hMOj8w8lU
	+BqxWITtoDMD0j0fU0ZFuoNevU7Y/wRFaLorWfYs9JfBrY/qesPLbjNi2OgcfsyaPjx1VK2s6Z7ij
	9VErhST7UFzKmHooHc/tO/n1MJDVt8K0nQFxeYpqGPVS3VL6Ysix2qm11IgP3VWiCoYjz6NF3Dir9
	XR3P4yBMPLKxWK6rAmK/tM8GqRHzAWtDJuYWLje3A7nz+x3Kd5ckEQkBfoO6D3M3qn35gXvDyQiLF
	gJh0XcpIXIr4xd6eWDgOkmmBW/EcDLESbzYvV7eh5Q+e/5zpVDA22NdEVu8AkPRAZFYokyzvLVf8e
	nlQFRIPg==;
Received: from i53875bf5.versanet.de ([83.135.91.245] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uYp1w-0004yl-RI; Mon, 07 Jul 2025 18:49:24 +0200
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
Subject: [PATCH 11/13] arm64: dts: rockchip: add the dsi controller to rk3576
Date: Mon,  7 Jul 2025 18:49:04 +0200
Message-ID: <20250707164906.1445288-12-heiko@sntech.de>
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

The RK3576 comes with one DSI2 controllers based on the same newer
Synopsis IP as the ones on the RK3588.

Add the necessary node for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 87d518422a60..5e9c3dce5823 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1271,6 +1271,34 @@ sai6: sai@27d50000 {
 			status = "disabled";
 		};
 
+		dsi: dsi@27d80000 {
+			compatible = "rockchip,rk3576-mipi-dsi2";
+			reg = <0x0 0x27d80000 0x0 0x10000>;
+			interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_DSIHOST0>, <&cru CLK_DSIHOST0>;
+			clock-names = "pclk", "sys";
+			power-domains = <&power RK3576_PD_VO0>;
+			resets = <&cru SRST_P_DSIHOST0>;
+			reset-names = "apb";
+			phys = <&mipidcphy PHY_TYPE_DPHY>;
+			phy-names = "dcphy";
+			rockchip,grf = <&vo0_grf>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dsi_in: port@0 {
+					reg = <0>;
+				};
+
+				dsi_out: port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
 		hdmi: hdmi@27da0000 {
 			compatible = "rockchip,rk3576-dw-hdmi-qp";
 			reg = <0x0 0x27da0000 0x0 0x20000>;
-- 
2.47.2


