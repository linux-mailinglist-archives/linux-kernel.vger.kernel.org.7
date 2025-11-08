Return-Path: <linux-kernel+bounces-891438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B2EC42A9A
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60B73A9D7F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0502F5A0D;
	Sat,  8 Nov 2025 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fXRamP5D"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E622F3C07;
	Sat,  8 Nov 2025 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762594617; cv=none; b=i27fperk1yhnyOfr5nXY976vTiPL/8h9OPU2b7+ome7RF29POuoIX7TaR5NmtdGexEqcrt7DR4G8qnToiP4XOACR+oMxhn0PBliInAw02+Qfm9G3kCx01d6TPV3hqSqQ5rbmzLMgqHF7U7l71iWaOChwq1cbyNYZTm4AAlt0jPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762594617; c=relaxed/simple;
	bh=NA/pEPq54tjIRQbYfe1AJ4RWRStd67bBpWv66gE41xA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4MmXjZzOFL+bplpYsL0GYrTVrPulQ0MA/PnwtNraw7b+edX9HORwiPOyXvYXWX1S3oZ0PkR18S94pFQJhRob9a9JCFLvu+tMxRTXebUtElWtZSrKTQxfaUg8kHWOWuCtpodBLsh4+lsgZfLixDQ1NX0PPGHtT3E/G+pEhx4u3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fXRamP5D; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.0.172] (mob-5-90-142-135.net.vodafone.it [5.90.142.135])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3E4B2E1F;
	Sat,  8 Nov 2025 10:34:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762594493;
	bh=NA/pEPq54tjIRQbYfe1AJ4RWRStd67bBpWv66gE41xA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fXRamP5DrKDjUoJRuLTjGnluoX8ov0y9hXknwvT2r6l00Ue+cXZv/Dqt+7wGMoA4m
	 mIlep1tx2k4spQ/xrv7ruzescIjn8Flxend3UZryJipbh6UA6Zsnyf/MAIg+RG6BFS
	 cQmZRUDzvskJl13jH2WE6EUyopNdyOis0EGq/4/Y=
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Date: Sat, 08 Nov 2025 10:36:28 +0100
Subject: [PATCH v9 7/8] media: amlogic-c3: Use v4l2-isp for validation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-extensible-parameters-validation-v9-7-6a7e22aa57d0@ideasonboard.com>
References: <20251108-extensible-parameters-validation-v9-0-6a7e22aa57d0@ideasonboard.com>
In-Reply-To: <20251108-extensible-parameters-validation-v9-0-6a7e22aa57d0@ideasonboard.com>
To: Dafna Hirschfeld <dafna@fastmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Keke Li <keke.li@amlogic.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Dan Scally <dan.scally@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Antoine Bouyer <antoine.bouyer@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9260;
 i=jacopo.mondi@ideasonboard.com; h=from:subject:message-id;
 bh=NA/pEPq54tjIRQbYfe1AJ4RWRStd67bBpWv66gE41xA=;
 b=owEBbQKS/ZANAwAKAXI0Bo8WoVY8AcsmYgBpDw8m6Sj0DeJ6yZsXVBr2zkc1fvxpW7la+hx4k
 pkRIVgiE12JAjMEAAEKAB0WIQS1xD1IgJogio9YOMByNAaPFqFWPAUCaQ8PJgAKCRByNAaPFqFW
 PMaEEACnuxIyxW0A0SZ8JabQMBl+0QZzapO1+DsOUA9SCTmJSGP/l1UOitE4OiN9dJUnBdaigW8
 bt5NYsbIDpKtmV43eW8BEtzuX4sL6d6qgOvRfjfxWpA7zMvfWVikAdfobPzhAZo9UMT/K2oBzSX
 abTWaGSvhuEKRwYWKIAnCMi1aS3DrvIqgEdScD5cCwwIPNcW5W556jdBDMzrlsbFr0lnAmmsKyg
 1ZFXjeqyqeDy7MPzTrblxC9vk8/3s0x+rjjGVQjo02WpSgtBSmYdaVCMaJsJnOVM9HKvAHqq5w9
 RiH551ldHksSk9MfQiZTc8O4w1184m+w207nAFPHhsWUdLH+9tCVJXd5HollG+ERVj4y8thLdUm
 g6AmrZqOX6fkuMzUdzjGGvMsnw6BO4mLkgX5/fxd+jAcNqZSyUg57pJeYId6kFis/UOYFRwpQR8
 ZJ0gRyhQ69UnycFtgxh2H8LsvH2VQEdRqP7AEAh3yYxTMBAP1WOH9ly6jgtNdIgy2kX9kf05gkv
 TJJ6XR/g/nGK8aUYlKbK43WMb8AxWRSSdd3G/iCsD51CDNGuo3IuyA9TKxKwiWA0FIZnvWdOfw9
 PULOcPtB82rJcqEnjwypzNi11jp+8GTwMzsU6yPM+bLWtFnmBNFs+V/4gbCSzwY0f818UPd+3t3
 l7O6Ioo4niXJhlQ==
