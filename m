Return-Path: <linux-kernel+bounces-891060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EBCC41B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF834352384
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5DB34A78C;
	Fri,  7 Nov 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dGTKGzaP"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322B34845C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549579; cv=none; b=njxkJi1KQk4uvDbpGjZw0zBR52CxmoAyK7BJ15xtjY3u52ujRM/pabvopvPEFvADtTCfVr1sII9xjam5ab1xnmscwbbjCVUwYz7zK/Grjf9GF6iuQxdL+obUjD1HJXuEgrjlMRJ4jFxhPEzqOuLy4McNnWa4zp9rnV9yMLO+HkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549579; c=relaxed/simple;
	bh=Kl9YsS1PIGvtggF1uJm277eJ2mqf4fTidxqHPnljr/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzobUYG2im/3ToQfXdqedyiZUO7ZhS+XYmjLcV0d2ZtN4vcGBTyaHJN/u+V92s3XNoOHNSWTg/2QvqJKi8Q7nnLsgl9qbxkxDwswzO8um/S3bdPpRdxvwjHNJ2ECul2yNfJC3AXe3uKgR4Xjw2HMlfcMgGgzjj04/kr9eb+pnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dGTKGzaP; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7869819394aso11261967b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549575; x=1763154375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzZNGPgWx94ISN9X3lQ14PyLWRhGYF2GiiJN7CqbrDw=;
        b=dGTKGzaPbq2rhZiIVJlx9wsOVAvU3zIy/GGqJAm+YflUZKGmGJSsOABdRm2E//1vjU
         rRZhmIhqK/+7avXKXIVl95eiDOqOWbKHPzR9TAFutXZtRqE+Tg9XTWlSbq2QSQnm0UKl
         kU1L6BTDqIBBq9q0ZU2U0asik3f7PjaD7AuJk5j/+GLNLfD0ndJPm/UJPV1DxMVOWjpA
         8HcGgklHfuhxYXyAB5IphIp0nFPL71SJwKF9mXMvuhU7k6h08I6OkCQeq6JMIF9QSdkm
         cSTepREt1VUqWsAp/TKfGVx6uqYPJRd76LKx3lKu8bHhMnJ5gJ5SXR+muQMWJcEjEc5Q
         1Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549575; x=1763154375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zzZNGPgWx94ISN9X3lQ14PyLWRhGYF2GiiJN7CqbrDw=;
        b=k64CoVOa+N6DdhhNvlKh4SNSEl0/QsLjo7ZJC3xrBKqkbMdqSuHB6IeBLxu3/6tu/m
         sOqqgXM7ZBw52YOVx0ZjAAHd71HbBGU7VFhoqtqrLrKdrCaORAMHWVPnd/YJqu73dH54
         ZwLakC83JBFt1zpPYi2tp+89CRQOEl/7axDoIaJ3FDZYaHnck23NfAv0o2qOfF6V5iT9
         AhXFgVP0xxxrsKAvFjbhcvGBOkfmcOVGsiVfhmrxvVivXrh7KhnfbH32AqJNCXcD8RX/
         vYcMPGw9kW5XZIBfK5JOseI+jCp7a2WHqlLfMqOaQ9YduD8cQXrrbC99GMBBvuYqD4Kp
         zeOw==
X-Forwarded-Encrypted: i=1; AJvYcCXtWlITxvYXtFGctddjb+OPDr45sw68k122b107a18f5hRr7DxVl9fuf4QYxL27jivAzMOp4INkTwwOawk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZR87AcqTRmOQZmWdb4OdKB1vQyCvr7NKUhoOOQLRLq/WGHGe7
	8xvBOD4l+ocG7q9NYIwSe59R4feRcR9zqSRsllJTymxwMa653KS753k9+xnKNwtIcAs=
