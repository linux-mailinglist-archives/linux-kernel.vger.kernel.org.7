Return-Path: <linux-kernel+bounces-885316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0EDC32916
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E83394EC6DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD74333EB10;
	Tue,  4 Nov 2025 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN6xKaFi"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782743446D7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279828; cv=none; b=re30dBNOjvV89lS9B2Gf/UfJs0H881t4WdIXf2oE41oNriY6AvBxSngfelbU302t67fdsfYKIV/f/kL645nOehv9C1+Y0/KWaDgXXunTkDCsKJ01Mfk2OSbBNnzvxnto0rpBt5xnIsrg4ZUL7mfUld/NEIVEPtCHQo2FZRFga24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279828; c=relaxed/simple;
	bh=dY6ZcTDLzk7IJaQR+fODPFvXrCrNpXJ/qB5JCNXGZaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8gMDe+Yb+z3HE7HO9lUewy4Y9ECc9WJWZDUPLDDcu3rmmol0vnnahJCb6+nCM+GV8foBplasPuIWRcWy0SPAb9UNUqCo3RpN8ZxD/B2YRI9BpRPCp5vAos0WgPevBU4+7rxkEQRgZ1ZypM/+z8f1yy1rYU+UF1GEKrR+kHqVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DN6xKaFi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477563bcaacso7270695e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279825; x=1762884625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tlXBSuCi9KYqEnYaWJPbYjWr/O8PttsygtENhT9s58=;
        b=DN6xKaFiXnl+cTVCVOOX03/IIfiH/qply6E/D6pkr9QjFrRCMAT45wKaP4wjLEdr6D
         +q/CLtoFmZhC1Y0Ym9ZoLOip23ZSIHfRpokHkz8e6IijKqY9eGdnVWuEY36xSpKiQN7X
         Gx3uzAlJTGZATwVDvT178D5R2M1nhRst+4fo9GOtDgw7J6Ydutp+4RLjNXnacDhnK34O
         ye2EpZd2b3kltnumgLkCxlLbVUUmyanIRzwWDeD1XJ+slTIpdLd9E/dNykxkbmj+NyE2
         Yn1klWLM1vkuNWm3DxG/VWdqlZCX8qucve5/ClkBuEzA6GqWBZZnfBZTHk/yLuDKj8Ur
         wocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279825; x=1762884625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tlXBSuCi9KYqEnYaWJPbYjWr/O8PttsygtENhT9s58=;
        b=L9wYlghxP5B2PcFeGQDO7BrEy4XXAfF3XZ3+QplAHuZCHIHPlf8oD8zdpIMurTrs8L
         mQEoMniGe+T7b8ttj4tYPGOAegDaliFCulxdeGsU3vhC03DfPFrhBV9Xu4XtMuvMmFkq
         wEJJq7P+qj8xuLbsGGvtSCAy6BP5k43E+o1JVNouZ/6EIBVTRM5hEZInPz7gC4b2JWgT
         4edXUOQblXM4rG+2bM37Rre4aCmjb/5uZlZ/Bst4uFZjhr0hrpF8pm/BSLc1y8i/4jFu
         9UOoz5FPBTM49Mage/TOvsm+JmPf7J1OdZNZJ0d37XZ21TpBzDESx7RVuk1An4bjVGGw
         uP/A==
X-Forwarded-Encrypted: i=1; AJvYcCUQjLPVvmGVnZG/bwJ3muQHDSES6MCEmdxkApSAxOb9re+ShNv4Wa9M3Ulk2+c41HR165rWzZyg9+7w9lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0lrB4WEu+dJrrRd/GOKQWHmYTEwTpARh7QiWoYH02hDYMnFQA
	82S027CELUaEPsQoC9UKG6L9O81Basb6d4JtMLwgwfyW/MbhTBmExPa6
X-Gm-Gg: ASbGncv4or0M5XBaEavl1NXzO0x8khY1VIYk7nyCyhmG94C2+vnwprHYYKNK+lGfkY6
	iMzahwRMPCW+84iSKQ1FoaB+mxraMxCuN8+08T5RaROIc7GghYwWEg+W/HPg/h9GsjOd/NK8nw/
	0eflbM0MzGpg23ReaBeySVayrYyeMOxJwv3730fY7kGo+XWdvWlRQLyhcA8q59VyWyZ0J/YY5ur
	aulpYXLv3Xb4ADn3bj4Nx65apqhcJpRV5/oa31A70GbsOvgXq03vNPmm0Ptzvj/LbQYinZnOsEv
	N4xvfHUPQde2AfepS/WqRwQNMNF9fAelJVtUf2c+u/a1XQMg+wdTqIeY+vPAboPpweysiJzAbUw
	iiayutQVM/57FxUkt0qZ5UvbFQhR2wy3VtDGRfx16KS5omwLgf1xgXSz6T0ZhD3Scq9x0k1v3iC
	s1Hq+sLFyUkVny+aAQDQ==
