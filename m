Return-Path: <linux-kernel+bounces-775310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34704B2BDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E577BA0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476AF31984B;
	Tue, 19 Aug 2025 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0LQ22EOg"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D01DF273
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596567; cv=none; b=Iru3Eu6nV3VdKghpHOn2WNaO7Ibt6+Pz4U9ORXdaOyCUfH6WqIN/ScmnlZJB8zOOfQCNERrPev/asAEf9CXV12Nw2vbPegplG/KtqMxD/9f332Rdkz2fgvSDXcYMafvfp+jJWnRk5D10SPA4WlQODXeZcsZwuKjSDGKVoxNXEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596567; c=relaxed/simple;
	bh=oBgHnl9exEXWTWzH77dkHQ9PKnz6enJdL62Q0xnTEAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRE3Zna7vO7Vl/HiH8Kqoy1iUMeE+tv91FyGGdy0oiQQzt8S73RYuCDyik5FB+y4puyQXhYjqhxuHxCvxwHGoY2P9JJowJwfIzx3US6LB28cCbEmnqUQCwO9Q32+C/rPagCbrCRG/jvwMdfQici0/B4iVO3uBcd0cS/EwHJ1joI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0LQ22EOg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 83C6C1A0936;
	Tue, 19 Aug 2025 09:42:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D13060697;
	Tue, 19 Aug 2025 09:42:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FE601C229658;
	Tue, 19 Aug 2025 11:42:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755596557; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wa0v0I2WqdC2JdYUW2NKyiKEQHDcnZtT8SCNn2TfAc4=;
	b=0LQ22EOgk5GVpkH9IfifatUNtMldEUwsOiuSwTXpO7WVrMzhz2LvrxuF4ktPFKHsfwJ3N2
	4oU3Zob9XF+EVOoduBCISazBkoeG5NLasDQk0eoDc98CwH9N98yn/lS5sEV8n0xakc2/R3
	v4DjKhKa0aeNQQDKTpA1FcRBE+3nTiN1pkWyyai0lNbbZfJ8uc4s8jQo8qwIi5vbpSVKRY
	7RhFusriqRJRSxk9g0Y/UHajnM9B1eNP7a1yPh4LemwA96JBQTbU+ICRsm+XSXBLqOLgqc
	BijX9x/V2fDtBO2HCI5XnSediPhSdDFDF14judjeVxJKJJ2ZJvUMcFAw6qTkYg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 Aug 2025 11:42:10 +0200
Subject: [PATCH v7 1/3] drm/debugfs: bridges_show: show refcount
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-drm-bridge-debugfs-removed-v7-1-970702579978@bootlin.com>
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

Now that bridges are refcounted, exposing the refcount in debugfs can be
useful.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v7:
- rebased on current code:
  - code is in drm_bridge.c now
  - removed if (drm_bridge_is_refcounted(bridge)), refcounting is not
    optional

This patch was added in v6.
---
 drivers/gpu/drm/drm_bridge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 0688f936eeb69d9f5655f2b00de4a0843dc76088..36e0829d25c29457cff5da5fec99646c74b6ad5a 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1477,6 +1477,9 @@ static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
 					   unsigned int idx)
 {
 	drm_printf(p, "bridge[%u]: %ps\n", idx, bridge->funcs);
+
+	drm_printf(p, "\trefcount: %u\n", kref_read(&bridge->refcount));
+
 	drm_printf(p, "\ttype: [%d] %s\n",
 		   bridge->type,
 		   drm_get_connector_type_name(bridge->type));

-- 
2.50.1


