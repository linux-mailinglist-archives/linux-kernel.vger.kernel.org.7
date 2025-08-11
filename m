Return-Path: <linux-kernel+bounces-761815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E82AAB1FEC3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D4B188BEF5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665C2A29;
	Mon, 11 Aug 2025 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuURFcmf"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96A26AAAA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891126; cv=none; b=ot3bvNBHqSwAhQRDy7Zzcgi6P7d5bamVCRXVnZNMj9QCKB9pR79VYeyrkNnqb21L+hrR/b6xNxJN2+l96In68P/fxRk0gpdmV72+JnIfkTXdRb/g196JpxyWKK/Jsj/jd95IQOw0zn+fV7TOsMKmoV4rTU+59RLdFGowPN/k/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891126; c=relaxed/simple;
	bh=UVGowK4VGDbNTdcg1OrwPZcSwbr78Z/2wjqAenselDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ApUFlbxns7AuQomNcuiBACAdOLekCVKRJu6laRvpYMj+SX9VyX4vTq42OOHUQjwXKhP1U6bEJOMBU8Lf/7IaH1ldhxWDR6xBqeHnEjIW3exTU2AUfvTeW8+SverDHjR6dIzTuUrEN/P3kxGGhYYyP35A3DRG/Ckn7sY2MEKaamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuURFcmf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2401248e4aaso45912375ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754891124; x=1755495924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+SbwLGlkzo48QtnyEGdu0tVgjZp6bv0qkAFAWLUh5M=;
        b=GuURFcmfeol2ZGjRCdWBWfGqKdgrp72Y8S5HKZvyeSU/GaXOhXhZ9rYzOOUKiwZfot
         PvAmQqbr3lxnAFtaaHV1F6pOZWb/byGg6rFWiDE9QV91Gcpm+byRWi4L9xVIjcfccrX2
         d5Dt+fCxQAWoiFQQ691CQVXWitNKXWYqb+e/PenzRiaOtHkdImBfMLNuEExM4uUq57sf
         9VGtuHk+HDhjNTHoG2Fzaz2d+g7YDy9t7UtUUsVunm1ANskagZqxnm8MhYWa2+FsYhGi
         DRQhqrVHCIGrG30e8q7CuKT3WlS3i9sJ8aDnnsOGKkn+uFX31dd1qaI66DRl9mfz8RU9
         0DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754891124; x=1755495924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+SbwLGlkzo48QtnyEGdu0tVgjZp6bv0qkAFAWLUh5M=;
        b=vCZEAV6Dzxw2U60ybGPLp1Lj2e9x9zQegngqgVOmEOHvAe4aVhlwit+CjLJy7y7GDe
         i+0y2OhF5dfW3ert3WCSbB/YKY3Wmfkd+J257EUu8zMhGB/23ZNE4rCiz/BAlmIZLcae
         P2Tc35plFjyohxW8KqaK7MhDDLE41GAdY1Ni0ShXdrJTLqtvPs5H8CvHj7mo2h20BGpX
         ZImYWAXbeBcYjhy1fLOystFfQeEKj7MJw2iGajmSn/joLcaIf/u6/e9KcZTua0jYCLfy
         PRFnACfRI/FueCLR/0vE0nypDRDz+mt4lWo2YBtf6dtyGTz0shokDxgdzB9bwc3Bkekc
         vpng==
X-Forwarded-Encrypted: i=1; AJvYcCUK5y3O+lTYGRzLgQVqa9Q8vidYOqRL0A1PErJMRt3Tkn/U1P+U8ICgGGYQm8GdwRxUZIWoolPLvVXMQ4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN33uURhkx3FXG4FeKmK9U+mexcLgxneukd8WYN/T4nmrFmLDw
	pqY3iSK8qVkvkDIvptKTZmJl4lL6LIJmL6+LH5cpl87QHuAfUsDQ1bVH
