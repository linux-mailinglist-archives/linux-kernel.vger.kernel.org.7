Return-Path: <linux-kernel+bounces-817857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F803B58788
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3C52A3445
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17192D191C;
	Mon, 15 Sep 2025 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xdp7XeWm"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E919D21ABB1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975367; cv=none; b=jMBegjAZyPMSsTYlKwwTjblYxb9iAoghSFgAv9oJktxRE6KhoI1M/7ko9x9dRWQWG4zRAFuefOp0yb6jqP5DTNZ6dqXxQf9FRYPVs6spvbjWnNtmaAocnWTMZLYLT3sxQb+dZ9Mkjvs5joA9X2Kl6CvOETWxHEOaEL2ybZfWTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975367; c=relaxed/simple;
	bh=NOf9G5hW1B+m2UtZv13eOsf0ejLlVWGd6BQGhgChIF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4tBPTvOiJFSUDvEqAD8L35uadx5jvcYS0W2oTYdkr5NQP5Uq0MIGbKszFflE2XovWxAXaHfpgJhfpSW7AhsiXm4w5rndB34fvsYJhFxxSgyF8uHmXDL2fRUHIYckCQum7vBZF4GM85eyQcrbDS9o3GRhCEflwaNpge7ZsR+FMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xdp7XeWm; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5607a240c75so4856361e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757975364; x=1758580164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D76hj/+1SdBYr5PchTl9OnwqQor+ON5VVPH4155kxo=;
        b=Xdp7XeWm3tx770GwrAlVHNUwuwDlVX70A/hUonwb6RXkCaWnWETPaXnEVWbEBtX5o5
         zWQbkUUnzR071KcRiI6gmprY/iaESTHJ9w5YyEhhrZBJa+4FDeeuQ2RFyc6b3VVCcPM0
         QegGiyXde956pd7nVv/lU/1AEESfieS6F9/7FYHrT2PugpdUO572g7S/AfIZoRa0C84s
         xeoLPOS94COqC3LcI6doYGO1fmf7s0BUMB8QphNanrZyYU7piaOftgub10ssJRZPrApL
         yWrdbOn2ctFDkfazCmJt6FofAU5+WepamPIOlRixOGb/XHnrir3VyElLDtcTOCACiLW5
         AVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757975364; x=1758580164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5D76hj/+1SdBYr5PchTl9OnwqQor+ON5VVPH4155kxo=;
        b=jdTJsezlY6VcV8pwL0OAepo30YvOJmWHEi0av4JGtNXbsIkCH7YqO0lE09w19zKZd5
         7QNOBswUjINvs9oDn6xugkvcGh0rKPC6lPvspDbLPCfDoiPtqiDva8JB5IFqX7l+NXfX
         dWnaDs5KJVIdnJlz/DMHf+aJfBeRCDMti/DVwtJyNCXEmUfaW7FGNmYLEk9nF/CvEYzz
         mFK4FqlR8QRjW8czocJ84ZbUI6HGFJ/FUhITGzKymlB/5FcxwvMY8o0DKF5TUlPzFoDT
         ad/CLFQ/8w4OC3+1R0vWuHe5EVYz1PV1zKksvXi2vcG8xzkiVkJC+3ZO8t8lYj4jxjTs
         ye6w==
X-Forwarded-Encrypted: i=1; AJvYcCUA/GoYa6sa0yZg9HMKgV07ul0fbA5LRwi9GYb10Mm2pZmUm3nERSB7Koi7FuAG/jNabv11lVaSXYyD3aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUyoDHj0pojwli9yEBuIoelVO4OW6TdUSNkGoMs/nzR7GsJSs
	zCWjdCB+rKvvG0f0/fXKi94PaCeO7WBcOsaOVf8ENTwBkDcjPHx38A+pv5XWK9l85PV5tpFAzGM
	TVUCVOc68nUQa20L0lgQfWff8RHe/Wa98aqznW/4=