X-Developer-Key: i=jacopo.mondi@ideasonboard.com; a=openpgp;
 fpr=72392EDC88144A65C701EA9BA5826A2587AD026B

Convert c3-isp-params.c to use the helpers defined in v4l2-isp.h
to perform validation of a ISP parameters buffer.

Reviewed-by: Keke Li <keke.li@amlogic.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/platform/amlogic/c3/isp/Kconfig      |   1 +
 .../media/platform/amlogic/c3/isp/c3-isp-params.c  | 165 ++++++---------------
 2 files changed, 44 insertions(+), 122 deletions(-)

diff --git a/drivers/media/platform/amlogic/c3/isp/Kconfig b/drivers/media/platform/amlogic/c3/isp/Kconfig
index 02c62a50a5e88eac665e27abf163e5d654faed3f..809208cd7e3aa7ca0821cb07366ec73a47edb278 100644
--- a/drivers/media/platform/amlogic/c3/isp/Kconfig
+++ b/drivers/media/platform/amlogic/c3/isp/Kconfig
@@ -10,6 +10,7 @@ config VIDEO_C3_ISP
 	select VIDEO_V4L2_SUBDEV_API
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEOBUF2_VMALLOC
+	select V4L2_ISP
 	help
 	  Video4Linux2 driver for Amlogic C3 ISP pipeline.
 	  The C3 ISP is used for processing raw images and
diff --git a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
index c80667dd766210d2b2e1ee60c8254a5814b9d81b..c2339d6dc1074818d333e0221b1d6a407a41acd7 100644
--- a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
+++ b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
@@ -3,11 +3,13 @@
  * Copyright (C) 2024 Amlogic, Inc. All rights reserved
  */
 
+#include <linux/build_bug.h>
 #include <linux/cleanup.h>
 #include <linux/media/amlogic/c3-isp-config.h>
 #include <linux/pm_runtime.h>
 
 #include <media/v4l2-ioctl.h>
+#include <media/v4l2-isp.h>
 #include <media/v4l2-mc.h>
 #include <media/videobuf2-vmalloc.h>
 
@@ -51,11 +53,6 @@ union c3_isp_params_block {
 typedef void (*c3_isp_block_handler)(struct c3_isp_device *isp,
 				     const union c3_isp_params_block *block);
 
-struct c3_isp_params_handler {
-	size_t size;
-	c3_isp_block_handler handler;
-};
-
 #define to_c3_isp_params_buffer(vbuf) \
 	container_of(vbuf, struct c3_isp_params_buffer, vb)
 
@@ -523,41 +520,36 @@ static void c3_isp_params_cfg_blc(struct c3_isp_device *isp,
 				   ISP_TOP_BEO_CTRL_BLC_EN);
 }
 
