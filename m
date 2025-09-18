Return-Path: <linux-kernel+bounces-821845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235D4B826ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35201C22793
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2641F5413;
	Thu, 18 Sep 2025 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gMnWRuD1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE201386C9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156338; cv=none; b=ss9JfDbJrG9lA0b9dWvHRthATbCXjSIj3NnHfoIi2ja1XhX/phOEmSZHv57kpV+/tT3d22kXSJArf4g+wWdVliysXn+rSs5pN76CA58Y1huWWiOwOnfzJB4r8/HrGXrGso6bILa817Jr89dDcfRvMsCw4GhvbleBJSqIu4qimgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156338; c=relaxed/simple;
	bh=63UDJCYYZKejAD7rK2QDvVeqxIbIk1HH1HrY2XmPNcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bx/3ijFQCIvsKBHSL41vNmysM/wQhDpqr+PGQ+vL8ULz6YYqjrm/ZKT1Wa+OUhsGGmhAQDO3+s10f0eqAyUrfolKn94tq7dwcyGXj5D0C/LWQ8I4iZ/B52jL6AaBFMU1zOwUXakX/BnPVu6SE/WwSutp0lfUWpKBh9MZOo+jxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gMnWRuD1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758156334;
	bh=63UDJCYYZKejAD7rK2QDvVeqxIbIk1HH1HrY2XmPNcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gMnWRuD1d7y9DpYWtVcKimU7+BVJRWJcbw0dTD7po+g0dP72VKp94T1tb4BJsX0TO
	 9lbZBqZKrFzfVK1g+nTfEw0l7aWzHtbFvViS6jYG1O1KCYyzKE11qp5MpOwSvMo3Gi
	 1rwLkXcU4PJ4FdUFNf6CpJdxNKK0al9RiUciQe4J3r50qM6eJTXxVbE+jL3Sb7pGnl
	 oCdMnWBVl3XsFgBDj1VssPOZjHYwhBI3VQ0TlX9bGtEx/ySw1og6NR/hN3oTcqSauY
	 NPYeERo7HpawHISGmsgH0kosefSYvZiQyQK+pwqZEejdWN2gQWXCmQHdpzjzlX0nd+
	 340M0jWplCqhw==
Received: from [127.0.1.1] (unknown [IPv6:2600:4041:5b1a:9400:62f0:406e:ac79:4a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE29617E13B2;
	Thu, 18 Sep 2025 02:45:27 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 17 Sep 2025 20:43:27 -0400
Subject: [PATCH RFC v2 18/20] drm/vkms: Prepare pre_blend_color_transform()
 for post-blend pipelines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-mtk-post-blend-color-pipeline-v2-18-ac4471b44758@collabora.com>
References: <20250917-mtk-post-blend-color-pipeline-v2-0-ac4471b44758@collabora.com>
In-Reply-To: <20250917-mtk-post-blend-color-pipeline-v2-0-ac4471b44758@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Alex Hung <alex.hung@amd.com>, wayland-devel@lists.freedesktop.org, 
 harry.wentland@amd.com, leo.liu@amd.com, ville.syrjala@linux.intel.com, 
 pekka.paalanen@collabora.com, contact@emersion.fr, mwen@igalia.com, 
 jadahl@redhat.com, sebastian.wick@redhat.com, shashank.sharma@amd.com, 
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, 
 xaver.hugl@gmail.com, victoria@system76.com, uma.shankar@intel.com, 
 quic_naseer@quicinc.com, quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com, 
 marcan@marcan.st, Liviu.Dudau@arm.com, sashamcintosh@google.com, 
 chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com, 
 mcanal@igalia.com, kernel@collabora.com, daniels@collabora.com, 
 leandro.ribeiro@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.2

As a preparatory step for supporting post-blend color pipelines in VKMS,
rename pre_blend_color_transform() to color_transform() and make it take
the first colorop instead of a plane state, so it can be shared by both
pre- and post-blend color pipeline code paths.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 31b1dd3cd115d930ec3ed498403a8f44208d76c3..05e1551d6330e4dc14563d3a399b3544d11c6576 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -189,13 +189,13 @@ static void apply_colorop(struct pixel_argb_s32 *pixel, struct drm_colorop *colo
 	}
 }
 
-static void pre_blend_color_transform(const struct vkms_plane_state *plane_state,
-				      struct line_buffer *output_buffer)
+static void color_transform(struct drm_colorop *first_colorop,
+			    struct line_buffer *output_buffer)
 {
 	struct pixel_argb_s32 pixel;
 
 	for (size_t x = 0; x < output_buffer->n_pixels; x++) {
-		struct drm_colorop *colorop = plane_state->base.base.color_pipeline;
+		struct drm_colorop *colorop = first_colorop;
 
 		/*
 		 * Some operations, such as applying a BT709 encoding matrix,
@@ -449,7 +449,7 @@ static void blend_line(struct vkms_plane_state *current_plane, int y,
 	 */
 	current_plane->pixel_read_line(current_plane, src_x_start, src_y_start, direction,
 				       pixel_count, &stage_buffer->pixels[dst_x_start]);
-	pre_blend_color_transform(current_plane, stage_buffer);
+	color_transform(current_plane->base.base.color_pipeline, stage_buffer);
 	pre_mul_alpha_blend(stage_buffer, output_buffer,
 			    dst_x_start, pixel_count);
 }

-- 
2.50.1