X-Gm-Gg: ASbGncvkDTAIWTS9vylPD8Bz5pfbAq5kN0FZRnEetvnNKdKfI+FROGnS87QveXLo53o
	fts6u3qnuiVTGbfb8mqvvxVqWH52skCmT+oFY2MnevRyviOwphHXT5gQbIpn35ofDnr2JYesCUY
	UevA9WsYc8B7ha7JIWHcrrklCL7B9yPvqvs3/jTuuChE/9J96twHurvNcOAakunuhLLR4KsVxeu
	WhWa8cPL1b78xhE0GYoEMNgftdYNjA7i8WLVY4/LZBYE1d8ofO3HkNLpio1ipE=
X-Google-Smtp-Source: AGHT+IFbFZ25DgRoGEzRyqdMGXRqriDFI1d0OMCzh5rfvRDo5F9p3+CnPrut39V4RNPhxtUrL1SU7FHk307ouB731RI=
X-Received: by 2002:ac2:4e13:0:b0:55f:639b:8057 with SMTP id
 2adb3069b0e04-5704824ed69mr4526663e87.4.1757975363402; Mon, 15 Sep 2025
 15:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702114924.091581796@infradead.org> <20250702121158.465086194@infradead.org>
In-Reply-To: <20250702121158.465086194@infradead.org>
From: John Stultz <jstultz@google.com>
Date: Mon, 15 Sep 2025 15:29:10 -0700
X-Gm-Features: AS18NWDyNgrLkbYG-dwAKr76PYAqIH90yggHmcRmrK41k6dWI7jNkokevQAxdSI
Message-ID: <CANDhNCpDW-fg6DK8Wcgwq-1fgaYSkxL1G6ChUkC4K6Mpk04aEQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] sched/deadline: Less agressive dl_server handling
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, clm@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 4:49=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> Chris reported that commit 5f6bd380c7bd ("sched/rt: Remove default
> bandwidth control") caused a significant dip in his favourite
> benchmark of the day. Simply disabling dl_server cured things.
>
> His workload hammers the 0->1, 1->0 transitions, and the
> dl_server_{start,stop}() overhead kills it -- fairly obviously a bad
> idea in hind sight and all that.
>
> Change things around to only disable the dl_server when there has not
> been a fair task around for a whole period. Since the default period
> is 1 second, this ensures the benchmark never trips this, overhead
> gone.
>
> Fixes: 557a6bfc662c ("sched/fair: Add trivial fair server")
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20250520101727.507378961@infradead.org

So I know this patch has already had a couple of issues reported against it=
:
  [1] "sched: DL replenish lagged too much" warnings
  [2]  changing server parameters break per-runqueue running_bw tracking
  [3] dl_server_stopped() should return true if dl_se->dl_server_active is =
0.

In fact, I reported [4] some trouble with one stress test
(ksched_football) I've been developing with the proxy-exec series
getting stuck because of the behavior change this brought. And while
I'm open to my test being problematic (it tries to generate 5*NR_CPU
spinning RT tasks, which starves kthreadd and with this change causes
the dl_server to only let one thread be spawned per second) it still
seemed concerning (as before this change the dl_server and
rt_throttling would let us generate the RT tasks faster - though that
may have been unintentional, I've not gotten my head totally around
the previous behavior, and unfortunately got distracted with other
work).

But separately testing out Peter's new cleanups for sched_ext (without
my problematic test), I started tripping over workqueue lockup BUGs in
certain situations, and I've found I can reproduce these pretty easily
with vanilla v6.17-rc6 alone (which includes the fixes for the
reported issues above).  I don't have CONFIG_SCHED_PROXY_EXEC enabled
for this.

If I run a 2 cpu qemu instance with locktorture enabled, booting with
the cmd arg:
"torture.random_shuffle=3D1 locktorture.writer_fifo=3D1
locktorture.torture_type=3Dmutex_lock locktorture.nested_locks=3D8
locktorture.rt_boost=3D1 locktorture.rt_boost_factor=3D50
locktorture.stutter=3D0 "

Within ~7 minutes, I'll usually see something like:
[   92.301253] BUG: workqueue lockup - pool cpus=3D1 node=3D0 flags=3D0x0
nice=3D0 stuck for 42s!
[   92.305170] Showing busy workqueues and worker pools:
[   92.307434] workqueue events_power_efficient: flags=3D0x80
[   92.309796]   pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 r=
efcnt=3D2
[   92.309834]     pending: neigh_managed_work
[   92.314565]   pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D4 r=
efcnt=3D5
[   92.314604]     pending: crda_timeout_work, neigh_managed_work,
neigh_periodic_work, gc_worker
[   92.321151] workqueue mm_percpu_wq: flags=3D0x8
[   92.323124]   pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 r=
efcnt=3D2
[   92.323161]     pending: vmstat_update
[   92.327638] workqueue kblockd: flags=3D0x18
[   92.329429]   pwq 7: cpus=3D1 node=3D0 flags=3D0x0 nice=3D-20 active=3D1=
 refcnt=3D2
