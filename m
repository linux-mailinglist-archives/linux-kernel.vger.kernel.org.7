Return-Path: <linux-kernel+bounces-841106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC80BB646C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330D93B76BB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED486261B77;
	Fri,  3 Oct 2025 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xH7vQ5m/"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7828369A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482051; cv=none; b=r5YYzkP9u3v0oZtM221kyPfiyxhUzkRKawcEoWMNOXCLFiocIwmZJRzbUMwiPV2jIFTb2DCVS0jQnpsQG87VWi+1ZjzxzkYllvJXBfyHEPFQRCwElALmPnpEGFgUQblUyfVoSZ55AWcoy6BtmI0ZwwaEhTYiFQ9lWr3+n7YNxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482051; c=relaxed/simple;
	bh=elKj5SGKRdahCPeqKBzJ7FplJSvKMwYHgJcE0grd/rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLz9drmmY6eMR0lBKmOox0trc8nnLjrYBNdaX7y47V9kKnqEelcbqzamNtg6OaiypPyLOEaitqnxJ8bA30aiycETKD5aLkaGczSx98/VWbspXpPffjpaX+sVpq9FXPuekFpxhsAgBJuH/Zi1NF+t3EuH2lWFkiowCKu4aBsLCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xH7vQ5m/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B322F4E40E90;
	Fri,  3 Oct 2025 09:00:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 89D7F60683;
	Fri,  3 Oct 2025 09:00:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BDB2102F1C33;
	Fri,  3 Oct 2025 11:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759482046; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ebfUGkYH5pGjBKB+Sf434xFBeiTl0SZ+ny8lNc0QXfU=;
	b=xH7vQ5m/dsvHtjScC488kOPlgbneze3g9Xbx0zuE4G4meEKLY/IGuzDaKTeGJT2UByCXHM
	SxBF9ZivjWXs5m+tOlJZ39gAPkNfDVC7rE76kTq7wvh9/r1sdOZAU4SPwUA0XJUHEmd5KQ
	Y7exiY3dgKKXlv6WC+jBmrkFhUtyrf6Z9P17IO9knzwKz99/9Dq2Z02BjyToC1Bk5GhVYn
	DrDKsgtaBls8lBHKGL0gAyUXYJh6XL3zlfEG5YoUWb+lG71BD9mlNNJR/sSEztomNMrr+y
	qBtO7rgUSdGvQqxt0USJF6hSdMScGhGPu3prU4w6cbn3qvfgeDkLTxhgXpNqaw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 03 Oct 2025 10:59:56 +0200
Subject: [PATCH 2/4] drm/sti: hdmi: add bridge before attaching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-2-92fb40d27704@bootlin.com>
References: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com>
In-Reply-To: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

DRM bridges should be always added to the global bridge list before being
attached.

Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
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


