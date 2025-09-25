Return-Path: <linux-kernel+bounces-832112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AD7B9E5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA8F1624F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A41E2EBBA6;
	Thu, 25 Sep 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ocb3b7eN"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AC287267
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792593; cv=none; b=YZjaPr/PyeNZYXLV6ncV9UEm9v4ZsT5HV2H+F+gstDA0pF9huZccZ7K60bPGqlWZWtj2vP/KxSEVCZaCZ0o0GYrXjB2m/ZlxFlgf5+esuRvQu2blzvGxYmalOMksZQwph1iYRZnx29+UFaq2KHjMJm/GV2skiN05ENIcoWU7B2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792593; c=relaxed/simple;
	bh=4sN6AWIEZC2s9rT3kWNfEE1C/sXi3Cjxos+ffOHuHxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCCvrhNjt9JIlAV1MBlpTuov4KFOmifikKsLLxTdDXIDKvLMOBoBdACmDwqkf87K60lb2gPW0BfAS4HvDqsBN2TerwiqgFiiJ6ZF5o7bHPoS1gO8U4hIKqMQAjc0KCNI0gjmlcQXUyC5DU0TqdaCyB4y11h1NGJXBixWP3vda5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ocb3b7eN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33082aed31dso823419a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758792590; x=1759397390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdRK3yfx8ROde6PzVS3GV+QcXGpu7Q3TM+KGkkucQzo=;
        b=Ocb3b7eNnYUj9vwAYDgydPBV7y+PuJwj2Si/klUdjMgx9L63pVgWQrmrbHqpj4QsxQ
         /dN+FzRW0Zn8qsMVDTFdbLo0PWo//W8ENi6fEpH7moJHDhSk2a9yzj+m8JcHsmbR7EQF
         8ON4gLqGcqywof4KFZ9J8PiBzNeuCrDlQIqBSHoHnJfNC51mhbmJ/gewAAL3MfqlbhQy
         xCzt5O1WmdWSZPbplvq89TVdlhPfibcq/QMeB6My/862k3wuUVrL8YW6fs1k1oGUzeeX
         3f2LJjFpIkEJB3JpyZERAwGLbs+bPgmvzjxYwp97YwCmUdeQvAu+DiTopX8BgcMvyuCq
         turw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792590; x=1759397390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdRK3yfx8ROde6PzVS3GV+QcXGpu7Q3TM+KGkkucQzo=;
        b=St7ORPed+nIiNk4qP2a7Llc8xgnGF1XRcWMrCQ0sGrmfdSHaBw/G99DBJ0BYfXD52u
         WMsZ41rH4BIw2IzJy3XoHWxWAjRQcw0Efi4Z3cBYlQjTSXdXTLmf9hstUvQkf+Z4wVgp
         xDjFVBGqpyoU/Ss5BAGim8fqW3Rk1kWWpUMIV/omCR/IPB8LhgyyMJ0vq1UuHLa7kpX8
         LCtJLGIM9KR9pF3WKiRvYSGLwOvxJxEnfFgIGM4y+YtgbpYZMhQ2lYWvr8G16FNjbC/4
         o2QXAkFbFBVjPNRF3sRRXGrgJPy3NPKTh9biG+pwaM06/bKor2P8N3L+zMp9Km9IXjAr
         CHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA1YpTe8N3yC0CXNTpTG81m+hzoE3ZSXl1cIzvL42RUYOzMOeqirbGaWjBhWO0HQnF7OUChtaOheGmrbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvj8JGGzHGI0L3W2LocEY/ekBbviN/gHdyZI/wECjZ2rVYCJoX
	+1ENY+CyiYDUxPHibtlFJI1W69NQmnGUIpnlR4h36XnfrajJ9DauzZhMJwlyixWLug==
X-Gm-Gg: ASbGnctjfZ54LaK30+G36AC1tm8pN1JK39P3XYV7D9ZbGW47NyyuNpRgte5lSCMr1Rw
	HfVUZ/fnPLBjVTdsfUcXtMa/ki3WX8LOjlbzGzxEfy/CnmWzKjs5jSYY1iOfdNB/STX4glb0Rf2
	qLfYsmeYElcsHPr9+RgtrvujoXTghTFSQCUHoSfi2O1j1+AcWyVbMdLC+x0HI2FqFomWf38jbLQ
	fNDH8J+d8McEDbyhvThfYshCDOK65UNGHr21zQ9CNoaMEAI/s1nUKGG75RvXGuOe8wIyg6GNp/o
	3xMNwgWRVKdw/7nBGEYOshkhrXDk10oN/gh+0a9s4LCJEmMiUHZJkDrLa2YTn+N4pxSWYlFDBY3
	abCrZ9Bv29uLC5EGfqhmclIAQtd8BWzLRVKDL5Gzd0DuhIBZRfw==
