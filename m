Return-Path: <linux-kernel+bounces-832364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE8B9F14D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B122D18918DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6C32E92B7;
	Thu, 25 Sep 2025 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fwNTZLUV"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A9196C7C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801920; cv=none; b=PYUAS0j9tM9EI0VCATaCk2FKdZcBKVpXZkY2GM3G4aVTQHRWoUXZzY4gXZth/0ilDfVGWZm+TymW+iNQbLsJ4jToCx/dLEpzlRUlE2zplYYCWtimLpJYwNn1HNhsEuB2iMtBgZYzIHJFG8B1BhBEeUNTI4/Y9IodM7IMFXIC6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801920; c=relaxed/simple;
	bh=YmP8inoUwD7SAXG/UDicvfE5R8iqwygFOMLbQgaKGO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkGrT/ONtmlWsBUxX86EC6oVCLg+OW64qRY85JWP6jlvIc18bsDL+AntNoJOLwESD16hruzFU1eZc7navV18xI5kRLJroUgRcsB/knuxwC7rp8SsFZZFyL2O2ExXqywVheJpnL7pJIPYQYZN5xkrtr+7Md82MTJuU2svOR3TaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fwNTZLUV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54a74f9150so800432a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758801917; x=1759406717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJfaYk/ADjggZbX1yowJutgFsALZbqt+nLjwb73l1ow=;
        b=fwNTZLUVn5sMW4aFsE1i38SaLlHDsxLyEvs9Exfvixf1cqIkg1nLYkk/ZxlJ8m6aF8
         1UJAqWhzAmv6KNkDtHZUP0WPzknavp0pJPQJIzJTL1i0LFHlBpQPtRD4OfvOiHbWADp7
         NHWG6W4Y8eBIRBwogyjCn12FZiXdVIDJo6hyKZC0RnH6eTxiwspA29cfeSiv1l5sD1Hd
         qLAsMjcpWFOuA33xT141DFX1KfCdBtFT/jv7yldhQ3vrVZcLfBph7PQl9NStkpNjRmDl
         OO2sNYEmEHXbx3E4ZesRj1RTw6ZIaCe9TtKtBoeXp1uK7gBg6sKGbq3NVedJVt8UjtoE
         lj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801917; x=1759406717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJfaYk/ADjggZbX1yowJutgFsALZbqt+nLjwb73l1ow=;
        b=uLzwfbFnWHdd2rEozon5ywf4G3ZOU0eToPzU/w62ej8PGZcKhKu8xBK//PG6gKcvAf
         fVKo4fL94JH/7t/fFuTK7Ezr7MKyqNFqyMv2VrQXCeFihzI0YOpekz9Jd/9mkWhEkdZh
         ZhzkG2hkg5zHTj4eDDPyyiI9x/NMgi7Pp22/QgvsSndilnSpRcnZ3Nx/7VBAVE+GyFbb
         RzQTvo95D/oISQl3Wioxc2h6rvuvK57c+6JinrGgBBeiuGuGaB8cuZ89S+kJG0wLSvPG
         S1OYMVRnhzQ6e4SAYhSLWb3PyzNtIhetCQ5TSLwZtBOnEIPxev/NapK7RNG8PkfZa50S
         Ia5A==
X-Forwarded-Encrypted: i=1; AJvYcCXDBWD68tNfHhS5zanCPZhgCuT8uvhzUyzZ+z63IPiOpDKg8KHKEk/6O+6o9cdmSeeKceu/oMNGf6tDFpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBQQIUZp0kkuJDtJcoaYwrKSDTTYn8sGRlGH5y9K5nJJuweWB
	EFIjMovFZma3ZF8oWsVwiNMGnK+nwTopKkUsMzbluXMugrE6M3v4NeoMKP99dToryQ==
