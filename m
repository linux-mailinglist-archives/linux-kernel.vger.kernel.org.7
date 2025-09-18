Return-Path: <linux-kernel+bounces-823762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C589EB87640
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A95F2A3570
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7A2D063D;
	Thu, 18 Sep 2025 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpMZaZhj"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16722FE0E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758238432; cv=none; b=Ll869wzf12SfOnTSQU5vcWkiyT1pZu62FzSGI6EwcfxrmQ97QWPIvxUnjYN0SZdB43K+VhTzUUQznW67zDd4mREWlmeInbt7cRdIGgXVfrHJguNJlIf9+skbFC5FDPad/WqW0ZCZERzsHX0WMXm9Zi4mV9cXMbdlacEdx7kJmvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758238432; c=relaxed/simple;
	bh=ifntGnvynx1degBdU8sjKziNZ6pafKbyThBGxFxnr3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bhmm4VywP4fFkGr8mjtSywBIN3PJkwn3eAoN0zta8GcQA3HErs4mpYi4ZCwxnxZNZCgbfmpKzXXCYmX3JMsPKS+aTL36Ppzgdbxdb5IGVFFI0MDU+pLK1ZPxjEFPXMn1ec8rvn0lbtiIH5LlF54OzNcCLaCbbmaU45vuPiYfpTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpMZaZhj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3304def7909so1480396a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758238430; x=1758843230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1L3e6pPzBz33MpefjSNtpBFFxOsX99LC84SCLzfuw6g=;
        b=hpMZaZhjRyhfafneebXMmg7/BRO+0ox8DNS2HDBd/85LYcDahc1HaqDvmpfyTz2znr
         6t4ahCvK0lXFThofC9g5CpEO6sI3NS9jVbhsqq1kaxQN095NlLWKywQVpEebgPLC+Io3
         O07JUiO+NUOeFik0rqTgvzo/hn1G2pGBupZxR1vKek0ASdD6NWb6TxKlkPOLjVVocupw
         8raohvfJBQ5D6pJxh466BXqtBIEqNXPJGz34YQGkxz/ABlkkKv6ai8wr3GIb6dOJuVvA
         k6YIlGKtVF2R6DoQdFHRYM0ovFjHcnJg67UHQMsrSIZM/AbX5jLSRKNEZeo3y+EbDA1C
         dAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758238430; x=1758843230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1L3e6pPzBz33MpefjSNtpBFFxOsX99LC84SCLzfuw6g=;
        b=bhjASk5s34KKlWdfmr7FoNW3CyJx7KHSph5ztUHAammvZqWMMOgmW3uNfqBuhIt2OC
         emup2zhwsdO3WgMt16A1RLHe/T949EwqrYqPPM0tjlHlb7bwbnEcPz1QjnxdoKL/HY2C
         m4RGAiDabQhrWQzHrtlFMOougbhX+qfxYwp/Ye4y/W1z/hPjC/2c4fHDdmDDRO0zLWn5
         pIRwOvgNZSKhnUaQdDmm9xY3TszOtkvKjImRWb02JHksnENDicrbkV+Q4XitBGY5IXf3
         xhnFqPZjz/kEa1zNYD9Xm+3iDop6SHeBsGFPzUemPDhAvgjtBn5NnXQGc3PYfHH8ICVT
         0QWQ==
X-Gm-Message-State: AOJu0YyrD0t+TEJ+iwcBf8PXOzKUDbe8Dy4EeX42KxUpDtEJcgiiVcSO
	EkDZdKsHVGlY04b7+irJSvKVRGIhr+lI3ayL/hDp8oxbuPTpW3cMSSphLE8oMC8u/M9VY1wQ3bv
	afzNu8qbNQTts2jeEoe96yyswv5mcnTYD1WsEqFTyDZTpACD485Klw4yFBlDwwdiPw0XRLbArqW
	P7OnoY89DKP3/41TxzUEqpmLG67peGnlL//cyLtApo85ZKSP3T
X-Google-Smtp-Source: AGHT+IHU5xnIbTD+BxQ2jW7Wrw2jnS3TnBYrvTJt5s8oRrQCqHgOFjOpgi9bZ7mzmZG43v/2pwv0iScAkE/m
X-Received: from pjbph15.prod.google.com ([2002:a17:90b:3bcf:b0:32d:df7e:66c2])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec83:b0:330:797a:f504
 with SMTP id 98e67ed59e1d1-33097fce4c3mr1474614a91.3.1758238430119; Thu, 18
 Sep 2025 16:33:50 -0700 (PDT)
Date: Thu, 18 Sep 2025 23:33:34 +0000
In-Reply-To: <20250918233344.4166141-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918233344.4166141-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250918233344.4166141-3-jstultz@google.com>
Subject: [RESEND x3][PATCH 3/3] test-ww_mutex: Allow test to be run (and
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
index 30512b3e95c99..79b5e45f8d4c2 100644
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
2.51.0.534.gc79095c0ca-goog


