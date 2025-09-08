Return-Path: <linux-kernel+bounces-805373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AA8B487BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF087A578F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C292ECD13;
	Mon,  8 Sep 2025 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjNM86RL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC38C2E88B6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322246; cv=none; b=KYNTzkXunIDJYXxTfdnzlFjL4MF8gWnljRDKAzz9Z+lkbRQW9hwklE/l7CXzuHRGz8cm6VW28Xra7Aw2L1ldugh2wYOmBrzu6nPGhFY8JNfj2Dkgt9XIdTC/a80GRjC2YoUBx7WA7cxiyFKNm39p/Eis2xs6llG+H4kubRkPASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322246; c=relaxed/simple;
	bh=pv+nHeguLuoKGL0Qj7WUIoNQZdnHGYVkEPZeryV8nYU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhhciBMCG/09I9ouQEaOYEpmuKObtDCQhoFNkbUsoA4EI/leNmrheLdTaiEDfMIE+bBWyHrf7hpwURAVSp5mqDFjxPKZUlp9SKSEErLJSDmPfMSMfCa+tiRZ4Imjv03OgRd0P3wyKKFyhHFa9LlCMnBvTTnf2uS0ccThJglq9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjNM86RL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757322243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhsjo8wyowZi6zz6knSbZ4Ze8J5T+YaMaavlwVLTizw=;
	b=YjNM86RLRyLNwUwuxIi9Nbb9EAVu4Tk7omKkt8b4FdMxQlshliX59D4cOYDIN87DboOIUL
	7HdRH5v1olpGjIjJJIm+bXVMcij+HGMUPzucVR6BnVix3kn53si+0OTg8LeMgycLXt+2wT
	PcvDcyiiAJPONYm+f3FlzUz8xevqyYU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-nq0UE2iSONqRfa4CCdC34A-1; Mon,
 08 Sep 2025 05:03:58 -0400
X-MC-Unique: nq0UE2iSONqRfa4CCdC34A-1
X-Mimecast-MFC-AGG-ID: nq0UE2iSONqRfa4CCdC34A_1757322237
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3394819541B2;
	Mon,  8 Sep 2025 09:03:57 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.33.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1950C1800452;
	Mon,  8 Sep 2025 09:03:53 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/3] drm/panic: Add kunit tests for drm_panic
Date: Mon,  8 Sep 2025 11:00:30 +0200
Message-ID: <20250908090341.762049-3-jfalempe@redhat.com>
In-Reply-To: <20250908090341.762049-1-jfalempe@redhat.com>
References: <20250908090341.762049-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add kunit tests for drm_panic.
They check that drawing the panic screen doesn't crash, but they
don't check the correctness of the resulting image.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v2:
 * Add a few checks, and more comments in the kunit tests. (Maxime Ripard).

 MAINTAINERS                            |   1 +
 drivers/gpu/drm/drm_panic.c            |   4 +
 drivers/gpu/drm/tests/drm_panic_test.c | 198 +++++++++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 drivers/gpu/drm/tests/drm_panic_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 402fe14091f1..e9be893d6741 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8480,6 +8480,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/drm_draw.c
 F:	drivers/gpu/drm/drm_draw_internal.h
 F:	drivers/gpu/drm/drm_panic*.c
+F:	drivers/gpu/drm/tests/drm_panic_test.c
 F:	include/drm/drm_panic*
 
 DRM PANIC QR CODE
diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 1e06e3a18d09..d89812ff1935 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -986,3 +986,7 @@ void drm_panic_exit(void)
 {
 	drm_panic_qr_exit();
 }
