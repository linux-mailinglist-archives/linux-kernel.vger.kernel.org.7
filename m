Return-Path: <linux-kernel+bounces-891437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19732C42A91
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A032D188E1EC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2296D2F549E;
	Sat,  8 Nov 2025 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TFdP0bri"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DC2F39D6;
	Sat,  8 Nov 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762594617; cv=none; b=qMpZSNhZn6pL7RqZ2ZxeQ2mbKyoI2FMUtLowk1sCJsPkTktYSIB4v+TCvuC/Aiv1Es2P+5eGfAs498xpvrL2fpdIFqScGTr4K1fSHNpGquSxbnMsSAeZHzFX1ZDVAoWqxvSI7M2l4XpRXxENw5RljK6N+JpjURR+j97RAGX7wjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762594617; c=relaxed/simple;
	bh=hVx/tae0uGmuOaa92bBCvwER55dA7gt64o7jGbjiS44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGndwa6ol1Yhu7j9cfqblA/iOCIUtQuAaOhUFWoB9iq/j+S5oRQyAM2QX0tlc/ukVJxjUBymGGU973+Z3hhfkC2gsScZ10BKBkK6iHnSf2gw0n+kOgiPV80ZQ2jNemSDvyS+H2Ms+U//5GgGmoOs+RWhH2EiWdO4cCTdwL93htk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TFdP0bri; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.0.172] (mob-5-90-142-135.net.vodafone.it [5.90.142.135])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E670DD9;
	Sat,  8 Nov 2025 10:34:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762594492;
	bh=hVx/tae0uGmuOaa92bBCvwER55dA7gt64o7jGbjiS44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TFdP0brihrFOJrZSSVZLyNJK7ZXlPFlwbUJ33X9kltxaVIawZrlEaw4cQT+rnshx3
	 4KmjPqfFh81Q3laAoCDJztfc0pJTuUvnmSyfjODNxgseHNYl7BY4Kpu0A0sRKJV3Rk
	 0ZnpgCuRgMwLn7lkwtw8BrYeuFI/1V4cPBkKUWcQ=
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Date: Sat, 08 Nov 2025 10:36:27 +0100
Subject: [PATCH v9 6/8] media: rkisp1: Use v4l2-isp for validation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-extensible-parameters-validation-v9-6-6a7e22aa57d0@ideasonboard.com>
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
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11868;
 i=jacopo.mondi@ideasonboard.com; h=from:subject:message-id;
 bh=hVx/tae0uGmuOaa92bBCvwER55dA7gt64o7jGbjiS44=;
 b=owEBbQKS/ZANAwAKAXI0Bo8WoVY8AcsmYgBpDw8mvWZ98SE805kcEg3u72CcAis2imsKJDY0C
 OL5kYNOYCCJAjMEAAEKAB0WIQS1xD1IgJogio9YOMByNAaPFqFWPAUCaQ8PJgAKCRByNAaPFqFW
 PIYXD/wMC0GP3LHxppnmFHmzzfnW939UuxJev4bB9YIGwWzDEjZ6yb2cLylX2nspoFPW7INyCsc
 pTWRYjBgSLB5H+fmpNb3FTI3ba9R/kLVX3ZxIa7k/TWWqzEgD/NopWwdVEbDCL+ruxQmjpGmh8P
 TH0vr03xb4RTioMyKgxetl678QuiVX0WEKGRaREgmnBnoZLAhl2kg4ko1q1GmujsN0Fv3upm8th
 hWwYvRVuB0/mhkgo5gEpF6qMuY26KKpVEA06iQOjcWI8b7rpGKOLyh+0NQVGgamkl40caIxPl7Y
 lMJ7SvvSLtMzdTfarLAq1Oi4VYumnSf/KKG8Dc++ZbzIUrGCZDUOmFSd1ar0qdOuOzh3NTohsKG
 3bA1iwyXybL8LwjBty0x24Jy8Z/2Ac1e2ZvFPIdSOMyJGYxM6BKiA+mKG65z0lVjL4h8AX/b+PS
 +GuSiHPNMTgnMpvyBmidjR4rL20xTvBaZnDeeF/E6zzkO3xoWsDr3DvsdLBmlhPhixKf964PO+k
 Xnf2iaLyeCAn8qWGp1WD4rYU5V8p1o6ifuBMM2SeezaTR99BTz+4Wgqb7t8eBjw1OObcGTGliHR
 a28pbxG7Spcf+pLCYxkxRZD3qr7CRACaYxDUKlnk/Pu6CCobx2gqVvMc/M7uXs8Ly/MtpKnksqK
 4FAEcJIhZVmE8uw==