[   92.329467]     pending: blk_mq_timeout_work
[   92.334259] Showing backtraces of running workers in stalled
CPU-bound worker pools:


And this will continue every 30 secs with the stuck time increasing:
[ 1411.472533] BUG: workqueue lockup - pool cpus=3D1 node=3D0 flags=3D0x0
nice=3D0 stuck for 1361s!
[ 1411.476404] BUG: workqueue lockup - pool cpus=3D1 node=3D0 flags=3D0x0
nice=3D-20 stuck for 1345s!
[ 1411.480214] Showing busy workqueues and worker pools:
[ 1411.482939] workqueue events_power_efficient: flags=3D0x80
[ 1411.486171]   pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D6 r=
efcnt=3D7
[ 1411.486220]     pending: crda_timeout_work, neigh_managed_work,
neigh_periodic_work, gc_worker, reg_check_chans_work, check_lifetime
[ 1411.497091] workqueue mm_percpu_wq: flags=3D0x8
[ 1411.499829]   pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 r=
efcnt=3D2
[ 1411.499878]     pending: vmstat_update
[ 1411.506010] workqueue kblockd: flags=3D0x18
[ 1411.508689]   pwq 7: cpus=3D1 node=3D0 flags=3D0x0 nice=3D-20 active=3D1=
 refcnt=3D2
[ 1411.508738]     pending: blk_mq_timeout_work
[ 1411.515311] workqueue mld: flags=3D0x40008
[ 1411.517764]   pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 r=
efcnt=3D2
[ 1411.517813]     pending: mld_ifc_work
[ 1411.523923] Showing backtraces of running workers in stalled
CPU-bound worker pools:

I bisected it down to this commit cccb45d7c4295 ("sched/deadline: Less
agressive dl_server handling"), and I found that reverting just the
dequeue_entities() changes (last two chunks of this patch), resolves
the lockup warnings.

That revert *also* resolves my ksched_football test problem, but I
suspect it's also because that change is the main point of this patch
(getting the costly dl_server_stop() out of the frequently used
dequeue_entities() path).

Now while locktorture will keep the cpu busy, it usually bounces
around a fair bit, but when I see the lockup warnings, it
lockturture_writer usually is pinning one cpu and stays that way,
where as with the revert I don't see things getting stuck running on
one cpu.  Adding a trace_printk() to __pick_task_dl() when we pick
from a dl_server, shows the dl_server running and picking tasks for
awhile, but then abruptly stopping shortly before we see the lockup
warnings, suggesting the dl_server somehow stopped and didn't get
started again.

From my initial debugging, it seems like the dl_se->dl_server_active
is set, but the dl_se isn't enqueued, and because active is set we're
short cutting out of dl_server_start(). I suspect the revert re-adding
dl_server_stop() helps because it forces dl_server_active to be
cleared and so we keep the dl_server_active and enqueued state in
sync.   Maybe we are dequeueing the dl_server from update_curr_dl_se()
due to dl_runtime_exceeded() but somehow not re-enqueueing it via
dl_server_timer()?

So I am still digging into it, but I do think there's something still
amiss with this change.  If there's anything I should try to further
debug this, do let me know.

thanks
-john


[1] https://lore.kernel.org/lkml/CAMuHMdVPR7Q7pvn+QqGcq2pJ00apDgUcaCmAgq6nn=
M1uHySMcw@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20250721-upstream-fix-dlserver-lessaggress=
ive-b4-v1-1-4ebc10c87e40@redhat.com/
[3] https://lore.kernel.org/lkml/20250809130419.1980742-1-chenhuacai@loongs=
on.cn/
[4] https://lore.kernel.org/lkml/CANDhNCo+G4_t8jYU-QNPz42uZsKdMgEmTnr8pYSKb=
gm26NJUCg@mail.gmail.com/

