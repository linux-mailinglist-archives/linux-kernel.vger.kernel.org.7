Return-Path: <linux-kernel+bounces-766156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5375DB242FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA247B0317
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B3C2D9ED9;
	Wed, 13 Aug 2025 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f37ZFEZA"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505762D3204
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070936; cv=none; b=B4W7JzTT32VXleeFlDOddSHhbJtLPeVHOJcuhaylar9r4QU53ifoQ2makqtqJxkgaKQHSd8urhp3HAqr5b61+U9WDVfv5qS8I9BAP1zxHwXVCYryDsu7iueRKNZvBgTcgaufM8FE/gbdJdAzdDcv31ape4s8WP3QoHLGrPdpPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070936; c=relaxed/simple;
	bh=jNrPDQvQa2z4vNt3ufQEDRvtq+3fqOqeCCF0Oy37Po8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubBA8/MMpjAswxE4mdpz+z27SR+w3P3lhBH9/WY6zGOL8zSTqDpsDkLLQofTNWWDRlvER3ng1RXQSRVYl61NNgHls7abD84SB+PzMcb8z0/sa6MveOtwyy/pXD+t+6HB79z40mLbs3s2iS/5wHQhG/5eqCMCZ9b2F6U2VUdIkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f37ZFEZA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bd6e84eddso7666774b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755070934; x=1755675734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CavdXOJmDoQ4WcQwQ9VbtE22m77hvVOEvRLARCsCyWk=;
        b=f37ZFEZArb7l3r22Btv0MiRhjvWh1PC1Kxe0H42XN0DeP3HU/nPHKTSbsBvipg0KTP
         qUInXS0n6NWYZPAikYWkoqzScJQrjQk7X8jnY7ejPji+DXFRB6dfAefwpVRy9F6LwiQ+
         BN7QJnB6l1KQW1tB/qY/oU8L+cYTspqfuJWgV+vtDEDGFqHQdXwyy/PAK+mpNICxx+YI
         GHmsogBQmxl0ekpxRBPKcpvWSynNs7pU80myw8mpatcHv6UBeTsGULGnRbLe21FaIZOz
         vLlI3Qbe5d0OZhFqONRIZDzKY4BVEcTAj7wZaUV+4kHIAUYv1P579CQwCWeh0z04Yst2
         VxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755070934; x=1755675734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CavdXOJmDoQ4WcQwQ9VbtE22m77hvVOEvRLARCsCyWk=;
        b=tcnlw2BP2o+4a1fK4FyroUlFQjf9WLE5/mi2jR6SzccARGq8GuvbuESFIL6lyMOOF9
         uRwF31M0y4qA9MQESzOMxtUnZ5yj45jzACtmrb2wnvBmo/I41mR+hg01Mh68Pn2ih1GI
         0oc598Bb5HLN+t3IlJ4VceVackDHYiIZ/HtcjBWHQCADvrGBsmGEs/5E5kBzHNzaNqF6
         PaEYgmD94ifAGyu4/VSkp4a8UG8QDRl56jytjGBNK4Ci0TWFZiCbW2arbFQvZ4rWKDcu
         6oaTen8s76NzMxSgkFR4TV8ItJJUz53hY5Mk/8nrm8A1Nzf1/r7M9q+n5re4poZyBOLp
         0Ogw==
X-Forwarded-Encrypted: i=1; AJvYcCVu0C5JBnim6paV4JzzS/qYU3JDgdqSi9rM36biTua0xkFckEOieLMHu7wfELm3i+IMJWI8Jsx7q6zmkes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxARHCEutgo+uDydsDlowku+QoHh8o2CURyPg2fEpNsqInYjDBL
	ljI/an3mwyuCgJXgTfmtlaO2j9EUyDbtxpYL5islnKXeskN+SrTvet59
X-Gm-Gg: ASbGncu67bBQDVTUDOKYarlTgR7ypvl5TzJmgnUgcP2ugqyL1LcFLx+9zJ88WeTTOj+
	gALTc8sQBLtfwxJlfeg7I4G0RgpYajJ/B7/9utMwvGM+tLcCI2BWB6AjvdgS26igdF1SNPpdp38
	p6vseQvx2Rkc+xZTFFJ1X4r9QJNLES+Te/+EI6J8Q5F1i6nSbauc8i1/To5GnSknCuCP1RzVXE1
	ZGOFNV4rpjw4D0XgRsXnn/NrjIoPrcALJjh9L8k2MjUnQcO4cFzkatcrpGb6lBMD1BuYUzasuve
	6dYj5wCoi+RViM8eUr5v4UEQ3bk7cf1X9/jiKoWy8RnxyXEA6XtbwXix/ve52VAszmNePgkJUmo
	qya9l4pbFlg1dojJXOdzH4La6t/O8zUnyayg7L2X7Ag==
X-Google-Smtp-Source: AGHT+IEhXNLhtUUwKSRp3Vr5YDOo/ZWfk9UUDwj9HJead4EPelMA7p/o0JPy4Z3dFA1LWs8XaMo84Q==
X-Received: by 2002:a05:6a21:3381:b0:23d:4777:49bd with SMTP id adf61e73a8af0-240a8b0cf5bmr3533433637.21.1755070934344;
        Wed, 13 Aug 2025 00:42:14 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c68:b9e1:95d4:9448:4c04:c914])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f474sm30819811b3a.4.2025.08.13.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 00:42:13 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	peterz@infradead.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	linux-kernel@vger.kernel.org
Cc: jann@thejh.net,
	keescook@chromium.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH v4] futex: don't leak robust_list pointer on exec race
Date: Wed, 13 Aug 2025 13:12:01 +0530
Message-ID: <20250813074201.6253-1-pranav.tyagi03@gmail.com>
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

 kernel/futex/syscalls.c | 108 +++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4b6da9116aa6..0da33abc2f17 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -39,6 +39,58 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
 	return 0;
 }
 
+static inline void __user *task_robust_list(struct task_struct *p, bool compat)
+{
+#ifdef CONFIG_COMPAT
+	if (compat)
+		return p->compat_robust_list;
+#endif
+	return p->robust_list;
+}
+
+static void __user *get_robust_list_common(int pid, bool compat)
+{
+	struct task_struct *p;
+	void __user *head;
+	unsigned long ret;
+
+	p = current;
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
+	head = task_robust_list(p, compat);
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
@@ -49,36 +101,14 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
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
+	struct robust_list_head __user *head = get_robust_list_common(pid, false);
 
-	ret = -EPERM;
-	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-		goto err_unlock;
-
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
@@ -455,36 +485,14 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
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
+	struct compat_robust_list_head __user *head = get_robust_list_common(pid, true);
 
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


