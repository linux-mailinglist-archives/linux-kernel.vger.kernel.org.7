Return-Path: <linux-kernel+bounces-755062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA0B1A0C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 036614E12FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9F253F1A;
	Mon,  4 Aug 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDKwABWY"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8790EEB2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754308561; cv=none; b=JK5wgnJ13CS2h3x8FzTjNhhv2PsSASU5WgLd3QByt8SQdX8GszSBYps5B8JnQeF4pBkRwqO5AYC+W8gX0oSv0cqCdYCacTyogmKwobK6yRpzW0eWD316uuV0veLjJGNDsORDQ3psxR4l+96+0xTGVciJCU4J1TxE6n2EgEUgv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754308561; c=relaxed/simple;
	bh=UNINGqHfq1YLeQx6OeR/fjKzIwuaw7UNHCh2cWhCXN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/6JvhEEoUU5KQ2woUA1GkwsL3A81uJY2fEeWlCezJaEFMGgzEXNAy7hgMyH/5EFGYjf/ZbjhMYTzsRasbEi4pOSxbDFwgMgxByjpmR7oCT/FSiZeRy23KEOglji7nYtVvfK8RiTI148JO871j+I/Ih+2sKl9NsFfqEbDQX/LV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDKwABWY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24022261323so56637985ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754308559; x=1754913359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ksOQ+Tj92J+PNXaCB7X2I+wlQcS5fcBNp3JiNzxWHzI=;
        b=NDKwABWYXkL3RTekCsS34xc+HfYO7Kk3PNqb+CL6EBt4HW/GTzuqoPdYFVy68aRkTQ
         H2V0mZEbrah9G//0YyXBPosm1OICLkiNs0znkDZsiFygqIWXPAFzn8sXDavHOc1sc+Cy
         ArO/MukYodnNgVZFjguUViia62silrf6Pup0zHq2ae44qbHMW4+lxTIW4k72cZCthiNB
         UogsEORvL+09WG7i/eCB26gOFZlYZiiDzHZP66FXLj6EvO2PT9wAh+tdHuVTsPDOhCVO
         2kbaIsb2Qf0Cns3aJVG9npd4JYM54IA56tOXJaD4Djj5q6nQ7TiY/fUTxjL+R/0ATe14
         kgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754308559; x=1754913359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksOQ+Tj92J+PNXaCB7X2I+wlQcS5fcBNp3JiNzxWHzI=;
        b=dLNobd0FnIp4l/B1c5GkL8KqIthY/kQOdHez7gcvhE41S1sQ2vdwoJMs7j5GgjBgDq
         c8hxmI4NcBlGIqwCNzfLQX88Ylj7VGCAiYAAmyFxI6FsM6F6rWrrhxlNbS3LPEdkSYIZ
         C4mHP2xJUBOJJytaXn4jSWlf59hrzRD+uzxX9r+8aAe1bGzikSltrpFRPMzcDAVb0ZMO
         w5mWP6xR9PDPgPIzzN6uUPNc/cM1opy8FrvAd9gcGMXeoDACsP+okS+OI8yrH2FjrxM3
         q4qSUtTS+nIPno85Y3eAiAb7us16rJCKYLnKKRyKLJ55Dvblv8nMyE3MXC6njk6s0etf
         f5Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXKrQ0fXx8CEYw2bies08h0cW+YyxICpPUVsfMTQ7Jx5vWLfLmFWhBzRTuvxabDz8A0MVTOEBCAO9SDT4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcGZsaW9rWAY9iDwvReAZZr32MA0zJUNsercI1bRaoAI2LCTp
	/nbroFcJp850/8AtXbdK2p4HsIEsYHCxJbYA/Otzh98eoMTC8noYwwIQ
X-Gm-Gg: ASbGncusEjGTqsiHD1lIEr7NVO/ElHreNpqutA5BsFSf8aGQaYW1yHf6HyHGXaa8ZTh
	CmAdK4bZCa0Ycghq8ynwhF6VE4GlAgua2O9P3ry/jDR6nDB+vf/IIVNZUHVOxSv8BYgyJcrn+j7
	05MY8T9TYpDNObdtR0b5s+PqrcDgj2NFmr/smqtGqPYqNq8N/cDcHKa+dWA82hcizrOELnt6dHw
	9Vf47oe/y7SSVNnKcy3aRLC6CcCIm6+B61QSnSKscjRSQYfgTJh6R9HEcmCQf9BANStZA1/qwGz
	s6p0OpejITPGNulvSzwk19U4NxE02kERU33keH/OCSIuoeISjMMilEyeF6bYQibpFSEJ0HqDkuY
	LShClaYQflMJ3X7vzwsljLcGAepmlGpncqUQeHNbo4g==
