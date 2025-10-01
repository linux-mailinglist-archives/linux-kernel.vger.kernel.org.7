Return-Path: <linux-kernel+bounces-838941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F7DBB078C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A32E2A37B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85842EFD95;
	Wed,  1 Oct 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="F8DBBgGC"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE42EF652
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324978; cv=none; b=eJbup4G4Lravx1jMXukEs+zqJKiNhPKQssAMcUF+BzAkJ7XyX/m9wIw8VjiWFhCnJuG7PIrOvwQCYcDAXs6ERZEUAqyRyR0s5hnt9BVqx13RcgfnetUm3G7sBR8TT8skngvDU1bJZ09iiKN3PRNcc6ylAYFEzH/2ugdwZuh+iPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324978; c=relaxed/simple;
	bh=XGJBxdhjI+9Q04mXj9KfwzrAY693U8tf4w8o/DovsCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BedeUIijztPFeptoYZr7x0xAB8a4P+ky4TFvgOYqmCKRV6hQY5L1qLHW6gQno+a45tjAGk0tOhBzSbsWt0v8Ft62ldOm3hCFHcn30yJ//CTuMw96AtM/yb7IkwFoEAcOQ61oHxcepVC0T9wtt+xl+b5y+zOoEycXYkCdzlJOzDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=F8DBBgGC; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9E92AEB4;
	Wed,  1 Oct 2025 15:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324881;
	bh=XGJBxdhjI+9Q04mXj9KfwzrAY693U8tf4w8o/DovsCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F8DBBgGCH/D/ShxL6BefSA4B7q/HTFu3pgBq6zfq8EJseCTV5YWjxJM0tHfTVhbUz
	 unqhYA7oHQoeac9/8t5uw73qExb/AwHJt2XHaKLh+ZU0N++DDfhkCTJ49D34KF4pTp
	 3xbaahlJelSiBZZmsck+AYQSUAFIyfQMOadUznbY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 01 Oct 2025 16:22:16 +0300
Subject: [PATCH v6 04/11] drm/fourcc: Add DRM_FORMAT_Y10_P32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-xilinx-formats-v6-4-014b076b542a@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=XGJBxdhjI+9Q04mXj9KfwzrAY693U8tf4w8o/DovsCE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3SshzdkJUDfXjyxn9ZTHd1tu5GDuV9WK9drgn
 vOrGLBCi2qJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rIQAKCRD6PaqMvJYe
 9QT2D/948DxIlZzibDFFxOjpG19jeXG1UTX/N/FYhWzru26N/rBPYVNbKTvfZjyMigtvDLAya9y
 O01/K/D3uXg14AEfLjHL/f6FpzZSUMzrc8eib4WGh6sFR4K5J3CLjzqdCiAHMfZSnNWNl5Bqvsu
 um6NKDPcVvS1673ECpyDIKLW5im4HJVoGfsW1A89HYCKIv7JDb72Odf0kKsA3lrUk3SZxaNAx6S
 BS/DEB7R2i194qT5NnyWQfZLdcywW/br0zQEbjnXJ8hCYtVZUVjiBVaMES60Sv5CNSt0MfQz1kL
 pGI0r8qKt/NY3A+3a2peGrStGf3WKuXxokfZUvUMVJrvaRqfEZfxt8jYjOuuHidd3+rtdVanpWU
 jSBRbiR/g8J9GpjDFYxjGfrxQI89zhHYq04H5OQobN683SVWUzHFIDlIeyL/shfw7Dc30u504IH
 sVMWer5ebtBPxCnGz57dLhRMt9Zn4SEKUH4w7C2K085BAxYlRMOBmd2DAIR0D5QRFKgG5cJCuMt
 NoJD/Ed/1gDwmkr2vMKdIVHDdCnZ3OklSco+aou6bl/74oXgYqKwfkQf7dy8/dEGNXiYLWjHkZE
 in1CX8qTI+gS6AJmmCKPfhhxICYXLSFegjwAPBSCz8GK4KqIeMSFGiuva0J6KRiQA0d7cIrkuze
 RuBlDr/EIr+iYog==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add Y10_P32, a 10 bit greyscale format, with 3 pixels packed into
32-bit container.

The fourcc for the format is 'YPA4', which comes from Y - Y only, P -
packed, A - 10 (as in 0xA), 4 - 4 bytes.

Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 3 +++
 include/uapi/drm/drm_fourcc.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index a39b9d7a5b62..0d222f6c1a30 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -388,6 +388,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_XV20,		.depth = 0,  .num_planes = 2,
 		  .char_per_block = { 4, 8, 0 }, .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 },
 		  .hsub = 2, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_Y10_P32,		.depth = 0,  .num_planes = 1,
+		  .char_per_block = { 4, 0, 0 }, .block_w = { 3, 0, 0 }, .block_h = { 1, 0, 0 },
+		  .hsub = 1, .vsub = 1, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index a08f900ea2c3..4754bb48e4c3 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -469,6 +469,7 @@ extern "C" {
  */
 
 #define DRM_FORMAT_Y8		fourcc_code('G', 'R', 'E', 'Y')  /* 8-bit Y-only */
+#define DRM_FORMAT_Y10_P32	fourcc_code('Y', 'P', 'A', '4')  /* [31:0] x:Y2:Y1:Y0 2:10:10:10 little endian */
 
 /*
  * Format Modifiers:

-- 
2.43.0


