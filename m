Return-Path: <linux-kernel+bounces-587006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9938EA7A65E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 17:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7EA3B8C8E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC7F253F04;
	Thu,  3 Apr 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9psE8gq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA8251799
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693576; cv=none; b=YHDHMJScTzt2iiywpFxn3LK4UEq8lEHoDVe0v0uAcghMjAwWgDF/7nAXNri/mVdORyZoxhm3PF6E9eMwseJu0ld9BEY9GKgvM0kP1nIpJZd86IRTIyHnoc1o72JMaTA7hc/W4SI6d+vhZs0YZfR2Vn1yBH4fVQpyPgFNbUk8MtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693576; c=relaxed/simple;
	bh=IGMA0Pw03P08QK9OT6Pxif1iJx2E0GZmvwD/L97m2Sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UT1BGGaHnMe2obQxtQrQVGg6HHCfcUgYnuIyryV5V25dj7UXeM5G5kAWfLZUvPWYoqU8IbwsHJ0ixctb/W58WNyQSveLIfrCtxDelBYF7CE7ZmBBNamqhU6NOm7g3JmhY6V50VRKJZHpju7H4DtNeygTJSSVYTVO+bUW2PZGefk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9psE8gq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743693573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dM2S/Y9aTCkFRtVZTaIWj9Pqd2VQDvShEv8JTuxc28M=;
	b=a9psE8gqcBtT/Pi/pfBOozTsrd1+N19Qe/V6PrwS0eWUBBHqb1mhv5V9075g7O/YfDEmD5
	zyJ7WgNEG2VNYhF7MrRDO4QiWKlIviec5f9SwYz2TD187F/geO3KtutNZQ+3LfbvlOWBnO
	TCoET06QJbJhqnAAyC/97NugaxJtDdo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-J2ZX0p5_PSKNM4gKMHZelw-1; Thu,
 03 Apr 2025 11:19:32 -0400
X-MC-Unique: J2ZX0p5_PSKNM4gKMHZelw-1
X-Mimecast-MFC-AGG-ID: J2ZX0p5_PSKNM4gKMHZelw_1743693569
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A7641800263;
	Thu,  3 Apr 2025 15:19:29 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 772C91809B65;
	Thu,  3 Apr 2025 15:19:25 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 03 Apr 2025 10:16:30 -0400
Subject: [PATCH v2 23/30] panel/novatek-nt35510: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-drm_panel_mass_convert_part2-v2-23-260c8a44c56b@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743689775; l=1384;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=IGMA0Pw03P08QK9OT6Pxif1iJx2E0GZmvwD/L97m2Sg=;
 b=A2Q1pWJDqM7TJeHcAqkDnnVizPvPBbpNGBbAo/zeXwQ0sLlKI3gPHXa/ohexkAqM2d9wU3YkS
 UYEPpPe4gHdDBuqEMJpgO5qBV97AKIaYH3DzsCJLbXkP0n+o66q107a
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
v2: none.
---
 drivers/gpu/drm/panel/panel-novatek-nt35510.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
index 549b86f2cc288741897992ce5cad6325f4289dba..3189d89c7ca00074314a6f4fec330a3e625c24f4 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -1087,9 +1087,12 @@ static int nt35510_probe(struct mipi_dsi_device *dsi)
 	struct nt35510 *nt;
 	int ret;
 
-	nt = devm_kzalloc(dev, sizeof(struct nt35510), GFP_KERNEL);
-	if (!nt)
-		return -ENOMEM;
+	nt = devm_drm_panel_alloc(dev, struct nt35510, panel,
+				  &nt35510_drm_funcs,
+				  DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(nt))
+		return PTR_ERR(nt);
+
 	mipi_dsi_set_drvdata(dsi, nt);
 	nt->dev = dev;
 
@@ -1142,9 +1145,6 @@ static int nt35510_probe(struct mipi_dsi_device *dsi)
 		return PTR_ERR(nt->reset_gpio);
 	}
 
-	drm_panel_init(&nt->panel, dev, &nt35510_drm_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	/*
 	 * First, try to locate an external backlight (such as on GPIO)
 	 * if this fails, assume we will want to use the internal backlight

-- 
2.48.1


