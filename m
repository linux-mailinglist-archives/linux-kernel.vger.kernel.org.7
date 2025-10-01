Return-Path: <linux-kernel+bounces-838942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A102BB0792
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECFB16088C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13142F067D;
	Wed,  1 Oct 2025 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MpBmYH54"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A732EFD81
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324981; cv=none; b=Y/ouRBQ4NZKBLuM9qgNDjvOiw5rLb5/WBM49NYvPoRoDHN687SGy37IDQsypEILbqzxAJedYc3kqeFvSDMFn7k73xu1mMe14+feDvHcDMYUg3dUmwAecThhBTqdkDZG2vJmKMF9Q2gLH4NbiLVDvyQkBQUh11vk7qG0ahjWHLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324981; c=relaxed/simple;
	bh=jcF9TO4w0dmiNuHteMC+0VDVhFz7gX4DbHPqYH+9J6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbsMXLVUYTvmk/Mcx9Ka75e3I/SUgQeiCk7RsTiS/gUE1SGjIfxRga8KFrBbfbFdH82cgamwqxNNsrgFUyDIxP5APTeQWfEF0vTawTLhypjzkCUiAAdOQ0W3c2RpQvYyvQZWdYE7kRjKmwAEcJeW3S6eu1HpmSYzwZ+4X2XnDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MpBmYH54; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 950E5173F;
	Wed,  1 Oct 2025 15:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324884;
	bh=jcF9TO4w0dmiNuHteMC+0VDVhFz7gX4DbHPqYH+9J6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MpBmYH54e+Hgvzux5IzTqdFPaYf1ivO5KMDVr287GWvHA8LWBHT85mr7Q25ImYPyo
	 u6u6g092p9vWV1FC/ZqxsF+rg1w8VDeSlbjFpsBi0oJ08oNAWwESmdNfBJuOm89kLx
	 uiGSV1YONGDZmWCDKar/S4YvVV9Fcz0Cw+uglpds=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 01 Oct 2025 16:22:19 +0300
Subject: [PATCH v6 07/11] drm: xlnx: zynqmp: Use drm helpers when
 calculating buffer sizes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-xilinx-formats-v6-7-014b076b542a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=jcF9TO4w0dmiNuHteMC+0VDVhFz7gX4DbHPqYH+9J6g=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3SsjnX1o4AVIECTUWPwFyTd++aQO6/WfXxbCK
 g+/9Efx86mJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rIwAKCRD6PaqMvJYe
 9UIwD/wJvuoMNRezoTPoSMUJkTadTXRubLBLrcUD+KJja74oLbQ8X18IGh8MFvgCgQnDdsXIHTE
 /EQHvp2ByacWuhTNz/x7kkxXaBCs01iZt0RxV4YnXYxI2TY98xVW5NHyaOkEvhkaQ7hQCSREuFE
 9bUXyQLgFVJAy6Tm9RB3iyZ6lrVP8yCOsmUqS+cAO4uJb5ghkgvPkq8aOPLyimxTMEfJFvJYL1l
 WCWsDojtnWj07L/NXMKV2dy+K7l2jlYDgbYkOXy0hIMn5EV5y8Zvzf+fJXfkdc51y66q5XNIEro
 5HfhlejYqgUj6XmfDROMQNd4IBQlrBis0kGusyGugUNGzQEgx552XFeuvqUnU1j6YS+AlHsWIdF
 nNBCoE6pmidb/NeGIgT5845i22AVAMTyvi/4npI4py2E3CSrVUxtXSeUADlvtQhM5N0yJdtUgx8
 ZBX6CkPSq3zryg6sRYUA9uUaZnDmeVsLy/wE5rCKmhQ0AEs4oGs0DQ5LRQqFdwlOt5XHAZLEbdI
 N8/Duy+n4ja/7M+EYGh+Ck3+D1mKw0X9vl7ZVvKBEqni4KIYXzJ8SDp3cBX26GusIW6SNi8wjzk
 4AwD0Hp4diSQo+jQfQwE50AvRxkw+jDaAenHbxfduYtBidqYJ0o/eAFHCJsCMuTpI8q7m8EoDJO
 Pgu2Qm6td1XUdvw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Use drm helpers, drm_format_info_plane_width(),
drm_format_info_plane_height() and drm_format_info_min_pitch() to
calculate sizes for the DMA.

This cleans up the code, but also makes it possible to support more
complex formats (like XV15, XV20).

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 80d1e499a18d..b9883ea2d03e 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -1116,16 +1116,19 @@ int zynqmp_disp_layer_update(struct zynqmp_disp_layer *layer,
 		return 0;
 
 	for (i = 0; i < info->num_planes; i++) {
-		unsigned int width = state->crtc_w / (i ? info->hsub : 1);
-		unsigned int height = state->crtc_h / (i ? info->vsub : 1);
 		struct zynqmp_disp_layer_dma *dma = &layer->dmas[i];
 		struct dma_async_tx_descriptor *desc;
 		dma_addr_t dma_addr;
+		unsigned int width;
+		unsigned int height;
+
+		width = drm_format_info_plane_width(info, state->crtc_w, i);
+		height = drm_format_info_plane_height(info, state->crtc_h, i);
 
 		dma_addr = drm_fb_dma_get_gem_addr(state->fb, state, i);
 
 		dma->xt.numf = height;
-		dma->sgl.size = width * info->cpp[i];
+		dma->sgl.size = drm_format_info_min_pitch(info, i, width);
 		dma->sgl.icg = state->fb->pitches[i] - dma->sgl.size;
 		dma->xt.src_start = dma_addr;
 		dma->xt.frame_size = 1;

-- 
2.43.0


