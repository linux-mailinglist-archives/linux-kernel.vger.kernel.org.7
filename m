Return-Path: <linux-kernel+bounces-585396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7240A79321
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE4118974F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 16:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26651957E4;
	Wed,  2 Apr 2025 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP7QQAvX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB3194C61
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611203; cv=none; b=UtunvIDPQ4aDiCS4qpVhqaJvltqwngPskG4B2/Ui4H91YhNrXTT1Ug/8UgIgQKb2x9S5wZbVtDdhQnr1y7zN182RNAy3xAfPb5ILpWOB/LBmiICf1cjwommsNnplY7u8vQXf7TaonsoXXhHLnlfrk1M2XNUeS7usHWdoOlp+wII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611203; c=relaxed/simple;
	bh=IMFre+7l7tWbk4mIS8m6SZxjRxqcMTkoQU9WfWpKabg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmGPmcInmr/IHfF0P4YWzdYuByAklzAvqtaiWx0JjNoJ2SiFdMcmfx24yvchDoV9aPDle65Mmnkhxs37SO6SPNLEj/t1jb5BzCCR4ozYGWI5QFqCOU97ND2a6eEyvPk8sTtmUj/4CMtwIatyHjOGj4kRs+qNpBb+E3swcafMHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP7QQAvX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743611199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npvZMXfvWV8eo3hpNGDEvptxCke1n/j0iwAHzQnv9eU=;
	b=UP7QQAvXq7OuIESK544S7nnTH9WSnOD6D+31JUFRt7BBrhC5DDl7WZkshozeL2ZWyh8i8N
	Co+1WrBkZjp1XtIO8WM5NIKTlsdbfhIRnNhH8w58aEA23a/EFQDCCzT4amqbme0RIA27oT
	CBxkegC8Xh6bYmjY9/0Twxkr9Df+o5M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-TKHCiYN4Ms2LV3bRiZtoRQ-1; Wed,
 02 Apr 2025 12:26:32 -0400
X-MC-Unique: TKHCiYN4Ms2LV3bRiZtoRQ-1
X-Mimecast-MFC-AGG-ID: TKHCiYN4Ms2LV3bRiZtoRQ_1743611189
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9249F180025E;
	Wed,  2 Apr 2025 16:26:29 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B554195609D;
	Wed,  2 Apr 2025 16:26:25 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Wed, 02 Apr 2025 11:23:51 -0400
Subject: [PATCH 13/30] panel/jadard-jd9365da-h3: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-b4-drm_panel_mass_convert_part2-v1-13-903b70999ea6@redhat.com>
References: <20250402-b4-drm_panel_mass_convert_part2-v1-0-903b70999ea6@redhat.com>
In-Reply-To: <20250402-b4-drm_panel_mass_convert_part2-v1-0-903b70999ea6@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743607440; l=1465;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=IMFre+7l7tWbk4mIS8m6SZxjRxqcMTkoQU9WfWpKabg=;
 b=2FSpbmOvXfcINUMAYycqUf/pnm8cHIiO41KUyMkAKzkiNVBDC7eE3BtcejqyuqNaHJGws2peh
 A0DB6ZXoHZrAJkz/xFkRm12K3t0F54y/qXm1ZQLx1b8VOd0Wf5qVKet
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 7d68a8acfe2ea45a913dff25eb5e9f0663503f08..6b02923de3f0778f45a6f9ce20d70d667772c64c 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -1120,9 +1120,10 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 	struct jadard *jadard;
 	int ret;
 
-	jadard = devm_kzalloc(&dsi->dev, sizeof(*jadard), GFP_KERNEL);
-	if (!jadard)
-		return -ENOMEM;
+	jadard = devm_drm_panel_alloc(dev, struct jadard, panel, &jadard_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(jadard))
+		return PTR_ERR(jadard);
 
 	desc = of_device_get_match_data(dev);
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
@@ -1148,9 +1149,6 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 		return PTR_ERR(jadard->vccio);
 	}
 
-	drm_panel_init(&jadard->panel, dev, &jadard_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	ret = of_drm_get_panel_orientation(dev->of_node, &jadard->orientation);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to get orientation\n");

-- 
2.48.1