X-Google-Smtp-Source: AGHT+IHm1TAQjaSzwnbLWrmSeHCsVmHtk5JoxXFn6C5ye+q9ij6rKyMSLmT96AnudZeM+B1bys7ikA==
X-Received: by 2002:a05:600c:34d5:b0:471:1306:aa0f with SMTP id 5b1f17b1804b1-4775ce8df34mr2008325e9.38.1762279824672;
        Tue, 04 Nov 2025 10:10:24 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:24 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v2 18/30] drm/sun4i: ui_scaler: use layer instead of mixer for args
Date: Tue,  4 Nov 2025 19:09:30 +0100
Message-ID: <20251104180942.61538-19-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104180942.61538-1-jernej.skrabec@gmail.com>
References: <20251104180942.61538-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Layer related peripherals should take layer struct as a input. This
looks cleaner and also necessary for proper DE33 support later.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c  |  9 ++++-----
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c | 14 ++++++++------
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index d5b7241acdea..9b938e3dae9c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -109,17 +109,16 @@ static void sun8i_ui_layer_update_coord(struct sun8i_layer *layer,
 					      state->fb->format);
 			sun8i_vi_scaler_enable(mixer, layer->channel, true);
 		} else {
-			sun8i_ui_scaler_setup(mixer, layer->channel, src_w, src_h,
-					      dst_w, dst_h, hscale, vscale,
-					      hphase, vphase);
-			sun8i_ui_scaler_enable(mixer, layer->channel, true);
+			sun8i_ui_scaler_setup(layer, src_w, src_h, dst_w, dst_h,
+					      hscale, vscale, hphase, vphase);
+			sun8i_ui_scaler_enable(layer, true);
 		}
 	} else {
 		DRM_DEBUG_DRIVER("HW scaling is not needed\n");
 		if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
 			sun8i_vi_scaler_enable(mixer, layer->channel, false);
 		else
-			sun8i_ui_scaler_enable(mixer, layer->channel, false);
+			sun8i_ui_scaler_enable(layer, false);
 	}
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
index 8b7a58e27517..fcd72c4fd49a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
@@ -127,14 +127,15 @@ static int sun8i_ui_scaler_coef_index(unsigned int step)
 	}
 }
 
-void sun8i_ui_scaler_enable(struct sun8i_mixer *mixer, int layer, bool enable)
+void sun8i_ui_scaler_enable(struct sun8i_layer *layer, bool enable)
 {
+	struct sun8i_mixer *mixer = layer->mixer;
 	u32 val, base;
 
-	if (WARN_ON(layer < mixer->cfg->vi_num))
+	if (WARN_ON(layer->channel < mixer->cfg->vi_num))
 		return;
 
-	base = sun8i_ui_scaler_base(mixer, layer);
+	base = sun8i_ui_scaler_base(mixer, layer->channel);
 
 	if (enable)
 		val = SUN8I_SCALER_GSU_CTRL_EN |
@@ -145,18 +146,19 @@ void sun8i_ui_scaler_enable(struct sun8i_mixer *mixer, int layer, bool enable)
 	regmap_write(mixer->engine.regs, SUN8I_SCALER_GSU_CTRL(base), val);
 }
 
-void sun8i_ui_scaler_setup(struct sun8i_mixer *mixer, int layer,
+void sun8i_ui_scaler_setup(struct sun8i_layer *layer,
 			   u32 src_w, u32 src_h, u32 dst_w, u32 dst_h,
 			   u32 hscale, u32 vscale, u32 hphase, u32 vphase)
 {
+	struct sun8i_mixer *mixer = layer->mixer;
 	u32 insize, outsize;
 	int i, offset;
 	u32 base;
 
-	if (WARN_ON(layer < mixer->cfg->vi_num))
+	if (WARN_ON(layer->channel < mixer->cfg->vi_num))
 		return;
 
-	base = sun8i_ui_scaler_base(mixer, layer);
+	base = sun8i_ui_scaler_base(mixer, layer->channel);
 
 	hphase <<= SUN8I_UI_SCALER_PHASE_FRAC - 16;
 	vphase <<= SUN8I_UI_SCALER_PHASE_FRAC - 16;
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h
index 1ef4bd6f2718..872d88a58e7e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h
@@ -35,8 +35,8 @@
 #define SUN8I_SCALER_GSU_CTRL_EN		BIT(0)
 #define SUN8I_SCALER_GSU_CTRL_COEFF_RDY		BIT(4)
 
-void sun8i_ui_scaler_enable(struct sun8i_mixer *mixer, int layer, bool enable);
-void sun8i_ui_scaler_setup(struct sun8i_mixer *mixer, int layer,
+void sun8i_ui_scaler_enable(struct sun8i_layer *layer, bool enable);
+void sun8i_ui_scaler_setup(struct sun8i_layer *layer,
 			   u32 src_w, u32 src_h, u32 dst_w, u32 dst_h,
 			   u32 hscale, u32 vscale, u32 hphase, u32 vphase);
 
-- 
2.51.2


