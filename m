Return-Path: <linux-kernel+bounces-854421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4827DBDE53A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B88427792
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1787322DC3;
	Wed, 15 Oct 2025 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a4F3Js2O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2Jw7oqCl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dOIpYtmp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1IuIOASb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD848322DB9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528974; cv=none; b=ehZbzfpqg4sRt3iDNuV8OvzhXVc4zRX5gWMiBkANGWu4VbqUTbXGgruoyKe6FYWeVOow0jk+t0Cl+D15YTQ02LfUwxTpIrt/1Be3knabWjYa6hjw+Xu/ikDvJjeHsfwnhomIFxYHSXKrPk5iz53spf3dDBB21EZGTzqw2I0reGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528974; c=relaxed/simple;
	bh=6/OuQEFoH9Y1lciWDwYaqUigyg/XgovT17O+9wk4fYc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Km0Bp2yyBPyTFC4qJaqR4BAuc+K5Ia+zNVHI+iH9bfMDHY0VwDYTugX89yWK86KM4inzj5pW+hQ4QcTn9n8+VT1imgNqeHBxJZfqPyBELTuvDxEJVjuIH4Qcv85igwzRq6Ug1Ol7wJIOjWJu4qtGUNRHFokSebJhXUxIWN8mm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a4F3Js2O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2Jw7oqCl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dOIpYtmp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1IuIOASb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9EAA31FB88;
	Wed, 15 Oct 2025 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760528970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oA+1x3aW4bnQ304WmXgLnvwNBbsoOMXd8wG5sobcq9A=;
	b=a4F3Js2OCw/CJpX445YC+q6XesnKunsGW0VyV0w8mQMfTcA//L3pJPyX6gFWZ9g50FmCzW
	zpWIDS5xQp/sEgI7HkHpaArZlkLOjzuhYtKtzkcCuvxBYhkhgST3dO94HCx0JRmGqxfr0f
	lX5cstxa68CeK4iyp+keLM5tXdX3jK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760528970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oA+1x3aW4bnQ304WmXgLnvwNBbsoOMXd8wG5sobcq9A=;
	b=2Jw7oqClle4eOMEMX96vCdFWuvWGwHnv4i5h0ZbsVQ4Rr5GqExO8yheS6+SIn9C9PHdepW
	2HwfBEosuxsRlsBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dOIpYtmp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1IuIOASb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760528969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oA+1x3aW4bnQ304WmXgLnvwNBbsoOMXd8wG5sobcq9A=;
	b=dOIpYtmpqWmM431cSUy0f397OXbeJE/e6QxuDdbjpIjr7GnCUrFM6me+6KLwICJ2U6sLE9
	gab0H+E9Uw7yDMOd5c8004jwqlYmCld3fk51cJ/BEMNtiwWSwtQZzphkCmu7pX0QdYy20+
	LKKo5Kgp3+FakhvT7uMkEyvTIXtzoS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760528969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oA+1x3aW4bnQ304WmXgLnvwNBbsoOMXd8wG5sobcq9A=;
	b=1IuIOASbh1uBNJO8lpsSHlQyxkcKIj2AS77K7xPYZecpjtCfmRu0FdfiyTzgCbQdZ3da3O
	YCKFKBwy9MOxQQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6874313A42;
	Wed, 15 Oct 2025 11:49:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V8IRGEmK72iWZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 15 Oct 2025 11:49:29 +0000
Date: Wed, 15 Oct 2025 13:49:29 +0200
Message-ID: <87sefkl706.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+c9ab1eb0f8f5ab1f18be@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_drop
In-Reply-To: <68dadf0e.050a0220.1696c6.001c.GAE@google.com>
References: <68dadf0e.050a0220.1696c6.001c.GAE@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9EAA31FB88
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[c9ab1eb0f8f5ab1f18be];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -1.01

