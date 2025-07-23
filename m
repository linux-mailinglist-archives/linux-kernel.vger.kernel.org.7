Return-Path: <linux-kernel+bounces-742012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3705B0EBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69023A63C8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959E277003;
	Wed, 23 Jul 2025 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzBMhdzv"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E361B13D8B1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255835; cv=none; b=DbPJNfrFg2cAIxLJcu3PLfN3pNn7ztjCbJV1I5fqlnydyqiQUFR+zLyHTI8tYna32cgiWVH8qzzmSSLWvJwouljxpxwZoEEuxI5TWfx2EfupnVj2k+ooto8vjb0nkXwI0NRGmXwR6DARgVj3s58nRFXRTae4+8USPrCBs9+rUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255835; c=relaxed/simple;
	bh=SUZ/lceqFHZOGd9EpBzSIk/aJG1icJS2YMhbagHGBKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ybw6ZHGwKG+/SteTfsNu+NPje26HffL1xVttZqHoCmtaXebi7q2+WbGdrDJRGhlnCV0qQxSSt2Hz8/5oiT9CoG6IUq4pwpzxYOrJFeLAjCTpwxUqi9DvElCnPImX1Gxshh2UydwGz//gQRybB2sY8cGfb2Z8CFehSFLVKswf+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fzBMhdzv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so11780181a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753255832; x=1753860632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tPGctgIslaWsLlxT/I9dhnURLXll1gv7MJQ122jo65o=;
        b=fzBMhdzvwswC3IKAt44jh9TQs0J/o7jGSDmyOkNgfTr/br5wux+YRZirri48tu6DYV
         aoXpGWe3OG79vAKecprdz5aZP2tLLn7boe4s/y5VOIaFlhsogZeVBy8tQlnezxoogVH6
         AMgxq1JZ9XngAdwIvD5fO436aL7nWsZMek0kllPz6f/ANpIbEEX3hhoUGvkvZJhy6SR5
         q0aX0bOuB8lexh5oEnziM9iZtKpkPWNGZckMlxbvcvSHShDHXfLwMfHAxGdicj/QZTXi
         xfBxizYJBi5OSXIXLCSq+URCNIkNep3Kc7TpG8yw8Y4FBpWPozNRrpWVTs75I5yMuXZc
         d74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753255832; x=1753860632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPGctgIslaWsLlxT/I9dhnURLXll1gv7MJQ122jo65o=;
        b=OHWydvjC1nU6B7yAhBg5yN84onEYVQJiOAa+wFAsMRLhUHelCBWKNNNZk4ss6msQrs
         yiQrL1hMDgTDDGz9SFmc/n2HwXPxkjC4nDRmvdBaXIUnCbgR53BJN54mBpc5Xu0VWDPD
         hdu6U2XaLADhFSYHig3qH58B+T6Nu94zgKW2vL2WzI1d/tZ6ve4OkjXcWwR7cXRUYhEr
         g2v2rIAGJr8s0MkiR5HVDrpNNfw2Rq86od+baNxGBRsk97j2pdiV6XCUmvhWo9wGTioV
         d++ozwl4nM+yKY4Xpsi+YGoWN2KG3pJHTpAt7qYqfx7iAI7VAyHcmu87mjR7j7nJ70v0
         eKKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqYVJV5XYaGFugHvQs5bQY9PtsD2OLbWusVcc2ktDfo4YHGq8kj0TqsZ7rt/9sZOc5WB/BMi+SWfxElB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3XdbzmPQ5orwrUtNEZQLADdZDdJ64cvFHzSXOyHjUzcNBh6M
	/yBnYcC/OSyv4wkJpYT4RJWk6tSZWGjhZj69Jp6y0XRg8W+3FeFO+9CuH2ALY3SdgJ7ov0j5rYD
	6w4nTSAJx2EBn/gTDvd437rF7TjVVRj+xKKjfqeKgKQ==
X-Gm-Gg: ASbGncskmyDJ/bdQg0P9+JYnCaLi87j/vVJXKvgoYCsEGdO0jcA7Q1Q55h0Be19Dag4
	lk4SKxnff8RuD6lWCR01FoPjrpEIT0mjcNH1iIlO3Zp+gY6IzpHTSCVpKVBnK5JMW0lDWPOfQ08
	uIsP36nmuBnJLbuZfDzgqKUdni7O8syUwN2fdoH+MUYZhhoopwQfUTPePuf9z9SXqRVi7FkQLEb
	HunkBihkJLUj/u9jfEsdseTkQc61c2NcJ9CZweu2g==
X-Google-Smtp-Source: AGHT+IE9GDWSe7nolzOM0is3U3VI71op2RDPDZQVKnedUQ13wkzgs+RiB+lGoScy3ZLG0S+dviJXLlenVr+UzF0CoU0=
X-Received: by 2002:a17:907:ea7:b0:ae1:f1e0:8730 with SMTP id
 a640c23a62f3a-af2f927b1b9mr184142366b.57.1753255831966; Wed, 23 Jul 2025
 00:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722102600.25976-1-shijie@os.amperecomputing.com>
In-Reply-To: <20250722102600.25976-1-shijie@os.amperecomputing.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 23 Jul 2025 09:30:18 +0200
X-Gm-Features: Ac12FXw5xX_Kpc66q3zNLbsl8KOKq0ttSsFQJ9kcqn3HCn1kL1j8zIcj27rE-Lo
Message-ID: <CAKfTPtBrnJ8wnB6bBKBFxHd+5rzKSeioouOc_wZetWrJmoz_uQ@mail.gmail.com>
Subject: Re: [PATCH v5] sched/fair: do not scan twice in detach_tasks()
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vschneid@redhat.com, patches@amperecomputing.com, cl@linux.com, 
	Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Jul 2025 at 12:26, Huang Shijie
<shijie@os.amperecomputing.com> wrote:
>
> detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
> iteration count limit. It is however set without the source RQ lock held.
>
> This means that env.loop_max and the actual length of env.src_rq->cfs_tasks
> as observed within detach_tasks() can differ. This can cause some tasks to
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
> This patch sets env.loop_max only once RQ lock is taken,
> and uses busiest->cfs.h_nr_queued for setting the env.loop_max.
>
> After this patch, I cannot catch any above issue in the Specjbb test.
>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> v4 --> v5:
>     Set the env.loop_max once the rq lock is taken.
>     v4:https://lore.kernel.org/all/20250721023939.19703-1-shijie@os.amperecomputing.com/
>
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
>  kernel/sched/fair.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7cc9d50e3e11..9c1f21d59b5c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11708,12 +11708,15 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>                  * still unbalanced. ld_moved simply stays zero, so it is
>                  * correctly treated as an imbalance.
>                  */
> -               env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
> -
>  more_balance:
>                 rq_lock_irqsave(busiest, &rf);
>                 update_rq_clock(busiest);
>
> +               if (!env.loop_max)
> +                       env.loop_max  = min(sysctl_sched_nr_migrate, busiest->cfs.h_nr_queued);
> +               else
> +                       env.loop_max  = min(env.loop_max, busiest->cfs.h_nr_queued);
> +
>                 /*
>                  * cur_ld_moved - load moved in current iteration
>                  * ld_moved     - cumulative load moved across iterations
> --
> 2.40.1
>