+
+#ifdef CONFIG_DRM_KUNIT_TEST
+#include "tests/drm_panic_test.c"
+#endif
diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tests/drm_panic_test.c
new file mode 100644
index 000000000000..d5d20dd2aa7c
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_panic_test.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/*
+ * Copyright (c) 2025 Red Hat.
+ * Author: Jocelyn Falempe <jfalempe@redhat.com>
+ *
+ * KUNIT tests for drm panic
+ */
+
+#include <drm/drm_fourcc.h>
+#include <drm/drm_panic.h>
+
+#include <kunit/test.h>
+
+#include <linux/units.h>
+#include <linux/vmalloc.h>
+
+/* Check the framebuffer color only if the panic colors are the default */
+#if (CONFIG_DRM_PANIC_BACKGROUND_COLOR == 0 && \
+	CONFIG_DRM_PANIC_FOREGROUND_COLOR == 0xffffff)
+#define DRM_PANIC_CHECK_COLOR
+#endif
+
+struct drm_test_mode {
+	const int width;
+	const int height;
+	const u32 format;
+	void (*draw_screen)(struct drm_scanout_buffer *sb);
+	const char *fname;
+};
+
+/*
+ * Run all tests for the 3 panic screens: user, kmsg and qr_code
+ */
+#define DRM_TEST_MODE_LIST(func) \
+	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_XRGB8888, func) \
+	DRM_PANIC_TEST_MODE(300, 200, DRM_FORMAT_XRGB8888, func) \
+	DRM_PANIC_TEST_MODE(1920, 1080, DRM_FORMAT_XRGB8888, func) \
+	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_RGB565, func) \
+	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_RGB888, func) \
+
+#define DRM_PANIC_TEST_MODE(w, h, f, name) { \
+	.width = w, \
+	.height = h, \
+	.format = f, \
+	.draw_screen = draw_panic_screen_##name, \
+	.fname = #name, \
+	}, \
+
+static const struct drm_test_mode drm_test_modes_cases[] = {
+	DRM_TEST_MODE_LIST(user)
+	DRM_TEST_MODE_LIST(kmsg)
+	DRM_TEST_MODE_LIST(qr_code)
+};
+#undef DRM_PANIC_TEST_MODE
+
+static int drm_test_panic_init(struct kunit *test)
+{
+	struct drm_scanout_buffer *priv;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	test->priv = priv;
+
+	drm_panic_set_description("Kunit testing");
+
+	return 0;
+}
+
+/*
+ * Test drawing the panic screen, using a memory mapped framebuffer
+ * Set the whole buffer to 0xa5, and then check that all pixels have been
+ * written.
+ */
+static void drm_test_panic_screen_user_map(struct kunit *test)
+{
+	struct drm_scanout_buffer *sb = test->priv;
+	const struct drm_test_mode *params = test->param_value;
+	char *fb;
+	int fb_size;
+
+	sb->format = drm_format_info(params->format);
+	fb_size = params->width * params->height * sb->format->cpp[0];
+
+	fb = vmalloc(fb_size);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	memset(fb, 0xa5, fb_size);
+
+	iosys_map_set_vaddr(&sb->map[0], fb);
+	sb->width = params->width;
+	sb->height = params->height;
+	sb->pitch[0] = params->width * sb->format->cpp[0];
+
+	params->draw_screen(sb);
+
+#ifdef DRM_PANIC_CHECK_COLOR
+	{
+		int i;
+
+		for (i = 0; i < fb_size; i++)
+			KUNIT_ASSERT_TRUE(test, fb[i] == 0 || fb[i] == 0xff);
+	}
+#endif
+	vfree(fb);
+}
+
+/*
+ * Test drawing the panic screen, using a list of pages framebuffer
+ * No checks are performed
+ */
+static void drm_test_panic_screen_user_page(struct kunit *test)
+{
+	struct drm_scanout_buffer *sb = test->priv;
+	const struct drm_test_mode *params = test->param_value;
+	int fb_size;
+	struct page **pages;
+	int i;
+	int npages;
+
+	sb->format = drm_format_info(params->format);
+	fb_size = params->width * params->height * sb->format->cpp[0];
+	npages = DIV_ROUND_UP(fb_size, PAGE_SIZE);
+
+	pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pages);
+
+	for (i = 0; i < npages; i++) {
+		pages[i] = alloc_page(GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, pages[i]);
+	}
+	sb->pages = pages;
+	sb->width = params->width;
+	sb->height = params->height;
+	sb->pitch[0] = params->width * sb->format->cpp[0];
+
+	params->draw_screen(sb);
+
+	for (i = 0; i < npages; i++)
+		__free_page(pages[i]);
+	kfree(pages);
+}
+
+static void drm_test_panic_set_pixel(struct drm_scanout_buffer *sb,
+				     unsigned int x,
+				     unsigned int y,
+				     u32 color)
+{
+	struct kunit *test = (struct kunit *) sb->private;
+
+	KUNIT_ASSERT_TRUE(test, x < sb->width && y < sb->height);
+}
+
+/*
+ * Test drawing the panic screen, using the set_pixel callback
+ * Check that all calls to set_pixel() are within the framebuffer
+ */
+static void drm_test_panic_screen_user_set_pixel(struct kunit *test)
+{
+	struct drm_scanout_buffer *sb = test->priv;
+	const struct drm_test_mode *params = test->param_value;
+
+	sb->format = drm_format_info(params->format);
+	sb->set_pixel = drm_test_panic_set_pixel;
+	sb->width = params->width;
+	sb->height = params->height;
+	sb->private = test;
+
+	params->draw_screen(sb);
+}
+
+static void drm_test_panic_desc(const struct drm_test_mode *t, char *desc)
+{
+	sprintf(desc, "Panic screen %s, mode: %d x %d \t%p4cc",
+		t->fname, t->width, t->height, &t->format);
+}
+
+KUNIT_ARRAY_PARAM(drm_test_panic_screen_user_map, drm_test_modes_cases, drm_test_panic_desc);
+KUNIT_ARRAY_PARAM(drm_test_panic_screen_user_page, drm_test_modes_cases, drm_test_panic_desc);
+KUNIT_ARRAY_PARAM(drm_test_panic_screen_user_set_pixel, drm_test_modes_cases, drm_test_panic_desc);
+
+static struct kunit_case drm_panic_screen_user_test[] = {
+	KUNIT_CASE_PARAM(drm_test_panic_screen_user_map,
+			 drm_test_panic_screen_user_map_gen_params),
+	KUNIT_CASE_PARAM(drm_test_panic_screen_user_page,
+			 drm_test_panic_screen_user_page_gen_params),
+	KUNIT_CASE_PARAM(drm_test_panic_screen_user_set_pixel,
+			 drm_test_panic_screen_user_set_pixel_gen_params),
+	{ }
+};
+
+static struct kunit_suite drm_panic_suite = {
+	.name = "drm_panic",
+	.init = drm_test_panic_init,
+	.test_cases = drm_panic_screen_user_test,
+};
+
+kunit_test_suite(drm_panic_suite);
-- 
2.51.0


