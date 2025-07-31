Return-Path: <linux-kernel+bounces-751974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C04CEB16FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBA91AA7E03
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334FE2C3278;
	Thu, 31 Jul 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyDCRJRZ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0F2C15A5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959360; cv=none; b=OJGVsNibXSrXfb76eZILwZkGWKm2/v+2+zm3kvt7yIaOeo5cffErbXsri4jUgHBceVCc3378DteSmQrhY5SeyNsYbtSqzApM2R4uthfsAqFHpFIwSbF7augBkqlWz0hmrLKlgkOtog7hfZMIxrR4X2V55tjN/loyGCVXw3pqcCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959360; c=relaxed/simple;
	bh=YOfu9u/lEMDWROzeoesVEFAQDL2hwPLy1q02eqDMkLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8XQqzCKyKs9tLTq1w34V7IuCfBmHiG13/5FIvVemZPKlWaBePDPUSm827ARV0v7LiL3rluJ/7YPC3izITVQ8gPXWqGpPR61RvpikBZgYJz5aLjXiF0iUymp8KdkpHl1jNmSnmPT7liOvyxjkxiCZ7xAA2dcEZ1K1SGn+d6vqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyDCRJRZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so630761f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959356; x=1754564156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Xqu0xZcMwu5bTVe+RW26RwXnOxaIGhBZuY4+vQOKNA=;
        b=OyDCRJRZgXfk34x5IuInWuOV+3wbNg6MBlZOpcwHuKCvbFOH9EAsEbanw6S5Q2LuIf
         HUsT3Nm82nlHlYT8Lc2w2WYnWT7PvVJtysDP9RPFTCon12bLt/AVTuoG4KD2u2xojDuU
         mavw4wZpijDFhSu8o6uEZm+Jb4MvHq0ei9RN8OvXA/X1/uoVBT9adndsWGhLNMJh90/8
         GU8cnw4pAY/6OItiYSl8Yj6c0EkzYbL42Pmtom2xGdTeN/eQFX+4vEoNkdt5xMEYEFjC
         SbZrF985eHygS5GHObCDlY6XfpxVLEcndrG2NY6Y2FEpynCMfUcMAV50wz0CQ9mn8cTb
         z6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959356; x=1754564156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Xqu0xZcMwu5bTVe+RW26RwXnOxaIGhBZuY4+vQOKNA=;
        b=E75gxNoKfHsNW3l7J6W970trFPfjm54FRrgEsLgSlyC7PT+3I2bMTvc50TD+KYR8eh
         IWUqfKHn0P9dOp18nhLwgdthCz5q1TN2mKq0ZQMZzwq3wUbOie+9xoMUhMotN5zrbxIb
         +z9PI8xozK/FhCV3V90LdZtxPPXbvk2FnDEXi623SfTKLzrYujqx6Ax2F9ovUdxYtqka
         Sza0YCqPgwHUUvESWu9wegWT61UOuUD6HL17NqVpxLb6AaJN2MDNp0tJc/ktM6yRGEcq
         gKBif8iEEO7acf4TCvfFMbIDZvHXNX/aJM/+hiAcSON+QkLxxGMzQ7D2xlsubD8atMt7
         sH/w==
X-Gm-Message-State: AOJu0YzTWtN7bG54BxmjSQGgoYFm8VjVPNyYCvnUU6TVx7IOmbUhE9Wc
	9L0oi7AFkMHVpcc+kqGk8ZOBeSzn/OOSHvSUQFASgd12qbBjk3WFqGYc
X-Gm-Gg: ASbGnctewyuAHCoxpwcantOFQbMqxUzS9KwyMANDaQL+oGJd+GbFobaNOVnQgHUorB5
	UzBkqcEVSmlhWk1vHn3gYO2PDzoJdCTZ+kfLR6WVc9Tei6wPpEPw7J/65XJWTNH87fYZ/0yUrjU
	dSHqRx3MQ6U/GyA0XYaU9IUqBNquOo+uoXZ2f4ddsOumifa8tF5HbHajdiJlzAa5/Qo5GdN2AX4
	mDoAEA/peEIGsV46In5XuApQ94EGIc5fEXPbIHQhhKpZSGdB1NuuB1ihu9GTRhmTd73+MfyPlbF
	vrmKDQwo3K1KcwOVSWCOLAMoswrZQjBlUZa/l4O/ENI6zC8yA4Lnz7DpqgAgGhiwajAhD2yLkeL
	XswHQo4kqMs6uF+vFleI=
