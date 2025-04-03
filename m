Return-Path: <linux-kernel+bounces-587877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EEEA7B151
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5321B605F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47771FF1D1;
	Thu,  3 Apr 2025 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuH9zW1x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EA1FECC6
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715533; cv=none; b=YRcClhOCNiG3AdHJegwGDjxO5fGl8zK3BN3luUyZ/h0voYH7T4wmKo1Lu26X7SszaJMxd+bNShbE5R8T2YSFBrM0XQQzP96VnG1eshgmtQ2f+n6b/9SyI0C3FOXtJKr3Gth6cxeJfipU3Qt3QWwuZqaTRJWpdr5Owx1EqO7g1aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715533; c=relaxed/simple;
	bh=ZKaWnW/6cQZn+CDlUP2TSkD0oUya2A47iGLWnNKidk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBiZ1UhYE9vVyzcS1z9q9Cjt+PQS81le9RiLAbL6OLqk0y7wf97oRjuMG9J1fr1O4aXh5YC4Ko69Hi0E0I1qpPcpH+y0hCjb+F5gnrBnwQaGu1iJxIhZUh45Df2Xq8NNyge+bjy9sGpeejV3AczlI3kTKX+bxZWW2Las0kgWPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuH9zW1x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743715530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/rKSNm9hTvEah8Dl409QcW46SE5bQw2NyWUMSj+buM=;
	b=DuH9zW1xHtlbJerpYHBCaG7rj8V9MYprGtd62keY9+RBPtZePqBcoh7PFhCFuylxfh3Gpq
	zcidvC9+QP0Np5fMdCGWl3WBPuLQU7AJgVkpaI685PBQc4pAjMU+jd+bn3/shPRa2wV+s0
	1MkMk77Hyy9XsrHZpmQI823j3Qqglxs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-GphoRuoZPH2yh18uKP8Ecw-1; Thu,
 03 Apr 2025 17:25:25 -0400
X-MC-Unique: GphoRuoZPH2yh18uKP8Ecw-1
X-Mimecast-MFC-AGG-ID: GphoRuoZPH2yh18uKP8Ecw_1743715523
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAB5E180AF50;
	Thu,  3 Apr 2025 21:25:22 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 790A9180B488;
	Thu,  3 Apr 2025 21:25:18 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 03 Apr 2025 16:21:10 -0400
Subject: [PATCH 39/46] panel/visionox-rm692e5.c: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-drm_panel_mass_driver_convert_part3-v1-39-965b15ad5b8e@redhat.com>
References: <20250403-b4-drm_panel_mass_driver_convert_part3-v1-0-965b15ad5b8e@redhat.com>
In-Reply-To: <20250403-b4-drm_panel_mass_driver_convert_part3-v1-0-965b15ad5b8e@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Chiras <robert.chiras@nxp.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Markuss Broks <markuss.broks@gmail.com>, 
 Artur Weber <aweber.kernel@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743711639; l=1481;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=ZKaWnW/6cQZn+CDlUP2TSkD0oUya2A47iGLWnNKidk4=;
 b=KCxgXUHD+W0B+JBAtbFESmZvdP7Iea2tYlSz0sXRFFk12f3aS1twiCf5ZAow38tHPo1XIezxz
 DmAeM7LVQ2xDa3lBMFRmwYj7oiZpCjnMcXHCs3MwnQSXU5kJpXAQH01
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-visionox-rm692e5.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm692e5.c b/drivers/gpu/drm/panel/panel-visionox-rm692e5.c
index 4db7fa8d74c4bb6fe733169d264e91c85eeaa32b..e53645d5941376e5c251601cff5bf485b0c817a7 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm692e5.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm692e5.c
@@ -360,9 +360,11 @@ static int visionox_rm692e5_probe(struct mipi_dsi_device *dsi)
 	struct visionox_rm692e5 *ctx;
 	int ret;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(dev, struct visionox_rm692e5, panel,
+				   &visionox_rm692e5_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	ret = devm_regulator_bulk_get_const(&dsi->dev,
 					    ARRAY_SIZE(visionox_rm692e5_supplies),
@@ -383,8 +385,6 @@ static int visionox_rm692e5_probe(struct mipi_dsi_device *dsi)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
-	drm_panel_init(&ctx->panel, dev, &visionox_rm692e5_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	ctx->panel.prepare_prev_first = true;
 
 	ctx->panel.backlight = visionox_rm692e5_create_backlight(dsi);

-- 
2.48.1


