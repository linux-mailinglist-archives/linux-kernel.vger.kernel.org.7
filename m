Return-Path: <linux-kernel+bounces-731031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BA7B04DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98BD188E7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963722C3278;
	Tue, 15 Jul 2025 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1XnrtExR"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE12BEFEF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545663; cv=none; b=J12leHpsWXCi6RLSrBZvyTAXTIBKOvPRL9kNPHRpXGAuDsvg2mNuZTpIczM8trMaJi7qAj9u9oF11fdroBVOo1++0F3uhmsIDd/xE8fpC+WJt4+v9Lh0HHdhA4B8njI5ea6o9eABtSILehRFcxTM3zAP9hABzNhjuj2KoUT0Fdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545663; c=relaxed/simple;
	bh=GIlb7f6IHKsl4Z63lBRgS4obA+lil1x1Gneli9YsqUI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=npWPSwv6ZkEQUTXsEAPZop8vHd9GG3Iu+ChMrH/fedgvuYtwM0uLsdl8LRA9FvBs1+Lg/IaK9xErsfgw0fdCg3UtGBLkuSDRu2AgzPT5D0wS8HHN68+/BS6KE6HWBrgXIAARMcqySRuoFYYqtHRNcOrUpAp4hdUXobLWfxstfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1XnrtExR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748d96b974cso4133425b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752545661; x=1753150461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a5oDuYW5HW4qAZ98tuqOetCtm3BGM+Zyd50lBfpfJ4Y=;
        b=1XnrtExRj9PNlT85SswAYJ2V7QlKkGGfpXMwvfuEJGpa934GMw4m/81WwG3NfJ48ME
         h0rcmOiT8cOrvpY63RGOLQoYi1ZIqoQMQhUOuBwTs7IwotUh39Jv4nxwax3mFNfTjbQg
         9gvfGVVamCpHtZML1oYiiCKzAeQglVG2mbA5QqcY8Y0eQ3s7CJ27xHrbtg8+j3B7CTVJ
         aurMwvBzX8LOkN4s0JbMVmepCpYzTZvK9+DXSAjxtanaFKCt9MdDiDA+ibteJz91F6ua
         9/omvumOy4yJQIdeJ9MgvAC3hJeIuKgm9jHB6EYePceA1BbxNZsa2iahkVYn1CoogvaT
         40RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752545661; x=1753150461;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5oDuYW5HW4qAZ98tuqOetCtm3BGM+Zyd50lBfpfJ4Y=;
        b=mfCoadteqclONjkHENQ0YT3k7Q7ZN+ineMwRt7BMs95suizKyo/RKdxaBmMgaduNHq
         H+iAYe6zMwkVqrYAusUjeYMTdop/OfOlTTVlt2Jt8zv0ffy3wjZezZWIsNZqMsQ+m21H
         eUaTTtbm7hns6ujoqisLMmmdfQccrCFv/h6QVzlmQNVok/WY0gb/MnUK5yHeOnw8jXf6
         RDCU3lTkJRNZLap7FR6u6c4x0HXJ8eu0o78oNi1vIhtSfIzqP4X7kOyYPps1fpEe87Rj
         1mUSm5htk5Z3Xxh7c+a2XWs0o9vGvqUvv9+TQjRnJCDfYSyG41pYfwkLXEk7N1ZQiHVV
         mJaw==
X-Gm-Message-State: AOJu0Yw4sBJe15hcIf2j/woSTH6XFsmaTycMIGkvVkyQW+qBQr68aMHI
	jgT0RGtyXiaJ2oqkqSlQrU0IyK/bJ6YcrghhK513NgP+L0tzZ65Ss3ArgI0F0gejxznmiXqe3UP
	PtbstEPBg8nIQEzMTRg1wcCl6c4rW6Qk6XDuaDB8GRujLyOyqh2lp3nIgAbdpkqSJtnRTFrB1aj
	GRYFL4zOjBND9FJQ0PUlB9BK+3NK7WJX7iLTUyNco+s0jlQ8oi
X-Google-Smtp-Source: AGHT+IHUV31HInPDPKz4V+4EqJqLI2voaIWRU/jTFQNp5wKQcmpoKkRUOKkKqXZXywZDO/o/PozmuIciSovk
X-Received: from pfez19.prod.google.com ([2002:aa7:8893:0:b0:746:1fcb:a9cc])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a2:b0:736:33fd:f57d
 with SMTP id d2e1a72fcca58-74f1ebccfcamr16278079b3a.17.1752545660737; Mon, 14
 Jul 2025 19:14:20 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:14:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715021417.4015799-1-jstultz@google.com>
Subject: [RESEND][PATCH 1/2] test-ww_mutex: Allow test to be run (and re-run)
 from userland
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
 kernel/locking/test-ww_mutex.c | 70 ++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index bcb1b9fea5880..dcfa5ab15ab49 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -635,19 +635,15 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 	return 0;
 }
 
-static int __init test_ww_mutex_init(void)
+static DEFINE_MUTEX(run_lock);
+
+static int run_tests(void)
 {
 	int ncpus = num_online_cpus();
 	int ret, i;
 
 	printk(KERN_INFO "Beginning ww mutex selftests\n");
 
-	prandom_seed_state(&rng, get_random_u64());
-
-	wq = alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
-	if (!wq)
-		return -ENOMEM;
-
 	ret = test_mutex();
 	if (ret)
 		return ret;
@@ -686,8 +682,68 @@ static int __init test_ww_mutex_init(void)
 	return 0;
 }
 
+static ssize_t run_tests_store(struct kobject *kobj, struct kobj_attribute *attr,
+			       const char *buf, size_t count)
+{
+	if (!mutex_trylock(&run_lock)) {
+		pr_err("Test already running\n");
+		return count;
+	}
+
+	run_tests();
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
+	ret = run_tests();
+	mutex_unlock(&run_lock);
+
+	return ret;
+}
+
 static void __exit test_ww_mutex_exit(void)
 {
+	kobject_put(test_ww_mutex_kobj);
 	destroy_workqueue(wq);
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


