Return-Path: <linux-kernel+bounces-818404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B71AB5914D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764C27AD5A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B3286890;
	Tue, 16 Sep 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTj64ywi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04841D63F7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012704; cv=none; b=kpV//A53L6JGi6Pa3EuxQRMDgQFiR+xI2sfSqAA2AwYPowk7DwTL1jAe4eAbfVkn0YVoKwz8lKi6awCMijTnL8BFG8btLyhJBIDv1m3sknIn6qrKqVJbgutE/SXc2nY1ADku4mr/wmemBJ/rnziW9a9gw6x76y7f4EPFvEnFE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012704; c=relaxed/simple;
	bh=SwOnDBRWryAzn1xoDTpeWQRuXOIwyB8LuH/p08oBAH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOR2KR18sQFqzs27hM7QccUsPdHaxLvUZQcSnFaJxZ0TpZSCXlML9vbR8mwGP3BRLX3g2dLzfKQha59fd8mszDHZgZamsfl2pVYaTrLLPb+BZB44TZg7sEJ/C2OWuOb+pPiSO7ISGSHCAt24fEC47cK4nxxTbgMY+Ch+F3qiPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTj64ywi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758012701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3QE5SGIIxZSoTDqWETp8XS9cZuIc68SQ4/v2jnlzuo=;
	b=RTj64ywi1ySgWo5rnmrPfyWPcdXvTIlO4u1WYufp29rbPfSe6r3jJOVvUMlVFNJl4TxyIF
	k5S0zKJHv+NY9bcooujcRbqpWEtDAybjX/FPYJWMwJa2WAubjwie3xwpeoQFx1UTRROV1i
	ymAcI0tVl2aYZMEjQYVyqvsXjNokh4Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Gp7lLEyUO-yIihOg_NqmPw-1; Tue, 16 Sep 2025 04:51:40 -0400
X-MC-Unique: Gp7lLEyUO-yIihOg_NqmPw-1
X-Mimecast-MFC-AGG-ID: Gp7lLEyUO-yIihOg_NqmPw_1758012699
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso20295265e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758012699; x=1758617499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3QE5SGIIxZSoTDqWETp8XS9cZuIc68SQ4/v2jnlzuo=;
        b=VfcF59zqZ7xhZvFvqB3g/flpe3gkHAklZeBxyXNfvX6xlS3ZQ2164h0RjGNrkAg2Rt
         8SeO/RF+F7KlMbtVHtWNGJ98bi+Ky1maQrZtF9TWCxpQa42boBN9YeiRTTpafivJNeM6
         s0NiIqTyubiLXsVhgfsKMnMgsGXg235+8bcSQJ/bcl/4hXMv3VEy6wzbtP5o2pKjFNtz
         fxvdyJPCpOeSPDms8PRogXGplyuThovHVfNwnW7m+Cz7XCH5iMcSQEy36XD45Au53pF0
         AtZ7ps4/WaLEFnZHFvqzrmOz3QNOVHl7PMhI1OhsLzrtMhY+Gj0WYgecf8t1udGrjK9x
         vlag==
X-Gm-Message-State: AOJu0YzG1YcdykhTdNNU9fF4BqXz6DprrrOa0XWrDa3NRvE1KLONZvQV
	PFss0Lp4CDB2ZshmGEea3W7y1Zb15ZA7GK2ovxUUdMrE9NVw9sHpAh30fsDPhpS4vjKFk1OT0vJ
	phYusBOFQg752xNdCW00g16/eVJAcf8XX3yJZB8DkZ9jWn2KsEyOeN4PLKpCrpwq65Q==
X-Gm-Gg: ASbGncsD5JO8CS1mFN2dlhFpLUtXh8RIMN1GPqj70aC6+ndcGeaIXwqdGosQRPZ7ja5
	vepaYkZ3jxoYsbF7ZMy4NEgSs80l7DmwO8BptWIFv9AY19R/IErNeCCYILPV04NJrhZlbHyFXXO
	omFORb/6VhYSf0h+M4T++0zTE/gbsAKBU8jixLRBJtlppc4gl7YSBc25MQR2RAfqLJ+jfEvMUut
	SXo7NQZ8FaMve7vT6L5qDQ87lLOHhRLkA79dJ2JzBBdIadrXeV4n02rzngXnvTiRje8eoPeqUjJ
	WSBNUEuaHBgPt+XVnNo1H7XMBejgoqDEMai3ZTUiP4QgdeekiJF7qMCYM+2rTak1GS0KVac=
X-Received: by 2002:a05:600c:1c0f:b0:45f:29b2:7617 with SMTP id 5b1f17b1804b1-45f29b277famr90005675e9.11.1758012699164;
        Tue, 16 Sep 2025 01:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzglKbrPgNnAoPxpw97CL7hwPOku5bY4CUjjoZ4QtYOA443vjBE0b7xkMK4NE4ZjTrmX3dQQ==
