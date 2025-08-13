Return-Path: <linux-kernel+bounces-766346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3172B24567
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A682189F72A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330C12F2909;
	Wed, 13 Aug 2025 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F5kha3We"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBFD2F0C68;
	Wed, 13 Aug 2025 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077217; cv=none; b=SilPHpYJnk/lL9GiIwh8I0xa0P0lokwKuakEWxqZpZLxdXjVDq25N8PpZS8tWilMZFn+yN7YcV4qemKNPnBDrB6xKIt9lKqVR6KIjnlKZgpP/YpeXHyFs+ix17ApMbwgptul55aezfpzV/k3WWnmPXNXPgfVtO9WoLF4Yg95YsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077217; c=relaxed/simple;
	bh=uCyPLhhjkqbdeJ7mORJ4vVbhOFgLVZuZgt0PEPXp+uI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jp7Ek95RQV8A90+CaaRvW3nvbI2seBy55rkHqvxRqkbI2SgvgcxxljayMGURDsPF145uiTuyrtp8bS1MKhC98DdhSfcofTNnJoEP/l4vwS+rZ0+UP9XXbNuZjsnIJv7vZj5CbJZ2d7I9GELHHcDFQTtjOWbw28aTWs76A2uuOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F5kha3We; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755077213;
	bh=uCyPLhhjkqbdeJ7mORJ4vVbhOFgLVZuZgt0PEPXp+uI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F5kha3WemExHwqzNeSWWs/vGXTRU5awJoZmAsnDuPAfngKKaHypI4MarIkgsLA+j1
	 VQoSFEPfVVmeN6mLRyncgEiAWuXxjVwZrXXQRsSg7WbEnehEUJzW1u9OMxypcgGY13
	 yCPRQalMvZEX7HGA5MF/diQMJ6bLCp+XgOISdiwfEEKXZL8kK9er9UtM7GTmT1/XhO
	 XBtbAEXHsX3wFTCAB7t7JyZ7Dh5rVX+4nTQyikD0Jl0omGLN+yeolBYI3Ws66rgvmh
	 E3qED4jt6iTo0JCyw7MumhtBoyphvmIql1KYJTLJcywKba14NpZ/XfNSHRlx74NwS6
	 0DK8YTSpI5Brg==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E8F1D17E01CC;
	Wed, 13 Aug 2025 11:26:52 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 13 Aug 2025 11:25:43 +0200
Subject: [PATCH 2/3] arm64: dts: mediatek: mt8365: Add GPU support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-mt8365-enable-gpu-v1-2-46c44c6c1566@collabora.com>
References: <20250813-mt8365-enable-gpu-v1-0-46c44c6c1566@collabora.com>
In-Reply-To: <20250813-mt8365-enable-gpu-v1-0-46c44c6c1566@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755077211; l=2491;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=uCyPLhhjkqbdeJ7mORJ4vVbhOFgLVZuZgt0PEPXp+uI=;
 b=nsamGrmvDrQW6cvxe7D8qeoDZ4ybZmT09f9gZb3kcVisjMx7EGGHF26YE3+bRfMkqLlhWsDHq
 Eg1fI2YskX1C/PjZZ4MgylHh1bZY5KbV/O7GDrauReUi/Dl+kynRnDl
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The Mediatek MT8365 SoC has an integrated Arm Mali G52 MC1 GPU
(Bifrost).
Add gpu, OPP table, and MFG clock driver nodes in mt8365.dtsi to support
it using the Panfrost driver.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 41 +++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index e6d2b3221a3b7a855129258b379ae4bc2fd05449..6a7b4f58918b22f51b792f3a99bd777acf72df9d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -267,6 +267,24 @@ clk26m: oscillator {
 		clock-output-names = "clk26m";
 	};
 
+	gpu_opp_table: opp-table-gpu {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-450000000 {
+			opp-hz = /bits/ 64 <450000000>;
+			opp-microvolt = <650000>;
+		};
+		opp-560000000 {
+			opp-hz = /bits/ 64 <560000000>;
+			opp-microvolt = <700000>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <800000>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -292,6 +310,27 @@ gic: interrupt-controller@c000000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		mfgcfg: syscon@13000000 {
+			compatible = "mediatek,mt8365-mfgcfg", "syscon";
+			reg = <0 0x13000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		gpu: gpu@13040000 {
+			compatible = "mediatek,mt8365-mali", "arm,mali-bifrost";
+			reg = <0 0x13040000 0 0x4000>;
+
+			clocks = <&mfgcfg CLK_MFG_BG3D>;
+			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 201 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 204 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names = "job", "mmu", "gpu", "event";
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MFG>;
+			status = "disabled";
+		};
+
 		topckgen: syscon@10000000 {
 			compatible = "mediatek,mt8365-topckgen", "syscon";
 			reg = <0 0x10000000 0 0x1000>;
@@ -398,7 +437,7 @@ power-domain@MT8365_POWER_DOMAIN_CONN {
 					mediatek,infracfg = <&infracfg>;
 				};
 
-				power-domain@MT8365_POWER_DOMAIN_MFG {
+				mfg: power-domain@MT8365_POWER_DOMAIN_MFG {
 					reg = <MT8365_POWER_DOMAIN_MFG>;
 					clocks = <&topckgen CLK_TOP_MFG_SEL>;
 					clock-names = "mfg";

-- 
2.50.1


