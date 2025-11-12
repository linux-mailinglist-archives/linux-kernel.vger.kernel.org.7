Return-Path: <linux-kernel+bounces-896539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B25F3C509D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75D2D4E5F46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCC52D839C;
	Wed, 12 Nov 2025 05:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQYU7e/J"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454211514DC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762925245; cv=none; b=FJxa3nzTOnLOSW9wMFp81gymwsZy0LHflG0TFfKh3opc2KGx48P+qVYElA158bbSTL6cuKf+t+zP7vdEHYyEVFCnNPWQtU5anygPXUWmKdmqev5IEjKKL4PpkNEF0loVOxuM5z/79vJYJIvP+dt1WGpoc1Ugdhci7qarv9zjjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762925245; c=relaxed/simple;
	bh=CwgHrpQttJ9JEif/wCfZWfWACrIIISVZ0PQBMV+bREA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvOrXdmc2hHjp5BPbZDWQnwR6YbBi8y9i2bKbwpGT8SQXiQY8INkN9sNZqW28B4wZS68PD/dwVX8I04ngl3DKJ0z2MExsMoiPrHruHz3EDYKqQAiKmrDEFAMgSx4L9LDwR51FX/14Bxy3z4xR1/Ao3M3vryOLRoCUkiXeWII5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQYU7e/J; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b72134a5125so70894966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762925242; x=1763530042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCo98k5zVGcrJMaFgGPWpScUCs9iIxNEITQOsVqAKIo=;
        b=aQYU7e/Jj+pjc7T9IOjCFn7lDzn3Dgs9gou/855HzmcAChrQcOB1U/amdNVscpXywS
         8tw8YurZh62DxviWXJ+158ESkoX9eowl/kCYgmQDrQ5pHY1j346+BmijVErQ9Onw0HCL
         XQpzt5QMZ5fN8oUXcxdE17IVm5JIKk9VA3boAn08vNkvMNV8F8av+rQQJZjNB39O0YJY
         Ix8blMjV5FUdDCuOmDx5iqek6PPhBAxZt7/jJhCHlHLNnBv+We3/ub1v1k48HNNBbhh8
         LlwLHtUuCpp2DDc0M0uiRDu5yQak9ri79qId8bqQBbpcmCXj+0bAjDUopBOr8yjNWPjx
         ME2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762925242; x=1763530042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCo98k5zVGcrJMaFgGPWpScUCs9iIxNEITQOsVqAKIo=;
        b=Z9ZrEkCLufA5mNs7rc2gmUqEi3ELVYQGcAO56pO+OWDwhficOULByVlsMU5GTiGFr7
         vWQw1ocFS6KS4+imjyTPWkg2LL1MOIws+wBiKXk/Oao2XMpXkyWFumg6f/TQhweup5XS
         JZjrs5+6Wd6ZPkAIrmXstJgmy0/fQU/hJfMZySwnrBu0dh6REKWgsxS3ZmhSAkmmrWau
         aOrjhabaPGJk845m9nTj0MIw7EzPbiDl+ecVrLC0nEaC0AdWOCYnamYMSPw+KbaAnt1a
         F3Bik32J9XUoofZHwuGs7U5xe9X7vY4AR0u+gICCpAI8lWqCF3rS5+HniAZENITKiyGs
         o1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXzI1fdsGmQs597ZKuYSWLGmy6aVvvx7RCE/T8TUN5p49BukQBEO+TUrUNQoGBhYOkzE5GwFu8lq2x2Dtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYChbuvSSVXf+WvKtkHlyRA81Xpn5lf2PVzvhZWcbz1Si4KYF
	7fsFcwfb1I68MSwf0aBWetDymTp+IS0nNbEVeW/a4/Zh+gH6tgL1tAFj/wTVX9zesCM8dquD6ty
	M86JH+sZsl5bUdtaTVmQCVLKxJ6ED7Gw=
X-Gm-Gg: ASbGnct/xq4g6262EipEvbKLyDDORMgcK/DX7gJGo/bqTcrvS6dCybHDsnflNvF+6+d
	/y41JKK98A0duY1nzqHsMinoGLJFSTLFc4nqeX82d1dK6aMJiaBdj0whwzCpv6pTYqRc+Ze8POD
	zzGpgY9HcjBoYs4NkhQbnCD1ljH8jOeVUD15EwcYHplE6r57Z3VyqGGthbfYhud/XBc5pF9/lIX
	IW+OAcWLec38tzbTmKC3BgoDMa5v0iFd1Fr2QKFS+GQAqWyat/0c23Qqso/
