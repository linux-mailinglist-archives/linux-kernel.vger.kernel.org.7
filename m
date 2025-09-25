Return-Path: <linux-kernel+bounces-833109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C994BA13DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1521893014
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E52D31D72C;
	Thu, 25 Sep 2025 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kiXMnWxJ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534831C591
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829385; cv=none; b=Ub5DUl1EErzwspC88sFaPgw747rIRXEHDB1I8jCNnnH+mpmO22X2ByLgmcueo6x9+Vl7+wg7bSFYdr+B5r+y62m+OKdKSHdpWL5eJlkG9fulIxrTCwV3FF5oMxWUpq1gH5ZPOHWZqhElpSypVTP3Hou0zzM708Rt+ugl7+tZz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829385; c=relaxed/simple;
	bh=74tY1ELT7zownYIeAAXgYi7gf5wP5xv05LDXflcNJKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izVv0BAJ2lWh1cbxe9JPZieEXLaIwtGxeVQxJPq7qKXQLdlBrHtzi5ujy3+sThC7wKtFXjytp6nSA7IvoQJcP9cx29cekawswaYjFixpFDw7QIGeSjZMaHcquepHo+s9xqcQ7AutvLTY+Vo1kyf8RMY6rgkXfiYWxeV4Pc8RXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kiXMnWxJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so1936007b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758829383; x=1759434183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5edo0c5RxfliwGuYbyfUV04HpZukmfrtbIDiUss1FI=;
        b=kiXMnWxJRsKeFyepzi15tYztNVBGgy7hxVoKOXqEehx8VQ0Er3L8e5ix1mRrIy/KXu
         azHklymUzBUFVMJn16KRz31t5nW2PAUqEU9X3gbSI0HrnXgUp4Mnf8D9bR2TSlojbak6
         ZyaiyI1qtnPfqGnY/5ViJR+kxoVOGogpzRFKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829383; x=1759434183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5edo0c5RxfliwGuYbyfUV04HpZukmfrtbIDiUss1FI=;
        b=uoPj+Bcoewmxgg2M54uXNPiifmcnfvxsV1aXr+qkj6SQGNLU6aFR0ebcB2VnXvG2nS
         FPKpT0xk8yfx54aS0FSa87UO3r5PDS889HFmtQdB+cTqnZBOyQ/rX2ZmIqLTzc7eZaLg
         etc1+qGSmRaE87i0tDGiCPxZA3msHqdDO1IZlPYvHkdRepMSbvsyJf/7VQUlNqIxKkd0
         4EqfJ97Zru8xOU0RT+XT8KQsk+d6cxzi1t98KILmcN5SqP1WHdZB3ai9wZjLYap1S8h+
         OILgSf0eCb4YFKuG/DhamzOu90N7QbR5esieU1HBd7oyixROBKMY012UTxdeMCRJEW4r
         r3UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+4GcaEECRQr0p4ZFWpNbJGc9yjsj/anBqw2g4wAOiQW5y89eri+wadHtjgvMSLHYKH4Js3uSt7F9uxrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe/a5TkVGG9TG2AXxO+VK8X1VUZJfpUfYAEsetCn7qIaFOLgkT
	0L1B9BNyHnTkDxaHlMUET18J2NxvynbjwOwHs/gz4tp6rCi9Y+i7llSTHzgGmngCpA==
X-Gm-Gg: ASbGncstkC1Du22OJJCthY2MDq4l24d9dxMTWDjjolH7H76pWjvw2dfj4f7HohS5+f7
	r3TqqvL1ZzJnIlMSWUDogA9jCIYLfR7kgVvY2DGewFe96yB7lBNRqh3VY4CbI2dOSoxN2zs+ndS
	hJMHWggVMma6cjneJmjYg03m/RK6n6uswTs4a0pdmdH1H/C9X0ZUCY3O2NR6d7LttXpTvWgC+cR
	eFW7IkKZL/eEwhX/p1KNqdsv/jAhHuoKB0+QVhIoo5rw0LoBYVTsW7yUCILVAIz6yaMO6ktTF69
	qnZ19PTr2x0zx5C5vcUgpRXdSjIePaSXoOvFn2y9fq8gnrtxlA2xYAV8tqrYE+loQ9H/I1bHDmi
	FZaa+gRIGd+VGLDQqP4esS3ygYzkixsOCtbUgm/k3v1ofUx6OhLy/HirWphb/
