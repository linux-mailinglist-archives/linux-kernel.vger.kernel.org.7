Return-Path: <linux-kernel+bounces-667531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A3AC8678
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 04:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B82D3A04A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 02:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17891C54AA;
	Fri, 30 May 2025 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViDo/dI+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E254191F91
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573441; cv=none; b=ga1EQx9hwKbXDqXBy/H4d/zySAFtpoCm2f/hAbOryUV8oC1d7DmHNH90V+uak9zxf3oyAefuKq7Fs4CRfHKQY8v28k8sqcidzFKhVkgq3//rkG+Wauj/FaTVZDHyJnOAVwvsAEIdaoCrD2T3TV9e++MKYoMpfnBjwaNa4VM5iuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573441; c=relaxed/simple;
	bh=SL5XsAZhcqZkqnmNdWeFDmk+1My9tmF7Rq8ky+W6RSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=djJNupxnEH1gzkAZWLw3QAIDMBwyZxeOgpojRRSx/RbvZBOnuruP9Dkc/W2UEEmzAcuZyDim9iyzkKiL0uBt6ZhqSot1aVBe+Rw771PNpk7Zogc5pSrJWQIVykddpFKyZ4bft1S9oCngvAaLXGpzADO+jERm8Cun0ahlKl5Lir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViDo/dI+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748573438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OTXs9GPeGDdK1tO0sr8JA4qFlGdw8TGC9kKclzho0o=;
	b=ViDo/dI+rH9MeKID6ETma6SEOylVPgE4SLNo0cnXKozlYRCelBPUtQVt7pzRJ5K+5/ChLn
	awz5GmfjK7gTtVkyDuPLY7piDpuRIvV/SYznuMezJO7sf3wNYE5mC/GCBZeHCZJaFtokyp
	PHGnGEa/2D3j42AsRf5Vu1dEkcCCtJM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-2k4emOokNeCnCmNzL1g9Fw-1; Thu,
 29 May 2025 22:50:35 -0400
X-MC-Unique: 2k4emOokNeCnCmNzL1g9Fw-1
X-Mimecast-MFC-AGG-ID: 2k4emOokNeCnCmNzL1g9Fw_1748573432
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 944E31956095;
	Fri, 30 May 2025 02:50:32 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.17.97])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35BA11955D82;
	Fri, 30 May 2025 02:50:28 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 29 May 2025 21:46:10 -0500
Subject: [PATCH v2 08/46] panel/samsung-ams581vf01: Use refcounted
 allocation in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-b4-drm_panel_mass_driver_convert_part3-v2-8-5d75a3711e40@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748573168; l=1573;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=SL5XsAZhcqZkqnmNdWeFDmk+1My9tmF7Rq8ky+W6RSA=;
 b=+KVbQtBG7Foaz3UjEoUaDvg48smcmmBTVjvLleNaUwgsqdnk+siplDNmaFRSGAPLTQQRmYM9E
 oMUvJx4P3uEDrm89b4EjTWGIdxrHLVQViW6+F+VlHWL4tu0u8ivVJ4X
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
v2: refactor. use &dsi->dev instead of dev.
---
 drivers/gpu/drm/panel/panel-samsung-ams581vf01.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-ams581vf01.c b/drivers/gpu/drm/panel/panel-samsung-ams581vf01.c
index cf61863122520ea1c2f6179bf51cef01d26db45e..188dd7cf0297f59e716dcd8aba3b03684d723bf9 100644
--- a/drivers/gpu/drm/panel/panel-samsung-ams581vf01.c
+++ b/drivers/gpu/drm/panel/panel-samsung-ams581vf01.c
@@ -211,9 +211,11 @@ static int ams581vf01_probe(struct mipi_dsi_device *dsi)
 	struct ams581vf01 *ctx;
 	int ret;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(&dsi->dev, struct ams581vf01, panel,
+				   &ams581vf01_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	ret = devm_regulator_bulk_get_const(&dsi->dev,
 					    ARRAY_SIZE(ams581vf01_supplies),
@@ -235,8 +237,6 @@ static int ams581vf01_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM;
 
-	drm_panel_init(&ctx->panel, dev, &ams581vf01_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	ctx->panel.prepare_prev_first = true;
 
 	ctx->panel.backlight = ams581vf01_create_backlight(dsi);

-- 
2.48.1


