Return-Path: <linux-kernel+bounces-876381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD0C1B55D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A211A231EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A12632571B;
	Wed, 29 Oct 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EDWUhscX"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB213112C9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748637; cv=none; b=FMVRc2ikaxQuz8LzMUMU1ZBWzeG1kVir9v98amN1oubmf3RFDo8GyvNvtm1qERb8oGo7uRlbbdCCUVnkeuTalaG99bs0GDb7jtCwaBFj0g/9JbprvwOg2hqw7K1ifzGm5SxszvhnBzVi+7LRBgvppeJ9fJoxIyI/Toe/cJUurmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748637; c=relaxed/simple;
	bh=+Nk0u/KrijgE5zDh6uaPSGFr6ndPexSiMuF6ZPkPnok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkT+vXUR4t3nYK7/y7Z6Q9QtqgsdBELLpvkRZQPB+h7gGKLaBJwizbup7BTWcyun2QzX2KHCczWJrwEYXQx30Tl2Dgy3m5ubaHLbKOLY/lieFHrgri/qOUU6xpOm3bX2YBL3g7GI1SNYZDC7f4pLeMsh+hpiEW6Kgt22f4yYR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EDWUhscX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9CF9E4E413D1;
	Wed, 29 Oct 2025 14:37:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 71F1360709;
	Wed, 29 Oct 2025 14:37:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1EAA4117F81B9;
	Wed, 29 Oct 2025 15:37:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748633; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4muwKvrTXY2eKur3coogPiXaumR8M+FqVnR4hpQELAA=;
	b=EDWUhscXdXDvNLLoepyby051Xj28ZKJDfWr6LLkLzUuZwA5HOPwDHulxNs1Hw01DYeujuL
	Nv3pX+4PcvYlwj+fLAjYNDM/gf+GZJrJlc4l47wwZKqCGTa0kJkTF/UOKezHA3VdPx3AYi
	tZmt/VBVOGBKM1D1pphQ+TtB0jgP2VunTLWqC1DxcFu55DuFPE1jEZU5l3SzaYRYHlF1+4
	lioz9ahcGcf6SVuul916Y+iIVxC0iCY3yPCu1A5OggZ6PSYGkNClmV9ZSWk88Y17HJGsDU
	bOZA0T2xt6AHEV1qJMo1sx59aQUmfnrv34T2podY5hE2YCrO63clME3cqVeKDw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:50 +0100
Subject: [PATCH RESEND v2 13/32] drm/drm_color_mgmt: Expose
 drm_get_color_range_name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-13-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2153;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=+Nk0u/KrijgE5zDh6uaPSGFr6ndPexSiMuF6ZPkPnok=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ7uZTqk2sqraOa5CFkOLQa25qfigWrgKY1e
 6wHWMUX37CJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImewAKCRAgrS7GWxAs
 4ndND/9clbGq8hMf9D5YRcm83d2Y8HP1EXP4YsCVpdmiVJfVe89loPnhO5GxCid2U32oXtkx9Oq
 0sEe5bzAICdK1du4fEeU6P/FePeWJ6raAXN5SMoq8OME2d9JOEQEvzcXIwOpQRUKtr7aRwaR49T
 Rglp76scaZzB4OTqvWENGou//H7WWzFinNdmLPYsDSBypmLgbep6C/rKhhmwGbKbg6PDfX01tJw
 YYDEi1gGx9QjpvwMVv6gJaz1cfgsOb/NtZW/ESoLsTmaTdUrVP28jifHx02oPMBNv4/vCmfMLfw
 8/I+WU5oplHSKhqPkRFZIlpuUEtaPXCYNpfqZrWt/vQeC+fpqvXwl36gQByETXunc25GaEEhSXO
 ZOTeHMKcITiPGLEaaArr0VQox0tfBPRg+DGUjjzxJ2ocXGlFdT0WwF/4iCui5WWXWe6SB1+Zbal
 h0z+DmNL3dMeJax93j4t2NiEMY5uQqla5B66oFaz11sai/ruOg9E19ceyLdkDBRBurrtvoD2Gcu
 1cemOJAP0FlXx8kT+oCkplwu9OUi64R5s56OIRISpnejjeBSN5Sh/d5qx4hLp4vq96MEx4PEnov
 tmn0soAoVmwn1GDLviWUbtjzf1WVjuwDRs/KVBcy6tK6Z7ToEOQRSazrdgFQAt58tPxjY3veaoz
 UsSW1GbPf6+CQPA==
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


