Return-Path: <linux-kernel+bounces-888395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD8C3AAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1AC189C7AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA18030CDA4;
	Thu,  6 Nov 2025 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="RVSwMCzi"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA93148C2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429711; cv=none; b=pc9oImwggi2ujtuIrNysmkPSPx3XEHh4koMR7pTHVfvcZbvFcDaJNjIp01qDRFBZ5OaW7ibQj/w68kaejpJIZQECoj1f52VUudc51SpHdtuNhb+aHxWWPNdEblsUM+tghlGcQlS5MdLMPXb+K7Nf8I+Ly9zGtYROEA2WgNTWllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429711; c=relaxed/simple;
	bh=LaQpUKmFQ1HoJ8RgD1TA7J8O6h83r8Qm+ZBLq4dao1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rJG6l8UhIc4pcL1atpHLUeJWY43uzEPQS0bw7eQSOD0f0GPQaMqB0xEXu7OTusU/VP5PwSQx0oGQCw9Ak1M4u+TpT6vrsBkFT0vlmNUCyAWWrKiXH5L9Quhi+K79xhMwsskHl92k2SGaQapbIAzEPvQjLf7E+ciosDqV6mhwr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=RVSwMCzi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso886883b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1762429707; x=1763034507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aiu6UYObNyFRnGMMXknuXL/ChxL/XTeOYAU4v8VOrrE=;
        b=RVSwMCzi4pbHEcrS+Omyp/NHkrusxwk0sOqYDozGP6FEPOk4bcCySrhk337hwnjsEH
         kTESkR0PKG43g+3P/O3y4ag96nj4+a41xSSV8EymQ6wRAL1nxeGa4wK1Gqx6sFEl8D+G
         RgzP6+StsP/FoCgNOzEOBe+KO+KCuLkeri8QHfx3lvlgLLeK3xgY3oxL7Z260i6DYRqE
         hkJNw1y2ZS0SBMnSEIdEA+drXYeCpx4JOvSKvVG+pPk+o2Fuk6IycKaFyhSwW6rS+TQz
         CqbHiV+kmZWElq+yHHOYvWkqXtam4HMaZ0C6GCJevwHiiw6FNKDx2SaTKBDpmoozsKrv
         JkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429707; x=1763034507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aiu6UYObNyFRnGMMXknuXL/ChxL/XTeOYAU4v8VOrrE=;
        b=EYAhu9RQ3MmpZ+mKpqNf79BjV4vvts9FDOZt37Gvyr+gh07/ofkmrIz08G1HCsu6fI
         IPJkByJxLGxlax7gRkpyLP6m3nvy8sTUHr8RPRq03EJBVT+YOOr1BPmcu8mfpYOoG49r
         um2yKr1oJU5SekPGi0kXOWoZWWA4ysk4Nh3G6dVpOCmI2YDbNisQOScfI7NIKqziLRcW
         dSHfj6iNMGJZpUVNjG8xK925t8dhItanUCUTlbSxEVhWI5M3FVl3lbM6FTPZMzBuY/oW
         shGqZG7eDT2q/cLEq29WkqwRIwn/C4FGxmP9hQJ07opYI7yGgjVmMqGn79RTfGimte96
         DeWg==
X-Forwarded-Encrypted: i=1; AJvYcCVkcgroBi0+IoZIaUU2p0qdGXh+ikvV5Lti0I02DS+0aOUffIbmQHEsF1MMx6V7hnHx8SXZOVRpWpkSuAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdyJFuhJODy4VyNs+q4iLB+GP5nttOufpqYmg3tHaZu9eMFqNE
	G7+lMfDRQoJyDp7b2Np+cEDn5sEOOAKEpfOaz4sth5VgVpBMUxKV6OU+qah0Av15VuKb8ro5gjr
	hqkaU