X-Developer-Key: i=jacopo.mondi@ideasonboard.com; a=openpgp;
 fpr=72392EDC88144A65C701EA9BA5826A2587AD026B

Convert rkisp1-params.c to use the helpers defined in v4l2-isp.h
to perform validation of a ISP parameters buffer.

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/Kconfig     |   1 +
 .../media/platform/rockchip/rkisp1/rkisp1-params.c | 150 ++++++---------------
 2 files changed, 44 insertions(+), 107 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/Kconfig b/drivers/media/platform/rockchip/rkisp1/Kconfig
index 731c9acbf6efa33188617204d441fb0ea59adebc..f53eb1f3f3e7003d8e02c9236aeabb5ae8844f7b 100644
--- a/drivers/media/platform/rockchip/rkisp1/Kconfig
+++ b/drivers/media/platform/rockchip/rkisp1/Kconfig
@@ -10,6 +10,7 @@ config VIDEO_ROCKCHIP_ISP1
 	select VIDEOBUF2_VMALLOC
 	select V4L2_FWNODE
 	select GENERIC_PHY_MIPI_DPHY
+	select V4L2_ISP
 	default n
 	help
 	  Enable this to support the Image Signal Processing (ISP) module
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
index f1585f8fa0f478304f74317fd9dd09199c94ec82..2dde0c62c8e6b8f8447e0414950cec0a511169fd 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
@@ -6,12 +6,14 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/build_bug.h>
 #include <linux/math.h>
 #include <linux/string.h>
 
 #include <media/v4l2-common.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-ioctl.h>
+#include <media/v4l2-isp.h>
 #include <media/videobuf2-core.h>
 #include <media/videobuf2-vmalloc.h>	/* for ISP params */
 
@@ -2097,122 +2099,132 @@ typedef void (*rkisp1_block_handler)(struct rkisp1_params *params,
 			     const union rkisp1_ext_params_config *config);
 
 static const struct rkisp1_ext_params_handler {
-	size_t size;
 	rkisp1_block_handler handler;
 	unsigned int group;
 	unsigned int features;
 } rkisp1_ext_params_handlers[] = {
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_BLS] = {
-		.size		= sizeof(struct rkisp1_ext_params_bls_config),
 		.handler	= rkisp1_ext_params_bls,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 		.features       = RKISP1_FEATURE_BLS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_DPCC] = {
-		.size		= sizeof(struct rkisp1_ext_params_dpcc_config),
 		.handler	= rkisp1_ext_params_dpcc,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_SDG] = {
-		.size		= sizeof(struct rkisp1_ext_params_sdg_config),
 		.handler	= rkisp1_ext_params_sdg,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_AWB_GAIN] = {
-		.size		= sizeof(struct rkisp1_ext_params_awb_gain_config),
 		.handler	= rkisp1_ext_params_awbg,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_FLT] = {
-		.size		= sizeof(struct rkisp1_ext_params_flt_config),
 		.handler	= rkisp1_ext_params_flt,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_BDM] = {
-		.size		= sizeof(struct rkisp1_ext_params_bdm_config),
 		.handler	= rkisp1_ext_params_bdm,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_CTK] = {
-		.size		= sizeof(struct rkisp1_ext_params_ctk_config),
 		.handler	= rkisp1_ext_params_ctk,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_GOC] = {
-		.size		= sizeof(struct rkisp1_ext_params_goc_config),
 		.handler	= rkisp1_ext_params_goc,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_DPF] = {
-		.size		= sizeof(struct rkisp1_ext_params_dpf_config),
 		.handler	= rkisp1_ext_params_dpf,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_DPF_STRENGTH] = {
-		.size		= sizeof(struct rkisp1_ext_params_dpf_strength_config),
 		.handler	= rkisp1_ext_params_dpfs,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_CPROC] = {
-		.size		= sizeof(struct rkisp1_ext_params_cproc_config),
 		.handler	= rkisp1_ext_params_cproc,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_IE] = {
-		.size		= sizeof(struct rkisp1_ext_params_ie_config),
 		.handler	= rkisp1_ext_params_ie,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_LSC] = {
-		.size		= sizeof(struct rkisp1_ext_params_lsc_config),
 		.handler	= rkisp1_ext_params_lsc,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_LSC,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_AWB_MEAS] = {
-		.size		= sizeof(struct rkisp1_ext_params_awb_meas_config),
 		.handler	= rkisp1_ext_params_awbm,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_HST_MEAS] = {
-		.size		= sizeof(struct rkisp1_ext_params_hst_config),
 		.handler	= rkisp1_ext_params_hstm,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_AEC_MEAS] = {
-		.size		= sizeof(struct rkisp1_ext_params_aec_config),
 		.handler	= rkisp1_ext_params_aecm,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_AFC_MEAS] = {
-		.size		= sizeof(struct rkisp1_ext_params_afc_config),
 		.handler	= rkisp1_ext_params_afcm,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_COMPAND_BLS] = {
-		.size		= sizeof(struct rkisp1_ext_params_compand_bls_config),
 		.handler	= rkisp1_ext_params_compand_bls,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 		.features	= RKISP1_FEATURE_COMPAND,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_COMPAND_EXPAND] = {
-		.size		= sizeof(struct rkisp1_ext_params_compand_curve_config),
 		.handler	= rkisp1_ext_params_compand_expand,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 		.features	= RKISP1_FEATURE_COMPAND,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_COMPAND_COMPRESS] = {
-		.size		= sizeof(struct rkisp1_ext_params_compand_curve_config),
 		.handler	= rkisp1_ext_params_compand_compress,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 		.features	= RKISP1_FEATURE_COMPAND,
 	},
 	[RKISP1_EXT_PARAMS_BLOCK_TYPE_WDR] = {
-		.size		= sizeof(struct rkisp1_ext_params_wdr_config),
 		.handler	= rkisp1_ext_params_wdr,
 		.group		= RKISP1_EXT_PARAMS_BLOCK_GROUP_OTHERS,
 	},
 };
 
