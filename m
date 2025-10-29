Return-Path: <linux-kernel+bounces-876386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DBEC1B5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2361A24486
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183B8338F54;
	Wed, 29 Oct 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wpwXU8Li"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852123358A6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748646; cv=none; b=c+xqKzf8JWb85o/R5bLyhXzDGTVVvYrxQEBFSkA9qOiFfJhjMVwiPB+zX/ZTdBim4qcC8xwsMkEUWff5MjPVYOKam1O3Ipor5wvSs0dD8FySJJ3wZJjb0TLjE6BV72FXOjjzaQdV0wYtivUJqCT3ab8ZDvuDvlG8JuMkAM1NMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748646; c=relaxed/simple;
	bh=rnZm7r0xEd9LrIvetwHGtyd26t99JexCbu1jReAcAkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ASC78Kd5Et+nYhD2PbAvjySUWic4DGtk+A91bc56OWZjGgf+Nny6e8Hr25rkEk3pXJ5eN4vR4Nbf8Lw8w/83xCm1nRElJ2NU9omGQuBaHjiDXHqj7ks5LHMnd56p/7iNKpdEybduLn13GUokwswVQ4B9Ne+31OdKD0fSURmIE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wpwXU8Li; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C653A4E413CD;
	Wed, 29 Oct 2025 14:37:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9D57E606E8;
	Wed, 29 Oct 2025 14:37:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3F3F117F81AF;
	Wed, 29 Oct 2025 15:37:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748641; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wuzcvgdxKucfzXi8j9im5vi/vTJhBZGMa5n+dwDEVE8=;
	b=wpwXU8Li2/6wN+XcWgPzVcZOQiH+n9oqv609Yka7wVMI0+znjXOocV7UxkALOoOv7QPCBn
	ecoE1pH7Mytoblv7WPVkZKm7d+1RVY0N3Xw/Zz9zMA3WggSUarkEvvtBXlJaeC8eLeDUDb
	QsR/1BumbB0fP5nt0yroKSfouYUUMs/h1N3DagWSUZoYbeTdrm65SU5Brqbdu5Jur9rp+R
	Tnc3zBzeEXYZsDcqpz/tXowJzLgTtRijG5IrmKb/clgNsLSyC8Jksufd+cGkdIiXfMt4mU
	LYdgM9AhhFD4C6aL21Nx1TouqZpq11xutXr4/BCpPAVlqc2XCJJGO6Y53jVUEA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:55 +0100
Subject: [PATCH RESEND v2 18/32] drm/vkms: Properly render plane using
 their zpos
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-18-a49a2d4cba26@bootlin.com>
References: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
In-Reply-To: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=rnZm7r0xEd9LrIvetwHGtyd26t99JexCbu1jReAcAkA=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ8bCaudyWE+A46e5tkBU4wtEm5i2Rcwx3CM
 dtYEjx2VhuJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImfAAKCRAgrS7GWxAs
 4ouSEAC+Az4FjpAq1CI4MetBO1K/TjVnfjMYKXHpb0KXMqNzNpKz6y5kFhL4fHqIxochAVYO+EQ
 4S7hBnTAoWTpuLJWxBrZnPhtB6XPcVTQat36SztGkgaAg/IlmJnGGswMKVbngD30fDGtE+GBi5x
 5oHqZSOZ96f2qT7c/eme3a0PYoKDu0o8V3G+z/veqc8Z/KQhiJqVibhBQxPmCzo0TLBrFU9JL8Y
 FUnVKiqmwtQsjXlOKcE6gbleXbOUYKxEkhDVFlo9tbF0Gbepo7OXqhgaKev48lJf1Sx+CzM77AK
 Tz4YkPEeCH7ix1QUJdmYULWVazQ1ZzY35hAABwfccE4ECc3CFhGFVdFzrnV4FpoW2inX0GkYRjN
 XFdiHiPc5gCXVGqcqnCogpJ0s9Dy+muPMyy7Dh8dLNDlY7dXUGK25PSxC7h0/wvhsi5iuvlBk3Q
 PSqlSlISIUUuyYLT8LDLckxzSOpUFGMHTfujwoSsAkvcqSjrhwxVppjE1PoZgITiGQF7aLNBY35
 Cx8Lq0lRlhTSVJkQr2qnJMO3DD4y7AFXkyhBeeZXjFZx0mB/tE/igHwnWdkK0yDwazM+SPcNhJ8
 MmX7EOW7hX61KulOeWZ7bHaP9AJyj0zvwnLTjaaa3rHBdvg9v01stAA110Y4R9OVDfiIZyZ3wNJ
 DhKHLt/tUShe+oQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Currently planes are rendered in creation order. This is not an issue, but
with the introduction of new zpos configuration, it is required to
properly render planes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index bac0790c6577..0524c47460fb 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -4,6 +4,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
@@ -141,14 +142,20 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 		return -ENOMEM;
 	vkms_state->num_active_planes = i;
 
-	i = 0;
+	ret = drm_atomic_normalize_zpos(crtc->dev, state);
+	if (ret)
+		return ret;
+
 	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
 		plane_state = drm_atomic_get_new_plane_state(crtc_state->state, plane);
 
 		if (!plane_state->visible)
 			continue;
 
-		vkms_state->active_planes[i++] =
+		// Order planes according to their normalized_zpos
+		// After drm_atomic_normalize_zpos, the possible values are 0..n_planes-1
+		// so store them using this index
+		vkms_state->active_planes[plane_state->normalized_zpos] =
 			to_vkms_plane_state(plane_state);
 	}
 

-- 
2.51.0


