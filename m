Return-Path: <linux-kernel+bounces-799619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C64B42E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E63582CB4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D521885A5;
	Thu,  4 Sep 2025 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5IrSAnD"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1112CD88
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945624; cv=none; b=s5YKz7Dy4Rj7kD+Pqs7Yf8Pgj0JABOFie+FjNQHmmYFCjSNVjuCgPLxJgF96r0PCEXe/4OCK5Rw0FYTDMbPheVB57s8ppAXMlmv81sAuOLvS4xwHTMnWV8kAb4i3ZSqObn4pmUcH38auhqCQj4LyrnNPLn3eMw5IdXRpOMGTjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945624; c=relaxed/simple;
	bh=9HLxXHMECannWVd48fSAK1SHVP7Ro6BVnGM7wtpM6ko=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GOqdwdoPQaWsLsQ+afWd1S5XRWF+ObraDI/S8GGcof+UT5z/CrA0Flj9x+0UxguBwgHsFujBsClHbj1kZN6wfeLBVex9fAF//SdcOALoLdyWvfek2fWZEcfVdqgkRl4fbt3e4DIaaGm2XZVOmboXV5q6YAzXvqJjon9QTnFFeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5IrSAnD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so811085b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756945621; x=1757550421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yvDVQLK04ab40q5EtK+feiNVb9JDEu/1QPl7bniWoyA=;
        b=r5IrSAnDECeIb6N2L+PXE5hbr2SXk9hfzN1w9acQIxKquQsevedGXBdeZecGN8uvDk
         77aufiybgAhVo3RAi259CCv2izQl0YrXS8rxPc/XKO9+5qnRc2gKBEC9m4SXg/QcoF82
         rHIrqrdsj2FeO0jVeMhQDAkgShPPt85OLJKL1/daIYNPfrGVyMdWahF9mRJSqYIWLb+a
         /K+UaeKGvBrhpkokVNxmu7zg5thmYUzLScT50hnUjDHgyb65wDlJDyUeYIOkQ31oMZml
         62MM7MDloAkNgPigu2vI7unhM1whZWm1W6sJ6E8kDahgJRM8pcDb7EKFYpNHzr5OIKfO
         1G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945621; x=1757550421;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvDVQLK04ab40q5EtK+feiNVb9JDEu/1QPl7bniWoyA=;
        b=fP8bQHxQg7eOfBwNN5adEAj855fUgIluGl0z8wNfQrt7ZGB8YxrImidFbvLs2KBFZ/
         Sm5pbyyYf/rI8gTKPINSa5LnJFMwptf80z/AcB7kQslIisIMkQ5UdkvfiKjDSV0l5RWt
         mLvNPDaA1gDv2/d399ALXTYi16TCV580RtGkciwUV93uwkHrDneXbZX35QtsMvOcHr/U
         8OPDqlfk9iWzd24nbMcU/yllUjI+6KEgAgWynCkK1lz7cbjbJXGBzd1xkmeYQZERL7cd
         jm7zqyJF+mR8rkuj0Z4SwI0UeCyaWcV1lBfPziC0AlMo41syx+g+rxpyMkjueRk9uCUV
         wZEQ==
X-Gm-Message-State: AOJu0YxntPH5DZNHZj3LK2REpNVV2Xu8jbG2W1x+NGeoYowaxfTgFTsp
	lly7Biglx6h+WYpKM9FSKprZX/UeDvJ5dDM8s2O7wrXixOnluf+9xFvhP0XcnZtpZm7lUAYlPIg
	EU7QHKSV8YBoTrhsBuM2QocHgxH+TWs25kWZfAMDbEcgA8t87fLnY7OnLP+hUF/Qvs2grbFsWQg
	tuBXlmAxyNJbrEacD73hZLWP1IdyvCh2iGcMVMLUdWJU66gkze
