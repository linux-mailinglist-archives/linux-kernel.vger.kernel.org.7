Return-Path: <linux-kernel+bounces-726688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D4B0100B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93BB7BE186
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1B72DAFD7;
	Fri, 11 Jul 2025 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTuudmWt"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C29A295DAA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752192000; cv=none; b=nMedcheOYVSZ++OvwkWP2fUTuztxS6RnxICCNzTVPPe7EeKdzLdvImZRzQL+A0RpO1QvGmPJl5A8E12U8Fpq4LxBYQeabG+rgQo1C2gnnX46SQnFD3t7o96EYeBfA8c/lzRKXetBXcBmFjoJtEJ8amnFcPrsu7wlM9C9dx0hloY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752192000; c=relaxed/simple;
	bh=INZQ9ImPvWH76SuG0dYKuQZPtZ+HPmjiIWXxTuRXlGk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjL3A1nH6a9DFPO6nP/9Q/sK71HjINDqcDTDly7F7iw3hlH7pJSflTS39XapiIg6v8BsD6GyMPuK1j9kP7gMjhP0mlUfZfYbXGP5PLjsiA3JRVR4KTjNVNrprZrxfI4Uut+qQGqfaZZz9A3fDEZhZE6/+9kW83XEKXDyW/YLGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTuudmWt; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so1471090a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752191997; x=1752796797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JR+vNibPDom+6/48b1weshfI5MDfOUfdFkjXew0Wvuo=;
        b=GTuudmWtzz93Yb2mu0v/E6ebkLbCneklIcKC9+5AUnQuwV/ggn/Jfm5ZMDJciQagQF
         dlYl0MdZ9Pyd+fqlEThoO7/Az/hawKDGu8jcHJhYhbQsikjsVduRyqiwwKQLqyGzqwIw
         weY+MnkdnnwWXJy/E7LsKyZar+4VU4KxejCcdS/l9PWXD1Moejd6JHJxyjpGWphtcCBS
         UJAGEJedRZRKIb+Zmr4F5PLQH2uPXhsvcOQbEXsx2p7foQobxqUSa1RIQPodwDFeP6kC
         WExzOglSNRud4Lia5HLxA8vdsdR2JlzUsTvMauVmj+YRqV1IwOfY82+MMv6juClrH8S8
         hNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191997; x=1752796797;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JR+vNibPDom+6/48b1weshfI5MDfOUfdFkjXew0Wvuo=;
        b=h6YSBaGYSsm7jCBK9JUQMtCWRtvWJcRTYfOaXiBJUPLnGfLfQFg+1r3SY0shT2HdhV
         9Ey9sp8/I0wW0noXgzkr3pfajX7Fgb2U9+BPetxWb8CVHNVyPEGdX+sdGRhx9wtgRnSD
         gcAaldVs4IzdA7TU4NqI+fZaSNmys2HqEQRCNzijRZn6/i/s00Nl9oqiF8Z/T3djMzQm
         6XXD7iIcBeBtSuyk9wu1Bd9exhxIUap9R4A2pjV/eBXZaZTjAcZe7p51C9DGufYG7wSS
         8GldF7qhJfw60WwnZD7Xtohfmr4R6p4SmlW7yZY8esZWyakkgpZc+1XItbCfB25AHtlz
         cxWw==
X-Forwarded-Encrypted: i=1; AJvYcCWzJzS0ed8KLzYn5RJYvuyhjb9OvHZs0GZvXyPqk6gSwSZ9J8h7UvmbIv4D2UYb4u2DmXjRtYJpnHARXqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31Ge0VfvzrbuCMudKghyWaHQPrgsf3ph85IPh/1m0e2JLSWzC
	Hfwy/1Jc06WcRtJy/5Iw9/pufE3h94h2WUcojeTWQH7y0PeG5o+Ybz4U6EtvzQ==
X-Gm-Gg: ASbGncuWzAQUDAW4zx/bOP8tYraz9rVM28+E5dkEfUnxcSLnTRvDAe2xzVLIY8lQwn4
	a9/Dnlw6xaAzXxUF6+wLpLHQtbiho4MXTqZ+2TxTvbLUntx15GPtuac/W4DT8fvfm5kE8nmVYWb
	PcxFhRlkubsAVRohWV2tEq4pgueZAyUawc4Sd1l3u1NMjZE/HRrZRYB9gYLioJBf6yVHFKGddDw
	4BVCSq6k5SUEK6mTqsWJqO7xjCS6ocFIYVk1AVt5ZqixcvawtCUuMBQVpWiJDcnlrRP2O3iKcmH
	5isoJjYpRpJ78FkM8gtFM3GQ4jqTUdoqL3BVFCihpjSxR0bpm2cu/Mp2+uFvW0IiH5oau/4QSzD
	sHLdnnGUsmbJE2FPr8VZ2Gu7aOgYhzX0dv5sIpuZeQn2yw7cu/PARrnZKc8jhUe+j25LAg+VHaT
	GO3C025gLi4NnBJ+Noh9k=
