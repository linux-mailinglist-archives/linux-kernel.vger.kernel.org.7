Return-Path: <linux-kernel+bounces-752816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BC8B17B3E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0FB189700B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03A3130E58;
	Fri,  1 Aug 2025 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5aAzCed"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018C19047F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754015649; cv=none; b=XzlRkMQpJe/rNXQqvZ4dyeLfOYK3m8teMjNkPA0vBoChqKZ4LjQ90cqpQ9NKmuRCHlk7MCTdJpg4PMzWeXWASgDttGhSIcxvbv3bdePufPb9sifpByhdx+Pb8wrHLqqSQ6bHl+nwvriGzzQNEU9wVVZhMO10kQHARrF9xbLUrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754015649; c=relaxed/simple;
	bh=Xnk++QmyYOL6Xx3CqnCauoC+p3ZNaxeumJ7Pf4HhTOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=guMMTWNi6tM7XnC6DRSBd5lJAir2pAjSrzcKqy7sDndehMA+QvX7mfyh+NP5hD7zTQEg3+33UXuRjWvkFZgnjQ+Wh9NNHg27Ar9tozx4ntoxdX1jnSqYAcvyZTBhejW+c5exvk8izdt3GFWLz012CtXHoZEB0MrfiBibFildYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y5aAzCed; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23fe26e5a33so13698995ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754015646; x=1754620446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUd1sXyrzNOvyTB9MkZYSLePfcY4IdRw2RKTcYFuUo8=;
        b=y5aAzCed4ov2+0HpOQWh01qj+i1Da+JAzTRpEIpSirNzm+WuAmy/kfFzluba/vSxRL
         9ck0OLuhs9b8Knvbg2dB6icKlEb3RORSK8FPEr8rThQhBOJFHZv9Ei1H7a/gq+vr1bDA
         sQYCkJxInwKuvy0BINjzhJd/yu502uSEAe2A+bucDGG1nCn16quX/w+Rm4lq81Q62zUH
         cuAfKGnCnInEZo2MUCbVOc3tzl866vR9aEPSv8VeDvHlG0I3zE+4n7bZjIofSXGi/Y/c
         EKkMCemIw5Oufq6c4iZ21IEI7ynzZ0UkO5bwgbpSrSvNjTeOuidxJ1FD5mRvLrm/Cvg1
         FM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754015646; x=1754620446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUd1sXyrzNOvyTB9MkZYSLePfcY4IdRw2RKTcYFuUo8=;
        b=xAwLbeEACAhUtLDRWCu7vaMOrxrnLuMGHaXvzxywaVK44WxJkK3DKdL8zklhIyD04E
         RRTrMYBo4Wpt6HGTS8xJVIu+TaHs7Td07YvTbyjM+tIEchZJ0pBdCrBpxbTkLFY6yrHb
         lJbFzWkiQqL0TixQyhuC2GONmYqqHcSOeqQm41D1D37sixo7Nc+3lE2+4hf6HxtoV/Ey
         W8qd4t43A7YpbqKv9lWH+Uu6CrpIVEccwXm4Y/JzUCrXB8W7sOhiyOydCoOvS8M4zgc/
         cZst31miZqLjblAnHDjziaEXZRbkBvfRfoWEZk0rBxW9LrO8cWBheAkhCNCMPgDNs5Xr
         qVBw==
X-Gm-Message-State: AOJu0Ywq5tl6sK3mN/jcZBbYKqA+Wb0EnUTJpiF8lIw0hJ/Sr1vOfekL
	4qN0EdMvPv0qd1StFK5Dpi0GhKXdFKN1xx0S7797H6YHWU65HiLothgCDXjvpH/Hes5GpVmyWWS
	j76v6wM4A+rcVy7uMBWPbE3WamnJvBVSPWpf07+LOM/q1+9iFBLSuTQv90JlJ7cQ7uCKqeF81LT
	4bB65tFm18tdFzN0dreZbrk14aWrKzYYqUTQ8+v49l0XpqLX9C
X-Google-Smtp-Source: AGHT+IEIaC9qOYd7wsLzN2PZV/nr0Kw5TBrngmzHhkMFUF67xUA7VClE6eikEgFew8IfgQ6Mj5xEXVp9dxZ5
X-Received: from pjj6.prod.google.com ([2002:a17:90b:5546:b0:31c:4a51:8b75])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f690:b0:240:2145:e53b
 with SMTP id d9443c01a7336-2422a4312e2mr13947105ad.9.1754015645858; Thu, 31
 Jul 2025 19:34:05 -0700 (PDT)
Date: Fri,  1 Aug 2025 02:33:49 +0000
In-Reply-To: <20250801023358.562525-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250801023358.562525-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801023358.562525-4-jstultz@google.com>
Subject: [PATCH 3/3] test-ww_mutex: Allow test to be run (and re-run) from userland
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
2.50.1.565.gc32cd1483b-goog


