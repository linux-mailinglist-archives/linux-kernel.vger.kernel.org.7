Return-Path: <linux-kernel+bounces-739001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3EB0C076
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F469189549C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60028C5A1;
	Mon, 21 Jul 2025 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+2+NKEE"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B361E50B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090867; cv=none; b=Gc6SXVbjO4kqfaLxjCe6ZuTA6dlWVNHR5dhBLr6ZsaI9HAuYSOnEdoijQtUGCqqah3dSYgwKpdnbyWHEqXdxq6XdTHysxlj0OEhS+o9u0PBjc3dqknBjOe1IZVZY5KKKGtFNl0ediEsphTHx8yDciA7xhGRcZd/zMc+b0X3v39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090867; c=relaxed/simple;
	bh=rqdEgD83J8iSzUNe7YgGx88uvb9b4GF6r9ZsVKjFd6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFqxYTc53sJ3iw5agWVw5LMDv2y1tmmNO8XOqjHNCp4jkVNpweUaSycyxeWQiC7udf5c0Ro1dWdrlIzbs3TQFg/zbHGEB3B8ZDhCoGl0zrxwbOR0g0p4/pAHk/+BC4ygihztMH1V7FKIFkbRwoyl0A5WYJntaVDoJ+V1xTYCDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+2+NKEE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso7878152a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753090864; x=1753695664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kLHZQ8wbyNwUVTj57cdtnbIVhJCFkeSVcy7WyOu42oQ=;
        b=A+2+NKEE6hIi5cyLtwxwwqEzO1/UbyDr04rIs6KDhG/cDQW9Oa0dxoPGEtnzYX9Myg
         faKDy0suT1wUokETGMUxJUNlTCREs9+F8cRDkQ5kv2y3eUt5ZubGCZeUJ46YL8m/0ONr
         FDbBF8XOR6lv328kgVS+hjl+VfVS/F9x8FvgBcm0mykobdOUEHwmztHGLrIIf7pyib4s
         Y/noi3By29SBSAdw3BkgErqLup0fqagotM6BW141ZRE6VXJnOxKv+hLjykeZS+aGkTpS
         +gbYYZ1+rh+hIPecv2JKGibp0+X8aNpEmwahwtpA99bc/lgBtJn/gWza7EqneH8af4Uu
         Y7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753090864; x=1753695664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLHZQ8wbyNwUVTj57cdtnbIVhJCFkeSVcy7WyOu42oQ=;
        b=um1D73UjRKdNUKYAHLe9v+dw8kJRMSn0XoXvRLO3UQDrCse+OuwSGkJqRaYKLlmQp8
         gd70gVyDxcT7C4f3zjJZHFKEVnhAhsFO3WJGqZvvD+QiFl7JAB2eD25jJZadxA8/rldp
         /n9H7/Ha3gAR5321CM0icAtkU+QBKxogKsyAXlTm0k4KS1RzQaBmFlS0NByBcLZkniFn
         rmPv8caRtDJ/PgDOLx+7VpoUvTqv/+nzXTDM6CxFTDQMmK9KDSBRN+zuOxFvPmzk7hLT
         lLwTrdlMUtHAhZuM5cFqZsRSXoMKFij8PWE6D/tJU2ilirpr+iI7WHH074DJtOMexa0F
         J7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCV7MsirM24F9qYf2MAdypBA4xifRy/DBhTfkhniIVcMPwJy3OyvnBCb/GC3bP6oz1AI88BfQKr24S4xFQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNpVHD6nqfostmAiUWuhQ2ogrBEISxZk4cgJZyPRiwP3o6gYO
	5Up+535Znfwe/LAJrKc8kPVLS4M35kWJXU/LuTVWW9vbQlzpLKx++XrtMSiwjMvxT6O58mC5w02
	FTuGI9F4C1ZeMWCGFwTDXns6rBmyDTSag6Ttaq6MHSQ==
X-Gm-Gg: ASbGncsIdknuTceE4S55HQDJEjZbq0XO93WiL5CUgZjgpSclcP3y/7/zrBouVvMbV4B
	CHRYPM9Tg4vPARrghw1KQA/pVT7ukTkkVXG7piTnG7vA3+3LVFX84PBErfMkdR2igfp9xFbdnBZ
	6nBfktP/mv0moUitGBFbFqF5musmTfCAfnXfNM36viBOuOb1eueVMWrrWvn9G5nUz2ZYOkf8E2R
	ox2AdQkclbw0DDuyaj5VAVmJSZ7JCbLEig86bv7