+#define RKISP1_PARAMS_BLOCK_INFO(block, data) \
+	[RKISP1_EXT_PARAMS_BLOCK_TYPE_ ## block] = { \
+		.size = sizeof(struct rkisp1_ext_params_ ## data ## _config), \
+	}
+
+static const struct v4l2_isp_params_block_info rkisp1_ext_params_blocks_info[] = {
+	RKISP1_PARAMS_BLOCK_INFO(BLS, bls),
+	RKISP1_PARAMS_BLOCK_INFO(DPCC, dpcc),
+	RKISP1_PARAMS_BLOCK_INFO(SDG, sdg),
+	RKISP1_PARAMS_BLOCK_INFO(AWB_GAIN, awb_gain),
+	RKISP1_PARAMS_BLOCK_INFO(FLT, flt),
+	RKISP1_PARAMS_BLOCK_INFO(BDM, bdm),
+	RKISP1_PARAMS_BLOCK_INFO(CTK, ctk),
+	RKISP1_PARAMS_BLOCK_INFO(GOC, goc),
+	RKISP1_PARAMS_BLOCK_INFO(DPF, dpf),
+	RKISP1_PARAMS_BLOCK_INFO(DPF_STRENGTH, dpf_strength),
+	RKISP1_PARAMS_BLOCK_INFO(CPROC, cproc),
+	RKISP1_PARAMS_BLOCK_INFO(IE, ie),
+	RKISP1_PARAMS_BLOCK_INFO(LSC, lsc),
+	RKISP1_PARAMS_BLOCK_INFO(AWB_MEAS, awb_meas),
+	RKISP1_PARAMS_BLOCK_INFO(HST_MEAS, hst),
+	RKISP1_PARAMS_BLOCK_INFO(AEC_MEAS, aec),
+	RKISP1_PARAMS_BLOCK_INFO(AFC_MEAS, afc),
+	RKISP1_PARAMS_BLOCK_INFO(COMPAND_BLS, compand_bls),
+	RKISP1_PARAMS_BLOCK_INFO(COMPAND_EXPAND, compand_curve),
+	RKISP1_PARAMS_BLOCK_INFO(COMPAND_COMPRESS, compand_curve),
+	RKISP1_PARAMS_BLOCK_INFO(WDR, wdr),
+};
+
+static_assert(ARRAY_SIZE(rkisp1_ext_params_handlers) ==
+	      ARRAY_SIZE(rkisp1_ext_params_blocks_info));
+
 static void rkisp1_ext_params_config(struct rkisp1_params *params,
 				     struct rkisp1_ext_params_cfg *cfg,
 				     u32 block_group_mask)
@@ -2646,31 +2658,16 @@ static int rkisp1_params_prepare_ext_params(struct rkisp1_params *params,
 {
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct rkisp1_params_buffer *params_buf = to_rkisp1_params_buffer(vbuf);
-	size_t header_size = offsetof(struct rkisp1_ext_params_cfg, data);
 	struct rkisp1_ext_params_cfg *cfg = params_buf->cfg;
 	size_t payload_size = vb2_get_plane_payload(vb, 0);
 	struct rkisp1_ext_params_cfg *usr_cfg =
 		vb2_plane_vaddr(&vbuf->vb2_buf, 0);
-	size_t block_offset = 0;
-	size_t cfg_size;
-
-	/*
-	 * Validate the buffer payload size before copying the parameters. The
-	 * payload has to be smaller than the destination buffer size and larger
-	 * than the header size.
-	 */
-	if (payload_size > params->metafmt->buffersize) {
-		dev_dbg(params->rkisp1->dev,
-			"Too large buffer payload size %zu\n", payload_size);
-		return -EINVAL;
-	}
+	int ret;
 
-	if (payload_size < header_size) {
-		dev_dbg(params->rkisp1->dev,
-			"Buffer payload %zu smaller than header size %zu\n",
-			payload_size, header_size);
-		return -EINVAL;
-	}
+	ret = v4l2_isp_params_validate_buffer_size(params->rkisp1->dev, vb,
+						   params->metafmt->buffersize);
+	if (ret)
+		return ret;
 
 	/*
 	 * Copy the parameters buffer to the internal scratch buffer to avoid
@@ -2678,71 +2675,10 @@ static int rkisp1_params_prepare_ext_params(struct rkisp1_params *params,
 	 */
 	memcpy(cfg, usr_cfg, payload_size);
 
-	/* Only v1 is supported at the moment. */
-	if (cfg->version != RKISP1_EXT_PARAM_BUFFER_V1) {
-		dev_dbg(params->rkisp1->dev,
-			"Unsupported extensible format version: %u\n",
-			cfg->version);
-		return -EINVAL;
-	}
-
-	/* Validate the size reported in the parameters buffer header. */
-	cfg_size = header_size + cfg->data_size;
-	if (cfg_size != payload_size) {
-		dev_dbg(params->rkisp1->dev,
-			"Data size %zu different than buffer payload size %zu\n",
-			cfg_size, payload_size);
-		return -EINVAL;
-	}
-
-	/* Walk the list of parameter blocks and validate them. */
-	cfg_size = cfg->data_size;
-	while (cfg_size >= sizeof(struct rkisp1_ext_params_block_header)) {
-		const struct rkisp1_ext_params_block_header *block;
-		const struct rkisp1_ext_params_handler *handler;
-
-		block = (const struct rkisp1_ext_params_block_header *)
-			&cfg->data[block_offset];
-
-		if (block->type >= ARRAY_SIZE(rkisp1_ext_params_handlers)) {
-			dev_dbg(params->rkisp1->dev,
-				"Invalid parameters block type\n");
-			return -EINVAL;
-		}
-
-		if (block->size > cfg_size) {
-			dev_dbg(params->rkisp1->dev,
-				"Premature end of parameters data\n");
-			return -EINVAL;
-		}
-
-		if ((block->flags & (RKISP1_EXT_PARAMS_FL_BLOCK_ENABLE |
-				     RKISP1_EXT_PARAMS_FL_BLOCK_DISABLE)) ==
-		   (RKISP1_EXT_PARAMS_FL_BLOCK_ENABLE |
-		    RKISP1_EXT_PARAMS_FL_BLOCK_DISABLE)) {
-			dev_dbg(params->rkisp1->dev,
-				"Invalid parameters block flags\n");
-			return -EINVAL;
-		}
-
-		handler = &rkisp1_ext_params_handlers[block->type];
-		if (block->size != handler->size) {
-			dev_dbg(params->rkisp1->dev,
-				"Invalid parameters block size\n");
-			return -EINVAL;
-		}
-
-		block_offset += block->size;
-		cfg_size -= block->size;
-	}
-
-	if (cfg_size) {
-		dev_dbg(params->rkisp1->dev,
-			"Unexpected data after the parameters buffer end\n");
-		return -EINVAL;
-	}
-
-	return 0;
+	return v4l2_isp_params_validate_buffer(params->rkisp1->dev, vb,
+				(struct v4l2_isp_params_buffer *)cfg,
+				rkisp1_ext_params_blocks_info,
+				ARRAY_SIZE(rkisp1_ext_params_blocks_info));
 }
 
 static int rkisp1_params_vb2_buf_prepare(struct vb2_buffer *vb)

-- 
2.51.0


