Return-Path: <linux-kernel+bounces-587836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52089A7B0AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BF37A1E89
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788D819F416;
	Thu,  3 Apr 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNg7X31G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884E14D433
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715351; cv=none; b=iB9VWnZowWAP0df8jC1M8cklynH3nfRQ2oUmIfEOiD7V+oxJT8sMtTlvH9vhqoyeiOANpDnfSF7t/gByUtWXSCxbissUEjRdFARZg5GBv5kLG4HlzDR+9/sThGu8r4kxCbhWVhzcZrHoe7FYyzdECFg4iBLaXmJKEEoMQamJaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715351; c=relaxed/simple;
	bh=N7+fvEGSle+CiECzPRbyfQ0I0pUwpBGgYZ3g1VjEgW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWVQgegGVPItaYTSSlgTHsHqN+XQ9s98VkFlEFvOuZEP/RIRe71dVL6NT9Jp/1zhI43SvmI1xKKuguIyO4p4Vc7OsF4neF+jkguy1yp989B0bUaDhiT/rZRH8fJt202Z/Q6+NMu/7aBDNLe/AbxZtt1guYdEjnbMSCbzrE8jRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNg7X31G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743715347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbWoNY9eB9OhX9nmhxgb7o/HKV1VVen0saleq9zaONc=;
	b=HNg7X31GDpVScUAeEqENSJ+I3ErFSwjtJ0xE22gwEI+50bwbI+w6XoT3ELB88FfEZ411nb
	hQWD549aPuRnUiBV6Uw9GnXa6T2FV0Qwa5RN1mMI1eyxOHoeFiZWZ17A9A5wCw6VsRifu4
	jOUpwguxKSHsXyeNhcMOZvOBiyiplJU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-3CL4Tfp0PryOy1dvFV63Cg-1; Thu,
 03 Apr 2025 17:22:24 -0400
X-MC-Unique: 3CL4Tfp0PryOy1dvFV63Cg-1
X-Mimecast-MFC-AGG-ID: 3CL4Tfp0PryOy1dvFV63Cg_1743715341
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71DCF19560B6;
	Thu,  3 Apr 2025 21:22:20 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12D841828AA8;
	Thu,  3 Apr 2025 21:22:14 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 03 Apr 2025 16:20:33 -0400
Subject: [PATCH 02/46] panel/raydium-rm67191: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-drm_panel_mass_driver_convert_part3-v1-2-965b15ad5b8e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743711639; l=1275;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=N7+fvEGSle+CiECzPRbyfQ0I0pUwpBGgYZ3g1VjEgW0=;
 b=mfNNq9/+87q+tbV2UrEYPOYGZYXfFne447vSfFpi8tVe8sqRbZHy1N3YL5Rf8lyJDgq9qbGJ1
 yugKU0QK2drBswBAJJdsPfYoOQ6Dtp9Q4cOiCiuu1la+Xx+x7whoSoU
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-raydium-rm67191.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index b2029e0356358f55e7a13a32202f0e38c7f0434b..2af6aa47a5510122c1e9e697cf42a7fc9993197d 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -527,9 +527,11 @@ static int rad_panel_probe(struct mipi_dsi_device *dsi)
 	int ret;
 	u32 video_mode;
 
-	panel = devm_kzalloc(&dsi->dev, sizeof(*panel), GFP_KERNEL);
-	if (!panel)
-		return -ENOMEM;
+	panel = devm_drm_panel_alloc(dev, struct rad_panel, panel,
+				     &rad_panel_funcs,
+				     DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(panel))
+		return PTR_ERR(panel);
 
 	mipi_dsi_set_drvdata(dsi, panel);
 
@@ -586,8 +588,6 @@ static int rad_panel_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_init(&panel->panel, dev, &rad_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	dev_set_drvdata(dev, panel);
 
 	drm_panel_add(&panel->panel);

-- 
2.48.1


