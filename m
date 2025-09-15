Return-Path: <linux-kernel+bounces-816587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DCEB575E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C093B36FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522C22FABED;
	Mon, 15 Sep 2025 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fjDASGvl"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71422FB601
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931251; cv=none; b=NKW4/BOEBSbu7hAwxgpZx8+svFe9vFyU3ud6rf5Dut17VjlST1z0H9vwbvIH28esnDItg1hzSr8OYt1p2qKIgkOWqJ7f7yseHXdkbabw2mJDIq+RwWt5/BvHKcfwTXwtP7czxiaDA/9tRVY0+8VX/HtUu6rF1SaN00Oc418MCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931251; c=relaxed/simple;
	bh=wc5TUXJ0T6obVvbOtZGrI+LHe8XU4yLo4f+LXuPnE8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VxkzeJpU8LbqBMK+7J0XQZlii+ZLazRY0BBK8z/THlfrWzrQECdPsLLROQFlt11KM6n4BYEUKKiEZnz+C1VQYsAaQWlPjzwIKDsHDV6IazFwHUGQb7UOwuGLsDRDBbPlT2TQivsAgY3AYWjGDYu0EoTiQX/Zy8XpolVpvaqqK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fjDASGvl; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 22FAB4E40C35;
	Mon, 15 Sep 2025 10:14:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB9656063F;
	Mon, 15 Sep 2025 10:14:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A064102F2AA2;
	Mon, 15 Sep 2025 12:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757931247; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=J9/AgKGIATQBdVyJoqM+e9KL7AMFzerN17q6UT9Xda4=;
	b=fjDASGvlNTRDGF29veJE/I+msnzzs0t7B/U55qcHiFayGzigavx7iKdPms0psCwGt3ajT8
	u25jAzL2lU1B6JfM0eZ94GmiLBv2egYtuB7uN55Y2i/4yYvQxCZnKtwcoG3SqSU02fK05t
	ohz1hJeBJEb4fhCRqON+kLqP8dmmIXwKxO5Wkns0YsHPGRNeVmVmUd7ipFwTxPyHjKX4cz
	AJ8ssXG8EcCw3TcAgL4JROsDkcxu+RM21OQ9BPlGoS5/NEnrjXD1Vq+QAPeP18Kw9rB1E6
	ShzXEuZ9EdwCkXp/M6MwqrX2B1WAp11qP0rAQgeH8jBNbPqpHqskcyokgyIi3Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 15 Sep 2025 12:12:48 +0200
Subject: [PATCH v9 3/3] drm/bridge: adapt drm_bridge_add/remove() docs,
 mention the lingering list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-drm-bridge-debugfs-removed-v9-3-6e5c0aff5de9@bootlin.com>
References: <20250915-drm-bridge-debugfs-removed-v9-0-6e5c0aff5de9@bootlin.com>
In-Reply-To: <20250915-drm-bridge-debugfs-removed-v9-0-6e5c0aff5de9@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The role of drm_bridge_add/remove() is more complex now after having added
the lingering list. Update the kdoc accordingly.

Also stop mentioning the global list(s) in the first line of the docs: the
most important thing to mention here is that bridges are registered and
deregistered, lists are just the type of container used to implement such
(de)registration.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v8:
- extracted to an ad-hoc patch from the v7 patch "drm/bridge: add list of
  removed refcounted bridges"
---
 drivers/gpu/drm/drm_bridge.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index dda4e641a38fa38cef16296366eea08fe8702618..10267d3903ea12f19308376d83d432637c26ae76 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -296,10 +296,13 @@ void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
 EXPORT_SYMBOL(__devm_drm_bridge_alloc);
 
 /**
- * drm_bridge_add - add the given bridge to the global bridge list
+ * drm_bridge_add - register a bridge
  *
  * @bridge: bridge control structure
  *
+ * Add the given bridge to the global list of bridges, where they can be
+ * found by users via of_drm_find_bridge().
+ *
  * The bridge to be added must have been allocated by
  * devm_drm_bridge_alloc().
  */
@@ -360,9 +363,14 @@ int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge)
 EXPORT_SYMBOL(devm_drm_bridge_add);
 
 /**
- * drm_bridge_remove - remove the given bridge from the global bridge list
+ * drm_bridge_remove - unregister a bridge
  *
  * @bridge: bridge control structure
+ *
+ * Remove the given bridge from the global list of registered bridges, so
+ * it won't be found by users via of_drm_find_bridge(), and add it to the
+ * lingering bridge list, to keep track of it until its allocated memory is
+ * eventually freed.
  */
 void drm_bridge_remove(struct drm_bridge *bridge)
 {

-- 
2.51.0


