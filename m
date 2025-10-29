Return-Path: <linux-kernel+bounces-876202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07070C1B2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA22F62308D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D8134AB14;
	Wed, 29 Oct 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T2xPsI9b"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C57348877;
	Wed, 29 Oct 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744658; cv=none; b=OJDuCx1ka90ZH0y96cC2jOY+6Zjl+ZOM1ZKRHE4wWzmdhLkhxnr6eSTFjS3YYiyF70ilI4HApTKMnXBaOv7aVl3CYnNVS4lKD313bAT6AyeGAwZIqM+KqJnG6yx4Wych7SeWyseyGN38zLLif9P42j8wIKsX8wNCfPaXZT0kl2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744658; c=relaxed/simple;
	bh=BMVGN+9+t9auyeVa0Egl37tcKEFQ9wQUAEN2uScKJxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dkS1kkjifdc6nUZHgClXtwSzfhCS8X38FCwYU3mh0AdU0+ffx6jJZtBgUeImqTD+QMnxQxZjRMP0SXSlGO9L6glqf9vaY3I2LLba/211g8Px3LYNaahmtlHIv9r1cxYS02e/GlWp703p7NJqusHlkqaFcGLdz2dFIb4ZrE6AirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T2xPsI9b; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A75024E413D0;
	Wed, 29 Oct 2025 13:30:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 727D2606E8;
	Wed, 29 Oct 2025 13:30:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 414AD117F8047;
	Wed, 29 Oct 2025 14:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744653; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RDpTgbAVmwlCytnSgkakGECg7adgLDFGZNh1TIOlRlw=;
	b=T2xPsI9baanfR5P3/tZVY7YxR0rp/OcohpU79jQtzuHQlXUguG0eoLJcxVBq8lekZj16v1
	x7HdF9gQEpOb3QHXMu65FJtOnUdvrmtDWPsNIb3Zd4bO1ywkjrgeFDlhTqJjN2ysmksi20
	Q04G9ahj4mQ6RV9lwEFCP8o1Q+GXol1/omtNhrhxIbrTz/9Mh6txKSZfWM2uJJVdgXyhFd
	R3hnJIu3AsiJ4B+kcLj8wyRC0o6BWze7UUuCEasTCp18vcxxHHsfwWiPustWJ+Kx3hDEib
	h2GC7vdhGcFBP1QfarIWhWLDAqY9dknan45PHJUHm3D6jXaYFL8OzrWYsTFD0w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:27 +0100
Subject: [PATCH v2 17/32] drm/vkms: Introduce configfs for plane format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-vkms-all-config-v2-17-be20b9bf146e@bootlin.com>
References: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
In-Reply-To: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10458;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=BMVGN+9+t9auyeVa0Egl37tcKEFQ9wQUAEN2uScKJxI=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbrtiEdWcSV2NOayXdSjqF+6TdyBXJqeBKxT
 V+O0s2GKFyJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6wAKCRAgrS7GWxAs
 4nmLD/9H0YT5x+8nydbcPgkwqy3AqfCu+poRWwjViT9699UXeXBjt892qOaw7mcIT+PHVKS0yOa
 xleZsqyIH9xet2GnsZtzWSMFPm4+PBKOdT1LrtI3sFNwTz7szxRoa74VmPWnMf1oMQnBRHms/l5
 V9OBG7CBgXuUcXTzVo6e9/tB5K0MnAAxrActIUwrpXbc1PL9P4kOtzUXpcgeC1x1bG77U/T4SfF
 luDhf4huqdVadLMXwXgbsYRpktsF9YN4SYmnupTH8Tzx0kRJ7f1/R199I8miD/wWe6MAXpOj/wS
 27vKNj59VT0qgLlsmnPMoGIHcXLJ5t1ofVcnL4D1+QMBy9kNpZzHQ+inn8Fs3AgN0VIayMPI8rv
 JOlKMaMWHSZClM+oTx0KGzUNxUhJIr9cc/Zk4nyDm8usWpbCJxfZUfnJGelVCfiHvfJal9aDgfj
 FoQlSeOkjnnFervSe0y8H+b7W1Cv+pLqXE00ySnlPMGIhCqqhOUYwgEP1milK917oC/kXNXMpqT
 zTaSA5cljeC4SxjLug/LFQh6SS6+INjT/d3ItoWfyUgd+Hymi8S7aT3mf69mCKfEvIkpuIYT7jD
 lMVmHvJzkonF2mCbgim3d7GlSDdCA/4v5UoEX3fjJXPEbmM52IQzPF3eg10wc3o7i00ds7L7G7F
 fhRn9HeWTppvuNw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

To allow the userspace to test many hardware configuration, introduce a
new interface to configure the available formats per planes. VKMS supports
multiple formats, so the userspace can choose any combination.

