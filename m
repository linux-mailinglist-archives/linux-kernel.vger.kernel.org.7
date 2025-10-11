Return-Path: <linux-kernel+bounces-849200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75175BCF7E9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5B814E30A4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C079B27E1A1;
	Sat, 11 Oct 2025 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FP9bmFEK"
Received: from smtp.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7478E552;
	Sat, 11 Oct 2025 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760196272; cv=none; b=ADJs7Rtk2EKgU+Gs2ovT3D++PVE6SF0BYoweJm0EF4MlSmm4crrjZ6/RMdFMhOViqLlRnU3Xemfk+UfRq/1gebBlXze8obU4QEpNfYfXqUEx0GVTmTrMZYhcdT3ZIDl3qu/qqmLDrj9SsFWukBO9F2QIUYf3zS4DTEuIj3ORuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760196272; c=relaxed/simple;
	bh=ENGYbSKEiBI0UF5g/v8l1ODX7PFtIIgsBfgqWfVOZo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGXj7AnCZpzPV5HBX46vOp1HPZEGlUHJOP/bp8BFCf/4V6rCZVwdBf6BHxR4iaUsptLyrYZbP8I2Or7BbUfNTsTxOjFVk3E5nvvTmt2t1JOb6CJd9Co0EJ6j6HaTNKHF6d99FxqBuuGZq7cZE3UCWdBP2sP5Ly5TEC98efZPM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FP9bmFEK; arc=none smtp.client-ip=80.12.242.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 7bRFvxJn1A5xR7bRFvBQ4T; Sat, 11 Oct 2025 17:23:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1760196200;
	bh=a/TfkN8iuDSFf5GeeZL7tz298UI34rTKa4QzIThjPH4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FP9bmFEKa5ovFis9LIiOWzEG0DWH0+nGhpuX8lhCF4OXUGebzo2arx2m8hgMpyS1h
	 27dR0az7gZwxoRHTxEGhU4EapSQGj4EREjJzVC8B+/CJNC6h/yGYuKP3v4UsZQ4wgh
	 rqJP/sFdsUHtXP5ifB0NsnA76+b2NUKtOXVCaCjjcX5jJIH+HhaeQSELbJGRgyPNGW
	 pOqGLSDryQtgDwrKrV20OsCfIRY9kPaEnXU67egA8SC8J1SH9p/oPOn7VnV3m9q7Ab
	 3+o8Hs61wjb56mesffIugaymwUNixxoCV/2Au2e3HHdhyxDQjrJ7CWbXUwCzTOCJvM
	 2q++Bix4ZYHHg==
X-ME-Helo: fedora
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Oct 2025 17:23:20 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: cdns-dsi: Remove a redundant memset()
Date: Sat, 11 Oct 2025 17:23:14 +0200
Message-ID: <beb76bce09880fa4afcdb04f359fd6b1012c298e.1760196170.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'dsi_state' is allocated with kzalloc(), so it is already zeroed.
No need to explicitly memset the memory to 0.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 09b289f0fcbf..29ffae74b5da 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1017,7 +1017,6 @@ cdns_dsi_bridge_atomic_reset(struct drm_bridge *bridge)
 	if (!dsi_state)
 		return NULL;
 
-	memset(dsi_state, 0, sizeof(*dsi_state));
 	dsi_state->base.bridge = bridge;
 
 	return &dsi_state->base;
-- 
2.51.0


