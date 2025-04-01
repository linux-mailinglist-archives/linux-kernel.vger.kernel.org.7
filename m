Return-Path: <linux-kernel+bounces-583895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16406A78114
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 19:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC4316B2AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 17:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17A5214A8B;
	Tue,  1 Apr 2025 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhcAqhQc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41C20E334
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743527142; cv=none; b=HutCqs2wJxonGQhcvb3AUDqzRPLvyJhz0WHd+iq3aXjFOO9ojrsmdyV1gRehrXPCDPrfNBKS/wcCq1zDzYJUD3wviXdz9ce5+xE0et15ql3r49IhyAFERD7oK6Y1X2isVxles9mfRZjPzPGnqSK/Pjlzps6V7/OSOZBjpboosPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743527142; c=relaxed/simple;
	bh=3A6rEhPpNi9ipO+apTpL1dxwKTytpp7SPV9JlxiG0gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kByN26NObQJQrPhiRSjJVaCXM9pYAOQdsiR8hU6aC+bjdn0lY+YutNaEEYVtMLM3EFYa+yTneM54sKNL2nO5D6tit0e2QAUo7xoxzrbt1Tw6HgG2APF1lWwRZer+RdCAjNLagxBFlaX0Hbkk/OY8G/KMqXcU9oyN06PCjmYHt6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhcAqhQc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743527139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbOko1i5Djwa/7oAwM/HgeHYZ+TPRLMxpGP21lRFZHU=;
	b=DhcAqhQcbrSh5mQS+8383UqZaiFhkVLhgBcLWxn+UTL8DWKrClUlhq3nJLWy3GKft8/jmJ
	GNW0wbClxBi8MQzTrGMICoKb8y5fScilLRuj0joSWf5rRpPQrogK7PgOti//xy+bx5ODKE
	Rol7AJbdTtUaEs+kQIX+2E+zwCWU9IM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-OEljgcvPPtK0FnKmVmCkSA-1; Tue,
 01 Apr 2025 13:05:35 -0400
X-MC-Unique: OEljgcvPPtK0FnKmVmCkSA-1
X-Mimecast-MFC-AGG-ID: OEljgcvPPtK0FnKmVmCkSA_1743527134
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEF6918004A9;
	Tue,  1 Apr 2025 17:05:33 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E83C8180B487;
	Tue,  1 Apr 2025 17:05:30 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 01 Apr 2025 12:03:49 -0400
Subject: [PATCH 06/10] panel/th101mb31ig002-28a: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-b4-drm-panel-mass-driver-convert-v1-6-cdd7615e1f93@redhat.com>
References: <20250401-b4-drm-panel-mass-driver-convert-v1-0-cdd7615e1f93@redhat.com>
In-Reply-To: <20250401-b4-drm-panel-mass-driver-convert-v1-0-cdd7615e1f93@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linus.walleij@linaro.org>, Joel Selvaraj <jo@jsfamily.in>, 
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743523429; l=1448;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=3A6rEhPpNi9ipO+apTpL1dxwKTytpp7SPV9JlxiG0gg=;
 b=eiJFXCSxlZCKggM1JaZdRbz5Vp2c337BAIll29x2NLJNkyoYh0Ds/Nbbd6+0wZGfe6pXI46Lg
 fBWghLmznRNAKO2HcNINwoyv34QmQz6WlvOPMwc0i0Ky1KJME9EnRQ/
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index 0b87f1e6ecaea71f10a249bdc53466d281f07a34..7ae196424b6dfb731cd1ea48363c4fa1e6c36464 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -349,9 +349,11 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 	const struct panel_desc *desc;
 	int ret;
 
-	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	panel = devm_drm_panel_alloc(dev, struct panel_desc, panel,
+				     &boe_th101mb31ig002_funcs,
+				     DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(panel))
+		return PTR_ERR(panel);
 
 	mipi_dsi_set_drvdata(dsi, ctx);
 	ctx->dsi = dsi;
@@ -383,9 +385,6 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, ret,
 				     "Failed to get orientation\n");
 
-	drm_panel_init(&ctx->panel, &dsi->dev, &boe_th101mb31ig002_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return ret;

-- 
2.48.1