X-Google-Smtp-Source: AGHT+IGWOtIOc8E0YArHA5yB4w/EfINlBS8Usv4TzZqVKyYsGdBWUNQbPUMVZ/yexKR6ZXeM/0D8wQ==
X-Received: by 2002:a17:90b:4b87:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-3342a2e5a2bmr3148559a91.35.1758792589345;
        Thu, 25 Sep 2025 02:29:49 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d71199sm1687651a91.5.2025.09.25.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:29:48 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:29:38 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/4] sched/fair: Propagate load for throttled cfs_rq
Message-ID: <20250925092938.GB120@bytedance>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
 <20250910095044.278-2-ziqianlu@bytedance.com>
 <58a587d694f33c2ea487c700b0d046fa@codethink.co.uk>
 <20250924113354.GA120@bytedance>
 <db7fc090-5c12-450b-87a4-bcf06e10ef68@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db7fc090-5c12-450b-87a4-bcf06e10ef68@amd.com>

Hi Prateek,

On Thu, Sep 25, 2025 at 01:47:35PM +0530, K Prateek Nayak wrote:
> Hello Aaron, Matteo,
> 
> On 9/24/2025 5:03 PM, Aaron Lu wrote:
> >> [   18.421350] WARNING: CPU: 0 PID: 1 at kernel/sched/fair.c:400 enqueue_task_fair+0x925/0x980
> > 
> > I stared at the code and haven't been able to figure out when
> > enqueue_task_fair() would end up with a broken leaf cfs_rq list.
> 
> Yeah neither could I. I tried running with PREEMPT_RT too and still
> couldn't trigger it :(
> 
> But I'm wondering if all we are missing is:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f993de30e146..5f9e7b4df391 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6435,6 +6435,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
>  
>  	cfs_rq->throttle_count = pcfs_rq->throttle_count;
>  	cfs_rq->throttled_clock_pelt = rq_clock_pelt(cpu_rq(cpu));
> +	cfs_rq->pelt_clock_throttled = pcfs_rq->pelt_clock_throttled;
>  }
>  
>  /* conditionally throttle active cfs_rq's from put_prev_entity() */
> ---
> 
> This is the only way we can currently have a break in
> cfs_rq_pelt_clock_throttled() hierarchy.
> 

Great finding! Yes, that is missed.

According to this info, I'm able to trigger the assert in
enqueue_task_fair(). The stack is different from Matteo's: his stack is
from ttwu path while mine is from exit. Anyway, let me do more analysis
and get back to you:

[   67.041905] ------------[ cut here ]------------
[   67.042387] WARNING: CPU: 2 PID: 11582 at kernel/sched/fair.c:401 enqueue_task_fair+0x6db/0x720
[   67.043227] Modules linked in:
[   67.043537] CPU: 2 UID: 0 PID: 11582 Comm: sudo Tainted: G        W           6.17.0-rc4-00010-gfe8d238e646e-dirty #72 PREEMPT(voluntary)
[   67.044694] Tainted: [W]=WARN
[   67.044997] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   67.045910] RIP: 0010:enqueue_task_fair+0x6db/0x720
[   67.046383] Code: 00 48 c7 c7 96 b2 60 82 c6 05 af 64 2e 05 01 e8 fb 12 03 00 8b 4c 24 04 e9 f8 fc ff ff 4c 89 ef e8 ea a2 ff ff e9 ad fa ff ff <0f> 0b e9 5d fc ff ff 49 8b b4 24 08 0b 00 00 4c 89 e7 e8 de 31 01
[   67.048155] RSP: 0018:ffa000002d2a7dc0 EFLAGS: 00010087
[   67.048655] RAX: ff11000ff05fd2e8 RBX: 0000000000000000 RCX: 0000000000000004
[   67.049339] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff11000ff05fd1f0
[   67.050036] RBP: 0000000000000001 R08: 0000000000000000 R09: ff11000ff05fc908
[   67.050731] R10: 0000000000000000 R11: 00000000fa83b2da R12: ff11000ff05fc800
[   67.051402] R13: 0000000000000000 R14: 00000000002ab980 R15: ff11000ff05fc8c0
[   67.052083] FS:  0000000000000000(0000) GS:ff110010696a6000(0000) knlGS:0000000000000000
[   67.052855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.053404] CR2: 00007f67f8b96168 CR3: 0000000002c3c006 CR4: 0000000000371ef0
[   67.054083] Call Trace:
[   67.054334]  <TASK>
[   67.054546]  enqueue_task+0x35/0xd0
[   67.054885]  sched_move_task+0x291/0x370
[   67.055268]  ? kmem_cache_free+0x2d9/0x480
[   67.055669]  do_exit+0x204/0x4f0
[   67.055984]  ? lock_release+0x10a/0x170
[   67.056356]  do_group_exit+0x36/0xa0
[   67.056714]  __x64_sys_exit_group+0x18/0x20
[   67.057121]  x64_sys_call+0x14fa/0x1720
[   67.057502]  do_syscall_64+0x6a/0x2d0
[   67.057865]  entry_SYSCALL_64_after_hwframe+0x76/0x7e


