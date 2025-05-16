Return-Path: <linux-kernel+bounces-651640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F68ABA106
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 18:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2863A6CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78F41DE2DE;
	Fri, 16 May 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AiBpUbKI"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF7224F6
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414127; cv=none; b=W+otzzHIjqEcqyBsjVpsq+EmAXh8dMyJk2u9v82tGoubIrltbXydv26CstsE2Uewg7qF+6vRSKdZmfRnSd/R/iTPnfAPFz2xO0ySL9QAf6RgloMtxDxvCNqX6uRu7l3D1qvtOVmAj6NuyVSNLcw1XhrOxVqPftNoevfZi1SpJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414127; c=relaxed/simple;
	bh=ZU3d4zBYeTPrDCggApT1wJbNmWQJ51VgK1f+6sgeEuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V770ubwmGLNS0N4s/bQbSgShT2FxklWUE4wwVKdve6H+1VvebL10BD7FCk8+3/Qwpkq4qLAtdcu3M48UL/l6apm4AuTzpzjuRi5JnwXwaX5HHMMPIFCX7nisP9WJno9E/8y2dGWWXLZP165rqowtSiWcvDZzbq8VjTFtbf9EZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AiBpUbKI; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7CF70439B0;
	Fri, 16 May 2025 16:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747414122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cB13JIYwcRaHKqdJWGZYYoAhod8XQl74qcOrQIyVBu4=;
	b=AiBpUbKI10lqJm9tsXcxxmQRKeo0iu5QwHDRYtMSCwY0ICWkSLNLjIfmm/20Eun9UzNfj0
	n3K/rAG4hMH4fL5DpX2Q8tjeMPlED9F7yybcqVq3ErpeMMQtX6hdd4LWBoYT7dkW7Tvy4M
	EmyeXpOA2PwEs/uPFVi1l8n+e9n3KoLvwLBs1CS/8ZjNzvbvSY3+sjDi0RYvY/0cIV5uyo
	C9w2GkrG8M5y0uCS67S/PphNVlVSUBoBJNHwBI/d5o5vM0Fs3sdd2Q2rM2LSHdIEUQxoo4
	ypMj70FVAkmxhB6ZKObbPFvTlit0LXiaOrl4RHRKg+67sVMVuUmhm/bwapr1aA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 16 May 2025 18:48:37 +0200
Subject: [PATCH v8 1/3] drm/tests: bridge: convert to
 devm_drm_bridge_alloc() API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-drm-bridge-alloc-doc-test-v8-1-7e356fd58ba5@bootlin.com>
References: <20250516-drm-bridge-alloc-doc-test-v8-0-7e356fd58ba5@bootlin.com>
In-Reply-To: <20250516-drm-bridge-alloc-doc-test-v8-0-7e356fd58ba5@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Anusha Srivatsa <asrivats@redhat.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Dmitry Baryshkov <lumag@kernel.org>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdejhegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhumhgrghesk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepphgruhhlkhesshihshdqsggrshgvrdhiohdprhgtphhtthhopehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Use the new DRM bridge allocation API, which is the only supported now, for
the kunit tests.

This change is more massive than for the typical DRM bridge driver because
struct drm_bridge_init_priv currently embeds a struct drm_bridge, which is
not supported anymore. We new have to use devm_drm_bridge_alloc() to
dynamically allocate a "private driver struct", which is a bit awkward here
because there is no real bridge driver. Thus let's add a "dummy" DRM bridge
struct to represent it.

As a nice cleanup we can now move the enable_count and disable_count
members, which are counting bridge-specific events, into the new "private
driver struct" (and avoid adding new unnecessary indirections).

Also add a trivial bridge_to_dummy_bridge() just like many drivers do.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

This patch was added in v8.
---
 drivers/gpu/drm/tests/drm_bridge_test.c | 95 +++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index ff88ec2e911c9cc9a718483f09d4c764f45f991a..f3a625c536f610dc8560b56531056df7c613f564 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -10,31 +10,45 @@
 
 #include <kunit/test.h>
 
+/*
+ * Mimick the typical struct defined by a bridge driver, which embeds a
+ * bridge plus other fields.
+ *
+ * Having at least one member before @bridge ensures we test non-zero
+ * @bridge offset.
+ */
+struct dummy_drm_bridge {
+	unsigned int enable_count;
+	unsigned int disable_count;
+	struct drm_bridge bridge;
+};
+
 struct drm_bridge_init_priv {
 	struct drm_device drm;
 	struct drm_plane *plane;
 	struct drm_crtc *crtc;
 	struct drm_encoder encoder;
-	struct drm_bridge bridge;
+	struct dummy_drm_bridge *test_bridge;
 	struct drm_connector *connector;
-	unsigned int enable_count;
-	unsigned int disable_count;
 };
 
