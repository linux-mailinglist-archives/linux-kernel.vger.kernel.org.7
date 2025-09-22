Return-Path: <linux-kernel+bounces-827945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C2EB9381B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D663AFABF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0169C255222;
	Mon, 22 Sep 2025 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mJW7FEQn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CC3175D53
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581302; cv=none; b=RytKDADP0qQLvYj5CxdQvSzyTIGNrqmbxoqntlgPggu8r4S70XdGfz6m540Z/2CRB+m1hvVFjTbCoKJNrR7X6WDRFddR4otnHR8LF3JpBnLcIkUhzRTtOe0kYVvTIQ0X3D46Q5WwGg21qqzY8qi6MCLFqxd4Jg1dw8tCGYeQa+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581302; c=relaxed/simple;
	bh=2I9P8Kp4M26PyrETkJwjLCt5NM3zJnoq9NweaGKhtDE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XukgKuedYzzVSR1tRBPs5V7pmkvDCpU30eIe1hcRh8GjXYfCYz2SaqAYPvtyTggnr06NECmVQ2KawVtmiBtdS2Qssx8Pt/rlOaPwfO3uC9DsdkwdYu42LJnoooOJ9mLC6H65dbJh+MmDXgw4EpgV6Q16y1Q8GNbFQgjL5IKCbj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mJW7FEQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A8EC4CEF0;
	Mon, 22 Sep 2025 22:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758581300;
	bh=2I9P8Kp4M26PyrETkJwjLCt5NM3zJnoq9NweaGKhtDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mJW7FEQnOk8vfT98W6Wu/PSWCrHOwm6UoUHORW4s7M7Ceii4O0g6MyoihBzJQTkWd
	 ATNujRZpAZGZzH+usk2KD6XLJNvd9gtnjmIpSZ1kkkk/gJq75mqyHzRadOvsw4lAuj
	 XrYT7cs5N05etrbN80zhh78V5vO5IdHIykIQRiI0=
Date: Mon, 22 Sep 2025 15:48:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Oleg Nesterov
 <oleg@redhat.com>
Subject: Re: [PATCH] kernel: Prevent prctl(PR_SET_PDEATHSIG) from racing
 with parent process exit
Message-Id: <20250922154819.c3049158ca006e1561ff5dcb@linux-foundation.org>
In-Reply-To: <ef4878fe-3edf-4bd0-bb33-116ced1a4eb8@gmail.com>
References: <20250913-fix-prctl-pdeathsig-race-v1-1-44e2eb426fe9@gmail.com>
	<ef4878fe-3edf-4bd0-bb33-116ced1a4eb8@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 00:10:07 -0400 Demi Marie Obenour <demiobenour@gmail.com> wrote:

> CCing Andrew Morton as the maintainer of last resort.
> -- 

Thanks.

This code has no maintainer, as far as I know.  So the trick is to cc a
smart person who understands signals.  Hi Oleg ;)


From: Demi Marie Obenour <demiobenour@gmail.com>
Subject: kernel: prevent prctl(PR_SET_PDEATHSIG) from racing with parent process exit
Date: Sat, 13 Sep 2025 18:28:49 -0400

If a process calls prctl(PR_SET_PDEATHSIG) at the same time that the
parent process exits, the child will write to me->pdeath_sig at the same
time the parent is reading it.  Since there is no synchronization, this is
a data race.

Worse, it is possible that a subsequent call to getppid() can continue to
return the previous parent process ID without the parent death signal
being delivered.  This happens in the following scenario:

parent                                                 child

forget_original_parent()                               prctl(PR_SET_PDEATHSIG, SIGKILL)
                                                         sys_prctl()
                                                           me->pdeath_sig = SIGKILL;
                                                       getppid();
  RCU_INIT_POINTER(t->real_parent, reaper);
  if (t->pdeath_signal) /* reads stale me->pdeath_sig */
           group_send_sig_info(t->pdeath_signal, ...);

And in the following:

parent                                                 child

forget_original_parent()
    RCU_INIT_POINTER(t->real_parent, reaper);
    /* also no barrier */
     if (t->pdeath_signal) /* reads stale me->pdeath_sig */
             group_send_sig_info(t->pdeath_signal, ...);

                                                       prctl(PR_SET_PDEATHSIG, SIGKILL)
                                                         sys_prctl()
                                                           me->pdeath_sig = SIGKILL;
                                                       getppid(); /* reads old ppid() */

As a result, the following pattern is racy:

	pid_t parent_pid = getpid();
	pid_t child_pid = fork();
	if (child_pid == -1) {
		/* handle error... */
		return;
	}
	if (child_pid == 0) {
		if (prctl(PR_SET_PDEATHSIG, SIGKILL) != 0) {
			/* handle error */
			_exit(126);
		}
		if (getppid() != parent_pid) {
			/* parent died already */
			raise(SIGKILL);
		}
		/* keep going in child */
	}
	/* keep going in parent */

If the parent is killed at exactly the wrong time, the child process can
(wrongly) stay running.

I didn't manage to reproduce this in my testing, but I'm pretty sure the
race is real.  KCSAN is probably the best way to spot the race.

Fix the bug by holding tasklist_lock for reading whenever pdeath_signal is
being written to.  This prevents races on me->pdeath_sig, and the locking
and unlocking of the rwlock provide the needed memory barriers.  If
prctl(PR_SET_PDEATHSIG) happens before the parent exits, the signal will
be sent.  If it happens afterwards, a subsequent getppid() will return the
new value.

Link: https://lkml.kernel.org/r/20250913-fix-prctl-pdeathsig-race-v1-1-44e2eb426fe9@gmail.com
Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/sys.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/sys.c~kernel-prevent-prctlpr_set_pdeathsig-from-racing-with-parent-process-exit
+++ a/kernel/sys.c
@@ -2533,7 +2533,17 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 			error = -EINVAL;
 			break;
 		}
+		/*
+		 * Ensure that either:
+		 *
+		 * 1. Subsequent getppid() calls reflect the parent process having died.
+		 * 2. forget_original_parent() will send the new me->pdeath_signal.
+		 *
+		 * Also prevent the read of me->pdeath_signal from being a data race.
+		 */
+		read_lock(&tasklist_lock);
 		me->pdeath_signal = arg2;
+		read_unlock(&tasklist_lock);
 		break;
 	case PR_GET_PDEATHSIG:
 		error = put_user(me->pdeath_signal, (int __user *)arg2);
_


