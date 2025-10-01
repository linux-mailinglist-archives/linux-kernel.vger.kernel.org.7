Return-Path: <linux-kernel+bounces-838939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372FABB0783
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F1C2A1F32
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BD82EC564;
	Wed,  1 Oct 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OEeuObYv"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC22ED86F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324974; cv=none; b=pRPpp+TYL/4PjbOh5Fnrnns9fDdsXji3ZzGZ++HO8DCZLggcDzDzFN47bkNNH2HkiLYlUiZsRkEG+tSKPUIr3ya2ZnL5TgUX+mGYg1qydy8Z+eS4wr+Gx2zdMmPpJEDCgbuWmyLZn8EzHj+oY6RHXZM2ItFumCiLmDKK5nqQtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324974; c=relaxed/simple;
	bh=OsW+fEwD6a+YJ18lCNu4EcJQlW1SlX7K7fHS3fOL1tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDLIBLc5nICGEO59uOqaRbqdmrcfVe51k8nQy7ILgLUedLQDchWB1FCfurqBHIudgakmwxTqTh3Ljbm6EE0HvXykhYyNqXH/aqHTSnMxlYcsM5b9CHskEOgU9RtTtodKI0H6uH94IbPMNDnhcX1v1rwOk0f7NeK0o0gLmgnrzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OEeuObYv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7FDDF669;
	Wed,  1 Oct 2025 15:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324879;
	bh=OsW+fEwD6a+YJ18lCNu4EcJQlW1SlX7K7fHS3fOL1tA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OEeuObYvTPX8FZ70S2XJFC35vrQVrVkcVSSw+Zb3BlY9dMMvU6gazpPAx45ITsAZ/
	 ZWPpavHHdcqsdDEg7DDjC3ls8puGCrbT7K5fgCxRXHTMUjykiE29JMO+J8QfJ/5dlA
	 +qwUNN0NdGkMlOrCsmyDxGZG1E3vNJN6sYyicvHw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 01 Oct 2025 16:22:14 +0300
Subject: [PATCH v6 02/11] drm/fourcc: Add DRM_FORMAT_XV15/XV20
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-xilinx-formats-v6-2-014b076b542a@ideasonboard.com>
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
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=OsW+fEwD6a+YJ18lCNu4EcJQlW1SlX7K7fHS3fOL1tA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3SshruI2cqpdJFUPZXbfmo4594o/rWIg4cp5M
 Hyc/Is0YWGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rIQAKCRD6PaqMvJYe
 9ZktEACfEc632w4+HGhT0iTTDWmKcPDH16WYg2m8jYCclA4vVEpPHDIroJSZa2AppUYjvJYfHFJ
 s6xVfBD/XgpVwLfZqxWMBsi0DfAsH6piYjXtQ3ez1zGDzn6Jx/FjX8hbZtx9WztOm+vo0W+le3B
 QGL1SNNh2nszL3xg0lGP04eVL8WGjJ23YMUgsd7h5i0VHXbkfXaMA1+FlYjt0bJgt2FqZkgwdqm
 3NouordsNYSGAWA48IwYsHbZfSEOnoMtB3UkpxTMFagBcpF3p53tOZEsJm8KD+1AQbOt2QpfjT7
 5daPpPxkpZXBEdB3PC1FR/+GWEihB+e7z5/2IKJ/6rRaFOM7P4UE/x8L6UYzIztTseU57D1HeRv
 Mf/PmTR8i2l5GPrWabWWB3PNtFbTCy7BYyIIJhHcQ8k8rCtRMqHEV7erfy69CXZ+FHwr/dfoTgW
 Xymnn3NQfb96XPckZjifGzO9Xu48mOoUT2hYmva5vHB4yCoitND6i3NsmJGSB6rWGnC4uNnqInC
 OEivxwdEfsWdEnw8QqazFgHd+zEWg89PID0As7ghFlzUd1YhgOIqIpr+hGfhOcHvTr+5zCG11z/
 1qMUm5ar3ARZCqZUmol2quLgrUT5yGEIuP8OwtNfdZgaD8iDwWFAxNl5P7p/hmytXZMdgi4fo0U
 J+t/mxMioYPTjgA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add two new pixel formats:

DRM_FORMAT_XV15 ("XV15")
DRM_FORMAT_XV20 ("XV20")

The formats are 2 plane 10 bit per component YCbCr, with the XV15 2x2
subsampled whereas XV20 is 2x1 subsampled.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 6 ++++++
 include/uapi/drm/drm_fourcc.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index e662aea9d105..b22ef86428a1 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -381,6 +381,12 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_S416,            .depth = 0,  .num_planes = 3,
 		  .char_per_block = { 2, 2, 2 }, .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 },
 		  .hsub = 1, .vsub = 1, .is_yuv = true},
+		{ .format = DRM_FORMAT_XV15,		.depth = 0,  .num_planes = 2,
+		  .char_per_block = { 4, 8, 0 }, .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 },
+		  .hsub = 2, .vsub = 2, .is_yuv = true },
+		{ .format = DRM_FORMAT_XV20,		.depth = 0,  .num_planes = 2,
+		  .char_per_block = { 4, 8, 0 }, .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 },
+		  .hsub = 2, .vsub = 1, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index ea91aa8afde9..2ba8808fe0d2 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -322,6 +322,14 @@ extern "C" {
 #define DRM_FORMAT_RGB565_A8	fourcc_code('R', '5', 'A', '8')
 #define DRM_FORMAT_BGR565_A8	fourcc_code('B', '5', 'A', '8')
 
+/*
+ * 2 plane 10 bit per component YCrCb
+ * index 0 = Y plane, [31:0] x:Y2:Y1:Y0 2:10:10:10 little endian
+ * index 1 = Cb:Cr plane, [63:0] x:Cr2:Cb2:Cr1:x:Cb1:Cr0:Cb0 2:10:10:10:2:10:10:10 little endian
+ */
+#define DRM_FORMAT_XV15		fourcc_code('X', 'V', '1', '5') /* 2x2 subsampled Cr:Cb plane 2:10:10:10 */
+#define DRM_FORMAT_XV20		fourcc_code('X', 'V', '2', '0') /* 2x1 subsampled Cr:Cb plane 2:10:10:10 */
+
 /*
  * 2 plane YCbCr
  * index 0 = Y plane, [7:0] Y

-- 
2.43.0