X-Google-Smtp-Source: AGHT+IEA4G/PWQo5B8b4huFdT4a5O8BIqPRp211JB0bxrg5wYp/9BSb6ozNlW0nMisWxY+MUvMrSdA==
X-Received: by 2002:a05:6a20:3d83:b0:263:bee9:1ac8 with SMTP id adf61e73a8af0-2e7d3db6041mr5785570637.28.1758829383044;
        Thu, 25 Sep 2025 12:43:03 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:ef44:9df6:231a:cd29])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b57c55a41b1sm2848378a12.44.2025.09.25.12.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:43:02 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	kunit-dev@googlegroups.com,
	linux-pm@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/3] PM: runtime: Add basic kunit tests for API contracts
Date: Thu, 25 Sep 2025 12:42:14 -0700
Message-ID: <20250925124216.v2.1.I443d97ccd1c67f32670eb93784ad735b11816743@changeid>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In exploring the various return codes and failure modes of runtime PM
APIs, I found it helpful to verify and codify many of them in unit
tests, especially given that even the kerneldoc can be rather complex to
reason through, and it also has had subtle errors of its own.

Notably, I avoid testing the return codes for pm_runtime_put() and
pm_runtime_put_autosuspend(), since code that checks them is probably
wrong, and we're considering making them return 'void' altogether. I
still test the sync() variants, since those have a bit more meaning to
them.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Improve comments, per review suggestions
 * Minor sequence changes, per review suggestions
 * Stop testing for pm_runtime_put() and pm_runtime_put_autosuspend()
   return codes

 drivers/base/Kconfig              |   6 +
 drivers/base/power/Makefile       |   1 +
 drivers/base/power/runtime-test.c | 253 ++++++++++++++++++++++++++++++
 3 files changed, 260 insertions(+)
 create mode 100644 drivers/base/power/runtime-test.c

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 064eb52ff7e2..1786d87b29e2 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -167,6 +167,12 @@ config PM_QOS_KUNIT_TEST
 	depends on KUNIT=y
 	default KUNIT_ALL_TESTS
 
