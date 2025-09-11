Return-Path: <linux-kernel+bounces-812631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23483B53AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A20AA7204
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE61536CC76;
	Thu, 11 Sep 2025 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAixnrkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69977369983;
	Thu, 11 Sep 2025 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612836; cv=none; b=RGL9fiWsBo2AsdcGFWE3m/eIQLQed231a8+Zoxgk/D5mU/ew0ISWYWEESjy4Id357mOo0dCZkYvC/FCMMKcfUOd7xIf/HXX5bemSz8dDheOlg1fmWRzMQBU2hOwYclviOviCUvPYVU42EjtwEL1caxCq/8vzGhsg7QwtIk+/WMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612836; c=relaxed/simple;
	bh=WzFwdnb/weY1BfCYsn8nBeYLnmC5YscOBh1kWZFapkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uFDezeDi3SajlMrzbOZC9tXXra/eIeeqE6wglkHltTb0ACjX8HzxfwKW8oK2i7K2HZT5z6Mgx6VlYjFzACHBA+0WZIvObnp+2m+PwuD/Py3kF1g5zIq2u8OHvEMxhpJ5KM99zu4A6YFKu1kxe4xtoBps2JQjBrshpHK37I43RQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAixnrkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE50C113CF;
	Thu, 11 Sep 2025 17:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757612836;
	bh=WzFwdnb/weY1BfCYsn8nBeYLnmC5YscOBh1kWZFapkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aAixnrkK6ogY1UdA6Cjp6ThQtGasFtjjg7sxdNkWSd9Bzoi7Ywv8jyy+YKxjk4PZB
	 NCra51SZcYII02kG/CZqAumdBg5f8gzKlrLFZ+g8aHT3ev2763V+Mn3tIenDlABlBd
	 j+st1A3dxxpzf+Pm+B8VqvzhqTEzS2LfbIKZzcxFnbY3qlWWj8tEhOtjFrC8SG9+PY
	 QjlWs6lqRm/8I8cx5OkqZRttMYErGjuZiI3HEIuE+BdJ1oit+wx12NgkEK1TKFAm/C
	 H0QCpV/ocb0h6IfOOqjHJUX4B4/a2KF9u/C6HMJOOaBYaPUESczovx+Pjm0v4qVJcU
	 Hjqm/FjFSpftQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 112515FEEE; Fri, 12 Sep 2025 01:47:12 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] arm64: dts: allwinner: a523: Add NPU device node
Date: Fri, 12 Sep 2025 01:47:10 +0800
Message-Id: <20250911174710.3149589-8-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911174710.3149589-1-wens@kernel.org>
References: <20250911174710.3149589-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The Allwinner T527 SoC has an NPU built in. Based on identifiers found
in the BSP, it is a Vivante IP block. After enabling it, the etnaviv
driver reports it as a GC9000 revision 9003.

The standard bindings are used as everything matches directly. There is
no option for DVFS at the moment. That might require some more work,
perhaps on the efuse side to map speed bins.

It is unclear whether the NPU block is fused out at the hardware level
or the BSP limits use of the NPU through software, as the author only
has boards with the T527.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index f93376372aba..9676caf9bd4e 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -852,6 +852,18 @@ mcu_ccu: clock-controller@7102000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		npu: npu@7122000 {
+			compatible = "vivante,gc";
+			reg = <0x07122000 0x1000>;
+			interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mcu_ccu CLK_BUS_MCU_NPU_ACLK>,
+				 <&ccu CLK_NPU>,
+				 <&mcu_ccu CLK_BUS_MCU_NPU_HCLK>;
+			clock-names = "bus", "core", "reg";
+			resets = <&mcu_ccu RST_BUS_MCU_NPU>;
+			power-domains = <&ppu PD_NPU>;
+		};
 	};
 
 	thermal-zones {
-- 
2.39.5


