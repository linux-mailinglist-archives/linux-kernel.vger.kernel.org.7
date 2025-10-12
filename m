Return-Path: <linux-kernel+bounces-849693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79807BD0B3D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6601897BEB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033A34BA41;
	Sun, 12 Oct 2025 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnuvXYvo"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8CF2F1FDE
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297026; cv=none; b=MLrtrJgAI/d7yImDwch5kWswatBHCwoMtLhZ9BNL4xfSVDpr/79qfJXs1jD7aOrQJcy4HNiUD4gQPya1imUcDuvdH45Zz5wT6MNS1QzQ1yAvG6Bbp8F7mP1d2bR8B/T0RCqff6SFDY95GvDS5tRMOPASGRlrPXbW+0LvEmAXulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297026; c=relaxed/simple;
	bh=tT1h4I4+dPWk/KoNyiQ6dHE5u1ti8FQV1X36C3i1/1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTUbHE7UZem1yPZzjOGcylSZpL/j/kZJ4g9QausYSSQBLTJOGOB9I3JKhjPVKidA1AzN6eIHCUqWftHm7jeZIQkj/4ZlUrmFfGVdSiN5zgQlJJjQfoV0VHNVCU3UDxSDSAp8A4cZZcd522SXligE7g/f9Iy7f/f87oM8xVd1zqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnuvXYvo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b54f55a290cso469274266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297023; x=1760901823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/RwR7PkAt08sGqCqdeSYXHmOvdiEO3Sen57EH3VrWU=;
        b=UnuvXYvom0pJjdqxwvZHen/BkFZs9m9bfn3juK/L4R7sucVPPb8fMkgvbTUYXqcB+U
         LR13s2h6j9LBKSodjs/KvRE69EJqrxToz5o8Xdgsyv4kw4+82Az9hYHu4E0dlPG4Encf
         X8QaSeb5PYJpVrfUN/jCobZJh61FBHA+wGSVnQ1HYBQc37hCqt40hqnuL74MmCxyuhK3
         drtPOqAgg59KU0F441InNhs3vOeIhAZuw2BZathsD+fI6HCi/wPVbM+UzZudReyE5TkW
         jGlhTMgjMwpBvAh0Qgvyga3Cwmrm90JoLDL/LWpOPLUaaZNK+VWAU7yVRLYncSwjm7sL
         gZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297023; x=1760901823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/RwR7PkAt08sGqCqdeSYXHmOvdiEO3Sen57EH3VrWU=;
        b=KA+8fXxnQqp4dDZOG0mcHSy7FaDRfYiwxGqf9e/aCjo9pYwBtDf06O6UnhIJ0GICQW
         6Jx/XSEtrOVBK1otLLSLDExZsatf0KFhd0HQllnSCWw/kLSk7cbz0Z+9bx1tQtPsahEF
         k+9atv/eBlcfU3QfUDIANpXRJU0G8NH89/p2jyJKNwNHjRbs/XBQDGtMkkzrVJU4GjbI
         l+edZ/eaiww+1B2gvTmMu6JsYaPve4sPcztAF65ECqT78tBzrK5Zq2a2BI3r/U1lOJ+h
         gS8QlFviOvf/52RT7GZxK3Aj8XCIcF/+tu8ggn1wft7nLTgpS4TK6PDESbuuqd+IsO5P
         JE4A==
X-Forwarded-Encrypted: i=1; AJvYcCWwYSCN8lXFfHoz8yWFr8G8LFYW3WLqWRQt6QA2F+DutPQy5bICfNvhMpI09Ta7+vCIz8HOjTn96VgZxVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqbYEs6d5YY2Ak/2VkG4JsqN/DznSk8T3UNqOH8GUZoXOAlIHz
	7OlFvl57X5QOTeezMN4vNltOqKSQPjg0NB6JMtOGneVKdWP6UPlts50g
X-Gm-Gg: ASbGncul7AGIQPrD2iujAUN8heTohyw2Y0ReoyJPIrzupJuLwk8qAVceh8r9EQECC6e
	j0vxYTHBrLe7XByeMxqw21BKAxel4AI7+AgtltkYz5Qtka8zl12iFl3hCcoey0oZ/Tl88k55S/5
	vYxIPPXV1JCOe/HovdKpTvmpcGeRGsZF3ZqBaSAIf78YBqKkbt0MvRuPPbo7BmIi0CBsIkXZxg+
	54KwC4wEElcflWIs8yT4oWokY0MKJcNvKKFCs9EV1AncAln5hQFYwZouxgJPFHt9Kz6JQq+GJ12
	9/QN0X+6bhhkOuvFLeQPEbWR/uZw5DQFufWWWWuVXxrUxS8Cycz6Xe7mCFGpbgARIfDR0fkHVSR
	8FKTZbykElhbXbhAwG4fo8oQ2wJq/7KdfW+x479xBdzVlKToYhAMaeyLOj0Gay0JfXQa6QQRCIS
	6jORSgy5Qi1NqEAIWMFmG/PxJEWiVb5FI=
X-Google-Smtp-Source: AGHT+IFr7DIU5+0XZbE3hR+c44DsyFKY1NvkxnYeQndJ+rW32FEQNP/zDp5N5Glq490y6QrN3W54Mw==
X-Received: by 2002:a17:907:c09:b0:b2b:63a9:223b with SMTP id a640c23a62f3a-b50ac1c5db0mr1978491866b.31.1760297023111;
        Sun, 12 Oct 2025 12:23:43 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:42 -0700 (PDT)
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
Subject: [PATCH 03/30] drm/sun4i: de2: Initialize layer fields earlier
Date: Sun, 12 Oct 2025 21:23:03 +0200
Message-ID: <20251012192330.6903-4-jernej.skrabec@gmail.com>
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

drm_universal_plane_init() can already call some callbacks, like
format_mod_supported, during initialization. Because of that, fields
should be initialized beforehand.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 9 +++++----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index f97be0040aab..9b786e5c7f3c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -304,6 +304,11 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
 
+	layer->mixer = mixer;
+	layer->type = SUN8I_LAYER_TYPE_UI;
+	layer->channel = channel;
+	layer->overlay = 0;
+
 	if (index == 0)
 		type = DRM_PLANE_TYPE_PRIMARY;
 
@@ -334,10 +339,6 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&layer->plane, &sun8i_ui_layer_helper_funcs);
-	layer->mixer = mixer;
-	layer->type = SUN8I_LAYER_TYPE_UI;
-	layer->channel = channel;
-	layer->overlay = 0;
 
 	return layer;
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index a09ee4097537..bd6c7915bbc4 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -485,6 +485,11 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
 
+	layer->mixer = mixer;
+	layer->type = SUN8I_LAYER_TYPE_VI;
+	layer->channel = index;
+	layer->overlay = 0;
+
 	if (mixer->cfg->de_type >= SUN8I_MIXER_DE3) {
 		formats = sun8i_vi_layer_de3_formats;
 		format_count = ARRAY_SIZE(sun8i_vi_layer_de3_formats);
@@ -543,10 +548,6 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&layer->plane, &sun8i_vi_layer_helper_funcs);
-	layer->mixer = mixer;
-	layer->type = SUN8I_LAYER_TYPE_VI;
-	layer->channel = index;
-	layer->overlay = 0;
 
 	return layer;
 }
-- 
2.51.0


