Return-Path: <linux-kernel+bounces-655558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F46ABD805
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 14:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E879179609
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6406B265CAA;
	Tue, 20 May 2025 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE/0GPzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634E21CC5A
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742922; cv=none; b=VcESLTbJO+9/wlPfD02KfpoYMa+CYUvB6ZuPLzUjg8YKyRRs3MfMYyh6FVgesntdskUJjBqw6eUAny0hfSojMbNsq1Pjy5Z0FCxNJTuuM+e27+mHYOhmsjrFK3wz0fBPJpz8dKTBNsB9SDw6KHu0B/yHMUGlfp6faIa/xIMBKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742922; c=relaxed/simple;
	bh=ZQfsFVX5UD/XSRwAU4E/sTwO70gFfISTPfGjtIaP3xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PbTHlqeR6gBaf3akWmVK73J4t4kerJv0ou5EGSGy1ApVz5vbM5hxWDurVzSoGvs5IwRyYGy/Yk7bCE+4JyFV+JLNFB7TvaR9dtRqPz/E7Jj1ZZq4cInHJ62qHy3vYnuUOOgjZUmbsUqTTwfHrkohbDGIuS41gh7z7C0cEmtJd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE/0GPzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEB0C4CEE9;
	Tue, 20 May 2025 12:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747742922;
	bh=ZQfsFVX5UD/XSRwAU4E/sTwO70gFfISTPfGjtIaP3xg=;
	h=From:Date:Subject:To:Cc:From;
	b=XE/0GPzIkKGDpNRmePgSqqJhADflIro7oL9sMYg+dynvngh9eLWKPlrt2AaxRzq/R
	 BLykpXA2nzdqRlF0njgAM/WXR3AOo8HvTOFA/uEIPiw1fLSgWaYqwHyeOKacE/rKk+
	 W0JD+0Ui6nlMIwteO/N3p3600EeT5aY6aw5yeamhnwSawiispjcoacMPxk70RNNDbo
	 /aiRZArItRRXoBBMBXG/6vz6KCgOX++RZx60QPdFRC3JCdRgfItwgts2uUeVZ2/83x
	 bVgWVbWvMmxFAPfiWEiIq8E6JC9qUs4I3uVMgC5olZ8E81ZQoh4vW86lYcEjxg4GrH
	 TyfjZNIexbCoQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 20 May 2025 14:08:36 +0200
Subject: [PATCH] drm/vc4: tests: pv_muxing: Fix locking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-drm-vc4-kunit-fixes-v1-1-ca281e485f8e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMNwLGgC/x3LTQqAIBBA4avIrBtQ0f6uEi3CphoiCy0JorsnL
 T8e74FIgSlCKx4IlDjy7jNUIcAtg58JecwGLbWVVkscw4bJGVwvzydOfFPEoaxVpawzRjaQzyP
 QH/LY9e/7AfOzWshlAAAA
X-Change-ID: 20250520-drm-vc4-kunit-fixes-a681715c4409
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4976; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ZQfsFVX5UD/XSRwAU4E/sTwO70gFfISTPfGjtIaP3xg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBk6BcdSl9wz29U2I+F104yYpTzrasNk/razpm+uqJasE
 UzRKvrYMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYy+Sdjwwmu+rmmJksnPyr9
 +4rX+GOn99R3Xx++0N2/NiX8xNmDr9S0lvx8LR5aE+UoO1+/nmlKGGOtjLqvrJ7YY8vnG1X8PP8
 cYhScfEBKb4vS9fzSWX9WpIuXZeRPffvpXYDQrlQR55hZL7cCAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Commit 30188df0c387 ("drm/tests: Drop drm_kunit_helper_acquire_ctx_alloc()")
removed a kunit-managed function to get a drm_modeset_acquire_ctx.

It converted the vc4_pv_muxing_test_init() function, used by
drm_vc4_test_pv_muxing() and drm_vc4_test_pv_muxing_invalid(). However,
during that conversion, it went from being kzalloc'd to being allocated
on the stack.

vc4_pv_muxing_test_init() then uses that context to allocate a
drm_atomic_state using drm_kunit_helper_atomic_state_alloc(), which
stores a pointer to the locking context in the allocated state.