X-Received: by 2002:a05:600c:1c0f:b0:45f:29b2:7617 with SMTP id 5b1f17b1804b1-45f29b277famr90005345e9.11.1758012698674;
        Tue, 16 Sep 2025 01:51:38 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f3262f6aesm11937825e9.8.2025.09.16.01.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:51:37 -0700 (PDT)
Date: Tue, 16 Sep 2025 10:51:34 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Qais Yousef <qyousef@layalina.io>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck,
 allowing cpu starvation
Message-ID: <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
 <20250916052904.937276-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916052904.937276-1-jstultz@google.com>

Hi John,

Thanks a lot for looking into this!

On 16/09/25 05:28, John Stultz wrote:
> With 6.17-rc6, I found when running with locktorture enabled, on
> a two core qemu VM, I could easily hit some lockup warnings:
> 
> [   92.301253] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 42s!
> [   92.305170] Showing busy workqueues and worker pools:
> [   92.307434] workqueue events_power_efficient: flags=0x80
> [   92.309796]   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
> [   92.309834]     pending: neigh_managed_work
> [   92.314565]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=4 refcnt=5
> [   92.314604]     pending: crda_timeout_work, neigh_managed_work, neigh_periodic_work, gc_worker
> [   92.321151] workqueue mm_percpu_wq: flags=0x8
> [   92.323124]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
> [   92.323161]     pending: vmstat_update
> [   92.327638] workqueue kblockd: flags=0x18
> [   92.329429]   pwq 7: cpus=1 node=0 flags=0x0 nice=-20 active=1 refcnt=2
> [   92.329467]     pending: blk_mq_timeout_work
> [   92.334259] Showing backtraces of running workers in stalled CPU-bound worker pools:
> 
> I bisected it down to commit cccb45d7c429 ("sched/deadline: Less
> agressive dl_server handling"), and in debugging it seems there
> is a chance where we end up with the dl_server dequeued, with
> dl_se->dl_server_active. This causes dl_server_start() to
> return without enqueueing the dl_server, thus it fails to run
> when RT tasks starve the cpu.
> 
> I found when this happens, the dl_timer hrtimer is set and calls
>  dl_server_timer(), which catches on the
>   `if (!dl_se->server_has_tasks(dl_se))`
> case, which then calls replenish_dl_entity() and
> dl_server_stopped() and finally returns HRTIMER_NORESTART.
> 
> The problem being, dl_server_stopped() will set
> dl_se->dl_server_idle before returning false (and notably not
> calling dl_server_stop() which would clear dl_server_active).
> 
> After this, we end up in a situation where the timer doesn't
> fire again. And nothing enqueues the dl_server entity back onto
> the runqueue, so it never picks from the fair sched and we see
> the starvation on that core.

Because dl_server_start() returns early if dl_server_active is set.
 
> So in dl_server_timer() call dl_server_stop() instead of
> dl_server_stopped(), as that will ensure dl_server_active
> gets cleared when we are dequeued.
> 
> Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> NOTE: I'm not confident this is the right fix, but I wanted
> to share for feedback and testing.
> 
> Also, this resolves the lockup warnings and problematic behavior
> I see with locktorture, but does *not* resolve the behavior
> change I hit with my ksched_football test (which intentionally
> causes RT starvation) that I bisected down to the same
> problematic change and mentioned here:
>   https://lore.kernel.org/lkml/20250722070600.3267819-1-jstultz@google.com/
> This may be just a problem with my test, but I'm still a bit
> wary that this behavior change may bite folks.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: kuyo chang <kuyo.chang@mediatek.com>
> Cc: hupu <hupu.gm@gmail.com>
> Cc: kernel-team@android.com
> ---
>  kernel/sched/deadline.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index f25301267e471..215c3e2cee370 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1152,8 +1152,6 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
>  /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
>  static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
>  
> -static bool dl_server_stopped(struct sched_dl_entity *dl_se);
> -
>  static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
>  {
>  	struct rq *rq = rq_of_dl_se(dl_se);
> @@ -1173,7 +1171,7 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
>  
>  		if (!dl_se->server_has_tasks(dl_se)) {
>  			replenish_dl_entity(dl_se);
> -			dl_server_stopped(dl_se);
> +			dl_server_stop(dl_se);
>  			return HRTIMER_NORESTART;
>  		}

It looks OK for a quick testing I've done. Also, it seems to make sense
to me. The defer timer has fired (we are executing the callback). If the
server hasn't got tasks to serve we can just stop it (clearing the
flags) and wait for the next enqueue of fair to start it again still in
defer mode. hrtimer_try_to_cancel() is redundant (but harmless),
dequeue_dl_entity() I believe we need to call to deal with
task_non_contending().

Peter, what do you think?

Thanks,
Juri