X-Google-Smtp-Source: AGHT+IFTh1AedixfwUaVcieQDb69lpIZKCzgYFFppt1bkt2eJhfVvzZzY1/8j+gyAXu2Ck/cIyuG9vJylgn49QZX6mk=
X-Received: by 2002:a17:907:6d0d:b0:b70:b5b9:1f82 with SMTP id
 a640c23a62f3a-b7331a6ef31mr189013366b.31.1762925241289; Tue, 11 Nov 2025
 21:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015114952.4014352-1-leonylgao@gmail.com> <20251110183854.48b33b50@gandalf.local.home>
 <20251111081314.j8CFfAD6@linutronix.de> <20251111102739.2a0a64cf@gandalf.local.home>
In-Reply-To: <20251111102739.2a0a64cf@gandalf.local.home>
From: Yongliang Gao <leonylgao@gmail.com>
Date: Wed, 12 Nov 2025 13:27:10 +0800
X-Gm-Features: AWmQ_bmnu2v8TbyZK6CGcTDW02AMhsuIyjYsDXPPjpZO667gKjMESzrWwoQr1Bw
Message-ID: <CAJxhyqDCFRT_fPWHb67x-PUu+Om91UrbrQEifcF7m+dkZ35dqA@mail.gmail.com>
Subject: Re: [PATCH] trace/pid_list: optimize pid_list->lock contention
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Yongliang Gao <leonylgao@tencent.com>, 
	Huang Cun <cunhuang@tencent.com>, frankjpliu@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Thank you for your detailed response and the proposed RCU-like approach.

I've looked into using a regular seqlock instead of the current
implementation, but as you pointed out, the write side is indeed a
critical path. More importantly, I found that even with seqlock, the
write_seqlock() function internally uses spin_lock() which on
PREEMPT_RT gets converted to an mutex. This would cause the same
issues we're trying to avoid - potential sleep in atomic contexts.

bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pi=
d)
{
    union upper_chunk *upper_chunk;
    union lower_chunk *lower_chunk;
    unsigned int seq;
    unsigned long flags;
    unsigned int upper1;
    unsigned int upper2;
    unsigned int lower;
    bool ret =3D false;

    if (!pid_list)
        return false;

    if (pid_split(pid, &upper1, &upper2, &lower) < 0)
        return false;

    do {
        local_irq_save(flags);
        seq =3D read_seqbegin(&pid_list->lock);
        ret =3D false;
        upper_chunk =3D pid_list->upper[upper1];
        if (upper_chunk) {
            lower_chunk =3D upper_chunk->data[upper2];
            if (lower_chunk)
                ret =3D test_bit(lower, lower_chunk->data);
        }
        local_irq_restore(flags);
    } while (read_seqretry(&pid_list->lock, seq));

    return ret;
}

 BUG: sleeping function called from invalid context at
kernel/locking/spinlock_rt.c:48
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 192, name: bash
 preempt_count: 1, expected: 0
 RCU nest depth: 0, expected: 0
 CPU: 3 UID: 0 PID: 192 Comm: bash Not tainted 6.18.0-rc5+ #84 PREEMPT_{RT,=
LAZY}
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 Call Trace:
  <TASK>
  dump_stack_lvl+0x4f/0x70
  __might_resched+0x113/0x160
  rt_spin_lock+0x41/0x130
  trace_pid_list_set+0x52/0x150
  ftrace_pid_follow_sched_process_fork+0x19/0x30
  kernel_clone+0x1b8/0x3e0
  __do_sys_clone+0x65/0x90
  do_syscall_64+0x48/0xa60
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Your proposed solution using atomic counters and memory barriers
should provide the lock-free read path we need while maintaining code
correctness. However, to achieve this correctly requires careful
consideration of all memory ordering scenarios, and I'm concerned
about introducing subtle bugs given the complexity.

Would you be willing to submit a patch implementing your approach?

