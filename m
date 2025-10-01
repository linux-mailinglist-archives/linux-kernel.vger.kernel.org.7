Return-Path: <linux-kernel+bounces-838938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 790CFBB0780
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4F02A1D40
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3444B2EE272;
	Wed,  1 Oct 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Xyl9dMFe"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4B2ED86E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324974; cv=none; b=AHaDGCZsU9czTcWrQPyJUMO5a9j0uFbUi8DC0xbEZpynY2/OzIj/WRR2UfwVHMm/xZDkFiVD6RoNqaXgESZlVprdKJ5G+UEkN5Vae1QGvgujeI7wWDiG+PS6jEg76t7UzLrNoap0bbCE8jq5VB4F7GBbWkYXMGxf3zQcJQwg0Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324974; c=relaxed/simple;
	bh=uIGQvyZwk+SENa1rKilXdvCrak68avgX0mLHz7Whqjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FmDgBY6NcL6yLeTx4OVxj3n9BuG0RxK5nD0tPnV3E9bvuG5LXldsoDjpmlnfD7Jo93lFktBCunqkdRAxvkt4WD7sgvXee/gnpkBLlyBsENRiH7HKYd+BttTh44Rz5rXhNm+jRXp6UrDHzi267i0g+eTrEo7N040t8IIslldtLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Xyl9dMFe; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89B3ABCA;
	Wed,  1 Oct 2025 15:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324880;
	bh=uIGQvyZwk+SENa1rKilXdvCrak68avgX0mLHz7Whqjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xyl9dMFeNqNijshnI628IsAxhBWEN/8NKEQj9jx/4fB+AFeZOLJUDRT0A4BB002/x
	 Ufob8gkD4xxlLRu3STmKEi3USvbPCjzHLmMbYwLxtKRNrISFMXhsPBwA2sbsB7oVEc
	 T9ifdLgZ+rJ60t6l8UPxk4xpsenplEJI+fP/Qqhs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 01 Oct 2025 16:22:15 +0300
Subject: [PATCH v6 03/11] drm/fourcc: Add DRM_FORMAT_Y8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-xilinx-formats-v6-3-014b076b542a@ideasonboard.com>
References: <20251001-xilinx-formats-v6-0-014b076b542a@ideasonboard.com>
In-Reply-To: <20251001-xilinx-formats-v6-0-014b076b542a@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Pekka Paalanen <ppaalanen@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=uIGQvyZwk+SENa1rKilXdvCrak68avgX0mLHz7Whqjs=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3SshYRcGKlRly9F/Rzom0aKceYfC2slnUQzmf
 wS7VEDVX1aJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rIQAKCRD6PaqMvJYe
 9YiZD/94m6ljg9nQKaW0OHIfxd74e1ULPRxy8WK8G6PxotcOC4qSKXGTPDN/BhgPYzWg0Wc9Agq
 tB9/4XkpqC15eIVmKYacZDBaxl1CIJN0QoY2JdSF2SCjMH3csY0ccP71K8ZEUIzFdsUoybk7s/E
 Q6NQ54uGtGPryrux2RulX8D4FKggEFmL0PFrSbKKcgV3UJF+B31h5IVzzWSLnZjdZC8jzOwA0r9
 OvBMuTd035L7UL31Mv3HTMj//t0Q74y5zfunuxHAwKUAvZYH2xg2bt1KGMpu206X4l+KFCAM4fd
 rctl46xYbr+RLp/EreK9pRegln2L3PsEbaSyZT7XMyE8zPheI/JN1Ds+PzjGDMwqYZJmBvlXu5w
 7ed7iXZB7NmGA2nmnWvKlDGq2BNlZtjHL8ui6cY8yLbJGpir69ofa3RCjq7koQlKJSoIAsp1HmT
 TXHzI74d7UPU250mI/Qju6dZic9mTb1WM4nb33CKWLkx8p1DEJ0Dr8l2H7GOw37LEnxTEtNRUew
 xyAvMP4d9VxWCkISVu/K6I2527Cp1h8ZTK1/6tOc4s61KRTOU9x4/ovd2BlLhznnd/Ehrs+FnRz
 RkRo1wtR94quhzyHVQ9ZvU0SGQJquaFs7LBq8cqfoRLv640H+zIop+fSLcPwBrj79miZvnE25Nt
 Nj1wDwpRYNxMiHg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add greyscale Y8 format.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  |  1 +
 include/uapi/drm/drm_fourcc.h | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index b22ef86428a1..a39b9d7a5b62 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -275,6 +275,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_YVU422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_YUV444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_YVU444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_Y8,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV12,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV21,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV16,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 2ba8808fe0d2..a08f900ea2c3 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -459,6 +459,16 @@ extern "C" {
 #define DRM_FORMAT_YUV444	fourcc_code('Y', 'U', '2', '4') /* non-subsampled Cb (1) and Cr (2) planes */
 #define DRM_FORMAT_YVU444	fourcc_code('Y', 'V', '2', '4') /* non-subsampled Cr (1) and Cb (2) planes */
 
+/*
+ * Y-only (greyscale) formats
+ *
+ * The Y-only formats are handled similarly to the YCbCr formats in the display
+ * pipeline, with the Cb and Cr implicitly neutral (0.0 in nominal values). This
+ * also means that COLOR_RANGE property applies to the Y-only formats.
+ *
+ */
+
+#define DRM_FORMAT_Y8		fourcc_code('G', 'R', 'E', 'Y')  /* 8-bit Y-only */
 
 /*
  * Format Modifiers:

-- 
2.43.0


