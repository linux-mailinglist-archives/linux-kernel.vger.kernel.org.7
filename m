Return-Path: <linux-kernel+bounces-830417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2979B9999E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 027D27A5BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679282FF172;
	Wed, 24 Sep 2025 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gArAq6ZZ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95A2FC87B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713662; cv=none; b=o5QLAOGFI9KiJ7LaAOOr+OjtuW21FPBheGpvPfIsmPu67sr2JhOAji/hbFj+tDJh34Ga4dAIG4Sb1IoVBhIQSbujqQOp8jopy8rk6Qo401vSEJZc8WWLRZ1vQ00WwBFaek/PuROEKBxzHA20wwKHEkTuy+NsBN4tOy/1o14cdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713662; c=relaxed/simple;
	bh=WfCTd+L2xydb0/+ZRTCVHpDzBcTwJp7Z8hiBsLE2Yhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRQZqk8UObXSSCVrJWFfL319iDAaZNu7dTXu/m6Aaup98uyQsUn3MuIBmiD4WVTdkiBy+EQg1HvsjtTFogCpw72InIwqZxK58RyaIc7Z5L0q8fspbDmSfVS1Ys0HV2uFvHRUYtEygK3WurONcIsopLnXzkC8fffEHgpD8quEwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gArAq6ZZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f7da24397so503100b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758713655; x=1759318455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=axgFTvtfqB5sYg3JOViFVqdQRbHH2y4i8d39eYJyJew=;
        b=gArAq6ZZJZDBGlDexYP/tT+7ksZTdv1Rw653Jik0EyQqpP4GkYEFfXbEtLVBCwydQx
         2+hsRROwowctlIpPZRycxy+m6JsIgRkWZvqTKrJIqxlQKtFuJggQH7vEsIu/FIfvT8Y7
         bSBqbw1D26Ku1ezl/lJ2oanCa+FuK/MU1Gn4LaN4gk/aZfzwHv0e1CfbMxltC5E4a2fY
         dO13jMr5566MMqJOJfcMtgd1lTnfjPZLBuyLNDcUWrnLuvRtMstmySxwL/ahdE97Clww
         maQGZodsDXq5hRzwbdNsEBXnMjvQO7DDLlVhEJyO6Y/yMgSu1e9eUIx9lFkT0E24Ntca
         FWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758713655; x=1759318455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axgFTvtfqB5sYg3JOViFVqdQRbHH2y4i8d39eYJyJew=;
        b=n3Z824ZetPmCZkYH4I5X90pypjr3JbyP9bURM4NPpaXt5nmwF8nHr+mjLYck34jXEh
         28MqfwVwBVd55C8JwdmEiuMSRUkMnoDsDIYvg67sFG6ue1MY0yeJwTGmbFiFc0X4SQPL
         hC6Y3xRMn+rOxfU7bd6KNzoY8RIFVUV/S8QIKU95WRAue7V5PSt7yDLF/d0m/gx0ozde
         kgLv7YEriwLAOPdBBUqXH/L0i7PuWKeozYipxPN22cogmPHRbCEeGl3mLSbWL4fF5IAE
         1YkIId+MbCFJlh6a8yJhNdBF+fE2QmOV/B2bLwK5IO3xRSnH7GPUJhC8Y10rVrYWsNY0
         9qvg==
X-Forwarded-Encrypted: i=1; AJvYcCWFu0eu5aqIWRLRZr88t2wiPyDqtxUJubAdS2NNNzrPJXyK/yJZWwNyEl1LZ9StbS9dm96pdKaDqLI/Ceo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8nUIc6LTaEp6WwuR//CLEOExfmflGpnsOBgTBRB8W+pxjQssW
	Q5jeT4Q5fxYeLDFSL4ikdRr6sAxPnaD7ZuI0aMD8tc8h/uhAOdl7WwvboitKRBnOOg==
