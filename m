Return-Path: <linux-kernel+bounces-743827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 223E9B103C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6BE1CC2400
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB4227510E;
	Thu, 24 Jul 2025 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CL4kXhsJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A1274B4B;
	Thu, 24 Jul 2025 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346354; cv=none; b=abCnn1qRpor8K+Gsgovf6Oo/z8gG1wuSMC6xGBprqdHCtWd5Xnr5qUMQw5R4im3UeCQEtGCcEDWkZ6bMPGquDtkDwrIttOrZiNuNs9R6X1rY4v+KXTzvxv1ckEWoUTeJnmvBdPKSu2BrtNUCAhnNLApQ3nzREnQDiZP2NiAeNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346354; c=relaxed/simple;
	bh=TbLsiYD2WKRADkZMF09I8y6SP9/pzpukwJSQWNOyHkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUc2xGfQDSxLKr4MinWFdx4UY495YfPLiASzzBgEcusJGDYJKyDtnrsDpCgrr4icLSSQN3pImzJJAm95tNutYpZnZTiDZIS3WonDaMEGJUW2HgyifoU44dfD/+pvNK4ca7BOcH+vLsSXAEX81OdL0iGMuQHyoNKE5S29sbzKI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CL4kXhsJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753346351;
	bh=TbLsiYD2WKRADkZMF09I8y6SP9/pzpukwJSQWNOyHkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CL4kXhsJFkH8miuh3BMC765Je/N2G6/OiELhoJkKE0fTTcK6VPA5nnf36nd8a0Rts
	 x/HpUKo54UMft6ezx5qaZTI6KoFoa7OPYsHKVHKYe+HSgmpgUWtffIMRZL5X+eDJkt
	 9vnDGkiUK2vyydC9jNDolpDOwKI+D+/LPttmqK4qpcTz2kKwD6rjbq2H3hKMqAU2sb
	 6EcS48XZ8yJktXo8hq8+uFRiM4WGSkc41ulFLRzaGSoT+wRVFebD1NM7QLxRpAIr1l
	 44GBldk+SO2BzKbME8f5gohzbLzLWiFtFQKJauumCO6e0aV5nSNpybbYPQIE3YVtin
	 Rb3r5osQSArig==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9FC6217E1110;
	Thu, 24 Jul 2025 10:39:10 +0200 (CEST)
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
Subject: [PATCH 2/3] clk: mediatek: mt7622-aud: Add missing AFE_MRGIF clock
Date: Thu, 24 Jul 2025 10:39:06 +0200
Message-ID: <20250724083907.61313-2-angelogioacchino.delregno@collabora.com>
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

Add the AFE Merge Interface clock used for the audio subsystem.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt7622-aud.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 931a0598e598..a4ea5e20efa2 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -75,6 +75,7 @@ static const struct mtk_gate audio_clks[] = {
 	GATE_AUDIO1(CLK_AUDIO_A1SYS, "audio_a1sys", "a1sys_hp_sel", 21),
 	GATE_AUDIO1(CLK_AUDIO_A2SYS, "audio_a2sys", "a2sys_hp_sel", 22),
 	GATE_AUDIO1(CLK_AUDIO_AFE_CONN, "audio_afe_conn", "a1sys_hp_sel", 23),
+	GATE_AUDIO1(CLK_AUDIO_AFE_MRGIF, "audio_afe_mrgif", "aud_mux1_sel", 25),
 	/* AUDIO2 */
 	GATE_AUDIO2(CLK_AUDIO_UL1, "audio_ul1", "a1sys_hp_sel", 0),
 	GATE_AUDIO2(CLK_AUDIO_UL2, "audio_ul2", "a1sys_hp_sel", 1),
-- 
2.50.1


