Return-Path: <linux-kernel+bounces-849708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54564BD0B7E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787503A4E6E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01A2F261B;
	Sun, 12 Oct 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy5WxRbL"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843882FABFB
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297046; cv=none; b=iCR4Rbsbjw8exJKjSZgDt7ar1prAzrnLZonRtnxT8t5xkyvF6pDNWc9I80N6NdFoxjf/wq9zj8uGOFDvmgkoyWLnAkfEPDn6waDLI8nfAdtnfMDNaLAoDh7a7lvQb8Q5h9aEj4COd7dDmwRIbHg4wMl8ioR5K7AXkQvT9dho90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297046; c=relaxed/simple;
	bh=104h35l/DchpohDTQvOcPAlK0/ZZNw6ykSs+tKAkpg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFLBYh1iPxPQbDrp0f8tZnqZI08VfYuSIThAX7LP07BF2ZfL6X09Imja1CO7XZPCRZDcU27OCc60IJ7Ca3YufMjdjqvV9vfadry8d2wfq4f7qG2qQFJUACg8FUCQB/bjJBB6syMOXQOkUXnBFwLTO+CD8oDt6/gBYgkldAdQmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy5WxRbL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e44f22f15so514475266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297042; x=1760901842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWJm6Ru2WyONf5Yro6jfwB0WobfTQWEzjnSYauNm30E=;
        b=gy5WxRbL3f4EPzFC9Iizxud9fO0LZuKdmgJL5Rjwb290vEt1kOsXnUheRQi0TsY3W+
         sw3Tgxhb6zJ2UEPyEitnqVMf6NX1eFDrGzKxxPPTIPoW1ivZEJJd2hvGszbhWjbf+mVD
         5+Hl1jnX+QIjCR08er0YStlJrQwoQg7N4QWYPKvKtaJYQLBD455nHZ1qaKbNcNs5li/4
         J1dft1vKW3mZAaAwxCIToYF9xspOJ2dT7zr8dnziKTEmOBfUWZ3mwfEINCleXqSZjvX6
         c3ZdzaETa9zkdoHbn0SWebjkmIvbo7V0LN2ebaoRHVkAmfZwqbFcSrGWjHZ1CnVsjR1s
         poEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297042; x=1760901842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWJm6Ru2WyONf5Yro6jfwB0WobfTQWEzjnSYauNm30E=;
        b=coivWOIMDkp0+/ZEsMxZb7HF8HVT0LdO0sidPKSkITPrxyfdsLNDUoFalqXRaN1HOK
         LDu0r78fWUDO3Qc54eZ2vyViSoaxzfE+1DmgnSSuPI4yFuOjtwjPny0+fMKXt5/vnU9A
         +pzf2u072FOvb+GYFm3s27ycYBBkxpEzUB8luJ931/mlk8UiFbPnVa+b8yh7bfJmWwQk
         p2yBCY/5aLyJNMY3LM/aFW7vcnM0JpHhYrYgTXi2v3iM0ShS7B+5EhI7gGz/fxBG+K6p
         Feg7UbbFqBFvJ5QGSMt0+ouXR1rKi4kRJ7DS4UNdtJx3q55TUe3hNzjFJSsVJunTEQpR
         xIGA==
X-Forwarded-Encrypted: i=1; AJvYcCUJmVWHhFmuyByQTzYiMTxU1ZQUzEJaASKHU2wtAoyC6FN4zzccQC22gaMufGC4j2d9r+3vJ5sUImkGyl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62/lvLRlikUuIQRVaAToImSCdcsMs5RF2Nd8kdZsGtKUlQ16V
	qpuFvsuvCaSzi8qb+FFEjNUSc+Ds4L1Xf9Ondcsru00vI5/OAnsW/IAA
X-Gm-Gg: ASbGncv9K3wHIR2m5XQk0g61EZ9JkodiEKjPWdVAnp3PAkvkGkel+RWjwciYf9jkSAR
	L8txZvEj+qRScI8MhzA2V+kAW0gqKSBFQ+NlSAc0dC4cByRr2s6rb9iffw7gzxZJ0nANhC2cCxw
	yljIvH9WxZ/0Quabj+k5MHivGk42neqqrK/ul26UIxr9uktlU3gRXoPZ/K4J4E5E+XxXljZ+qO8
	AztKnaEO8zq6Aez7nO8f1P1ppsQdiJAmVPQZskE3SaH0P7jZu4r/R0wjxXVP+/SkCx+2xc0pZaE
	Vcv/glTZFKK7TGvAbeTKLWqlCCkTBa8uPlsmTh7ca8CS34dLquOW5e2xU9pKQVmMdLjWS2Wgz3D
	1JN8r3E3Zyp455CXrtiRpp3BtBnOqxAL+bepWQoGDlBXktU7Xzc3fILmBb31SlXz2QEymoww3nh
	fKxa9w7GeoTPWFw4uU7miE
X-Google-Smtp-Source: AGHT+IFB2WPpLvhhyF6jFh1SDHHRriNhPzMUznraEeE598jcJE65TAjpsOVtaGxdtE1HPt1fjYbNLA==
X-Received: by 2002:a17:906:7312:b0:b57:78fa:db40 with SMTP id a640c23a62f3a-b5778fae354mr614837566b.46.1760297041514;
        Sun, 12 Oct 2025 12:24:01 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:01 -0700 (PDT)
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
Subject: [PATCH 18/30] drm/sun4i: ui_scaler: use layer instead of mixer for args
Date: Sun, 12 Oct 2025 21:23:18 +0200
Message-ID: <20251012192330.6903-19-jernej.skrabec@gmail.com>
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

Layer related peripherals should take layer struct as a input. This
looks cleaner and also necessary for proper DE33 support later.

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
2.51.0


