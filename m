Return-Path: <linux-kernel+bounces-846330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9613BC7983
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B446351F69
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9D2D0601;
	Thu,  9 Oct 2025 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUxqIhG8"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734F19047A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759992916; cv=none; b=RkUNeMpF6SLbhiUYXpLdz8D7DVH7OeQsXgr6vDeZhGhvOuFgzgXlGbx5mcOu+zPqOnW+tRz58miwZc7VGdbP0JInyisbSVfKrOHE28wL7BqQxss2nP/PamZOIy/eDVUCLEud9WVyg5Nla9r/ehgVAyxo2g48j/go8BYqbF53AHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759992916; c=relaxed/simple;
	bh=NYq1csqyvSvFTrw6opplfcNna5M434TjvIqSfahBwuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5eUtFg//htQQqglbnfjLaAxTE9aJbSINwal78+YdKVcU83NFYuDv/cOQ5umtL2jXIcIk2qW+Ftlyj5SXhgyTB6ku3vBA5bz77yF/M9d2vxIJEFgqo55h1Hi0kn3dHURWow/Er/OwfCSgkyOYWIHveLi9NfcZJ6nDKMhqAkmeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUxqIhG8; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-27c369f8986so5555405ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759992914; x=1760597714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xjbn6Qkt0hOf7RLR/8BSQWMvC3Q74RSHRsJXdymqqEo=;
        b=MUxqIhG8carWT3knij8qZ7psqpkTy6CYE/qBjTqo3RY6iJ2p0HZufL7v5v7St7/aEM
         QAzz1xZtCAvoP6iIbauBxyKXPEtxcKJRFXLBFKTxBGJP1OSLdMJ0I18I+Sc/AvyWuHEf
         RSHMPyEkl1TGo6Vgvo4pi+MG7uvaTw+2rpjZb6j2cZeaYby8ltaFxycSEWWnkC0CmzzG
         UTdwiJlFRzXkvQFee0VVRTam9hG5yfaRT3QOhYseEgfhi5NwNC5UyLISYlO4sqMU7rYy
         JDEfa+BJCSR5QFh06P7pXAhUjqeiN35zcGw3s7esFcX3BQpuIKrgZ5yz9VZ8SVTfURLi
         R24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759992914; x=1760597714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xjbn6Qkt0hOf7RLR/8BSQWMvC3Q74RSHRsJXdymqqEo=;
        b=J5Zlndf72jSGF3YQW+Qx9pDA90Aroyadnbmp82kistJOda9B5XCJ1FYsCcQhomq1Yh
         G0Ta8mddiFjj0eD/eK7HCOthp4oSCpy2VuSP0X/sSkNDlGSP7ma4e8z/PQyei0cERHtY
         NQx1VTwrYNvNrrRBlu2NcAWUpzbP71BifD14ZAZOdJSeqZyjaIjhlQO/WIYfPn5ucgbe
         GKHnunMiOfw7AlM+G8gULzMvQOK7SeQGqa5WXjdeRStdiso7l3mFX2ROmzSSxvVbp/lH
         M1lzdFsST6tnLpNB/2m77E4Q0WY9Z/2Y+AyrLCmXOhgM0ntquLIhf/S0L/d6Jg0oiBUk
         g8Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWWcWxNAQwsXqXiNE0SR1NOn0l8TOTJhOoIAObqvpKgZDpiwsrib87jLubzbkD0I8LAPQw1rG+KRVPDfYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/DlQ2zrS1U2RNUJYgQ9RZPbZMNzTzrW0PDu5qLkTnrTVnjUl
	XiWC4n2IsjGwO+9ahQIRS07fVux5CYp3tdjulE2qiCEHoNZgVfoOxnKMcb54o3kEclLqjf8X2HF
	+UOI8Uocb/ZpOA8WZEnUVR/O4vmDG6dg=
X-Gm-Gg: ASbGncs4p+w99VrYP8AMfw8E87Kgsotot7eyS2dxKEysMjy2P1aQa5YUx+V+m/iFQ0U
	8i56QtrmlbNILA2j1Uj6QgSZ4qO8JCW3ArVLCnebYqZ2DKbdTfnkWiAaM25D9S3pcWjMDinU5ZL
	JmKVZqijer0I9EaEN9RlIR82JiGeV75OIMxeK4TwANxu7jSL1jezeskF8/Pfl0n/YzEmrMyMMWz
	q7Rwu5E9ZF6mfXnsOsHmIyWFQKJr0HgE7DuGG19Ew==
X-Google-Smtp-Source: AGHT+IF4yxQFkUSsbq8Vuj7QId1kRhnuIYONJPJ+PPfAiowuGpDG5Q3ViKwyQqAtHZXzs6gqeLNnfxDESAN5RF1NMUk=
X-Received: by 2002:a17:903:3c66:b0:282:eea8:764d with SMTP id
 d9443c01a7336-290273ecb72mr81124035ad.35.1759992913654; Wed, 08 Oct 2025
 23:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009024657.151767-1-jianyungao89@gmail.com> <41283b3e-cf11-4faf-879d-0078bb24e6a0@linux.ibm.com>
In-Reply-To: <41283b3e-cf11-4faf-879d-0078bb24e6a0@linux.ibm.com>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Thu, 9 Oct 2025 14:55:02 +0800
X-Gm-Features: AS18NWCRdMOG7GHk7tuoI9JZDp-PIa9z7Zd1zDf6sVzbo60BW-roKYoCxg51OxU
Message-ID: <CAHP3+4DSdvB43JHc2hWwBWQLQG8AoLFBSNuHEPi3_LSKa8vHrQ@mail.gmail.com>
Subject: Re: [PATCH v3] sched: Fix some spelling mistakes in the scheduler module
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Madadi,
Thank you for your review. I will fix it in the next patch.

