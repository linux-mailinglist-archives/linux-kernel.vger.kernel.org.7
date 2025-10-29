Return-Path: <linux-kernel+bounces-876047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D3AC1A849
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC13B584774
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEEC34CFDF;
	Wed, 29 Oct 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dwurp.de header.i=@dwurp.de header.b="xiKzlm+H"
Received: from mail.dwurp.de (mail.dwurp.de [185.183.156.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75630748D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.183.156.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741624; cv=none; b=A6tbgKKfKCPj54YIvSfN20IA6BzejL5X/zPFdwrinDLDro+72sEjERVypxjZDZ4Poqpi+r5zLxdNRgFWgSU7+Le9sA/MpPKRBuOgUO1hU6kpkzCy5oxGnRJjk2q8FHdnm8xFqXOV/WCEPCLlqATq/h8VNs0TMEFkMPyc6+KNxlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741624; c=relaxed/simple;
	bh=OZqfzFdxoIzorBe7PjAS4/RI5ndFQdger9fTPlhH6ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZS02U5jGvuIltGbGz75Md2kT+ZP6jO6UuqYCcnES8x2+ZTJT87fQ5E23P8jYA043quFGVXJMxPA4+PgvaPeocVQ0rR0BLBfp+C7YrsbrtMqDKte/Tr77QIhA1C3piVQBJbfc4Ir0eEuqAF01mwoWXROUtkhSVrfGIO/oQ7W7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dwurp.de; spf=pass smtp.mailfrom=dwurp.de; dkim=pass (1024-bit key) header.d=dwurp.de header.i=@dwurp.de header.b=xiKzlm+H; arc=none smtp.client-ip=185.183.156.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dwurp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwurp.de
From: Sebastian Fleer <dev@dwurp.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwurp.de; s=mail;
	t=1761741619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VJB18FjU3ZpQ6gifGhjmuB4V1Bz7InYQSrBtNNvS9nY=;
	b=xiKzlm+HnHTnGz2qD52EB+8BPoj+bdgDWpbATTdUSjax05wDaVRieLomD/HxkN4iIUIm1n
	RLMPjULfR4H9d55XcPS7k3u/BRxTdIickyIz8RYzMfhVYlnwlvnjb+TlgSd7PQg9xYX2TQ
	NbK2HqFU5bQGKtitAL1ncqKSYnmEXTM=
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Fritz <chf.fritz@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jens Reidel <adrian@postmarketos.org>
Subject: [PATCH v2] drm/panel: kingdisplay-kd097d04: Disable EoTp
Date: Wed, 29 Oct 2025 13:35:28 +0100
Message-ID: <20251029124007.232333-1-dev@dwurp.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit d97e71e44937 ("drm/bridge: synopsys: dw-mipi-dsi: enable EoTp by
default") panel output on an Acer Chromebook Tab 10 (google-dru) is corrupted.
The tablet I use is equipped with a kingdisplay-kd097d04 panel, disabling EoTp
restores the correct functionality.

Fixes: 2a994cbed6b2 ("drm/panel: Add Kingdisplay KD097D04 panel driver")
Suggested-by: Jens Reidel <adrian@postmarketos.org>
Signed-off-by: Sebastian Fleer <dev@dwurp.de>
---

Changes in v2:
- Reference correct commit in Fixes tag
- Added Suggested-by

---
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 2fc7b0779b37..893af9b16756 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -359,7 +359,7 @@ static int kingdisplay_panel_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_LPM;
+			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET;
 
 	kingdisplay = devm_drm_panel_alloc(&dsi->dev, __typeof(*kingdisplay), base,
 					   &kingdisplay_panel_funcs,
-- 
2.51.2