X-Gm-Gg: ASbGncuLDz0o11idkNWu7Oz+2+V3i6FBRjx7t9b/xsIJC6VIQaIKHq17DDJdAt53O+j
	/ft1+AmXO4rAilvqQ0rjaDm5z9jfRW8Gh6fkm2ynhaZF4QMG3YjjvySQgxKhkUO/f3NovCSNhr+
	phrkuo/Vl9szRX1GkPZrDTJrJ79X4R4x6X3ZZhyHTce+RCwX43Orme5r+e7uIy/iV0rIMdg1o/x
	Ms3Cij7eKbbXOlIX+xiufVvsAq527Ve2LSJpjvXEMHGLHZYZWaLo3vn2Eemz67HxC+/w+EWfBiJ
	uLKCq3a21aDSqJ5K7JQqSOUixXHJJEwfWzLgeLrnQEQI/3I9LRW0lyZeBgfYBKhPSCLxVAp5tar
	EXvZXWtPoKa3X2PZ4NLKDdZI5az4PzlbhqEq8lW5B5m5b++Hliw==
X-Google-Smtp-Source: AGHT+IFFmCK2QZicA0k7Iofl/6uD/mibI5NUlo6lTS3nqSxsRXUMWlKsDFnQwzFFG6HSs8kUs8hv9w==
X-Received: by 2002:a17:902:d541:b0:24c:7f03:61cb with SMTP id d9443c01a7336-27cc48a097fmr74064185ad.26.1758713654547;
        Wed, 24 Sep 2025 04:34:14 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053078sm190134065ad.10.2025.09.24.04.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:34:13 -0700 (PDT)
Date: Wed, 24 Sep 2025 19:33:54 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Matteo Martelli <matteo.martelli@codethink.co.uk>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
Message-ID: <20250924113354.GA120@bytedance>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
 <20250910095044.278-2-ziqianlu@bytedance.com>
 <58a587d694f33c2ea487c700b0d046fa@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a587d694f33c2ea487c700b0d046fa@codethink.co.uk>

Hi Matteo,