X-Google-Smtp-Source: AGHT+IGS5MXyEyHbJrz5qYKdb4Z218qHfNmzRLHCS2jK2XXgQgrBaJocz+IxaqZD79e/Hn/wVNKPPQ==
X-Received: by 2002:a17:90b:3a4b:b0:312:f2ee:a895 with SMTP id 98e67ed59e1d1-31c4cd134f6mr1582677a91.31.1752191997187;
        Thu, 10 Jul 2025 16:59:57 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c301eb658sm6531182a91.45.2025.07.10.16.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:59:56 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:59:52 +0900
Message-ID: <m2zfdb38cn.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 09/13] x86/um: nommu: signal handling
In-Reply-To: <m2jz4r438h.wl-thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
	<548dcef198b79a4f8eb166481e39abe6e13ed2e3.1750594487.git.thehajime@gmail.com>
	<3b407ed711c5d7e1819da7513c3e320699473b2d.camel@sipsolutions.net>
	<m2sejl47ke.wl-thehajime@gmail.com>
	<734965ac85b2c4cf481cc98ac53052fd5064d30e.camel@sipsolutions.net>
	<m2plem3urj.wl-thehajime@gmail.com>
	<a9133d9a69843948078f590a102bad9302f3f554.camel@sipsolutions.net>
	<m2jz4r438h.wl-thehajime@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hello Benjamin,

below is the updated patch of this patch.
I didn't follow your suggestion to use host handler to execute
userspace handlers.  instead, setup stack and %rip register to call
userspace handlers at the end of the host handler.

It would be great to hear your opinion.

---
 arch/um/include/shared/kern_util.h      |   4 +
 arch/um/nommu/Makefile                  |   2 +-
 arch/um/nommu/os-Linux/signal.c         |   8 +
 arch/um/nommu/trap.c                    | 201 ++++++++++++++++++++++++
 arch/um/os-Linux/signal.c               |   3 +-
 arch/x86/um/nommu/do_syscall_64.c       |   6 +
 arch/x86/um/nommu/entry_64.S            |  14 ++
 arch/x86/um/nommu/os-Linux/mcontext.c   |   5 +
 arch/x86/um/shared/sysdep/mcontext.h    |   1 +
 arch/x86/um/shared/sysdep/ptrace.h      |   2 +-
 arch/x86/um/shared/sysdep/syscalls_64.h |   1 +
 11 files changed, 244 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/nommu/trap.c

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/ke=
rn_util.h
index ec8ba1f13c58..7f55402b6385 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -73,4 +73,8 @@ void um_idle_sleep(void);
=20
 void kasan_map_memory(void *start, size_t len);
=20
+#ifndef CONFIG_MMU
+extern void nommu_relay_signal(void *ptr);
+#endif
+
 #endif
diff --git a/arch/um/nommu/Makefile b/arch/um/nommu/Makefile
index baab7c2f57c2..096221590cfd 100644
--- a/arch/um/nommu/Makefile
+++ b/arch/um/nommu/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
=20
-obj-y :=3D os-Linux/
+obj-y :=3D trap.o os-Linux/
diff --git a/arch/um/nommu/os-Linux/signal.c b/arch/um/nommu/os-Linux/signa=
l.c
index 19043b9652e2..27b6b37744b7 100644
--- a/arch/um/nommu/os-Linux/signal.c
+++ b/arch/um/nommu/os-Linux/signal.c
@@ -5,6 +5,7 @@
 #include <os.h>
 #include <sysdep/mcontext.h>
 #include <sys/ucontext.h>
+#include <as-layout.h>
=20
 void sigsys_handler(int sig, struct siginfo *si,
 		    struct uml_pt_regs *regs, void *ptr)
@@ -14,3 +15,10 @@ void sigsys_handler(int sig, struct siginfo *si,
 	/* hook syscall via SIGSYS */
 	set_mc_sigsys_hook(mc);
 }
