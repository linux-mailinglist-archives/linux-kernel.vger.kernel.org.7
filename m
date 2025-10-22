Return-Path: <linux-kernel+bounces-864595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FFABFB244
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C6119A2D26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AE326CE2D;
	Wed, 22 Oct 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9mtF2pv"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816172FA0E9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124967; cv=none; b=sG2qPfaokzDB0XKvYgRqR3MtEre8lFXaE49wNj87XseoBTaZNp7GeKdDwW50GYCOL4t/6skOXvpeCesGjn11Nx9gtFz6czDWXJUM6bAAebIzCkNTzDh445iCHY5BO/cBmDEY/8Wpu2bZZ8Jbvml/hON8J4OFXxw6Gk7JpyOEMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124967; c=relaxed/simple;
	bh=5eJVCN65aWpTd/ibf819VRR+4EAugWqgoENJJjBvBfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sxq5gRtF7KixCf+xkV3EHdSUe1qG9ygyCDDPtTwPL83QxnjudyzF9jtLJPREadQaPZ8rLjT+EUrFFIj7WvnMCobv8kCWXMDePjGf1ZhMyxq1jREVNriU27Pm17UZlMeT5tHwGkjSQAMaA6x3LYqV4uYLyXlEnA1Rp157FnUUisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9mtF2pv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47112a73785so50182555e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761124964; x=1761729764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VNMoTZJllpgSAwO+/JhEP/SxoXgVZAY6noBMUvcjjeA=;
        b=R9mtF2pveN+1CWiSMIh81+mvNIVgBnrnqjyHfRVbNs8uFLzLdO8wp8sUZn86AAWfKz
         DxqkIHfZ1NCS6q0VtzcO1TuFNKx/w/viQ99wkaoZfXa5vUsbELIQBTClcy7OjDU1W1Ny
         J6c/LuOhsssozrUce7rgk4ncBPlm7rgWvuX3DiZv98EUgiN7qG7AmD3NQzSMT8AJn+rV
         UGFXaePs8GVdgu0d/WoodEg8kF3BPvh+2KGRA8u/43i87Kvvv2cbpl92pEO1FmFIk0/D
         DcVWtCnxNLxKw3lkFWJygoYLX3YHM6Z4U7/gIePLhjqK1dx1f6MCY/vQThWR3lymFtKT
         PqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124964; x=1761729764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNMoTZJllpgSAwO+/JhEP/SxoXgVZAY6noBMUvcjjeA=;
        b=giYPHFI9aDbCn758YIHBYBUlUqZur5rtOPt8wMGaHTCwtgqg8qR7NaCJxtA8zFkYuM
         jfvrVJxxDkmFlv1TOSeyjQTb2teWWkPoyMkUka751Hzx6tEuPY/4rVOnn0u1tx6W4htW
         x+zrkDYuZAF9Hk84gNaXRpsUDFLZla7Y0/zQ9SzzNWwkFPNl5YGall5+G3hfyFRCkYWD
         21L8Mc0Hf3x3AyOSOWiWeeoSphJ56zNoLfyvjzSKPwE7f7lqp9g16FZn29hKc3gR085Y
         3UZdkoJKwtAm/UkQHmreAgpnbFYHDlos+FUMdQZTzU2PwHg8wO5a2fUQX7Ik89zWHDS0
         fKIw==
X-Forwarded-Encrypted: i=1; AJvYcCWWnimFW4ewHpLpnHfe7ut0AMf87gc/+F8MuBYqQD5X/A/PmnpkwZmmdt92bkAyxnyvjp9bX/vW0XBAK1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYaPcPC99oErVVLbW7ftvjdRkXBbi6TUUaFKmG+MX+6jFFwteh
	9o6Ww9aw1k5iMFEHsuR5qHwYvo0gCS0XVEhojOzo0gru+kBjZoYeN+Be
