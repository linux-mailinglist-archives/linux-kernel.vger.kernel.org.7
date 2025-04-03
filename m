Return-Path: <linux-kernel+bounces-587002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C92DA7A655
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 17:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC2E3B7CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C4725179A;
	Thu,  3 Apr 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2+elsda"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD57250C16
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693564; cv=none; b=h6lvusgVDwuXy1l9J6W5SnO53s7ggi28f+5ATtrogrlblkQtnDz2bWZMwKiv8pGHDdk+qNU/LX3qB5ohfIO3IsBRsyNg5B4jgG5z6+KoigDNMlndcXqSuTAaIyW+HM151eRDlWrbTagDWCv3UEpov2M53jL8c/De4E6V02tWrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693564; c=relaxed/simple;
	bh=EI+tsgjmay2fitW+KazTBhcVCZR8HgeELnVAaQAP2bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=adP/LeCkxyzlAQcWHA/CuAUEkOdcvhAYiXsPeZb675Vxni9hZNF5HUuTJ0EyXG8pjwXlE8RjXcZzv5R9mXx3FJnuLEK7TCMavxKT9epJxm8iaAVEunAZYWugyLm5xZe6xcEqYrzZxwG9iQDZZFfr8lpF/GMURTl9TxSZzb31QXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2+elsda; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743693561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vt9nmE2W6fAP5x7WHE2AxHpH1utj7r9hW1CF65sgUZU=;
	b=I2+elsdaHSiwBSR299138UTI0hXRhsFO6RoMDXaUJ2IvfviDiajJDSE7UgKz34RJvWILFP
	cm+GOtrKT7ob0256WRcAhjdjHrhfJvjaDNPxS+uhVOBl0VRMFqLxugUQP+nA4anTDnLPR6
	FFsD4mYXsWkEIyHpxKvgov4mDWogegE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-Qz1623huNSqpc82YGhX4qQ-1; Thu,
 03 Apr 2025 11:19:15 -0400
X-MC-Unique: Qz1623huNSqpc82YGhX4qQ-1
X-Mimecast-MFC-AGG-ID: Qz1623huNSqpc82YGhX4qQ_1743693552
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 300E3195609E;
	Thu,  3 Apr 2025 15:19:12 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0662D1801752;
	Thu,  3 Apr 2025 15:19:07 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 03 Apr 2025 10:16:26 -0400
Subject: [PATCH v2 19/30] panel/magnachip-d53e6ea8966: Use refcounted
 allocation in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-drm_panel_mass_convert_part2-v2-19-260c8a44c56b@redhat.com>
References: <20250403-b4-drm_panel_mass_convert_part2-v2-0-260c8a44c56b@redhat.com>
In-Reply-To: <20250403-b4-drm_panel_mass_convert_part2-v2-0-260c8a44c56b@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743689775; l=1437;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=EI+tsgjmay2fitW+KazTBhcVCZR8HgeELnVAaQAP2bo=;
 b=bL90yP/YOvSR6+LHZNo/7S2R0LSzWO+uOeoC7kC5cVeM+0Squ0rxBZFwKyisFOMN0+AEi+hNX
 cinCU/DMwxUAykRtbJ42nQdnAdP8ep+Ew3MT2bjKRZJgQLgke1HxF/E
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
v2: none.
---
 drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c b/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c
index 799c2161fc85b24e1fb236fd63b397bf66fc15c8..ee225286ce6df0ce48cf7a2c60d600332d02ed86 100644
--- a/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c
+++ b/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c
@@ -370,9 +370,11 @@ static int d53e6ea8966_probe(struct spi_device *spi)
 		.node = NULL,
 	};
 
-	db = devm_kzalloc(dev, sizeof(*db), GFP_KERNEL);
-	if (!db)
-		return -ENOMEM;
+	db = devm_drm_panel_alloc(dev, struct ili9881c, panel,
+				  &d53e6ea8966_panel_funcs,
+				  DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(db))
+		return PTR_ERR(db);
 
 	spi_set_drvdata(spi, db);
 
@@ -425,9 +427,6 @@ static int d53e6ea8966_probe(struct spi_device *spi)
 	db->dsi_dev->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET;
 
-	drm_panel_init(&db->panel, dev, &d53e6ea8966_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	if (db->panel_info->backlight_register) {
 		ret = db->panel_info->backlight_register(db);
 		if (ret < 0)

-- 
2.48.1


