Return-Path: <linux-kernel+bounces-740415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2607B0D3F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1921638AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19A128C5CA;
	Tue, 22 Jul 2025 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUmv8V74"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF8D288C97
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170613; cv=none; b=Agzlmhq4ed9jjgcqv3//vPtCpK373x0ZR6YLS1J5RK7+xAxP1KNYhaZpTvU0iywiYUZGJ2bthEYaZATxVsBkVb3Ea7Oc4ltsXZH98VKMDU0lvOggnT6R5kJtayOJNDNSqUj/HSG80zSysHKaTynJ64LJiQFsKeDKxwET2cC+9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170613; c=relaxed/simple;
	bh=F7sGwSxJ+uY0dcp8aVX8hlijprgZuhC9qAB3ug6ox7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnW1D7p8hclVyIn4AuP/dAJDKoowseTIHMijmHvGEw8hQP1MvO3ChuClSnKPYhOoo1WW2qgR6OAItKKcEpqRwViS75Q15gzifJEVrJpqBEYcbug5IGsCf2NE6x83bgY1Bcc+1X/ypfVxnDntqj6vcUNnoAP0UaSOlaO/EEovr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pUmv8V74; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae361e8ec32so897882666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753170609; x=1753775409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aEy+htj9Kl6cEpxrZwo8EQ1P+7DKUCHkQ4Vw9s2R4N8=;
        b=pUmv8V74CGwA+NqKirXpYgB9JzrxfJqMbBBzvhVQVrj1De5oOzvElxdKLAX0Hm9Elb
         OVMd7SMZXmWxoEa8NOIQtE2w+tFhF0/2efgznh2cY2BXk3+cstTTiNSXqS248CH6zchT
         09IgR5GTcZzQdMbdrJ7r2UaIz06Vt7YfT+h2tgHdvGYgBtoUd9LFFRAJu4y2ftfht68A
         RTwrywcQS6KiSIaWwE4s1Zecl1Pj4j9dc/8bhESrb+bfoeXdbPumnXw4xKdCdcqKW0Cp
         UXAHwj6fT82rAt72oi5KOPv5Wd4GD5pPNeMXbK5bMfCgwFXM/Ybo6fhARRz6M8TppWCV
         XjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753170609; x=1753775409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEy+htj9Kl6cEpxrZwo8EQ1P+7DKUCHkQ4Vw9s2R4N8=;
        b=pRAL1VHs3orS8B8DlSuJst6H39+WfXQ/jFoYJ7Ulilh8WBCM7pFIeQzkytQ4/AyO2x
         jqA1gCGi0TgQI/H2qXvaF6yuWoTdCop7dgmjatZbLjBkEsPFREk3d4h9Ty0NLTGXNOZY
         L6CnljskJ7Zr/x+WbGWFdlyjgQxeOFWwpw5hc/A+htNfJBhvFXs6a96neffmevXmG90Z
         RSiNjuFN35dSMScds1V0kvkIgyXX9h5Sg4lZn1lpeK8QlKRvT0BKzDL+F5O9yswSYJsh
         Xm78xO8DA8BJQ2cN0q23P2IMom9XczKFUfR3XIO8pfeXjGSmM2iy4EB3sn/CqRHtUpLz
         L2vg==
X-Forwarded-Encrypted: i=1; AJvYcCUxvc3OFpLF70cE8KgJS6jnz5hXikEmEh/YeQ0US0dviDb8T+1RcHutWbrLdvFDwzFVk/pdq8JzBwa3Eh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtR0wO7S4l78Ptev9PMoWGK6DoCm8gwxXRw5O1+1NPkpd9yZZk
	RHUuy/JfR90rY7d32SS+JiwkRhjgb/MqbgpAKRdt/apazhR1nwGbyKLaf9bU+8ReIRLuEi8s0PO
	R01t0axSItZ4EWpcZwwgj9t7EODaVufO/IPqa8V5EKQ==
X-Gm-Gg: ASbGncu65YG6BzClJ7ulH3wumYeOb/C1djjrEbDtLvyD9ptrNTVWqhB9nfEPPYXUtIt
	JpixOhMHE82a5aRZlaIuV3s7UXd71QHwJhJ9bLsu0g8KSr2oWqKqIPZ4cgCXkzoucrqC6ODvF4L
	G4HluU8dvZ9aYapHre/P0zTQWh8omXdzaOSb2VmWF0B8sLFYMENK7KSHCOzzDtaaHyKWImv07lT
	EKqdMN1VjKD8P/jpwqQMuCfpujhe4kdQH8jCJ2t
