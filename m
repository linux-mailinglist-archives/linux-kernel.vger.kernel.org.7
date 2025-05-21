Return-Path: <linux-kernel+bounces-656781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE53ABEACC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 06:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4587D1BA4A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 04:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F50B23184E;
	Wed, 21 May 2025 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHAaJf1S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B63231824
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 04:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800688; cv=none; b=o0RmB1D/Nt6EytVylEM5b52QmIvCkn2iQRpYdXcAeJY417mLsP7RX6hLUVbFT2cn5exjFRdlyDTkex9rkyTeU790HAhiB5pP8qtZNcv+0CNGfgvtdCZiyaDJX/rqt9AnzahjtvDQqyPyA10XiAjIyWayuz6aBA3xWejeUX709hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800688; c=relaxed/simple;
	bh=7z/14Z93au3tZmh/25cm3I5uZGx9IqpzQvvkTCyqZeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qpA0P0y1pqRxQZ4PGvNWi8dfKKB3XRolEwSH1bbuw0a8agGdMUuXcw4HapJLFivONDgtEjG4O3gZug/FZ55ytx/nbgqHY99oK2uEwMEFiro2iIFuAtrfufDrEkdRQ3zyab3hyYmuNYHHBKm0huht43TWjdNq0db6JLe70GLbBYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHAaJf1S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747800685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2sYOIMJ9v8YXY0x8O4WlQj8yER15JxDTAFZyqAkmCk=;
	b=DHAaJf1SsqHq3c0+9xXLeXlk+eUFHNigr0qrt1ZHSSgsfADcszCd6b6J6STcGMrLB64qnj
	KHBPfH/OLjwXCnSUxDl1JA3aJUMdXHt1rdcfLnaOE2EO+uqpfDImKcd+eolVGB4pmJ6kjE
	lwxgCdG2FEtkP9DorOflI67O5xQQDiM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-8TJbWdmgMZm-vHIdMprLqA-1; Wed,
 21 May 2025 00:11:20 -0400
X-MC-Unique: 8TJbWdmgMZm-vHIdMprLqA-1
X-Mimecast-MFC-AGG-ID: 8TJbWdmgMZm-vHIdMprLqA_1747800678
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72323195608C;
	Wed, 21 May 2025 04:11:18 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.184])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 151741956095;
	Wed, 21 May 2025 04:11:12 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 20 May 2025 22:03:54 -0500
Subject: [PATCH v3 23/30] panel/novatek-nt35510: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-drivers-mass-convert-part2-v3-23-f7ae7b723c68@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747796667; l=1452;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=7z/14Z93au3tZmh/25cm3I5uZGx9IqpzQvvkTCyqZeM=;
 b=Fncw0Sx4+Rc7bRNSm83jdAQsdE4818Xhpf3XSX0ubGAD7cLNhPlTAJ0+bYxMf8yAd6zrYnjSp
 pv0ilH5ZCq9DF3clg0b+xpzUjnQUHiSr5ryKHgLjFcDeE0LJXK+uBef
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
v3: none.
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


