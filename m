Return-Path: <linux-kernel+bounces-814539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A57DB5554E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8AE1D65D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF3A326D50;
	Fri, 12 Sep 2025 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IH4OJtqO"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42530DED0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696658; cv=none; b=LohwOsZrQVYMsGUWpCODxSzmcAoL6VluZQ6DzInkzDTDSuW5alIPx0X0eYf7w0o21iSUhPwr07GIXUWbUN3itZI5umKAQ2hy7iuu39eg05Al/mMo/lvairpZ8Z8k/eK6x5LwNf3oog3nKUdHPe2MFBI6wWBfFIM4eVM1uThq8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696658; c=relaxed/simple;
	bh=vuSX4FsmbWEEZpJ2iPXX3RYpav4VQJePAQGIRAt6hS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIoBtptDz1643ja7HOYLC/UJNrPGiRVbBS60jAdmPv2wwOyJhMxwC5RVhpVZhx8BrQbzSruRIwSEq9SbZgzXnRkBoEHVHJXFirl89RmorVr8OHbro0XNqZFQpE1+NTHHibqnTtyCtRreI30An37tqrjpx9q8jx1+Nx4YIKemxW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IH4OJtqO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 86A9B1A0DAF;
	Fri, 12 Sep 2025 17:04:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C7B360638;
	Fri, 12 Sep 2025 17:04:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D9D2102F2A07;
	Fri, 12 Sep 2025 19:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757696653; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0FN+VQXH0gC957+CRfqZ7uNe9rZqNRVL8JKOdPNEbBI=;
	b=IH4OJtqOMV2F8MuFwjZurDp6r3Yg2bVrJ8qcFJ8GoqNNyl8nGxFFgE886dZgq4ayNwMUjs
	6PhsXDJp1L7oryqO3JqoYgdTikkGaZfZG9SIdYSxJAyl8sgTyv3NgCwTJOzsF27PSdoIhY
	3E9htP8NUJXvq13qQl1lHihPvbRuGlYbrUMGgkpQ7kyeVRAkUF6XYnoGqGELWAwfHQNlBP
	UZMgG2khlwOV4llSmRGR/LYgJrIVPAQJUVhxivlLLaGFrhpqlEgyN07SN3XzMrmgPelawi
	OQTCy0ga4CVXgkAu5oSSbaZ6W9ROsHjRRcMQnJf5cOTRO1nBR1CRwczFFyYqMQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 12 Sep 2025 19:03:42 +0200
Subject: [PATCH v8 2/3] drm/debugfs: show removed bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-drm-bridge-debugfs-removed-v8-2-5c33d87ccb55@bootlin.com>
References: <20250912-drm-bridge-debugfs-removed-v8-0-5c33d87ccb55@bootlin.com>
In-Reply-To: <20250912-drm-bridge-debugfs-removed-v8-0-5c33d87ccb55@bootlin.com>
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
refcounted bridges can stay allocated for a long time after
drm_bridge_remove(), and a memory leak due to a missing drm_bridge_put()
would not be visible in this debugfs file.

Add removed bridges to the /sys/kernel/debug/dri/bridges output.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

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
index 9491ae7c884d355be4a82fb02a43a42d17fa8e0c..fccc42017fd4df6ecfb596325df2dc4d17566f39 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1491,17 +1491,20 @@ EXPORT_SYMBOL(devm_drm_put_bridge);
 
 static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
 					   struct drm_bridge *bridge,
-					   unsigned int idx)
+					   unsigned int idx,
+					   bool removed)
 {
 	drm_printf(p, "bridge[%u]: %ps\n", idx, bridge->funcs);
 
-	drm_printf(p, "\trefcount: %u\n", kref_read(&bridge->refcount));
+	drm_printf(p, "\trefcount: %u%s\n", kref_read(&bridge->refcount),
+		   removed ? " [removed]" : "");
 
 	drm_printf(p, "\ttype: [%d] %s\n",
 		   bridge->type,
 		   drm_get_connector_type_name(bridge->type));
 
-	if (bridge->of_node)
+	/* The OF node could be freed after drm_bridge_remove() */
+	if (bridge->of_node && !removed)
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