X-Gm-Gg: ASbGncvnDKysTTWNXwH60Rgc89Fb5wm/hPoW5k1TPh3p+C+rVdhtowLECxfCLv3JnTW
	S8fKhi0RDMQ0QzB4q6udcGGJWayvC39fbQ4bWQdUrSCMDrIn4NxogryDYe8kkvMui1sM+T+sMAV
	bNlTkuU/Aei89yVYnvtej/c2L08mqPaxZo8Gpr3g84JE/mbNGx/XC9+SjNpZPoOHd05jEN2A9T+
	19teGbyvZqpIXTzhvjLShsR+WGJhEYk0QP4X8yURNl4DWbgt85oq6WNdAnBvK0nrfZWlI19fN9E
	VhFU8rZCi2suzAbLYLcYMqcS4D/FtDfqQLhM6+nnmbH8/WIh7udlv+h9qC8SBhW5mF/C4r0HdyM
	Bj9Cdf70EDU7bv9qt1cdxF9t7CbCkk/0BepbLyg1zbxV1fppVVw==
X-Google-Smtp-Source: AGHT+IHqDDMF0tlP8h5tvW7t+b2FQfev+/Ajro6sb/nuFtAvbnjpVZtZ8hg7uw1gVHICdtgAY3cdOA==
X-Received: by 2002:a17:903:fa5:b0:26e:49e3:55f0 with SMTP id d9443c01a7336-27ed4a1a37cmr39285025ad.16.1758801916505;
        Thu, 25 Sep 2025 05:05:16 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6716081sm22930815ad.53.2025.09.25.05.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:05:15 -0700 (PDT)
Date: Thu, 25 Sep 2025 20:05:04 +0800
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
Message-ID: <20250925120504.GC120@bytedance>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
 <20250910095044.278-2-ziqianlu@bytedance.com>
 <58a587d694f33c2ea487c700b0d046fa@codethink.co.uk>
 <20250924113354.GA120@bytedance>
 <db7fc090-5c12-450b-87a4-bcf06e10ef68@amd.com>
 <20250925092938.GB120@bytedance>
 <72706108-f1c3-4719-a65c-c7c5d76f9b1e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72706108-f1c3-4719-a65c-c7c5d76f9b1e@amd.com>

