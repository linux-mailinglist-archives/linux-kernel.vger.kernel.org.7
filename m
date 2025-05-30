Return-Path: <linux-kernel+bounces-667557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351DAAC86B2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 04:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B5A4E2F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 02:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9023921D595;
	Fri, 30 May 2025 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKQ2kFK7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6391E8323
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573556; cv=none; b=hM39C1N164mAH9D3e6t9CqI/3kbdL/cdrXyEnObIh1Xqkjmkr/muI2/bqsAc4ug0LMAP3JFBHTxBYBL3HOTnED5JYN2GhL1HEdsP32+8t2iwfhW0UGa2biZxFSuPfkIuwPBwIW256Cj+ajx+5nPWPKcITENhrpdlb2DxklglaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573556; c=relaxed/simple;
	bh=HXGA7dzp4/Dj3Rx7qAhpbJ4GY9ei3E9AojQjOdLR7Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aX4jo9GUxSyvVqeM1t0P3RBK7AtLtnZ62zHdRlKK7H9hIWQDk+DYv6FvGONr42FPtEnuig1TLxoITimcF1qsXpSRDc6CkE8XvG3FNwdVEl1ov/CIkXZzcKqz4MLSsReEtPbO6/kJHIrgBHW//ILkM8BWxJoanuv+r2p+JdVzBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKQ2kFK7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748573553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqkGcoAKWo5VrLS+AhxF5qaDYWELv6xstEXyTL2DsKM=;
	b=bKQ2kFK7p1vtBMRt40SUWl0WW5k87fUF8XFFuSixFC9n/Wrz4APgxSSdNOab/zCnBIMvI4
	50g23k7j6lbmtzTbzsg+IBR78mAu3ztcMOXDDLFcDPuHLg8gTyEl/apJUsAJHc8iHUrEA1
	eLPlNF1WA+g461Pc0eW5t5H6q2+5z7Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-NEYQa8mCO3aAtH_TW0vxVg-1; Thu,
 29 May 2025 22:52:30 -0400
X-MC-Unique: NEYQa8mCO3aAtH_TW0vxVg-1
X-Mimecast-MFC-AGG-ID: NEYQa8mCO3aAtH_TW0vxVg_1748573547
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6829B1955DB3;
	Fri, 30 May 2025 02:52:27 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.17.97])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E9EB1955D82;
	Fri, 30 May 2025 02:52:22 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 29 May 2025 21:46:34 -0500
Subject: [PATCH v2 32/46] panel/panel-summit: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-b4-drm_panel_mass_driver_convert_part3-v2-32-5d75a3711e40@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748573168; l=1422;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=HXGA7dzp4/Dj3Rx7qAhpbJ4GY9ei3E9AojQjOdLR7Wc=;
 b=wRpsp4C2BExhwKFIVF8af6nTZha6EH/v3v4PmH3BpXZywfTPg+DFVVv9AyYDo88GHPIECLITT
 yUOriDdT2fFCSfjnKpJeAUg5QW+10pO2g1hReNTnAPVu5noQ/rlWAiU
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
v2: refactor.Use already dereferenced dev instead of &dsi->dev.
---
 drivers/gpu/drm/panel/panel-summit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-summit.c b/drivers/gpu/drm/panel/panel-summit.c
index e780faee18570c9970d381b3f7c65b95665469cd..4854437e2899126c74d8060433a9064cc3812de7 100644
--- a/drivers/gpu/drm/panel/panel-summit.c
+++ b/drivers/gpu/drm/panel/panel-summit.c
@@ -68,9 +68,11 @@ static int summit_probe(struct mipi_dsi_device *dsi)
 	struct summit_data *s_data;
 	int ret;
 
-	s_data = devm_kzalloc(dev, sizeof(*s_data), GFP_KERNEL);
-	if (!s_data)
-		return -ENOMEM;
+	s_data = devm_drm_panel_alloc(dev, struct summit_data, panel,
+				      &summit_panel_funcs,
+				      DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(s_data))
+		return PTR_ERR(s_data);
 
 	mipi_dsi_set_drvdata(dsi, s_data);
 	s_data->dsi = dsi;
@@ -85,8 +87,6 @@ static int summit_probe(struct mipi_dsi_device *dsi)
 	if (IS_ERR(s_data->bl))
 		return PTR_ERR(s_data->bl);
 
-	drm_panel_init(&s_data->panel, dev, &summit_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	drm_panel_add(&s_data->panel);
 
 	return mipi_dsi_attach(dsi);

-- 
2.48.1


