Return-Path: <linux-kernel+bounces-620073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FC8A9C58D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 12:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34641893262
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5F125394E;
	Fri, 25 Apr 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I7b5ckXE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8583D23D2B7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576921; cv=none; b=newGNzSEw5cvyUmyzcKIENjq+kt6nDJDcz0LLkP0gPcj6Mzs3dt46mgjPCpalPyEOfWT1SC2FzejZmYlinoawrXLSEK3QFIwLGm+/kkLkU1rgbZDhLS3pMguCyCR7y30pPisapv8/r2tpA9VQiK+S301SE8zpLW0/dwPEnZlU6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576921; c=relaxed/simple;
	bh=7ofSckO83vB+rgyQi4o06LSvEMNgZtnj6GcHybd32Jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G77PPVVuD6kSZ8PfEb5Bm0PBnMzju3ZH4Smw4UjhimIGFsf5YIFz0vb/vDClYSxTx9f9tL+zrWidxGgH93FR52dMMnW7WHJaLSd6t3SRAZSdqtwWvYEaeZLgPmGtQbZO9SzAkLEDXRkr0zLWPW3/KAOCzUiaELx8H21AT5LpA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I7b5ckXE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745576918;
	bh=7ofSckO83vB+rgyQi4o06LSvEMNgZtnj6GcHybd32Jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I7b5ckXEPS03FYGRuCxmxXiEmWt1HA4LHNjbGbBYcioe1fDivREKN9Ljoyhdu7axb
	 LwRW/wpNqj7bTDykS8Q51gAqyqD0s35y/mD/OiEH+7XF9nys1TlWzuxOKOGzfVkQ8Q
	 SoMoe64dzFVdnCpY7e5L4J3Bn7+7KbRDC1AJmtFbucP0+j6sWxdClRoksaUb7aVbsg
	 kP/mC/mezhlADPtxDZyyAOuixwEF6JyI0/aHJp3yLAB32KJPoy2XnLSf3zA+ffMLtq
	 itgY1XgrPoihikmoc1kwkfexbnBgelbFkwGHpbS1jJeffhm/uEzpBqtJ+6XqBiVzSP
	 WVzhdedFMv25Q==
Received: from localhost (unknown [82.76.59.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id CAB7117E3626;
	Fri, 25 Apr 2025 12:28:37 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 25 Apr 2025 13:27:14 +0300
Subject: [PATCH v4 23/23] drm/tests: hdmi: Add test for unsupported
 RGB/YUV420 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-hdmi-conn-yuv-v4-23-5e55e2aaa3fa@collabora.com>
References: <20250425-hdmi-conn-yuv-v4-0-5e55e2aaa3fa@collabora.com>
In-Reply-To: <20250425-hdmi-conn-yuv-v4-0-5e55e2aaa3fa@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Provide a test to verify that if both driver and screen support RGB and
YUV420 formats, drm_atomic_helper_connector_hdmi_check() cannot succeed
when trying to set a mode unsupported by the display.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index d79084cfb516b69c4244098c0767d604ad02f2c3..6337a1c52b86810c638f446c4995e7ee63dbc084 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -1622,6 +1622,71 @@ static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test
 	drm_modeset_acquire_fini(&ctx);
 }
 
+/*
+ * Test that if a driver and screen supports RGB and YUV420 formats, but the
+ * chosen mode cannot be supported by the screen, we end up with unsuccessful
+ * fallback attempts.
+ */
+static void drm_test_check_display_unsupported_fallback_rgb_yuv420(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_state *state;
+	struct drm_display_info *info;
+	struct drm_display_mode *preferred, *unsupported_mode;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(HDMI_COLORSPACE_RGB) |
+				BIT(HDMI_COLORSPACE_YUV420),
+				10,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	info = &conn->display_info;
+	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->ycbcr_420_allowed);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	unsupported_mode = drm_kunit_display_mode_from_cea_vic(test, drm, 96);
+	KUNIT_ASSERT_NOT_NULL(test, unsupported_mode);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	ret = drm_kunit_helper_try_enable_crtc_connector(test, drm,
+							 crtc, conn,
+							 preferred, &ctx);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	drm_kunit_atomic_restart_on_deadlock(ret, state, &ctx, retry);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	ret = drm_atomic_set_mode_for_crtc(crtc_state, unsupported_mode);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = drm_atomic_check_only(state);
+	drm_kunit_atomic_restart_on_deadlock(ret, state, &ctx, retry);
+	KUNIT_ASSERT_LT(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 /*
  * Test that if a driver and screen supports RGB and YUV formats, and we
  * try to set the VIC 1 mode, we end up with 8bpc RGB even if we could
@@ -2023,6 +2088,7 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
 	KUNIT_CASE(drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv422),
 	KUNIT_CASE(drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv420),
 	KUNIT_CASE(drm_test_check_driver_unsupported_fallback_yuv420),
+	KUNIT_CASE(drm_test_check_display_unsupported_fallback_rgb_yuv420),
 	KUNIT_CASE(drm_test_check_output_bpc_crtc_mode_changed),
 	KUNIT_CASE(drm_test_check_output_bpc_crtc_mode_not_changed),
 	KUNIT_CASE(drm_test_check_output_bpc_dvi),

-- 
2.49.0


