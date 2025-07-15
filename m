Return-Path: <linux-kernel+bounces-732613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C843FB06984
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012C04E2E63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEE72D3EDD;
	Tue, 15 Jul 2025 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="fTCmM11C";
	dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="rO4B+He+"
Received: from mail.adomerle.pw (mail.adomerle.pw [185.125.100.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C22D1931;
	Tue, 15 Jul 2025 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.100.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620296; cv=none; b=kbFw7FUM4V68QGcCYTU0HD57z4VGlCcIuyxs074fcAB8G1IPMiIKDSF628IR9x1UE509Pgo67hC3jlf4hEKAV6LxOkmB313V0aNNMo5RN2OJ1PMpAAeAzv4n9r0UEJbleCo6nnTbOgyV0OYxhLeoC8k2LEpPxXjC35wBrs/J/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620296; c=relaxed/simple;
	bh=u1XE30y9kCF97/2NBxCRQVeeaimzzoDInmLf6wBEuC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRJbrvoXX/dynj8SBjz+T4+nVVPCcLRjqNMkzqxMeRyduiLKJO6dsajSdXgnHKXDlzE1/iigvxahG4T47JXFvCGwH2h/49g/tHF0k0B/Aw0Q5fsMYhAYicIrRzCdmX7MDvO4WMdJy7fSc8DMbs7J78OQbuPcsopml6P7sUPypZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw; spf=pass smtp.mailfrom=adomerle.pw; dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=fTCmM11C; dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=rO4B+He+; arc=none smtp.client-ip=185.125.100.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adomerle.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202506r; d=adomerle.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1752620275; bh=USA2Og1vbx3Iuv7PPIOLyPV
	akb2nDaD2HJC0yzF81E0=; b=fTCmM11CDqBBRhv2TaFptb/Zk9uH5o9RcqAVXcTKklR8y8Q6sO
	dWIWDPoZtYQrX3a4sv/NN5o4AcsvBiXGb0hYh31hdyY1NqaIUIaRM3Kn68wfIk1L7D2nED4T3EQ
	AyxRblh/s8imbI+zfq75Kxmwqb9BBVYOFlIb8YEQMJoYg0USML6l8BHMPgDnLZBZ5o1Tuz/Agvr
	iechjUJst2dEoqgccLqXswQ/RDF6dZJEUNkffUYhDRq7X/7SCwON4I4+Ps9x0CYiL81suI8dcQD
	QLve68vkKW+22OVMXvLix+RvwEyOjijwXPFTgVGpMdXBuQ+axbIzaDUXIAkoz0OvgGQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202506e; d=adomerle.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1752620275; bh=USA2Og1vbx3Iuv7PPIOLyPV
	akb2nDaD2HJC0yzF81E0=; b=rO4B+He+He4CSH4Nhf0+dhiAFI12D96su8wl7pGWBeUvce66fY
	nx8jYGNgnCwcG6NGpn2SPlkgYL9ijRlR8iCw==;
From: Arseniy Velikanov <me@adomerle.pw>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Arseniy Velikanov <me@adomerle.pw>
Subject: [PATCH v1 2/2] soc: mediatek: mtk-pmic-pwrap: Add MT6789 support
Date: Wed, 16 Jul 2025 02:57:46 +0400
Message-ID: <20250715225746.1321-2-me@adomerle.pw>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250715225746.1321-1-me@adomerle.pw>
References: <20250715225746.1321-1-me@adomerle.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PMIC-Wrapper support for MT6789 SoC.

Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 0bcd85826375..34b66cb656c7 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -640,6 +640,17 @@ static const int mt6779_regs[] = {
 	[PWRAP_WACS2_VLDCLR] =		0xC28,
 };
 
+static int mt6789_regs[] = {
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_TIMER_EN] =		0x3E4,
+	[PWRAP_INT_EN] =		0x450,
+	[PWRAP_WACS2_CMD] =		0x880,
+	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
+	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
+	[PWRAP_WACS2_VLDCLR] =		0x8A4,
+	[PWRAP_WACS2_RDATA] =		0x8A8,
+};
+
 static const int mt6795_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -1316,6 +1327,7 @@ enum pwrap_type {
 	PWRAP_MT2701,
 	PWRAP_MT6765,
 	PWRAP_MT6779,
+	PWRAP_MT6789,
 	PWRAP_MT6795,
 	PWRAP_MT6797,
 	PWRAP_MT6873,
@@ -1852,6 +1864,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	case PWRAP_MT7622:
 		pwrap_writel(wrp, 0, PWRAP_CIPHER_EN);
 		break;
+	case PWRAP_MT6789:
 	case PWRAP_MT6873:
 	case PWRAP_MT8183:
 	case PWRAP_MT8195:
@@ -2302,6 +2315,19 @@ static const struct pmic_wrapper_type pwrap_mt6779 = {
 	.init_soc_specific = NULL,
 };
 
+static struct pmic_wrapper_type pwrap_mt6789 = {
+	.regs = mt6789_regs,
+	.type = PWRAP_MT6789,
+	.arb_en_all = 0x777f,
+	.int_en_all = 0x180000,
+	.int1_en_all = 0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_ARB,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static const struct pmic_wrapper_type pwrap_mt6795 = {
 	.regs = mt6795_regs,
 	.type = PWRAP_MT6795,
@@ -2448,6 +2474,7 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
 	{ .compatible = "mediatek,mt2701-pwrap", .data = &pwrap_mt2701 },
 	{ .compatible = "mediatek,mt6765-pwrap", .data = &pwrap_mt6765 },
 	{ .compatible = "mediatek,mt6779-pwrap", .data = &pwrap_mt6779 },
+	{ .compatible = "mediatek,mt6789-pwrap", .data = &pwrap_mt6789 },
 	{ .compatible = "mediatek,mt6795-pwrap", .data = &pwrap_mt6795 },
 	{ .compatible = "mediatek,mt6797-pwrap", .data = &pwrap_mt6797 },
 	{ .compatible = "mediatek,mt6873-pwrap", .data = &pwrap_mt6873 },
-- 
2.50.0


