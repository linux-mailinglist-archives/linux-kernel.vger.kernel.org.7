Return-Path: <linux-kernel+bounces-863700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80399BF8DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDDCF356C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC262877FA;
	Tue, 21 Oct 2025 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UDm4nEbE"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371902874F8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080491; cv=none; b=bLCD+BA2aKYoJKaIFcf9xz+4SzlWtzB7PNgs9fdJCIyUIgBqhGdG3QUIDprLTPUXJ8WKxhN7srk/QPGWwftgM+w9dqAbM6b2f0+SgRvTLzn7AYiYxs/Yo0aIAIvQa0tJq44oSTugm5BZx/4yNiaU297QXYVKcFauQ+qyqJcy/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080491; c=relaxed/simple;
	bh=pBjfUdjbqY9Yz36hon7vReamWFx77NrxoFtcL3aa/+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqgWK34BjvVUw5ZMMCGPRnKGFes+YPh9yGMMpPsjQkCK9DEV6Qo3JdjAGXGAKhNb5LAjpjxJ/0D6nrvobW/M4RB/RpBe7lNIigzQaE/qT5ODUyf//VumzgmP4a2TKgRs5icUBfWlrpqQucWx0T7XO3Nysu9aiAW/94UEhYR7gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UDm4nEbE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 96A001A15AC;
	Tue, 21 Oct 2025 21:01:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6D90C60680;
	Tue, 21 Oct 2025 21:01:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49BDC102F241F;
	Tue, 21 Oct 2025 23:01:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761080487; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=p/3IIpo2fKAEaKJeCKwn/2EO3bVCvyymxE4cdcCqCkM=;
	b=UDm4nEbE2HVXl+I3B42iVs765XRRw5DrLs4OqZ8TN28Zgn1tG1P9TwxzSlsd/FV5QPNwJB
	1yiF7otbpl/9zsaTwRRYASbxZ3rhJYmjhCyfVnej+Y7r6JdEm1aYv+Ud4cjhHAj6DQWKXU
	C0LyDAbZeUmsaJy8jXiPo9pkUUj5fpK4byb4o/v7N0jm9lK2YaM6vGbwKqnTI9oIUSR/6K
	K1VYcxKgw4VeWiRPwqidIoVDBqdW5ej4l1PwsaImB8PZjvzac9I3suR1kz3RWZguHYfoSx
	o5xw9jKjUH6sejwG+HBIHl1pMkTFZ95YFyrLsCZffqMuwBUgvPS2CUT6t/AmiQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 21 Oct 2025 23:00:47 +0200
Subject: [PATCH v2 4/5] drm/bridge: add warning for bridges attached
 without being added
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-4-c17cc1bbff72@bootlin.com>
References: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-0-c17cc1bbff72@bootlin.com>
In-Reply-To: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-0-c17cc1bbff72@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

DRM bridges must be added before they are attached. Add a warning to catch
violations.

The warning is based on the bridge not being part of any list, so it will
trigger if the bridge is being attached without ever having been added.

It won't catch cases of bridges attached after having been added and then
removed, because in that case the bridge will be in
bridge_lingering_list. However such a case is both more demanding to detect
and less likely to happen, so it can be left unchecked, at least for now.

Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
Reviewed-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1246a52f8767b52c5f10139aa897824b3c2f28da..6dba601a056bb3cff8b8dd5b1ec46299235b2d85 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -441,6 +441,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (!encoder || !bridge)
 		return -EINVAL;
 
+	if (list_empty(&bridge->list))
+		DRM_WARN("Missing drm_bridge_add() before attach\n");
+
 	drm_bridge_get(bridge);
 
 	if (previous && (!previous->dev || previous->encoder != encoder)) {

-- 
2.51.0


