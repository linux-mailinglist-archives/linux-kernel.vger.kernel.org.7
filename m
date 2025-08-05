Return-Path: <linux-kernel+bounces-756688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB52B1B7C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1E0178CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BFF17E0;
	Tue,  5 Aug 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgP3qCME"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83285247280
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408860; cv=none; b=PkecinhyrO0ZEp3zGb6GXpfh4zv/I2V4YAZYB0tSiKeg6DZfw2EtbJc62Sggz6PhlBg7q5aOz2wjSIRIUWCMsHFZnqJk/jldXMDpHxCATHBmQn+vCi5TzN0vm09FnEb4T7Ud3eBqFEFkjlu3WBTWlS2B9ow9X6dxdqjzhAy/+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408860; c=relaxed/simple;
	bh=r1ZNtVzkV46tgwYdkFFJqca2KpFO/4Xqj8AgnYiL/ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ehc7IxN6RaViJOaFJXm0XPRKfKsHW+p60Vb+UwgX3HmgTfYyOl661zdjsRgaCc+A1Cpfk3n5ZqjflK/i43V+vP8rElNCC5yUUdHffKvdtx2sY69wojOJj6dQ2G+6uf8y83mnZdNfjKh1dOfNOjOl8tgt+3CHu4Rc9p1s6DAQy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgP3qCME; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2402774851fso49255365ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754408858; x=1755013658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fBa/zrBHVKKChl/K3snAlz7daAzVsSWKAZ9bPTQlz2g=;
        b=OgP3qCMEmEFdwcIMePua1q/2c8MXU9kaNcacbUMQlnF2Tp+UFZPHvF2ibI/6L5X5L0
         Qp5sw79PB2WnISTIIGc7wHxLAmOHljsUcg4uKw/KtFDddKWkp7lidDnSMZdjN70kxM23
         PeKr5nNStS4TaiczhTK8uF5coCOLRLp4bqj3NaT959pjGC8ERK683BWKGSSSZSjKTbWT
         faLF4eMulvnniWRTEhHQyj86dZZmmuvE5VgtA/hVaXYk+SyY+gn//Okwf0626xQKoCJA
         k6bcpKE/QQfC2XIBIxRb18122baFMovooV6smimEPb0vPRWGXS0H6tO1VBNxw/QBFYSA
         co1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408858; x=1755013658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBa/zrBHVKKChl/K3snAlz7daAzVsSWKAZ9bPTQlz2g=;
        b=Yvt7Ba3+bq4WKpxjC6eSg/0p97woywtdAPPoanog+1ic84EoVph8BZiyYH46egInyx
         lCkkXGSx2El4Qrh94VYaJHH1KtVly9Egz2WOYoWjCOEBgGCQOTWRl/hmuXZrDl/K30b3
         mx6I0/S0gUhdmp5G742jshJPhrMoIK1HWSz+O/tEgvMHK1PzJtoWt47fgitn1DZsz9qm
         X0tnlH4rAPwdPQZgGNXgPpyFipWvni9ds8EsYqCu8TfFcJ38EwnktNwzCaWCAbdIsWdI
         No0QzSCGRzmP0fyAAv2+nYJdo/uCFPVPzQHReLQoq/PpHhiJmLphaCTAr9wiW81F+1K1
         T23w==
X-Forwarded-Encrypted: i=1; AJvYcCVOcuVKQPJh5REAlstTX6W2LNZbLdheONADjcW6d5F9GbCr0zLzd7Bp20LBKVT/Q7guiBQxtvzFLjvBr1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjxDMUGyVO0UsljTCInbaeoC1JQDJ5U3ySjzcDsGNey+ld1C2F
	7MfK+YngHmvceDEHGBOG3Ts7TMRxVCF7UxVZubZCKuX+z+YKNBg66upG
X-Gm-Gg: ASbGnctcbspCswV2/8ib82eRx34wIZQrFIj/PcggckfAr+Ylf2MBKrCHvLCt+SCkULr
	dCa6pSIXHTyndaqzE7hR5TVZnbiG+/Uyn+FtLYKXgeaPZxpEpC+oAjF8XnC3pXxT0PCI3DXAZKz
	NLrBMY47zHsoq9+TP/FYIP4KcUjW95WiKGsINusEPB2uEXa+R0TSbKglciwontDe9zKwIYX4Q6X
	wUlXVzSR4NxyOpkWvHF87kIUD8H07cwql57gQD1S0vY1lC2ctzYreB8Gu6dx0+XCtA9p1LVvy0g
	lS+CoNW6Ht0UOvdzXEUuwVKaucPeP6Odq4d8p3PC4fdXY6IUA5svgbqCZCruexASbr/BSRluouh
	J/PpxaEzJYHeKZNX0n/VEVWKQIdmxlR3b7E+jvkZBhA==
X-Google-Smtp-Source: AGHT+IGRqosIMPxw9Sw/5Tt3m1euRzAovlSm4EaACj5l52jRzWo9lWCHslnHwghgGcTZRJAIc10QiQ==
X-Received: by 2002:a17:902:f652:b0:240:8cec:4823 with SMTP id d9443c01a7336-2424703a024mr201403575ad.41.1754408857698;
        Tue, 05 Aug 2025 08:47:37 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c31:41da:bdc2:5f7d:c803:6cd1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aa9055sm138305345ad.150.2025.08.05.08.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 08:47:37 -0700 (PDT)
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
Subject: [PATCH v3] futex: don't leak robust_list pointer on exec race
Date: Tue,  5 Aug 2025 21:17:25 +0530
Message-ID: <20250805154725.22031-1-pranav.tyagi03@gmail.com>
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
changed in v3:
- replaced RCU with scoped_guard(rcu)
- corrected error return type cast
- added IS_ENABLED(CONFIG_COMPAT) for ensuring compatability
- removed stray newlines and unnecessary line breaks
changed in v2:
- improved changelog
- helper function for common part of compat and native syscalls

 kernel/futex/syscalls.c | 102 ++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 50 deletions(-)

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4b6da9116aa6..c342c16d6d00 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -39,6 +39,52 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
 	return 0;
 }
 
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
+	if (IS_ENABLED(CONFIG_COMPAT) && compat)
+		head = p->compat_robust_list;
+	else
+		head = p->robust_list;
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
@@ -49,36 +95,14 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 		struct robust_list_head __user * __user *, head_ptr,
 		size_t __user *, len_ptr)
 {
-	struct robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
+	struct robust_list_head __user *head = get_robust_list_common(pid, false);
 
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
@@ -455,36 +479,14 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 			compat_uptr_t __user *, head_ptr,
 			compat_size_t __user *, len_ptr)
 {
-	struct compat_robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
+	struct compat_robust_list_head __user *head = get_robust_list_common(pid, true);
 
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


