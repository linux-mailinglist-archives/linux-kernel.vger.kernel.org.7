Return-Path: <linux-kernel+bounces-682940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BC2AD66B7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 06:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08031BC17EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 04:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B31E5B94;
	Thu, 12 Jun 2025 04:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO0qY2Fu"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B51A3165
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 04:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702060; cv=none; b=iWymRs/1dl/SoAe9BD9vg6FQNIxYj6pNmbeL/NG4iLvXJCtz2SLZXYBxtZ82QnRkU0FF84ftZHJJh+sHUjxfHKwoj7Olxv4BBBUwgOzmnyNfnpwYFzRvH/RR6JzvZbhKtIxDkLGkbWGIIepm+hh7XidQh/mEgsRsUg1E+mIW0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702060; c=relaxed/simple;
	bh=TsxN2z8IOm8/jwGSpBka8PYJRa2K7ScElWp5HNUlTS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=un0oKii4BECLznXfvVMhVVEpX5bnFg+IrisF2qTrPy6hYlUXyxCBz7JoRD/bmJimNYI/mjUHARDgiXOG83QQgAobE2zoyTq/RftIRzy9v5vi09GTJrIPVRCjZex0yLcGrpUOkBb0h7sC2LzkYeRYTgRQl7rzjHvzQwjXiG3zl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO0qY2Fu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74877ac9d42so420803b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 21:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749702058; x=1750306858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct43B9dpr2sXOkfVpusyhMVLq0HGGYTToPuza0NtbVc=;
        b=KO0qY2FuaBUkjt3xzLTK7vTEky+kVlvU87M35wkVIU911ZgcjstwdUP697OFIzHoN9
         g2VavI9QzYIKS2/hoaXxBoaZId9xetGHq0sdPGWF072dBDe6L9W71I1KJKiFgYY+YeVM
         bIpQV75/wLkAvS3LogZqguY3I5TOMHVW+2bRdW3+J3zc7vc7bghGkfk7dNeEJmnrSTuL
         gOEiisGU1+4hbDFEx3HYOx+Etd2fGofMN8i8+RTg3f3OnFUZXPzaS/3uTZumL+OYBmc6
         krxcCnhXMbXjhgTKL7AsmQwBA3NDoN3DyaOS+cRQ1O4kavymF6Zbma4QNe9tZP428A1n
         x5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749702058; x=1750306858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ct43B9dpr2sXOkfVpusyhMVLq0HGGYTToPuza0NtbVc=;
        b=GnY0/5YHaiCOlXynIHbz98iewfQB9hhGU7786M7LFIkvW6ccBTnE3PE9xGitNeeEjt
         NcOWKda+C/oNfcY4iWNCu5/fUAnSrd8Ff7tgVbDy87clE4aGduct9qw/We4Dk458D/E3
         GP0XjslqtsrsgbhcK0h1Ei2wV2rpnUyCkhvEUy18R8oxABr5Jo9NlweN1DWTUiP13BiH
         lQiXDW9CKUo3TVUemTecW+nwH7HUaZSjZLOCQjiAp69psTT19LxRK7K7WpaTLRzqQste
         L7yMU9VNEmPRHZWlJlsYEwIAXLpzmm6t4IelYzAfOjoOjjUNb2nQH9l6CPO2ZaCuySyX
         ZJyg==
X-Forwarded-Encrypted: i=1; AJvYcCWB6O7ZEQGR4L1afp0vgVUSYSBMSQoxXzzASQUgjnJrDGBlt7TR7dGo7qj+ILPTiL75qze2DsTRtM5Hd0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxghuMADMs7uZc/4GeTxmOVUyBGJbPHSaE9dnKOuqT+W/GT8E/4
	Opk9hJoM70sSrnb05EKzNj9V57ttt7IOKf8NgQraLWNHQmh/yfg7b/IDtX+5fA==
X-Gm-Gg: ASbGncvaSU+ZTKkZX+R6iVE4md8m1ZlSz4HbdKGa8kreve6DXneStPzPhUHmr15hB52
	3WWJ9miYnvfS+3Sy6II8eefv3bCYoQiTPK2aNNj0LjdsCGxOq1pvvA6bPbGLK8HMqMapc8a6YsD
	FVPZEHD2HRDmned4UJ70CvAn+TPSm+i+JdRXzewrn9/z5shNLmrxj5MUHhJOoJsTqikFtko6o1a
	j4x2jgH+4qQt3v5MrpuhU+p4EgRyMzEMo5K0bgJtgzMVFblCtYO5KwclPqwgf6R5qyNVwyklxz9
	I06l6rFQfUG3GO1VLF814IFFbXDeM+26VkRSoOhT2y/vXmZAlZj6Jkul/5nshVk+K70Hm6o=