+static struct dummy_drm_bridge *bridge_to_dummy_bridge(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct dummy_drm_bridge, bridge);
+}
+
 static void drm_test_bridge_enable(struct drm_bridge *bridge)
 {
-	struct drm_bridge_init_priv *priv =
-		container_of(bridge, struct drm_bridge_init_priv, bridge);
+	struct dummy_drm_bridge *dummy_br = bridge_to_dummy_bridge(bridge);
 
-	priv->enable_count++;
+	dummy_br->enable_count++;
 }
 
 static void drm_test_bridge_disable(struct drm_bridge *bridge)
 {
-	struct drm_bridge_init_priv *priv =
-		container_of(bridge, struct drm_bridge_init_priv, bridge);
+	struct dummy_drm_bridge *dummy_br = bridge_to_dummy_bridge(bridge);
 
-	priv->disable_count++;
+	dummy_br->disable_count++;
 }
 
 static const struct drm_bridge_funcs drm_test_bridge_legacy_funcs = {
@@ -45,19 +59,17 @@ static const struct drm_bridge_funcs drm_test_bridge_legacy_funcs = {
 static void drm_test_bridge_atomic_enable(struct drm_bridge *bridge,
 					  struct drm_atomic_state *state)
 {
-	struct drm_bridge_init_priv *priv =
-		container_of(bridge, struct drm_bridge_init_priv, bridge);
+	struct dummy_drm_bridge *dummy_br = bridge_to_dummy_bridge(bridge);
 
-	priv->enable_count++;
+	dummy_br->enable_count++;
 }
 
 static void drm_test_bridge_atomic_disable(struct drm_bridge *bridge,
 					   struct drm_atomic_state *state)
 {
-	struct drm_bridge_init_priv *priv =
-		container_of(bridge, struct drm_bridge_init_priv, bridge);
+	struct dummy_drm_bridge *dummy_br = bridge_to_dummy_bridge(bridge);
 
-	priv->disable_count++;
+	dummy_br->disable_count++;
 }
 
 static const struct drm_bridge_funcs drm_test_bridge_atomic_funcs = {
@@ -102,6 +114,10 @@ drm_test_bridge_init(struct kunit *test, const struct drm_bridge_funcs *funcs)
 	if (IS_ERR(priv))
 		return ERR_CAST(priv);
 
+	priv->test_bridge = devm_drm_bridge_alloc(dev, struct dummy_drm_bridge, bridge, funcs);
+	if (IS_ERR(priv->test_bridge))
+		return ERR_CAST(priv->test_bridge);
+
 	drm = &priv->drm;
 	priv->plane = drm_kunit_helper_create_primary_plane(test, drm,
 							    NULL,
@@ -125,9 +141,8 @@ drm_test_bridge_init(struct kunit *test, const struct drm_bridge_funcs *funcs)
 
 	enc->possible_crtcs = drm_crtc_mask(priv->crtc);
 
-	bridge = &priv->bridge;
+	bridge = &priv->test_bridge->bridge;
 	bridge->type = DRM_MODE_CONNECTOR_VIRTUAL;
-	bridge->funcs = funcs;
 
 	ret = drm_kunit_bridge_add(test, bridge);
 	if (ret)
@@ -173,7 +188,7 @@ static void drm_test_drm_bridge_get_current_state_atomic(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 retry_commit:
-	bridge = &priv->bridge;
+	bridge = &priv->test_bridge->bridge;
 	bridge_state = drm_atomic_get_bridge_state(state, bridge);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bridge_state);
 
@@ -228,7 +243,7 @@ static void drm_test_drm_bridge_get_current_state_legacy(struct kunit *test)
 	 * locking. The function would return NULL in all cases anyway,
 	 * so we don't really have any concurrency to worry about.
 	 */
-	bridge = &priv->bridge;
+	bridge = &priv->test_bridge->bridge;
 	KUNIT_EXPECT_NULL(test, drm_bridge_get_current_state(bridge));
 }
 
@@ -253,7 +268,7 @@ static void drm_test_drm_bridge_helper_reset_crtc_atomic(struct kunit *test)
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_bridge_init_priv *priv;
 	struct drm_display_mode *mode;
-	struct drm_bridge *bridge;
+	struct dummy_drm_bridge *dummy_br;
 	int ret;
 
 	priv = drm_test_bridge_init(test, &drm_test_bridge_atomic_funcs);
@@ -279,14 +294,14 @@ static void drm_test_drm_bridge_helper_reset_crtc_atomic(struct kunit *test)
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	bridge = &priv->bridge;
-	KUNIT_ASSERT_EQ(test, priv->enable_count, 1);
-	KUNIT_ASSERT_EQ(test, priv->disable_count, 0);
+	dummy_br = priv->test_bridge;
+	KUNIT_ASSERT_EQ(test, dummy_br->enable_count, 1);
+	KUNIT_ASSERT_EQ(test, dummy_br->disable_count, 0);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
 retry_reset:
-	ret = drm_bridge_helper_reset_crtc(bridge, &ctx);
+	ret = drm_bridge_helper_reset_crtc(&dummy_br->bridge, &ctx);
 	if (ret == -EDEADLK) {
 		drm_modeset_backoff(&ctx);
 		goto retry_reset;
@@ -296,8 +311,8 @@ static void drm_test_drm_bridge_helper_reset_crtc_atomic(struct kunit *test)
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	KUNIT_EXPECT_EQ(test, priv->enable_count, 2);
-	KUNIT_EXPECT_EQ(test, priv->disable_count, 1);
+	KUNIT_EXPECT_EQ(test, dummy_br->enable_count, 2);
+	KUNIT_EXPECT_EQ(test, dummy_br->disable_count, 1);
 }
 
 /*
@@ -309,7 +324,7 @@ static void drm_test_drm_bridge_helper_reset_crtc_atomic_disabled(struct kunit *
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_bridge_init_priv *priv;
 	struct drm_display_mode *mode;
-	struct drm_bridge *bridge;
+	struct dummy_drm_bridge *dummy_br;
 	int ret;
 
 	priv = drm_test_bridge_init(test, &drm_test_bridge_atomic_funcs);
@@ -318,14 +333,14 @@ static void drm_test_drm_bridge_helper_reset_crtc_atomic_disabled(struct kunit *
 	mode = drm_kunit_display_mode_from_cea_vic(test, &priv->drm, 16);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode);
 
-	bridge = &priv->bridge;
-	KUNIT_ASSERT_EQ(test, priv->enable_count, 0);
-	KUNIT_ASSERT_EQ(test, priv->disable_count, 0);
+	dummy_br = priv->test_bridge;
+	KUNIT_ASSERT_EQ(test, dummy_br->enable_count, 0);
+	KUNIT_ASSERT_EQ(test, dummy_br->disable_count, 0);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
 retry_reset:
-	ret = drm_bridge_helper_reset_crtc(bridge, &ctx);
+	ret = drm_bridge_helper_reset_crtc(&dummy_br->bridge, &ctx);
 	if (ret == -EDEADLK) {
 		drm_modeset_backoff(&ctx);
 		goto retry_reset;
@@ -335,8 +350,8 @@ static void drm_test_drm_bridge_helper_reset_crtc_atomic_disabled(struct kunit *
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	KUNIT_EXPECT_EQ(test, priv->enable_count, 0);
-	KUNIT_EXPECT_EQ(test, priv->disable_count, 0);
+	KUNIT_EXPECT_EQ(test, dummy_br->enable_count, 0);
+	KUNIT_EXPECT_EQ(test, dummy_br->disable_count, 0);
 }
 
 /*
@@ -348,7 +363,7 @@ static void drm_test_drm_bridge_helper_reset_crtc_legacy(struct kunit *test)
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_bridge_init_priv *priv;
 	struct drm_display_mode *mode;
-	struct drm_bridge *bridge;
+	struct dummy_drm_bridge *dummy_br;
 	int ret;
 
 	priv = drm_test_bridge_init(test, &drm_test_bridge_legacy_funcs);
@@ -374,14 +389,14 @@ static void drm_test_drm_bridge_helper_reset_crtc_legacy(struct kunit *test)
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	bridge = &priv->bridge;
-	KUNIT_ASSERT_EQ(test, priv->enable_count, 1);
-	KUNIT_ASSERT_EQ(test, priv->disable_count, 0);
+	dummy_br = priv->test_bridge;
+	KUNIT_ASSERT_EQ(test, dummy_br->enable_count, 1);
+	KUNIT_ASSERT_EQ(test, dummy_br->disable_count, 0);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
 retry_reset:
-	ret = drm_bridge_helper_reset_crtc(bridge, &ctx);
+	ret = drm_bridge_helper_reset_crtc(&dummy_br->bridge, &ctx);
 	if (ret == -EDEADLK) {
 		drm_modeset_backoff(&ctx);
 		goto retry_reset;
@@ -391,8 +406,8 @@ static void drm_test_drm_bridge_helper_reset_crtc_legacy(struct kunit *test)
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	KUNIT_EXPECT_EQ(test, priv->enable_count, 2);
-	KUNIT_EXPECT_EQ(test, priv->disable_count, 1);
+	KUNIT_EXPECT_EQ(test, dummy_br->enable_count, 2);
+	KUNIT_EXPECT_EQ(test, dummy_br->disable_count, 1);
 }
 
 static struct kunit_case drm_bridge_helper_reset_crtc_tests[] = {

-- 
2.49.0


