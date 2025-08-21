Return-Path: <linux-kernel+bounces-779479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46135B2F4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 215004E1BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353E62DFA3B;
	Thu, 21 Aug 2025 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRmQn5im"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D592DAFC7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769967; cv=none; b=pljXcU2Ofb55Mz8PdvHHWuQs/QlFNcVjnFW6FIBD7muz0/P2Vbq2Px6bYKwBreXH8miPQXeDHA98hbfo/fSYY24far624irKdDT6W4y1YU0k/rbU1TpYnSj2MkOhVEZPxen61dcI4WLOamyj7KzCo1iPwCtYma1skbPwYuoz0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769967; c=relaxed/simple;
	bh=5OYGRPbTF7OQtS3BfhI0g4Y4h93HCUlmBzYKZQ4ZRws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pg2tleSnqVOAYsTqkNrgazpFoDzSAKNfroexdScnNfk/Cd4ZJzv+LemS+jib1OSp04IcX3//Zu4zVYCpzxRTVwVvaiVoxm8xwENONpfB0xyEZYMmpMWfvvQ88qnMqlIEPGnEqGyPioHfSoRCJX3qOtJe9T8zdXORSYZnyMhSUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRmQn5im; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755769965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iAm/zvI0Eff2wE9jd/ydPFKoAPLPkgSyf/zQO1N1E4=;
	b=KRmQn5imQVpxFOyXd0ZhkqVd4So1GHly7WaxRloD92RmYlmRLVxBDaVWRVswWqaBHPto16
	gmrR/lIwx87JYcCyJAKovlcVRW0TojS6lKMu9PtdK1pLepKgJ8eBXEjqTNTMIUalmRCGNx
	RBjYIHXkIigTiL2ZZRgFrSxzkLJJEXo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-i8PxERLhON2CMRY71zdtwQ-1; Thu,
 21 Aug 2025 05:52:41 -0400
X-MC-Unique: i8PxERLhON2CMRY71zdtwQ-1
X-Mimecast-MFC-AGG-ID: i8PxERLhON2CMRY71zdtwQ_1755769959
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8810919560B0;
	Thu, 21 Aug 2025 09:52:39 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.33.118])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D41B197768D;
	Thu, 21 Aug 2025 09:52:36 +0000 (UTC)
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
Subject: [PATCH 1/3] drm/panic: Rename draw_panic_static_* to draw_panic_screen_*
Date: Thu, 21 Aug 2025 11:49:05 +0200
Message-ID: <20250821095228.648156-2-jfalempe@redhat.com>
In-Reply-To: <20250821095228.648156-1-jfalempe@redhat.com>
References: <20250821095228.648156-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
2.50.1