+
+void nommu_relay_signal(void *ptr)
+{
+	mcontext_t *mc =3D (mcontext_t *) ptr;
+
+	set_mc_return_address(mc);
+}
diff --git a/arch/um/nommu/trap.c b/arch/um/nommu/trap.c
new file mode 100644
index 000000000000..430297517455
--- /dev/null
+++ b/arch/um/nommu/trap.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/hardirq.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/sched/debug.h>
+#include <asm/current.h>
+#include <asm/tlbflush.h>
+#include <arch.h>
+#include <as-layout.h>
+#include <kern_util.h>
+#include <os.h>
+#include <skas.h>
+
+/*
+ * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM by
+ * segv().
+ */
+int handle_page_fault(unsigned long address, unsigned long ip,
+		      int is_write, int is_user, int *code_out)
+{
+	/* !MMU has no pagefault */
+	return -EFAULT;
+}
+
+static void show_segv_info(struct uml_pt_regs *regs)
+{
+	struct task_struct *tsk =3D current;
+	struct faultinfo *fi =3D UPT_FAULTINFO(regs);
+
+	if (!unhandled_signal(tsk, SIGSEGV))
+		return;
+
+	pr_warn_ratelimited("%s%s[%d]: segfault at %lx ip %p sp %p error %x",
+			    task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
+			    tsk->comm, task_pid_nr(tsk), FAULT_ADDRESS(*fi),
+			    (void *)UPT_IP(regs), (void *)UPT_SP(regs),
+			    fi->error_code);
+}
+
+static void bad_segv(struct faultinfo fi, unsigned long ip)
+{
+	current->thread.arch.faultinfo =3D fi;
+	force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *) FAULT_ADDRESS(fi));
+}
+
+void fatal_sigsegv(void)
+{
+	force_fatal_sig(SIGSEGV);
+	do_signal(&current->thread.regs);
+	/*
+	 * This is to tell gcc that we're not returning - do_signal
+	 * can, in general, return, but in this case, it's not, since
+	 * we just got a fatal SIGSEGV queued.
+	 */
+	os_dump_core();
+}
+
+/**
+ * segv_handler() - the SIGSEGV handler
+ * @sig:	the signal number
+ * @unused_si:	the signal info struct; unused in this handler
+ * @regs:	the ptrace register information
+ *
+ * The handler first extracts the faultinfo from the UML ptrace regs struc=
t.
+ * If the userfault did not happen in an UML userspace process, bad_segv i=
s called.
+ * Otherwise the signal did happen in a cloned userspace process, handle i=
t.
+ */
+void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *=
regs,
+		  void *mc)
+{
+	struct faultinfo *fi =3D UPT_FAULTINFO(regs);
+
+	/* !MMU specific part; detection of userspace */
+	/* mark is_user=3D1 when the IP is from userspace code. */
+	if (UPT_IP(regs) > uml_reserved && UPT_IP(regs) < high_physmem)
+		regs->is_user =3D 1;
+
+	if (UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)) {
+		show_segv_info(regs);
+		bad_segv(*fi, UPT_IP(regs));
+		return;
+	}
+	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs, mc);
+
+	/* !MMU specific part; detection of userspace */
+	relay_signal(sig, unused_si, regs, mc);
+}
+
+/*
+ * We give a *copy* of the faultinfo in the regs to segv.
+ * This must be done, since nesting SEGVs could overwrite
+ * the info in the regs. A pointer to the info then would
+ * give us bad data!
+ */
+unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
+		   struct uml_pt_regs *regs, void *mc)
+{
+	int si_code;
+	int err;
+	int is_write =3D FAULT_WRITE(fi);
+	unsigned long address =3D FAULT_ADDRESS(fi);
+
+	if (!is_user && regs)
+		current->thread.segv_regs =3D container_of(regs, struct pt_regs, regs);
+
+	if (current->mm =3D=3D NULL) {
+		show_regs(container_of(regs, struct pt_regs, regs));
+		panic("Segfault with no mm");
+	} else if (!is_user && address > PAGE_SIZE && address < TASK_SIZE) {
+		show_regs(container_of(regs, struct pt_regs, regs));
+		panic("Kernel tried to access user memory at addr 0x%lx, ip 0x%lx",
+		       address, ip);
+	}
+
+	if (SEGV_IS_FIXABLE(&fi))
+		err =3D handle_page_fault(address, ip, is_write, is_user,
+					&si_code);
+	else {
+		err =3D -EFAULT;
+		/*
+		 * A thread accessed NULL, we get a fault, but CR2 is invalid.
+		 * This code is used in __do_copy_from_user() of TT mode.
+		 * XXX tt mode is gone, so maybe this isn't needed any more
+		 */
+		address =3D 0;
+	}
+
+	if (!err)
+		goto out;
+	else if (!is_user && arch_fixup(ip, regs))
+		goto out;
+
+	if (!is_user) {
+		show_regs(container_of(regs, struct pt_regs, regs));
+		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx",
+		      address, ip);
+	}
+
+	show_segv_info(regs);
+
+	if (err =3D=3D -EACCES) {
+		current->thread.arch.faultinfo =3D fi;
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
+	} else {
+		WARN_ON_ONCE(err !=3D -EFAULT);
+		current->thread.arch.faultinfo =3D fi;
+		force_sig_fault(SIGSEGV, si_code, (void __user *) address);
+	}
+
+out:
+	if (regs)
+		current->thread.segv_regs =3D NULL;
+
+	return 0;
+}
+
+void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs,
+		  void *mc)
+{
+	int code, err;
+
+	/* !MMU specific part; detection of userspace */
+	/* mark is_user=3D1 when the IP is from userspace code. */
+	if (UPT_IP(regs) > uml_reserved && UPT_IP(regs) < high_physmem)
+		regs->is_user =3D 1;
+
+	if (!UPT_IS_USER(regs)) {
+		if (sig =3D=3D SIGBUS)
+			pr_err("Bus error - the host /dev/shm or /tmp mount likely just ran out=
 of space\n");
+		panic("Kernel mode signal %d", sig);
+	}
+	/* if is_user=3D=3D1, set return to userspace sig handler to relay signal=
 */
+	nommu_relay_signal(mc);
+
+	arch_examine_signal(sig, regs);
+
+	/* Is the signal layout for the signal known?
+	 * Signal data must be scrubbed to prevent information leaks.
+	 */
+	code =3D si->si_code;
+	err =3D si->si_errno;
+	if ((err =3D=3D 0) && (siginfo_layout(sig, code) =3D=3D SIL_FAULT)) {
+		struct faultinfo *fi =3D UPT_FAULTINFO(regs);
+
+		current->thread.arch.faultinfo =3D *fi;
+		force_sig_fault(sig, code, (void __user *)FAULT_ADDRESS(*fi));
+	} else {
+		pr_err("Attempted to relay unknown signal %d (si_code =3D %d) with errno=
 %d\n",
+		       sig, code, err);
+		force_sig(sig);
+	}
+}
+
+void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
+	   void *mc)
+{
+	do_IRQ(WINCH_IRQ, regs);
+}
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 53e276e81b37..67dcd88b45b1 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -40,9 +40,10 @@ static void sig_handler_common(int sig, struct siginfo *=
si, mcontext_t *mc)
 	int save_errno =3D errno;