On Mon, 29 Sep 2025 21:33:34 +0200,
syzbot wrote:
> 
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4ff71af020ae Merge tag 'net-6.17-rc8' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1191c2e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
> dashboard link: https://syzkaller.appspot.com/bug?extid=c9ab1eb0f8f5ab1f18be
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1644dd34580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156d6f12580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3fb4198b5763/disk-4ff71af0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1499875eb2cc/vmlinux-4ff71af0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/182864fb8af7/bzImage-4ff71af0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c9ab1eb0f8f5ab1f18be@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> syz.2.2869/8991 is trying to acquire lock:
> ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
> ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168
> 
> but task is already holding lock:
> ffff8880302d0150 (&group->lock#2){+.+.}-{3:3}, at: spin_lock_irq include/linux/spinlock_rt.h:93 [inline]
> ffff8880302d0150 (&group->lock#2){+.+.}-{3:3}, at: snd_pcm_group_lock_irq sound/core/pcm_native.c:98 [inline]
> ffff8880302d0150 (&group->lock#2){+.+.}-{3:3}, at: snd_pcm_stream_lock_irq sound/core/pcm_native.c:137 [inline]
> ffff8880302d0150 (&group->lock#2){+.+.}-{3:3}, at: class_pcm_stream_lock_irq_constructor include/sound/pcm.h:679 [inline]
> ffff8880302d0150 (&group->lock#2){+.+.}-{3:3}, at: snd_pcm_drop+0x10d/0x270 sound/core/pcm_native.c:2223
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&group->lock#2){+.+.}-{3:3}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        rt_spin_lock+0x88/0x2c0 kernel/locking/spinlock_rt.c:56
>        spin_lock include/linux/spinlock_rt.h:44 [inline]
>        _snd_pcm_stream_lock_irqsave+0x7c/0xa0 sound/core/pcm_native.c:171
>        class_pcm_stream_lock_irqsave_constructor include/sound/pcm.h:682 [inline]
>        snd_pcm_period_elapsed+0x1e/0x80 sound/core/pcm_lib.c:1938
>        dummy_hrtimer_callback+0x80/0x180 sound/drivers/dummy.c:386
>        __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
>        __hrtimer_run_queues+0x54f/0xd40 kernel/time/hrtimer.c:1825
>        hrtimer_run_softirq+0x1a3/0x2e0 kernel/time/hrtimer.c:1842
>        handle_softirqs+0x22f/0x710 kernel/softirq.c:579
>        __do_softirq kernel/softirq.c:613 [inline]
>        run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
>        smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
>        kthread+0x70e/0x8a0 kernel/kthread.c:463
>        ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #1 (&base->softirq_expiry_lock){+...}-{3:3}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        rt_spin_lock+0x88/0x2c0 kernel/locking/spinlock_rt.c:56
>        spin_lock include/linux/spinlock_rt.h:44 [inline]
>        hrtimer_cpu_base_lock_expiry kernel/time/hrtimer.c:1383 [inline]
>        hrtimer_run_softirq+0x7c/0x2e0 kernel/time/hrtimer.c:1838
>        handle_softirqs+0x22f/0x710 kernel/softirq.c:579
>        __do_softirq kernel/softirq.c:613 [inline]
>        run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
>        smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
>        kthread+0x70e/0x8a0 kernel/kthread.c:463
>        ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #0 ((softirq_ctrl.lock)){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
>        __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>        reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5385
>        __lock_release kernel/locking/lockdep.c:5574 [inline]
>        lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5889
>        __local_bh_enable_ip+0x10c/0x270 kernel/softirq.c:228
>        hrtimer_cancel+0x39/0x60 kernel/time/hrtimer.c:1491
>        dummy_hrtimer_stop+0xcf/0x100 sound/drivers/dummy.c:410
>        snd_pcm_do_stop+0x127/0x1c0 sound/core/pcm_native.c:1525
>        snd_pcm_action_single sound/core/pcm_native.c:1305 [inline]
>        snd_pcm_action+0xe4/0x240 sound/core/pcm_native.c:1388
>        snd_pcm_stop sound/core/pcm_native.c:1561 [inline]
>        snd_pcm_drop+0x160/0x270 sound/core/pcm_native.c:2228
>        snd_pcm_oss_sync+0x1de/0xc30 sound/core/oss/pcm_oss.c:1733
>        snd_pcm_oss_release+0x102/0x250 sound/core/oss/pcm_oss.c:2574
>        __fput+0x45b/0xa80 fs/file_table.c:468
>        task_work_run+0x1d4/0x260 kernel/task_work.c:227
>        resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>        exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
>        exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>        syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>        syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>        do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   (softirq_ctrl.lock) --> &base->softirq_expiry_lock --> &group->lock#2
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&group->lock#2);
>                                lock(&base->softirq_expiry_lock);
>                                lock(&group->lock#2);
>   lock((softirq_ctrl.lock));
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz.2.2869/8991:
>  #0: ffff8880302d0150 (&group->lock#2){+.+.}-{3:3}, at: spin_lock_irq include/linux/spinlock_rt.h:93 [inline]
>  #0: ffff8880302d0150 (&group->lock#2){+.+.}-{3:3}, at: snd_pcm_group_lock_irq sound/core/pcm_native.c:98 [inline]
>  #0: ffff8880302d0150 (&group->lock#2){+.+.}-{3:3}, at: snd_pcm_stream_lock_irq sound/core/pcm_native.c:137 [inline]
>  #0: ffff8880302d0150 (&group->lock#2){+.+.}-{3:3}, at: class_pcm_stream_lock_irq_constructor include/sound/pcm.h:679 [inline]
>  #0: ffff8880302d0150 (&group->lock#2){+.+.}-{3:3}, at: snd_pcm_drop+0x10d/0x270 sound/core/pcm_native.c:2223
>  #1: ffffffff8d9a8d80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #1: ffffffff8d9a8d80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #1: ffffffff8d9a8d80 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
>  #1: ffffffff8d9a8d80 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1bb/0x2c0 kernel/locking/spinlock_rt.c:57
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 8991 Comm: syz.2.2869 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
>  check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
>  check_prev_add kernel/locking/lockdep.c:3165 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>  validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>  reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5385
>  __lock_release kernel/locking/lockdep.c:5574 [inline]
>  lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5889
>  __local_bh_enable_ip+0x10c/0x270 kernel/softirq.c:228
>  hrtimer_cancel+0x39/0x60 kernel/time/hrtimer.c:1491
>  dummy_hrtimer_stop+0xcf/0x100 sound/drivers/dummy.c:410
>  snd_pcm_do_stop+0x127/0x1c0 sound/core/pcm_native.c:1525
>  snd_pcm_action_single sound/core/pcm_native.c:1305 [inline]
>  snd_pcm_action+0xe4/0x240 sound/core/pcm_native.c:1388
>  snd_pcm_stop sound/core/pcm_native.c:1561 [inline]
>  snd_pcm_drop+0x160/0x270 sound/core/pcm_native.c:2228
>  snd_pcm_oss_sync+0x1de/0xc30 sound/core/oss/pcm_oss.c:1733
>  snd_pcm_oss_release+0x102/0x250 sound/core/oss/pcm_oss.c:2574
>  __fput+0x45b/0xa80 fs/file_table.c:468
>  task_work_run+0x1d4/0x260 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
>  exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>  do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc9f7ffeec9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffef674cdc8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 0000000000036070 RCX: 00007fc9f7ffeec9
> RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000bf674d0bf
> R10: 0000001b31c20000 R11: 0000000000000246 R12: 00007fc9f8255fac
> R13: 00007fc9f8255fa0 R14: ffffffffffffffff R15: 0000000000000003
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

#syz fix: ALSA: pcm: Disable bottom softirqs as part of spin_lock_irq() on PREEMPT_RT

