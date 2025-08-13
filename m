Return-Path: <linux-kernel+bounces-766347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22857B2456E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6185E7BC24C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A502F290C;
	Wed, 13 Aug 2025 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YgjV8Ubg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573E2F0C74;
	Wed, 13 Aug 2025 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077217; cv=none; b=FLJDtQpqFpvewNYbM5RFpoypDN5YRU/QTxPIVJUHMyoEsgwoac59pDDGhGL2TiukRiwIXgToxaPDNfelTUxicucWDNDCwUfBxb6dhkT/5hxOs97PLFkPZBEU71sSbdky/uljCUio5lss2Ff6qKviL1cCaddx36HpL/BK8XImeZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077217; c=relaxed/simple;
	bh=GsBiIB+JAKlRgMGVDCXXiu9HEN1btXm7zaeu99PDBiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RuKUUt5LT8ohw2pNQNkl8af17yHqCV5cIxmGIyxOYmb8QBDAz7ybMQy+qe4BMdSZp1j6SsdBPxZVHV2d3yq0Bo/Ulq0hFYH17eX3Xqo2RovqUfTie4J/EbCJRySAa3lMobjZJsIYGGPvHkgH/Dwelw+zkMk1Lt+2jg7R+mtFz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YgjV8Ubg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755077214;
	bh=GsBiIB+JAKlRgMGVDCXXiu9HEN1btXm7zaeu99PDBiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YgjV8UbgInZG14R44PY8w1qjPXDYCOfIxQso2AT+Dm7tJXZU7/6mdMSrYBjJArAbc
	 DhsZCNdfQvOFkB58fu2g15cm/PQK6VdgYzplBSf+V2OKVTH/G5mG85NgPFEq/ycOaT
	 nn+NWzTl+voiFrxOhh5RIncw+wlPThOcFsslMVi2I9FTVQuo3KcuMIQUtwa8OmkWoH
	 m3wOr2agpiDtdo6TAYKQTp4YFiGGF3p2fgI80/3rsbTHe3cKm13zbdynKCJiKscxgF
	 VHWYKtThLmBcyi+RXmtAsKZSmDEXURcHvmnkcRalQM8+yiElX4HX79g/9to4pd4Mr4
	 jtiMl6M5Q0NGQ==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C506517E1014;
	Wed, 13 Aug 2025 11:26:53 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 13 Aug 2025 11:25:44 +0200
Subject: [PATCH 3/3] arm64: dts: mediatek: mt8365-evk: Enable GPU support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-mt8365-enable-gpu-v1-3-46c44c6c1566@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755077211; l=1054;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=GsBiIB+JAKlRgMGVDCXXiu9HEN1btXm7zaeu99PDBiw=;
 b=+MSuQ8H3GNnkHrrL2stWSQyx1La3ptro7rPiBYOu8PnLBhliqTgBGzlV1lU2fad/EO+hN5+NZ
 RDG4BUsw1v2ATJseuo7vvarGtDqgHdwxUoIU6TJ0pM92/SAQIsKq9om
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Enable for the Mediatek Genio 350-EVK board the support of the
Arm Mali G52 MC1 GPU integrated in the MT8365 SoC.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index c8418888268d982875b3aa1aff5551f7c6b5e339..b5dd5ef9fa11ae1d54aa754325bac2e184b90dd3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -284,6 +284,11 @@ eth_phy: ethernet-phy@0 {
 	};
 };
 
+&gpu {
+	mali-supply = <&mt6357_vcore_reg>;
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <100000>;
 	pinctrl-0 = <&i2c0_pins>;
@@ -353,6 +358,10 @@ touchscreen@5d {
 	};
 };
 
+&mfg {
+	domain-supply = <&mt6357_vsram_others_reg>;
+};
+
 &mmc0 {
 	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL>;
 	assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;

-- 
2.50.1


