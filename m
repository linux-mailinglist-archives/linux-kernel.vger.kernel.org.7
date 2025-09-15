Return-Path: <linux-kernel+bounces-816586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD34B575E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2171AA11FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD322FB99E;
	Mon, 15 Sep 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CtZTMnMU"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904D2FB632
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931250; cv=none; b=l+KnlYIWgRSX9dWOx8K+XAUH3BnA1CE1yrQwZvUSEAUP7ATXuuo18ZKNnEtPKke/AQf16ljq+6KTUjG77HbL+G+p9jOGBAxvvLGPfAOBcA8SDCOpNypsGj0dXVogz3hglkFwXm9KqOHAzo4QRqc5hParFSMkxM8kQEQjTNoAQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931250; c=relaxed/simple;
	bh=ecPadECTbqy38SJJqaQ6PdYuKoRS8Wmn5VIsEo8/w/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0i971300n40KPmlzeF+H3iIZq2S8rl6QBIqgDBFo5DCHl3GZ9PfrEUZ7hEKt5dTKaMUwSi4PcBbsmYAb62E4IdqsYFXJgD1FkJ/tKiUehqc+IYVilUtT9QC05iH9YsJzeDB7xMJULUGXcd7F8GR6sy/j7o4giKouy9eSXmrIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CtZTMnMU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 37A2C4E40C32;
	Mon, 15 Sep 2025 10:14:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0CD9B6063F;
	Mon, 15 Sep 2025 10:14:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 32F1E102F2ABB;
	Mon, 15 Sep 2025 12:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757931245; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MxaPaKKWKs3ulFwyzozXHLb7YuQsngXreF1xvu2bmpo=;
	b=CtZTMnMU03MxTsrWXJ9NXMRSnC0dMIdN9ALKSTRBqUHAc7zlUv+xA2w7kfdoJKHwa/y5J/
	63Nq+cjEoHfO5MKZd0vlB6xyPwf2YDm0Y6UPJaI8JUqtVFpkcFfCGCtC0L+So0A2FDwZL0
	W6+orSJQh/TbX17Trd9bW3xtJG3P/e3ymWii4/1pEQnuWsEEZiLrhauMYqDAkF6LrWk2bN
	WWBb7AqKUKtkOBN983pbMZebyzDH9mWONo2pFFbfZNbZ/KtKXTSTpUdQyzJRJHKuwyWkAw
	pzjxZnALiNY7i2jeKZbWzcZ9AnMXaAfbGg+mCsJwRZX8STxTrPqihKUtY/4Dsw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 15 Sep 2025 12:12:47 +0200
Subject: [PATCH v9 2/3] drm/debugfs: show lingering bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-drm-bridge-debugfs-removed-v9-2-6e5c0aff5de9@bootlin.com>
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

The usefulness of /sys/kernel/debug/dri/bridges is limited as it only shows
bridges between drm_bridge_add() and drm_bridge_remove(). However
refcounted bridges can stay allocated and lingering for a long time after
drm_bridge_remove(), and a memory leak due to a missing drm_bridge_put()
would not be visible in this debugfs file.

Add lingering bridges to the /sys/kernel/debug/dri/bridges output.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v9:
- rename leftover instances of "removed" to "lingering"

Changes in v8:
- updated to rename bridge_removed_list -> bridge_lingering_list

Changes in v7:
- rebased on current code which is in drm_bridge.c now
- removed if (drm_bridge_is_refcounted(bridge)), refcounting is not
  optional
- don't show bridge address
- improve commit message

This patch was added in v6.
---
 drivers/gpu/drm/drm_bridge.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 9491ae7c884d355be4a82fb02a43a42d17fa8e0c..dda4e641a38fa38cef16296366eea08fe8702618 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1491,17 +1491,20 @@ EXPORT_SYMBOL(devm_drm_put_bridge);
 
 static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
 					   struct drm_bridge *bridge,
-					   unsigned int idx)
+					   unsigned int idx,
+					   bool lingering)
 {
 	drm_printf(p, "bridge[%u]: %ps\n", idx, bridge->funcs);
 
-	drm_printf(p, "\trefcount: %u\n", kref_read(&bridge->refcount));
+	drm_printf(p, "\trefcount: %u%s\n", kref_read(&bridge->refcount),
+		   lingering ? " [lingering]" : "");
 
 	drm_printf(p, "\ttype: [%d] %s\n",
 		   bridge->type,
 		   drm_get_connector_type_name(bridge->type));
 
-	if (bridge->of_node)
+	/* The OF node could be freed after drm_bridge_remove() */
+	if (bridge->of_node && !lingering)
 		drm_printf(p, "\tOF: %pOFfc\n", bridge->of_node);
 
 	drm_printf(p, "\tops: [0x%x]", bridge->ops);
@@ -1527,7 +1530,10 @@ static int allbridges_show(struct seq_file *m, void *data)
 	mutex_lock(&bridge_lock);
 
 	list_for_each_entry(bridge, &bridge_list, list)
-		drm_bridge_debugfs_show_bridge(&p, bridge, idx++);
+		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, false);
+
+	list_for_each_entry(bridge, &bridge_lingering_list, list)
+		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, true);
 
 	mutex_unlock(&bridge_lock);
 
@@ -1542,7 +1548,7 @@ static int encoder_bridges_show(struct seq_file *m, void *data)
 	unsigned int idx = 0;
 
 	drm_for_each_bridge_in_chain_scoped(encoder, bridge)
-		drm_bridge_debugfs_show_bridge(&p, bridge, idx++);
+		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, false);
 
 	return 0;
 }

-- 
2.51.0