> > 
> > No matter what the culprit commit did, enqueue_task_fair() should always
> > get all the non-queued cfs_rqs on the list in a bottom up way. It should
> > either add the whole hierarchy to rq's leaf cfs_rq list, or stop at one
> > of the ancestor cfs_rqs which is already on the list. Either way, the
> > list should not be broken.
> > 
> >> [   18.421355] Modules linked in: efivarfs
> >> [   18.421360] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.17.0-rc4-00010-gfe8d238e646e #2 PREEMPT_{RT,(full)}
> >> [   18.421362] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
> >> [   18.421364] RIP: 0010:enqueue_task_fair+0x925/0x980
> >> [   18.421366] Code: b5 48 01 00 00 49 89 95 48 01 00 00 49 89 bd 50 01 00 00 48 89 37 48 89 b0 70 0a 00 00 48 89 90 78 0a 00 00 e9 49 fa ff ff 90 <0f> 0b 90 e9 1c f9 ff ff 90 0f 0b 90 e9 59 fa ff ff 48 8b b0 88 0a
> >> [   18.421367] RSP: 0018:ffff9c7c8001fa20 EFLAGS: 00010087
> >> [   18.421369] RAX: ffff9358fdc29da8 RBX: 0000000000000003 RCX: ffff9358fdc29340
> >> [   18.421370] RDX: ffff935881a89000 RSI: 0000000000000000 RDI: 0000000000000003
> >> [   18.421371] RBP: ffff9358fdc293c0 R08: 0000000000000000 R09: 00000000b808a33f
> >> [   18.421371] R10: 0000000000200b20 R11: 0000000011659969 R12: 0000000000000001
> >> [   18.421372] R13: ffff93588214fe00 R14: 0000000000000000 R15: 0000000000200b20
> >> [   18.421375] FS:  00007fb07deddd80(0000) GS:ffff935945f6d000(0000) knlGS:0000000000000000
> >> [   18.421376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   18.421377] CR2: 00005571bafe12a0 CR3: 00000000024e6000 CR4: 00000000000006f0
> >> [   18.421377] Call Trace:
> >> [   18.421383]  <TASK>
> >> [   18.421387]  enqueue_task+0x31/0x70
> >> [   18.421389]  ttwu_do_activate+0x73/0x220
> >> [   18.421391]  try_to_wake_up+0x2b1/0x7a0
> >> [   18.421393]  ? kmem_cache_alloc_node_noprof+0x7f/0x210
> >> [   18.421396]  ep_autoremove_wake_function+0x12/0x40
> >> [   18.421400]  __wake_up_common+0x72/0xa0
> >> [   18.421402]  __wake_up_sync+0x38/0x50
> >> [   18.421404]  ep_poll_callback+0xd2/0x240
> >> [   18.421406]  __wake_up_common+0x72/0xa0
> >> [   18.421407]  __wake_up_sync_key+0x3f/0x60
> >> [   18.421409]  sock_def_readable+0x42/0xc0
> >> [   18.421414]  unix_dgram_sendmsg+0x48f/0x840
> >> [   18.421420]  ____sys_sendmsg+0x31c/0x350
> >> [   18.421423]  ___sys_sendmsg+0x99/0xe0
> >> [   18.421425]  __sys_sendmsg+0x8a/0xf0
> >> [   18.421429]  do_syscall_64+0xa4/0x260
> >> [   18.421434]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> [   18.421438] RIP: 0033:0x7fb07e8d4d94
> >> [   18.421439] Code: 15 91 10 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00 f3 0f 1e fa 80 3d d5 92 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> >> [   18.421440] RSP: 002b:00007ffff30e4d08 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> >> [   18.421442] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb07e8d4d94
> >> [   18.421442] RDX: 0000000000004000 RSI: 00007ffff30e4e80 RDI: 0000000000000031
> >> [   18.421443] RBP: 00007ffff30e5ff0 R08: 00000000000000c0 R09: 0000000000000000
> >> [   18.421443] R10: 00007fb07deddc08 R11: 0000000000000202 R12: 00007ffff30e6070
> >> [   18.421444] R13: 00007ffff30e4f00 R14: 00007ffff30e4d10 R15: 000000000000000f
> >> [   18.421445]  </TASK>
> >> [   18.421446] ---[ end trace 0000000000000000 ]---
> >>
> >> [1]: https://lore-kernel.gnuweeb.org/lkml/20250829081120.806-1-ziqianlu@bytedance.com/
> >> [2]: https://lore.kernel.org/lkml/d37fcac575ee94c3fe605e08e6297986@codethink.co.uk/
> >>
> >> I hope this is helpful. I'm happy to provide more information or run
> >> additional tests if needed.
> > 
> > Yeah, definitely helpful, thanks.
> > 
> > While looking at this commit, I'm thinking maybe we shouldn't use
> > cfs_rq_pelt_clock_throttled() to decide if cfs_rq should be added
> > to rq's leaf list. The reason is, for a cfs_rq that is in throttled
> > hierarchy, it can be removed from that leaf list when it has no entities
> > left in dequeue_entity(). So even when it's on the list now doesn't
> > mean it will still be on the list at unthrottle time.
> > 
> > Considering that the purpose is to have cfs_rq and its ancestors to be
> > added to the list in case this cfs_rq may have some removed load that
> > needs to be decayed later as described in commit 0258bdfaff5b("sched/fair: 
> > Fix unfairness caused by missing load decay"), I'm thinking maybe we
> > should deal with cfs_rqs differently according to whether it is in
> > throttled hierarchy or not:
> > - for cfs_rqs not in throttled hierarchy, add it and its ancestors to
> >   the list so that the removed load can be decayed;
> > - for cfs_rqs in throttled hierarchy, check on unthrottle time whether
> >   it has any removed load that needs to be decayed.
> >   The case in my mind is: an blocked task @p gets attached to a throttled
> >   cfs_rq by attaching a pid to a cgroup. Assume the cfs_rq was empty, had
> >   no tasks throttled or queued underneath it. Then @p is migrated to
> >   another cpu before being queued on it, so this cfs_rq now has some
> >   removed load on it. On unthrottle, this cfs_rq is considered fully
> >   decayed and isn't added to leaf cfs_rq list. Then we have a problem.
> > 
> > With the above said, I'm thinking the below diff. No idea if this can
> > fix Matteo's problem though, it's just something I think can fix the
> > issue I described above, if I understand things correctly...
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index f993de30e1466..444f0eb2df71d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4062,6 +4062,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> >  	if (child_cfs_rq_on_list(cfs_rq))
> >  		return false;
> >  
> > +	if (cfs_rq->removed.nr)
> > +		return false;
> 
> If load_avg_is_decayed(), then having removed load makes no difference
> right? We are not adding any weight to the tg and the sum/avg cannot go
> negative so we are essentially removing nothing.
> 
> And, update_load_avg() would propagate the removed load anyways so does
> this make a difference?
> 

You are right. I misunderstood the meanning of removed load, I thought
the load was transferred to the removed part but actually, the load is
still there in the cfs_rq when a task migrates away.

Having a positive removed.nr but fully decayed load avg looks strange
to me, maybe we can avoid this by doing something below, it should
be able to save some cycles by avoiding taking a lock and later dealing
with zero removed load in update_cfs_rq_load_avg(). Just a thought:
(I had a vague memory that util_avg and runnable_avg should always be
smaller than load_avg, if so, we can simplify the condition by just
checking load_avg)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f993de30e1466..130db255a1ef6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4788,6 +4808,10 @@ static void remove_entity_load_avg(struct sched_entity *se)
 
 	sync_entity_load_avg(se);
 
+	/* It's possible this entity has no load left after sync */
+	if (!se->avg.util_avg && !se->avg.load_avg && !se->avg.runnable_avg)
+		return;
+
 	raw_spin_lock_irqsave(&cfs_rq->removed.lock, flags);
 	++cfs_rq->removed.nr;
 	cfs_rq->removed.util_avg	+= se->avg.util_avg;

