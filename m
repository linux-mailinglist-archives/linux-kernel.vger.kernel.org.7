Return-Path: <linux-kernel+bounces-586996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BBDA7A64D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 17:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D0E174FE9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E1F2512EF;
	Thu,  3 Apr 2025 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUSTBffT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B7250BE7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693537; cv=none; b=oKlLP28iGZd+5xoFqFRqf+Un8WIGyPXwpm6TQxLvC3Lodf9mz6zJKf+wSifs4gPJBd5s4QoTVkTLe75wYBprL5XtJcRzq2MI5nQ9cA2AAfWkxK51agCviY3njHHE7jeVjhZC4idJJbiooJA+uIc10fpLpEnFAC5uxR4i2DcMaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693537; c=relaxed/simple;
	bh=2Ppp42n1JAcHF1UuWWQB89Nz0jJj4qROsA4cT0xPbA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMqtSbH/FvSVJPxyumxw7hfU0QEWyist8YC47/Q7avacdITcWql+6YWi+FohDdlRAj4KPwPFbdqWV9rG/bQo8eK0otSFSvvJeFS8cQlzZtYGg/Iw8Fe6q9GbUJfqe1880ta3IuEF6ZrwBe+1fk7Rpk+7dzL08DL19UGlzr5UG5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUSTBffT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743693534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBubk4denLeJ0/UMdEngZePdOeytf3QhxNkPBd813NY=;
	b=SUSTBffTf5jFWQlWDd5m0GFWWqyQldZinjogIgDow4+0JEEKFMQXszFmanHCpmQ3+UfZER
	C48RQ7rYH8tAOg33HjC9OBpg5NQ7NymgcrGWlszhL2Ky1pbuIkMlyUld/sRhO50jqJyl/p
	x4fqrq3etPG3Di64+JQ2OuCEpEAeBZY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-ZKfs-eKRMmOIbcfH-S55tw-1; Thu,
 03 Apr 2025 11:18:48 -0400
X-MC-Unique: ZKfs-eKRMmOIbcfH-S55tw-1
X-Mimecast-MFC-AGG-ID: ZKfs-eKRMmOIbcfH-S55tw_1743693526
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FAE519560B7;
	Thu,  3 Apr 2025 15:18:45 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6C561801752;
	Thu,  3 Apr 2025 15:18:41 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 03 Apr 2025 10:16:20 -0400
Subject: [PATCH v2 13/30] panel/jadard-jd9365da-h3: Use refcounted
 allocation in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-drm_panel_mass_convert_part2-v2-13-260c8a44c56b@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743689775; l=1481;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=2Ppp42n1JAcHF1UuWWQB89Nz0jJj4qROsA4cT0xPbA8=;
 b=+rWI9zmSximoK5m5QPC56glPl5Te2D01thzqEQvb4MKd28+R8hFrOMlfFhbwqvdB1WiVsnFCd
 IvC/IhONe7JCdpSV++mg0521D4866ptyDFJry8v+9FcBkU9qgVHzHiR
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
v2: none.
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


