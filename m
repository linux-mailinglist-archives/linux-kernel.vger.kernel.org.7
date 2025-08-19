Return-Path: <linux-kernel+bounces-775311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82684B2BDB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C44C175929
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57A831AF25;
	Tue, 19 Aug 2025 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xXN6mLqv"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C7A31AF12
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596572; cv=none; b=KIWLyVejKr2TG03UVddFdep0c3qVBQeyIs7S+/Pg/CDsNLt08xAUqTXoB746QTI17jWXowBGK1zzvBKVUCP+SrOxZt9dNUBQ3eRHQw4Ftb2S3bvKAyEjAtCYL97NYq3gFBL+PgtCTTvSYbn+bRntjtOX4RY8MFc+h/Yo8cALG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596572; c=relaxed/simple;
	bh=tbEbxC3lasitTEiFGF1v1C5EhcUL1XXAfMyzF3iDbUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+xGRdh+0VosT5d12y72eYgHYMTSEnmzEXnpwkuUGOWE52xU55TukbXBnI32iUatiGXOVZAPKWjIqAaR0fJXwhwXlV7dKZZ1HhCUQzMyRIiHTQ7NQV+yuBrdQFdTMAGbCWDx7eJ5LN/FkoFN7CjGUD03f9MMy0eEuA9j0OpHeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xXN6mLqv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4BB741A09EE;
	Tue, 19 Aug 2025 09:42:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 247BD60697;
	Tue, 19 Aug 2025 09:42:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22EA81C22A3C7;
	Tue, 19 Aug 2025 11:42:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755596562; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2zNEQPZm8ICen3OOvc7q25hoGo9P+jznlNsABvPRulI=;
	b=xXN6mLqvOUaVJoNCPpIvghQ8ufVJlS7dDO2xiPJ5CNBjIcvpn3Dsoje/ErdeiW/bcgPvXg
	e+bm7Ds9lm9vf4LNnRdjye7n2nbiuRf1RbalKE0Cxk2GsDMYBwortejAfo5/pD+SsXO+75
	BiiCijda81WjuMOK9eT/TmopY1iW1EOBSMF8MWwMlgCVQUPcku4B2qUqcRKK930oGlz6wi
	+VD3F01DN+MfutUSzXRAfPRcsrTjAD7GDCPSG0z7Vmn/DRE2mmmoTcMZWMtdTzycjxGGQh
	4oPDzg6q7mG5LhEsQ9h0XfNlRPoVvO9NZYTjkq1vf1tqkqkruXMEFzq6TFNTeQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 Aug 2025 11:42:12 +0200
Subject: [PATCH v7 3/3] drm/debugfs: show removed bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-drm-bridge-debugfs-removed-v7-3-970702579978@bootlin.com>
References: <20250819-drm-bridge-debugfs-removed-v7-0-970702579978@bootlin.com>
In-Reply-To: <20250819-drm-bridge-debugfs-removed-v7-0-970702579978@bootlin.com>
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
index 2e688ee14b9efbc810bcdb0ab7ecd4b688be8299..4e9ad8a198e357c448b82a1ff5e07e558a6168d6 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1498,17 +1498,20 @@ EXPORT_SYMBOL(devm_drm_put_bridge);
 
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
@@ -1534,7 +1537,10 @@ static int allbridges_show(struct seq_file *m, void *data)
 	mutex_lock(&bridge_lock);
 
 	list_for_each_entry(bridge, &bridge_list, list)
-		drm_bridge_debugfs_show_bridge(&p, bridge, idx++);
+		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, false);
+
+	list_for_each_entry(bridge, &bridge_removed_list, list)
+		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, true);
 
 	mutex_unlock(&bridge_lock);
 
@@ -1549,7 +1555,7 @@ static int encoder_bridges_show(struct seq_file *m, void *data)
 	unsigned int idx = 0;
 
 	drm_for_each_bridge_in_chain_scoped(encoder, bridge)
-		drm_bridge_debugfs_show_bridge(&p, bridge, idx++);
+		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, false);
 
 	return 0;
 }

-- 
2.50.1


