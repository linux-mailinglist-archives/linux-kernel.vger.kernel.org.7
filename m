Return-Path: <linux-kernel+bounces-838946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB31BB07AD
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B7B166D61
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F642F1FCD;
	Wed,  1 Oct 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BbhDktVd"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF32F0C4F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324985; cv=none; b=VGLiDpykoUDBYfWAEwOTw9RuQBF9bcXgiKS29+uVqGqa0Fj4lr+XhS3YE0NA3NtCyqqZ/HTykfIy7gnm6OIorQiIVMtmTJk1RxqCOCKsO6QRQhzAZw+b1NyTSoS+n/u6k3r/g79PzMTc5Gsk4U/h9anUvXoGQmp28uJj9AsnGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324985; c=relaxed/simple;
	bh=L1FSsg0Qh6Izmf4vGGUqKbG48MvEYOAEvR+4KJGxUuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EN915pd494eJChG1FmEfZvRIqLZCLzB24Ix2HM3J5gKzJm6IAyFvzcx0fa7vOJJiZxXUXwTNK2sFnTjb1zn6yYALPW33scuTZOjnp3WYdDagjmgOaxDBjykiTEgPpzmm3VfFeKqmrlDtWK5IhovKHsFEMac+QbeeWVUoD1J0M0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BbhDktVd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 959454C7;
	Wed,  1 Oct 2025 15:21:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324886;
	bh=L1FSsg0Qh6Izmf4vGGUqKbG48MvEYOAEvR+4KJGxUuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BbhDktVdmHON1E6NAYBiK0dPvJU1KNiKI9TF5dJRCx71ng9Uh0lE4TxR9Qjbzc+k8
	 IQWTazpubUEAUDOW9vAF5AW9PJPyNjJRTXb6UuH4wRc86scfx1+7LSn7IoyQ2jeh7f
	 3eLzayiDvprb3LX6cSud/oohDJf7XUhusN5jeTN8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 01 Oct 2025 16:22:21 +0300
Subject: [PATCH v6 09/11] drm: xlnx: zynqmp: Add support for Y8 and Y10_P32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-xilinx-formats-v6-9-014b076b542a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=L1FSsg0Qh6Izmf4vGGUqKbG48MvEYOAEvR+4KJGxUuI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3SsjieDuSmOYZfypptmav0LGYhOsi8XuLBO9U
 khfKq1hKa2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rIwAKCRD6PaqMvJYe
 9cVeD/9CzY0gSF8fKQvL23OQQMUYKeTRoA/WEW7EbOR9pZsosDEAKtbjczTL/xtJJp3sKFfj4Pc
 PM5YAMWB+tlMNZoYoLYLpPOZz4NZDr8U17qp0SazKdEIkFOnB7ZeU5mQOZbE2PI/QeqZEmWnAT6
 m3Vhlp6VMtUgncxnllo3farKKcO3fLpzeqVq+lVVjC5ciu9LPPupLHVewaA3mv0ggFP4vlfLKB2
 vVjDX9hOvdaAdhoykYVM2uxVEY6ftfzYqx6tAj6Cs9291PDe/innnFcT03Ly9YTna4M9AOLKDfo
 QZyX/vgxdxMXMxMKny93ayFHB8LXp9FHYg1FE85bNaqI7K3AGwLvuiVlmBwekpCIp6ckE/HGKAl
 icu968VGh4tpsa2eUhwfVoJR0X7rNMbtJ5Om3s5efaCG8N3faIfelJcZJWbO5ALwgxtThxWBbyB
 r+Kg3B5SkWkLa3ZaFOuZ3N1U8a5lR6gFZZ4rMpir4pY1zpSorKwaWPerLtK8IKWE8zH24tljjAk
 FGusiUBviqh/dRhrrZy15JIxTg5BY4c68sdePLZ7jSBk0W9pRejcgbLy8x05FikSCHCXxKpMe/F
 Ez4cWMwzg2NahPxzcnE6pp6oygBLU5J+oVg3ABynPsYx8Eda4/APW2EDmPpMI3/loBlJ9Fsj4li
 gOAAu5T3bqP3uNg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for Y8 and Y10_P32 formats. We also need to add new csc
matrices for the y-only formats.

Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 1dc77f2e4262..fe111fa8cc13 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -307,6 +307,16 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_Y8,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_MONO,
+		.swap		= false,
+		.sf		= scaling_factors_888,
+	}, {
+		.drm_fmt	= DRM_FORMAT_Y10_P32,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YONLY_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 
@@ -697,6 +707,16 @@ static const u32 csc_sdtv_to_rgb_offsets[] = {
 	0x0, 0x1800, 0x1800
 };
 
+static const u16 csc_sdtv_to_rgb_yonly_matrix[] = {
+	0x0, 0x0, 0x1000,
+	0x0, 0x0, 0x1000,
+	0x0, 0x0, 0x1000,
+};
+
+static const u32 csc_sdtv_to_rgb_yonly_offsets[] = {
+	0x0, 0x0, 0x0
+};
+
 /**
  * zynqmp_disp_blend_set_output_format - Set the output format of the blender
  * @disp: Display controller
@@ -846,7 +866,11 @@ static void zynqmp_disp_blend_layer_enable(struct zynqmp_disp *disp,
 				ZYNQMP_DISP_V_BLEND_LAYER_CONTROL(layer->id),
 				val);
 
-	if (layer->drm_fmt->is_yuv) {
+	if (layer->drm_fmt->format == DRM_FORMAT_Y8 ||
+	    layer->drm_fmt->format == DRM_FORMAT_Y10_P32) {
+		coeffs = csc_sdtv_to_rgb_yonly_matrix;
+		offsets = csc_sdtv_to_rgb_yonly_offsets;
+	} else if (layer->drm_fmt->is_yuv) {
 		coeffs = csc_sdtv_to_rgb_matrix;
 		offsets = csc_sdtv_to_rgb_offsets;
 	} else {

-- 
2.43.0