X-Gm-Gg: ASbGncu5FxGV9tO6OBEnWkgVSvgfB73QBkix87qeHZPGGReU0QCoWeQ4ZTnDIyLBpDs
	KGvPSfTNlhE43K8x0Srn/Wr6wYj9yLj6EJHwSZrZYOz4ZB/VsicE1hopibXhYmXkXL80GI0H+Mq
	q6JxSmKpOWaHgi9PqQkG8SBr7sPDHhTTJ4f69Hsq2rUVuDI/V+VcGm1fqiGS8GIj3mQnKlG5JYo
	2XitO8UEtPjQ7T/vV7gt0GV3jrpZFsTmSSEZg39ayOv14ECkSOXBRbjECuY3y5IlhhC4G8c+tAm
	z01t3dp6Fl9myc+sR4awkj4gIZlVJPjuGhu/9ZrfxYC+JS97nSzwyn6WhM9olgJYkMXa/WL6eNc
	8h4ZSg9Om4rL1qhJTD82sCMU4iVIXcoHShq2W
X-Google-Smtp-Source: AGHT+IExwAT9Sif1a2vkzk3Xy0KYiI6G1iRI9mcV03pG4buJeritwA3KFQH/LWMzNVpt++ddECdstA==
X-Received: by 2002:a17:902:e5ca:b0:240:9f9:46b1 with SMTP id d9443c01a7336-242c21df7ccmr155670745ad.37.1754891124095;
        Sun, 10 Aug 2025 22:45:24 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a3acfsm262957025ad.146.2025.08.10.22.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:45:23 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com
Subject: [PATCH] drm/komeda: Convert logging in komeda_crtc.c to drm_* with drm_device parameter
Date: Mon, 11 Aug 2025 11:14:59 +0530
Message-ID: <20250811054459.15851-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all dev_err(), dev_warn(), dev_info() and DRM_ERROR/WARN/INFO()
calls in drivers/gpu/drm/arm/display/komeda/komeda_crtc.c with the
corresponding drm_err(), drm_warn(), and drm_info() helpers.

The new drm_*() logging functions take a struct drm_device * as the
first argument. This allows the DRM core to prefix log messages with
the specific DRM device name and instance, which is essential for
distinguishing logs when multiple GPUs or display controllers are present.

This change aligns komeda with the DRM TODO item: "Convert logging to
drm_* functions with drm_device parameter".

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 37 +++++++++++--------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index 2ad33559a33a..b50ce3653ff6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -111,6 +111,7 @@ komeda_crtc_atomic_check(struct drm_crtc *crtc,
 static int
 komeda_crtc_prepare(struct komeda_crtc *kcrtc)
 {
+	struct drm_device *drm = kcrtc->base.dev;
 	struct komeda_dev *mdev = kcrtc->base.dev->dev_private;
 	struct komeda_pipeline *master = kcrtc->master;
 	struct komeda_crtc_state *kcrtc_st = to_kcrtc_st(kcrtc->base.state);
@@ -128,8 +129,8 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
 
 	err = mdev->funcs->change_opmode(mdev, new_mode);
 	if (err) {
-		DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
-			  mdev->dpmode, new_mode);
+		drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,",
+			mdev->dpmode, new_mode);
 		goto unlock;
 	}
 
@@ -142,18 +143,18 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
 	if (new_mode != KOMEDA_MODE_DUAL_DISP) {
 		err = clk_set_rate(mdev->aclk, komeda_crtc_get_aclk(kcrtc_st));
 		if (err)
-			DRM_ERROR("failed to set aclk.\n");
+			drm_err(drm, "failed to set aclk.\n");
 		err = clk_prepare_enable(mdev->aclk);
 		if (err)
-			DRM_ERROR("failed to enable aclk.\n");
+			drm_err(drm, "failed to enable aclk.\n");
 	}
 
 	err = clk_set_rate(master->pxlclk, mode->crtc_clock * 1000);
 	if (err)
-		DRM_ERROR("failed to set pxlclk for pipe%d\n", master->id);
+		drm_err(drm, "failed to set pxlclk for pipe%d\n", master->id);
 	err = clk_prepare_enable(master->pxlclk);
 	if (err)
-		DRM_ERROR("failed to enable pxl clk for pipe%d.\n", master->id);
+		drm_err(drm, "failed to enable pxl clk for pipe%d.\n", master->id);
 
 unlock:
 	mutex_unlock(&mdev->lock);