X-Gm-Gg: ASbGncu6rGNcfkCOvfBenNagW964fK2FhUnlZOeD1Z3Fh/3WJ42XoMt9qwk4WQIkbxJ
	x48dr6SSijCAbWkcTrPFzky7q4vPD/ovW57dlGrJGhrLTxMsRip6M7R3pK/ICxPbw23v0ifoVZP
	JGUT4Obe4ytX/1DFsCKmYyCYtQX7OaiI1WgCAjtTfLVhCnK1+7i1y61IV5AhBPMjgA2cYrd1K72
	7axaEHe08CLQjZO7lLl+0ArjNLegcLHwlKyGg1erqHCssERpDOQaYfxV7aMtVSHZAzr1jbkqaeU
	8E3iPKGPyZcxJbvp0+IKhHpARywNYBQrK4FSArQSItGAzSMtcTT6LqhbRAjrDa71Jx+Lq7XtAQ9
	xPxvTd+MKK1Qu8YSx8BgOtcJMcAemUlRPsyQ98bfSG6jn3LlzfOMfLiW+PU8/25lsEAYiOzXJdf
	MZGrSbBZTiR+lcB7kwlFoRMByTebo7ReHFtrKaUZC42r0nHbU=
X-Google-Smtp-Source: AGHT+IE1xrlkqIX5O8nY5UQVTJetxH1Fz5NjUVVU0aIlEE+5symWHBD9ac08zk8Z6ZitGMR4+vdyNw==
X-Received: by 2002:a05:6a00:4b0c:b0:7ab:c5b9:615f with SMTP id d2e1a72fcca58-7ae1f881089mr7680773b3a.22.1762429707539;
        Thu, 06 Nov 2025 03:48:27 -0800 (PST)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af827effebsm2478330b3a.57.2025.11.06.03.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:48:27 -0800 (PST)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	jesszhan0024@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel: ilitek-ili9882t: Switch Tianma TL121BVMS07 to DSC 120Hz mode
Date: Thu,  6 Nov 2025 19:48:18 +0800
Message-Id: <20251106114818.1871161-1-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate the TL121BVMS07 panel from non-DSC 60 Hz to DSC-enabled 120 Hz,
including updated init sequence, DSC configuration, and display timings.

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 147 ++++++++++++++++--
 1 file changed, 136 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index c52f20863fc7..370424ddfc80 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -8,6 +8,8 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
+#include <drm/display/drm_dsc.h>
+#include <drm/display/drm_dsc_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
@@ -15,6 +17,8 @@
 
 #include <video/mipi_display.h>
 
