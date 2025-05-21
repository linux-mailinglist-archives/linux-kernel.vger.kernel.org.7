Return-Path: <linux-kernel+bounces-656776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44456ABEAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 06:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BEF1892463
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 04:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5122FF42;
	Wed, 21 May 2025 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+06skH8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D322E41C
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800660; cv=none; b=KSlozIjaNuKvOxn/CESiFMAx2eAbW4IfQr5Ggw7Ex2/78qrR/qS6WJtPJeujZ02umQZzdX3yppXbzFPL2Ru/WtP1ztfp3qY6qEgNNb0liHm1ABS61AyGLoyivATrMPaTDkopdBnQjqSQTxeiVEDbUt/vGDTWOEbh3xtqyFPxpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800660; c=relaxed/simple;
	bh=9+av1MoRfTDg6Xt8AzhHXFQWRHO8Hs6yciyb3ZWXh0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oXaA1EigfyHijahbqmyobP2F4x5Rpg0Qi9bnSnt4BPApHielww9+PT6a5a4QHsLy1nBW+kBYuHRXK/Ia2XYAimGNWnE20+ZdWfSPpn1CkRFUUw8f81xIDZk1oyKiQIL7PL/f2oWo4+1jIA4YlHjv/4sydL8CX4j22LL8Yzf+FGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+06skH8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747800657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOpCIpUBE+zc1Cnk22l0S5fBkIXF5NBzxV3nU11JwcE=;
	b=V+06skH8KRzMg9Ar6RNpAigJllrIioaXtU299HZfG2WI2wOWXCVrlBFjNrTx32HbE+9LQb
	V+52ZbIB8YykTC9z3uhTnIEkT8Z2fmOBXWpmstVkdAsc1Hu7B3zt/jcy1DqLtyU26fpq2z
	k0LVr1wMc/ky+6AB1xQwEPkdsRCNDw8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-692LpgF2NxKruf0zgf_B5w-1; Wed,
 21 May 2025 00:10:51 -0400
X-MC-Unique: 692LpgF2NxKruf0zgf_B5w-1
X-Mimecast-MFC-AGG-ID: 692LpgF2NxKruf0zgf_B5w_1747800649
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E9BC18001D5;
	Wed, 21 May 2025 04:10:49 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.184])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B54F195608F;
	Wed, 21 May 2025 04:10:43 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 20 May 2025 22:03:49 -0500
Subject: [PATCH v3 18/30] panel/lincolntech-lcd197: Use refcounted
 allocation in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-drivers-mass-convert-part2-v3-18-f7ae7b723c68@redhat.com>
References: <20250520-drivers-mass-convert-part2-v3-0-f7ae7b723c68@redhat.com>
In-Reply-To: <20250520-drivers-mass-convert-part2-v3-0-f7ae7b723c68@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Icenowy Zheng <icenowy@aosc.io>, Jagan Teki <jagan@amarulasolutions.com>, 
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Walle <mwalle@kernel.org>, Jagan Teki <jagan@edgeble.ai>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jianhua Lu <lujianhua000@gmail.com>, Stefan Mavrodiev <stefan@olimex.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747796667; l=1573;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=9+av1MoRfTDg6Xt8AzhHXFQWRHO8Hs6yciyb3ZWXh0k=;
 b=dKX5BqIJOfyFx2dCKnijeLENv6cljOeqolS/y4OTxDa3xwNM3FqawLxNN+UjBiVgbp+LJ9hU7
 vi4LHfqZjJFC9ldAWeUzuCtwv5vYTYFH5aHYRzJujjiQFImXTdN5Rke
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
v3: s/ctx/lcd. fix compilation
v2: none.
---
 drivers/gpu/drm/panel/panel-lincolntech-lcd197.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c b/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
index 032c542aab0f788e8a244721c838d9d740af98fb..24b34443ace02bc179da5068d52b1115805deea9 100644
--- a/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
+++ b/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
@@ -190,9 +190,11 @@ static int lincoln_lcd197_panel_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = (MIPI_DSI_MODE_VIDEO |
 			   MIPI_DSI_MODE_VIDEO_BURST);
 
-	lcd = devm_kzalloc(&dsi->dev, sizeof(*lcd), GFP_KERNEL);
-	if (!lcd)
-		return -ENOMEM;
+	lcd = devm_drm_panel_alloc(dev, struct lincoln_lcd197_panel, panel,
+				   &lincoln_lcd197_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(lcd))
+		return PTR_ERR(lcd);
 
 	mipi_dsi_set_drvdata(dsi, lcd);
 	lcd->dsi = dsi;
@@ -214,9 +216,6 @@ static int lincoln_lcd197_panel_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(lcd->reset_gpio),
 				     "failed to get reset gpio");
 
-	drm_panel_init(&lcd->panel, dev,
-		       &lincoln_lcd197_panel_funcs, DRM_MODE_CONNECTOR_DSI);
-
 	err = drm_panel_of_backlight(&lcd->panel);
 	if (err)
 		return err;

-- 
2.48.1


