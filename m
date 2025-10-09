Return-Path: <linux-kernel+bounces-846724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83624BC8DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC293E7D52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A952DFF12;
	Thu,  9 Oct 2025 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aQUj4nHv"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC672D7DE5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009966; cv=none; b=XoD3BwyR8ToZWxpPZCNiFOGM1eVQQeVkR8iNC2NzU24Z9lRzGpy7HKYCQNH0ulXCXWK5FR+53QlCGnvEAsXgdGi+lvx3tml9X6WSllzi3Kp+LXJPyGeV6IC2JGPJdh0I8zc329QDFNBrHs2jX3i1wFkTqh04/rHtd3Xt7I1XjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009966; c=relaxed/simple;
	bh=maEkPxciNRj0q+f5j17JeBW/u7CNxjTUZ7pppeDlfIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YO1U0XlpDAJNSOS6xMA8tei+R51Omr802esS8/40EHELGsi/ThcUrS6/FAO27EcIH1rmwAvuG5LXwv9Zm9udRYLr5AcLrzeQ9J3lot9anhnfepSQxqqeQG2wYR+sD6CLcTwqyB4aTp00tMrRfNkW+FdnsibJLodn1EYHh16lKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aQUj4nHv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F2B9BC0359D;
	Thu,  9 Oct 2025 11:38:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 86FE96062C;
	Thu,  9 Oct 2025 11:39:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CA2D102F21D1;
	Thu,  9 Oct 2025 13:39:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760009956; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AwYCkGNcORGbBTMYr3nyq+d2grRy53+g1LRUgh49gfo=;
	b=aQUj4nHvlMNcQkFMJJv/WyPV2Wy+5OMmMqu2CI+oAXaekoHjJjosmwmZxH3GdU5A525/Pt
	hAuHiaG5QDWtPws0gvbXWY/3tGZJcv4r1ScROv0F4mJJcKsrYLJdDXXpnoiBjc8j8PdIb6
	U2zZkP3w3TVV2rlt6oE6sCTVDKBU/7M8oD4bpbOQSw+y8nImfRpNJcLr2SjIIlb7OcRI0j
	CJG0HD9ukAlCIzGNsmq2rVhnRbOXVH82+2q80/ap6Zfkhmr/5bN1zHVEprHZ7OdDMNQg9j
	hzOzwsW2azECrbaK90+/fgAq1rYPbeBtXNG1HByp9LaOq7Xe0j1fu82LkHKf/w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 09 Oct 2025 13:38:56 +0200
Subject: [PATCH v3 1/7] drm/encoder: add mutex to protect the bridge chain
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-1-c90ed744efec@bootlin.com>
References: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-0-c90ed744efec@bootlin.com>
In-Reply-To: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-0-c90ed744efec@bootlin.com>
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

The per-encoder bridge chain is currently assumed to be static once it is
fully initialized. Work is in progress to add hot-pluggable bridges,
breaking that assumption.

With bridge removal, the encoder chain can change without notice, removing
tail bridges. This can be problematic while iterating over the chain.

Add a mutex to be taken whenever looping or changing the encoder chain.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- Removed the drm_encoder_chain_[un]lock() wrappers

Changes in v2:
- Added documentation to new APIs
---
 drivers/gpu/drm/drm_encoder.c | 2 ++
 include/drm/drm_encoder.h     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index 8f2bc6a28482229fd0b030a1958f87753ad7885f..3261f142baea30c516499d23dbf8d0acf5952cd6 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -129,6 +129,7 @@ static int __drm_encoder_init(struct drm_device *dev,
 	}
 
 	INIT_LIST_HEAD(&encoder->bridge_chain);
+	mutex_init(&encoder->bridge_chain_mutex);
 	list_add_tail(&encoder->head, &dev->mode_config.encoder_list);
 	encoder->index = dev->mode_config.num_encoder++;
 
@@ -202,6 +203,7 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
 	kfree(encoder->name);
 	list_del(&encoder->head);
 	dev->mode_config.num_encoder--;
+	mutex_destroy(&encoder->bridge_chain_mutex);
 
 	memset(encoder, 0, sizeof(*encoder));
 }
diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index 977a9381c8ba943b4d3e021635ea14856df8a17d..eded7c34481a2e9b4a1273004627a03f4035b24f 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -25,6 +25,7 @@
 
 #include <linux/list.h>
 #include <linux/ctype.h>
+#include <linux/mutex.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_mode_object.h>
@@ -189,6 +190,9 @@ struct drm_encoder {
 	 */
 	struct list_head bridge_chain;
 
+	/** @bridge_chain_mutex: protect bridge_chain from changes while iterating */
+	struct mutex bridge_chain_mutex;
+
 	const struct drm_encoder_funcs *funcs;
 	const struct drm_encoder_helper_funcs *helper_private;
 

-- 
2.51.0


