Return-Path: <linux-kernel+bounces-805372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA2EB487BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AC33C0516
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B4B1F8EEC;
	Mon,  8 Sep 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9LLqOB6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B92EF675
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322241; cv=none; b=jR9Leq4Qae+Akh8WmByXT65ADhDE98p9z+WEkP0yf+0dVSepqVccS7CNWEO/93gOTyUbrz9mm3pJtzBUeFB7AcSXrvSQSGshjeAAWK+KOqwKmjN18RBxMye6A8It3OLOUSoYf73BWtyKssOi5kepemqSqPOeIiTRVFcTOLV9jL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322241; c=relaxed/simple;
	bh=vPVI36ukM/Jq0am/HgD0hAXC6elfkRj6PkYOhAkPO4s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7XydlZXg2K/jWvUFFTClerKglHKAzZNWg5im9EAiF7QVifetSJqlKUZ/ztV97Gb1bGvUZu3nbHgMqn7zH4Y5htFi+rHeHFkkUbw40UJA5+siqlauA/57+N/ZryAC+b4MPqWYjLlfCWGkgXD6cWMw/NS9pvvLvrNqO6rMD3mQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9LLqOB6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757322238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZiAhmyFaEKVq6s3K9ByIEa1k2zTn1HXQWc3GKVxQxE=;
	b=S9LLqOB6V8f3SQUBR2TIxqVZJx/xDx5U1N6iZQM8eWpP5ZXQUoX63QLVDIRaY8G7KujoNc
	8t3SdhroOys5BcNiqB9zGlpm1P+aSrJzKenGGbZU9n0XsTIYDM+bDbdtJUGxP0w3H291ac
	AIabZlMxQI6r/BuvkUTWepPaPjKH5K0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-cOzpdao8PPSI8vZdUIlqNA-1; Mon,
 08 Sep 2025 05:03:55 -0400
X-MC-Unique: cOzpdao8PPSI8vZdUIlqNA-1
X-Mimecast-MFC-AGG-ID: cOzpdao8PPSI8vZdUIlqNA_1757322233
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63C411800343;
	Mon,  8 Sep 2025 09:03:53 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.33.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 565781800452;
	Mon,  8 Sep 2025 09:03:50 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/3] drm/panic: Rename draw_panic_static_* to draw_panic_screen_*
Date: Mon,  8 Sep 2025 11:00:29 +0200
Message-ID: <20250908090341.762049-2-jfalempe@redhat.com>
In-Reply-To: <20250908090341.762049-1-jfalempe@redhat.com>
References: <20250908090341.762049-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

I called them "static" because the panic screen is drawn only once,
but this can be confused with the static meaning in C.
Also remove some unnecessary braces in draw_panic_dispatch().
No functionnal change.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 1d6312fa1429..1e06e3a18d09 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -437,7 +437,7 @@ static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *
 				   fg_color);
 }
 
-static void draw_panic_static_user(struct drm_scanout_buffer *sb)
+static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
 {
 	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
 						    sb->format->format);
@@ -506,7 +506,7 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
  * Draw the kmsg buffer to the screen, starting from the youngest message at the bottom,
  * and going up until reaching the top of the screen.
  */
-static void draw_panic_static_kmsg(struct drm_scanout_buffer *sb)
+static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 {
 	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
 						    sb->format->format);
@@ -694,7 +694,7 @@ static int drm_panic_get_qr_code(u8 **qr_image)
 /*
  * Draw the panic message at the center of the screen, with a QR Code
  */
-static int _draw_panic_static_qr_code(struct drm_scanout_buffer *sb)
+static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 {
 	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
 						    sb->format->format);
@@ -759,15 +759,15 @@ static int _draw_panic_static_qr_code(struct drm_scanout_buffer *sb)
 	return 0;
 }
 
-static void draw_panic_static_qr_code(struct drm_scanout_buffer *sb)
+static void draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 {
-	if (_draw_panic_static_qr_code(sb))
-		draw_panic_static_user(sb);
+	if (_draw_panic_screen_qr_code(sb))
+		draw_panic_screen_user(sb);
 }
 #else
-static void draw_panic_static_qr_code(struct drm_scanout_buffer *sb)
+static void draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 {
-	draw_panic_static_user(sb);
+	draw_panic_screen_user(sb);
 }
 
 static void drm_panic_qr_init(void) {};
@@ -790,13 +790,12 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
 
 static void draw_panic_dispatch(struct drm_scanout_buffer *sb)
 {
-	if (!strcmp(drm_panic_screen, "kmsg")) {
-		draw_panic_static_kmsg(sb);
-	} else if (!strcmp(drm_panic_screen, "qr_code")) {
-		draw_panic_static_qr_code(sb);
-	} else {
-		draw_panic_static_user(sb);
-	}
+	if (!strcmp(drm_panic_screen, "kmsg"))
+		draw_panic_screen_kmsg(sb);
+	else if (!strcmp(drm_panic_screen, "qr_code"))
+		draw_panic_screen_qr_code(sb);
+	else
+		draw_panic_screen_user(sb);
 }
 
 static void drm_panic_set_description(const char *description)
-- 
2.51.0