X-Gm-Gg: ASbGncvQPixDzO/8n4ttn1YuSyknD56yy7F0ceBRllCVm7MYPpbmYjzep0gRha3aFkG
	2UnaEtH6ydalZeTMP424Bfiadqs1+7ktV0jPMUIgBuhHiHw+MQOaKHNQVNw3Uj9uZt4tIGXA0qT
	CyBXdxgajaVeeFG98UExRWXesbJd9nTXdhIR5WHi3zrVjD+m8iq9cuVZtiaSlGQ3AiyiSylu9Gd
	FGaZSBdfLOWpucrW+Y2G+CfdTYM7iSy8Qy4mFiUHQECxckwt2uGA9hD6YutXmbc39Xl9/yLHZ3h
	Nujz5UX0JL94B4m3r+qdXhrewMbGtHbDfKspIMR4SNmPXYtLIVTu6tiAXcOhvzZBh/dpS5NjL1K
	ZLK9XhZy4utkpEv2lAB5xWYmtD8vRZ4z80Ww4foDdIwCdBZ85GprOvYaL+e5yDjB+rs4Z6PcjWC
	NZYFODhbulwW0aX58UUSKEsr8wJv3mgmA5KBFLn/45d/Sul0/AfDOEedrWPlTe3dSJnMQbXFFAi
	A==
X-Google-Smtp-Source: AGHT+IHOz7qc/OdNH+hwEFR2mgMLzMFENl/tjweqpUXWP41GYcTPchZvuPAXTMaj9WvfxwDjBEwMvw==
X-Received: by 2002:a05:690c:690b:b0:786:6df0:8a36 with SMTP id 00721157ae682-787d53afd94mr7203087b3.29.1762549575032;
        Fri, 07 Nov 2025 13:06:15 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:06:14 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v5 22/22] tests/liveupdate: Add in-kernel liveupdate test
Date: Fri,  7 Nov 2025 16:03:20 -0500
Message-ID: <20251107210526.257742-23-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an in-kernel test module to validate the core logic of the
Live Update Orchestrator's File-Lifecycle-Bound feature. This
provides a low-level, controlled environment to test FLB registration
and callback invocation without requiring userspace interaction or
actual kexec reboots.

The test is enabled by the CONFIG_LIVEUPDATE_TEST Kconfig option.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_file.c     |   2 +
 kernel/liveupdate/luo_internal.h |   8 ++
 lib/Kconfig.debug                |  23 ++++++
 lib/tests/Makefile               |   1 +
 lib/tests/liveupdate.c           | 130 +++++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+)
 create mode 100644 lib/tests/liveupdate.c

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 713069b96278..4c0a75918f3d 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -829,6 +829,8 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 	INIT_LIST_HEAD(&fh->flb_list);
 	list_add_tail(&fh->list, &luo_file_handler_list);
 
+	liveupdate_test_register(fh);
+
 	return 0;
 }
 
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 89c2fd97e5a7..be8986f7ac9b 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -90,4 +90,12 @@ int __init luo_flb_setup_outgoing(void *fdt);
 int __init luo_flb_setup_incoming(void *fdt);
 void luo_flb_serialize(void);
 
+#ifdef CONFIG_LIVEUPDATE_TEST
+void liveupdate_test_register(struct liveupdate_file_handler *h);
+#else
+static inline void liveupdate_test_register(struct liveupdate_file_handler *h)
+{
+}
+#endif
+
 #endif /* _LINUX_LUO_INTERNAL_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ddacf9e665a2..2cbfa3dead0b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2813,6 +2813,29 @@ config LINEAR_RANGES_TEST
 
 	  If unsure, say N.
 
+config LIVEUPDATE_TEST
+	bool "Live Update Kernel Test"
+	default n
+	depends on LIVEUPDATE
+	help
+	  Enable a built-in kernel test module for the Live Update
+	  Orchestrator.
+
+	  This module validates the File-Lifecycle-Bound subsystem by
+	  registering a set of mock FLB objects with any real file handlers
+	  that support live update (such as the memfd handler).
+
+	  When live update operations are performed, this test module will
+	  output messages to the kernel log (dmesg), confirming that its
+	  registration and various callback functions (preserve, retrieve,
+	  finish, etc.) are being invoked correctly.
+
+	  This is a debugging and regression testing tool for developers
+	  working on the Live Update subsystem. It should not be enabled in
+	  production kernels.
+
+	  If unsure, say N
+
 config CMDLINE_KUNIT_TEST
 	tristate "KUnit test for cmdline API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index f7460831cfdd..8e5c527a94ac 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_KFIFO_KUNIT_TEST) += kfifo_kunit.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_LIVEUPDATE_TEST) += liveupdate.o
 
 CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
