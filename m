Return-Path: <linux-kernel+bounces-834361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C10BA4883
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DE91C070EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9C24676A;
	Fri, 26 Sep 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AtRdtuR8"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303F123643E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902458; cv=none; b=PPnKnRBTlcTzRxiDW9bV6Ou5PgnEWkFo4TyvDivMP+aVzd1KwseX1KGFau94p/KwdL44V8eudkVhaJwsVpPKmruEnzjK/mQDVcsk0n2J9NfrhMvgNmww0klTAlctUZ5V09rUolBZA5sJqTjKcnGh6whjqI1GIPmjTFS7eRVJQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902458; c=relaxed/simple;
	bh=HWrjTsOcpTrvoFLdgOVq6bKMnxz/4oF11kX5j36JVGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmiijUK3QG2fj49lraOeQ757ln9UQS5TZNdBz7KMVClpgTX2/KzRQAmrjvgLwJ5sjw8bxdqvlLpyIkZs709sP2ZRJ4WgGTDYN1OZ6sIvUP+4CsQBb/0uZV83YPYUMzngubxOqUoajbqFUMNG1FMDfyesNxbiReBp3GQZ0kX3KnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AtRdtuR8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A6EA04E40E09;
	Fri, 26 Sep 2025 16:00:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C4AA606B5;
	Fri, 26 Sep 2025 16:00:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08939102F1982;
	Fri, 26 Sep 2025 18:00:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758902454; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bQbeSoETZvU76kTebT1SrvTmAa6ZoKkteFMvPmRF7a0=;
	b=AtRdtuR8jwkfmX062IdknJYEmv1ogWUWg5qb4lEWZVrr6tzSpFn7TxdpRdM5m+oxtYWHaY
	fokEGjBgzdcHWbnviqpPGsqefh47MAyRviCDcfmealsBypya0EVoL4v9metwIOFcSQoLVR
	pkLra3LfmebhjZiEsye564AtBTyT3QCEXWhLzn6vEK7Tppx9qN3eUa1ibzuPe4CN3pDbCp
	HpfZfSjfhK4WJ9b7obGDW/f/cHP72OYZ1QbAadcP2pgfir0Cfud5B2y/qX3pTLYH3ZfEmp
	pU2PFqpB9RxnP4QfIQNBQ3rLqcmMjIkhfih++C9g4Z1c0HCR+mAFHx3moEK5CA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Sep 2025 17:59:47 +0200
Subject: [PATCH 6/7] drm/bridge: prevent encoder chain changes while
 iterating with list_for_each_entry_reverse()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-6-23b62c47356a@bootlin.com>
References: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com>
In-Reply-To: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com>
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

These loops in drm_bridge.c iterate over the encoder chain using
list_for_each_entry_reverse), which does not prevent changes to the bridge
chain while iterating over it.

Take the encoder chain mutex while iterating to avoid chain changes while
iterating.

All the "simple" loops are converted. drm_atomic_bridge_chain_pre_enable()
and drm_atomic_bridge_chain_post_disable() are handled by a separate
commit.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 554959147a00efa9807c245290cba8977ce88fc5..66c0a80db8426ffb360248895cfe2a11d6007ed7 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -706,6 +706,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 		return;
 
 	encoder = bridge->encoder;
+	drm_encoder_chain_lock(encoder);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->funcs->atomic_disable) {
 			iter->funcs->atomic_disable(iter, state);
@@ -716,6 +717,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 		if (iter == bridge)
 			break;
 	}
+	drm_encoder_chain_unlock(encoder);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_disable);
 
@@ -1220,6 +1222,7 @@ int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
 		return ret;
 
 	encoder = bridge->encoder;
+	drm_encoder_chain_lock(encoder);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		int ret;
 
@@ -1234,12 +1237,15 @@ int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
 						      crtc_state->state);
 
 		ret = drm_atomic_bridge_check(iter, crtc_state, conn_state);
-		if (ret)
+		if (ret) {
+			drm_encoder_chain_unlock(encoder);
 			return ret;
+		}
 
 		if (iter == bridge)
 			break;
 	}
+	drm_encoder_chain_unlock(encoder);
 
 	return 0;
 }

-- 
2.51.0


