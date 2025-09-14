Return-Path: <linux-kernel+bounces-815822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F9B56B81
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F617A7DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011422D0C94;
	Sun, 14 Sep 2025 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzT0l4Ni"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0402D0292
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757877307; cv=none; b=FUdJkJsEUWv5llqH6jBVAaReCoqU71LL0DOof2+5IisM6JXou5qtfrY96AxD4FBOKgdeDmKug2pkdtO4OUHhD/xzaE1grQqRxUylCpvzT+P73OPRaQt960XpvDcDYXPyYqtDI90CZ7TdR8PxEO4+sHkwtnvzy4NVvkqPTmJpu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757877307; c=relaxed/simple;
	bh=eofSGT1FR+XLSEaDlZM1gFl7INPOHNtGfnqBW7HXQo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onRHo6fQlOwkvzLs7oSV/o5U7JDLIf/sa9GOqemHsxM7tnyqx2AAJnMfKrcV6fC95NCKlwz0rx5bZmhSWly4awn6u7eehm255yPPmDd23WLY07vEgFiapzM71uzsbUzFwvbZxGpr34wINqHyTpa5KM8Uj4+u7+mfUOQLuizHlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzT0l4Ni; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so4635196a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757877305; x=1758482105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9mSLYd1cMU9j2dD0TlDL/hDDwlE3ozp1ZoA+lVIe+zM=;
        b=TzT0l4NiDRue8PXMxYNQ8yV2uHV5wl2iJudvspWRr9OAp4orgyR8Al7cBCfN4Xhjn7
         b574BMcnsbAip3ZRvGmlpBeSPOt12s5+SN3hgWasyY2w0YPtGbSHwm4/A+sVmvWv89oJ
         /QzlrZtE3N4k6+burY1nDrhYmqefHsGvgB4xCRJMPO9jEOu8Ic72EvWn4tuwEgSsPpjO
         guOQnqbl1g7tRc+5GC/D4/Tk5uqQVTcysVEWuR9I/Tcax4vJO5HxxNyCfb5PFw/fLIHB
         KSuB9P+MDUHzgxJoPHlucBtZK//N2ZpYqv0HVjJcj2l6vLiECL668c5Ihhn0h8aHOzWI
         0vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757877305; x=1758482105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mSLYd1cMU9j2dD0TlDL/hDDwlE3ozp1ZoA+lVIe+zM=;
        b=NaPLq47tiGoWKqpj1DGYnYcGd/sBQATsXXZKYgf1Vqz2b6fsUiDHOKBabCAc8VnS/+
         XC/QqilfsW34us81KyMtv0br9+eZyJNoaIvUEcRFkx3C7FZbnbXwbmLbfkZq7AYMvdMX
         6pEUdzB84nz1hUKla0u3uMCqKkmYm+pPaE4EDDRx0hx+qCmCuOCNsNCLVQNbZ+CH+naV
         I4xRlSY2o3suy11K6kv0OFL2SEC/InWPGrLxX5ORrjnE7RQQwEjZ3s33lknvzXwvmv/w
         Gb+X9syJ6CgA22bMCbM5n29Js5HkMj1EVxdrRYIrCY9VwgcxU8UPAnsrI8iPIj4jkjz9
         Xlhg==
X-Forwarded-Encrypted: i=1; AJvYcCUqP+WDnPKW4hCf1WfXeR57IEn6qnzs9eY/Aiv8b1HSOvdhLuuq9fvFJPJFRzL2EFplU7MJEEuUgsOScQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1s/7um8gk2PsDl4n24Gnh3b+IHwUGNkeTT3gN+XmT4WssI0bI
	1k0lRFG+vYN7qMMzyG0aQuoJbzwsu97I6NGIZhdXFD+M3kUV9pGLhGp9
X-Gm-Gg: ASbGncv45fC+m/qXfVpqFNAM8GlNha7GFkmpic0XGSYXeA03RtppiDAwQ/X58LGLbPX
	DrA8CPtXZIEROFb9FkeoQuAIPlT8voFSoTRD3CFTVxFZznfDzJfk4CEyaeBRTMNh68sdl0CY6PX
	11/r/DqamspOX/7Tb6wG1AIpkGSD6wKrTu7KKjxTRZyOSTLSiCEaoqyrJFJnZ8gb7FdipOXaxhp
	eAavzISjm75d/Xn+aLyNPSRjAlXEWeQOOq/xHBFfxI/IQws7wm8FPYEn0PcmTylelH32YJc8FQB
	NNQhgEqgqJ8P0Zj/NXPnG/YXQlMWW1bnsuA+3EA/sEX99aDZCwqrWCTCYcNBe7tgjPqqUm1TsAd
	ugJyQIz3LBbhmN4yHIUMhKoHp8mWkAfyNmYJMFqdjBG7fiCt2W2uXzLrd
X-Google-Smtp-Source: AGHT+IEx4tK1JU8Z2wO+qfzF66OrUv6lddDKs4j7XncZA+Agsgt0LMeyKQxBWYeDZDQ8omfs68OyXw==
X-Received: by 2002:a17:90b:1f87:b0:329:d8d2:3602 with SMTP id 98e67ed59e1d1-32de4f7dce2mr13387681a91.17.1757877304755;
        Sun, 14 Sep 2025 12:15:04 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5ba2:94e0:f95f:1f26:518e:1465])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e3602e11dsm1025197a91.7.2025.09.14.12.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 12:15:04 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	peterz@infradead.org,
	=dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	linux-kernel@vger.kernel.org
Cc: jann@thejh.net,
	keescook@chromium.org,
	skhan@linuxfoundation.org,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH v5] futex: don't leak robust_list pointer on exec race
