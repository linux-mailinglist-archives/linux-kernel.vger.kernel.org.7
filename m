Return-Path: <linux-kernel+bounces-596010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6BA825C2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 15:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FD98C32B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7955B265613;
	Wed,  9 Apr 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AALbTqyk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E39263F3A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204400; cv=none; b=ud/4ivzHafAWCFb7ANZLuyKKk3cJRS2DVQX7VfJVgIwpOX+B3lQOkzJYi4vNB2iKeq6p3ZdWwFDZ+xID2Pfct9mnPGCF2Pe0leyTfG6XWDuzqJC7OQUCfeuoGHDlV+Aw5zIZR8+WqnbL+iiz3Io6UaJpHFC5ioGI7EsY3cczeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204400; c=relaxed/simple;
	bh=NEuXEAf0EoHvdi3tLgzyhmCbJUmfqZDU6pN1X9AaFMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKBTFS8WRsYhe2gW2I6vU0hrlv6vZdgOr6h6c49TmQNwao+jdGb163XRUrOav/eSRPEiQblGZWNPp9u1cfc0VRwejw6dEhZnekkJTPDyN5wJ46yyJvEJJTCkJyQKL9ZXEuwO//h/o47Qm6xYmYD5GBL0OzNr1K8PxXshYs1G2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AALbTqyk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744204397;
	bh=NEuXEAf0EoHvdi3tLgzyhmCbJUmfqZDU6pN1X9AaFMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AALbTqykzgOFJwXwrfudo7uMKkPLpsGgttDFYQ/SHqOVCdGLvIuMr+OiI0f3r7s3l
	 cT4p7GxNdHYQ1+z57QywB+fSapcg2pUN8qIyEZ5nMwhbS6yl2rUUUWlBcp2h6jXVmW
	 f1myxybJ6YqDKKos0Cg6YGg7TNBn3CnAj/ET46w3wSGG+CGdghGPZAs30hoZ0Ho2BB
	 hJqa3pbv0LKe2+BGG3L+7ibaoDI2GVXnw1W3yylMmwIvBhwBVCnMPE0QC21SoJwvp9
	 BjmmC0qUeyIx3JVSkgOHiCb8FbRQ9iReaBMg098MnjgoA1UkGauCZg4S1fC/ESO32U
	 V3H25MdeUH0SQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C775917E0FC1;
	Wed,  9 Apr 2025 15:13:16 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	lewis.liao@mediatek.com,
	ives.chenjh@mediatek.com,
	tommyyl.chen@mediatek.com,
	jason-jh.lin@mediatek.com
Subject: [PATCH v1 5/5] drm/mediatek: mtk_dpi: Rename output fmts array for MT8195 DP_INTF
Date: Wed,  9 Apr 2025 15:13:06 +0200
Message-ID: <20250409131306.108635-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409131306.108635-1-angelogioacchino.delregno@collabora.com>
References: <20250409131306.108635-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the sake of increasing human readability and avoid possible
confusion between DPI and DP_INTF output formats (as the two are
ever so slightly different), rename the mt8195_output_fmts array
to mt8195_dp_intf_output_fmts.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 9de537a77493..0b7f91fb519f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -1106,7 +1106,7 @@ static const u32 mt8195_dpi_output_fmts[] = {
 	MEDIA_BUS_FMT_YUV10_1X30,
 };
 
-static const u32 mt8195_output_fmts[] = {
+static const u32 mt8195_dp_intf_output_fmts[] = {
 	MEDIA_BUS_FMT_RGB888_1X24,
 	MEDIA_BUS_FMT_RGB888_2X12_LE,
 	MEDIA_BUS_FMT_RGB888_2X12_BE,
@@ -1248,8 +1248,8 @@ static const struct mtk_dpi_conf mt8195_dpintf_conf = {
 	.dpi_factor = dpi_factor_mt8195_dp_intf,
 	.num_dpi_factor = ARRAY_SIZE(dpi_factor_mt8195_dp_intf),
 	.max_clock_khz = 600000,
-	.output_fmts = mt8195_output_fmts,
-	.num_output_fmts = ARRAY_SIZE(mt8195_output_fmts),
+	.output_fmts = mt8195_dp_intf_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8195_dp_intf_output_fmts),
 	.pixels_per_iter = 4,
 	.dimension_mask = DPINTF_HPW_MASK,
 	.hvsize_mask = DPINTF_HSIZE_MASK,
-- 
2.49.0


