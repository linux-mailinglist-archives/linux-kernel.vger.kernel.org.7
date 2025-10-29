Return-Path: <linux-kernel+bounces-876203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A36EC1B2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A8C461694
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE0334AB1F;
	Wed, 29 Oct 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ASZ5Zlsx"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7449229A9F9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744659; cv=none; b=tmDYQ0Y4/Cof9+zZF6xJl7jZ0+trpbwyrUatAm+IFTHjr2c9N5DPkbZS/QAxjmkoiVvFyr4hoOCYZEJFmKLW9/9siyKqetgrXOWthFtxUZHy8gy75mSQ92dOnjKFmIskMVj487s5of9E4BKJh3oa/4Gz/LQBLT4URzYX+HNUnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744659; c=relaxed/simple;
	bh=rnZm7r0xEd9LrIvetwHGtyd26t99JexCbu1jReAcAkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z51u9f+zE2apIWL9OE52FQktHOwLchLZvSwo4CRXKSGPavafL27qdH9j+q6tTUsfS2pqzSMWDhGJPcAr6k7nmpPIaDPG4GdSoWcAf1FMi6cFpk8P8epCR44ys9tr5SymVMzvzuRb241knzoTRbW+XzlrfLRctPUp71DNCpi2+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ASZ5Zlsx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0CD5F4E413CE;
	Wed, 29 Oct 2025 13:30:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D51A4606E8;
	Wed, 29 Oct 2025 13:30:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED79C117F809B;
	Wed, 29 Oct 2025 14:30:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744655; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wuzcvgdxKucfzXi8j9im5vi/vTJhBZGMa5n+dwDEVE8=;
	b=ASZ5Zlsx4A0Y/RcACYw3dQWnbPKhYPnCJqDmprrPg709u8mwkGDgXs0dUiQ4ivlm0cnD6B
	RDsgnhpY9nlkxtMauuDjJ6PAdC4LgCYy6oZsFebyZ4O5cEa8g90Nrv/VlyX7USlf39xXfA
	lGuQQaAsIHxpqQeZms4aKIVOTiA5pLAsBzSTqiG4FwQC4B9RQtvUmgGp8yRWYwMB+1Adhi
	JEt2JLNW4bLF/MlgDL2FrlpYiIZGWQvM0VU4OcUtY/w5cfsTrcig1NkYZpaa8gRgRxDGUH
	ID6xOrjAKcCDRygEW13YmH5n6cjjnKLxSRo+H370TdvZuEbQcqhX/ZSh77Z5pg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:28 +0100
Subject: [PATCH v2 18/32] drm/vkms: Properly render plane using their zpos
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-18-be20b9bf146e@bootlin.com>
References: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
In-Reply-To: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
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
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbr5Et15Lks27W8MDhnUIKB9p1+Dwhs8Ene2
 hoCdZOSIfmJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6wAKCRAgrS7GWxAs
 4rzKD/4ijWYQu1vkdHRqzD+m7+lRrQKc6YHLy4CkzlgfJsvTyTC+sporUwIWM+bqPw077FEa+rS
 R+fD8hInSc/Pj6MhLLBhpb6nC1zM6SI2nWUjW0JeE9kWruRMLE7eG1kD2uVoWLoLvlbMNYZTSFQ
 j65v2xSQF+C6WZ74WoovlzytXaWDmBdt9+5r+TGj9AHLgMRxUd1DGdhCt628osgiJRcVnYMfDJo
 JfEj59KO505PHJs1L/PglfpjWwrvfIi9xrF7YTnWRPqXjrF/BGApJ1b98XUAGpvogVmLAcU/FxK
 sINMakhPCvlI/Q2cdYzSzdp38B5Y+dx6QycdeQ952m3Nf6gYQsa7oZNrTXBIYGrym4AlK5D/QYU
 isLeQpm7yOZBgIz/lkucfGSWYJbKx+urH7eGzHkAcSzCoxANahE55aHYj9SHUOq3toqlp3jr5xS
 qH2l5XHSU4TjeQb2wqya1QCscbdEk7ntCOGC/i7CfHlZ8qHEJUFjD5J16R8bp0QquddzWBGnlQG
 BhoqxMQMte1wuC2p8EQMrfuRZn4pVjM1afimDsqKIdrc3LJXCgg4fwmD+pq/0ksKZyijsPDtECB
 qwT3/VaTstvybWfIDRlJtZ+0promJP6RlWLCqVyEEKfWpCiIHCWtm+ibNI9FcwkjTHpXz1SViaO
 wMrfj2j7ZQC36fg==
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


