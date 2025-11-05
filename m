Return-Path: <linux-kernel+bounces-886568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB278C35F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FEF3A4E10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D65A328B6C;
	Wed,  5 Nov 2025 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiFs/b/H"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1E324B0C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351552; cv=none; b=RddG6k90+41Shz9dVd+KAafPZ5RfLE4sVzD582ou0EZVQw5xaoZqjCJaFxmpq0mTV/Ic48eFj2WQBBI9TU12xLil7A+V5yc9JgOfZHwsfI577dj/1ICK8uPvEmDGdC2ruIAKbwGTXhOW7GVhv2W2DInMQDLVq96H8+CMplDU0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351552; c=relaxed/simple;
	bh=JXoV6kUftFSascQFoxPb3u7Yjr5yxj8zRpvd60JJ6N4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n+3cGZyVxw7i+Cj7Jd6DoKpFbe+4gVaNsEaqWLHHStBG33S0Y7yikPYcmufp9pb+0mGIjyHZCmrgMEacCMWlG0TbtEmrfBLV6BOcwFVPEDUauglvMXsuXh4s952c3sH6Mi5t6TQoKU8WZN16/tvT179RAfD8STnGWwNjlrarYkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiFs/b/H; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34188ba5801so1550462a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762351550; x=1762956350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWeiWrMKd9Z/TbiJerx/2iuu0esuEkNLSPAotvZVuJU=;
        b=hiFs/b/HvWG7NmgMOIqI/rWGKVTKvnx8rd0TpAQHGHdUqElV3dlUP5pduHPnuQCkhu
         AmAF/YY1oTPKnOogHJ59e4OHs3p7c3k5XneFKKK3y4junprDpXiro7xs354BFrMqcPtk
         YH4B0gFyD5Blnt9j2ZSC0BCoKrw7sMnWbQ/0Q6YSqgLbH4v1lr1maagoZICWR9Vjm41v
         50pLMT7ZD8VazhjQUGd6emZdR0FXqT9gofFg86ag8EcaXLmj53w7emB2s+abDea8kW2W
         XzOhdoQlFtJdgdxTxu0wyWp7f9tHs1UFKgFcnDAWzzvwca/uM9zWuo+UmkyY410sRpo1
         ds5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762351550; x=1762956350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWeiWrMKd9Z/TbiJerx/2iuu0esuEkNLSPAotvZVuJU=;
        b=QTRONbXk8SDOthC1lNe30MO/BBo+BiIyXwsMBf0tkOHUv9E4yQP44VAuCnWUU7S9sI
         lLwxxkNueqUfjbiDkneWxWB3z7yZj+5EjPswr/oLH/KoAtyAExXX57CHl0D/pLvmKc6V
         OgdMXKJb1rbszBgikORE/8tgvayoFZRy4OXOJjkrs7YPDd8CZm5CBXTGUATNVK4BUdqs
         qn0HePtSXCnyixbyVVVozJxZIhYYLKh7RH5fEwijVMaTKJfk/vfytdfxPtQkUTn/TWRV
         Cj3RH7eSBX0yGG+XFXlxn7xZVacCvC6u9cuxhXXTXrpuA6bf2SkrZqTH86ppL7iZngm7
         5VBg==
X-Forwarded-Encrypted: i=1; AJvYcCVa0U7MqOdHZAHRcfAb9US/lAAhYWGTJNGN2y5N6YfXYh7jaJpHDooqOY4XUx9FHCitMVqeltOyiKjtmAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSsQj5od7wCpQm4JjrpmQIfwF3WipyNIzygLRLny3GmNh97mU
	U7ts7kauAbmNwCilz10kPkCxMK53VcbSG/5qxG6qWgfKKDOqjUoIalrF
X-Gm-Gg: ASbGncvG2+Kj012Z10o6N3KK7eebi9DVD/kmIfl6LcVZiEKWP3WqU4JmT37GX6y5Jg7
	iDmM3aEPQlBUGGdd+TefRRs9fKa5tDAEkpxb281gskqLBrX5cQ38RktpMkZFlyAgQwVE7RVSicF
	qXrYGpJy6SXMC8v7Cfb/k0bOecyGWOYieLhOrwFSxpdFDFZMGkCQpE0yFvkVLldhaOqRcE67Ywg
	E6v/dXe6H//Lr/tLtlHqb8GHdjfP1lo9cM5AOdXO0K3+UAICTdmjZhYYUV6eXiBwoDtel2lqvyA
	FNCm3cKoJWB9tBITBZBj600T8EMokx47h0Gn3U0k/JYg91VjNAJ7D1XR8TOtf4RBPF2DskUaWp0
	sX3lrQL1O/P/Cq+cPrQCvInCONMKXzsMKHPIiKnkZaJ3U2czlPGSFB1ndgNHlZkzdnZ5mVNMUqq
	e4esW8k+hHSHRlXcY=
X-Google-Smtp-Source: AGHT+IFeBlsmW8JHlbv/gntunQn7tZUm1UTAg8HQ88lVmC8OALHy9ZPLKjl5dXN7UsVJ8ikCAg+yuw==
X-Received: by 2002:a17:90b:3843:b0:340:ad5e:ca with SMTP id 98e67ed59e1d1-341a6c5e511mr4428905a91.12.1762351550331;
        Wed, 05 Nov 2025 06:05:50 -0800 (PST)