diff --git a/lib/tests/liveupdate.c b/lib/tests/liveupdate.c
new file mode 100644
index 000000000000..62c592aa859f
--- /dev/null
+++ b/lib/tests/liveupdate.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME " test: " fmt
+
+#include <linux/init.h>
+#include <linux/liveupdate.h>
+#include <linux/module.h>
+#include "../../kernel/liveupdate/luo_internal.h"
+
+#define TEST_NFLBS 3
+#define TEST_FLB_MAGIC_BASE 0xFEEDF00DCAFEBEE0ULL
+
+static struct liveupdate_flb test_flbs[TEST_NFLBS];
+
+static int test_flb_preserve(struct liveupdate_flb_op_args *argp)
+{
+	ptrdiff_t index = argp->flb - test_flbs;
+
+	pr_info("%s: preserve was triggered\n", argp->flb->compatible);
+	argp->data = TEST_FLB_MAGIC_BASE + index;
+
+	return 0;
+}
+
+static void test_flb_unpreserve(struct liveupdate_flb_op_args *argp)
+{
+	pr_info("%s: unpreserve was triggered\n", argp->flb->compatible);
+}
+
+static void test_flb_retrieve(struct liveupdate_flb_op_args *argp)
+{
+	ptrdiff_t index = argp->flb - test_flbs;
+	u64 expected_data = TEST_FLB_MAGIC_BASE + index;
+
+	if (argp->data == expected_data) {
+		pr_info("%s: found flb data from the previous boot\n",
+			argp->flb->compatible);
+		argp->obj = (void *)argp->data;
+	} else {
+		pr_err("%s: ERROR - incorrect data handle: %llx, expected %llx\n",
+		       argp->flb->compatible, argp->data, expected_data);
+	}
+}
+
+static void test_flb_finish(struct liveupdate_flb_op_args *argp)
+{
+	ptrdiff_t index = argp->flb - test_flbs;
+	void *expected_obj = (void *)(TEST_FLB_MAGIC_BASE + index);
+
+	if (argp->obj == expected_obj)
+		pr_info("%s: finish was triggered\n", argp->flb->compatible);
+	else
+		pr_err("%s: ERROR - finish called with invalid object\n",
+		       argp->flb->compatible);
+}
+
+static const struct liveupdate_flb_ops test_flb_ops = {
+	.preserve	= test_flb_preserve,
+	.unpreserve	= test_flb_unpreserve,
+	.retrieve	= test_flb_retrieve,
+	.finish		= test_flb_finish,
+};
+
+#define DEFINE_TEST_FLB(i) \
+	{ .ops = &test_flb_ops, .compatible = "test-flb-v" #i }
+
+static struct liveupdate_flb test_flbs[TEST_NFLBS] = {
+	DEFINE_TEST_FLB(0),
+	DEFINE_TEST_FLB(1),
+	DEFINE_TEST_FLB(2),
+};
+
+static int __init liveupdate_test_early_init(void)
+{
+	int i;
+
+	if (!liveupdate_enabled())
+		return 0;
+
+	for (i = 0; i < TEST_NFLBS; i++) {
+		struct liveupdate_flb *flb = &test_flbs[i];
+		void *obj;
+		int err;
+
+		liveupdate_init_flb(flb);
+
+		err = liveupdate_flb_incoming_locked(flb, &obj);
+		if (!err) {
+			liveupdate_flb_incoming_unlock(flb, obj);
+		} else if (err != -ENODATA && err != -ENOENT) {
+			pr_err("liveupdate_flb_incoming_locked for %s failed: %pe\n",
+			       flb->compatible, ERR_PTR(err));
+		}
+	}
+
+	return 0;
+}
+early_initcall(liveupdate_test_early_init);
+
+void liveupdate_test_register(struct liveupdate_file_handler *h)
+{
+	int err, i;
+
+	for (i = 0; i < TEST_NFLBS; i++) {
+		struct liveupdate_flb *flb = &test_flbs[i];
+
+		err = liveupdate_register_flb(h, flb);
+		if (err)
+			pr_err("Failed to register %s %pe\n",
+			       flb->compatible, ERR_PTR(err));
+	}
+
+	err = liveupdate_register_flb(h, &test_flbs[0]);
+	if (!err || err != -EEXIST) {
+		pr_err("Failed: %s should be already registered, but got err: %pe\n",
+		       test_flbs[0].compatible, ERR_PTR(err));
+	}
+
+	pr_info("Registered %d FLBs with file handler: [%s]\n",
+		TEST_NFLBS, h->compatible);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pasha Tatashin <pasha.tatashin@soleen.com>");
+MODULE_DESCRIPTION("In-kernel test for LUO mechanism");
-- 
2.51.2.1041.gc1ab5b90ca-goog


