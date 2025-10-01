Return-Path: <linux-kernel+bounces-838940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C3BB0786
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0892E1946265
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED732ED86F;
	Wed,  1 Oct 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AKeeWZse"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8712EE617
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324977; cv=none; b=bMuu7/ho7q1UnuRoQyAU1T1IU7rz4qmBAh7L+P1YxTsQvGSFB9NINVOtfDYSSdIZytucmO+1poFsxJEgpXNtdhpvZgdnoOFYdv1o2FN+RyMIvHzccnNVQ6IaGWPV0EFQJ31W7ROWo8iXGSFk0HDtjP6vSlI53LdO12dxRVBfvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324977; c=relaxed/simple;
	bh=t6T8bX8vVVnz3LIbbDD4xEvopZzG0dBgNUZvJ9LMSa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxW1AN2BdEi9L+VAzVWfQ27a/AwafZXSXuDAk1CQuUg7IOHlCI2ok/7Fp4+AyN1wFHjLTUZmVwHtg3Ia5b41VVEbxty3MYxyf/LPeReuHpGNxHPOp0P90VvBAx2eEI5gmYDZkUCv+vCh/WKNHDYgtYUkJyVC+3qOgCjsHYyI58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AKeeWZse; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C3C8E96;
	Wed,  1 Oct 2025 15:21:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324882;
	bh=t6T8bX8vVVnz3LIbbDD4xEvopZzG0dBgNUZvJ9LMSa8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AKeeWZse9sqgkzl7YGEsCuSWRygX///AlmNTa6UYNOot/diXlkBy+gma99PkaIWnQ
	 VLV/9gRXVh+VgEW9bsx4qTrAALOpueBufEeIGIDQioIzNNhHiqZeBZ3vgM0xk0cY4S
	 Eie/P1PehMg0Cw9b0puFI3aJkrEjCCb/knif+yeY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 01 Oct 2025 16:22:17 +0300
Subject: [PATCH v6 05/11] drm/fourcc: Add DRM_FORMAT_X403
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-xilinx-formats-v6-5-014b076b542a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=t6T8bX8vVVnz3LIbbDD4xEvopZzG0dBgNUZvJ9LMSa8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3Ssijm6NcN+RRA5sDBjmksBBoPa/ZWSKlYnZD
 R0LCSu5BWmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rIgAKCRD6PaqMvJYe
 9cInD/4hPZRiNeTWF9oV8gR9og08cBu6wAOnHFEpkoUe6Fg2vPX/jJAoYdyy2GQndutTI69H24H
 ZJ3PBh6c1OPmXNpo4QhwelcyMmlTniJImBnaqRUYUH+D+V/gdPIj3zvbwGWK9Z1PW+nYwCLysQ5
 0u5Vfos8+rxtG2WkrTK0a0W9My7Pwq6PPZeX6gW8AGKM1hW40TAHYT9c/GMVjlMYit5BOncOBfH
 Hd+JNDvk3LJiLlbwlSPD4uGHFq+ymBw172tTSJ0KZc84ulNRxQ2Ml6Tu2Cx1JmHtyjhW2ED8p9I
 A7+f2N5LypL9Jsfi/sCDpFMZzTVwH4YrrT7p6GKOgGp5NYK0jJ56WNt+c4xGrebOQxDGKMwjPh8
 lN/mGBSL5uPB5ZAavWqY7wK/PTDe/Ub+55Qkf7Aa3rXHggb7MaEdnltJ3ZGn4IRwulY1xoFs4gF
 hcP0c5hjNr5Nejwe7azJw7bbwe1t6YBQufLjl743D154oS6GGjTK9x579HBSel6SF0jBwfJn2gK
 xMDqI6op1R6PtgnnDV1njtVbodUhxUKR079f3oCCfM3lmPoyUGMI5QwSxfBBgSd4vf7fOP1SqND
 gLvNJMaEOL0+af69JEJ1hrtIpn11DNsxUnvXw7W8B79HXiS/5DqrM5u3PoWbI2qHNndcHjglYh1
 9D5pTbxVcBC9VqA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add X403, a 3 plane 10 bits per component non-subsampled YCbCr format.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 3 +++
 include/uapi/drm/drm_fourcc.h | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 0d222f6c1a30..ab643dedd6d4 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -391,6 +391,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_Y10_P32,		.depth = 0,  .num_planes = 1,
 		  .char_per_block = { 4, 0, 0 }, .block_w = { 3, 0, 0 }, .block_h = { 1, 0, 0 },
 		  .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_X403,		.depth = 0,  .num_planes = 3,
+		  .char_per_block = { 4, 4, 4 }, .block_w = { 3, 3, 3 }, .block_h = { 1, 1, 1 },
+		  .hsub = 1, .vsub = 1, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 4754bb48e4c3..8ac36a74ceb1 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -403,6 +403,15 @@ extern "C" {
  */
 #define DRM_FORMAT_Q401		fourcc_code('Q', '4', '0', '1')
 
+/*
+ * 3 plane non-subsampled (444) YCbCr
+ * 10 bpc, 30 bits per sample image data in a single contiguous buffer.
+ * index 0: Y plane,  [31:0] x:Y2:Y1:Y0    [2:10:10:10] little endian
+ * index 1: Cb plane, [31:0] x:Cb2:Cb1:Cb0 [2:10:10:10] little endian
+ * index 2: Cr plane, [31:0] x:Cr2:Cr1:Cr0 [2:10:10:10] little endian
+ */
+#define DRM_FORMAT_X403		fourcc_code('X', '4', '0', '3')
+
 /*
  * 3 plane YCbCr LSB aligned
  * In order to use these formats in a similar fashion to MSB aligned ones

-- 
2.43.0


