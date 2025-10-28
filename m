Return-Path: <linux-kernel+bounces-873491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C618C140E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26EDA4FA943
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B593081B0;
	Tue, 28 Oct 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NJsb70WG"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BE307AF2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646615; cv=none; b=qysNyG11N6IIgd26Gq4aXM6bNWj/cA3rQ5DMhiE6BVxq+UiUxBglu4w6ww9KVMxPJtFEV2hJ6qq5U26mZIQIUA3y1CWA1ql8Xl1A4GkGQ9BVqWwaFkB8TBSqGSwB6ddtN9N6wWuk+3dgwiphuAQn7XqIfs5Ay5W5IO6Q8kngIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646615; c=relaxed/simple;
	bh=azBQ3OWrgMDeqzBKXjWG/3P66Ru0UGjGqS7Tm81ePBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YcoWReoHNKxzEXNdmMFd4fnM1b/0BQIpiAkMFB1lX8o2vfFuK5n4JpisQIQ5CjBioFG2HXmYeC6yfNSBqm2udhkfJmAHB0gIGyXkLKemmFAKuoucy0y2/DcawuVZWq+xV4XK/jGD6TcTuVDL9YaDh+nVdFWHx6WnSuMoWxvYr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NJsb70WG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9453A4E41393;
	Tue, 28 Oct 2025 10:16:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61E8F606AB;
	Tue, 28 Oct 2025 10:16:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A1731179B1A0;
	Tue, 28 Oct 2025 11:16:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761646609; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+OuXZMnaZ4fecFxPcq14M2NVMZIWpSpSGN4BrirylB4=;
	b=NJsb70WGj3gzFkkHQ9peasIqc9ipmU2eFTBxN8RViZloU3PbUejLbAfegZxMQrRJ9pbQeA
	jFEtjUGrbDob/mQD3Pc8W8/iktEPQ+7opkZCyPE6OrxgODiOudGzeZMFVZfWRj4nyDHyDq
	v/FAH0o7JLITPliZLxdofG/N0asK7GVTO8pP+qxcama1CZNYkw9X7QTb2vAIp9ZLogx2hY
	M8m9GdiXvnn9W+Fh2UxnDZ5E2x71+rkREBoFLqNJPnHhOxLGGlWNNYJtvAzqn+8iAKd7Xx
	gqP2Aq49d4l5YmAFKBcsw377SOb1j6jfIuzhTTYy36W1As6negm8txob1Y3F2g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 28 Oct 2025 11:15:47 +0100
Subject: [PATCH v3 6/6] drm/bridge: synopsys: dw-dp: add bridge before
 attaching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-6-bb8611acbbfb@bootlin.com>
References: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-0-bb8611acbbfb@bootlin.com>
In-Reply-To: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-0-bb8611acbbfb@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

DRM bridges should be always added to the global bridge list before being
attached.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

This patch was added in v3 after searching for any remaining bridges not
using drm_bridge_add().
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 9bbfe8da3de0264acbf8725d54f2f9627662e595..82aaf74e1bc070603bdda0be3a1c6dc631ff00da 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2049,6 +2049,8 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
 	bridge->ycbcr_420_allowed = true;
 
+	devm_drm_bridge_add(dev, bridge);
+
 	dp->aux.dev = dev;
 	dp->aux.drm_dev = encoder->dev;
 	dp->aux.name = dev_name(dev);

-- 
2.51.0


