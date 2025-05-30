Return-Path: <linux-kernel+bounces-667564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40472AC86BC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 04:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BF1188D20E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 02:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5FD221F18;
	Fri, 30 May 2025 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLKE3ax6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C8919CC3A
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573603; cv=none; b=X69RkCf5+ABpWy8gR9/7RVPa8+vdq+29+5mnPRTkT2A+hQw8je9Q+4x1Tev4VSeEpt+tqEsTMVeviM0kgNrdDHVflW2P1y3IwRi/geYD2nRAcsbEVr8Q3+VMAL649DIdzUES9ojblPQtOuybzhDATbt6UhR6URykxPfIxNWTd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573603; c=relaxed/simple;
	bh=cq/t+JYt9f18jDNHlp1xwHXjakBvHEyRzYySh/NPimU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fdNlakX585q+lcKYPzBuH1/SeRzf4mrCH09/foWMC6BlJaoq7tgoTxvdTSwyk5mSEPPhYy4TA5fSOa4/OM7BIzZJHzWQB/ZiKh+xbKXuINCFHaODIbAxhwnhnKJA8Sg1MkaO2CWi/9oK0wcDbAvVSU+fCKQuhbsUwkntVlGdGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLKE3ax6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748573601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZY0kgm6KEpMAsySHfqswnvva1AFbixcn2bV9jhCcCw=;
	b=SLKE3ax6xNmteBwzzREus9w8KPy5fwysqKbhxytDxWrgget0k10Yi06AyAdIg/mlDI9gCD
	83sQ8F11gEK4pbyAcyVxmj/nEJ7Q1Z1SIMXyH9eRpBjAky6f7HTS2YCGWynIG3Tb7ZAdOq
	VQUQRJhvCAeesDs0MylMeCqkvnxcTu0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-o-VcDIr9MP6PuYDVp-5ucA-1; Thu,
 29 May 2025 22:53:18 -0400
X-MC-Unique: o-VcDIr9MP6PuYDVp-5ucA-1
X-Mimecast-MFC-AGG-ID: o-VcDIr9MP6PuYDVp-5ucA_1748573595
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 569BE1800366;
	Fri, 30 May 2025 02:53:15 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.17.97])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1AAD1955D82;
	Fri, 30 May 2025 02:53:10 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 29 May 2025 21:46:41 -0500
Subject: [PATCH v2 39/46] panel/visionox-rm692e5.c: Use refcounted
 allocation in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-b4-drm_panel_mass_driver_convert_part3-v2-39-5d75a3711e40@redhat.com>
References: <20250529-b4-drm_panel_mass_driver_convert_part3-v2-0-5d75a3711e40@redhat.com>
In-Reply-To: <20250529-b4-drm_panel_mass_driver_convert_part3-v2-0-5d75a3711e40@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748573168; l=1553;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=cq/t+JYt9f18jDNHlp1xwHXjakBvHEyRzYySh/NPimU=;
 b=d8WwwcSiKbR0Q5GgqlTrEOsgpx9TGu70m4uES969Ymi+skv0W8FXtt4qYoEVpSh9QVUnKYT9N
 i3sVpwyI46fB+SUK0djQiv8lGmhGtfBbOj0K3iE/vPY85ROTnxvhAc2
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
v2: none
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