+#define DSC_BPG_OFFSET(x)	((u8)((x) & DSC_RANGE_BPG_OFFSET_MASK))
+
 struct ili9882t;
 
 /*
@@ -23,6 +27,7 @@ struct ili9882t;
  */
 struct panel_desc {
 	const struct drm_display_mode *modes;
+	const struct drm_dsc_config *dsc;
 	unsigned int bpc;
 
 	/**
@@ -52,6 +57,8 @@ struct ili9882t {
 	struct regulator *avee;
 	struct regulator *avdd;
 	struct gpio_desc *enable_gpio;
+
+	struct drm_dsc_config dsc;
 };
 
 /* ILI9882-specific commands, add new commands as you decode them */
@@ -68,6 +75,67 @@ struct ili9882t {
 	mipi_dsi_dcs_write_seq_multi(ctx, IL79900A_DCS_SWITCH_PAGE, \
 				     0x5a, 0xa5, (page))
 
+static const struct drm_dsc_config tianma_il79900a_dsc = {
+	.dsc_version_major = 1,
+	.dsc_version_minor = 2,
+	.slice_height = 8,
+	.slice_width = 800,
+	.slice_count = 2,
+	.bits_per_component = 8,
+	.bits_per_pixel = 8 << 4,
+	.block_pred_enable = true,
+	.native_420 = false,
+	.native_422 = false,
+	.simple_422 = false,
+	.vbr_enable = false,
+	.rc_model_size = DSC_RC_MODEL_SIZE_CONST,
+	.pic_width = 1600,
+	.pic_height = 2560,
+	.convert_rgb = 0,
+	.vbr_enable = 0,
+	.rc_buf_thresh = {14, 28, 42, 56, 70, 84, 98, 105, 112, 119, 121, 123, 125, 126},
+	.rc_model_size = DSC_RC_MODEL_SIZE_CONST,
+	.rc_edge_factor = DSC_RC_EDGE_FACTOR_CONST,
+	.rc_tgt_offset_high = DSC_RC_TGT_OFFSET_HI_CONST,
+	.rc_tgt_offset_low = DSC_RC_TGT_OFFSET_LO_CONST,
+	.mux_word_size = DSC_MUX_WORD_SIZE_8_10_BPC,
+	.line_buf_depth = 9,
+	.first_line_bpg_offset = 12,
+	.initial_xmit_delay = 512,
+	.initial_offset = 6144,
+	.rc_quant_incr_limit0 = 11,
+	.rc_quant_incr_limit1 = 11,
+	.nfl_bpg_offset = 1402,
+	.rc_range_params = {
+		{ 0,  4, DSC_BPG_OFFSET(2)},
+		{ 0,  4, DSC_BPG_OFFSET(0)},
+		{ 1,  5, DSC_BPG_OFFSET(0)},
+		{ 1,  6, DSC_BPG_OFFSET(-2)},
+		{ 3,  7, DSC_BPG_OFFSET(-4)},
+		{ 3,  7, DSC_BPG_OFFSET(-6)},
+		{ 3,  7, DSC_BPG_OFFSET(-8)},
+		{ 3,  8, DSC_BPG_OFFSET(-8)},
+		{ 3,  9, DSC_BPG_OFFSET(-8)},
+		{ 3, 10, DSC_BPG_OFFSET(-10)},
+		{ 5, 10, DSC_BPG_OFFSET(-10)},
+		{ 5, 11, DSC_BPG_OFFSET(-12)},
+		{ 5, 11, DSC_BPG_OFFSET(-12)},
+		{ 9, 12, DSC_BPG_OFFSET(-12)},
+		{12, 13, DSC_BPG_OFFSET(-12)},
+	},
+	.initial_scale_value = 32,
+	.slice_chunk_size = 800,
+	.initial_dec_delay = 657,
+	.final_offset = 4320,
+	.scale_increment_interval = 222,
+	.scale_decrement_interval = 11,
+	.initial_scale_value = 32,
+	.nfl_bpg_offset = 3511,
+	.slice_bpg_offset = 2179,
+	.flatness_max_qp = 12,
+	.flatness_min_qp = 3,
+};
+
 static int starry_ili9882t_init(struct ili9882t *ili)
 {
 	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
@@ -423,22 +491,72 @@ static int starry_ili9882t_init(struct ili9882t *ili)
 static int tianma_il79900a_init(struct ili9882t *ili)
 {
 	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
+	struct drm_dsc_picture_parameter_set pps;
 
 	mipi_dsi_usleep_range(&ctx, 5000, 5100);
 
 	il79900a_switch_page(&ctx, 0x06);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3e, 0x62);
 
+	il79900a_switch_page(&ctx, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x00);
+
 	il79900a_switch_page(&ctx, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1b, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1b, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5d, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5e, 0x40);
 
+	il79900a_switch_page(&ctx, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0X9e, 0xe9);
+
 	il79900a_switch_page(&ctx, 0x07);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0X29, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0X29, 0x01);
+
+	il79900a_switch_page(&ctx, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x00,
+				     0x00, 0x89, 0x30, 0x80, 0x0a, 0x00, 0x06, 0x40, 0x00,
+				     0x08, 0x03, 0x20, 0x03, 0x20, 0x02, 0x00, 0x02, 0x91,
+				     0x00, 0x20, 0x00, 0xde, 0x00, 0x0b, 0x00, 0x0c, 0x0d,
+				     0xb7, 0x08, 0x83, 0x18, 0x00, 0x10, 0xe0, 0x03, 0x0c,
+				     0x20, 0x00, 0x06, 0x0b, 0x0b, 0x33, 0x0e, 0x1c, 0x2a,
+				     0x38, 0x46, 0x54, 0x62, 0x69, 0x70, 0x77, 0x79, 0x7b,
+				     0x7d, 0x7e, 0x01, 0x02, 0x01, 0x00, 0x09, 0x40, 0x09,
+				     0xbe, 0x19, 0xfc, 0x19, 0xfa, 0x19, 0xf8, 0x1a, 0x38,
+				     0x1a, 0x78, 0x1a, 0xb6, 0x2a, 0xb6, 0x2a, 0xf4, 0x2a,
+				     0xf4, 0x4b, 0x34, 0x63, 0x74);
 
 	il79900a_switch_page(&ctx, 0x06);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x92, 0x22);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x91, 0x45);
