Return-Path: <linux-kernel+bounces-833820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10245BA325A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FA77AF13F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7793E2836A6;
	Fri, 26 Sep 2025 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxOEmi//"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2522C19FA8D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879033; cv=none; b=LCC4H4euaT8LjFG/TW+LEOyUxktb8TukveXo1DbP7rewsSKehfGgWJnlx5/YdHkYvaED5Ai3EQmpno+hzrOdHcxk9TB0sfMe9GzIwq1jy/9HRwz/kVIg7o0qxE2P9YRWTA1mN/IBFDuHd9SMrr09SmezTJy1jnGfgUA8os+imxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879033; c=relaxed/simple;
	bh=jsaDXrvFd+opyQe9qY5lje0lqnMdfeVW1SeWz23pFVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxYzWSWb4gHTkpWWO4Sb2msCYcQb5a7P85u7sfRYoYWHIvo28J31b1MQ/sIUb/c9aQ2skfRjjVhXIOZCxqC+j6s+bDKz9PrbTI53Ugh3SK9bga6ujBfqwPudKGlrJYosRNDmhFWI7JymkRcXh3cy6T9vdoKfNxVkXguF3fINUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxOEmi//; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b551350adfaso1846464a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879031; x=1759483831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xIrcfuajKloRdvJjcJcWDV/tHO/j0RB4pp+HMPl3L4g=;
        b=JxOEmi//wlcpQC1/c368ka1oVc19JD+sj+pxEYCNzZ1OXP1SxBNvzoiIEvxyhrM1UX
         xpwBfuLfDfMW58bIUcHKCaoHl5r3z+a1lJhgPGTWyJ/gaRXRtRe2e9CMZQUmZS8BOMOY
         C4KovdMjc5ca3G1Huai5q0h5PdhPXb5sVxGCwYawDGo+vsAp3d02moL8839ggszWMW9k
         Jh/CchIqBhRt1y/+0Phajrdyi3YQ43mRyoZZWAiGjRp2SDmdv7Rfnq8uChjK1tf/U6yR
         wWm4sif3XZqf7AwFxc8r/lOj+qeEOZJnfBkGVus9zyuN5201PnBwsMdMb86M6d14EJQz
         OIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879031; x=1759483831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIrcfuajKloRdvJjcJcWDV/tHO/j0RB4pp+HMPl3L4g=;
        b=u+ZlhTHc/NfndF8dh/m/n/9AUow+nbOwH8YjbcMAMP8I0ljHiJrkAfAIz9Jw6uIrb5
         ymbE5nKMDPtkLO06VdMqaHO8n1sc6RbolVg58rm0CaJERRjzTkFp9wF8w8HCnnsvih3u
         5w17LGHQJln85v1N8dXLhg2EhAYZFlsC/yJkQP/ZnCbwb6iO9mvaCysLEUMdDl9b/y/Y
         qbrfgu8ExhPjhLZxbELEfbGDNn3LxJos0Baq086MM2oFIpjIDU65nx/rbWGY1KSVhNri
         9WzDQn9RLtY4+Op5MAdPsOqmAUDS7TdufogLG6ehcfWMxoj+qGPoXYOEBSKgRIVU/5Ug
         gIyA==
X-Forwarded-Encrypted: i=1; AJvYcCVLm+jd2dhmsN6KDtr+eEYfdoQgpVHEmpXsdruole+ygxwiOrAbINJZ2fbhVTjEjvcxUT5Aj2ISESMPpmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7zRVyE/OZI+TLU1Fl4MkM5IUjG7XboSCAJR8+aZsqdGT+mW7R
	iOZuxQRN+tQlTOrXZg2+N2jA04bck0KG7wiC0L0TuAPjRGHPD5lNPPZk
X-Gm-Gg: ASbGncuqKZkzsx+BL/Pqdpu4drr+gPEuMHUzI4qebSi8UB8Grj4woVzUJuXoEjJEHtU
	QttDlarmj6YOBQH2BJ7Jt61JuEEZLoOxMCyOM2yt3syzLC8+C09/X98HDQ9HtuuM5jUcrL/BnPi
	7lOBLX9tCvZyC0dqLD6KSOPEBiVLLvaK1P6bPUbD6GnD/1YCJjxZvn06lzSFg4PA2n7tQ7RSWYD
	a28Gudp57iEAIyEIKCotJ8/eJSozq2oZZfZG8aZEBT2iDCj3FQT+dpcgWHwGaP9vdV/MYkt52h4
	e7Ffn6C0RfxlYLsB2XL/LTIi0lB204FSvv2SoKREDtJUnxvFGV2pR0rSRZJMj5d1uCqJq2DLf1W
	StxnIQNdy3aaqnP47fIa+fCf9nLT4LmgeAtX3yVBuX7RvsnE=
X-Google-Smtp-Source: AGHT+IFh/+YHDIq4RGXYffEQZgqis2V02Xt7mq2qDUgh7Tj46rZmWeOaWQ9Ju5fqSzoyMvNSy1QcEA==
X-Received: by 2002:a05:6a20:9150:b0:249:d3d:a4d4 with SMTP id adf61e73a8af0-2e7c7ea3a75mr8452854637.26.1758879031332;
        Fri, 26 Sep 2025 02:30:31 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238b19dsm4048646b3a.10.2025.09.26.02.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:30:31 -0700 (PDT)
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
Subject: [PATCH v3] drm/komeda: Convert logging in komeda_crtc.c to drm_* with drm_device parameter
Date: Fri, 26 Sep 2025 15:00:08 +0530
Message-ID: <20250926093008.1949131-1-rk0006818@gmail.com>
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
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
Changes since v2:
- Added Reviewed-by tag from Liviu Dudau

Link to v1:
https://lore.kernel.org/all/aJshoswGslcYQFLI@e110455-lin.cambridge.arm.com/
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index 2ad33559a33a..5a66948ffd24 100644
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
@@ -613,6 +617,7 @@ static int komeda_attach_bridge(struct device *dev,
 				struct komeda_pipeline *pipe,
 				struct drm_encoder *encoder)
 {
+	struct drm_device *drm = encoder->dev;
 	struct drm_bridge *bridge;
 	int err;
 
@@ -624,7 +629,7 @@ static int komeda_attach_bridge(struct device *dev,
 
 	err = drm_bridge_attach(encoder, bridge, NULL, 0);
 	if (err)
-		dev_err(dev, "bridge_attach() failed for pipe: %s\n",
+		drm_err(drm, "bridge_attach() failed for pipe: %s\n",
 			of_node_full_name(pipe->of_node));
 
 	return err;
-- 
2.43.0


