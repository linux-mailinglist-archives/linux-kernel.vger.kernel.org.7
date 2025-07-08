Return-Path: <linux-kernel+bounces-722354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE586AFD883
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA7C5687E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149C92417C2;
	Tue,  8 Jul 2025 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7N4hLtq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90D24676F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007004; cv=none; b=IBTWXvhMOudeU21EtasLsH1zCZXPNDorvOmbyncaZHEdXlwns0P3Zso+3xuDUfOGfg6E7VJkjCgsQrK0944bdP5dEPoCl9dp3tYfEwZl9Kd7EZ9xJUqdB83CCoBifBOx0NVd8mCLBbLd4aTpPAXetqJyVjhTm/WhQFUjcyLSZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007004; c=relaxed/simple;
	bh=vsvHIMQx+bz1MugawrqwN+PrKys/gpceYZf2lTHUZo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhRAce2burhqlUanHg3fzVLSIj3ScCDtjhDxbYuAvu9XnodaXfpiG3hV6UAQ4iiQaHlS9Q0i+v9+HK0eqD4dr7KgBaeoz4NcMH70T1buizWlNMCOWNVm2LUWFC5WJsT28kD5tr3dDapYr1dgMfKt8yldm8P6VaHzpM2CPcPib+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7N4hLtq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752007002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkthyQecCVK2yqwg1DPkHhbTWatnZwsBkt13NL9bfxM=;
	b=W7N4hLtq80IzvnCPhfXm4V38NH3g2Bx+/exni3pmwH9anoxOwJp5iW5UAh7c9FEE0H1UhH
	17K54drv/9BNzispl/pEi/9a6A4A3I7RHqpToQlrsz971XUkT8p4lSXIXXzOVtLc9HhH1+
	40Avm9xGPgv0OrLyLY/SoBuEie74u9c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-eXTUk8hJM96iffEYT7fGYg-1; Tue,
 08 Jul 2025 16:36:40 -0400
X-MC-Unique: eXTUk8hJM96iffEYT7fGYg-1
X-Mimecast-MFC-AGG-ID: eXTUk8hJM96iffEYT7fGYg_1752006998
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8867193F061;
	Tue,  8 Jul 2025 20:36:38 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.132])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A28B51956087;
	Tue,  8 Jul 2025 20:36:36 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 08 Jul 2025 15:35:18 -0500
Subject: [PATCH 6/6] drm/panel/samsung-s6e63m0: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-simple-panel-api-convert-july-v1-6-630902123ea1@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752006919; l=1510;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=vsvHIMQx+bz1MugawrqwN+PrKys/gpceYZf2lTHUZo8=;
 b=/p/iezB5BBWwJRFLoAflR91gj1xcjB9ZRrKdmqtJ7EnES2GYibe0PfCMTmbLkVHOELUPZp7u6
 xjlljvh7aXiDpTeJ1qp+rBOTiN5VHwC0+BENbpvgiTtc/KdkQp6gnqS
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
index ea241c89593b6726e8356c30229e99191c69bf03..562ad06c251f8992b3f28894ce2309913324ef11 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
@@ -677,9 +677,13 @@ int s6e63m0_probe(struct device *dev, void *trsp,
 	u32 max_brightness;
 	int ret;
 
-	ctx = devm_kzalloc(dev, sizeof(struct s6e63m0), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
+				   &s6e63m0_drm_funcs,
+				   dsi_mode ? DRM_MODE_CONNECTOR_DSI :
+				   DRM_MODE_CONNECTOR_DPI);
+
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	ctx->transport_data = trsp;
 	ctx->dsi_mode = dsi_mode;
@@ -712,10 +716,6 @@ int s6e63m0_probe(struct device *dev, void *trsp,
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
-	drm_panel_init(&ctx->panel, dev, &s6e63m0_drm_funcs,
-		       dsi_mode ? DRM_MODE_CONNECTOR_DSI :
-		       DRM_MODE_CONNECTOR_DPI);
-
 	ret = s6e63m0_backlight_register(ctx, max_brightness);
 	if (ret < 0)
 		return ret;

-- 
2.48.1