On Tue, Nov 11, 2025 at 11:27=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 11 Nov 2025 09:13:14 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>
> > Nope, no read-write lock that can be used in atomic sections. Well,
> > there is RCU.
>
> Well, it can't simply be replaced by RCU as the write side is also a
> critical path. It happens when new tasks are spawned.
>
> Now we could possibly do some RCU like magic, and remove the lock in the
> read, but it would need some care with the writes.
>
> Something like this (untested):
>
> bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int =
pid)
> {
>         union upper_chunk *upper_chunk;
>         union lower_chunk *lower_chunk;
>         unsigned long flags;
>         unsigned int upper1;
>         unsigned int upper2;
>         unsigned int lower;
>         bool ret =3D false;
>
>         if (!pid_list)
>                 return false;
>
>         if (pid_split(pid, &upper1, &upper2, &lower) < 0)
>                 return false;
>
>         upper_chunk =3D READ_ONCE(pid_list->upper[upper1]);
>         if (upper_chunk) {
>                 lower_chunk =3D READ_ONCE(upper_chunk->data[upper2]);
>                 if (lower_chunk)
>                         ret =3D test_bit(lower, lower_chunk->data);
>         }
>
>         return ret;
> }
>
> Now when all the bits of a chunk is cleared, it goes to a free-list. And
> when a new chunk is needed, it acquires it from that free-list. We need t=
o
> make sure that the chunk acquired in the read hasn't gone through the
> free-list.
>
> Now we could have an atomic counter in the pid_list and make this more of=
 a
> seqcount? That is, have the counter updated when a chunk goes to the free
> list and also when it is taken from the free list. We could then make thi=
s:
>
>  again:
>         counter =3D atomic_read(&pid_list->counter);
>         smp_rmb();
>         upper_chunk =3D READ_ONCE(pid_list->upper[upper1]);
>         if (upper_chunk) {
>                 lower_chunk =3D READ_ONCE(upper_chunk->data[upper2]);
>                 if (lower_chunk) {
>                         ret =3D test_bit(lower, lower_chunk->data);
>                         smp_rmb();
>                         if (unlikely(counter !=3D atomic_read(&pid_list->=
counter))) {
>                                 ret =3D false;
>                                 goto again;
>                         }
>                 }
>         }
>
>
> And in the set we need:
>
>         upper_chunk =3D pid_list->upper[upper1];
>         if (!upper_chunk) {
>                 upper_chunk =3D get_upper_chunk(pid_list);
>                 if (!upper_chunk) {
>                         ret =3D -ENOMEM;
>                         goto out;
>                 }
>                 atomic_inc(&pid_list->counter);
>                 smp_wmb();
>                 WRITE_ONCE(pid_list->upper[upper1], upper_chunk);
>         }
>         lower_chunk =3D upper_chunk->data[upper2];
>         if (!lower_chunk) {
>                 lower_chunk =3D get_lower_chunk(pid_list);
>                 if (!lower_chunk) {
>                         ret =3D -ENOMEM;
>                         goto out;
>                 }
>                 atomic_inc(&pid_list->counter);
>                 smp_wmb();
>                 WRITE_ONCE(upper_chunk->data[upper2], lower_chunk);
>         }
>
> and in the clear:
>
>         if (find_first_bit(lower_chunk->data, LOWER_MAX) >=3D LOWER_MAX) =
{
>                 put_lower_chunk(pid_list, lower_chunk);
>                 WRITE_ONCE(upper_chunk->data[upper2], NULL);
>                 smp_wmb();
>                 atomic_inc(&pid_list->counter);
>                 if (upper_empty(upper_chunk)) {
>                         put_upper_chunk(pid_list, upper_chunk);
>                         WRITE_ONCE(pid_list->upper[upper1], NULL);
>                         smp_wmb();
>                         atomic_inc(&pid_list->counter);
>                 }
>         }
>
> That is, the counter gets updated after setting the chunk to NULL and
> before assigning it a new value. And reading it, the counter is read befo=
re
> looking at any of the chunks, and tested after getting the result. If the
> value is the same, then the chunks are for the correct PID and haven't
> swapped in a free/alloc swap where it's looking at a chunk for a differen=
t
> PID.
>
> This would allow for the read to not take any locks.
>
> -- Steve

