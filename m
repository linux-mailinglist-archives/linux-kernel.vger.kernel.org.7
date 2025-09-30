Return-Path: <linux-kernel+bounces-837701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AADBACFC4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1297A9A11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F7F2FC895;
	Tue, 30 Sep 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlt41fG1"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFEA2FB0BA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237891; cv=none; b=WRSTuiRv2dwhsgSejgFzwl0UEhABzih8rxD4AxaWl99DZX1UXbvWdhlHPU+wzokcMKz2dMClXABQY7tT2ZkTsav2SUmsRNtbxDfYjo8q7JPxDHWQjKQiWVFaUp1X8ewY6ADX3hHZTFMiyi8020bcjdJuRe9F7ttJTEAY072x0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237891; c=relaxed/simple;
	bh=Ytf2NkRfcS24mvyhgg6Fpz/jDl94mam559z3JfUeyu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=by0Ts4lptr5TcQMGwyzgEjOR/axmLWsTI5ZIM9BKpylLW7Fv6kC6SXb3pNGriMbP9yXwk6gvBHEgiq8dc2hmsw5A3+eZc4XxisqW66NNbERV+V3P6GasPGBn5uHYAOaVSvnqoaHcBYuOH0ZS6fX/eV4Oh0lJ2Jjt5NvaSI95FwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlt41fG1; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2897522a1dfso23583425ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759237889; x=1759842689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHc/E7m/jFKYEfR1/jPPVcerM7wOAZa1eDOTdDgLqtM=;
        b=dlt41fG1Oy9lxkpSgmuLrESTEgBNKy2M2G7t341JhVSaIgDeZJwaOqq8nLoeN6957r
         YHzzvYFIG8zMyjo5WDdG8dmRfUMV3U/4F+KPsygqtn0iQK9WIYFDsr0zznPGSUASy9nX
         Q9QHaDI+kRmel9lF9iuBJ/4AFgwqYC4j1lxuJcCQBvVcYAlYs9MufNRrCCMaxAIXuR7b
         /09xutJ9ZLkt2tv5uchV07myy8nwsPtAwtpXxJIpwcHYn5jIXjD2CpdDFp8KMXR9LiLM
         Wl4kNi0RsRkfP3u2MG+VR6YD+LthYfmoeLdnhDaRbCruZ3YHjzPqmgy5s9k3VTxmbdrM
         x1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759237889; x=1759842689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHc/E7m/jFKYEfR1/jPPVcerM7wOAZa1eDOTdDgLqtM=;
        b=bEiqRJHVX8f9toQ6yLaSk90oclbaow9HjU0pZQmVZP4Z6OxbLPLY0kEGO26se9UGpl
         P8NdexQdmhoYjbo/L/Lqy53X9pM5RTulmsVzZgYi6XlhWfOHWJjjNhRuK7MsOWEIyoY4
         SHlgUwbruRcAueqe/jGfE/vEaSTyLAgolPWa0XW4BrrK6KVKcfjekYYB7ndLvYfBg1VP
         /+C3jMgqzvUHMr6qGE4ahWeW8NBC5S+eRJNis+30XOglXXyEFZ1zGR41zjwSbTBi69ve
         ZfLVkgIdBFlMHgAVuRyehuap82c9IrA+DH+rS3eK3Lh1yI1jzM2VFFGgbKcAClOKb9ef
         Yo4A==
X-Forwarded-Encrypted: i=1; AJvYcCUmnmLywJvED4gn7KVOE6/DtfujRvtCQq8N0hUmNqKHcVokMvELGd/LZ1auHh+af+K61WZ4i0YOqdrGfyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZELd4QVn1sS+wkKw1qQYM77459s7akHH0w98UWVekhoekxqd
	/GX3DdxKCLJlzc5ksabmVGNC9AdhEyvHeijb5QdUiFdHWVJW9JNNBJZugQNkQGqb8quqLiZ5hPD
	UUgyVfOf6dg4mbwH+t/4SQruzlYMk+38=
X-Gm-Gg: ASbGncu9DMCcdwH6hQk8SkM9Il1gDOX96kpw8NKql8+fC8Ypih+o3LMwcgCNQk8mj45
	rEezaqBKTpiNFmJpWhkpAJlaEzRrqe1tuHoWLfq3363fsvpvpAKYqJg8LT2M4b/RzCfy/wyW6ie
	7TWklEzb8RVLJOZIDPVELT5cqFKZ3g77vRZk6exQYY2pUJI5iL7cubTEFvUk90kq1EY8EJ9St/2
	MALC6/D9oAc9U++5pm8zBhBh5DK240Osij6/3wnKw==
