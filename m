Return-Path: <linux-kernel+bounces-750479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF42B15BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2572918C1FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D36279DAD;
	Wed, 30 Jul 2025 09:35:07 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E13167DB7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868106; cv=none; b=Iis6pCCBon64CNduqB/4w7j//5ReXsuU3FVG0nU3sVLmWB4HUaEoFu22saNj+kciZv67HR6qQAjEHjIYoXFybJ3CgManmJ0PqcJ9mByo6FX/GWS8uQavefDYxUZvyONXMDwKYtrk5e6eUX97r4YHA3V1BT/dVASfBEFvt9Hlu+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868106; c=relaxed/simple;
	bh=Ul0O4QgDlk8UCNwdkXN6z/QOIq9BOSolmblqo5VTi3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIYpdcP2JUCZDCME0Ocdemgh49HO06ru7loljrpgJ0/Ta3aPROkIaaXWj5w1900fynyWYKc3wtTGJqj9RExFwIikQ2HiJuBE5DgB3NYbTR8wDlNl5xwCzyBdnx38vTiP62aXTqeDBS9mprgPFtAJWkMymJB1I7yABGqJMXJT7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-88bc56adfb8so328520241.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753868102; x=1754472902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bw9ch+r6opJEUpIjpC/Dh8bkHfaHF/wvasrBSsHdMc=;
        b=s5WvPAhXA0dASYJbX1F85qu4wByXQBYw/1r1iXKAzycsUHJ/U4X7h9mKLe0I0csyW1
         b9d7JEjGsmgTT1TB48fThAwninprxw9tYDeHf/ZZGUCMqeACxtMz9izx6m0jRT5xf3PM
         R1YVQSSyGsLmoUMgjzvQVVnLmdOS2uADY6962Cw8F1njDvIv/76oooGS56w0GppEkWmk
         5aAffh9G4sA2jsuhib0iKnorMNnAxlrYxdAU+/ye4gkkFYlYnd671kMTxHDMxKUwhIw3
         0EUALN1VDKHoI2OmCp27ug1tB6kUCzfp/qReOgtMNi5bRuiIbplr1eHjUB7vpYAuAS04
         WOnw==
X-Forwarded-Encrypted: i=1; AJvYcCX/12zCf0O8Oid0zi+j0DTeAEtlVgOUDQqGzIA/QF/lc3CYKxRcmFexuCVJO1K9SyXSTVOBh8vaBsWF1XI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ALFnRe8DrpD00gA/ZgOW726ao+VwQwgaxI84eE+VwUC1T/8m
	khhWivGcsxOB1XhL47YLVmgecpmqOC0rPvggHRVAZKPs5MKFWt2Dh7HjqkskVsUz
X-Gm-Gg: ASbGncvBgRtfYv61uyPopUssw3Kq6n5qIG/xyQAmeJqXTvaelXqnaMpvHD4OQGHJCf6
	ccvMWVEU7GDozvhkU1n6MoBXWkTLMsQbUGZDfWGstI2u53te8Vwivc8eRyTyot4qcBsXyhOitiX
	4teM830V7KLA3WS2XM5LNT+O8cpUJF3dQKCiNpvJPFRSgEfnC78zlZsuOMXmXKqwYbkAsHGz8WG
	mGsBd256Sqyi4/yBHIg7zvu5qh6UYyBHgf2a64Jl6C063qEkSH96FXpkb9Y574aPi2rChE9b4P4
	Lu7xkANtpFSsAYyF66Xgsu1a9uTPluI8gnsg/ihoIPaS6vN3tj32yMNtrLqpllk+HjSDPPSIBGb
	L2p7fHLEiUV9RCeZp2gYtIzyFB61ido4g9O+gFFpw0gd1rg/yfBUOs9GUsUS6r/ltNpo57Dc=
X-Google-Smtp-Source: AGHT+IFIJcxYj4253Z6p+Yp20u9rPh88+0k8hds7D2paZPTjdthlLY1eRkbYC0ZCqG8Wlv2mFYNaXQ==
X-Received: by 2002:a05:6102:15a9:b0:4e5:9d76:e8c8 with SMTP id ada2fe7eead31-4fbe87a2aa6mr1469825137.18.1753868102390;
        Wed, 30 Jul 2025 02:35:02 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b8dcd2199sm2322376241.17.2025.07.30.02.35.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 02:35:01 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87edd8f4e9fso1556892241.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:35:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGR4w2OdDIe4KkZm9FipOVQMGCMzrkW8IR1erFKO6EtWms2OljvTS7XeuS0WHBekQCa4tMtY3AEBX0lig=@vger.kernel.org
X-Received: by 2002:a05:6102:1627:b0:4fa:58e:89c9 with SMTP id
 ada2fe7eead31-4fbe7f1e5f8mr1723113137.5.1753868100701; Wed, 30 Jul 2025
 02:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702114924.091581796@infradead.org> <20250702121158.465086194@infradead.org>