X-Google-Smtp-Source: AGHT+IHp+TrDpYOL2EW1gnU8IlHnV/0vXqH0dISgVaNDvudJhUGB/JfjkFfiHo15CgWdHT+oLPnivw==
X-Received: by 2002:aa7:88c9:0:b0:748:3a1a:ba72 with SMTP id d2e1a72fcca58-7487e29c60amr2188551b3a.20.1749702057954;
        Wed, 11 Jun 2025 21:20:57 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([103.88.46.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809d2b79sm439361b3a.92.2025.06.11.21.20.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Jun 2025 21:20:57 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
X-Google-Original-From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: zi.li@linux.dev,
	anna.schumaker@oracle.com,
	boqun.feng@gmail.com,
	joel.granados@kernel.org,
	jstultz@google.com,
	kent.overstreet@linux.dev,
	leonylgao@tencent.com,
	linux-kernel@vger.kernel.org,
	longman@redhat.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	mingzhe.yang@ly.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	will@kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH RFC 3/3] hung_task: extend hung task blocker tracking to rwsems
Date: Thu, 12 Jun 2025 12:19:26 +0800
Message-ID: <20250612042005.99602-4-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612042005.99602-1-lance.yang@linux.dev>
References: <20250612042005.99602-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

Inspired by mutex blocker tracking[1], and having already extended it to
semaphores, let's now add support for reader-writer semaphores (rwsems).

The approach is simple: when a task enters TASK_UNINTERRUPTIBLE while
waiting for an rwsem, we just call hung_task_set_blocker(). The hung task
detector can then query the rwsem's owner to identify the lock holder.

Tracking works reliably for writers, as there can only be a single writer
holding the lock, and its task struct is stored in the owner field.

The main challenge lies with readers. The owner field points to only one
of many concurrent readers, so we might lose track of the blocker if that
specific reader unlocks, even while others remain. This is not a
significant issue, however. In practice, long-lasting lock contention is
almost always caused by a writer. Therefore, reliably tracking the writer
is the primary goal of this patch series ;)

With this change, the hung task detector can now show blocker task's info
like below:

[Thu Jun 12 11:01:33 2025] INFO: task rw_sem_thread2:36526 blocked for more than 122 seconds.
[Thu Jun 12 11:01:33 2025]       Tainted: G S         O        6.16.0-rc1 #1
[Thu Jun 12 11:01:33 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Thu Jun 12 11:01:33 2025] task:rw_sem_thread2  state:D stack:0     pid:36526 tgid:36526 ppid:2      task_flags:0x208040 flags:0x00004000
[Thu Jun 12 11:01:33 2025] Call Trace:
[Thu Jun 12 11:01:33 2025]  <TASK>
[Thu Jun 12 11:01:33 2025]  __schedule+0x7c7/0x1930
[Thu Jun 12 11:01:33 2025]  ? __pfx___schedule+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? _raw_spin_lock_irq+0x8a/0xe0
[Thu Jun 12 11:01:33 2025]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[Thu Jun 12 11:01:33 2025]  schedule+0x6a/0x180
[Thu Jun 12 11:01:33 2025]  schedule_preempt_disabled+0x15/0x30
[Thu Jun 12 11:01:33 2025]  rwsem_down_write_slowpath+0x447/0x1090
[Thu Jun 12 11:01:33 2025]  ? __pfx_rwsem_down_write_slowpath+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? __pfx___schedule+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? __pfx___might_resched+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? __pfx_thread2_func+0x10/0x10 [rw_sem_test_2]
[Thu Jun 12 11:01:33 2025]  down_write+0x125/0x140
[Thu Jun 12 11:01:33 2025]  ? __pfx_down_write+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? msleep+0x91/0xf0
[Thu Jun 12 11:01:33 2025]  ? __raw_spin_lock_irqsave+0x8c/0xf0
[Thu Jun 12 11:01:33 2025]  thread2_func+0x37/0x70 [rw_sem_test_2]
[Thu Jun 12 11:01:33 2025]  kthread+0x39f/0x750
[Thu Jun 12 11:01:33 2025]  ? __pfx_kthread+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? __pfx_kthread+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ret_from_fork+0x25d/0x320
[Thu Jun 12 11:01:33 2025]  ? __pfx_kthread+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ret_from_fork_asm+0x1a/0x30
[Thu Jun 12 11:01:33 2025]  </TASK>
[Thu Jun 12 11:01:33 2025] INFO: task rw_sem_thread2:36526 <writer> blocked on an rw-semaphore likely owned by task rw_sem_thread1:36525 <writer>
[Thu Jun 12 11:01:33 2025] task:rw_sem_thread1  state:S stack:0     pid:36525 tgid:36525 ppid:2      task_flags:0x208040 flags:0x00004000
[Thu Jun 12 11:01:33 2025] Call Trace:
[Thu Jun 12 11:01:33 2025]  <TASK>
[Thu Jun 12 11:01:33 2025]  __schedule+0x7c7/0x1930
[Thu Jun 12 11:01:33 2025]  ? __pfx___schedule+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? __mod_timer+0x304/0xa80
[Thu Jun 12 11:01:33 2025]  ? irq_work_queue+0x6a/0xa0
[Thu Jun 12 11:01:33 2025]  ? __pfx_vprintk_emit+0x10/0x10
[Thu Jun 12 11:01:33 2025]  schedule+0x6a/0x180
[Thu Jun 12 11:01:33 2025]  schedule_timeout+0xfb/0x230
[Thu Jun 12 11:01:33 2025]  ? __pfx_schedule_timeout+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? __pfx_process_timeout+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? down_write+0xc4/0x140
[Thu Jun 12 11:01:33 2025]  msleep_interruptible+0xbe/0x150
[Thu Jun 12 11:01:33 2025]  ? __pfx_thread1_func+0x10/0x10 [rw_sem_test_2]
[Thu Jun 12 11:01:33 2025]  thread1_func+0x37/0x60 [rw_sem_test_2]
[Thu Jun 12 11:01:33 2025]  kthread+0x39f/0x750
[Thu Jun 12 11:01:33 2025]  ? __pfx_kthread+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ? __pfx_kthread+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ret_from_fork+0x25d/0x320
[Thu Jun 12 11:01:33 2025]  ? __pfx_kthread+0x10/0x10
[Thu Jun 12 11:01:33 2025]  ret_from_fork_asm+0x1a/0x30
[Thu Jun 12 11:01:33 2025]  </TASK>

[1] https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com/

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/linux/hung_task.h | 18 +++++++++---------
 kernel/hung_task.c        | 29 +++++++++++++++++++++++++----
 kernel/locking/rwsem.c    | 17 ++++++++++++++++-
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
index 1bc2b3244613..34e615c76ca5 100644
--- a/include/linux/hung_task.h
+++ b/include/linux/hung_task.h
@@ -21,17 +21,17 @@
  * type.
  *
  * Type encoding:
- * 00 - Blocked on mutex        (BLOCKER_TYPE_MUTEX)
- * 01 - Blocked on semaphore    (BLOCKER_TYPE_SEM)
- * 10 - Blocked on rt-mutex     (BLOCKER_TYPE_RTMUTEX)
- * 11 - Blocked on rw-semaphore (BLOCKER_TYPE_RWSEM)
+ * 00 - Blocked on mutex			(BLOCKER_TYPE_MUTEX)
+ * 01 - Blocked on semaphore			(BLOCKER_TYPE_SEM)
+ * 10 - Blocked on rw-semaphore as READER	(BLOCKER_TYPE_RWSEM_READER)
+ * 11 - Blocked on rw-semaphore as WRITER	(BLOCKER_TYPE_RWSEM_WRITER)
  */
-#define BLOCKER_TYPE_MUTEX      0x00UL
-#define BLOCKER_TYPE_SEM        0x01UL
-#define BLOCKER_TYPE_RTMUTEX    0x02UL
-#define BLOCKER_TYPE_RWSEM      0x03UL
+#define BLOCKER_TYPE_MUTEX		0x00UL
+#define BLOCKER_TYPE_SEM		0x01UL
+#define BLOCKER_TYPE_RWSEM_READER	0x02UL
+#define BLOCKER_TYPE_RWSEM_WRITER	0x03UL
 
-#define BLOCKER_TYPE_MASK       0x03UL
+#define BLOCKER_TYPE_MASK		0x03UL
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 static inline void hung_task_set_blocker(void *lock, unsigned long type)
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index d2432df2b905..8708a1205f82 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -23,6 +23,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/sysctl.h>
 #include <linux/hung_task.h>
+#include <linux/rwsem.h>
 
 #include <trace/events/sched.h>
 
