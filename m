Return-Path: <linux-kernel+bounces-774559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E581B2B422
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BD6528111
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C1027B4FB;
	Mon, 18 Aug 2025 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R88ACZOk"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1E26E143
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755556489; cv=none; b=ZGHa6DxvDFIkJBRt84fF3fV9c+mTAf/F8STNWxuaRGGwMP1mK9QubZO4WmVMSyzWs7jd0F49R0e6pv8KdMEhVLZg+MlZWocUnUd+epIQx1XNZwqWCnWGqfstzdxiwLqn0Tfr7pvomJhVzOwMe7Zxg7vyb/hJ9tis9j6k86ymel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755556489; c=relaxed/simple;
	bh=HIRDCuUBbkqUg5zseTXjl2/Lv/OcpQqnEHRYW+blGRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F5vUyFEhlQlircxW1oPBAZ5N+q59zC+poK/keTgT6YDUpetwAoyuRD8+t0WXJDqFXa9CI8VTCd60K6S0t4aQNFVNLA75sQEhMhnuhTPluT12LuXb6APHPu8ed75Sa5ykNBFikZsMjPx46VFahd95F+CEViQqkc14QcjXp/DllwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R88ACZOk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458067fdeso54730315ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755556487; x=1756161287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8b5kUlwwzWyxmG3fmBmFP8YohbMmn5ekXpZn2iz2Mw=;
        b=R88ACZOk3QXoO45GNSAHWEHrUA811zV7YFJHEEsbe7M34EmEGbj+AnG3xNbz9nCbjr
         dsdv7/dypSJSCYE3jQFKXxEgHr4CFt65ogaZP1c2luPMBmMUZ32/HFYzQKoalD1C+cJE
         pO9OxaLkZvXCtzrs24BG+wr/EXo6ZHUu/SEtwVpY5s6YqF4EV1RjosmWTWeuoZ51eYMl
         GpQJJEMIgdYbh2FoDsutAUcWv3HENymV1hc3rcewtwj0AACodChFgHF/orb/lRqx2YLm
         2fqcVUjnrhwx8BeVEXmuLMU/ObJG+QD9BaqZAqreH6iDP4x48airbQwhsX+14t+T1uwW
         dxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755556487; x=1756161287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8b5kUlwwzWyxmG3fmBmFP8YohbMmn5ekXpZn2iz2Mw=;
        b=p/ApH93a/Zh9huvnYwuHQzsJ5zDfp7EmGch0Tq85lhTi3ThMwI3OfFfjQ17O4tn/v3
         oQ99hzdTvK/aNy0bEKr4bub1eLsf8UEN9tdwTrAjwPF0yqJS/CBXwmr3EeZvbTnbWFbW
         nqy9Dth4cMZU7yH9yytbSOXuEdEXQlqu9QhdfXCl4DPVDNH8cZ6jygKn9utRGN/n0zQ6
         vEpMx3QZvpM3ziLPW9Yfi2tXlW7h1IuH7y/h/AaPUW5NFtbELtZ870yRChGugLbySI6a
         OHNOuk+FvieosSXmgim8u6K2fWwF31uwRJEeA4yRSXt93gVLS4HaXh1UuXtySYYa0hw5
         GSSw==
X-Gm-Message-State: AOJu0YxpvU28DgcQBVwLI9W6KZ9TEnvEwZ4UcDxykgr8Xnb9EfyTz65O
	5VEZhd2WwkZBaMvBi4ez9dNnahaV7rXZUcYrTgB05PbLw9hX1bUxmk2yIdhRS3a8P+zsuTtLMNs
	zeUy8pmdLgXfiGablNNPAOxGI+j/5m71EnK/KW0ySl3c6b4mRGg7XaVgIlsugzofHLjG1QVdrzW
	NvI9atVRQtAr4YbtFerFLPt4ZMvT0cpEr7RTmwCCGJ2YCDmCrp
X-Google-Smtp-Source: AGHT+IHKtW906D0FeLROFbstAMPOctXxDmvJgqYe+pEimIGA/qCYVHSUD8csMm12A2F9oYBPgjJLCUjvYkL6
X-Received: from plgp9.prod.google.com ([2002:a17:902:ebc9:b0:240:2ea7:26fe])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f606:b0:240:3915:99ba
 with SMTP id d9443c01a7336-245e02d501emr4285335ad.5.1755556486633; Mon, 18
 Aug 2025 15:34:46 -0700 (PDT)
Date: Mon, 18 Aug 2025 22:34:24 +0000
In-Reply-To: <20250818223439.2989969-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818223439.2989969-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818223439.2989969-3-jstultz@google.com>
Subject: [RESEND][PATCH 3/3] test-ww_mutex: Allow test to be run (and re-run)
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
 kernel/locking/test-ww_mutex.c | 51 ++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 89ded3a3c6d20..3329a3f8acaac 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -645,7 +645,7 @@ static int stress(struct ww_class *class, int nlocks, int nthreads, unsigned int
 	return 0;
 }
 
-static int __init run_tests(struct ww_class *class)
+static int run_tests(struct ww_class *class)
 {
 	int ncpus = num_online_cpus();
 	int ret, i;
@@ -687,7 +687,7 @@ static int __init run_tests(struct ww_class *class)
 	return 0;
 }
 
-static int __init run_test_classes(void)
+static int run_test_classes(void)
 {
 	int ret;
 
@@ -706,6 +706,36 @@ static int __init run_test_classes(void)
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
@@ -716,13 +746,30 @@ static int __init test_ww_mutex_init(void)
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
2.51.0.rc1.167.g924127e9c0-goog