The supported formats are configured by writing the fourcc code in
supported_formats:
 # enable AR24 format
  echo '+AR24' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats
 # disable AR24 format
  echo '-AR24' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats
 # enable all format supported by VKMS
  echo '+*' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats
 # disable all formats
  echo '-*' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst                      |   7 +-
 drivers/gpu/drm/vkms/tests/Makefile             |   1 +
 drivers/gpu/drm/vkms/tests/vkms_configfs_test.c | 102 ++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.c            | 119 ++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.h            |   6 ++
 5 files changed, 234 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 8383e1b94668..779ae363110d 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,7 +87,7 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 8 configurable attributes:
+Planes have 9 configurable attributes:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
@@ -109,6 +109,11 @@ Planes have 8 configurable attributes:
   must be set too.
 - default_color_range: Default color range presented to the userspace, same
   values as supported_color_range
+- supported_formats: List of supported formats for this plane. To add a new item in the
+  list, write it using a plus its fourcc code: +XR24
+  To remove a format, use a minus and its fourcc: -XR24
+  To add all formats use +*
+  To remove all formats, use -*
 
 Continue by creating one or more CRTCs::
 
diff --git a/drivers/gpu/drm/vkms/tests/Makefile b/drivers/gpu/drm/vkms/tests/Makefile
index 5750f0bd9d40..a2dc4008d27e 100644
--- a/drivers/gpu/drm/vkms/tests/Makefile
+++ b/drivers/gpu/drm/vkms/tests/Makefile
@@ -2,6 +2,7 @@
 
 vkms-kunit-tests-y := \
 	vkms_config_test.o \
+	vkms_configfs_test.o \
 	vkms_format_test.o
 
 obj-$(CONFIG_DRM_VKMS_KUNIT_TEST) += vkms-kunit-tests.o