X-Google-Smtp-Source: AGHT+IGHOp5Dy+vBf5scno3BDqZJSmoW/HyCNwJQWRz31aCwhtpdhEJdbAjnOh+rTHWGYxvCZalCIOkQWDr2J0an+wg=
X-Received: by 2002:a17:903:3586:b0:24c:6125:390a with SMTP id
 d9443c01a7336-27ed49b9cbfmr200771805ad.10.1759237889185; Tue, 30 Sep 2025
 06:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929061213.1659258-1-jianyungao89@gmail.com>
 <ff4099fa-a6e4-4478-af81-a4c1baaf483b@arm.com> <20250930122959.GA87275@pauld.westford.csb>
In-Reply-To: <20250930122959.GA87275@pauld.westford.csb>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Tue, 30 Sep 2025 21:11:17 +0800
X-Gm-Features: AS18NWDgd9hjpvoGPLnSvbAr3swPPrcMEkZVbjoQPLK8GHVmWUGsAq3f7LD5WpU
Message-ID: <CAHP3+4DRJuEtxEXLLz1Z76ofPqd030sTmX5pQ+21jAFKQB9K_g@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Fix some spelling mistakes in the scheduler module
To: Phil Auld <pauld@redhat.com>
Cc: Christian Loehle <christian.loehle@arm.com>, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phil,
I agree with you. As a non-native English speaker, I think both of
them(except or exempt) are acceptable.
So, do I still need to change "except" to "exempt"?

On Tue, Sep 30, 2025 at 8:30=E2=80=AFPM Phil Auld <pauld@redhat.com> wrote:
>
> On Tue, Sep 30, 2025 at 09:26:59AM +0100 Christian Loehle wrote:
> > On 9/29/25 07:12, Jianyun Gao wrote:
> > > From: "jianyun.gao" <jianyungao89@gmail.com>
> > >
> > > The following are some spelling mistakes existing in the scheduler
> > > module. Just fix it!
> > >
> > >   slection -> selection
> > >   achitectures -> architectures
> > >   excempt -> except
> > >   incorectly -> incorrectly
> > >   litle -> little
> > >   faireness -> fairness
> > >   condtion -> condition
> > >
> > > Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> > > ---
> > > V2:
> > > Delete the incorrect modifications for "borken" in V1.
> > > The previous version is here:
> > >
> > > https://lore.kernel.org/lkml/20250926092832.1457477-1-jianyungao89@gm=
ail.com/
> > >
> > >  kernel/sched/core.c     | 2 +-
> > >  kernel/sched/cputime.c  | 2 +-
> > >  kernel/sched/fair.c     | 8 ++++----
> > >  kernel/sched/wait_bit.c | 2 +-
> > >  4 files changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 7f1e5cb94c53..af5076e40567 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -6858,7 +6858,7 @@ static void __sched notrace __schedule(int sche=
d_mode)
> > >             /*
> > >              * We pass task_is_blocked() as the should_block arg
> > >              * in order to keep mutex-blocked tasks on the runqueue
> > > -            * for slection with proxy-exec (without proxy-exec
> > > +            * for selection with proxy-exec (without proxy-exec
> > >              * task_is_blocked() will always be false).
> > >              */
> > >             try_to_block_task(rq, prev, &prev_state,
> > > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > > index 7097de2c8cda..2429be5a5e40 100644
> > > --- a/kernel/sched/cputime.c
> > > +++ b/kernel/sched/cputime.c
> > > @@ -585,7 +585,7 @@ void cputime_adjust(struct task_cputime *curr, st=
ruct prev_cputime *prev,
> > >     stime =3D mul_u64_u64_div_u64(stime, rtime, stime + utime);
> > >     /*
> > >      * Because mul_u64_u64_div_u64() can approximate on some
> > > -    * achitectures; enforce the constraint that: a*b/(b+c) <=3D a.
> > > +    * architectures; enforce the constraint that: a*b/(b+c) <=3D a.
> > >      */
> > >     if (unlikely(stime > rtime))
> > >             stime =3D rtime;
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 18a30ae35441..20fe5899b247 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5381,7 +5381,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se, int flags)
> > >             bool delay =3D sleep;
> > >             /*
> > >              * DELAY_DEQUEUE relies on spurious wakeups, special task
> > > -            * states must not suffer spurious wakeups, excempt them.
> > > +            * states must not suffer spurious wakeups, except them.
> >
> > This should be exempt, no?
> >
>
> I had the same thought then decded that "except" as a verb worked too.
> We are making an exception for the special states, right? I think either
> works, but not both at once :)
>
> But that said, I'm not sure we should bother as these don't seem to
> effect the meaning (at least to me as a native 'merican speaker).
>
> Cheers,
> Phil
>
>
>
> --
>

