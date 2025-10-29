Return-Path: <linux-kernel+bounces-875345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F16FC18BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BF0B4EA896
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9858130216D;
	Wed, 29 Oct 2025 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sgf3Bxev"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7F12D0C90
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723702; cv=none; b=q3PqdPF+Ujmzo+Jw1d8fJk5jzSDtQ1kDFxzFzewiSE+bH4d7ZjGG0sW41vre9kYlMobTtE197TGm5TzF2hFyU4qoLnHRDRp5uPbyHbrMJ7BJ0dkKPuiBMJ81IDjHBJPJKUTXydECjPSGSqS5p0MbQxNWYM7JOsxsCycc82gztpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723702; c=relaxed/simple;
	bh=vQSgQhpSPXq7YicGVSd0ynrLW5738W31iJ/iUBFQPSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kd/nlZ9YwyR3DXBkSROvDZBEZhRZyIcyCYl2mBUosMihgZrGwoFX+Ha4daid0zbaGEyeNI/DPV5qQTxL/o6UGGUZ4c+EANT7lGXYS1LxD9a/7hKIzBwyxeFrUpQTYzo1+o0dnzkO2c6XPuyzl2C8CsW5Z0CBa4wBPPnjfi+WqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sgf3Bxev; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2698d47e776so55447325ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761723700; x=1762328500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgvDUTgmwUbybBiqh6wci1MBiFa+WkYYBAxgF2SWiwA=;
        b=Sgf3BxevDX/53PJQwR6IpjVyabiMVmP/SxtSoawkI90iHgMd3jOybNIihdS47yLY/Y
         +cC3poZDv+IUy6Cuh71ayjcf5QT/qSxNx6j01x3Ze8PHac7Zp8LjdB0VIy3t1kql4FxD
         uLe3JD/M75kyyOOkDwg8datHGwCW29RDdje2lu9L/PF2mQelk6PG50knIpryktv8BixC
         X9IFzdNgHivJ0vkjHk2CDBzqw7urYaBojmZX6OvgrJHg+jN5/DHjWj7o30joH2gEYa6P
         RW6i+y0fJENk5+YErUTj/bjWa/cuVJcubkq3QqCXekeMSVQ6k0sllxf3gHMraphHt6ff
         tQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723700; x=1762328500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgvDUTgmwUbybBiqh6wci1MBiFa+WkYYBAxgF2SWiwA=;
        b=P0FYDZy0qzTa0pYvBsUGtJNPnPjDzytY/8Iz+fvZr7v/e4bn7yK+MQtZ252mbrAveX
         y01UvJOkgI1PfinrODpTT1BN2zcJc44CwoFkGj0hk50/VmMxm/lf1RYVtfYxSJOhYZv3
         X/Xlm+7lJViw1c9CuoQxJNkcFiN+mzCqalNDMNKJCp5Tfos/r3AWa9iOOjoSUXESL21I
         XNm40pK1dIAKtOC1ZPCRPKGf6gB4QSlI3yYQXT5Ftfx5ljjdx5ZywVCbR61lzW2zDvYi
         QW+gjQmVyTRbIuRNFnRYrq00kj8o3TzNf8kBiQR8RiyQeZO54n7M8ToFVGQibT+iOa5/
         ukFw==
X-Forwarded-Encrypted: i=1; AJvYcCWEX77n3g8cSQWOqinVKz6mK1B31JPkaTifCuOQutFURM1B2dMUqVll8wm0v6cUus4DVKQyXz04D2KOw4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9DbOVcgmiaP2knbxOaI0r4tfZbmAJVenOl0IaS1SU4lthUCz
	S4kPbyERNe8tVK6Q9l6ng3ugVVAiaSGfyrYICVymPwXqloub0azu6Wm8
X-Gm-Gg: ASbGncsiEm8jPrq9x2c001jgjo/iVrlDg9i7czTyMQfSQ9jXSctWTUc+glonU+YRbBw
	ZXsgPqaD7b6ucrUYGpjzt0l/alfsuV9Ig7v8zgBcVJA06wrLVJitOKtqMO+7RW0uCdl4yqgeFMH
	d0xqXUIB1gYVTYq6WZ9B5jcv1SISBUyvOU63S2+/JX3MjhraBVEk9iWFyeSRO/NszukkpXrfa3e
	J11CJG1nO/gKf9D4nHtqoqZaGxzGT30VUtMU6ZCln8QCV9MeyHJyMG+6ix2dPZb9QOWkouxZMmy
	/ATsnXbG/lPWglM1etMarxjyoY6EAeSKIf1akdCnTMZJlIVrX2jrNabMUrv/+d6V3orL5Q4fnt8
	5T/8bomz//Xd+FMDPW/s8x0fZXywXgKF8+LFHlqdPMAx+Fuqph30kaEsoSpTGN44GlG7PFgYLZ+
	5WHZrqexUtlFCvsl8AEbUqnQ==
X-Google-Smtp-Source: AGHT+IEAqSeL49I0O53+T8EYYG0n4Be/S9PQxC/LftWWFjftQd/hhQp8QU08hja4QrlQTuil7K/59Q==
X-Received: by 2002:a17:903:234c:b0:246:4077:4563 with SMTP id d9443c01a7336-294def2da22mr23417225ad.34.1761723699803;
        Wed, 29 Oct 2025 00:41:39 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fed706449sm14495814a91.2.2025.10.29.00.41.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 00:41:39 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: samsung-dsim: Fix device node reference leak in samsung_dsim_parse_dt
Date: Wed, 29 Oct 2025 15:41:20 +0800
Message-Id: <20251029074121.15260-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function samsung_dsim_parse_dt() calls of_graph_get_endpoint_by_regs()
to get the endpoint device node, but fails to call of_node_put() to release
the reference when the function returns. This results in a device node
reference leak.

Fix this by adding the missing of_node_put() call before returning from
the function.

Found via static analysis and code review.

Fixes: 77169a11d4e9 ("drm/bridge: samsung-dsim: add driver support for exynos7870 DSIM bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index eabc4c32f6ab..1a5acd5077ad 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -2086,6 +2086,7 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
 		if (lane_polarities[1])
 			dsi->swap_dn_dp_data = true;
 	}
+	of_node_put(endpoint);
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