X-Google-Smtp-Source: AGHT+IGKY0LuxO/c50j3yZ7leqa+8itWfH62iJhEIHQj7AFYzPpKsvn2M9NaW5dXXFnGyHmRLA6yqw==
X-Received: by 2002:a05:6000:250f:b0:3b7:94c6:865e with SMTP id ffacd0b85a97d-3b794ffce8bmr4934246f8f.30.1753959356450;
        Thu, 31 Jul 2025 03:55:56 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:56 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v2 15/25] sched/rt: Remove old RT_GROUP_SCHED data structures
Date: Thu, 31 Jul 2025 12:55:33 +0200
Message-ID: <20250731105543.40832-16-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731105543.40832-1-yurand2000@gmail.com>
References: <20250731105543.40832-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luca abeni <luca.abeni@santannapisa.it>

Completely remove the old RT_GROUP_SCHED's functions and data structures.

Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 include/linux/sched.h |  4 ----
 kernel/sched/rt.c     |  1 -
 kernel/sched/sched.h  | 26 --------------------------
 3 files changed, 31 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f0c8229afd1..343e8ef5ba1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -621,13 +621,9 @@ struct sched_rt_entity {
 	unsigned short			on_rq;
 	unsigned short			on_list;
 
-	struct sched_rt_entity		*back;
 #ifdef CONFIG_RT_GROUP_SCHED
-	struct sched_rt_entity		*parent;
 	/* rq on which this entity is (to be) queued: */
 	struct rt_rq			*rt_rq;
-	/* rq "owned" by this entity/group: */
-	struct rt_rq			*my_q;
 #endif
 } __randomize_layout;
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index bd11f4a03f7..f37ac9100d1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1,4 +1,3 @@
-#pragma GCC diagnostic ignored "-Wunused-function"
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Real-Time Scheduling Class (mapped to the SCHED_FIFO and SCHED_RR
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f235df4bf1..4a1bbda3720 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -310,15 +310,6 @@ struct rt_prio_array {
 	struct list_head queue[MAX_RT_PRIO];
 };
 
-struct rt_bandwidth {
-	/* nests inside the rq lock: */
-	raw_spinlock_t		rt_runtime_lock;
-	ktime_t			rt_period;
-	u64			rt_runtime;
-	struct hrtimer		rt_period_timer;
-	unsigned int		rt_period_active;
-};
-
 struct dl_bandwidth {
 	raw_spinlock_t          dl_runtime_lock;
 	u64                     dl_runtime;
@@ -483,7 +474,6 @@ struct task_group {
 	struct sched_dl_entity	**dl_se;
 	struct rt_rq		**rt_rq;
 
-	struct rt_bandwidth	rt_bandwidth;
 	struct dl_bandwidth	dl_bandwidth;
 #endif
 
@@ -802,11 +792,6 @@ struct scx_rq {
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
 
-static inline int rt_bandwidth_enabled(void)
-{
-	return 0;
-}
-
 /* RT IPI pull logic requires IRQ_WORK */
 #if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP)
 # define HAVE_RT_PUSH_IPI
@@ -824,17 +809,6 @@ struct rt_rq {
 	bool			overloaded;
 	struct plist_head	pushable_tasks;
 
-	int			rt_queued;
-
-#ifdef CONFIG_RT_GROUP_SCHED
-	int			rt_throttled;
-	u64			rt_time; /* consumed RT time, goes up in update_curr_rt */
-	u64			rt_runtime; /* allotted RT time, "slice" from rt_bandwidth, RT sharing/balancing */
-	/* Nests inside the rq lock: */
-	raw_spinlock_t		rt_runtime_lock;
-
-	unsigned int		rt_nr_boosted;
-#endif
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group	*tg; /* this tg has "this" rt_rq on given CPU for runnable entities */
 #endif
-- 
2.50.1