On Thu, Oct 9, 2025 at 2:01=E2=80=AFPM Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
>
> Hi Jianyun,
>
> On 09/10/25 08:16, Jianyun Gao wrote:
> > From: "jianyun.gao" <jianyungao89@gmail.com>
> >
> > The following are some spelling mistakes existing in the scheduler
> > module. Just fix it!
> >
> >   slection -> selection
> >   achitectures -> architectures
> >   excempt -> exempt
> >   incorectly -> incorrectly
> >   litle -> little
> >   faireness -> fairness
> >   condtion -> condition
> >
> > Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> > ---
> > v3:
> > Change "except" to "exempt" in v2.
>
> It should be "excempt" to "exempt"
>
> > The previous version is here:
> >
> > https://lore.kernel.org/lkml/20250929061213.1659258-1-jianyungao89@gmai=
l.com/
> >
> >  kernel/sched/core.c     | 2 +-
> >  kernel/sched/cputime.c  | 2 +-
> >  kernel/sched/fair.c     | 8 ++++----
> >  kernel/sched/wait_bit.c | 2 +-
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 7f1e5cb94c53..af5076e40567 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6858,7 +6858,7 @@ static void __sched notrace __schedule(int sched_=
mode)
> >               /*
> >                * We pass task_is_blocked() as the should_block arg
> >                * in order to keep mutex-blocked tasks on the runqueue
> > -              * for slection with proxy-exec (without proxy-exec
> > +              * for selection with proxy-exec (without proxy-exec
> >                * task_is_blocked() will always be false).
> >                */
> >               try_to_block_task(rq, prev, &prev_state,
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index 7097de2c8cda..2429be5a5e40 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -585,7 +585,7 @@ void cputime_adjust(struct task_cputime *curr, stru=
ct prev_cputime *prev,
> >       stime =3D mul_u64_u64_div_u64(stime, rtime, stime + utime);
> >       /*
> >        * Because mul_u64_u64_div_u64() can approximate on some
> > -      * achitectures; enforce the constraint that: a*b/(b+c) <=3D a.
> > +      * architectures; enforce the constraint that: a*b/(b+c) <=3D a.
> >        */
> >       if (unlikely(stime > rtime))
> >               stime =3D rtime;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 18a30ae35441..b1c335719f49 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5381,7 +5381,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sche=
d_entity *se, int flags)
> >               bool delay =3D sleep;
> >               /*
> >                * DELAY_DEQUEUE relies on spurious wakeups, special task
> > -              * states must not suffer spurious wakeups, excempt them.
> > +              * states must not suffer spurious wakeups, exempt them.
> >                */
> >               if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
> >                       delay =3D false;
> > @@ -5842,7 +5842,7 @@ static bool enqueue_throttled_task(struct task_st=
ruct *p)
> >        * target cfs_rq's limbo list.
> >        *
> >        * Do not do that when @p is current because the following race c=
an
> > -      * cause @p's group_node to be incorectly re-insterted in its rq'=
s
> > +      * cause @p's group_node to be incorrectly re-insterted in its rq=
's
>
> s/re-insterted/re-inserted/
>
> Thanks,
> Madadi Vineeth Reddy
>
> >        * cfs_tasks list, despite being throttled:
> >        *
> >        *     cpuX                       cpuY
> > @@ -12161,7 +12161,7 @@ static inline bool update_newidle_cost(struct s=
ched_domain *sd, u64 cost)
> >                * sched_balance_newidle() bumps the cost whenever newidl=
e
> >                * balance fails, and we don't want things to grow out of
> >                * control.  Use the sysctl_sched_migration_cost as the u=
pper
> > -              * limit, plus a litle extra to avoid off by ones.
> > +              * limit, plus a little extra to avoid off by ones.
> >                */
> >               sd->max_newidle_lb_cost =3D
> >                       min(cost, sysctl_sched_migration_cost + 200);
> > @@ -13176,7 +13176,7 @@ static void propagate_entity_cfs_rq(struct sche=
d_entity *se)
> >        * If a task gets attached to this cfs_rq and before being queued=
,
> >        * it gets migrated to another CPU due to reasons like affinity
> >        * change, make sure this cfs_rq stays on leaf cfs_rq list to hav=
e
> > -      * that removed load decayed or it can cause faireness problem.
> > +      * that removed load decayed or it can cause fairness problem.
> >        */
> >       if (!cfs_rq_pelt_clock_throttled(cfs_rq))
> >               list_add_leaf_cfs_rq(cfs_rq);
> > diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
> > index 1088d3b7012c..47ab3bcd2ebc 100644
> > --- a/kernel/sched/wait_bit.c
> > +++ b/kernel/sched/wait_bit.c
> > @@ -207,7 +207,7 @@ EXPORT_SYMBOL(init_wait_var_entry);
> >   * given variable to change.  wait_var_event() can be waiting for an
> >   * arbitrary condition to be true and associates that condition with a=
n
> >   * address.  Calling wake_up_var() suggests that the condition has bee=
n
> > - * made true, but does not strictly require the condtion to use the
> > + * made true, but does not strictly require the condition to use the
> >   * address given.
> >   *
> >   * The wake-up is sent to tasks in a waitqueue selected by hash from a
>