Received: from clint-Latitude-7390.. ([110.226.182.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f1a19f60sm5772433a12.3.2025.11.05.06.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:05:49 -0800 (PST)
From: Clint George <clintbgeorge@gmail.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	Clint George <clintbgeorge@gmail.com>
Subject: [PATCH] hangcheck-timer: use pr_crit and fix coding style
Date: Wed,  5 Nov 2025 19:35:41 +0530
Message-Id: <20251105140541.9658-1-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix coding style issues and improve logging in hangcheck-timer such as replace printk(KERN_CRIT ...) to pr_crit(...) where applicable and replace non-standard %Ld with %lld in debug prints and use proper pr_debug/pr_crit for kernel logging.

No functional changes were made to hangcheck logic.

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---

Testing:
- Verified timer firing and margin detection using "hangtest" module that i created (I will paste the code below for reference) and checked dmesg logs for expected output: "Hangcheck: hangcheck value past margin!".
- Used Static Analysis tools
- Ensured module builds and inserts cleanly after changes.

Let me know if you want me to do more testing on this module.

[] hangtest.c (testing module i created to test hangcheck-timer module):

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Clint George");
MODULE_DESCRIPTION("Hang test for testing hangcheck-timer");

static int hang_duration = 20;
module_param(hang_duration, int, 0644);

static int __init hangtest_init(void) {
    unsigned long timeout;

    printk(KERN_INFO "hangtest: Disabling interrupts for %d seconds...\n", hang_duration);

    local_irq_disable();
    preempt_disable();

    timeout = jiffies + (hang_duration * HZ);
    while (time_before(jiffies, timeout)) {
        cpu_relax();
        barrier();
    }

    preempt_enable();
    local_irq_enable();

    printk(KERN_INFO "hangtest: Interrupts re-enabled\n");
//    return 0;
    return -EINVAL; // Return error so module doesn't stay loaded
}

static void __exit hangtest_exit(void) {
    printk(KERN_INFO "hangtest: Exit\n");
}

module_init(hangtest_init);
module_exit(hangtest_exit);

 drivers/char/hangcheck-timer.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
index 497fc167c..a95e6d608 100644
--- a/drivers/char/hangcheck-timer.c
+++ b/drivers/char/hangcheck-timer.c
@@ -69,7 +69,8 @@ MODULE_VERSION(VERSION_STR);
 static int __init hangcheck_parse_tick(char *str)
 {
 	int par;
-	if (get_option(&str,&par))
+
+	if (get_option(&str, &par))
 		hangcheck_tick = par;
 	return 1;
 }
@@ -77,7 +78,8 @@ static int __init hangcheck_parse_tick(char *str)
 static int __init hangcheck_parse_margin(char *str)
 {
 	int par;
-	if (get_option(&str,&par))
+
+	if (get_option(&str, &par))
 		hangcheck_margin = par;
 	return 1;
 }
@@ -85,7 +87,8 @@ static int __init hangcheck_parse_margin(char *str)
 static int __init hangcheck_parse_reboot(char *str)
 {
 	int par;
-	if (get_option(&str,&par))
+
+	if (get_option(&str, &par))
 		hangcheck_reboot = par;
 	return 1;
 }
@@ -93,7 +96,8 @@ static int __init hangcheck_parse_reboot(char *str)
 static int __init hangcheck_parse_dump_tasks(char *str)
 {
 	int par;
-	if (get_option(&str,&par))
+
+	if (get_option(&str, &par))
 		hangcheck_dump_tasks = par;
 	return 1;
 }
@@ -126,23 +130,24 @@ static void hangcheck_fire(struct timer_list *unused)
 
 	if (tsc_diff > hangcheck_tsc_margin) {
 		if (hangcheck_dump_tasks) {
-			printk(KERN_CRIT "Hangcheck: Task state:\n");
+			pr_crit("Hangcheck: Task state:\n");
+
 #ifdef CONFIG_MAGIC_SYSRQ
 			handle_sysrq('t');
 #endif  /* CONFIG_MAGIC_SYSRQ */
 		}
 		if (hangcheck_reboot) {
-			printk(KERN_CRIT "Hangcheck: hangcheck is restarting the machine.\n");
+			pr_crit("Hangcheck: hangcheck is restarting the machine.\n");
 			emergency_restart();
 		} else {
-			printk(KERN_CRIT "Hangcheck: hangcheck value past margin!\n");
+			pr_crit("Hangcheck: hangcheck value past margin!\n");
 		}
 	}
 #if 0
 	/*
 	 * Enable to investigate delays in detail
 	 */
-	printk("Hangcheck: called %Ld ns since last time (%Ld ns overshoot)\n",
+	pr_debug("Hangcheck: called %lld ns since last time (%lld ns overshoot)\n",
 			tsc_diff, tsc_diff - hangcheck_tick*TIMER_FREQ);
 #endif
 	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
@@ -152,7 +157,7 @@ static void hangcheck_fire(struct timer_list *unused)
 
 static int __init hangcheck_init(void)
 {
-	printk("Hangcheck: starting hangcheck timer %s (tick is %d seconds, margin is %d seconds).\n",
+	pr_debug("Hangcheck: starting hangcheck timer %s (tick is %d seconds, margin is %d seconds).\n",
 	       VERSION_STR, hangcheck_tick, hangcheck_margin);
 	hangcheck_tsc_margin =
 		(unsigned long long)hangcheck_margin + hangcheck_tick;
@@ -168,7 +173,7 @@ static int __init hangcheck_init(void)
 static void __exit hangcheck_exit(void)
 {
 	timer_delete_sync(&hangcheck_ticktock);
-        printk("Hangcheck: Stopped hangcheck timer.\n");
+	pr_debug("Hangcheck: Stopped hangcheck timer.\n");
 }
 
 module_init(hangcheck_init);
-- 
2.34.1


