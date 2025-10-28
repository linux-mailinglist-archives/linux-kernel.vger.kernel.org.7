Return-Path: <linux-kernel+bounces-873486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 438FEC140B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FB33500570
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EE5277CA4;
	Tue, 28 Oct 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZQoiuq/g"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2E303A03
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646600; cv=none; b=k7aSTkMY151/VsxYYGZf/dlJZahFM/Uyd72W+JvxSd7dbRXFY5ltAMBCquU8C14rA84Gd6a4+8b7wBTnxiNoayaOxrpJ+3ZsggJTF6akPVmPnTVMHldjqk9mp7Bc4KUsWOMEsI6gc3z3X3qU1ZPO4/6fELJ8Sh6gUDfW9p60x3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646600; c=relaxed/simple;
	bh=m0jhAQW6Nuy2F/RFwu4GuGJ6hb/4pWU9YS4dkgmp8U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MsmBjrNJwnFXi3CD52WFMBqSARNrlNwX49FyMejD1gdIumIy47rWR2EJEAETzp8U8WonZ8XDvULQHHw/tPpQ/f+L2zuN0/VE51v9ABg2ADXC/jFCyrVf2BZR8j9mUVZ3moeALZuAyJiEmNdsuPfXehU7D+B11U0BPk0GU7l6kNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZQoiuq/g; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EB379C0C408;
	Tue, 28 Oct 2025 10:16:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 351D8606AB;
	Tue, 28 Oct 2025 10:16:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E9361179B14C;
	Tue, 28 Oct 2025 11:16:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761646596; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Pbf/CGcLpewLgLdKRQhA80Qa7Mx65sj1bmKZQ1GINdc=;
	b=ZQoiuq/gQMnwBUKeeos5Z27KdRZdCIgcUFjRSL8JdEeuh/NkS1gI3yIt7XheNTYpQJYbot
	ALgs6yDieHKQJ1pXFXUomXKsVOSCOnhTCwvrDILiD+ZUpHFjOAJZjlMhDBJAQ9+Vvt1gL+
	gYTRTndraZXJdjk/f2Q3pOUoiuMhuG36dpeJXtLT/w9WLXuWAml46KOl+/73+s3R8sbSTn
	ZODKyl1InDUYffGe7M5guuHme/NKG+25cMqOxXf5rRRb88gNcylLhsf1oOkqTTJc7qL+rH
	TtUR94xFcJ5htSmf/Wh62f8lKMu3nn2GEbVdwVtAsLD9CKZMcvWtWNZatV6Fxw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 28 Oct 2025 11:15:43 +0100
Subject: [PATCH v3 2/6] drm/sti: hdmi: add bridge before attaching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-2-bb8611acbbfb@bootlin.com>
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

Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Acked-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- removed misplaced 'Link:' tag
---
 drivers/gpu/drm/sti/sti_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 4e7c3d78b2b971f8083deae96f3967b44a6499cb..f8222e60b1e01afb6d93f816915f17056c060f22 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1459,6 +1459,7 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hdmi);
 
+	drm_bridge_add(&hdmi->bridge);
 	return component_add(&pdev->dev, &sti_hdmi_ops);
 
  release_adapter:
@@ -1475,6 +1476,7 @@ static void sti_hdmi_remove(struct platform_device *pdev)
 	if (hdmi->audio_pdev)
 		platform_device_unregister(hdmi->audio_pdev);
 	component_del(&pdev->dev, &sti_hdmi_ops);
+	drm_bridge_remove(&hdmi->bridge);
 }
 
 struct platform_driver sti_hdmi_driver = {

-- 
2.51.0


