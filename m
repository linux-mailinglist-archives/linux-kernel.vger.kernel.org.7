Return-Path: <linux-kernel+bounces-747845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF30B13909
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65461893D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6468226520;
	Mon, 28 Jul 2025 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="P16oc+Lf"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27DB213E89;
	Mon, 28 Jul 2025 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698761; cv=none; b=P4Na68i61S56NQxiaznphaJerozylbVA5Gn1kon8fbPNNLxprjtWrSjNqiK/84hFTrukEFHBhXs2fGVFgHfYnNP3eEsixMca1UVj0HTSZQB0UdzTZhBbaqNYbdB6iTSNyJX6J7pD5HiiGCAI2WiC3Yopcftmy4PSCpqC7ohriGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698761; c=relaxed/simple;
	bh=y5vVdmQ4dC2wsUn0JtuEjMgsKW9qhleLEj6ifOgi1pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEErLf4tUNKdy01pY60rJF/NglnLa+utnupUNimLexbDHyfBB7Tn2dfcqBq9oaU3DuOZUnHTZw++CT5GWJr52tEMSByKjvqlG6hnZ7KliixTiPPodRg8e7Csa0kc6apAuQj5g/RbJ+HZ0AS+GAYLhUt6AvyF53I37DnxzqsO/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=P16oc+Lf; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5337820E30;
	Mon, 28 Jul 2025 12:32:38 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wAhAAW0WYRYv; Mon, 28 Jul 2025 12:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753698757; bh=y5vVdmQ4dC2wsUn0JtuEjMgsKW9qhleLEj6ifOgi1pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P16oc+LfQNN+AmGnexdHMN9iGdC5bg5sWr5nbmaxSLEND69x5Th9IABXmJs9YUsNf
	 8rDETyRWThLtV+l8dS+0beo0trTlTS4awAnFgSgloPRsHFlVY+b1W5pHZgXd+D90jB
	 Hwga1K1yef2QWIqvkEc+XE1Q4bDrAceyjl3wlRSi5slQwIDAGgEHmvDwzw6n4vLH0+
	 06l+mtPyHY8qG/r+KatUsh/Z91zqAsJCpqXTLNruqMTx0xdSz7+76JVgP6jey9FcOX
	 kJbQKSv8IfcDiVzTl06mFn+ugV4Fn22n6wKlaeAg+DKpbbyS9YGyaEUVZMx5/ZEY6w
	 bxgNxUBc3l3gQ==
From: Yao Zi <ziyao@disroot.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] arm64: dts: rockchip: Add naneng-combphy for RK3528
Date: Mon, 28 Jul 2025 10:29:48 +0000
Message-ID: <20250728102947.38984-8-ziyao@disroot.org>
In-Reply-To: <20250728102947.38984-2-ziyao@disroot.org>
References: <20250728102947.38984-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 ships a naneng-combphy that is shared by PCIe and USB
3.0 controllers. Describe it and the pipe-phy grf which it depends on.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 54fa8089c4d3..58c8977249be 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -417,6 +417,11 @@ vpu_grf: syscon@ff340000 {
 			reg = <0x0 0xff340000 0x0 0x8000>;
 		};
 
+		pipe_phy_grf: syscon@ff348000 {
+			compatible = "rockchip,rk3528-pipe-phy-grf", "syscon";
+			reg = <0x0 0xff348000 0x0 0x8000>;
+		};
+
 		vo_grf: syscon@ff360000 {
 			compatible = "rockchip,rk3528-vo-grf", "syscon";
 			reg = <0x0 0xff360000 0x0 0x10000>;
@@ -1085,6 +1090,25 @@ dmac: dma-controller@ffd60000 {
 			#dma-cells = <1>;
 			arm,pl330-periph-burst;
 		};
+
+		combphy: phy@ffdc0000 {
+			compatible = "rockchip,rk3528-naneng-combphy";
+			reg = <0x0 0xffdc0000 0x0 0x10000>;
+			assigned-clocks = <&cru CLK_REF_PCIE_INNER_PHY>;
+			assigned-clock-rates = <100000000>;
+			clocks = <&cru CLK_REF_PCIE_INNER_PHY>,
+				 <&cru PCLK_PCIE_PHY>,
+				 <&cru PCLK_PIPE_GRF>;
+			clock-names = "ref", "apb", "pipe";
+			power-domains = <&power RK3528_PD_VPU>;
+			resets = <&cru SRST_PCIE_PIPE_PHY>,
+				 <&cru SRST_P_PCIE_PHY>;
+			reset-names = "phy", "apb";
+			#phy-cells = <1>;
+			rockchip,pipe-grf = <&vpu_grf>;
+			rockchip,pipe-phy-grf = <&pipe_phy_grf>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.50.1


