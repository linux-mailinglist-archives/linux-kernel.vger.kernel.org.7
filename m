Return-Path: <linux-kernel+bounces-790914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8923B3AF87
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928CB16F398
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A8D18A93F;
	Fri, 29 Aug 2025 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m+7X99VY"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166714B96E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427625; cv=none; b=ikjji4KktdD0xKo9E/f9yYu862Xis4mhMPwndTRcYKHXQz8ffyOiS/gS5FJpN2FXb5fRb2ITeywQ3nVMZqUc2iCXSliyIKnPf9fYv+mJvDGFuGyd3toikPstyEW58KdVBGI64nCQZHX2QG3rQlAgROcJlA7ssv+PsWQf/Jikj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427625; c=relaxed/simple;
	bh=nFQXM1aW41LAXPppteosWFPJ4eFtmadciONPJS3w3W8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHpTBRXUFnml5boMxYmHPpSY5rxZKWIa1ORui6a0I/OaInjaKcqIaQ6XbozPuZ2IF+QIoN2n2BRuqcEtVi9K/LZQUPS+7PYM7DiNk8COlP876l9DSeEQLmWVD3SCW5uXnwaZR3hXb5eWyPeW9OoctrtOGAWl0ZMBz7h5LgDz2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m+7X99VY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-248ff4403b9so6805455ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756427623; x=1757032423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4cQ2mwFM3/MUzj8X9mmiON4xa3YENmuqiejyCjoPpY=;
        b=m+7X99VYiNIOEvKs+HNhAdXq61VUYhz8Spjh8UoqLbgJL/r3O6x1RPPPlCp1Brp+gr
         jGoWlHtG1EH9H1xYEewA8PGMwZtgBxgmpeRodTyvogN/mRB5P2iFXy27lK3Riaa87UiE
         JWMVKbH0JRv6/cvuJAOuW4rWgzDw6kqK7hfHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427623; x=1757032423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4cQ2mwFM3/MUzj8X9mmiON4xa3YENmuqiejyCjoPpY=;
        b=wKgeMmEczjHT2FfUzBzVrZWQsiFDR/+jkmFySXPQFBK5CoxiZfXtO9cDExpAy7YHvK
         NQ39B37+gQ/ukgbKWjQpU8DTBsLUUSACxQJOf46LVXB/bz0YRU4ILeCG9OXNX2rKgLEe
         1QECj4oKGvlp9/J1nUg0uQLUfSA9YWCu4RftURRpjXT1lOZ695CwDsVV5icCRXncXCWE
         txtHkBCP6dBp1azodmChWZU4N5mFJ9cMCpQtvHdGkjGK1IjRbYhMyMzfqhZ4ZWQiVFTl
         ZBZ1WC28Hn1zfsMiMru47f10D/esCZu5Qke67SQAhYqqTJyy97hE/hSzibMTGgCHSiBG
         7XJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0diiG2F/pYiKN6sNhMccBsgP40GspG+GVHMYJOWOa/wDxEPdvyshvBZArJYSzA9AiSWcxYF596/wy+nI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0lKmKnOA2skBUYvTn1P1D5/DeFG8OToIyq3UbDuwyXIdEm+EG
	vakTUv7T9x9A/wxs1sBT02mC8KvBmxRDG7hFQSVLl9zjp4u1fvIc9AaHMPrsD0lE0Q==
X-Gm-Gg: ASbGncsveJFWbcSBC50Oeq24cnai2NhIB3Yn3XnmFZy8IHJY4c55cBDCBv8TaKrEpIy
	lUk9FWez9aWr1V+zwK3/VvYLO2K4/DZTsGXNulwZs+9+1p+pkir2wl5rlUeICmjJBd3YbQQnqT8
	LjO8AdMaDTjYBMykEJy/wM4wECXb2+X9P8k6lQDbTlQIiOE2ZoGjANjSkGHvM2XosLn+c/C1KKG
	4mBRdvbY8qvooq3jwcBzFMZoXtdbgiNHwcDMsFu4NvVji3MyrglH0KKgUV/vsYfJ38LIgHA6ugD
	HbxvHwXTSYsBi+mdxg9Yvg884qVhVGyTOBvPYOCSR09tnGy7q/72gMIEo+GUfYm1r9ql5NyiubE
	oMyx17eSmmgQSLPm7nVNmFMw6rkW/TgnBAbU754woHGW36YiPUZC1SVQqkK5v8wBBKzA739s=
X-Google-Smtp-Source: AGHT+IF4t2agZT+2M4WjltArWt5bcLKvc6/IrvChCMZyFh3GDggVY1firwSU9tWo3JJu2r4WvgmpQw==
X-Received: by 2002:a17:902:c94c:b0:245:f0d8:6ee2 with SMTP id d9443c01a7336-2462efade2amr357353545ad.52.1756427623139;
        Thu, 28 Aug 2025 17:33:43 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2893:df0f:26ec:df00])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4cd0e1cfbbsm590852a12.23.2025.08.28.17.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 17:33:42 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	kunit-dev@googlegroups.com,
	Len Brown <lenb@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/3] PM: runtime: Add basic kunit tests for API contracts
Date: Thu, 28 Aug 2025 17:28:26 -0700
Message-ID: <20250829003319.2785282-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
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

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/Kconfig              |   6 +
 drivers/base/power/Makefile       |   1 +
 drivers/base/power/runtime-test.c | 259 ++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
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
index 000000000000..263c28d5fc50
--- /dev/null
+++ b/drivers/base/power/runtime-test.c
@@ -0,0 +1,259 @@
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
+
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	pm_runtime_get_noresume(dev);
+
+	/* Flush, in case the above (non-sync) triggered any work. */
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup needed */
+
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	/*
+	 * We never actually left RPM_SUSPENDED, but rpm_idle() still treats
+	 * this as -EAGAIN / "runtime PM status change ongoing".
+	 */
+	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put(dev));
+
+	pm_runtime_get_noresume(dev);
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
+
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_request_autosuspend(dev));
+
+	pm_runtime_get_noresume(dev);
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync_autosuspend(dev));
+
+	pm_runtime_get_noresume(dev);
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_autosuspend(dev));
+
+	/* Grab 2 refcounts */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_get_noresume(dev);
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	/* The first put() sees usage_count 1 */
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_autosuspend(dev));
+	/* The second put() sees usage_count 0 but tells us "already suspended". */
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_autosuspend(dev));
+
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
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put(dev));
+
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get_sync(dev));
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_sync(dev));
+
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
+	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_autosuspend(dev));
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
+	/* Still active */
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
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
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put(dev));
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get_sync(dev));
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_sync(dev));
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
+	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_autosuspend(dev));
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
+	/* Still suspended */
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	/* Clear error */
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_set_suspended(dev));
+	KUNIT_EXPECT_EQ(test, 0, dev->power.runtime_error);
+	/* Still suspended */
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_barrier(dev)); /* resume was pending */
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put(dev));
+	pm_runtime_suspend(dev); /* flush the put(), to suspend */
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_autosuspend(dev));
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_resume_and_get(dev));
+
+	/*
+	 * The following should all "fail" with -EAGAIN (usage is non-zero) or
+	 * 1 (already resumed).
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
+	/* Flush, and ensure we stayed active. */
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
2.51.0.318.gd7df087d1a-goog


