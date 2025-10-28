Return-Path: <linux-kernel+bounces-874788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA7EC17160
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E53B3BB65F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFFA2E9730;
	Tue, 28 Oct 2025 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dwurp.de header.i=@dwurp.de header.b="E+nUC4EY"
Received: from mail.dwurp.de (mail.dwurp.de [185.183.156.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB52E9733
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.183.156.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687987; cv=none; b=WWjfx2Ux1aoOhp8UWt66pY+rYxNOH+OpEhzsxr59aiQO+776uNMSGPqNYVBOAkqGY7rTwYrBMGppQBhpKkOuCxpjQ7Bjnyci7wBwyi9RL59hHAVubzNSXqLWEEoWXoQMuLrkes62Zy2WfWmsh1zVqT6RWLLmodREIFjacxqXeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687987; c=relaxed/simple;
	bh=gmJ7pVGTNizMj5fFA5HEWGgn8h6JzvidoxGobCB4Ie0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDybuhkf/psTSmHAsJcSxN39bmV4POT4vKzFrCwp4pVkr4sDZsVCPRUNtIwj8zHNxptoyvZfPhHUxNtK1lH2mDN4Eb+DNHsGOGIBODsoOS1YOCzVZpYka8WQhd97ofyVpxQn5kDgEw/HiFAWGsAUSl6TVp++uVGp6BbqLs3MmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dwurp.de; spf=pass smtp.mailfrom=dwurp.de; dkim=pass (1024-bit key) header.d=dwurp.de header.i=@dwurp.de header.b=E+nUC4EY; arc=none smtp.client-ip=185.183.156.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dwurp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwurp.de
From: Sebastian Fleer <dev@dwurp.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwurp.de; s=mail;
	t=1761687658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nup17Y1kzFSR3efnVH+GVmUx6KfCqfYTDIb4rIKMcv0=;
	b=E+nUC4EYq3xxVTJtbsuqJUw8PQokQXMEGuZ6+BEv/4KVQ4nmig+EpHI9+acnan2pnZ12DG
	fUwxmQsY12WRw1iD9URhQ1FIkcnP7o8ecd6of8QOYGazyBye8b8Z6sKoYXyjgy0DkVWddR
	+SVDoFnYqbBaotIF2LDA/TfiYVRlk2w=
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] drm/panel: kingdisplay-kd097d04: Disable EoTp
Date: Tue, 28 Oct 2025 22:38:12 +0100
Message-ID: <20251028214045.1944956-1-dev@dwurp.de>
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

Fixes: d97e71e44937 ("drm/bridge: synopsys: dw-mipi-dsi: enable EoTp by default")
Signed-off-by: Sebastian Fleer <dev@dwurp.de>
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