@@ -100,6 +101,7 @@ static void debug_show_blocker(struct task_struct *task)
 {
 	struct task_struct *g, *t;
 	unsigned long owner, blocker, blocker_type;
+	const char *rwsem_blocked_by, *rwsem_blocked_as;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
 
@@ -111,12 +113,20 @@ static void debug_show_blocker(struct task_struct *task)
 
 	switch (blocker_type) {
 	case BLOCKER_TYPE_MUTEX:
-		owner = mutex_get_owner(
-			(struct mutex *)hung_task_blocker_to_lock(blocker));
+		owner = mutex_get_owner(hung_task_blocker_to_lock(blocker));
 		break;
 	case BLOCKER_TYPE_SEM:
-		owner = sem_last_holder(
-			(struct semaphore *)hung_task_blocker_to_lock(blocker));
+		owner = sem_last_holder(hung_task_blocker_to_lock(blocker));
+		break;
+	case BLOCKER_TYPE_RWSEM_READER:
+	case BLOCKER_TYPE_RWSEM_WRITER:
+		owner = (unsigned long)rwsem_owner(
+					hung_task_blocker_to_lock(blocker));
+		rwsem_blocked_as = (blocker_type == BLOCKER_TYPE_RWSEM_READER) ?
+					"reader" : "writer";
+		rwsem_blocked_by = is_rwsem_reader_owned(
+					hung_task_blocker_to_lock(blocker)) ?
+					"reader" : "writer";
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -134,6 +144,11 @@ static void debug_show_blocker(struct task_struct *task)
 			pr_err("INFO: task %s:%d is blocked on a semaphore, but the last holder is not found.\n",
 			       task->comm, task->pid);
 			break;
+		case BLOCKER_TYPE_RWSEM_READER:
+		case BLOCKER_TYPE_RWSEM_WRITER:
+			pr_err("INFO: task %s:%d is blocked on an rw-semaphore, but the owner is not found.\n",
+			       task->comm, task->pid);
+			break;
 		}
 		return;
 	}
@@ -152,6 +167,12 @@ static void debug_show_blocker(struct task_struct *task)
 			pr_err("INFO: task %s:%d blocked on a semaphore likely last held by task %s:%d\n",
 			       task->comm, task->pid, t->comm, t->pid);
 			break;
+		case BLOCKER_TYPE_RWSEM_READER:
+		case BLOCKER_TYPE_RWSEM_WRITER:
+			pr_err("INFO: task %s:%d <%s> blocked on an rw-semaphore likely owned by task %s:%d <%s>\n",
+			       task->comm, task->pid, rwsem_blocked_as, t->comm,
+			       t->pid, rwsem_blocked_by);
+			break;
 		}
 		sched_show_task(t);
 		return;
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index a310eb9896de..92c6332da401 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
+#include <linux/hung_task.h>
 #include <trace/events/lock.h>
 
 #ifndef CONFIG_PREEMPT_RT
@@ -1065,10 +1066,13 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 		wake_up_q(&wake_q);
 
 	trace_contention_begin(sem, LCB_F_READ);
+	set_current_state(state);
+
+	if (state == TASK_UNINTERRUPTIBLE)
+		hung_task_set_blocker(sem, BLOCKER_TYPE_RWSEM_READER);
 
 	/* wait to be given the lock */
 	for (;;) {
-		set_current_state(state);
 		if (!smp_load_acquire(&waiter.task)) {
 			/* Matches rwsem_mark_wake()'s smp_store_release(). */
 			break;
@@ -1083,8 +1087,12 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 		}
 		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_reader);
+		set_current_state(state);
 	}
 
+	if (state == TASK_UNINTERRUPTIBLE)
+		hung_task_clear_blocker();
+
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock);
 	trace_contention_end(sem, 0);
@@ -1146,6 +1154,9 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	set_current_state(state);
 	trace_contention_begin(sem, LCB_F_WRITE);
 
+	if (state == TASK_UNINTERRUPTIBLE)
+		hung_task_set_blocker(sem, BLOCKER_TYPE_RWSEM_WRITER);
+
 	for (;;) {
 		if (rwsem_try_write_lock(sem, &waiter)) {
 			/* rwsem_try_write_lock() implies ACQUIRE on success */
@@ -1179,6 +1190,10 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 trylock_again:
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
+
+	if (state == TASK_UNINTERRUPTIBLE)
+		hung_task_clear_blocker();
+
 	__set_current_state(TASK_RUNNING);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
-- 
2.49.0


