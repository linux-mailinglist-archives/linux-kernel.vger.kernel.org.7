Return-Path: <linux-kernel+bounces-823069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DD1B85716
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80CC1C845F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161C1B424F;
	Thu, 18 Sep 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuO31Kl4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84441AD23
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207741; cv=none; b=DqCpcijn6EZ4nudCBGXFPqyL9CriHi0HN+FEtdnhvCg14hMX3ukFAK5j9fhqhCXH9i8TNSBwmC3xe9NF/t8jeE3O4HXqondDu4f1RCU0l5i6jHQybU5x4R19G0OQ5n0TOC7piffc1Q36360j5NfQrKgApfQunTEJHWS+iNapYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207741; c=relaxed/simple;
	bh=meJjgacrhUYersxYABL+DHWYIbYd62EaOcd61+QZ4Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYLgzwKNFNU9YgahcOy2xJqI7z8AFiuMb3i2I563D7240jH5XS2jBi8kRzZhg1d4zMASI7zGhYxnfEIQax/i3c2tI6MHoGvXPd0YM369fJcoFU0H85PJW4ENloZ+YLMm0wwRlzQRs10MPkEqQUHAWumbYjxDk0ap8mpDOUkhDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuO31Kl4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758207738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykK7NSIyf/iwZWPNy//hcXF5nt83DCKn5obVHjsfZBk=;
	b=KuO31Kl4sFxmEDaTTnyMWijzdhbGGRdMQoypZhlhMU/XuRDAJtiH9qurCqKZndmzFto6K3
	lBJNHwuNXBiXr38Xo1+/X3xmm8rZy1Ripisru66/y7NVn6OMSzs0vzoP3zJUxYqwshENoi
	UtcRxJctLWxgAKM5gmbHa7A7+qtc7FY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-9GGR9adSOi-7p7Xku3F71Q-1; Thu, 18 Sep 2025 11:02:16 -0400
X-MC-Unique: 9GGR9adSOi-7p7Xku3F71Q-1
X-Mimecast-MFC-AGG-ID: 9GGR9adSOi-7p7Xku3F71Q_1758207735
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2f1a650dso7613955e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207735; x=1758812535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykK7NSIyf/iwZWPNy//hcXF5nt83DCKn5obVHjsfZBk=;
        b=KWqcNddhZdC28exM+mLajPWhHth+7CFbNHpX3RK8joBPgvYmzi4njKPgnKI4aE7BIH
         ACFGiRxeq9Xto6EynUKCB6yrZP9xQHCb8nSjglMPRiwsxhITso3ijqedl/wGwJaN7Cpj
         tAU4iCklhlFhTVOdrqLz0iCcSI3i5DtQGpz2el+jpeozbdeuk83qgKa9yQ/oW1iCMhXg
         qjENH0k/GpDhCKB8+LQRBiTv2TG3o2hU5mUXS6EzhboXCeKVS5LSoWF262YDAFZ8zDY6
         6qP7Jg8a823xHHor9hiMYzycFJ/YXjqZIVXgJw9n50YB97VieymVzuhP5BcOUlhZUehg
         j/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWAr6xKn41Ykxbb7/kl62gMtqR9iaMFfV4BtfWxF++kRTM7NGMuXGpQQ93SiznbYHxq1SIc2hXojL407pU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eBRhNgHlBUblLNQQctR79p2jYdKieB/o7KkX6ucjF2dOIx+7
	+UvXWeVtYpgXuwyYcqzq8MW+v9FqWBKZ04RscHOYCO4uxrO9DyN5TeldwryacAmNfKDoRYWlorN
	ehSCyJf+VxMjZuEGXfDU5hfY/k3WMq26JQmyckVnGiDRqCfFXtOaBlIGpfGanQ5ancA==
X-Gm-Gg: ASbGnctd1fEa1GJhPOXPr3iXUr/W0GJcGp2L0pVCNGP31Pll3zRvKappJKWpjFBFS5L
	NpjF9h/4a2D69TP7Max5j4aVuP4wu/md2qnLvguaCoD8Km06beLmx8MbX8aKx320+Z4cIcKLfNT
	UB2L6ijo68cfttV/AlwMN3ZjDbNyeyS6Du9JiDoCBiWD5NyinmqHexDZLZ/uq5iurf2UJ7s7XVo
	t7/SrezPENEBfOnt1voh5L8IqABlTLInrbVLKI5LLv958DCGyUHfjJq808iuRc+SpqxqeQqm+9c
	6fhFfIQ7RnYdhZkH/vxhR2VGNptWOjDouk4=
X-Received: by 2002:a05:6000:40df:b0:3eb:f3de:1a87 with SMTP id ffacd0b85a97d-3ecdfa3be10mr6526710f8f.56.1758207735275;
        Thu, 18 Sep 2025 08:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdAvmcyLZbrnkTBz5MiMNI4fyFWESmbbsuhEoTjC5BH2ktUX8nLQEQvjdp8oibmVxty51aLw==
X-Received: by 2002:a05:6000:40df:b0:3eb:f3de:1a87 with SMTP id ffacd0b85a97d-3ecdfa3be10mr6526528f8f.56.1758207733236;
        Thu, 18 Sep 2025 08:02:13 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7284sm4060115f8f.33.2025.09.18.08.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:02:12 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:02:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: syzbot <syzbot+a1a3cefd6148c781117c@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] WARNING in __vhost_task_wake
Message-ID: <20250918110101-mutt-send-email-mst@kernel.org>
References: <68caec73.050a0220.2ff435.0595.GAE@google.com>
 <68cb6475.050a0220.3c6139.0fab.GAE@google.com>
 <aMwdsFGkM-tMjHwc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMwdsFGkM-tMjHwc@google.com>