On Thu, Sep 25, 2025 at 04:52:25PM +0530, K Prateek Nayak wrote:
> 
> 
> On 9/25/2025 2:59 PM, Aaron Lu wrote:
> > Hi Prateek,
> > 
> > On Thu, Sep 25, 2025 at 01:47:35PM +0530, K Prateek Nayak wrote:
> >> Hello Aaron, Matteo,
> >>
> >> On 9/24/2025 5:03 PM, Aaron Lu wrote:
> >>>> [   18.421350] WARNING: CPU: 0 PID: 1 at kernel/sched/fair.c:400 enqueue_task_fair+0x925/0x980
> >>>
> >>> I stared at the code and haven't been able to figure out when
> >>> enqueue_task_fair() would end up with a broken leaf cfs_rq list.
> >>
> >> Yeah neither could I. I tried running with PREEMPT_RT too and still
> >> couldn't trigger it :(
> >>
> >> But I'm wondering if all we are missing is:
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index f993de30e146..5f9e7b4df391 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6435,6 +6435,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
> >>  
> >>  	cfs_rq->throttle_count = pcfs_rq->throttle_count;
> >>  	cfs_rq->throttled_clock_pelt = rq_clock_pelt(cpu_rq(cpu));
> >> +	cfs_rq->pelt_clock_throttled = pcfs_rq->pelt_clock_throttled;
> >>  }
> >>  
> >>  /* conditionally throttle active cfs_rq's from put_prev_entity() */
> >> ---
> >>
> >> This is the only way we can currently have a break in
> >> cfs_rq_pelt_clock_throttled() hierarchy.
> >>
> > 
> > Great finding! Yes, that is missed.
> > 
> > According to this info, I'm able to trigger the assert in
> > enqueue_task_fair(). The stack is different from Matteo's: his stack is
> > from ttwu path while mine is from exit. Anyway, let me do more analysis
> > and get back to you:
> > 
> > [   67.041905] ------------[ cut here ]------------
> > [   67.042387] WARNING: CPU: 2 PID: 11582 at kernel/sched/fair.c:401 enqueue_task_fair+0x6db/0x720
> > [   67.043227] Modules linked in:
> > [   67.043537] CPU: 2 UID: 0 PID: 11582 Comm: sudo Tainted: G        W           6.17.0-rc4-00010-gfe8d238e646e-dirty #72 PREEMPT(voluntary)
> > [   67.044694] Tainted: [W]=WARN
> > [   67.044997] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [   67.045910] RIP: 0010:enqueue_task_fair+0x6db/0x720
> > [   67.046383] Code: 00 48 c7 c7 96 b2 60 82 c6 05 af 64 2e 05 01 e8 fb 12 03 00 8b 4c 24 04 e9 f8 fc ff ff 4c 89 ef e8 ea a2 ff ff e9 ad fa ff ff <0f> 0b e9 5d fc ff ff 49 8b b4 24 08 0b 00 00 4c 89 e7 e8 de 31 01
> > [   67.048155] RSP: 0018:ffa000002d2a7dc0 EFLAGS: 00010087
> > [   67.048655] RAX: ff11000ff05fd2e8 RBX: 0000000000000000 RCX: 0000000000000004
> > [   67.049339] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff11000ff05fd1f0
> > [   67.050036] RBP: 0000000000000001 R08: 0000000000000000 R09: ff11000ff05fc908
> > [   67.050731] R10: 0000000000000000 R11: 00000000fa83b2da R12: ff11000ff05fc800
> > [   67.051402] R13: 0000000000000000 R14: 00000000002ab980 R15: ff11000ff05fc8c0
> > [   67.052083] FS:  0000000000000000(0000) GS:ff110010696a6000(0000) knlGS:0000000000000000
> > [   67.052855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   67.053404] CR2: 00007f67f8b96168 CR3: 0000000002c3c006 CR4: 0000000000371ef0
> > [   67.054083] Call Trace:
> > [   67.054334]  <TASK>
> > [   67.054546]  enqueue_task+0x35/0xd0
> > [   67.054885]  sched_move_task+0x291/0x370
> > [   67.055268]  ? kmem_cache_free+0x2d9/0x480
> > [   67.055669]  do_exit+0x204/0x4f0
> > [   67.055984]  ? lock_release+0x10a/0x170
> > [   67.056356]  do_group_exit+0x36/0xa0
> > [   67.056714]  __x64_sys_exit_group+0x18/0x20
> > [   67.057121]  x64_sys_call+0x14fa/0x1720
> > [   67.057502]  do_syscall_64+0x6a/0x2d0
> > [   67.057865]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Great! I'll try stressing this path too.

I now also see other paths leading to enqueue_task_fair() too, so I
think this is the same problem as seen by Matteo.

> P.S. Are you seeing this with sync_throttle() fix too?

Nope, your finding fixed it for me :)

I added some trace prints but due to too many traces, it keeps losing
those critical ones.

Anyway, I think I've figured out how it happened: during
online_fair_sched_group() -> sync_throttle(), the newly onlined cfs_rq
didn't have pelt_clock_throttled synced. Suppose its parent's pelt clock
is throttled, then in propagate_entity_cfs_rq(), this newly onlined
cfs_rq is added to leaf list but its parent is not. Now
rq->tmp_alone_branch points to this newly onlined cfs_rq, waiting for
its parent to be added(but this didn't happen).

Then another task wakes up and gets enqueued on this same cpu, all its
ancestor cfs_rqs are already on the list so list_add_leaf_cfs_rq()
didn't manipulate rq->tmp_alone_branch. At the end of the enqueue,
assert will fire.

I'm thinking we should add an assert_list_leaf_cfs_rq() at the end of
propagate_entity_cfs_rq() to capture other potential problems.

Hi Matteo,

Can you test the above diff Prateek sent in his last email? Thanks.

