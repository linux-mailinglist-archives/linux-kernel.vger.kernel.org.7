Return-Path: <linux-kernel+bounces-722350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F9FAFD87F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98AA7A5DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05423243958;
	Tue,  8 Jul 2025 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlgeuUZh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B924166D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006996; cv=none; b=X+hu0uNnLmPQVU13fZDtj3Lt3eEvOp92sca+hrIWWIgVDmXnK8GUL6jrOGxZyY/8/7CSeDEcc8P2QReJyQjc2nCcDIvbwbmrbdQe2cUnO5J4Q6Qz/eyVc3Ov/F6SnsMhDrtkVn/DwAozWl0UxSbZ2ugbvlVE2wS1fCsVyKkQ0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006996; c=relaxed/simple;
	bh=iPWaa2ssBgdgZ5jitMgJGsC/88hb1PdE1sWk1oi+wu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLjJ4aEwpmy0WL/TWzV7smpMmRvUZBy5MSvgO6hFwG+Lkp8vSoU3q+UrdHQiZqsvMv0rnYuTK0lMt9J58ycKNWWI1yiJ2GeDEa3cWJYB1T7bFErR9uZxIlhmlKTNFQTBv62yNqrXFKDssy4wjEw+qR4gsXHo+zjcnTzYVlcuTGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlgeuUZh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752006993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZoffccY80vAolUnWk/XhowDV1tFbX8aSEkoHnTw1fs=;
	b=QlgeuUZhMeydpg8nPmgB5byk+clHWqdBxJzS3cXJUMM8I0eXXglyA+nuK+QO1k0DPFfqyE
	AfKb434pDoL7+zWf0wzIthErve+aLrPC1JmrB1/G3A8UNi0xxnzN/vWBL4bmfc1MNa9OWm
	xKPUQj5HPakxPLqRLl+afRc1yjhcI+Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-mjZWMWH_NGOotLIYVuxGWQ-1; Tue,
 08 Jul 2025 16:36:28 -0400
X-MC-Unique: mjZWMWH_NGOotLIYVuxGWQ-1
X-Mimecast-MFC-AGG-ID: mjZWMWH_NGOotLIYVuxGWQ_1752006987
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD32C18002E4;
	Tue,  8 Jul 2025 20:36:26 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.132])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5AB301956087;
	Tue,  8 Jul 2025 20:36:24 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 08 Jul 2025 15:35:14 -0500
Subject: [PATCH 2/6] drm/panel/truly-nt35597: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-simple-panel-api-convert-july-v1-2-630902123ea1@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752006919; l=1407;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=iPWaa2ssBgdgZ5jitMgJGsC/88hb1PdE1sWk1oi+wu0=;
 b=yvSXKyBgpo/aNVC7VKL5dM4C3WOBFYRCDXq78Ro1g0rtPTvxSTVE442HfMc5GmvERdQJ+8Qc2
 TQXM/76wF/3Ax7k9anv9MZDQEQaTUF5fNlikj0D+38e9Zt/xBeZpTO2
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-truly-nt35597.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
index d447db912a61ec958a4718ce49454f5f706e41db..eb6c2608e4f1509c9626dcda790aee3f9b21eb8b 100644
--- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
+++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
@@ -476,8 +476,6 @@ static int truly_nt35597_panel_add(struct truly_nt35597 *ctx)
 	/* dual port */
 	gpiod_set_value(ctx->mode_gpio, 0);
 
-	drm_panel_init(&ctx->panel, dev, &truly_nt35597_drm_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	drm_panel_add(&ctx->panel);
 
 	return 0;
@@ -523,10 +521,12 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
 		.node = NULL,
 	};
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
+				   &truly_nt35597_drm_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
 
-	if (!ctx)
-		return -ENOMEM;
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	/*
 	 * This device represents itself as one with two input ports which are

-- 
2.48.1


