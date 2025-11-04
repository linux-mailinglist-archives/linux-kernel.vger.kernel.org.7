Return-Path: <linux-kernel+bounces-885319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E8DC32925
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2209E4EEE2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B98346A1E;
	Tue,  4 Nov 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q73Ul6rA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33958345CC2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279832; cv=none; b=X6MEICn4oxNHIuoZRDIeOBUfLkQGMJR/YQz7HYwXlkfpaWmlm5t68oLAC+E27sA9IZ898F6rr7C/gxNdNdi+eqsSRZZC48GMGjzytokBtQvHj8f2Dz/JvZPaEvM8R+oi+8B4f0Doe4P1xEp8P+E7OdLLAmNnmKRwM8PugzahpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279832; c=relaxed/simple;
	bh=VFseA8+0asa6bmZbTX8OqhwqKLycWDdmZpgLOdy9Z7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OV787sJSvIwV7SHzyH55Nl9zoRInECVMqXOJXS+O3vuErxiP/Y1rngeFQpkHNSN0aSKTjsTlDyxODcGSOY3EQ54KroJBCc9t1+1CzhAmyIejnqmRpCS/WV7SBZhPTEAUNZkaR5NMjliULqPC+OTCB6J1hcvxCNHGARAgkV0px9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q73Ul6rA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47755a7652eso8492625e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279828; x=1762884628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxUKDaL1Q7bL2awForB4PNE5HPywXNIJXgBLrPAkKJk=;
        b=Q73Ul6rAi7S0QSb9ABR2l3VDj0M2Chk0hkEjKKAlDz0EaC2cjzL+AI9wLK9zZjBFfY
         YtST4mBRlTFnZ3HPs9m3At2mCuBMoujLKfElwmGkRTFNYpQ54CLcqYP9+t1/+7dK0bMo
         TI0bWZwNqMgo2LwtsNNaVgw4NrIz6fW6pHSTPy7VN+s4xzI7+Q/8frrO7xU/qzeSiOkV
         Bl5OaaYpAr7SEo0LKUcJ4DZ191IF0vpZLA+vYJM+mafpV/cK1RNwPBUPV5HpVhooRP/c
         qLG5GMRXrYbRAeUqyen9sHgDPC71xS9ir+UNw0o1QHZswKyhKEwuvVQaUuGaiWjTn1N1
         fy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279828; x=1762884628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxUKDaL1Q7bL2awForB4PNE5HPywXNIJXgBLrPAkKJk=;
        b=YzO/2qbzSpzYCwoguNJ3Rbec3wlVjXZAKE0C52E85PkoGGCyWIuMKaymIXFDP6SEjR
         K2HLAnLMZK7npNtXu1ZQqTUMpcwi0Fmm9r3iuPj6DlWGO7mlFIu3GmJ/exuZ40BsFy65
         2kyr4gQpbeMNVP7lsofKmRaScL8hUxsBpPr4+Fs7TdQG1bB8Hk6ZBDOUrAuGSM8iygBY
         vBgDfR/YCgN7zbM0O6DJ2L4WewBsB22ypY/hkRspbqngppdlu8H8dRphhbQQbzNiQX7V
         RdXziDNv8RRc31XeHeWJAK69TiWA4VEJWhe7G8x/al+fzXmiqsQWtwZT1b5+lBm8NH5s
         KeZg==
X-Forwarded-Encrypted: i=1; AJvYcCVWuyXTTUFfODh9dRdHMAOY1+fj5fBbbUBeZXmJVfdmZUhGqQnTXIsYtiGuISBE0ucul6QhjCG4MtcLbF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExS9wmLKhZAvf5NN76302odVLid7u3r4d6mAbTFBOwY2QxJt8
	T7M11WlVZ0xQ9AbrwUjnNOaZKJjKgJ63QlSmW3eFpaE/2S5d20dpeBxb
X-Gm-Gg: ASbGncvQhr4QetDw0H9NLWH5quHOfeVTEToZqPEqRYJYhFOeRMFnAHsZe0sOmiUsft8
	TC5B9YF5t1QPucfHenIuB/dKmog/wWV2aE5YTaqokdm3p21dKU9MMmPlQoWMh0y8XQxifuH/GXh
	JJvRNjllJslegXLMn69Wk5nJC6kXleOr/mxGOK9sBsbi742tA3TIuVOt65VarL0VR8J225QV0ih
	46i49eCbtA/UnenXK9bcXvO/TGdkbupCFmIDolmgEGUtVNE0orgxMcgja79Ziclj590j7pBwX8I
	gpIDjBMMnUj4IVxF1tOjOiTTnBXj3QFJ/jUn3veMrYTlp+O5n6gZc2Sj6r61cHwoFY8SqMQX+/d
	TQcNFLwnYfRLma+KUX63YHP+h17OkdGUa75aU7lMs+M4mlVg2ejagHocjwlzmn2LrDSkE43s/NK
	SuQE/MhcjYvmXm+jKxw2ENM6/B0UMd
X-Google-Smtp-Source: AGHT+IF5c8+mHZzz90mVXQjinbLLHXZDEwGQ66eyEvr+K8f4HxTWYfLZ4fwJ/Z+IpDrhmhZsMsoK/A==
X-Received: by 2002:a05:600c:64cd:b0:475:d917:7218 with SMTP id 5b1f17b1804b1-4775ce7df88mr2080215e9.36.1762279828376;
        Tue, 04 Nov 2025 10:10:28 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:28 -0800 (PST)
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
Subject: [PATCH v2 21/30] drm/sun4i: csc: use layer arg instead of mixer
Date: Tue,  4 Nov 2025 19:09:33 +0100
Message-ID: <20251104180942.61538-22-jernej.skrabec@gmail.com>
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

Layer will be more universal, due to DE33 support.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
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
2.51.2


