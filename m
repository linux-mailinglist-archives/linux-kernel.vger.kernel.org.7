Return-Path: <linux-kernel+bounces-849718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC8BBD0BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED94F4EC05C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59412FD7C6;
	Sun, 12 Oct 2025 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxqTVSC7"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7ED2FD1B0
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297058; cv=none; b=qTFw/Y++CIkwFMQLFIFOlFJDAWklWqNKhawIhGa5ANdzKbkqk3VT+G9Mo1vdbzJLBZIy8WDjxkG9ToSs2m8H80mRfnUUf39wXzq+f2LlONFC/Ohx3I2pqZLp3QCDAXdktNQGblIrQnBDHkRRLwDEj9jBxoP9E7d07a6246s1964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297058; c=relaxed/simple;
	bh=AKEPEVp/D5bLHzuCgLd8B8iJEurynArxX4T5wTeN/QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fxga/iskpCGDrd0P4mjfPZ6xHrHT2AFNkuG6UnPRbuxm0cX08w7NXWb6ggyL4YdIDWqvoNdcs6vip9gVXtB/Yg44VDEP+psLn3Ev5krGgIMp7EMagtjY9jQJ1PppHBmeQ1D8h0z6xXk9JVzQ3UcdNEti8Z0SzVVT4V6KY9xPqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxqTVSC7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63babfdb52cso356045a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297054; x=1760901854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN8no7TuZPEE4ZrIoWOSDqFeNHwdwABVG2L9ibzW5CM=;
        b=GxqTVSC7LPMkWshctN3oYz+invSrnjQdULj+NIO5Yf9WPWnD8LgjrwxhzDqD7yv3Sa
         8Qk46YeVggktiqKcpMHQxuwi+DpbIsCX/vZniXO+Y/I1vw87yY5/emgOCK1H8WT+dSnU
         jeTzZqnfwPIZWZ1S2tzW18Mq6EFp/FbRdpcbcSySsTVJFA42gwGG4l+EXcZazjBZjh90
         hcUcjl9neY8b2azMq6S0kqYx1+itsJbdtvm8yOUFdlmbuPaH3qrYArG9Ai+yeN5ZWU4U
         eLIwZcyj/NH4sqObWZnWzmcsR46EXpiLQHmyVbyA+4CssGhEotoQJ9a8+HFPVoN3hFeN
         dZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297054; x=1760901854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN8no7TuZPEE4ZrIoWOSDqFeNHwdwABVG2L9ibzW5CM=;
        b=RGxNADIdFKMUyxQY6VPLiDdZ48INwhl9q5bFIpqdltHQDQ7oGytpS0FPBOT0R16on+
         HSlMVij5amodBNjSWz/rq1WaJuBwrKVpg/+wLY5YdXEUEoa8ctiK4BuxrWkuOHqaansN
         WBWpdjkqS/tpsBw5gpzf6GtFi7igbZGRYbM2QiSFKMlQ4s5IiY/QDA8CI7fyOubOXjGQ
         KEKLnLv2JQ9/lwyA001z9M5qPlEqwiJK0uQA0erxBuW/VD3FVV/WLVj7H9NNGvLbGja4
         Sfvlj/dwT0wy0GCFJjL1ZkokYHAezH/t3b9vejRKJsCSOoGZwJGURYerU62/aCl2930K
         5tMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRoBa89AMsKGHQjAgdcgw9SlpA5n2jq1HfDvV6lYNkH9FvAt0L/9usrta38JQPn276pDGGn2OgBXOl1dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5BSYI0cwJv73qhpGo/pR7QL0fYf5kErPknC9hzdhFJ1nr4zx
	npShvZiU5LsBEusd8LK8XPIcSBteyo9gNtSZlvZaoQkEdg1UleQ9WeJ5
X-Gm-Gg: ASbGncu5JWZVSxULi/s8f7yTTNyGP+g1b/+DZKi6lkf1FOG/sthXgcBrjrJbXBlaDEU
	zECQTbgv664rM7kQi682fPoodOtEEApcXpy8QtdyOT8febwGx0DRQP1ixjwUS/eAxlDy5Th3ALk
	9qMGmnjaIrzb5vcplPB7aHY1dhBFVxhD7h+so8l7GA/ykz+v0DzypquAMgBWiRYdwiGBENsJmIi
	GiPzBZTcehSfWmt96aLWXV6s9NdRF1fTR3dLm5q2fwPMtg2UZc815+d4tBhnCz4jXoBiyqDdeE3
	52QCwpvbqIsMjFDHSQvByWVEAC20Jo2nTE3du7Q6ITFFk7KuRNPiosY+k4IofKFy1cqrba7nK74
	UrQsNoEn9Br8FR9sAHR0E/hT4p4L8XEM4MTbEEwKPoydKRsv5hgJ2gdKmNS6Jr91xzEIkjZ8rfd
	uuNOP9yopemoHLKOLC3Go7
X-Google-Smtp-Source: AGHT+IGliGTnpTGRawNal6hhCfPRYBSBq/r1s8fnX2W1RihxLmu9ewXMj4AGe/8If5EcaR6rduNrqg==
X-Received: by 2002:a17:907:94d2:b0:afe:7b8c:a583 with SMTP id a640c23a62f3a-b50aa48cbb6mr1956645266b.13.1760297054099;
        Sun, 12 Oct 2025 12:24:14 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:13 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: mripard@kernel.org,
	wens@csie.org
Cc: maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 29/30] drm/sun4i: vi_scaler: Find mixer from crtc
Date: Sun, 12 Oct 2025 21:23:29 +0200
Message-ID: <20251012192330.6903-30-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012192330.6903-1-jernej.skrabec@gmail.com>
References: <20251012192330.6903-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With "floating" planes in DE33, mixer can't be stored in layer structure
anymore. Find mixer using currently bound crtc.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index afe38ea03beb..4534998af825 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -13,6 +13,7 @@
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_probe_helper.h>
 
+#include "sun4i_crtc.h"
 #include "sun8i_csc.h"
 #include "sun8i_mixer.h"
 #include "sun8i_vi_layer.h"
@@ -62,8 +63,9 @@ static void sun8i_vi_layer_update_coord(struct sun8i_layer *layer,
 					struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
+	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(state->crtc);
+	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(scrtc->engine);
 	const struct drm_format_info *format = state->fb->format;
-	struct sun8i_mixer *mixer = layer->mixer;
 	u32 src_w, src_h, dst_w, dst_h;
 	u32 outsize, insize;
 	u32 hphase, vphase;
-- 
2.51.0


