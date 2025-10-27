Return-Path: <linux-kernel+bounces-871071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 006D6C0C66D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32BB94F4F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDAF2F12C8;
	Mon, 27 Oct 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4QL/wD8"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1482E6CD1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554597; cv=none; b=F2Sae9MTjs//5o/Ld22iKgP2d79Rc5g+Tg2EBgYOvx8jC3GKwQfHot1Rmc/XwUEwl7c47EFDWG2KbU6E5sNrTfqiDoTkuao8AJVIcT54JO9JqlJ63QMei1CXiAJm3TCX0ITInnqzqDdfDv9KekaFhAX8u7BDQwXhs55vDR4c/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554597; c=relaxed/simple;
	bh=oMKB4koHGfhFxqW7ZtCA1mWeRO3jC3K1GWY5reJ1TjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=seo/25NbLjSB//rRHfXg/7pf/wxBYVLgmF1LwbVr9fLOzT64zhJzBx9z20yL0WqyHJgKc/gX9GdGY1Aujf5LibnjHrOb8aet5L+3466QsJZXTlYsWABFwhrtm72g2btsu5ccbUsj0V/4M2Ahp4dSBuPoIRzSvmS4yOiRXcepgUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4QL/wD8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6cdba2663dso3114104a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554595; x=1762159395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHwoqgImEy7LQLhZWFXUDhaPJoy+ecZ3A4KynxwsxS0=;
        b=A4QL/wD81Yvir5jIrST7pzfQaM9QZpokBqwsDOqDCVFFEmisx8cL8/ippltZKwHfQp
         J/sBY3cOIyEnN7WGRv1vXjsReKrIQBM3w66fn9L6FbWwrz2pANSGC+x2Cpu1dGYMnjOC
         gRs+ERyUe/jt2zawSqhSFbqbqDzW+lGvDG3UbklrwKcXdmvCGPTwOp5JKkVah56Mzn30
         m1tAeioxL5V+hA93o9x1gk+9X+cEu4lxnIKoECEhtyCaLgR7GRJHAu40wtANzRsff66b
         92rIJnnw9m5dOnpYl6k0l0iBZcBNQl8QPYKGkrVjJPoUkDn7ohuhSZPDAUnzGMy2mHIR
         qzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554595; x=1762159395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHwoqgImEy7LQLhZWFXUDhaPJoy+ecZ3A4KynxwsxS0=;
        b=fBfGTMUi7+j2xar9HNH8vOaT/dDps0yH4JXEYTrWRwZkR03WatISIHr8R30ww0WFfx
         XJk9PurLGvEPWX0+8cgPMtqss37ra8934gRDFaiXK750gOzyCsALWaToF1noxtMyCM9C
         yXMogZXrk2d9Fxp0nIT8eH/Seyejv49ttbqaarvGX10akZCIXUGF0ecbLy+vZIu/K3rp
         MfnWb8E0+yC7e5Vt5pkdnkNf5liVfj1HthHs+RF18b0sLjKzsLfo1fSNNVx3Fm//3rP0
         /3F3CTntBu7kkzEg/ru8XfDTgEyvd31zhp/lwAWcbsnM723QySW0n5iWrG83dx+lBJk3
         SaBA==
X-Forwarded-Encrypted: i=1; AJvYcCVB2m1Y9LWMgHfCbqTbJLoOc+MrMNPYBAVj6KQ090cTpWZSFDunTiZqb2uFNVMF92uG5XvppHPquNd6Z14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVSV3ImxL5d2sW1I7d6DMvEvoq35Ey2CmrYJ05KMIMU8Q+igV
	kE7EwJAXPLZJ0BRE7LFBfFVu7yTquB/3Oz4enWYvl9DObHcACQeMs0lu
X-Gm-Gg: ASbGncswLfDaip4eMIIjgi8uOnHa+05oAabnQqWAYznSj/HiybJfcMpY46iGOjYpySY
	wrLUQYdqGWOcPhI08qzISFvHmLOH84w/AX+bQQQZS64mBYeXt89BefDOpTGl7B3+A9a2UWr3+ZO
	6ctlRainMbr6o9yss8BOE/yu3hnU7DW2GYAfVGK6J/bmfwCfawsgVZzc5p3m+GKv5OVwdepCnvT
	I+44nE4QFrKz5HcJWuymdD9OLsqSgj9F8u1+1DIWj2ysznDSEcr5NNihOjhLMO1bLVpg/57p9Tl
	jw9O54bBFAYkKgyINLad954H7Jfs+3fJlitKsZNhN9OmE2QbC9SPT7aKjtSSdqIy/W8cTkarROb
	Ivhr/UnUU/zNza+vMfTyAT9Wy/EwChEhyXUVD/hbgEBtwbFqmax1tEdKmRzQe/Y0ubGBeYp9upM
	aVoEf0P9AkmWMQzHKETeh6/p22l75FYVQfUCPT1TtIFYY=
X-Google-Smtp-Source: AGHT+IHwgVcslq+1mjD8C6Vh5GqRLux2tDGUe1R/TUV71B2G9ynp6h0rzEeVb0xZxIg7lRsdj6RNXQ==
X-Received: by 2002:a17:903:247:b0:294:c189:68dd with SMTP id d9443c01a7336-294c1896977mr7969545ad.44.1761554595286;
        Mon, 27 Oct 2025 01:43:15 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e3d2aasm75349815ad.88.2025.10.27.01.43.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 01:43:14 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Nicolas Belin <nbelin@baylibre.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/meson: Fix reference count leak in meson_encoder_dsi_probe
Date: Mon, 27 Oct 2025 16:42:58 +0800
Message-Id: <20251027084258.79180-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_graph_get_remote_node() function returns a device node with its
reference count incremented. The caller is responsible for calling
of_node_put() to release this reference when done.

Fixes: 42dcf15f901c ("drm/meson: add DSI encoder")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/meson/meson_encoder_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
index 6c6624f9ba24..01edf46e30d0 100644
--- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
@@ -121,6 +121,7 @@ int meson_encoder_dsi_probe(struct meson_drm *priv)
 	}
 
 	meson_encoder_dsi->next_bridge = of_drm_find_bridge(remote);
+	of_node_put(remote);
 	if (!meson_encoder_dsi->next_bridge)
 		return dev_err_probe(priv->dev, -EPROBE_DEFER,
 				     "Failed to find DSI transceiver bridge\n");
-- 
2.39.5 (Apple Git-154)