X-Google-Smtp-Source: AGHT+IG6G4ajdssc/YWvwb9of7mOBV21SiBFjpYyYjNuNDmhGrvw93kvZgBti4flreJEZuk1BBVKlt2cdJLcRSLQLiU=
X-Received: by 2002:a17:907:7ba0:b0:ae3:4f80:ac4c with SMTP id
 a640c23a62f3a-ae9cdd834fdmr1817176966b.12.1753090863631; Mon, 21 Jul 2025
 02:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721023939.19703-1-shijie@os.amperecomputing.com>
In-Reply-To: <20250721023939.19703-1-shijie@os.amperecomputing.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 21 Jul 2025 11:40:52 +0200
X-Gm-Features: Ac12FXzI1MXGDPatOw9rK3i3bzvmCgizdoo_IQxX5D7JpnwWUeRBGbICAxLwpLA
Message-ID: <CAKfTPtC7+V6ubaGDPy0MW2MFG7w_yrnYCPQ-b2=3uYgeM+-+EA@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: do not scan twice in detach_tasks()
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vschneid@redhat.com, patches@amperecomputing.com, cl@linux.com, 
	Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Jul 2025 at 04:40, Huang Shijie
<shijie@os.amperecomputing.com> wrote:
>
> detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
> iteration count limit. It is however set without the source RQ lock held,
> and besides detach_tasks() can be re-invoked after releasing and
> re-acquiring the RQ lock per LBF_NEED_BREAK.
>
> This means that env.loop_max and the actual length of env.src_rq->cfs_tasks
> as observed within detach_tasks() can differ. This can cause some tasks to

why not setting env.loop_max only once rq lock is taken in this case ?

side note : by default loop_max <= loop_break

> be unnecessarily iterated over more than once, for instance:
>
>   env.loop_max := 4
>   detach_tasks()
>     // Here env.src->cfs_tasks only contains two tasks which can't be
>     // migrated anywhere, so they're put back in the list each time.
>     env.src->cfs_tasks := [p1, p0]
>     // The iteration goes:
>     p0; cfs_tasks := [p0, p1]
>     p1; cfs_tasks := [p1, p0]
>     p0; cfs_tasks := [p0, p1]
>     p1; cfs_tasks := [p1, p0]
>
>     // IOW we iterate over each task twice
>
> In the Specjbb test, the similar issues can be caught many times.
> (Over 330,000 times in a 30-minites Specjbb test)
>
> The patch introduces "first_back" to record the first task which
> is put back to the task list. If we get a task which is equal to
> first_back, we break the loop, and avoid to scan twice for it.
>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
> v3 --> v4:
>     Changed the commit message suggested by Valentin Schneider.
>     v3: https://lore.kernel.org/all/20250718063523.9232-1-shijie@os.amperecomputing.com/
>
> v2 --> v3:
>     Fix a typo in the commit message.
>     v2: https://lore.kernel.org/all/20250718054709.8781-1-shijie@os.amperecomputing.com/
>
> v1 --> v2:
>     Add more comment from Valentin Schneider
>     v1: https://lore.kernel.org/all/20250707083636.38380-1-shijie@os.amperecomputing.com/
> ---
>  kernel/sched/fair.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7e2963efe800..7cc9d50e3e11 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9443,6 +9443,7 @@ static int detach_tasks(struct lb_env *env)
>  {
>         struct list_head *tasks = &env->src_rq->cfs_tasks;
>         unsigned long util, load;
> +       struct task_struct *first_back = NULL;
>         struct task_struct *p;
>         int detached = 0;
>
> @@ -9481,6 +9482,12 @@ static int detach_tasks(struct lb_env *env)
>                 }
>
>                 p = list_last_entry(tasks, struct task_struct, se.group_node);
> +               /*
> +                * We're back to an already visited task that couldn't be
> +                * detached, we've seen all there is to see.
> +                */
> +               if (p == first_back)
> +                       break;
>
>                 if (!can_migrate_task(p, env))
>                         goto next;
> @@ -9562,6 +9569,8 @@ static int detach_tasks(struct lb_env *env)
>                         schedstat_inc(p->stats.nr_failed_migrations_hot);
>
>                 list_move(&p->se.group_node, tasks);
> +               if (!first_back)
> +                       first_back = p;
>         }
>
>         /*
> --
> 2.40.1
>

