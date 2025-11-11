Return-Path: <linux-kernel+bounces-895356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4102C4D928
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99A8189814D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CAD3587D3;
	Tue, 11 Nov 2025 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="s0oWb7a4"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B283570A0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862501; cv=none; b=kY5Uw5vq3xViM/2m/+o+h2zW6ckYPm4UEdJtLBmJfbygU6FtKSZMAFfE4EUffCNWH0NZH6WiVu0G4bGzFll9h4Yh0UTeyQ3VLFOp1VbltD4ra2D1unFE5iLCZ6VNTD/Y64zn0ZJKUDe5A899d6+EGfXO3yxDPd9fBCI3biSNdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862501; c=relaxed/simple;
	bh=xUPpOKK7DQhW4FTyGwu88aTs6YPnXL36m4PzyQr2ymE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtMisNPI8thVAYSrHC2shJqn2WoKt3TN+gj03YqiymaFYwaOUTZKTUGWedhmhr+khytSbeCfrL7pbWreBwlo6HgFGwL++eyI3FwadOAOA9SmHTn1V3YcGrUPVgsRUmOmuOKw8GmBfmBFmlROe1loiRMljdQh6ORsWcMy98AW6ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=s0oWb7a4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id ECE4E4E41627;
	Tue, 11 Nov 2025 12:01:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9B7DC606FB;
	Tue, 11 Nov 2025 12:01:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CFF410371942;
	Tue, 11 Nov 2025 13:01:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762862489; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=caYAPf6iewWTVEYkDv72AgsM1cq+8VKXAzMNFg+RhVE=;
	b=s0oWb7a4OaPHX0gRDTBb9NN711RRduEmHAIlDZHgEI7uj884WiJjMNm8TGid3RmPnpqD3b
	sFfCtnNYpIk2crGbwgl2oDooHeILJtD+qVKZE+JrdlRKys9JOxwR9rEIh0vfk4HOtH9wce
	n0+azbhIEfqoQF2ItveAiVljZZn17xA2AKmI7Bzp1VFrEEzK+ZkNUavs/4IatWx2PWzWeX
	LIR+4NeeZggmMhZImk/JPI1KhSaDlQoq1gGQzw6wgJOq7MF4UxsEPbjOj23xYqy6Wburnw
	/2Kw4U7vaTHAzDZsUYb118Zt+S09SFfDTz8Inw1SHsF5/P/2mohhl2aEUmtUlA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 11 Nov 2025 13:01:21 +0100
Subject: [PATCH v4 1/7] drm/encoder: add mutex to protect the bridge chain
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-drm-bridge-alloc-encoder-chain-mutex-v4-1-12b13eb8c0f8@bootlin.com>
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

The per-encoder bridge chain is currently assumed to be static once it is
fully initialized. Work is in progress to add hot-pluggable bridges,
breaking that assumption.

With bridge removal, the encoder chain can change without notice, removing
tail bridges. This can be problematic while iterating over the chain.

Add a mutex to be taken whenever looping or changing the encoder chain.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
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
2.51.1


