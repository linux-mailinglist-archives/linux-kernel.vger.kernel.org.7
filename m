Return-Path: <linux-kernel+bounces-841149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C83BB65A8
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DF642294A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28EB28BAAC;
	Fri,  3 Oct 2025 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuA9/B9I"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BA23AE9B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483168; cv=none; b=DiJGs3u/bkpSQsaeJJKOGQXJ01KMkwAXR/Jc9DSvUWTlIKPsrbKP+h7wUaBRnRoAfcXrcpn0X1Aq3HICVIorVGkQu09X9YsF3OaVdsejU2Fpd0Z/phb7BVoIb/iRTB0kdrH2iVrn/Dz2n0THoLvxoWNiD9ghbQSgfbbews8jQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483168; c=relaxed/simple;
	bh=mNmPuCOnPxXj+qpseCxd3YXfqpseTdW9amhH+O1sgsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F6gmrpcT2kTnJu853xGFriZ4yJpK3eh0XMZ6bR4LGVn+lYWMkddZ25pPAUhIAg+FXtA9YCEoHnnKw6WorBMVE/hPzc/FQ5S2UiSUFRYGChIZqakJCwCZW6tvIWh68F2zmfJ9/S0OCNkF8BzJC7Bx0ASnGZUaLAmbwa2f7UAhbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuA9/B9I; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1724343a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759483166; x=1760087966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miqL2nfl182qCuGEXVN6/ipsxsc3oYfM7+xZ2WASv98=;
        b=RuA9/B9IbLHjHQLxjSmq82vQOFmcbROaqdW3ZdV/hdZRcdtEKqHkf/wEqA+MIKApun
         NN7S5ZN+nR1m5DpKOvFzSieIbkSnAw9p1VoZepIbm4Fm/ZAWPpLNQRAhZOJk+Z+YCqzP
         QfjRwskd1iWpOkvDeZqnuTuvyPshHVzAD2O5pFMBS2bcAjJk/FHAZaT5uN9+6qDbqzuf
         0KPI2GFSeYGm0QvX45OlLv52VSEcb7iuD7HokQY0pIh2Rpg/UAffwcmF/fCakLQStvFD
         GbfIzQsbjqf5b16537P2leSXbR8ndxLNV9UROAED8+fwxX7WotwkLugpaeXI6+vUS4t7
         L+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483166; x=1760087966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miqL2nfl182qCuGEXVN6/ipsxsc3oYfM7+xZ2WASv98=;
        b=qZpzL9NjJHL0ZSwQ6IcsKQ7SOnRr20P+vMkMOtwNokrAy5pEQUggMRIG9+bua17Tos
         AVEie2FA3uSzl1T9ENP6XoAOQ9FiFgfL+m1984IKokEvgjR1MxSdBEqovzB6NoOX4RZB
         Cm57iDv8SR7DHyDY613zsngklcDexZM2/bVFAvm0rZdgQcjcm+T6APzJ/Ik2aBijVLEx
         H2Jkk7LsuOy7pzJBGB1ySScxkrBlwrjva8fcoeUaPkLrubAt0JbODWJqmO2kyW6GRrPE
         +48dshVkOwmKbpucREDi4U/pDxG/Ie0GO6jVpVrvgt/T05UtGxfhbeb7cBGZ9D05OY7Q
         e3mw==
X-Forwarded-Encrypted: i=1; AJvYcCVlBq7MA3Y6eqTZYXw4oz6tiW/xYk9Ewc0X3aL/yC8Ezy4L5YWlNPukLo1xKUul9schZA16YrO00hi/hLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdsiPFnpHBUcV5n/+Qzk+1N0sWi4y7hhtpWsuO4ey0a2lCuX7z
	RYYcoyDH+01Kl+oE0ReYHxFTuHHxchqbopd4eCPCOBSQpSqbg7GtWK1q
X-Gm-Gg: ASbGnctn1O5B17npUScncTqBesDgH85UuyEnTJn4QGDeURHF/BLydNlnpMk6b9OisnN
	LBmV5ZrNlUuNTIGl4Phbt/OFNvGl6ZO1XnjEc4XVkQyHJdBjozRLLlWYKIJ9sX0drScoeHKAb1f
	+PNfJym8oe0Yiw8owBluSwTTSp8+ymHnN3KjsxRe3sG+QuIU4lthZly704b+82Xf4OFzgNEqbpz
	HAe0k5tcESidSZrEdjfGspg9840WtQ1lTX9hwOce/HbGDASzYhW9M6D0fwU1vACuObTMpXRoZCz
	QLvXVrSGQktuvmdfE5DXs5Vc7Rfpbat8M79hVunQmggkIYj6i10AYkqKwALeIL/Ml41FqgNLfGk
	X+5mcyIW2ubCVC7cgjhVbSRfqOBD4vM65r8eCha+ZvxAo4F3XtO62GcSjrkwhKFLlzWfMco99k0
	GBwvWV/kpOyFl0QlnnKg==
X-Google-Smtp-Source: AGHT+IHP7V42K1exHHhwAiEhcgdXPEeqQhKkdSrZzwIjkiTs7OXyRTUQVua0JfktO63AZYNNUNjXIg==
X-Received: by 2002:a17:90b:314e:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-339c279740amr3104240a91.23.1759483165790;
        Fri, 03 Oct 2025 02:19:25 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399bc02e5bsm4164019a91.0.2025.10.03.02.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:19:25 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org
Cc: rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	tessolveupstream@gmail.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bridge: ti-sn65dsi83: Fix LVDS output configuration
Date: Fri,  3 Oct 2025 14:49:11 +0530
Message-Id: <20251003091911.3269073-2-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003091911.3269073-1-tessolveupstream@gmail.com>
References: <20251003091911.3269073-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the SN65DSI83 bridge driver to improve LVDS output
stability and correctness:

- Program additional device registers during initialization to ensure
   proper LVDS configuration.
- Adjust the DSI mode_flags to match the recommended settings.

Both changes are based on guidance from TI SN65DSI83 experts, addressing
cases where the existing driver configuration was insufficient.

Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 033c44326552..d6a2b20be1fe 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -613,6 +613,20 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 		     mode->hsync_start - mode->hdisplay);
 	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_FRONT_PORCH,
 		     mode->vsync_start - mode->vdisplay);
+
+	regmap_write(ctx->regmap, 0x0A, 0x05);
+	regmap_write(ctx->regmap, 0x0D, 0x00);
+	regmap_write(ctx->regmap, 0x12, 0x53);
+	regmap_write(ctx->regmap, 0x18, 0x6f);
+	regmap_write(ctx->regmap, 0x19, 0x00);
+	regmap_write(ctx->regmap, 0x24, 0x00);
+	regmap_write(ctx->regmap, 0x25, 0x00);
+	regmap_write(ctx->regmap, 0x2c, 0x10);
+	regmap_write(ctx->regmap, 0x34, 0x28);
+	regmap_write(ctx->regmap, 0x36, 0x00);
+	regmap_write(ctx->regmap, 0x38, 0x00);
+	regmap_write(ctx->regmap, 0x3A, 0x00);
+
 	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN, 0x00);
 
 	/* Enable PLL */
@@ -912,9 +926,7 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
 
 	dsi->lanes = dsi_lanes;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
-			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
-- 
2.34.1


