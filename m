Return-Path: <linux-kernel+bounces-823048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1413B85638
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E2E587D31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3430DD0A;
	Thu, 18 Sep 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYfqwgXl"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB730CB49
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207413; cv=none; b=QxRnpi/jdArb1VX/R0MVJbBK0h7fIAQa5dnm363r6o2Ho2X3XPMSk+Rl243YEoHhASuDy57UNPJsTcHvTg2jVArNaobjW50EIo0/1BpYllsmsQSRvRFl6bAI25VAIcbDDPJXj1CQOvtCqPR+smlayjLtlwzOvh4BPXbZ2eI+U5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207413; c=relaxed/simple;
	bh=o1BapFUSqZpjew5mFLrR0KAkmbOkNk0w2dJkjCsfdk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g92ZI0lFiyPIJBrI+YEGTRLLmZccsKKvEVEOmvlKQe8nccp1KClAfYchk0aSRGoCTqBhHRJ0Q+rr3DxGY684Vbu2yj/ASmz6uUNliPRq8HxjGTfA6oB10SauVeecDhxs+je2NkCbex5BPeBauAmJ0GqGKsE3sxeFDT7GGZqu/s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYfqwgXl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so1074969a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758207410; x=1758812210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABJOvv+RgK0j3lou6GVGSj3pSuz+N8LpjujEU/KOwOA=;
        b=jYfqwgXlp8wAi7XvrckKrjAaMpTsFog3R98AyDrTFOXIRWlA3MswQzYj9gy0oHvQC+
         qS5hwuyD6+oQvV5jbWmgPVkSyesDcajmLHeHkCaezjhXbGYtLDwdS+Bs2HpntTcxNAnr
         j+GOUYY+nIIoYtoueiehkTdeOd1JkXnuL/U+Nwn5Y0ZP5yjPmIfsB74eWtu4ermVxAyO
         RqsvfujgZ6z0c43boeFaxCKISPOEv8iWjgQKTsoXbcL2Pog3KucCSW12oJ4Bs+A3p8S8
         VW//e8WXiQjyJibxNG6R7ozJcpcjm2nyog+Uz8LtNkywZmokJDtCwZD5G1RpivUgHHb+
         /V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207410; x=1758812210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABJOvv+RgK0j3lou6GVGSj3pSuz+N8LpjujEU/KOwOA=;
        b=KMNXgDwSzH0XgQsHUMEFCAoumKIEFR3Yy2uzICf/15/BOMtpi+O+kac1xvDrSyMH0I
         JxgUyEMGoZPsWuRI+HLnqc6cLMRWsXXTPrG7e0gAleoZFNuKBUyc4sVcKYMjkgT/V36J
         bZUtyaBsPuITQVf1s8TLG3aH0sM3jFevM7viA7ePyfsqDY5JM56/w9LF2vAPAimnk9eM
         m+7+/URDmpx+2gLE6683CrtA9yfYCDJ5C00G2+ozFgn1ziyw/+uijbHf83dmVF9Lpxgv
         Y4/xHg6kjKXOFGf6PYLIb4jr7K80CshgCmmqvstO9s3HMycIVmPGg6AoCeHfpDB2URlR
         D4Eg==
X-Gm-Message-State: AOJu0Yx8e/DlJxQjwVCEMrMKe4PV7wVd/aVbHhjgIPiOTEWyVct1H5kN
	/FNMQwzIY1YzIO3MSm1XK3KOGKJ/T3gl3m1JLeFcbzQcc1eV1prdPOGdMd+NxmMdZ9MwUj3Iroi
	Vcoylpw==
X-Google-Smtp-Source: AGHT+IE9d7XIFxtEu83Yt8vYjU6Cee5gJ6k7Ag6ASJzvt9thxibUpZ/ZiTragMTnJZJDDogu212Ih+/vyuo=
X-Received: from pjbsw12.prod.google.com ([2002:a17:90b:2c8c:b0:32f:46d:993b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58c6:b0:330:604a:1009
 with SMTP id 98e67ed59e1d1-330604a119fmr4137301a91.23.1758207410517; Thu, 18
 Sep 2025 07:56:50 -0700 (PDT)
Date: Thu, 18 Sep 2025 07:56:48 -0700
In-Reply-To: <68cb6475.050a0220.3c6139.0fab.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <68caec73.050a0220.2ff435.0595.GAE@google.com> <68cb6475.050a0220.3c6139.0fab.GAE@google.com>
Message-ID: <aMwdsFGkM-tMjHwc@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in __vhost_task_wake
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+a1a3cefd6148c781117c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="us-ascii"

+Michael

Michael, this is the VHOST_TASK_FLAGS_KILLED WARN that was added[*] to detect
violations similar to KVM.

	/*
	 * Checking VHOST_TASK_FLAGS_KILLED can race with signal delivery, but
	 * a race can only result in false negatives and this is just a sanity
	 * check, i.e. if KILLED is set, the caller is buggy no matter what.
	 */
	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)))
		return;