On Thu, Sep 18, 2025 at 07:56:48AM -0700, Sean Christopherson wrote:
> +Michael
> 
> Michael, this is the VHOST_TASK_FLAGS_KILLED WARN that was added[*] to detect
> violations similar to KVM.
> 
> 	/*
> 	 * Checking VHOST_TASK_FLAGS_KILLED can race with signal delivery, but
> 	 * a race can only result in false negatives and this is just a sanity
> 	 * check, i.e. if KILLED is set, the caller is buggy no matter what.
> 	 */
> 	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)))
> 		return;
> 
> I haven't been able to repro the splat, but after much staring I think the issue
> is that vhost_task_fn() marks the task KILLED before invoking handle_sigkill().
> If vhost_worker_flush() already holds worker->mutex, before vhost_worker_killed()
> runs, then it could wake a (not yet dead) task that has KILLED set.
> 
> Assuming waiting to set KILLED until after handle_sigkill() resolves the issue
> (fingers crossed), the two options I see would be to apply the below as fixup,
> or simply drop the sanity check for the 6.17 and add it back in 6.18 in conjunction
> with the below (again, assuming it actually resolves the issue).
> 
> [*] https://lore.kernel.org/all/20250827194107.4142164-2-seanjc@google.com

I just sent this one to Linus. Enough?

> On Wed, Sep 17, 2025, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    ae2d20002576 Add linux-next specific files for 20250917
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11678f62580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d737cfaddae0058c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a1a3cefd6148c781117c
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1790ef62580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10242534580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/96197382e3c0/disk-ae2d2000.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/55a8a6ba3307/vmlinux-ae2d2000.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c1b4ed5d6e2c/bzImage-ae2d2000.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+a1a3cefd6148c781117c@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: kernel/vhost_task.c:97 at __vhost_task_wake+0xbb/0xd0 kernel/vhost_task.c:97, CPU#0: syz.0.174/6507
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 6507 Comm: syz.0.174 Not tainted syzkaller #0 PREEMPT(full) 
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> > RIP: 0010:__vhost_task_wake+0xbb/0xd0 kernel/vhost_task.c:97
> > Code: 38 00 74 08 48 89 df e8 93 81 95 00 48 8b 3b 5b 41 5e 41 5f e9 a6 45 01 00 e8 31 ef 30 00 90 0f 0b 90 eb 8b e8 26 ef 30 00 90 <0f> 0b 90 5b 41 5e 41 5f e9 18 c7 ff 09 cc 0f 1f 80 00 00 00 00 90
> > RSP: 0018:ffffc90003b7f680 EFLAGS: 00010293
> > RAX: ffffffff818f2d7a RBX: ffff888033c7c400 RCX: ffff88802bc85ac0
> > RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> > RBP: ffffc90003b7f750 R08: ffff888033c7c477 R09: 1ffff1100678f88e
> > R10: dffffc0000000000 R11: ffffed100678f88f R12: 1ffff9200076fed8
> > R13: dffffc0000000000 R14: 0000000000000002 R15: dffffc0000000000
> > FS:  0000000000000000(0000) GS:ffff88812579c000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f9942aa0f98 CR3: 0000000027bfc000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  vhost_worker_queue+0x194/0x260 drivers/vhost/vhost.c:253
> >  __vhost_worker_flush+0x134/0x1e0 drivers/vhost/vhost.c:290
> >  vhost_worker_flush drivers/vhost/vhost.c:303 [inline]
> >  vhost_dev_flush+0xb2/0x130 drivers/vhost/vhost.c:313
> >  vhost_vsock_flush drivers/vhost/vsock.c:698 [inline]
> >  vhost_vsock_dev_release+0x1fb/0x3f0 drivers/vhost/vsock.c:750
> >  __fput+0x44c/0xa70 fs/file_table.c:468
> >  task_work_run+0x1d4/0x260 kernel/task_work.c:227
> >  exit_task_work include/linux/task_work.h:40 [inline]
> >  do_exit+0x6b5/0x2300 kernel/exit.c:966
> >  do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
> >  get_signal+0x1285/0x1340 kernel/signal.c:3034
> >  arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
> >  exit_to_user_mode_loop+0x72/0x130 kernel/entry/common.c:40
> >  exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
> >  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
> >  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
> >  do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f9941b8eba9
> > Code: Unable to access opcode bytes at 0x7f9941b8eb7f.
> > RSP: 002b:00007f9942aa10e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> > RAX: fffffffffffffe00 RBX: 00007f9941dd5fa8 RCX: 00007f9941b8eba9
> > RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f9941dd5fa8
> > RBP: 00007f9941dd5fa0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f9941dd6038 R14: 00007ffd2989c130 R15: 00007ffd2989c218
> >  </TASK>
> > 
> > 
> > ---
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> 
> #syz test
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 01bf7b0e2c5b..6cb3b8b26768 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -58,9 +58,15 @@ static int vhost_task_fn(void *data)
>          * new work and flushed.
>          */
>         if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
> -               set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
>                 if (vtsk->handle_sigkill)
>                         vtsk->handle_sigkill(vtsk->data);
> +
> +               /*
> +                * Mark the task KILLED *after* giving the owner the chance to
> +                * handle SIGKILL to avoid false positives on the sanity check
> +                * in __vhost_task_wake().
> +                */
> +               set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
>         }
>         mutex_unlock(&vtsk->exit_mutex);
>         complete(&vtsk->exited);


