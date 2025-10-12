Return-Path: <linux-kernel+bounces-849711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC35DBD0B87
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D163AB936
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C22FABFE;
	Sun, 12 Oct 2025 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY+cwhFF"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8152FAC1D
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297051; cv=none; b=MCnctnXyMGGOPAdU+SLIvAhhxVJKyDm265pPSClka/e7ku+1lN1cXUZDzZdCJaM8ZAvp/C1lIi5/064preWUdI/TZgrdm+TT3VqRr5cu4VpeeK6KFChGjRiBpfH50IlRPZ4qLARS9ptnQ169b451npXYXNfODK0EzTHIzQ5kONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297051; c=relaxed/simple;
	bh=2rEgqEZ2KuPdRGMl0QKQlefkIl3FEYhRSxtjPD2zq0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyD1e9EToX3j5YYKWxAPZoygdH3AuGhWNPq4xmVxe4fIE0+jAG6jTxo/p5hMc3EOZZCA14vPZgZaxtbGjHFWav8bJlsE5FPcf9WvyHCxLUPf++9tQSiQm3BdkTaXONgg3Mpao/ZWdXMEvZdCZntLwLh1e2Q6rY1dV2HAlskBmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY+cwhFF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b4539dddd99so728714266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297045; x=1760901845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08VhihKvGZOzCvy6uNWRiLafS0nfxwn+0WLCtxZhCew=;
        b=QY+cwhFF/wKnizLOv+WnYCFbodxqSOzV27q744UD8kZpf6jzVSgucbyHVI50fmfYcG
         OHL5s4/5ynXQeGuhPlXXfXnbcVzrDIdDmbPJ3RjPXC0jrv+quI6u1lC6shI8qLzGkkDn
         j3ULvsUpYMgbpH7exnOgQGHfRatGfJl+9xUq4DsGUApQjvlxLbHtwKFufEVPNaMcaSCJ
         kk8A1pUcPWLyLDacPS6i+Bz0o7Qdb+E69pSfF31toW8uZl8MFHofz8mM0/5GwzsgR19E
         x/oM3i4AUA2YW2bg9Oh7dv4s6RamkEe0Kmvhxcn5ULp/zMK9o3CYa56K8O9PgI/ERRt4
         Fq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297045; x=1760901845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08VhihKvGZOzCvy6uNWRiLafS0nfxwn+0WLCtxZhCew=;
        b=PViJthBlytEkzYh61VoL3h75M1j4+dXc7errG6QFlRhpSGJaAgAL7qyP+PuW72L7/O
         zf40YWCv+MDdVYiJj7W+GhQuLu4zEkGygHZnqpeY4JC4mDbCH8GzVXtMHzeXr/w9pwDs
         /ctNIbFtQOkXbMY2illxB+v426mMOPPIqqc8Vxut9B5QtzoaV8VWf2z2/xUgB259c6gY
         IZa7rwc035212eeR/UuqDZyjAAOFd1Rgr1zbdhGXfbJokrQWz7koZoHsDakXnUFTf7Xm
         DHueN21VlsT426Sf3+zTof/Ql43dNmT+YU4/uugmrGNf4GZPafQPHpylU9HHz0w93XQP
         1cPA==
X-Forwarded-Encrypted: i=1; AJvYcCXUJLbw6dXUDUJfSJ0Y7U71fQ+WNYOSGzc5br5jETBd3YCGsR6P3pU127UVmQjhm4NJBtKwE36lB85sVBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNJgOZuA4w6JzLi4QJ2N3KAShGndsnJfaqTSdNZJHkF6SA6/k
	GwNQyruFIN2vIqUVpp06mLMAha/bzemv98VH1+ub5UT6Tnj08dqOvp3W
