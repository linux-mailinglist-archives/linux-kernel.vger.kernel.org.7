Return-Path: <linux-kernel+bounces-587869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91401A7B14C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B5C3BB85A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC481EEA4E;
	Thu,  3 Apr 2025 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOC8MsVo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DF1EE02E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715501; cv=none; b=SEzVk1tKVDkn+u71GT4cS8fajaIekVHn1BAD+U22hqWtVOinb80lWPXCFryV6dLkgUFBk2Bx0nZYP7YEennfQyrNGvni3cDMovINUFG8EktBW7y0f0TL71TZaaMl2UCyG3EP8/A7tIozxRSPfvOm3rAOoh0A0+JeutLFWY7ZLok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715501; c=relaxed/simple;
	bh=hzl5+XpbY3L9Z9QFXh4WpkT75vD3DjBUCqCNF0Fl/90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4NSGSWLXl1CSJ+ijrY/ZnMispTEDZIDscvI5uct/T1Av/Zc+MyXwEA74lRo0N+sMUuWdW6IujMTy3aDv1Jy8rF2OASJmsSK7jtAT5VumnpFwNV2wHv66DeTryltHHH9yKrXxmqTSNskNrKSuc7h4Lwsue/IchPQJtkEKKmCfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOC8MsVo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743715498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pN/MvrFKLXvLJmqk8Hb1dyU5eTOHXw2yIV/UnSntsyQ=;
	b=EOC8MsVoaCAjXwhC7CgPS7pTlvJSf0f3D2DGenxW5vk8PN8LTgmPfi2L2FxXydgmkVU6eL
	SKTqTXaX73U58ZO5LdhzkzmFIuR9FjVOaJP5j4xMzjOioecM7DAq1qoVHoXaPZfI6acwvL
	amDmyQQzZvVIl8LcBHlxkUnPIPtwe6A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-giHKKm6sPH-NnQv8CALo7A-1; Thu,
 03 Apr 2025 17:24:53 -0400
X-MC-Unique: giHKKm6sPH-NnQv8CALo7A-1
X-Mimecast-MFC-AGG-ID: giHKKm6sPH-NnQv8CALo7A_1743715490
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DFCD180025E;
	Thu,  3 Apr 2025 21:24:50 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 518B1180B488;
	Thu,  3 Apr 2025 21:24:46 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 03 Apr 2025 16:21:03 -0400
Subject: [PATCH 32/46] panel/panel-summit: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-drm_panel_mass_driver_convert_part3-v1-32-965b15ad5b8e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743711639; l=1301;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=hzl5+XpbY3L9Z9QFXh4WpkT75vD3DjBUCqCNF0Fl/90=;
 b=9YxMCXfIcJNt6wji0IlbF61kePJLqGLiVfSvHEwHFy15AM10jelze8/D1m8EehZVvkWIycKIV
 D4YoYWTpRm0BQPosPMtkcPjRSPepwUKKWAv224i0jbsb/scQp2GpBQ/
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-summit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-summit.c b/drivers/gpu/drm/panel/panel-summit.c
index e780faee18570c9970d381b3f7c65b95665469cd..90bb0e159b4ddf930e0415c638f02b0be755453c 100644
--- a/drivers/gpu/drm/panel/panel-summit.c
+++ b/drivers/gpu/drm/panel/panel-summit.c
@@ -68,9 +68,11 @@ static int summit_probe(struct mipi_dsi_device *dsi)
 	struct summit_data *s_data;
 	int ret;
 
-	s_data = devm_kzalloc(dev, sizeof(*s_data), GFP_KERNEL);
-	if (!s_data)
-		return -ENOMEM;
+	s_data = devm_drm_panel_alloc(&dsi->dev, struct summit_data, panel,
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


