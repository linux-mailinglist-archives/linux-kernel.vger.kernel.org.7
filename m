Return-Path: <linux-kernel+bounces-651642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985E3ABA108
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 18:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A560176297
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214981DF269;
	Fri, 16 May 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WitPjM45"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EC01DDC2B
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414129; cv=none; b=Z3Guc17aAd/yo5m1G22F5+KZVCHvkUr572bMjSdTOR5HJ0UKbc4jLnZCCi0ZDFqVwtPmzRTyE6kIvFaIJ77G8F1pGMaEZ5nAB3nYWVoS6Ww9eBO2I7RGTV9qAJD0l2FdJyoAVApvLEDvzdANqHzeJIMgbvRxq4PUklcWCI2BJzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414129; c=relaxed/simple;
	bh=/f8kyOvNPuischNyTg3IFMOJTDBfi3p3WIMAiKExCd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U9MHYKt5WeyyRsbfsppJxJq9eUpUfoUTfwV4bItZh1wRbvH6+SkLN2ycfvpw5KJ67qOPJ8/eUjiZTn/gmbS2gH/cSV12lI0mHX2KCQ11k96gV9Cv1ok2FPuvb49ATJTXnzjL5sQqpMbUa9qctS4mhVTmdi58HhhW+Vtvi1dQ5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WitPjM45; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1805439C3;
	Fri, 16 May 2025 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747414125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQrmPmkpZLcvYwzVyIcePfVAEoL0IdnmeRCnBsVn4Rs=;
	b=WitPjM45siFcCw96knYm6XtevTudsV5ENtd7wJBmPN4Rc9EoSceN4Zyw9kyMra6Zm+Vder
	2+UwNe5ork0e99LkrJ6Bm0STiTWKGU3jK1TW+SQrV5KufimwzDUaRWijOU1RAYuXx+GmIN
	n6e3q1qxSphY+kXRY2G25wZKZyi30MnLtC1fouXotJWGupHM+Tk4aD2587vpM4wujq1jqL
	BLRBlEHX7cZAHq7y079Iaid+WuuT46o+GHLwRnLOgZQB0P8JYLoetSU/jSCelMH+X7sguG
	m9cxUwdBr1B+Bgbi2B9l8hhzOt+GvXNcZi16wYZSU2JAFsSve4y8DUOHzzoRjQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 16 May 2025 18:48:39 +0200
Subject: [PATCH v8 3/3] drm/tests: bridge: add KUnit tests for
 devm_drm_bridge_alloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-drm-bridge-alloc-doc-test-v8-3-7e356fd58ba5@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdejhegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhumhgrghesk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepphgruhhlkhesshihshdqsggrshgvrdhiohdprhgtphhtthhopehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Add KUnit tests for the newly introduced devm_drm_bridge_alloc().

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v8:
 - rebase on new patch converting drm_bridge_test.c to
   devm_drm_bridge_alloc()
 - add check that bridge is removed (thanks to the .destroy callback)
 - add a check with get/put

Changed in v7:
 - rebase on current drm-misc-next, which now has a drm_bridge_test.c file
 - cleanup commit message

Changed in v6:
 - update to new devm_drm_bridge_alloc() API
 - remove drm_test_drm_bridge_put test, not straightforward to write with
   the new API and the current notification mechanism
 - do not allocate a drm_device: a bridge is allocated without one
 - rename some identifiers for easier code reading

This patch was added in v5.
---
 drivers/gpu/drm/tests/drm_bridge_test.c | 84 +++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index f3a625c536f610dc8560b56531056df7c613f564..32db3a82fe6d14a3e9d6536bcf4b19f1bc65969a 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -8,6 +8,7 @@
 #include <drm/drm_bridge_helper.h>
 #include <drm/drm_kunit_helpers.h>
 
+#include <kunit/device.h>
 #include <kunit/test.h>
 
 /*
@@ -21,6 +22,7 @@ struct dummy_drm_bridge {
 	unsigned int enable_count;
 	unsigned int disable_count;
 	struct drm_bridge bridge;
+	void *data;
 };
 
 struct drm_bridge_init_priv {
@@ -422,11 +424,93 @@ static struct kunit_suite drm_bridge_helper_reset_crtc_test_suite = {
 	.test_cases = drm_bridge_helper_reset_crtc_tests,
 };
 
+struct drm_bridge_alloc_test_ctx {
+	struct device *dev;
+	struct dummy_drm_bridge *dummy_br;
+	bool destroyed;
+};
+
+static void dummy_drm_bridge_destroy(struct drm_bridge *bridge)
+{
+	struct dummy_drm_bridge *dummy_br = bridge_to_dummy_bridge(bridge);
+	struct drm_bridge_alloc_test_ctx *ctx = (struct drm_bridge_alloc_test_ctx *)dummy_br->data;
+
+	ctx->destroyed = true;
+}
+
+static const struct drm_bridge_funcs drm_bridge_dummy_funcs = {
+	.destroy = dummy_drm_bridge_destroy,
+};
+
+static int drm_test_bridge_alloc_init(struct kunit *test)
+{
+	struct drm_bridge_alloc_test_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	ctx->dev = kunit_device_register(test, "drm-bridge-dev");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->dev);
+
+	test->priv = ctx;
+
+	ctx->dummy_br = devm_drm_bridge_alloc(ctx->dev, struct dummy_drm_bridge, bridge,
+					      &drm_bridge_dummy_funcs);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->dummy_br);
+
+	ctx->dummy_br->data = ctx;
+
+	KUNIT_ASSERT_FALSE(test, ctx->destroyed);
+
+	return 0;
+}
+
+static void drm_test_drm_bridge_alloc_basic(struct kunit *test)
+{
+	struct drm_bridge_alloc_test_ctx *ctx = test->priv;
+
+	KUNIT_ASSERT_FALSE(test, ctx->destroyed);
+
+	kunit_device_unregister(test, ctx->dev);
+	KUNIT_ASSERT_TRUE(test, ctx->destroyed);
+}
+
+static void drm_test_drm_bridge_alloc_get_put(struct kunit *test)
+{
+	struct drm_bridge_alloc_test_ctx *ctx = test->priv;
+
+	KUNIT_ASSERT_FALSE(test, ctx->destroyed);
+
+	drm_bridge_get(&ctx->dummy_br->bridge);
+	KUNIT_ASSERT_FALSE(test, ctx->destroyed);
+
+	kunit_device_unregister(test, ctx->dev);
+	KUNIT_ASSERT_FALSE(test, ctx->destroyed);
+
+	drm_bridge_put(&ctx->dummy_br->bridge);
+	KUNIT_ASSERT_TRUE(test, ctx->destroyed);
+}
+
+static struct kunit_case drm_bridge_alloc_tests[] = {
+	KUNIT_CASE(drm_test_drm_bridge_alloc_basic),
+	KUNIT_CASE(drm_test_drm_bridge_alloc_get_put),
+	{ }
+};
+
+static struct kunit_suite drm_bridge_alloc_test_suite = {
+	.name = "drm_bridge_alloc",
+	.init = drm_test_bridge_alloc_init,
+	.test_cases = drm_bridge_alloc_tests,
+};
+
 kunit_test_suites(
 	&drm_bridge_get_current_state_test_suite,
 	&drm_bridge_helper_reset_crtc_test_suite,
+	&drm_bridge_alloc_test_suite,
 );
 
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
+MODULE_AUTHOR("Luca Ceresoli <luca.ceresoli@bootlin.com>");
+
 MODULE_DESCRIPTION("Kunit test for drm_bridge functions");
 MODULE_LICENSE("GPL");

-- 
2.49.0


