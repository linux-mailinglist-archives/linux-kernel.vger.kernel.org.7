Return-Path: <linux-kernel+bounces-764544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F331B2245D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC33B1B66CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030402EACF2;
	Tue, 12 Aug 2025 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgKceKoq"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827A2853F3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993505; cv=none; b=qE0nNXTiuetQikORxY+hzo+J/tGuIbtO8vuNP2Cf5eIoUV+dkAsHPVlguOeL91aPGS1YrSeE80wlwOTasu0EYq3lBQOCgodZufZfVNLWlyRWS4BGWzsHLMdrcAVMNycz3GYJEpBlLIzo0hWZ7y6b4SuYcx8m/23eYpGxlPF1ibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993505; c=relaxed/simple;
	bh=pkMs+cneLnoDVrNbo9gVFUWUh/TIDNzT9Wk/+obn0BE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbfuXRlL4vPwz6Z8ayFz5+x7x9/Sa52jcHmIKCibbP1EKqXMMcvdxV8M8pNBD5PocCH32md+kK951rBWROHL2A3iP6qGReOcUuNF7p7q0s/6j7JybNNYb+nv15yH12cQ5z1N328IkyxiBFRbu1TNHWaHAHrma30sRCI6fdT/CzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgKceKoq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bc5e68e26so4871211b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754993503; x=1755598303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3fgtXN5rRXHOe1ck5n3dKX8NCGLvm4nzF6Ux8XvV2gs=;
        b=KgKceKoqTO3OvppPIz+ko2x87hlC83tAzEb1J88Txoetw6+7L7VTYWWRk3gS+K60hq
         z9TIBPTP+qMPu2tBJ2WeTFiIoaxTSq5PZ5tArNQ9ZUYCZJFK/ibXjX3EK1kSUGrYn+UR
         9kRa28A82I1m4I0gwqtIbgrDZmI1LvghNHYSOV9qlVnCTKECvjpRcaAYew9Hf+3A5AVX
         VURMYZQJmgYjqqpD52aIAgdd7au4As3VkytR5uhFr3+JEZ7O5ZvKHK6uZ/euChetuRQL
         TVvWLcy6Fu+NlwKUMXQIJGQ9jZR3ui0ApwPcsEPpEjDkMm5YrP0Sk+V+wyWEio3ZMB/e
         +xOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754993503; x=1755598303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fgtXN5rRXHOe1ck5n3dKX8NCGLvm4nzF6Ux8XvV2gs=;
        b=tscEu2E1Sqb6XK4K4l5z2JA9+zJWnz72hAEtOcqHF+/dvtZcmIbxMkYdQ3zXXPldsH
         1aAlFXCKZJsU9UztEAAGHkySnnLfHNtF+FUCnq46Hnrdwl+2BjOkQ5Vf5IYpej2J8Y4A
         nv+QIJrNiIHz94SSRv/UWYcB8fH913ZHqeS90hRCtR2MGDsUZUO6ZhdTJ6YVb874wcXq
         VKs30GRrj3POmvws3+fMlup8HQMenJ0zfw7Vr0aMJyxf9+jXi9+jiIuzqZaVcLZdQ3vD
         32GC/wY4ejQgaE3MiG5lpDsqMEm3LL2mVoWa5wV424//r04UPxvRvSxTK056oCJlT0Rz
         c9bA==
X-Forwarded-Encrypted: i=1; AJvYcCUxFXbz19jko1KZRP7hFQNwXplLEwoZsGIBmNs9CCbyg2q8FCLBZR8GHKtzd3EUHC2JcT9DHyzA3WCU+C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR29CaYSpSPliUa2HImKleKqMn7StmiOfzim0F3mhd1ZcfWkFx
	mCf+t87kLOaH1OOpUJsm2kFCuAs4SHlnW+Yi4aYXlmFvXCrpJsWwRLTq
X-Gm-Gg: ASbGncsNIkyV7tcywbfTsu5zyJO1BAp8MdC5JaNgw21oi+LVw3LNHRawnDtWrYDWnBW
	AsHmsemk9wsF6PSY44stYolO4ww++RMtEC+ah8O+KGvH7yI2FLdJkbo23eUKZNVqtqnnZ3nub+y
	Mb0h9+Obe0FmeaBgn7PjEiFlC3DYRTq8ZH9/wPs5U3f6dtoGCZPMBWY+ekY1GboGRMvkr4icgeR
	SjAR+X2fxtacywl+2ybJY7nCCHWY3dn0fz58ipEvR6Bh5cDxF8DQ9Bl04TKjXnWSqIwQQWESd4T
	C6w2+62OTS5DcyOvNbTZNUwXiRkvU4OyVQgxzurm1abJEYCejXFxw/6NR0caF+qZ1o9sGjmfXDi
	3buBZ6ByI3Kbj80u5+pd8ad0AfMTJBbwsEykg
X-Google-Smtp-Source: AGHT+IFZMB56+TLUK9FTTWXt/xVo62vy3KzcAIw48udlpbEJwb+VtWN52sGJtvdTKBAk/gkhpGIqWQ==
X-Received: by 2002:a05:6a00:92a7:b0:76b:ffd1:7728 with SMTP id d2e1a72fcca58-76e0dfa08d3mr3840831b3a.17.1754993502833;
        Tue, 12 Aug 2025 03:11:42 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccead450sm29125124b3a.54.2025.08.12.03.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:11:42 -0700 (PDT)
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
Date: Tue, 12 Aug 2025 15:41:19 +0530
Message-ID: <20250812101119.2506-1-rk0006818@gmail.com>
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
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 27 +++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index 2ad33559a33a..e4cc1fb34e94 100644
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
@@ -128,7 +129,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
 
 	err = mdev->funcs->change_opmode(mdev, new_mode);
 	if (err) {
-		DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
+		drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,",
 			  mdev->dpmode, new_mode);
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
@@ -180,7 +182,7 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
 
 	err = mdev->funcs->change_opmode(mdev, new_mode);
 	if (err) {
-		DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
+		drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,",
 			  mdev->dpmode, new_mode);
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