In-Reply-To: <20250702121158.465086194@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Jul 2025 11:34:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXn4z1pioTtBGMfQM0jsLviqS2jwysaWXpoLxWYoGa82w@mail.gmail.com>
X-Gm-Features: Ac12FXwKLsTXDgyNFgB_fGOTKvy3Pfg_IiJiWZaeBuDhTzV4576DeZdUaxz8VC0
Message-ID: <CAMuHMdXn4z1pioTtBGMfQM0jsLviqS2jwysaWXpoLxWYoGa82w@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] sched/deadline: Less agressive dl_server handling
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, clm@meta.com, 
	linux-kernel@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

On Wed, 2 Jul 2025 at 14:19, Peter Zijlstra <peterz@infradead.org> wrote:
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

Thanks for your patch, which is now commit cccb45d7c4295bbf
("sched/deadline: Less agressive dl_server handling") upstream.

This commit causes

    sched: DL replenish lagged too much

to be printed after full user-space (Debian) start-up on m68k
(atari_defconfig running on ARAnyM).  Reverting this commit and fixing
the small conflict gets rid of the message.

> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -701,6 +701,7 @@ struct sched_dl_entity {
>         unsigned int                    dl_defer          : 1;
>         unsigned int                    dl_defer_armed    : 1;
>         unsigned int                    dl_defer_running  : 1;
> +       unsigned int                    dl_server_idle    : 1;
>
>         /*
>          * Bandwidth enforcement timer. Each -deadline task has its
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1215,6 +1215,8 @@ static void __push_dl_task(struct rq *rq
>  /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
>  static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
>
> +static bool dl_server_stopped(struct sched_dl_entity *dl_se);
> +
>  static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
>  {
>         struct rq *rq = rq_of_dl_se(dl_se);
> @@ -1234,6 +1236,7 @@ static enum hrtimer_restart dl_server_ti
>
>                 if (!dl_se->server_has_tasks(dl_se)) {
>                         replenish_dl_entity(dl_se);
> +                       dl_server_stopped(dl_se);
>                         return HRTIMER_NORESTART;
>                 }
>
> @@ -1639,8 +1642,10 @@ void dl_server_update_idle_time(struct r
>  void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
>  {
>         /* 0 runtime = fair server disabled */
> -       if (dl_se->dl_runtime)
> +       if (dl_se->dl_runtime) {
> +               dl_se->dl_server_idle = 0;
>                 update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
> +       }
>  }
>
>  void dl_server_start(struct sched_dl_entity *dl_se)
> @@ -1663,7 +1668,7 @@ void dl_server_start(struct sched_dl_ent
>                 setup_new_dl_entity(dl_se);
>         }
>
> -       if (!dl_se->dl_runtime)
> +       if (!dl_se->dl_runtime || dl_se->dl_server_active)
>                 return;
>
>         dl_se->dl_server_active = 1;
> @@ -1684,6 +1689,20 @@ void dl_server_stop(struct sched_dl_enti
>         dl_se->dl_server_active = 0;
>  }
>
> +static bool dl_server_stopped(struct sched_dl_entity *dl_se)
> +{
> +       if (!dl_se->dl_server_active)
> +               return false;
> +
> +       if (dl_se->dl_server_idle) {
> +               dl_server_stop(dl_se);
> +               return true;
> +       }
> +
> +       dl_se->dl_server_idle = 1;
> +       return false;
> +}
> +
>  void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
>                     dl_server_has_tasks_f has_tasks,
>                     dl_server_pick_f pick_task)
> @@ -2435,7 +2454,7 @@ static struct task_struct *__pick_task_d
>         if (dl_server(dl_se)) {
>                 p = dl_se->server_pick_task(dl_se);
>                 if (!p) {
> -                       if (dl_server_active(dl_se)) {
> +                       if (!dl_server_stopped(dl_se)) {
>                                 dl_se->dl_yielded = 1;
>                                 update_curr_dl_se(rq, dl_se, 0);
>                         }
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5879,7 +5879,6 @@ static bool throttle_cfs_rq(struct cfs_r
>         struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
>         struct sched_entity *se;
>         long queued_delta, runnable_delta, idle_delta, dequeue = 1;
> -       long rq_h_nr_queued = rq->cfs.h_nr_queued;
>
>         raw_spin_lock(&cfs_b->lock);
>         /* This will start the period timer if necessary */
> @@ -5963,10 +5962,6 @@ static bool throttle_cfs_rq(struct cfs_r
>
>         /* At this point se is NULL and we are at root level*/
>         sub_nr_running(rq, queued_delta);
> -
> -       /* Stop the fair server if throttling resulted in no runnable tasks */
> -       if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
> -               dl_server_stop(&rq->fair_server);
>  done:
>         /*
>          * Note: distribution will already see us throttled via the
> @@ -7060,7 +7055,6 @@ static void set_next_buddy(struct sched_
>  static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  {
>         bool was_sched_idle = sched_idle_rq(rq);
> -       int rq_h_nr_queued = rq->cfs.h_nr_queued;
>         bool task_sleep = flags & DEQUEUE_SLEEP;
>         bool task_delayed = flags & DEQUEUE_DELAYED;
>         struct task_struct *p = NULL;
> @@ -7144,9 +7138,6 @@ static int dequeue_entities(struct rq *r
>
>         sub_nr_running(rq, h_nr_queued);
>
> -       if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
> -               dl_server_stop(&rq->fair_server);
> -
>         /* balance early to pull high priority tasks */
>         if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>                 rq->next_balance = jiffies;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

