Return-Path: <linux-kernel+bounces-726873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB40B0124A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8262172C70
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108D01B414E;
	Fri, 11 Jul 2025 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PN6PSc1e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD291B3937
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208381; cv=none; b=tPz2fwjVq+EpumGcTFV2YfUUQymDv+hkrH2ZsMdMBpNjOox5+EZhiJIHPkVppr6DsKojcIq9mcyVVDMsVkQptkfbnF4NQrqBO+wtRDmcGcfAGtI6F68bcJgyi6qmjl3a1JWHcqoPQrQqrXsfgrnTZd+SMzdP60VVUuXFdQFuVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208381; c=relaxed/simple;
	bh=x9jjKpQmSTs4YmDmtzZOKXceb+X207TGO3xWPLWt/E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYyYqjEoNNWAhZZcGpuvqaBMCgQLs9Bd9XcANKQtUHRxyqPju+KScRTpgUGpRfwNHYc31EUW9cJcbNXdZfxGFugr3wQlaMDYL4oOVlBthqchE/EGijFjvd8EoDbFjvr5I3caJTnAG6shIhzkHDk0NtBzfee2rgXpJNIkLXdxdGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PN6PSc1e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvROWprvZVObxVu7yfL80nRieDhkDbGSMls4JOe4MeA=;
	b=PN6PSc1evjS/Ud8lmnGjDvVD7PsnaTW6kGo9dgSsj+/Lh8rWMIIM/XjNrNyZipiJIflPwM
	fF1v2fNnG+fIQugINrxowqeZqyYUsCMSsTGzSKjiKfQnkw9hsL7OOOW21cYdOBERloLJau
	WBgfYO2/l5nFge9bLOLQeMR1sRYDtn4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-tz-HPw1oNZu7DDbA8AWMvA-1; Fri,
 11 Jul 2025 00:32:52 -0400
X-MC-Unique: tz-HPw1oNZu7DDbA8AWMvA-1
X-Mimecast-MFC-AGG-ID: tz-HPw1oNZu7DDbA8AWMvA_1752208370
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 336E619560A2;
	Fri, 11 Jul 2025 04:32:50 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B8C3180045B;
	Fri, 11 Jul 2025 04:32:46 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 10 Jul 2025 23:31:18 -0500
Subject: [PATCH 07/14] drm/panel/kd097d04: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-b4-driver-convert-last-part-july-v1-7-de73ba81b2f5@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752208280; l=1638;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=x9jjKpQmSTs4YmDmtzZOKXceb+X207TGO3xWPLWt/E4=;
 b=nCwchFKw19gEAI9laVB4vJcXAZ1fnbeo5uSxXlTF0jFmOCMdEsCjb98o6tf8Y6hXM7tsQgYfD
 bZxHP/EnZ7jDHxOU/PX9v8LIiPHtCBEVIqIr7W7p/OsaWx8WC5hgmW6
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index d6b912277196ee68a7ca57bfefb327dee11596fa..2fc7b0779b37b28c7ed2fba6b28459c8a9d27e70 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -337,9 +337,6 @@ static int kingdisplay_panel_add(struct kingdisplay_panel *kingdisplay)
 		kingdisplay->enable_gpio = NULL;
 	}
 
-	drm_panel_init(&kingdisplay->base, &kingdisplay->link->dev,
-		       &kingdisplay_panel_funcs, DRM_MODE_CONNECTOR_DSI);
-
 	err = drm_panel_of_backlight(&kingdisplay->base);
 	if (err)
 		return err;
@@ -364,9 +361,12 @@ static int kingdisplay_panel_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_MODE_LPM;
 
-	kingdisplay = devm_kzalloc(&dsi->dev, sizeof(*kingdisplay), GFP_KERNEL);
-	if (!kingdisplay)
-		return -ENOMEM;
+	kingdisplay = devm_drm_panel_alloc(&dsi->dev, __typeof(*kingdisplay), base,
+					   &kingdisplay_panel_funcs,
+					   DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(kingdisplay))
+		return PTR_ERR(kingdisplay);
 
 	mipi_dsi_set_drvdata(dsi, kingdisplay);
 	kingdisplay->link = dsi;

-- 
2.48.1


