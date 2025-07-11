Return-Path: <linux-kernel+bounces-726875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4530FB0124B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095815A1DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F821DC9BB;
	Fri, 11 Jul 2025 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJwcVNLX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037491B413D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208383; cv=none; b=BkdTQYyDjnCE+dduFRhLUjPzhBpjDfpOmtRQ59B7KkMv211oXN2LnQPKevWFnrY9FS6t2zNRM8+/fLuR5sybf+G5NpzTfBQsef+dGAOIoyNi3vkAAfrz4F4j7jU3IUW79+kGpB+Iitm6tPGuMPPIIE4zR7gIKV7kDx+brwZdQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208383; c=relaxed/simple;
	bh=ATz8x7koYgHgmVT1nHAx9zlNjogIDPekD0KoOrO4J1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8k3j0P569T8DbZfGFkPROx3+p1iLrF6rHwUKXW1xT7SRmRkowrzWsua/heH6L8Jqj5t+uguu0k2/FYLFQNHEfOEBxZdeVlfAJx5JbSqipP5vMz6mlQGHshjdk4lG3US6BaDGYKkNTHN1jrqN951vmy0ZviMFu+80DY4Sm3ja2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJwcVNLX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfn9L63NyGnHcCssK+9XeEnkkOjmDRSCTK1Dph1u3rQ=;
	b=iJwcVNLXIp4l6zRg2frLBBJIDnG+eQAr/r6UpMyMu/EKTKC+4MEGQpJdt+HCHzcWdNJipv
	ekdcnhtkj4KvVGVHA1E3PLAjmAJQIMYn61W8O1W2IiyS5c99ajxQ3FGF44JbnnjpMybGD7
	go2UAqwn9rWRpZp/SIMP5IYfhxlpZEQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-DHN0yI4lMT2wculgXQo02g-1; Fri,
 11 Jul 2025 00:32:59 -0400
X-MC-Unique: DHN0yI4lMT2wculgXQo02g-1
X-Mimecast-MFC-AGG-ID: DHN0yI4lMT2wculgXQo02g_1752208377
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32A9118002ED;
	Fri, 11 Jul 2025 04:32:57 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F841180045B;
	Fri, 11 Jul 2025 04:32:53 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 10 Jul 2025 23:31:20 -0500
Subject: [PATCH 09/14] drm/panel/jdi-lt070me05000: Use refcounted
 allocation in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-b4-driver-convert-last-part-july-v1-9-de73ba81b2f5@redhat.com>
References: <20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com>
In-Reply-To: <20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752208280; l=1496;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=ATz8x7koYgHgmVT1nHAx9zlNjogIDPekD0KoOrO4J1M=;
 b=InQRUyJBwdB1lNXv874qbjdyrZ9XkP3sY/uix3iwPoBIiQms7YjhEoOYkZxO8Mp6NtgvOWwc7
 g9DXi63tWKkAmBDAben3ngAA4tvqelfC41XYWET6IvpiM4sumVnnQbu
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index b1ce186de2616be03fa9f94d0e0724141e9dcbac..3513e5c4dd8c6ee3c9c8836e8d150d838d8666cd 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -402,9 +402,6 @@ static int jdi_panel_add(struct jdi_panel *jdi)
 		return dev_err_probe(dev, PTR_ERR(jdi->backlight),
 				     "failed to register backlight %d\n", ret);
 
-	drm_panel_init(&jdi->base, &jdi->dsi->dev, &jdi_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	drm_panel_add(&jdi->base);
 
 	return 0;
@@ -426,9 +423,11 @@ static int jdi_panel_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags =  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
 			   MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
-	jdi = devm_kzalloc(&dsi->dev, sizeof(*jdi), GFP_KERNEL);
-	if (!jdi)
-		return -ENOMEM;
+	jdi = devm_drm_panel_alloc(&dsi->dev, __typeof(*jdi), base,
+				   &jdi_panel_funcs, DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(jdi))
+		return PTR_ERR(jdi);
 
 	mipi_dsi_set_drvdata(dsi, jdi);
 

-- 
2.48.1


