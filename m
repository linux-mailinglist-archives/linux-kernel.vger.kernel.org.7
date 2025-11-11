Return-Path: <linux-kernel+bounces-895309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55414C4D74E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FC1189EFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F4357A57;
	Tue, 11 Nov 2025 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9C9GLKF"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1FF357A54
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861055; cv=none; b=RkUmHZ1RXCeOuVEeNTwYXaVYKV6Cuggz/wCyc01GDJ5wYqbVJXoyU075zxQXZy6omtDeR0A2/KL6k8v4sB1jWlv2Xxvi3JPpbBkZsuDL8PY38s75z61uN+OKoNlGrL9j0mKcfzMohpraVrsjMONSOir/ogoKmWlcgUPeQBNo55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861055; c=relaxed/simple;
	bh=/MgPwMVzEXdsbIFFhmbSUn1XnqXwRhuRjFj/SdQ+ciw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bVbzusbm4kNQfzpJiulkMH1Urhv65LIKOQU6Iop94ITxpOvBkxll13NxkpmQPvTrkD8VUjh5QDuyRMTjgKqmmlyY9w8d6s0nYXdh4rB5rrDnVLOUS24ErOINMnRKy67SIG/XZh1uRhWUWI2R1+PPVIVIMCuuxgjW8cnwGZxMjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9C9GLKF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34381ec9197so2445199a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762861053; x=1763465853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKj1IvLy5c2i5aotV94CJILL6XNH/z+FL6hHNrbGtSM=;
        b=k9C9GLKFR37Nl/8dHo1VZP90HDbxkeyuhiSow4mNrFAKMzmk/6dxMv5MWhA1frSPu/
         TvMqJ1QsVF55fbZYFfpMkshBJ6OMcffayHipeULVuzAJOOOH8uKprd9+sMrqHmvCDAoe
         ylqUcg7VGgqBg76mikWFa7TN9kUkVGl8vfe9BuL9bhMVCgEZnBm2qIk/q75P3PHeZI+N
         Po7ezHYqpq+gQVElTiOtx12Dr5u/BdreE3qIE1xBcNOkWjkR+Zv97HoPjkjqKsS1XJX+
         w6tANzTM+tl36B5k5ckgoLnFHzcHAJrXOVAtaasKNffLoFCS33ZsOUKD/DGPXga0QE9Q
         RQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861053; x=1763465853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKj1IvLy5c2i5aotV94CJILL6XNH/z+FL6hHNrbGtSM=;
        b=KMA2zWUrcpECBp/r35rs2fOk2gLmgCf8BiWuCB9X5cM4uIZMV0oBIy/gtncbml/Kyn
         UxMwAum9gUGjVv2CuanI89Ww/vGu9h3/QLktZLx/OVXUeul/oMScq/Amn+3EJ8tllYc+
         EeAqicepV8X2VRkIQYFSUkeGDPv9M2eQDl3VNAKnXXtds43RQai/4Y6gCaQDaOqyD+rC
         PjY4ONRDGItDoA82+l03Rsb5cYbGd/HVq0o7sdxd0A+bxrUdyVQ1J+094QDxcIxdJxRk
         fJs1i/Ctc+m7rW4muxzRz0xpUCgaWhaEWY+58U9pSj/zxotRWOgCrl6Y4WfH4n9uX5Eo
         a+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+eJ5T9ioFZAAJ4Cna5ocx99aqy4szePAS+N9/obWjcxFLdbjW0RoKw2lixaV4Csk1xeSIPniR7QRNIe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDJomZru1fLfcYAOexDG/oMbV8Asz2lWg0UJ4WobU0tLqwu0y
	2EuNoXlXtPvpXflPwHRr9k9tZOL5Hzvn7KiRV/zxBBVxtXEteO3u6LPg
X-Gm-Gg: ASbGnctDvk8cto3b3Prd3xSqznGS7DJeOae81aZzcf3uCqUDJyPJJ/VKJ4Q/N2v9RfN
	RM3d6Uxb1bzhEYIuY9I7YSdn3G2fIIsCj/ZIDGKYNVQNyGmycLgZerdK6NzR9gGxX7pbLNrVmNK
	w8fjywNXgPzVehVAHe29djb+TQXneQpRIzQD606jVfCqqby+sPeJpevOZ8m2ZHcrdOy4FuxftR5
	dcy5RXng+5CQ4SKnkkB6Asafj3kE1TOA3xouJdufsMJMU7cZOxu6SyOARRM/NcNbn2kiS7ntf+B
	f4igLWb4oQ23sD7FHHITg0v3sPFZZ/IgOlKuzAvjMHHOFTvod58Wwoh2crVfIlVLWWxAGr4HgAc
	FY/TIGl1IIT8v/WzhU8wGSs3HVFr+YwhvaROfEzTCacWSkRFyhDW7MV/quqoq7ogH7rfUHcM661
	1HmWANUzzUVpu0IH11i/nz5d0yXDNg
