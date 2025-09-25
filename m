Return-Path: <linux-kernel+bounces-832940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1638BA0CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220963A9576
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C516230CB22;
	Thu, 25 Sep 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iOpkIZ6M"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D831B14658D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820816; cv=none; b=c4Un61rzU/upI6se6fF8wwOF89K3HycptuMEsQJQXRq83AUUbHOyEkiHbokpoJOG2Ecc2lcT535oeVWsOZTRvYdjGTeH3Mi2V4LQuHlfWz0j91/U4rvVSULsmR5DDNk0qDVkt8XQ0R7bJgXvZ9oGYRTeuwVhzPCF9qjWLEV1vuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820816; c=relaxed/simple;
	bh=FMldVev/xV/swbnn0A2UVed8DEgJs+vvTzf6WW3AY3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8IKbUVZoMfvFShafMUErzXUox5B0/TMNAsD91cEzGa4esQSNMOpB0dX5hJGVjoqtjfnXYng8aw156QsNFvQ09F13jjG0FIuNrjBo9+MOoyPCgLpQ/NxKeXebeEC5yZaJKl1xnr4nRMgMavozK2pwVah1NIKVDUuzfNKISdtFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iOpkIZ6M; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1C159C011FF;
	Thu, 25 Sep 2025 17:19:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 64BE060665;
	Thu, 25 Sep 2025 17:20:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36952102F18A6;
	Thu, 25 Sep 2025 19:20:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758820811; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xHjzQbM/4RJWH0CChP1hj2HXRcgPGp7OejUh4qefmG0=;
	b=iOpkIZ6MraXlaLq3hs/jbA/mLz0DmdJ+9nEQHFO1/iIwjjkzLZln5Ril8MpIUAItw2Qfua
	tyu5D+f3jZXsMKcrPhT8Zhnwf3iw5n5iNUt8FI1yRVqexgmR+cqhZKYq8by2nvGSQJvGQZ
	7gmjv2mx53Vd+KywFNpeea0CCxMTC+sM5ynUqJ0DdWq/C39AAZiRQW+8lVkUyjsSMIPsr4
	e2zHPnBVOONEgfGJzJHf+lmSpaGiXdEud97ABlHeUn5Tkw4Qb9hZu2m131vGg3/K0KdWGT
	T2SwFKY54sAXAsScuTqkVZImbMQlJa3FQUfpYaGWqOMHbnvihwe7PsZSA3c3ow==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 25 Sep 2025 19:19:49 +0200
Subject: [PATCH 1/2] drm/connector: allow a .destroy callback for
 drmm-allocated connectors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-drm-bridge-alloc-getput-bridge-connector-v1-1-f0736e1c73ee@bootlin.com>
References: <20250925-drm-bridge-alloc-getput-bridge-connector-v1-0-f0736e1c73ee@bootlin.com>
In-Reply-To: <20250925-drm-bridge-alloc-getput-bridge-connector-v1-0-f0736e1c73ee@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Some code is going to need connector-specific cleanup actions (namely
drm_bridge_connector will need to put refcounted bridges).

The .destroy callback is appropriate for this task but it is currently
forbidden by drmm_connector_init(). Relax this limitation and document it.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

The other obvious approach would be adding a separate .cleanup callback for
the cleanup-only actions. I tried both, they both apparently work, so any
arguments and opinions on which approach is best within the overall DRM
design would be very useful here.
---
 drivers/gpu/drm/drm_connector.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 272d6254ea4784e97ca894ec4d463beebf9fdbf0..bd0220513a23afcb096b0c4c4d2b957b81f21ee1 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -513,7 +513,8 @@ static void drm_connector_cleanup_action(struct drm_device *dev,
  *
  * The connector structure should be allocated with drmm_kzalloc().
  *
- * The @drm_connector_funcs.destroy hook must be NULL.
+ * The @drm_connector_funcs.destroy hook must only do connector-specific
+ * cleanups if any is needed, not dealloacte the connector.
  *
  * Returns:
  * Zero on success, error code on failure.
@@ -526,9 +527,6 @@ int drmm_connector_init(struct drm_device *dev,
 {
 	int ret;
 
-	if (drm_WARN_ON(dev, funcs && funcs->destroy))
-		return -EINVAL;
-
 	ret = drm_connector_init_and_add(dev, connector, funcs, connector_type, ddc);
 	if (ret)
 		return ret;

-- 
2.51.0


