Return-Path: <linux-kernel+bounces-884569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA27C307A2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6A21885DBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E7314D34;
	Tue,  4 Nov 2025 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NccWkf8h"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB692E7635
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251794; cv=none; b=Aia5PtsrHWeeRdSn+/ZLqEFgIJniYx6YJf2s+BImUDNyAMlztM4PKqDQ/X+/LzSbPlSbTbHfwpVGpQ/spUG7nkKnNPmHq0NNPVkkiV9N9X4Cb5vdU/DUZJTC8iv795u2VMg1+/PZdTG7iyA6wMelFJodo7ReKZOOa+7qDkTVaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251794; c=relaxed/simple;
	bh=3REHbCCQr7ryR5aRza56zsy/xJ3T8S6PHurN6Y9NaKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hwoo6DsDMQoJZqubkxyHSt0etFpiCYZ9n/fcHQkDmyOeTAW3ccog38HXFh3PEfshonpDNIUcSHXvKcwCw445OVoR3SWCj/nwc1CVm3Wi7O3PylAlZSKHjnK1Xe8a4YZgj6m6i4RKQRNj8uNLpD8W5HgYg4v+iNXkdn80Gdl7NCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NccWkf8h; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47117f92e32so43536125e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762251790; x=1762856590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F20WkVDMnVuGhUdaFvlHMiL1gr9I2eF6DsUKNYkjzsw=;
        b=NccWkf8hbk3BWqaXZsPsgT8cjO7Xb0cE7GJ6kJ+CW/7IcxrHVJ7rZ92mBwy+H8WXof
         jOPf76OByrj24LN90REFf/qv/iEFrUVQ5hFGF3kwo31sQhjXgINfseATm6QDsAUf5KvC
         A62JcfvXFYCfWEYbXYsbMGVow0jZSE1cavXa+Np9MrwgeeC+WPbUblpWMYJYyDmI5srS
         APb9ofm5yjb0LTkIkxjk/MTIFnRRbfII81vsoaPPT0LJ9o+PsqTRv2l40DYcJuQn8VA+
         yPiidWCAWWIzHbfIZQv5fOzKYkKt4EieimHXscKu+7QGlhV/sJMIK9dGSxUKbbzXFIcr
         BViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251790; x=1762856590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F20WkVDMnVuGhUdaFvlHMiL1gr9I2eF6DsUKNYkjzsw=;
        b=s3H/k5peiSLXwziZY66UUcNS12iUND8uygvFv1ukRhta88a32s6UrR0t/uv/RnFxYs
         1gpD/7A7XazYf/Hu+seUJ8Djowju19oLv46UqsWvcxMGpvy4/QZ9DLoxB3XEpltpDQoG
         OobD8JVFJIRBlFKVfe33AfkFZvNcJsvGHW0S18LBnJTylXYz/wKnrtsStK6vtNHY+4eY
         Fx4Dh8yb8gUm0LgieEAs0lwNja/ENZjATppzKDI/AVkz9rH79KB1dSF/2e6OcYSwgDDu
         KGEDIqs82iKiVl6BNwF6tz9YDI5K55cVQiHigTEyHCgaJhFbr66FIp/eD9F8BA5tqspb
         w5tw==
X-Forwarded-Encrypted: i=1; AJvYcCU9VYxo4jumCRRBukTYDiKusRJCPsKde6V1PlZZnfdahqVAYGOwxigYA1b3gyAJP4QilBMcvh8y7x1PisM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJq9qVAGOZq5LZlq4vDZG0E/1OxE7t0EkpexoTKwX+cDgwPgw
	mKefoMp8yI4LIsJaRdqS9nSJE3IoImdBDrByM95JMXNd7Ow/tIElUR/0
X-Gm-Gg: ASbGnctpPh8XZ6FpWTSUpZGQH8q+BxzqTfMNmZplCwR4pp1EFBPgyl+62iz/tnrfgUM
	+AsZKFJH/nhszcIbfTjHO8PuDP5hCGitTHJB9n/bKAUnWIR/vI8VM7NJhCGl+zb/mkqON6txm+B
	EmDxb9uWAP3l1mG5hLiOyjwSCKBukKbTeABhWyweOVp3qnQtsVenlr+1eXboLlgextcn4uNqzBy
	2gw5RbjasK94r7CLrK7cfbjUawDkPnhYUoGp5Gt3V1WL1sRcFCHO/v4gUbiJ869dC7j0iIXhr/X
	ORvS4G9Cmq9jUgZlkZf1EbwAq3rsOmmDabObrnh93CLCubQuLsj/qvecRHpWKZPHHLXUvtODLlm
	wG8Lv1D692/n2g5rm4VHCnAN8Sudp28e8NA/nC9MVVfSbQDEa3eVMldicrbxfm5Kc0cGN2Gkf83
	5ktjH7jwnB
X-Google-Smtp-Source: AGHT+IGKjhzqQ3l/o85RnxG6GfkFOfaSy80wjqnRvBu8AXnNM14v9fVkT3kLxkcGNgrOpSZ18ecwTg==
X-Received: by 2002:a05:600c:538e:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47730890e99mr156705115e9.32.1762251790205;
        Tue, 04 Nov 2025 02:23:10 -0800 (PST)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755932d9csm14426205e9.3.2025.11.04.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:23:09 -0800 (PST)
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
Subject: [PATCH v2] drm/tests: hdmi: Handle drm_kunit_helper_enable_crtc_connector() returning EDEADLK
Date: Tue,  4 Nov 2025 11:22:35 +0100
Message-ID: <20251104102258.10026-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.1
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
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: Add Reviewed-by: Maxime Ripard
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
2.51.1


