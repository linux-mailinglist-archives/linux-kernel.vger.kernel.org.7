Return-Path: <linux-kernel+bounces-779480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5EAB2F4A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A893B9B03
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793BF2DA776;
	Thu, 21 Aug 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXGGMaTQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD762E2DC6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769970; cv=none; b=M5XVbCOvc5+SH3gfPVWfjRHxpDznmthqnFGTkUHI+YLOjKXtuZw94c03LZ6n3e9L17/xfFval9PsOIIhkjj8yNPLIxZzYAV6NP5u9oWipms3Dop8Hg7J29ckgs6sVa8MI1mCo3U7qOBzwJI7BycIVR4aH30iYeeC/N6FL1tcyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769970; c=relaxed/simple;
	bh=t2iUy/wZuKlC7s7lNGJcsEGhu3N4LW8iuiwyZGIDZRA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkW+8B3kiTyzRqgGpj674VedH06aBIm62s74bfRR/4hiqyVxMu83wOzks5z2YaHXwOPPrXzGK/lqtgz5IkJ3uOSzIFe5owPiIhhtL0bEOyTY0qlibzZhvdBmjP5rWchgzBUiK4MUXTkspcmGWJwbM3jLReMeFCyU9FRHohKuqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXGGMaTQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755769967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgTYz/xc1IhWIiyKBtA2fPS1zW/AfOLuNLmyMAtu254=;
	b=fXGGMaTQDw0ynK0b3eWgcvgltQu1GoNz98nhK+cfQo5jlGAFEmdvePz5LtzrUAeAyh3yGZ
	SngCOQF06J37iO6gDrtSJxckKjqEv1f+cJRhLeaQhpxLAkmxpZt++u58aYW5P9bXOJiTpC
	nX4Oademel5+ofjuSApMKF+EX2ACvaU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-lG8voXtTPkmKoLxWi8A7gg-1; Thu,
 21 Aug 2025 05:52:44 -0400
X-MC-Unique: lG8voXtTPkmKoLxWi8A7gg-1
X-Mimecast-MFC-AGG-ID: lG8voXtTPkmKoLxWi8A7gg_1755769963
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BE841956086;
	Thu, 21 Aug 2025 09:52:43 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.33.118])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 112B01977691;
	Thu, 21 Aug 2025 09:52:39 +0000 (UTC)
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
Subject: [PATCH 2/3] drm/panic: Add kunit tests for drm_panic
Date: Thu, 21 Aug 2025 11:49:06 +0200
Message-ID: <20250821095228.648156-3-jfalempe@redhat.com>
In-Reply-To: <20250821095228.648156-1-jfalempe@redhat.com>
References: <20250821095228.648156-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add kunit tests for drm_panic.
They check that drawing the panic screen doesn't crash, but they
don't check the correctness of the resulting image.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 MAINTAINERS                            |   1 +
 drivers/gpu/drm/drm_panic.c            |   4 +
 drivers/gpu/drm/tests/drm_panic_test.c | 164 +++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/gpu/drm/tests/drm_panic_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cfa28b3470ab..285d1e27734f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8465,6 +8465,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
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
index 000000000000..46ff3e5e0e5d
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_panic_test.c
@@ -0,0 +1,164 @@
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
+static void drm_test_panic_screen_user_map(struct kunit *test)
+{
+	struct drm_scanout_buffer *sb = test->priv;
+	const struct drm_test_mode *params = test->param_value;
+	void *fb;
+	int fb_size;
+
+	sb->format = drm_format_info(params->format);
+	fb_size = params->width * params->height * sb->format->cpp[0];
+
+	fb = vmalloc(fb_size);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	iosys_map_set_vaddr(&sb->map[0], fb);
+	sb->width = params->width;
+	sb->height = params->height;
+	sb->pitch[0] = params->width * sb->format->cpp[0];
+
+	params->draw_screen(sb);
+	vfree(fb);
+}
+
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
+}
+
+static void drm_test_panic_screen_user_set_pixel(struct kunit *test)
+{
+	struct drm_scanout_buffer *sb = test->priv;
+	const struct drm_test_mode *params = test->param_value;
+
+	sb->format = drm_format_info(params->format);
+	sb->set_pixel = drm_test_panic_set_pixel;
+	sb->width = params->width;
+	sb->height = params->height;
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
2.50.1


