Return-Path: <linux-kernel+bounces-862311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A85A4BF4F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F10E64F72BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F50280025;
	Tue, 21 Oct 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dW0gTjge"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6194C27FD6E;
	Tue, 21 Oct 2025 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031912; cv=none; b=pRyKHs+ves04BLkmSLBa7zUoYf1daT6JwRsNhGR3j2M8NgDKxiSPYZYFTGkKjvJnoPXMzPePSA76MdAzoV4ovUg0LvH/728AEaaCK09VJs3RTCXgLteWXiHF6AyZlzksrRnyzy3Lo2apQaPptB7pd369Vu2UswE2QctJF6vWPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031912; c=relaxed/simple;
	bh=qr9XyEgoKDrOvlQ/a4EvmrD00l7EvEI7RmtYodAKgIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GRI1thHU5jXSxX6IqGsx2eVDApEcWlsW5Qn0ym1ltJbgG9Q/eKWfHf2jbSLo0lqbsXWVGYAS7T2WGIg90G9MAgiWZgmsTLRJUTdKR/pdPw7+qfh6dEd53Q1RYU+QA51s3Ny9iAoIKtl4R8lMNvdYgV2x4j/PSX1/ZZ3xnjOFAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dW0gTjge; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761031908;
	bh=qr9XyEgoKDrOvlQ/a4EvmrD00l7EvEI7RmtYodAKgIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dW0gTjgeOApqnGqmEI57D2DqO0dLmHAF2ruzdQQoe0xxt+dy4PLcasIdyPbR6HG0M
	 Lv0N9El/lXwuwcdtP3baYFAASpLznKjJVFzGHzrrPddXI9d+GrifdBJQbgOWd84CnD
	 tsHOVG1yVeJ/xvC8z/hKQgKS7jT6ZsP+OIlj+U7pAXZOHFZRVl+PehVydDi6yZPSOH
	 6C2kEb9w8JrpQkWd1cznIflMWViMXLIleiCQvxdFWgRZbsTfJFoet1qAajhlcEOZ4t
	 EbqWu00tZ+ZkOYHrGfaLS3nYoixj0yblyor/1v6rnjZGReJ9HcLYNmPen+TxPfZqra
	 GXqqXZXkldPPg==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AF99D17E1404;
	Tue, 21 Oct 2025 09:31:47 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 21 Oct 2025 09:30:53 +0200
Subject: [PATCH v2 3/3] arm64: dts: mediatek: mt8365-evk: Enable GPU
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-mt8365-enable-gpu-v2-3-17e05cff2c86@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761031905; l=1137;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=qr9XyEgoKDrOvlQ/a4EvmrD00l7EvEI7RmtYodAKgIY=;
 b=BTk5evTjx76vWj0BG4kqs51CoKzKQA0I1u53jD7R8c+No3fzOaD/cj8PcW5jg7FGhngEcjNh5
 lfTS+ARGzmiB2mjtHq+TygszS/qCGstK24Iinm/XVo45JtYMCefdsmE
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Enable for the Mediatek Genio 350-EVK board the support of the
Arm Mali G52 MC1 GPU integrated in the MT8365 SoC.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 3de04ae70cc5fcd203a9cb745dfb3575ace66801..92ecde96dfeb4bdbc85a8fd869b405ef6cc1cdc0 100644
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
@@ -354,6 +359,10 @@ touchscreen@5d {
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
2.51.0


