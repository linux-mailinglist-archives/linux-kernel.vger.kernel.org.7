Return-Path: <linux-kernel+bounces-873487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB93BC140B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4C13AF039
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F260E30596A;
	Tue, 28 Oct 2025 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YbyV++KO"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42143054F9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646603; cv=none; b=NFiYrDWP6+tZ/bMBhLflbhs4PkfZeFABXuyiMUiqOVrdpDLhNlpkRfH9ujzulN+zCnAwbpQpg3Ugp6Pib88RJBieabCpLSq6gvmQHUcMf1FfxeWQr67ybKniZFH9jboEyfMYvaCr9ydeYGJ/v+a0RyaCgrb6WXLnNQ7kzxjXcKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646603; c=relaxed/simple;
	bh=0DXON5mT7BeW24BxRlTCJMjtuhADOpj9r16JxuuL5rM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGVN6bpLqG+LSyA4xi9yKsKyzWA5RBvEOxqfQ4wptLCzh7w2NIhYYQG77BzRRDfHhwSBO9h6TzVg1ecKQk2QyD4rwtK6AnXY0aLVBUUQ2bc0kM0kD6+N9+G/QzbZ057p8/J6AV/5q41qHaJuaysnO75u9wP2BWQj5HV8QEtEd5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YbyV++KO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 29E3C4E41393;
	Tue, 28 Oct 2025 10:16:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F2594606AB;
	Tue, 28 Oct 2025 10:16:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90C931179B15C;
	Tue, 28 Oct 2025 11:16:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761646599; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CO/6DLIe3Dzo5sLr1BlifC8tEkQKj1yPrLzvRzKt3Ik=;
	b=YbyV++KO4+DwHAdTVhCxcflDWiuRKIdQt5d1HcQr6CNNpdcOlgaoa2TIVAlQweaH7UjzYU
	f8BUKzoVhX14m8VrKcl3Zzqy2KhCzw7wloKeODQcEUOryY0v4E5iedzB/DIR2uB7ExIlrb
	g7tk/YO1v6Fve3kkx6wKEgz61HjNq6DLBSfRx3HyFTBaPyn7ZzFMZKlAGmGBXYzXq4J5ne
	+BJXEoUYjx/jvlCvfW6hRIIH0VTy1jm6F4yV2lS5dUMmmY8PYiU8zWTLN4hosQhWdIeI2u
	UGpX/FS++4VqeG1nz79rGspLn2FICI9GW08WU4uMoZELB8GEvz1cJpAyhSYBWA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 28 Oct 2025 11:15:44 +0100
Subject: [PATCH v3 3/6] drm/bridge: document that adding a bridge is
 mandatory before attach
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-3-bb8611acbbfb@bootlin.com>
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

At the moment it's not documented that you need to add a bridge before
attaching it. Clarify that.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
Reviewed-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 53e7ece36dd940aabd1c0880f296fce7224a12ac..1246a52f8767b52c5f10139aa897824b3c2f28da 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -422,6 +422,9 @@ static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
  * If non-NULL the previous bridge must be already attached by a call to this
  * function.
  *
+ * The bridge to be attached must have been previously added by
+ * drm_bridge_add().
+ *
  * Note that bridges attached to encoders are auto-detached during encoder
  * cleanup in drm_encoder_cleanup(), so drm_bridge_attach() should generally
  * *not* be balanced with a drm_bridge_detach() in driver code.

-- 
2.51.0