@@ -164,6 +165,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
 static int
 komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
 {
+	struct drm_device *drm = kcrtc->base.dev;
 	struct komeda_dev *mdev = kcrtc->base.dev->dev_private;
 	struct komeda_pipeline *master = kcrtc->master;
 	u32 new_mode;
@@ -180,8 +182,8 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
 
 	err = mdev->funcs->change_opmode(mdev, new_mode);
 	if (err) {
-		DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
-			  mdev->dpmode, new_mode);
+		drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,",
+			mdev->dpmode, new_mode);
 		goto unlock;
 	}
 
@@ -200,6 +202,7 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
 void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
 			      struct komeda_events *evts)
 {
+	struct drm_device *drm = kcrtc->base.dev;
 	struct drm_crtc *crtc = &kcrtc->base;
 	u32 events = evts->pipes[kcrtc->master->id];
 
@@ -212,7 +215,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
 		if (wb_conn)
 			drm_writeback_signal_completion(&wb_conn->base, 0);
 		else
-			DRM_WARN("CRTC[%d]: EOW happen but no wb_connector.\n",
+			drm_warn(drm, "CRTC[%d]: EOW happen but no wb_connector.\n",
 				 drm_crtc_index(&kcrtc->base));
 	}
 	/* will handle it together with the write back support */
@@ -236,7 +239,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
 			crtc->state->event = NULL;
 			drm_crtc_send_vblank_event(crtc, event);
 		} else {
-			DRM_WARN("CRTC[%d]: FLIP happened but no pending commit.\n",
+			drm_warn(drm, "CRTC[%d]: FLIP happened but no pending commit.\n",
 				 drm_crtc_index(&kcrtc->base));
 		}
 		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
@@ -309,7 +312,7 @@ komeda_crtc_flush_and_wait_for_flip_done(struct komeda_crtc *kcrtc,
 
 	/* wait the flip take affect.*/
 	if (wait_for_completion_timeout(flip_done, HZ) == 0) {
-		DRM_ERROR("wait pipe%d flip done timeout\n", kcrtc->master->id);
+		drm_err(drm, "wait pipe%d flip done timeout\n", kcrtc->master->id);
 		if (!input_flip_done) {
 			unsigned long flags;
 
@@ -562,6 +565,7 @@ static const struct drm_crtc_funcs komeda_crtc_funcs = {
 int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
 			   struct komeda_dev *mdev)
 {
+	struct drm_device *drm = &kms->base;
 	struct komeda_crtc *crtc;
 	struct komeda_pipeline *master;
 	char str[16];
@@ -581,7 +585,7 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
 		else
 			sprintf(str, "None");
 
-		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s).\n",
+		drm_info(drm, "CRTC-%d: master(pipe-%d) slave(%s).\n",
 			 kms->n_crtcs, master->id, str);
 
 		kms->n_crtcs++;
@@ -609,10 +613,11 @@ get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc *crtc)
 	return NULL;
 }
 
-static int komeda_attach_bridge(struct device *dev,
-				struct komeda_pipeline *pipe,
+static int komeda_attach_bridge(struct komeda_pipeline *pipe,
 				struct drm_encoder *encoder)
 {
+	struct drm_device *drm = pipe->mdev->drm;
+	struct device *dev = drm->dev;
 	struct drm_bridge *bridge;
 	int err;
 
@@ -624,7 +629,7 @@ static int komeda_attach_bridge(struct device *dev,
 
 	err = drm_bridge_attach(encoder, bridge, NULL, 0);
 	if (err)
-		dev_err(dev, "bridge_attach() failed for pipe: %s\n",
+		drm_err(drm, "bridge_attach() failed for pipe: %s\n",
 			of_node_full_name(pipe->of_node));
 
 	return err;
@@ -658,7 +663,7 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
 		return err;
 
 	if (pipe->of_output_links[0]) {
-		err = komeda_attach_bridge(base->dev, pipe, encoder);
+		err = komeda_attach_bridge(pipe, encoder);
 		if (err)
 			return err;
 	}
-- 
2.43.0