X-Google-Smtp-Source: AGHT+IFovU9GBH8kw8DAxkVYm0/vx5mdwpbRvIsRe+wCjjnO2ynIsO/VWDRC5MIL+zNlPxwQpd5HDA4ISeTY
X-Received: from pfnn22.prod.google.com ([2002:a05:6a00:2b96:b0:772:38cc:6145])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b56:b0:74e:ab93:422b
 with SMTP id d2e1a72fcca58-7723e21a5femr25206372b3a.4.1756945620636; Wed, 03
 Sep 2025 17:27:00 -0700 (PDT)
Date: Thu,  4 Sep 2025 00:26:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904002658.974593-1-jstultz@google.com>
Subject: [RESEND x2][PATCH 1/3] test-ww_mutex: Extend ww_mutex tests to test
 both classes of ww_mutexes
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Currently the test-ww_mutex tool only utilizes the wait-die
class of ww_mutexes, and thus isn't very helpful in exercising
the wait-wound class of ww_mutexes.

So extend the test to exercise both classes of ww_mutexes for
all of the subtests.

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
 kernel/locking/test-ww_mutex.c | 114 +++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 41 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index bcb1b9fea5880..20f509ca17e16 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -13,7 +13,8 @@
 #include <linux/slab.h>
 #include <linux/ww_mutex.h>
 
-static DEFINE_WD_CLASS(ww_class);
+static DEFINE_WD_CLASS(wd_class);
+static DEFINE_WW_CLASS(ww_class);
 struct workqueue_struct *wq;
 
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
@@ -54,16 +55,16 @@ static void test_mutex_work(struct work_struct *work)
 	ww_mutex_unlock(&mtx->mutex);
 }
 
-static int __test_mutex(unsigned int flags)
+static int __test_mutex(struct ww_class *class, unsigned int flags)
 {
 #define TIMEOUT (HZ / 16)
 	struct test_mutex mtx;
 	struct ww_acquire_ctx ctx;
 	int ret;
 
-	ww_mutex_init(&mtx.mutex, &ww_class);
+	ww_mutex_init(&mtx.mutex, class);
 	if (flags & TEST_MTX_CTX)
-		ww_acquire_init(&ctx, &ww_class);
+		ww_acquire_init(&ctx, class);
 
 	INIT_WORK_ONSTACK(&mtx.work, test_mutex_work);
 	init_completion(&mtx.ready);
@@ -106,13 +107,13 @@ static int __test_mutex(unsigned int flags)
 #undef TIMEOUT
 }
 
-static int test_mutex(void)
+static int test_mutex(struct ww_class *class)
 {
 	int ret;
 	int i;
 
 	for (i = 0; i < __TEST_MTX_LAST; i++) {
-		ret = __test_mutex(i);
+		ret = __test_mutex(class, i);
 		if (ret)
 			return ret;
 	}
@@ -120,15 +121,15 @@ static int test_mutex(void)
 	return 0;
 }
 
