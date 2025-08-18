Return-Path: <linux-kernel+bounces-773348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB001B29EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68E2174972
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335C9310644;
	Mon, 18 Aug 2025 10:00:28 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E25317709;
	Mon, 18 Aug 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511227; cv=none; b=jJRnzpNcr2irXFuQ0vDf32EMdn3bLk27c2rB6UC55dDc1tN27H9XpjfC4qASITzN4T0d2NhkTLsgYkM16g9yW/UbN09+uccLxEBufIIm25F+g3Z/AZvCmTbgKUWNSYHlV+aWUos8ygxEkuog5wVMmdJXngUZzw2gpYO30qdhoxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511227; c=relaxed/simple;
	bh=m8CsG+Bs3O7XJmgUbIZ00d19Nb0kOxAXPvPMwxFi3tU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLtHZgRMFI/xkkU2tGkmMihKt2M+eu7wRxTlFbymSqsKnN6cvamPc3o7O/xBnXUCOPfn3vxXRGKglKR+U4B6ulGfbR2U+SB1a3KD7mgOrSfLXv6jFNZqkGLYX0zLJEGvggEPnASLxzU7MhfNvlBoi480JqS2xVqv+TDT8kzLulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.154])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fbaa9d09;
	Mon, 18 Aug 2025 18:00:21 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: rockchip: Add HINLINK H66K
Date: Mon, 18 Aug 2025 18:00:09 +0800
Message-Id: <20250818100009.170202-5-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250818100009.170202-1-amadeus@jmu.edu.cn>
References: <20250818100009.170202-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98bc9f6d8e03a2kunm3d9619f636a27b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS09DVktLGB9MTUxLHh0dSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKTk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++

The HINLINK H66K is a development board with the
Rockchip RK3568 SoC. It has the following features:

- 2/4GB LPDDR4
- 1x HDMI Type A
- 3.5mm jack with mic
- 1x PCIE 2.0 WiFi slot
- 1x USB 3.0, 2x USB 2.0
- 2x 2.5GbE RTL8125B Ethernet
- MicroSD card slot / eMMC 32GB

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/Makefile                |  1 +
 arch/arm64/boot/dts/rockchip/rk3568-hinlink-h66k.dts | 10 ++++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-hinlink-h66k.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 09c810cb64a4..93e547a1c77b 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -130,6 +130,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r68s.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-hinlink-h66k.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-hinlink-h68k.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-lubancat-2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-mecsbc.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-hinlink-h66k.dts b/arch/arm64/boot/dts/rockchip/rk3568-hinlink-h66k.dts
new file mode 100644
index 000000000000..bc51123d53f5
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-hinlink-h66k.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3568-hinlink-opc.dtsi"
+
+/ {
+	model = "HINLINK H66K";
+	compatible = "hinlink,h66k", "rockchip,rk3568";
+};
-- 
2.25.1


