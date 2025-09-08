Return-Path: <linux-kernel+bounces-805544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD6B48A05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7485D1B23063
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F492F3617;
	Mon,  8 Sep 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SMZawYYS"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D81DFFC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326951; cv=none; b=mxm+3Jrs8xT566fOA/A/kuEc1oad8+hOxcfyE6Rar7cTTzoMODUg7NHz4YQ3OeTEYR4No+bqn3hkbF+TxX4QZVpbWCeGvRD33zD7CCWu5OWQT1kwwDI9G9Viwh3W43p0Bsxn3GSUS8Y8tEjzArGmu/bmyiSd/xLzQJ9G6y7qxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326951; c=relaxed/simple;
	bh=Bo4R2srjkeq0H9/iqOb3QQxgaNQ2+g6uMTOt2Ia4jOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXfzMyFafz5y+Qh/PZELgbNcTuJLbN2ZaxZeSVj3t/qpKt/Uh2c5Rt5fTA08TCSPE7yOP1UukcQbAsOPi8/8onRWIn8sMJz0Rs9wisnX7LVZqVzaQTFUZmKH86FBXh1mcjh/xeuanjfum3MCKyGWe6XC50OFL8dCITKBfv6jOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SMZawYYS; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757326947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dEhcnr2X+qmyqAXr9sSFjDSvggs46vsUK8XfBne8efQ=;
	b=SMZawYYS+/zNrE0nb81PkQV+BiPtH5ixsQ9VmkXV0JWIuXLf0Uf7AszQfq0pCx+AeVrJGj
	VWSrT0kT9/Cwe8Rtk317gwih9WrzxTXH3mhijO7jmN5sa7Y4Sx9AeSr1v2ZsqyMeBf1UIs
	6VxQRWIQTqSpbVm0/NSbZoshD1OhRNI=
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
Date: Mon,  8 Sep 2025 12:22:16 +0200
Message-ID: <20250908102217.3725-1-thorsten.blum@linux.dev>
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
2.51.0


