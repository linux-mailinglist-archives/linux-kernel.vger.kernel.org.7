Return-Path: <linux-kernel+bounces-862310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01431BF4F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51DE427BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CAC280CD2;
	Tue, 21 Oct 2025 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hy3dnRt3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909824678F;
	Tue, 21 Oct 2025 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031911; cv=none; b=G9tYw2HbSCao+KJNwcnOZDrma6x45MHCeDL+buk3pRcEWLPuOtXYxCHGlvgTvyWxl+w9i1wNOU8VAcNIBjD6tqW9f9bwfVb8Wa513uUBOTeJRKUPGupYKkh8tz0uNWWYhfL9EEBokUvXH0zC3cBqwNz+npNbNfpat9sCJL9q9gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031911; c=relaxed/simple;
	bh=u+G8Mt1dpRFClpUAKvKbFwgypYjcR8NzUmnmamS1YxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0QIFZ5KpEEYmaGKATxHWsM2MhBOi17HR4PqOa+7inHvVOewjeGCpLCOtOD3JNmsj37wqlYsTRdU+f7tOrofgWkynVknvzaDrd8biKlo0J1lXCKiy4iuOckMnS42WRSBjkBTYbiOKYzXLdO8SMl44EXs1EUTQEb5qTQjDOcSWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hy3dnRt3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761031907;
	bh=u+G8Mt1dpRFClpUAKvKbFwgypYjcR8NzUmnmamS1YxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hy3dnRt3eGLK9sJNQcn2Pt6rxou3kv6Wfv2SP/N/THo1eNPYIzy9TRnq63NrEe4wM
	 3d0cKnRe9qgCTziRmCs+3GxI/w15CJl941+Z3ktXdfq/GWSexB2keIn2YeTgglJqQd
	 xQv04P2xssQLfgyP4AVJ/tJ20JJllo4EuuLKDjyNKJllhPKO271r3IS9m//4ynms0i
	 zl75+KqwwF7Qdq12kbfhNk46A+POCAp9k+aIDz6qJ9ubhe3tUMINsDzVQhIIdLZgYm
	 a3dI8YlQBaScUvg85jgXwWmLp6lFcqrzXqHEq88bJgmn2zWhnvevXiMw/L0tgWWDa8
	 9wBba5oa2yjVA==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E0EA417E1305;
	Tue, 21 Oct 2025 09:31:46 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 21 Oct 2025 09:30:52 +0200
Subject: [PATCH v2 2/3] arm64: dts: mediatek: mt8365: Add GPU support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-mt8365-enable-gpu-v2-2-17e05cff2c86@collabora.com>
References: <20251021-mt8365-enable-gpu-v2-0-17e05cff2c86@collabora.com>
In-Reply-To: <20251021-mt8365-enable-gpu-v2-0-17e05cff2c86@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761031905; l=2580;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=u+G8Mt1dpRFClpUAKvKbFwgypYjcR8NzUmnmamS1YxM=;
 b=y05pIlBN0LFY95ArJuuCsCuEONmMvdyrcfp3eGfkpqGJkcEnRG5trecSjXqSwe1G06oqT2A7H
 LCL+qahdJMeCBNOr/GGmvc/3avl+W9OykjeO9G1siKKpKZItu8jez8d
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The Mediatek MT8365 SoC has an integrated Arm Mali G52 MC1 GPU
(Bifrost).
Add gpu, OPP table, and MFG clock driver nodes in mt8365.dtsi to support
it using the Panfrost driver.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 43 +++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index e6d2b3221a3b7a855129258b379ae4bc2fd05449..a5ca3cda6ef30d59a106222549dc15bcb6ce503d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -267,6 +267,26 @@ clk26m: oscillator {
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
+
+		opp-560000000 {
+			opp-hz = /bits/ 64 <560000000>;
+			opp-microvolt = <700000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <800000>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -292,6 +312,27 @@ gic: interrupt-controller@c000000 {
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
@@ -398,7 +439,7 @@ power-domain@MT8365_POWER_DOMAIN_CONN {
 					mediatek,infracfg = <&infracfg>;
 				};
 
-				power-domain@MT8365_POWER_DOMAIN_MFG {
+				mfg: power-domain@MT8365_POWER_DOMAIN_MFG {
 					reg = <MT8365_POWER_DOMAIN_MFG>;
 					clocks = <&topckgen CLK_TOP_MFG_SEL>;
 					clock-names = "mfg";

-- 
2.51.0