X-Gm-Gg: ASbGncuHv3GHNqO6Q2kYK0x/mvw7DTH3ug4IWiw4fr+RLT/1HWO1nVF8CL+VWhvPhvw
	cDMruZSBwU0RTu5niCvNZEFfs0XnxpFENE8SAu4cXeLC5BW5kH5zpS1eQKTFzWD8+siGrwpyHVD
	3iyEWSC0eODdkeNy5olo7IlffKB1LGsFGeUcFLQnpjIE+rcxYobvx8Fxv5IeMqhlKDv4g2sGgGk
	eG7OPN3jW+dnFr+DmfnjXtp79YlQTIqywSuL3oUqqpkND6EVe4O51zcO486tH3YZcSeDBSUk/Np
	KOTUb9mzJoqChM7fDWID+TOCmh+7jRJRkirsBG95gMPRMfBH0uQ2FzKkSbDgGFZbPbFz+71MKwX
	S3uNCm1gqj3p1ThdPNZ7BeGW/Yd82zP85dmMSkj+ECOnWrK7cuhRrESuRrtg/32VCq8SDdCz2oU
	nRYAIkMJPGnA==
X-Google-Smtp-Source: AGHT+IG3shR1jkIXjfz9mpIHyj77SpOy/9Mx7bfHfwJZCSED1Rhf3mSo44aJkQh6ifUEBGx+vAYZxA==
X-Received: by 2002:a05:600c:3494:b0:471:76f:80ed with SMTP id 5b1f17b1804b1-47117934827mr145803435e9.41.1761124963386;
        Wed, 22 Oct 2025 02:22:43 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm34829455e9.1.2025.10.22.02.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:22:42 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: mripard@kernel.org
Cc: maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	cristian.ciocaltea@collabora.com,
	lumag@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/tests: hdmi: Handle drm_kunit_helper_enable_crtc_connector() returning EDEADLK
Date: Wed, 22 Oct 2025 11:22:14 +0200
Message-ID: <20251022092233.8020-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fedora/CentOS/RHEL CI is reporting intermittent failures while running
the KUnit tests present in drm_hdmi_state_helper_test.c [1].

While the specific test causing the failure change between runs, all of
them are caused by drm_kunit_helper_enable_crtc_connector() returning
-EDEADLK. The error trace always follow this structure:

    # <test name>: ASSERTION FAILED at
    # drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:<line>
    Expected ret == 0, but
        ret == -35 (0xffffffffffffffdd)

As documented, if the drm_kunit_helper_enable_crtc_connector() function
returns -EDEADLK (-35), the entire atomic sequence must be restarted.

Handle this error code for all function calls.

Closes: https://datawarehouse.cki-project.org/issue/4039  [1]
Fixes: 6a5c0ad7e08e ("drm/tests: hdmi_state_helpers: Switch to new helper")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../drm/tests/drm_hdmi_state_helper_test.c    | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 8bd412735000..70f9aa702143 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -257,10 +257,16 @@ static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
@@ -326,10 +332,16 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
@@ -397,10 +409,16 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
@@ -457,10 +475,17 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	crtc = priv->crtc;
+
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     mode,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
@@ -518,10 +543,16 @@ static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
@@ -580,10 +611,17 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	crtc = priv->crtc;
+
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     mode,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
@@ -643,10 +681,16 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
@@ -705,10 +749,17 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	crtc = priv->crtc;
+
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     mode,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
@@ -870,10 +921,16 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
@@ -946,10 +1003,16 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
@@ -1022,10 +1085,16 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
@@ -1069,10 +1138,16 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
@@ -1118,10 +1193,16 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
@@ -1167,10 +1248,16 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
@@ -1218,10 +1305,16 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	/* You shouldn't be doing that at home. */
@@ -1292,10 +1385,16 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_rgb(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
@@ -1440,10 +1539,16 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv422(struct kunit
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
@@ -1669,10 +1774,17 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	drm_modeset_acquire_init(&ctx, 0);
 
 	crtc = priv->crtc;
+
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     mode,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
@@ -1736,10 +1848,16 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
@@ -1805,10 +1923,16 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
@@ -1865,10 +1989,16 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
@@ -1927,10 +2057,16 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
@@ -1970,10 +2106,17 @@ static void drm_test_check_disable_connector(struct kunit *test)
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
+
+retry_conn_enable:
 	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
 						     crtc, conn,
 						     preferred,
 						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
-- 
2.51.0


