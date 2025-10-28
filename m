Return-Path: <linux-kernel+bounces-873488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB537C140CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86C784F191F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224C9305E37;
	Tue, 28 Oct 2025 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VUKNk8bO"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA47305E2D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646608; cv=none; b=ss4wBP2HwDfS7P3maJOA0FoWVnqcTNDRlowSSNPugioK2n8yqwuVTmbg0DFk86E0sdTdavxLTTUm2/iNkwLL+IcrY/XN6R54JHI2uhKFsHFIysogUi8n33VEP17GAv7nJABLyY0rydCRsvm9BhtKW4Zo8C3/NvxqNUxbjk8v4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646608; c=relaxed/simple;
	bh=IAND4q8BblOAeS5tfwL9gK+8ZJzaFqeI8sc1eST0XHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9VvzLhOEEIoL6pRMFCcW880woGFnS7W1IEwn4h/zgWqZe4oM6RsQMHX6DHhq9unoMGruPck+cuSZzPmlVhRTR6epuqjz08dD2IzRm6xF/aB+HCLk/IZ6aUL3qt+SF9VPVcV6h1ePWQKA/AP5gz1NQMHOMd3FxcDbkLTJgIAHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VUKNk8bO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 84D42C0C408;
	Tue, 28 Oct 2025 10:16:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BDB38606AB;
	Tue, 28 Oct 2025 10:16:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67CE91179B16F;
	Tue, 28 Oct 2025 11:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761646603; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Aqs+sfSmiPEHQh8G/sn7Sqo6VRtZAC2XPw+ZTvejj+4=;
	b=VUKNk8bOKU9dg6anXLvRhKDRhB6uty6Eg/UxHEma4KiWOpJGR2lg44OvHVfRRZrP2RYFa4
	eFxE1qC9b7edsKUAh5rN4bJo+rDYqBllggWSWcJzprbp0Pw+d+VoiB+RL6UcIzvNSPDwwD
	ZRll/uWUjDYDDK8Dvtvr9rlJ43422ae3JXq339d/v8emcPN0G5lVwbKkcrMGe/rIDRqmva
	JGQfqkG6Cz+JnlHKc/ahmJBD5aeIWohTjVy/qYHLkUJSkWjmGaCJs3wBMfb1fH3tBmDQmK
	JugyOW5FZzwNgDLwezbWKWTCxe8RXmLlKJcOJpBnk/JLTZeHS9+BN7BV6GsYww==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 28 Oct 2025 11:15:45 +0100
Subject: [PATCH v3 4/6] drm/bridge: add warning for bridges attached
 without being added
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-4-bb8611acbbfb@bootlin.com>
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

DRM bridges must be added before they are attached. Add a warning to catch
violations.

The warning is based on the bridge not being part of any list, so it will
trigger if the bridge is being attached without ever having been added.

It won't catch cases of bridges attached after having been added and then
removed, because in that case the bridge will be in
bridge_lingering_list. However such a case is both more demanding to detect
and less likely to happen, so it can be left unchecked, at least for now.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
Reviewed-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- added 'Suggested-by: Maxime Ripard' which was missing in v1 and v2 by
  mistake
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