X-Google-Smtp-Source: AGHT+IGjxi0V+gnnbb+bhG8XDgM5LZDOYM3GDNlnKgiYoSvZUnLKPh+1D38yKt7FiZfh6R6R+84haQ==
X-Received: by 2002:a17:90b:2fcd:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-3436cb227c9mr13365843a91.15.1762861053348;
        Tue, 11 Nov 2025 03:37:33 -0800 (PST)
Received: from rahul-mintos.ban-spse ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902c9d0d4sm15048526a12.36.2025.11.11.03.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:37:33 -0800 (PST)
From: Abhishek Rajput <abhiraj21put@gmail.com>
To: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	abhiraj21put@gmail.com
Subject: [PATCH] drm/komeda: Convert logging in d71_component.c to drm_* with drm_device parameter
Date: Tue, 11 Nov 2025 17:07:17 +0530
Message-ID: <20251111113717.139401-1-abhiraj21put@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace DRM_ERROR() calls in
drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
with the corresponding drm_err() helper.

The drm_*() logging helpers take a struct drm_device * as the first
argument, allowing the DRM core to prefix log messages with the
corresponding device instance. This improves log traceability when
multiple display controllers are present.

The drm_device pointer is now safely obtained using
komeda_kms_attach(d71->mdev), ensuring proper initialization and
alignment with Komeda’s internal design.

This change aligns komeda with the DRM TODO item:
"Convert logging to drm_* functions with drm_device parameter".