+config PM_RUNTIME_KUNIT_TEST
+	tristate "KUnit Tests for runtime PM" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on PM
+	default KUNIT_ALL_TESTS
+
 config HMEM_REPORTING
 	bool
 	default n
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 01f11629d241..2989e42d0161 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o wakeup_stats.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
+obj-$(CONFIG_PM_RUNTIME_KUNIT_TEST) += runtime-test.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
new file mode 100644
index 000000000000..2e966fd96664
--- /dev/null
+++ b/drivers/base/power/runtime-test.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google, Inc.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/pm_runtime.h>
+#include <kunit/device.h>
+#include <kunit/test.h>
+
+#define DEVICE_NAME "pm_runtime_test_device"
+
+static void pm_runtime_depth_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+
+	pm_runtime_enable(dev);
+
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_get_sync(dev)); /* "already active" */
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+}
+
+/* Test pm_runtime_put() and friends when already suspended. */
+static void pm_runtime_already_suspended_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+
+	pm_runtime_enable(dev);
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+
+	pm_runtime_get_noresume(dev);
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup needed */
+	pm_runtime_put(dev);
+
+	pm_runtime_get_noresume(dev);
+	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
+
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_request_autosuspend(dev));
+
+	pm_runtime_get_noresume(dev);
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync_autosuspend(dev));
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	/* Grab 2 refcounts */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_get_noresume(dev);
+	/* The first put() sees usage_count 1 */
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync_autosuspend(dev));
+	/* The second put() sees usage_count 0 but tells us "already suspended". */
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync_autosuspend(dev));
+
+	/* Should have remained suspended the whole time. */
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+}
+
+static void pm_runtime_idle_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+
+	pm_runtime_enable(dev);
+
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
+	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
+	pm_runtime_put_noidle(dev);
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_idle(dev));
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
+	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_idle(dev));
+}
+
+static void pm_runtime_disabled_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+
+	/* Never called pm_runtime_enable() */
+	KUNIT_EXPECT_FALSE(test, pm_runtime_enabled(dev));
+
+	/* "disabled" is treated as "active" */
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
+	KUNIT_EXPECT_FALSE(test, pm_runtime_suspended(dev));
+
+	/*
+	 * Note: these "fail", but they still acquire/release refcounts, so
+	 * keep them balanced.
+	 */
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
+	pm_runtime_put(dev);
+
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get_sync(dev));
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_sync(dev));
+
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
+	pm_runtime_put_autosuspend(dev);
+
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume_and_get(dev));
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_idle(dev));
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_request_idle(dev));
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_request_resume(dev));
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_request_autosuspend(dev));
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_suspend(dev));
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume(dev));
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_autosuspend(dev));
+
+	/* Still disabled */
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
+	KUNIT_EXPECT_FALSE(test, pm_runtime_enabled(dev));
+}
+
+static void pm_runtime_error_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+
+	pm_runtime_enable(dev);
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+
+	/* Fake a .runtime_resume() error */
+	dev->power.runtime_error = -EIO;
+
+	/*
+	 * Note: these "fail", but they still acquire/release refcounts, so
+	 * keep them balanced.
+	 */
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
+	pm_runtime_put(dev);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get_sync(dev));
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_sync(dev));
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
+	pm_runtime_put_autosuspend(dev);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_sync_autosuspend(dev));
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume_and_get(dev));
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_idle(dev));
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_idle(dev));
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_resume(dev));
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_autosuspend(dev));
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_suspend(dev));
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume(dev));
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_autosuspend(dev));
+
+	/* Error is still pending */
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	KUNIT_EXPECT_EQ(test, -EIO, dev->power.runtime_error);
+	/* Clear error */
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_set_suspended(dev));
+	KUNIT_EXPECT_EQ(test, 0, dev->power.runtime_error);
+	/* Still suspended */
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_barrier(dev)); /* resume was pending */
+	pm_runtime_put(dev);
+	pm_runtime_suspend(dev); /* flush the put(), to suspend */
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
+	pm_runtime_put_autosuspend(dev);
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_resume_and_get(dev));
+
+	/*
+	 * The following should all return -EAGAIN (usage is non-zero) or 1
+	 * (already resumed).
+	 */
+	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
+	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_idle(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_request_resume(dev));
+	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_autosuspend(dev));
+	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_suspend(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_resume(dev));
+	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_autosuspend(dev));
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
+
+	/* Suspended again */
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+}
+
+/*
+ * Explore a typical probe() sequence in which a device marks itself powered,
+ * but doesn't hold any runtime PM reference, so it suspends as soon as it goes
+ * idle.
+ */
+static void pm_runtime_probe_active_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+
+	KUNIT_EXPECT_TRUE(test, pm_runtime_status_suspended(dev));
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_set_active(dev));
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
+
+	pm_runtime_enable(dev);
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
+
+	/* Nothing to flush. We stay active. */
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev));
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
+
+	/* Ask for idle? Now we suspend. */
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_idle(dev));
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+}
+
+static struct kunit_case pm_runtime_test_cases[] = {
+	KUNIT_CASE(pm_runtime_depth_test),
+	KUNIT_CASE(pm_runtime_already_suspended_test),
+	KUNIT_CASE(pm_runtime_idle_test),
+	KUNIT_CASE(pm_runtime_disabled_test),
+	KUNIT_CASE(pm_runtime_error_test),
+	KUNIT_CASE(pm_runtime_probe_active_test),
+	{}
+};
+
+static struct kunit_suite pm_runtime_test_suite = {
+	.name = "pm_runtime_test_cases",
+	.test_cases = pm_runtime_test_cases,
+};
+
+kunit_test_suite(pm_runtime_test_suite);
+MODULE_DESCRIPTION("Runtime power management unit test suite");
+MODULE_LICENSE("GPL");
-- 
2.51.0.536.g15c5d4f767-goog