On Tue, Sep 23, 2025 at 03:05:29PM +0200, Matteo Martelli wrote:
> Hi Aaron,
> 
> On Wed, 10 Sep 2025 17:50:41 +0800, Aaron Lu <ziqianlu@bytedance.com> wrote:
> > Before task based throttle model, propagating load will stop at a
> > throttled cfs_rq and that propagate will happen on unthrottle time by
> > update_load_avg().
> > 
> > Now that there is no update_load_avg() on unthrottle for throttled
> > cfs_rq and all load tracking is done by task related operations, let the
> > propagate happen immediately.
> > 
> > While at it, add a comment to explain why cfs_rqs that are not affected
> > by throttle have to be added to leaf cfs_rq list in
> > propagate_entity_cfs_rq() per my understanding of commit 0258bdfaff5b
> > ("sched/fair: Fix unfairness caused by missing load decay").
> > 
> > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> > ---
> 
> I have been testing again the patch set "[PATCH v4 0/5] Defer throttle
> when task exits to user" [1] together with these follow up patches. I
> found out that with this patch the kernel sometimes produces the warning
> WARN_ON_ONCE(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list); in
> assert_list_leaf_cfs_rq() called by enqueue_task_fair(). I could
> reproduce this systematically by applying both [1] and this patch on top
> of tag v6.17-rc6 and also by directly testing at commit fe8d238e646e
> from sched/core branch of tip tree. I couldn't reproduce the warning by
> testing at commmit 5b726e9bf954 ("sched/fair: Get rid of
> throttled_lb_pair()").
>

Thanks a lot for the test.

> The test setup is the same used in my previous testing for v3 [2], where
> the CFS throttling events are mostly triggered by the first ssh logins
> into the system as the systemd user slice is configured with CPUQuota of
> 25%. Also note that the same systemd user slice is configured with CPU

I tried to replicate this setup, below is my setup using a 4 cpu VM
and rt kernel at commit fe8d238e646e("sched/fair: Propagate load for
throttled cfs_rq"):
# pwd
/sys/fs/cgroup/user.slice
# cat cpu.max
25000 100000
# cat cpuset.cpus
0

I then login using ssh as a normal user and I can see throttle happened
but couldn't hit this warning. Do you have to do something special to
trigger it?

> affinity set to only one core. I added some tracing to trace functions
> throttle_cfs_rq, tg_throttle_down, unthrottle_cfs_rq, tg_unthrottle_up,
> and it looks like the warning is triggered after the last unthrottle
> event, however I'm not sure the warning is actually related to the
> printed trace below or not. See the following logs that contains both
> the traced function events and the kernel warning.
> 
> [   17.859264]  systemd-xdg-aut-1006    [000] dN.2.    17.865040: throttle_cfs_rq <-pick_task_fair
> [   17.859264]  systemd-xdg-aut-1006    [000] dN.2.    17.865042: tg_throttle_down <-walk_tg_tree_from
> [   17.859264]  systemd-xdg-aut-1006    [000] dN.2.    17.865042: tg_throttle_down <-walk_tg_tree_from
> [   17.859264]  systemd-xdg-aut-1006    [000] dN.2.    17.865043: tg_throttle_down <-walk_tg_tree_from
> [   17.876999]        ktimers/0-15      [000] d.s13    17.882601: unthrottle_cfs_rq <-distribute_cfs_runtime
> [   17.876999]        ktimers/0-15      [000] d.s13    17.882603: tg_unthrottle_up <-walk_tg_tree_from
> [   17.876999]        ktimers/0-15      [000] d.s13    17.882605: tg_unthrottle_up <-walk_tg_tree_from
> [   17.876999]        ktimers/0-15      [000] d.s13    17.882605: tg_unthrottle_up <-walk_tg_tree_from
> [   17.910250]          systemd-999     [000] dN.2.    17.916019: throttle_cfs_rq <-put_prev_entity
> [   17.910250]          systemd-999     [000] dN.2.    17.916025: tg_throttle_down <-walk_tg_tree_from
> [   17.910250]          systemd-999     [000] dN.2.    17.916025: tg_throttle_down <-walk_tg_tree_from
> [   17.910250]          systemd-999     [000] dN.2.    17.916025: tg_throttle_down <-walk_tg_tree_from
> [   17.977245]        ktimers/0-15      [000] d.s13    17.982575: unthrottle_cfs_rq <-distribute_cfs_runtime
> [   17.977245]        ktimers/0-15      [000] d.s13    17.982578: tg_unthrottle_up <-walk_tg_tree_from
> [   17.977245]        ktimers/0-15      [000] d.s13    17.982579: tg_unthrottle_up <-walk_tg_tree_from
> [   17.977245]        ktimers/0-15      [000] d.s13    17.982580: tg_unthrottle_up <-walk_tg_tree_from
> [   18.009244]          systemd-999     [000] dN.2.    18.015030: throttle_cfs_rq <-pick_task_fair
> [   18.009244]          systemd-999     [000] dN.2.    18.015033: tg_throttle_down <-walk_tg_tree_from
> [   18.009244]          systemd-999     [000] dN.2.    18.015033: tg_throttle_down <-walk_tg_tree_from
> [   18.009244]          systemd-999     [000] dN.2.    18.015033: tg_throttle_down <-walk_tg_tree_from
> [   18.076822]        ktimers/0-15      [000] d.s13    18.082607: unthrottle_cfs_rq <-distribute_cfs_runtime
> [   18.076822]        ktimers/0-15      [000] d.s13    18.082609: tg_unthrottle_up <-walk_tg_tree_from
> [   18.076822]        ktimers/0-15      [000] d.s13    18.082611: tg_unthrottle_up <-walk_tg_tree_from
> [   18.076822]        ktimers/0-15      [000] d.s13    18.082611: tg_unthrottle_up <-walk_tg_tree_from
> [   18.109820]          systemd-999     [000] dN.2.    18.115604: throttle_cfs_rq <-put_prev_entity
> [   18.109820]          systemd-999     [000] dN.2.    18.115609: tg_throttle_down <-walk_tg_tree_from
> [   18.109820]          systemd-999     [000] dN.2.    18.115609: tg_throttle_down <-walk_tg_tree_from
> [   18.109820]          systemd-999     [000] dN.2.    18.115609: tg_throttle_down <-walk_tg_tree_from
> [   18.177167]        ktimers/0-15      [000] d.s13    18.182630: unthrottle_cfs_rq <-distribute_cfs_runtime
> [   18.177167]        ktimers/0-15      [000] d.s13    18.182632: tg_unthrottle_up <-walk_tg_tree_from
> [   18.177167]        ktimers/0-15      [000] d.s13    18.182633: tg_unthrottle_up <-walk_tg_tree_from
> [   18.177167]        ktimers/0-15      [000] d.s13    18.182634: tg_unthrottle_up <-walk_tg_tree_from
> [   18.220827]          systemd-999     [000] dN.2.    18.226594: throttle_cfs_rq <-pick_task_fair
> [   18.220827]          systemd-999     [000] dN.2.    18.226597: tg_throttle_down <-walk_tg_tree_from
> [   18.220827]          systemd-999     [000] dN.2.    18.226597: tg_throttle_down <-walk_tg_tree_from
> [   18.220827]          systemd-999     [000] dN.2.    18.226597: tg_throttle_down <-walk_tg_tree_from
> [   18.220827]          systemd-999     [000] dN.2.    18.226598: tg_throttle_down <-walk_tg_tree_from
> [   18.220827]          systemd-999     [000] dN.2.    18.226598: tg_throttle_down <-walk_tg_tree_from
> [   18.220827]          systemd-999     [000] dN.2.    18.226598: tg_throttle_down <-walk_tg_tree_from
> [   18.220827]          systemd-999     [000] dN.2.    18.226598: tg_throttle_down <-walk_tg_tree_from
> [   18.276886]        ktimers/0-15      [000] d.s13    18.282606: unthrottle_cfs_rq <-distribute_cfs_runtime
> [   18.276886]        ktimers/0-15      [000] d.s13    18.282608: tg_unthrottle_up <-walk_tg_tree_from
> [   18.276886]        ktimers/0-15      [000] d.s13    18.282610: tg_unthrottle_up <-walk_tg_tree_from
> [   18.276886]        ktimers/0-15      [000] d.s13    18.282610: tg_unthrottle_up <-walk_tg_tree_from
> [   18.276886]        ktimers/0-15      [000] d.s13    18.282611: tg_unthrottle_up <-walk_tg_tree_from
> [   18.276886]        ktimers/0-15      [000] d.s13    18.282611: tg_unthrottle_up <-walk_tg_tree_from
> [   18.276886]        ktimers/0-15      [000] d.s13    18.282611: tg_unthrottle_up <-walk_tg_tree_from
> [   18.276886]        ktimers/0-15      [000] d.s13    18.282611: tg_unthrottle_up <-walk_tg_tree_from
> [   18.421349] ------------[ cut here ]------------
> [   18.421350] WARNING: CPU: 0 PID: 1 at kernel/sched/fair.c:400 enqueue_task_fair+0x925/0x980

I stared at the code and haven't been able to figure out when
enqueue_task_fair() would end up with a broken leaf cfs_rq list.

No matter what the culprit commit did, enqueue_task_fair() should always
get all the non-queued cfs_rqs on the list in a bottom up way. It should
either add the whole hierarchy to rq's leaf cfs_rq list, or stop at one
of the ancestor cfs_rqs which is already on the list. Either way, the
list should not be broken.

> [   18.421355] Modules linked in: efivarfs
> [   18.421360] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.17.0-rc4-00010-gfe8d238e646e #2 PREEMPT_{RT,(full)}
> [   18.421362] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
> [   18.421364] RIP: 0010:enqueue_task_fair+0x925/0x980
> [   18.421366] Code: b5 48 01 00 00 49 89 95 48 01 00 00 49 89 bd 50 01 00 00 48 89 37 48 89 b0 70 0a 00 00 48 89 90 78 0a 00 00 e9 49 fa ff ff 90 <0f> 0b 90 e9 1c f9 ff ff 90 0f 0b 90 e9 59 fa ff ff 48 8b b0 88 0a
> [   18.421367] RSP: 0018:ffff9c7c8001fa20 EFLAGS: 00010087
> [   18.421369] RAX: ffff9358fdc29da8 RBX: 0000000000000003 RCX: ffff9358fdc29340
> [   18.421370] RDX: ffff935881a89000 RSI: 0000000000000000 RDI: 0000000000000003
> [   18.421371] RBP: ffff9358fdc293c0 R08: 0000000000000000 R09: 00000000b808a33f
> [   18.421371] R10: 0000000000200b20 R11: 0000000011659969 R12: 0000000000000001
> [   18.421372] R13: ffff93588214fe00 R14: 0000000000000000 R15: 0000000000200b20
> [   18.421375] FS:  00007fb07deddd80(0000) GS:ffff935945f6d000(0000) knlGS:0000000000000000
> [   18.421376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   18.421377] CR2: 00005571bafe12a0 CR3: 00000000024e6000 CR4: 00000000000006f0
> [   18.421377] Call Trace:
> [   18.421383]  <TASK>
> [   18.421387]  enqueue_task+0x31/0x70
> [   18.421389]  ttwu_do_activate+0x73/0x220
> [   18.421391]  try_to_wake_up+0x2b1/0x7a0
> [   18.421393]  ? kmem_cache_alloc_node_noprof+0x7f/0x210
> [   18.421396]  ep_autoremove_wake_function+0x12/0x40
> [   18.421400]  __wake_up_common+0x72/0xa0
> [   18.421402]  __wake_up_sync+0x38/0x50
> [   18.421404]  ep_poll_callback+0xd2/0x240
> [   18.421406]  __wake_up_common+0x72/0xa0
> [   18.421407]  __wake_up_sync_key+0x3f/0x60
> [   18.421409]  sock_def_readable+0x42/0xc0
> [   18.421414]  unix_dgram_sendmsg+0x48f/0x840
> [   18.421420]  ____sys_sendmsg+0x31c/0x350
> [   18.421423]  ___sys_sendmsg+0x99/0xe0
> [   18.421425]  __sys_sendmsg+0x8a/0xf0
> [   18.421429]  do_syscall_64+0xa4/0x260
> [   18.421434]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   18.421438] RIP: 0033:0x7fb07e8d4d94
> [   18.421439] Code: 15 91 10 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00 f3 0f 1e fa 80 3d d5 92 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> [   18.421440] RSP: 002b:00007ffff30e4d08 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> [   18.421442] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb07e8d4d94
> [   18.421442] RDX: 0000000000004000 RSI: 00007ffff30e4e80 RDI: 0000000000000031
> [   18.421443] RBP: 00007ffff30e5ff0 R08: 00000000000000c0 R09: 0000000000000000
> [   18.421443] R10: 00007fb07deddc08 R11: 0000000000000202 R12: 00007ffff30e6070
> [   18.421444] R13: 00007ffff30e4f00 R14: 00007ffff30e4d10 R15: 000000000000000f
> [   18.421445]  </TASK>
> [   18.421446] ---[ end trace 0000000000000000 ]---
> 
> [1]: https://lore-kernel.gnuweeb.org/lkml/20250829081120.806-1-ziqianlu@bytedance.com/
> [2]: https://lore.kernel.org/lkml/d37fcac575ee94c3fe605e08e6297986@codethink.co.uk/
> 
> I hope this is helpful. I'm happy to provide more information or run
> additional tests if needed.

Yeah, definitely helpful, thanks.

While looking at this commit, I'm thinking maybe we shouldn't use
cfs_rq_pelt_clock_throttled() to decide if cfs_rq should be added
to rq's leaf list. The reason is, for a cfs_rq that is in throttled
hierarchy, it can be removed from that leaf list when it has no entities
left in dequeue_entity(). So even when it's on the list now doesn't
mean it will still be on the list at unthrottle time.

Considering that the purpose is to have cfs_rq and its ancestors to be
added to the list in case this cfs_rq may have some removed load that
needs to be decayed later as described in commit 0258bdfaff5b("sched/fair: 
Fix unfairness caused by missing load decay"), I'm thinking maybe we
should deal with cfs_rqs differently according to whether it is in
throttled hierarchy or not:
- for cfs_rqs not in throttled hierarchy, add it and its ancestors to
  the list so that the removed load can be decayed;
- for cfs_rqs in throttled hierarchy, check on unthrottle time whether
  it has any removed load that needs to be decayed.
  The case in my mind is: an blocked task @p gets attached to a throttled
  cfs_rq by attaching a pid to a cgroup. Assume the cfs_rq was empty, had
  no tasks throttled or queued underneath it. Then @p is migrated to
  another cpu before being queued on it, so this cfs_rq now has some
  removed load on it. On unthrottle, this cfs_rq is considered fully
  decayed and isn't added to leaf cfs_rq list. Then we have a problem.

With the above said, I'm thinking the below diff. No idea if this can
fix Matteo's problem though, it's just something I think can fix the
issue I described above, if I understand things correctly...

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f993de30e1466..444f0eb2df71d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4062,6 +4062,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (child_cfs_rq_on_list(cfs_rq))
 		return false;
 
+	if (cfs_rq->removed.nr)
+		return false;
+
 	return true;
 }
 
@@ -13167,7 +13170,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
 	 * that removed load decayed or it can cause faireness problem.
 	 */
-	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
+	if (!throttled_hierarchy(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
 
 	/* Start to propagate at parent */
@@ -13178,7 +13181,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
+		if (!throttled_hierarchy(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 }