Signed-off-by: Abhishek Rajput <abhiraj21put@gmail.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 34 ++++++++++++++-----
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
index 67e5d3b4190f..3524ca623d6e 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -409,6 +409,8 @@ static const struct komeda_component_funcs d71_layer_funcs = {
 static int d71_layer_init(struct d71_dev *d71,
 			  struct block_header *blk, u32 __iomem *reg)
 {
+	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
+	struct drm_device *drm = &kms->base;
 	struct komeda_component *c;
 	struct komeda_layer *layer;
 	u32 pipe_id, layer_id, layer_info;
@@ -421,7 +423,7 @@ static int d71_layer_init(struct d71_dev *d71,
 				 get_valid_inputs(blk),
 				 1, reg, "LPU%d_LAYER%d", pipe_id, layer_id);
 	if (IS_ERR(c)) {
-		DRM_ERROR("Failed to add layer component\n");
+		drm_err(drm, "Failed to add layer component\n");
 		return PTR_ERR(c);
 	}
 
@@ -527,6 +529,8 @@ static const struct komeda_component_funcs d71_wb_layer_funcs = {
 static int d71_wb_layer_init(struct d71_dev *d71,
 			     struct block_header *blk, u32 __iomem *reg)
 {
+	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
+	struct drm_device *drm = &kms->base;
 	struct komeda_component *c;
 	struct komeda_layer *wb_layer;
 	u32 pipe_id, layer_id;
@@ -539,7 +543,7 @@ static int d71_wb_layer_init(struct d71_dev *d71,
 				 1, get_valid_inputs(blk), 0, reg,
 				 "LPU%d_LAYER_WR", pipe_id);
 	if (IS_ERR(c)) {
-		DRM_ERROR("Failed to add wb_layer component\n");
+		drm_err(drm, "Failed to add wb_layer component\n");
 		return PTR_ERR(c);
 	}
 
@@ -837,6 +841,8 @@ static const struct komeda_component_funcs d71_scaler_funcs = {
 static int d71_scaler_init(struct d71_dev *d71,
 			   struct block_header *blk, u32 __iomem *reg)
 {
+	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
+	struct drm_device *drm = &kms->base;
 	struct komeda_component *c;
 	struct komeda_scaler *scaler;
 	u32 pipe_id, comp_id;
@@ -851,7 +857,7 @@ static int d71_scaler_init(struct d71_dev *d71,
 				 pipe_id, BLOCK_INFO_BLK_ID(blk->block_info));
 
 	if (IS_ERR(c)) {
-		DRM_ERROR("Failed to initialize scaler");
+		drm_err(drm, "Failed to initialize scaler");
 		return PTR_ERR(c);
 	}
 
@@ -945,6 +951,8 @@ static const struct komeda_component_funcs d71_splitter_funcs = {
 static int d71_splitter_init(struct d71_dev *d71,
 			     struct block_header *blk, u32 __iomem *reg)
 {
+	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
+	struct drm_device *drm = &kms->base;
 	struct komeda_component *c;
 	struct komeda_splitter *splitter;
 	u32 pipe_id, comp_id;
@@ -959,7 +967,7 @@ static int d71_splitter_init(struct d71_dev *d71,
 				 "CU%d_SPLITTER", pipe_id);
 
 	if (IS_ERR(c)) {
-		DRM_ERROR("Failed to initialize splitter");
+		drm_err(drm, "Failed to initialize splitter");
 		return -1;
 	}
 
@@ -1015,6 +1023,8 @@ static const struct komeda_component_funcs d71_merger_funcs = {
 static int d71_merger_init(struct d71_dev *d71,
 			   struct block_header *blk, u32 __iomem *reg)
 {
+	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
+	struct drm_device *drm = &kms->base;
 	struct komeda_component *c;
 	struct komeda_merger *merger;
 	u32 pipe_id, comp_id;
@@ -1030,7 +1040,7 @@ static int d71_merger_init(struct d71_dev *d71,
 				 "CU%d_MERGER", pipe_id);
 
 	if (IS_ERR(c)) {
-		DRM_ERROR("Failed to initialize merger.\n");
+		drm_err(drm, "Failed to initialize merger.\n");
 		return PTR_ERR(c);
 	}
 
@@ -1126,6 +1136,8 @@ static const struct komeda_component_funcs d71_improc_funcs = {
 static int d71_improc_init(struct d71_dev *d71,
 			   struct block_header *blk, u32 __iomem *reg)
 {
+	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
+	struct drm_device *drm = &kms->base;
 	struct komeda_component *c;
 	struct komeda_improc *improc;
 	u32 pipe_id, comp_id, value;
@@ -1139,7 +1151,7 @@ static int d71_improc_init(struct d71_dev *d71,
 				 get_valid_inputs(blk),
 				 IPS_NUM_OUTPUT_IDS, reg, "DOU%d_IPS", pipe_id);
 	if (IS_ERR(c)) {
-		DRM_ERROR("Failed to add improc component\n");
+		drm_err(drm, "Failed to add improc component\n");
 		return PTR_ERR(c);
 	}
 
@@ -1253,6 +1265,8 @@ static const struct komeda_component_funcs d71_timing_ctrlr_funcs = {
 static int d71_timing_ctrlr_init(struct d71_dev *d71,
 				 struct block_header *blk, u32 __iomem *reg)
 {
+	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
+	struct drm_device *drm = &kms->base;
 	struct komeda_component *c;
 	struct komeda_timing_ctrlr *ctrlr;
 	u32 pipe_id, comp_id;
@@ -1266,7 +1280,7 @@ static int d71_timing_ctrlr_init(struct d71_dev *d71,
 				 1, BIT(KOMEDA_COMPONENT_IPS0 + pipe_id),
 				 BS_NUM_OUTPUT_IDS, reg, "DOU%d_BS", pipe_id);
 	if (IS_ERR(c)) {
-		DRM_ERROR("Failed to add display_ctrl component\n");
+		drm_err(drm, "Failed to add display_ctrl component\n");
 		return PTR_ERR(c);
 	}
 
@@ -1280,6 +1294,8 @@ static int d71_timing_ctrlr_init(struct d71_dev *d71,
 int d71_probe_block(struct d71_dev *d71,
 		    struct block_header *blk, u32 __iomem *reg)
 {
+	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
+	struct drm_device *drm = &kms->base;
 	struct d71_pipeline *pipe;
 	int blk_id = BLOCK_INFO_BLK_ID(blk->block_info);
 
@@ -1346,8 +1362,8 @@ int d71_probe_block(struct d71_dev *d71,
 		break;
 
 	default:
-		DRM_ERROR("Unknown block (block_info: 0x%x) is found\n",
-			  blk->block_info);
+		drm_err(drm, "Unknown block (block_info: 0x%x) is found\n",
+			blk->block_info);
 		err = -EINVAL;
 		break;
 	}
-- 
2.43.0