=20
 	r.is_user =3D 0;
+	if (mc)
+		get_regs_from_mc(&r, mc);
 	if (sig =3D=3D SIGSEGV) {
 		/* For segfaults, we want the data from the sigcontext. */
-		get_regs_from_mc(&r, mc);
 		GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
 	}
=20
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_sysca=
ll_64.c
index 74d5bcc4508d..d77e69e097c1 100644
--- a/arch/x86/um/nommu/do_syscall_64.c
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -44,6 +44,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	/* set fs register to the original host one */
 	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
=20
+	/* save fp registers */
+	asm volatile("fxsaveq %0" : "=3Dm"(*(struct _xstate *)regs->regs.fp));
+
 	if (likely(syscall < NR_syscalls)) {
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
@@ -54,6 +57,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	/* handle tasks and signals at the end */
 	interrupt_end();
=20
+	/* restore fp registers */
+	asm volatile("fxrstorq %0" : : "m"((current->thread.regs.regs.fp)));
+
 	/* restore back fs register to userspace configured one */
 	os_x86_arch_prctl(0, ARCH_SET_FS,
 		      (void *)(current->thread.regs.regs.gp[FS_BASE
diff --git a/arch/x86/um/nommu/entry_64.S b/arch/x86/um/nommu/entry_64.S
index 950447dfa66b..e038bc7b53ac 100644
--- a/arch/x86/um/nommu/entry_64.S
+++ b/arch/x86/um/nommu/entry_64.S
@@ -111,3 +111,17 @@ ENTRY(userspace)
 	jmp	*%r11
=20
 END(userspace)
+
+/*
+ * this routine prepares the stack to return via host-generated
+ * signals (e.g., SEGV, FPE) via do_signal() from interrupt_end().
+ */
+ENTRY(__prep_sigreturn)
+	/*
+	 * Switch to current top of stack, so "current->" points
+	 * to the right task.
+	 */
+	movq	current_top_of_stack, %rsp
+
+	jmp	userspace
+END(__prep_sigreturn)
diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c b/arch/x86/um/nommu/os-L=
inux/mcontext.c
index c4ef877d5ea0..87fb2a35e7ff 100644
--- a/arch/x86/um/nommu/os-Linux/mcontext.c
+++ b/arch/x86/um/nommu/os-Linux/mcontext.c
@@ -6,6 +6,11 @@
 #include <sysdep/mcontext.h>
 #include <sysdep/syscalls.h>
=20
+void set_mc_return_address(mcontext_t *mc)
+{
+	mc->gregs[REG_RIP] =3D (unsigned long) __prep_sigreturn;
+}
+
 void set_mc_sigsys_hook(mcontext_t *mc)
 {
 	mc->gregs[REG_RCX] =3D mc->gregs[REG_RIP];
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysd=
ep/mcontext.h
index 9a0d6087f357..de4041b758f3 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -19,6 +19,7 @@ extern int set_stub_state(struct uml_pt_regs *regs, struc=
t stub_data *data,
=20
 #ifndef CONFIG_MMU
 extern void set_mc_sigsys_hook(mcontext_t *mc);
+extern void set_mc_return_address(mcontext_t *mc);
 #endif
=20
 #ifdef __i386__
diff --git a/arch/x86/um/shared/sysdep/ptrace.h b/arch/x86/um/shared/sysdep=
/ptrace.h
index 8f7476ff6e95..7d553d9f05be 100644
--- a/arch/x86/um/shared/sysdep/ptrace.h
+++ b/arch/x86/um/shared/sysdep/ptrace.h
@@ -65,7 +65,7 @@ struct uml_pt_regs {
 	int is_user;
=20
 	/* Dynamically sized FP registers (holds an XSTATE) */
-	unsigned long fp[];
+	unsigned long fp[] __attribute__((aligned(16)));
 };
=20
 #define EMPTY_UML_PT_REGS { }
diff --git a/arch/x86/um/shared/sysdep/syscalls_64.h b/arch/x86/um/shared/s=
ysdep/syscalls_64.h
index ffd80ee3b9dc..bd152422cdfb 100644
--- a/arch/x86/um/shared/sysdep/syscalls_64.h
+++ b/arch/x86/um/shared/sysdep/syscalls_64.h
@@ -29,6 +29,7 @@ extern syscall_handler_t sys_arch_prctl;
 extern void do_syscall_64(struct pt_regs *regs);
 extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_t =
a3,
 			      int64_t a4, int64_t a5, int64_t a6);
+extern void __prep_sigreturn(void);
 #endif
=20
 #endif
--=20
2.43.0



thanks, and have a nice day,
-- Hajime

On Wed, 02 Jul 2025 13:37:50 +0900,
Hajime Tazaki wrote:
>=20
>=20
> Hello Benjamin,
>=20
> On Tue, 01 Jul 2025 21:03:36 +0900,
> Benjamin Berg wrote:
> >=20
> > Hi Hajim,
> >=20
> > On Mon, 2025-06-30 at 10:04 +0900, Hajime Tazaki wrote:
> > >=20
> > > Hello Benjamin,
> > >=20
> > > On Sat, 28 Jun 2025 00:02:05 +0900,
> > > Benjamin Berg wrote:
> > > >=20
> > > > Hi,
> > > >=20
> > > > On Fri, 2025-06-27 at 22:50 +0900, Hajime Tazaki wrote:
> > > > > thanks for the comment on the complicated part of the kernel (sig=
nal).
> > > >=20
> > > > This stuff isn't simple.
> > > >=20
> > > > Actually, I am starting to think that the current MMU UML kernel al=
so
> > > > needs a redesign with regard to signal handling and stack use in th=
at
> > > > case. My current impression is that the design right now only permi=
ts
> > > > voluntarily scheduling. More specifically, scheduling in response t=
o an
> > > > interrupt is impossible.
> > > >=20
> > > > I suppose that works fine, but it also does not seem quite right.
> > >=20
> > > thanks for the info.=C2=A0 it's very useful to understand what's goin=
g on.
> > >=20
> > > (snip)
> > >=20
> > > > > > > +void set_mc_userspace_relay_signal(mcontext_t *mc)
> > > > > > > +{
> > > > > > > + mc->gregs[REG_RIP] =3D (unsigned long) __userspace_relay_si=
gnal;
> > > > > > > +}
> > > > > > > +
> > > > >=20
> > > > > This is a bit scary code which I tried to handle when SIGSEGV is
> > > > > raised by host for a userspace program running on UML (nommu).
> > > > >=20
> > > > > # and I should remember my XXX tag is important to fix....
> > > > >=20
> > > > > let me try to explain what happens and what I tried to solve.
> > > > >=20
> > > > > The SEGV signal from userspace program is delivered to userspace =
but
> > > > > if we don't fix the code raising the signal, after (um) rt_sigret=
urn,
> > > > > it will restart from $rip and raise SIGSEGV again.
> > > > >=20
> > > > > # so, yes, we've already relied on host and um's rt_sigreturn to
> > > > > =C2=A0 restore various things.
> > > > >=20
> > > > > when a uml userspace crashes with SIGSEGV,
> > > > >=20
> > > > > - host kernel raises SIGSEGV (at original $rip)
> > > > > - caught by uml process (hard_handler)
> > > > > - raise a signal to uml userspace process (segv_handler)
> > > > > - handler ends (hard_handler)
> > > > > - (host) run restorer (rt_sigreturn, registered by (libc)sigactio=
n,
> > > > > =C2=A0 not (host) rt_sigaction)
> > > > > - return back to the original $rip
> > > > > - (back to top)
> > > > >=20
> > > > > this is the case where endless loop is happened.
> > > > > um's sa_handler isn't called as rt_sigreturn (um) isn't called.
> > > > > and the my original attempt (__userspace_relay_signal) is what I =
tried.
> > > > >=20
> > > > > I agree that it is lazy to call a dummy syscall (indeed, getpid).
> > > > > I'm trying to introduce another routine to jump into userspace and
> > > > > call (um) rt_sigreturn after (host) rt_sigreturn.
> > > > >=20
> > > > > > And this is really confusing me. The way I am reading it, the c=
ode
> > > > > > tries to do:
> > > > > > =C2=A0=C2=A0 1. Rewrite RIP to jump to __userspace_relay_signal
> > > > > > =C2=A0=C2=A0 2. Trigger a getpid syscall (to do "nothing"?)
> > > > > > =C2=A0=C2=A0 3. Let do_syscall_64 fire the signal from interrup=
t_end
> > > > >=20
> > > > > correct.
> > > > >=20
> > > > > > However, then that really confuses me, because:
> > > > > > =C2=A0* If I am reading it correctly, then this approach will d=
estroy the
> > > > > > =C2=A0=C2=A0 contents of various registers (RIP, RAX and likely=
 more)
> > > > > > =C2=A0* This would result in an incorrect mcontext in the users=
pace signal
> > > > > > =C2=A0=C2=A0 handler (which could be relevant if userspace is i=
nspecting it)
> > > > > > =C2=A0* However, worst, rt_sigreturn will eventually jump back
> > > > > > =C2=A0=C2=A0 into__userspace_relay_signal, which has nothing to=
 return to.
> > > > > > =C2=A0* Also, relay_signal doesn't use this? What happens for a=
 SIGFPE, how
> > > > > > =C2=A0=C2=A0 is userspace interrupted immediately in that case?
> > > > >=20
> > > > > relay_signal shares the same goal of this, indeed.
> > > > > but the issue with `mc->gregs[REG_RIP]` (endless signals) still e=
xists
> > > > > I guess.
> > > >=20
> > > > Well, endless signals only exist as long as you exit to the same
> > > > location. My suggestion was to read the user state from the mcontext
> > > > (as SECCOMP mode does it) and executing the signal right away, i.e.:
> > >=20
> > > thanks too;=C2=A0 below is my understanding.
> > >=20
> > > > =C2=A0* Fetch the current registers from the mcontext
> > >=20
> > > I guess this is already done in sig_handler_common().
> >=20
> > Well, not really?
> >=20
> > It does seem to fetch the general purpose registers. But the code
> > pretty much assumes we will return to the same location and only stores
> > them on the stack for the signal handler itself. Also, remember that it
> > might be userspace or kernel space in your case. The kernel task
> > registers are in "switch_buf" while the userspace registers are in
> > "regs" of "struct task_struct" (effectively "struct uml_pt_regs").
>=20
> indeed, the handler returns to the same location.
> here is what the current patchset does for the signal handling.
>=20
> # sorry i might be writing same things several times, but I hope
>   this will help to understand/discuss what it should be.
>=20
> receive signal (from host)
> - > call host sa_handler (hard_handler)
>  - > sig_handler_common =3D> get_regs_from_mc (fetch host mcontext to um)
>  - > set TIF_SIGPENDING (um kernel)
>  - > set host mcontext[RIP] to __userspace_relay_signal
> (host sa_handler ends)
> - call host sa_restorer =3D> return to mcontext[RIP]
>  - > call __userspace_relay_signal from mcontext[RIP]
>  - > call interrupt_end()
>  - > do_signal =3D> handle_signal =3D> setup_signal_stack_si
>      (because TIF_SIGPENDING is on above)
>  - > call userspace sa_handler
>  - > call userspace sa_restorer
>=20
> instead of set mcontext[RIP] to userspace sa_handler, it uses
> __userspace_relay_signal, which configures stack and mcontext (via
> interrupt_end, setup_signal_stack_si, etc) and call userspace
> sa_handler/restorer after that.
>=20
> in this way, programs runs userspace sa_handler not in the host
> sa_handler context.  I guess this means we don't have to configure
> host register/mcontext with the userspace one ?
>=20
> I agree that the current __userspace_relay_signal can be shrunk not
> to call __kernel_vsyscall and focus on interrupt_end and stack
> preparation.
>=20
> > > > =C2=A0* Push the signal context onto the userspace stack
> > >=20
> > > (guess) this is already done on handle_signal() =3D> setup_signal_sta=
ck_si().
> > >=20
> > > > =C2=A0* Modify the host mcontext to set registers for the signal ha=
ndler
> > >=20
> > > this is something which I'm not well understanding.
> > > - do you mean the host handler when you say "for the signal handler" ?
> > > =C2=A0 or the userspace handler ?
> >=20
> > Both in a way ;-)
> >=20
> > I mean modify the registers in the host mcontext so that the UML
> > userspace will continue executing inside its signal handler.
> >
> > > - if former (the host one), maybe mcontext is already there so, it
> > > =C2=A0 might not be the one you mentioned.
> > > - if the latter, how the original handler (the host one,
> > > =C2=A0 hard_handler()) works ? even if we can call userspace handler
> > > =C2=A0 instead of the host one, we need to call the host handler (and
> > > =C2=A0 restorer).=C2=A0 do we call both ?
> > > - and by "to set registers", what register do you mean ? for the
> > > =C2=A0 registers inspected by userspace signal handler ?=C2=A0 but if=
 you set a
> > > =C2=A0 register, for instance RIP, as the fault location to the host
> > > =C2=A0 register, it will return to RIP after handler and restart the =
fault
> > > =C2=A0 again ?
> >=20
> > I am confused, why would the fault handler be restarted? If you modify
> > RIP, then the host kernel will not return to the faulting location. You
> > were using that already to jump into __userspace_relay_signal. All I am
> > arguing that instead of jumping to __userspace_relay_signal you can
> > prepare everything and directly jump into the users signal handler.
>=20
> what I meant in that example is; set host mcontext[RIP] to the fault
> location, as a userspace information, which will lead to the fault
> again.  But this doesn't change RIP before and after so, I guess this
> isn't a good example..
> Sorry for the confusion.
>=20
> > > > =C2=A0* Jump back to userspace by doing a "return"
> > >=20
> > > this is still also unclear to me.
> > >=20
> > > it would be very helpful if you point the location of the code (at
> > > uml/next tree) on how SECCOMP mode does.=C2=A0 I'm also looking at but
> > > really hard to map what you described and the code (sorry).
> >=20
> > "stub_signal_interrupt" simply returns, which means it jumps into the
> > restorer "stub_signal_restorer" which does the rt_sigreturn syscall.
> > This means the host kernel restores the userspace state from the
> > mcontext. As the mcontext resides in shared memory, the UML kernel can
> > update it to specify where the process should continue running (thread
> > switching, signals, syscall return value, =E2=80=A6).
>=20
> thanks !
>=20
> so, stub_signal_interrupt runs on a different host process.
> nommu mode tries to reuse existing host sa_handler (hard_handler) to
> do the job (handle SEGV etc).
>=20
> If there are something missing on hard_handler and co on nommmu mode
> for what userspace_tramp does on seccomp mode, I've been trying to
> update it.
>=20
> -- Hajime
>=20
> >=20
> > Benjamin
> >=20
> > > all of above runs within hard_handler() in nommu mode on SIGSEGV.
> > > my best guess is this is different from what ptrace/seccomp do.
> > >=20
> > > > Said differently, I really prefer deferring as much logic as possib=
le
> > > > to the host. This is both safer and easier to understand. Plus, it =
also
> > > > has the advantage of making it simpler to port UML to other
> > > > architectures.
> > >=20
> > > okay.
> > >=20
> > > >=20
> > > > > > Honestly, I really think we should take a step back and swap the
> > > > > > current syscall entry/exit code. That would likely also simplify
> > > > > > floating point register handling, which I think is currently
> > > > > > insufficient do deal with the odd special cases caused by diffe=
rent
> > > > > > x86_64 hardware extensions.
> > > > > >=20
> > > > > > Basically, I think nommu mode should use the same general appro=
ach as
> > > > > > the current SECCOMP mode. Which is to use rt_sigreturn to jump =
into
> > > > > > userspace and let the host kernel deal with the ugly details of=
 how to
> > > > > > do that.
> > > > >=20
> > > > > I looked at how MMU mode (ptrace/seccomp) does handle this case.
> > > > >=20
> > > > > In nommu mode, we don't have external process to catch signals so=
, the
> > > > > nommu mode uses hard_handler() to catch SEGV/FPE of userspace
> > > > > programs.=C2=A0 While mmu mode calls segv_handler not in a contex=
t of
> > > > > signal handler.
> > > > >=20
> > > > > # correct me if I'm wrong.
> > > > >=20
> > > > > thus, mmu mode doesn't have this situation.
> > > >=20
> > > > Yes, it does not have this specific issue. But see the top of the m=
ail
> > > > for other issues that are somewhat related.
> > > >=20
> > > > > I'm attempting various ways; calling um's rt_sigreturn instead of
> > > > > host's one, which doesn't work as host restore procedures (unbloc=
king
> > > > > masked signals, restoring register states, etc) aren't called.
> > > > >=20
> > > > > I'll update here if I found a good direction, but would be great =
if
> > > > > you see how it should be handled.
> > > >=20
> > > > Can we please discuss possible solutions? We can figure out the det=
ails
> > > > once it is clear how the interaction with the host should work.
> > >=20
> > > I was wishing to update to you that I'm working on it.=C2=A0 So, your
> > > comments are always helpful to me.=C2=A0 Thanks.
> > >=20
> > > -- Hajime
> > >=20
> > > > I still think that the idea of using the kernel task stack as the
> > > > signal stack is really elegant. Actually, doing that in normal UML =
may
> > > > be how we can fix the issues mentioned at the top of my mail. And f=
or
> > > > nommu, we can also use the host mcontext to jump back into userspace
> > > > using a simple "return".
> > > >=20
> > > > Conceptually it seems so simple.
> > > >=20
> > > > Benjamin
> > > >=20
> > > >=20
> > > > >=20
> > > > > -- Hajime
> > > > >=20
> > > > > > I believe that this requires a second "userspace" sigaltstack in
> > > > > > addition to the current "IRQ" sigaltstack. Then switching in be=
tween
> > > > > > the two (note that the "userspace" one is also used for IRQs if=
 those
> > > > > > happen while userspace is executing).
> > > > > >=20
> > > > > > So, in principle I would think something like:
> > > > > > =C2=A0* to jump into userspace, you would:
> > > > > > =C2=A0=C2=A0=C2=A0 - block all signals
> > > > > > =C2=A0=C2=A0=C2=A0 - set "userspace" sigaltstack
> > > > > > =C2=A0=C2=A0=C2=A0 - setup mcontext for rt_sigreturn
> > > > > > =C2=A0=C2=A0=C2=A0 - setup RSP for rt_sigreturn
> > > > > > =C2=A0=C2=A0=C2=A0 - call rt_sigreturn syscall
> > > > > > =C2=A0* all signal handlers can (except pure IRQs):
> > > > > > =C2=A0=C2=A0=C2=A0 - check on which stack they are
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> easy to detect whether we are=
 in kernel mode
> > > > > > =C2=A0=C2=A0=C2=A0 - for IRQs one can probably handle them dire=
ctly (and return)
> > > > > > =C2=A0=C2=A0=C2=A0 - in user mode:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + store mcontext location =
and information needed for rt_sigreturn
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + jump back into kernel ta=
sk stack
> > > > > > =C2=A0* kernel task handler to continue would:
> > > > > > =C2=A0=C2=A0=C2=A0 - set sigaltstack to IRQ stack
> > > > > > =C2=A0=C2=A0=C2=A0 - fetch register from mcontext
> > > > > > =C2=A0=C2=A0=C2=A0 - unblock all signals
> > > > > > =C2=A0=C2=A0=C2=A0 - handle syscall/signal in whatever way need=
ed
> > > > > >=20
> > > > > > Now that I wrote about it, I am thinking that it might be possi=
ble to
> > > > > > just use the kernel task stack for the signal stack. One would =
probably
> > > > > > need to increase the kernel stack size a bit, but it would also=
 mean
> > > > > > that no special code is needed for "rt_sigreturn" handling. The=
 rest
> > > > > > would remain the same.
> > > > > >=20
> > > > > > Thoughts?
> > > > > >=20
> > > > > > Benjamin
> > > > > >=20
> > > > > > > [SNIP]
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20
> >=20