However, since vc4_pv_muxing_test_init() is a test init function, the
context is then cleared when we leave the function, and before executing
the test. We're then running the test with a dangling pointer, which
then leads to various crashes.

Rework the context initialization and state allocation to move them to
drm_vc4_test_pv_muxing() and drm_vc4_test_pv_muxing_invalid().

Fixes: 30188df0c387 ("drm/tests: Drop drm_kunit_helper_acquire_ctx_alloc()")
Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Closes: https://lore.kernel.org/r/Z_95jWM2YMTGy3pi@arm.com/
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 38 ++++++++++++++++----------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
index 992e8f5c5c6ea8d92338a8fe739fa1115ff85338..a79b152f8b97add449cffc9674abec0df95239e3 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
@@ -18,11 +18,10 @@
 
 #include "vc4_mock.h"
 
 struct pv_muxing_priv {
 	struct vc4_dev *vc4;
-	struct drm_atomic_state *state;
 };
 
 static bool check_fifo_conflict(struct kunit *test,
 				const struct drm_atomic_state *state)
 {
@@ -675,14 +674,22 @@ KUNIT_ARRAY_PARAM(vc5_test_pv_muxing_invalid,
 
 static void drm_vc4_test_pv_muxing(struct kunit *test)
 {
 	const struct pv_muxing_param *params = test->param_value;
 	const struct pv_muxing_priv *priv = test->priv;
-	struct drm_atomic_state *state = priv->state;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_state *state;
+	struct drm_device *drm;
 	unsigned int i;
 	int ret;
 
+	drm_modeset_acquire_init(&ctx, 0);
+
+	drm = &priv->vc4->base;
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
 	for (i = 0; i < params->nencoders; i++) {
 		enum vc4_encoder_type enc_type = params->encoders[i];
 
 		ret = vc4_mock_atomic_add_output(test, state, enc_type);
 		KUNIT_ASSERT_EQ(test, ret, 0);
@@ -698,56 +705,59 @@ static void drm_vc4_test_pv_muxing(struct kunit *test)
 		enum vc4_encoder_type enc_type = params->encoders[i];
 
 		KUNIT_EXPECT_TRUE(test, check_channel_for_encoder(test, state, enc_type,
 								  params->check_fn));
 	}
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 static void drm_vc4_test_pv_muxing_invalid(struct kunit *test)
 {
 	const struct pv_muxing_param *params = test->param_value;
 	const struct pv_muxing_priv *priv = test->priv;
-	struct drm_atomic_state *state = priv->state;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_state *state;
+	struct drm_device *drm;
 	unsigned int i;
 	int ret;
 
+	drm_modeset_acquire_init(&ctx, 0);
+
+	drm = &priv->vc4->base;
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
 	for (i = 0; i < params->nencoders; i++) {
 		enum vc4_encoder_type enc_type = params->encoders[i];
 
 		ret = vc4_mock_atomic_add_output(test, state, enc_type);
 		KUNIT_ASSERT_EQ(test, ret, 0);
 	}
 
 	ret = drm_atomic_check_only(state);
 	KUNIT_EXPECT_LT(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 static int vc4_pv_muxing_test_init(struct kunit *test)
 {
 	const struct pv_muxing_param *params = test->param_value;
-	struct drm_modeset_acquire_ctx ctx;
 	struct pv_muxing_priv *priv;
-	struct drm_device *drm;
 	struct vc4_dev *vc4;
 
 	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 	test->priv = priv;
 
 	vc4 = params->mock_fn(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 	priv->vc4 = vc4;
 
-	drm_modeset_acquire_init(&ctx, 0);
-
-	drm = &vc4->base;
-	priv->state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->state);
-
-	drm_modeset_drop_locks(&ctx);
-	drm_modeset_acquire_fini(&ctx);
-
 	return 0;
 }
 
 static struct kunit_case vc4_pv_muxing_tests[] = {
 	KUNIT_CASE_PARAM(drm_vc4_test_pv_muxing,

---
base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
change-id: 20250520-drm-vc4-kunit-fixes-a681715c4409

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>