X-Google-Smtp-Source: AGHT+IHhRXbGekmhCpa+AR9UGAjJMz/aF6f1BIug3liJmfAa5XhHAS2BcOKnsVRULHvDefvm+Uxldw==
X-Received: by 2002:a17:902:d486:b0:240:8381:45b9 with SMTP id d9443c01a7336-242462c234amr143364775ad.8.1754308558795;
        Mon, 04 Aug 2025 04:55:58 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c31:41da:bdc2:5f7d:c803:6cd1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6aa4sm107374325ad.35.2025.08.04.04.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:55:58 -0700 (PDT)
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
Subject: [PATCH v2] futex: don't leak robust_list pointer on exec race
Date: Mon,  4 Aug 2025 17:25:33 +0530
Message-ID: <20250804115533.14186-1-pranav.tyagi03@gmail.com>
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

changed in v2:
- improved changelog
- helper function for common part of the compat and native syscalls

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
Suggested-by: Jann Horn <jann@thejh.net>
Link: https://lore.kernel.org/linux-fsdevel/1477863998-3298-5-git-send-email-jann@thejh.net/
Link: https://github.com/KSPP/linux/issues/119
---
 kernel/futex/syscalls.c | 110 ++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 48 deletions(-)

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4b6da9116aa6..3278d91d95ce 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -39,46 +39,81 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
 	return 0;
 }
 
-/**
- * sys_get_robust_list() - Get the robust-futex list head of a task
- * @pid:	pid of the process [zero for current task]
- * @head_ptr:	pointer to a list-head pointer, the kernel fills it in
- * @len_ptr:	pointer to a length field, the kernel fills in the header size
- */
-SYSCALL_DEFINE3(get_robust_list, int, pid,
-		struct robust_list_head __user * __user *, head_ptr,
-		size_t __user *, len_ptr)
+static void __user *get_robust_list_common(int pid,
+		bool compat)
 {
-	struct robust_list_head __user *head;
+	void __user *head;
 	unsigned long ret;
-	struct task_struct *p;
 
-	rcu_read_lock();
+	struct task_struct *p;
 
-	ret = -ESRCH;
-	if (!pid)
+	if (!pid) {
 		p = current;
-	else {
+		get_task_struct(p);
+	} else {
+		rcu_read_lock();
 		p = find_task_by_vpid(pid);
+		/*
+		 * pin the task to permit dropping the RCU read lock before
+		 * acquiring the semaphore
+		 */
+		if (p)
+			get_task_struct(p);
+		rcu_read_unlock();
 		if (!p)
-			goto err_unlock;
+			return ERR_PTR(-ESRCH);
 	}
 
+	/*
+	 * Hold exec_update_lock to serialize with concurrent exec()
+	 * so ptrace_may_access() is checked against stable credentials
+	 */
+
+	ret = down_read_killable(&p->signal->exec_update_lock);
+	if (ret)
+		goto err_put;
+
 	ret = -EPERM;
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
 		goto err_unlock;
 
-	head = p->robust_list;
-	rcu_read_unlock();
+	if (compat)
+		head = p->compat_robust_list;
+	else
+		head = p->robust_list;
 
-	if (put_user(sizeof(*head), len_ptr))
-		return -EFAULT;
-	return put_user(head, head_ptr);
+	up_read(&p->signal->exec_update_lock);
+	put_task_struct(p);
+
+	return head;
 
 err_unlock:
-	rcu_read_unlock();
+	up_read(&p->signal->exec_update_lock);
+err_put:
+	put_task_struct(p);
+	return ERR_PTR(ret);
+}
 
-	return ret;
+
+/**
+ * sys_get_robust_list() - Get the robust-futex list head of a task
+ * @pid:	pid of the process [zero for current task]
+ * @head_ptr:	pointer to a list-head pointer, the kernel fills it in
+ * @len_ptr:	pointer to a length field, the kernel fills in the header size
+ */
+SYSCALL_DEFINE3(get_robust_list, int, pid,
+		struct robust_list_head __user * __user *, head_ptr,
+		size_t __user *, len_ptr)
+{
+	struct robust_list_head __user *head =
+		get_robust_list_common(pid, false);
+
+	if (IS_ERR(head))
+		return PTR_ERR(head);
+
+	if (put_user(sizeof(*head), len_ptr))
+		return -EFAULT;
+	return put_user(head, head_ptr);
 }
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
@@ -455,36 +490,15 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 			compat_uptr_t __user *, head_ptr,
 			compat_size_t __user *, len_ptr)
 {
-	struct compat_robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
+	struct compat_robust_list_head __user *head =
+		get_robust_list_common(pid, true);
 
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
-
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


