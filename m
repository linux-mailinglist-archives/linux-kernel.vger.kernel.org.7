Return-Path: <linux-kernel+bounces-799621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD3B42E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66351632F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C91155333;
	Thu,  4 Sep 2025 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6LAnM5E"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA97E105
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945625; cv=none; b=s20ggfhUJ+3NbuO1v4j5mpIxASc9j3CT9XvpHQvBF+C9x6hxJGZaFZMJLmCrTbMDriUOyFZWPSJx9sSSib09gwtm7/invCwY1gG8pq7FAnjQeJB5gOQa6Di8+CJmRGTeo9PNmLem1AK6eezDW5yad7xFvA/JEVaXstXZ3Xw57Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945625; c=relaxed/simple;
	bh=QgEaYKf0+NtoGV2J2qlMRu+LSVec7oKtZLa7qMtLk68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rxeAwjtoPdAiHDzSPqWn5xfCkiqxh4ojI0irGhb4fGxnXT1kDBCoz1OdrZ+rMV+4FCJuuCecikn6Ejt2FFyLnp/jN0yhOQgQMjBiRN4upPOkoc7o+2LuYrtDXU7M6edaDG88+FKHOHhV1DKUqI8iwNVrC/3yii/hMTOfm+/CXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y6LAnM5E; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24b18ad403eso12211855ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756945623; x=1757550423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh9+/BRpi/v1UoM93ifYBxoxd35O+IdZFaGleFP8xKY=;
        b=Y6LAnM5Evg6qPEiTE2bdxjqyS6eM6+vvEmN/X8U8aisvkvVh77OzhCO/MFB7bSgAMA
         2HOCKKeRkoxaBxvW1EZOPjAUNfBCQ0ii+sBV2TNlpZcr5KoiicLEIrXvsskGLrUqBIcg
         7/BfsCET2BVxUuoxdFPiLEs2lW+kK2QMb0kqyr6o6pypyeUCHCYVJPpgupr15EJWw6vZ
         dFjBXM6o8mUnZaAuJsUoYLUp32cZEQVaqoAZnuDON8z8jz14HqGVUM2rZyRt0TylDP4l
         5NaXEJPjI2V4aKG7wh/vwXCv+W4cUHOBFb9x5igCN408TWi7ELSePJIJE++gT8/FWkR4
         ftug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945623; x=1757550423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh9+/BRpi/v1UoM93ifYBxoxd35O+IdZFaGleFP8xKY=;
        b=lXVFJnObhN0B4iIG4cBdCCZ/+gOLLtAavIG30Eij/y2FsPEcDNKXQY/pF9gukFnYhe
         if8uI6NgxtEP3hPNQ3mR1cKctQcN5UM4yamC64xNpawypAPpgSXAWMHmQaUQBzfcBhEs
         kffJUPyJ/D/eqWHRUxSphI+W3w6TK+/wKZRwCjmByNyYGdU7Wy+n+ihpyBIr28OSxMth
         iKTqb4rjToa+GH/oj2WLQdf1nvvQqUbU///+Wqu2mTOyKyjM75L7tkpKTvEqaWWzIIyA
         6jZ9vVJDc2trTeXSFd1TnaM+b0cFZG89GYIg3XaonO/tmmL+69CcKZNKm9Cd1Jr1Cr3+
         Yomg==
X-Gm-Message-State: AOJu0YxE+1u/Nx/Z7laxue+wlXMnEjn/dEkph4b1yb195zzNgt5+4sIR
	J2sttYzkrgz/gMS8/2YWO9TBImb2Xmy0x2OhIuUkX5zJKnCRXaAaQQ7Vk+cZBVZvMWXzR38aYJI
	T8aooT5fCmrt3+qWw3AwEPNEAWZVAdGokcGMkdmXOEOPls89CIw6SJZ8c5EJLVs/nt+s1dEbHy+
	9F8Ed9MBuKXSIcW8sf+Bfpsg/ZA0L/1zVgz3QGC0UyYqefcPJV
