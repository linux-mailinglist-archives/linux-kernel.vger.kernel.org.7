Return-Path: <linux-kernel+bounces-743828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE04B103D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B52A7AFB53
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A51276048;
	Thu, 24 Jul 2025 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pxusdln6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00323274B53;
	Thu, 24 Jul 2025 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346355; cv=none; b=UiK7LDnudB8K54KX1BMFhXNbzEvZvbon5RarAs6caSQLcO0Qz88lXoBQHr2EB6XHOON7RQYJ/7IDDsoStAYFij9UZaUViDsqWVEOcBhorNBhuzjppSdQsxlWMd+959eAdg8nGFS7d+VLrPaP6K7exhKwJAp1LNqZx/Br7jiAR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346355; c=relaxed/simple;
	bh=k3CxvdIFne4d7WnWUFyHn9jMo/aAR5LTnqhS5VtHfmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ad+KAZy5m0+0KCGu3FTKP13xNmaWgjlkfRx6DvxuXDsy2fgmBkNycFqQ2xcX9aVKpB8i1poak87acH4rpzmfMAhVfacoIXxrL+18Xdni+sbtaohkhjajX1q9j855AP1ILkARV6+n+nXLGx3DUIPJn1/dTB7TSWHfQa1iYYzG7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pxusdln6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753346352;
	bh=k3CxvdIFne4d7WnWUFyHn9jMo/aAR5LTnqhS5VtHfmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pxusdln65wCWqLYwZuVfsCEnelwtqT+Nd6iQJaDo7Xk+5M/1q9kvkZgm9n38IjIml
	 VS714qsiF9Q8EGHmCPh7tQ9oDi98BdkCKhKPPkzI1m9bxiZPO/fw8cVdNBBKUQ2L70
	 kpuYBOr9GXvSrYV5Fe1RtxE/AoWD/Ij+uVu/C/V++qo2KjnlKUUPHPSFPCPPNHCiRB
	 LGdCSwGQdENJCuJC3H28I1whEb+ju+k+IT48KlU/SMkCiNWoxyXNQ+YkLaM5Wdu1GI
	 4PcGGLunD3YBILPKjhJp8xgp2jLIruxu3kU/WJbfU62vZlaYUmDgDafKuGLuxyOkl3
	 K2qokTPUlYQgA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 89DBD17E11EE;
	Thu, 24 Jul 2025 10:39:11 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	geert+renesas@glider.be,
	u.kleine-koenig@baylibre.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-clk@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 3/3] arm64: dts: mediatek: mt7622: Add missing audio_mrgif_pd clock
Date: Thu, 24 Jul 2025 10:39:07 +0200
Message-ID: <20250724083907.61313-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724083907.61313-1-angelogioacchino.delregno@collabora.com>
References: <20250724083907.61313-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing audio merge interface clock to the audio-controller
node to enable the ability to merge AFE connections.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 917fa39a74f8..308c23b9de28 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -650,7 +650,8 @@ afe: audio-controller {
 				 <&audsys CLK_AUDIO_AFE>,
 				 <&audsys CLK_AUDIO_AFE_CONN>,
 				 <&audsys CLK_AUDIO_A1SYS>,
-				 <&audsys CLK_AUDIO_A2SYS>;
+				 <&audsys CLK_AUDIO_A2SYS>,
+				 <&audsys CLK_AUDIO_AFE_MRGIF>;
 
 			clock-names = "infra_sys_audio_clk",
 				      "top_audio_mux1_sel",
@@ -684,7 +685,8 @@ afe: audio-controller {
 				      "audio_afe_pd",
 				      "audio_afe_conn_pd",
 				      "audio_a1sys_pd",
-				      "audio_a2sys_pd";
+				      "audio_a2sys_pd",
+				      "audio_mrgif_pd";
 
 			assigned-clocks = <&topckgen CLK_TOP_A1SYS_HP_SEL>,
 					  <&topckgen CLK_TOP_A2SYS_HP_SEL>,
-- 
2.50.1


