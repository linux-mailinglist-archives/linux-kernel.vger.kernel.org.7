Return-Path: <linux-kernel+bounces-667526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B45AC8668
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 04:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200189E7364
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8919309E;
	Fri, 30 May 2025 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCYBdFJS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60171465B4
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573420; cv=none; b=tmxyXLuXXCHGs9gjSfHmH/G3ZpTjm/zw0rGfeVubQUXx3hgiLJd7yO96LAQAemIbUo79xIFkIiEPjTgCIY+e2PCvUhe5jWwzh4DFgBfZ8EHys6lO7uC4LsLXxPtxMMkqKHwO8rw08P2GscBpopY6EroLQ4yb1UPkgPJiYGHhYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573420; c=relaxed/simple;
	bh=P4Tbzc5MWoBswSwR5HZLlejqr48XCRdQ5VD/mhwHP1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SBeJJ6koT4Vb2N83aAs/QN9Gci87ehDQ63stUgwOvY3MP+ImScF9QsOKT0ZbKgJaiR5aleHXgIMYdzXZbf8Xc+xBu5T9ws7NEPWdflAjon5DITDbVJtQ9T2TruZCvtY/tftc+6hSqZtnfj5ByWk9mmjSId1W0NZKvg98xyVQKi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCYBdFJS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748573418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G64KxmR9zY/S/gcR8CpuLFrSEZ28ZqqaC0VGyL1euDw=;
	b=GCYBdFJSAPBr/BAylmwdOPg37t5YJJpPeQQnYxI1IEXS6QUQx+oQxIlOoTSiHgMzEK7mDX
	Q0sYaSYjc25T9JLPgzR4VUo3oGs9w3Djh5jVmdnSU0oQdYZKtOh4yuhpXZatU1+1mXHH7+
	g63J+wp3+1rXgu5xrrBHbwHL6t6lDow=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-8TU9PDXhNYOLOXoJjfXFMg-1; Thu,
 29 May 2025 22:50:11 -0400
X-MC-Unique: 8TU9PDXhNYOLOXoJjfXFMg-1
X-Mimecast-MFC-AGG-ID: 8TU9PDXhNYOLOXoJjfXFMg_1748573408
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB3D819560AA;
	Fri, 30 May 2025 02:50:07 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.17.97])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE6B41955D88;
	Fri, 30 May 2025 02:50:02 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 29 May 2025 21:46:05 -0500
Subject: [PATCH v2 03/46] panel/raydium-rm67200: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-b4-drm_panel_mass_driver_convert_part3-v2-3-5d75a3711e40@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748573168; l=1454;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=P4Tbzc5MWoBswSwR5HZLlejqr48XCRdQ5VD/mhwHP1g=;
 b=ITry/VJUbQRl0xaw9BoFUHHVM3dFiAkL5F0Ui3WL8gtwZfq4+MJVFLTsIsNmd/J9zVSXypnWZ
 4R8djYeEOa+D0bIDY8+2cfW23lRNGOAKEeKYn4Hvh/+8HuDmUeuSHna
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
v2: none.
---
 drivers/gpu/drm/panel/panel-raydium-rm67200.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67200.c b/drivers/gpu/drm/panel/panel-raydium-rm67200.c
index 64b685dc11f65b0f402995e27a42df5d69ae4361..1da8225e6f7a5cff94a882874be909db1d28fe86 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67200.c
@@ -391,9 +391,11 @@ static int raydium_rm67200_probe(struct mipi_dsi_device *dsi)
 	struct raydium_rm67200 *ctx;
 	int ret = 0;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(dev, struct raydium_rm67200, panel,
+				   &raydium_rm67200_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	ctx->panel_info = device_get_match_data(dev);
 	if (!ctx->panel_info)
@@ -421,9 +423,6 @@ static int raydium_rm67200_probe(struct mipi_dsi_device *dsi)
 			  MIPI_DSI_MODE_LPM;
 	ctx->panel.prepare_prev_first = true;
 
-	drm_panel_init(&ctx->panel, dev, &raydium_rm67200_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return ret;

-- 
2.48.1


