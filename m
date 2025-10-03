Return-Path: <linux-kernel+bounces-841108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5154BB646D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28D20344AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E122BEC28;
	Fri,  3 Oct 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ObAWEyCX"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D3288C89
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482057; cv=none; b=uCp5hsey9OdxT9EPSigw6qun1liVKq9UpW8xvLAhJveQUcxwAqe6M3JqGbtdl5Culf6E86f/PXVRNCxARXHgckfetpNzZ6PjIMKt5OVX664fVH7gYT5cLhRrlKT+gR8/U4SbYp3Ve1BZp5Dlg9GIz1vT1Hw1rj20pYxt65maZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482057; c=relaxed/simple;
	bh=ebnwyZ92XBfrC87y4vHvaA6sN1g21WrKrf/tOG+0dn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SRVJ0zRyQ2hXbdyzrDSwmYE9J+tJ0fJBS+XlHEegswPKLqk85+tNAg0+N94PHB0YCXeVgXa5/qrcXLob2zl0+5l10IK0QiWer2R3Q8icnSp4gdR46AVrqtJc1sZOICqHS7b++woUqh4sKk6iqbldR2vS1pCFeIHJ29Y0u3gI9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ObAWEyCX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BF4EDC00D93;
	Fri,  3 Oct 2025 09:00:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BD8D360683;
	Fri,  3 Oct 2025 09:00:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A1E7102F1C33;
	Fri,  3 Oct 2025 11:00:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759482052; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ieiQe/8Bss9tI8naQDPEum9VPw8wY17XSTnksOOgxkg=;
	b=ObAWEyCXotcBuCrFfYanIqOZ7uT7LApr0EjRpVNSK5CUNW6ggTBk9Yl3BbZWM3DuUD13LZ
	jWeIkrqq4IpYYV6KTfVIQM5959FyeBrEGVqyThZhqR5CwD1MaeOrN932XYZkHMBk0+wHP6
	plfObkAez1laKJRhtEulLvrzS3Zw2K67Adqriv3buL3G3P57AAqOUrQRcrVnACby3+vMwY
	UO31I0EaC5SkCeVfXNOG8QV2m8R1aMr0CY6BDVI1ctMyi7Ce1lbKesWRUU+rSXxmsgdixV
	iKiPtyfE3Ta1SCo4khbqn/T2cdpz4gvk7SkTdVcCAFHShBU9mxhHsKptpziGWg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 03 Oct 2025 10:59:58 +0200
Subject: [PATCH 4/4] drm/bridge: add warning for bridges attached without
 being added
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-4-92fb40d27704@bootlin.com>
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

DRM bridges must be added before they are attached. Add a warning to catch
violations.

The warning is based on the bridge not being part of any list, so it will
trigger if the bridge is being attached without ever having been added.

It won't catch cases of bridges attached after having been added and then
removed, because in that case the bridge will be in
bridge_lingering_list. However such a case is both more demanding to detect
and less likely to happen, so it can be left unchecked, at least for now.

Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
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


