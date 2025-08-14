Return-Path: <linux-kernel+bounces-769315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C6B26CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C949A2144A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8E3301478;
	Thu, 14 Aug 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="EpgBbQHa"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6241E4BE;
	Thu, 14 Aug 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189795; cv=pass; b=H9s5WMtjg74F6/dbyQ0UHbuoQRJH8hBZvV/D/qAQDan9mh12yno75ItKNsJ30sEsJCQF3t3YTitjYRLg1TRES0ASYW+P5ep/DXNJ6AzKOBfGiNtcyobUw5vVrgOZBOiJ4o+5RR4Z0K7YmUz42+fsRM0yGzOFW2zTU/bYahfz/8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189795; c=relaxed/simple;
	bh=krYJhBzYYkjDqRK8P8j4PWMkgDLHhF8N5uQrD8rvwKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3hZgDuWYNY1JOdYddqxvoVyqbtFeuXoP5Fap4gQlZg+sPQjLzHYq4aSH2hteENaCVwyT1qndS6lop/cCJGmojOmbMqMaPl12qb8vj9hXt6/93Bc3Dz1Fq/zjgw+6vURWZRj13OEhKY8OD+Uako56Q/f2T7z84w+9aWtkL1v9V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=EpgBbQHa; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755189764; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GjyjxnI+vF7nf+vcXqV0H+9X+Y2LbJA0lMoIf8ZsiXvnyFvY1myhixwNEiC0OaNfuyqEIsk9E7Okw2EfJjNkyhLjvGWrmby5IK/qTB7NhSqfenB1v8caVAT5YxFpKolTkmNhywGB4fYIbHgOIVyunaWdR6z9AuxvJhZPpLzd6uQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755189764; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VqDoPccRJR3+HUqswVJ868xVxgAyLML/1e/8wWdRzig=; 
	b=EpbJIRMIUW7xLVPNRq0yGeqnEj2n6bbaDLptRCohskSjL1gp3k1WWQRpwXpOz87CLoav1X7dJS3XTVCfXY6LwQHPrOdEpQKFjTWAoeK6GmnhTLPgORyciKqeFK7vRPhlHW5LzXQDMnvVRQPzJtaDXrm0VBURLzjUzbVNjc7s41o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755189764;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VqDoPccRJR3+HUqswVJ868xVxgAyLML/1e/8wWdRzig=;
	b=EpgBbQHayPxU8xSs+Itgg8gvuKJpMnt8tG9Ie0b4WzyJEoo0vX0vMCZPylAaHm8r
	xOIOVVidQms2FYKDC/uk1micvtQmIfWvilQQAsb1ozuc8UJrOTqK4U026WUuYicDdmy
	VEXxHIY+/HzRlw6V4EUfm1QT+jWaN8YzrvXgqtc6BAOlDVduHb9xoBVHngHZT2QJOrm
	ppvYcMLRwG2WWTmANcH91gj8mWjVd8X283vXAFnXTml2bzxXyBph4p39rxX0SuE9Lkj
	NyB4I5E494x3aukqB3sdO2bFlKxuonnIWfJDOxqArwPLVxNHIQTGy4SPp/OF/Uxq67y
	vsOZT7h+xw==
Received: by mx.zohomail.com with SMTPS id 1755189763117644.8149878497185;
	Thu, 14 Aug 2025 09:42:43 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH 6/8] riscv: dts: thead: add DPU and HDMI device tree nodes
Date: Fri, 15 Aug 2025 00:40:46 +0800
Message-ID: <20250814164048.2336043-7-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814164048.2336043-1-uwu@icenowy.me>
References: <20250814164048.2336043-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

T-Head TH1520 SoC contains a Verisilicon DC8200 display controller
(called DPU in manual) and a Synopsys DesignWare HDMI TX controller.

Add device tree nodes to them.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 70 +++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 42724bf7e90e0..13a6de742b9f7 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -513,6 +513,76 @@ clk_vo: clock-controller@ffef528050 {
 			#clock-cells = <1>;
 		};
 
+		hdmi: hdmi@ffef540000 {
+			compatible = "thead,th1520-dw-hdmi";
+			reg = <0xff 0xef540000 0x0 0x40000>;
+			reg-io-width = <4>;
+			interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vo CLK_HDMI_PCLK>,
+				 <&clk_vo CLK_HDMI_SFR>,
+				 <&clk_vo CLK_HDMI_CEC>,
+				 <&clk_vo CLK_HDMI_PIXCLK>;
+			clock-names = "iahb", "isfr", "cec", "pix";
+			resets = <&rst TH1520_RESET_ID_HDMI>,
+				 <&rst TH1520_RESET_ID_HDMI_APB>;
+			reset-names = "main", "apb";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					hdmi_in: endpoint {
+						remote-endpoint = <&dpu_out_dp1>;
+					};
+				};
+
+				hdmi_out_port: port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
+		dpu: display@ffef600000 {
+			compatible = "verisilicon,dc";
+			reg = <0xff 0xef600000 0x0 0x100000>;
+			interrupts = <93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vo CLK_DPU_CCLK>,
+				 <&clk_vo CLK_DPU_ACLK>,
+				 <&clk_vo CLK_DPU_HCLK>,
+				 <&clk_vo CLK_DPU_PIXELCLK0>,
+				 <&clk_vo CLK_DPU_PIXELCLK1>;
+			clock-names = "core", "axi", "ahb", "pix0", "pix1";
+			resets = <&rst TH1520_RESET_ID_DPU_CORE>,
+				 <&rst TH1520_RESET_ID_DPU_AXI>,
+				 <&rst TH1520_RESET_ID_DPU_AHB>;
+			reset-names = "core", "axi", "ahb";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dpu_port0: port@0 {
+					reg = <0>;
+				};
+
+				dpu_port1: port@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					dpu_out_dp1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&hdmi_in>;
+					};
+				};
+			};
+		};
+
 		dmac0: dma-controller@ffefc00000 {
 			compatible = "snps,axi-dma-1.01a";
 			reg = <0xff 0xefc00000 0x0 0x1000>;
-- 
2.50.1