-static int test_aa(bool trylock)
+static int test_aa(struct ww_class *class, bool trylock)
 {
 	struct ww_mutex mutex;
 	struct ww_acquire_ctx ctx;
 	int ret;
 	const char *from = trylock ? "trylock" : "lock";
 
-	ww_mutex_init(&mutex, &ww_class);
-	ww_acquire_init(&ctx, &ww_class);
+	ww_mutex_init(&mutex, class);
+	ww_acquire_init(&ctx, class);
 
 	if (!trylock) {
 		ret = ww_mutex_lock(&mutex, &ctx);
@@ -177,6 +178,7 @@ static int test_aa(bool trylock)
 
 struct test_abba {
 	struct work_struct work;
+	struct ww_class *class;
 	struct ww_mutex a_mutex;
 	struct ww_mutex b_mutex;
 	struct completion a_ready;
@@ -191,7 +193,7 @@ static void test_abba_work(struct work_struct *work)
 	struct ww_acquire_ctx ctx;
 	int err;
 
-	ww_acquire_init_noinject(&ctx, &ww_class);
+	ww_acquire_init_noinject(&ctx, abba->class);
 	if (!abba->trylock)
 		ww_mutex_lock(&abba->b_mutex, &ctx);
 	else
@@ -217,23 +219,24 @@ static void test_abba_work(struct work_struct *work)
 	abba->result = err;
 }
 
-static int test_abba(bool trylock, bool resolve)
+static int test_abba(struct ww_class *class, bool trylock, bool resolve)
 {
 	struct test_abba abba;
 	struct ww_acquire_ctx ctx;
 	int err, ret;
 
-	ww_mutex_init(&abba.a_mutex, &ww_class);
-	ww_mutex_init(&abba.b_mutex, &ww_class);
+	ww_mutex_init(&abba.a_mutex, class);
+	ww_mutex_init(&abba.b_mutex, class);
 	INIT_WORK_ONSTACK(&abba.work, test_abba_work);
 	init_completion(&abba.a_ready);
 	init_completion(&abba.b_ready);
+	abba.class = class;
 	abba.trylock = trylock;
 	abba.resolve = resolve;
 
 	schedule_work(&abba.work);
 
-	ww_acquire_init_noinject(&ctx, &ww_class);
+	ww_acquire_init_noinject(&ctx, class);
 	if (!trylock)
 		ww_mutex_lock(&abba.a_mutex, &ctx);
 	else
@@ -278,6 +281,7 @@ static int test_abba(bool trylock, bool resolve)
 
 struct test_cycle {
 	struct work_struct work;
+	struct ww_class *class;
 	struct ww_mutex a_mutex;
 	struct ww_mutex *b_mutex;
 	struct completion *a_signal;
@@ -291,7 +295,7 @@ static void test_cycle_work(struct work_struct *work)
 	struct ww_acquire_ctx ctx;
 	int err, erra = 0;
 
-	ww_acquire_init_noinject(&ctx, &ww_class);
+	ww_acquire_init_noinject(&ctx, cycle->class);
 	ww_mutex_lock(&cycle->a_mutex, &ctx);
 
 	complete(cycle->a_signal);
@@ -314,7 +318,7 @@ static void test_cycle_work(struct work_struct *work)
 	cycle->result = err ?: erra;
 }
 
-static int __test_cycle(unsigned int nthreads)
+static int __test_cycle(struct ww_class *class, unsigned int nthreads)
 {
 	struct test_cycle *cycles;
 	unsigned int n, last = nthreads - 1;
@@ -327,7 +331,8 @@ static int __test_cycle(unsigned int nthreads)
 	for (n = 0; n < nthreads; n++) {
 		struct test_cycle *cycle = &cycles[n];
 
-		ww_mutex_init(&cycle->a_mutex, &ww_class);
+		cycle->class = class;
+		ww_mutex_init(&cycle->a_mutex, class);
 		if (n == last)
 			cycle->b_mutex = &cycles[0].a_mutex;
 		else
@@ -367,13 +372,13 @@ static int __test_cycle(unsigned int nthreads)
 	return ret;
 }
 
-static int test_cycle(unsigned int ncpus)
+static int test_cycle(struct ww_class *class, unsigned int ncpus)
 {
 	unsigned int n;
 	int ret;
 
 	for (n = 2; n <= ncpus + 1; n++) {
-		ret = __test_cycle(n);
+		ret = __test_cycle(class, n);
 		if (ret)
 			return ret;
 	}
@@ -384,6 +389,7 @@ static int test_cycle(unsigned int ncpus)
 struct stress {
 	struct work_struct work;
 	struct ww_mutex *locks;
+	struct ww_class *class;
 	unsigned long timeout;
 	int nlocks;
 };
@@ -443,7 +449,7 @@ static void stress_inorder_work(struct work_struct *work)
 		int contended = -1;
 		int n, err;
 
-		ww_acquire_init(&ctx, &ww_class);
+		ww_acquire_init(&ctx, stress->class);
 retry:
 		err = 0;
 		for (n = 0; n < nlocks; n++) {
@@ -511,7 +517,7 @@ static void stress_reorder_work(struct work_struct *work)
 	order = NULL;
 
 	do {
-		ww_acquire_init(&ctx, &ww_class);
+		ww_acquire_init(&ctx, stress->class);
 
 		list_for_each_entry(ll, &locks, link) {
 			err = ww_mutex_lock(ll->lock, &ctx);
@@ -570,7 +576,7 @@ static void stress_one_work(struct work_struct *work)
 #define STRESS_ONE BIT(2)
 #define STRESS_ALL (STRESS_INORDER | STRESS_REORDER | STRESS_ONE)
 
-static int stress(int nlocks, int nthreads, unsigned int flags)
+static int stress(struct ww_class *class, int nlocks, int nthreads, unsigned int flags)
 {
 	struct ww_mutex *locks;
 	struct stress *stress_array;
@@ -588,7 +594,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 	}
 
 	for (n = 0; n < nlocks; n++)
-		ww_mutex_init(&locks[n], &ww_class);
+		ww_mutex_init(&locks[n], class);
 
 	count = 0;
 	for (n = 0; nthreads; n++) {
@@ -617,6 +623,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 		stress = &stress_array[count++];
 
 		INIT_WORK(&stress->work, fn);
+		stress->class = class;
 		stress->locks = locks;
 		stress->nlocks = nlocks;
 		stress->timeout = jiffies + 2*HZ;
@@ -635,57 +642,82 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 	return 0;
 }
 
-static int __init test_ww_mutex_init(void)
+static int __init run_tests(struct ww_class *class)
 {
 	int ncpus = num_online_cpus();
 	int ret, i;
 
-	printk(KERN_INFO "Beginning ww mutex selftests\n");
-
-	prandom_seed_state(&rng, get_random_u64());
-
-	wq = alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
-	if (!wq)
-		return -ENOMEM;
-
-	ret = test_mutex();
+	ret = test_mutex(class);
 	if (ret)
 		return ret;
 
-	ret = test_aa(false);
+	ret = test_aa(class, false);
 	if (ret)
 		return ret;
 
-	ret = test_aa(true);
+	ret = test_aa(class, true);
 	if (ret)
 		return ret;
 
 	for (i = 0; i < 4; i++) {
-		ret = test_abba(i & 1, i & 2);
+		ret = test_abba(class, i & 1, i & 2);
 		if (ret)
 			return ret;
 	}
 
-	ret = test_cycle(ncpus);
+	ret = test_cycle(class, ncpus);
 	if (ret)
 		return ret;
 
-	ret = stress(16, 2*ncpus, STRESS_INORDER);
+	ret = stress(class, 16, 2*ncpus, STRESS_INORDER);
 	if (ret)
 		return ret;
 
-	ret = stress(16, 2*ncpus, STRESS_REORDER);
+	ret = stress(class, 16, 2*ncpus, STRESS_REORDER);
 	if (ret)
 		return ret;
 
-	ret = stress(2046, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
+	ret = stress(class, 2046, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
 	if (ret)
 		return ret;
 
-	printk(KERN_INFO "All ww mutex selftests passed\n");
 	return 0;
 }
 
+static int __init run_test_classes(void)
+{
+	int ret;
+
+	pr_info("Beginning ww (wound) mutex selftests\n");
+
+	ret = run_tests(&ww_class);
+	if (ret)
+		return ret;
+
+	pr_info("Beginning ww (die) mutex selftests\n");
+	ret = run_tests(&wd_class);
+	if (ret)
+		return ret;
+
+	pr_info("All ww mutex selftests passed\n");
+	return 0;
+}
+
+static int __init test_ww_mutex_init(void)
+{
+	int ret;
+
+	prandom_seed_state(&rng, get_random_u64());
+
+	wq = alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
+	if (!wq)
+		return -ENOMEM;
+
+	ret = run_test_classes();
+
+	return ret;
+}
+
 static void __exit test_ww_mutex_exit(void)
 {
 	destroy_workqueue(wq);
-- 
2.51.0.338.gd7d06c2dae-goog


