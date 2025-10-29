Return-Path: <linux-kernel+bounces-876198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2727DC1B219
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2856621CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FDB3469F7;
	Wed, 29 Oct 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ELl7iV1+"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72128C866
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744650; cv=none; b=Uh30eTRUITiN58Y3gAub9AoyrFiHucyW8Ngm7EVg1tlmOZnjFGAxGT33AZFNhLYReG9hjeGbSTwpu9bMLym9C4BFG35sGgOtOTIKHApeyWKpjA+iy68oug4RNdbRMJOrhobLvhkpcEqR7fNQpTZJBvZtX6fxk5wl2t1Sh+nC2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744650; c=relaxed/simple;
	bh=+Nk0u/KrijgE5zDh6uaPSGFr6ndPexSiMuF6ZPkPnok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxkhT20AcurSvTB9LYeqyR+kVDY/3p03sescImIUI2lA2Zlqn7+xA3ROr7oTNWQHHl+XeqxUxqqPZZrf/DAJvs8n/hyV8CM7CquQ0jjCut2DlAphOg7yfA1K5YZWygNaXiH7Y8QYuXpne+f7U60dwfWzfGMj1Fd53YuYZPH8KVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ELl7iV1+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 774B74E413CF;
	Wed, 29 Oct 2025 13:30:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4C5D8606E8;
	Wed, 29 Oct 2025 13:30:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3DA07117F80A3;
	Wed, 29 Oct 2025 14:30:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744646; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4muwKvrTXY2eKur3coogPiXaumR8M+FqVnR4hpQELAA=;
	b=ELl7iV1+daHOifJAnMDc4pNMnW5CcwlXHnySbbdrj52lKFr+AJoHzjsc2WG2yUZMljQBrK
	GMBYcqpkshSLzouXvxwNN2Cr1s12lI/F1+zEZlJsrZcXAYomQtbI0KKtHuL0BPUklsj0oz
	nXAfGpyEQ6M0MMnFu5DcvoKi61fapIMaCejRWoD9BUKXu7RlNkDoXtwlJq5hZGLYYlmbxt
	JaygWgm/ouz2T8DD1V1l100noTMMe2f+IyqkrfkOB1Q9kqvnteZRF2YzNVwF0L7U/enp7s
	jV266+CdPRXYN8n0AmABrj+x5ULIt+tV3mWFcok9AI2x16SebaNXrCqMgP9+cA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:23 +0100
Subject: [PATCH v2 13/32] drm/drm_color_mgmt: Expose
 drm_get_color_range_name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-13-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2153;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=+Nk0u/KrijgE5zDh6uaPSGFr6ndPexSiMuF6ZPkPnok=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbql1UMg6xHECN89J3YBGgKB0//neNYGL8C5
 KyjbqFLjkiJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6gAKCRAgrS7GWxAs
 4pmKD/9m6UU4Fet0eVOx7sd2PT6nCgZexnf0JWDttzBsf9+EA/Z6qVgnXgFy9g/cZNhLjRJvNhr
 pNOuDdpRaLSE4NoIDM+JFyhH5sIO1UCsVd2ZJpKAK9Hxf34kN01KeUhQdUfToMWK/LrVoNwbmQz
 3nQ2Nu7FQTd+Av4Q4RP4D46bbbXizFC456EjXVlHwGkK5hnBDjWOz24wxVguE5PKoINOVZT6fZO
 eY0wLIjnh+UmDFjjHYl6rq1pjZQgsw9q1wZB+zB4P0iz8coD7PRpQrwQBu4H/hJnVBpx6EXV7iW
 a983IKSyjOblL2d6Qu7PoBQI5tvk9j40K0Tp50+SJAMcImSjp9zBprKEy1vMQRTyJ+CwBRKH+Ps
 MmD5bnP8V3M3ZJXB3GIVHG/ydxrCzyfxths+PCsZTptEXPv11n8NSjzsMB1LeFfZnnOOa6wcZyb
 ZvG2O6a0FWWuB/5D7qEOmQ/JVRyyEzJJUqHN6zpuxBzTlH8NTbWmEvQznpTD3Q+gbE6EJd+/5al
 i5lwSYydeWTgfeewYP4zKQutDTVI1y7rLkfVc95RypixwewxDKGYBBNy2ih7M58Q94piDygwO69
 3mX60yW+p9vy4Z+z2BuYifGHvAvpuZy7kHf9H0Qoe8OKxGcjtxDLVveNwYIfujpCsWHWwd4Y+6E
 Ecl2DYC7RhVMVJg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

drm_get_color_range_name can be useful to print debugging information.
Export it so it could be used from VKMS.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_color_mgmt.c    | 2 +-
 drivers/gpu/drm/drm_crtc_internal.h | 4 ----
 include/drm/drm_color_mgmt.h        | 1 +
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index b0a3be3cc016..5b24b9843531 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -512,7 +512,7 @@ const char *drm_get_color_range_name(enum drm_color_range range)
 
 	return color_range_name[range];
 }
-EXPORT_SYMBOL_IF_KUNIT(drm_get_color_range_name);
+EXPORT_SYMBOL(drm_get_color_range_name);
 
 /**
  * drm_plane_create_color_properties - color encoding related plane properties
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 68fd5385917f..9141127a16ab 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -38,7 +38,6 @@
 #include <linux/err.h>
 #include <linux/types.h>
 
-enum drm_color_range;
 enum drm_connector_force;
 enum drm_mode_status;
 
@@ -119,9 +118,6 @@ int drm_mode_mmap_dumb_ioctl(struct drm_device *dev,
 int drm_mode_destroy_dumb_ioctl(struct drm_device *dev,
 				void *data, struct drm_file *file_priv);
 
-/* drm_color_mgmt.c */
-const char *drm_get_color_range_name(enum drm_color_range range);
-
 /* IOCTLs */
 int drm_mode_gamma_get_ioctl(struct drm_device *dev,
 			     void *data, struct drm_file *file_priv);
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index eb55bdd33f50..0d25b7d9cb29 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -86,6 +86,7 @@ enum drm_color_range {
 };
 
 const char *drm_get_color_encoding_name(enum drm_color_encoding encoding);
+const char *drm_get_color_range_name(enum drm_color_range range);
 
 int drm_plane_create_color_properties(struct drm_plane *plane,
 				      u32 supported_encodings,

-- 
2.51.0