X-Google-Smtp-Source: AGHT+IE8W40zcysv8DOf3SKm537lpDBUUXhHuy2bXiGouupuXKbzYB6Rir8H10II9GvjZ9PP/E00wdBVbbDaF55jrok=
X-Received: by 2002:a17:907:7242:b0:ad5:5b2e:655b with SMTP id
 a640c23a62f3a-ae9c9a0dd3bmr2346065466b.25.1753170609131; Tue, 22 Jul 2025
 00:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721023939.19703-1-shijie@os.amperecomputing.com>
 <CAKfTPtC7+V6ubaGDPy0MW2MFG7w_yrnYCPQ-b2=3uYgeM+-+EA@mail.gmail.com> <xhsmhv7nleqfl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhv7nleqfl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 22 Jul 2025 09:49:57 +0200
X-Gm-Features: Ac12FXzr1coJOcWLnkj5sXRCeEvRrfzGIYAqVsdRM2T3DEU5LkoIbQz4vcEka0s
Message-ID: <CAKfTPtD8uF=6kr=RpduggahJRztH4DtQFQ5Q5zM6PWY8EESfxg@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: do not scan twice in detach_tasks()
To: Valentin Schneider <vschneid@redhat.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, patches@amperecomputing.com, cl@linux.com, 
	Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Jul 2025 at 13:25, Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 21/07/25 11:40, Vincent Guittot wrote:
> > On Mon, 21 Jul 2025 at 04:40, Huang Shijie
> > <shijie@os.amperecomputing.com> wrote:
> >>
> >> detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
> >> iteration count limit. It is however set without the source RQ lock held,
> >> and besides detach_tasks() can be re-invoked after releasing and
> >> re-acquiring the RQ lock per LBF_NEED_BREAK.
> >>
> >> This means that env.loop_max and the actual length of env.src_rq->cfs_tasks
> >> as observed within detach_tasks() can differ. This can cause some tasks to
> >
> > why not setting env.loop_max only once rq lock is taken in this case ?
> >
> > side note : by default loop_max <= loop_break
> >
>
> I thought so too and dismissed that due to LBF_NEED_BREAK, but I guess we
> could still do something like:
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b9b4bbbf0af6f..eef3a0d341661 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11643,6 +11643,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>                 .dst_grpmask    = group_balance_mask(sd->groups),
>                 .idle           = idle,
>                 .loop_break     = SCHED_NR_MIGRATE_BREAK,
> +               .loop_max       = UINT_MAX,
>                 .cpus           = cpus,
>                 .fbq_type       = all,
>                 .tasks          = LIST_HEAD_INIT(env.tasks),
> @@ -11681,18 +11682,19 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>         /* Clear this flag as soon as we find a pullable task */
>         env.flags |= LBF_ALL_PINNED;
>         if (busiest->nr_running > 1) {
> +more_balance:
>                 /*
>                  * Attempt to move tasks. If sched_balance_find_src_group has found
>                  * an imbalance but busiest->nr_running <= 1, the group is
>                  * still unbalanced. ld_moved simply stays zero, so it is
>                  * correctly treated as an imbalance.
>                  */
> -               env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
> -
> -more_balance:
>                 rq_lock_irqsave(busiest, &rf);
>                 update_rq_clock(busiest);
>
> +
> +               env.loop_max = min3(env.loop_max, sysctl_sched_nr_migrate, busiest->h_nr_running);
> +
>                 /*
>                  * cur_ld_moved - load moved in current iteration
>                  * ld_moved     - cumulative load moved across iterations
>

I would prefer something like below:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1b3879850a9e..636798d53798 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11702,12 +11702,16 @@ static int sched_balance_rq(int this_cpu,
struct rq *this_rq,
                 * still unbalanced. ld_moved simply stays zero, so it is
                 * correctly treated as an imbalance.
                 */
-               env.loop_max  = min(sysctl_sched_nr_migrate,
busiest->nr_running);

 more_balance:
                rq_lock_irqsave(busiest, &rf);
                update_rq_clock(busiest);

+               if (!env.loop_max)
+                       env.loop_max = min(sysctl_sched_nr_migrate,
busiest->cfs.h_nr_runnable);
+               else
+                       env.loop_max = min(env.loop_max,
busiest->cfs.h_nr_runnable);
+
                /*
                 * cur_ld_moved - load moved in current iteration
                 * ld_moved     - cumulative load moved across iterations

