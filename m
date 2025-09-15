Return-Path: <linux-kernel+bounces-817611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A31B5847D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BA81AA77E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA52BE7B3;
	Mon, 15 Sep 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WycRs0zI"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2B1E411C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960531; cv=none; b=SuByCTCeEbqIsmU4Re/2M5c9xaOHsIpk0fvsTIQ1cKYbFokCHxqn/ayaz/8DDZ1iemMaKdh/HJvWZMsRd4oADmpcTfheZR9FVrm0Qi7r96P04SAzEW7uHO8lQHKbuQmL8q1s5AOPQFHlId+dNtmN9igrSvPWUBegR6sDO/LjtdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960531; c=relaxed/simple;
	bh=o/h1xZihp6iFdI14d7C67W8XgShqC5H3sxO3VZi/1kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dpUs4bEYrNTRgTjo7fQeQlyV1PRLEc8cjec2iAowJXNjqIlrkJ2/2nz5XIH8o4BDVQheFDyUboEkEMulSfkUMTTBMQtVO1/xe7QBZ0XA/K/HFPCktUr0cT5WYnAugsKbzwP8/RC76ici59o1bklF7GOQYRv0qUZ5dBQvd8O2aWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WycRs0zI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b54b2428fafso2796548a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757960528; x=1758565328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rG2H4q46JFVd7d8yJXAoVcDxo6FMqUCgE7ZXP9GFDS8=;
        b=WycRs0zIgmJ3AMmS3L2GdzfntCTZ4ZwrXQZlVfQO2DgnKU0nIHMBREHBAG7+bgMVjQ
         choE0wUAAQQIhj5gvsC8IrsJ1o7cWRYPTgDdPBb1jnDccJqmBHb5IxOBo6g8eqXVBsBh
         hMUsCZh+DF+QXHmUVvjk8+Fva/YDfVmEjifcDReurb3qk5eyVlKvcLVjH3HvCvb7REwO
         z5M8ka1xjzjYjKoP5fUeI8lrLqEASc4Mowy0BSMVGLE401Tc/E/BYrYTnn5bOXq0dGFp
         HECI3CtUfjQrtfoOApJXThP8lJQVw+ISw6WahZ9vPFkeJH1C296+yZEDvvkixB66AhAq
         D8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960528; x=1758565328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rG2H4q46JFVd7d8yJXAoVcDxo6FMqUCgE7ZXP9GFDS8=;
        b=ADlCUFKwDC4nhak6/x3ndo8pv+Jrq/6cRoNObE4bof6Ouz4YukTGF3YHkOoiRdi149
         soVKuo1wcwp2dzVxiSpz6lH1pGGXIlQ2/EpspwRnjoKQitYV7bq08db/ShkkTDf36cR5
         378B2VXoOg7DPj4L8l7lkbu2fDgZALbLsJp3LuvSDSeEBjVKLIvyK922JNrXqpRB+a2W
         ugo7Y+mjSldaFdw5d6rWAlYiVNTM94PNh3YbilIvYGnOdPZKXc/O+cNS65pZRsTzu9cF
         3m2aVFOZWejVEkTWR5FiNBm8MpKbCEsizvWobv31IE0bhZEZVLdDNHXN2H1mECi+0uOv
         C0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVT4rMVPq/NIO306sfiAhMcXCfMrrdzXj55IaRU5hyAW5HTCyDHKKz0Mni+/z7eIM9vydjfSCRXJk2lGWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZEUj7SpLgs7eDB7r48h/9waX/O79rUjjybqvT79w+BpE/V/U
	5+ugzCnb/gXouNUeIL2q2QpslQZOaI6T/nGPYGfNkzxWFmBUMptZinBo6zU/ik/j
X-Gm-Gg: ASbGncs6VIs8r7z9wWUFYnNlQNZpRDfk2w7P3g1r05wZB0ZTRMm45HateOd7YOtkMDc
	Zsi6ErocTDKPa6I50+sKbFDQbp/7SumCVaIK0RsDCay+xN8NomgZh+XqnrguchORqVm5HMqFSBN
	PomMFpkb6Y5WoQcbrVMW6QIbDRPc2SR1HIxuTbMEE8W/gYwPMsSHKYveHTW8xYIfsSvGVl51yjs
	r+lagih7LRV/yBsuXu/y9aQWvtlcBR6PQadIf36UnFMZCmw0oFS+XGjLbYBFj4HxLtDzDAOLW6Q
	pvJQx15RuvWuviI063ktGj+V9/JSZj3ZbgJPfnptyM60GSXHHea4etDU+KBew5NfQ2iGAxnJAmo
	ftuxYGnLQI3jtwA5oDXKHmBHGQ5E6XhtCVaOmJEEIAaI=
X-Google-Smtp-Source: AGHT+IHUIR+VxNlepuLR6IFM2aCzDPWu3qoCyfrKAuI97pk+pE9ZTdTi1WxkKxlT7njnZVyWVxQQFw==
X-Received: by 2002:a17:903:985:b0:265:c145:3018 with SMTP id d9443c01a7336-265c163b982mr64335525ad.37.1757960528077;
        Mon, 15 Sep 2025 11:22:08 -0700 (PDT)
Received: from manjaro.lan ([2409:40d4:306a:a34:c83e:3326:3473:afa6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26310ead07dsm65755295ad.29.2025.09.15.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:22:07 -0700 (PDT)
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
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH RESEND v5] futex: don't leak robust_list pointer on exec race
Date: Mon, 15 Sep 2025 23:51:54 +0530
Message-ID: <20250915182154.9468-1-pranav.tyagi03@gmail.com>
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
Resending to correct Darren Hart's email. No changes since v5.
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