-static const struct c3_isp_params_handler c3_isp_params_handlers[] = {
-	[C3_ISP_PARAMS_BLOCK_AWB_GAINS] = {
-		.size = sizeof(struct c3_isp_params_awb_gains),
-		.handler = c3_isp_params_cfg_awb_gains,
-	},
-	[C3_ISP_PARAMS_BLOCK_AWB_CONFIG] = {
-		.size = sizeof(struct c3_isp_params_awb_config),
-		.handler = c3_isp_params_cfg_awb_config,
-	},
-	[C3_ISP_PARAMS_BLOCK_AE_CONFIG] = {
-		.size = sizeof(struct c3_isp_params_ae_config),
-		.handler = c3_isp_params_cfg_ae_config,
-	},
-	[C3_ISP_PARAMS_BLOCK_AF_CONFIG] = {
-		.size = sizeof(struct c3_isp_params_af_config),
-		.handler = c3_isp_params_cfg_af_config,
-	},
-	[C3_ISP_PARAMS_BLOCK_PST_GAMMA] = {
-		.size = sizeof(struct c3_isp_params_pst_gamma),
-		.handler = c3_isp_params_cfg_pst_gamma,
-	},
-	[C3_ISP_PARAMS_BLOCK_CCM] = {
-		.size = sizeof(struct c3_isp_params_ccm),
-		.handler = c3_isp_params_cfg_ccm,
-	},
-	[C3_ISP_PARAMS_BLOCK_CSC] = {
-		.size = sizeof(struct c3_isp_params_csc),
-		.handler = c3_isp_params_cfg_csc,
-	},
-	[C3_ISP_PARAMS_BLOCK_BLC] = {
-		.size = sizeof(struct c3_isp_params_blc),
-		.handler = c3_isp_params_cfg_blc,
-	},
+static const c3_isp_block_handler c3_isp_params_handlers[] = {
+	[C3_ISP_PARAMS_BLOCK_AWB_GAINS] = c3_isp_params_cfg_awb_gains,
+	[C3_ISP_PARAMS_BLOCK_AWB_CONFIG] = c3_isp_params_cfg_awb_config,
+	[C3_ISP_PARAMS_BLOCK_AE_CONFIG] = c3_isp_params_cfg_ae_config,
+	[C3_ISP_PARAMS_BLOCK_AF_CONFIG] = c3_isp_params_cfg_af_config,
+	[C3_ISP_PARAMS_BLOCK_PST_GAMMA] = c3_isp_params_cfg_pst_gamma,
+	[C3_ISP_PARAMS_BLOCK_CCM] = c3_isp_params_cfg_ccm,
+	[C3_ISP_PARAMS_BLOCK_CSC] = c3_isp_params_cfg_csc,
+	[C3_ISP_PARAMS_BLOCK_BLC] = c3_isp_params_cfg_blc,
+};
+
+#define C3_ISP_PARAMS_BLOCK_INFO(block, data) \
+	[C3_ISP_PARAMS_BLOCK_ ## block] = { \
+		.size = sizeof(struct c3_isp_params_ ## data), \
+	}
+
+static const struct v4l2_isp_params_block_info c3_isp_params_blocks_info[] = {
+	C3_ISP_PARAMS_BLOCK_INFO(AWB_GAINS, awb_gains),
+	C3_ISP_PARAMS_BLOCK_INFO(AWB_CONFIG, awb_config),
+	C3_ISP_PARAMS_BLOCK_INFO(AE_CONFIG, ae_config),
+	C3_ISP_PARAMS_BLOCK_INFO(AF_CONFIG, af_config),
+	C3_ISP_PARAMS_BLOCK_INFO(PST_GAMMA, pst_gamma),
+	C3_ISP_PARAMS_BLOCK_INFO(CCM, ccm),
+	C3_ISP_PARAMS_BLOCK_INFO(CSC, csc),
+	C3_ISP_PARAMS_BLOCK_INFO(BLC, blc),
 };
 
+static_assert(ARRAY_SIZE(c3_isp_params_handlers) ==
+	      ARRAY_SIZE(c3_isp_params_blocks_info));
+
 static void c3_isp_params_cfg_blocks(struct c3_isp_params *params)
 {
 	struct c3_isp_params_cfg *config = params->buff->cfg;
@@ -568,14 +560,14 @@ static void c3_isp_params_cfg_blocks(struct c3_isp_params *params)
 
 	/* Walk the list of parameter blocks and process them */
 	while (block_offset < config->data_size) {
-		const struct c3_isp_params_handler *block_handler;
 		const union c3_isp_params_block *block;
+		c3_isp_block_handler block_handler;
 
 		block = (const union c3_isp_params_block *)
 			 &config->data[block_offset];
 
-		block_handler = &c3_isp_params_handlers[block->header.type];
-		block_handler->handler(params->isp, block);
+		block_handler = c3_isp_params_handlers[block->header.type];
+		block_handler(params->isp, block);
 
 		block_offset += block->header.size;
 	}
@@ -771,26 +763,15 @@ static int c3_isp_params_vb2_buf_prepare(struct vb2_buffer *vb)
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct c3_isp_params_buffer *buf = to_c3_isp_params_buffer(vbuf);
 	struct c3_isp_params *params = vb2_get_drv_priv(vb->vb2_queue);
-	struct c3_isp_params_cfg *cfg = buf->cfg;
 	struct c3_isp_params_cfg *usr_cfg = vb2_plane_vaddr(vb, 0);
 	size_t payload_size = vb2_get_plane_payload(vb, 0);
-	size_t header_size = offsetof(struct c3_isp_params_cfg, data);
-	size_t block_offset = 0;
-	size_t cfg_size;
-
-	/* Payload size can't be greater than the destination buffer size */
-	if (payload_size > params->vfmt.fmt.meta.buffersize) {
-		dev_dbg(params->isp->dev,
-			"Payload size is too large: %zu\n", payload_size);
-		return -EINVAL;
-	}
+	struct c3_isp_params_cfg *cfg = buf->cfg;
+	int ret;
 
-	/* Payload size can't be smaller than the header size */
-	if (payload_size < header_size) {
-		dev_dbg(params->isp->dev,
-			"Payload size is too small: %zu\n", payload_size);
-		return -EINVAL;
-	}
+	ret = v4l2_isp_params_validate_buffer_size(params->isp->dev, vb,
+						   params->vfmt.fmt.meta.buffersize);
+	if (ret)
+		return ret;
 
 	/*
 	 * Use the internal scratch buffer to avoid userspace modifying
@@ -798,70 +779,10 @@ static int c3_isp_params_vb2_buf_prepare(struct vb2_buffer *vb)
 	 */
 	memcpy(cfg, usr_cfg, payload_size);
 
-	/* Only v0 is supported at the moment */
-	if (cfg->version != C3_ISP_PARAMS_BUFFER_V0) {
-		dev_dbg(params->isp->dev,
-			"Invalid params buffer version: %u\n", cfg->version);
-		return -EINVAL;
-	}
-
-	/* Validate the size reported in the parameter buffer header */
-	cfg_size = header_size + cfg->data_size;
-	if (cfg_size != payload_size) {
-		dev_dbg(params->isp->dev,
-			"Data size %zu and payload size %zu are different\n",
-			cfg_size, payload_size);
-		return -EINVAL;
-	}
-
-	/* Walk the list of parameter blocks and validate them */
-	cfg_size = cfg->data_size;
-	while (cfg_size >= sizeof(struct c3_isp_params_block_header)) {
-		const struct c3_isp_params_block_header *block;
-		const struct c3_isp_params_handler *handler;
-
-		block = (struct c3_isp_params_block_header *)
-			&cfg->data[block_offset];
-
-		if (block->type >= ARRAY_SIZE(c3_isp_params_handlers)) {
-			dev_dbg(params->isp->dev,
-				"Invalid params block type\n");
-			return -EINVAL;
-		}
-
-		if (block->size > cfg_size) {
-			dev_dbg(params->isp->dev,
-				"Block size is greater than cfg size\n");
-			return -EINVAL;
-		}
-
-		if ((block->flags & (C3_ISP_PARAMS_BLOCK_FL_ENABLE |
-				     C3_ISP_PARAMS_BLOCK_FL_DISABLE)) ==
-		    (C3_ISP_PARAMS_BLOCK_FL_ENABLE |
-		     C3_ISP_PARAMS_BLOCK_FL_DISABLE)) {
-			dev_dbg(params->isp->dev,
-				"Invalid parameters block flags\n");
-			return -EINVAL;
-		}
-
-		handler = &c3_isp_params_handlers[block->type];
-		if (block->size != handler->size) {
-			dev_dbg(params->isp->dev,
-				"Invalid params block size\n");
-			return -EINVAL;
-		}
-
-		block_offset += block->size;
-		cfg_size -= block->size;
-	}
-
-	if (cfg_size) {
-		dev_dbg(params->isp->dev,
-			"Unexpected data after the params buffer end\n");
-		return -EINVAL;
-	}
-
-	return 0;
+	return v4l2_isp_params_validate_buffer(params->isp->dev, vb,
+					(struct v4l2_isp_params_buffer *)cfg,
+					c3_isp_params_blocks_info,
+					ARRAY_SIZE(c3_isp_params_blocks_info));
 }
 
 static int c3_isp_params_vb2_buf_init(struct vb2_buffer *vb)

-- 
2.51.0