diff --git a/drivers/gpu/drm/vkms/tests/vkms_configfs_test.c b/drivers/gpu/drm/vkms/tests/vkms_configfs_test.c
new file mode 100644
index 000000000000..0963a8e8a585
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/vkms_configfs_test.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "linux/printk.h"
+#include <kunit/test.h>
+
+#include "../vkms_configfs.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+/**
+ * struct vkms_configfs_parse_format_case - Store test case for format parsing
+ * @data: Contains the string to parse
+ * @data_len: data len
+ * @expected_len: expected len of the matched format
+ * @expected_offset: expected offset in the string for the parsed format
+ */
+struct vkms_configfs_parse_format_case {
+	const char *data;
+	int data_len;
+	int expected_len;
+	int expected_offset;
+};
+
+struct vkms_configfs_parse_format_case vkms_configfs_parse_format_test_cases[] = {
+	{
+		.data = "+RG24",
+		.data_len = 6,
+		.expected_len = 5,
+		.expected_offset = 0,
+	}, {
+		.data = "-RG24",
+		.data_len = 6,
+		.expected_len = 5,
+		.expected_offset = 0
+	}, {
+		.data = "  -RG24",
+		.data_len = 8,
+		.expected_len = 5,
+		.expected_offset = 2
+	}, {
+		.data = "+*",
+		.data_len = 3,
+		.expected_len = 2,
+		.expected_offset = 0
+	}, {
+		.data = "-RG24+RG24",
+		.data_len = 11,
+		.expected_len = 5,
+		.expected_offset = 0
+	}, {
+		.data = "-R1+RG24",
+		.data_len = 9,
+		.expected_len = 3,
+		.expected_offset = 0
+	}, {
+		.data = "\n-R1",
+		.data_len = 5,
+		.expected_len = 3,
+		.expected_offset = 1
+	}, {
+		.data = "-R1111",
+		.data_len = 3,
+		.expected_len = 3,
+		.expected_offset = 0
+	}
+};
+
+static void vkms_configfs_test_parse_format(struct kunit *test)
+{
+	const struct vkms_configfs_parse_format_case *param = test->param_value;
+	char *out;
+	int len = vkms_configfs_parse_next_format(param->data, param->data + param->data_len, &out);
+
+	KUNIT_EXPECT_EQ(test, len, param->expected_len);
+	KUNIT_EXPECT_PTR_EQ(test, out, param->data + param->expected_offset);
+}
+
+static void vkms_configfs_test_parse_format_get_desc(struct vkms_configfs_parse_format_case *t,
+						     char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s", t->data);
+}
+
+KUNIT_ARRAY_PARAM(vkms_configfs_test_parse_format, vkms_configfs_parse_format_test_cases,
+		  vkms_configfs_test_parse_format_get_desc
+);
+
+static struct kunit_case vkms_configfs_test_cases[] = {
+	KUNIT_CASE_PARAM(vkms_configfs_test_parse_format,
+			 vkms_configfs_test_parse_format_gen_params),
+	{}
+};
+
+static struct kunit_suite vkms_configfs_test_suite = {
+	.name = "vkms-configfs",
+	.test_cases = vkms_configfs_test_cases,
+};
+
+kunit_test_suite(vkms_configfs_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Kunit test for vkms configfs utility");
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 3f658dd41272..b0a26c4dbebe 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
+
 #include <linux/cleanup.h>
 #include <linux/configfs.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/string.h>
+#include <kunit/visibility.h>
 
 #include "vkms_drv.h"
 #include "vkms_config.h"
@@ -618,6 +621,120 @@ static ssize_t plane_default_color_encoding_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_supported_formats_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	page[0] = '\0';
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		u32 *formats = vkms_config_plane_get_supported_formats(plane->config);
+
+		for (int i = 0;
+		     i < vkms_config_plane_get_supported_formats_count(plane->config);
+		     i++) {
+			char tmp[6] = { 0 };
+			const ssize_t ret = snprintf(tmp, ARRAY_SIZE(tmp), "%.*s\n",
+					       (int)sizeof(*formats),
+					       (char *)&formats[i]);
+			if (ret < 0)
+				return ret;
+			/*
+			 * Limitation of ConfigFS attributes, an attribute can't be bigger
+			 * than PAGE_SIZE. This will crop the result if this plane support
+			 * more than ≈1000 formats.
+			 */
+			if (ret + strlen(page) > PAGE_SIZE - 1)
+				return -ENOMEM;
+			strncat(page, tmp, ARRAY_SIZE(tmp));
+		}
+	}
+
+	return strlen(page);
+}
+
+/**
+ * parse_next_format() - Parse the next format in page, skipping all non fourcc-related characters
+ * @page: page to search into
+ * @page_end: last charater of the page
+ * @out: Output pointer, will point inside page
+ *
+ * Returns: size of the matched format, @out will point to the + or -
+ */
+VISIBLE_IF_KUNIT
+int vkms_configfs_parse_next_format(const char *page, const char *page_end, char **out)
+{
+	int count = page - page_end;
+	char *tmp_plus = strnchr(page, count, '+');
+	char *tmp_minus = strnchr(page, count, '-');
+
+	if (!tmp_plus && !tmp_minus)
+		return 0;
+	if (!tmp_plus)
+		*out = tmp_minus;
+	else if (!tmp_minus)
+		*out = tmp_plus;
+	else
+		*out = min(tmp_plus, tmp_minus);
+
+	char *end = *out + 1;
+
+	while (end < page_end) {
+		if (!isalnum(*end) && *end != '*')
+			break;
+		end++;
+	}
+
+	return end - *out;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_configfs_parse_next_format);
+
+static ssize_t plane_supported_formats_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct vkms_configfs_plane *plane;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+	int ret = 0;
+	const char *end_page = page + count;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		while (1) {
+			char *tmp;
+			char fmt[4] = {' ', ' ', ' ', ' '};
+			int len = vkms_configfs_parse_next_format(page, end_page, &tmp);
+
+			// No fourcc code found
+			if (len <= 1)
+				break;
+
+			page = tmp + len;
+			memcpy(tmp, &fmt[1], min(len - 1, 4));
+			if (tmp[0] == '+') {
+				if (fmt[0] == '*') {
+					ret = vkms_config_plane_add_all_formats(plane->config);
+					if (ret)
+						return ret;
+				} else {
+					ret = vkms_config_plane_add_format(plane->config,
+									   *(int *)fmt);
+					if (ret)
+						return ret;
+				}
+			} else if (tmp[0] == '-') {
+				if (fmt[0] == '*')
+					vkms_config_plane_remove_all_formats(plane->config);
+				else
+					vkms_config_plane_remove_format(plane->config, *(int *)fmt);
+			}
+		}
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, name);
 CONFIGFS_ATTR(plane_, supported_rotations);
@@ -626,6 +743,7 @@ CONFIGFS_ATTR(plane_, supported_color_ranges);
 CONFIGFS_ATTR(plane_, default_color_range);
 CONFIGFS_ATTR(plane_, supported_color_encodings);
 CONFIGFS_ATTR(plane_, default_color_encoding);
+CONFIGFS_ATTR(plane_, supported_formats);
 
 static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_type,
@@ -636,6 +754,7 @@ static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_default_color_range,
 	&plane_attr_supported_color_encodings,
 	&plane_attr_default_color_encoding,
+	&plane_attr_supported_formats,
 	NULL,
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.h b/drivers/gpu/drm/vkms/vkms_configfs.h
index e9020b0043db..2774655bfcc5 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.h
+++ b/drivers/gpu/drm/vkms/vkms_configfs.h
@@ -2,7 +2,13 @@
 #ifndef _VKMS_CONFIGFS_H_
 #define _VKMS_CONFIGFS_H_
 
+#include <linux/types.h>
+
 int vkms_configfs_register(void);
 void vkms_configfs_unregister(void);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int vkms_configfs_parse_next_format(const char *page, const char *end_page, char **out);
+#endif
+
 #endif /* _VKMS_CONFIGFS_H_ */

-- 
2.51.0