+
+	il79900a_switch_page(&ctx, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x03, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x04, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x05, 0xdf);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x00, 0x01);
+
+	il79900a_switch_page(&ctx, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x12, 0x8c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x14, 0x3c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x15, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1d, 0xfc);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x25, 0x9d);
+
+	il79900a_switch_page(&ctx, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc0, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2a, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x38, 0xcd);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x80, 0x53);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x81, 0x0e);
+
+	il79900a_switch_page(&ctx, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x61, 0x5c);
+
+	drm_dsc_pps_payload_pack(&pps, &tianma_il79900a_dsc);
+
+	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
+
+	mipi_dsi_compression_mode_ext_multi(&ctx, true,
+					    MIPI_DSI_COMPRESSION_DSC, 1);
 
 	il79900a_switch_page(&ctx, 0x00);
 	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
@@ -447,9 +565,9 @@ static int tianma_il79900a_init(struct ili9882t *ili)
 
 	mipi_dsi_dcs_set_display_on_multi(&ctx);
 
-	mipi_dsi_msleep(&ctx, 80);
+	mipi_dsi_msleep(&ctx, 20);
 
-	return 0;
+	return ctx.accum_err;
 };
 
 static inline struct ili9882t *to_ili9882t(struct drm_panel *panel)
@@ -569,15 +687,15 @@ static const struct drm_display_mode starry_ili9882t_default_mode = {
 };
 
 static const struct drm_display_mode tianma_il79900a_default_mode = {
-	.clock = 264355,
+	.clock = 543850,
 	.hdisplay = 1600,
 	.hsync_start = 1600 + 20,
-	.hsync_end = 1600 + 20 + 4,
-	.htotal = 1600 + 20 + 4 + 20,
+	.hsync_end = 1600 + 20 + 2,
+	.htotal = 1600 + 20 + 2 + 20,
 	.vdisplay = 2560,
-	.vsync_start = 2560 + 82,
-	.vsync_end = 2560 + 82 + 2,
-	.vtotal = 2560 + 82 + 2 + 36,
+	.vsync_start = 2560 + 62,
+	.vsync_end = 2560 + 62 + 2,
+	.vtotal = 2560 + 62 + 2 + 136,
 	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
 };
 
@@ -597,6 +715,7 @@ static const struct panel_desc starry_ili9882t_desc = {
 
 static const struct panel_desc tianma_tl121bvms07_desc = {
 	.modes = &tianma_il79900a_default_mode,
+	.dsc = &tianma_il79900a_dsc,
 	.bpc = 8,
 	.size = {
 		.width_mm = 163,
@@ -716,6 +835,12 @@ static int ili9882t_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = desc->mode_flags;
 	ili->desc = desc;
 	ili->dsi = dsi;
+
+	if (desc->dsc) {
+		ili->dsc = *desc->dsc;
+		dsi->dsc = &ili->dsc;
+	}
+
 	ret = ili9882t_add(ili);
 	if (ret < 0)
 		return ret;
-- 
2.34.1


