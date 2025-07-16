Return-Path: <linux-kernel+bounces-734280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C84B07F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9409117C52E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161326E6F9;
	Wed, 16 Jul 2025 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EbXPd/Gq"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BF1FECCD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700511; cv=none; b=R/J3zwKvpdbKjMvF3UiNlr2ij0EsMXyY0jCmDZS4QFHns2D9DHvhyLhlA3Jax8+45tC+zn5P/4/hGCqqH5NfLBWG27g+T9Lsckk6iICeS2dgHPHxAeyf9TZimCG0LQ2MKSIVTf7q/r09TRiBRSi6TDspsc53AmZ2+SXWwK8kxxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700511; c=relaxed/simple;
	bh=p0i1FB6F+kXJG8Ue0bhsTU1IKwDgs4suxTDEAvEkNDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQ4EIU1BxYnsJR7ns+ZG4otkNkCbxqG601JVdaTYxA/GfrmLOUtzeBRp08lm+6Nr554beR02eka6s998KbhV9ZGToMDXUl/sqcd6miS9bWQZuaLbDR9Z9KG+pcMi91+gSNvKPtU9DyV3Uy2/QwVKcM9tUz4tA6UjtqfFTyxFoNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EbXPd/Gq; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752700507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=19CADCH4ex67/f+oe/6jdXcNL5Bo7Hgf1ytFVQUJ75o=;
	b=EbXPd/GqDjoHZp5QQrWjmO3uNzUJtjcv/EqCSYY9gsYWvOo8btmauDj79xGQtW5Z16M4Gm
	jFFEXwByat10uAH0wKINOwl3Ly5giQHZXbgcmmRPjRnNrQAkHuNszF2gErTYe4vKzDimpJ
	ZtUVmuTVJAWEYKhDIUWA1QU+pY2bHg0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] drm: Use strscpy() instead of strscpy_pad()
Date: Wed, 16 Jul 2025 23:14:53 +0200
Message-ID: <20250716211454.277019-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

kzalloc() already zero-initializes the destination buffers, making
strscpy() sufficient for safely copying the names. The additional
NUL-padding performed by strscpy_pad() is unnecessary.

If the destination buffer has a fixed length, strscpy() automatically
determines its size using sizeof() when the argument is omitted. This
makes the explicit size arguments unnecessary.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/drm_property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index 596272149a35..47f2891f3f06 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -128,7 +128,7 @@ struct drm_property *drm_property_create(struct drm_device *dev,
 	property->num_values = num_values;
 	INIT_LIST_HEAD(&property->enum_list);
 
-	strscpy_pad(property->name, name, DRM_PROP_NAME_LEN);
+	strscpy(property->name, name);
 
 	list_add_tail(&property->head, &dev->mode_config.property_list);
 
@@ -421,7 +421,7 @@ int drm_property_add_enum(struct drm_property *property,
 	if (!prop_enum)
 		return -ENOMEM;
 
-	strscpy_pad(prop_enum->name, name, DRM_PROP_NAME_LEN);
+	strscpy(prop_enum->name, name);
 	prop_enum->value = value;
 
 	property->values[index] = value;
-- 
2.50.1