I haven't been able to repro the splat, but after much staring I think the issue
is that vhost_task_fn() marks the task KILLED before invoking handle_sigkill().
If vhost_worker_flush() already holds worker->mutex, before vhost_worker_killed()
runs, then it could wake a (not yet dead) task that has KILLED set.

Assuming waiting to set KILLED until after handle_sigkill() resolves the issue
(fingers crossed), the two options I see would be to apply the below as fixup,
or simply drop the sanity check for the 6.17 and add it back in 6.18 in conjunction
with the below (again, assuming it actually resolves the issue).

[*] https://lore.kernel.org/all/20250827194107.4142164-2-seanjc@google.com

On Wed, Sep 17, 2025, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    ae2d20002576 Add linux-next specific files for 20250917
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11678f62580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d737cfaddae0058c
> dashboard link: https://syzkaller.appspot.com/bug?extid=a1a3cefd6148c781117c
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1790ef62580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10242534580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/96197382e3c0/disk-ae2d2000.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/55a8a6ba3307/vmlinux-ae2d2000.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c1b4ed5d6e2c/bzImage-ae2d2000.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a1a3cefd6148c781117c@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: kernel/vhost_task.c:97 at __vhost_task_wake+0xbb/0xd0 kernel/vhost_task.c:97, CPU#0: syz.0.174/6507
> Modules linked in:
> CPU: 0 UID: 0 PID: 6507 Comm: syz.0.174 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> RIP: 0010:__vhost_task_wake+0xbb/0xd0 kernel/vhost_task.c:97
> Code: 38 00 74 08 48 89 df e8 93 81 95 00 48 8b 3b 5b 41 5e 41 5f e9 a6 45 01 00 e8 31 ef 30 00 90 0f 0b 90 eb 8b e8 26 ef 30 00 90 <0f> 0b 90 5b 41 5e 41 5f e9 18 c7 ff 09 cc 0f 1f 80 00 00 00 00 90
> RSP: 0018:ffffc90003b7f680 EFLAGS: 00010293
> RAX: ffffffff818f2d7a RBX: ffff888033c7c400 RCX: ffff88802bc85ac0
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> RBP: ffffc90003b7f750 R08: ffff888033c7c477 R09: 1ffff1100678f88e
> R10: dffffc0000000000 R11: ffffed100678f88f R12: 1ffff9200076fed8
> R13: dffffc0000000000 R14: 0000000000000002 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff88812579c000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9942aa0f98 CR3: 0000000027bfc000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  vhost_worker_queue+0x194/0x260 drivers/vhost/vhost.c:253
>  __vhost_worker_flush+0x134/0x1e0 drivers/vhost/vhost.c:290
>  vhost_worker_flush drivers/vhost/vhost.c:303 [inline]
>  vhost_dev_flush+0xb2/0x130 drivers/vhost/vhost.c:313
>  vhost_vsock_flush drivers/vhost/vsock.c:698 [inline]
>  vhost_vsock_dev_release+0x1fb/0x3f0 drivers/vhost/vsock.c:750
>  __fput+0x44c/0xa70 fs/file_table.c:468
>  task_work_run+0x1d4/0x260 kernel/task_work.c:227
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0x6b5/0x2300 kernel/exit.c:966
>  do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
>  get_signal+0x1285/0x1340 kernel/signal.c:3034
>  arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop+0x72/0x130 kernel/entry/common.c:40
>  exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>  do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9941b8eba9
> Code: Unable to access opcode bytes at 0x7f9941b8eb7f.
> RSP: 002b:00007f9942aa10e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00007f9941dd5fa8 RCX: 00007f9941b8eba9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f9941dd5fa8
> RBP: 00007f9941dd5fa0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f9941dd6038 R14: 00007ffd2989c130 R15: 00007ffd2989c218
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 01bf7b0e2c5b..6cb3b8b26768 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -58,9 +58,15 @@ static int vhost_task_fn(void *data)
         * new work and flushed.
         */
        if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
-               set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
                if (vtsk->handle_sigkill)
                        vtsk->handle_sigkill(vtsk->data);
+
+               /*
+                * Mark the task KILLED *after* giving the owner the chance to
+                * handle SIGKILL to avoid false positives on the sanity check
+                * in __vhost_task_wake().
+                */
+               set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
        }
        mutex_unlock(&vtsk->exit_mutex);
        complete(&vtsk->exited);