X-Gm-Gg: ASbGncszMjhOKwMb2fy9Ie11YVmgT0QT/e+lRfJtqZIxLpGqYK9G1nL7ZgE6yFeaVrE
	3Uz0UApYwOKwmYoFsH6WUTywq2unLqbfwCReH2LTdZfOih5cQPjAm9O6j6hI0bwdPqv7bv8po6N
	8agcfKK1lTyilAWT8rLynoEp/ihNuzrod7TkmEqEcqH/UeJVzPLqqvwZa6TUNBU2RN9Ur8Z7Mq7
	cErIHNHCae7WZ2q6eOvJvMnMHlqcbIIBX4iXwnIQqdCPzr1zYr2FylUryN7I4BGpMvGxGudONCT
	KvwaDrg0CtH8+chtiKUyD5gsLoZvIF9xMvF/CDivQymbJqpCSDgdPFiTd138jbHNqkjU1DfnWGK
	WcoLbJmUlAJ2jDaT4jjnxPOuxuF0cp0hRn7mIFLqeStxpO7bdKS7D9CeAjWjoxaW7D/WyROLuX8
	pvGxfBiEFKEJegY0kzQdUvIS/44+s/xlk=
X-Google-Smtp-Source: AGHT+IHvhXW73NXWnN/w1+a157WT7XVAMC9an0CwaQWq1dgdtB3ecG7lOa+m5GizVxeaSFFM+lpHgA==
X-Received: by 2002:a17:906:dc90:b0:b41:873d:e21f with SMTP id a640c23a62f3a-b50aa292f1bmr2074832566b.18.1760297045043;
        Sun, 12 Oct 2025 12:24:05 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:04 -0700 (PDT)
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
Subject: [PATCH 21/30] drm/sun4i: csc: use layer arg instead of mixer
Date: Sun, 12 Oct 2025 21:23:21 +0200
Message-ID: <20251012192330.6903-22-jernej.skrabec@gmail.com>
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

Layer will be more universal, due to DE33 support.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c      | 10 +++++-----
 drivers/gpu/drm/sun4i/sun8i_csc.h      |  4 ++--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/sun8i_csc.c
index ac7b62adc7df..c371e94b95bd 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -227,22 +227,22 @@ static u32 sun8i_csc_get_mode(struct drm_plane_state *state)
 	}
 }
 
-void sun8i_csc_config(struct sun8i_mixer *mixer, int layer,
+void sun8i_csc_config(struct sun8i_layer *layer,
 		      struct drm_plane_state *state)
 {
 	u32 mode = sun8i_csc_get_mode(state);
 	u32 base;
 
-	if (mixer->cfg->de_type == SUN8I_MIXER_DE3) {
-		sun8i_de3_ccsc_setup(mixer->engine.regs, layer,
+	if (layer->mixer->cfg->de_type == SUN8I_MIXER_DE3) {
+		sun8i_de3_ccsc_setup(layer->regs, layer->channel,
 				     mode, state->color_encoding,
 				     state->color_range);
 		return;
 	}
 
-	base = ccsc_base[mixer->cfg->ccsc][layer];
+	base = ccsc_base[layer->mixer->cfg->ccsc][layer->channel];
 
-	sun8i_csc_setup(mixer->engine.regs, base,
+	sun8i_csc_setup(layer->regs, base,
 			mode, state->color_encoding,
 			state->color_range);
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.h b/drivers/gpu/drm/sun4i/sun8i_csc.h
index ce921521aaca..2a4b79599610 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.h
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.h
@@ -9,7 +9,7 @@
 #include <drm/drm_color_mgmt.h>
 
 struct drm_plane_state;
-struct sun8i_mixer;
+struct sun8i_layer;
 
 /* VI channel CSC units offsets */
 #define CCSC00_OFFSET 0xAA050
@@ -23,7 +23,7 @@ struct sun8i_mixer;
 
 #define SUN8I_CSC_CTRL_EN		BIT(0)
 
-void sun8i_csc_config(struct sun8i_mixer *mixer, int layer,
+void sun8i_csc_config(struct sun8i_layer *layer,
 		      struct drm_plane_state *state);
 
 #endif
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 2290c983e177..4f0c929faf36 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -301,7 +301,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 
 	sun8i_vi_layer_update_attributes(layer, plane);
 	sun8i_vi_layer_update_coord(layer, plane);
-	sun8i_csc_config(layer->mixer, layer->channel, new_state);
+	sun8i_csc_config(layer, new_state);
 	sun8i_vi_layer_update_buffer(layer, plane);
 }
 
-- 
2.51.0