Date: Mon, 15 Sep 2025 00:44:47 +0530
Message-ID: <20250914191447.49194-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sys_get_robust_list() and compat_get_robust_list() use
ptrace_may_access() to check if the calling task is allowed to access
another task's robust_list pointer. This check is racy against a
concurrent exec() in the target process.

During exec(), a task may transition from a non-privileged binary to a
privileged one (e.g., setuid binary) and its credentials/memory mappings
may change. If get_robust_list() performs ptrace_may_access() before
this transition, it may erroneously allow access to sensitive information
after the target becomes privileged.

A racy access allows an attacker to exploit a window
during which ptrace_may_access() passes before a target process
transitions to a privileged state via exec().

For example, consider a non-privileged task T that is about to execute a
setuid-root binary. An attacker task A calls get_robust_list(T) while T
is still unprivileged. Since ptrace_may_access() checks permissions
based on current credentials, it succeeds. However, if T begins exec
immediately afterwards, it becomes privileged and may change its memory
mappings. Because get_robust_list() proceeds to access T->robust_list
without synchronizing with exec() it may read user-space pointers from a
now-privileged process.

This violates the intended post-exec access restrictions and could
expose sensitive memory addresses or be used as a primitive in a larger
exploit chain. Consequently, the race can lead to unauthorized
disclosure of information across privilege boundaries and poses a
potential security risk.

Take a read lock on signal->exec_update_lock prior to invoking
ptrace_may_access() and accessing the robust_list/compat_robust_list.
This ensures that the target task's exec state remains stable during the
check, allowing for consistent and synchronized validation of
credentials.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
Suggested-by: Jann Horn <jann@thejh.net>
Link: https://lore.kernel.org/linux-fsdevel/1477863998-3298-5-git-send-email-jann@thejh.net/
Link: https://github.com/KSPP/linux/issues/119
---
changed in v5:
- added futex_ prefix to function names
- changed data type of ret to int
- struct task_struct *p initialized at declaration
changed in v4:
- added task_robust_list() function
changed in v3:
- replaced RCU with scoped_guard(rcu)
- corrected error return type cast
- added IS_ENABLED(CONFIG_COMPAT) for ensuring compatability
- removed stray newlines and unnecessary line breaks
changed in v2:
- improved changelog
- helper function for common part of compat and native syscalls

 kernel/futex/syscalls.c | 106 +++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 50 deletions(-)

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4b6da9116aa6..880c9bf2f315 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -39,6 +39,56 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
 	return 0;
 }
 
+static inline void __user *futex_task_robust_list(struct task_struct *p, bool compat)
+{
+#ifdef CONFIG_COMPAT
+	if (compat)
+		return p->compat_robust_list;
+#endif
+	return p->robust_list;
+}
+
+static void __user *futex_get_robust_list_common(int pid, bool compat)
+{
+	struct task_struct *p = current;
+	void __user *head;
+	int ret;
+
+	scoped_guard(rcu) {
+		if (pid) {
+			p = find_task_by_vpid(pid);
+			if (!p)
+				return (void __user *)ERR_PTR(-ESRCH);
+		}
+		get_task_struct(p);
+	}
+
+	/*
+	 * Hold exec_update_lock to serialize with concurrent exec()
+	 * so ptrace_may_access() is checked against stable credentials
+	 */
+	ret = down_read_killable(&p->signal->exec_update_lock);
+	if (ret)
+		goto err_put;
+
+	ret = -EPERM;
+	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
+		goto err_unlock;
+
+	head = futex_task_robust_list(p, compat);
+
+	up_read(&p->signal->exec_update_lock);
+	put_task_struct(p);
+
+	return head;
+
+err_unlock:
+	up_read(&p->signal->exec_update_lock);
+err_put:
+	put_task_struct(p);
+	return (void __user *)ERR_PTR(ret);
+}
+
 /**
  * sys_get_robust_list() - Get the robust-futex list head of a task
  * @pid:	pid of the process [zero for current task]
@@ -49,36 +99,14 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 		struct robust_list_head __user * __user *, head_ptr,
 		size_t __user *, len_ptr)
 {
-	struct robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
-
-	rcu_read_lock();
-
-	ret = -ESRCH;
-	if (!pid)
-		p = current;
-	else {
-		p = find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
-
-	ret = -EPERM;
-	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-		goto err_unlock;
+	struct robust_list_head __user *head = futex_get_robust_list_common(pid, false);
 
-	head = p->robust_list;
-	rcu_read_unlock();
+	if (IS_ERR(head))
+		return PTR_ERR(head);
 
 	if (put_user(sizeof(*head), len_ptr))
 		return -EFAULT;
 	return put_user(head, head_ptr);
-
-err_unlock:
-	rcu_read_unlock();
-
-	return ret;
 }
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
@@ -455,36 +483,14 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 			compat_uptr_t __user *, head_ptr,
 			compat_size_t __user *, len_ptr)
 {
-	struct compat_robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
-
-	rcu_read_lock();
-
-	ret = -ESRCH;
-	if (!pid)
-		p = current;
-	else {
-		p = find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
-
-	ret = -EPERM;
-	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-		goto err_unlock;
+	struct compat_robust_list_head __user *head = futex_get_robust_list_common(pid, true);
 
-	head = p->compat_robust_list;
-	rcu_read_unlock();
+	if (IS_ERR(head))
+		return PTR_ERR(head);
 
 	if (put_user(sizeof(*head), len_ptr))
 		return -EFAULT;
 	return put_user(ptr_to_compat(head), head_ptr);
-
-err_unlock:
-	rcu_read_unlock();
-
-	return ret;
 }
 #endif /* CONFIG_COMPAT */
 
-- 
2.49.0


