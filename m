Return-Path: <linux-kernel+bounces-895360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A38C4D934
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3AE18992C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBEC358D35;
	Tue, 11 Nov 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h+GBEUer"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01B358D01
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862504; cv=none; b=uhjb61HGXkZP83ocwyjYW9wRDVgLw5xvqUWPgirLbENj3FzjBJFn4cj+UBKXSK0OUvVZZhF0z0eS+lvnjBAbBB8a/Sk+8HtAEL7H45oFuDieXVpOftueGutx1SCe9zqmCzwVcMjx1DpY4R3dD2ogItJ4zD7c4YwMu3kecj1C5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862504; c=relaxed/simple;
	bh=1clLNtEjwoVOKR5NKC+W2AEfzxwh8weW58OA/GwlBLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H1QFhnSnq5XuCI6BEUS8W/opKBjW8so/E/LmAn44lDT6XrGTS0+zytE/XrWb06xbEyt1Jdnl1BYsIUQSiSD7WnoUFuzFMPVvkAQ52UzM+tIuWXzVO8PgxrDmj8UmQqNP2b5Oes7/CBA2+54DlsBhQbtQlpQ54Slt5Y71BB2z3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h+GBEUer; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D3440C0F547;
	Tue, 11 Nov 2025 12:01:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5EDEF606FB;
	Tue, 11 Nov 2025 12:01:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 885C110371757;
	Tue, 11 Nov 2025 13:01:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762862494; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TA4TZzdHdTlEwf3ZFsWUEX0NQNey9iL6sbyvv48f/cQ=;
	b=h+GBEUer8cMBIfQmoPpCeJekDGUYKE98C+sDX0n5/CZ94fy/iFSBaQbvTa0WJgzi6vnA/N
	QdjFKlUxCB7HHuv35IoRCo/TfkN0Spei1dAGj0fuEncxy5soGR5a+brT+jsc82k94uFb4X
	u1ltUZq3fdxC4p4/VMqgSmsMRRGl6GZtx8oXm3A4Mh2ulVZCaBY7Yq5RJMFBm+EJLLlWn3
	jGaI7CP1BjgvhaRUUXHfYxZsmiZXGRZPK0oJVId0C9Tdv/ZqchHJFw0c90fB4f2p+anNXt
	ty9maGcDltboPSIyzJPMlyfDtz33/QK1r/+aJNOjsELPW5Rsik8YU2ww0UIjxQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 11 Nov 2025 13:01:23 +0100
Subject: [PATCH v4 3/7] drm/bridge: drm_bridge_attach: lock the encoder
 chain mutex during insertion
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-drm-bridge-alloc-encoder-chain-mutex-v4-3-12b13eb8c0f8@bootlin.com>
References: <20251111-drm-bridge-alloc-encoder-chain-mutex-v4-0-12b13eb8c0f8@bootlin.com>
In-Reply-To: <20251111-drm-bridge-alloc-encoder-chain-mutex-v4-0-12b13eb8c0f8@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
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

drm_bridge_attach() modifies the encoder bridge chain, so take a mutex
around such operations to allow users of the chain to protect themselves
from chain modifications while iterating.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v3:
- Lock encoder->bridge_chain_mutex directly, no wrappers

Changes in v2:
- Removed comment before on drm_bridge_detach()
---
 drivers/gpu/drm/drm_bridge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 8f355df883d8ac8de9d361ec302f4ccbf3bca0d6..c8389383e0d286c0d576ae1864ee783e002d44be 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -462,10 +462,12 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	bridge->dev = encoder->dev;
 	bridge->encoder = encoder;
 
+	mutex_lock(&encoder->bridge_chain_mutex);
 	if (previous)
 		list_add(&bridge->chain_node, &previous->chain_node);
 	else
 		list_add(&bridge->chain_node, &encoder->bridge_chain);
+	mutex_unlock(&encoder->bridge_chain_mutex);
 
 	if (bridge->funcs->attach) {
 		ret = bridge->funcs->attach(bridge, encoder, flags);
@@ -496,7 +498,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 err_reset_bridge:
 	bridge->dev = NULL;
 	bridge->encoder = NULL;
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_del(&bridge->chain_node);
+	mutex_unlock(&encoder->bridge_chain_mutex);
 
 	if (ret != -EPROBE_DEFER)
 		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",

-- 
2.51.1


