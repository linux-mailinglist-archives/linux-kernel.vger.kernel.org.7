Return-Path: <linux-kernel+bounces-587850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28BDA7B121
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF93C1887F13
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97B1F2C5B;
	Thu,  3 Apr 2025 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kghvv5bw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41CF1F150D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715406; cv=none; b=n0dhM/LIKV/UfEZbQRKBu5u63FvYjc7HFF7y1I4kUvplSU6+VKw7xFl4ab6Aauos6APiEioe9Y5kPDplOyJlhLy3yz5/pcF+0e8dwNt0wxHpIBB/Jlo+8bGm72/z3sbBpiynxSUbSn2YRzZpLNragH++5/cKeQOMs+hJUMwQRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715406; c=relaxed/simple;
	bh=/NlLsp2MB9dVm9Cp5dnLDlTkm+/oBFpaglJ5fVeWlCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gbNzDa5Iq65k+0U2YisQWPYo9hwXL6npJ0IyDr8oC2NCFLKFXcemPwSMmeXC5grrdrZaNftOEV/xvuk+JaMqA410cX4Ces0+jCzF19WeiuVUpnVdRsvWub+FlF0WSNunUZ/6LigbEg+3i+NQxtw2CnuV9jLHGThjEwY5EZovaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kghvv5bw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743715403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pnKkQQEKHsKY1YhCIro9rGIbxn4v7K+ED7a+gV0mqc=;
	b=Kghvv5bwKxUa0vgGg8oM59vpv1ZXyZgPFASmbcuDPXv7mvt/w/G82ho3lnWvGuyhAxlXsX
	ygUc31QHi9LCK4N7q8fodl3eNs15qbd03enALFs8P4caFN5Xev3cr5lpUsK0rKddskyd3A
	MPJ4o9vAj22eB8TirN9zBS9jt6KO8+M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-94r8fWniP2qfjHq2KWd-eg-1; Thu,
 03 Apr 2025 17:23:21 -0400
X-MC-Unique: 94r8fWniP2qfjHq2KWd-eg-1
X-Mimecast-MFC-AGG-ID: 94r8fWniP2qfjHq2KWd-eg_1743715398
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71E8F180AF4E;
	Thu,  3 Apr 2025 21:23:18 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B17BA180B488;
	Thu,  3 Apr 2025 21:23:13 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 03 Apr 2025 16:20:44 -0400
Subject: [PATCH 13/46] panel/samsung-s6d16d0: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-drm_panel_mass_driver_convert_part3-v1-13-965b15ad5b8e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743711639; l=1260;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=/NlLsp2MB9dVm9Cp5dnLDlTkm+/oBFpaglJ5fVeWlCM=;
 b=QnUKZtBR5vj1j448vHLU1lkYK7Y0p/D7auM9CRix8mQrxXHmfaDvl212l0bbEo2GBf4lFgFRB
 az0wc5ArAwyCr5gPTGIV3Vet9aep/eTHiQcLBasbhUb6/sprLbKNFyO
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
index 79f611963c6183218b42c7b6c3e2ab298e3fdb99..ba1a02000bb9def0b4afa8a43e13bc7c3c92a51d 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
@@ -166,9 +166,11 @@ static int s6d16d0_probe(struct mipi_dsi_device *dsi)
 	struct s6d16d0 *s6;
 	int ret;
 
-	s6 = devm_kzalloc(dev, sizeof(struct s6d16d0), GFP_KERNEL);
-	if (!s6)
-		return -ENOMEM;
+	s6 = devm_drm_panel_alloc(dev, struct s6d16d0, panel,
+				  &s6d16d0_drm_funcs,
+				  DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(s6))
+		return PTR_ERR(s6);
 
 	mipi_dsi_set_drvdata(dsi, s6);
 	s6->dev = dev;
@@ -200,9 +202,6 @@ static int s6d16d0_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
 
-	drm_panel_init(&s6->panel, dev, &s6d16d0_drm_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	drm_panel_add(&s6->panel);
 
 	ret = mipi_dsi_attach(dsi);

-- 
2.48.1


