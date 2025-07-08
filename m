Return-Path: <linux-kernel+bounces-722349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12286AFD87D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D615686E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB37A24169A;
	Tue,  8 Jul 2025 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5agfP6T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9123AB9D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006994; cv=none; b=PBEJxRtAFJnIIUPx8xDCfZWma7y5RrHSuYmRNugTcFPfieRzKabTDD0XZFUfnHiBw3xYl0wzUaoWstZmF9aGxhHSeJXQxtK1IV4nM5LkFonCR3HgmqhQQGP1ZQrLpzF5bePGsSDdJaO9XOprNbyDOtmEHb6EBxPj//5mi1VFldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006994; c=relaxed/simple;
	bh=Dw6Cs+A/hBHtq4601NDIRAdDThTx44TPw7gqGwpJVc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YEpnL3eYB48DcCgsAPrjCJiGKuJWHsPJf1r7e6wdJO75McnRQNIR/fOvuLFeIdy6KWZoMuiuAuvg6b0Achh+LTTDHe3jLfsnNMymIGINqCBLu7vwpejdqSg6Nmz26qVqA/zIH5y0DZaR7rQWI4jKlKBrdWaMrAVw1pLYKi5mgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5agfP6T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752006991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pp6uoEdFg9IjTT5RKNshFKfo5L4alpIIljULoKU13vk=;
	b=E5agfP6T2ZA47PSXxJSGQQ95YoMxCLwV5rb4TGw7TyJoitnvAZxKI0EEVt4tZIypFJnCJB
	h673KaDF58g7yAuh3vT7UHtXZGccZt3CJ/VhfKmhIby3tKBLAp8vnChiu7sH7bLj7n+GCP
	UshCcEtTE6jAvAqWFSPr80SYscdyU3w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-DCZ9Y0jmNy6fOFNCXEOQnQ-1; Tue,
 08 Jul 2025 16:36:26 -0400
X-MC-Unique: DCZ9Y0jmNy6fOFNCXEOQnQ-1
X-Mimecast-MFC-AGG-ID: DCZ9Y0jmNy6fOFNCXEOQnQ_1752006984
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 073B51955ECA;
	Tue,  8 Jul 2025 20:36:24 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.132])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BB2619560A2;
	Tue,  8 Jul 2025 20:36:21 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 08 Jul 2025 15:35:13 -0500
Subject: [PATCH 1/6] drm/panel/visionox-g2647fb105: Use refcounted
 allocation in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-simple-panel-api-convert-july-v1-1-630902123ea1@redhat.com>
References: <20250708-b4-simple-panel-api-convert-july-v1-0-630902123ea1@redhat.com>
In-Reply-To: <20250708-b4-simple-panel-api-convert-july-v1-0-630902123ea1@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752006919; l=1552;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=Dw6Cs+A/hBHtq4601NDIRAdDThTx44TPw7gqGwpJVc0=;
 b=U3oT3iEsDQdg07rYjv4hbcxBaPVzlRgTZAjDsLxkEVJkm0PT1GtJ1HKEFYjSMQX27JLQad/sL
 xp2BrM89j2cDeSNMn7ZglNuDN5MI9Mnl8Zf/atyfpYpO3ulpIK7Mg8z
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-visionox-g2647fb105.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c b/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c
index 413849f7b4dec97e9afa2df2843ef25898ed2549..eac6ec6e71d17285431b1cef3cb46d133f0648d9 100644
--- a/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c
+++ b/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c
@@ -207,9 +207,11 @@ static int visionox_g2647fb105_probe(struct mipi_dsi_device *dsi)
 	struct visionox_g2647fb105 *ctx;
 	int ret;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
+				   &visionox_g2647fb105_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	ret = devm_regulator_bulk_get_const(dev,
 					    ARRAY_SIZE(visionox_g2647fb105_supplies),
@@ -233,8 +235,6 @@ static int visionox_g2647fb105_probe(struct mipi_dsi_device *dsi)
 
 	ctx->panel.prepare_prev_first = true;
 
-	drm_panel_init(&ctx->panel, dev, &visionox_g2647fb105_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	ctx->panel.prepare_prev_first = true;
 
 	ctx->panel.backlight = visionox_g2647fb105_create_backlight(dsi);

-- 
2.48.1