X-Google-Smtp-Source: AGHT+IHlyu4heNwNO+vvRSL4y0d+uFls78Hw61PgteGOlGigLscvhQwYOqi27fdlZBgqmoQeJAkdf4B6BOsf
X-Received: from pjbeu6.prod.google.com ([2002:a17:90a:f946:b0:31c:32f8:3f88])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da88:b0:249:f4f:f021
 with SMTP id d9443c01a7336-2493ef9ee79mr216380635ad.24.1756945623511; Wed, 03
 Sep 2025 17:27:03 -0700 (PDT)
Date: Thu,  4 Sep 2025 00:26:46 +0000
In-Reply-To: <20250904002658.974593-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904002658.974593-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904002658.974593-3-jstultz@google.com>
Subject: [RESEND x2][PATCH 3/3] test-ww_mutex: Allow test to be run (and
 re-run) from userland
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

In cases where the ww_mutex test was occasionally tripping on
hard to find issues, leaving qemu in a reboot loop was my best
way to reproduce problems. These reboots however wasted time
when I just wanted to run the test-ww_mutex logic.

So tweak the test-ww_mutex test so that it can be re-triggered
via a sysfs file, so the test can be run repeatedly without
doing module loads or restarting.

This has been particularly valuable to stressing and finding
issues with the proxy-exec series.

To use, run as root:
  echo 1 > /sys/kernel/test_ww_mutex/run_tests

Signed-off-by: John Stultz <jstultz@google.com>
---
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kernel-team@android.com
---
 kernel/locking/test-ww_mutex.c | 51 ++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 11bc467c286aa..e7b7211d25768 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -642,7 +642,7 @@ static int stress(struct ww_class *class, int nlocks, int nthreads, unsigned int
 	return 0;
 }
 
-static int __init run_tests(struct ww_class *class)
+static int run_tests(struct ww_class *class)
 {
 	int ncpus = num_online_cpus();
 	int ret, i;
@@ -684,7 +684,7 @@ static int __init run_tests(struct ww_class *class)
 	return 0;
 }
 
-static int __init run_test_classes(void)
+static int run_test_classes(void)
 {
 	int ret;
 
@@ -703,6 +703,36 @@ static int __init run_test_classes(void)
 	return 0;
 }
 
+static DEFINE_MUTEX(run_lock);
+
+static ssize_t run_tests_store(struct kobject *kobj, struct kobj_attribute *attr,
+			       const char *buf, size_t count)
+{
+	if (!mutex_trylock(&run_lock)) {
+		pr_err("Test already running\n");
+		return count;
+	}
+
+	run_test_classes();
+	mutex_unlock(&run_lock);
+
+	return count;
+}
+
+static struct kobj_attribute run_tests_attribute =
+	__ATTR(run_tests, 0664, NULL, run_tests_store);
+
+static struct attribute *attrs[] = {
+	&run_tests_attribute.attr,
+	NULL,   /* need to NULL terminate the list of attributes */
+};
+
+static struct attribute_group attr_group = {
+	.attrs = attrs,
+};
+
+static struct kobject *test_ww_mutex_kobj;
+
 static int __init test_ww_mutex_init(void)
 {
 	int ret;
@@ -713,13 +743,30 @@ static int __init test_ww_mutex_init(void)
 	if (!wq)
 		return -ENOMEM;
 
+	test_ww_mutex_kobj = kobject_create_and_add("test_ww_mutex", kernel_kobj);
+	if (!test_ww_mutex_kobj) {
+		destroy_workqueue(wq);
+		return -ENOMEM;
+	}
+
+	/* Create the files associated with this kobject */
+	ret = sysfs_create_group(test_ww_mutex_kobj, &attr_group);
+	if (ret) {
+		kobject_put(test_ww_mutex_kobj);
+		destroy_workqueue(wq);
+		return ret;
+	}
+
+	mutex_lock(&run_lock);
 	ret = run_test_classes();
+	mutex_unlock(&run_lock);
 
 	return ret;
 }
 
 static void __exit test_ww_mutex_exit(void)
 {
+	kobject_put(test_ww_mutex_kobj);
 	destroy_workqueue(wq);
 }
 
-- 
2.51.0.338.gd7d06c2dae-goog


