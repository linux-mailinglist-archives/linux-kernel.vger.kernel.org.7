Return-Path: <linux-kernel+bounces-834357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A568CBA486E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D767AAB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E6623817E;
	Fri, 26 Sep 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pSEdxGvo"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6047233149
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902450; cv=none; b=tTvns2ZVqMVNJRRJbpehn00NqVjDApBZeMQFFKYsceaZi7mymEuKjhLyOjsvbBR7P571KjJYfmW3/KyAytDlmCro9QbdU4wXsygqt15/4rCABxxdEQ/fAZ/BxwOOKyJk+JRkrWawm+YJed4zUW8urGZTJs9WMh+0OmJZ8lsM70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902450; c=relaxed/simple;
	bh=bSKlgcTE2tqnQAfvUw7h2KuSRdXrRYfsMe8uvhDe/2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OkjPCauASiAFttC41L1g/IqC97wpFuXbMJpd4GBuL1K/cMFfq4IWWOHPuiP3ZlA6XkMz3xAux2WRDy7xM307JSzBlINz6CFNXRz+RdqMkV6tY6chJlppzcs+DadEStLVsbNCdxQiZWCDsK6qlWM6+S2mhyzQo9dPA0zmkNIs1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pSEdxGvo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 35C8C4E40E0C;
	Fri, 26 Sep 2025 16:00:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C058606B5;
	Fri, 26 Sep 2025 16:00:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 927C4102F197A;
	Fri, 26 Sep 2025 18:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758902446; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Pyl7McX8p/BvXq+1eS++mIsDEQYJnykZVE13rAURX84=;
	b=pSEdxGvoMSA2wLwDyKPNC11bCZHACQd7041B62ZaVy8r3Cin3eZ6ivrLAgkw51kf5hTl/B
	/eVefzTFdgRc9Gw3dJns3lX5lEwyvV4IuNjrkIqLWUAbUJvcZpHKm4fpAQ6UyaaJxieb7q
	Ziy+KKKwAqPnm9o15Y/3FWc+litHwWYSYXl+cZRZEQkOPJIzYtnhCdEUIIkPiiP8ahq380
	QuLFg/7RnbvTMFRC46BHyEdb7kkPjDBCpdJEeHmQLRzPTFFcArGE6PsAuG4+Wjh00usNCY
	kVbO5WBYl+d2Vn5fS75bXtrlpKJdLFtcPex4N2qgu40POPOYIzvnLxdADx4IGA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Sep 2025 17:59:43 +0200
Subject: [PATCH 2/7] drm/encoder: drm_encoder_cleanup: take chain mutex
 while tearing down
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-2-23b62c47356a@bootlin.com>
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

drm_encoder_cleanup() modifies the encoder chain by removing bridges via
drm_bridge_detach(). Protect this whole operation by taking the mutex, so
any users iterating over the chain will not access it during the change.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_encoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index 3261f142baea30c516499d23dbf8d0acf5952cd6..3a04bedf9b759acd6826864b7f2cc9b861a8f170 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -195,9 +195,11 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
 	 * the indices on the drm_encoder after us in the encoder_list.
 	 */
 
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_safe(bridge, next, &encoder->bridge_chain,
 				 chain_node)
 		drm_bridge_detach(bridge);
+	mutex_unlock(&encoder->bridge_chain_mutex);
 
 	drm_mode_object_unregister(dev, &encoder->base);
 	kfree(encoder->name);

-- 
2.51.0


